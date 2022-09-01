local UIDisposeItemPanel = {};

UIDisposeItemPanel.buyItemdata = nil;

UIDisposeItemPanel.mStoreTable = nil;

UIDisposeItemPanel.mIsUseReplaceMoney = false;

function UIDisposeItemPanel:IsNeedPlayOpenAudio()
    return false
end

--region Components
--region GameObject

function UIDisposeItemPanel.GetRootNode_GameObject()
    if (UIDisposeItemPanel.mWidgetRoot_GameObject == nil) then
        UIDisposeItemPanel.mWidgetRoot_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root", "GameObject");
    end
    return UIDisposeItemPanel.mWidgetRoot_GameObject;
end

function UIDisposeItemPanel.GetUIItem_GameObject()
    if (UIDisposeItemPanel.mUIItem_GameObject == nil) then
        UIDisposeItemPanel.mUIItem_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/UIItem", "GameObject");
    end
    return UIDisposeItemPanel.mUIItem_GameObject;
end

function UIDisposeItemPanel.GetBtnAdd_GameObject()
    if (UIDisposeItemPanel.mBtnAdd_GaemObject == nil) then
        UIDisposeItemPanel.mBtnAdd_GaemObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/add", "GameObject");
    end
    return UIDisposeItemPanel.mBtnAdd_GaemObject;
end

function UIDisposeItemPanel.GetBtnReduce_GameObject()
    if (UIDisposeItemPanel.mBtnReduce_GameObject == nil) then
        UIDisposeItemPanel.mBtnReduce_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/reduce", "GameObject");
    end
    return UIDisposeItemPanel.mBtnReduce_GameObject;
end

function UIDisposeItemPanel.GetBtnCancel_GameObject()
    if (UIDisposeItemPanel.mBtnCancel_GameObject == nil) then
        UIDisposeItemPanel.mBtnCancel_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/btn_cancel", "GameObject");
    end
    return UIDisposeItemPanel.mBtnCancel_GameObject;
end

function UIDisposeItemPanel.GetBackGround_GameObject()
    if (UIDisposeItemPanel.mBackGround_GameObject == nil) then
        UIDisposeItemPanel.mBackGround_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/window/box", "GameObject");
    end
    return UIDisposeItemPanel.mBackGround_GameObject;
end

function UIDisposeItemPanel.GetBtnBuy_GameObject()
    if (UIDisposeItemPanel.mBtnBuy_GameObject == nil) then
        UIDisposeItemPanel.mBtnBuy_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/dispose", "GameObject");
    end
    return UIDisposeItemPanel.mBtnBuy_GameObject;
end

function UIDisposeItemPanel.GetBtnCommerceBtn_GameObject()
    if (UIDisposeItemPanel.mBtnCommerceBtn_GameObject == nil) then
        UIDisposeItemPanel.mBtnCommerceBtn_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/CommerceBtn", "GameObject");
    end
    return UIDisposeItemPanel.mBtnCommerceBtn_GameObject;
end

function UIDisposeItemPanel.GetTitleBtn_GameObject()
    if (UIDisposeItemPanel.mTitleBtn_GameObject == nil) then
        UIDisposeItemPanel.mTitleBtn_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/events/TitleBtns", "GameObject");
    end
    return UIDisposeItemPanel.mTitleBtn_GameObject;
end

function UIDisposeItemPanel.GetTitleBtnLeft_GameObject()
    if (UIDisposeItemPanel.mTitleBtnLeft_GameObject == nil) then
        UIDisposeItemPanel.mTitleBtnLeft_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/events/TitleBtns/left", "GameObject");
    end
    return UIDisposeItemPanel.mTitleBtnLeft_GameObject;
end

function UIDisposeItemPanel.GetTitleBtnRight_GameObject()
    if (UIDisposeItemPanel.mTitleBtnRight_GameObject == nil) then
        UIDisposeItemPanel.mTitleBtnRight_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/events/TitleBtns/right", "GameObject");
    end
    return UIDisposeItemPanel.mTitleBtnRight_GameObject;
end

function UIDisposeItemPanel.GetDownline_GameObject()
    if (UIDisposeItemPanel.mDownline_GameObject == nil) then
        UIDisposeItemPanel.mDownline_GameObject = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/window/downline", "GameObject");
    end
    return UIDisposeItemPanel.mDownline_GameObject;
end

--region Sprite
function UIDisposeItemPanel.GetBackground_Sprite()
    if (UIDisposeItemPanel.mBackground_Sprite == nil) then
        UIDisposeItemPanel.mBackground_Sprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/window/background", "UISprite");
    end
    return UIDisposeItemPanel.mBackground_Sprite;
end

function UIDisposeItemPanel.GetMoneyTypeSprite_Sprite()
    if (UIDisposeItemPanel.mMoneyTypeSprite_Sprite == nil) then
        UIDisposeItemPanel.mMoneyTypeSprite_Sprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/pricetitle/Sprite", "UISprite");
    end
    return UIDisposeItemPanel.mMoneyTypeSprite_Sprite;
