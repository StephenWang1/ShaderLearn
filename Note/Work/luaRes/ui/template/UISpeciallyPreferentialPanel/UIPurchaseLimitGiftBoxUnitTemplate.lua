---@class UIPurchaseLimitGiftBoxUnitTemplate :UIRechargeRewardTemplate 限购礼包格子模板
local UIPurchaseLimitGiftBoxUnitTemplate = {}

setmetatable(UIPurchaseLimitGiftBoxUnitTemplate, luaComponentTemplates.UIRechargeRewardTemplate)

function UIPurchaseLimitGiftBoxUnitTemplate:InitComponent()
    self:RunBaseFunction("InitComponent")
    ---@type UILabel 限购文本
    self.LimitBuy = self:Get("LimitBuy", "UILabel")

end

---@param data activitiesV2.OneActivitiesInfo
function UIPurchaseLimitGiftBoxUnitTemplate:Refresh(data)
    if data then
        ---@type activitiesV2.OneActivitiesInfo
        self.singleActivityData = data
        if self:RefreshData() then
            self:RefreshView()
        end
    end
end

---刷新数据
---@return boolean 数据是否初始化完成
function UIPurchaseLimitGiftBoxUnitTemplate:RefreshData()
    if self.singleActivityData == nil then
        return false
    end
    ---@type TABLE.cfg_special_activity
    self.specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(self.singleActivityData.configId)
    if self.specialActivityTbl == nil then
        return false
    end
    local rechargeId = (self.specialActivityTbl:GetGoal() ~= nil and #self.specialActivityTbl:GetGoal().list > 0) and self.specialActivityTbl:GetGoal().list[1] or 0
    ---@type TABLE.cfg_recharge
    self.rechargeTbl = clientTableManager.cfg_rechargeManager:TryGetValue(rechargeId)

    local boxID = (self.rechargeTbl ~= nil and self.rechargeTbl:GetReward() ~= nil) and self.rechargeTbl:GetReward() or 0
    ---@type <number,bagV2.CoinInfo>
    self.rewardInfo = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(boxID)

    self.allTemplateByRewardGoTbl = {}

    local storeIndex = (self.rechargeTbl ~= nil and self.rechargeTbl:GetStoreIndex() ~= nil) and self.rechargeTbl:GetStoreIndex() or 0

    if self.rechargeTbl ~= nil and self.rechargeTbl:GetType() == luaEnumRechargeRewardType.DiamondRechargeGift then
        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfo(storeIndex, function(storeVo)
            self.storeInfo = storeVo
            self:RefreshView()
        end);
        return false
    end

    return true
end

function UIPurchaseLimitGiftBoxUnitTemplate:RefreshView()
    if self.specialActivityTbl == nil or self.rechargeTbl == nil then
        return
    end

    ---刷新标题
    self.mTitle_UILabel.text = self.specialActivityTbl:GetSmallName()
    ---刷新限购次数
    self.LimitBuy.text = luaEnumColorType.Gray .. '限购' .. tostring(self.singleActivityData.dataParam) .. '/' .. tostring(self.singleActivityData.date64Param)

    ---按钮文本
    local showCoinStr = ''
    if self.rechargeTbl:GetType() == luaEnumRechargeRewardType.DiamondRechargeGift then
        showCoinStr = self.storeInfo == nil and '0' or tostring(math.ceil(self.storeInfo.price / 10) * 10)
    elseif self.rechargeTbl ~= nil and self.rechargeTbl:GetRmb() ~= nil then
        showCoinStr = '￥' .. tostring(math.ceil(self.rechargeTbl:GetRmb() / 100))
    end
    self.price_UILabel.text = showCoinStr
    ---钻石图片
    self.mDiamondSprite_UISprite.gameObject:SetActive(self.rechargeTbl:GetType() == luaEnumRechargeRewardType.DiamondRechargeGift)
    self.updateItem = CS.CSListUpdateMgr.Add(300, nil, function()
        if self.go == nil or CS.StaticUtility.IsNull(self.go) then
            return
        end
        self.mDiamondSprite_UISprite:MakePixelPerfect()
        self.mDiamondSprite_UISprite:UpdateAnchors()
    end)
    self.mBuyingTable_UITable.IsDealy = true
    self.mBuyingTable_UITable:Reposition();
    ---刷新奖励显示
    self:RefreshRewardView()
end

---刷新奖励显示
function UIPurchaseLimitGiftBoxUnitTemplate:RefreshRewardView()
    if self.rewardInfo.Count == 0 then
        return
    end

    ---首个显示上方大框里
    if self.bigRewardTemplate == nil then
        self.bigRewardTemplate = templatemanager.GetNewTemplate(self.BuyRewardGO, luaComponentTemplates.UIItem)
    end

    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.rewardInfo[0].itemId)
    if isFind then
        self.bigRewardTemplate:RefreshUIWithItemInfo(itemInfo, self.rewardInfo[0].count)
        self.bigRewardTemplate:RefreshOtherUI({ showItemInfo = itemInfo })
    end

    self.mRewardList_UIGridContainer.MaxCount = self.rewardInfo.Count - 1
    for i = 1, self.rewardInfo.Count - 1 do
        local go = self.mRewardList_UIGridContainer.controlList[i - 1]
        ---@type UIItem
        local template = self.allTemplateByRewardGoTbl[go]
        local rewardInfo = self.rewardInfo[i]
        if template == nil then
            template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
            self.allTemplateByRewardGoTbl[go] = template
        end
        local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.itemId)
        if isFind then
            template:RefreshUIWithItemInfo(itemInfo, rewardInfo.count)
            template:RefreshOtherUI({ showItemInfo = itemInfo })
        end
    end
end

---重写点击购买
function UIPurchaseLimitGiftBoxUnitTemplate:OnGetItemClicked(go)
    ---策划需求空余格子数量小于四个不让购买
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetEmptyGridCount() < 4 then
        Utility.ShowPopoTips(go.transform, nil, 281, 'UISpeciallyPreferentialPanel')
        return
    end

    if self.rechargeTbl == nil then
        return
    end

    ---对限制次数做校验
    if self.singleActivityData ~= nil and self.singleActivityData.dataParam == self.singleActivityData.date64Param then
        return
    end

    if (self.rechargeTbl:GetType() == luaEnumRechargeRewardType.DiamondRechargeGift and self.storeInfo ~= nil) then
        if (CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.Diamond) >= self.storeInfo.price) then
            --networkRequest.ReqBuyItem(self.storeInfo.storeId, 1, self.storeInfo.storeTable.itemId, 1)
            --local uiRechargePanel = uimanager:GetPanel("UIRechargePanel")
            --if uiRechargePanel ~= nil then
            --    uiRechargePanel.mIsRequestedBuyItem = true
            --end
            if self.specialActivityTbl ~= nil then
                networkRequest.ReqGetOneActivitiesAward(self.specialActivityTbl.id)
            end
        else
            Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.CrossServerLimitGift)
        end
    else
        Utility.PayRechargeItem(self.rechargeTbl)
    end
end

function UIPurchaseLimitGiftBoxUnitTemplate:onDestroy()
    if self.updateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
        self.updateItem = nil
    end
end

return UIPurchaseLimitGiftBoxUnitTemplate