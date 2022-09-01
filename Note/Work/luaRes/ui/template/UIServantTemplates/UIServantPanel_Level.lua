---灵兽升级面板
---@class UISelf_Level:UIServantBasicPanel
local UIself_Level = {}

setmetatable(UIself_Level, luaComponentTemplates.UIServantBasicPanel)

UIself_Level.self = nil;
UIself_Level.LevelUpContinues = false
UIself_Level.isRunningUpLevel = false
UIself_Level.MoreLevelUp = false
UIself_Level.LevelUpData = nil
UIself_Level.ExpBarSpeed = 0.5
--region 属性
--region 升级组件
function UIself_Level:GetLevelupeffect_GameObject()
    if (self.levelupEffectGo == nil) then
        self.levelupEffectGo = self:Get("view/lv_bg/levelupeffect", "GameObject")
    end
    return self.levelupEffectGo
end

function UIself_Level:GetLevelHighLight_GameObject()
    if (self.roleexplight == nil) then
        self.roleexplight = self:Get("view/lv_bg/roleexplight", "GameObject")
    end
    return self.roleexplight
end

function UIself_Level:GetAddExpBtn_GameObject()
    if (self.mAddExpBtn == nil) then
        self.mAddExpBtn = self:Get("events/btn_addnum", "GameObject")
    end
    return self.mAddExpBtn
end

function UIself_Level:GetPracticeBtn_GameObject()
    if (self.mPracticeBtn == nil) then
        self.mPracticeBtn = self:Get("events/btn_practice", "GameObject")
    end
    return self.mPracticeBtn
end

function UIself_Level:GetLevelBar_FillTween()
    if (self.mLevelBarTween == nil) then
        self.mLevelBarTween = self:Get("view/lv_bg/roleexp", "Top_FillTween")
    end
    return self.mLevelBarTween
end

function UIself_Level:GetLevelBar_UISprite()
    if (self.mLevelBar == nil) then
        self.mLevelBar = self:Get("view/lv_bg/roleexp", "UISprite")
    end
    return self.mLevelBar
end

function UIself_Level:GetLevelBar_CSValueTween()
    if (self.mLevelBarCSValueTween == nil) then
        self.mLevelBarCSValueTween = self:Get("view/lv_bg/roleexp", "CSValueTween")
    end
    return self.mLevelBarCSValueTween
end

function UIself_Level:GetLevelBg_GameObject()
    if (self.mLevelBg == nil) then
        self.mLevelBg = self:Get("view/lv_bg", "GameObject")
    end
    return self.mLevelBg
end

function UIself_Level:GetLevelExp_UILabel()
    if (self.mLevelExp == nil) then
        self.mLevelExp = self:Get("view/lv_bg/roleexpvalue", "UILabel")
    end
    return self.mLevelExp
end

function UIself_Level:GetLevelLv_UILabel()
    if (self.mLevelLv == nil) then
        self.mLevelLv = self:Get("view/lv_bg/lv", "UILabel")
    end
    return self.mLevelLv
end

function UIself_Level:GetLevelMax_GameObject()
    if (self.mLevelMax == nil) then
        self.mLevelMax = self:Get("view/LevelMax", "GameObject")
    end
    return self.mLevelMax
end

function UIself_Level:GetLevelPanelPoolExp_UILabel()
    if (self.mLevelPanelLevelPanelPoolExp == nil) then
        self.mLevelPanelLevelPanelPoolExp = self:Get("view/expPool", "UILabel")
    end
    return self.mLevelPanelLevelPanelPoolExp
end
--endregion
function UIself_Level:GetBodyAttribute_GameObject()
    if self.mBodyAttribute == nil then
        self.mBodyAttribute = self:Get("view/attribute", "GameObject")
    end
    return self.mBodyAttribute
end

--region 按钮
function UIself_Level:GetLevelUpBtn_GameObject()
    if (self.mLevelBtn == nil) then
        self.mLevelBtn = self:Get("events/btn_lvup", "GameObject")
    end
    return self.mLevelBtn
end

function UIself_Level:GetLevelHelp_GameObject()
    if self.mLevelHelp == nil then
        self.mLevelHelp = self:Get("btn_help", "GameObject")
    end
    return self.mLevelHelp
end

