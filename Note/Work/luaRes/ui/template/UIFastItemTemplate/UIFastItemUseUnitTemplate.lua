---@class UIFastItemUseUnitTemplate
local UIFastItemUseUnitTemplate = {};

UIFastItemUseUnitTemplate.mItemId = nil;

UIFastItemUseUnitTemplate.mHasEffect = false

--region Components

--region GameObject

function UIFastItemUseUnitTemplate:GetBtnAdd_GameObject()
    if (self.mBtnAdd_GameObject == nil) then
        self.mBtnAdd_GameObject = self:Get("rootNode/UIItem/add", "GameObject");
    end
    return self.mBtnAdd_GameObject;
end

function UIFastItemUseUnitTemplate:GetUseBtn_GameObject()
    if (self.mUseBtn_GameObject == nil) then
        self.mUseBtn_GameObject = self:Get("rootNode/UIItem/bg", "GameObject");
    end
    return self.mUseBtn_GameObject;
end

function UIFastItemUseUnitTemplate:GetItemName_GameObject()
    if (self.mItemName_GameObject == nil) then
        self.mItemName_GameObject = self:Get("rootNode/UIItem/name", "GameObject");
    end
    return self.mItemName_GameObject;
end

function UIFastItemUseUnitTemplate:GetItemFrame_GameObject()
    if (self.mItemFrame_GameObject == nil) then
        self.mItemFrame_GameObject = self:Get("rootNode/UIItem/frame", "GameObject");
    end
    return self.mItemFrame_GameObject;
end

--endregion

function UIFastItemUseUnitTemplate:GetUSeBtn_UIButtonScale()
    if (self.mUSeBtn_UIButtonScale == nil) then
        self.mUSeBtn_UIButtonScale = self:Get("rootNode/UIItem/bg", "Top_UIButtonScale");
    end
    return self.mUSeBtn_UIButtonScale;
end

function UIFastItemUseUnitTemplate:GetItemIcon_UISprite()
    if (self.mItemIcon_UISprite == nil) then
        self.mItemIcon_UISprite = self:Get("rootNode/UIItem/icon", "UISprite");
    end
    return self.mItemIcon_UISprite;
end

function UIFastItemUseUnitTemplate:GetBuy_GameObject()
    if (self.mBuy_GameObject == nil) then
        self.mBuy_GameObject = self:Get("rootNode/buy", "GameObject");
    end
    return self.mBuy_GameObject;
end

---@return UI物品
function UIFastItemUseUnitTemplate:GetUIItem()
    if (self.mUIItem == nil) then
        self.mUIItem = templatemanager.GetNewTemplate(self:Get("rootNode/UIItem", "GameObject"), luaComponentTemplates.UIItem);
    end
    return self.mUIItem;
end

---@return UISprite 加号
function UIFastItemUseUnitTemplate:GetAddSign_UISprite()
    if self.mAddSign == nil then
        self.mAddSign = self:Get("rootNode/UIItem/add", "UISprite")
    end
    return self.mAddSign
end

---特效节点
function UIFastItemUseUnitTemplate:GetMedicineEffectRoot()
    if self.effectRoot == nil then
        self.effectRoot = self:Get("rootNode/effectRoot", "GameObject")
    end
    return self.effectRoot
end

function UIFastItemUseUnitTemplate:GetRandomStoneEffectRoot()
    if self.mRandomStoneEffectRoot == nil then
        self.mRandomStoneEffectRoot = self:Get("rootNode/randomStoneEffectRoot", "GameObject")
    end
    return self.mRandomStoneEffectRoot
end

function UIFastItemUseUnitTemplate:GetCanBuyMedicineEffectRoot()
    if self.mCanBuyMedicineEffectRoot == nil then
        self.mCanBuyMedicineEffectRoot = self:Get("rootNode/canBuyMedicineEffectRoot", "GameObject")
    end
    return self.mCanBuyMedicineEffectRoot
end

function UIFastItemUseUnitTemplate:GetCDMask_UISprite()
    if (self.mCDMask_UISprite == nil) then
        self.mCDMask_UISprite = self:Get("rootNode/cdMask", "UISprite");
    end
    return self.mCDMask_UISprite;
end

--endregion

--region Method

