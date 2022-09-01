---Vip面板
---@class UIRechargePanel:UIBase
local UIRechargePanel = {}
local CenterOnChild = nil

UIRechargePanel.mToggleName = {
    [LuaEnumRechargeType.Reward] = "领奖", --
    [LuaEnumRechargeType.ContinueRecharge] = "连充", --
    [LuaEnumRechargeType.LastRecharge] = "终身限购",
    [LuaEnumRechargeType.NormalRecharge] = "充值",
    --[LuaEnumRechargeType.VIP] = "VIP",
    --[LuaEnumRechargeType.Card] = "月卡",
    --[LuaEnumRechargeType.Investment1] = "第1日",
    --[LuaEnumRechargeType.Investment2] = "第2日",
    [LuaEnumRechargeType.AccumulatedRecharge] = "累计充值",
    --[LuaEnumRechargeType.PotentialInvest] = "潜能投资",
    --[LuaEnumRechargeType.PreferenceGift] = "特惠礼包",
}

UIRechargePanel.mOpenSort = {
    LuaEnumRechargeType.Reward,
    LuaEnumRechargeType.ContinueRecharge,
    LuaEnumRechargeType.LastRecharge,
    --LuaEnumRechargeType.PotentialInvest,
    LuaEnumRechargeType.NormalRecharge,
    --LuaEnumRechargeType.Investment1,
    --LuaEnumRechargeType.Investment2,
    LuaEnumRechargeType.AccumulatedRecharge,
    --LuaEnumRechargeType.PreferenceGift,
}

---指向当前对象
---是否显示箭头
UIRechargePanel.NeedShowArrow = false
UIRechargePanel.TotalRechargeAmount = 0
UIRechargePanel.FirstRechargeGiftBoxList = { }
UIRechargePanel.mNeedRefreshOnLevelUp = true
---@type number
UIRechargePanel.mContinueRewardID = 0
---@type number
--UIRechargePanel.mIsReceive = 1
UIRechargePanel.mContinousGiftBoxInfo = nil
---@type table
UIRechargePanel.mContinueCanReceiveList = {}
---@type table
UIRechargePanel.mContinueRechargeTemDic = {}
---@type UnityEngine.Vector3
UIRechargePanel.mRechargeBeforePos = CS.UnityEngine.Vector3(153, 0, 0)
---@type UnityEngine.Vector3
UIRechargePanel.mRechargeAfterPos = CS.UnityEngine.Vector3(306, 0, 0)
UIRechargePanel.mContinueNowGroup = 0
---@type table
UIRechargePanel.GridDic = {}
UIRechargePanel.mCurContinueGiftID = 0
UIRechargePanel.mCurContinueGiftTime = 0
UIRechargePanel.mBuyAllRewardInfo = nil
UIRechargePanel.isshowCanRechargeToReward = false
---是否需要再次请求一次礼包数据
UIRechargePanel.mIsNeedRequestRechargeGiftBoxAgain = nil
---是否请求了购买物品,true时在下次货币刷新时将向服务器再次请求礼包数据
UIRechargePanel.mIsRequestedBuyItem = nil
UIRechargePanel.AllTotalRechargeCount = 0
---@type boolean 是否可以显示一键直购按钮
UIRechargePanel.AllBuyBtnShow = false
---@type boolean 是否需要重新请求倒计时结束之后的礼包
UIRechargePanel.IsNeedReqGiftWithTimeOut = true
---当前不同类型的消息数目（领奖/投资）
UIRechargePanel.mCurrentMessageType = 2
---是否开启连充
UIRechargePanel.mIsOpenContinueRecharge = false

---参数传入的界面类型
UIRechargePanel.mPanelLayerType = nil;
--region 属性
---@return CSMainPlayerInfo
function UIRechargePanel:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end
--endregion

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIRechargePanel.GetBtnClose_GameObject()
    if (UIRechargePanel.mBtnCloseGameObject == nil) then
        UIRechargePanel.mBtnCloseGameObject = UIRechargePanel:GetCurComp("events/btn_close", "GameObject");
    end
    return UIRechargePanel.mBtnCloseGameObject;
end

---充值Grid
function UIRechargePanel.GetRechargeGrid_UIGridContainer()
    if UIRechargePanel.mRechargeGrid__UIGridContainer == nil then
        UIRechargePanel.mRechargeGrid__UIGridContainer = UIRechargePanel:GetCurComp("ScrollView/Grid", "Top_UIGridContainer")
    end
    return UIRechargePanel.mRechargeGrid__UIGridContainer
end

--region vipInfo
---Vip等级
function UIRechargePanel.GetVipLevel_UILabel()
    if UIRechargePanel.mVipLevel_UILabel == nil then
        UIRechargePanel.mVipLevel_UILabel = UIRechargePanel:GetCurComp("vipInfo/VipLv", "UILabel")
    end
    return UIRechargePanel.mVipLevel_UILabel
end
---vip进度文本
function UIRechargePanel.GetVipProgress_UILabel()
    if UIRechargePanel.mVipProgress_UILabel == nil then
        UIRechargePanel.mVipProgress_UILabel = UIRechargePanel:GetCurComp("vipInfo/VipPoints", "UILabel")
    end
    return UIRechargePanel.mVipProgress_UILabel
end
---vip进度Sprite
function UIRechargePanel.GetVipProgress_UISprite()
    if UIRechargePanel.mVipProgress_UISprite == nil then
        UIRechargePanel.mVipProgress_UISprite = UIRechargePanel:GetCurComp("vipInfo/Bar", "UISprite")
    end
    return UIRechargePanel.mVipProgress_UISprite
end
---vip进度提示
function UIRechargePanel.GetVipTips_UILabel()
    if UIRechargePanel.mVipProgress_UILabel == nil then
        UIRechargePanel.mVipProgress_UILabel = UIRechargePanel:GetCurComp("vipInfo/Tips", "UILabel")
    end
    return UIRechargePanel.mVipProgress_UILabel
end

---@return UIRechargeViewTemplate 充值模板
function UIRechargePanel:GetRechargeViewTemplate()
    if (self.mRechargeViewTemplate == nil) then
        self.mRechargeViewTemplate = templatemanager.GetNewTemplate(self:GetRechargeScrollView_GameObject(), luaComponentTemplates.UIRechargeViewTemplate, self)
    end
    return self.mRechargeViewTemplate;
end
--endregion

--region Toggle
---@return UIToggle
function UIRechargePanel:GetRewardToggle_UIGrid()
    if self.mRewardToggleGrid == nil then
        self.mRewardToggleGrid = self:GetCurComp("events/toggles", "Top_UIGrid")
    end
    return self.mRewardToggleGrid
end

---@return UIGridContainer
function UIRechargePanel:GetToggle_UIGridContainer()
    if self.mToggleContainer == nil then
        self.mToggleContainer = self:GetCurComp("events/toggles", "UIGridContainer")
    end
    return self.mToggleContainer
end

---@return UIGridContainer
function UIRechargePanel:GetContinueRechargeGridContainer()
    if (self.mContinueRechargeGrid == nil) then
        self.mContinueRechargeGrid = self:GetCurComp("ContinuityRecharge/ScrollView/GridContainer", "Top_UIGridContainer")
    end
    return self.mContinueRechargeGrid
end

--[[---@return UIToggle 领奖按钮
function UIRechargePanel:GetRewardToggle()
    if self.mRewardToggle == nil then
        self.mRewardToggle = self:GetCurComp("events/toggles/btn_reward", "UIToggle")
    end
    return self.mRewardToggle
end

---@return UISprite 领奖按钮背景
function UIRechargePanel:GetRewardToggleBG_UISprite()
    if self.mRewardToggleBG == nil then
        self.mRewardToggleBG = self:GetCurComp("events/toggles/btn_reward/Background", "UISprite")
    end
    return self.mRewardToggleBG
end]]

--[[
---@return UIToggle 充值按钮
function UIRechargePanel:GetRechargeToggle()
    if self.mRechargeToggle == nil then
        self.mRechargeToggle = self:GetCurComp("events/toggles/btn_recharge", "UIToggle")
    end
    return self.mRechargeToggle
end

---@return UISprite 充值按钮背景
function UIRechargePanel:GetRechargeToggleBG_UISprite()
    if self.mRechargeToggleBG == nil then
        self.mRechargeToggleBG = self:GetCurComp("events/toggles/btn_recharge/Background", "UISprite")
    end
    return self.mRechargeToggleBG
end
]]

--[[
---@return UIToggle 连续充值按钮
function UIRechargePanel:GetContinueRechargeToggle()
    if self.mContinueRechargeToggle == nil then
        self.mContinueRechargeToggle = self:GetCurComp("events/toggles/btn_continuerecharge", "UIToggle")
    end
    return self.mContinueRechargeToggle
end

---@return UISprite 连续充值按钮背景
function UIRechargePanel:GetContinueRechargeToggleBG_UISprite()
    if self.mContinueRechargeToggleBG == nil then
        self.mContinueRechargeToggleBG = self:GetCurComp("events/toggles/btn_continuerecharge/Background", "UISprite")
    end
    return self.mContinueRechargeToggleBG
end
]]

--[[
---@return UIToggle 终身限购按钮
function UIRechargePanel:GetLastRechargeToggle()
    if self.mLastRechargeToggle == nil then
        self.mLastRechargeToggle = self:GetCurComp("events/toggles/btn_lastbuy", "UIToggle")
    end
    return self.mLastRechargeToggle
end

---@return UISprite 终身限购按钮背景
function UIRechargePanel:GetLastRechargeToggleBG_UISprite()
    if self.mLastRechargeToggleBG == nil then
        self.mLastRechargeToggleBG = self:GetCurComp("events/toggles/btn_lastbuy/Background", "UISprite")
    end
    return self.mLastRechargeToggleBG
end
]]

--[[---@return UIToggle 充值投资按钮1
function UIRechargePanel:Getbtn_Investment1()
    if self.mbtn_Investment1 == nil then
        self.mbtn_Investment1 = self:GetCurComp("events/toggles/btn_Investment1", "UIToggle")
    end
    return self.mbtn_Investment1
end]]

---@return UILabel 充值投资按钮1描述1
function UIRechargePanel:Getbtn_Investment1_Label1()
    if self.mbtn_Investment1Label1 == nil then
        self.mbtn_Investment1Label1 = self:GetCurComp("events/toggles/btn_Investment1/Background/Label", "UILabel")
    end
    return self.mbtn_Investment1Label1
end

---@return UILabel 充值投资按钮1描述2
function UIRechargePanel:Getbtn_Investment1_Label2()
    if self.mbtn_Investment1Label2 == nil then
        self.mbtn_Investment1Label2 = self:GetCurComp("events/toggles/btn_Investment1/Checkmark/Label", "UILabel")
    end
    return self.mbtn_Investment1Label2
end

--[[---@return UISprite 充值投资按钮1背景
function UIRechargePanel:Getbtn_Investment1_Bg()
    if self.mbtn_Investment1BG == nil then
        self.mbtn_Investment1BG = self:GetCurComp("events/toggles/btn_Investment1/Background", "UISprite")
    end
    return self.mbtn_Investment1BG
end]]

--[[---
---@return UIToggle 充值投资按钮2
function UIRechargePanel:Getbtn_Investment2()
    if self.mbtn_Investment2 == nil then
        self.mbtn_Investment2 = self:GetCurComp("events/toggles/btn_Investment2", "UIToggle")
    end
    return self.mbtn_Investment2
end]]

---@return UILabel 充值投资按钮1描述1
function UIRechargePanel:Getbtn_Investment2_Label1()
    if self.mbtn_Investment2Label1 == nil then
        self.mbtn_Investment2Label1 = self:GetCurComp("events/toggles/btn_Investment2/Background/Label", "UILabel")
    end
    return self.mbtn_Investment2Label1