function UIself_Level:GetExpBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:Get("view/reinLevel/Sprite", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

function UIself_Level:GetUpArrow_GameObject()
    if (self.mUpArrow_GameObject == nil) then
        self.mUpArrow_GameObject = self:Get("view/UpArrow", "GameObject");
    end
    return self.mUpArrow_GameObject;
end

function UIself_Level:GetUpArrow_TweenAlpha()
    if (self.mUpArrow_TweenAlpha == nil) then
        self.mUpArrow_TweenAlpha = self:Get("view/UpArrow", "Top_TweenAlpha");
    end
    return self.mUpArrow_TweenAlpha;
end

function UIself_Level:GetDownArrow_GameObject()
    if (self.mDownArrow_GameObject == nil) then
        self.mDownArrow_GameObject = self:Get("view/DownArrow", "GameObject");
    end
    return self.mDownArrow_GameObject;
end

function UIself_Level:GetDownArrow_TweenAlpha()
    if (self.mDownArrow_TweenAlpha == nil) then
        self.mDownArrow_TweenAlpha = self:Get("view/DownArrow", "Top_TweenAlpha");
    end
    return self.mDownArrow_TweenAlpha;
end

function UIself_Level:GetUseTipsText_GameObject()
    if (self.mUseTipsText_GameObject == nil) then
        self.mUseTipsText_GameObject = self:Get("view/UseTipsText", "GameObject");
    end
    return self.mUseTipsText_GameObject;
end

--endregion
---Top_CSEffectRenderQueue
function UIself_Level:Top_CSEffectRenderQueue()
    if self.mTop_CSEffectRenderQueue == nil then
        self.mTop_CSEffectRenderQueue = CS.Utility_Lua.GetComponent(self.waterEffect.transform, 'Top_CSEffectRenderQueue')
    end
    return self.mTop_CSEffectRenderQueue
end

---@type Top_CSEffectRenderQueue
function UIself_Level:Top_LevelEffectRenderQueue()
    if self.mTop_LevelEffectRenderQueue == nil then
        self.mTop_LevelEffectRenderQueue = CS.Utility_Lua.GetComponent(self.levelFillEffect.transform, 'Top_CSEffectRenderQueue')
    end
    return self.mTop_LevelEffectRenderQueue
end

---@type Top_CSEffectRenderQueue
function UIself_Level:Top_LevelRotateEffectRenderQueue()
    if self.mTop_LevelRotateEffectRenderQueue == nil then
        self.mTop_LevelRotateEffectRenderQueue = CS.Utility_Lua.GetComponent(self.waterEffect.transform, 'Top_CSEffectRenderQueue')
    end
    return self.mTop_LevelRotateEffectRenderQueue
end

--region 升级属性
function UIself_Level:GetLevelFirstTitle_UILabel()
    if (self.mLevelPanelFirstTitle == nil) then
        self.mLevelPanelFirstTitle = self:Get("view/Scroll View/arributelist/arribute01/curarribute/gongji/title", "UILabel")
    end
    return self.mLevelPanelFirstTitle
end

function UIself_Level:GetLevelSecondTitle_UILabel()
    if (self.mLevelPanelSecondTitle == nil) then
        self.mLevelPanelSecondTitle = self:Get("view/Scroll View/arributelist/arribute11/curarribute/gongji/title", "UILabel")
    end
    return self.mLevelPanelSecondTitle
end

function UIself_Level:GetLevelThirdTitle_UILabel()
    if (self.mLevelPanelThirdTitle == nil) then
        self.mLevelPanelThirdTitle = self:Get("view/Scroll View/arributelist/arribute21/curarribute/gongji/title", "UILabel")
    end
    return self.mLevelPanelThirdTitle
end

function UIself_Level:GetLevelFourthTitle_UILabel()
    if (self.mLevelPanelFourthTitle == nil) then
        self.mLevelPanelFourthTitle = self:Get("view/Scroll View/arributelist/arribute31/curarribute/gongji/title", "UILabel")
    end
    return self.mLevelPanelFourthTitle
end

function UIself_Level:GetLevelFifthTitle_UILabel()
    if (self.mLevelPanelFifthTitle == nil) then
        self.mLevelPanelFifthTitle = self:Get("view/Scroll View/arributelist/arribute41/curarribute/gongji/title", "UILabel")
    end
    return self.mLevelPanelFifthTitle
end

function UIself_Level:GetLevelSixthTitle_UILabel()
    if (self.mLevelPanelSixthTitle == nil) then
        self.mLevelPanelSixthTitle = self:Get("view/Scroll View/arributelist/arribute51/curarribute/gongji/title", "UILabel")
    end
    return self.mLevelPanelSixthTitle
end

function UIself_Level:GetLevelPanelFirstAttributeCur_UILabel()
    if (self.mLevelPanelHP == nil) then
        self.mLevelPanelHP = self:Get("view/Scroll View/arributelist/arribute01/curarribute/gongji", "UILabel")
    end
    return self.mLevelPanelHP
end

function UIself_Level:GetLevelPanelSecondAttributeCur_UILabel()
    if (self.mLevelPanelAttack == nil) then
        self.mLevelPanelAttack = self:Get("view/Scroll View/arributelist/arribute11/curarribute/gongji", "UILabel")
    end
    return self.mLevelPanelAttack
end

function UIself_Level:GetLevelPanelThirdAttributeCur_UILabel()
    if (self.mLevelPanelDefence == nil) then
        self.mLevelPanelDefence = self:Get("view/Scroll View/arributelist/arribute21/curarribute/gongji", "UILabel")
    end
    return self.mLevelPanelDefence
end

function UIself_Level:GetLevelPanelFourthAttributeCur_UILabel()
    if (self.mLevelPanelMDefence == nil) then
        self.mLevelPanelMDefence = self:Get("view/Scroll View/arributelist/arribute31/curarribute/gongji", "UILabel")
    end
    return self.mLevelPanelMDefence
end

function UIself_Level:GetLevelPanelFifthAttributeCur_UILabel()
    if (self.mLevelPanelHolyAttack == nil) then
        self.mLevelPanelHolyAttack = self:Get("view/Scroll View/arributelist/arribute41/curarribute/gongji", "UILabel")
    end
    return self.mLevelPanelHolyAttack
end

function UIself_Level:GetLevelPanelSixthAttributeCur_UILabel()
    if (self.mLevelPanelHolyDefence == nil) then
        self.mLevelPanelHolyDefence = self:Get("view/Scroll View/arributelist/arribute51/curarribute/gongji", "UILabel")
    end
    return self.mLevelPanelHolyDefence
end

function UIself_Level:GetLevelPanelFirstAttributeNext_UILabel()
    if (self.mLevelPanelNextHP == nil) then
        self.mLevelPanelNextHP = self:Get("view/Scroll View/arributelist/arribute01/nextarribute/gongji", "UILabel")
    end
    return self.mLevelPanelNextHP
end

function UIself_Level:GetLevelPanelFirstAttributeNextArrow_UISprite()
    if (self.mLevelPanelNextHPUIArrow == nil) then
        self.mLevelPanelNextHPUIArrow = self:Get("view/Scroll View/arributelist/arribute01/nextarribute/arrow", "UISprite")
    end
    return self.mLevelPanelNextHPUIArrow
end

function UIself_Level:GetLevelPanelFirstAttributeNextEffect_UILabel()
    if (self.mLevelPanelNextHPValueEffect == nil) then
        self.mLevelPanelNextHPValueEffect = self:Get("view/Scroll View/arributelist/arribute01/nextarribute/valueEffect", "UILabel")
    end
    return self.mLevelPanelNextHPValueEffect
end

function UIself_Level:GetLevelPanelFirstAttributeNextEffect_TweenAlpha()
    if (self.mLevelPanelNextHPEffectTweenAlpha == nil) then
        self.mLevelPanelNextHPEffectTweenAlpha = self:Get("view/Scroll View/arributelist/arribute01/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mLevelPanelNextHPEffectTweenAlpha
end

function UIself_Level:GetLevelPanelSecondAttributeNext_UILabel()
    if (self.mLevelPanelNextAttack == nil) then
        self.mLevelPanelNextAttack = self:Get("view/Scroll View/arributelist/arribute11/nextarribute/gongji", "UILabel")
    end
    return self.mLevelPanelNextAttack
end

function UIself_Level:GetLevelPanelSecondAttributeNextArrow_UISprite()
    if (self.mLevelPanelNextAttackArrow == nil) then
        self.mLevelPanelNextAttackArrow = self:Get("view/Scroll View/arributelist/arribute11/nextarribute/arrow", "UISprite")
    end
    return self.mLevelPanelNextAttackArrow
end

function UIself_Level:GetLevelPanelSecondAttributeNextEffect_UILabel()
    if (self.mLevelPanelNextAttackValueEffect == nil) then
        self.mLevelPanelNextAttackValueEffect = self:Get("view/Scroll View/arributelist/arribute11/nextarribute/valueEffect", "UILabel")
    end
    return self.mLevelPanelNextAttackValueEffect
end

function UIself_Level:GetLevelPanelSecondAttributeNextEffect_TweenAlpha()
    if (self.mLevelPanelNextAttackEffectTweenAlpha == nil) then
        self.mLevelPanelNextAttackEffectTweenAlpha = self:Get("view/Scroll View/arributelist/arribute11/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mLevelPanelNextAttackEffectTweenAlpha
end

function UIself_Level:GetLevelPanelThirdAttributeNext_UILabel()
    if (self.mLevelPanelNextDefence == nil) then
        self.mLevelPanelNextDefence = self:Get("view/Scroll View/arributelist/arribute21/nextarribute/gongji", "UILabel")
    end
    return self.mLevelPanelNextDefence
end

function UIself_Level:GetLevelPanelThirdAttributeNextArrow_UISprite()
    if (self.mLevelPanelNextDefenceArrow == nil) then
        self.mLevelPanelNextDefenceArrow = self:Get("view/Scroll View/arributelist/arribute21/nextarribute/arrow", "UISprite")
    end
    return self.mLevelPanelNextDefenceArrow
end

function UIself_Level:GetLevelPanelThirdAttributeNextEffect_UILabel()
    if (self.mLevelPanelNextDefenceValueEffect == nil) then
        self.mLevelPanelNextDefenceValueEffect = self:Get("view/Scroll View/arributelist/arribute21/nextarribute/valueEffect", "UILabel")
    end
    return self.mLevelPanelNextDefenceValueEffect
end

function UIself_Level:GetLevelPanelThirdAttributeNextEffect_TweenAlpha()
    if (self.mLevelPanelNextDefenceEffectTweenAlpha == nil) then
        self.mLevelPanelNextDefenceEffectTweenAlpha = self:Get("view/Scroll View/arributelist/arribute21/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mLevelPanelNextDefenceEffectTweenAlpha
end

function UIself_Level:GetLevelPanelFourthAttributeNext_UILabel()
    if (self.mLevelPanelNextMDefence == nil) then
        self.mLevelPanelNextMDefence = self:Get("view/Scroll View/arributelist/arribute31/nextarribute/gongji", "UILabel")
    end
    return self.mLevelPanelNextMDefence
end

function UIself_Level:GetLevelPanelFourthAttributeNextArrow_UISprite()
    if (self.mLevelPanelNextMDefenceArrow == nil) then
        self.mLevelPanelNextMDefenceArrow = self:Get("view/Scroll View/arributelist/arribute31/nextarribute/arrow", "UISprite")
    end
    return self.mLevelPanelNextMDefenceArrow
end

function UIself_Level:GetLevelPanelFourthAttributeNextEffect_UILabel()
    if (self.mLevelPanelNextMDefenceValueEffect == nil) then
        self.mLevelPanelNextMDefenceValueEffect = self:Get("view/Scroll View/arributelist/arribute31/nextarribute/valueEffect", "UILabel")
    end
    return self.mLevelPanelNextMDefenceValueEffect
end

function UIself_Level:GetLevelPanelFourthAttributeNextEffect_TweenAlpha()
    if (self.mLevelPanelNextMDefenceEffectTweenAlpha == nil) then
        self.mLevelPanelNextMDefenceEffectTweenAlpha = self:Get("view/Scroll View/arributelist/arribute31/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mLevelPanelNextMDefenceEffectTweenAlpha
end

function UIself_Level:GetLevelPanelFifthAttributeNext_UILabel()
    if (self.mLevelPanelNextHolyAttack == nil) then
        self.mLevelPanelNextHolyAttack = self:Get("view/Scroll View/arributelist/arribute41/nextarribute/gongji", "UILabel")
    end
    return self.mLevelPanelNextHolyAttack
end

function UIself_Level:GetLevelPanelFifthAttributeNextArrow_UISprite()
    if (self.mLevelPanelNextHolyAttackArrow == nil) then
        self.mLevelPanelNextHolyAttackArrow = self:Get("view/Scroll View/arributelist/arribute41/nextarribute/arrow", "UISprite")
    end
    return self.mLevelPanelNextHolyAttackArrow
end

function UIself_Level:GetLevelPanelFifthAttributeNextEffect_UILabel()
    if (self.mLevelPanelNextHolyAttackValueEffect == nil) then
        self.mLevelPanelNextHolyAttackValueEffect = self:Get("view/Scroll View/arributelist/arribute41/nextarribute/valueEffect", "UILabel")
    end
    return self.mLevelPanelNextHolyAttackValueEffect
end

function UIself_Level:GetLevelPanelFifthAttributeNextEffect_TweenAlpha()
    if (self.mLevelPanelNextHolyAttackEffectTweenAlpha == nil) then
        self.mLevelPanelNextHolyAttackEffectTweenAlpha = self:Get("view/Scroll View/arributelist/arribute41/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mLevelPanelNextHolyAttackEffectTweenAlpha
end

function UIself_Level:GetLevelPanelSixthAttributeNext_UILabel()
    if (self.mLevelPanelNextHolyDefence == nil) then
        self.mLevelPanelNextHolyDefence = self:Get("view/Scroll View/arributelist/arribute51/nextarribute/gongji", "UILabel")
    end
    return self.mLevelPanelNextHolyDefence
end

function UIself_Level:GetLevelPanelSixthAttributeNextArrow_UISprite()
    if (self.mLevelPanelNextHolyDefenceArrow == nil) then
        self.mLevelPanelNextHolyDefenceArrow = self:Get("view/Scroll View/arributelist/arribute51/nextarribute/arrow", "UISprite")
    end
    return self.mLevelPanelNextHolyDefenceArrow
end

function UIself_Level:GetLevelPanelSixthAttributeNextEffect_UILabel()
    if (self.mLevelPanelNextHolyDefenceValueEffect == nil) then
        self.mLevelPanelNextHolyDefenceValueEffect = self:Get("view/Scroll View/arributelist/arribute51/nextarribute/valueEffect", "UILabel")
    end
    return self.mLevelPanelNextHolyDefenceValueEffect
end

function UIself_Level:GetLevelPanelSixthAttributeNextEffect_TweenAlpha()
    if (self.mLevelPanelNextHolyDefenceEffectTweenAlpha == nil) then
        self.mLevelPanelNextHolyDefenceEffectTweenAlpha = self:Get("view/Scroll View/arributelist/arribute51/nextarribute/valueEffect", "TweenAlpha")
    end
    return self.mLevelPanelNextHolyDefenceEffectTweenAlpha
end

function UIself_Level:GetLevelPanelLevelValue_UILabel()
    if (self.mLevelPanelLevelValue == nil) then
        self.mLevelPanelLevelValue = self:Get("view/reinLevel/value", "Top_UILabel")
    end
    return self.mLevelPanelLevelValue
end

function UIself_Level:GetWaterEffectParent()
    if (self.mWaterEffectParent == nil) then
        self.mWaterEffectParent = self:Get("view/reinLevel/Sprite", "Transform")
    end
    return self.mWaterEffectParent
end

function UIself_Level:GetWaterSecondEffectParent()
    if (self.mWaterSecondEffectParent == nil) then
        self.mWaterSecondEffectParent = self:Get("view/reinLevel/Sprite1", "Transform")
    end
    return self.mWaterSecondEffectParent
end

function UIself_Level:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:Get("view/Scroll View", "UIScrollView");
    end
    return self.mScrollView;
end

function UIself_Level:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:Get("view/Scroll View/arributelist", "UIGridContainer");
    end
    return self.mGridContainer;
end

--endregion
--endregion

--region 初始化
function UIself_Level:Init(panel, callback)
    self.ServantPanel = panel;
    self.ServantPanel:ShowOtherServantPanel()
    self.mCriticalTimeInterval = 0.2
    self:BindUIEvents()
    self.LevelUpEffectAni = false
    self.mUpdateAttributeCoroutine = nil
    self.mClickCount = 0
    self.mGreenColor = CS.UnityEngine.Color(0.035, 1, 0)
end
--切换时调用
function UIself_Level:InitLevelData(servantInfo, callback)
    self.ServantInfo = servantInfo
    self.isInit = true
    --self:HideInjectionEffect()
    self:InitLevel()
    self:InitFillEffectAmount()
    self:InitShowEffect()
    self:ShowFull(false)
    self:RefreshPool()
    self.UpLevelCallBack = callback
end

function UIself_Level:InitComponents()

end

function UIself_Level:InitParameters()
    self.maxExpPool = 0
    self.CurWaterValue = 0
    self.WaterTargetValue = 0
    self.poolExp = 0
    self.mLevelBtnOnPress = false
    self.levelUpFinish = true
    self.loadeSuccessEffect = false
    self:GetWaterValueMax()
end

function UIself_Level:InitEffect()
    if self.upSuccessEffect ~= nil then
        self.upSuccessEffect.gameObject:SetActive(false)
    end
    if self.fillFlickerEffect ~= nil then
        self.fillFlickerEffect.gameObject:SetActive(false)
    end
    self:DestroyEffect()
end

function UIself_Level:Show()
    self.go:SetActive(true)
    self:InitEffect()
    self:InitParameters()
    self:CheckAttributeArrowShow();
    self:RestartEffect()
    self:IsOpenServantPractice()
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL)
end

function UIself_Level:BindUIEvents()
    CS.UIEventListener.Get(self:GetLevelUpBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetLevelUpBtn_GameObject()).onPressLuaDelegate = self.LevelUpBtnOnPress
    CS.UIEventListener.Get(self:GetLevelUpBtn_GameObject()).OnClickLuaDelegate = self.LevelUpBtnOnClick
    CS.UIEventListener.Get(self:GetLevelHelp_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetLevelHelp_GameObject()).OnClickLuaDelegate = self.HelpBtnOnClick
    CS.UIEventListener.Get(self:GetAddExpBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetAddExpBtn_GameObject()).OnClickLuaDelegate = self.AddExpBtnOnClick
    CS.UIEventListener.Get(self:GetExpBtnHelp_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetExpBtnHelp_GameObject()).OnClickLuaDelegate = self.OnClickExpBtnHelp
    CS.UIEventListener.Get(self:GetPracticeBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetPracticeBtn_GameObject()).OnClickLuaDelegate = self.OnClickPracticeBtn

    self:GetScrollView().onDragProgress = function()
        self:OnScrollViewMomentumMove();
    end
end

function UIself_Level:InitLevel()
    --初始化经验球及等级
    self.ShowExp = self.ServantPanel:GetSelectServantInfo() ~= nil and self.ServantPanel:GetSelectServantInfo().exp or 0
    local selectServantInfo = self.ServantPanel:GetSelectServantInfo();
    local isMin = selectServantInfo == nil and true or self.ServantPanel:GetSelectServantInfo().servantId == 0
    if (selectServantInfo ~= nil) then
        local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(selectServantInfo.level + 1)
        self.maxLevel = isMin and false or not res
    else
        self.maxLevel = false;
    end
    self:GetLevelBg_GameObject():SetActive(not isMin and not self.maxLevel)
    self:GetLevelUpBtn_GameObject():SetActive(not isMin and not self.maxLevel)
    self:GetUseTipsText_GameObject():SetActive(isMin)
    self:GetLevelMax_GameObject():SetActive(isMin == false and self.maxLevel)
    self:GetAddExpBtn_GameObject():SetActive(not isMin and not self.maxLevel)
    self.ServantLevelTbl = (not self.maxLevel and not isMin) and CS.Cfg_HsLevelTableManager.Instance.dic[self.ServantPanel:GetSelectServantInfo().level + 1] or nil
    self.mNeedExp = self.ServantLevelTbl ~= nil and self.ServantLevelTbl.upgrade or 0

    --self:GetLevelExp_UILabel().text = (self.maxLevel or not isMin) and '' or self.ShowExp .. "/" .. self.mNeedExp
    self:GetLevelBar_UISprite().fillAmount = (self.maxLevel or isMin or self.mNeedExp == 0) and 0 or self.ShowExp / self.mNeedExp

    self:GetLevelBar_FillTween():Reset()
    if (self.ServantPanel:GetSelectServantInfo() ~= nil) then
        self:GetLevelLv_UILabel().text = 'Lv: ' .. self.ServantPanel:GetSelectServantInfo().level
        self.ShowLevel = self.ServantPanel:GetSelectServantInfo().level
    end
    self:GetLevelBar_FillTween().TweenLevel = self.ShowLevel
    self:GetLevelBar_FillTween().TweenValue = not self.maxLevel and self.ShowExp or 0

    --self:UpdateServantLevelProcessSet();
end

function UIself_Level:UpdateShowLevel()
    local selectServantInfo = self.ServantPanel:GetSelectServantInfo();
    local isMin = selectServantInfo == nil and true or self.ServantPanel:GetSelectServantInfo().servantId == 0
    if (selectServantInfo ~= nil) then
        local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(selectServantInfo.level + 1)
        self.maxLevel = isMin and false or not res
    else
        self.maxLevel = false;
    end
    self:GetLevelBg_GameObject():SetActive(not isMin and not self.maxLevel)
    self:GetLevelUpBtn_GameObject():SetActive(not isMin and not self.maxLevel)
    self:GetUseTipsText_GameObject():SetActive(isMin)
    self:GetLevelMax_GameObject():SetActive(isMin == false and self.maxLevel)
    self:GetAddExpBtn_GameObject():SetActive(not isMin and not self.maxLevel)
    self.ServantLevelTbl = (not self.maxLevel and not isMin) and CS.Cfg_HsLevelTableManager.Instance.dic[self.ServantPanel:GetSelectServantInfo().level + 1] or nil
    self:InitLevel();
    self:ShowLevelCanUpEffect()
end

function UIself_Level:IsOpenServantPractice()
    local isOpen = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsOpenServantPractice()
    self:GetPracticeBtn_GameObject():SetActive(isOpen)
    --self:GetAddExpBtn_GameObject():SetActive(false)
end

--endregion

--region update
UIself_Level.ServantLevelReqNum = 0
function UIself_Level:UpdateFun()
    if (self.mLevelBtnOnPress) then
        if (CS.UnityEngine.Time.time - self.intervalTime > self.mCriticalTimeInterval) then
            self.intervalTime = CS.UnityEngine.Time.time
            local IsExitPoolExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool > 0
            if (IsExitPoolExp) then
                if (self.ServantLevelReqNum < self:GetServantUpServerTargetSpeed()) then
                    self.ServantLevelReqNum = self.ServantLevelReqNum + self:GetServantUpGrowRateSpeed()
                end
                networkRequest.ReqUpServant(self.ServantInfo.type, self.ServantLevelReqNum)
            else
                self.ServantPanel:ShowTips(self:GetLevelUpBtn_GameObject(), 21)
            end

        end
    else
        return
    end
end
--endregion

--region 刷新面板

---@param panelOpenType XLua.Cast.Int32  升级界面刷新用（在此仅占位，可以nil，避免出错）
function UIself_Level:RefreshServant(servantInfo, panelOpenType)
    self.targetInfo = servantInfo
    self.ServantInfo = self.targetInfo
    self:UpdateServantAttribute();
    self:UpdateShowLevel();
end

function UIself_Level:RefreshPool()
    local poolexpValue = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
    if self.isInit then
        self.isInit = false
    end
    local previousExp = self.poolExp
    self.poolExp = poolexpValue
    --self:RefeshWaterEffect()
    self:GetLevelPanelPoolExp_UILabel().text = self.poolExp
    if self.mIsFirstTimeRefreshExp == nil then
        self.mIsFirstTimeRefreshExp = false
    else
        if previousExp ~= nil and self.poolExp ~= nil and previousExp < self.poolExp then
            CS.UIFlashingLabel.PlayFlashing(self:GetLevelPanelPoolExp_UILabel(), 3)
        end
    end
    self:LimitLevelPoolEffect()
    --等级的赋值 服务器的值
    self:ShowLevelCanUpEffect()
end

function UIself_Level:LimitLevelPoolEffect()
    if (self.waterEffect ~= nil) then
        if (self.poolExp == 0) then
            self.waterEffect:SetActive(false)
        else
            self.waterEffect:SetActive(true)
        end
    end
end

function UIself_Level:ShowLevelCanUpEffect()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    local servantInfo = self.ServantInfo

    if (mainPlayerInfo ~= nil and servantInfo ~= nil and self.poolExp and self.mNeedExp and self.ServantInfo.exp and self.poolExp >= self.mNeedExp - self.ServantInfo.exp and self.ServantInfo.level and mainPlayerInfo.Level and self.ServantInfo.level < CS.CSScene.MainPlayerInfo.Level) then
        if (self.MaxExpEffect == nil) then
            self.MaxExpEffect = 0
            self:LoadEffect('700040', self:GetLevelUpBtn_GameObject().transform, function(pool, go)
                self.MaxExpEffectPool = pool
                self.MaxExpEffect = go
            end, CS.UnityEngine.Vector3.one)
        else
            if (self.MaxExpEffect ~= 0) then
                self.MaxExpEffect:SetActive(true)
            end
        end
    else
        if (self.MaxExpEffect ~= nil and self.MaxExpEffect ~= 0) then
            self.MaxExpEffect:SetActive(false)
        end
    end
end
--endregion

--region 升级进度条

---设置进度条
function UIself_Level:SetLevelProgress(data)
    local selectServantInfo = self.ServantPanel:GetSelectServantInfo();
    local isMin = selectServantInfo == nil and true or self.ServantPanel:GetSelectServantInfo().servantId == 0
    if (data == nil) then
        self:SetLevelFillEffect(0)
        self:GetLevelExp_UILabel().text = ""
        return
    end
    if (self.maxLevel) then
        self:GetLevelMax_GameObject():SetActive(isMin == false)
        return
    end
    UIself_Level.LevelUpData = nil
    if (not UIself_Level.isRunningUpLevel) then
        if (self.ServantPanel:GetSelectHeadInfo().info ~= nil and data.type == self.ServantPanel:GetSelectHeadInfo().info.type) then
            self:RefreshPool()
            local num = 0
            if self.mNeedExp == nil or type(self.mNeedExp) ~= "number" or self.mNeedExp <= 0 then
            else
                num = data.exp / self.mNeedExp
            end
            self.ServantPanel:GetSelectHeadInfo().info.exp = data.exp
            --UIself_Level.isRunningUpLevel = true
            if (num >= 1) then
                if (self:GetLevelBar_CSValueTween() ~= nil) then
                    self:GetLevelBar_CSValueTween().enabled = false
                end
                self:GetLevelBar_UISprite().fillAmount = 1
                --设置特效动画
                self:SetLevelFillEffect(0.99)
                self:GetLevelExp_UILabel().text = math.floor(self.mNeedExp * num) .. "/" .. self.mNeedExp
                UIself_Level.isRunningUpLevel = false
            else
                if (self:GetLevelBar_CSValueTween() ~= nil) then
                    self:GetLevelBar_CSValueTween().enabled = true
                end
                CS.CSValueTween.Begin(self:GetLevelBar_UISprite().gameObject, UIself_Level.ExpBarSpeed, self:GetLevelBar_UISprite().fillAmount, num, function(item, value)
                    self:GetLevelBar_UISprite().fillAmount = value
                    --设置特效动画
                    self:SetLevelFillEffect(value)
                    self:GetLevelExp_UILabel().text = math.floor(self.mNeedExp * value) .. "/" .. self.mNeedExp
                end, function(item, value)
                    self:ILevelEffectSpeedNormal()
                    UIself_Level.isRunningUpLevel = false
                end)
            end

        end
    end
end

function UIself_Level:LevelEffectSpeedUp()
    local v2 = CS.UnityEngine.Vector4.zero
    local str = ""
    str = "_UVParams"
    v2.x = 0.75
    v2.y = -1
    if (self.waterEffect ~= nil and self:Top_LevelRotateEffectRenderQueue() ~= nil) then
        self:Top_LevelRotateEffectRenderQueue().matS[1]:SetVector(str, v2)
    end
end

function UIself_Level:ILevelEffectSpeedNormal()
    local v2 = CS.UnityEngine.Vector4(0.75, -1, 0, 0)
    local str = "_UVParams"
    v2.x = 0.25
    v2.y = -0.5
    if (self.waterEffect ~= nil and self:Top_LevelRotateEffectRenderQueue() ~= nil) then
        self:Top_LevelRotateEffectRenderQueue().matS[1]:SetVector(str, v2)
    end
end

function UIself_Level:SetLevelHightLightPos(value)
    self:GetLevelHighLight_GameObject():SetActive(value ~= 0)
    self:GetLevelHighLight_GameObject().transform.localPosition = CS.UnityEngine.Vector3(415 * value - 215, 0, 0);
end
--endregion

--region  刷新幻兽升级属性界面
function UIself_Level:ShowFull(full)
    self:GetBodyAttribute_GameObject():SetActive(full)
end

UIself_Level.ServantMid = 0;
UIself_Level.ServantLevel = 0;
UIself_Level.IsFlicker = false;
function UIself_Level:UpdateServantAttribute()
    if self.ServantInfo == nil or self.ServantInfo.itemId == 0 then
        self:GetLevelPanelFirstAttributeCur_UILabel().text = 0
        self:GetLevelPanelSecondAttributeCur_UILabel().text = 0
        self:GetLevelPanelThirdAttributeCur_UILabel().text = 0
        self:GetLevelPanelFourthAttributeCur_UILabel().text = 0
        self:GetLevelPanelFifthAttributeCur_UILabel().text = 0
        self:GetLevelPanelSixthAttributeCur_UILabel().text = 0

        self:GetLevelPanelFirstAttributeNext_UILabel().text = 0
        self:GetLevelPanelSecondAttributeNext_UILabel().text = 0
        self:GetLevelPanelThirdAttributeNext_UILabel().text = 0
        self:GetLevelPanelFourthAttributeNext_UILabel().text = 0
        self:GetLevelPanelFifthAttributeNext_UILabel().text = 0
        self:GetLevelPanelSixthAttributeNext_UILabel().text = 0
        self:EmptyAttributeArrowColor()
        self:SetAttributeLabelColor(0)
        self:ChangeAttackLabel()
        UIself_Level.ServantMid = 0
        UIself_Level.ServantLevel = 0
        return
    end
    if (UIself_Level.ServantMid ~= self.ServantInfo.mid or self.ServantInfo.level ~= UIself_Level.ServantLevel) then
        UIself_Level.ServantMid = self.ServantInfo.mid;
        UIself_Level.ServantLevel = self.ServantInfo.level;
        UIself_Level.IsFlicker = true;
    else
        UIself_Level.IsFlicker = false;
    end

    local levelAttrs = self.ServantInfo.levelAttrs
    local nextLevelAttrs = self.ServantInfo.nextLevelAttrs
    if (levelAttrs ~= nil and levelAttrs.Count > 0) then
        for i = 0, levelAttrs.Count - 1 do
            local v = levelAttrs[i];
            if (v.type == LuaEnumAttributeType.MaxHp) then
                self.iLevelPanelHP = v.value
            elseif (v.type == LuaEnumAttributeType.PhyDefenceMin) then
                self.iLevelPanelMinDefence = v.value
            elseif (v.type == LuaEnumAttributeType.PhyDefenceMax) then
                self.iLevelPanelMaxDefence = v.value
            elseif (v.type == LuaEnumAttributeType.PhyAttackMin) then
                self.iLevelPanelMinAttack = v.value
            elseif (v.type == LuaEnumAttributeType.PhyAttackMax) then
                self.iLevelPanelMaxAttack = v.value
            elseif (v.type == LuaEnumAttributeType.MagicDefenceMin) then
                self.iLevelPanelMinMDefence = v.value
            elseif (v.type == LuaEnumAttributeType.MagicDefenceMax) then
                self.iLevelPanelMaxMDefence = v.value
            elseif (v.type == LuaEnumAttributeType.HolyAttackMax) then
                self.iLevelPanelHolyAttackMax = v.value
            elseif (v.type == LuaEnumAttributeType.HolyAttackMin) then
                self.iLevelPanelHolyAttackMin = v.value
            elseif (v.type == LuaEnumAttributeType.HolyDefenceMax) then
                self.iLevelPanelHolyDefenceMax = v.value
            elseif (v.type == LuaEnumAttributeType.HolyDefenceMin) then
                self.iLevelPanelHolyDefenceMin = v.value
            elseif (v.type == LuaEnumAttributeType.Dodge) then
                self.iLevelPanelDodge = v.value
            elseif (v.type == LuaEnumAttributeType.Accurate) then
                self.iLevelPanelAccurate = v.value
            end
        end
    end

    --for k, v in pairs(nextLevelAttrs) do
    if (nextLevelAttrs ~= nil and nextLevelAttrs.Count > 0) then
        for i = 0, nextLevelAttrs.Count - 1 do
            local v = nextLevelAttrs[i];
            if (v.type == LuaEnumAttributeType.MaxHp) then
                self.iNextLevelPanelHP = v.value
            elseif (v.type == LuaEnumAttributeType.PhyDefenceMin) then
                self.iNextLevelPanelMinDefence = v.value
            elseif (v.type == LuaEnumAttributeType.PhyDefenceMax) then
                self.iNextLevelPanelMaxDefence = v.value
            elseif (v.type == LuaEnumAttributeType.PhyAttackMin) then
                self.iNextLevelPanelMinAttack = v.value
            elseif (v.type == LuaEnumAttributeType.PhyAttackMax) then
                self.iNextLevelPanelMaxAttack = v.value
            elseif (v.type == LuaEnumAttributeType.MagicDefenceMin) then
                self.iNextLevelPanelMinMDefence = v.value
            elseif (v.type == LuaEnumAttributeType.MagicDefenceMax) then
                self.iNextLevelPanelMaxMDefence = v.value
            elseif (v.type == LuaEnumAttributeType.HolyAttackMax) then
                self.iNextLevelPanelHolyAttackMax = v.value
            elseif (v.type == LuaEnumAttributeType.HolyAttackMin) then
                self.iNextLevelPanelHolyAttackMin = v.value
            elseif (v.type == LuaEnumAttributeType.HolyDefenceMax) then
                self.iNextLevelPanelHolyDefenceMax = v.value
            elseif (v.type == LuaEnumAttributeType.HolyDefenceMin) then
                self.iNextLevelPanelHolyDefenceMin = v.value
            elseif (v.type == LuaEnumAttributeType.Dodge) then
                self.iNextLevelPanelDodge = v.value
            elseif (v.type == LuaEnumAttributeType.Accurate) then
                self.iNextLevelPanelAccurate = v.value
            end
        end
    end

    local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(self.ServantInfo.level + 1)
    if (not res) then
        self:GetLevelPanelFirstAttributeCur_UILabel().text = tostring(self. iLevelPanelHP)
        self:GetLevelPanelSecondAttributeCur_UILabel().text = tostring(self. iLevelPanelMinAttack) .. " - " .. tostring(self. iLevelPanelMaxAttack)
        self:GetLevelPanelThirdAttributeCur_UILabel().text = tostring(self. iLevelPanelMinDefence) .. " - " .. tostring(self.iLevelPanelMaxDefence)
        self:GetLevelPanelFourthAttributeCur_UILabel().text = tostring(self. iLevelPanelMinMDefence) .. " - " .. tostring(self. iLevelPanelMaxMDefence)
        self:GetLevelPanelFifthAttributeCur_UILabel().text = tostring(self. iLevelPanelHolyAttackMin) .. " - " .. tostring(self. iLevelPanelHolyAttackMax)
        self:GetLevelPanelSixthAttributeCur_UILabel().text = tostring(self. iLevelPanelHolyDefenceMin) .. " - " .. tostring(self. iLevelPanelHolyDefenceMax)

        self:GetLevelPanelFirstAttributeNext_UILabel().text = "已满"
        self:GetLevelPanelSecondAttributeNext_UILabel().text = "已满"
        self:GetLevelPanelThirdAttributeNext_UILabel().text = "已满"
        self:GetLevelPanelFourthAttributeNext_UILabel().text = "已满"
        self:GetLevelPanelFifthAttributeNext_UILabel().text = "已满"
        self:GetLevelPanelSixthAttributeNext_UILabel().text = "已满"
        if (self.levelFillEffect ~= nil) then
            self.levelFillEffect:SetActive(false);
        end
        self:EmptyAttributeArrowColor()
        self:SetAttributeLabelColor(1)
        self:ChangeAttackLabel()
        return
    else
        --self:GetLevelPanelFirstAttributeNext_UILabel().text = tostring(self. iNextLevelPanelHP)
        --self:GetLevelPanelSecondAttributeNext_UILabel().text = tostring(self. iNextLevelPanelMinAttack) .. " - " .. tostring(self. iNextLevelPanelMaxAttack)
        --self:GetLevelPanelThirdAttributeNext_UILabel().text = tostring(self. iNextLevelPanelMinDefence) .. " - " .. tostring(self. iNextLevelPanelMaxDefence)
        --self:GetLevelPanelFourthAttributeNext_UILabel().text = tostring(self. iNextLevelPanelMinMDefence) .. " - " .. tostring(self. iNextLevelPanelMaxMDefence)
        --self:GetLevelPanelFifthAttributeNext_UILabel().text = tostring(self. iNextLevelPanelHolyAttackMin) .. " - " .. tostring(self. iNextLevelPanelHolyAttackMax)
        --self:GetLevelPanelSixthAttributeNext_UILabel().text = tostring(self. iNextLevelPanelHolyDefenceMin) .. " - " .. tostring(self. iNextLevelPanelHolyDefenceMax)
    end
    if (self.mUpdateAttributeCoroutine ~= nil) then
        StopCoroutine(self.mUpdateAttributeCoroutine)
        self.mUpdateAttributeCoroutine = nil
    end
    self.mUpdateAttributeCoroutine = StartCoroutine(self.UpdateNextAttributeLabelColor, self)
end

function UIself_Level:ChangeAttackLabel()
    if (self:GetLevelFirstTitle_UILabel().text == "攻击") then
        self:GetLevelFirstTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetLevelSecondTitle_UILabel().text == "攻击") then
        self:GetLevelSecondTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetLevelThirdTitle_UILabel().text == "攻击") then
        self:GetLevelThirdTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetLevelFourthTitle_UILabel().text == "攻击") then
        self:GetLevelFourthTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetLevelFifthTitle_UILabel().text == "攻击") then
        self:GetLevelFifthTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
    if (self:GetLevelSixthTitle_UILabel().text == "攻击") then
        self:GetLevelSixthTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        return
    end
end

---@param type 颜色类型
--- 1:绿色 2:白色
function UIself_Level:SetAttributeLabelColor(type)
    if (type == 1) then
        self:GetLevelPanelSecondAttributeNext_UILabel().color = self.mGreenColor
        self:GetLevelPanelThirdAttributeNext_UILabel().color = self.mGreenColor
        self:GetLevelPanelFourthAttributeNext_UILabel().color = self.mGreenColor
        self:GetLevelPanelFirstAttributeNext_UILabel().color = self.mGreenColor
        self:GetLevelPanelFifthAttributeNext_UILabel().color = self.mGreenColor
        self:GetLevelPanelSixthAttributeNext_UILabel().color = self.mGreenColor
    else
        self:GetLevelPanelSecondAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetLevelPanelThirdAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetLevelPanelFourthAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetLevelPanelFirstAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetLevelPanelFifthAttributeNext_UILabel().color = CS.UnityEngine.Color.white
        self:GetLevelPanelSixthAttributeNext_UILabel().color = CS.UnityEngine.Color.white
    end
end

function UIself_Level:EmptyAttributeArrowColor()
    self:GetLevelPanelSecondAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetLevelPanelThirdAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetLevelPanelFourthAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetLevelPanelFirstAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetLevelPanelFifthAttributeNextArrow_UISprite().spriteName = "arrow3"
    self:GetLevelPanelSixthAttributeNextArrow_UISprite().spriteName = "arrow3"
end

function UIself_Level:UpdateNextAttributeLabelColor()
    yield_return(0)
    if CS.StaticUtility.IsNull(self.go) then
        return
    end
    local attributeList = CS.System.Collections.Generic["List`1[System.Int32]"]()

    if (self.iNextLevelPanelMinAttack == self.iLevelPanelMinAttack and self.iNextLevelPanelMaxAttack == self.iLevelPanelMaxAttack) then
    else
        attributeList:Add(1)
    end
    if (self.iNextLevelPanelMinDefence == self.iLevelPanelMinDefence and self.iNextLevelPanelMaxDefence == self.iLevelPanelMaxDefence) then
    else
        attributeList:Add(2)
    end
    if (self.iNextLevelPanelMinMDefence == self.iLevelPanelMinMDefence and self.iNextLevelPanelMaxMDefence == self.iLevelPanelMaxMDefence) then
    else
        attributeList:Add(3)
    end
    if (self.iNextLevelPanelHP == self.iLevelPanelHP) then
    else
        attributeList:Add(4)
    end
    if (self.iNextLevelPanelHolyAttackMin == self.iLevelPanelHolyAttackMin and self.iNextLevelPanelHolyAttackMax == self.iLevelPanelHolyAttackMax) then
    else
        attributeList:Add(5)
    end
    if (self.iNextLevelPanelHolyDefenceMin == self.iLevelPanelHolyDefenceMin and self.iNextLevelPanelHolyDefenceMax == self.iLevelPanelHolyDefenceMax) then
    else
        attributeList:Add(6)
    end

    self:SortAttributeList(attributeList)
    if (self.mUpdateAttributeCoroutine ~= nil) then
        StopCoroutine(self.mUpdateAttributeCoroutine)
    end
end

function UIself_Level:SortAttributeList(data)
    local index = 1
    local AttributeList = data
    for i = 0, 5 do
        if (data.Count <= i) then
            AttributeList:Add(index)
        else
            if (data[i] ~= index and not data:Contains(index)) then
                AttributeList:Add(index)
            end
        end
        index = index + 1
    end
    for j = 0, AttributeList.Count - 1 do
        local color = CS.UnityEngine.Color.white
        local spriteName = "arrow3"
        if (AttributeList[j] == 1) then
            if (self.iNextLevelPanelMinAttack == self.iLevelPanelMinAttack and self.iNextLevelPanelMaxAttack == self.iLevelPanelMaxAttack) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)), tostring(self.iLevelPanelMinAttack) .. " - " .. tostring(self.iLevelPanelMaxAttack), tostring(self.iNextLevelPanelMinAttack) .. " - " .. tostring(self.iNextLevelPanelMaxAttack))
        elseif (AttributeList[j] == 2) then
            if (self.iNextLevelPanelMinDefence == self.iLevelPanelMinDefence and self.iNextLevelPanelMaxDefence == self.iLevelPanelMaxDefence) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax), tostring(self.iLevelPanelMinDefence) .. " - " .. tostring(self.iLevelPanelMaxDefence), tostring(self.iNextLevelPanelMinDefence) .. " - " .. tostring(self.iNextLevelPanelMaxDefence))
        elseif (AttributeList[j] == 3) then
            if (self.iNextLevelPanelMinMDefence == self.iLevelPanelMinMDefence and self.iNextLevelPanelMaxMDefence == self.iLevelPanelMaxMDefence) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax), tostring(self.iLevelPanelMinMDefence) .. " - " .. tostring(self.iLevelPanelMaxMDefence), tostring(self.iNextLevelPanelMinMDefence) .. " - " .. tostring(self.iNextLevelPanelMaxMDefence))
        elseif (AttributeList[j] == 4) then
            if (self.iNextLevelPanelHP == self.iLevelPanelHP) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.MaxHp), tostring(self.iLevelPanelHP), tostring(self.iNextLevelPanelHP))
        elseif (AttributeList[j] == 5) then
            if (self.iNextLevelPanelHolyAttackMin == self.iLevelPanelHolyAttackMin and self.iNextLevelPanelHolyAttackMax == self.iLevelPanelHolyAttackMax) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax), tostring(self.iLevelPanelHolyAttackMin) .. " - " .. tostring(self.iLevelPanelHolyAttackMax), tostring(self.iNextLevelPanelHolyAttackMin) .. " - " .. tostring(self.iNextLevelPanelHolyAttackMax))
        elseif (AttributeList[j] == 6) then
            if (self.iNextLevelPanelHolyDefenceMin == self.iLevelPanelHolyDefenceMin and self.iNextLevelPanelHolyDefenceMax == self.iLevelPanelHolyDefenceMax) then
            else
                color = self.mGreenColor
                spriteName = "arrow"
            end
            self:ChangeLabelValue(j, color, spriteName, Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax), tostring(self.iLevelPanelHolyDefenceMin) .. " - " .. tostring(self.iLevelPanelHolyDefenceMax), tostring(self.iNextLevelPanelHolyDefenceMin) .. " - " .. tostring(self.iNextLevelPanelHolyDefenceMax))
        end
    end
    self:RefreshLevelData()