--region CallFunction
function UIFastItemUseUnitTemplate:OnClickSelfGameObject()
    if (self.mItemId == 0) then
        local customData = {};
        customData.targetId = luaEnumNavigationType.SkillKeyPos;
        customData.SkillKeyPosParams = {};
        customData.SkillKeyPosParams.type = LuaEnumSkillConfigPanelOpenType.Bag;
        luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, customData);
        return ;
    end
    self:ShowZhaoHuanLingEffect(false)
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId);
    if (not self:GetUSeBtn_UIButtonScale().enabled or not self:CanUse()) then
        if (not self:CanUse()) then
            local wayGetShopId = 1; ---获取途径表里面的商城途径的id
            local wayGetAuctionHouseId = 6; ---获取途径表里拍卖行的id
            if (isFind) then
                if (itemInfo.wayGet ~= nil) then
                    if (itemInfo.wayGet.list:Contains(wayGetShopId)) then
                        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(self.mItemId, function(storeVo)
                            if (storeVo ~= nil) then
                                uimanager:CreatePanel("UIShopPanel", nil, { type = storeVo.storeTable.sellId, chooseStore = { storeVo.storeId } })
                            else
                                uimanager:CreatePanel("UIShopPanel")
                            end
                        end);
                    elseif (itemInfo.wayGet.list:Contains(wayGetAuctionHouseId)) then
                        uimanager:CreatePanel("UIAuctionPanel", nil, { isFastItem = true })
                    else
                        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(self.mItemId, function(storeVo)
                            if (storeVo ~= nil) then
                                Utility.ShowItemGetWayByData({
                                    itemId = storeVo.itemTable.id,
                                    target = self:GetBuy_GameObject(),
                                    arrowType = LuaEnumWayGetPanelArrowDirType.TopRight,
                                    offset = CS.UnityEngine.Vector2(0, -20),
                                    isShowBox = false
                                })
                            else
                                uimanager:CreatePanel("UIShopPanel")
                            end
                        end);
                    end
                end
            end
        end
        return ;
    end

    ---是否有晕眩buff
    if (CS.CSScene.MainPlayerInfo.BuffInfo:HasBuff(4)) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = self.go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 65
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end

    --region 检查是否为帮会召唤类型
    if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 6 then
        local UnionInfoV2 = CS.CSScene.MainPlayerInfo.UnionInfoV2;
        if (UnionInfoV2 ~= nil) then
            ---未加入帮会
            if (UnionInfoV2.UnionID == 0) then
                self:ShowTips(self.go.transform, nil, 82)
                return
            end
            ---职位不符
            if (UnionInfoV2.UnionInfo.unionInfo.leaderId ~= 0 and UnionInfoV2.UnionInfo.myPositionInfo < UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition) then
                local pos = uiStaticParameter.PosStringList[UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition]
                local str = pos .. "职位以上可使用"
                self:ShowTips(self.go.transform, str, 83)
                return
            end
        else
            self:ShowTips(self.go.transform, nil, 82)
            return
        end
    end
    --endregion

    --region Boss召唤令
    if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 3 then
        if (CS.CSScene.MainPlayerInfo.MapInfoV2:IsMainCityMap(CS.CSScene.MainPlayerInfo.MapID) == false) then
            self:ShowTips(self.go.transform, nil, 433)
            return
        end
    end
    --endregion

    local isFindOut, nextSplitedItemID, allCount = CS.Cfg_BindItemTableManager.Instance:GetAvailableSplitedItemsInBag(self.mItemId)
    if isFindOut then
        self.mUIMainSkillPanel:UseItem(nextSplitedItemID);
    else
        self.mUIMainSkillPanel:UseItem(self.mItemId);
    end
end

---@param trans UnityEngine.GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIFastItemUseUnitTemplate:ShowTips(trans, str, id)
    --local TipsInfo = {}
    --if str ~= nil or str ~= '' then
    --    TipsInfo[LuaEnumTipConfigType.Describe] = str
    --end
    --TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform
    --TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    --uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)

    if (str ~= nil) then
        CS.Utility.ShowTips(str)
    else
        local isFind, promptTable = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id);
        if (isFind) then
            CS.Utility.ShowTips(promptTable.content);
        end
    end
end

function UIFastItemUseUnitTemplate:TryStartCDTime(itemId, cdTime)
    if CS.CSScene.MainPlayerInfo.BagInfo:IsItemIDUsingRelated(itemId, self.mItemId) then
        if (self.mCoroutineCDTime ~= nil) then
            StopCoroutine(self.mCoroutineCDTime);
            self.mCoroutineCDTime = nil;
        end
        self.mCoroutineCDTime = StartCoroutine(UIFastItemUseUnitTemplate.IEnumCDTime, self, cdTime);
    end