end

---@return UILabel 充值投资按钮1描述2
function UIRechargePanel:Getbtn_Investment2_Label2()
    if self.mbtn_Investment2Label2 == nil then
        self.mbtn_Investment2Label2 = self:GetCurComp("events/toggles/btn_Investment2/Checkmark/Label", "UILabel")
    end
    return self.mbtn_Investment2Label2
end

---@return UISprite 充值投资按钮2背景
function UIRechargePanel:Getbtn_Investment2_Bg()
    if self.mbtn_Investment2BG == nil then
        self.mbtn_Investment2BG = self:GetCurComp("events/toggles/btn_Investment2/Background", "UISprite")
    end
    return self.mbtn_Investment2BG
end

--[[---@return UIRedPoint 投资1按钮红点
function UIRechargePanel:GetInvestment1_UIRedPoint()
    if self.mInvestment1_UIRedPoint == nil then
        self.mInvestment1_UIRedPoint = self:GetCurComp("events/toggles/btn_Investment1/redPoint", "UIRedPoint")
    end
    return self.mInvestment1_UIRedPoint
end

---@return UIRedPoint 投资2按钮红点
function UIRechargePanel:GetInvestment2_UIRedPoint()
    if self.mInvestment2_UIRedPoint == nil then
        self.mInvestment2_UIRedPoint = self:GetCurComp("events/toggles/btn_Investment2/redPoint", "UIRedPoint")
    end
    return self.mInvestment2_UIRedPoint
end]]

--[[
---@return UIToggle 根据类型获取Toggle
function UIRechargePanel:GetToggle(num)
    if num == LuaEnumRechargeType.NormalRecharge then
        return self:GetRechargeToggle()
    elseif num == LuaEnumRechargeType.Reward then
        return self:GetRewardToggle()
    elseif num == LuaEnumRechargeType.ContinueRecharge then
        return self:GetContinueRechargeToggle()
    elseif num == LuaEnumRechargeType.LastRecharge then
        return self:GetLastRechargeToggle()
    elseif num == LuaEnumRechargeType.Investment1 then
        return self:Getbtn_Investment1()
    elseif num == LuaEnumRechargeType.Investment2 then
        return self:Getbtn_Investment2()
    end
end
]]

--endregion

--region 充值


---@return UnityEngine.GameObject 充值ScrollViewGo
function UIRechargePanel:GetRechargeScrollView_GameObject()
    if self.mRechargeScrollView == nil then
        self.mRechargeScrollView = self:GetCurComp("ScrollView", "GameObject")
    end
    return self.mRechargeScrollView
end
--endregion

--region 领奖

---@return UnityEngine.GameObject 领奖ScrollViewGo
function UIRechargePanel:GetRewardScrollView_GameObject()
    if self.mRewardScrollViewGO == nil then
        self.mRewardScrollViewGO = self:GetCurComp("ScrollViewReward", "GameObject")
    end
    return self.mRewardScrollViewGO
end

---@return UILoopScrollViewPlus 领奖格子控制组件
function UIRechargePanel:GetReward_UILoopScrollViewPlus()
    if self.mRewardGridContainer == nil then
        self.mRewardGridContainer = self:GetCurComp("ScrollViewReward/Grid", "UILoopScrollViewPlus")
    end
    return self.mRewardGridContainer
end

---@return UnityEngine.GameObject 呼吸箭头
function UIRechargePanel:GetArrow_GameObject()
    if self.mArrowGo == nil then
        self.mArrowGo = self:GetCurComp("Arrow", "GameObject")
    end
    return self.mArrowGo
end

---@return TweenAlpha 动画
function UIRechargePanel:GetLeftArrow_TweenAlpha()
    if self.mLeftArrowTweenAlpha == nil then
        self.mLeftArrowTweenAlpha = self:GetCurComp("Arrow/leftArrow", "TweenAlpha")
    end
    return self.mLeftArrowTweenAlpha
end

---@return TweenAlpha 动画
function UIRechargePanel:GetRightArrow_TweenAlpha()
    if self.mRightArrowTweenAlpha == nil then
        self.mRightArrowTweenAlpha = self:GetCurComp("Arrow/rightArrow", "TweenAlpha")
    end
    return self.mRightArrowTweenAlpha
end

---@return UIScrollView 领奖ScrollView
function UIRechargePanel:GetRewardScrollView()
    if self.mRewardScrollView == nil then
        self.mRewardScrollView = self:GetCurComp("ScrollViewReward", "UIScrollView")
    end
    return self.mRewardScrollView
end

---@return UIPanel 领奖UIPanel
function UIRechargePanel:GetRewardUIPanel()
    if self.mRewardUIPanel == nil then
        self.mRewardUIPanel = self:GetCurComp("ScrollViewReward", "UIPanel")
    end
    return self.mRewardUIPanel
end

---@return UnityEngine.GameObject
function UIRechargePanel:GetRechargeWindowGo()
    if self.mRechargeWindowGo == nil then
        self.mRechargeWindowGo = self:GetCurComp("window", "GameObject")
    end
    return self.mRechargeWindowGo
end

---@return UnityEngine.GameObject
function UIRechargePanel:GetRechargeWindowBoxGO()
    if self.mRechargeWindowBoxGo == nil then
        self.mRechargeWindowBoxGo = self:GetCurComp("window/box", "GameObject")
    end
    return self.mRechargeWindowBoxGo
end

---@return UnityEngine.GameObject
function UIRechargePanel:GetRechargeWindowSprite1GO()
    if self.mRechargeWindowSprite1Go == nil then
        self.mRechargeWindowSprite1Go = self:GetCurComp("window/Sprite1", "GameObject")
    end
    return self.mRechargeWindowSprite1Go
end

---@return UnityEngine.GameObject 领奖背景图片
function UIRechargePanel:Getreward_slogan_GameObject()
    if self.mGetreward_slogan_GameObject == nil then
        self.mGetreward_slogan_GameObject = self:GetCurComp("reward_slogan", "GameObject")
    end
    return self.mGetreward_slogan_GameObject
end
---@return UnityEngine.GameObject 领奖背景图片
function UIRechargePanel:GetRewardBG_GameObject()
    if self.mRewardBg == nil then
        self.mRewardBg = self:GetCurComp("window/Sprite_reward", "GameObject")
    end
    return self.mRewardBg
end

---@return UnityEngine.GameObject 领奖标题
function UIRechargePanel:GetRewardTitle_GameObject()
    if self.mRewardTitle == nil then
        self.mRewardTitle = self:GetCurComp("window/Sprite_reward/title", "GameObject")
    end
    return self.mRewardTitle
end

---@return UnityEngine.GameObject 领奖描述
function UIRechargePanel:GetRewardContent_GameObject()
    if self.mRewardContent == nil then
        self.mRewardContent = self:GetCurComp("window/Sprite_reward/slogan_bg", "GameObject")
    end
    return self.mRewardContent
end

--[[---@return UIRedPoint 领奖红点
function UIRechargePanel:GetRewardRedPoint_UIRedPoint()
    if self.mRewardRedPoint == nil then
        self.mRewardRedPoint = self:GetCurComp("events/toggles/btn_reward/redPoint", "UIRedPoint")
    end
    return self.mRewardRedPoint
end]]

---@return UIScrollView
function UIRechargePanel:GetReward_UIScrollView()
    if self.mRewardScrollView == nil then
        self.mRewardScrollView = self:GetCurComp("ScrollViewReward", "UIScrollView")
    end
    return self.mRewardScrollView
end

---@return UnityEngine.GameObject 一键直购按钮
function UIRechargePanel:GetOneClickPurchaseBtn_GameObject()
    if self.mOnClickPurchaseBtn == nil then
        self.mOnClickPurchaseBtn = self:GetCurComp("events/btn_OneClickPurchase", "GameObject")
    end
    return self.mOnClickPurchaseBtn
end

---@return UnityEngine.GameObject 连充可领取Logo
function UIRechargePanel:GetContinueRechargeLogo_GameObject()
    if (self.mContinueRechargeLogo == nil) then
        self.mContinueRechargeLogo = self:GetCurComp("ScrollView/ContinueRechargeLogo", "GameObject")
    end
    return self.mContinueRechargeLogo
end
---@return UISprite 连充可领取Logo静图
function UIRechargePanel:GetContinueRechargeLogoEff_UISprite()
    if (self.mContinueRechargeLogoEff_UISprite == nil) then
        self.mContinueRechargeLogoEff_UISprite = self:GetCurComp("ScrollView/ContinueRechargeLogo/box", "Top_UISprite")
    end
    return self.mContinueRechargeLogoEff_UISprite
end
---@return CS.CSUIEffectLoad  连充可领取Logo特效
function UIRechargePanel:GetContinueRechargeLogoEff_CSUIEffectLoad()
    if (self.mContinueRechargeLogoEff_CSUIEffectLoad == nil) then
        self.mContinueRechargeLogoEff_CSUIEffectLoad = self:GetCurComp("ScrollView/ContinueRechargeLogo/box", "CSUIEffectLoad")
    end
    return self.mContinueRechargeLogoEff_CSUIEffectLoad
end
--endregion

---@return UnityEngine.GameObject 首充豪礼Logo
function UIRechargePanel:GetFirstRechargeRewardLogo_GameObject()
    if (self.mFirstRechargeRewardLogo_GameObject == nil) then
        self.mFirstRechargeRewardLogo_GameObject = self:GetCurComp("ScrollView/FirstRechargeLogo", "GameObject")
    end
    return self.mFirstRechargeRewardLogo_GameObject
end
---@return CS.CSUIEffectLoad 首充豪礼Logo的特效
function UIRechargePanel:GetFirstRechargeRewardLogoEff_CSUIEffectLoad()
    if (self.mFirstRechargeRewardLogoEff_CSUIEffectLoad == nil) then
        self.mFirstRechargeRewardLogoEff_CSUIEffectLoad = self:GetCurComp("ScrollView/FirstRechargeLogo/box", "CSUIEffectLoad")
    end
    return self.mFirstRechargeRewardLogoEff_CSUIEffectLoad
end
---@return UISprite 首充豪礼Logo的静图
function UIRechargePanel:GetFirstRechargeRewardLogoEff_UISprite()
    if (self.mFirstRechargeRewardLogoEff_UISprite == nil) then
        self.mFirstRechargeRewardLogoEff_UISprite = self:GetCurComp("ScrollView/FirstRechargeLogo/box", "Top_UISprite")
    end
    return self.mFirstRechargeRewardLogoEff_UISprite
end
--endregion

--region 连充
function UIRechargePanel:GetContinueRecharge_GameObject()
    if (self.mContinueRechargeGo == nil) then
        self.mContinueRechargeGo = self:GetCurComp("ContinuityRecharge", "GameObject")
    end
    return self.mContinueRechargeGo
end

---@return UISprite
function UIRechargePanel:GetContinueRechargeTitle_UISprite()
    if (self.mContinueRechargeTitle_UISprite == nil) then
        self.mContinueRechargeTitle_UISprite = self:GetCurComp("ContinuityRecharge/Sprite_slogan/title", "Top_UISprite")
    end
    return self.mContinueRechargeTitle_UISprite
end

---@return UISprite
function UIRechargePanel:GetContinueRechargeSlogan_UISprite()
    if (self.mContinueRechargeSlogan_UISprite == nil) then
        self.mContinueRechargeSlogan_UISprite = self:GetCurComp("ContinuityRecharge/Sprite_slogan/slogan_bg/slogan", "Top_UISprite")
    end
    return self.mContinueRechargeSlogan_UISprite
end

