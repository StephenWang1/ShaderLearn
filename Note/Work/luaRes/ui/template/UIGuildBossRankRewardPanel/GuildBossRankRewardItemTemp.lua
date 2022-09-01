---@class GuildBossRankRewardItemTemp
local GuildBossRankRewardItemTemp = {}


--region 组件

---@return Top_UILabel 排行等级
function GuildBossRankRewardItemTemp:GetRankLevelLabel()
    if self.mGetRankLevelLabel == nil then
        self.mGetRankLevelLabel = self:Get("Total/rankingValue", "Top_UILabel")
    end
    return self.mGetRankLevelLabel
end

---@return Top_UIGridContainer
function GuildBossRankRewardItemTemp:GetItemGrid()
    if self.mGetItemGrid == nil then
        self.mGetItemGrid = self:Get("quiteDropGrid", "Top_UIGridContainer")
    end
    return self.mGetItemGrid
end

--endregion

function GuildBossRankRewardItemTemp:Init()

end

---@param tbl TABLE.cfg_union_boss_rank
function GuildBossRankRewardItemTemp:UpdateUnit(tbl)
    self:GetRankLevelLabel().text = "第 "..tostring(tbl:GetRank()).." 名"
    self:UpdateRewardItemGrid(tbl)
end

---@param tbl TABLE.cfg_union_boss_rank
function GuildBossRankRewardItemTemp:UpdateRewardItemGrid(tbl)
    if(tbl == nil or tbl:GetItem() == nil) then
        return;
    end

    self:GetItemGrid().MaxCount = #tbl:GetItem().list
    local index = 0
    for i, v in pairs(tbl:GetItem().list) do
        local obj = self:GetItemGrid().controlList[index]
        local iconSprite =  CS.Utility_Lua.GetComponent(obj.transform:Find("icon"), "Top_UISprite");
        local countLabel =  CS.Utility_Lua.GetComponent(obj.transform:Find("count"), "Top_UILabel");

        local data = v.list
        local itemId = data[1]
        local count = data[2]
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)

        CS.UIEventListener.Get(obj).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl:CsTABLE(), showRight = false })
        end

        if(itemId ~= nil) then
            iconSprite.spriteName = itemTbl:GetIcon()
            countLabel.text = tostring(count)
        end

        index = index + 1
    end
end

return GuildBossRankRewardItemTemp