end

function UIDisposeItemPanel.GetAllMoneyTypeSprite_Sprite()
    if (UIDisposeItemPanel.mAllMoneyTypeSprite_Sprite == nil) then
        UIDisposeItemPanel.mAllMoneyTypeSprite_Sprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/itemgold/Sprite", "UISprite");
    end
    return UIDisposeItemPanel.mAllMoneyTypeSprite_Sprite;
end

function UIDisposeItemPanel.GetBackground_Sprite()
    if (UIDisposeItemPanel.mBackground_Sprite == nil) then
        UIDisposeItemPanel.mBackground_Sprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/window/background", "UISprite");
    end
    return UIDisposeItemPanel.mBackground_Sprite;
end

function UIDisposeItemPanel.GetMinegoldSprite_Sprite()
    if (UIDisposeItemPanel.mMinegoldSprite_Sprite == nil) then
        UIDisposeItemPanel.mMinegoldSprite_Sprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/minegold/Sprite", "UISprite");
    end
    return UIDisposeItemPanel.mMinegoldSprite_Sprite;
end

function UIDisposeItemPanel.GetTitleBtnLeftIcon_UISprite()
    if (UIDisposeItemPanel.mTitleBtnLeftIcon_UISprite == nil) then
        UIDisposeItemPanel.mTitleBtnLeftIcon_UISprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/events/TitleBtns/left/Bg/icon", "UISprite");
    end
    return UIDisposeItemPanel.mTitleBtnLeftIcon_UISprite;
end

function UIDisposeItemPanel.GetTitleBtnLeftIcon1_UISprite()
    if (UIDisposeItemPanel.mTitleBtnLeftIcon1_UISprite == nil) then
        UIDisposeItemPanel.mTitleBtnLeftIcon1_UISprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/events/TitleBtns/left/icon", "UISprite");
    end
    return UIDisposeItemPanel.mTitleBtnLeftIcon1_UISprite;
end

function UIDisposeItemPanel.GetTitleBtnRightIcon_UISprite()
    if (UIDisposeItemPanel.mTitleBtnRightIcon_UISprite == nil) then
        UIDisposeItemPanel.mTitleBtnRightIcon_UISprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/events/TitleBtns/right/Bg/icon", "UISprite");
    end
    return UIDisposeItemPanel.mTitleBtnRightIcon_UISprite;
end

function UIDisposeItemPanel.GetTitleBtnRightIcon1_UISprite()
    if (UIDisposeItemPanel.mTitleBtnRightIcon1_UISprite == nil) then
        UIDisposeItemPanel.mTitleBtnRightIcon1_UISprite = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/events/TitleBtns/right/icon", "UISprite");
    end
    return UIDisposeItemPanel.mTitleBtnRightIcon1_UISprite;
end
--endregion

--region UILabel
function UIDisposeItemPanel.GetMoneyValueText_Text()
    if (UIDisposeItemPanel.mMoneyValueText_Text == nil) then
        UIDisposeItemPanel.mMoneyValueText_Text = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/pricetitle/Label", "UILabel");
    end
    return UIDisposeItemPanel.mMoneyValueText_Text;
end

function UIDisposeItemPanel.GetAllMoneyValueText_Text()
    if (UIDisposeItemPanel.mAllMoneyValueText_Text == nil) then
        UIDisposeItemPanel.mAllMoneyValueText_Text = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/itemgold", "UILabel");
    end
    return UIDisposeItemPanel.mAllMoneyValueText_Text;
end

function UIDisposeItemPanel.GetMinegoldText_Text()
    if (UIDisposeItemPanel.mMinegoldText_Text == nil) then
        UIDisposeItemPanel.mMinegoldText_Text = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/minegold", "UILabel");
    end
    return UIDisposeItemPanel.mMinegoldText_Text;
end

function UIDisposeItemPanel.GetMaxBuyCount_Text()
    if (UIDisposeItemPanel.mMaxBuyCount_Text == nil) then
        UIDisposeItemPanel.mMaxBuyCount_Text = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/UIItem/MaxValueLabel", "UILabel");
    end
    return UIDisposeItemPanel.mMaxBuyCount_Text;
end
--endregion

--endregion

--region Others
function UIDisposeItemPanel.GetUIItem_UIItem()
    if (UIDisposeItemPanel.mUIItem_UIItem == nil) then
        UIDisposeItemPanel.mUIItem_UIItem = templatemanager.GetNewTemplate(UIDisposeItemPanel.GetUIItem_GameObject(), luaComponentTemplates.UIItem);
    end
    return UIDisposeItemPanel.mUIItem_UIItem;
end

