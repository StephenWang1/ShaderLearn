local UINormalRechargeUnitTemplate = {}

setmetatable(UINormalRechargeUnitTemplate, luaComponentTemplates.UIRechargeUnitTemplate)

--region 组件
function UINormalRechargeUnitTemplate:GetRewards_UIGridContainer()
    if (self.mRewardsGrid == nil) then
        self.mRewardsGrid = self:Get("DayRecharge/rewards/rewards", "Top_UIGridContainer")
    end
    return self.mRewardsGrid
end

function UINormalRechargeUnitTemplate:GetAttachedGift_GameObject()
    if (self.mAttachedGift_GameObject == nil) then
        self.mAttachedGift_GameObject = self:Get("AttachedGift", "GameObject")
    end
    return self.mAttachedGift_GameObject
end

function UINormalRechargeUnitTemplate:GetNormalReward_GameObject()
    if (self.mNormalReward_GameObject == nil) then
        self.mNormalReward_GameObject = self:Get("DayRecharge/normalReward", "GameObject")
    end
    return self.mNormalReward_GameObject
end

function UINormalRechargeUnitTemplate:GetRebateIcon_UISprite()
    if (self.mIcon_UISprite == nil) then
        self.mIcon_UISprite = self:Get("DayRecharge/normalReward/icon", "UISprite")
    end
    return self.mIcon_UISprite
end

function UINormalRechargeUnitTemplate:GetRebatePrice_UILabel()
    if (self.mPrice_UILabel == nil) then
        self.mPrice_UILabel = self:Get("DayRecharge/normalReward/price", "UILabel")
    end
    return self.mPrice_UILabel
end
--endregion

--region 初始化
function UINormalRechargeUnitTemplate:InitData()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22088)
    if (isFind) then
        self.iconName = info.value
    end
    self:InitPanel()
    self:InitParams()
    self:UpdateRewards()
end

function UINormalRechargeUnitTemplate:InitPanel()
    self:GetAttachedGift_GameObject():SetActive(false)
    self:GetNormalReward_GameObject():SetActive(false)
end

function UINormalRechargeUnitTemplate:InitParams()
    self.rebateCoinItemId = LuaGlobalTableDeal:GetRebateCoinItemId()
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.rebateCoinItemId)
    if itemInfoIsFind then
        self.rebateCoinItemInfo = itemInfo
    end
end

function UINormalRechargeUnitTemplate:Init(panel)
    self.panel = panel
    self:InitPanel()
end
--endregion

--region 刷新
---刷新奖励
function UINormalRechargeUnitTemplate:RefreshUIItem(tableData)
    self.mTableData = tableData;
    local day = CS.CSScene.MainPlayerInfo.ActualOpenDays
    local rewardBoxId = gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetRechargeDiamondRewardNum(self.mTableData:GetId(), day)
    self:GetRewards_UIGridContainer().gameObject:SetActive(rewardBoxId ~= nil)
    local rewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(rewardBoxId)
    self:GetRewards_UIGridContainer().MaxCount = rewardList.Count
    for i = 0, rewardList.Count - 1 do
        local go = self:GetRewards_UIGridContainer().controlList[i]
        local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite")
        local count = CS.Utility_Lua.GetComponent(go.transform:Find("count"), "Top_UILabel")
        local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardList[i].itemId)
        count.text = rewardList[i].count == 0 and "" or rewardList[i].count
        if (isfind) then
            icon.spriteName = itemInfo.icon
        end
    end
end
--endregion

return UINormalRechargeUnitTemplate