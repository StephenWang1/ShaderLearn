---白日门押镖活动
---@class BaiRiMenActController_DartCar:BaiRiMenActControllerBase
local BaiRiMenActController_DartCar = {}

setmetatable(BaiRiMenActController_DartCar, luaclass.BaiRiMenActControllerBase)

function BaiRiMenActController_DartCar:GetRepresentActivityID()
    return 40001
end

--region 数据
---@type table<number,OperationDartCar> 正在运行的镖车列表
BaiRiMenActController_DartCar.OperationDartCarList = nil
---@type table<LuaEnumPersonDartCarType,table<ConfigDartCar>> 押镖字典
BaiRiMenActController_DartCar.ConfigDartCarDic = nil
---@type number 押镖次数
BaiRiMenActController_DartCar.YaBiaoNum = nil
---@type number 劫镖次数
BaiRiMenActController_DartCar.PlunderDartNum = nil
--endregion

---@param owner BaiRiMenActivityMgr
function BaiRiMenActController_DartCar:Init(owner)
    self:RunBaseFunction("Init",owner)
    networkRequest.ReqGetRoleFreightCarInfo()
end

--region 初始化
--region 服务器镖车数据初始化
---刷新正在运行的镖车数据
---@param tblData cartV2.ResFreightCarInfo lua table类型消息数据
function BaiRiMenActController_DartCar:RefreshOperationDartCar(tblData)
    if tblData == nil or tblData.lid == nil or tblData.carConfigId == nil then
        return
    end
    if self.OperationDartCarList == nil then
        self.OperationDartCarList = {}
    end
    local operationDartCarClass = luaclass.OperationDartCar:New()
    operationDartCarClass:RefreshOperationDartCarData(tblData)
    self.OperationDartCarList[tblData.lid] = operationDartCarClass
    self.ShowLeftPanel = true
    self:TryOpenLeftPanel()
end


---刷新正在运行的镖车坐标数据
---@param tblData cartV2.ResFreightCarPointChange lua table类型消息数据
function BaiRiMenActController_DartCar:RefreshOperationDartCarPos(tblData)
    if tblData == nil or tblData.lid == nil or type(self.OperationDartCarList) ~= 'table' then
        return
    end
    ---@type OperationDartCar
    local operationDartCar = self.OperationDartCarList[tblData.lid]
    if operationDartCar ~= nil then
        operationDartCar:RefreshOperationPosition(tblData)
        if CS.CSScene.MainPlayerInfo.AsyncOperationController.BaiRiMenFindPathOperation.IsOn == true then
            self:RefreshBaiRiMenDartCarPoint(operationDartCar.Position.mapId,operationDartCar.Position.x,operationDartCar.Position.y,operationDartCar.lid)
        end
    end
end

---刷新正在运行的镖车血量
---@param tblData cartV2.ResFreightCarHpChange lua table类型消息数据
function BaiRiMenActController_DartCar:RefreshOperationDartCarHp(tblData)
    if tblData == nil or tblData.lid == nil or type(self.OperationDartCarList) ~= 'table' then
        return
    end
    ---@type OperationDartCar
    local operationDartCar = self.OperationDartCarList[tblData.lid]
    if operationDartCar ~= nil then
        operationDartCar:RefreshOperationDartCarHp(tblData)
    end
end

---刷新主角押镖基础信息
---@param tblData cartV2.ResRoleFreightInfo lua table类型消息数据
function BaiRiMenActController_DartCar:RefreshMainPlayerDartCarBaseInfo(tblData)
    if tblData ~= nil then
        self.YaBiaoNum = tblData.deliveryCount
        self.PlunderDartNum = tblData.plunderCount
        luaEventManager.DoCallback(LuaCEvent.BaiRiMenDartCarDataChange, {dataChangeType = LuaEnumBaiRiMenDartCarDataChangeType.MainPlayerInfo})
    end
end

---清除镖车数据
---@param lid number
function BaiRiMenActController_DartCar:ClearDartCar(lid)
    if lid == nil then
        return
    end
    self.OperationDartCarList[lid] = nil
end
--endregion

