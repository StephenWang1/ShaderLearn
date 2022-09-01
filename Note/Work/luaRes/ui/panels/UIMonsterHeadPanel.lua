--怪物头像面板
local UIMonsterHeadPanel = {}

UIMonsterHeadPanel.PanelLayerType = CS.UILayerType.BasicPlane

--region 临时变量
UIMonsterHeadPanel.mHumanHeadPos_V3 = CS.UnityEngine.Vector3(0, -32, 0)
UIMonsterHeadPanel.mBossHeadPos_V3 = CS.UnityEngine.Vector3(1, -30, 0)
UIMonsterHeadPanel.mBossHeadPos2_V3 = CS.UnityEngine.Vector3(6, -14, 0)
UIMonsterHeadPanel.mAvater = nil
UIMonsterHeadPanel.mStarted_bool = false
UIMonsterHeadPanel.mLastHp = 0
UIMonsterHeadPanel.mCurHp = 0
UIMonsterHeadPanel.mTargetHp = 0
UIMonsterHeadPanel.mHpLayerValue = 1
UIMonsterHeadPanel.oneLayerHp = 0
UIMonsterHeadPanel.scale = CS.UnityEngine.Vector3(0.45, 0.45, 0.45)
UIMonsterHeadPanel.mUpdateHpShadowTime = 0.7
UIMonsterHeadPanel.mHpShadowTimer = 0
UIMonsterHeadPanel.mDisplayBossHpDividerRange = 0.956
UIMonsterHeadPanel.mDisplayRoleHpDividerRange = 0.976
UIMonsterHeadPanel.mdropList = {}
UIMonsterHeadPanel.mavaterId = nil
UIMonsterHeadPanel.mavaterName = nil
UIMonsterHeadPanel.isShowing = false
UIMonsterHeadPanel.inithp = true
--endregion

--region 组件
function UIMonsterHeadPanel.GetRolehpGo_GameObject()
    if (UIMonsterHeadPanel.mRolehpGO == nil) then
        UIMonsterHeadPanel.mRolehpGO = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO", "GameObject")
    end
    return UIMonsterHeadPanel.mRolehpGO
end

function UIMonsterHeadPanel.GetRolehp_UISprite()
    if (UIMonsterHeadPanel.mRolehp == nil) then
        UIMonsterHeadPanel.mRolehp = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/hp_bg/rolehp", "UISprite")
    end
    return UIMonsterHeadPanel.mRolehp
end

function UIMonsterHeadPanel.GetRolempEffect_UISprite()
    if (UIMonsterHeadPanel.mRolempEffect == nil) then
        UIMonsterHeadPanel.mRolempEffect = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/mp_bg/effect", "UISprite")
    end
    return UIMonsterHeadPanel.mRolempEffect
end

function UIMonsterHeadPanel.GetRolehp_TweenFillAmount()
    if (UIMonsterHeadPanel.mRolehpTween == nil) then
        UIMonsterHeadPanel.mRolehpTween = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/hp_bg/rolehp", "TweenFillAmount")
    end
    return UIMonsterHeadPanel.mRolehpTween
end

function UIMonsterHeadPanel.GetRolehpbottom_UISlider()
    if (UIMonsterHeadPanel.mRolehpbottom == nil) then
        UIMonsterHeadPanel.mRolehpbottom = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/hp_bg", "UISlider")
    end
    return UIMonsterHeadPanel.mRolehpbottom
end

function UIMonsterHeadPanel.GetRolemp_UISprite()
    if (UIMonsterHeadPanel.mRolemp == nil) then
        UIMonsterHeadPanel.mRolemp = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/mp_bg/rolemp", "UISprite")
    end
    return UIMonsterHeadPanel.mRolemp
end

function UIMonsterHeadPanel.GetRolempvalue_UILabel()
    if (UIMonsterHeadPanel.mRolempvalue == nil) then
        UIMonsterHeadPanel.mRolempvalue = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/mp_bg/rolempvalue", "UILabel")
    end
    return UIMonsterHeadPanel.mRolempvalue
end

function UIMonsterHeadPanel.GetRolehpvalue_UILabel()
    if (UIMonsterHeadPanel.mRolehpvalue == nil) then
        UIMonsterHeadPanel.mRolehpvalue = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/hp_bg/Thumb/rolehpvalue", "UILabel")
    end
    return UIMonsterHeadPanel.mRolehpvalue
end

function UIMonsterHeadPanel.GetRolehead_UISprite()
    if (UIMonsterHeadPanel.mRolehead == nil) then
        UIMonsterHeadPanel.mRolehead = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/headIcon", "UISprite")
    end
    return UIMonsterHeadPanel.mRolehead
end

function UIMonsterHeadPanel.GetBosshpGO_GameObject()
    if (UIMonsterHeadPanel.mBosshpGO == nil) then
        UIMonsterHeadPanel.mBosshpGO = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO", "GameObject")
    end
    return UIMonsterHeadPanel.mBosshpGO
end

function UIMonsterHeadPanel.GetBosshp_UISprite()
    if (UIMonsterHeadPanel.mBosshp == nil) then
        UIMonsterHeadPanel.mBosshp = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bosshpbg/bosshp", "UISprite")
    end
    return UIMonsterHeadPanel.mBosshp
end

function UIMonsterHeadPanel.GetBosshpFade_UISprite()
    if (UIMonsterHeadPanel.mBosshpFade == nil) then
        UIMonsterHeadPanel.mBosshpFade = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bosshpbg/bosshpFade", "UISprite")
    end
    return UIMonsterHeadPanel.mBosshpFade
end

function UIMonsterHeadPanel.GetRolehpFade_UISprite()
    if (UIMonsterHeadPanel.mRolehpFade == nil) then
        UIMonsterHeadPanel.mRolehpFade = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/hp_bg/rolehpFade", "UISprite")
    end
    return UIMonsterHeadPanel.mRolehpFade
end

function UIMonsterHeadPanel.GetBosshpbg_UISprite()
    if (UIMonsterHeadPanel.mBosshpbg == nil) then
        UIMonsterHeadPanel.mBosshpbg = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bosshpbg", "UISprite")
    end
    return UIMonsterHeadPanel.mBosshpbg
end

function UIMonsterHeadPanel.GetLastBossHp_UISprite()
    if (UIMonsterHeadPanel.mLastBossHp == nil) then
        UIMonsterHeadPanel.mLastBossHp = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bossLasthp", "UISprite")
    end
    return UIMonsterHeadPanel.mLastBossHp
end

function UIMonsterHeadPanel.GetLastHpSlider_UISlider()
    if (UIMonsterHeadPanel.mLastHpSlider == nil) then
        UIMonsterHeadPanel.mLastHpSlider = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bossLasthp", "UISlider")
    end
    return UIMonsterHeadPanel.mLastHpSlider
end

function UIMonsterHeadPanel.GetSecondBossHp_UISprite()
    if (UIMonsterHeadPanel.mSecondBossHp == nil) then
        UIMonsterHeadPanel.mSecondBossHp = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bossSecondhp", "UISprite")
    end
    return UIMonsterHeadPanel.mSecondBossHp
end

function UIMonsterHeadPanel.GetBosshpvalue_UILabel()
    if (UIMonsterHeadPanel.mbosshpvalue == nil) then
        UIMonsterHeadPanel.mbosshpvalue = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bosshpbg/Thumb/bosshpvalue", "UILabel")
    end
    return UIMonsterHeadPanel.mbosshpvalue
end

function UIMonsterHeadPanel.GetHpLayer_UILabel()
    if (UIMonsterHeadPanel.mHpLayer == nil) then
        UIMonsterHeadPanel.mHpLayer = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/hpLayer", "UILabel")
    end
    return UIMonsterHeadPanel.mHpLayer
end

function UIMonsterHeadPanel.GetBossHead_UISprite()
    if (UIMonsterHeadPanel.mBossHead == nil) then
        UIMonsterHeadPanel.mBossHead = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bosshead", "UISprite")
    end
    return UIMonsterHeadPanel.mBossHead
end

function UIMonsterHeadPanel.GetRoleHP_Slider()
    if (UIMonsterHeadPanel.mRoleHPSlider == nil) then
        UIMonsterHeadPanel.mRoleHPSlider = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/hp_bg", "Top_UISlider")
    end
    return UIMonsterHeadPanel.mRoleHPSlider
