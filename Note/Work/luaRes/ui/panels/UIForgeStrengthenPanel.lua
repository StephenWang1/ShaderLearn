---@class UIForgeStrengthenPanel:UIBase 强化界面
local UIForgeStrengthenPanel = {}

--region 局部变量定义
---当前选中的物品信息
UIForgeStrengthenPanel.mBagItemInfo = nil
---当前选中的物品lid
UIForgeStrengthenPanel.mCurrentChooseBagItemId = nil
---成功特效
UIForgeStrengthenPanel.mWinEffect = nil
UIForgeStrengthenPanel.winEffectPool = nil
---失败特效
UIForgeStrengthenPanel.mFailEffect = nil
---最大星级
UIForgeStrengthenPanel.mMaxStar = nil
---当前选中道具Id
UIForgeStrengthenPanel.mCurrentChooseCostId = nil
---存储格子对应模板
---@type table<XLua.Cast.Int32,UIForgeStrengthenPanel_CostItemTemplate>
UIForgeStrengthenPanel.mItemIdToTemplate = nil
---存储道具是否足够
UIForgeStrengthenPanel.mIsCanIntensify = false
---需要限制subtype列表
UIForgeStrengthenPanel.mNeedLimitIdList = nil
---玩家是否达到限制条件
UIForgeStrengthenPanel.mHasPlayerArriveLimit = false
---存储限制条件
UIForgeStrengthenPanel.mLimitShow = nil
---存储未选择信息
UIForgeStrengthenPanel.mNoChooseTips = nil
---存储道具不足提示信息
UIForgeStrengthenPanel.mNotEnoughTips = nil
---拥有的矿石
UIForgeStrengthenPanel.OwnCount = 0
---装备信息
UIForgeStrengthenPanel.EquipDic = nil
---套装等级
UIForgeStrengthenPanel.mCurrentSuitLevel = 0
---下一级套装等级
UIForgeStrengthenPanel.mNextSuitLevel = 0
---当前套装攻击
UIForgeStrengthenPanel.mCurrentSuitAttack = 0
---下一级套装攻击
UIForgeStrengthenPanel.mNextSuitAttack = 0
---套装总数
UIForgeStrengthenPanel.mSuitTableData = 0
---大于某星级套装数量
UIForgeStrengthenPanel.mStarSuitNum = {}
---套装信息
UIForgeStrengthenPanel.mSuitInfo = nil
---满足下一级套装等级
UIForgeStrengthenPanel.mArriveNextSuitLevel = nil
---@type UIRolePanel 角色界面
UIForgeStrengthenPanel.mRolePanel = nil
---@type UIBagPanel 背包界面
UIForgeStrengthenPanel.mBagPanel = nil
---@type UIServantPanel 元灵界面
UIForgeStrengthenPanel.mServantPanel = nil
---正在打开的界面,记录下正在打开的界面,当当前界面销毁时顺手把正在打开的界面也关闭
UIForgeStrengthenPanel.mOpeningPanel = {}
---所有打开过的界面
UIForgeStrengthenPanel.mOpenPanel = {}

---进入界面需要选中道具
---@type bagV2.BagItemInfo
UIForgeStrengthenPanel.mNeedChooseBagItemInfo = nil

---所有矿物类型
UIForgeStrengthenPanel.mAllMineList = nil
---@type table<number,TABLE.CFG_ITEMS> 矿信息
UIForgeStrengthenPanel.mMineItemInfo = nil
---背包矿信息
UIForgeStrengthenPanel.bagMineDic = nil
---矿id对应消耗数目
UIForgeStrengthenPanel.mMineIdToCostNum = nil
---每页显示矿最大数目
UIForgeStrengthenPanel.mPageMaxNum = 5

---当前选中消耗的物品的itemid
UIForgeStrengthenPanel.curSelectItemID = 0

UIForgeStrengthenPanel.mWinEffect = nil
UIForgeStrengthenPanel.winEffectPool = nil

---星级换算
UIForgeStrengthenPanel.SuitStar = {
    [1] = "一星",
    [2] = "二星",
    [3] = "三星",
    [4] = "四星",
    [5] = "五星",
    [6] = "六星",
    [7] = "七星",
    [8] = "八星",
    [9] = "九星",
    [10] = "十星",
    [11] = "十一星",
    [12] = "十二星",
    [13] = "十三星",
    [14] = "十四星",
    [15] = "十五星",
}
--endregion

--region数据
---@return CSMainPlayerInfo 玩家信息
function UIForgeStrengthenPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSEquipInfoV2 装备信息
function UIForgeStrengthenPanel:GetEquipInfoV2()
    if self.mEquipInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mEquipInfoV2 = self:GetMainPlayerInfo().EquipInfo
    end
    return self.mEquipInfoV2
end

---@return number 套装数目限制数目 到达此数目表示套装激活
function UIForgeStrengthenPanel:GetSuitLimitNum()
    if self.suitMaxNum == nil then
        self.suitMaxNum = CS.Cfg_GlobalTableManager.Instance:GetStrengeSuitMaxNum()
        if self.suitMaxNum == nil then
            self.suitMaxNum = 0
        end
    end
    return self.suitMaxNum
end

---@return CSBagInfoV2
function UIForgeStrengthenPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

--endregion

--region 组件
---强化按钮
function UIForgeStrengthenPanel.GetStrengthenButton_GameObject()
    if UIForgeStrengthenPanel.mStrengthenButton_GO == nil then
        UIForgeStrengthenPanel.mStrengthenButton_GO = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/BtnRoot/btn_strengthen", "GameObject")
    end
    return UIForgeStrengthenPanel.mStrengthenButton_GO
end

---强化按钮文本
function UIForgeStrengthenPanel:GetStrengthenButton_UILabel()
    if self.mStrengthenButtonLb == nil then
        self.mStrengthenButtonLb = self:GetCurComp("WidgetRoot/view/BtnRoot/btn_strengthen/Label", "UILabel")
    end
    return self.mStrengthenButtonLb
end

---锻造消耗道具名字
function UIForgeStrengthenPanel.GetItemName_UILabel()
    if UIForgeStrengthenPanel.mItemName == nil then
        UIForgeStrengthenPanel.mItemName = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/BtnRoot/gold/moneyName", "UILabel")
    end
    return UIForgeStrengthenPanel.mItemName
end

---原属性
function UIForgeStrengthenPanel.GetCurAttribute_UILabel()
    if UIForgeStrengthenPanel.mCurAttributeLabel == nil then
        UIForgeStrengthenPanel.mCurAttributeLabel = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/curarribute/value", "UILabel")
    end
    return UIForgeStrengthenPanel.mCurAttributeLabel
end

---追加属性
function UIForgeStrengthenPanel.GetNextAttribute_UILabel()
    if UIForgeStrengthenPanel.mNextAttributeLabel == nil then
        UIForgeStrengthenPanel.mNextAttributeLabel = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/nextarribute/value", "UILabel")

    end
    return UIForgeStrengthenPanel.mNextAttributeLabel
end

---追加属性特效Label
function UIForgeStrengthenPanel.GetNextAttributeEffect_UILabel()
    if UIForgeStrengthenPanel.mNextAttributeLabelEffectUILabel == nil then
        UIForgeStrengthenPanel.mNextAttributeLabelEffectUILabel = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/nextarribute/valueEffect", "UILabel")
    end
    return UIForgeStrengthenPanel.mNextAttributeLabelEffectUILabel
end

---追加属性特效
function UIForgeStrengthenPanel.GetNextArributeEffect()
    if UIForgeStrengthenPanel.mNextarributeLableEffect == nil then
        UIForgeStrengthenPanel.mNextarributeLableEffect = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/nextarribute/valueEffect", "Top_TweenAlpha")
    end
    return UIForgeStrengthenPanel.mNextarributeLableEffect
end

---消耗普通道具Label
function UIForgeStrengthenPanel.GetNormalResource_UILabel()
    if UIForgeStrengthenPanel.mNormalResource == nil then
        UIForgeStrengthenPanel.mNormalResource = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/BtnRoot/gold/goldNum", "UILabel")
    end
    return UIForgeStrengthenPanel.mNormalResource
end

---@return UISprite 被强化装备Icon
function UIForgeStrengthenPanel:GetItem_UIItem()
    if UIForgeStrengthenPanel.mItem == nil then
        UIForgeStrengthenPanel.mItem = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/ItemIcon", "UISprite")
    end
    return UIForgeStrengthenPanel.mItem
end

---@return UILabel 星级文本
function UIForgeStrengthenPanel:GetStrengthLb()
    if self.mStrengthLb == nil then
        self.mStrengthLb = self:GetCurComp("WidgetRoot/view/ItemIcon/strengthen", "UILabel")
    end
    return self.mStrengthLb
end

---@return UISprite 星级文本
function UIForgeStrengthenPanel:GetStrengthStar_UISprite()
    if self.mStrengthStarSp == nil then
        self.mStrengthStarSp = self:GetCurComp("WidgetRoot/view/ItemIcon/star", "UISprite")
    end
    return self.mStrengthStarSp
end

---强化成功率显示
function UIForgeStrengthenPanel:GetSuccessRate_UILabel()
    if self.mSuccessRateLabel == nil then
        self.mSuccessRateLabel = self:GetCurComp("WidgetRoot/view/successrate", "UILabel")
    end
    return self.mSuccessRateLabel
end