function UIDisposeItemPanel.GetInputText_UIInput()
    if (UIDisposeItemPanel.mInputText_UIInput == nil) then
        UIDisposeItemPanel.mInputText_UIInput = UIDisposeItemPanel:GetCurComp("WidgetRoot/root/view/inputcount", "UIInput");
        UIDisposeItemPanel.mInputText_UIInput.submitOnUnselect = true;
        CS.EventDelegate.Add(UIDisposeItemPanel.mInputText_UIInput.onSubmit, UIDisposeItemPanel.OnUIInputValueChanged);
    end
    return UIDisposeItemPanel.mInputText_UIInput;
end

function UIDisposeItemPanel.GetPanel()
    if (UIDisposeItemPanel.mGetPanel == nil) then
        UIDisposeItemPanel.mGetPanel = CS.Utility_Lua.GetComponent(UIDisposeItemPanel.go, "Top_UIPanel")
    end
    return UIDisposeItemPanel.mGetPanel;
end
--endregion
--endregion

--region Method

--region CallFunc
function UIDisposeItemPanel.OnClickBtnAdd()
    local maxCount = UIDisposeItemPanel.GetMaxBuyCount();
    local buyNum = UIDisposeItemPanel.GetInputText_UIInput().value + 1;
    if (buyNum > maxCount) then
        buyNum = maxCount;
    end
    UIDisposeItemPanel.SetBuyNum(buyNum);
end

function UIDisposeItemPanel.OnClickBtnReduce()
    local minCount = UIDisposeItemPanel.GetMinBuyCount();
    local buyNum = UIDisposeItemPanel.GetInputText_UIInput().value - 1;
    if (buyNum < minCount) then
        local canBuyMaxNum = UIDisposeItemPanel.GetCanBuyMaxNum();
        buyNum = canBuyMaxNum > minCount and canBuyMaxNum or minCount;
    end
    UIDisposeItemPanel.SetBuyNum(buyNum);
end

function UIDisposeItemPanel.OnClickBtnClose()
    uimanager:ClosePanel("UIDisposeItemPanel");
end

function UIDisposeItemPanel.OnClickBtnBuy()
    local tabledata = UIDisposeItemPanel.mStoreTable;
    local buyNum = tonumber(UIDisposeItemPanel.GetInputText_UIInput().value);
    if (buyNum > 0) then
        local stateCode = UIDisposeItemPanel.GetBuyItemCode(buyNum);
        if (stateCode == 2) then
            --UIDisposeItemPanel.OnClickBtnClose()
            return
        elseif (stateCode == 1) then
            local isFind, moneyItemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(UIDisposeItemPanel.GetMoneyType());
            if (moneyItemTable ~= nil) then
                if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(moneyItemTable.id)) then
                    if (UIDisposeItemPanel.buyItemdata.storeClassId == LuaEnumStoreType.Diamond) then
                        Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.ShopDiamondNotEnough);
                    elseif (UIDisposeItemPanel.buyItemdata.storeClassId == LuaEnumStoreType.CommerceDiamond) then
                        Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.CommerceShopDiamondNotEnough);
                    end
                elseif (moneyItemTable.id == 6210001 or moneyItemTable.id == 6210002) then
                    local data = 0
                    --创造宝石(绑定或者非绑定,两者数量需要同时计算)
                    data = data + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210001)
                    data = data + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210002)
                    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.CommerceShopGemsNotEnough
                    Utility.ShowItemGetWay(moneyItemTable.id, UIDisposeItemPanel.GetBtnBuy_GameObject(), LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0), nil, nil);
                else
                    local EntraceType = nil
                    if (UIDisposeItemPanel.buyItemdata.storeClassId == LuaEnumStoreType.YuanBao) then
                        uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.ShopIngotNotEnough
                        EntraceType = LuaEnumRechargePointType.ShopPanelIngotNotEnoughToRewardGift
                    elseif (UIDisposeItemPanel.buyItemdata.storeClassId == LuaEnumStoreType.CommerceDiamond) then
                        uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.CommerceShopIngotNotEngough
                        EntraceType = LuaEnumRechargePointType.CommerceShopIngotNotEngoughToRewardGift
                    elseif (UIDisposeItemPanel.buyItemdata.storeClassId == LuaEnumStoreType.GoldShop) then
                        EntraceType = LuaEnumRechargePointType.ShopPanelGoldNotEnoughToRewardGift
                    end
                    Utility.ShowItemGetWay(moneyItemTable.id, UIDisposeItemPanel.GetBtnBuy_GameObject(), LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0), nil, EntraceType);
                end
            end
        elseif (stateCode == 0) then
            if (UIDisposeItemPanel.mIsUseReplaceMoney) then
                networkRequest.ReqBuyItem(UIDisposeItemPanel.buyItemdata.storeId, buyNum, tabledata.itemId, 0, 1);
            else
                networkRequest.ReqBuyItem(UIDisposeItemPanel.buyItemdata.storeId, buyNum, tabledata.itemId, 0, 0);
            end
            local isFind, info = CS.Cfg_StoreTableManager.Instance.PreNumStoreDic:TryGetValue(UIDisposeItemPanel.buyItemdata.storeId)
            if (isFind) then
                CS.UnityEngine.PlayerPrefs.SetInt("BuyItemCount" .. tostring(CS.CSScene.MainPlayerInfo.ID) .. tostring(info.id), buyNum)
            end
            UIDisposeItemPanel.OnClickBtnClose();
        end
    else
        CS.Utility.ShowTips("购买数量不可为0!", 1, CS.ColorType.Red)
    end