---@return GameObject
function UIRechargePanel:GetLastRechargeSlogan_GameObject()
    if (self.mLastRechargeSlogan_GameObject == nil) then
        self.mLastRechargeSlogan_GameObject = self:GetCurComp("window/Sprite_reward/slogan_lastbuy", "GameObject")
    end
    return self.mLastRechargeSlogan_GameObject
end
---@return GameObject
function UIRechargePanel:GetLastRechargeSloganTipsLabel_GameObject()
    if (self.mLastRechargeSloganTipsLabel_GameObject == nil) then
        self.mLastRechargeSloganTipsLabel_GameObject = self:GetCurComp("window/Sprite_reward/slogan_lastbuy/TipsSprite", "GameObject")
    end
    return self.mLastRechargeSloganTipsLabel_GameObject
end

---@return UnityEngine.GameObject
function UIRechargePanel:GetContinueRepayBtn_GameObject()
    if (self.mContinueRechargeRepayBtn == nil) then
        self.mContinueRechargeRepayBtn = self:GetCurComp("reward_slogan/btn_repay", "GameObject")
    end
    return self.mContinueRechargeRepayBtn
end

---@return UnityEngine.GameObject 特效
function UIRechargePanel:GetContinueRepayBtnEffect_GameObject()
    if (self.mContinueRechargeRepayBtnEffect == nil) then
        self.mContinueRechargeRepayBtnEffect = self:GetCurComp("reward_slogan/btn_repay/effect", "GameObject")
    end
    return self.mContinueRechargeRepayBtnEffect
end

---@return GameObject
function UIRechargePanel:GetContinueRepay_UILabel()
    if (self.mContinueRechargeRepayLabel == nil) then
        self.mContinueRechargeRepayLabel = self:GetCurComp("reward_slogan/lb_repay", "Top_UILabel")
    end
    return self.mContinueRechargeRepayLabel
end

function UIRechargePanel:GetRechargeDic()
    return CS.Cfg_ContinueRechargeTableManager.Instance.GroupRechargeDic
end
--endregion

---@return ObservationModel
function UIRechargePanel:GetModel_ObservationModel()
    if (self.mModel == nil) then
        self.mModel = CS.ObservationModel()
    end
    return self.mModel
end

function UIRechargePanel:GetModelRoot()
    if (self.mModelRoot == nil) then
        self.mModelRoot = self:GetCurComp("ContinuityRecharge/Model", "GameObject")
    end
    return self.mModelRoot
end

---@return UIGridContainer
function UIRechargePanel:GetRewardItemList_GridContainer()
    if (self.mRewardItemList == nil) then
        self.mRewardItemList = self:GetCurComp("ContinuityRecharge/RewardItemList", "Top_UIGridContainer")
    end
    return self.mRewardItemList
end

---@return UIGridContainer 用于显示最上面一行不足三个的
function UIRechargePanel:GetCenterRewardList_GridContainer()
    if self.mCenterRewardContainer == nil then
        self.mCenterRewardContainer = self:GetCurComp("ContinuityRecharge/CenterList", "UIGridContainer")
    end
    return self.mCenterRewardContainer
end

--endregion

--region 初始化
function UIRechargePanel:Init()
    self:BindEvents()
    self:BindMessage()
    self.mNeedRefreshOnLevelUp = not self:GetPlayerCanReward()
    ---self:GetContinueRepayBtn_GameObject():SetActive(gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():GetOpenState())
    self:RefreshContinueBtnEffect()
end

function UIRechargePanel:Show(customData)
    self.ShowList = {}
    self.ShowPreferenceList = {};

    ---@type number 存储当前接受消息数目,第一次在接受完毕领奖和投资两个消息以后才进行页签选中
    self.mGetResTime = 0
    if (customData == nil or customData.type == nil) then
        customData = {}
        customData.type = LuaEnumRechargeType.NormalRecharge
        customData.selectRewardID = 0
    end
    if (customData.PanelLayerType ~= nil) then
        self.mPanelLayerType = customData.PanelLayerType;
    end

    self.selectRewardID = customData.selectRewardID
    if customData.type then
        self.mCurrentToggleType = customData.type
        self.PanelType = customData.type
    end

    networkRequest.ReqRechargeGiftBox()
    networkRequest.ReqVipInfo()
    networkRequest.ReqRoleCycleGiftBoxInfo()
    networkRequest.ReqInvestPlanData()
    networkRequest.ReqFirstRechargeGive()
    --self:GetStoreDiamondBoxInfo()rebateRewardGet
    self:InitInvestmentInfo()

    self.mRefreshBookMarkTime = 0
    if self.mIsNotFirstTime == nil then
        self.mIsNotFirstTime = true
    else
        self:ShowPanel(nil)
    end
end

function UIRechargePanel:BindEvents()
    CS.UIEventListener.Get(self.GetBtnClose_GameObject()).onClick = function()
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetModelRoot()).onClick = function()
        self:ShowLastRewardInfo()
    end

    CS.UIEventListener.Get(self:GetContinueRepayBtn_GameObject()).onClick = function()
        uimanager:CreatePanel("UIContinuityRechargeRepayPanel", nil, { PanelLayerType = self.mPanelLayerType })
    end

    CS.UIEventListener.Get(UIRechargePanel:GetFirstRechargeRewardLogo_GameObject()).onClick = function()
        uimanager:ClosePanel("UIRechargePanel")
        uimanager:CreatePanel("UIRechargeFirstTips", nil, { PanelLayerType = self.mPanelLayerType })
    end

    self:GetRewardScrollView().onDragFinished = function()
        self:RewardRefreshArrow()
    end

    CS.UIEventListener.Get(self:GetOneClickPurchaseBtn_GameObject()).onClick = function()
        local temp = {}
        local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(104)
        if isFind then
            temp.Content = string.gsub(info.des, '\\n', '\n')
            if (UIRechargePanel.mBuyAllRewardInfo ~= nil) then
                temp.CenterDescription = "[ffcda5]￥" .. math.floor(UIRechargePanel.mBuyAllRewardInfo.rmb / 100)
            end
            temp.CallBack = UIRechargePanel.OnOneClickPurchaseBtnClicked
            temp.ID = 104
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        end
    end
end

function UIRechargePanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleVipInfoMessage, UIRechargePanel.ResVipInfo)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleVipInfoChangeMessage, UIRechargePanel.ResRoleVipInfoChangeMessageInfo)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpdateRechargeGiftBoxMessage, UIRechargePanel.RefreshRechargeGiftBox)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleCycleGiftBoxInfoMessage, function(id, data)
        self:RefreshCircleDiamondGiftList(id, data)
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOpenStoreByIdMessage, function()
        self:RewardMessageReceived()
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInvestPlanDataMessage, function()
        self:ResInvestPlanDataMessage()
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFirstRechargeGiveMessage, function(id, data)
        if (UIRechargePanel.PanelType == LuaEnumRechargeType.NormalRecharge) then
            UIRechargePanel:GetRechargeViewTemplate():ShowRechargeView(LuaEnumRechargeType.NormalRecharge);
        end
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:RefreshRewardInfo()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RechargeRewardChange, function()
        self:RewardMessageReceived()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        if UIRechargePanel.mIsRequestedBuyItem then
            UIRechargePanel.mIsRequestedBuyItem = nil
            UIRechargePanel.mIsNeedRequestRechargeGiftBoxAgain = true
        end
    end)

    --self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshRechargeBookMark, function()
    --    self:ResetBookMark()
    --end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AccumulatedRechargeRedPointChange, function()
        self:RefreshContinueBtnEffect()
    end)


end

--endregion

--region 页签
---初始化页签
function UIRechargePanel:ResetBookMark()
    local csData = self:GetPlayerInfo().RechargeInfo.CurrentRechargeGiftBoxInfo
    ---@type table<number,LuaEnumRechargeType> 当前显示页签类型
    self.mCurrentShowToggle = {}
    ---@type table<LuaEnumRechargeType,UIToggle> 类型对应toggle
    self.mTypeToToggle = {}
    ---@type table<LuaEnumRechargeType,UISprite> 类型对应背景图
    self.mTypeToSp = {}
    ---@type table<number,boolean> 类型对应的显示状态
    self.mTypeToOpenState = {}
    --领奖
    local finalShowList = self:GetRewardShowList()
    local isfind, globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22921)
    local rewardCondition = true
    if (isfind) then
        rewardCondition = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(globalInfo.value)
    end
    local isShowReward = finalShowList and #finalShowList > 0 and rewardCondition
    if isShowReward then
        self:AddToggle(LuaEnumRechargeType.Reward)
    end
    self:SaveToggleOpenState(LuaEnumRechargeType.Reward, isShowReward)

    local finalPreferenceList = self:GetPreferenceShowList()
    local isShowPreference = finalPreferenceList and #finalPreferenceList > 0
    if isShowPreference then
        self:AddToggle(LuaEnumRechargeType.PreferenceGift)
    end
    self:SaveToggleOpenState(LuaEnumRechargeType.PreferenceGift, isShowPreference)
    ---连续充值
    --local isShowContinueRecharge = csData.continuousGiftBoxInfo.nowGroup ~= 0
    --print(isShowContinueRecharge)
    --if isShowContinueRecharge then
    --    self:OpenContinueRechargePanel()
    --    self:AddToggle(LuaEnumRechargeType.ContinueRecharge)
    --end

    --self:SaveToggleOpenState(LuaEnumRechargeType.ContinueRecharge, isShowContinueRecharge)
    --[[
        --终身限购
        local isShowLastRecharge = LuaGlobalTableDeal:GetLastRechargeOpenConditionState()
        and self.LastRechargeList and Utility.GetLuaTableCount(self.LastRechargeList) ~= 0

        if isShowLastRecharge then
            self:AddToggle(LuaEnumRechargeType.LastRecharge)
        end
        self:SaveToggleOpenState(LuaEnumRechargeType.LastRecharge, isShowLastRecharge)
    ]]

    --self:SaveToggleOpenState(LuaEnumRechargeType.ContinueRecharge, true)
    self:SaveToggleOpenState(LuaEnumRechargeType.LastRecharge, true)

    --累计充值（第一期）
    --local isShowAccumulatedRecharge = gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():IsShowBookMarkByPeriod(1)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22195)
    if isFind then
        --self:GetContinueRepay_UILabel().gameObject:SetActive(CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(info.value))
        self:GetContinueRepay_UILabel().gameObject:SetActive(false)
    end
    --if isShowAccumulatedRecharge then
    --self:AddToggle(LuaEnumRechargeType.AccumulatedRecharge)
    --end
    --self:GetContinueRepayBtn_GameObject():SetActive(isShowAccumulatedRecharge)

    --self:SaveToggleOpenState(LuaEnumRechargeType.AccumulatedRecharge, isShowAccumulatedRecharge)


    --local isopen1 = false
    --local isopen2 = false
    --local InvestmentMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr()
    --if InvestmentMgr ~= nil then
    --    isopen1 = InvestmentMgr:GetOneTurmDic() ~= nil
    --    isopen2 = InvestmentMgr:GetTwoTurmDic() ~= nil
    --end
    ----投资1
    --if isopen1 then
    --    self:AddToggle(LuaEnumRechargeType.Investment1)
    --end
    --self:SaveToggleOpenState(LuaEnumRechargeType.Investment1, isopen1)
    ----投资2
    --if isopen2 then
    --    self:AddToggle(LuaEnumRechargeType.Investment2)
    --end
    --self:SaveToggleOpenState(LuaEnumRechargeType.Investment2, isopen2)


    --[[
    --潜能投资
    local IsShowPotentialInvest = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():IsShowPotentialInvest()
    if IsShowPotentialInvest then
        self:AddToggle(LuaEnumRechargeType.PotentialInvest)
    end
    self:SaveToggleOpenState(LuaEnumRechargeType.PotentialInvest, IsShowPotentialInvest)
    --]]

    --常规充值
    self:AddToggle(LuaEnumRechargeType.NormalRecharge)
    self:SaveToggleOpenState(LuaEnumRechargeType.NormalRecharge, true)
    self:SaveToggleOpenState(LuaEnumRechargeType.ContinueRecharge, true)

    self:RefreshBookMarkShow()
    self:ChooseCurrentToggle()