end

function UIMonsterHeadPanel.GetBossHP_Slider()
    if (UIMonsterHeadPanel.mBossHPSlider == nil) then
        UIMonsterHeadPanel.mBossHPSlider = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bosshpbg", "Top_UISlider")
    end
    return UIMonsterHeadPanel.mBossHPSlider
end

function UIMonsterHeadPanel.GetLevel_UILabel()
    if (UIMonsterHeadPanel.mLevel == nil) then
        UIMonsterHeadPanel.mLevel = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/level", "UILabel")
    end
    return UIMonsterHeadPanel.mLevel
end

function UIMonsterHeadPanel.GetLabName_UILabel()
    if (UIMonsterHeadPanel.mLabName == nil) then
        UIMonsterHeadPanel.mLabName = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/labName", "UILabel")
    end
    return UIMonsterHeadPanel.mLabName
end

function UIMonsterHeadPanel.GetTypeName_UILabel()
    if (UIMonsterHeadPanel.mTypeName_UILabel == nil) then
        UIMonsterHeadPanel.mTypeName_UILabel = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/labName/typename", "UILabel")
    end
    return UIMonsterHeadPanel.mTypeName_UILabel
end

function UIMonsterHeadPanel.GetHeadFrame_UISprite()
    if (UIMonsterHeadPanel.mHeadFrame == nil) then
        UIMonsterHeadPanel.mHeadFrame = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head", "UISprite")
    end
    return UIMonsterHeadPanel.mHeadFrame
end

function UIMonsterHeadPanel.GetHeadIcon_UISprite()
    if (UIMonsterHeadPanel.mHeadIcon == nil) then
        UIMonsterHeadPanel.mHeadIcon = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/headIcon", "Top_UISprite")
    end
    return UIMonsterHeadPanel.mHeadIcon
end

function UIMonsterHeadPanel.GetBossHpDivider_UISprite()
    if (UIMonsterHeadPanel.mDivider == nil) then
        UIMonsterHeadPanel.mDivider = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bosshp/divider", "UISprite")
    end
    return UIMonsterHeadPanel.mDivider
end

function UIMonsterHeadPanel.GetRoleHpDivider_UISprite()
    if (UIMonsterHeadPanel.mRoleHpDivider == nil) then
        UIMonsterHeadPanel.mRoleHpDivider = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/rolehp/divider", "UISprite")
    end
    return UIMonsterHeadPanel.mRoleHpDivider
end

function UIMonsterHeadPanel.GetLastRoleHpSlider_UISlider()
    if (UIMonsterHeadPanel.mLastRoleHpSlider == nil) then
        UIMonsterHeadPanel.mLastRoleHpSlider = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/roleLasthp", "UISlider")
    end
    return UIMonsterHeadPanel.mLastRoleHpSlider
end

function UIMonsterHeadPanel.GetRoleClose_GameObject()
    if (UIMonsterHeadPanel.mroleClose == nil) then
        UIMonsterHeadPanel.mroleClose = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/rolehpGO/roleClose", "GameObject")
    end
    return UIMonsterHeadPanel.mroleClose
end

function UIMonsterHeadPanel.GetBossClose_GameObject()
    if (UIMonsterHeadPanel.mbossClose == nil) then
        UIMonsterHeadPanel.mbossClose = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/bosshpGO/bossClose", "GameObject")
    end
    return UIMonsterHeadPanel.mbossClose
end

---获取组件
function UIMonsterHeadPanel.GetOtherRoleIcon_GameObject()
    if (UIMonsterHeadPanel.mRoleIcon == nil) then
        UIMonsterHeadPanel.mRoleIcon = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/headIcon", "GameObject")
    end
    return UIMonsterHeadPanel.mRoleIcon
end

function UIMonsterHeadPanel.GetHeadIcon_BoxCollider()
    if (UIMonsterHeadPanel.mHeadIconBox == nil) then
        UIMonsterHeadPanel.mHeadIconBox = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/headIcon", "BoxCollider")
    end
    return UIMonsterHeadPanel.mHeadIconBox
end

function UIMonsterHeadPanel.GetHeadBottom_UISprite()
    if (UIMonsterHeadPanel.mHeadBottom == nil) then
        UIMonsterHeadPanel.mHeadBottom = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head", "UISprite")
    end
    return UIMonsterHeadPanel.mHeadBottom
end

function UIMonsterHeadPanel.GetBelongName_UILabel()
    if (UIMonsterHeadPanel.mBelongName == nil) then
        UIMonsterHeadPanel.mBelongName = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/BelongName", "UILabel")
    end
    return UIMonsterHeadPanel.mBelongName
end

function UIMonsterHeadPanel.GetWakeUp_UILabel()
    if (UIMonsterHeadPanel.mWakeUp == nil) then
        UIMonsterHeadPanel.mWakeUp = UIMonsterHeadPanel:GetCurComp("WidgetRoot/anchor/head/WakeUp", "UILabel")
    end
    return UIMonsterHeadPanel.mWakeUp
end

--endregion

--region 初始化
function UIMonsterHeadPanel:Init()
    UIMonsterHeadPanel.BindUIEvents()
    UIMonsterHeadPanel.BindMessage()
    UIMonsterHeadPanel.GetHeadFrame_UISprite().gameObject:SetActive(true)
    --UIMonsterHeadPanel.GetRolehpEffect_UISpriteAnimation().OnFinish = UIMonsterHeadPanel.RoleHPEffectSpriteAnimationFinished
    --UIMonsterHeadPanel.GetBosshpEffect_UISpriteAnimation().OnFinish = UIMonsterHeadPanel.BossHPEffectSpriteAnimationFinished
    luaEventManager.DoCallback(LuaCEvent.FastUseItem_UpdateRandomStoneEffect);
end

function UIMonsterHeadPanel:Show(_mAvater)

    UIMonsterHeadPanel.inithp = true
    if UIMonsterHeadPanel.isShowing then
        return
    end
    if self.go == nil or CS.StaticUtility.IsNull(self.go) == true then
        return
    end
    if _mAvater == self.mAvater then
        return
    end

    UIMonsterHeadPanel.isShowing = true
    self:RunBaseFunction("Show")
    self.mAvater = _mAvater
    if (_mAvater == nil or _mAvater.BaseInfo == nil) then
        UIMonsterHeadPanel.isShowing = false
        return
    end
    self.mCurHp = UIMonsterHeadPanel.mAvater.AvatarType ~= CS.EAvatarType.Player and _mAvater.BaseInfo.HP or _mAvater.BaseInfo.TotalHP
    self.mLastHp = UIMonsterHeadPanel.mAvater.AvatarType ~= CS.EAvatarType.Player and _mAvater.BaseInfo.HP or _mAvater.BaseInfo.TotalHP
    self.mTargetHp = UIMonsterHeadPanel.mAvater.AvatarType ~= CS.EAvatarType.Player and _mAvater.BaseInfo.HP or _mAvater.BaseInfo.TotalHP
    self.mStarted_bool = false

    UIMonsterHeadPanel.mavaterId = _mAvater.BaseInfo.ID

    UIMonsterHeadPanel.mavaterName = _mAvater.BaseInfo.Name
    --UIMonsterHeadPanel:SetMonsterHeadSize()
    UIMonsterHeadPanel:CollapseUIActivitiesPanel()
    UIMonsterHeadPanel:Refresh()
    UIMonsterHeadPanel:RefreshTypeNameAnchor()
    --UIMonsterHeadPanel:RefreshPanel()
    UIMonsterHeadPanel:InitClientBuffData()
    UIMonsterHeadPanel.isShowing = false
    UIMonsterHeadPanel:RefreshBuff()
    UIMonsterHeadPanel:RefreshOwnerName()
    UIMonsterHeadPanel:RefreshWakeFill()


end