end

function UIDisposeItemPanel.OnCommerceBtnClick()
    uimanager:CreatePanel("UICommercePanel")
end

function UIDisposeItemPanel.OnUIInputValueChanged()
    local buyNum = UIDisposeItemPanel.GetInputText_UIInput().value == "" and 0 or tonumber(UIDisposeItemPanel.GetInputText_UIInput().value);
    buyNum = buyNum == nil and UIDisposeItemPanel.GetMinBuyCount() or buyNum;
    buyNum = buyNum > UIDisposeItemPanel.GetMaxBuyCount() and UIDisposeItemPanel.GetMaxBuyCount() or buyNum;
    buyNum = buyNum < UIDisposeItemPanel.GetMinBuyCount() and UIDisposeItemPanel.GetMinBuyCount() or buyNum;
    UIDisposeItemPanel.SetBuyNum(buyNum);
end

function UIDisposeItemPanel.GetSuitableBuyCount(id)
    local count = CS.UnityEngine.PlayerPrefs.GetInt("BuyItemCount" .. tostring(CS.CSScene.MainPlayerInfo.ID) .. tostring(id))
    local stateCode = UIDisposeItemPanel.GetBuyItemCode(count);
    if (stateCode == 1) then
        return UIDisposeItemPanel.GetCanBuyMaxNum() <= UIDisposeItemPanel.GetMinBuyCount() and UIDisposeItemPanel.GetMinBuyCount() or UIDisposeItemPanel.GetCanBuyMaxNum()
    else
        return count
    end
end
--endregion

--region Private

function UIDisposeItemPanel.GetPrice(buyNum)
    if (buyNum == nil) then
        buyNum = UIDisposeItemPanel.GetMinBuyCount();
    end
    return buyNum * UIDisposeItemPanel.GetMoneyPrice();
end

function UIDisposeItemPanel.GetTitleBtnIconName(isReplaceMoney)
    local moneyType = UIDisposeItemPanel.GetMoneyType(isReplaceMoney);
    if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(moneyType)) then
        if UIDisposeItemPanel.mIsUseReplaceMoney then
            return "tips_topicon5_1"
        else
            return "tips_topicon5_2"
        end
    elseif (moneyType == LuaEnumCoinType.YuanBao) then
        return "tips_topicon4_2";
    elseif (moneyType == 6210001 or moneyType == 6210002) then
        if UIDisposeItemPanel.mIsUseReplaceMoney then
            return "tips_topicon8_2";
        else
            return "tips_topicon8_1"
        end
    end
    return "tips_topicon4_2";
end

---获取购买物品状态码
---@return 0:没有异常可购买, 1:货币不足 2:跳出特殊礼包推送，取消本次购买
function UIDisposeItemPanel.GetBuyItemCode(buyNum)
    local storeTable = UIDisposeItemPanel.mStoreTable;
    local price = UIDisposeItemPanel.GetPrice(buyNum);
    if (storeTable ~= nil) then
        local costItemId = UIDisposeItemPanel.GetMoneyType();

        --创造宝石(绑定或者非绑定,两者数量需要同时计算)
        if (costItemId == 6210001 or costItemId == 6210002) then
            local data = 0
            data = data + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210001)
            data = data + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210002)
            if (data < price) then
                return 1
            end
            return 0
        end

        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(costItemId);
        if (isFind) then
            local isGetValue = false;
            local costCount = 0;
            if (itemTable.type == luaEnumItemType.Coin) then
                if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(costItemId)) then
                    isGetValue = true;
                    costCount = CS.CSScene.MainPlayerInfo.BagInfo.DiamondNum;
                    if (Utility.IsPushSpecialGift()) then
                        uimanager:CreatePanel("UIRechargeGiftPanel")
                        return 2
                    end
                else
                    costCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(costItemId);
                end
            else
                isGetValue = true;
                costCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(costItemId);
            end
            if (costCount < price) then
                return 1;
            end
        end
    end
    return 0;
end

function UIDisposeItemPanel.SetBuyNum(buyNum)
    UIDisposeItemPanel.GetInputText_UIInput().value = Utility.GetIntPart(buyNum);
    UIDisposeItemPanel.GetAllMoneyValueText_Text().text = Utility.GetIntPart(UIDisposeItemPanel.GetPrice(buyNum));

    UIDisposeItemPanel:UpdateMineMoney(buyNum);
end