end

---存储所有页签显示状态
function UIRechargePanel:SaveToggleOpenState(type, state)
    self.mTypeToOpenState[type] = state
end

---获取页签显示状态
function UIRechargePanel:GetToggleOpenState(type)
    local state = false
    if self.mTypeToOpenState then
        state = self.mTypeToOpenState[type]
        if state == nil then
            state = false
            self.mTypeToOpenState[type] = state
        end
    end
    return state
end

function UIRechargePanel:OpenContinueRechargePanel()
    --self:GetContinueRecharge_GameObject():SetActive(true)
    --local itemlist = self:GetRechargeDic()[UIRechargePanel.mContinueNowGroup].rewardShow.list
    --self:RefreshRewardList(itemlist)
    --self:UpdateContinueRechargePanelTitleAndSlogan()
    --self:UpdateModel(self:GetModel_ObservationModel(), self:GetModelRoot())
    uiStaticParameter.SetLCRedPointValue(true)
end
---选中一个页签
function UIRechargePanel:ChooseCurrentToggle()
    self.mRefreshBookMarkTime = self.mRefreshBookMarkTime + 1
    --初始有两个消息都会刷新

    --如果当前有选中页签，则显示选中页签
    if self.mCurrentToggleType then
        local state = self:GetToggleOpenState(self.mCurrentToggleType)
        if state then
            self:OnSingleToggleClicked(self.mCurrentToggleType)
            return
        end
    end
    --否则显示选中第一个开启页签
    for i = 1, #self.mOpenSort do
        local type = self.mOpenSort[i]
        local state = self:GetToggleOpenState(type)
        if state then
            self:OnSingleToggleClicked(type)
            return
        end
    end
end

---@param toggleType LuaEnumRechargeType 添加页签
function UIRechargePanel:AddToggle(toggleType)
    if self.mCurrentShowToggle then
        table.insert(self.mCurrentShowToggle, toggleType)
    end
end

---刷新页签显示
function UIRechargePanel:RefreshBookMarkShow()
    --if self.mCurrentShowToggle then
    --    print(#self.mCurrentShowToggle,"#self.mCurrentShowToggle")
    --    self:GetToggle_UIGridContainer().MaxCount = #self.mCurrentShowToggle
    --    for i = 0, self:GetToggle_UIGridContainer().controlList.Count - 1 do
    --        local go = self:GetToggle_UIGridContainer().controlList[i]
    --        self:RefreshSingleToggle(go, self.mCurrentShowToggle[i + 1])
    --    end
    --end
end

---刷新单个页签
function UIRechargePanel:RefreshSingleToggle(go, type)
    local lb = CS.Utility_Lua.Get(go.transform, "Background/Label", "UILabel")
    local checkLb = CS.Utility_Lua.Get(go.transform, "Checkmark/Label", "UILabel")
    local sp = CS.Utility_Lua.Get(go.transform, "Background", "UISprite")
    local name = self.mToggleName[type]
    ---@type UIRedPoint
    local redPointKey = CS.Utility_Lua.Get(go.transform, "redPoint", "UIRedPoint")
    redPointKey:RemoveRedPointKey()
    lb.text = name
    checkLb.text = name
    ---@type UIToggle
    local toggle = CS.Utility_Lua.GetComponent(go.transform, "UIToggle")
    --CS.UIEventListener.Get(go).onClick = function()
    --    self:OnSingleToggleClicked(type)
    --end
    self.mTypeToToggle[type] = toggle
    self.mTypeToSp[type] = sp
    self:DealSingleTypeRedPoint(type, redPointKey)
    toggle:Set(false)
end

---选中单个页签
function UIRechargePanel:OnSingleToggleClicked(type)
    self.mCurrentToggleType = type
    local toggle = self.mTypeToToggle[type]
    if toggle then
        toggle:Set(true)
    end
    for k, v in pairs(self.mTypeToSp) do
        v.color = k == type and LuaEnumUnityColorType.Transparent or LuaEnumUnityColorType.Normal
    end
    self:DealSingleToggleChoose(type)
end

---处理选中事件
function UIRechargePanel:DealSingleToggleChoose(type)
    if type == LuaEnumRechargeType.Reward then
        self:OnRewardToggleChoose()
    elseif type == LuaEnumRechargeType.ContinueRecharge then
        self:OnContinueRechargeToggleChoose()
    elseif type == LuaEnumRechargeType.LastRecharge then
        self:OnLastRechargeToggleChoose()
    elseif type == LuaEnumRechargeType.NormalRecharge then
        self:OnRechargeToggleChoose()
    elseif type == LuaEnumRechargeType.Investment1 then
        self:OnClickInvestment1()
    elseif type == LuaEnumRechargeType.Investment2 then
        self:OnClickInvestment2()
    elseif type == LuaEnumRechargeType.AccumulatedRecharge then
        self:OnClickAccumulatedRecharge()
    elseif type == LuaEnumRechargeType.PotentialInvest then
        self:OnClickPotentialInvest()
    elseif type == LuaEnumRechargeType.PreferenceGift then
        self:OnClickPreferenceGift()
    end
end

---给对应页签绑定红点
---@param type LuaEnumRechargeType
---@param redPointKey UIRedPoint
function UIRechargePanel:DealSingleTypeRedPoint(type, redPointKey)
    redPointKey:RemoveRedPointKey()
    if type == LuaEnumRechargeType.Reward then
        redPointKey:AddRedPointKey(CS.RedPointKey.Recharge_Reward)
        local AccumulatedRecharge = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.AccumulatedRecharge)
        redPointKey:AddRedPointKey(AccumulatedRecharge)
    elseif type == LuaEnumRechargeType.Investment1 then
        local Investment_One = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Investment_One)
        redPointKey:AddRedPointKey(Investment_One)
    elseif type == LuaEnumRechargeType.Investment2 then
        local Investment_Two = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Investment_Two)
        redPointKey:AddRedPointKey(Investment_Two)
    elseif type == LuaEnumRechargeType.AccumulatedRecharge then
        local AccumulatedRecharge = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.AccumulatedRecharge)
        redPointKey:AddRedPointKey(AccumulatedRecharge)
    elseif type == LuaEnumRechargeType.PotentialInvest then
        local PotentialInvest = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint)
        redPointKey:AddRedPointKey(PotentialInvest)
    elseif type == LuaEnumRechargeType.ContinueRecharge then
        local LianChongRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianChongRedPoint)
        redPointKey:AddRedPointKey(LianChongRedPoint)
    end
end
--endregion

--region 管理组件显示
---@param type LuaEnumRechargeType 界面显示类型
function UIRechargePanel:ShowPanel(type)
    self.PanelType = type
    self:GetRechargeScrollView_GameObject():SetActive(type == LuaEnumRechargeType.NormalRecharge)
    self:GetRewardScrollView_GameObject():SetActive(type == LuaEnumRechargeType.Reward or type == LuaEnumRechargeType.LastRecharge or type == LuaEnumRechargeType.PreferenceGift)
    self:GetRewardBG_GameObject():SetActive(type == LuaEnumRechargeType.Reward or type == LuaEnumRechargeType.LastRecharge or type == LuaEnumRechargeType.PreferenceGift)
    self:Getreward_slogan_GameObject():SetActive(type == LuaEnumRechargeType.Reward)
    self:GetContinueRecharge_GameObject():SetActive(type == LuaEnumRechargeType.ContinueRecharge)
    self:ShowFirstRechargeRewardTip()
    self:ShowContinueRechargePanel(type)
    self:GetRechargeWindowGo():SetActive(false)
    --self:GetReward_UILoopScrollViewPlus().gameObject.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    if type == LuaEnumRechargeType.Reward then
        self:GetRewardTitle_GameObject():SetActive(true)
        self:GetRewardContent_GameObject():SetActive(true)
        self:GetLastRechargeSlogan_GameObject():SetActive(false)
        self:GetOneClickPurchaseBtn_GameObject():SetActive(false)
        self:RefreshRewardShow(self:GetRewardShowList(), self.onlineTime)
        self:GetReward_UILoopScrollViewPlus().gameObject.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
        --if (self:GetReward_UILoopScrollViewPlus().itemsList.Count >= 2) then
        --    self:GetReward_UILoopScrollViewPlus().itemsList[0].transform.localPosition = CS.UnityEngine.Vector3(-355, 0, 0)
        --    self:GetReward_UILoopScrollViewPlus().itemsList[1].transform.localPosition = CS.UnityEngine.Vector3(25, 0, 0)
        --end
    elseif (type == LuaEnumRechargeType.LastRecharge) then
        self:GetRechargeWindowGo():SetActive(true)
        self:GetRechargeWindowSprite1GO():SetActive(false)
        self:GetRechargeWindowBoxGO():SetActive(false)
        self:GetRewardTitle_GameObject():SetActive(false)
        self:GetRewardContent_GameObject():SetActive(false)
        self:GetLastRechargeSlogan_GameObject():SetActive(true)
        if (self.LastRechargeList ~= nil) then
            self:SortShowList(self.LastRechargeList)
            if #self.LastRechargeList==0 then
                --显示暂无可购礼包字样
                self:GetLastRechargeSloganTipsLabel_GameObject():SetActive(true)
            else
                --关闭暂无可购礼包字样
                self:GetLastRechargeSloganTipsLabel_GameObject():SetActive(false)
            end
            self:RefreshRewardShow(self.LastRechargeList, self.onlineTime)
        end
    elseif (type == LuaEnumRechargeType.PreferenceGift) then
        self:GetRewardTitle_GameObject():SetActive(true)
        self:GetRewardContent_GameObject():SetActive(true)
        self:GetLastRechargeSlogan_GameObject():SetActive(false)
        self:GetOneClickPurchaseBtn_GameObject():SetActive(false)
        self:RefreshRewardShow(self:GetPreferenceShowList(), self.onlineTime)
    else
        self:GetArrow_GameObject():SetActive(false)
        self:GetOneClickPurchaseBtn_GameObject():SetActive(false)

        --self:GetOneClickPurchaseBtn_GameObject():SetActive((self.AllBuyBtnShow and self.PanelType == LuaEnumRechargeType.Reward))
    end
    if type ~= LuaEnumRechargeType.Investment1 and type ~= LuaEnumRechargeType.Investment2 then
        local InvestmentPanel = uimanager:GetPanel("UISevenDayInvestmentPanel")
        if InvestmentPanel ~= nil then
            InvestmentPanel:Hide()
        end
    end
    ---隐藏累计充值页面
    if type ~= LuaEnumRechargeType.AccumulatedRecharge then
        local AccumulatedRechargePanel = uimanager:GetPanel("UIAccumulatedRechargePanel")
        if AccumulatedRechargePanel ~= nil then
            AccumulatedRechargePanel:HideSelf()
        end
    end
    if type ~= LuaEnumRechargeType.PotentialInvest then
        local PotentialInvestPanel = uimanager:GetPanel("UIPotentialInvestPanel")
        if PotentialInvestPanel ~= nil then
            PotentialInvestPanel:HideSelf()
        end
    end
end