function UIMonsterHeadPanel:RefreshPanel()
    self:GetLevel_UILabel().gameObject:SetActive(true)
    if (UIMonsterHeadPanel.mAvater == nil or UIMonsterHeadPanel.mAvater.BaseInfo == nil) then
        return
    end
    UIMonsterHeadPanel.mCurHp = CS.UnityEngine.Mathf.Lerp(UIMonsterHeadPanel.mCurHp, UIMonsterHeadPanel.mTargetHp, 10 * CS.UnityEngine.Time.deltaTime)

    if (CS.UnityEngine.Mathf.Abs(UIMonsterHeadPanel.mCurHp - UIMonsterHeadPanel.mTargetHp) <= 1) then
        UIMonsterHeadPanel.mCurHp = UIMonsterHeadPanel.mTargetHp
        UIMonsterHeadPanel.mLastHp = UIMonsterHeadPanel.mTargetHp
    else
        UIMonsterHeadPanel.mHpShadowTimer = UIMonsterHeadPanel.mHpShadowTimer + CS.UnityEngine.Time.deltaTime
        if (UIMonsterHeadPanel.mHpShadowTimer > UIMonsterHeadPanel.mUpdateHpShadowTime) then
            UIMonsterHeadPanel.mLastHp = UIMonsterHeadPanel.mCurHp
            UIMonsterHeadPanel.mHpShadowTimer = 0
        end
    end

    --- 怪物
    if (UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Monster) then
        local ratio = self.mAvater.BaseInfo.HP / UIMonsterHeadPanel.mAvater.BaseInfo.MaxHP
        if (UIMonsterHeadPanel.mCurHp == UIMonsterHeadPanel.mTargetHp) then
            UIMonsterHeadPanel.mHpShadowTimer = 0
        else
        end
        --region C#
        --第一次设置血条进度
        if (UIMonsterHeadPanel.inithp == true) then
            UIMonsterHeadPanel.GetBosshpFade_UISprite().fillAmount = ratio

            CS.CSValueTween.Begin(UIMonsterHeadPanel.GetBossHP_Slider().gameObject, 0.01, UIMonsterHeadPanel.GetBossHP_Slider().value, ratio, function(item, value)
                UIMonsterHeadPanel.GetBossHP_Slider().value = value
                if (UIMonsterHeadPanel.GetBossHP_Slider().thumb.localPosition.x - UIMonsterHeadPanel.GetBosshpvalue_UILabel().width <= -80) then
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetBossHP_Slider().transform
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().pivot = CS.UIWidget.Pivot.Left;
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-80, 0, 0)
                else
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetBossHP_Slider().thumb
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().pivot = CS.UIWidget.Pivot.Right;
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-5, 0, 0)
                end
            end)
        else
            CS.CSValueTween.Begin(UIMonsterHeadPanel.GetBossHP_Slider().gameObject, 1, UIMonsterHeadPanel.GetBossHP_Slider().value, ratio, function(item, value)
                UIMonsterHeadPanel.GetBossHP_Slider().value = value
                if (UIMonsterHeadPanel.GetBossHP_Slider().thumb.localPosition.x - UIMonsterHeadPanel.GetBosshpvalue_UILabel().width <= -80) then
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetBossHP_Slider().transform
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().pivot = CS.UIWidget.Pivot.Left;
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-80, 0, 0)
                else
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetBossHP_Slider().thumb
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().pivot = CS.UIWidget.Pivot.Right;
                    UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-5, 0, 0)
                end
            end)
        end

        --endregion
        ---人物 灵兽
    elseif (UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Player or UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Pet or UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Servant) then
        local ratio = 0
        local oldratio = 0
        local maxHp = UIMonsterHeadPanel.mAvater.BaseInfo.TotalHpMax --or UIMonsterHeadPanel.mAvater.BaseInfo.MaxHP
        if (UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Servant) then
            self:GetLevel_UILabel().gameObject:SetActive(false)
        else
            self:GetLevel_UILabel().gameObject:SetActive(true)
        end
        if (UIMonsterHeadPanel.mAvater.BaseInfo.MaxHP ~= 0) then
            ratio = self.mAvater.BaseInfo.HP / maxHp
        else
            ratio = 0
        end
        if (UIMonsterHeadPanel.mAvater.BaseInfo.MaxHP ~= 0) then
            oldratio = UIMonsterHeadPanel.mLastHp / maxHp
        else
        end
        if (UIMonsterHeadPanel.GetRolehp_UISprite()) then
            local hpFillValue = ternary(maxHp == UIMonsterHeadPanel.mCurHp, 1, ratio)
            UIMonsterHeadPanel.GetRolehp_UISprite().fillAmount = hpFillValue
        end
        if (UIMonsterHeadPanel.GetHpLayer_UILabel() and UIMonsterHeadPanel.GetHpLayer_UILabel().gameObject.activeSelf) then
            UIMonsterHeadPanel.GetHpLayer_UILabel().gameObject:SetActive(false)
        end
        if (UIMonsterHeadPanel.inithp == true) then
            CS.CSValueTween.Begin(UIMonsterHeadPanel.GetRoleHP_Slider().gameObject, 0.01, UIMonsterHeadPanel.GetRoleHP_Slider().value, UIMonsterHeadPanel.GetRolehp_UISprite().fillAmount, function(item, value)
                UIMonsterHeadPanel.GetRoleHP_Slider().value = value
                UIMonsterHeadPanel.GetRolehpFade_UISprite().fillAmount = 0
                if (UIMonsterHeadPanel.GetRoleHP_Slider().thumb.localPosition.x - UIMonsterHeadPanel.GetRolehpvalue_UILabel().width <= -70) then
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetRoleHP_Slider().transform
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().pivot = CS.UIWidget.Pivot.Left;
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-70, 0, 0)
                else
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetRoleHP_Slider().thumb
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().pivot = CS.UIWidget.Pivot.Right;
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-5, 0, 0)
                end
            end)
        else
            CS.CSValueTween.Begin(UIMonsterHeadPanel.GetRoleHP_Slider().gameObject, 1, UIMonsterHeadPanel.GetRoleHP_Slider().value, UIMonsterHeadPanel.GetRolehp_UISprite().fillAmount, function(item, value)
                UIMonsterHeadPanel.GetRoleHP_Slider().value = value
                if (UIMonsterHeadPanel.GetRoleHP_Slider().thumb.localPosition.x - UIMonsterHeadPanel.GetRolehpvalue_UILabel().width <= -70) then
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetRoleHP_Slider().transform
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().pivot = CS.UIWidget.Pivot.Left;
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-70, 0, 0)
                else
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.parent = UIMonsterHeadPanel.GetRoleHP_Slider().thumb
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().pivot = CS.UIWidget.Pivot.Right;
                    UIMonsterHeadPanel.GetRolehpvalue_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-5, 0, 0)
                end
            end)
        end
    end
    UIMonsterHeadPanel.inithp = false
    --endregion
end

function UIMonsterHeadPanel.BindUIEvents()

    if UIMonsterHeadPanel.GetHeadIcon_BoxCollider() ~= nil then
        UIMonsterHeadPanel.GetHeadIcon_BoxCollider().enabled = true
    end
    local UIEventListener = CS.UIEventListener
    ---添加事件
    if (UIMonsterHeadPanel.GetOtherRoleIcon_GameObject() ~= nil) then
        UIEventListener.Get(UIMonsterHeadPanel.GetOtherRoleIcon_GameObject()).onClick = UIMonsterHeadPanel.RoleIcononClick
    end

    if (UIMonsterHeadPanel.GetRoleClose_GameObject() ~= nil) then
        UIEventListener.Get(UIMonsterHeadPanel.GetRoleClose_GameObject()).onClick = UIMonsterHeadPanel.OnClose
    end
    if (UIMonsterHeadPanel.GetBossClose_GameObject() ~= nil) then
        UIEventListener.Get(UIMonsterHeadPanel.GetBossClose_GameObject()).onClick = UIMonsterHeadPanel.OnClose
    end

    --UIMonsterHeadPanel.CallOnActivityButtonsOpened = function()
    --    uimanager:HidePanel(UIMonsterHeadPanel);
    --    UIMonsterHeadPanel.mHidePanel = true;
    --end
    --luaEventManager.BindCallback(LuaCEvent.ActivityButtons_OnButtonsOpened, UIMonsterHeadPanel.CallOnActivityButtonsOpened);
    --
    --UIMonsterHeadPanel.CallOnActivityButtonsClosed = function()
    --    if(UIMonsterHeadPanel.mHidePanel) then
    --        UIMonsterHeadPanel.mHidePanel = false;
    --        uimanager:ReShowPanel(UIMonsterHeadPanel);
    --    end
    --end
    --luaEventManager.BindCallback(LuaCEvent.ActivityButtons_OnButtonsClosed, UIMonsterHeadPanel.CallOnActivityButtonsClosed);
end