function UIDisposeItemPanel.GetDefaultBuyCount()
    --如果需要读取上一次购买数量
    if (UIDisposeItemPanel.buyItemdata ~= nil) then
        local isFind, info = CS.Cfg_StoreTableManager.Instance.PreNumStoreDic:TryGetValue(UIDisposeItemPanel.buyItemdata.storeId)
        if (isFind) then
            if CS.UnityEngine.PlayerPrefs.HasKey("BuyItemCount" .. tostring(CS.CSScene.MainPlayerInfo.ID) .. tostring(info.id)) then
                return UIDisposeItemPanel.GetSuitableBuyCount(info.id)
            end
        end
    end
    return UIDisposeItemPanel.GetMinBuyCount()
end

function UIDisposeItemPanel.GetMinBuyCount()
    return 1;
end

function UIDisposeItemPanel.GetMaxBuyCount()
    if (UIDisposeItemPanel.buyItemdata == nil) then
        return 0;
    end

    local selfDayBuyNum = UIDisposeItemPanel.buyItemdata.dayBuyNum;
    local selfLifeBuyNum = UIDisposeItemPanel.buyItemdata.lifeBuyNum;
    local serverDayBuyNum = UIDisposeItemPanel.buyItemdata.serverDayBuyNum;
    local serverLifeBuyNum = UIDisposeItemPanel.buyItemdata.serverLifeBuyNum;
    local tabledata = UIDisposeItemPanel.mStoreTable;
    if (tabledata ~= nil) then
        local selfMaxLimitBuyNum = 0;
        local selfLimitRemainBuyNum = 0;
        local serverMaxLimitBuyNum = 0;
        local serverLimitRemainBuyNum = 0;
        local isLimit = false;
        --region 个人限购
        if (tabledata.singleLimit ~= nil) then

            local list = tabledata.singleLimit.list;
            local limitType;

            if (list.Count > 0) then
                limitType = tabledata.singleLimit.list[0];
            end

            if (limitType == luaEnumShopLimitType.RandomLimitNum) then
                selfMaxLimitBuyNum = UIDisposeItemPanel.buyItemdata.randomLimitNum;
            elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                selfMaxLimitBuyNum = UIDisposeItemPanel.buyItemdata.randomLimitNum;
            else
                if (list.Count > 1) then
                    selfMaxLimitBuyNum = tabledata.singleLimit.list[1];
                end
            end

            if (limitType == luaEnumShopLimitType.DayLimit) then
                selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfDayBuyNum;
            elseif (limitType == luaEnumShopLimitType.LifeLimit) then
                selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfLifeBuyNum;
            elseif (limitType == luaEnumShopLimitType.MysteriousLimit) then
                ---暂时没有字段
            elseif (limitType == luaEnumShopLimitType.RandomLimitNum) then
                selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfDayBuyNum;
            elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfDayBuyNum;
            end
            selfLimitRemainBuyNum = selfLimitRemainBuyNum > 0 and selfLimitRemainBuyNum or 0;
            isLimit = true;
        end
        --endregion
        --region 全服限购
        if (tabledata.allLimit ~= nil) then
            local list = tabledata.allLimit.list;
            local limitType;

            if (list.Count > 0) then
                limitType = tabledata.allLimit.list[0];
            end

            if (limitType == luaEnumShopLimitType.RandomLimitNum) then
                serverMaxLimitBuyNum = UIDisposeItemPanel.buyItemdata.randomLimitNum;
            elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                serverMaxLimitBuyNum = UIDisposeItemPanel.buyItemdata.randomLimitNum;
            else
                if (list.Count > 1) then
                    serverMaxLimitBuyNum = tabledata.allLimit.list[1];
                end
            end

            if (limitType == luaEnumShopLimitType.DayLimit) then
                serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverDayBuyNum;
            elseif (limitType == luaEnumShopLimitType.LifeLimit) then
                serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverLifeBuyNum;
            elseif (limitType == luaEnumShopLimitType.MysteriousLimit) then
                ---暂时没有字段
            elseif (limitType == luaEnumShopLimitType.RandomLimitNum) then
                serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverDayBuyNum;
            elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverDayBuyNum;
            end
            serverLimitRemainBuyNum = serverLimitRemainBuyNum > 0 and serverLimitRemainBuyNum or 0;
            isLimit = true;
        end
        --endregion
        local isFind, itemdata = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tabledata.itemId);
        ---剩余填充满背包的数量
        local bagRemainNum = 0;
        if (isFind) then
            local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo;
            local bagItemInfoList = bagInfo:GetNotFullOverlyingItems(tabledata.itemId);
            ---背包格子剩余可叠加的数量
            local bagItemRemainNum = 0
            --for k,v in pairs(bagItemInfoList) do
            if (bagItemInfoList ~= nil and bagItemInfoList.Count > 0) then
                for i = 0, bagItemInfoList.Count - 1 do
                    bagItemRemainNum = bagItemRemainNum + (itemdata.overlying - bagItemInfoList[i].count);
                end
            end
            ---剩余没有占用的背包格子数量
            local remainBagItemCount = CS.CSScene.MainPlayerInfo.BagInfo.EmptyGridCount;
            local overlying = itemdata.overlying == 0 and 1 or itemdata.overlying;
            bagRemainNum = (remainBagItemCount * overlying) + bagItemRemainNum;
            bagRemainNum = Utility.GetIntPart(bagRemainNum / tabledata.num);
        end
        local returnNum = bagRemainNum;
        if (isLimit) then
            local limitRemainBuyNum = serverLimitRemainBuyNum > selfLimitRemainBuyNum and serverLimitRemainBuyNum or selfLimitRemainBuyNum;
            returnNum = limitRemainBuyNum < bagRemainNum and limitRemainBuyNum or bagRemainNum;
        end
        if (tabledata.singleBuyNumber ~= nil and tabledata.singleBuyNumber ~= 0) then
            returnNum = returnNum > tabledata.singleBuyNumber and tabledata.singleBuyNumber or returnNum;
        end

        return returnNum;
    end
    return 0;
