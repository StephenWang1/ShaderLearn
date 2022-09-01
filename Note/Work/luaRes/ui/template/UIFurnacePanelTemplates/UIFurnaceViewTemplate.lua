---@class UIFurnaceViewTemplate:TemplateBase
local UIFurnaceViewTemplate = {};

UIFurnaceViewTemplate.selectId = LuaEnumFurnaceOpenType.BloodSign;
UIFurnaceViewTemplate.isShowShop = false;
UIFurnaceViewTemplate.mCurEquipId = nil;
UIFurnaceViewTemplate.mNextEquipId = nil;
UIFurnaceViewTemplate.mUpEffect = nil;
UIFurnaceViewTemplate.isPlayEffect = false;

local effectIds = {};
effectIds.upLevelEffectId = "700008";
--region Component

--region GameObject
function UIFurnaceViewTemplate:GetFirstLock_GameObject()
    if (self.mDefaultLock == nil) then
        self.mDefaultLock = self:Get("Background/firstItem/Lock", "GameObject");
    end
    return self.mDefaultLock
end

function UIFurnaceViewTemplate:GetSecondLock_GameObject()
    if (self.mSecondLock == nil) then
        self.mSecondLock = self:Get("Background/secondItem/Lock", "GameObject");
    end
    return self.mSecondLock
end

function UIFurnaceViewTemplate:GetThirdUIItemLock_GameObject()
    if (self.mThirdUIItemLock_GameObject == nil) then
        self.mThirdUIItemLock_GameObject = self:Get("Background/thirdItem/Lock", "GameObject");
    end
    return self.mThirdUIItemLock_GameObject;
end

function UIFurnaceViewTemplate:GetBtnUpgrade_GameObject()
    if self.mBtnUpgrade == nil then
        self.mBtnUpgrade = self:Get("MainEquipPanel/Btn_Upgrade", "GameObject")
    end
    return self.mBtnUpgrade
end

function UIFurnaceViewTemplate:GetBtnChangToBuy_GameObject()
    if (self.mBtnChangToBuy == nil) then
        self.mBtnChangToBuy = self:Get("MainEquipPanel/Btn_ChangToBuy", "GameObject")
    end
    return self.mBtnChangToBuy
end

function UIFurnaceViewTemplate:GetUIMainPanel_GameObject()
    return self.go;
end

function UIFurnaceViewTemplate:GetFirstUIItemFrame_GameObject()
    if (self.mFirstUIItemFrame_GameObject == nil) then
        self.mFirstUIItemFrame_GameObject = self:Get("Background/firstItem/frame", "GameObject");
    end
    return self.mFirstUIItemFrame_GameObject;
end

function UIFurnaceViewTemplate:GetSecondUIItemFrame_GameObject()
    if (self.mSecondUIItemFrame_GameObject == nil) then
        self.mSecondUIItemFrame_GameObject = self:Get("Background/secondItem/frame", "GameObject");
    end
    return self.mSecondUIItemFrame_GameObject;
end

function UIFurnaceViewTemplate:GetThirdUIItemFrame_GameObject()
    if (self.mThirdUIItemFrame_GameObject == nil) then
        self.mThirdUIItemFrame_GameObject = self:Get("Background/thirdItem/frame", "GameObject");
    end
    return self.mThirdUIItemFrame_GameObject;
end

function UIFurnaceViewTemplate:GetFirstUIItemIcon_GameObject()
    if (self.mFirstUIItemIcon_GameObject == nil) then
        self.mFirstUIItemIcon_GameObject = self:Get("Background/firstItem/icon", "GameObject");
    end
    return self.mFirstUIItemIcon_GameObject;
end

function UIFurnaceViewTemplate:GetSecondUIItemIcon_GameObject()
    if (self.mSecondUIItemIcon_GameObject == nil) then
        self.mSecondUIItemIcon_GameObject = self:Get("Background/secondItem/icon", "GameObject");
    end
    return self.mSecondUIItemIcon_GameObject;
end

function UIFurnaceViewTemplate:GetThirdUIItemIcon_GameObject()
    if (self.mThirdUIItemIcon_GameObject == nil) then
        self.mThirdUIItemIcon_GameObject = self:Get("Background/thirdItem/icon", "GameObject");
    end
    return self.mThirdUIItemIcon_GameObject;
end

---@return Top_UISprite
function UIFurnaceViewTemplate:GetThirdUIItemBg1_UISprite()
    if (self.mThirdUIItemBg1_UISprite == nil) then
        self.mThirdUIItemBg1_UISprite = self:Get("Background/thirdItem/itembg1", "UISprite");
    end
    return self.mThirdUIItemBg1_UISprite
end

---@return Top_UISprite
function UIFurnaceViewTemplate:GetThirdUIItemBg2_UISprite()
    if (self.mThirdUIItemBg2_UISprite == nil) then
        self.mThirdUIItemBg2_UISprite = self:Get("Background/thirdItem/itembg2", "UISprite");
    end
    return self.mThirdUIItemBg2_UISprite
end

function UIFurnaceViewTemplate:GetNextLevelNode_GameObject()
    if (self.mNextLevelNode_GameObject == nil) then
        self.mNextLevelNode_GameObject = self:Get("MainEquipPanel/nextLevelAttribute", "GameObject");
    end
    return self.mNextLevelNode_GameObject;
end

function UIFurnaceViewTemplate:GetCurLevelNode_GameObject()
    if (self.mCurLevelNode_GameObject == nil) then
        self.mCurLevelNode_GameObject = self:Get("MainEquipPanel/curLevelAttribute", "GameObject");
    end
    return self.mCurLevelNode_GameObject;
end

function UIFurnaceViewTemplate:GetMaxLevelNode_GameObject()
    if (self.mMaxLevelNode_GameObject == nil) then
        self.mMaxLevelNode_GameObject = self:Get("MainEquipPanel/maxLevelAttribute", "GameObject");
    end
    return self.mMaxLevelNode_GameObject;
end

function UIFurnaceViewTemplate:GeArrowBackGround_GameObject()
    if (self.mArrowBackGround_GameObject == nil) then
        self.mArrowBackGround_GameObject = self:Get("MainEquipPanel/Background", "GameObject");
    end
    return self.mArrowBackGround_GameObject;
end

function UIFurnaceViewTemplate:GeArrow_GameObject()
    if (self.mArrow_GameObject == nil) then
        self.mArrow_GameObject = self:Get("MainEquipPanel/Background/arrow", "GameObject");
    end
    return self.mArrow_GameObject;
end

function UIFurnaceViewTemplate:GetActiveEffectLoad_GameObject()
    if (self.mActiveEffectLoad_GameObject == nil) then
        self.mActiveEffectLoad_GameObject = self:Get("MainEquipPanel/Btn_Upgrade/activeEffect", "GameObject");
    end
    return self.mActiveEffectLoad_GameObject;
end

function UIFurnaceViewTemplate:GetUpEffectParent_GameObject()
    if (self.mUpEffectParent_GameObject == nil) then
        self.mUpEffectParent_GameObject = self:Get("upEffect/upEffect", "GameObject");
    end
    return self.mUpEffectParent_GameObject;
end

function UIFurnaceViewTemplate:GetBtnGet_GameObject()
    if (self.mBtnGet_GameObject == nil) then
        self.mBtnGet_GameObject = self:Get("MainEquipPanel/Btn_Get", "GameObject");
    end
    return self.mBtnGet_GameObject;
end

function UIFurnaceViewTemplate:GetUpPpPhaseLevel_GameObject()
    if (self.mUpPpPhaseLevel_GameObject == nil) then
        self.mUpPpPhaseLevel_GameObject = self:Get("MainEquipPanel/upPhaseLevel", "GameObject");
    end
    return self.mUpPpPhaseLevel_GameObject;
end

---等级限制内容
---@return Top_UILabel
function UIFurnaceViewTemplate:GetLevelLimit_UILabel()
    if self.mLevelLimit_UILabel == nil then
        self.mLevelLimit_UILabel = self:Get("MainEquipPanel/needlevel", "Top_UILabel")
    end
    return self.mLevelLimit_UILabel
end

---等级限制内容
---@return Top_UISprite
function UIFurnaceViewTemplate:GetLevelLimit_UISprite()
    if self.mLevelLimit_UISprite == nil then
        self.mLevelLimit_UISprite = self:Get("MainEquipPanel/needlevel/lb_level", "Top_UISprite")
    end
    return self.mLevelLimit_UISprite
end

---获取经验
---@return GameObject
--function UIFurnaceViewTemplate:Btn_GetExperience_GameObject()
--    if (self.mBtn_GetExperience_GameObject == nil) then
--        self.mBtn_GetExperience_GameObject = self:Get("MainEquipPanel/Btn_GetExperience", "GameObject");
--    end
--    return self.mBtn_GetExperience_GameObject;
--end
--endregion

--region 另一个材料
---@return UnityEngine.GameObject Coin2
function UIFurnaceViewTemplate:GetCoin2_GO()
    if self.mCoin2Go == nil then
        self.mCoin2Go = self:Get("MainEquipPanel/Btn_Con2", "GameObject")
    end
    return self.mCoin2Go
end

---@return UISprite icon
function UIFurnaceViewTemplate:GetCoin2Icon_Sp()
    if self.mCoin2IconSp == nil then
        self.mCoin2IconSp = self:Get("MainEquipPanel/Btn_Con2/icon", "UISprite")
    end
    return self.mCoin2IconSp
end

---@return UILabel 货币2名字
function UIFurnaceViewTemplate:GetCoin2Name_Lb()
    if self.mCoin2NameLb == nil then
        self.mCoin2NameLb = self:Get("MainEquipPanel/Btn_Con2/itemName", "UILabel")
    end
    return self.mCoin2NameLb
end

---@return UILabel 货币2消耗数目
function UIFurnaceViewTemplate:GetCoin2Cost_Lb()
    if self.mCoin2CostLb == nil then
        self.mCoin2CostLb = self:Get("MainEquipPanel/Btn_Con2/Label", "UILabel")
    end
    return self.mCoin2CostLb
end

---@return UnityEngine.GameObject Coin2
function UIFurnaceViewTemplate:GetCoin2Cost_AddGO()
    if self.mCoin2AddGo == nil then
        self.mCoin2AddGo = self:Get("MainEquipPanel/Btn_Con2/Btn_ChangToBuy", "GameObject")
    end
    return self.mCoin2AddGo
end
--endregion

--region 货币
---@return UISprite 货币icon
function UIFurnaceViewTemplate:GetGoldCost_Sp()
    if self.mGoldCostSp == nil then
        self.mGoldCostSp = self:Get("MainEquipPanel/gold/img", "UISprite")
    end
    return self.mGoldCostSp
end

---@return UILabel 货币数目
function UIFurnaceViewTemplate:GetGoldCost_Lb()
    if self.mGoldCostLb == nil then
        self.mGoldCostLb = self:Get("MainEquipPanel/gold", "UILabel")
    end
    return self.mGoldCostLb
end

---@return UIWidget
function UIFurnaceViewTemplate:GetGoldCost_Widget()
    if self.mGoldCostWidget == nil then
        self.mGoldCostWidget = self:Get("MainEquipPanel/gold/img", "UIWidget")
    end
    return self.mGoldCostWidget
end
--endregion

--region 查看属性
function UIFurnaceViewTemplate:GetAttributeBtn_Go()
    if self.mAttrGo == nil then
        self.mAttrGo = self:Get("MainEquipPanel/btn_Attr", "GameObject")
    end
    return self.mAttrGo
end
--endregion

--endregion

--region UISprite
--function UIFurnaceViewTemplate:GetFirstSmallIcon_UISprite()
--    if (self.mFirstSmallIcon_UISprite == nil) then
--        self.mFirstSmallIcon_UISprite = self:Get("Background/firstSmallIcon", "UISprite");
--    end
--    return self.mFirstSmallIcon_UISprite;
--end

--function UIFurnaceViewTemplate:GetSecondSmallIcon_UISprite()
--    if (self.mSecondSmallIcon_UISprite == nil) then
--        self.mSecondSmallIcon_UISprite = self:Get("Background/secondSmallIcon", "UISprite");
--    end
--    return self.mSecondSmallIcon_UISprite;
--end

function UIFurnaceViewTemplate:GetSecondUIItemIcon_UISprite()
    if (self.mSecondUIItemIcon_UISprite == nil) then
        self.mSecondUIItemIcon_UISprite = self:Get("Background/secondItem/icon", "UISprite");
    end
    return self.mSecondUIItemIcon_UISprite;
end

function UIFurnaceViewTemplate:GetConsumeIcon_UISprite()
    if (self.mConsumeIcon_UISprite == nil) then
        self.mConsumeIcon_UISprite = self:Get("MainEquipPanel/Btn_Get/icon", "UISprite");
    end
    return self.mConsumeIcon_UISprite;
end

function UIFurnaceViewTemplate:GetFirstLockDefaultIcon_UISprite()
    if (self.mFirstLockDefaultIcon_UISprite == nil) then
        self.mFirstLockDefaultIcon_UISprite = self:Get("Background/firstItem/Lock/icon", "UISprite")
    end
    return self.mFirstLockDefaultIcon_UISprite;
end

