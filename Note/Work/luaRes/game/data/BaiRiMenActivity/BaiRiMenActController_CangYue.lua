--- DateTime: 2021/03/26 09:11
--- Description 白日门-苍月岛 数据类

---@class BaiRiMenActController_CangYue:BaiRiMenActControllerBase
local BaiRiMenActController_CangYue = {}

setmetatable(BaiRiMenActController_CangYue, luaclass.BaiRiMenActControllerBase)

--region parameters

--endregion

--region Overrides

---ID
function BaiRiMenActController_CangYue:GetRepresentActivityID()
    return 70001
end

---region 数据
function BaiRiMenActController_CangYue:Initialize()

end

--endregion

--region public methods

---@class CangYueShowRewards 苍月岛奖励展示
---@field itemID number
---@field itemCount number

---传送到苍月岛
---@param parent Transform 气泡悬挂父对象
function BaiRiMenActController_CangYue:TryDeliverCangyueIsland(parent)
    ---@type TABLE.cfg_bairimen_activity
    local ActivityTable = self:GetActivityTables()
    if (ActivityTable == nil or #ActivityTable <= 0 or #ActivityTable[1] == nil) then
        return
    end
    local confirmType, confirmParam, failType, failParam = self:ParseData(ActivityTable[1]:GetEventParameters())
    ---直接传送
    if confirmType == 4 then
        if confirmParam ~= nil then
            if (self:CheckMeetTheConditionsOfCangyueIsland(23023, parent) and self:CheckMeetTheConditionsOfCangyueIsland(23024, parent)) then
                local transferResult = Utility.TryTransfer(confirmParam, false)
                if transferResult ~= nil and transferResult.resultType ~= CS.Enum_TransferResult.Success then
                    --Utility.ShowPopoTips(go.transform,costItemInfo:GetName() .. "不足",10)
                    return
                end
                --networkRequest.ReqDeliverByConfig(confirmParam)
                uimanager:ClosePanel("UIWhiteSunGatePanel")
            end
        end
    end
end

---获取标题
---@return string 标题
function BaiRiMenActController_CangYue:GetTitle()
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23022)
    if (tbl ~= nil) then
        return tbl.value
    end
    return nil
end

---获取奖励展示列表
---@return tbale 奖励
function BaiRiMenActController_CangYue:GetRewardDisplayList()
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23025)
    if (tbl ~= nil) then
        local RewardList = string.Split(tbl.value, '&')
        ---玩家职业
        local playerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        ---玩家性别
        local playerSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
        ---@type table 奖励列表
        local rewardTable = {}
        local reward = nil
        for i = 1, #RewardList do
            reward = string.Split(RewardList[i], '#')
            if (#reward > 3) then
                if ((tonumber(reward[3]) == 0 or playerCareer == tonumber(reward[3])) and (tonumber(reward[4]) == 0 or playerSex == tonumber(reward[4]))) then
                    ---@type CangYueShowRewards
                    local temReward = {}
                    temReward.itemID = tonumber(reward[1])
                    temReward.itemCount = tonumber(reward[2])
                    table.insert(rewardTable, temReward)
                end
            end
        end
        return rewardTable
    end
    return nil
end

---检查是否满足条件
---@param conditionIDs table
---@return boolean&table|nil
function BaiRiMenActController_CangYue:CheckWhetherTheConditionsAreMet(conditionIDs)
    if (conditionIDs == nil or #conditionIDs == 0) then
        return false
    end
    for i = 1, #conditionIDs do
        ---@type LuaMatchConditionResult
        local matchCondition = Utility.IsMainPlayerMatchCondition(tonumber(conditionIDs[i]))
        if matchCondition == nil or matchCondition.success == false then
            return false, matchCondition
        end
    end
    return true
end

--endregion

--region private methods
---检查是否满足去苍月岛的条件
---@param globalID number
---@param parent Transform 气泡悬挂父对象
---@return boolean true:满足传送条件，false:不满足传送条件
function BaiRiMenActController_CangYue:CheckMeetTheConditionsOfCangyueIsland(globalID, parent)
    local conditionIDs = self:GetFormConditionInformation(globalID)
    local result, matchCondition = self:CheckWhetherTheConditionsAreMet(conditionIDs)
    if (result == false) then
        local text = (matchCondition ~= nil and matchCondition.txt ~= nil and type(matchCondition.txt) == 'string') and matchCondition.txt or "条件不满足"
        CS.Utility.ShowRedTips(text);
        return false
    end
    return true
end

---获取Global表格中的ConditionIDs和显示文本
---@param globalID number
function BaiRiMenActController_CangYue:GetFormConditionInformation(globalID)
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(globalID)
    if isFind then
        local strs = string.Split(tbl.value, '&')
        if (#strs > 1) then
            local conditionIDs = string.Split(strs[1], '#')
            return conditionIDs, strs[2]
        end
    end
    return nil
end

---解析数据
---@public
---@param eventParams string
---@return number, number, number|nil, number|nil
function BaiRiMenActController_CangYue:ParseData(eventParams)
    local confirmType, confirmData, failType, failData
    if eventParams ~= nil and eventParams ~= "" then
        local strs1 = string.Split(eventParams, '&')
        if strs1 ~= nil then
            local confirmParams = strs1[1]
            if confirmParams ~= nil then
                local strs1Strs1 = string.Split(confirmParams, '#')
                if #strs1Strs1 >= 1 then
                    confirmType = tonumber(strs1Strs1[1])
                end
                if #strs1Strs1 >= 2 then
                    confirmData = tonumber(strs1Strs1[2])
                end
                local failParams = strs1[2]
                local strs2Strs1 = string.Split(failParams, '#')
                if #strs2Strs1 >= 1 then
                    failType = tonumber(strs2Strs1[1])
                end
                if #strs2Strs1 >= 2 then
                    failData = tonumber(strs2Strs1[2])
                end
            end
        end
    end
    return confirmType, confirmData, failType, failData
end
--endregion

--region destroy

--endregion

return BaiRiMenActController_CangYue