---满星提示
function UIForgeStrengthenPanel.GetMaxStarTips_GameObject()
    if (UIForgeStrengthenPanel.mMaxStarTips_GameObject == nil) then
        UIForgeStrengthenPanel.mMaxStarTips_GameObject = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/MaxStarTips", "GameObject");
    end
    return UIForgeStrengthenPanel.mMaxStarTips_GameObject;
end

---按钮描述Go
function UIForgeStrengthenPanel:GetBtnRoot_GameObject()
    if self.mBtnRoot == nil then
        self.mBtnRoot = self:GetCurComp("WidgetRoot/view/BtnRoot", "GameObject")
    end
    return self.mBtnRoot
end

---强化等级星星
function UIForgeStrengthenPanel.GetIntensityStarLineOneFrame_GridContainer()
    if UIForgeStrengthenPanel.mIntensityLineOneFrame == nil then
        UIForgeStrengthenPanel.mIntensityLineOneFrame = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/stars1", "UIGridContainer")
    end
    return UIForgeStrengthenPanel.mIntensityLineOneFrame
end

---消耗物品Icon
function UIForgeStrengthenPanel.GetNormalResourceIcon_Sprite()
    if UIForgeStrengthenPanel.mNormalResourceIcon == nil then
        UIForgeStrengthenPanel.mNormalResourceIcon = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/BtnRoot/gold/purityBg/money", "UISprite")
    end
    return UIForgeStrengthenPanel.mNormalResourceIcon
end

---锻造提示Label
function UIForgeStrengthenPanel.GetDescription_UILabel()
    if UIForgeStrengthenPanel.mDescription == nil then
        UIForgeStrengthenPanel.mDescription = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/Description", "UILabel")
    end
    return UIForgeStrengthenPanel.mDescription
end

---套装按钮
function UIForgeStrengthenPanel.GetSuitButton_GameObject()
    if UIForgeStrengthenPanel.mSuitLabel == nil then
        UIForgeStrengthenPanel.mSuitLabel = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_suit", "GameObject")
    end
    return UIForgeStrengthenPanel.mSuitLabel
end

---@return UILabel 套装按钮显示文字
function UIForgeStrengthenPanel:GetSuitButtonLabel_UILabel()
    if self.mSuitButtonLabel == nil then
        self.mSuitButtonLabel = self:GetCurComp("WidgetRoot/events/btn_suit/Label", "UILabel")
    end
    return self.mSuitButtonLabel
end

---@return UILabel 套装数目
function UIForgeStrengthenPanel:GetSuitButtonNumLabel_UILabel()
    if self.mSuitButtonNumLabel == nil then
        self.mSuitButtonNumLabel = self:GetCurComp("WidgetRoot/events/btn_suit/value", "UILabel")
    end
    return self.mSuitButtonNumLabel
end

---特效节点
function UIForgeStrengthenPanel.GetEffectRoot_GameObject()
    if UIForgeStrengthenPanel.mEffectRoot == nil then
        UIForgeStrengthenPanel.mEffectRoot = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/ItemIcon", "GameObject")
    end
    return UIForgeStrengthenPanel.mEffectRoot
end

---系统说明按钮
function UIForgeStrengthenPanel.GetHelpBtn_GameObject()
    if UIForgeStrengthenPanel.mHelpBtn_GameObject == nil then
        UIForgeStrengthenPanel.mHelpBtn_GameObject = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return UIForgeStrengthenPanel.mHelpBtn_GameObject
end

---选择Root
function UIForgeStrengthenPanel.GetChooseScrollView_GameObject()
    if UIForgeStrengthenPanel.mChooseScrollViewObj == nil then
        UIForgeStrengthenPanel.mChooseScrollViewObj = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/choose", "GameObject")
    end
    return UIForgeStrengthenPanel.mChooseScrollViewObj
end

---选择列表GridContainer
function UIForgeStrengthenPanel.GetChooseGridContainer_UIGridContainer()
    if UIForgeStrengthenPanel.mChooseList == nil then
        UIForgeStrengthenPanel.mChooseList = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/choose/Scroll View/sendlist", "UIGridContainer")
    end
    return UIForgeStrengthenPanel.mChooseList
end

---提升属性文本
function UIForgeStrengthenPanel:GetUpAttributeName_UILabel()
    if self.mUpAttributeName_UILabel == nil then
        self.mUpAttributeName_UILabel = self:GetCurComp("WidgetRoot/view/cur/value", "UILabel")
    end
    return self.mUpAttributeName_UILabel
end

---角色按钮
function UIForgeStrengthenPanel.GetRoleButton_GameObject()
    if UIForgeStrengthenPanel.mRoleButton == nil then
        UIForgeStrengthenPanel.mRoleButton = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_role", "GameObject")
    end
    return UIForgeStrengthenPanel.mRoleButton
end

---角色按钮选中
function UIForgeStrengthenPanel.GetRoleButtonChoose_GameObject()
    if UIForgeStrengthenPanel.mRoleButtonChoose == nil then
        UIForgeStrengthenPanel.mRoleButtonChoose = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_role/Checkmark", "GameObject")
    end
    return UIForgeStrengthenPanel.mRoleButtonChoose
end

---背包按钮
function UIForgeStrengthenPanel.GetBagButton_GameObject()
    if UIForgeStrengthenPanel.mBagButton == nil then
        UIForgeStrengthenPanel.mBagButton = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_bag", "GameObject")
    end
    return UIForgeStrengthenPanel.mBagButton
end

---背包按钮选中
function UIForgeStrengthenPanel.GetBagButtonChoose_GameObject()
    if UIForgeStrengthenPanel.mBagButtonChoose == nil then
        UIForgeStrengthenPanel.mBagButtonChoose = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_bag/Checkmark", "GameObject")
    end
    return UIForgeStrengthenPanel.mBagButtonChoose
end

---元灵按钮
function UIForgeStrengthenPanel.GetServantButton_GameObject()
    if UIForgeStrengthenPanel.mServantButton == nil then
        UIForgeStrengthenPanel.mServantButton = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_yuanling", "GameObject")
    end
    return UIForgeStrengthenPanel.mServantButton
end

---灵兽按钮选中
function UIForgeStrengthenPanel.GetServantButtonChoose_GameObject()
    if UIForgeStrengthenPanel.mServantButtonChoose == nil then
        UIForgeStrengthenPanel.mServantButtonChoose = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_yuanling/Checkmark", "GameObject")
    end
    return UIForgeStrengthenPanel.mServantButtonChoose
end

---关闭按钮
function UIForgeStrengthenPanel.GetCloseButton_GameObject()
    if UIForgeStrengthenPanel.mCloseButton == nil then
        UIForgeStrengthenPanel.mCloseChoose = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIForgeStrengthenPanel.mCloseChoose
end

---升星效果箭头
function UIForgeStrengthenPanel:GetAttributeChangeArrow()
    if UIForgeStrengthenPanel.arrow == nil then
        UIForgeStrengthenPanel.arrow = UIForgeStrengthenPanel:GetCurComp("WidgetRoot/view/Sprite", "UISprite")
    end
    return UIForgeStrengthenPanel.arrow
end
--endregion

--region 货币组件
--region 矿
---@return UnityEngine.GameObject
function UIForgeStrengthenPanel:GetGold1_GO()
    if self.mGold1 == nil then
        self.mGold1 = self:GetCurComp("WidgetRoot/view/BtnRoot/gold", "GameObject")
    end
    return self.mGold1
end

---@return UISprite 货币icon
function UIForgeStrengthenPanel:GetGold1_UISprite()
    if self.mGold1SP == nil then
        self.mGold1SP = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/purityBg/money", "UISprite")
    end
    return self.mGold1SP
end

---@return UILabel 货币数目
function UIForgeStrengthenPanel:GetGold1_UILabel()
    if self.mGold1Lb == nil then
        self.mGold1Lb = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/goldNum", "UILabel")
    end
    return self.mGold1Lb
end

---@return UnityEngine.GameObject Add
function UIForgeStrengthenPanel:GetGold1_AddGo()
    if self.mGold1AddGo == nil then
        self.mGold1AddGo = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/Add", "GameObject")
    end
    return self.mGold1AddGo
end

---@return UIGridContainer UIGridContainer
function UIForgeStrengthenPanel:GetGold1MatContainer()
    if self.mGold1MatContainer == nil then
        self.mGold1MatContainer = self:GetCurComp("WidgetRoot/view/choose/Scroll View/sendlist", "UIGridContainer")
    end
    return self.mGold1MatContainer
end

---@return UnityEngine.GameObject 材料显示
function UIForgeStrengthenPanel:GetGold1Mat_GO()
    if self.mGold1MatGO == nil then
        self.mGold1MatGO = self:GetCurComp("WidgetRoot/view/choose", "GameObject")
    end
    return self.mGold1MatGO
end

---@return UILabel 纯度显示
function UIForgeStrengthenPanel:GetPurity_UILabel()
    if self.mPurityLabel == nil then
        self.mPurityLabel = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/purityBg/purity", "UILabel")
    end
    return self.mPurityLabel
end

---@return UnityEngine.GameObject 材料按钮
function UIForgeStrengthenPanel:GetMatButton_GameObject()
    if self.mAddButton == nil then
        self.mAddButton = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/purityBg", "GameObject")
    end
    return self.mAddButton
end

---@return UIScrollView 选择Scroll
function UIForgeStrengthenPanel:GetChooseScrollView_UIScrollView()
    if self.mChooseScrollView == nil then
        self.mChooseScrollView = self:GetCurComp("WidgetRoot/view/choose/Scroll View", "UIScrollView")
    end
    return self.mChooseScrollView