function UIFurnaceViewTemplate:GetSecondLockDefaultIcon_UISprite()
    if (self.mSecondLockDefaultIcon_UISprite == nil) then
        self.mSecondLockDefaultIcon_UISprite = self:Get("Background/secondItem/Lock/icon", "UISprite")
    end
    return self.mSecondLockDefaultIcon_UISprite;
end

function UIFurnaceViewTemplate:GetThirdLockDefaultIcon_UISprite()
    if (self.mThirdLockDefaultIcon_UISprite == nil) then
        self.mThirdLockDefaultIcon_UISprite = self:Get("Background/thirdItem/Lock/icon", "UISprite")
    end
    return self.mThirdLockDefaultIcon_UISprite;
end

function UIFurnaceViewTemplate:GetMaxLevelSprite_UISprite()
    if (self.mMaxLevelSprite_UISprite == nil) then
        self.mMaxLevelSprite_UISprite = self:Get("MainEquipPanel/maxLevelAttribute/maxSprite", "UISprite");
    end
    return self.mMaxLevelSprite_UISprite;
end

--endregion

--region UILabel

function UIFurnaceViewTemplate:GetConsumeName_UILabel()
    if self.mConsumeName_UILabel == nil then
        self.mConsumeName_UILabel = self:Get("MainEquipPanel/Btn_Get/itemName", "UILabel")
    end
    return self.mConsumeName_UILabel
end

function UIFurnaceViewTemplate:GetCurLevelAttributeName_Text()
    if (self.mCurLevelArrtibuteNameText == nil) then
        self.mCurLevelArrtibuteNameText = self:Get("MainEquipPanel/curLevelAttribute/AttributeName", "UILabel");
    end
    return self.mCurLevelArrtibuteNameText;
end

function UIFurnaceViewTemplate:GetCurLevelAttributeValue_Text()
    if (self.mCurLevelArrtibuteValueText == nil) then
        self.mCurLevelArrtibuteValueText = self:Get("MainEquipPanel/curLevelAttribute/AttributeValue", "UILabel");
    end
    return self.mCurLevelArrtibuteValueText;
end

function UIFurnaceViewTemplate:GetCurPhaseName_Text()
    if (self.mCurPhaseName_Text == nil) then
        self.mCurPhaseName_Text = self:Get("MainEquipPanel/curLevelAttribute/PhaseName", "UILabel");
    end
    return self.mCurPhaseName_Text;
end

function UIFurnaceViewTemplate:GetCurOtherValue_Text()
    if (self.mCurOtherValue_Text == nil) then
        self.mCurOtherValue_Text = self:Get("MainEquipPanel/curLevelAttribute/OtherValue", "UILabel");
    end
    return self.mCurOtherValue_Text;
end

function UIFurnaceViewTemplate:GetNextLevelAttributeName_Text()
    if (self.mNextLevelAttributeNameText == nil) then
        self.mNextLevelAttributeNameText = self:Get("MainEquipPanel/nextLevelAttribute/AttributeName", "UILabel");
        self.mNextLevelAttributeNameText.color = CS.UnityEngine.Color.green;
    end
    return self.mNextLevelAttributeNameText;
end

--function UIFurnaceViewTemplate:GetNextOtherName_Text()
--    if (self.mNextOtherName_Text == nil) then
--        self.mNextOtherName_Text = self:Get("MainEquipPanel/nextLevelAttribute/OtherName", "UILabel");
--    end
--    return self.mNextOtherName_Text;
--end

function UIFurnaceViewTemplate:GetNextLevelAttributeValue_Text()
    if (self.mNextLevelAttributeValueText == nil) then
        self.mNextLevelAttributeValueText = self:Get("MainEquipPanel/nextLevelAttribute/AttributeValue", "UILabel");
    end
    return self.mNextLevelAttributeValueText;
end

function UIFurnaceViewTemplate:GetNextOtherValue_Text()
    if (self.mNextOtherValue_Text == nil) then
        self.mNextOtherValue_Text = self:Get("MainEquipPanel/nextLevelAttribute/OtherValue", "UILabel");
    end
    return self.mNextOtherValue_Text;
end

function UIFurnaceViewTemplate:GetMaxLevelAttributeValue_Text()
    if (self.mMaxLevelAttributeValue_Text == nil) then
        self.mMaxLevelAttributeValue_Text = self:Get("MainEquipPanel/maxLevelAttribute/AttributeValue", "UILabel")
    end
    return self.mMaxLevelAttributeValue_Text;
end

function UIFurnaceViewTemplate:GetMaxOtherValue_Text()
    if (self.mMaxOtherValue_Text == nil) then
        self.mMaxOtherValue_Text = self:Get("MainEquipPanel/maxLevelAttribute/OtherValue", "UILabel");
    end
    return self.mMaxOtherValue_Text;
end

function UIFurnaceViewTemplate:GetConsume_Text()
    if (self.mConsumeText == nil) then
        self.mConsumeText = self:Get("MainEquipPanel/Btn_Get/Label", "UILabel")
    end
    return self.mConsumeText;
end

function UIFurnaceViewTemplate:GetItemName_Text()
    if (self.mItemNameText == nil) then
        self.mItemNameText = self:Get("Background/name", "UILabel");
    end
    return self.mItemNameText;
end

function UIFurnaceViewTemplate:GetBtnChangToBuy_Text()
    if (self.mBtnChangToBuy_Text == nil) then
        self.mBtnChangToBuy_Text = self:Get("MainEquipPanel/Btn_ChangToBuy/Label", "UILabel")
    end
    return self.mBtnChangToBuy_Text
end

function UIFurnaceViewTemplate:GetConsumeName_Text()
    if (self.mConsumeName_Text == nil) then
        self.mConsumeName_Text = self:Get("MainEquipPanel/Btn_Get/title", "UILabel")
    end
    return self.mConsumeName_Text;
end

function UIFurnaceViewTemplate:GetUpLevelActionName_Text()
    if (self.mUpLevelActionName_Text == nil) then
        self.mUpLevelActionName_Text = self:Get("MainEquipPanel/OtherTitle", "UILabel");
    end
    return self.mUpLevelActionName_Text;
end

function UIFurnaceViewTemplate:GetUpLevelButtonName_Text()
    if (self.mUpLevelButtonName_Text == nil) then
        self.mUpLevelButtonName_Text = self:Get("MainEquipPanel/Btn_Upgrade/Label", "UILabel");
    end
    return self.mUpLevelButtonName_Text;
end

function UIFurnaceViewTemplate:GetNotHasEquipTip_Text()
    if (self.mNotHasEquipTip_Text == nil) then
        self.mNotHasEquipTip_Text = self:Get("MainEquipPanel/notHasEquipTipsLabel", "UILabel");
    end
    return self.mNotHasEquipTip_Text;
end
--endregion

function UIFurnaceViewTemplate:GetFurnaceQuickShopViewTemplate()
    if (self.mFurnaceQuickShopViewTemplate == nil) then
        self.mFurnaceQuickShopViewTemplate = templatemanager.GetNewTemplate(self:GetUIBuyPanel_GameObject(), luaComponentTemplates.UIFurnaceQuickShopViewTemplate);
    end
    return self.mFurnaceQuickShopViewTemplate;
end

function UIFurnaceViewTemplate:GetFirstUIItem_UIItem()
    if (self.mFirstUIItem_UIItem == nil) then
        self.mFirstUIItem_UIItem = templatemanager.GetNewTemplate(self:Get("Background/firstItem", "GameObject"), luaComponentTemplates.UIItem);
    end
    return self.mFirstUIItem_UIItem;
end

function UIFurnaceViewTemplate:GetSecondUIItem_UIItem()
    if (self.mSecondUIItem_UIItem == nil) then
        self.mSecondUIItem_UIItem = templatemanager.GetNewTemplate(self:Get("Background/secondItem", "GameObject"), luaComponentTemplates.UIItem);
    end
    return self.mSecondUIItem_UIItem;
end

function UIFurnaceViewTemplate:GetThirdUIItem_UIItem()
    if (self.mThirdUIItem_UIItem == nil) then
        self.mThirdUIItem_UIItem = templatemanager.GetNewTemplate(self:Get("Background/thirdItem", "GameObject"), luaComponentTemplates.UIItem);
    end
    return self.mThirdUIItem_UIItem;
end

function UIFurnaceViewTemplate:GetNextLevelAttributeValueEffect_Text()
    if (self.mNextLevelAttributeValueEffect_Text == nil) then
        self.mNextLevelAttributeValueEffect_Text = self:Get("MainEquipPanel/nextLevelAttribute/HighlightEffect", "UILabel");
    end
    return self.mNextLevelAttributeValueEffect_Text;
end

function UIFurnaceViewTemplate:GetNextPhaseName_Text()
    if (self.mNextPhaseName_Text == nil) then
        self.mNextPhaseName_Text = self:Get("MainEquipPanel/nextLevelAttribute/PhaseName", "UILabel");
    end
    return self.mNextPhaseName_Text;
end

--function UIFurnaceViewTemplate:GetNextLevelOtherValueEffect_Text()
--    if (self.mNextLevelOtherValueEffect_Text == nil) then
--        self.mNextLevelOtherValueEffect_Text = self:Get("MainEquipPanel/nextLevelAttribute/OtherEffect", "UILabel");
--    end
--    return self.mNextLevelOtherValueEffect_Text;
--end

--function UIFurnaceViewTemplate:GetNextLevelAttributeValue_TweenAlpha()
--    if (self.mNextLevelAttributeValue_TweenAlpha == nil) then
--        self.mNextLevelAttributeValue_TweenAlpha = self:Get("MainEquipPanel/nextLevelAttribute/HighlightEffect", "TweenAlpha");
--    end
--    return self.mNextLevelAttributeValue_TweenAlpha;
--end

--function UIFurnaceViewTemplate:GetNextLevelOtherValue_TweenAlpha()
--    if (self.mNextLevelOtherValue_TweenAlpha == nil) then
--        self.mNextLevelOtherValue_TweenAlpha = self:Get("MainEquipPanel/nextLevelAttribute/OtherEffect", "TweenAlpha");
--    end
--    return self.mNextLevelOtherValue_TweenAlpha;
--end

function UIFurnaceViewTemplate:GetMaxLevelAttributeEffect_Text()
    if (self.mMaxLevelAttributeEffect_Text == nil) then
        self.mMaxLevelAttributeEffect_Text = self:Get("MainEquipPanel/maxLevelAttribute/HighlightEffect", "UILabel");
    end
    return self.mMaxLevelAttributeEffect_Text;
end

function UIFurnaceViewTemplate:GetMaxLevelAttributeValue_TweenAlpha()
    if (self.mMaxLevelAttributeValue_TweenAlpha == nil) then
        self.mMaxLevelAttributeValue_TweenAlpha = self:Get("MainEquipPanel/maxLevelAttribute/HighlightEffect", "TweenAlpha");
    end
    return self.mMaxLevelAttributeValue_TweenAlpha;
end

function UIFurnaceViewTemplate:GetMaxLevelOtherValue_TweenAlpha()
    if (self.mMaxLevelOtherValue_TweenAlpha == nil) then
        self.mMaxLevelOtherValue_TweenAlpha = self:Get("MainEquipPanel/maxLevelAttribute/OtherEffect", "TweenAlpha");
    end
    return self.mMaxLevelOtherValue_TweenAlpha;
end

function UIFurnaceViewTemplate:GetTipsParent_Transform()
    return self:GetBtnUpgrade_GameObject().transform;
end

function UIFurnaceViewTemplate:GetOtherAttribute_UIGridContainer()
    if (self.mOtherAttribute_UIGridContainer == nil) then
        self.mOtherAttribute_UIGridContainer = self:Get("MainEquipPanel/ScrollView/otherAttribute", "UIGridContainer")
    end
    return self.mOtherAttribute_UIGridContainer;
end

function UIFurnaceViewTemplate:GetScrollviewSpringPanel()
    if (self.mScrollviewSpringPanel == nil) then
        self.mScrollviewSpringPanel = self:Get("MainEquipPanel/ScrollView", "SpringPanel")
    end
    return self.mScrollviewSpringPanel;
end

function UIFurnaceViewTemplate:GetSpecialAttributeViewTemplate()
    if (self.mSpecialAttributeViewTemplate == nil) then
        self.mSpecialAttributeViewTemplate = templatemanager.GetNewTemplate(self:Get("MainEquipPanel/ScrollView_Attribute", "GameObject"), luaComponentTemplates.UIFurnaceSpecialAttributesViewTemplate, self.mRootPanel);
    end
    return self.mSpecialAttributeViewTemplate;
end

--endregion

--region Method

--region CallFunction
function UIFurnaceViewTemplate:OnToggleClickMainEquip()
    self:GetUIMainPanel_GameObject():SetActive(true);
end