function UIMonsterHeadPanel.BindMessage()
    UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.Scene_PlayerExitView, UIMonsterHeadPanel.HidePanel)
    UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OnFreshSelectAvatarHP, UIMonsterHeadPanel.OnUpdateFightHurtChange)
    --UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OnFreshSelectAvatarHP, UIMonsterHeadPanel.RefreshPanel)
    --UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateMp, UIMonsterHeadPanel.RefreshPlayer)
    UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OwenerNameChange, UIMonsterHeadPanel.onOwnerNameChangeCallBack)
    UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerHeadColorChange, UIMonsterHeadPanel.onPKOwnerNameChangeCallBack)
    UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BuDouKaiStageRefresh, UIMonsterHeadPanel.OnRefreshName)
    UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MonsterNameColorChange, UIMonsterHeadPanel.OnRefreshNameColor)
    UIMonsterHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.AvaterLevelChange, function(msgId, avaterLid, oldValue, newValue)
        UIMonsterHeadPanel:OnAvaterLevelChange(msgId, avaterLid, oldValue, newValue)
    end)

    UIMonsterHeadPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMapCommonMessage, UIMonsterHeadPanel.OnMapCommonMessage)

    UIMonsterHeadPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AnimalBossHurtBuffRefresh, function()
        UIMonsterHeadPanel:RefreshAnimalBossBuff()
    end)
end
--endregion

--region UIEvent
function UIMonsterHeadPanel.RoleIcononClick()
    if UIMonsterHeadPanel.BiqiMysteryMen() then
        return
    end

    if (CS.CSScene.MainPlayerInfo:IsInCommerceMap()) then
        return ;
    end
    if not UIMonsterHeadPanel.IsCanClickIcon() then
        return
    end
    ---判断点击的是否是玩家
    if UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Player then

        local mapId = CS.CSScene.getMapID()

        local meetLYMJ = CS.Cfg_GlobalTableManager.Instance:IsLangYanMengJingMap(mapId)

        local meetBudowill = CS.CSScene.MainPlayerInfo.BudowillInfo:IsChangeModelAndName(UIMonsterHeadPanel.mavaterId)

        if meetLYMJ then
            -- 狼烟梦境判定
            CS.Utility.ShowTips("在梦境中无法查看信息")
            return
        end

        if not meetBudowill then
            -- 武道会判定
            local playerId = CS.CSScene.MainPlayerInfo.ID
            local clickPlayerId = UIMonsterHeadPanel.mAvater.BaseInfo.ID
            local isMember, teamPlayerData = CS.CSScene.MainPlayerInfo.GroupInfoV2:IsTeamMember(clickPlayerId)
            local hostid = (UIMonsterHeadPanel.mAvater.Info ~= nil and UIMonsterHeadPanel.mAvater.Info.RemoteHostInfo ~= nil) and
                    UIMonsterHeadPanel.mAvater.Info.RemoteHostInfo.RemoteHostId or 0
            if isMember then
                local type = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain and LuaEnumPanelIDType.TeamPanel_MyTeamPanel or LuaEnumPanelIDType.TeamPanel_Members;

                uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                    panelType = type,
                    isShowArrow = true,
                    roleId = clickPlayerId,
                    roleName = UIMonsterHeadPanel.mAvater.BaseInfo.Name,
                    roleSex = Utility.EnumToInt(UIMonsterHeadPanel.mAvater.BaseInfo.Sex),
                    roleCareer = Utility.EnumToInt(UIMonsterHeadPanel.mAvater.BaseInfo.Career),
                    teamData = teamPlayerData,
                    isFromHeadPanel = true,
                    hostId = hostid,
                })
            else
                uimanager:CreatePanel("UIGuildTipsPanel", function(panel)
                    panel.baseInfo = UIMonsterHeadPanel.mAvater.BaseInfo
                end, {
                    panelType = LuaEnumPanelIDType.MonsterHeadPanel,
                    isShowArrow = true,
                    roleId = clickPlayerId,
                    roleName = UIMonsterHeadPanel.mAvater.BaseInfo.Name,
                    roleSex = Utility.EnumToInt(UIMonsterHeadPanel.mAvater.BaseInfo.Sex),
                    roleCareer = Utility.EnumToInt(UIMonsterHeadPanel.mAvater.BaseInfo.Career),
                    isFromHeadPanel = true,
                    hostId = hostid,
                })
            end
        end
    elseif UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Monster then
        local res, monsterHeadInfo = CS.Cfg_BossTableManager.Instance.BossDic:TryGetValue(UIMonsterHeadPanel.mAvater.MonsterTable.id)
        if res then
            local customData = {};
            customData.avater = UIMonsterHeadPanel.mAvater
            customData.id = UIMonsterHeadPanel.mAvater.MonsterTable.id;
            customData.level = UIMonsterHeadPanel.mAvater.BaseInfo.Level;
            customData.color = UIMonsterHeadPanel.mAvater.Head.ActorName.color;
            uimanager:CreatePanel("UIBossinfoPanel", function(panel)
                panel.go.transform.localPosition = CS.UnityEngine.Vector3(-145, 266, 0)
            end, customData)
        else
            local resmons, monsterTable = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(UIMonsterHeadPanel.mAvater.MonsterTable.id)
            if (resmons) then
                if monsterTable.type == LuaEnumMonsterType.PersonDartCar then
                    uimanager:CreatePanel("UIGuildTipsPanel", function(panel)
                        panel.baseInfo = UIMonsterHeadPanel.mAvater.BaseInfo
                    end, {
                        panelType = LuaEnumPanelIDType.PersonDartCarHeadPanel,
                        isShowArrow = true,
                        roleId = UIMonsterHeadPanel.mAvater.BaseInfo.Data.masterId,
                        roleName = UIMonsterHeadPanel.mAvater.BaseInfo.Data.masterName,
                        isFromHeadPanel = true,
                    })
                else
                    if monsterTable.dropShow == nil or monsterTable.dropShow.list.Count == 0 then
                        return
                    end
                    local customData = {};
                    customData.avater = UIMonsterHeadPanel.mAvater
                    customData.id = UIMonsterHeadPanel.mAvater.MonsterTable.id;
                    customData.level = UIMonsterHeadPanel.mAvater.BaseInfo.Level;
                    customData.color = UIMonsterHeadPanel.mAvater.Head.ActorName.color;
                    uimanager:CreatePanel("UIBossinfoPanel", function(panel)
                        panel.go.transform.localPosition = CS.UnityEngine.Vector3(-145, 266, 0)
                    end, customData)
                end
            end
        end
    elseif UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Servant then

        if UIMonsterHeadPanel.mAvater.BaseInfo ~= nil and UIMonsterHeadPanel.mAvater.BaseInfo.MasterID == CS.CSScene.MainPlayerInfo.ID then
            local ServantHeadPanel = uimanager:GetPanel("UIServantHeadPanel")
            if (ServantHeadPanel ~= nil) then
                ServantHeadPanel.OpenServantPanelByServantID(UIMonsterHeadPanel.mAvater.BaseInfo.ID)
            end
            return
        end
        local mapId = CS.CSScene.getMapID()
        local meetLYMJ = CS.Cfg_GlobalTableManager.Instance:IsLangYanMengJingMap(mapId)

        local meetBudowill = CS.CSScene.MainPlayerInfo.BudowillInfo:IsChangeModelAndName(UIMonsterHeadPanel.mavaterId)

        if meetLYMJ then
            -- 狼烟梦境判定
            CS.Utility.ShowTips("在梦境中无法查看信息")
            return
        end
        if not meetBudowill then
            -- 武道会判定
            local clickPlayerId = UIMonsterHeadPanel.mAvater.BaseInfo.MasterID
            uimanager:CreatePanel("UIGuildTipsPanel", function(panel)
                panel.baseInfo = UIMonsterHeadPanel.mAvater.BaseInfo
                panel.OpenPanel(LuaEnumPanelIDType.ServantHeadPanel, nil)
            end, {
                panelType = LuaEnumPanelIDType.ServantHeadPanel,
                isShowArrow = true,
                roleId = clickPlayerId,
                roleName = UIMonsterHeadPanel.mAvater.BaseInfo.Name,
                isFromHeadPanel = true,
            })
        end
    elseif UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Servant then

    end
end