end

function UIself_Level:ChangeLabelValue(num, color, spriteName, title, cur, next)
    if (num == 0) then
        self:GetLevelFirstTitle_UILabel().text = title
        self:GetLevelPanelFirstAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetLevelPanelFirstAttributeNext_UILabel().color = color
        self:GetLevelPanelFirstAttributeCur_UILabel().text = cur
        self:GetLevelPanelFirstAttributeNext_UILabel().text = next
    elseif (num == 1) then
        self:GetLevelSecondTitle_UILabel().text = title
        self:GetLevelPanelSecondAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetLevelPanelSecondAttributeNext_UILabel().color = color
        self:GetLevelPanelSecondAttributeCur_UILabel().text = cur
        self:GetLevelPanelSecondAttributeNext_UILabel().text = next
    elseif (num == 2) then
        self:GetLevelThirdTitle_UILabel().text = title
        self:GetLevelPanelThirdAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetLevelPanelThirdAttributeNext_UILabel().color = color
        self:GetLevelPanelThirdAttributeCur_UILabel().text = cur
        self:GetLevelPanelThirdAttributeNext_UILabel().text = next
    elseif (num == 3) then
        self:GetLevelFourthTitle_UILabel().text = title
        self:GetLevelPanelFourthAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetLevelPanelFourthAttributeNext_UILabel().color = color
        self:GetLevelPanelFourthAttributeCur_UILabel().text = cur
        self:GetLevelPanelFourthAttributeNext_UILabel().text = next
    elseif (num == 4) then
        self:GetLevelFifthTitle_UILabel().text = title
        self:GetLevelPanelFifthAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetLevelPanelFifthAttributeNext_UILabel().color = color
        self:GetLevelPanelFifthAttributeCur_UILabel().text = cur
        self:GetLevelPanelFifthAttributeNext_UILabel().text = next
    elseif (num == 5) then
        self:GetLevelSixthTitle_UILabel().text = title
        self:GetLevelPanelSixthAttributeNextArrow_UISprite().spriteName = spriteName
        self:GetLevelPanelSixthAttributeNext_UILabel().color = color
        self:GetLevelPanelSixthAttributeCur_UILabel().text = cur
        self:GetLevelPanelSixthAttributeNext_UILabel().text = next
    end
