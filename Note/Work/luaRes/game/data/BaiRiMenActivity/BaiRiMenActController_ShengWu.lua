---白日门圣物活动
---@class BaiRiMenActController_ShengWu:BaiRiMenActControllerBase
local BaiRiMenActController_ShengWu = {}

setmetatable(BaiRiMenActController_ShengWu, luaclass.BaiRiMenActControllerBase)

function BaiRiMenActController_ShengWu:GetRepresentActivityID()
    return 10001
end

---获取地图上显示的圣物列表
---@return table<number, {mapID:number, gatherID:number, x:number, y:number}>
function BaiRiMenActController_ShengWu:GetShengWuMapShowList()
    if self.mShengWuMapShowList == nil then
        self.mShengWuMapShowList = {}
        local globalTblExist, globalTbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22774)
        if globalTbl then
            local strs = string.Split(globalTbl.value, '&')
            for i = 1, #strs do
                local strs2 = string.Split(strs[i], '#')
                if #strs2 >= 4 then
                    local mapID = tonumber(strs2[1])
                    local gatherID = tonumber(strs2[2])
                    local x = tonumber(strs2[3])
                    local y = tonumber(strs2[4])
                    table.insert(self.mShengWuMapShowList, { mapID = mapID, gatherID = gatherID, x = x, y = y })
                end
            end
        end
    end
    return self.mShengWuMapShowList
end

---获取圣物最大采集次数
---@public
function BaiRiMenActController_ShengWu:GetShengWuGatherMaxCount()
    if self.mShengWuGatherMaxCount == nil then
        local globalTblExist, globalTbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22768)
        if globalTbl then
            local strs = string.Split(globalTbl.value, '#')
            if strs ~= nil and #strs >= 2 then
                self.mShengWuGatherMaxCount = tonumber(strs[2])
            end
        else
            self.mShengWuGatherMaxCount = 0
        end
    end
    return self.mShengWuGatherMaxCount
end

---获取圣物的地图ID和剩余数量
---@param monsterID number 圣物的monsterID
---@return number, number 圣物所处的地图ID  该地图上所剩余的怪物数量
function BaiRiMenActController_ShengWu:GetShengWuMapIDAndLastAmount(monsterID)
    if self.mShengWuDistrubute == nil then
        return 0, 0
    end
    local temp = self.mShengWuDistrubute[monsterID]
    if temp == nil then
        return 0, 0
    end
    return temp.mapID, temp.lastAmount
end

---获取当前圣物采集次数
---@public
---@return number|nil
function BaiRiMenActController_ShengWu:GetCurrentLastingShengWuGatherCount()
    return self.mCurrentLastingShengWuGatherCount or 0
end

---获取当前圣物剩余体力
---@return number/nil
function BaiRiMenActController_ShengWu:GetCurrentLastingShengWuStamina()
    return self.mCurrentLastingShengWuStamina
end

function BaiRiMenActController_ShengWu:Initialize()
    if self:IsActivityShowToPlayer() then
        ---如果活动向玩家展示,则进入时就请求一次服务器数据
        self:RequestServerData()
    end
    self:GetOwner():GetClientEventHander():AddEvent(CS.CEvent.V2_StartGatherEvent, function(id, gatherData)
        --print("Start Gather", gatherData.GatherType)
        if gatherData == nil or gatherData.GatherType ~= CS.EGatherType.ShuiJing then
            return
        end
        self:OnShuiJingGatherStarted(gatherData)
    end)
    self:GetOwner():GetClientEventHander():AddEvent(CS.CEvent.V2_StopGatherEvent, function(id, gatherData)
        --print("Stop Gather", gatherData.GatherType)
        if gatherData == nil or gatherData.GatherType ~= CS.EGatherType.ShuiJing then
            return
        end
        self:OnShuiJingGatherStopped(gatherData)
    end)
    self:GetOwner():GetClientEventHander():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, function(id, gatherData)
        self.previousGatherCountAvailable = nil
        self:RefreshGatherControllerTips()
    end)
end

function BaiRiMenActController_ShengWu:OnUpdate()

end