function UIRechargePanel:ShowFirstRechargeRewardTip()
    self:GetFirstRechargeRewardLogo_GameObject():SetActive(false)--not CS.CSScene.MainPlayerInfo.RechargeInfo.IsGetFirstRechargeReward and CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel == 0
    self:GetFirstRechargeRewardLogoEff_UISprite().color = (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false or CS.CSScene.MainPlayerInfo.RechargeInfo.IsGetFirstRechargeReward) and CS.UnityEngine.Color(1, 1, 1, 1) or CS.UnityEngine.Color(1, 1, 1, 1 / 255)
    self:GetFirstRechargeRewardLogoEff_CSUIEffectLoad().enabled = not (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false or CS.CSScene.MainPlayerInfo.RechargeInfo.IsGetFirstRechargeReward)
end

function UIRechargePanel:ShowContinueRechargePanel(type)
    --self:GetContinueRechargeLogo_GameObject():SetActive(type == LuaEnumRechargeType.NormalRecharge and (CS.CSScene.MainPlayerInfo.RechargeInfo.IsCanGetContinueReward or UIRechargePanel.isshowCanRechargeToReward) and CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel ~= 0)
    --self:GetContinueRechargeLogoEff_UISprite().color = not (CS.CSScene.MainPlayerInfo.RechargeInfo.IsCanGetContinueReward) and CS.UnityEngine.Color(1, 1, 1, 1) or CS.UnityEngine.Color(1, 1, 1, 1 / 255)
    --self:GetContinueRechargeLogoEff_CSUIEffectLoad().enabled = CS.CSScene.MainPlayerInfo.RechargeInfo.IsCanGetContinueReward
    --print(111111)
    -- self:GetContinueRecharge_GameObject():SetActive(type == LuaEnumRechargeType.ContinueRecharge and UIRechargePanel.mIsOpenContinueRecharge)
    -- if (type == LuaEnumRechargeType.Reward and UIRechargePanel.mIsOpenContinueRecharge) then
    --     local itemlist = self:GetRechargeDic()[UIRechargePanel.mContinueNowGroup].rewardShow.list
    --     self:RefreshRewardList(itemlist)
    --     --self:UpdateContinueRechargePanelTitleAndSlogan()
    --     self:UpdateModel(self:GetModel_ObservationModel(), self:GetModelRoot())
    --     uiStaticParameter.SetLCRedPointValue(true)
    -- end
    if (type == LuaEnumRechargeType.ContinueRecharge) then
        if UIRechargePanel.mContinueNowGroup == nil then
            return
        end
        self:UpdateModel(self:GetModel_ObservationModel(), self:GetModelRoot())
        self:GetItemGrid()
        gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():CheckRedPoint(false)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianChongRedPoint))
        if self:GetRechargeDic() == nil or self:GetRechargeDic():ContainsKey(UIRechargePanel.mContinueNowGroup) == false then
            return
        end
        if self:GetRechargeDic()[UIRechargePanel.mContinueNowGroup].rewardShow == nil then
            return
        end
        local itemlist = self:GetRechargeDic()[UIRechargePanel.mContinueNowGroup].rewardShow.list
        --self:RefreshRewardList(itemlist)
        --self:UpdateContinueRechargePanelTitleAndSlogan()
        uiStaticParameter.SetLCRedPointValue(true)
    end
end

---获取角色模型下面的奖励列表
function UIRechargePanel:GetItemGrid()
    self:GetCenterRewardList_GridContainer().gameObject:SetActive(true)
    self:GridShow(UIRechargePanel.mContinueNowGroup)

end

function UIRechargePanel:GridShow(id)
    local gender = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local isFind, list = self:GetRechargeDic():TryGetValue(id)
    if isFind then
        local itemlist = list.show.list
        local tempList = {}
        for i = 0, itemlist.Count - 1 do
            table.insert(tempList, itemlist[i])
        end
        for i = #tempList, 1, -1 do
            local listTemp = tempList[i].list
            if gender ~= listTemp[3] and listTemp[3] ~= 0 then
                table.remove(tempList, i)
            end
            if career ~= listTemp[2] and listTemp[2] ~= 0 then
                table.remove(tempList, i)
            end
        end
        self:GetCenterRewardList_GridContainer().MaxCount = #tempList
        for i = 1, #tempList do
            local go = self:GetCenterRewardList_GridContainer().controlList[i - 1]
            local icon = self:GetComp(go.transform, "icon", 'UISprite')
            local count = self:GetComp(go.transform, "count", 'UILabel')
            if tempList[i].list[1] > 1 then
                count.text = tempList[i].list[1]
            else
                count.text = " "
            end
            local itemData = self:GetItemTable(tonumber(tempList[i].list[0]))
            icon.spriteName = itemData:GetIcon()
            local res, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tempList[i].list[0])
            CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = Info, showRight = false })
            end
        end
    end
end

---获取item表
function UIRechargePanel:GetItemTable(id)
    local LuaItemTable = clientTableManager.cfg_itemsManager:TryGetValue(id)
    return LuaItemTable
end

function UIRechargePanel:RefreshRewardList(itemlist)
    if itemlist == nil or CS.StaticUtility.IsNull(self:GetRewardItemList_GridContainer()) then
        return
    end

    local count = itemlist.Count
    ---计算不满三个的数目也就是多出来的数目
    local leaveNum = count % self:GetRewardItemList_GridContainer().MaxPerLine

    local SpecialShow = {}
    local FullShow = {}
    for i = 0, count - 1 do
        if i < leaveNum then
            table.insert(SpecialShow, itemlist[i])
        else
            table.insert(FullShow, itemlist[i])
        end
    end
    --self:GetCenterRewardList_GridContainer().gameObject:SetActive(#FullShow > 0)
    self:RefreshGridShow(self:GetCenterRewardList_GridContainer(), SpecialShow)
    self:RefreshGridShow(self:GetRewardItemList_GridContainer(), FullShow)
    local pos = self:GetCenterRewardList_GridContainer().gameObject.transform.localPosition
    local cellHeight = self:GetRewardItemList_GridContainer().CellHeight
    pos.y = pos.y + cellHeight
    self:GetCenterRewardList_GridContainer().gameObject.transform.localPosition = pos
end

---刷新（此处是原逻辑没有改动）
function UIRechargePanel:RefreshGridShow(container, data)
    container.MaxCount = #data
    for i = 0, #data - 1 do
        local showInfo = data[i + 1]
        local bagItemInfo
        local bagFind, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(showInfo.list[0])
        if (bagFind) then
            bagItemInfo = Info
        end
        if bagItemInfo ~= nil then
            local go = container.controlList[i]
            if (UIRechargePanel.GridDic[go] == nil) then
                UIRechargePanel.GridDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGridItem)
            end
            UIRechargePanel.GridDic[go]:RefreshUIWithItemInfo(bagItemInfo, bagItemInfo.count)
            UIRechargePanel.GridDic[go].bagItemInfo = bagItemInfo
            CS.Utility_Lua.GetComponent(go.transform:Find("bg"), "CSUIEffectLoad").effectId = showInfo.list[2]
            CS.Utility_Lua.GetComponent(go.transform:Find("count"), "Top_UILabel").text = showInfo.list[1] == 1 and "" or showInfo.list[1]
            CS.UIEventListener.Get(go).onClick = UIRechargePanel.OnCheckItemClicked
        end
    end
end

function UIRechargePanel.OnCheckItemClicked(go)
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        local itemTemp = UIRechargePanel.GridDic[go]
        if itemTemp ~= nil and itemTemp.ItemInfo ~= nil and itemTemp.ItemInfo ~= nil then
            --打开物品信息界面
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTemp.ItemInfo, showRight = false })
        end
    end
end

function UIRechargePanel:ShowLastRewardInfo(go)
    if self:GetRewardItemList_GridContainer() == nil then
        return
    end
    local count = self:GetRewardItemList_GridContainer().MaxCount
    if count == 0 then
        return
    end
    self.OnCheckItemClicked(self:GetRewardItemList_GridContainer().controlList[count - 1])
end

function UIRechargePanel:ContinueRechargeRepayBtnOnClick(go)
    self:OnSingleToggleClicked(LuaEnumRechargeType.AccumulatedRecharge)
end
--endregion

--region 充值
function UIRechargePanel:OnRechargeToggleChoose()
    --self:GetRechargeToggle():Set(true, true)
    self:ShowPanel(LuaEnumRechargeType.NormalRecharge)
    self:GetRechargeViewTemplate():ShowRechargeView(LuaEnumRechargeType.NormalRecharge);
end
--endregion

--region 领奖
function UIRechargePanel:RefreshRewardInfo()
    if self.PanelType == LuaEnumRechargeType.Reward then
        if self:GetPlayerCanReward() and self.mNeedRefreshOnLevelUp then
            self.mNeedRefreshOnLevelUp = false
            self:RewardMessageReceived()
        end
    end
end

function UIRechargePanel:GetPlayerCanReward()
    if self:GetPlayerInfo() and self:GetPlayerInfo().Level >= CS.Cfg_GlobalTableManager.Instance:GetRewardLevel() then
        return true
    end
    return false
end

function UIRechargePanel:OnRewardToggleChoose()
    self:ShowPanel(LuaEnumRechargeType.Reward)
    self:UpdateContinueRechargeList()
end

