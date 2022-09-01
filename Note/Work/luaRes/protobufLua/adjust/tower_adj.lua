--[[本文件为工具自动生成,禁止手动修改]]
local towerV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable towerV2.ResRoleTowerInfo
---@type towerV2.ResRoleTowerInfo
towerV2_adj.metatable_ResRoleTowerInfo = {
    _ClassName = "towerV2.ResRoleTowerInfo",
}
towerV2_adj.metatable_ResRoleTowerInfo.__index = towerV2_adj.metatable_ResRoleTowerInfo
--endregion

---@param tbl towerV2.ResRoleTowerInfo 待调整的table数据
function towerV2_adj.AdjustResRoleTowerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, towerV2_adj.metatable_ResRoleTowerInfo)
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.awardList == nil then
        tbl.awardList = {}
    else
        if adjustTable.common_adj ~= nil and adjustTable.common_adj.AdjustIntIntStruct ~= nil then
            for i = 1, #tbl.awardList do
                adjustTable.common_adj.AdjustIntIntStruct(tbl.awardList[i])
            end
        end
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.showRewardList == nil then
        tbl.showRewardList = {}
    else
        if adjustTable.common_adj ~= nil and adjustTable.common_adj.AdjustIntIntStruct ~= nil then
            for i = 1, #tbl.showRewardList do
                adjustTable.common_adj.AdjustIntIntStruct(tbl.showRewardList[i])
            end
        end
    end
end

return towerV2_adj