---@class UIDefKingRankFirstUnit 排行榜单元类型二（帮会）
local UIDefKingRankFirstUnit = {}

--region 初始化

function UIDefKingRankFirstUnit:Init()
    self:InitComponents()
    --self:InitParameters()
    --self:BindUIMessage()
    --self:BindNetMessage()
end
--初始化变量
function UIDefKingRankFirstUnit:InitParameters()
end

function UIDefKingRankFirstUnit:InitComponents()
    ---@type Top_UISprite
    self.firstSprite = self:Get("firstSprite", "Top_UISprite")
    ---@type Top_UILabel
    self.firstValue = self:Get("firstValue", "Top_UILabel")
    ---@type Top_UILabel
    self.secondValue = self:Get("secondValue", "Top_UILabel")
    ---@type Top_UILabel
    self.thirdValue = self:Get("thirdValue", "Top_UILabel")
    ---@type Top_UIGridContainer
    self.rewardList = self:Get("rewardList", "Top_UIGridContainer")
end

function UIDefKingRankFirstUnit:BindUIMessage()

end

function UIDefKingRankFirstUnit:BindNetMessage()

end

--endregion

--region Show

---@param customData table
---{
---@field customData.firstSpriteName string
---@field customData.firstValue      string
---@field customData.secondValue     string
---@field customData.thirdValue      string
---@field customData.rewardValue     table
---}
function UIDefKingRankFirstUnit:SetTemplate(customData)
    if customData then
        self.firstSprite.spriteName = customData.firstSpriteName
        self.firstValue.text = customData.firstValue
        self.secondValue.text = customData.secondValue
        self.thirdValue.text = customData.thirdValue
        self:SetRewardList(customData.rewardValue)
    end
end

function UIDefKingRankFirstUnit:SetRewardList(rewards)
    if rewards == nil then
        --清空
        for i = 1, self.rewardList.controlList.Count do
            self.rewardList:ClearItem(i)
        end
        return
    end
    self.rewardList.MaxCount = rewards.Count
    for i = 0, rewards.Count - 1 do
        for i = 0, rewards.Count - 1 do
            self.rewardList.MaxCount = i + 1
            local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(rewards[i].itemId)
            if infobool then
                local go = self.rewardList.controlList[i]
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo, rewards[i].num)
            end
        end
    end
end

--endregion

--region UI函数监听

--endregion

--region otherFunction



--endregion

return UIDefKingRankFirstUnit