end
---升级成功
function UIself_Level:RefreshPanelLevelUp(data)
    self:RefreshPool()
    UIself_Level.isRunningUpLevel = true
    CS.CSValueTween.Begin(self:GetLevelBar_UISprite().gameObject, 0.5, self:GetLevelBar_UISprite().fillAmount, 1, function(item, value)
        self:GetLevelBar_UISprite().fillAmount = value
        --设置特效动画
        self:SetLevelFillEffect(value)
        self:GetLevelExp_UILabel().text = (math.floor(self.mNeedExp * value)) .. "/" .. self.mNeedExp
    end, function(item, value)
        self:GetLevelBar_UISprite().fillAmount = 0
        UIself_Level.isRunningUpLevel = false
        self:ShowFlickerEffect()
        self:ILevelEffectSpeedNormal()
        self:GetLevelLv_UILabel().text = 'Lv: ' .. data.level
        local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(data.level + 1)
        if (res) then
            self.mNeedExp = levelInfo.upgrade
            if (data.exp ~= nil) then
                CS.CSValueTween.Begin(self:GetLevelBar_UISprite().gameObject, 0.5, 0, tonumber(data.exp / levelInfo.upgrade), function(item, value)
                    self:GetLevelBar_UISprite().fillAmount = value
                    --设置特效动画
                    self:SetLevelFillEffect(value)
                    self:GetLevelExp_UILabel().text = tonumber(string.format('%.0f', data.exp)) .. "/" .. levelInfo.upgrade
                end)
            end
        else
            self.mNeedExp = 0
            self:GetLevelExp_UILabel().text = ""
            local selectServantInfo = self.ServantPanel:GetSelectServantInfo();
            local isMin = selectServantInfo == nil and true or self.ServantPanel:GetSelectServantInfo().servantId == 0
            self:GetLevelMax_GameObject():SetActive(isMin == false)
        end
        if (UIself_Level.LevelUpContinues) then
            UIself_Level.MoreLevelUp = true
            self:LevelUpBtnOnClick(self:GetLevelUpBtn_GameObject())
        else
            if (not UIself_Level.MoreLevelUp) then
                self.mClickCount = self.mClickCount + 1
                if (self.mClickCount == 5) then
                    self.ServantPanel:ShowTips(self:GetLevelUpBtn_GameObject(), 135)
                    self.mClickCount = 0
                end
            end
            UIself_Level.MoreLevelUp = false
        end
    end)