---收到服务器消息返回显示列表
function UIRechargePanel:RewardMessageReceived()
    if CS.StaticUtility.IsNull(self.go) then
        return
    end
    self:GetRewardScrollView():ResetPosition()
    if self:GetPlayerInfo() == nil then
        return
    end
    ---@type rechargegiftboxV2.RechargeGiftBoxInfo
    local csData = self:GetPlayerInfo().RechargeInfo.CurrentRechargeGiftBoxInfo
    self.onlineTime = csData.onlineGiftBoxInfo.onlineTime
    local tableData = gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetRechargeGiftBoxInfo()
    if csData == nil or tableData == nil then
        return
    end
    local isshow = false
    if (csData.continuousGiftBoxInfo.nowGroup ~= 0) then
        UIRechargePanel.mCurContinueGiftID = csData.lastCompleteCfgId
        UIRechargePanel.mContinousGiftBoxInfo = csData.continuousGiftBoxInfo
        UIRechargePanel.mContinueNowGroup = csData.continuousGiftBoxInfo.nowGroup
        UIRechargePanel.mContinueCanReceiveList = csData.continuousGiftBoxInfo.rewardInfo

        local count = UIRechargePanel.mContinueCanReceiveList.Count
        for i = 0, count - 1 do
            if (UIRechargePanel.mContinueCanReceiveList[i].receive == 1) then
                isshow = true
            end
        end
    else
        UIRechargePanel.mContinueNowGroup = 0
    end

    CS.CSScene.MainPlayerInfo.RechargeInfo.IsCanGetContinueReward = isshow
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_ContinueReward);
    --基础礼包列表
    self.ShowList = {}
    self.ShowPreferenceList = {}
    self.IsNeedReqGiftWithTimeOut = true
    --终身限购礼包列表
    self.LastRechargeList = {}
    CS.CSRechargeInfoV2.LastRechargeTableList:Clear()

    --region 添加在线列表
    local onlineRewardList = csData.onlineGiftBoxInfo.rewardInfo
    local canAdd = self:CanAddOnLineTime(onlineRewardList)
    if canAdd then
        ---@type rechargegiftboxV2.OnlineGiftBoxRewardInfo
        local onlineInfo = CS.CSRechargeInfoV2.GetShowOnLineInfo(onlineRewardList)
        if onlineInfo then
            local data = {}
            data.id = onlineInfo.id
            data.receive = onlineInfo.receive
            data.tableInfo = self:GetRewardTableData(onlineInfo.id)
            data.type = luaEnumRechargeRewardType.Online
            table.insert(self.ShowList, data)
        end
    else
        if onlineRewardList.Count > 0 then
            local onlineInfo = onlineRewardList[onlineRewardList.Count - 1]
            if onlineInfo ~= nil then
                local data = {}
                data.id = onlineInfo.id
                data.receive = onlineInfo.receive
                data.tableInfo = self:GetRewardTableData(onlineInfo.id)
                data.type = luaEnumRechargeRewardType.Online
                table.insert(self.ShowList, data)
            end
        end
    end
    --endregion

    --region 添加每日累充
    self:InsertDailyRechargeGiftBoxInfo(self.ShowList, tableData.dailyRechargeGiftBoxInfo);
    --endregion

    --region 添加累充列表
    --[[    if not self:GetPlayerInfo().RechargeInfo.isFirstRecharge then
            local totalRechargeRewardList = csData.totalRechargeGiftBoxInfo.TotalRechargeDataInfo
            ---@type rechargegiftboxV2.TotalRechargeDataInfo
            local rechargeInfo = CS.CSRechargeInfoV2.GetShowRechargeInfo(totalRechargeRewardList)
            print(rechargeInfo)
            if rechargeInfo then
                local data = {}
                data.id = rechargeInfo.id
                data.count = rechargeInfo.count
                data.totalCount = rechargeInfo.totalCount
                data.receive = rechargeInfo.state
                data.tableInfo = self:GetRewardTableData(rechargeInfo.id)
                data.type = luaEnumRechargeRewardType.Recharge
                table.insert(self.ShowList, data)
            end
        end]]
    --endregion

    local buyRewardList = csData.buyTimes
    --region 添加元宝礼包
    local openserverDays = CS.CSScene.MainPlayerInfo.ActualOpenDays
    self:AddIngotPurchaseReward(buyRewardList, openserverDays)
    --endregion

    --region 添加直购列表
    local buyInfo
    self.GMId = 0
    buyInfo, self.GMId = CS.CSRechargeInfoV2.GetBuyRewardInfo_LastRecharge(buyRewardList)
    local gminfo, info = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(self.GMId)
    if (gminfo) then
        UIRechargePanel.mBuyAllRewardInfo = info
    end
    self:AddBuyingReward(buyInfo, self.ShowPreferenceList, self.LastRechargeList)
    --endregion

    --region 添加领奖直购礼包
    local openserverDays = CS.CSScene.MainPlayerInfo.ActualOpenDays
    self:AddLingJiangDirectPurchaseGift(buyRewardList, openserverDays)
    --endregion

    if (self.PanelType == LuaEnumRechargeType.Reward) then
        self:SortShowList(self.ShowList)
        self:RefreshRewardShow(self:GetRewardShowList(), self.onlineTime)
    elseif (self.PanelType == LuaEnumRechargeType.PreferenceGift) then
        self:AddCircleDiamondGift()
    end

    local selectIndex = 0
    for i = 1, #self.ShowList do
        if self.ShowList[i].tableInfo.id == self.selectRewardID then
            selectIndex = i - 1
        end
    end
    self:lockSelectRewardColumn(selectIndex)

    self.AllTotalRechargeCount = csData.totalRechargeDiamondCount / 10
    local canShowBtn = CS.CSRechargeInfoV2.CanShowOneClickPurchaseBtn(buyRewardList)
    self.AllBuyBtnShow = self.AllTotalRechargeCount >= 500 and canShowBtn and CS.CSScene.MainPlayerInfo.OpenServerDayNumber >= 1
    --self:GetOneClickPurchaseBtn_GameObject():SetActive(self.AllBuyBtnShow and self.PanelType == LuaEnumRechargeType.Reward)
    self:GetOneClickPurchaseBtn_GameObject():SetActive(false)
    --self:GetRewardToggle_UIGrid():Reposition()
    -- self:ResetBookMark()

    self.mCurrentChooseBookMarkTime = CS.UnityEngine.Time.time
end

--region 循环钻石礼包
---添加循环钻石礼包
function UIRechargePanel:UpdateCircleDiamondGift(luadata)
    self.CircleDiamondGiftList = {}
    for i = 1, #luadata.giftBoxInfo do
        local tableinfo = self:GetBuyTableData(luadata.giftBoxInfo[i].id)
        local data = {}
        data.id = luadata.giftBoxInfo[i].id
        data.tableInfo = tableinfo
        data.refreshType = luadata.giftBoxInfo[i].refreshType
        data.type = luaEnumRechargeRewardType.CircleDiamondGift
        if (CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(LuaEnumStoreType.CircleDiamondRechargeGift)
                and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.CircleDiamondRechargeGift].storeUnitDic:TryGetValue(tableinfo.storeIndex)) then
            table.insert(self.CircleDiamondGiftList, data)
        end
    end
end

function UIRechargePanel:AddCircleDiamondGift()
    self:RefreshRewardShow(self:GetPreferenceShowList(), self.onlineTime)
end

---移除循环钻石礼包
function UIRechargePanel:ClearCircleDiamondGift()
    local index = 1
    while index <= #self.ShowList do
        if (self.ShowList[index].type == luaEnumRechargeRewardType.CircleDiamondGift) then
            table.remove(self.ShowList, index)
        end
        index = index + 1
    end
end

--endregion

---领奖页签内礼包（累充和在线、循环礼包）
function UIRechargePanel:GetRewardShowList()
    local finalShowList = {}
    if self.ShowList then
        for i = 1, #self.ShowList do
            table.insert(finalShowList, self.ShowList[i])
        end
    end
    if self.CircleDiamondGiftList then
        ---不满足 开服前7天98元首充是未领取完时 不显示
        if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFinishReceivingTheFirstRechargeReward()) then
            for i = 1, #self.CircleDiamondGiftList do
                table.insert(finalShowList, self.CircleDiamondGiftList[i])
            end
        end
    end
    self:SortShowList(finalShowList)
    return finalShowList
end

---获取特惠礼包
function UIRechargePanel:GetPreferenceShowList()
    local finalShowList = {}
    if (self.ShowPreferenceList ~= nil) then
        for i = 1, #self.ShowPreferenceList do
            table.insert(finalShowList, self.ShowPreferenceList[i])
        end
    end
    self:SortShowList(finalShowList)
    return finalShowList
end
---@return boolean 是否可添加在线礼包
function UIRechargePanel:CanAddOnLineTime(onlineRewardList)
    if onlineRewardList == nil or onlineRewardList.Count < 5 then
        return true
    end
    for i = 0, onlineRewardList.Count - 1 do
        ---@type rechargegiftboxV2.OnlineGiftBoxRewardInfo
        local singleData = onlineRewardList[i]
        if singleData and singleData.receive ~= 1 then
            return true
        end
    end
    return false
end

---插入每日累充信息 (PS: 每日累充最多显示1条数据)
---@param table 最后显示的礼包列表数据table
---@param dailyRechargeGiftBoxInfo rechargegiftboxV2.DailyRechargeGiftBoxInfo
function UIRechargePanel:InsertDailyRechargeGiftBoxInfo(showTable, dailyRechargeGiftBoxInfo)
    if (dailyRechargeGiftBoxInfo == nil) then
        return ;
    end
    ---不满足 开服前7天98元首充是未领取完时 不显示
    if (not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFinishReceivingTheFirstRechargeReward()) then
        return
    end
    --奖励信息
    ---@type rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo
    local dailyRechargeGiftBoxRewardInfoList = dailyRechargeGiftBoxInfo.rewardInfo
    local onlyShow = nil
    local index = 0
    for i, dailyRechargeGiftBoxRewardInfo in pairs(dailyRechargeGiftBoxRewardInfoList) do
        ---只显示正在进行中的(还未领取的那个)

        index = index + 1
        local islastObj = index == #dailyRechargeGiftBoxRewardInfoList
        if (dailyRechargeGiftBoxRewardInfo.status ~= 2) or islastObj then
            local data = {}
            data.id = dailyRechargeGiftBoxRewardInfo.id
            data.receive = dailyRechargeGiftBoxRewardInfo.status
            data.remainRecharge = dailyRechargeGiftBoxRewardInfo.remainRecharge
            data.tableInfo = self:GetRewardTableData(dailyRechargeGiftBoxRewardInfo.id)
            data.type = luaEnumRechargeRewardType.DayRecharge

            if (onlyShow == nil or data.tableInfo.sequence < onlyShow.tableInfo.sequence) then
                onlyShow = data;
            end
        end

    end
    if (onlyShow ~= nil) then
        table.insert(showTable, onlyShow)
    end
end

---根据类型筛选不同的充值优先级, 数值越小越优先
function UIRechargePanel:GetRechargeTypePriority(type)
    if (type == 1) then
        return 10;
    end
    if (type == 4) then
        return 100;
    end

    return 1000
end

---对显示的列表进行排序,直购和限时按照
function UIRechargePanel:SortShowList(showList)
    if showList == nil then
        return
    end
    ---当前仅对直购和限时礼包进行排序(领奖中当前只有这两个类型礼包),根据礼包的价格从前往后排序
    table.sort(showList, function(left, right)
        if left == nil or right == nil or left.tableInfo == nil or right.tableInfo == nil then
            return false
        end
        left.priority = self:GetRechargeTypePriority(left.tableInfo.type);
        right.priority = self:GetRechargeTypePriority(right.tableInfo.type);

        if (left.priority < right.priority) then
            return true
        elseif (left.priority > right.priority) then
            return false
        end
        if (left.tableInfo.type == 3) then
            return true
        end

        if left.tableInfo.type ~= 6 and right.tableInfo.type == 6 then
            return false
        end
        if left.tableInfo.type == 6 and right.tableInfo.type ~= 6 then
            return true
        end

        if ((left.tableInfo.type == 13 and right.tableInfo.type == 13)) then
            return left.tableInfo.index < right.tableInfo.index
        end

        if ((left.tableInfo.index == 1 and right.tableInfo.index ~= 1) or (left.tableInfo.index ~= 1 and right.tableInfo.index == 1)) then
            return left.tableInfo.index < right.tableInfo.index
        end

        if left.rmbCount == nil then
            if left.tableInfo.clientPrice ~= 0 then
                left.rmbCount = left.tableInfo.clientPrice
            else
                left.rmbCount = left.tableInfo.rmb
            end
        end
        if right.rmbCount == nil then
            if right.tableInfo.clientPrice ~= 0 then
                right.rmbCount = right.tableInfo.clientPrice
            else
                right.rmbCount = right.tableInfo.rmb
            end
        end
        if left.rmbCount ~= right.rmbCount then
            return left.rmbCount < right.rmbCount
        else
            if left.tableInfo.isTimeLimit == right.tableInfo.isTimeLimit then
                return false
            else
                if left.tableInfo.isTimeLimit == 1 then
                    return true
                else
                    return false
                end
            end
        end
    end)
end

---添加元宝礼包
function UIRechargePanel:AddIngotPurchaseReward(buyInfo, openServerDay)
    for i = 0, buyInfo.Count - 1 do
        ---@type rechargegiftboxV2.RechargeGiftTimes
        local rechargeGiftTimes = buyInfo[i]
        local tableinfo = self:GetBuyTableData(buyInfo[i].id)
        if (tableinfo ~= nil and tableinfo.type == LuaEnumRechargeType.IngotPurchase) then
            ---@type TABLE.CFG_RECHARGE
            if (tableinfo ~= nil and self:IsOpenDaysEnough(openServerDay, tableinfo.effectiveTime) and buyInfo[i].todayBuyTimes < 1) then
                local data = {}
                data.id = tableinfo.id
                data.type = luaEnumRechargeRewardType.IngotRecharge
                data.tableInfo = tableinfo
                if (tableinfo.storeIndex ~= 0) then
                    if (CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(LuaEnumStoreType.DiamondRechargeGift)
                            and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.DiamondRechargeGift].storeUnitDic:TryGetValue(tableinfo.storeIndex)) then
                        table.insert(self.ShowPreferenceList, data)
                    end
                else
                    table.insert(self.ShowPreferenceList, data)
                end
            end
        end
    end
end