---元石升级请求
function UIFurnaceViewTemplate:OnButtonClickUpgradeGem()
    local subType = 21;---元石手套id
    local FirstId = 0;
    local secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_BaoShi; ---灯芯id
    secondId = secondId == 0 and LuaEnumCoinType.GemFragment or secondId;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(subType)
    if (equipInfo == nil) then
        --return CS.Utility.ShowTips("没有装备元石手套!", 1, CS.ColorType.Red);
        FirstId = 0;
    else
        FirstId = equipInfo.itemId;
    end
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.GemFragment);
    local itemName = "";
    if (isFind) then
        itemName = itemTable.name;
    end
    local stateCode = CS.CSScene.MainPlayerInfo.BagInfo:GetGemUpLevelState();
    if (stateCode == LuaEnumFurnaceUpLevelStateCode.AlreadyFull) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = "已满级"
        TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    elseif (stateCode == LuaEnumFurnaceUpLevelStateCode.MaterialNotEnough) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = "材料不足"
        TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end

    --if self:OtherCondition(self:GetTipsParent_Transform()) then
    --    self.isPlayEffect = true;
    --    networkRequest.ReqlampUpgrade(FirstId, secondId, 4);
    --end
    self.isPlayEffect = true;
    networkRequest.ReqlampUpgrade(FirstId, secondId, 4);
end

---赤炎灯升级请求
function UIFurnaceViewTemplate:OnButtonClickUpgradeChyanLamp()
    local subType = 13;
    local FirstId = 0; ---灯座id
    local secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_DengXin; ---灯芯id
    secondId = secondId == 0 and LuaEnumCoinType.LampFragment or secondId;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(subType)
    if (equipInfo == nil) then
        --return CS.Utility.ShowTips("没有装备灯座!", 1, CS.ColorType.Red);
        FirstId = 0;
    else
        FirstId = equipInfo.itemId;
    end
    --local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.LampFragment);
    --local itemName = "";
    --if (isFind) then
    --    itemName = itemTable.name;
    --end
    local stateCode = CS.CSScene.MainPlayerInfo.BagInfo:GetChyanLampUpLevelState();
    if (stateCode == LuaEnumFurnaceUpLevelStateCode.AlreadyFull) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = "已满级"
        TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    elseif (stateCode == LuaEnumFurnaceUpLevelStateCode.MaterialNotEnough) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = "材料不足"
        TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end
    self.isPlayEffect = true;
    networkRequest.ReqlampUpgrade(FirstId, secondId, 1);
end

---进攻之源升级请求
function UIFurnaceViewTemplate:OnButtonClickUpgradeTheSourceOfAttack()
    local subType = 18;
    local FirstId = 0; ---灵兽秘宝id
    local secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan; ---进攻之源id
    secondId = secondId == 0 and LuaEnumCoinType.TheSourceOfAttackFragment or secondId;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(subType)
    if (equipInfo == nil) then
        FirstId = 0;
    else
        FirstId = equipInfo.itemId;
    end
    ---升级请求方法
    local UpGradeFunc = function()
        --local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.TheSourceOfAttackFragment);
        --local itemName = "";
        --if (isFind) then
        --    itemName = itemTable.name;
        --end
        local stateCode = CS.CSScene.MainPlayerInfo.BagInfo:GetTheSourceOfAttackUpLevelState();
        if (stateCode == LuaEnumFurnaceUpLevelStateCode.AlreadyFull) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Describe] = "已满级"
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
            TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIFurnacePanel";
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        elseif (stateCode == LuaEnumFurnaceUpLevelStateCode.MaterialNotEnough) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Describe] = "材料不足"
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
            TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIFurnacePanel";
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        end
        self.isPlayEffect = true;
        networkRequest.ReqlampUpgrade(FirstId, secondId, 2);
    end

    UpGradeFunc();
end

---守护之源升级请求
function UIFurnaceViewTemplate:OnButtonClickUpgradeTheSourceOfDefense()
    local subType = 18;
    local FirstId = 0; ---灵兽秘宝id
    local secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan; ---守护之源id
    secondId = secondId == 0 and LuaEnumCoinType.TheSourceOfDefenseFragment or secondId;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(subType)
    if (equipInfo == nil) then
        --return CS.Utility.ShowTips("没有装备灵兽秘宝!", 1, CS.ColorType.Red);
        FirstId = 0;
    else
        FirstId = equipInfo.itemId;
    end

    local UpGradeFunc = function()
        --local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.TheSourceOfDefenseFragment);
        --local itemName = "";
        --if (isFind) then
        --    itemName = itemTable.name;
        --end
        local stateCode = CS.CSScene.MainPlayerInfo.BagInfo:GetTheSourceOfDefenseUpLevelState();
        if (stateCode == LuaEnumFurnaceUpLevelStateCode.AlreadyFull) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Describe] = "已满级"
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
            TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIFurnacePanel";
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        elseif (stateCode == LuaEnumFurnaceUpLevelStateCode.MaterialNotEnough) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Describe] = "材料不足"
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
            TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIFurnacePanel";
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        end

        self.isPlayEffect = true;
        networkRequest.ReqlampUpgrade(FirstId, secondId, 3);
    end
    --region 升级条件提示
    --local showStr = "守护之源超过当前灵兽秘宝所能镶嵌的最大等级, 继续升级属性暂时不会附加";
    --
    --local isShowTip = self:IsShowTips(equipInfo.itemId, secondId, showStr, UpGradeFunc);
    --if(isShowTip) then
    --    return;
    --end
    --endregion
    UpGradeFunc();
end

---魂珠升级请求
function UIFurnaceViewTemplate:OnButtonClickUpgradeSoulBead()
    local subType = 15;
    local FirstId = 0; ---魂玉id
    local secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShengMingJingPo; ---生命精魄id
    secondId = secondId == 0 and LuaEnumCoinType.EssenceOfLifeFragment or secondId;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(subType)
    if (equipInfo == nil) then
        --return CS.Utility.ShowTips("没有装备魂玉!", 1, CS.ColorType.Red);
        FirstId = 0;
    else
        FirstId = equipInfo.itemId;
    end

    local UpGradeFunc = function()
        --local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.EssenceOfLifeFragment);
        --local itemName = "";
        --if (isFind) then
        --    itemName = itemTable.name;
        --end
        local stateCode = CS.CSScene.MainPlayerInfo.BagInfo:GetSoulBeadUpLevelState();
        if (stateCode == LuaEnumFurnaceUpLevelStateCode.AlreadyFull) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Describe] = "已满级"
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
            TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIFurnacePanel";
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        elseif (stateCode == LuaEnumFurnaceUpLevelStateCode.MaterialNotEnough) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Describe] = "材料不足"
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
            TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIFurnacePanel";
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        end

        self.isPlayEffect = true;
        networkRequest.ReqUpgradeSoulJade(FirstId, secondId, 0);
    end
    --region 升级条件提示
    --local showStr = "生命精魄超过当前魂玉所能镶嵌的最大等级, 继续升级属性暂时不会附加";
    --local isShowTip = self:IsShowTips(equipInfo.itemId, secondId, showStr, UpGradeFunc);
    --if(isShowTip) then
    --    return;
    --end
    --endregion
    UpGradeFunc();
end

---@param firstId number
---@param secondId number
---@param content string
---@param CallBack function
function UIFurnaceViewTemplate:ShowTips(firstId, secondId, content, CallBack)
    local data = {};
    data.Content = content;
    data.CallBack = CallBack;

    local isPhase = self:IsShowTips(firstId, secondId);
    if (isPhase) then
        uimanager:CreatePanel("UIPromptPanel", nil, data)
    end
    return isPhase;
end

function UIFurnaceViewTemplate:IsShowTips(firstId, secondId)
    local firstItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(firstId)
    local secondItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(secondId)

    if (firstItemInfo.useParam == nil) then
        return false;
    end

    if (firstItemInfo.useParam.list.Count < 2) then
        return false;
    end

    if (secondItemInfo.useParam == nil) then
        return false;
    end

    if (secondItemInfo.useParam.list[0] < firstItemInfo.useParam.list[1]) then
        return false;
    end

    return true;
end

---购买
function UIFurnaceViewTemplate:OnButtonClickChangToBuy()
    --if(self.isShowShop) then
    --    self:GetBtnChangToBuy_Text().text = "获得碎片";
    --    self.isShowShop = false;
    --else
    --    self:GetBtnChangToBuy_Text().text = "退回列表";
    --    self.isShowShop = true;
    --end
    --self:GetFurnaceQuickShopViewTemplate():SetShopWithSelectType(self.selectId);

    if (self.mNeedItemId ~= nil) then
        Utility.ShowItemGetWay(self.mNeedItemId, self:GetBtnChangToBuy_GameObject(), LuaEnumWayGetPanelArrowDirType.Down);
    end
end

---@return boolean 其他条件判断
function UIFurnaceViewTemplate:OtherCondition(go)
    local isCoin1enough, Coin1Name = self:GetCoin1Enough()
    if not isCoin1enough then
        Utility.ShowPopoTips(go, Coin1Name .. "不足", 23)
        return false
    end

    local isCoin2Enough, Coin2Name = self:GetCoin2Enough()
    if not isCoin2Enough then
        Utility.ShowPopoTips(go, Coin2Name .. "不足", 23)
        return false
    end
    local isGoldEnough, GoldName = self:GetGoldEnough()
    if not isGoldEnough then
        Utility.ShowPopoTips(go, GoldName .. "不足", 23)
        return false
    end
    return true
end

---刷新升级的宝物icon后面的背景图
function UIFurnaceViewTemplate:RefreshFurnaceItemBg()
    local showItemBg1 = true
    if self.curSelectId == LuaEnumFurnaceOpenType.TheSourceOfAttack or
            self.curSelectId == LuaEnumFurnaceOpenType.TheSourceOfDefense then
        showItemBg1 = false
    end
    luaclass.UIRefresh:RefreshActive(self:GetThirdUIItemBg1_UISprite(), showItemBg1)
    luaclass.UIRefresh:RefreshActive(self:GetThirdUIItemBg2_UISprite(), not showItemBg1)
end
--endregion

--region Public

function UIFurnaceViewTemplate:SetUIShowWithSelectId(selectId, isPlayEffect)
    self.isPlayEffect = isPlayEffect;
    self.curSelectId = selectId
    if (self:GetScrollviewSpringPanel() ~= nil) then
        self:GetScrollviewSpringPanel().target = CS.UnityEngine.Vector3(-48, -28, 0);
        self:GetScrollviewSpringPanel().enabled = true;
    end

    if selectId == LuaEnumFurnaceOpenType.SoulBead then
        self:OnSelectSoulBead()
    elseif selectId == LuaEnumFurnaceOpenType.Gem then
        self:OnSelectGem()
    elseif selectId == LuaEnumFurnaceOpenType.ChyanLamp then
        self:OnSelectChyanLamp();
    elseif selectId == LuaEnumFurnaceOpenType.TheSourceOfAttack then
        self:OnSelectTheSourceOfAttack()
    elseif selectId == LuaEnumFurnaceOpenType.TheSourceOfDefense then
        self:OnSelectTheSourceOfDefense();
    end
    self:SetHelpBtnShow(selectId == LuaEnumFurnaceOpenType.ChyanLamp or selectId == LuaEnumFurnaceOpenType.Gem)
    self:RefreshFurnaceItemBg()
end

---endregion

--region Private