end

--endregion

function UIFastItemUseUnitTemplate:ShowUnit(itemId)
    self.mItemId = itemId;
    --self:ResetEvents();
    local res
    res, self.mItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId)
    if res and itemId ~= 0 then
        self:GetBtnAdd_GameObject():SetActive(false);
    else
        self:GetUIItem():ResetUI()
        self:GetBtnAdd_GameObject():SetActive(true);
        --self:GetAddSign_UISprite().color = LuaEnumUnityColorType.Normal
    end
    self:UpdateUI()
end

function UIFastItemUseUnitTemplate:UpdateUI()
    if (self.mItemInfo ~= nil) then
        local count = 0;
        if (self.mItemInfo.type == luaEnumItemType.Drug) then
            ---如果是药品获得使用次数
            count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mItemId);
        else
            ---否则获得道具数量
            count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mItemId);
        end
        self:GetUSeBtn_UIButtonScale().enabled = self:CanUse();
        self:GetBuy_GameObject():SetActive(not self:CanUse() and self:CanBuy());
        self:GetItemIcon_UISprite().color = self:CanUse() and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        self:GetUIItem():RefreshUIWithItemInfo(self.mItemInfo, count);
        self:GetItemName_GameObject():SetActive(false);
        self:GetItemFrame_GameObject():SetActive(false);

        self:CheckShowCanBuyMedicineEffect()

        -- self:GetAddSign_UISprite().color = LuaEnumUnityColorType.Transparent
    else
        self:GetBuy_GameObject():SetActive(false);
    end
end

function UIFastItemUseUnitTemplate:CanUse()
    local count = 0;
    if (self.mItemInfo.type == luaEnumItemType.Drug) then
        ---如果是药品获得使用次数
        count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mItemId);
    else
        ---否则获得道具数量
        count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mItemId);
    end
    return count > 0;
end

function UIFastItemUseUnitTemplate:IEnumCDTime(targetTime)
    self:GetCDMask_UISprite().gameObject:SetActive(true);
    self:GetUSeBtn_UIButtonScale().enabled = false;
    self:GetCDMask_UISprite().fillAmount = 1;
    local isFind, tableValue = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId);
    if (isFind) then
        local tableCDTime = tableValue.resetTime * 1000
        local cur_timestamp = targetTime - tableCDTime;
        if (tableCDTime > 0) then
            while cur_timestamp < targetTime do
                self:GetCDMask_UISprite().fillAmount = (targetTime - cur_timestamp) / tableCDTime
                coroutine.yield(CS.NGUIAssist.waitForEndOfFrame);
                cur_timestamp = cur_timestamp + CS.UnityEngine.Time.deltaTime * 1000;
            end
        end
    end
    self:GetCDMask_UISprite().fillAmount = 0;
    self:GetCDMask_UISprite().gameObject:SetActive(false);
    self:GetUSeBtn_UIButtonScale().enabled = true;
    self.mCoroutineCDTime = nil;
end

--region 道具提示特效

--region 随机石特效

function UIFastItemUseUnitTemplate:ShowRandomStoneEffect(isShow)
    if (self.mItemInfo ~= nil and self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 1) then
        if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.BagInfo then
            local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mItemId);
            self:SetRandomStoneEffectActive(isShow and count > 0);
        end
    else
        self:SetRandomStoneEffectActive(false);
    end
end

--endregion

--region药品特效
---显示药品特效
function UIFastItemUseUnitTemplate:ShowMedicineEffect(isShow, type)
    local isMp = type == 1;
    local localParam = true;
    if (isMp and self.mItemInfo ~= nil) then
        localParam = self.mItemInfo.subType == 1
    end
    if self.mItemInfo ~= nil and self.mItemInfo.type == luaEnumItemType.Drug and localParam then
        local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mItemId);
        self:SetMedicineEffectActive(isShow and count > 0);
    else
        -- self:SetMedicineEffectActive(false)
    end
end