function UIMonsterHeadPanel.OnClose()
    if CS.CSScene.IsLanuchMainPlayer then
        if CS.CSAutoFightMgr.Instance.IsOn == false then
            CS.CSScene.Sington.MainPlayer.SkillEngine.SkillReleaseType = CS.ESkillReleaseMethodType.None
        end
        CS.CSScene.Sington.MainPlayer.TouchEvent:cancelSelect()
    end
    uimanager:ClosePanel("UIMonsterHeadPanel")
end

function UIMonsterHeadPanel.OnUpdateFightHurtChange(eventID, targetID)
    if UIMonsterHeadPanel.mAvater ~= nil then
        if targetID ~= nil and targetID == UIMonsterHeadPanel.mAvater.ID and targetID ~= 0 then
            UIMonsterHeadPanel:Refresh()
        end
    end
end

--怪物归属发生改变
function UIMonsterHeadPanel.onOwnerNameChangeCallBack(eventid, id, value)
    if id == UIMonsterHeadPanel.mavaterId then
        UIMonsterHeadPanel:RefreshOwnerName(value)
    end
end

--怪物归属发生改变
function UIMonsterHeadPanel.onPKOwnerNameChangeCallBack(eventid, id, value)
    UIMonsterHeadPanel:RefreshOwnerName()
end

--灵兽合体血量变化
function UIMonsterHeadPanel.OnUpdateShowHpChange(eventid, id)
    if id == UIMonsterHeadPanel.mavaterId then
        UIMonsterHeadPanel:Refresh()
    end

end

function UIMonsterHeadPanel.OnRefreshName()
    UIMonsterHeadPanel:Refresh()
    UIMonsterHeadPanel:RefreshTypeNameAnchor()
end

function UIMonsterHeadPanel.OnRefreshNameColor()
    UIMonsterHeadPanel:OnRefreshMonsterNameColor()
end

function UIMonsterHeadPanel:OnAvaterLevelChange(msgId, avaterLid, oldValue, newValue)
    if avaterLid == self.mAvater.ID then
        luaclass.UIRefresh:RefreshLabel(self.GetLevel_UILabel(), tostring(self.mAvater.BaseInfo.Level))
    end
end

function UIMonsterHeadPanel:OnRefreshMonsterNameColor()
    if (self.mAvater.AvatarType == CS.EAvatarType.Monster) then
        if (self.GetLabName_UILabel()) then
            if (self.mAvater.Head) then
                self.GetLabName_UILabel().color = self.mAvater.Head.ActorName.color
            end
        end
    end
end

--endregion

--region 面板
--刷新面板
function UIMonsterHeadPanel:Refresh()
    if (self == nil) then
        return
    end

    if (self.mAvater == nil or self.mAvater.BaseInfo == nil) then
        return
    end
    local hp = self.mAvater.AvatarType ~= CS.EAvatarType.Player and self.mAvater.BaseInfo.HP or self.mAvater.BaseInfo.TotalHP
    if (hp <= 0) then
        gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetIsTarget(false)
        uimanager:ClosePanel("UIMonsterHeadPanel")
        return
    end

    if (self.GetLevel_UILabel() ~= nil) then
        local monsterTbl = self.mAvater.MonsterTbl
        if monsterTbl then
--[[            if monsterTbl.reinLv > 0 then
                self.GetLevel_UILabel().text = tostring(monsterTbl.reinLv) .. "转"
            else
                self.GetLevel_UILabel().text = monsterTbl.showLevel
            end]]
            self.GetLevel_UILabel().text = monsterTbl.showLevel
        else
            self.GetLevel_UILabel().text = tostring(self.mAvater.BaseInfo.Level)
        end
    end

    self.mTargetHp = hp
    self:RefreshPanel()

    if not self.mStarted_bool and self.GetTypeName_UILabel() then
        self.GetTypeName_UILabel().text = ""
    end

    if (self.mAvater.AvatarType == CS.EAvatarType.Pet or self.mAvater.AvatarType == CS.EAvatarType.Servant) then
        if (self.mStarted_bool == false) then
            if (self.GetRolehpGo_GameObject() ~= nil) then
                self.GetRolehpGo_GameObject():SetActive(true)
            end
            if (self.GetBosshpGO_GameObject() ~= nil) then
                self.GetBosshpGO_GameObject():SetActive(false)
            end

            if (self.GetLabName_UILabel()) then
                self.GetLabName_UILabel().text = self.mAvater.BaseInfo.Name
                if (self.mAvater.Head) then
                    self.GetLabName_UILabel().color = self.mAvater.Head.ActorName.color
                end
            end
        end
        self.RefreshPlayer()
        self.SetSpecialMapPlayerInfo()
    elseif (self.mAvater.AvatarType == CS.EAvatarType.Pet) then
        return
    elseif (self.mAvater.AvatarType == CS.EAvatarType.Monster) then
        if (not self.mStarted_bool) then
            if (self.GetRolehpGo_GameObject() ~= nil) then
                self.GetRolehpGo_GameObject():SetActive(false)
            end
            if (self.GetBosshpGO_GameObject() ~= nil) then
                self.GetBosshpGO_GameObject():SetActive(true)
            end
            if (self.GetLabName_UILabel()) then
                self.GetLabName_UILabel().text = self.mAvater.BaseInfo.Name
                --[[if self.GetTypeName_UILabel() then
                    self.GetTypeName_UILabel().text = CS.Cfg_GlobalTableManager.Instance:GetMonsterTypeNameByTypeId(self.mAvater.BaseInfo.Type)
                end
                ]]
                if (self.mAvater.Head) then
                    self.GetLabName_UILabel().color = self.mAvater.Head.ActorName.color
                end
            end
        end
        self:RefreshMonster()
    elseif self.mAvater.AvatarType == CS.EAvatarType.Player then
        if (self.GetRolehpGo_GameObject() ~= nil) then
            self.GetRolehpGo_GameObject():SetActive(true)
        end
        if (self.GetBosshpGO_GameObject() ~= nil) then
            self.GetBosshpGO_GameObject():SetActive(false)
        end

        if (self.GetLabName_UILabel()) then
            local nameStr = ''
            if CS.Cfg_GlobalTableManager.CfgInstance:IsLangYanMengJingMap(CS.CSScene.getMapID()) then
                nameStr = '同梦者'
            elseif (CS.CSScene.MainPlayerInfo:IsInCommerceMap()) then
                nameStr = "商会会员"
                -- 武道会判定
            elseif CS.CSScene.MainPlayerInfo.BudowillInfo:IsChangeModelAndName(UIMonsterHeadPanel.mavaterId) then
                nameStr = "神秘武者"
            else
                nameStr = self.mAvater.BaseInfo.Name
            end
            if (self.mAvater.Head) then
                self.GetLabName_UILabel().color = self.mAvater.Head.ActorName.color
            end
            self.GetLabName_UILabel().text = nameStr
        end
        self.RefreshPlayer()
    end
    self:RefreshPetrifactState()
end

--刷新人物头像面板
function UIMonsterHeadPanel.RefreshPlayer()

    if UIMonsterHeadPanel.buff then
        UIMonsterHeadPanel.buff:SetBuffPos(true)
    end
    if (UIMonsterHeadPanel.mAvater == nil) then
        return
    end
    if (UIMonsterHeadPanel.mStarted_bool == false) then
        UIMonsterHeadPanel.mStarted_bool = true
        UIMonsterHeadPanel.GetHeadFrame_UISprite().gameObject:SetActive(true)
        UIMonsterHeadPanel.GetLevel_UILabel().transform.parent.gameObject:SetActive(true)
        local headIcon = ""
        if (UIMonsterHeadPanel.mAvater.AvatarType ~= CS.EAvatarType.Player) then
            local resmons, monsterTable = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(UIMonsterHeadPanel.mAvater.BaseInfo.Data.mid)
            if (resmons) then
                headIcon = monsterTable.head
            end
        else
            headIcon = "headicon" .. CS.System.String.Format(tostring(Utility.EnumToInt(UIMonsterHeadPanel.mAvater.Info.Sex)) .. tostring(Utility.EnumToInt(UIMonsterHeadPanel.mAvater.Info.Career)))
        end
        UIMonsterHeadPanel.GetHeadIcon_UISprite().spriteName = headIcon --== CS.ECareer.CunMin, CS.ECareer.Warrior, UIMonsterHeadPanel.mAvater.Info.Career)))
        UIMonsterHeadPanel.GetHeadIcon_UISprite():MakePixelPerfect()
    end
    local strInfo = ""
    CS.CSStringBuilder.Clear()
    if (UIMonsterHeadPanel.GetRolehpvalue_UILabel() ~= nil) then
        local hpPercentage = UIMonsterHeadPanel.mAvater.BaseInfo.TotalHP / UIMonsterHeadPanel.mAvater.BaseInfo.TotalHpMax * 100
        hpPercentage = Utility.FloatRounding(hpPercentage, 0)
        UIMonsterHeadPanel.GetRolehpvalue_UILabel().text = tostring(hpPercentage) .. '%'
    end