--region 显示信息设置
---元石
function UIFurnaceViewTemplate:OnSelectGem()
    --region 元石
    self.selectId = LuaEnumFurnaceOpenType.Gem
    ---@type GodFurnaceData
    local data = {};
    data.subType = 21;---元石手套
    data.fragmentId = LuaEnumCoinType.GemFragment;
    data.curLevelShowNameStr = "";
    data.curLevelShowValueStr = "";
    data.nextLevelShowNameStr = "";
    data.nextLevelShowValueStr = "";
    data.itemNameStr = "";
    data.curEquipInfo = nil;
    data.secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_BaoShi; ---元石id
    data.secondId = data.secondId == 0 and data.fragmentId or data.secondId;
    local equipId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_BaoShi;
    data.otherCurShowAttribute = {};
    data.otherNextShowAttribute = {};
    local isAddFurnaceCritMultiplier = false
    if (equipId == 0) then
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(data.fragmentId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end
        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(data.fragmentId)

        --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        --    data.curLevelShowValueStr = "0-0";
        --end
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "吸血概率", curValueStr = data.curLevelShowValueStr });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "吸血比例", curValueStr = data.curLevelShowValueStr });

        --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        --    data.curLevelShowValueStr = "0-0";
        --end
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "切割伤害", curValueStr = "0-0" });
    else
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(equipId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(equipId);
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(equipId)
        if tableInfo ~= nil then
            data.curEquipInfo = tableInfo;
            data.itemNameStr = tableInfo.name;
            --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
            --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
            --    data.curLevelShowValueStr = tableInfo.phyAttackMin .. "-" .. tableInfo.phyAttackMax;
            --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
            --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
            --    data.curLevelShowValueStr = tableInfo.magicAttackMin .. "-" .. tableInfo.magicAttackMax;
            --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
            --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
            --    data.curLevelShowValueStr = tableInfo.taoAttackMin .. "-" .. tableInfo.taoAttackMax;
            --end
            --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
            --if (tableInfo.suckBloodFake ~= nil) then
            --    table.insert(data.otherCurShowAttribute, { curNameStr = "吸血概率", curValueStr = Utility.RemoveEndZero(tableInfo.suckBloodFake.list[0] / 100) .. '%' });
            --    table.insert(data.otherCurShowAttribute, { curNameStr = "吸血比例", curValueStr = Utility.RemoveEndZero(tableInfo.suckBloodFake.list[1] / 100) .. '%' });
            --end
            -----暴击倍数
            --local furnaceCritMultiplier = self:GetFurnaceCritMultiplierShowStr()
            --if tableInfo.compoundParam ~= nil and tableInfo.compoundParam.list ~= nil and tableInfo.compoundParam.list.Count > 0 and furnaceCritMultiplier ~= nil then
            --    isAddFurnaceCritMultiplier = true
            --    local arrtibuteNum = tableInfo.compoundParam.list[0] / 10000
            --    arrtibuteNum = Utility.GetPreciseDecimal(arrtibuteNum, 2)
            --    arrtibuteNum = Utility.RemoveEndZero(arrtibuteNum)
            --    arrtibuteNum = arrtibuteNum + 1
            --    table.insert(data.otherCurShowAttribute, { curNameStr = string.format(furnaceCritMultiplier, tostring(arrtibuteNum)), curValueStr = "" });
            --end

            ---攻击
            self:CheckCareerAttack(tableInfo, data, true)

            ---切割伤害
            self:CheckHolyAttack(tableInfo, data, true)
        end
    end

    local isFirst = data.curGodFurnaceItem == nil or data.curGodFurnaceItem.lv == 0;
    if (isFirst) then
        data.itemNameStr = luaEnumColorType.White .. "元石未激活" .. "[-]";
    end

    if (data.nextGodFurnaceItem ~= nil) then
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(data.nextGodFurnaceItem.id)
        if tableInfo ~= nil then
            data.nextEquipInfo = tableInfo;
            --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
            --    data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
            --    data.nextLevelShowValueStr = tableInfo.phyAttackMin .. "-" .. tableInfo.phyAttackMax;
            --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
            --    data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
            --    data.nextLevelShowValueStr = tableInfo.magicAttackMin .. "-" .. tableInfo.magicAttackMax;
            --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
            --    data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
            --    data.nextLevelShowValueStr = tableInfo.taoAttackMin .. "-" .. tableInfo.taoAttackMax;
            --end
            --table.insert(data.otherNextShowAttribute, { nextNameStr = data.nextLevelShowNameStr, nextValueStr = data.nextLevelShowValueStr });
            --if (tableInfo.suckBloodFake ~= nil) then
            --    table.insert(data.otherNextShowAttribute, { nextNameStr = "吸血概率", nextValueStr = Utility.RemoveEndZero(tableInfo.suckBloodFake.list[0] / 100) .. '%' });
            --    table.insert(data.otherNextShowAttribute, { nextNameStr = "吸血比例", nextValueStr = Utility.RemoveEndZero(tableInfo.suckBloodFake.list[1] / 100) .. '%' });
            --end

            ---攻击
            self:CheckCareerAttack(tableInfo, data, false, isFirst)

            ---切割伤害
            self:CheckHolyAttack(tableInfo, data, false, isFirst)
        end

        -----暴击倍数
        --
        --if isAddFurnaceCritMultiplier then
        --    table.insert(data.otherNextShowAttribute, nil);
        --end
    else
        data.nextLevelShowNameStr = "攻击";
        if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        end
        table.insert(data.otherNextShowAttribute, { nextNameStr = data.nextLevelShowNameStr, nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = "切割伤害", nextValueStr = "已满级" });
    end

    self:SetUIShowWithData(data);
    self:OnToggleClickMainEquip();
    --endregion
end

---魂珠
function UIFurnaceViewTemplate:OnSelectSoulBead()
    --region 魂珠
    self.selectId = LuaEnumFurnaceOpenType.SoulBead
    ---@type GodFurnaceData
    local data = {};
    data.subType = 15;---魂玉
    data.fragmentId = LuaEnumCoinType.EssenceOfLifeFragment;
    data.curLevelShowNameStr = "";
    data.curLevelShowValueStr = "";
    data.nextLevelShowNameStr = "";
    data.nextLevelShowValueStr = "";
    data.itemNameStr = "";
    data.curEquipInfo = nil;
    data.secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShengMingJingPo; ---生命精魄id
    data.secondId = data.secondId == 0 and data.fragmentId or data.secondId;
    local FirstSmallIconSpriteName = "";
    local secondSmallIconSpriteName = "";
    local equipId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShengMingJingPo;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(data.subType)
    --data.curLevelShowNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp);
    data.otherCurShowAttribute = {};
    data.otherNextShowAttribute = {};
    if (equipId == 0) then
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(data.fragmentId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(data.fragmentId);
        --data.curLevelShowValueStr = "0";
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), curValueStr = "0" });

        --data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        --data.curLevelShowValueStr = "0-0";
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        --if (tableInfo.suckBloodFake ~= nil) then
        --    table.insert(data.otherCurShowAttribute, { curNameStr = "吸血概率", curValueStr = Utility.RemoveEndZero(tableInfo.suckBloodFake.list[0] / 100) .. '%' });
        --    table.insert(data.otherCurShowAttribute, { curNameStr = "吸血比例", curValueStr = Utility.RemoveEndZero(tableInfo.suckBloodFake.list[1] / 100) .. '%' });
        --end

        --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        --    data.curLevelShowValueStr = "0-0";
        --end
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "血量", curValueStr = "0" });
    else
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(equipId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(equipId)
        if tableInfo ~= nil then
            data.curEquipInfo = tableInfo;
            data.itemNameStr = tableInfo.name;
            FirstSmallIconSpriteName = tableInfo.icon;
        end
        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(equipId);
        --data.curLevelShowValueStr = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(equipId, CS.CareerAttributeType.HP);
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), curValueStr = data.curLevelShowValueStr });

        -----暴击倍数
        --local furnaceCritMultiplier = self:GetFurnaceCritMultiplierShowStr()
        --if tableInfo.compoundParam ~= nil and tableInfo.compoundParam.list ~= nil and tableInfo.compoundParam.list.Count > 0 and furnaceCritMultiplier ~= nil then
        --    isAddFurnaceCritMultiplier = true
        --    local arrtibuteNum = tableInfo.compoundParam.list[0] / 10000
        --    arrtibuteNum = Utility.GetPreciseDecimal(arrtibuteNum, 2)
        --    arrtibuteNum = Utility.RemoveEndZero(arrtibuteNum)
        --    arrtibuteNum = arrtibuteNum + 1
        --    table.insert(data.otherCurShowAttribute, { curNameStr = string.format(furnaceCritMultiplier, tostring(arrtibuteNum)), curValueStr = "" });
        --end

        ---攻击
        self:CheckCareerAttack(tableInfo, data, true)

        local hp = CS.CSScene.MainPlayerInfo.EquipInfo:GetBaseAttribute(tableInfo, CS.AttributeType.MaxHp, CS.CSScene.MainPlayerInfo.Career);
        if (not self:CheckAttributeIsEmpty(hp)) then
            table.insert(data.otherCurShowAttribute, { curNameStr = "血量", curValueStr = hp });
        end

        if (not self:CheckAttributeIsEmpty(tableInfo.criticalDamage)) then
            table.insert(data.otherCurShowAttribute, { curNameStr = "暴击伤害", curValueStr = tableInfo.criticalDamage });
        end
    end

    local isFirst = data.curGodFurnaceItem.lv == 0;
    if (isFirst) then
        data.itemNameStr = luaEnumColorType.White .. "玉魂未激活" .. "[-]";
    end

    --data.nextLevelShowNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp);
    if (data.nextGodFurnaceItem ~= nil) then
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(data.nextGodFurnaceItem.id)
        if tableInfo ~= nil then
            data.nextEquipInfo = tableInfo;
            secondSmallIconSpriteName = tableInfo.icon;
        end
        --data.nextLevelShowValueStr = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(data.nextGodFurnaceItem.id, CS.CareerAttributeType.HP);
        --table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), nextValueStr = data.nextLevelShowValueStr });

        ---攻击
        self:CheckCareerAttack(tableInfo, data, false, isFirst)

        local hp = CS.CSScene.MainPlayerInfo.EquipInfo:GetBaseAttribute(tableInfo, CS.AttributeType.MaxHp, CS.CSScene.MainPlayerInfo.Career);

        if (not self:CheckAttributeIsEmpty(hp)) then
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = "血量", curValueStr = '0' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = "血量", nextValueStr = hp });
        end

        if (not self:CheckAttributeIsEmpty(tableInfo.criticalDamage)) then
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = "暴击伤害", curValueStr = "0" });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = "暴击伤害", nextValueStr = tableInfo.criticalDamage });
        end
    else
        if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        end
        table.insert(data.otherNextShowAttribute, { nextNameStr = data.nextLevelShowNameStr, nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = "血量", nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = "暴击伤害", nextValueStr = "已满级" });
    end

    self:SetUIShowWithData(data);
    self:OnToggleClickMainEquip();
    --endregion
end

---进攻之源
function UIFurnaceViewTemplate:OnSelectTheSourceOfAttack()
    --region 进攻之源
    self.selectId = LuaEnumFurnaceOpenType.TheSourceOfAttack
    ---@type GodFurnaceData
    local data = {};
    data.subType = 18;---灵兽秘宝
    data.fragmentId = LuaEnumCoinType.TheSourceOfAttackFragment;
    data.curLevelShowNameStr = "";
    data.curLevelShowValueStr = "";
    data.nextLevelShowNameStr = "";
    data.nextLevelShowValueStr = "";
    data.itemNameStr = "";
    data.curEquipInfo = nil;
    data.secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan; ---进攻之源id
    data.secondId = data.secondId == 0 and data.fragmentId or data.secondId;
    data.otherCurShowAttribute = {};
    data.otherNextShowAttribute = {};
    local FirstSmallIconSpriteName = "";
    local secondSmallIconSpriteName = "";
    local equipId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan;
    local isAddFurnaceCritMultiplier = false
    if (equipId == 0) then
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(data.fragmentId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(data.fragmentId);
        --data.curLevelShowNameStr = "攻击继承";
        --data.curLevelShowValueStr = "0" .. "%";
        --table.insert(data.otherCurShowAttribute, { curNameStr = "攻击继承", curValueStr = "0" .. "%" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "切割伤害继承", curValueStr = "0" .. "%" });
        --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        --    data.curLevelShowValueStr = "0-0"
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        --    data.curLevelShowValueStr = "0-0"
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        --    data.curLevelShowValueStr = "0-0"
        --end
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), curValueStr = "0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantHP), curValueStr = "0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritAttack), curValueStr = "0%" });
    else
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(equipId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(equipId);
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(equipId)
        if tableInfo ~= nil then
            data.curEquipInfo = tableInfo;
            data.itemNameStr = tableInfo.name;
            FirstSmallIconSpriteName = tableInfo.icon;
            --data.curLevelShowNameStr = "攻击继承";
            --data.curLevelShowValueStr = string.format("%.1f", tableInfo.attackPercentage / 10) .. "%";
            --
            --table.insert(data.otherCurShowAttribute, { curNameStr = "攻击继承", curValueStr = string.format("%.1f", tableInfo.attackPercentage / 10) .. "%" });
            --table.insert(data.otherCurShowAttribute, { curNameStr = "切割伤害继承", curValueStr = string.format("%.1f", tableInfo.cutDamage / 100) .. "%" });
            --
            -----暴击倍数
            --local furnaceCritMultiplier = self:GetFurnaceCritMultiplierShowStr()
            --if tableInfo.compoundParam ~= nil and tableInfo.compoundParam.list ~= nil and tableInfo.compoundParam.list.Count > 0 and furnaceCritMultiplier ~= nil then
            --    isAddFurnaceCritMultiplier = true
            --    local arrtibuteNum = tableInfo.compoundParam.list[0] / 10000
            --    arrtibuteNum = Utility.GetPreciseDecimal(arrtibuteNum, 2)
            --    arrtibuteNum = Utility.RemoveEndZero(arrtibuteNum)
            --    arrtibuteNum = arrtibuteNum + 1
            --    table.insert(data.otherCurShowAttribute, { curNameStr = string.format(furnaceCritMultiplier, tostring(arrtibuteNum)), curValueStr = "" });
            --end

            ---攻击
            self:CheckCareerAttack(tableInfo, data, true)

            local MaxHp = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(equipId, CS.CareerAttributeType.HP)
            if (not self:CheckAttributeIsEmpty(MaxHp)) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), curValueStr = MaxHp });
            end

            if (not self:CheckAttributeIsEmpty(tableInfo.hsmaxHp)) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantHP), curValueStr = tableInfo.hsmaxHp });
            end

            ---灵兽合体继承攻击
            self:CheckAttackPercentage(tableInfo, data, true)

            ---掉宝率
            self:CheckDropTreasure(tableInfo, data, true)
        end
    end

    local isFirst = data.curGodFurnaceItem.lv == 0;
    if (isFirst) then
        data.itemNameStr = luaEnumColorType.White .. "魔血之源未激活" .. "[-]";
    end

    data.nextLevelShowNameStr = "攻击继承";
    if (data.nextGodFurnaceItem ~= nil) then
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(data.nextGodFurnaceItem.id)
        if tableInfo ~= nil then
            --data.nextEquipInfo = tableInfo;
            --data.nextLevelShowValueStr = string.format("%.1f", tableInfo.attackPercentage / 10) .. "%";
            --secondSmallIconSpriteName = tableInfo.icon;
            --
            --table.insert(data.otherNextShowAttribute, { nextNameStr = "攻击继承", nextValueStr = string.format("%.1f", tableInfo.attackPercentage / 10) .. "%" });
            --table.insert(data.otherNextShowAttribute, { nextNameStr = "切割伤害继承", nextValueStr = string.format("%.1f", tableInfo.cutDamage / 100) .. "%" });

            ---攻击
            self:CheckCareerAttack(tableInfo, data, false, isFirst)

            local MaxHp = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(tableInfo.id, CS.CareerAttributeType.HP)
            if (not self:CheckAttributeIsEmpty(MaxHp)) then
                if (isFirst) then
                    table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), curValueStr = '0' });
                end
                table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), nextValueStr = MaxHp });
            end

            if (not self:CheckAttributeIsEmpty(tableInfo.hsmaxHp)) then
                if (isFirst) then
                    table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantHP), curValueStr = '0' });
                end
                table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantHP), nextValueStr = tableInfo.hsmaxHp });
            end

            ---灵兽合体继承攻击
            self:CheckAttackPercentage(tableInfo, data, false, isFirst)

            ---掉宝率
            self:CheckDropTreasure(tableInfo, data, false, isFirst)
        end
    else
        if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        end
        table.insert(data.otherNextShowAttribute, { nextNameStr = data.nextLevelShowNameStr, nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantHP), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritAttack), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure), nextValueStr = "已满级" });
    end

    self:SetUIShowWithData(data);
    self:OnToggleClickMainEquip();
    --endregion