end

function UIself_Level:RefreshLevelData()
    if (UIself_Level.IsFlicker == false) then
        return
    end
    self:GetLevelPanelFirstAttributeNextEffect_UILabel().text = self:GetLevelPanelFirstAttributeNext_UILabel().text
    self:GetLevelPanelFirstAttributeNextEffect_TweenAlpha():PlayTween();
    self:GetLevelPanelSecondAttributeNextEffect_UILabel().text = self:GetLevelPanelSecondAttributeNext_UILabel().text
    self:GetLevelPanelSecondAttributeNextEffect_TweenAlpha():PlayTween();
    self:GetLevelPanelThirdAttributeNextEffect_UILabel().text = self:GetLevelPanelThirdAttributeNext_UILabel().text
    self:GetLevelPanelThirdAttributeNextEffect_TweenAlpha():PlayTween();
    self:GetLevelPanelFourthAttributeNextEffect_UILabel().text = self:GetLevelPanelFourthAttributeNext_UILabel().text
    self:GetLevelPanelFourthAttributeNextEffect_TweenAlpha():PlayTween();
    self:GetLevelPanelFifthAttributeNextEffect_UILabel().text = self:GetLevelPanelFifthAttributeNext_UILabel().text
    self:GetLevelPanelFifthAttributeNextEffect_TweenAlpha():PlayTween();
    self:GetLevelPanelSixthAttributeNextEffect_UILabel().text = self:GetLevelPanelSixthAttributeNext_UILabel().text
    self:GetLevelPanelSixthAttributeNextEffect_TweenAlpha():PlayTween();