end

---@return UnityEngine.GameObject 关闭选择Root
function UIForgeStrengthenPanel:GetCloseChoose_GameObject()
    if self.mCloseChoose == nil then
        self.mCloseChoose = self:GetCurComp("WidgetRoot/view/choose/bg", "GameObject")
    end
    return self.mCloseChoose
end

--endregion

--region 金币
---@return UnityEngine.GameObject
function UIForgeStrengthenPanel:GetGold2_GO()
    if self.mGold2 == nil then
        self.mGold2 = self:GetCurComp("WidgetRoot/view/BtnRoot/gold2", "GameObject")
    end
    return self.mGold2
end

---@return UISprite 货币icon
function UIForgeStrengthenPanel:GetGold2_UISprite()
    if self.mGold2SP == nil then
        self.mGold2SP = self:GetCurComp("WidgetRoot/view/BtnRoot/gold2/money", "UISprite")
    end
    return self.mGold2SP
end

---@return UILabel 货币数目
function UIForgeStrengthenPanel:GetGold2_UILabel()
    if self.mGold2Lb == nil then
        self.mGold2Lb = self:GetCurComp("WidgetRoot/view/BtnRoot/gold2/goldNum", "UILabel")
    end
    return self.mGold2Lb
end

---@return UnityEngine.GameObject Add
function UIForgeStrengthenPanel:GetGold2_AddGo()
    if self.mGold2AddGo == nil then
        self.mGold2AddGo = self:GetCurComp("WidgetRoot/view/BtnRoot/gold2/Add", "GameObject")
    end
    return self.mGold2AddGo
end
--endregion
--endregion

--region 初始化
function UIForgeStrengthenPanel:Init()
    self:BindUIEvents()
    self:BindMessage()
    UIForgeStrengthenPanel.InitData()
    UIForgeStrengthenPanel.RefreshServantButtonShow()
end

---@param customData.bagItemIfo bagV2.BagItemInfo
function UIForgeStrengthenPanel:Show(customData)
    --local openPanelType = LuaEnumStrengthenType.Role
    if customData then
        if customData.type == nil then
            customData.type = LuaEnumStrengthenType.Role
        elseif customData.type == LuaEnumStrengthenType.Role then
            if customData.bagItemInfo ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2:IsEquiped(customData.bagItemInfo) then
                customData.type = LuaEnumStrengthenType.YuanLing
            end
        end
        if customData.bagItemInfo then
            self.mNeedChooseBagItemInfo = customData.bagItemInfo
        elseif self:GetEquipInfoV2() then
            local bagItemInfo = gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():GetCanStrengthEquipItem()
            if bagItemInfo then
                self.mNeedChooseBagItemInfo = bagItemInfo
            end
        end
    end
    UIForgeStrengthenPanel.mCustomData = customData;
    UIForgeStrengthenPanel.mDelayShowUIRolePanel = 2;
    --self:SwitchToPanel(openPanelType)
    self:RefreshShowSuit()
end

function UIForgeStrengthenPanel:BindUIEvents()
    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetStrengthenButton_GameObject()).onClick = function(go)
        self:OnStrengthenButtonClicked(go)
    end
    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetSuitButton_GameObject()).onClick = function(go)
        self:OnSuitButtonClicked(go)
    end
    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetNormalResource_UILabel().gameObject).onClick = UIForgeStrengthenPanel.OnNormalResourceButtonClicked
    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetHelpBtn_GameObject()).onClick = UIForgeStrengthenPanel.OnHelpBtnClicked

    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetNormalResourceIcon_Sprite().gameObject).onClick = UIForgeStrengthenPanel.OnNormalResourceIconClicked

    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetRoleButton_GameObject()).onClick = UIForgeStrengthenPanel.OnRoleButtonClicked
    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetBagButton_GameObject()).onClick = UIForgeStrengthenPanel.OnBagButtonClicked
    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetServantButton_GameObject()).onClick = UIForgeStrengthenPanel.OnServantButtonClicked

    CS.UIEventListener.Get(self:GetItem_UIItem().gameObject).onClick = function()
        if (UIForgeStrengthenPanel.mBagItemInfo ~= nil) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self:GetCurrentChooseBagItemInfo(), showRight = false });
        end
    end

    CS.UIEventListener.Get(self:GetMatButton_GameObject()).onClick = function(go)
        self:OnMatClicked(go)
    end

    CS.UIEventListener.Get(self:GetCloseChoose_GameObject()).onClick = function(go)
        self:OnCloseChooseButtonClicked(go)
    end

    CS.UIEventListener.Get(UIForgeStrengthenPanel.GetCloseButton_GameObject().gameObject).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetGold2_UISprite().gameObject).onClick = function()
        local itemInfo = self.GetMineInfo(self:GetCurrentChooseCostId())
        if itemInfo then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
        end
    end
    CS.UIEventListener.Get(self:GetGold2_AddGo()) .onClick = function(go)
        Utility.ShowItemGetWay(self:GetCurrentChooseCostId(), go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
    end
    CS.UIEventListener.Get(self:GetGold1_AddGo()) .onClick = function(go)
        Utility.ShowItemGetWay(self:GetCurrentChooseCostId(), go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
    end
end

function UIForgeStrengthenPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResIntensifyMessage, UIForgeStrengthenPanel.OnResIntensifyMessageReceived)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GridSingleClicked, UIForgeStrengthenPanel.OnBagItemClicked)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, UIForgeStrengthenPanel.OnRoleItemClicked)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Servant_GridClicked, UIForgeStrengthenPanel.OnServantItemClicked)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UIForgeStrengthenPanel.OnBagButtonClicked)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_StrengthenMineNumChange, function()
        self:ResetCoinShow()
    end)
end
--endregion

--region初始化数据
---初始化数据
function UIForgeStrengthenPanel.InitData()
    UIForgeStrengthenPanel.strengthenIDList = CS.Cfg_GlobalTableManager.Instance:GetStrengthenID()
    UIForgeStrengthenPanel.mAllMineList = CS.Cfg_IntensifyTableManager.Instance:GetMineIdList()
    UIForgeStrengthenPanel.mMineIdToCostNum = CS.Cfg_IntensifyTableManager.Instance:GetMineIdToCostNum()
    UIForgeStrengthenPanel.mNeedLimitIdList = CS.Cfg_GlobalTableManager.Instance:GetNeedLimitId()
    UIForgeStrengthenPanel.mHasPlayerArriveLimit = UIForgeStrengthenPanel.GetPlayerLimitInfo()
    UIForgeStrengthenPanel.mSuitTableData = CS.Cfg_IntensifyTableManager.Instance.dic.Count
end

---获取PromptFrame表数据
function UIForgeStrengthenPanel.GetBubbleInfo(id)
    local res1, bubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
    if res1 then
        return bubbleInfo
    end
end

---获取限制点击信息
function UIForgeStrengthenPanel.GetPlayerLimitInfo()
    local isOpen = true
    local showInfo = ""
    local res2, limit2 = CS.Cfg_NoticeTableManager.Instance.dic:TryGetValue(21)
    if res2 and limit2.openCondition then
        local conditionId = limit2.openCondition.list
        UIForgeStrengthenPanel.mLimitShow = {}
        for i = 0, conditionId.Count - 1 do
            local res, conditionInfo = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(conditionId[i])
            if res then
                local info = string.gsub(conditionInfo.show, ' { 0 } ', tostring(conditionInfo.conditionParam.list[0]))
                local addInfo = ternary(i == 0, "", "并且")
                showInfo = showInfo .. addInfo .. info
            end
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId[i]) then
                isOpen = false
            end
        end
    end
    UIForgeStrengthenPanel.mLimitShow = showInfo
    return isOpen
end

---dic转table
function UIForgeStrengthenPanel.DicToTable(dic)
    local list = {}
    if UIForgeStrengthenPanel.mAllMineList then
        for i = 0, UIForgeStrengthenPanel.mAllMineList.Count - 1 do
            local itemId = UIForgeStrengthenPanel.mAllMineList[i]
            local res, info = dic:TryGetValue(itemId)
            if res then
                local mineInfo = {}
                mineInfo.itemId = itemId
                mineInfo.itemNum = info
                table.insert(list, mineInfo)
            end
        end
    end
    return list
end

---获取矿ItemInfo
function UIForgeStrengthenPanel.GetMineInfo(itemId)
    if UIForgeStrengthenPanel.mMineItemInfo == nil then
        UIForgeStrengthenPanel.mMineItemInfo = {}
    end
    if UIForgeStrengthenPanel.mMineItemInfo[itemId] == nil then
        local res, intensifyInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        if res then
            UIForgeStrengthenPanel.mMineItemInfo[itemId] = intensifyInfo
        end
    end
    return UIForgeStrengthenPanel.mMineItemInfo[itemId]
end

---设置模板选中
function UIForgeStrengthenPanel.ChooseItem(itemId, isChoose)
    local template = UIForgeStrengthenPanel.mItemIdToTemplate[itemId]
    if template then
        template:ChooseItem(isChoose)
    end
end