end

---防守之源
function UIFurnaceViewTemplate:OnSelectTheSourceOfDefense()
    --region 防守之源
    self.selectId = LuaEnumFurnaceOpenType.TheSourceOfDefense
    ---@type GodFurnaceData
    local data = {};
    data.subType = 18;---灵兽秘宝
    data.fragmentId = LuaEnumCoinType.TheSourceOfDefenseFragment;
    data.curLevelShowNameStr = "";
    data.curLevelShowValueStr = "";
    data.nextLevelShowNameStr = "";
    data.nextLevelShowValueStr = "";
    data.itemNameStr = "";
    data.curEquipInfo = nil;
    data.secondId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan; ---守护之源id
    data.secondId = data.secondId == 0 and data.fragmentId or data.secondId;
    local FirstSmallIconSpriteName = "";
    local secondSmallIconSpriteName = "";
    local equipId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(data.subType)
    data.otherCurShowAttribute = {};
    data.otherNextShowAttribute = {};
    if (equipId == 0) then
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(data.fragmentId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(data.fragmentId);

        --data.curLevelShowNameStr = "防御继承";
        --data.curLevelShowValueStr = "0" .. "%";
        --table.insert(data.otherCurShowAttribute, { curNameStr = "防御继承", curValueStr = "0" .. "%" });
        --table.insert(data.otherCurShowAttribute, {curNameStr = "神圣防御继承", curValueStr = "0" .. "%"});
        --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        --end
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = "0-0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax), curValueStr = "0-0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax), curValueStr = "0-0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantPhyDefMax), curValueStr = "0-0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantMagicDefMax), curValueStr = "0-0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritDefense), curValueStr = "0%" });
    else
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(equipId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(equipId);
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(equipId)
        if tableInfo ~= nil then
            data.curEquipInfo = tableInfo;
            data.itemNameStr = tableInfo.name;
            --FirstSmallIconSpriteName = tableInfo.icon;
            --data.curLevelShowNameStr = "防御继承";
            --data.curLevelShowValueStr = string.format("%.1f", tableInfo.defensePercentage / 10) .. "%";
            --table.insert(data.otherCurShowAttribute, { curNameStr = "防御继承", curValueStr = string.format("%.1f", tableInfo.defensePercentage / 10) .. "%" });
            --table.insert(data.otherCurShowAttribute, {curNameStr = "神圣防御继承", curValueStr = string.format("%.1f", tableInfo.sacredDefense / 100) .. "%"});

            ---攻击
            self:CheckCareerAttack(tableInfo, data, true)

            local minPhyDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(equipId, CS.CareerAttributeType.PHYDEFENCEMIN);
            local maxPhyDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(equipId, CS.CareerAttributeType.PHYDEFENCEMAX);
            if (not self:CheckAttributeIsEmpty(minPhyDef) and not self:CheckAttributeIsEmpty(maxPhyDef)) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax), curValueStr = minPhyDef .. "-" .. maxPhyDef });
            end

            local minMagicDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(equipId, CS.CareerAttributeType.MAGICDEFENCEMIN);
            local maxMagicDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(equipId, CS.CareerAttributeType.MAGICDEFENCEMAX);
            if (not self:CheckAttributeIsEmpty(minMagicDef) and not self:CheckAttributeIsEmpty(maxMagicDef)) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax), curValueStr = minMagicDef .. "-" .. maxMagicDef });
            end

            if (not self:CheckAttributeIsEmpty(tableInfo.hsphyDefenceMin) and not self:CheckAttributeIsEmpty(tableInfo.hsphyDefenceMax)) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantPhyDefMax), curValueStr = tableInfo.hsphyDefenceMin .. "-" .. tableInfo.hsphyDefenceMax });
            end

            if (not self:CheckAttributeIsEmpty(tableInfo.hsmagicDefenceMin) and not self:CheckAttributeIsEmpty(tableInfo.hsmagicDefenceMax)) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantMagicDefMax), curValueStr = tableInfo.hsmagicDefenceMin .. "-" .. tableInfo.hsmagicDefenceMax });
            end

            ---灵兽合体继承防御
            self:CheckDefensePercentage(tableInfo, data, true)

            ---掉宝率
            self:CheckDropTreasure(tableInfo, data, true)
        end
    end

    local isFirst = data.curGodFurnaceItem.lv == 0;
    if (isFirst) then
        data.itemNameStr = luaEnumColorType.White .. "守护之源未激活" .. "[-]";
    end

    if (data.nextGodFurnaceItem ~= nil) then
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(data.nextGodFurnaceItem.id)
        if tableInfo ~= nil then
            --data.nextEquipInfo = tableInfo;
            --data.nextLevelShowValueStr = string.format("%.1f", tableInfo.defensePercentage / 10) .. "%";
            --secondSmallIconSpriteName = tableInfo.icon;
            --
            --table.insert(data.otherNextShowAttribute, { nextNameStr = "防御继承", nextValueStr = string.format("%.1f", tableInfo.defensePercentage / 10) .. "%" });
            --table.insert(data.otherNextShowAttribute, {nextNameStr = "神圣防御继承", nextValueStr = string.format("%.1f", tableInfo.sacredDefense / 100) .. "%"});

            ---攻击
            self:CheckCareerAttack(tableInfo, data, false, isFirst)

            local minPhyDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(tableInfo.id, CS.CareerAttributeType.PHYDEFENCEMIN);
            local maxPhyDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(tableInfo.id, CS.CareerAttributeType.PHYDEFENCEMAX);
            if (not self:CheckAttributeIsEmpty(minPhyDef) and not self:CheckAttributeIsEmpty(maxPhyDef)) then
                if (isFirst) then
                    table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax), curValueStr = "0-0" });
                end
                table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax), nextValueStr = minPhyDef .. "-" .. maxPhyDef });
            end

            local minMagicDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(tableInfo.id, CS.CareerAttributeType.MAGICDEFENCEMIN);
            local maxMagicDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(tableInfo.id, CS.CareerAttributeType.MAGICDEFENCEMAX);
            if (not self:CheckAttributeIsEmpty(minMagicDef) and not self:CheckAttributeIsEmpty(maxMagicDef)) then
                if (isFirst) then
                    table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax), curValueStr = "0-0" });
                end
                table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax), nextValueStr = minMagicDef .. "-" .. maxMagicDef });
            end

            if (not self:CheckAttributeIsEmpty(tableInfo.hsphyDefenceMin) and not self:CheckAttributeIsEmpty(tableInfo.hsphyDefenceMax)) then
                if (isFirst) then
                    table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantPhyDefMax), curValueStr = "0-0" });
                end
                table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantPhyDefMax), nextValueStr = tableInfo.hsphyDefenceMin .. "-" .. tableInfo.hsphyDefenceMax });
            end

            if (not self:CheckAttributeIsEmpty(tableInfo.hsmagicDefenceMin) and not self:CheckAttributeIsEmpty(tableInfo.hsmagicDefenceMax)) then
                if (isFirst) then
                    table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantMagicDefMax), curValueStr = "0-0" });
                end
                table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantMagicDefMax), nextValueStr = tableInfo.hsmagicDefenceMin .. "-" .. tableInfo.hsmagicDefenceMax });
            end

            ---灵兽合体继承防御
            self:CheckDefensePercentage(tableInfo, data, false, isFirst)

            ---掉宝率
            self:CheckDropTreasure(tableInfo, data, false, isFirst)
        end
    else
        --data.nextLevelShowValueStr = "已满级";
        --table.insert(data.otherNextShowAttribute, { nextNameStr = "防御继承", nextValueStr = "已满级" });
        --table.insert(data.otherNextShowAttribute, {nextNameStr = "神圣防御继承", nextValueStr = "已满级"});
        table.insert(data.otherNextShowAttribute, { nextNameStr = data.curLevelShowNameStr, nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantPhyDefMax), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantMagicDefMax), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritDefense), nextValueStr = "已满级" });
        table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure), nextValueStr = "已满级" });
    end

    self:SetUIShowWithData(data);

    self:OnToggleClickMainEquip();
    self.isChooseServant = true
    --endregion
end

---赤炎灯
function UIFurnaceViewTemplate:OnSelectChyanLamp()
    --region 赤炎灯
    self.selectId = LuaEnumFurnaceOpenType.ChyanLamp
    ---@type GodFurnaceData
    local data = {};
    data.subType = 13;---赤炎灯灯座
    data.fragmentId = LuaEnumCoinType.LampFragment;
    data.curLevelShowNameStr = "";
    data.curLevelShowValueStr = "";
    data.nextLevelShowNameStr = "";
    data.nextLevelShowValueStr = "";
    data.itemNameStr = "";
    data.curEquipInfo = nil;
    local FirstSmallIconSpriteName = "";
    local secondSmallIconSpriteName = "";
    local equipId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_DengXin;
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(data.subType)
    local isAddFurnaceCritMultiplier = false

    data.otherCurShowAttribute = {};
    data.otherNextShowAttribute = {};
    if (equipId == 0) then
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(data.fragmentId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(data.fragmentId);
        --data.curLevelShowNameStr = "暴击率";
        --data.curLevelShowValueStr = "0%";
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "暴击伤害", curValueStr = "0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "秒杀血量", curValueStr = "0" });
        --table.insert(data.otherCurShowAttribute, { curNameStr = "秒杀概率", curValueStr = "0" });

        --data.curLevelShowNameStr = "攻击";
        --if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        --    data.curLevelShowValueStr = "0-0";
        --elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        --    data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        --    data.curLevelShowValueStr = "0-0";
        --end
        --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        --table.insert(data.otherCurShowAttribute, { curNameStr = '暴击倍数', curValueStr = "1" });
    else
        local isGetValue, tableValue = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(equipId);
        if (isGetValue) then
            data.curGodFurnaceItem = tableValue;
        end

        data.nextGodFurnaceItem = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(equipId);
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(equipId)
        if tableInfo ~= nil then
            data.curEquipInfo = tableInfo;
            data.itemNameStr = tableInfo.name;
            FirstSmallIconSpriteName = tableInfo.icon;
            --data.curLevelShowNameStr = "暴击率";
            --data.curLevelShowValueStr = Utility.RemoveEndZero(tableInfo.showCritical / 100) .. '%';
            --table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
            --table.insert(data.otherCurShowAttribute, { curNameStr = "暴击伤害", curValueStr = tableInfo.criticalDamage });
            --if (tableInfo.seckill ~= nil) then
            --    table.insert(data.otherCurShowAttribute, { curNameStr = "秒杀血量", curValueStr = Utility.RemoveEndZero(tableInfo.seckill.list[0] / 100) .. '%' });
            --    table.insert(data.otherCurShowAttribute, { curNameStr = "秒杀概率", curValueStr = Utility.RemoveEndZero(tableInfo.seckill.list[1] / 100) .. '%' });
            --end

            ---攻击
            self:CheckCareerAttack(tableInfo, data, true)

            ---切割伤害
            self:CheckHolyAttack(tableInfo, data, true)

            ---暴击倍数
            self:CheckCriticalHurtAdd(tableInfo, data, true)

            ---展示暴击率
            self:CheckShowCritical(tableInfo, data, true)
        end
    end

    local isFirst = data.curGodFurnaceItem.lv == 0;
    if (isFirst) then
        data.itemNameStr = luaEnumColorType.White .. "灯芯未激活" .. "[-]";
    end

    --data.nextLevelShowNameStr = "暴击率";
    if (data.nextGodFurnaceItem ~= nil) then
        local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(data.nextGodFurnaceItem.id)
        if tableInfo ~= nil then
            data.nextEquipInfo = tableInfo;

            data.nextLevelShowValueStr = Utility.RemoveEndZero(tableInfo.showCritical / 100) .. '%';
            secondSmallIconSpriteName = tableInfo.icon;
            --table.insert(data.otherNextShowAttribute, { nextNameStr = data.nextLevelShowNameStr, nextValueStr = data.nextLevelShowValueStr });
            --table.insert(data.otherNextShowAttribute, { nextNameStr = "暴击伤害", nextValueStr = tableInfo.criticalDamage });
            --if (tableInfo.seckill ~= nil) then
            --    table.insert(data.otherNextShowAttribute, { nextNameStr = "秒杀血量", nextValueStr = Utility.RemoveEndZero(tableInfo.seckill.list[0] / 100) .. '%' });
            --    table.insert(data.otherNextShowAttribute, { nextNameStr = "秒杀概率", nextValueStr = Utility.RemoveEndZero(tableInfo.seckill.list[1] / 100)});
            --end
        end

        ---攻击
        self:CheckCareerAttack(tableInfo, data, false, isFirst)

        ---切割伤害
        self:CheckHolyAttack(tableInfo, data, false, isFirst)

        ---暴击倍数
        self:CheckCriticalHurtAdd(tableInfo, data, false, isFirst)

        ---展示暴击率
        self:CheckShowCritical(tableInfo, data, false, isFirst)
    else
        if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
            data.nextLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        end
        data.nextLevelShowValueStr = "已满级";
        table.insert(data.otherNextShowAttribute, { nextNameStr = data.nextLevelShowNameStr, nextValueStr = data.nextLevelShowValueStr });
        table.insert(data.otherNextShowAttribute, { nextNameStr = "暴击倍数", nextValueStr = data.nextLevelShowValueStr });
        table.insert(data.otherNextShowAttribute, { nextNameStr = "暴击率", nextValueStr = data.nextLevelShowValueStr });
    end

    self:SetUIShowWithData(data);
    self:OnToggleClickMainEquip();
    --endregion
end

--region 显示属性相关
---检查属性是否为空
---@param Attr string
function UIFurnaceViewTemplate:CheckAttributeIsEmpty(Attr)
    return Utility.CheckAttributeIsEmpty(Attr)
end

---将攻击填加到显示属性列表
---@param tableInfo TABLE.cfg_items
---@param data table 属性列表
---@param IsItTheCurrentLevel boolean 是否当前等级
---@param isFirst boolean 是否首次激活
---@param isMax boolean 是否最大等级
function UIFurnaceViewTemplate:CheckCareerAttack(tableInfo, data, IsItTheCurrentLevel, isFirst, isMax)
    if (tableInfo == nil) then
        if (isMax) then
            ---攻击
            data.curLevelShowNameStr = '攻击'
            if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
                data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
            elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
                data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
            elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
                data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = data.curLevelShowNameStr, nextValueStr = '已满级' });
        end
        return
    end

    ---攻击
    data.curLevelShowNameStr = '攻击'
    if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
        data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
        data.curLevelShowValueStr = tableInfo.phyAttackMin .. "-" .. tableInfo.phyAttackMax;
    elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
        data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Master);
        data.curLevelShowValueStr = tableInfo.magicAttackMin .. "-" .. tableInfo.magicAttackMax;
    elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
        data.curLevelShowNameStr = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
        data.curLevelShowValueStr = tableInfo.taoAttackMin .. "-" .. tableInfo.taoAttackMax;
    end

    if (not self:CheckAttributeIsEmpty(data.curLevelShowValueStr)) then
        if (IsItTheCurrentLevel) then
            table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = data.curLevelShowValueStr });
        else
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = data.curLevelShowNameStr, curValueStr = '0-0' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = data.curLevelShowNameStr, nextValueStr = data.curLevelShowValueStr });
        end
    end
