---@class LuaReinDataManager
local LuaReinDataManager = {}

---@return boolean 是否显示转生红点
function LuaReinDataManager:IsShowReinRedPoint()
    return self.mCanLevelUp
end

function LuaReinDataManager:CallUpReinLvRedPoint()
    self:RefreshReinRedPoint()
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.LuaRoleReinRedPoint)
end

---刷新红点数据（转生红点受背包道具影响）
function LuaReinDataManager:RefreshReinRedPoint()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        self.mCanLevelUp = false
        return
    end
    local currentReinLevel = mainPlayerInfo.ReinCfgID
    local nextReinLevel = currentReinLevel + 1
    local currentReinTbl = clientTableManager.cfg_reincarnationManager:TryGetValue(currentReinLevel)
    local nextReinTbl = clientTableManager.cfg_reincarnationManager:TryGetValue(nextReinLevel)
    if nextReinTbl == nil then
        self.mCanLevelUp = false
        return
    end
    if currentReinLevel < currentReinTbl:GetReincarnation() or mainPlayerInfo.Level < currentReinTbl:GetNeedLevel() then
        self.mCanLevelUp = false
        return
    end
    if currentReinTbl:GetBoss() ~= nil and currentReinTbl:GetBoss().list ~= nil and currentReinTbl:GetBoss().list.Count > 0 then
        local reinitemlist = currentReinTbl:GetBoss().list
        for i = 0, reinitemlist.Count - 1 do
            local conditionId = reinitemlist[i]
            local result = Utility.IsMainPlayerMatchCondition(conditionId)
            if result.success == false then
                self.mCanLevelUp = false
                return
            end
        end
    end
    if currentReinTbl:GetNeedItem() ~= nil and currentReinTbl:GetNeedItem().list ~= nil and currentReinTbl:GetNeedItem().list.Count > 0 then
        local conditionTable = Utility.CSListChangeTable(currentReinTbl:GetNeedItem().list)
        local conditionResult = Utility.IsMainPlayerMatchConditionList_AND(conditionTable)
        if conditionResult.success == false then
            self.mCanLevelUp = false
            return
        end
    end
    if currentReinTbl:GetOpenNeedItem() ~= nil and currentReinTbl:GetOpenNeedItem().list ~= nil and currentReinTbl:GetOpenNeedItem().list.Count > 0 then
        local conditionTable = Utility.CSListChangeTable(currentReinTbl:GetOpenNeedItem().list)
        local conditionResult = Utility.IsMainPlayerMatchConditionList_AND(conditionTable)
        if conditionResult.success == false then
            self.mCanLevelUp = false
            return
        end
    end
    self.mCanLevelUp = true
end

---获取怪物击杀进度
function LuaReinDataManager:GetMonsterKill(count)
    if count == nil then
        return self.count
    end
    if count ~= nil then
        self.count = count
    end
end

return LuaReinDataManager