end

--设置特殊信息
function UIMonsterHeadPanel.SetSpecialMapPlayerInfo()
end

--刷新怪物头像面板
function UIMonsterHeadPanel:RefreshMonster()
    local isHideHp = self.mAvater.MonsterTable ~= nil and
            self.mAvater.MonsterTable.functionType == 1 and
            self.mAvater.BaseInfo.treasureMonsterTable ~= nil and
            (self.mAvater.BaseInfo.treasureMonsterTable.type == 1 or self.mAvater.BaseInfo.treasureMonsterTable.type == 3)

    local hpPercentage = self.mAvater.BaseInfo.HP / self.mAvater.BaseInfo.MaxHP * 100
    hpPercentage = Utility.FloatRounding(hpPercentage, 0)
    self.GetBosshpvalue_UILabel().text = not isHideHp and tostring(hpPercentage) .. '%' or "???"

    if (self.mStarted_bool == false) then
        self.mStarted_bool = true
        local monster = self.mAvater
        if (monster.MonsterTable == nil) then
            return
        end
        local tbl_monster = monster.MonsterTable
        self.mHpLayerValue = tbl_monster.hpshow
        self.oneLayerHp = self.mAvater.BaseInfo.MaxHP / self.mHpLayerValue
        self.GetHeadIcon_UISprite().spriteName = tostring(tbl_monster.head)
        self.GetHeadFrame_UISprite().gameObject:SetActive(true)
        self.GetLevel_UILabel().transform.parent.gameObject:SetActive(true)
        self.GetHeadIcon_UISprite():MakePixelPerfect()
    end
end

--刷新归属名称
function UIMonsterHeadPanel:RefreshOwnerName(value)

    if CS.StaticUtility.IsNull(UIMonsterHeadPanel.GetBelongName_UILabel()) then
        return
    end

    local OwnerName = ''
    --归属名称
    if self.mAvater.AvatarType ~= CS.EAvatarType.Monster then
        UIMonsterHeadPanel.GetBelongName_UILabel().gameObject:SetActive(false)
        return
    end

    ---检查怪物归属是否为玩家（幽灵船功能）
    if self.mAvater.Info ~= nil then
        if self.mAvater.Info.monsterTable ~= nil then
            if self.mAvater.Info.monsterTable.id ~= nil and CS.CSScene.Sington ~= nil then
                gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetIsTarget(CS.CSScene.Sington.MainPlayer.ID == self.mAvater.OwnerId)
                if CS.CSScene.Sington.MainPlayer.ID == self.mAvater.OwnerId then
                    gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetMonsterId(self.mAvater.Info.monsterTable.id)
                end
            end
        end
    end

    if CS.Cfg_GlobalTableManager.CfgInstance:IsLangYanMengJingMap(CS.CSScene.getMapID()) then
        local selfname = CS.CSScene.MainPlayerInfo.Name
        if (value ~= nil) then
            if (CS.System.String.IsNullOrEmpty(value)) then
                OwnerName = ''
            else
                if (value ~= selfname) then
                    OwnerName = "同梦者"
                else
                    OwnerName = value
                end
            end
        else
            if CS.System.String.IsNullOrEmpty(self.mAvater.Info.OwnerName) then
                OwnerName = ''
            else
                if (self.mAvater.Info.OwnerName ~= selfname) then
                    OwnerName = '同梦者'
                else
                    OwnerName = selfname
                end
            end
        end
        -- 武道会判定
    elseif CS.CSScene.MainPlayerInfo.BudowillInfo:IsChangeModelAndName(UIMonsterHeadPanel.mavaterId) then
        local selfname = CS.CSScene.MainPlayerInfo.Name
        if (value ~= nil) then
            if (CS.System.String.IsNullOrEmpty(value)) then
                OwnerName = ''
            else
                if (value ~= selfname) then
                    OwnerName = "神秘武者"
                else
                    OwnerName = value
                end
            end
        else
            if CS.System.String.IsNullOrEmpty(self.mAvater.Info.OwnerName) then
                OwnerName = ''
            else
                if (self.mAvater.Info.OwnerName ~= selfname) then
                    OwnerName = '神秘武者'
                else
                    OwnerName = selfname
                end
            end
        end
    elseif self.mAvater.Info ~= nil and self.mAvater.Info.monsterTable ~= nil and CS.Cfg_GlobalTableManager.Instance:IsNeetNotShowOwnerNameOfID(self.mAvater.Info.monsterTable.id) then
        --特殊怪物不需要显示
        UIMonsterHeadPanel.GetBelongName_UILabel().gameObject:SetActive(false)
        return
    else
        if value ~= nil then
            OwnerName = value
        elseif self.mAvater ~= nil then
            OwnerName = self.mAvater.Info.OwnerName ~= nil and self.mAvater.Info.OwnerName or ''
        end
    end

    local avater = CS.CSScene.Sington:getAvatar(self.mAvater.OwnerId)
    if (avater ~= nil and avater.Head ~= nil) then
        UIMonsterHeadPanel.GetBelongName_UILabel().color = avater.Head.ActorName.color
    end
    UIMonsterHeadPanel.GetBelongName_UILabel().gameObject:SetActive(OwnerName ~= "")
    if UIMonsterHeadPanel.buff then
        UIMonsterHeadPanel.buff:SetBuffPos(OwnerName == "")
    end
    UIMonsterHeadPanel.GetBelongName_UILabel().text = OwnerName
end

--获取Boss血条sprite
function UIMonsterHeadPanel.GetBosshpSpritename(value)
    if (value == 1) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight"
        return "redline"
    elseif (value == 2) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight1"
        return "redline1"
    elseif (value == 3) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight2"
        return "redline2"
    elseif (value == 4) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight3"
        return "redline3"
    elseif (value == 5) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight4"
        return "redline4"
    elseif (value == 6) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight5"
        return "redline5"
    else
        return ""
    end
end

function UIMonsterHeadPanel.GetLastBossHpSpritename(value)
    if (value == 1) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight"
        return "redline"
    elseif (value == 2) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight1"
        return "redline1"
    elseif (value == 3) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight2"
        return "redline2"
    elseif (value == 4) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight3"
        return "redline3"
    elseif (value == 5) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight4"
        return "redline4"
    elseif (value == 6) then
        --UIMonsterHeadPanel.GetBosshpEffect_UISprite().spriteName = "redlight5"
        return "redline5"
    else
        return ""
    end
end

--刷新怪物名字后缀
function UIMonsterHeadPanel:RefreshTypeNameAnchor()
    if UIMonsterHeadPanel.refreshTypeNameAnchor ~= nil and CS.ListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIMonsterHeadPanel.refreshTypeNameAnchor)
        UIMonsterHeadPanel.refreshTypeNameAnchor = nil
    end
    UIMonsterHeadPanel.refreshTypeNameAnchor = CS.CSListUpdateMgr.Add(100, nil, function()
        CS.CSListUpdateMgr.Instance:Remove(UIMonsterHeadPanel.refreshTypeNameAnchor)
        UIMonsterHeadPanel.refreshTypeNameAnchor = nil
        if CS.StaticUtility.IsNull(self.go) or UIMonsterHeadPanel.GetTypeName_UILabel() == nil or CS.StaticUtility.IsNull(UIMonsterHeadPanel.GetTypeName_UILabel()) then
            return
        end
        --UIMonsterHeadPanel.GetTypeName_UILabel():UpdateAnchors()
    end, false)
end