---显示当前选中矿信息
function UIForgeStrengthenPanel.ChooseMine(itemId)
    if itemId then
        UIForgeStrengthenPanel.curSelectItemID = itemId
        local itemInfo = UIForgeStrengthenPanel.GetMineInfo(itemId)
        if itemInfo then
            --name
            if not CS.StaticUtility.IsNull(UIForgeStrengthenPanel.GetItemName_UILabel()) then
                UIForgeStrengthenPanel.GetItemName_UILabel().text = itemInfo.name
            end
            --icon
            if not CS.StaticUtility.IsNull(UIForgeStrengthenPanel.GetNormalResourceIcon_Sprite()) then
                UIForgeStrengthenPanel.GetNormalResourceIcon_Sprite().spriteName = itemInfo.icon
            end
            if itemInfo.useParam.list.Count >= 2 then
                --纯度
                local name = itemInfo.name
                local str = string.sub(name, 1, #name - 3)
                UIForgeStrengthenPanel.GetPurity_UILabel().text = str .. "纯度" .. itemInfo.useParam.list[0]
                --成功率
                -- UIForgeStrengthenPanel.GetSuccessRate_UILabel().text = "[dde6eb]" .. math.ceil(itemInfo.useParam.list[1] / 100)
            end
            --消耗资源数目
            if UIForgeStrengthenPanel.bagMineDic and UIForgeStrengthenPanel.mMineIdToCostNum then
                local res, bagNum = UIForgeStrengthenPanel.bagMineDic:TryGetValue(itemId)
                local res2, costNum = UIForgeStrengthenPanel.mMineIdToCostNum:TryGetValue(itemId)
                if res2 then
                    if res then
                        UIForgeStrengthenPanel.mIsCanIntensify = bagNum >= costNum
                    else
                        UIForgeStrengthenPanel.mIsCanIntensify = false
                        bagNum = 0
                    end
                    local color = ternary(UIForgeStrengthenPanel.mIsCanIntensify, luaEnumColorType.Green, luaEnumColorType.White)
                    UIForgeStrengthenPanel.GetNormalResource_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(bagNum, costNum)
                end
            end
        end
    end
end
--endregion

--region 服务器消息
function UIForgeStrengthenPanel.OnResIntensifyMessageReceived()
    if UIForgeStrengthenPanel.mCurrentType == LuaEnumStrengthenType.Bag then
        local newBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems[UIForgeStrengthenPanel.mBagItemInfo.lid]
        UIForgeStrengthenPanel:StrengthenReturn(newBagItemInfo)
    elseif UIForgeStrengthenPanel.mCurrentType == LuaEnumStrengthenType.YuanLing then
        local newBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantEquip[UIForgeStrengthenPanel.mBagItemInfo.index]
        UIForgeStrengthenPanel:StrengthenReturn(newBagItemInfo)
    elseif UIForgeStrengthenPanel.mCurrentType == LuaEnumStrengthenType.Role then
        local newEquipItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo.Equips[UIForgeStrengthenPanel.mBagItemInfo.index]
        UIForgeStrengthenPanel:StrengthenReturn(newEquipItemInfo)
    end
end

---强化结果
function UIForgeStrengthenPanel:StrengthenReturn(newBagItemInfo)
    if newBagItemInfo then
        if newBagItemInfo.intensify > UIForgeStrengthenPanel.mBagItemInfo.intensify then
            UIForgeStrengthenPanel.ShowWinEffect()
            UIForgeStrengthenPanel.GetNextArributeEffect():PlayTween();
        else
            UIForgeStrengthenPanel.ShowLoseEffect()
        end
    end
    self:RefreshPanel(newBagItemInfo)
    self:RefreshShowSuit()
end
--endregion

--region 客户端消息
---点击背包物品
function UIForgeStrengthenPanel.OnBagItemClicked(MsgID, bagItemInfo)
    if bagItemInfo then
        if bagItemInfo.lid ~= UIForgeStrengthenPanel.mCurrentChooseBagItemId then
            UIForgeStrengthenPanel.mCurrentType = LuaEnumStrengthenType.Bag
            UIForgeStrengthenPanel:RefreshPanel(bagItemInfo)
        end
    end
end

---点击角色界面物品
function UIForgeStrengthenPanel.OnRoleItemClicked(MsgID, itemTemp)
    if itemTemp and itemTemp.bagItemInfo and itemTemp.bagItemInfo.lid ~= UIForgeStrengthenPanel.mCurrentChooseBagItemId then
        UIForgeStrengthenPanel.RefreshStateToRole(itemTemp.bagItemInfo)
    end
end

---刷新到角色界面状态
function UIForgeStrengthenPanel.RefreshStateToRole(bagItemInfo)
    UIForgeStrengthenPanel.mCurrentType = LuaEnumStrengthenType.Role
    UIForgeStrengthenPanel:RefreshPanel(bagItemInfo)
end

---点击元灵界面物品
function UIForgeStrengthenPanel.OnServantItemClicked(MsgID, bagItemInfo)
    if bagItemInfo then
        if bagItemInfo.lid ~= UIForgeStrengthenPanel.mCurrentChooseBagItemId then
            UIForgeStrengthenPanel.mCurrentType = LuaEnumStrengthenType.YuanLing
            UIForgeStrengthenPanel:RefreshPanel(bagItemInfo)
        end
    end
end
--endregion

--region 设置选中道具
---@return bagV2.BagItemInfo 获得当前选中的道具信息
function UIForgeStrengthenPanel:GetCurrentChooseBagItemInfo()
    return self.mBagItemInfo
end

---设置当前选中道具
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeStrengthenPanel:SetCurrentChooseBagItemInfo(bagItemInfo)
    self.mBagItemInfo = bagItemInfo
    if bagItemInfo then
        self.mCurrentChooseBagItemId = bagItemInfo.lid
        self:RefreshStars(bagItemInfo.intensify)

    end
    self:ResetCoinShow()

    self.GetMaxStarTips_GameObject():SetActive(self:IsStarFull())
    self:GetBtnRoot_GameObject():SetActive(not self:IsStarFull())
end
--endregion

--region  刷新货币
---重置货币显示
function UIForgeStrengthenPanel:ResetCoinShow()
    self:OnCloseChooseButtonClicked()
    ---@type table<number,StrengthMineInfo>
    local costList = self:GetCurrentIntensifyCostInfo()

    if costList then
        self.mCurrentCoinList = costList
        local costInfo
        if #costList == 1 then
            costInfo = costList[1]
        else
            costInfo = self:GetMatTypeCoin(costList)
        end
        self:SetCurrentChooseCoinAllData(costInfo)
        self:GetGold1_GO():SetActive(#costList > 1)
        self:GetGold2_GO():SetActive(#costList == 1)
        self:RefreshChooseList(costList)
    end

    local type = (costList == nil or #costList == 1) and 2 or 1
    self:RefreshCoinShow(type)
end

---@return table<number,StrengthMineInfo> 当前道具消耗货币id,消耗数目 字典
function UIForgeStrengthenPanel:GetCurrentIntensifyCostInfo()
    local intensify = 0
    if self:GetCurrentChooseBagItemInfo() then
        intensify = self:GetCurrentChooseBagItemInfo().intensify
    end
    local costList = self:GetIntensifyCost(intensify)
    return costList
end

---@class StrengthMineInfo
---@field itemId number 矿id
---@field costNum number 消耗矿数目
---@field rate number 成功率
---@field playerHas number 成功率

---@return table<number,StrengthMineInfo>获得强化星级对应的货币消耗
function UIForgeStrengthenPanel:GetIntensifyCost(intensify)
    local costList = {}
    local data = self:CacheIntensifyData(intensify)
    if data then
        local canStrengthList = data:GetConsume()
        if canStrengthList and canStrengthList.list and canStrengthList.list.Count > 0 then
            for i = 0, canStrengthList.list.Count - 1 do
                local tblList = canStrengthList.list[i].list
                if tblList and tblList.Count >= 3 then
                    ---@type  StrengthMineInfo
                    local costInfo = {}
                    costInfo.itemId = tblList[0]
                    costInfo.costNum = tblList[1]
                    costInfo.rate = math.ceil(tblList[2] / 100)
                    costInfo.playerHas = self:GetMinInfo(costInfo.itemId)
                    table.insert(costList, costInfo)
                end
            end
        end

    end
    return costList
end

---获得玩家拥有的矿数目
function UIForgeStrengthenPanel:GetMinInfo(mineId)
    local bagMinDic = self:GetBagInfoV2():GetStrengthenMinesIdDic()
    local res, num = bagMinDic:TryGetValue(mineId)
    if res then
        return num
    end
    return 0
end

---获取玩家有的道具类型
---@param costList table<number,StrengthMineInfo>
function UIForgeStrengthenPanel:GetMatTypeCoin(costList)
    if self.mCurrentChooseMatInfo then
        local playerHas = self:GetMinInfo(self.mCurrentChooseMatInfo.itemId)
        if playerHas >= self.mCurrentChooseMatInfo.costNum then
            self.mCurrentChooseMatInfo.playerHas = playerHas
            return self.mCurrentChooseMatInfo
        end
    end
    if costList then
        for i = 1, #costList do
            local singleInfo = costList[i]
            local mineNum = singleInfo.costNum
            local playerHas = singleInfo.playerHas
            if playerHas >= mineNum then
                self:SetPlayerHasMat(true)
                return singleInfo
            end
        end
        self:SetPlayerHasMat(false)
        return costList[1]
    end
end

---刷新选中列表
---@param costList table<number,StrengthMineInfo>
function UIForgeStrengthenPanel:RefreshChooseList(costList)
    self:GetGold1MatContainer().MaxCount = #costList
    for i = 0, self:GetGold1MatContainer().controlList.Count - 1 do
        local data = costList[i + 1]
        local go = self:GetGold1MatContainer().controlList[i]
        ---@type UIForgeStrengthenPanel_CostItemTemplate
        local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIForgeStrengthenPanel_CostItemTemplate)
        local itemId = data.itemId
        local itemInfo = self:CacheItemData(itemId)
        local needChoose = itemId == self:GetCurrentChooseCostId()
        template:RefreshGrid(data, itemInfo, needChoose)
        CS.UIEventListener.Get(go).onClick = function()
            self:SetCurrentChooseCoinAllData(data)
            self:RefreshCoinShow(self.mCurrentCoinShowType)
            self:OnMatClicked()
        end
    end
end

---货币变化
function UIForgeStrengthenPanel:CoinChange()

end

---刷新货币
function UIForgeStrengthenPanel:RefreshCoinShow(type)
    self:GetSuccessRate_UILabel().gameObject:SetActive(self:IsShowSuccessRate())
    if self:IsStarFull() then
        return
    end
    self.mCurrentCoinShowType = type
    if type == 1 then
        self:RefreshCoin1()
    else
        self:RefreshCoin2()
    end

end

---设置单条货币选中
---@param costInfo StrengthMineInfo
function UIForgeStrengthenPanel:SetCurrentChooseCoinAllData(costInfo)
    if costInfo then
        self:SetCurrentChooseCostId(costInfo.itemId)
        local costNum = self:GetCurrentChooseBagItemInfo() and costInfo.costNum or 0
        self:SetCurrentChooseCostNum(costNum)
        self:GetSuccessRate_UILabel().text = "[dde6eb]" .. costInfo.rate
        self.mCurrentChooseMatInfo = costInfo
    end
end

---@return StrengthMineInfo
function UIForgeStrengthenPanel:GetCurrentChooseCoinAllData()
    return self.mCurrentChooseMatInfo
end

---设置当前花费道具id
function UIForgeStrengthenPanel:SetCurrentChooseCostId(id)
    self.mCurrentChooseCostId = id
end

---获取当前花费道具id
function UIForgeStrengthenPanel:GetCurrentChooseCostId()
    return self.mCurrentChooseCostId
end

---设置当前选中道具花费
function UIForgeStrengthenPanel:SetCurrentChooseCostNum(num)
    self.mCurrentChooseCostNum = num
end

---获得当前选中道具花费
function UIForgeStrengthenPanel:GetCurrentChooseCostNum()
    return self.mCurrentChooseCostNum
end

--region 金币材料
---刷新当前货币显示
function UIForgeStrengthenPanel:RefreshCoin2()
    local coinId = self:GetCurrentChooseCostId()
    local coinInfo = self:CacheItemData(coinId)
    if coinInfo then
        self:GetGold2_UISprite().spriteName = coinInfo:GetIcon()
    end
    local playerHas = self:GetBagInfoV2():GetCoinAmount(coinId)
    local need = self:GetCurrentChooseCostNum()
    self.mCoinEnough = playerHas >= need
    self.mCoinEnoughPrompt = coinInfo:GetName() .. "不足"
    local color = self.mCoinEnough and luaEnumColorType.Green or luaEnumColorType.Red
    self:GetGold2_UILabel().text = color .. playerHas .. "[-]/" .. need
end
--endregion

--region 矿材料
---点击材料
function UIForgeStrengthenPanel:OnMatClicked(go)
    if self:GetCurrentMatOpen() then
        self:SetCurrentMatOpen(false)
    else
        if self:GetPlayerHasMat() then
            self:GetChooseScrollView_UIScrollView():ResetPosition()
            self:SetCurrentMatOpen(true)
        else
            Utility.ShowPopoTips(go, nil, 44, "UIForgeStrengthenPanel")
        end
    end
end

---关闭选项
function UIForgeStrengthenPanel:OnCloseChooseButtonClicked(go)
    self:SetCurrentMatOpen(false)
end

---@return boolean 当前材料是否开启
function UIForgeStrengthenPanel:GetCurrentMatOpen()
    if self.mMatOpen == nil then
        self.mMatOpen = false
    end
    return self.mMatOpen
end

---设置当前材料是否开启
function UIForgeStrengthenPanel:SetCurrentMatOpen(open)
    self:GetGold1Mat_GO():SetActive(open)
    self.mMatOpen = open
end

---设置玩家是否有材料
function UIForgeStrengthenPanel:SetPlayerHasMat(state)
    self.mPlayerHasMat = state
end

---判断玩家是否有材料
function UIForgeStrengthenPanel:GetPlayerHasMat()
    if self.mPlayerHasMat ~= nil then
        return self.mPlayerHasMat
    end
    return false
end

---刷新矿货币显示
function UIForgeStrengthenPanel:RefreshCoin1()
    if self:GetCurrentMatOpen() then

    end

    ---@type StrengthMineInfo
    local costInfo = self:GetCurrentChooseCoinAllData()
    if costInfo == nil then
        return
    end

    local coinId = costInfo.itemId
    local coinInfo = self:CacheItemData(coinId)
    if coinInfo then
        self:GetGold1_UISprite().spriteName = coinInfo:GetIcon()
    end
    local playerHas = costInfo.playerHas
    local need = costInfo.costNum
    self.mCoinEnough = playerHas >= need
    self.mCoinEnoughPrompt = coinInfo:GetName() .. "不足"
    local color = self.mCoinEnough and luaEnumColorType.Green or luaEnumColorType.Red
    self:GetGold1_UILabel().text = color .. playerHas .. "[-]/" .. need
    local name = coinInfo:GetName()
    local str = string.sub(name, 1, #name - 3)
    if coinInfo:GetUseParam() and coinInfo:GetUseParam().list and coinInfo:GetUseParam().list.Count > 0 then
        self:GetPurity_UILabel().text = str .. "纯度" .. coinInfo:GetUseParam().list[0]
    end
end

---刷新资源显示
function UIForgeStrengthenPanel.RefreshCost()
    UIForgeStrengthenPanel.bagMineDic = CS.CSScene.MainPlayerInfo.BagInfo:GetStrengthenMinesIdDic()
    local showInfo = UIForgeStrengthenPanel.DicToTable(UIForgeStrengthenPanel.bagMineDic)
    if #showInfo > 0 then
        UIForgeStrengthenPanel.RefreshMineInfo(showInfo)
        local mineId = UIForgeStrengthenPanel.mCurrentChooseCostId
        if not UIForgeStrengthenPanel.bagMineDic:TryGetValue(mineId) then
            mineId = showInfo[1].itemId
            UIForgeStrengthenPanel.mCurrentChooseCostId = mineId
        end
        UIForgeStrengthenPanel.ChooseMine(mineId)
        UIForgeStrengthenPanel.ChooseItem(mineId, true)
    else
        if UIForgeStrengthenPanel.mAllMineList then
            UIForgeStrengthenPanel.mCurrentChooseCostId = UIForgeStrengthenPanel.mAllMineList[0]
            UIForgeStrengthenPanel.ChooseMine(UIForgeStrengthenPanel.mAllMineList[0])
        end
    end
end




--endregion

---@return boolean 是否显示成功率
function UIForgeStrengthenPanel:IsShowSuccessRate()
    if self:GetCurrentChooseBagItemInfo() then
        return not self:IsStarFull()
    end
    return false
end

---@return boolean 星级是否满
function UIForgeStrengthenPanel:IsStarFull()
    if self:GetCurrentChooseBagItemInfo() then
        local intensify = self:GetCurrentChooseBagItemInfo().intensify
        local tblData = self:CacheIntensifyData(intensify)
        if tblData and tblData:GetConsume() == nil then
            return true
        end
    end
    return false
end
--endregion

--region 刷新星星显示
function UIForgeStrengthenPanel:RefreshStars(intensify)
    local firstData = Utility.GetIntensifyColor(1)
    local singleData = Utility.GetIntensifyColor(intensify)

    local maxStar = firstData.max
    local index = intensify % maxStar
    local showLb = "升星"
    if intensify > 0 and index == 0 then
        index = maxStar
        showLb = "突破"
    end
    self:GetStrengthenButton_UILabel().text = showLb
    local container = UIForgeStrengthenPanel.GetIntensityStarLineOneFrame_GridContainer()
    if CS.StaticUtility.IsNull(container) == false then
        container.MaxCount = maxStar
        for i = 0, container.controlList.Count - 1 do
            local gp = container.controlList[i]
            local sp = CS.Utility_Lua.GetComponent(gp, "UISprite")
            if not CS.StaticUtility.IsNull(sp) then
                if singleData then
                    if i + 1 > index then
                        sp .spriteName = singleData.floorIcon
                    else
                        sp.spriteName = singleData.icon
                    end
                end
            end
        end
    end
end
--endregion

--region 角色
---切换到角色状态
function UIForgeStrengthenPanel.SwitchToRolePanel()
    UIForgeStrengthenPanel.HideOtherPanel(LuaEnumStrengthenType.Role)
    if UIForgeStrengthenPanel.mRolePanel == nil or CS.StaticUtility.IsNull(UIForgeStrengthenPanel.mRolePanel.go) then
        local roleData = {}
        roleData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateStrengthen
        roleData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateStrength
        local panelNameExist = false
        for i = 1, #UIForgeStrengthenPanel.mOpeningPanel do
            if UIForgeStrengthenPanel.mOpeningPanel[i] == "UIRolePanel" then
                panelNameExist = true
                break
            end
        end
        if panelNameExist == false then
            table.insert(UIForgeStrengthenPanel.mOpeningPanel, "UIRolePanel")
        end
        uimanager:ClosePanel("UIBagPanel")
        uimanager:CreatePanel("UIRolePanel", UIForgeStrengthenPanel.CreateRollPanelCallBack, roleData)
    else
        uimanager:ReShowPanel(UIForgeStrengthenPanel.mRolePanel)
    end
end

---角色界面创建完成回调
function UIForgeStrengthenPanel.CreateRollPanelCallBack(panel)
    if UIForgeStrengthenPanel == nil or UIForgeStrengthenPanel.go == nil or CS.StaticUtility.IsNull(UIForgeStrengthenPanel.go) then
        return
    end
    panel:SetSLToggle(false)
    UIForgeStrengthenPanel.mRolePanel = panel
    panel:ShowCloseButton(false)
    table.insert(UIForgeStrengthenPanel.mOpenPanel, panel)
    if panel ~= nil then
        for i = 1, #UIForgeStrengthenPanel.mOpeningPanel do
            if UIForgeStrengthenPanel.mOpeningPanel[i] == panel._PanelName then
                table.remove(UIForgeStrengthenPanel.mOpeningPanel, i)
                break
            end
        end
    end
    UIForgeStrengthenPanel.RefreshStateToRole(UIForgeStrengthenPanel.mNeedChooseBagItemInfo)
end
--endregion

--region 背包
---切换到背包状态
function UIForgeStrengthenPanel.SwitchToBagPanel()
    UIForgeStrengthenPanel.HideOtherPanel(LuaEnumStrengthenType.Bag)
    if UIForgeStrengthenPanel.mBagPanel == nil or CS.StaticUtility.IsNull(UIForgeStrengthenPanel.mBagPanel.go) then
        local panelNameExist = false
        for i = 1, #UIForgeStrengthenPanel.mOpeningPanel do
            if UIForgeStrengthenPanel.mOpeningPanel[i] == "UIBagPanel" then
                panelNameExist = true
                break
            end
        end
        if panelNameExist == false then
            table.insert(UIForgeStrengthenPanel.mOpeningPanel, "UIBagPanel")
        end
        if UIForgeStrengthenPanel.mNeedChooseBagItemInfo then
            uimanager:CreatePanel("UIBagPanel", UIForgeStrengthenPanel.CreateBagPanelCallBack, { type = LuaEnumBagType.Strength, focusedBagItemInfo = UIForgeStrengthenPanel.mNeedChooseBagItemInfo })
        else
            uimanager:CreatePanel("UIBagPanel", UIForgeStrengthenPanel.CreateBagPanelCallBack, { type = LuaEnumBagType.Strength })
        end
    else
        uimanager:ReShowPanel(UIForgeStrengthenPanel.mBagPanel)
        UIForgeStrengthenPanel.OnBagItemClicked(LuaCEvent.Bag_GirdPressed, UIForgeStrengthenPanel.mBagItemInfo)
    end
end

---创建背包界面回调
function UIForgeStrengthenPanel.CreateBagPanelCallBack(panel)
    UIForgeStrengthenPanel.OnBagItemClicked(LuaCEvent.Bag_GirdPressed, UIForgeStrengthenPanel.mNeedChooseBagItemInfo)
    UIForgeStrengthenPanel.mBagPanel = panel
    table.insert(UIForgeStrengthenPanel.mOpenPanel, panel)
    if panel ~= nil then
        for i = 1, #UIForgeStrengthenPanel.mOpeningPanel do
            if UIForgeStrengthenPanel.mOpeningPanel[i] == panel._PanelName then
                table.remove(UIForgeStrengthenPanel.mOpeningPanel, i)
                break
            end
        end
    end
end
--endregion

--region 灵兽
---切换到灵兽状态
function UIForgeStrengthenPanel.SwitchToServantPanel()
    UIForgeStrengthenPanel.HideOtherPanel(LuaEnumStrengthenType.YuanLing)
    if UIForgeStrengthenPanel.mServantPanel == nil or CS.StaticUtility.IsNull(UIForgeStrengthenPanel.mServantPanel.go) then
        local servantData = {}
        servantData.topOpenType = LuaEnumServantPanelType.BasePanel
        servantData.openServantPanelType = LuaEnumPanelOpenSourceType.ByStrengthenPanel
        servantData.BaseTemplate = luaComponentTemplates.UIForgeStrengthPanel_ServantBase
        servantData.ServantHead = luaComponentTemplates.UIForgeTransferPanel_ServantHead
        servantData.pos = UIForgeStrengthenPanel.GetServantOpenPos()
        local panelNameExist = false
        for i = 1, #UIForgeStrengthenPanel.mOpeningPanel do
            if UIForgeStrengthenPanel.mOpeningPanel[i] == "UIServantPanel" then
                panelNameExist = true
                break
            end
        end
        if panelNameExist == false then
            table.insert(UIForgeStrengthenPanel.mOpeningPanel, "UIServantPanel")
        end
        uimanager:CreatePanel("UIServantPanel", UIForgeStrengthenPanel.CreateServantPanelCallBack, servantData)
    else
        uimanager:ReShowPanel(UIForgeStrengthenPanel.mServantPanel)
    end
end

---创建灵兽界面回调
function UIForgeStrengthenPanel.CreateServantPanelCallBack(panel)
    UIForgeStrengthenPanel.mServantPanel = panel
    panel:ShowOtherButton(false)
    table.insert(UIForgeStrengthenPanel.mOpenPanel, panel)
    if panel ~= nil then
        for i = 1, #UIForgeStrengthenPanel.mOpeningPanel do
            if UIForgeStrengthenPanel.mOpeningPanel[i] == panel._PanelName then
                table.remove(UIForgeStrengthenPanel.mOpeningPanel, i)
                break
            end
        end
    end
    UIForgeStrengthenPanel.mNeedDelayToChooseServantPanelEquip = 6
end

---选中灵兽界面装备
function UIForgeStrengthenPanel.ChooseServantPanelEquip()
    if UIForgeStrengthenPanel.mNeedChooseBagItemInfo and UIForgeStrengthenPanel.mServantPanel and UIForgeStrengthenPanel.mServantPanel.SetStrengthItemChoose then
        UIForgeStrengthenPanel.mServantPanel.SetStrengthItemChoose(UIForgeStrengthenPanel.mNeedChooseBagItemInfo.lid)
    end
end

---获取灵兽打开页面
function UIForgeStrengthenPanel.GetServantOpenPos()
    local pos = 0
    if UIForgeStrengthenPanel.mNeedChooseBagItemInfo then
        pos = math.floor(UIForgeStrengthenPanel.mNeedChooseBagItemInfo .index / 1000 - 1)
    end
    return pos
end
--endregion

--region UI事件
---點擊角色按鈕
function UIForgeStrengthenPanel.OnRoleButtonClicked()
    UIForgeStrengthenPanel:SwitchToPanel(LuaEnumStrengthenType.Role)
end

---點擊背包按鈕
function UIForgeStrengthenPanel.OnBagButtonClicked()
    UIForgeStrengthenPanel:SwitchToPanel(LuaEnumStrengthenType.Bag)
end

---點擊靈獸按鈕
function UIForgeStrengthenPanel.OnServantButtonClicked()
    UIForgeStrengthenPanel:SwitchToPanel(LuaEnumStrengthenType.YuanLing)
end

function update()

    if (UIForgeStrengthenPanel.mDelayShowUIRolePanel ~= nil) then
        UIForgeStrengthenPanel.mDelayShowUIRolePanel = UIForgeStrengthenPanel.mDelayShowUIRolePanel - 1
        if UIForgeStrengthenPanel.mDelayShowUIRolePanel == 0 then
            UIForgeStrengthenPanel.mDelayShowUIRolePanel = nil
            local openPanelType = UIForgeStrengthenPanel.mCustomData.type;
            UIForgeStrengthenPanel:SwitchToPanel(openPanelType);
        end
    elseif UIForgeStrengthenPanel.mNeedDelayToChooseServantPanelEquip ~= nil then
        UIForgeStrengthenPanel.mNeedDelayToChooseServantPanelEquip = UIForgeStrengthenPanel.mNeedDelayToChooseServantPanelEquip - 1
        if UIForgeStrengthenPanel.mNeedDelayToChooseServantPanelEquip == 0 then
            UIForgeStrengthenPanel.mNeedDelayToChooseServantPanelEquip = nil
            UIForgeStrengthenPanel.ChooseServantPanelEquip()
        end
    end
end

---切換到指定界面
function UIForgeStrengthenPanel:SwitchToPanel(type)
    if type == LuaEnumStrengthenType.Role then
        UIForgeStrengthenPanel.SwitchToRolePanel()
    elseif type == LuaEnumStrengthenType.Bag then
        UIForgeStrengthenPanel.SwitchToBagPanel()
    elseif type == LuaEnumStrengthenType.YuanLing then
        UIForgeStrengthenPanel.SwitchToServantPanel()
    end
    UIForgeStrengthenPanel.GetBagButtonChoose_GameObject():SetActive(type == LuaEnumStrengthenType.Bag)
    UIForgeStrengthenPanel.GetServantButtonChoose_GameObject():SetActive(type == LuaEnumStrengthenType.YuanLing)
    UIForgeStrengthenPanel.GetRoleButtonChoose_GameObject():SetActive(type == LuaEnumStrengthenType.Role)

end

---隐藏其他界面
function UIForgeStrengthenPanel.HideOtherPanel(type)
    if UIForgeStrengthenPanel.mRolePanel and type ~= LuaEnumStrengthenType.Role then
        uimanager:HidePanel(UIForgeStrengthenPanel.mRolePanel)
    end
    if UIForgeStrengthenPanel.mServantPanel and type ~= LuaEnumStrengthenType.YuanLing then
        uimanager:HidePanel(UIForgeStrengthenPanel.mServantPanel)
    end
    if UIForgeStrengthenPanel.mBagPanel and type ~= LuaEnumStrengthenType.Bag then
        uimanager:HidePanel(UIForgeStrengthenPanel.mBagPanel)
    end
end

---点击资源
function UIForgeStrengthenPanel.OnNormalResourceButtonClicked()
    local itemInfo = UIForgeStrengthenPanel.GetMineInfo(UIForgeStrengthenPanel.mCurrentChooseCostId)
    if itemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
    end
end

---点击帮助按钮
function UIForgeStrengthenPanel.OnHelpBtnClicked()
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(35)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---刷新UI面板
---@param bagItemInfo bagV2.BagItemInfo 强化物品信息
function UIForgeStrengthenPanel:RefreshPanel(bagItemInfo)
    self:SetCurrentChooseBagItemInfo(bagItemInfo)
    local noData = bagItemInfo == nil or bagItemInfo.intensify == nil
    self:GetStrengthLb().gameObject:SetActive(not noData)
    self:GetStrengthStar_UISprite().gameObject:SetActive(not noData)
    if noData then
        self:GetItem_UIItem().gameObject:SetActive(false)
        return
    end
    local str, icon = Utility.GetIntensifyShow(bagItemInfo.intensify)
    self:GetStrengthLb().text = str
    self:GetStrengthStar_UISprite().spriteName = icon
    luaEventManager.DoCallback(LuaCEvent.StrengthenBagItemChange, UIForgeStrengthenPanel.mBagItemInfo)
    ---被强化装备信息
    local res1, ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
    if res1 then
        --icon
        self:GetItem_UIItem().gameObject:SetActive(true)
        self:GetItem_UIItem().spriteName = ItemInfo.icon
    end
    local res2, intensifyInfo = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(bagItemInfo.intensify)
    local res3, nextLevelIntensifyInfo = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(bagItemInfo.intensify + 1)
    if res2 then
        ---属性变化
        UIForgeStrengthenPanel.GetCurAttribute_UILabel().text = "[dde6eb]" .. intensifyInfo.attAdd
        if res3 and bagItemInfo.intensify < ItemInfo.star then
            UIForgeStrengthenPanel.GetNextAttribute_UILabel().text = "[00ff00]" .. nextLevelIntensifyInfo.attAdd
            UIForgeStrengthenPanel.GetNextAttributeEffect_UILabel().text = nextLevelIntensifyInfo.attAdd
        else
            UIForgeStrengthenPanel.GetNextAttribute_UILabel().text = ""
        end
        UIForgeStrengthenPanel:GetAttributeChangeArrow().spriteName = ternary(res3 and bagItemInfo.intensify < ItemInfo.star and nextLevelIntensifyInfo.attAdd > nextLevelIntensifyInfo.attAdd, "arrow", "arrow3")
    end
    self:RefreshShowAttributeLabel(bagItemInfo)
end

---刷新显示属性文本
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeStrengthenPanel:RefreshShowAttributeLabel(bagItemInfo)
    local res, ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
    if res then
        local Career = self:GetMainPlayerInfo().Career
        self:GetUpAttributeName_UILabel().text = self:GetShowInfo(ItemInfo, Career)
    end
end

---获取属性显示
function UIForgeStrengthenPanel:GetShowInfo(ItemInfo, Career)
    if Career == CS.ECareer.Warrior then
        if (ItemInfo.phyAttackMax and ItemInfo.phyAttackMax ~= 0) or (ItemInfo.phyAttackMin and ItemInfo.phyAttackMin ~= 0) then
            return "攻击"
        elseif (ItemInfo.magicAttackMax and ItemInfo.magicAttackMax ~= 0) or (ItemInfo.magicAttackMin and ItemInfo.magicAttackMin ~= 0) then
            return "魔法"
        elseif (ItemInfo.taoAttackMax and ItemInfo.taoAttackMax ~= 0) or (ItemInfo.taoAttackMin and ItemInfo.taoAttackMin ~= 0) then
            return "道术"
        end
    elseif Career == CS.ECareer.Master then
        if (ItemInfo.magicAttackMax and ItemInfo.magicAttackMax ~= 0) or (ItemInfo.magicAttackMin and ItemInfo.magicAttackMin ~= 0) then
            return "魔法"
        elseif (ItemInfo.phyAttackMax and ItemInfo.phyAttackMax ~= 0) or (ItemInfo.phyAttackMin and ItemInfo.phyAttackMin ~= 0) then
            return "攻击"
        elseif (ItemInfo.taoAttackMax and ItemInfo.taoAttackMax ~= 0) or (ItemInfo.taoAttackMin and ItemInfo.taoAttackMin ~= 0) then
            return "道术"
        end
    elseif Career == CS.ECareer.Taoist then
        if (ItemInfo.taoAttackMax and ItemInfo.taoAttackMax ~= 0) or (ItemInfo.taoAttackMin and ItemInfo.taoAttackMin ~= 0) then
            return "道术"
        elseif (ItemInfo.phyAttackMax and ItemInfo.phyAttackMax ~= 0) or (ItemInfo.phyAttackMin and ItemInfo.phyAttackMin ~= 0) then
            return "攻击"
        elseif (ItemInfo.magicAttackMax and ItemInfo.magicAttackMax ~= 0) or (ItemInfo.magicAttackMin and ItemInfo.magicAttackMin ~= 0) then
            return "魔法"
        end
    end
end

---显示底部描述
function UIForgeStrengthenPanel.ShowDescription()
    if UIForgeStrengthenPanel.mBagItemInfo == nil then
        return
    end
    local intensify = UIForgeStrengthenPanel.mBagItemInfo.intensify
    if intensify < UIForgeStrengthenPanel.mMaxStar then
        UIForgeStrengthenPanel.GetDescription_UILabel().gameObject:SetActive(true)
    else
        UIForgeStrengthenPanel.GetDescription_UILabel().gameObject:SetActive(false)
    end
    if intensify == 5 or intensify == 10 or intensify == 15 then
        UIForgeStrengthenPanel.GetDescription_UILabel().text = "[878787]您已达到" .. intensify .. "星,失败不会降星"
    elseif intensify < 5 then
        UIForgeStrengthenPanel.GetDescription_UILabel().text = "[878787]升到5星,失败不会降星"
    elseif intensify < 10 then
        UIForgeStrengthenPanel.GetDescription_UILabel().text = "[878787]升到10星,失败不会降星"
    elseif intensify < UIForgeStrengthenPanel.mMaxStar then
        UIForgeStrengthenPanel.GetDescription_UILabel().text = "[878787]升到" .. UIForgeStrengthenPanel.mMaxStar .. "星,失败不会降星"
    end
end

---点击道具信息
function UIForgeStrengthenPanel.OnNormalResourceIconClicked()
    if UIForgeStrengthenPanel.mCurrentChooseCostId then
        local info = UIForgeStrengthenPanel.GetMineInfo(UIForgeStrengthenPanel.mCurrentChooseCostId)
        if info then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info })
        end
    end
end

---判断灵兽页签是否开启
function UIForgeStrengthenPanel.RefreshServantButtonShow()
    local isShowServantButton = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsOpenServantStrength()
    if not CS.StaticUtility.IsNull(UIForgeStrengthenPanel.GetServantButton_GameObject()) then
        UIForgeStrengthenPanel.GetServantButton_GameObject():SetActive(isShowServantButton)
    end
end

---@return TABLE.CFG_ITEMS 获Item表数据
function UIForgeStrengthenPanel:GetItemDataCache(id)
    if self.mItemIdToData == nil then
        self.mItemIdToData = {}
    end
    local data = self.mItemIdToData[id]
    if data == nil then
        data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToData[id] = data
    end
    return data
end
--endregion

--region 特效
---显示成功特效
function UIForgeStrengthenPanel.ShowWinEffect()
    if UIForgeStrengthenPanel.mWinEffect == nil then
        if not CS.StaticUtility.IsNull(UIForgeStrengthenPanel.GetEffectRoot_GameObject()) then
            CS.CSResourceManager.Singleton:AddQueueCannotDelete("700008", CS.ResourceType.UIEffect, function(res)
                if res ~= nil then
                    if CS.StaticUtility.IsNull(UIForgeStrengthenPanel.GetEffectRoot_GameObject()) then
                        return
                    end
                    UIForgeStrengthenPanel.winEffectPool = res:GetUIPoolItem()
                    if UIForgeStrengthenPanel.winEffectPool == nil then
                        return
                    end
                    UIForgeStrengthenPanel.mWinEffect = UIForgeStrengthenPanel.winEffectPool.go
                    if UIForgeStrengthenPanel.mWinEffect then
                        UIForgeStrengthenPanel.mWinEffect.transform.parent = UIForgeStrengthenPanel.GetEffectRoot_GameObject().transform
                        UIForgeStrengthenPanel.mWinEffect.transform.localPosition = CS.UnityEngine.Vector3.zero
                        UIForgeStrengthenPanel.mWinEffect.transform.localScale = CS.UnityEngine.Vector3(125, 125, 125)
                        UIForgeStrengthenPanel.mWinEffect:SetActive(true)
                    end
                end
            end
            , CS.ResourceAssistType.UI)
        end
    else
        UIForgeStrengthenPanel.mWinEffect:SetActive(false)
        UIForgeStrengthenPanel.mWinEffect:SetActive(true)
    end
end

---显示失败特效
function UIForgeStrengthenPanel.ShowLoseEffect()
    if UIForgeStrengthenPanel.mFailEffect == nil then
        if not CS.StaticUtility.IsNull(UIForgeStrengthenPanel.GetEffectRoot_GameObject()) then
            CS.CSResourceManager.Singleton:AddQueueCannotDelete("700009", CS.ResourceType.UIEffect, function(res)
                if res ~= nil then
                    if CS.StaticUtility.IsNull(UIForgeStrengthenPanel.GetEffectRoot_GameObject()) then
                        return
                    end
                    UIForgeStrengthenPanel.winEffectPool = res:GetUIPoolItem()
                    if UIForgeStrengthenPanel.winEffectPool == nil then
                        return
                    end
                    UIForgeStrengthenPanel.mFailEffect = UIForgeStrengthenPanel.winEffectPool.go
                    if UIForgeStrengthenPanel.mFailEffect then
                        UIForgeStrengthenPanel.mFailEffect.transform.parent = UIForgeStrengthenPanel.GetEffectRoot_GameObject().transform
                        UIForgeStrengthenPanel.mFailEffect.transform.localPosition = CS.UnityEngine.Vector3.zero
                        UIForgeStrengthenPanel.mFailEffect.transform.localScale = CS.UnityEngine.Vector3(125, 125, 125)
                        UIForgeStrengthenPanel.mFailEffect:SetActive(true)
                    end
                end
            end
            , CS.ResourceAssistType.UI)
        end
    else
        UIForgeStrengthenPanel.mFailEffect:SetActive(false)
        UIForgeStrengthenPanel.mFailEffect:SetActive(true)
    end
end
--endregion

--region  套装
---设置套装显示
function UIForgeStrengthenPanel:RefreshShowSuit()
    if self:GetEquipInfoV2() then
        local suitLevel = self:GetEquipInfoV2():GetSuitLevel()--套装等级
        self.mCurrentSuitLevel = suitLevel
        local showLevel = self.mCurrentSuitLevel
        local suitNum = self:GetEquipInfoV2():GetSuitNum(suitLevel)--该等级套装有几件
        local star = "套装"
        --tostring(self.SuitStar[showLevel])
        local num = "(" .. suitNum .. "/" .. self:GetSuitLimitNum() .. ")"
        self:GetSuitButtonLabel_UILabel().text = star
        -- self:GetSuitButtonNumLabel_UILabel().text = num
    end
end

---@return number 当前套装等级
function UIForgeStrengthenPanel:GetCurrentSuitLevel()

end

---获取当前套装与下级套装信息
function UIForgeStrengthenPanel.GetCurrentLevel(level)
    local isGetSuit = true
    local num = 0
    while isGetSuit do
        local suitAttack = CS.Cfg_IntensifyTableManager.Instance:GetSuitAttackByStar(level)
        if suitAttack > 0 then
            isGetSuit = false
            UIForgeStrengthenPanel.mCurrentSuitAttack = suitAttack
            break
        end
        level = level + 1
        num = num + 1
        if num > UIForgeStrengthenPanel.mSuitTableData then
            break
        end
    end

    UIForgeStrengthenPanel.mCurrentSuitLevel = level
    local nextLevel = level + 1
    local isGetNextSuit = true
    while isGetNextSuit do
        if nextLevel >= UIForgeStrengthenPanel.mSuitTableData then
            isGetNextSuit = false
            break
        end
        local res, attackInfo = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(nextLevel)
        if res then
            if attackInfo.attTao > UIForgeStrengthenPanel.mCurrentSuitAttack then
                UIForgeStrengthenPanel.mNextSuitAttack = attackInfo.attTao
                isGetNextSuit = false
                break
            end
        end
        nextLevel = nextLevel + 1
    end
    UIForgeStrengthenPanel.mNextSuitLevel = nextLevel
end

---获取套装数据
function UIForgeStrengthenPanel:GetSuitData()
    local mSuitData = {}
    if self.mCurrentSuitLevel and self.mSuitTableData and self:GetEquipInfoV2() then
        if self.mNextSuitLevel < self.mSuitTableData then
            local color = "[878787]"
            mSuitData.NextAttack = color .. "+" .. UIForgeStrengthenPanel.mNextSuitAttack
            mSuitData.NextShow, mSuitData.NextNum = UIForgeStrengthenPanel:GetShowData(UIForgeStrengthenPanel.mNextSuitLevel, color)
        else
            mSuitData.NextShow = nil
        end
        local suitNum = self:GetEquipInfoV2():GetSuitNum(self.mCurrentSuitLevel)
        local color = ternary(suitNum >= self:GetSuitLimitNum(), "[00ff00]", "[878787]")
        mSuitData.CurrentAttack = color .. "+" .. self.mCurrentSuitAttack
        mSuitData.CurrentShow, mSuitData.CurrentNum = self:GetShowData(self.mCurrentSuitLevel, color)
        self.mArriveNextSuitLevel = ternary(suitNum >= self:GetSuitLimitNum(), self.mNextSuitLevel, self.mCurrentSuitLevel)
    end
    local limitNum = self.mNeedLimitIdList.Length
    mSuitData.ShowNum = ternary(self.mHasPlayerArriveLimit, limitNum + self:GetSuitLimitNum(), self:GetSuitLimitNum())
    mSuitData.CurrentLevel = self.mArriveNextSuitLevel
    return mSuitData
end

---获取显示信息
function UIForgeStrengthenPanel:GetShowData(num, colorNormal)
    local star = tostring(self.SuitStar[num])
    local show = colorNormal .. star .. "套装效果"
    local suitNum = 0
    if self:GetEquipInfoV2() then
        suitNum = self:GetEquipInfoV2():GetSuitNum(num)
    end
    local des = colorNormal .. self:GetSuitLimitNum() .. "件装备星级+" .. num .. "(" .. suitNum .. "/" .. self:GetSuitLimitNum() .. ")"
    return show, des
end

---点击套装
function UIForgeStrengthenPanel:OnSuitButtonClicked()
    self.mHasPlayerArriveLimit = UIForgeStrengthenPanel.GetPlayerLimitInfo()
    local limitNum = self.mNeedLimitIdList.Length
    local ShowNum = ternary(self.mHasPlayerArriveLimit, limitNum + self:GetSuitLimitNum(), self:GetSuitLimitNum())
    uimanager:CreatePanel("UISuitAttributePanel", nil, self.mCurrentSuitLevel, ShowNum)
end
--endregion

--region 强化

---强化
function UIForgeStrengthenPanel:OnStrengthenButtonClicked(go)
    local chooseBagItemInfo = self:GetCurrentChooseBagItemInfo()
    if chooseBagItemInfo == nil then
        Utility.ShowPopoTips(go, nil, 43)
        return
    end

    if not self.mCoinEnough then
        Utility.ShowPopoTips(go, self.mCoinEnoughPrompt, 39)
        return
    end

    if UIForgeStrengthenPanel.mCurrentType == LuaEnumStrengthenType.Bag then
        networkRequest.ReqIntensify(chooseBagItemInfo.lid, self:GetCurrentChooseCostId())
    elseif UIForgeStrengthenPanel.mCurrentType == LuaEnumStrengthenType.YuanLing then
        networkRequest.ReqIntensify(chooseBagItemInfo.index * (-1), self:GetCurrentChooseCostId())
    elseif UIForgeStrengthenPanel.mCurrentType == LuaEnumStrengthenType.Role then
        networkRequest.ReqIntensify(chooseBagItemInfo.index * (-1), self:GetCurrentChooseCostId())
    end
end
--endregion

--region  缓存表数据
---@return TABLE.cfg_intensify
function UIForgeStrengthenPanel:CacheIntensifyData(intensify)
    if intensify == nil then
        return
    end
    if self.mIntensifyToTblInfo == nil then
        self.mIntensifyToTblInfo = {}
    end
    local data = self.mIntensifyToTblInfo[intensify]
    if data == nil then
        data = clientTableManager.cfg_intensifyManager:TryGetValue(intensify)
        self.mIntensifyToTblInfo[intensify] = data
        self.mIntensifyToTblInfo[intensify] = data
    end
    return data
end

---@return TABLE.cfg_items
function UIForgeStrengthenPanel:CacheItemData(id)
    if id == nil then
        return
    end

    if self.mItemIdToTblInfo == nil then
        self.mItemIdToTblInfo = {}
    end
    local data = self.mItemIdToTblInfo[id]
    if data == nil then
        data = clientTableManager.cfg_itemsManager:TryGetValue(id)
        self.mItemIdToTblInfo[id] = data
    end
    return data
end

--endregion

--region onDestroy
function ondestroy()
    for i = 1, #UIForgeStrengthenPanel.mOpenPanel do
        local panel = UIForgeStrengthenPanel.mOpenPanel[i]
        if panel and CS.StaticUtility.IsNull(panel.go) == false then
            uimanager:ClosePanel(panel)
        end
    end
    for i = 1, #UIForgeStrengthenPanel.mOpeningPanel do
        local panelName = UIForgeStrengthenPanel.mOpeningPanel[i]
        uimanager:ClosePanel(panelName)
    end
    UIForgeStrengthenPanel.mOpeningPanel = {}
end
--endregion

return UIForgeStrengthenPanel