end
--endregion

--region UIEvents
---升级按钮长按
function UIself_Level:LevelUpBtnOnPress(go, state)
    if (go ~= nil and CS.StaticUtility.IsNull(go) == false) then
        if (UIself_Level.LevelUpContinues == false) then
            self:LevelUpBtnOnClick(go)
            UIself_Level.LevelUpContinues = true
        end
        if (not state) then
            UIself_Level.LevelUpContinues = false
        end
    end
end

---升级按钮点击
function UIself_Level:LevelUpBtnOnClick(go)

    if (UIself_Level.isRunningUpLevel) then
        return
    end
    ---@type servantV2.ServantInfo
    local info = self.ServantPanel:GetSelectServantInfo()
    if (info ~= nil and info.level < CS.CSScene.MainPlayerInfo.Level) then
        if (CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool <= 0) then
            self.ServantPanel:ShowTips(go, 21)
            return
        end
        self:LevelEffectSpeedUp()
        local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(info.level + 1)
        if (res) then
            if levelInfo.upgrade < info.exp then
                return
            end
            if (levelInfo.upgrade - info.exp <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool) then
                networkRequest.ReqUpServant(info.type, levelInfo.upgrade - info.exp)
                if (self.levelBallFillEffect ~= nil) then
                    self.levelBallFillEffect:SetActive(false)
                    self.levelBallFillEffect:SetActive(true)
                end
            else
                networkRequest.ReqUpServant(info.type, CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool)
                --self:SetInjectionEffect()
                self.ServantPanel:ShowTips(go, 21)
            end
        end
    else
        self.ServantPanel:ShowTips(go, 275)
    end