--比奇神秘人
function UIMonsterHeadPanel.BiqiMysteryMen()
    if CS.CSScene:getMapID() == Utility.EnumToInt(CS.ESpecialMap.YeZhanBiQiScene) and UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Player then
        UIMonsterHeadPanel.GetLabName_UILabel().text = '神秘人'
        UIMonsterHeadPanel.GetLevel_UILabel().text = '?'
        UIMonsterHeadPanel.GetRolehpvalue_UILabel().text = ''
        UIMonsterHeadPanel.GetRolempvalue_UILabel().text = ''
        UIMonsterHeadPanel.GetRolehead_UISprite().gameObject:SetActive(true);
        UIMonsterHeadPanel.GetRolehead_UISprite().spriteName = 'headicon14'
        return true
    end
    return false
end

function UIMonsterHeadPanel:HidePanel()
    gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetIsTarget(false)
    uimanager:ClosePanel("UIMonsterHeadPanel")
end
--endregion

--region buff

---刷新生肖boss伤害buff
function UIMonsterHeadPanel:RefreshAnimalBossBuff()
    if self.mAvater ~= nil and self.mAvater.AvatarType == CS.EAvatarType.Monster and UIMonsterHeadPanel.buff ~= nil then
        if LuaGlobalTableDeal:CheckRefreshAnimalBossBuff() then
            UIMonsterHeadPanel.buff:RefreshAllBuffers()
        end
    end
end

---初始化客户单buff数据
function UIMonsterHeadPanel:InitClientBuffData()
    if self.mAvater ~= nil and self.mAvater.AvatarType == CS.EAvatarType.Monster then
        if self.mAvater.BaseInfo ~= nil and self.mAvater.BaseInfo.Data ~= nil and self.mAvater.BaseInfo.BuffInfo ~= nil then
            ---是否需要添加生肖boss伤害buff
            if LuaGlobalTableDeal:IsNeedAddAnimalBossHurtBuff(self.mAvater.BaseInfo.Data.mid) then
                ---添加生肖boss伤害客户端buff
                self.mAvater.BaseInfo.BuffInfo:AddClientBuff(200000001)
            end
        end
    end
end

function UIMonsterHeadPanel:RefreshBuff()
    if UIMonsterHeadPanel.buff == nil then
        UIMonsterHeadPanel.buff = templatemanager.GetNewTemplate(UIMonsterHeadPanel.go, luaComponentTemplates.UIHeadPanel_Buff)
    end
    UIMonsterHeadPanel.buff:Show(LuaEnumRolePanelType.OtherPlayer, UIMonsterHeadPanel.mAvater)
    UIMonsterHeadPanel.buff:SetBuffPos(true)
end

---移除buff数据
function UIMonsterHeadPanel:ClearClientBuffData()
    if self.mAvater ~= nil and self.mAvater.AvatarType == CS.EAvatarType.Monster then
        if self.mAvater.BaseInfo ~= nil and self.mAvater.BaseInfo.Data ~= nil and self.mAvater.BaseInfo.BuffInfo ~= nil then
            ---是否需要添加生肖boss伤害buff
            if LuaGlobalTableDeal:IsNeedAddAnimalBossHurtBuff(self.mAvater.BaseInfo.Data.mid) then
                ---添加生肖boss伤害客户端buff
                self.mAvater.BaseInfo.BuffInfo:RemoveClientBuff(200000001)
            end
        end
    end
end

--endregion

--region 特效
UIMonsterHeadPanel.HpEffect = nil
UIMonsterHeadPanel.HpEffectPool = nil
UIMonsterHeadPanel.MpEffect = nil
UIMonsterHeadPanel.MpEffectPool = nil

UIMonsterHeadPanel.isloadHp = false
UIMonsterHeadPanel.isloadMp = false

function UIMonsterHeadPanel.ShowFillEffect(type, value)
    local code = type == 1 and '700069' or '700068'
    local resObj = type == 1 and UIMonsterHeadPanel.HpEffect or UIMonsterHeadPanel.MpEffect
    local parent = type == 1 and UIMonsterHeadPanel:GetBosshp_UISprite().transform or UIMonsterHeadPanel:GetRolemp_UISprite().transform
    if UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Player and type == 1 then
        parent = UIMonsterHeadPanel.GetRolehp_UISprite().transform
    end
    if resObj ~= nil then
        resObj.transform.parent = parent
        UIMonsterHeadPanel.ChangeFillEffect(resObj, value)
    else
        if type == 1 then
            if UIMonsterHeadPanel.isloadHp then
                return
            else
                UIMonsterHeadPanel.isloadHp = true
            end
        else
            if UIMonsterHeadPanel.isloadMp then
                return
            else
                UIMonsterHeadPanel.isloadMp = true
            end
        end
        UIMonsterHeadPanel.LoadeEffect(code, resObj, parent, function(pool, obj)

            local hpFillValue = ternary(UIMonsterHeadPanel.mAvater.BaseInfo.MaxHP == UIMonsterHeadPanel.mCurHp, 1, ratio)
            UIMonsterHeadPanel.ChangeFillEffect(resObj, hpFillValue)

            if type == 1 then
                UIMonsterHeadPanel.HpEffectPool = pool
                UIMonsterHeadPanel.HpEffect = obj
                UIMonsterHeadPanel.isloadHp = false
                local effectRender = CS.Utility_Lua.GetComponent(UIMonsterHeadPanel.HpEffect.transform, "Top_CSEffectRenderQueue")
                if (effectRender ~= nil) then
                    effectRender:BindMaterial();
                end
            else
                UIMonsterHeadPanel.HpEffectPool = pool
                UIMonsterHeadPanel.MpEffect = obj
                UIMonsterHeadPanel.isloadMp = false
                local effectRender = CS.Utility_Lua.GetComponent(UIMonsterHeadPanel.MpEffect.transform, "Top_CSEffectRenderQueue")
                if (effectRender ~= nil) then
                    effectRender:BindMaterial();
                end
            end
        end)
    end
end

---@param type number 类型 1：hp 2：mp
function UIMonsterHeadPanel.ChangeFillEffect(obj, value)
    if obj == nil then
        return
    end
    if obj.transform.localPosition ~= CS.UnityEngine.Vector3.zero then
        obj.transform.localPosition = CS.UnityEngine.Vector3.zero
        obj.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
    end

    local trans = obj.transform:Find('low/mask/post')
    if trans then
        local max = 0
        local min = -1.51
        local x = min - (value * (min - max))
        trans.localPosition = CS.UnityEngine.Vector3(x, 0, 0)
    end
    --obj.gameObject:SetActive(not self.maxLevel and self.ShowExp ~= 0)
end

function UIMonsterHeadPanel.LoadeEffect(effectCode, obj, parent, callback)
    if obj ~= nil then
        obj.transform.localPosition = CS.UnityEngine.Vector3.zero
        obj.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
        obj.gameObject:SetActive(false)
        obj.gameObject:SetActive(true)
        return
    end

    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectCode, CS.ResourceType.UIEffect, function(res)
        if res ~= nil then
            local objPool = res:GetUIPoolItem()
            if parent == nil or CS.StaticUtility.IsNull(parent) or objPool == nil then
                return
            end
            local obj = objPool.go
            obj.transform.parent = parent
            obj.transform.localPosition = CS.UnityEngine.Vector3.zero
            obj.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
            if callback ~= nil then
                callback(objPool, obj)
            end
        end
    end, CS.ResourceAssistType.UI)
end

--function UIMonsterHeadPanel.RoleHPEffectSpriteAnimationFinished()
--    UIMonsterHeadPanel.GetRolehpEffect_UISpriteAnimation().gameObject:SetActive(false)
--end

--function UIMonsterHeadPanel.BossHPEffectSpriteAnimationFinished()
--    UIMonsterHeadPanel.GetBosshpEffect_UISpriteAnimation().gameObject:SetActive(false)
--end
--endregion

--region 精英怪血条特殊处理
UIMonsterHeadPanel.StartlocalScale = CS.UnityEngine.Vector3(1, 1, 1)
UIMonsterHeadPanel.hpStartlocalPosition = CS.UnityEngine.Vector3(0, 0, 0)
UIMonsterHeadPanel.hpNumberStartlocalPosition = CS.UnityEngine.Vector3(65, 0, 0)
UIMonsterHeadPanel.closeBtnStartlocalPosition = CS.UnityEngine.Vector3(99, 0, 0)