end

---将切割伤害填加到显示属性列表
---@param tableInfo TABLE.cfg_items
---@param data table 属性列表
---@param IsItTheCurrentLevel boolean 是否当前等级
---@param isFirst boolean 是否首次激活
function UIFurnaceViewTemplate:CheckHolyAttack(tableInfo, data, IsItTheCurrentLevel, isFirst)
    if (tableInfo == nil) then
        return
    end

    ---切割伤害
    local holyAttack = tableInfo.holyAttackMin .. "-" .. tableInfo.holyAttackMax

    if (not self:CheckAttributeIsEmpty(holyAttack)) then
        if (IsItTheCurrentLevel) then
            table.insert(data.otherCurShowAttribute, { curNameStr = "切割伤害", curValueStr = tostring(holyAttack) });
        else
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = '切割伤害', curValueStr = '0' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = "切割伤害", nextValueStr = tostring(holyAttack) });
        end
    end
end

---将暴击倍数填加到显示属性列表
---@param tableInfo TABLE.cfg_items
---@param data table 属性列表
---@param IsItTheCurrentLevel boolean 是否当前等级
---@param isFirst boolean 是否首次激活
function UIFurnaceViewTemplate:CheckCriticalHurtAdd(tableInfo, data, IsItTheCurrentLevel, isFirst)
    if (tableInfo == nil) then
        return
    end

    ---暴击倍数
    local criticalHurtAdd = self:GetCriticalHurtAdd(tableInfo)

    if (not self:CheckAttributeIsEmpty(criticalHurtAdd)) then
        if (IsItTheCurrentLevel) then
            table.insert(data.otherCurShowAttribute, { curNameStr = "暴击倍数", curValueStr = tostring(criticalHurtAdd) });
        else
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = '暴击倍数', curValueStr = '1' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = "暴击倍数", nextValueStr = tostring(criticalHurtAdd) });
        end
    end
end

---将展示暴击率填加到显示属性列表
---@param tableInfo TABLE.cfg_items
---@param data table 属性列表
---@param IsItTheCurrentLevel boolean 是否当前等级
---@param isFirst boolean 是否首次激活
function UIFurnaceViewTemplate:CheckShowCritical(tableInfo, data, IsItTheCurrentLevel, isFirst)
    if (tableInfo == nil) then
        return
    end

    ---展示暴击率
    local showCritical = self:GetShowCritical(tableInfo)

    if (not self:CheckAttributeIsEmpty(showCritical)) then
        if (IsItTheCurrentLevel) then
            table.insert(data.otherCurShowAttribute, { curNameStr = "暴击率", curValueStr = tostring(showCritical) .. '%' });
        else
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = '暴击率', curValueStr = '0%' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = "暴击率", nextValueStr = tostring(showCritical) .. '%' });
        end
    end
end

---将灵兽合体继承攻击填加到显示属性列表
---@param tableInfo TABLE.cfg_items
---@param data table 属性列表
---@param IsItTheCurrentLevel boolean 是否当前等级
---@param isFirst boolean 是否首次激活
function UIFurnaceViewTemplate:CheckAttackPercentage(tableInfo, data, IsItTheCurrentLevel, isFirst)
    if (tableInfo == nil) then
        return
    end

    ---灵兽合体继承攻击
    local attackPercentage = self:GetAttackPercentage(tableInfo)

    if (not self:CheckAttributeIsEmpty(attackPercentage)) then
        if (IsItTheCurrentLevel) then
            table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritAttack), curValueStr = tostring(attackPercentage) .. '%' });
        else
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritAttack), curValueStr = '0%' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritAttack), nextValueStr = tostring(attackPercentage) .. '%' });
        end
    end
end

---将灵兽合体继承防御填加到显示属性列表
---@param tableInfo TABLE.cfg_items
---@param data table 属性列表
---@param IsItTheCurrentLevel boolean 是否当前等级
---@param isFirst boolean 是否首次激活
function UIFurnaceViewTemplate:CheckDefensePercentage(tableInfo, data, IsItTheCurrentLevel, isFirst)
    if (tableInfo == nil) then
        return
    end

    ---灵兽合体继承防御
    local defensePercentage = self:GetDefensePercentage(tableInfo)

    if (not self:CheckAttributeIsEmpty(defensePercentage)) then
        if (IsItTheCurrentLevel) then
            table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritDefense), curValueStr = tostring(defensePercentage) .. '%' });
        else
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritDefense), curValueStr = '0%' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritDefense), nextValueStr = tostring(defensePercentage) .. '%' });
        end
    end
end

---将掉宝率填加到显示属性列表
---@param tableInfo TABLE.cfg_items
---@param data table 属性列表
---@param IsItTheCurrentLevel boolean 是否当前等级
---@param isFirst boolean 是否首次激活
function UIFurnaceViewTemplate:CheckDropTreasure(tableInfo, data, IsItTheCurrentLevel, isFirst)
    if (tableInfo == nil) then
        return
    end

    ---掉宝率
    local defensePercentage = self:GetAddDropTreasure(tableInfo)

    if (not self:CheckAttributeIsEmpty(defensePercentage)) then
        if (IsItTheCurrentLevel) then
            table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure), curValueStr = tostring(defensePercentage) .. '%' });
        else
            if (isFirst) then
                table.insert(data.otherCurShowAttribute, { curNameStr = Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure), curValueStr = '0%' });
            end
            table.insert(data.otherNextShowAttribute, { nextNameStr = Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure), nextValueStr = tostring(defensePercentage) .. '%' });
        end
    end
end

---暴击倍数
function UIFurnaceViewTemplate:GetCriticalHurtAdd(tableInfo)
    if (tableInfo == nil or tableInfo.criticalHurtAdd == nil or tableInfo.criticalHurtAdd <= 0) then
        return 0
    end
    local criticalHurtAdd = 0
    criticalHurtAdd = tableInfo.criticalHurtAdd / 10000
    criticalHurtAdd = Utility.GetPreciseDecimal(criticalHurtAdd, 2)
    criticalHurtAdd = Utility.RemoveEndZero(criticalHurtAdd)
    criticalHurtAdd = criticalHurtAdd + 1
    return criticalHurtAdd
end

---展示暴击率
function UIFurnaceViewTemplate:GetShowCritical(tableInfo)
    if (tableInfo == nil or tableInfo.showCritical == nil or tableInfo.showCritical <= 0) then
        return 0
    end
    local showCritical = 0
    showCritical = tableInfo.showCritical / 100
    showCritical = Utility.GetPreciseDecimal(showCritical, 2)
    showCritical = Utility.RemoveEndZero(showCritical)
    return showCritical
end

---灵兽合体继承攻击
function UIFurnaceViewTemplate:GetAttackPercentage(tableInfo)
    if (tableInfo == nil or tableInfo.attackPercentage == nil or tableInfo.attackPercentage <= 0) then
        return 0
    end
    local attackPercentage = 0
    attackPercentage = tableInfo.attackPercentage / 10
    attackPercentage = Utility.RemoveEndZero(attackPercentage)
    return attackPercentage
end

---灵兽合体继承防御
function UIFurnaceViewTemplate:GetDefensePercentage(tableInfo)
    if (tableInfo == nil or tableInfo.defensePercentage == nil or tableInfo.defensePercentage <= 0) then
        return 0
    end
    local defensePercentage = 0
    defensePercentage = tableInfo.defensePercentage / 10
    defensePercentage = Utility.RemoveEndZero(defensePercentage)
    return defensePercentage
end

---掉宝率
function UIFurnaceViewTemplate:GetAddDropTreasure(tableInfo)
    if (tableInfo == nil or tableInfo.addDropTreasure == nil or tableInfo.addDropTreasure <= 0) then
        return 0
    end
    local addDropTreasure = 0
    addDropTreasure = Utility.RemoveEndZero(tableInfo.addDropTreasure / 1000)
    return addDropTreasure
end
--endregion

--endregion

--region 根据选择信息显示当前选择界面内容

function UIFurnaceViewTemplate:GetNotHasEquipTipStr(subType)
    local str = "";
    if (subType == LuaEnumEquiptype.Baoshishoutao) then
        str = "需要装备元石手套才能生效对应属性";
    elseif (subType == LuaEnumEquiptype.TheSecretTreasureOfYuanling) then
        str = "需要装备元灵秘宝才能生效对应属性";
    elseif (subType == LuaEnumEquiptype.Light) then
        str = "需要装备赤炎灯才能生效对应属性";
    elseif (subType == LuaEnumEquiptype.SoulJade) then
        str = "需要装备魂玉才能生效对应属性";
    end
    --return luaEnumColorType.Red..str.."[-]";
    return "";
end

---@class GodFurnaceData
---@field subType number 物品类型
---@field fragmentId number 所需碎片id
---@field curLevelShowNameStr string 当前展示属性Name
---@field curLevelShowValueStr string 当前展示属性Value
---@field nextLevelShowNameStr string 下级展示属性Name
---@field nextLevelShowValueStr string 下级展示属性Value
---@field curEquipInfo TABLE.CFG_ITEMS 当前展示信息
---@field nextEquipInfo TABLE.CFG_ITEMS 下级展示信息
---@field curGodFurnaceItem TABLE.CFG_GODFURNACE 当前对应神炉数据
---@field nextGodFurnaceItem TABLE.CFG_GODFURNACE 下级对应神炉数据