function BaiRiMenActController_ShengWu:OnActivityInOpenTimeStateChanged()
    local mShuiJingExtraLayer = CS.UIMiniMapController.GetExtraPointLayer(LuaEnumMiniMapExtraDepth.ShuiJing, LuaEnumMiniMapExtraType.BossMapOnly)
    if self:IsActivityOpenedNow() then
        for i = 1, #self:GetShengWuMapShowList() do
            local temp = self:GetShengWuMapShowList()[i]
            local gatherID = temp.gatherID
            ---@type TABLE.CFG_GATHER
            local gatherTblExist, gatherTbl = CS.Cfg_GatherTableManager.Instance:TryGetValue(gatherID)
            if gatherTbl ~= nil then
                if gatherID == 106201 then
                    ---初级水晶
                    mShuiJingExtraLayer:AddPoint(temp.mapID, true, temp.x, temp.y, "crystal_low", gatherTbl.name)
                elseif gatherID == 106202 then
                    ---高级水晶
                    mShuiJingExtraLayer:AddPoint(temp.mapID, true, temp.x, temp.y, "crystal_high", gatherTbl.name)
                end
            end
        end
    else
        mShuiJingExtraLayer:RemoveAllPoints()
    end
end

function BaiRiMenActController_ShengWu:OnServerDataReceived(currentData, oldData)
    if currentData == nil or #currentData.availNum == 0 then
        self.mCurrentLastingShengWuGatherCount = nil
    else
        self.mCurrentLastingShengWuGatherCount = currentData.availNum[1]
    end
    self:RefreshGatherControllerTips()
    ---@type table<number, {mapID:number, lastAmount:number}>
    self.mShengWuDistrubute = {}
    if currentData ~= nil then
        for i = 1, #currentData.info do
            local infoTemp = currentData.info[i]
            if infoTemp.targetId ~= 0 then
                self.mShengWuDistrubute[infoTemp.targetId] = { mapID = infoTemp.mapId, lastAmount = infoTemp.remindNum }
            end
        end
    end
    if currentData == nil or type(currentData.dayDoorPhysical) ~= 'number' then
        self.mCurrentLastingShengWuStamina = nil
    else
        self.mCurrentLastingShengWuStamina = currentData.dayDoorPhysical
    end
    --print("self.mCurrentLastingShengWuGatherCount", self.mCurrentLastingShengWuGatherCount)
end

---刷新采集控制提示
---@private
function BaiRiMenActController_ShengWu:RefreshGatherControllerTips()
    if self.mCurrentLastingShengWuGatherCount == nil then
        self.mCurrentLastingShengWuGatherCount = 0
    end
    local currentGatherCountAvailable = self.mCurrentLastingShengWuGatherCount ~= nil and self.mCurrentLastingShengWuGatherCount > 0
    if currentGatherCountAvailable ~= self.previousGatherCountAvailable then
        if CS.CSSceneExt.Sington ~= nil then
            self.previousGatherCountAvailable = currentGatherCountAvailable
            if currentGatherCountAvailable then
                ---如果当前可以采集,则移除禁止水晶采集类型
                --print("移除提示:  今日次数已用完，明日再来")
                CS.CSSceneExt.Sington.GatherController:RemoveForbiddenGatherType(11)
            else
                ---如果当前不可以采集,则增加禁止水晶采集类型及其提示
                --print("增加提示:  今日次数已用完，明日再来")
                CS.CSSceneExt.Sington.GatherController:AddForbiddenGatherTypeAndTips(11, "今日次数已用完，明日再来")
            end
        end
    end
end

---开始水晶采集
---@private
---@param gatherData CSMainPlayerGatherGatherData
function BaiRiMenActController_ShengWu:OnShuiJingGatherStarted(gatherData)
    --print("OnShuiJingGatherStarted gatherData.GatherID", gatherData.GatherID)
    uimanager:CreatePanel("UIGatherProgressPanel", nil, gatherData.GatherID, CS.UnityEngine.Time.time)
end

---结束水晶采集
---@private
---@param gatherData CSMainPlayerGatherGatherData
function BaiRiMenActController_ShengWu:OnShuiJingGatherStopped(gatherData)
    --print("OnShuiJingGatherStopped gatherData.GatherID", gatherData.GatherID)
    uimanager:ClosePanel("UIGatherProgressPanel")
    ---采集完水晶后主动请求一次服务器数据
    self:RequestServerData()
end

return BaiRiMenActController_ShengWu