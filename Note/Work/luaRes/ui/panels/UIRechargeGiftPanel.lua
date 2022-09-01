local UIRechargeGiftPanel = {}

function UIRechargeGiftPanel:Init()
    self.mCloseBtn = self:GetCurComp("events/close", "GameObject")
    self.mGetBtn = self:GetCurComp("view/btn_get", "GameObject")
    self.mTitle = self:GetCurComp("view/background/Table/title", "Top_UILabel")
    self.reward_bg = self:GetCurComp("view/background/reward_bg", "Top_UISprite")
    self.reward_sprite = self:GetCurComp("view/background/reward_limit/reward_icon", "Top_UISprite")
    self.reward_bgGo = self:GetCurComp("view/background/reward_limit/Sprite", "GameObject")
    self.reward_label = self:GetCurComp("view/background/reward_limit/reward_label", "Top_UISprite")
    self.reward_go = self:GetCurComp("view/background/reward_limit/reward_icon", "GameObject")
    self.RewardCount_UILabel = self:GetCurComp("view/background/reward_limit/reward_count", "Top_UILabel")
    self.rewardsList = self:GetCurComp("view/rewardsList", "Top_UIGridContainer")
    self.price_UILabel = self:GetCurComp("view/btn_get/cost/label", "UILabel")
    self.mDes2TimeCount_UILabel = self:GetCurComp("view/background/description2", "UICountdownLabel")
    self:InitData()
    self:BindMessage()
    self:BindUIEvent()
end

function UIRechargeGiftPanel:BindMessage()

end

function UIRechargeGiftPanel:BindUIEvent()
    CS.UIEventListener.Get(self.mCloseBtn).onClick = function()
        self:CloseBtnOnClick();
    end
    CS.UIEventListener.Get(self.mGetBtn).onClick = function()
        self:GetBtnOnClick();
    end
    CS.UIEventListener.Get(self.reward_go).onClick = function()
        self:OnClickBuyingReward();
    end
end

function UIRechargeGiftPanel:InitData()
    local isFind, globalinfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22836)
    local giftId = 0
    if (isFind) then
        local params = string.Split(globalinfo.value, '#')
        if (#params >= 4) then
            giftId = tonumber(params[4])
        end
    end

    local isFind, rechargeinfo = CS.Cfg_RechargeTableManager.Instance:TryGetValue(giftId)

    CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfo(rechargeinfo.storeIndex, function(info)
        self.storeInfo = info
        if (isFind) then
            self:RefreshUI(rechargeinfo)
        end
    end)
    if (self.storeInfo == nil) then
        uimanager:ClosePanel("UIRechargeGiftPanel")
    end
end

--region 客户端事件
function UIRechargeGiftPanel:CloseBtnOnClick(go)
    uimanager:ClosePanel("UIRechargeGiftPanel")
end

function UIRechargeGiftPanel:OnClickBuyingReward(go)
    if self.mBuyingRewardInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mBuyingRewardInfo, showRight = false, isExhibitionPanel = true, ExhibitionPanelNeedLink = false })
    end
end

function UIRechargeGiftPanel:GetBtnOnClick(go)
    if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
        if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
            if (CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.Diamond) >= self.storeInfo.price) then
                networkRequest.ReqBuyItem(self.storeInfo.storeId, 1, self.storeInfo.storeTable.itemId, 1)
                local uiRechargePanel = uimanager:GetPanel("UIRechargePanel")
                if uiRechargePanel ~= nil then
                    uiRechargePanel.mIsRequestedBuyItem = true
                end
            else
                Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.DiamondToPushGiftPanel)
            end
        else
            if (CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.Diamond) >= self.storeInfo.price) then
                networkRequest.ReqBuyItem(self.storeInfo.storeId, 1, self.storeInfo.storeTable.itemId, 1)
                local uiRechargePanel = uimanager:GetPanel("UIRechargePanel")
                if uiRechargePanel ~= nil then
                    uiRechargePanel.mIsRequestedBuyItem = true
                end
            else
                Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.DiamondToPushGiftPanel)
            end
        end
    end
    self:CloseBtnOnClick(go)
end

function UIRechargeGiftPanel:RefreshUI(info)
    if (self.storeInfo ~= nil) then
        self.price = self.storeInfo.price
        self.mTitle.text = tostring(math.ceil(self.price / 100))
        self.price_UILabel.text = tostring(math.ceil(self.price))
    end

    local data = string.Split(info.title, '#')
    if (#data >= 1) then
        self.reward_bg.spriteName = data[1]
    end
    local rewardList = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(info.reward)
    local itemInfo = self:GetItemInfoCache(rewardList[0].itemId)
    if (rewardList[0].count == 1) then
        self.RewardCount_UILabel.text = ""
    else
        self.RewardCount_UILabel.text = rewardList[0].count
    end

    if (self.reward_label ~= nil) then
        self.reward_label.spriteName = info.effectId
        self.reward_label:MakePixelPerfect()
    end

    if itemInfo then
        self.reward_sprite.spriteName = itemInfo.icon
        self.mBuyingRewardInfo = itemInfo
    end

    self.rewardsList.MaxCount = rewardList.Count - 1
    for i = 0, self.rewardsList.MaxCount - 1 do
        local go = self.rewardsList.controlList[i]
        local info = rewardList[i + 1]
        self:RefreshRewardItem(go, info.itemId, info.count)
    end

    self.reward_bgGo.gameObject:SetActive(false)
    self.mDes2TimeCount_UILabel.gameObject:SetActive(false)

    --local time = info.effectiveTime
    --if time and time.list.Count >= 2 then
    --    local days = time.list[1]
    --    local finishTime = CS.CSRechargeInfoV2.GetFinishTimeStamp(days)
    --    --self.mDes2TimeCount_UILabel:StartCountDown(nil, 10, finishTime * 1000, "[e85038]", "后结束", nil, function()
    --    --    --networkRequest.ReqRechargeGiftBox()
    --    --end)
    --end
end

---刷新单个奖励格子
---@param go UnityEngine.GameObject 奖励格子
---@param itemId number 奖励id
---@param rewardNum number 奖励数目
function UIRechargeGiftPanel:RefreshRewardItem(go, itemId, rewardNum)
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    local itemInfo = self:GetItemInfoCache(itemId)
    if itemInfo then
        icon.spriteName = itemInfo.icon
        CS.UIEventListener.Get(go).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false, isExhibitionPanel = true, ExhibitionPanelNeedLink = false })
        end
    end
    if rewardNum and rewardNum > 1 then
        count.text = rewardNum
    else
        count.text = ""
    end
end

---@return TABLE.CFG_ITEMS 获取道具缓存信息
function UIRechargeGiftPanel:GetItemInfoCache(itemId)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[itemId]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = info
    end
    return info
end
--endregion

function ondestroy()

end

return UIRechargeGiftPanel