---显示弹窗界面
---@param dataObj GodFurnaceData
function UIFurnaceViewTemplate:SetUIShowWithData(dataObj)
    self.GodFurnaceData = dataObj
    ---@type LuaMatchConditionResult 是否满足升级需要的人物等级条件
    self.matchCondition = nil

    --region UIItem的显示
    local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(dataObj.subType)
    self:GetNotHasEquipTip_Text().gameObject:SetActive(equipInfo == nil);
    self:GetNotHasEquipTip_Text().text = self:GetNotHasEquipTipStr(dataObj.subType);
    if (dataObj.curEquipInfo ~= nil) then
        self:GetFirstLock_GameObject():SetActive(false);
        self:GetFirstUIItemIcon_GameObject():SetActive(true);
        self:GetFirstUIItemFrame_GameObject():SetActive(true);

        self:GetThirdUIItemLock_GameObject():SetActive(false);
        self:GetThirdUIItemIcon_GameObject():SetActive(true);
        self:GetThirdUIItemFrame_GameObject():SetActive(true);
        self.mCurEquipId = dataObj.curGodFurnaceItem.id;
        self:GetFirstUIItem_UIItem():RefreshUIWithItemInfo(dataObj.curEquipInfo, 1);
        self:GetThirdUIItem_UIItem():RefreshUIWithItemInfo(dataObj.curEquipInfo, 1);
    else
        self.mCurEquipId = nil;
        self:GetFirstLock_GameObject():SetActive(true);
        self:GetFirstUIItemIcon_GameObject():SetActive(false);
        self:GetFirstUIItemFrame_GameObject():SetActive(false);

        self:GetThirdUIItemLock_GameObject():SetActive(true);
        self:GetThirdUIItemIcon_GameObject():SetActive(false);
        self:GetThirdUIItemFrame_GameObject():SetActive(false);
    end

    if (dataObj.nextEquipInfo ~= nil) then
        self:GetSecondLock_GameObject():SetActive(false);
        self:GetSecondUIItemFrame_GameObject():SetActive(true);
        self:GetSecondUIItemIcon_GameObject():SetActive(true);
        self.mNextEquipId = dataObj.nextGodFurnaceItem.id;
        self:GetSecondUIItem_UIItem():RefreshUIWithItemInfo(dataObj.nextEquipInfo, 1);

    else
        self.mNextEquipId = nil;
        self:GetSecondLock_GameObject():SetActive(true);
        self:GetSecondUIItemFrame_GameObject():SetActive(false);
        self:GetSecondUIItemIcon_GameObject():SetActive(false);
    end
    --endregion

    --region 神炉属性之类的显示
    local tableInfo;
    local showConsumeStr = "";
    ---是否是升阶
    local isPhase = false;
    ---是否为激活(第一次升级)
    local isFirst = false;
    ---当前阶段等级
    local phaseLevel = 0;
    ---是否满级
    local isMax = (dataObj.nextGodFurnaceItem == nil);
    ---是否满足升级条件(是否可升级)
    local isCanLevelUp = false;

    local showStr = isMax and dataObj.curLevelShowValueStr or dataObj.nextLevelShowValueStr;

    if dataObj.curGodFurnaceItem ~= nil then
        isFirst = false;
        local curLevel = dataObj.curGodFurnaceItem.lv
        self:GetCurOtherValue_Text().text = curLevel;
        self.matchCondition = Utility.IsMainPlayerMatchCondition(dataObj.curGodFurnaceItem.conditionId)
        ---是否升阶
        self:ChangeCoin2()
        if dataObj.curGodFurnaceItem.assist ~= nil and dataObj.curGodFurnaceItem.assist.list ~= nil and dataObj.curGodFurnaceItem.assist.list.Count > 0 then
            for i = 0, dataObj.curGodFurnaceItem.assist.list.Count - 1 do
                local v = dataObj.curGodFurnaceItem.assist.list[i]
                if i == 0 then
                    if (v.list ~= nil and v.list.Count > 0) then
                        local colorStr = "[FF4500]";
                        local itemId = v.list[0];
                        local itemCount = v.list[1];
                        local count = 0;
                        self.mNeedItemId = itemId;
                        tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(itemId);
                        if (tableInfo ~= nil) then
                            if (tableInfo.type == luaEnumItemType.Coin) then
                                count = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemId);
                            elseif (tableInfo.type == luaEnumItemType.Material) then
                                count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemId);
                                local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId);
                                if (itemTbl ~= nil) then
                                    count = count + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemTbl:GetLinkItemId());
                                end
                            end
                            --showConsumeStr = showConsumeStr..tableInfo.name.." : ";
                            showConsumeStr = "";
                            self:GetConsumeIcon_UISprite().spriteName = tableInfo.icon;
                            self:GetConsumeName_UILabel().text = tableInfo.name
                            self.needItemInfo = tableInfo;
                        end

                        ---是否可升级
                        isCanLevelUp = count >= itemCount;
                        self:SetCoin1Enough(isCanLevelUp, tableInfo.name)
                        colorStr = isCanLevelUp and luaEnumColorType.Green or luaEnumColorType.White;
                        local maxCountColorStr = isCanLevelUp and luaEnumColorType.Green or "";
                        local maxCountEndStr = isCanLevelUp and "[-]" or "";
                        local showNeedCount = itemCount <= 0 and "-" or itemCount;
                        showConsumeStr = showConsumeStr .. CS.Utility_Lua.SetProgressLabelColor(count, showNeedCount) .. maxCountEndStr;
                    end
                elseif i == 1 then
                    self:ChangeCoin2(v.list)
                end
            end
            self:RefreshExtraCost(dataObj.curGodFurnaceItem)
        end
        if isCanLevelUp == true then
            isCanLevelUp = CS.Cfg_GodFurnaceTableManager.Instance:MainPlayerHaveEnoughCoin(dataObj.curGodFurnaceItem.id)
        end
        isFirst = dataObj.curGodFurnaceItem.lv == 0;
        self:GetItemName_Text().text = dataObj.itemNameStr;
        self:GetConsumeName_Text().text = isFirst and "激活条件" or "升级条件";
        local isServant = self.selectId == LuaEnumFurnaceOpenType.TheSourceOfAttack or self.selectId == LuaEnumFurnaceOpenType.TheSourceOfDefense
        self:GetUpLevelActionName_Text().text = isFirst and "激活效果" or "升级效果" --(isServant and "灵兽合体效果" or "升级效果");
        self:GetUpLevelButtonName_Text().text = isFirst and "激活" or "升级";
        --local equipIndex = Utility.GetEquipIndexWithFurnacePanelId(self.selectId);
        --local iconId = CS.Cfg_GlobalTableManager.Instance:GetFurnaceDefaultIcon(equipIndex);
        --if (iconId ~= nil) then
        --    self:GetFirstLockDefaultIcon_UISprite().spriteName = iconId;
        --    self:GetSecondLockDefaultIcon_UISprite().spriteName = iconId;
        --    self:GetThirdLockDefaultIcon_UISprite().spriteName = iconId;
        --end
    end
    if (dataObj.nextGodFurnaceItem ~= nil) then
        local nextLevel = dataObj.nextGodFurnaceItem.lv;
        self:GetNextOtherValue_Text().text = nextLevel;
        self:GetMaxLevelNode_GameObject():SetActive(false);
        self:GeArrowBackGround_GameObject():SetActive(true);
    else
        self:GetMaxLevelNode_GameObject():SetActive(true);
        self:GeArrowBackGround_GameObject():SetActive(false);
    end
    self:GetConsume_Text().text = showConsumeStr;

    ---激活特效
    self:GetActiveEffectLoad_GameObject():SetActive(isFirst and isCanLevelUp);

    --region 升阶显示
    self:GetThirdUIItem_UIItem().go:SetActive(isFirst or not isPhase);
    self:GetSecondUIItem_UIItem().go:SetActive(not (isFirst or not isPhase));
    self:GetFirstUIItem_UIItem().go:SetActive(not (isFirst or not isPhase));

    self:GetUpPpPhaseLevel_GameObject():SetActive(isPhase);

    ---升阶时或者满级不显示
    self:GetNextOtherValue_Text().gameObject:SetActive(not isFirst and not isPhase and not isMax);
    self:GetCurOtherValue_Text().gameObject:SetActive(not isFirst and not isPhase and not isMax);

    self:GetCurPhaseName_Text().gameObject:SetActive(isPhase);
    self:GetNextPhaseName_Text().gameObject:SetActive(isPhase);
    self:GeArrow_GameObject():SetActive(not isFirst and not isPhase);
    self:GetItemName_Text().gameObject:SetActive(not isPhase);
    if (isPhase) then
        self:GetCurPhaseName_Text().text = dataObj.curEquipInfo == nil and "" or dataObj.curEquipInfo.name;
        self:GetNextPhaseName_Text().text = dataObj.nextEquipInfo == nil and "" or dataObj.nextEquipInfo.name;
    end
    --endregion
    self:UpdateOtherAttribute(dataObj);

    --region 满级&不满足人物等级条件
    if (self.isPlayEffect) then
        self:PlayEffect(self:GetNextOtherValue_Text().text, showStr, isMax);
    end

    local meetMatchCondition = self.matchCondition == nil or (self.matchCondition ~= nil and self.matchCondition.success)
    self:GetMaxLevelSprite_UISprite().gameObject:SetActive(isMax);
    self:GetMaxLevelSprite_UISprite().spriteName = self:GetMaxLevelSpriteName(self.selectId);
    self:GetMaxLevelSprite_UISprite():MakePixelPerfect();
    self:GetBtnUpgrade_GameObject():SetActive(not isMax and meetMatchCondition);
    self:GetBtnChangToBuy_GameObject():SetActive(not isMax and meetMatchCondition);
    self:GetBtnGet_GameObject():SetActive(not isMax and meetMatchCondition);
    local costNum, costTbl = self:GetCoin2Info()
    self:GetCoin2_GO():SetActive(not isMax and costNum ~= nil and costTbl ~= nil and meetMatchCondition);
    luaclass.UIRefresh:RefreshActive(self:GetLevelLimit_UILabel(), not meetMatchCondition)
    luaclass.UIRefresh:RefreshLabel(self:GetLevelLimit_UILabel(), self.matchCondition == nil and '' or self.matchCondition.txt)
    --luaclass.UIRefresh:RefreshActive(self:Btn_GetExperience_GameObject(), not meetMatchCondition)

    --luaclass.UIRefresh:RefreshSprite(self:GetLevelLimit_UISprite(),spriteName)
    --endregion

    --endregion

    --region 激活效果
    local isShow = false
    local id, state = self:GetActiveEquipId()
    if id ~= nil and state ~= nil then
        local curTitleDes, curContentDes = Utility:GetGemAdditionBufferDes(id)
        if CS.StaticUtility.IsNullOrEmpty(curTitleDes) == false and CS.StaticUtility.IsNullOrEmpty(curContentDes) == false then
            isShow = true
        end
    end
    --luaclass.UIRefresh:RefreshActive(self:GetAttributeBtn_Go(), isShow)
    --endregion

    local furnaceIds = nil;
    if (self.selectId == LuaEnumFurnaceOpenType.ChyanLamp) then
        furnaceIds = LuaGlobalTableDeal:GetLightComponentIds();
    elseif (self.selectId == LuaEnumFurnaceOpenType.SoulBead) then
        furnaceIds = LuaGlobalTableDeal:GetSoulJadeComponentIds();
    elseif (self.selectId == LuaEnumFurnaceOpenType.Gem) then
        furnaceIds = LuaGlobalTableDeal:GetGemComponentIds();
    end

    if (dataObj.curGodFurnaceItem ~= nil) then
        self:GetSpecialAttributeViewTemplate():UpdateView(dataObj.curGodFurnaceItem.id, furnaceIds, self.selectId, self.CallOnBtnAttributeClick);
    end
end

function UIFurnaceViewTemplate:UpdateOtherAttribute(data)
    if (self.mOtherAttributeUnitDic == nil) then
        self.mOtherAttributeUnitDic = {};
    end
    local gridContainer = self:GetOtherAttribute_UIGridContainer();
    --gridContainer.gameObject:SetActive(data.otherCurShowAttribute ~= nil);
    if (data.otherCurShowAttribute ~= nil and data.otherNextShowAttribute ~= nil) then
        gridContainer.MaxCount = #data.otherCurShowAttribute;
        if (gridContainer.MaxCount > 0) then
            local index = 0;
            for k, v in pairs(data.otherCurShowAttribute) do
                local gobj = gridContainer.controlList[index];
                if (self.mOtherAttributeUnitDic[gobj] == nil) then
                    self.mOtherAttributeUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIFurnaceOtherAttributeUnitTemplate);
                end
                self.mOtherAttributeUnitDic[gobj]:UpdateUnit(v, self:GetOtherAttributeUnitValue(v, data.otherNextShowAttribute));
                index = index + 1;
            end
        end
    else
        gridContainer.MaxCount = 0;
    end
    local count = gridContainer.MaxCount - 1
    if count > 3 then
        count = 3
    end
    count = count < 0 and 0 or count;
    local yPos = -34 + count * 34 - 17
    local pos = gridContainer.transform.localPosition
    pos. y = yPos
    gridContainer.transform.localPosition = pos
    local pos1 = self:GetUpLevelActionName_Text().gameObject.transform.localPosition
    pos1.y = yPos
    self:GetUpLevelActionName_Text().gameObject.transform.localPosition = pos1
    local pos2 = self:GetNotHasEquipTip_Text().gameObject.transform.localPosition
    pos2.y = yPos
    self:GetNotHasEquipTip_Text().gameObject.transform.localPosition = pos2
end