end

function UIDisposeItemPanel.GetCanBuyMaxNum()
    local maxCount = UIDisposeItemPanel.GetMaxBuyCount();
    if (UIDisposeItemPanel.mStoreTable ~= nil) then
        local mCoinsNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(UIDisposeItemPanel.mStoreTable.moneyType)
        --if (isFind) then
        local moneyBuyMaxNum = math.floor(mCoinsNum / UIDisposeItemPanel.buyItemdata.price);
        return maxCount > moneyBuyMaxNum and moneyBuyMaxNum or maxCount;
        --end
    end
    return maxCount;
end

function UIDisposeItemPanel.GetMoneyType(isReplaceMoney)
    local moneyTypeId = 0;
    if (isReplaceMoney == nil) then
        isReplaceMoney = UIDisposeItemPanel.mIsUseReplaceMoney;
    end
    if (UIDisposeItemPanel.mStoreTable ~= nil) then
        if (isReplaceMoney) then
            if (UIDisposeItemPanel.mStoreTable.replaceMoney ~= nil and UIDisposeItemPanel.mStoreTable.replaceMoney ~= 0) then
                moneyTypeId = UIDisposeItemPanel.mStoreTable.replaceMoney;
            end
        end

        if (moneyTypeId == 0) then
            moneyTypeId = UIDisposeItemPanel.mStoreTable.moneyType;
        end
    end
    return moneyTypeId;
end

function UIDisposeItemPanel.GetMoneyPrice(isReplaceMoney)
    local moneyPrice = 0;
    if (isReplaceMoney == nil) then
        isReplaceMoney = UIDisposeItemPanel.mIsUseReplaceMoney;
    end
    if (UIDisposeItemPanel.mStoreTable ~= nil) then
        if (isReplaceMoney) then
            if (UIDisposeItemPanel.mStoreTable.replacePrice ~= nil) then
                local replacePrice = UIDisposeItemPanel.mStoreTable.replacePrice;
                moneyPrice = replacePrice;
            else
                moneyPrice = 0
            end
        end

        if (moneyPrice == 0) then
            moneyPrice = UIDisposeItemPanel.buyItemdata.price;
        end
    end
    return moneyPrice;
end

function UIDisposeItemPanel.ShowBuyItem(buyItemdata, buyNum)
    local tabledata = UIDisposeItemPanel.mStoreTable;
    UIDisposeItemPanel.SetBuyNum(buyNum);

    if (tabledata ~= nil) then
        local isFind, itemdata = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tabledata.itemId);
        if (isFind) then
            local reuseAmount = itemdata.reuseAmount;
            reuseAmount = (reuseAmount == nil or reuseAmount == 0) and 1 or reuseAmount;
            local num = tabledata.num * reuseAmount;
            UIDisposeItemPanel.GetUIItem_UIItem():RefreshUIWithItemInfo(itemdata, num);
        end
        local isGet, moneydata = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(UIDisposeItemPanel.GetMoneyType());
        if (isGet) then
            UIDisposeItemPanel.GetMoneyTypeSprite_Sprite().spriteName = tostring(moneydata.icon);
            UIDisposeItemPanel.GetAllMoneyTypeSprite_Sprite().spriteName = tostring(moneydata.icon);
            UIDisposeItemPanel.GetMinegoldSprite_Sprite().spriteName = tostring(moneydata.icon);
            UIDisposeItemPanel.GetMoneyValueText_Text().text = buyItemdata.price;
        end
    end
    UIDisposeItemPanel.GetMaxBuyCount_Text().text = UIDisposeItemPanel.GetMaxBuyCount();

    --region 商会商城按钮显示
    if (UIDisposeItemPanel.buyItemdata.storeClassId == LuaEnumStoreType.CommerceDiamond) then
        if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(220003)) then
            UIDisposeItemPanel.GetBtnBuy_GameObject():SetActive(true)
            UIDisposeItemPanel.GetBtnCommerceBtn_GameObject():SetActive(false)
            UIDisposeItemPanel:FitDropDow(0)
        else
            UIDisposeItemPanel.GetBtnBuy_GameObject():SetActive(false)
            UIDisposeItemPanel.GetBtnCommerceBtn_GameObject():SetActive(true)
            UIDisposeItemPanel:FitDropDow(22)
        end
    else
        UIDisposeItemPanel.GetBtnBuy_GameObject():SetActive(true)
        UIDisposeItemPanel.GetBtnCommerceBtn_GameObject():SetActive(false)
        UIDisposeItemPanel:FitDropDow(0)
    end
    --endregion