UIMonsterHeadPanel.ElitelocalScale = CS.UnityEngine.Vector3(1, 1, 1)
UIMonsterHeadPanel.ElitelocalPosition = CS.UnityEngine.Vector3(14, 0, 0)
UIMonsterHeadPanel.EliteHpNumberlocalPosition = CS.UnityEngine.Vector3(95, 0, 0)
UIMonsterHeadPanel.ElitecloseBtnlocalPosition = CS.UnityEngine.Vector3(125, 0, 0)

---设置怪物血条大小
function UIMonsterHeadPanel.SetMonsterHeadSize()
    if (UIMonsterHeadPanel.mAvater.AvatarType == CS.EAvatarType.Monster) then
        --UIMonsterHeadPanel.GetBosshp_UISprite().transform.localPosition = UIMonsterHeadPanel.ElitelocalPosition
        --UIMonsterHeadPanel.GetBosshp_UISprite().transform.localScale = UIMonsterHeadPanel.ElitelocalScale
        --
        --UIMonsterHeadPanel.GetBosshpFade_UISprite().transform.localPosition = UIMonsterHeadPanel.ElitelocalPosition
        --UIMonsterHeadPanel.GetBosshpFade_UISprite().transform.localScale = UIMonsterHeadPanel.ElitelocalScale
        --
        --UIMonsterHeadPanel.GetBosshpbg_UISprite().transform.localPosition = UIMonsterHeadPanel.ElitelocalPosition
        --UIMonsterHeadPanel.GetBosshpbg_UISprite().transform.localScale = UIMonsterHeadPanel.ElitelocalScale

        --UIMonsterHeadPanel.GetBossClose_GameObject().transform.localPosition = UIMonsterHeadPanel.ElitecloseBtnlocalPosition
        --UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.localPosition = UIMonsterHeadPanel.EliteHpNumberlocalPosition
    else
        --UIMonsterHeadPanel.GetBosshp_UISprite().transform.localPosition = UIMonsterHeadPanel.hpStartlocalPosition
        --UIMonsterHeadPanel.GetBosshp_UISprite().transform.localScale = UIMonsterHeadPanel.StartlocalScale
        --
        --UIMonsterHeadPanel.GetBossClose_GameObject().transform.localPosition = UIMonsterHeadPanel.closeBtnStartlocalPosition
        --UIMonsterHeadPanel.GetBosshpvalue_UILabel().transform.localPosition = UIMonsterHeadPanel.hpNumberStartlocalPosition
        --
        --UIMonsterHeadPanel.GetBosshpFade_UISprite().transform.localPosition = UIMonsterHeadPanel.hpStartlocalPosition
        --UIMonsterHeadPanel.GetBosshpFade_UISprite().transform.localScale = UIMonsterHeadPanel.StartlocalScale
        --
        --UIMonsterHeadPanel.GetBosshpbg_UISprite().transform.localPosition = UIMonsterHeadPanel.hpStartlocalPosition
        --UIMonsterHeadPanel.GetBosshpbg_UISprite().transform.localScale = UIMonsterHeadPanel.StartlocalScale
    end

end

function UIMonsterHeadPanel:CollapseUIActivitiesPanel()
    luaEventManager.DoCallback(LuaCEvent.ActivityButtons_CloseButtons);
end

--endregion

--region 神庙石化怪特殊处理

function UIMonsterHeadPanel.OnMapCommonMessage(msgID, tblData)
    if tblData.type == LuaEnumCommonMapMsgType.Hunt_Status then
        if tblData.data64 == UIMonsterHeadPanel.mavaterId and UIMonsterHeadPanel.mavaterId ~= 0 then
            UIMonsterHeadPanel:RefreshPetrifactState(tblData.data)
            UIMonsterHeadPanel:RefreshWakeFill(tblData.str)
        end
    end
end

--刷新神庙石化怪物石化状态
function UIMonsterHeadPanel:RefreshPetrifactState(state)
    if self.mAvater ~= nil and self.mAvater.AvatarType == CS.EAvatarType.Monster and self.mAvater.MonsterTable ~= nil then
        if self.mAvater.MonsterTable.functionType == 1 then
            local huntState = state == nil and self.mAvater.BaseInfo.Data.huntStatus or tonumber(state)
            local isPetrifact = self.mAvater.BaseInfo ~= nil and huntState == 1
            self.GetHeadIcon_UISprite().color = isPetrifact and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.White
            return
        end
    end
    self.GetHeadIcon_UISprite().color = LuaEnumUnityColorType.White
end

--刷新唤醒进度
function UIMonsterHeadPanel:RefreshWakeFill(count)
    if self.GetWakeUp_UILabel() ~= nil and not CS.StaticUtility.IsNull(self.GetWakeUp_UILabel()) then
        if self.mAvater ~= nil and self.mAvater.AvatarType == CS.EAvatarType.Monster and self.mAvater.MonsterTable ~= nil then
            if self.mAvater.MonsterTable.functionType == 1 and self.mAvater.BaseInfo.treasureMonsterTable ~= nil then
                local curFill = count == nil and self.mAvater.BaseInfo.Data.wakeUpCount or count
                local targetCount = self.mAvater.BaseInfo.treasureMonsterTable.wakeUpTime
                if tonumber(curFill) ~= targetCount then
                    self.GetWakeUp_UILabel().text = "唤醒" .. curFill .. "/" .. targetCount
                    self.GetWakeUp_UILabel().gameObject:SetActive(true)
                    return
                end
            end
        end
        self.GetWakeUp_UILabel().gameObject:SetActive(false)
    end
end

--endregion

function UIMonsterHeadPanel.OnDestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMapCommonMessage, UIMonsterHeadPanel.OnMapCommonMessage)
    --if CS.CSResourceManager.Instance ~= nil and self ~= nil then
    --    if UIMonsterHeadPanel.HpEffect_Path ~= nil or UIMonsterHeadPanel.HpEffect_Path ~= '' then
    --        CS.CSResourceManager.Instance:ForceDestroyResource(UIMonsterHeadPanel.HpEffect_Path)
    --    end
    --    if UIMonsterHeadPanel.MpEffect_Path ~= nil or UIMonsterHeadPanel.MpEffect_Path ~= '' then
    --        CS.CSResourceManager.Instance:ForceDestroyResource(UIMonsterHeadPanel.MpEffect_Path)
    --    end
    --end
    if CS.CSObjectPoolMgr.Instance ~= nil then
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIMonsterHeadPanel.MpEffectPool)
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIMonsterHeadPanel.HpEffectPool)
    end
    if UIMonsterHeadPanel.refreshTypeNameAnchor ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIMonsterHeadPanel.refreshTypeNameAnchor)
        UIMonsterHeadPanel.refreshTypeNameAnchor = nil
    end
    if UIMonsterHeadPanel.mAvater ~= nil then
        luaEventManager.DoCallback(LuaCEvent.CloseMonsterHeadPanel, UIMonsterHeadPanel.mAvater.BaseInfo.ID)

        local buffTipsPanel = uimanager:GetPanel("UIBuffTipsPanel")
        if buffTipsPanel ~= nil and buffTipsPanel.taregetLid == UIMonsterHeadPanel.mAvater.BaseInfo.ID then
            uimanager:ClosePanel("UIBuffTipsPanel")
        end
    end
    UIMonsterHeadPanel:ClearClientBuffData()
end

function UIMonsterHeadPanel.IsCanClickIcon()
    if CS.CSScene.Sington == nil then
        return true
    end
    return CS.CSScene.Sington:GetChildCountOfLayer(CS.UILayerType.WindowsPlane) == 0
end

function ondestroy()
    if (CS.CSScene.Sington ~= nil and CS.CSScene.Sington.TargetSelection ~= nil and CS.CSScene.Sington.TargetSelection.PreviousSelectionID ~= nil) then
        CS.CSScene.Sington.TargetSelection.PreviousSelectionID = 0
    end
    UIMonsterHeadPanel.OnDestroy()
    uimanager:ClosePanel("UIBossinfoPanel")

    luaEventManager.DoCallback(LuaCEvent.FastUseItem_UpdateRandomStoneEffect)
    ;

    --luaEventManager.RemoveCallback(LuaCEvent.ActivityButtons_OnButtonsOpened, UIMonsterHeadPanel.CallOnActivityButtonsOpened);
    --luaEventManager.RemoveCallback(LuaCEvent.ActivityButtons_OnButtonsClosed, UIMonsterHeadPanel.CallOnActivityButtonsClosed);
end

return UIMonsterHeadPanel