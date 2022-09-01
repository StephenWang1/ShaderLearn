--[[本文件为工具自动生成,禁止手动修改]]
local activeV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable activeV2.ActiveInfo
---@type activeV2.ActiveInfo
activeV2_adj.metatable_ActiveInfo = {
    _ClassName = "activeV2.ActiveInfo",
}
activeV2_adj.metatable_ActiveInfo.__index = activeV2_adj.metatable_ActiveInfo
--endregion

---@param tbl activeV2.ActiveInfo 待调整的table数据
function activeV2_adj.AdjustActiveInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activeV2_adj.metatable_ActiveInfo)
    if tbl.activeNumber == nil then
        tbl.activeNumberSpecified = false
        tbl.activeNumber = 0
    else
        tbl.activeNumberSpecified = true
    end
    if tbl.activeProgress == nil then
        tbl.activeProgress = {}
    else
        if activeV2_adj.AdjustActiveItem ~= nil then
            for i = 1, #tbl.activeProgress do
                activeV2_adj.AdjustActiveItem(tbl.activeProgress[i])
            end
        end
    end
    if tbl.reward == nil then
        tbl.rewardSpecified = false
        tbl.reward = 0
    else
        tbl.rewardSpecified = true
    end
    if tbl.firstRandomIndex == nil then
        tbl.firstRandomIndex = {}
    end
end

--region metatable activeV2.ActiveItem
---@type activeV2.ActiveItem
activeV2_adj.metatable_ActiveItem = {
    _ClassName = "activeV2.ActiveItem",
}
activeV2_adj.metatable_ActiveItem.__index = activeV2_adj.metatable_ActiveItem
--endregion

---@param tbl activeV2.ActiveItem 待调整的table数据
function activeV2_adj.AdjustActiveItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activeV2_adj.metatable_ActiveItem)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.completeCount == nil then
        tbl.completeCountSpecified = false
        tbl.completeCount = 0
    else
        tbl.completeCountSpecified = true
    end
    if tbl.hasCompleteItem == nil then
        tbl.hasCompleteItemSpecified = false
        tbl.hasCompleteItem = false
    else
        tbl.hasCompleteItemSpecified = true
    end
    if tbl.clientActiveNum == nil then
        tbl.clientActiveNumSpecified = false
        tbl.clientActiveNum = 0
    else
        tbl.clientActiveNumSpecified = true
    end
end

--region metatable activeV2.GetActiveRewardRequest
---@type activeV2.GetActiveRewardRequest
activeV2_adj.metatable_GetActiveRewardRequest = {
    _ClassName = "activeV2.GetActiveRewardRequest",
}
activeV2_adj.metatable_GetActiveRewardRequest.__index = activeV2_adj.metatable_GetActiveRewardRequest
--endregion

---@param tbl activeV2.GetActiveRewardRequest 待调整的table数据
function activeV2_adj.AdjustGetActiveRewardRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activeV2_adj.metatable_GetActiveRewardRequest)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable activeV2.GetActiveCompleteRequest
---@type activeV2.GetActiveCompleteRequest
activeV2_adj.metatable_GetActiveCompleteRequest = {
    _ClassName = "activeV2.GetActiveCompleteRequest",
}
activeV2_adj.metatable_GetActiveCompleteRequest.__index = activeV2_adj.metatable_GetActiveCompleteRequest
--endregion

---@param tbl activeV2.GetActiveCompleteRequest 待调整的table数据
function activeV2_adj.AdjustGetActiveCompleteRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activeV2_adj.metatable_GetActiveCompleteRequest)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

return activeV2_adj