---添加领奖直购礼包
function UIRechargePanel:AddLingJiangDirectPurchaseGift(buyInfo, openServerDay)
    ---不满足 开服前7天98元首充是未领取完时 不显示
    if (not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFinishReceivingTheFirstRechargeReward()) then
        return
    end
    for i = 0, buyInfo.Count - 1 do
        ---@type rechargegiftboxV2.RechargeGiftTimes
        local rechargeGiftTimes = buyInfo[i]
        local tableinfo = self:GetBuyTableData(buyInfo[i].id)
        if tableinfo ~= nil and tableinfo.type == LuaEnumRechargeType.DirectPurchase and tableinfo.isTimeLimit == LuaEnumRechargeMainBookMarkType.Activity then
            local conditionList = Utility.ChangeNumberTable(string.Split(tableinfo.conditions, '#'))
            local conditionResult = #conditionList <= 0 or Utility.IsMainPlayerMatchConditionList_AND(conditionList).success
            local canBuy = rechargeGiftTimes.todayBuyTimes < tableinfo.limitCount
            if conditionResult == true and canBuy == true then
                local data = {}
                data.id = rechargeGiftTimes.id
                data.receive = nil
                data.tableInfo = tableinfo
                data.type = luaEnumRechargeRewardType.LastRecharge
                table.insert(self.ShowList, data)
            end
        end
    end
end

function UIRechargePanel:IsOpenDaysEnough(OpenDays, LimitTime)
    if (LimitTime.list.Count >= 2 and OpenDays >= LimitTime.list[0] and OpenDays <= LimitTime.list[1]) then
        return true
    end
    return false
end

--region 添加礼包
---添加直购礼包
function UIRechargePanel:AddBuyingReward(buyInfo, ShowList, LastRechargeList)
    local addNum = 0
    local sortTable = {}
    for i = 0, buyInfo.Count - 1 do
        local id = buyInfo[i]
        table.insert(sortTable, id)
    end
    table.sort(sortTable, self.SortBuyingReward)
    CS.CSRechargeInfoV2.LastRechargeTableList:Clear()
    for j = 1, #sortTable do
        local id = sortTable[j]
        local data = {}
        data.id = id
        local tableInfo = self:GetBuyTableData(id)
        data.tableInfo = tableInfo
        if (tableInfo.isTimeLimit == 2) then
            --终生限购礼包
            if (LastRechargeList ~= nil) then
                data.type = luaEnumRechargeRewardType.LastRecharge
                table.insert(LastRechargeList, data)
                CS.CSRechargeInfoV2.LastRechargeTableList:Add(tableInfo)
            end
        else
            data.type = tableInfo.isTimeLimit == 1 and luaEnumRechargeRewardType.LimitBuy or luaEnumRechargeRewardType.Buy
            if tableInfo.isTimeLimit == 1 then
                if (tableInfo.conditions ~= nil) then
                    local conditionList = string.Split(tableInfo.conditions, '&')
                    if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(conditionList)) then
                        local days = tableInfo.effectiveTime
                        if CS.CSRechargeInfoV2.IsShowReward(days) then
                            table.insert(ShowList, data)
                        end
                    end
                else
                    local days = tableInfo.effectiveTime
                    if CS.CSRechargeInfoV2.IsShowReward(days) then
                        table.insert(ShowList, data)
                    end
                end
            else
                if (UIRechargePanel.AllTotalRechargeCount >= 20000) then
                    table.insert(ShowList, data)
                else
                    if addNum < 7 then
                        table.insert(ShowList, data)
                        addNum = addNum + 1
                    end
                end
            end
        end
    end
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_LastRecharge);
end

---直购排序
function UIRechargePanel.SortBuyingReward(left, right)
    local leftTableInfo = UIRechargePanel:GetBuyTableData(left)
    local rightTableInfo = UIRechargePanel:GetBuyTableData(right)
    local leftrmb = 0
    local rightrmb = 0
    if (leftTableInfo.clientPrice ~= 0) then
        leftrmb = leftTableInfo.clientPrice
        rightrmb = rightTableInfo.clientPrice
    else
        leftrmb = leftTableInfo.rmb
        rightrmb = rightTableInfo.rmb
    end

    if leftrmb == rightrmb then
        if leftTableInfo.isTimeLimit == rightTableInfo.isTimeLimit then
            return false
        else
            if leftTableInfo.isTimeLimit == 1 then
                return true
            else
                return false
            end
        end
    else
        return leftrmb < rightrmb
    end
end

--endregion

---刷新列表显示
function UIRechargePanel:RefreshRewardShow(ShowList, onlineTime)
    if not CS.StaticUtility.IsNull(self:GetReward_UILoopScrollViewPlus()) then
        self:GetReward_UILoopScrollViewPlus():Init(function(go, line)
            --if (UIRechargePanel.AllTotalRechargeCount <= 2000) then
            local count = #ShowList <= 6 and #ShowList or 6
            if line < count then
                ---只显示5个礼包
                local data = ShowList[line + 1]
                local template = self:GetRewardTemplate(go)
                if template then
                    template:Refresh(data, onlineTime, self.selectRewardID)
                end
                return true
            else
                return false
            end
            --else
            --    if line < #ShowList then
            --        ---全显示
            --        local data = ShowList[line + 1]
            --        local template = self:GetRewardTemplate(go)
            --        if template then
            --            template:Refresh(data, onlineTime, self.selectRewardID)
            --        end
            --        return true
            --    else
            --        return false
            --    end
            --end

            self.NeedShowArrow = #ShowList > 3
            self:RewardRefreshArrow()
        end, nil)
        if (self.PanelType == LuaEnumRechargeType.Reward and not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFinishReceivingTheFirstRechargeReward()) then
            if (CenterOnChild == nil) then
                CenterOnChild = CS.Utility_Lua.AddComponent(self:GetReward_UILoopScrollViewPlus().gameObject, "Top_UICenterOnChild")
            end
            CenterOnChild.enabled = true;
            CenterOnChild:Recenter();
        end
    end
end

---锁定到选中的奖励宝箱栏目
---@param selectIndex int 当前选中的宝箱下标
function UIRechargePanel:lockSelectRewardColumn(selectIndex)
    if selectIndex < 3 then
        return
    end
    local clipOffset = 315 * (selectIndex - 2)
    local transform = self:GetRewardUIPanel().gameObject.transform.localPosition
    transform.x = -clipOffset
    self:GetRewardUIPanel().gameObject.transform.localPosition = transform;
    self:GetRewardUIPanel().clipOffset = CS.UnityEngine.Vector2(clipOffset, 0);
end

---@param showTable table 显示表
---@param shareInfo rechargegiftboxV2.ShareGiftBoxRewardInfo 分享礼包信息
function UIRechargePanel:AddShareData(showTable, shareData)
    local data = {}
    data.id = shareData.id
    data.receive = shareData.receive
    local tableInfo = self:GetRewardTableData(shareData.id)
    data.tableInfo = tableInfo
    data.type = luaEnumRechargeRewardType.Share
    if tableInfo then
        table.insert(showTable, data)
    end
end

---@return TABLE.CFG_LINGJIANG_REWARD 缓存表格数据
function UIRechargePanel:GetRewardTableData(id)
    if self.mIdToRewardInfo == nil then
        self.mIdToRewardInfo = {}
    end
    local data = self.mIdToRewardInfo[id]
    if data == nil then
        ___, data = CS.Cfg_LingJiang_RewardTableManager.Instance.dic:TryGetValue(id)
        self.mIdToRewardInfo[id] = data
    end
    return data
end

---@return TABLE.CFG_RECHARGE 充值表
function UIRechargePanel:GetBuyTableData(id)
    if self.mIdToBuyTableInfo == nil then
        self.mIdToBuyTableInfo = {}
    end
    local data = self.mIdToBuyTableInfo[id]
    if data == nil then
        ___, data = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(id)
        self.mIdToBuyTableInfo[id] = data
    end
    return data
end

---@param go UnityEngine.GameObject
---@return UIRechargeRewardTemplate
function UIRechargePanel:GetRewardTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIRechargeRewardTemplate, self)
    end
    return template
end

---领奖刷新箭头
function UIRechargePanel:RewardRefreshArrow()
    self:GetArrow_GameObject():SetActive(self.NeedShowArrow and self.PanelType == LuaEnumRechargeType.Reward)
    if self.NeedShowArrow then
        local state = self:GetReward_UIScrollView():GetScrollViewSoftState(false)
        local numState = Utility.EnumToInt(state)
        self:GetLeftArrow_TweenAlpha().gameObject:SetActive(numState ~= 1)
        self:GetRightArrow_TweenAlpha().gameObject:SetActive(numState ~= 3)
        self:GetLeftArrow_TweenAlpha():PlayTween()
        self:GetRightArrow_TweenAlpha():PlayTween()
    end
end

---一键直购
function UIRechargePanel.OnOneClickPurchaseBtnClicked()
    if (UIRechargePanel.mBuyAllRewardInfo ~= nil) then
        if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
            UIRechargePanel.SetRechargePoint()
            if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                networkRequest.ReqGM("@43 " .. tostring(UIRechargePanel.mBuyAllRewardInfo.id))
            else
                local data = Utility:GetPayData(UIRechargePanel.mBuyAllRewardInfo)
                if (data ~= nil) then
                    CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                end
            end
        end
    end
    --networkRequest.ReqGM("@43 " .. tostring(self.GMId))
end

---@return TABLE.CFG_ITEMS 获取道具缓存信息
function UIRechargePanel:GetItemInfoCache(itemId)
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

---@return TABLE.CFG_DESCRIPTION 帮助描述
function UIRechargePanel:GetRechargeHelpDes()
    if self.mRechargeHelpDes == nil then
        ___, self.mRechargeHelpDes = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(132)
    end
    return self.mRechargeHelpDes
end
--endregion

--region 连续充值
function UIRechargePanel:GetContinueRewardInfoBySmallID(index)
    return UIRechargePanel.mContinueCanReceiveList[index - 1]
end

function UIRechargePanel:OnContinueRechargeToggleChoose()
    self:ShowPanel(LuaEnumRechargeType.ContinueRecharge)
    self:UpdateContinueRechargeList()
end

function UIRechargePanel:OnLastRechargeToggleChoose()
    CS.CSScene.MainPlayerInfo.RechargeInfo.isFirstShowLastRechargeRedPoint = false
    self:ShowPanel(LuaEnumRechargeType.LastRecharge)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_LastRecharge);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge);
end

