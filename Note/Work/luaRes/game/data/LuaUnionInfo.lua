---行会类
---@class LuaUnionInfo:luaobject
local LuaUnionInfo = {}

LuaUnionInfo.unionBossRankNo = nil

---得到行会boss首领排名
---行会boss首领排名  -1:没有打过 0 不在前3名 1 2 3分别对应名词
function LuaUnionInfo:GetUnionBossRankNo()
    if (CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0) then
        return nil
    end
    return self.unionBossRankNo
end

function LuaUnionInfo:Init()
    --self.CallShowUnionRenvengeRedPoint = function()
    --    return self:ShowUnionRenvengeRedPoint();
    --end
    --CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(CS.RedPointKey.UNION_REVENGE, self.CallShowUnionRenvengeRedPoint)
end

---得到当前秘境地图的进入副本
function LuaUnionInfo:GetUnionMJDuplicate()
    local unionBossRank = self:GetUnionBossRankNo()
    if (unionBossRank == nil) then
        return 0
    end
    if (unionBossRank == -1) then
        ---当前一次都没有打过,那么使用公会本身的排名
        local rank = CS.CSScene.MainPlayerInfo.UnionInfoV2.Ranking
        if (rank == 1) then
            return 23001
        elseif (rank == 2) then
            return 23101
        elseif (rank == 3) then
            return 23201
        end
    else
        if (unionBossRank == 1) then
            return 23001
        elseif (unionBossRank == 2) then
            return 23101
        elseif (unionBossRank == 3) then
            return 23201
        end
    end
    return 0
end

---@param tblData unionV2.ResSendPlayerUnionInfo lua table类型消息数据
function LuaUnionInfo:ResSendPlayerUnionInfoMessage(tblData)
    self.unionBossRankNo = tblData.unionInfo.unionBossRankNo
end

---@param rank number
function LuaUnionInfo:SetUnionBossRank(rank)
    self.unionBossRankNo = rank
end

---获取帮会仇人列表
function LuaUnionInfo:GetUnionEnemyTable()
    if (self.mUnionEnemyTable == nil) then
        self.mUnionEnemyTable = {}
    end
    return self.mUnionEnemyTable
end

---设置帮会仇人列表
---@param list table<number,unionV2.UnionRevenge>
function LuaUnionInfo:SetUnionEnemyTable(list)
    self:SortUnionEnemyTable(list)
    self.mUnionEnemyTable = list
end

---帮会仇人列表排序
---@param list table<number,unionV2.UnionRevenge>
function LuaUnionInfo:SortUnionEnemyTable(list)
    if (#list > 1) then
        table.sort(list, function(l, r)
            if (l.canReward == r.canReward) then
                if (l.canReward == 0) then
                    if (l.revengeType == r.revengeType) then
                        return l.createTime > r.createTime
                    else
                        return l.revengeType < r.revengeType
                    end
                else
                    return l.createTime > r.createTime
                end
            else
                return l.canReward > r.canReward
            end
        end)
    end
end

---刷新帮会仇人列表中的某一个
---@param info unionV2.ResAddUnionRevenge
function LuaUnionInfo:RefreshUnionEnemyTable(info)
    if (self.mUnionEnemyTable ~= nil) then
        for i = 1, #self.mUnionEnemyTable do
            if (self.mUnionEnemyTable[i].id == info.id) then
                self.mUnionEnemyTable[i] = info
            end
        end
        self:SortUnionEnemyTable(self.mUnionEnemyTable)
    end
end

---刷新帮会仇人列表的奖励状态
---@param info unionV2.ResRewardUnionRevenge
function LuaUnionInfo:RefreshUnionEnemyReward(info)
    for i = 1, #self.mUnionEnemyTable do
        if (self.mUnionEnemyTable[i].id == info.id) then
            self.mUnionEnemyTable[i].canReward = info.canReward
        end
    end
    self:SortUnionEnemyTable(self.mUnionEnemyTable)
end

---添加一个仇人到帮会仇人列表
---@param info unionV2.ResAddUnionRevenge
function LuaUnionInfo:AddUnionEnemyTable(info)
    if (self.mUnionEnemyTable ~= nil) then
        table.insert(self.mUnionEnemyTable, info)
        self:SortUnionEnemyTable(self.mUnionEnemyTable)
    end
end

---移除一个仇人到帮会仇人列表
---@param info unionV2.ResAddUnionRevenge
function LuaUnionInfo:RemoveUnionEnemyTable(info)
    if (self.mUnionEnemyTable ~= nil) then
        local index = 1
        while index <= #self.mUnionEnemyTable do
            if (self.mUnionEnemyTable[index].id == info.id) then
                table.remove(self.mUnionEnemyTable, index)
            end
            index = index + 1
        end
        self:SortUnionEnemyTable(self.mUnionEnemyTable)
    end
end

--region 红点
function LuaUnionInfo:ShowUnionRenvengeRedPoint()
    if (self.mUnionEnemyTable ~= nil) then
        if (Utility.GetLuaTableCount(self.mUnionEnemyTable) == 0) then
            return false
        else
            local tab = self.mUnionEnemyTable
            for i = 1, #tab do
                if (tab[i].canReward == 1) then
                    return true
                end
            end
            return false
        end
    else
        return false
    end
end
--endregion
function LuaUnionInfo:OnDestroy()
    --CS.CSUIRedPointManager.GetInstance():RemoveLuaCallRedPointFunction(CS.RedPointKey.UNION_REVENGE)
end

return LuaUnionInfo