---行会复仇
---@class LuaAsyncOperation_UnionRevenge:LuaAsyncOperationBase
local LuaAsyncOperation_UnionRevenge = {}

setmetatable(LuaAsyncOperation_UnionRevenge, luaclass.LuaAsyncOperationBase)

---最终目标地图ID
---@type number
LuaAsyncOperation_UnionRevenge.targetMapID = nil
---最终目标坐标
---@type SFMiscBaseDot2
LuaAsyncOperation_UnionRevenge.targetCoord = nil
---最终地图的分线数
---@type number
LuaAsyncOperation_UnionRevenge.targetLine = nil
---中间mapnpc表数据
---@type TABLE.CFG_MAP_NPC
LuaAsyncOperation_UnionRevenge.mapNPCTbl = nil
---npc所在地图ID
---@type number
LuaAsyncOperation_UnionRevenge.mapNPCMapID = nil
---npc地图坐标
---@type SFMiscBaseDot2
LuaAsyncOperation_UnionRevenge.mapNPCCoord = nil
---当前状态
---@type number 0:表示正在直接前往目标点  1:表示正在前往NPC处,抵达NPC处后还需要打开NPC界面  2:表示已打开NPC面板,正在等待玩家点击npc界面并进行传送,传送后还需要继续寻路
LuaAsyncOperation_UnionRevenge.currentState = 0

---@param mapid number 追踪目标所在的地图id
---@param coord SFMiscBaseDot2 追踪目标所在的地图坐标
---@param line number 追踪目标所在的地图分线id
---@param buttonGO UnityEngine.GameObject 追踪按钮,根据不同的状况进行不同的提示
function LuaAsyncOperation_UnionRevenge:TryStartOperation(mapid, coord, line, buttonGO)
    --此处根据输入条件和当前条件决定是否开启了异步操作以及开始操作时执行的步骤
    local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(mapid)
    if mapTbl == nil then
        return false
    end
    local cls = mapTbl:GetCls()
    if cls == 3 or cls == 4 then
        ---个人副本/多人副本
        ---玩家在追踪其他玩家时需要判断被追踪玩家是否处于个人副本，如果被追踪玩家处于个人副本，需提示“该地图无法追踪”
        Utility.ShowPopoTips(buttonGO, "该地图无法追踪", 290, "UIGangTrackPromptPanel")
        return false
    else
        self.targetMapID = mapid
        self.targetCoord = coord
        self.targetLine = line
        ---其他地图,先尝试前往该地图
        local pathFindResult, reason = self:DoPathFindToTargetMapAndCoord(mapid, coord, line, buttonGO)
        if pathFindResult then
            ---如果被追踪的玩家不处于个人副本，并且双方地图可以通过传送阵进行正常移动时执行正常的寻路逻辑。
            self.currentState = 0
            if reason == 1 then
                ---在主角周围,不进行寻路,弹出tips
                Utility.ShowPopoTips(buttonGO, "已到达目标点", 290, "UIGangTrackPromptPanel")
                return false
            end
            return true
        else
            ---判断追踪玩家所在地图与被追踪玩家所在地图是否有传送阵可以进行寻路
            --（1）如果不能进行正常寻路，则自动寻路至该地图的传送npc，
            --（2）打开该npc的传送面板并标亮被追踪玩家所在的地图
            --（3）当玩家点击面板中的按钮传送至被追踪玩家所在地图时继续寻路功能
            local mapDeliverID = mapTbl:GetAnnounceDeliver()
            if mapDeliverID == nil or mapDeliverID == 0 then
                return false
            end
            local mapDeliverTbl = clientTableManager.cfg_deliverManager:TryGetValue(mapDeliverID)
            if mapDeliverTbl and mapDeliverTbl:GetToNpcId() ~= nil and mapDeliverTbl:GetToNpcId() ~= 0 then
                ---@type TABLE.CFG_MAP_NPC
                local isTblExist, mapNPCTbl = CS.Cfg_MapNpcTableManager.Instance:TryGetValue(mapDeliverTbl:GetToNpcId())
                if mapNPCTbl then
                    local isFind, targetMapNPCMapID, targetMapNPCCoord, npcDetectRange = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.GetMapNPCCoord(mapNPCTbl)
                    local qianziheInfo = CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo
                    if (qianziheInfo == nil) then
                        qianziheInfo = CS.Chat_FindPathInfo();
                        CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo = qianziheInfo
                    end
                    qianziheInfo.mapId = targetMapNPCMapID
                    qianziheInfo.dot = targetMapNPCCoord
                    qianziheInfo.line = 0
                    local finishCode = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(
                            CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.DoPathFindToNPC(
                                    mapNPCTbl,
                                    CS.EAutoPathFindSourceSystemType.Normal,
                                    CS.EAutoPathFindType.UnionRevenge_FindPath))
                    if finishCode < 0 then
                        return false
                    end
                    self.mapNPCTbl = mapNPCTbl
                    self.mapNPCMapID = targetMapNPCMapID
                    self.mapNPCCoord = targetMapNPCCoord
                    if finishCode ~= 1 then
                        ---npc需要寻路过去
                        self.currentState = 1
                    else
                        ---npc在玩家边上,直接打开界面
                        if self:TryOpenNPCPanel() then
                            self.currentState = 2
                            return true
                        end
                        return false
                    end
                    return true
                end
            end
            return false
        end
    end
    return true