function UIRechargePanel:UpdateContinueRechargeList()
    local csData = self:GetPlayerInfo().RechargeInfo.CurrentRechargeGiftBoxInfo
    if csData == nil then
        return
    end
    local nowGroupID = csData.continuousGiftBoxInfo.nowGroup
    local ReceiveListCount = UIRechargePanel.mContinueCanReceiveList.Count
    --当前组别的奖励列表（全）
    ---Dictionary<int, TABLE.CFG_CONTINUOUS_RECHARGE>
    local RewardDic = CS.Cfg_ContinueRechargeTableManager.Instance:GetGroupData(nowGroupID)

    if (RewardDic == nil) then
        return
    end
    --已经领取的奖励列表
    local isReceiveList = {}
    --可以领取但未领取的奖励列表
    local unReceiveList = {}
    for i = 0, ReceiveListCount - 1 do
        local num = gameMgr:GetPlayerDataMgr():GetRechargeInfo():Cfg_ContinueRechargeTableManager_GetRewardSmallID(nowGroupID, UIRechargePanel.mContinueCanReceiveList[i].id)
        if (UIRechargePanel.mContinueCanReceiveList[i].receive == 2) then
            table.insert(isReceiveList, num)
        else
            table.insert(unReceiveList, num)
        end
    end

    ---新加~~~~
    local RewardCount = RewardDic.Count - Utility.GetLuaTableCount(isReceiveList)
    self:GetContinueRechargeGridContainer().MaxCount = RewardCount
    local isReceiveCount = Utility.GetLuaTableCount(isReceiveList)
    local unindex = 1
    --用于获取已跳过领奖的间隔
    local receiveIndex = 1
    for i = 0, RewardCount - 1 do
        local gobj = self:GetContinueRechargeGridContainer().controlList[i];
        if (self.mContinueRechargeTemDic[i] == nil) then
            self.mContinueRechargeTemDic[i] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIContinueRechargeUnitTemplate, self);
        end
        --已经领取奖励的ID
        if (receiveIndex <= isReceiveCount) then
            local cur = false
            for j = receiveIndex, isReceiveCount do
                if (isReceiveList[receiveIndex] == i + j) then
                    receiveIndex = receiveIndex + 1
                else
                    if (cur == false) then
                        local isfind, info = RewardDic:TryGetValue(i + j)
                        if (isfind) then
                            self.mContinueRechargeTemDic[i]:Refresh(info)
                        end
                        break
                    end
                end
                if (cur == false) then
                    local isfind, info = RewardDic:TryGetValue(i + receiveIndex)
                    if (isfind) then
                        self.mContinueRechargeTemDic[i]:Refresh(info)
                    end
                end
            end
        else
            if (i + receiveIndex > RewardDic.Count) then
                local isfind, info = RewardDic:TryGetValue(isReceiveList[unindex])
                if (isfind) then
                    self.mContinueRechargeTemDic[i]:Refresh(info, true)
                    unindex = unindex + 1
                end
            else
                local isfind, info = RewardDic:TryGetValue(i + receiveIndex)
                if (isfind) then
                    self.mContinueRechargeTemDic[i]:Refresh(info)
                end
            end
        end
    end
end

function UIRechargePanel:UpdateContinueRechargePanelTitleAndSlogan()
    if (self:GetRechargeDic() ~= nil and UIRechargePanel.mContinueNowGroup ~= 0) then
        self:GetContinueRechargeTitle_UISprite().spriteName = self:GetRechargeDic()[UIRechargePanel.mContinueNowGroup].slogan_left
        self:GetContinueRechargeTitle_UISprite():MakePixelPerfect()
        self:GetContinueRechargeSlogan_UISprite().spriteName = self:GetRechargeDic()[UIRechargePanel.mContinueNowGroup].slogan_right
        self:GetContinueRechargeSlogan_UISprite():MakePixelPerfect()
    end
end

---更新连充大奖模型
---@param ObservationModel ObservationModel
---@param ModelRootGO UnityEngine.GameObject
function UIRechargePanel:UpdateModel(ObservationModel, ModelRootGO)
    if ObservationModel == nil or CS.StaticUtility.IsNull(ModelRootGO) then
        return
    end
    local gender = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    local ModelId = 0
    local tempId
    if (self:GetRechargeDic() ~= nil and UIRechargePanel.mContinueNowGroup ~= 0) then
        tempId = self:GetRechargeDic()[UIRechargePanel.mContinueNowGroup].model.list
    end
    if tempId ~= nil then
        for i = 0, tempId.Count - 1 do
            if gender == tempId[i].list[1] then
                ModelId = tempId[i].list[0]
            end
        end
    end
    ---ModelId =500005
    if self.mContinueRechargeNpcModelID == ModelId then
        return
    end
    self.mContinueRechargeNpcModelID = ModelId
    if self.mContinueRechargeNpcModelID == nil or self.mContinueRechargeNpcModelID == 0 then
        ObservationModel:ClearModel()
        self.mContinueRechargeNpcModelID = nil
        return
    end

    ObservationModel:ClearModel()
    ObservationModel:SetShowMotion(CS.CSMotion.ShowStand)
    ObservationModel:SetPosition(CS.UnityEngine.Vector3(0, -180, 0))
    ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
    ObservationModel:SetBindRenderQueue()
    ObservationModel:SetDragRoot(ModelRootGO)
    ObservationModel:CreateModel(self.mContinueRechargeNpcModelID, CS.EAvatarType.Monster, ModelRootGO.transform, function()
        ObservationModel:ResetCurScale()
    end)
end
--endregion

--region 服务器消息
function UIRechargePanel:RefreshCircleDiamondGiftList(id, data)
    if (self.PanelType == LuaEnumRechargeType.Reward) then
        self:UpdateCircleDiamondGift(data)
        self.mCurrentChooseBookMarkTime = CS.UnityEngine.Time.time
    end
end

function UIRechargePanel.ResVipInfo(id, data)
    UIRechargePanel.TotalRechargeAmount = data.monthRechargeDiamond
end

function UIRechargePanel.ResRoleVipInfoChangeMessageInfo(id, data)
    if (UIRechargePanel.PanelType == LuaEnumRechargeType.NormalRecharge) then
        UIRechargePanel:GetRechargeViewTemplate():ShowRechargeView(LuaEnumRechargeType.NormalRecharge)
    end
end

---@param csData rechargegiftboxV2.RechargeGiftBoxInfo
function UIRechargePanel.RefreshRechargeGiftBox(id, data, csData)
    if data == nil then
        return
    end
    local isShowContinueRecharge = data.continuousGiftBoxInfo.nowGroup ~= 0
    UIRechargePanel.mIsOpenContinueRecharge = isShowContinueRecharge
    UIRechargePanel.FirstRechargeGiftBoxList = {}
    CS.Cfg_GlobalTableManager.Instance.FirstRechargeGiftBoxList:Clear()
    for i = 1, #data.buyTimes do
        if (data.buyTimes[i].resetOpenServerDay) then
            table.insert(UIRechargePanel.FirstRechargeGiftBoxList, data.buyTimes[i].id)
            CS.Cfg_GlobalTableManager.Instance.FirstRechargeGiftBoxList:Add(data.buyTimes[i].id)
        end
    end
    if (UIRechargePanel.PanelType == LuaEnumRechargeType.Reward and UIRechargePanel.mIsOpenContinueRecharge) then
        UIRechargePanel:UpdateContinueRechargeList()
    elseif (UIRechargePanel.PanelType == LuaEnumRechargeType.NormalRecharge) then
        UIRechargePanel:ShowPanel(UIRechargePanel.PanelType)
        UIRechargePanel:GetRechargeViewTemplate():ShowRechargeView(LuaEnumRechargeType.NormalRecharge);
    elseif (UIRechargePanel.PanelType == LuaEnumRechargeType.LastRecharge) then
        if (Utility.GetLuaTableCount(UIRechargePanel.LastRechargeList) == 0) then
            UIRechargePanel:ShowPanel(LuaEnumRechargeType.NormalRecharge)
        else
            UIRechargePanel:ShowPanel(UIRechargePanel.PanelType)
        end
    end
end
--endregion

--region 投资

function UIRechargePanel:InitInvestmentInfo()
    local isopen1 = false
    local isopen2 = false
    local InvestmentMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr()
    if InvestmentMgr ~= nil then
        isopen1 = InvestmentMgr:GetOneTurmDic() ~= nil
        isopen2 = InvestmentMgr:GetTwoTurmDic() ~= nil
    end
    --[[    self:Getbtn_Investment1().gameObject:SetActive(isopen1)
        self:Getbtn_Investment2().gameObject:SetActive(isopen2)]]
    if isopen1 == true then
        self:Getbtn_Investment1_Label1().text = InvestmentMgr:GetOneTurmDic():GetTurmName()
        self:Getbtn_Investment1_Label2().text = InvestmentMgr:GetOneTurmDic():GetTurmName()
    end
    if isopen2 == true then
        self:Getbtn_Investment2_Label1().text = InvestmentMgr:GetTwoTurmDic():GetTurmName()
        self:Getbtn_Investment2_Label2().text = InvestmentMgr:GetTwoTurmDic():GetTurmName()
    end
    -- self:GetRewardToggle_UIGrid():Reposition()
end

---返回投资计划数据
function UIRechargePanel:ResInvestPlanDataMessage()
    self:InitInvestmentInfo()
end

---点击投资1
function UIRechargePanel:OnClickInvestment1()
    self:ShowPanel(LuaEnumRechargeType.Investment1)
    local InvestmentMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr()
    if InvestmentMgr ~= nil and InvestmentMgr:GetOneTurmDic() ~= nil then
        InvestmentMgr:GetOneTurmDic().isStartSignRedData = true
        InvestmentMgr:UpdateRedData()
        InvestmentMgr:GetOneTurmDic().turm.PanelLayerType = self.mPanelLayerType;
        uimanager:CreatePanel("UISevenDayInvestmentPanel", nil, InvestmentMgr:GetOneTurmDic().turm)
    end
end

---点击投资2
function UIRechargePanel:OnClickInvestment2()
    self:ShowPanel(LuaEnumRechargeType.Investment2)
    local InvestmentMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr()
    if InvestmentMgr ~= nil and InvestmentMgr:GetOneTurmDic() ~= nil then
        InvestmentMgr:GetTwoTurmDic().isStartSignRedData = true
        InvestmentMgr:UpdateRedData()
        InvestmentMgr:GetTwoTurmDic().turm.PanelLayerType = self.mPanelLayerType;
        uimanager:CreatePanel("UISevenDayInvestmentPanel", nil, InvestmentMgr:GetTwoTurmDic().turm)
    end
end

---点击累计充值
function UIRechargePanel:OnClickAccumulatedRecharge()
    self:ShowPanel(LuaEnumRechargeType.AccumulatedRecharge)
    local AccumulatedRechargePanel = uimanager:GetPanel("UIAccumulatedRechargePanel")
    if AccumulatedRechargePanel then
        AccumulatedRechargePanel:ReShowSelf()
    else
        uimanager:CreatePanel("UIAccumulatedRechargePanel", nil, { Period = 1, PanelLayerType = self.mPanelLayerType })
    end
end
--endregion

--region 潜能投资
function UIRechargePanel:OnClickPotentialInvest()
    self:ShowPanel(LuaEnumRechargeType.PotentialInvest)
    local PotentialInvestPanel = uimanager:GetPanel("UIPotentialInvestPanel")
    if PotentialInvestPanel then
        PotentialInvestPanel:ReShowSelf()
        PotentialInvestPanel:Show()
    else
        uimanager:CreatePanel("UIPotentialInvestPanel", nil, { PanelLayerType = self.mPanelLayerType })
    end
end
--endregion

--region 特惠礼包点击事件
function UIRechargePanel:OnClickPreferenceGift()
    self:ShowPanel(LuaEnumRechargeType.PreferenceGift)
end
--endregion

--region 累充
function UIRechargePanel:RefreshContinueBtnEffect()
    local isShow = gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():IsShowRedPoint()
    self:GetContinueRepayBtnEffect_GameObject():SetActive(isShow)
end
--endregion

function update()
    if UIRechargePanel.mIsNeedRequestRechargeGiftBoxAgain then
        UIRechargePanel.mIsNeedRequestRechargeGiftBoxAgain = nil
        networkRequest.ReqRechargeGiftBox()
    end

    if UIRechargePanel.mCurrentChooseBookMarkTime and CS.UnityEngine.Time.time - UIRechargePanel.mCurrentChooseBookMarkTime >= 0.1 then
        UIRechargePanel:ResetBookMark()
        UIRechargePanel.mCurrentChooseBookMarkTime = nil
    end
end

function ondestroy()
    uimanager:ClosePanel("UISevenDayInvestmentPanel")
    uimanager:ClosePanel("UIAccumulatedRechargePanel")
    uimanager:ClosePanel("UIPotentialInvestPanel")
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRoleVipInfoMessage, UIRechargePanel.ResVipInfo)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUpdateRechargeGiftBoxMessage, UIRechargePanel.RefreshRechargeGiftBox)
end

return UIRechargePanel