end

---更新当前选中一栏,自身拥有的货币数量
function UIDisposeItemPanel:UpdateMineMoney(buyNum)
    if (UIDisposeItemPanel.mStoreTable ~= nil) then
        local moneyType = UIDisposeItemPanel.GetMoneyType()
        local data = 0
        --创造宝石(绑定或者非绑定,两者数量需要同时计算)
        if (moneyType == 6210001 or moneyType == 6210002) then
            data = data + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210001)
            data = data + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210002)
        else
            data = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(moneyType);
        end
        --if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(UIDisposeItemPanel.mStoreTable.moneyType)) then
        --    data = CS.CSScene.MainPlayerInfo.BagInfo.DiamondNum
        --end
        --if isfind then
        local isEnough = data >= Utility.GetIntPart(UIDisposeItemPanel.GetPrice(buyNum))
        UIDisposeItemPanel.GetMinegoldText_Text().text = (isEnough and luaEnumColorType.White or luaEnumColorType.Red) .. data .. "[-]";
        --end
    end
end

---设置面板Alpha
function UIDisposeItemPanel:SetPanelAlpha(alpha)
    UIDisposeItemPanel.GetPanel().alpha = alpha
end

function UIDisposeItemPanel:SetStartPoision(itemHight)
    if (not CS.StaticUtility.IsNull(UIDisposeItemPanel.GetBackground_Sprite())) then
        local width = UIDisposeItemPanel.GetBackground_Sprite().width / 2;
        local height = itemHight - UIDisposeItemPanel.GetBackground_Sprite().height / 2 + 1;
        UIDisposeItemPanel.GetRootNode_GameObject().transform.localPosition = CS.UnityEngine.Vector3(width, height, 0)
    end
end

function UIDisposeItemPanel.InitEvents()
    CS.UIEventListener.Get(UIDisposeItemPanel.GetBtnAdd_GameObject()).onClick = UIDisposeItemPanel.OnClickBtnAdd;
    CS.UIEventListener.Get(UIDisposeItemPanel.GetBtnReduce_GameObject()).onClick = UIDisposeItemPanel.OnClickBtnReduce;
    CS.UIEventListener.Get(UIDisposeItemPanel.GetBackGround_GameObject()).onClick = UIDisposeItemPanel.OnClickBtnClose;
    CS.UIEventListener.Get(UIDisposeItemPanel.GetBtnCancel_GameObject()).onClick = UIDisposeItemPanel.OnClickBtnClose;
    CS.UIEventListener.Get(UIDisposeItemPanel.GetBtnBuy_GameObject()).onClick = UIDisposeItemPanel.OnClickBtnBuy;
    CS.UIEventListener.Get(UIDisposeItemPanel.GetBtnCommerceBtn_GameObject()).onClick = UIDisposeItemPanel.OnCommerceBtnClick;

    UIDisposeItemPanel.CallOnBagCoinsChanged = function()
        UIDisposeItemPanel:UpdateMineMoney(tonumber(UIDisposeItemPanel.GetInputText_UIInput().value));
    end
    UIDisposeItemPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, UIDisposeItemPanel.CallOnBagCoinsChanged);

    CS.UIEventListener.Get(UIDisposeItemPanel.GetTitleBtnLeft_GameObject()).onClick = function()
        UIDisposeItemPanel.mIsUseReplaceMoney = false;
        UIDisposeItemPanel.RefreshLeftRightIcon()
        UIDisposeItemPanel.ShowBuyItem(UIDisposeItemPanel.buyItemdata, UIDisposeItemPanel.GetDefaultBuyCount());
    end

    CS.UIEventListener.Get(UIDisposeItemPanel.GetTitleBtnRight_GameObject()).onClick = function()
        UIDisposeItemPanel.mIsUseReplaceMoney = true;
        UIDisposeItemPanel.RefreshLeftRightIcon()
        UIDisposeItemPanel.ShowBuyItem(UIDisposeItemPanel.buyItemdata, UIDisposeItemPanel.GetDefaultBuyCount());
    end
end