end

---@param mapid number 追踪目标所在的地图id
---@param coord SFMiscBaseDot2 追踪目标所在的地图坐标
---@param line number 追踪目标所在的地图分线id
---@return boolean,number
function LuaAsyncOperation_UnionRevenge:DoPathFindToTargetMapAndCoord(mapid, coord, line)
    if (CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo == nil) then
        CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo = CS.Chat_FindPathInfo();
    end
    CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo.mapId = mapid
    CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo.dot = coord
    CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo.line = line
    local finishCode = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(
            CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.SetPathFindToTarget(mapid, coord,
                    0, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.UnionRevenge_FindPath))
    local isfind = finishCode >= 0
    return isfind, finishCode
end

---直接打开NPC界面
---@private
function LuaAsyncOperation_UnionRevenge:TryOpenNPCPanel()
    local finishCode = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(
            CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.OpenNPCPanel(self.mapNPCTbl, self.targetMapID))
    if finishCode < 0 then
        return false
    end
    return true
end

---寻路状态变化事件
---@protected
---@param currentPathFindState boolean 当前的寻路状态
---@param sourceSystemType number 寻路源系统类型
---@param pathFindType number 寻路类型
function LuaAsyncOperation_UnionRevenge:OnAutoPathFindStateChanged(currentPathFindState, sourceSystemType, pathFindType)
    if currentPathFindState == false then
        if self.currentState == 1 then
            if self:TryOpenNPCPanel() then
                self.currentState = 2
            end
        elseif self.currentState == 0 then
            local result, reason = self:DoPathFindToTargetMapAndCoord(self.targetMapID, self.targetCoord, self.targetLine)
            if result == false or reason == 1 then
                ---已到目标点
                self:Stop()
            end
        end
    end
end

---主角位置突变事件
---@protected
---@param positionChangeReason number 位置变化原因
---@param x number x坐标
---@param y number y坐标
---@param isChangeMap boolean 是否切换了地图
function LuaAsyncOperation_UnionRevenge:OnMainPlayerPositionSuddenlyChanged(positionChangeReason, x, y, isChangeMap)
    self:OnTransfered()
end

---场景变化事件
---@protected
function LuaAsyncOperation_UnionRevenge:OnSceneChangedAction()
    self:OnTransfered()
end

---传送时触发
---@private
function LuaAsyncOperation_UnionRevenge:OnTransfered()
    if self.currentState == 1 then
        ---如果当前正在前往NPC处,抵达NPC处后还需要打开NPC界面
        if self:TryOpenNPCPanel() then
            ---如果打开了NPC界面,则等待传送
            self.currentState = 2
        end
    elseif self.currentState == 2 then
        local result, reason = self:DoPathFindToTargetMapAndCoord(self.targetMapID, self.targetCoord, self.targetLine)
        if reason == 1 then
            ---已到目标点
            self:Stop()
        elseif result then
            self.currentState = 0
        end
    end
end

function LuaAsyncOperation_UnionRevenge:OnEnable()
    --此处执行开始异步操作的处理
    --print("OnEnable")
end

function LuaAsyncOperation_UnionRevenge:OnUpdate()
    --此处执行每帧执行的处理
    --print("OnUpdate")
end

function LuaAsyncOperation_UnionRevenge:OnDisable()
    --此处执行结束异步操作时的处理
    self.targetMapID = nil
    self.targetCoord = nil
    self.targetLine = nil
    self.mapNPCTbl = nil
    self.mapNPCMapID = nil
    self.mapNPCCoord = nil
    self.currentState = 0
end

return LuaAsyncOperation_UnionRevenge