--region 配置的镖车列表数据初始化
---初始化配置的镖车字典
function BaiRiMenActController_DartCar:InitConfigDartCarDic()
    if self.ConfigDartCarDic == nil then
        self.ConfigDartCarDic = {}
        self.ConfigDartCarDic[LuaEnumPersonDartCarType.BaiRiMen_Locality] = self:GetAndSortConfigDartCarList(LuaEnumPersonDartCarType.BaiRiMen_Locality)
        self.ConfigDartCarDic[LuaEnumPersonDartCarType.BaiRiMen_ShareServer] = self:GetAndSortConfigDartCarList(LuaEnumPersonDartCarType.BaiRiMen_ShareServer)
    end
end

---获取镖车列表
---@param dartCarType LuaEnumPersonDartCarType
---@return table<ConfigDartCar>
function BaiRiMenActController_DartCar:GetAndSortConfigDartCarList(dartCarType)
    local dartCarList = clientTableManager.cfg_yabiaoManager:GetConfigYaBiaoList(dartCarType)
    if dartCarList ~= nil then
        local curDartCarClassList = {}
        for k,v in pairs(dartCarList) do
            ---@type TABLE.cfg_yabiao
            local dartCarTbl = v
            local configDartCarClass = luaclass.ConfigDartCar:New()
            configDartCarClass:AnalysisConfigDartCarData(dartCarTbl:GetId())
            table.insert(curDartCarClassList,configDartCarClass)
        end
        self:SortConfigDartCar(curDartCarClassList)
        return curDartCarClassList
    end
end
--endregion
--endregion

--region 查询
---查询玩家当前是否有正在运行的镖车
---@return boolean
function BaiRiMenActController_DartCar:CheckPlayerHaveOptionDartCar()
    if self.OperationDartCarList ~= nil and type(self.OperationDartCarList) == 'table' then
        for k,v in pairs(self.OperationDartCarList) do
            ---@type OperationDartCar 正在运行的镖车类
            local operationDartCarClass = v
            if operationDartCarClass ~= nil and operationDartCarClass:DartCarIsOperation() then
                return true
            end
        end
    end
    return false
end

---主角附近是否有押镖Npc
---@return boolean 是否有押镖Npc
function BaiRiMenActController_DartCar:AroundHaveYaBiaoNpc()
    return gameMgr:GetMainScene():GetLuaAvatarByNpcId(338) ~= nil
end

---是否有押镖次数
---@return boolean
function BaiRiMenActController_DartCar:YaBiaoNumIsEnough()
    return self.YaBiaoNum > 0
end

