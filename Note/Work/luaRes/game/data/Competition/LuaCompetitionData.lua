---@class LuaCompetitionData 竞技数据
local LuaCompetitionData = {}

--region 回收

function LuaCompetitionData:OnBagItemChange()
    self:RefreshRecycleCache()
end

---避免反复遍历背包，缓存一个背包道具列表
function LuaCompetitionData:RefreshRecycleCache()
    self.mHasItemInBag = {}
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local bagInfo = mainPlayerInfo.BagInfo:GetBagItemList()
        for i = 0, bagInfo.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = bagInfo[i]
            self.mHasItemInBag[bagItemInfo.itemId] = true
        end
    end
end

---@return boolean 背包中是否有该道具
function LuaCompetitionData:HasRecycleItemInBag(itemId)
    if self.mHasItemInBag == nil then
        self:RefreshRecycleCache()
    end

    return self.mHasItemInBag[itemId]
end

--endregion

return LuaCompetitionData