---显示召唤令特效
function UIFastItemUseUnitTemplate:ShowZhaoHuanLingEffect(isShow)

    if self.mItemId == LuaGlobalTableDeal.ZhaoHuanLingItemID() then
        self:SetMedicineEffectActive(isShow);
        if isShow == true then
            local number = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.CallToMakeTipShowNumber)
            if number < LuaGlobalTableDeal.ZhaoHuanLingTipLimitNumber() then
                if uimanager:GetPanel("UIBubbleGuildTipsPanel") == nil then
                    uimanager:CreatePanel('UIBubbleGuildTipsPanel', nil, self.go)
                    number = number + 1
                    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.CallToMakeTipShowNumber, number)
                end
            end
        else
            uimanager:ClosePanel('UIBubbleGuildTipsPanel')
        end
    end
end
--endregion

--endregion

---显示特效

function UIFastItemUseUnitTemplate:SetMedicineEffectActive(isShow)
    if CS.StaticUtility.IsNull(self:GetMedicineEffectRoot()) == false then
        self:GetMedicineEffectRoot():SetActive(isShow);
    end
end

function UIFastItemUseUnitTemplate:SetRandomStoneEffectActive(isShow)
    if CS.StaticUtility.IsNull(self:GetRandomStoneEffectRoot()) == false then
        if (self:GetRandomStoneEffectRoot().activeSelf ~= isShow) then
            self:GetRandomStoneEffectRoot():SetActive(isShow);
        end
    end
end

function UIFastItemUseUnitTemplate:CheckShowCanBuyMedicineEffect()
    local isShow = false
    if self.mItemInfo.type == luaEnumItemType.Drug then
        if self:GetBuy_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetBuy_GameObject()) then
            if self:GetBuy_GameObject().activeSelf then
                if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(uiStaticParameter.GetShowCanBuyMedicineEffectCondition()) then
                    isShow = true
                end
            end
        end
    end
    self:SetCanBuyMedicineEffectActive(isShow)
end

function UIFastItemUseUnitTemplate:SetCanBuyMedicineEffectActive(isShow)
    if CS.StaticUtility.IsNull(self:GetCanBuyMedicineEffectRoot()) == false then
        if (self:GetCanBuyMedicineEffectRoot().activeSelf ~= isShow) then
            self:GetCanBuyMedicineEffectRoot():SetActive(isShow);
        end
    end
end

--endregion

---获取途径中是否有购买
function UIFastItemUseUnitTemplate:CanBuy()
    local wayGetShopId = 1; ---获取途径表里面的商城途径的id
    local wayGetAuctionHouseId = 6; ---获取途径表里拍卖行的id
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId);
    if (isFind) then
        if (itemInfo.wayGet ~= nil) then
            -- return itemInfo.wayGet.list:Contains(wayGetShopId) or itemInfo.wayGet.list:Contains(wayGetAuctionHouseId);
            return true
        end
    end
    return false;
end

--function UIFastItemUseUnitTemplate:ResetEvents()
--    self:RemoveEvents();
--    self:InitEvents();
--end

function UIFastItemUseUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetUseBtn_GameObject()).onClick = function()
        self:OnClickSelfGameObject();
    end
    --self.CallOnResUseItemMessage = function(msgId, msgData)
    --    self:OnResUseItemMessage(msgId, msgData);
    --end
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResUseItemMessage, self.CallOnResUseItemMessage)
end

function UIFastItemUseUnitTemplate:RemoveEvents()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUseItemMessage, self.CallOnResUseItemMessage)
    --self:GetUSeBtn_UIButtonScale().enabled = true;
    if (self.mCoroutineCDTime ~= nil) then
        StopCoroutine(self.mCoroutineCDTime);
        self.mCoroutineCDTime = nil;
    end
end

function UIFastItemUseUnitTemplate:Clear()
    self.mUIMainSkillPanel = nil;
    self.mItemId = nil;
    self.mCDMask_UISprite = nil;
    self.mUIItem = nil;
    self.mItemIcon_UISprite = nil;
    self.mUSeBtn_UIButtonScale = nil;
    self.mItemFrame_GameObject = nil;
    self.mItemName_GameObject = nil;
    self.mUseBtn_GameObject = nil;
end

function UIFastItemUseUnitTemplate:Init(UIMainSkillPanel)
    ---@type UIMainSkillPanel
    self.mUIMainSkillPanel = UIMainSkillPanel
    self.mHasEffect = false;
    self:InitEvents();
end

--function UIFastItemUseUnitTemplate:Start()
--    self:InitEvents()
--end

function UIFastItemUseUnitTemplate:OnDestroy()


    self:RemoveEvents();
    self:Clear();
end

return UIFastItemUseUnitTemplate;