---是否是白日门押镖材料
---@param itemId number
---@return boolean
function BaiRiMenActController_DartCar:IsBaiRiMenDartCarMaterial(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    return itemInfo ~= nil and itemInfo:GetType() == luaEnumItemType.Material and itemInfo:GetSubType() == 37
end
--endregion

--region 获取
---获取服务器配置的镖车列表
---@return table<ConfigDartCar>
function BaiRiMenActController_DartCar:GetConfigDartCarList()
    local isKuaFuOpen = luaclass.RemoteHostDataClass:IsKuaFuMap()
    local dartCarType = LuaEnumPersonDartCarType.BaiRiMen_Locality
    if isKuaFuOpen == true then
        dartCarType = LuaEnumPersonDartCarType.BaiRiMen_ShareServer
    end
    return self:GetConfigDartCarListByType(dartCarType)
end

---获取服务器配置的镖车列表
---@param dartCarType LuaEnumPersonDartCarType
---@return table<ConfigDartCar>
function BaiRiMenActController_DartCar:GetConfigDartCarListByType(dartCarType)
    if self.ConfigDartCarDic == nil then
        self:InitConfigDartCarDic()
    end
    if self.ConfigDartCarDic ~= nil and type(self.ConfigDartCarDic) == 'table' then
        return self.ConfigDartCarDic[dartCarType]
    end
end

---获取第一个正在运行的镖车
---@return OperationDartCar 正在运行的镖车类
function BaiRiMenActController_DartCar:GetFirstOperationDartCar()
    if self.OperationDartCarList ~= nil and type(self.OperationDartCarList) == 'table' then
        for k,v in pairs(self.OperationDartCarList) do
            ---@type OperationDartCar
            local operationDartCar = v
            if operationDartCar ~= nil and operationDartCar.AnalysisState and operationDartCar:DartCarIsOperation() then
                return operationDartCar
            end
        end
    end
end

---通过押镖id获取同类型的正在运行的镖车数据
---@param yaBiaoId number 押镖表id
---@return OperationDartCar 正在运行的镖车类
function BaiRiMenActController_DartCar:GetOperationDartCarByYaBiaoId(yaBiaoId)
    if type(self.OperationDartCarList) == 'table' then
        for k,v in pairs(self.OperationDartCarList) do
            ---@type OperationDartCar
            local operationDartCar = v
            if operationDartCar ~= nil and operationDartCar.AnalysisState and operationDartCar:DartCarIsOperation() and operationDartCar:IsSameConfigDartCar(yaBiaoId) then
                return operationDartCar
            end
        end
    end
end
--endregion

--region 排序
---配置的镖车数据排序
---@param configDartCarList table<ConfigDartCar>
function BaiRiMenActController_DartCar:SortConfigDartCar(configDartCarList)
    table.sort(configDartCarList,function(a,b)
        ---@type ConfigDartCar
        local leftDartCar,rightDartCar = a,b
        if leftDartCar ~= nil and leftDartCar.analysisState == true and rightDartCar ~= nil and rightDartCar.analysisState == true then
            return leftDartCar.YaBiaoConfigTbl:GetDartLv() < rightDartCar.YaBiaoConfigTbl:GetDartLv()
        end
    end)
end
--endregion

--region 寻路
---开启白日门镖车寻路
---@param mapId number
---@param x number
---@param y number
---@param carLid number
function BaiRiMenActController_DartCar:OpenBaiRiMenDartCarFindPath(mapId,x,y,carLid)
    if mapId == nil or x == nil or y == nil or carLid == nil then
        return
    end
    local mapTblIsFind,mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(mapId)
    if mapTblIsFind == false then
        return
    end
    local CSDot2 = CS.SFMiscBase.Dot2(x,y)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.BaiRiMenFindPathOperation:DoOperation(mapTbl, CSDot2,carLid)
end

---刷新白日门镖车寻路的目标点
---@param mapId number
---@param x number
---@param y number
---@param carLid number
function BaiRiMenActController_DartCar:RefreshBaiRiMenDartCarPoint(mapId,x,y,carLid)
    if mapId == nil or x == nil or y == nil or carLid == nil then
        return
    end
    local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(mapId)
    if mapTbl == nil then
        return
    end
    local CSDot2 = CS.SFMiscBase.Dot2(x,y)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.BaiRiMenFindPathOperation:RefreshPosition(mapId, CSDot2,carLid)
end

---停止白日门押镖寻路
function BaiRiMenActController_DartCar:StopBaiRiMenDartCarFindPoint()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController.BaiRiMenFindPathOperation.IsOn == true then
        CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop()
    end
end
--endregion

--region 左侧面板相关
---尝试开启左侧面板
function BaiRiMenActController_DartCar:TryOpenLeftPanel()
    ---@type UIMainMenusPanel
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    if self.ShowLeftPanel == true and uiMainMenusPanel ~= nil then
        uiMainMenusPanel:ChangeLeftPanel("UIBrmEscortLeftPanel",{operationDartCar = self:GetFirstOperationDartCar()})
    end
end

---尝试关闭左侧面板
---@param lid number 镖车唯一id
function BaiRiMenActController_DartCar:TryCloseLeftPanel(lid)
    ---@type UIBrmEscortLeftPanel
    local UIBrmEscortLeftPanel = uimanager:GetPanel("UIBrmEscortLeftPanel")
    if UIBrmEscortLeftPanel ~= nil then
        local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
        if uiMainMenusPanel ~= nil then
            uiMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
            self:StopBaiRiMenDartCarFindPoint()
            self:ClearDartCar(lid)
        end
    end
end
--endregion

--region 货运结束提示
---尝试提示玩家开始押送白日门镖车
function BaiRiMenActController_DartCar:TryHintPlayerStartDartCar()
    if self:YaBiaoNumIsEnough() == false then
        return
    end
    Utility.ShowSecondConfirmPanel({PromptWordId = 157,ComfireAucion = function()
        Utility.TryTransfer(40017,false)
    end})
end
--endregion

return BaiRiMenActController_DartCar