function UIDisposeItemPanel.RemoveEvents()
    UIDisposeItemPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_BagCoinsChanged, UIDisposeItemPanel.CallOnBagCoinsChanged);

    if(UIDisposeItemPanel.mCoroutineDelayFitDropDow ~= nil) then
        StopCoroutine(UIDisposeItemPanel.mCoroutineDelayFitDropDow);
        UIDisposeItemPanel.mCoroutineDelayFitDropDow = nil;
    end
end

--endregion

--endregion

function UIDisposeItemPanel:Show(buyItemdata)
    if (buyItemdata ~= nil) then
        UIDisposeItemPanel.buyItemdata = buyItemdata;
        UIDisposeItemPanel.mStoreTable = CS.Cfg_StoreTableManager.Instance:GetStoreItem(UIDisposeItemPanel.buyItemdata.storeId);
        local costItemId = UIDisposeItemPanel.GetMoneyType();
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(costItemId);
        if (isFind) then
            UIDisposeItemPanel.mMoneyItemTable = itemTable;
        end

        local posY = 0;
        UIDisposeItemPanel.GetTitleBtn_GameObject():SetActive(false);
        if (buyItemdata.storeTable.replaceMoney ~= nil and buyItemdata.storeTable.replaceMoney ~= 0) then
            posY = 40;
            UIDisposeItemPanel.GetTitleBtn_GameObject():SetActive(true);
        end

        UIDisposeItemPanel.RefreshLeftRightIcon()

        UIDisposeItemPanel.ShowBuyItem(buyItemdata, UIDisposeItemPanel.GetDefaultBuyCount());
        self:SetPanelAlpha(1 / 255)
        if (buyItemdata.itemTable.type == 8 and buyItemdata.itemTable.subType == 4) then
            local bagiteminfo = CS.Utility_Lua.GetJLZBagItemInfoByItemInfo(buyItemdata.itemTable)
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagiteminfo, isCloseCollider = true, refreshEndFunc = function(panel)
                local itemWidth = panel:GetBackground_UISprite().width / 2
                local itemHight = panel:GetBackground_UISprite().height / 2
                panel.go.transform.localPosition = CS.UnityEngine.Vector3(-itemWidth, posY, 0)
                self:SetStartPoision(itemHight)
                self:SetPanelAlpha(1)
            end, showRight = false })
        else
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = buyItemdata.itemTable, isCloseCollider = true, refreshEndFunc = function(panel)
                local itemWidth = panel:GetBackground_UISprite().width / 2
                local itemHight = panel:GetBackground_UISprite().height / 2
                panel.go.transform.localPosition = CS.UnityEngine.Vector3(-itemWidth, posY, 0)
                self:SetStartPoision(itemHight)
                self:SetPanelAlpha(1)
            end, showRight = false })
        end
    end
end

function UIDisposeItemPanel.RefreshLeftRightIcon()
    UIDisposeItemPanel.GetTitleBtnLeftIcon_UISprite().spriteName = UIDisposeItemPanel.GetTitleBtnIconName(false);
    UIDisposeItemPanel.GetTitleBtnLeftIcon1_UISprite().spriteName = UIDisposeItemPanel.GetTitleBtnIconName(false);

    UIDisposeItemPanel.GetTitleBtnRightIcon_UISprite().spriteName = UIDisposeItemPanel.GetTitleBtnIconName(true);
    UIDisposeItemPanel.GetTitleBtnRightIcon1_UISprite().spriteName = UIDisposeItemPanel.GetTitleBtnIconName(true);
end

---设置面板的适配下来,传入一个height,表示基于原来的标准,拉伸多少
function UIDisposeItemPanel:FitDropDow(height)
    if(UIDisposeItemPanel.mCoroutineDelayFitDropDow ~= nil) then
        StopCoroutine(UIDisposeItemPanel.mCoroutineDelayFitDropDow);
        UIDisposeItemPanel.mCoroutineDelayFitDropDow = nil;
    end
    UIDisposeItemPanel.mCoroutineDelayFitDropDow = StartCoroutine(UIDisposeItemPanel.CDelayFitDropDow, self, height);
end

function UIDisposeItemPanel:CDelayFitDropDow(height)
    coroutine.yield(0);
    coroutine.yield(0);
    coroutine.yield(0);
    coroutine.yield(0);
    coroutine.yield(0);
    if (UIDisposeItemPanel:GetBackground_Sprite() ~= nil) then
        UIDisposeItemPanel:GetBackground_Sprite().height = 200 + height
    end
    if (UIDisposeItemPanel:GetDownline_GameObject() ~= nil) then
        UIDisposeItemPanel:GetDownline_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-1, -97 - height)
    end
end

function UIDisposeItemPanel:Init()
    UIDisposeItemPanel.InitEvents();
end

function ondestroy()
    UIDisposeItemPanel.RemoveEvents();
    uimanager:ClosePanel('UIItemInfoPanel')
end

return UIDisposeItemPanel;