end

function UIself_Level:LevelEffectTime()
    if (self.levelBallFillEffect ~= nil) then
        self.levelBallFillEffect:SetActive(false)
        self.levelBallFillEffect:SetActive(true)
    end
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1.1))
    self.LevelUpEffectAni = false
    if (self.LevelEffectCor ~= nil) then
        StopCoroutine(self.LevelEffectCor)
    end
end

---帮助界面点击
function UIself_Level:HelpBtnOnClick(go)
    local info = self:GetHelpTableData(40)
    if info then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

function UIself_Level:GetHelpTableData(id)
    local res, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if res then
        return info
    end
    return nil
end

function UIself_Level:AddExpBtnOnClick()
    Utility.ShowItemGetWay(1000019, self:GetAddExpBtn_GameObject(), LuaEnumWayGetPanelArrowDirType.Left);
end

function UIself_Level:OnClickPracticeBtn()
    uimanager:ClosePanel('UIBagPanel')
    uimanager:ClosePanel('UIOtherPlayerMessagePanel')
    uimanager:CreatePanel('UIServantPracticePanel')
end

function UIself_Level:OnClickExpBtnHelp()
    local info
    local isFind = nil
    isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(53)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

function UIself_Level:OnScrollViewMomentumMove()
    self:CheckAttributeArrowShow();
end
--endregion

function UIself_Level:CheckAttributeArrowShow()
    if (self:GetScrollView().panel == nil) then
        return ;
    end
    local gridContainer = self:GetGridContainer();
    local height = gridContainer.MaxCount * gridContainer.CellHeight;
    local offsetY = self:GetScrollView().panel.clipOffset.y;
    if (offsetY < 0) then
        if (math.abs(offsetY) > gridContainer.CellHeight / 2) then
            self:GetUpArrow_GameObject():SetActive(true);
            self:GetDownArrow_TweenAlpha():PlayTween()
        else
            self:GetUpArrow_GameObject():SetActive(false);
        end
    else
        self:GetUpArrow_GameObject():SetActive(false);
    end

    local interval = (height - self:GetScrollView().panel.height) - math.abs(offsetY);
    if (interval > gridContainer.CellHeight / 2) then
        self:GetDownArrow_GameObject():SetActive(true);
        self:GetUpArrow_TweenAlpha():PlayTween()
    else
        self:GetDownArrow_GameObject():SetActive(false);
    end
end

--region 特效
function UIself_Level:InitShowEffect()
    --液体特效
    if self.waterEffect == nil then
        self:LoadEffect('700165', self:GetWaterEffectParent(), function(pool, go)
            self.waterEffectPool = pool
            self.waterEffect = go
            --self:RefeshWaterEffect()
            self:LimitLevelPoolEffect()
        end)
    end

    --经验条特效
    if self.levelFillEffect == nil then
        self:LoadEffect('700044', self:GetLevelBg_GameObject().transform, function(pool, go)
            self.levelFillEffectPool = pool
            self.levelFillEffect = go
            self.post = self.levelFillEffect.transform:Find('low/700044_uv')
            self:InitFillEffectAmount()
        end)
    end

    --符文特效
    --if self.runeEffect == nil then
    --    self:LoadEffect('700042', self:GetWaterEffectParent(), function(pool, go)
    --        self.runeEffectPool = pool
    --        self.runeEffect = go
    --    end)
    --end

    --经验球注入特效
    if self.levelBallFillEffect == nil then
        self:LoadEffect('700133', self:GetWaterSecondEffectParent().transform, function(pool, go)
            self.levelBallFillEffectPool = pool
            self.levelBallFillEffect = go
            self.levelBallFillEffect:SetActive(false)
        end, CS.UnityEngine.Vector3.one)
    end

    --if self.levelConBallFillEffect == nil then
    --    self:LoadEffect('700134', self:GetWaterEffectParent().transform, function(pool, go)
    --        self.levelConBallFillEffectPool = pool
    --        self.levelConBallFillEffect = go
    --        self.levelConBallFillEffect:SetActive(false)
    --    end, CS.UnityEngine.Vector3.one)
    --end

    --注入特效
    --if self.poolUpEffect1 == nil then
    --    self:LoadEffect('700048_1', self:GetWaterEffectParent(), function(pool, go)
    --        self.poolUpEffect1Pool = pool
    --        self.poolUpEffect1 = go
    --        self.poolUpEffect1:SetActive(false)
    --        self.poolEffectLeftAnim1 = self.poolUpEffect1.transform:Find('low'):GetComponent(typeof(CS.UnityEngine.Animator))
    --    end)
    --end
    --if self.poolUpEffect2 == nil then
    --    self:LoadEffect('700048_2', self:GetWaterEffectParent(), function(pool, go)
    --        self.poolUpEffect2Pool = pool
    --        self.poolUpEffect2 = go
    --        self.poolUpEffect2:SetActive(false)
    --        self.poolEffectLeftAnim2 = self.poolUpEffect2.transform:Find('low'):GetComponent(typeof(CS.UnityEngine.Animator))
    --    end)
    --end
    --if self.poolUpEffect3 == nil then
    --    self:LoadEffect('700048_3', self:GetWaterEffectParent(), function(pool, go)
    --        self.poolUpEffect3Pool = pool
    --        self.poolUpEffect3 = go
    --        self.poolUpEffect3:SetActive(false)
    --        self.poolEffectLeftAnim3 = self.poolUpEffect3.transform:Find('low'):GetComponent(typeof(CS.UnityEngine.Animator))
    --    end)
    --end
    --进度条闪烁特效
    if self.fillFlickerEffect ~= nil then
        self.fillFlickerEffect.gameObject:SetActive(false)
    end

end
---注入特效
function UIself_Level:SetInjectionEffect()

    if self.ServantInfo == nil then
        return
    end
    --左
    if self.poolEffectLeftAnim1 ~= nil and self.ServantInfo.type == 1 then
        local animTime = self.poolEffectLeftAnim1:GetCurrentAnimatorStateInfo(0).normalizedTime
        local isPlaying = animTime < 1 and animTime > 0
        if not isPlaying then
            self.poolUpEffect1.gameObject:SetActive(false)
            self.poolUpEffect1.gameObject:SetActive(not self.isInit)
        end
    end
    --中
    if self.poolEffectLeftAnim2 ~= nil and self.ServantInfo.type == 2 then
        local animTime = self.poolEffectLeftAnim2:GetCurrentAnimatorStateInfo(0).normalizedTime

        local isPlaying = animTime < 1 and animTime > 0

        if not isPlaying then
            self.poolUpEffect2.gameObject:SetActive(false)
            self.poolUpEffect2.gameObject:SetActive(not self.isInit)
        end
    end

    --右
    if self.poolEffectLeftAnim3 ~= nil and self.ServantInfo.type == 3 then
        local animTime = self.poolEffectLeftAnim3:GetCurrentAnimatorStateInfo(0).normalizedTime

        local isPlaying = animTime < 1 and animTime > 0

        if not isPlaying then
            self.poolUpEffect3.gameObject:SetActive(false)
            self.poolUpEffect3.gameObject:SetActive(not self.isInit)
        end
    end
end
---隐藏所有注入特效
function UIself_Level:HideInjectionEffect()
    if self.poolUpEffect1 ~= nil then
        self.poolUpEffect1.gameObject:SetActive(false)
    end
    if self.poolUpEffect2 ~= nil then
        self.poolUpEffect2.gameObject:SetActive(false)
    end
    if self.poolUpEffect3 ~= nil then
        self.poolUpEffect3.gameObject:SetActive(false)
    end
end

---初始化进度条特效
function UIself_Level:InitFillEffectAmount()
    if self.levelFillEffect == nil then
        return
    end
    if self.ShowExp == nil or self.mNeedExp == nil then
        return
    end
    self.mNeedExp = self.mNeedExp == 0 and 1 or self.mNeedExp;
    local amount = self.ShowExp / self.mNeedExp
    self:SetLevelFillEffect(amount, true)
end

---显示进度条闪烁
function UIself_Level:ShowFlickerEffect()
    if self.fillFlickerEffect == nil then
        self:LoadEffect('700044_1', self:GetLevelBg_GameObject().transform, function(pool, go)
            self.fillFlickerEffectPool = pool
            self.fillFlickerEffect = go
        end, nil, CS.UnityEngine.Vector3(210, 0, 0))
    else
        self.fillFlickerEffect.gameObject:SetActive(false)
        self.fillFlickerEffect.gameObject:SetActive(true)
    end
    self:GetLevelupeffect_GameObject():SetActive(false)
    self:GetLevelupeffect_GameObject():SetActive(true)
end

---设置进度条特效
function UIself_Level:SetLevelFillEffect(amount, isInit)
    if self.post == nil then
        return
    end
    local maxPos = -1
    local minPos = 0.01
    local x = minPos - (amount * (minPos - maxPos));
    if (x ~= nil) then
        self:SetLevelEffectFillAmount(x)
        self:SetLevelHightLightPos(amount)
    end
    self.levelFillEffect.gameObject:SetActive(amount ~= 1 and amount ~= 0)
    if amount >= 1 then
        self:SetLevelEffectFillAmount(0)
        --if isInit ~= nil and not isInit then
        --    if self.upSuccessEffect == nil then
        --        self:LoadEffect('700043', self:GetWaterEffectParent(), function(pool, go)
        --            self.upSuccessEffectPool = pool
        --            self.upSuccessEffect = go
        --        end)
        --    else
        --        self.upSuccessEffect.gameObject:SetActive(false)
        --        self.upSuccessEffect.gameObject:SetActive(true)
        --    end
        --end
    end
end

function UIself_Level:LoadEffect(effectCode, parent, callback, size, pos)
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectCode, CS.ResourceType.UIEffect, function(res)
        if res ~= nil and not CS.StaticUtility.IsNull(self.go) then
            if parent == nil or CS.StaticUtility.IsNull(parent) then
                return
            end
            local objPool = res:GetUIPoolItem()
            if objPool == nil then
                return
            end
            local obj = objPool.go
            obj.transform.parent = parent
            if (pos ~= nil) then
                obj.transform.localPosition = pos
            else
                obj.transform.localPosition = CS.UnityEngine.Vector3.zero
            end
            if (size ~= nil) then
                obj.transform.localScale = size
            else
                obj.transform.localScale = CS.UnityEngine.Vector3.one
            end
            obj:SetActive(true)
            if callback ~= nil then
                callback(objPool, obj)
            end
        end
    end, CS.ResourceAssistType.UI)
end

function UIself_Level:CheckUpShowFillEffect()
    local value = self.poolExp - self.mNeedExp
    self.levelFillEffect.gameObject:SetActive(value >= 0)
end

--region 液体特效

function UIself_Level:RefeshWaterEffect()
    self:CalculationWaterValue()
    if self.IEnumChangeWaterEffect ~= nil then
        StopCoroutine(self.IEnumChangeWaterEffect)
        self.IEnumChangeWaterEffect = nil
    end
    self.IEnumChangeWaterEffect = StartCoroutine(self.IEnumWaterValueChange, self)
end

---计算当前总进度 0-1
function UIself_Level:CalculationWaterValue()
    if self.maxExpPool == 0 or self.poolExp == 0 then
        self.WaterTargetValue = 0
        return
    end
    if (self.maxExpPool ~= nil) then
        local Value = self.poolExp / self.maxExpPool
        self.WaterTargetValue = Value > 1 and 1 or Value
    end
end

---设置液体特效数值

--region old
--materialsNum 0-1
--function UIself_Level:SetWaterEffect(value)
--    if self.waterEffect == nil then
--        return
--    end
--    local v2 = CS.UnityEngine.Vector2.zero
--    -- 液体shader数值为从大到小 min数值为最大 液体数值为最小 max 数值为最小  液体数值为最大
--    local min = 1
--    local max = 0
--    local str = ''
--    if self:Top_CSEffectRenderQueue() == nil then
--        return
--    end
--    for i = 0, self:Top_CSEffectRenderQueue().matS.Length - 1 do
--        if i ~= 5 and i ~= 7 and i ~= 8 and i ~= 0 then
--            min = i == 4 and 0.49 or i == 6 and 0.9 or 0.5
--            max = i == 4 and -0.01 or i == 6 and 0.55 or 0
--            str = i == 4 and "_MainTex" or "_MaskTex"
--            v2.y = min - (value * (min - max))
--            self:Top_CSEffectRenderQueue().matS[i]:SetTextureOffset(str, v2)
--        end
--    end
--    self.CurWaterValue = value
--end
--endregion

function UIself_Level:SetLevelEffectFillAmount(value)
    if self.waterEffect == nil then
        return
    end
    local v2 = CS.UnityEngine.Vector2.zero
    -- 液体shader数值为从大到小 min数值为最大 液体数值为最小 max 数值为最小  液体数值为最大

    local str = ''
    if self:Top_LevelEffectRenderQueue() == nil then
        return
    end
    for i = 0, self:Top_LevelEffectRenderQueue().matS.Length - 1 do
        str = "_MaskTex"
        v2.x = value
        self:Top_LevelEffectRenderQueue().matS[i]:SetTextureOffset(str, v2)
    end
    --self.CurWaterValue = value
end

function UIself_Level:IEnumWaterValueChange()
    if (self.WaterTargetValue ~= nil and self.CurWaterValue ~= nil) then
        local value = (self.WaterTargetValue - self.CurWaterValue) / 10
        value = tonumber(string.format("%.1f", value))
        local waterValue = 0
        if math.abs(value) <= 0.01 then
            self:SetWaterEffect(self.WaterTargetValue)
        else
            while math.abs(self.CurWaterValue) < math.abs(self.WaterTargetValue) do
                waterValue = self.CurWaterValue + value
                waterValue = waterValue > 1 and 1 or waterValue
                self:SetWaterEffect(waterValue)
                coroutine.yield(0.5)
            end
            self:SetWaterEffect(self.WaterTargetValue)
        end
    end
end

--endregion
function UIself_Level:RestartEffect()
    if (self.waterEffect ~= nil) then
        self.waterEffect:SetActive(true)
    end
    if (self.levelFillEffect ~= nil) then
        self.levelFillEffect:SetActive(true)
    end
end

function UIself_Level:DestroyEffect()
    if (self.waterEffect ~= nil) then
        self.waterEffect:SetActive(false)
    end
    if (self.levelFillEffect ~= nil) then
        self.levelFillEffect:SetActive(false)
    end
    if (self.levelBallFillEffect ~= nil) then
        self.levelBallFillEffect:SetActive(false)
    end
    if (self.fillFlickerEffect ~= nil) then
        self.fillFlickerEffect:SetActive(false)
    end
    if (self:GetLevelupeffect_GameObject() ~= nil) then
        self:GetLevelupeffect_GameObject():SetActive(false)
    end
end
--endregion

--region otherFunction

function UIself_Level:GetWaterValueMax()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20292)
    if isFind then
        self.maxExpPool = info.value
    end
end

--endregion

function UIself_Level:Hide()
    self.go:SetActive(false)
    self.ServantPanel:GetTabLevel_UIToggle().value = false
    self:DestroyEffect()
end

function UIself_Level:OnDestroy()
    if (self.mUpdateAttributeCoroutine ~= nil) then
        StopCoroutine(self.mUpdateAttributeCoroutine)
        self.mUpdateAttributeCoroutine = nil
    end
    if (self.LevelEffectCor ~= nil) then
        StopCoroutine(self.LevelEffectCor)
    end
    uimanager:ClosePanel('UIServantPracticePanel')
    self.mClickCount = 0
end

return UIself_Level