---获取下一属性列表中的与当前属性名相同的属性
---@param CurAttr table
---@param NextAttrdata table[]
function UIFurnaceViewTemplate:GetOtherAttributeUnitValue(CurAttr, NextAttrdata)
    if (CurAttr == nil or NextAttrdata == nil or #NextAttrdata <= 0) then
        return {}
    end
    for k, v in pairs(NextAttrdata) do
        if (v ~= nil and CurAttr.curNameStr == v.nextNameStr) then
            return v
        end
    end
    return {}
end

--region 刷新货币1(材料1)
function UIFurnaceViewTemplate:SetCoin1Enough(isEnough, materialName)
    self.mCoin1Enough = isEnough
    self.Coin1MatName = materialName
end

---@return boolean,string 第二种材料是否足够,第二种材料名字
function UIFurnaceViewTemplate:GetCoin1Enough()
    return self.mCoin1Enough, self.Coin1MatName
end
--endregion

--region刷新货币2(材料2)
function UIFurnaceViewTemplate:ChangeCoin2(list)
    self:SetCoin2Info(nil, nil)
    if list and list.Count >= 2 then
        local itemId = list[0];
        local itemCount = list[1];
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        self:SetCoin2Info(itemCount, itemTbl)
    end
    self:RefreshCoin2()
end

---刷新显示
function UIFurnaceViewTemplate:RefreshCoin2()
    self:SetCoin2Enough(false, "")
    local costNum, costTbl = self:GetCoin2Info()
    if costNum == nil or costTbl == nil then
        return
    end
    self:GetCoin2Name_Lb().text = costTbl:GetName()
    self:GetCoin2Icon_Sp().spriteName = costTbl:GetIcon()

    local res, csItemTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(costTbl:GetId())
    if res then
        CS.UIEventListener.Get(self:GetCoin2Icon_Sp().gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = csItemTbl })
        end
    end

    local playerHas = 0

    if (costTbl:GetType() == luaEnumItemType.Coin) then
        playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(costTbl:GetId())
    elseif (costTbl:GetType() == luaEnumItemType.Material) then
        playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(costTbl:GetId(), nil)
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(costTbl:GetId());
        if (itemTbl ~= nil) then
            playerHas = playerHas + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(itemTbl:GetLinkItemId(), nil)
        end
    end
    self:SetCoin2Enough(playerHas >= costNum, costTbl:GetName())
    local color = playerHas >= costNum and luaEnumColorType.Green or luaEnumColorType.Red
    self:GetCoin2Cost_Lb().text = Utility.CombineStringQuickly(color, playerHas, "[-]/", costNum)
    CS.UIEventListener.Get(self:GetCoin2Cost_AddGO()).onClick = function()
        Utility.ShowItemGetWay(costTbl:GetId(), self:GetCoin2Cost_AddGO(), LuaEnumWayGetPanelArrowDirType.Down);
    end
end

---设置货币2信息
function UIFurnaceViewTemplate:SetCoin2Info(itemNum, itemTbl)
    self.mCoin2Num = itemNum
    self.mCoin2Tbl = itemTbl
end

---设置材料2是否足够
function UIFurnaceViewTemplate:SetCoin2Enough(isEnough, materialName)
    self.mCoin2Enough = isEnough
    self.Coin2MatName = materialName
end

---@return boolean,string 第二种材料是否足够,第二种材料名字
function UIFurnaceViewTemplate:GetCoin2Enough()
    return self.mCoin2Enough, self.Coin2MatName
end

---@return number,TABLE.cfg_items
function UIFurnaceViewTemplate:GetCoin2Info()
    return self.mCoin2Num, self.mCoin2Tbl
end
--endregion

--region 刷新货币
---刷新当前升级货币
---@param csTbl TABLE.CFG_GODFURNACE
function UIFurnaceViewTemplate:RefreshExtraCost(csTbl)
    self:SaveCurrentGoldCostInfo(csTbl)
    self:RefreshGoldCost()
end

---存储货币消耗
function UIFurnaceViewTemplate:SaveCurrentGoldCostInfo(csTbl)
    self.mCurrentGoldCostId = nil
    self.mCurrentGoldCostNum = nil
    if csTbl == nil then
        return
    end
    local luaGodTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(csTbl.id)
    if luaGodTbl == nil then
        return
    end
    local costList = luaGodTbl:GetCost()
    if costList and costList.list.Count >= 2 then
        self.mCurrentGoldCostId = costList.list[0]
        self.mCurrentGoldCostNum = costList.list[1]
    end
    if self.mCurrentGoldCostId then
        ---@type TABLE.CFG_ITEMS
        local res, csItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCurrentGoldCostId)
        if res then
            self:GetGoldCost_Sp().spriteName = csItemInfo.icon
            self:SaveGoldName(csItemInfo.name)
        end
        CS.UIEventListener.Get(self:GetGoldCost_Sp().gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = csItemInfo })
        end
    end
end

---刷新货币
function UIFurnaceViewTemplate:RefreshGoldCost()
    local hasData = self.mCurrentGoldCostId and self.mCurrentGoldCostNum
    if self.mCurrentGoldCostId and self.mCurrentGoldCostNum then
        local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self.mCurrentGoldCostId)
        local color = playerHas >= self.mCurrentGoldCostNum and luaEnumColorType.Green or luaEnumColorType.Red
        self:GetGoldCost_Lb().text = Utility.CombineStringQuickly(color, playerHas, "[-]/", self.mCurrentGoldCostNum)
        self:SaveGoldEnough(playerHas >= self.mCurrentGoldCostNum)
    end
    local meetMatchCondition = self.matchCondition == nil or (self.matchCondition ~= nil and self.matchCondition.success)
    self:GetGoldCost_Lb().gameObject:SetActive(hasData and meetMatchCondition)
end

---@param isEnough boolean 存储货币是否足够
function UIFurnaceViewTemplate:SaveGoldEnough(isEnough)
    self.mGoldEnough = isEnough
end

---@param goldName string 存储货币名字
function UIFurnaceViewTemplate:SaveGoldName(goldName)
    self.mGoldName = goldName
end

---获取货币信息
function UIFurnaceViewTemplate:GetGoldEnough()
    return self.mGoldEnough, self.mGoldName
end
--endregion

--endregion

---设置下级属性信息
function UIFurnaceViewTemplate:SetNextAttributeNameAndValue(nameStr, valueStr)
    self:GetNextLevelAttributeName_Text().text = nameStr;
    self:GetNextLevelAttributeValue_Text().text = "[00ff00]" .. valueStr .. "[-]";
end

---设置当前属性信息
function UIFurnaceViewTemplate:SetCurAttributeNameAndValue(nameStr, valueStr)
    self:GetCurLevelAttributeName_Text().text = nameStr;
    self:GetCurLevelAttributeValue_Text().text = valueStr;
    self:GetMaxLevelAttributeValue_Text().text = "[00ff00]" .. valueStr .. "[-]";
end

--region 升级特效
function UIFurnaceViewTemplate:PlayEffect(otherValue, value, isMax)
    self.isPlayEffect = false;
    if self.mUpEffect == nil then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectIds.upLevelEffectId, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                if self:GetUpEffectParent_GameObject() == nil or CS.StaticUtility.IsNull(self:GetUpEffectParent_GameObject()) then
                    return
                end
                self.mUpEffect = res:GetObjInst()
                if self.mUpEffect then
                    self.mUpEffect.transform.parent = self:GetUpEffectParent_GameObject().transform
                    self.mUpEffect.transform.localPosition = CS.UnityEngine.Vector3(-40, 150, 0);
                    self.mUpEffect.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        self.mUpEffect:SetActive(false);
        self.mUpEffect:SetActive(true);
    end

    if (isMax) then
        self:GetMaxLevelAttributeEffect_Text().text = value;

        self:GetMaxLevelAttributeValue_TweenAlpha():PlayTween();
    else
        --self:GetNextLevelOtherValueEffect_Text().text = otherValue;
        --self:GetNextLevelAttributeValueEffect_Text().text = value;

        --self:GetNextLevelAttributeValue_TweenAlpha():PlayTween();
        --self:GetNextLevelOtherValue_TweenAlpha():PlayTween();

        if (self.mOtherAttributeUnitDic ~= nil) then
            for k, v in pairs(self.mOtherAttributeUnitDic) do
                v:PlayerNextLevelEffect();
            end
        end
    end
end
--endregion

---获取宝物倍数显示文本
function UIFurnaceViewTemplate:GetFurnaceCritMultiplierShowStr()
    if self.curSelectId == LuaEnumFurnaceOpenType.Gem then
        return LuaGlobalTableDeal:GetGemDes()
    elseif self.curSelectId == LuaEnumFurnaceOpenType.ChyanLamp then
        return LuaGlobalTableDeal:GetLightComponentDes()
    elseif self.curSelectId == LuaEnumFurnaceOpenType.TheSourceOfAttack then
        return LuaGlobalTableDeal:GetJingongzhiyuanDes()
    else
        return nil
    end
end

function UIFurnaceViewTemplate:GetMaxLevelSpriteName(type)
    if (type == LuaEnumFurnaceOpenType.Gem) then
        return "GemLvMax";
    elseif (type == LuaEnumFurnaceOpenType.ChyanLamp) then
        return "WickLvMax";
    elseif (type == LuaEnumFurnaceOpenType.SoulBead) then
        return "SMJPLvMax";
    elseif (type == LuaEnumFurnaceOpenType.TheSourceOfAttack) then
        return "JGZYLvMax";
    elseif (type == LuaEnumFurnaceOpenType.TheSourceOfDefense) then
        return "SHZYLvMax";
    end
    return "GemLvMax";
end

function UIFurnaceViewTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnUpgrade_GameObject()).onClick = function()
        if (self.selectId == LuaEnumFurnaceOpenType.Gem) then
            self:OnButtonClickUpgradeGem();
        elseif (self.selectId == LuaEnumFurnaceOpenType.ChyanLamp) then
            self:OnButtonClickUpgradeChyanLamp();
        elseif (self.selectId == LuaEnumFurnaceOpenType.SoulBead) then
            self:OnButtonClickUpgradeSoulBead();
        elseif (self.selectId == LuaEnumFurnaceOpenType.TheSourceOfAttack) then
            self:OnButtonClickUpgradeTheSourceOfAttack();
        elseif (self.selectId == LuaEnumFurnaceOpenType.TheSourceOfDefense) then
            self:OnButtonClickUpgradeTheSourceOfDefense();
        end
    end

    CS.UIEventListener.Get(self:GetBtnChangToBuy_GameObject()).onClick = function()
        self:OnButtonClickChangToBuy();
    end

    CS.UIEventListener.Get(self:GetFirstUIItem_UIItem().go).onClick = function()
        if (self.mCurEquipId ~= nil) then
            local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mCurEquipId);
            if (isFind) then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
            end
        end
    end

    CS.UIEventListener.Get(self:GetSecondUIItem_UIItem().go).onClick = function()
        if (self.mNextEquipId ~= nil) then
            local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mNextEquipId);
            if (isFind) then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
            end
        end
    end

    CS.UIEventListener.Get(self:GetThirdUIItem_UIItem().go).onClick = function()
        if (self.mCurEquipId ~= nil) then
            local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mCurEquipId);
            if (isFind) then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
            end
        end
    end

    CS.UIEventListener.Get(self:GetConsumeIcon_UISprite().gameObject).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.needItemInfo })
    end

    --CS.UIEventListener.Get(self:Btn_GetExperience_GameObject().gameObject).onClick = function()
    --    uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Rein_LevelExpExchange, nil, nil);
    --end

    self.CallOnBtnAttributeClick = function(furnaceSpecialAttributesUnitTemplate)
        local id, state = self:GetActiveEquipId()
        ---@type UIFurnaceSpecialAttributesUnitTemplate
        local curFurnaceSpecialAttributesUnitTemplate = furnaceSpecialAttributesUnitTemplate
        if type(curFurnaceSpecialAttributesUnitTemplate) == 'table' and type(curFurnaceSpecialAttributesUnitTemplate.mFurnaceId) == 'number' then
            id = curFurnaceSpecialAttributesUnitTemplate.mFurnaceId
            state = curFurnaceSpecialAttributesUnitTemplate:IsActive()
        end
        if id == nil or state == nil then
            return
        end
        uimanager:CreatePanel("UIGemSuitAttributePanel", nil, { furnaceId = id, state = state, type = self.selectId })
    end
    luaclass.UIRefresh:BindClickCallBack(self:GetAttributeBtn_Go(), self.CallOnBtnAttributeClick)
end

---@return number,boolean 装备id，是否激活
function UIFurnaceViewTemplate:GetActiveEquipId()
    if self.GodFurnaceData.curEquipInfo then
        return Utility:GetCurSpecialFurnaceState(self.GodFurnaceData.curEquipInfo.id, self.selectId);
    elseif self.GodFurnaceData.nextEquipInfo then
        local id, isActive = Utility:GetCurSpecialFurnaceState(self.GodFurnaceData.nextEquipInfo.id, self.selectId);
        return id, false;
    end
end

function UIFurnaceViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UIFurnaceViewTemplate:Show()

end

---@param panel UIFurnacePanel
function UIFurnaceViewTemplate:Init(panel)
    self.mRootPanel = panel
    self:InitEvents();
end

function UIFurnaceViewTemplate:SetHelpBtnShow(isShow)
    if self.mRootPanel then
        self.mRootPanel:SetHelpBtnShow(isShow)
    end
end

function UIFurnaceViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIFurnaceViewTemplate;