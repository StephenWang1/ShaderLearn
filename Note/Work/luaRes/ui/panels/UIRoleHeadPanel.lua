local UIRoleHeadPanel = {}

--UI界面层级为Resident
UIRoleHeadPanel.PanelLayerType = CS.UILayerType.BasicPlane

--region 变量
UIRoleHeadPanel.mLastFightValue_int = 0
UIRoleHeadPanel.mOldFightValue_int = 0
UIRoleHeadPanel.mCurFightValue_int = 0
UIRoleHeadPanel.mTargetFightValue_int = 0
UIRoleHeadPanel.mOffsetFightValue_int = 0
UIRoleHeadPanel.mFightTimer_float = 0
UIRoleHeadPanel.mUpdateTime_float = 0.7
UIRoleHeadPanel.mUpdateDeltaTime_float = 0.03
UIRoleHeadPanel.mPkOptionDepth_int = nil
UIRoleHeadPanel.mHpRate_float = 0
UIRoleHeadPanel.mHpWarningThreshold_float = 0
UIRoleHeadPanel.mpRate_float = 0
UIRoleHeadPanel.mpWarningThreshold_float = 0
UIRoleHeadPanel.IsCanUpLevel = true
UIRoleHeadPanel.ping_Ping = nil

UIRoleHeadPanel.fightPowerEffect = nil
UIRoleHeadPanel.fightPowerEffect_Path = ''

UIRoleHeadPanel.levleEffect = nil
UIRoleHeadPanel.levleEffect_Path = ''

---是否在导航栏开启时点击过头像
UIRoleHeadPanel.mIsHeadClickedWithNavClose = false;
--endregion

--region 属性
function UIRoleHeadPanel:GetRoleLevel_UILabel()
    if (self.mRoleLevel == nil) then
        self.mRoleLevel = self:GetCurComp("WidgetRoot/rolehead/headSprite/rolelevel", "UILabel")
    end
    return self.mRoleLevel
end

function UIRoleHeadPanel:GetRoleLevel_Blink()
    if (self.mRoleLevelblink == nil) then
        self.mRoleLevelblink = self:GetCurComp("WidgetRoot/rolehead/headSprite/rolelevel", "CSFontBlink")
    end
    return self.mRoleLevelblink
end

function UIRoleHeadPanel:GetRoleFight_UILabel()
    if (self.mRoleFight == nil) then
        self.mRoleFight = self:GetCurComp("WidgetRoot/rolefight", "UILabel")
    end
    return self.mRoleFight
end

function UIRoleHeadPanel:GetCutDamage_UILabel()
    if (self.mCutDamage == nil) then
        self.mCutDamage = self:GetCurComp("WidgetRoot/cutDamage", "UILabel")
    end
    return self.mCutDamage
end

function UIRoleHeadPanel:GetCutDamage_GameObject()
    if (self.mCutDamage_GameObject == nil) then
        self.mCutDamage_GameObject = self:GetCurComp("WidgetRoot/cutDamage", "GameObject")
    end
    return self.mCutDamage_GameObject
end

function UIRoleHeadPanel:GetRoleFight_Down_UILabel()
    if (self.mRoleFight_Down == nil) then
        self.mRoleFight_Down = self:GetCurComp("WidgetRoot/fight_down/rolefight_down", "UILabel")
    end
    return self.mRoleFight_Down
end

function UIRoleHeadPanel:GetRoleIcon_UISprite()
    if (self.mRoleIcon == nil) then
        self.mRoleIcon = self:GetCurComp("WidgetRoot/rolehead/headSprite", "UISprite")
    end
    return self.mRoleIcon
end

function UIRoleHeadPanel:GetPkMode_GameObject()
    if (self.mPkModeGameObject == nil) then
        self.mPkModeGameObject = self:GetCurComp("WidgetRoot/PkMode", "GameObject")
    end
    return self.mPkModeGameObject
end

function UIRoleHeadPanel:GetPkModeSprite_UISprite()
    if (self.mPkModeSprite == nil) then
        self.mPkModeSprite = self:GetCurComp("WidgetRoot/PkMode/Background", "UISprite")
    end
    return self.mPkModeSprite
end

function UIRoleHeadPanel:GetPkModeLabel_UILabel()
    if (self.mPkModeLabel == nil) then
        self.mPkModeLabel = self:GetCurComp("WidgetRoot/PkMode/Label", "UILabel")
    end
    return self.mPkModeLabel
end

function UIRoleHeadPanel:GetPkOption_GameObject()
    if (self.mPkOption == nil) then
        self.mPkOption = self:GetCurComp("WidgetRoot/PkOption", "GameObject")
    end
    return self.mPkOption
end

function UIRoleHeadPanel:GetPkOption_UIPanel()
    if (self.mPkOption_UIPanel == nil) then
        self.mPkOption_UIPanel = self:GetCurComp("WidgetRoot/PkOption", "UIPanel")
    end
    return self.mPkOption_UIPanel
end

function UIRoleHeadPanel:GetPkAll_GameObject()
    if (self.mPkAll == nil) then
        self.mPkAll = self:GetCurComp("WidgetRoot/PkOption/all", "GameObject")
    end
    return self.mPkAll
end

function UIRoleHeadPanel:GetPkPeace_GameObject()
    if (self.mPkPeace == nil) then
        self.mPkPeace = self:GetCurComp("WidgetRoot/PkOption/peace", "GameObject")
    end
    return self.mPkPeace
end

function UIRoleHeadPanel:GetPkGoodness_GameObject()
    if (self.mPkGoodness == nil) then
        self.mPkGoodness = self:GetCurComp("WidgetRoot/PkOption/goodness", "GameObject")
    end
    return self.mPkGoodness
end

function UIRoleHeadPanel:GetPkGroup_GameObject()
    if (self.mPkGroup == nil) then
        self.mPkGroup = self:GetCurComp("WidgetRoot/PkOption/group", "GameObject")
    end
    return self.mPkGroup
end

function UIRoleHeadPanel:GetPkGuild_GameObject()
    if (self.mPkGuild == nil) then
        self.mPkGuild = self:GetCurComp("WidgetRoot/PkOption/guild", "GameObject")
    end
    return self.mPkGuild
end

function UIRoleHeadPanel:GetBtnVip_GameObject()
    if (self.mBtnVip == nil) then
        self.mBtnVip = self:GetCurComp("WidgetRoot/vip", "GameObject")
    end
    return self.mBtnVip
end

function UIRoleHeadPanel:GetVipLevel_UILabel()
    if (self.mVipLevel == nil) then
        self.mVipLevel = self:GetCurComp("WidgetRoot/vip/Label", "UILabel")
    end
    return self.mVipLevel
end

function UIRoleHeadPanel:GetToBeVip_UISprite()
    if (self.mToBeVip == nil) then
        self.mToBeVip = self:GetCurComp("WidgetRoot/vip/beVIP", "UISprite")
    end
    return self.mToBeVip
end

function UIRoleHeadPanel:GetRolehpEffect_GameObject()
    if (self.mRolehpEffect == nil) then
        self.mRolehpEffect = self:GetCurComp("WidgetRoot/rolehead/hp_bg/effect", "GameObject")
    end
    return self.mRolehpEffect
end

function UIRoleHeadPanel:GetRolempEffect_TweenPosition()
    if (self.mRolempEffect == nil) then
        self.mRolempEffect = self:GetCurComp("WidgetRoot/rolehead/mp_bg/effect", "TweenPosition")
    end
    return self.mRolempEffect
end

function UIRoleHeadPanel:GetRolehp_UISprite()
    if (self.mRolehp == nil) then
        self.mRolehp = self:GetCurComp("WidgetRoot/rolehead/hp_bg/rolehp", "UISprite")
    end
    return self.mRolehp
end

function UIRoleHeadPanel:GetRolehpSlider()
    if (self.mRolehpSlider == nil) then
        self.mRolehpSlider = self:GetCurComp("WidgetRoot/rolehead/hp", "UISlider")
    end
    return self.mRolehpSlider
end

function UIRoleHeadPanel:GetRolempValue_UILabel()
    if (self.mRolempValue == nil) then
        self.mRolempValue = self:GetCurComp("WidgetRoot/rolehead/mp/Thumb/rolempvalue", "UILabel")
    end
    return self.mRolempValue
end

function UIRoleHeadPanel:GetRoleMpSlider()
    if (self.mRoleMpSlider == nil) then
        self.mRoleMpSlider = self:GetCurComp("WidgetRoot/rolehead/mp", "UISlider")
    end
    return self.mRoleMpSlider
end

function UIRoleHeadPanel:GetHpBar_TweenFillAmount()
    if (self.mHpBar == nil) then
        self.mHpBar = self:GetCurComp("WidgetRoot/rolehead/hp_bg/rolehp", "TweenFillAmount")
    end
    return self.mHpBar
end

function UIRoleHeadPanel:GetMpBar_TweenFillAmount()
    if (self.mMpBar == nil) then
        self.mMpBar = self:GetCurComp("WidgetRoot/rolehead/mp_bg/rolemp", "TweenFillAmount")
    end
    return self.mMpBar
end

function UIRoleHeadPanel:GetBtn_buff_UISprite()
    if (self.mBtn_buff == nil) then
        self.mBtn_buff = self:GetCurComp("btn_buff", "UISprite")
    end
    return self.mBtn_buff
end

function UIRoleHeadPanel:GetBUFF_GameObject()
    if (self.mBUFF == nil) then
        self.mBUFF = self:GetCurComp("WidgetRoot/buffCon", "GameObject")
    end
    return self.mBUFF
end

function UIRoleHeadPanel:GetBuff_name_UILabel()
    if (self.mBuff_name == nil) then
        self.mBuff_name = self:GetCurComp("WidgetRoot/buffCon/tip/name", "UILabel")
    end
    return self.mBuff_name
end

function UIRoleHeadPanel:GetBtn_buff_UISprite()
    if (self.mBufftip == nil) then
        self.mBufftip = self:GetCurComp("WidgetRoot/buffCon/tip", "UISprite")
    end
    return self.mBufftip
end

function UIRoleHeadPanel:GetBuff_bg_UISprite()
    if (self.mBuff_bg == nil) then
        self.mBuff_bg = self:GetCurComp("WidgetRoot/buffCon/bg", "UISprite")
    end
    return self.mBuff_bg
end

function UIRoleHeadPanel:GetLabel_buff_UILabel()
    if (self.mLabel_buff == nil) then
        self.mLabel_buff = self:GetCurComp("btn_buff/Label", "UILabel")
    end
    return self.mLabel_buff
end

function UIRoleHeadPanel:GetBuffContainerList_UIGridContainer()
    if (self.mBuffContainerList == nil) then
        self.mBuffContainerList = self:GetCurComp("WidgetRoot/buffCon/bufflist", "UIGridContainer")
    end
    return self.mBuffContainerList
end

function UIRoleHeadPanel:GetHeadEffect_GameObject()
    if (self.mHeadEffect == nil) then
        self.mHeadEffect = self:GetCurComp("WidgetRoot/rolehead/head/headSprite/rolehead/roleHeadEffect", "GameObject")
    end
    return self.mHeadEffect
end

function UIRoleHeadPanel:GetDeltaFight_UIPlayTween()
    if (self.mDeltaFight == nil) then
        self.mDeltaFight = self:GetCurComp("WidgetRoot/fight_down/deltaFight", "UIPlayTween")
    end
    return self.mDeltaFight
end

function UIRoleHeadPanel:GetDeltaFightLabel_UILabel()
    if (self.mDeltaFightLabel == nil) then
        self.mDeltaFightLabel = self:GetCurComp("WidgetRoot/fight_down/deltaFight/num", "UILabel")
    end
    return self.mDeltaFightLabel
end

function UIRoleHeadPanel:GetPingLabel_UILabel()
    if (self.mPingLabel == nil) then
        self.mPingLabel = self:GetCurComp("WidgetRoot/PingLabel", "UILabel")
    end
    return self.mPingLabel
end

function UIRoleHeadPanel:GetHeadObj_GameObject()
    if (self.mHeadObj == nil) then
        self.mHeadObj = self:GetCurComp("WidgetRoot/rolehead/head", "GameObject")
    end
    return self.mHeadObj
end

function UIRoleHeadPanel:GetBreatheEffect_GameObject()
    if (self.mBreatheEffect == nil) then
        self.mBreatheEffect = self:GetCurComp("WidgetRoot/PkOption/BreatheEffect", "GameObject")
    end
    return self.mBreatheEffect
end

function UIRoleHeadPanel:GetRedPointEffect_GameObject()
    if (self.mRedPointEffect == nil) then
        -- if (self.GetHeadObj_GameObject() ~= nil and self.mRedPointEffect ~= nil) then
        --     CS.NGUITools.SetParent(self.GetHeadObj_GameObject().transform, self.mRedPointEffect)
        --     self.mRedPointEffect.transform.localPosition = CS.UnityEngine.Vector3(28, 25, 0)
        -- end
    end
    return self.mRedPointEffect
end

function UIRoleHeadPanel:GetRedPoint_RedPoint()
    if (self.mRedPoint_RedPoint == nil) then
        self.mRedPoint_RedPoint = self:GetCurComp("WidgetRoot/rolehead/headSprite/redpoint", "UIRedPoint")
    end
    return self.mRedPoint_RedPoint
end

function UIRoleHeadPanel:GetRoleAttackType_UISprite()
    if (self.mRoleAttackType == nil) then
        self.mRoleAttackType = self:GetCurComp("WidgetRoot/rolefight/img", "UISprite")
    end
    return self.mRoleAttackType
end

function UIRoleHeadPanel:GetPlayerInfo()
    return CS.CSScene.MainPlayerInfo
end

function UIRoleHeadPanel:GetRolehpbottom_UISprite()
    if (self.Rolehpbottom == nil) then
        self.Rolehpbottom = self:GetCurComp("WidgetRoot/rolehead/hp/rolehpbottom", "UISprite")
    end
    return self.Rolehpbottom
end

--endregion

--region 初始化
function UIRoleHeadPanel:Init()
    self:RunBaseFunction("Init")
    self.Refresh()
    CS.UnityEngine.PlayerPrefs.SetString("RoleID", tostring(CS.CSScene.MainPlayerInfo.ID))
    UIRoleHeadPanel.RefreshBuff()
    UIRoleHeadPanel.BindMessage()
    UIRoleHeadPanel.BindUIEvents()
    self:GetRoleAttackType_UISprite().spriteName = "attack" .. tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
end

function UIRoleHeadPanel.Refresh()
    if (CS.CSScene.MainPlayerInfo == nil) then
        return
    end
    local sex = tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex))
    UIRoleHeadPanel:GetRoleIcon_UISprite().spriteName = "headicon" .. sex .. tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
    UIRoleHeadPanel.InitUI()
end

function UIRoleHeadPanel.InitUI()
    UIRoleHeadPanel.InitShowEffect()
    UIRoleHeadPanel.RefreshLevel()
    UIRoleHeadPanel.RefreshFight(nil, true)
    UIRoleHeadPanel.RefreshVipLevel()
    UIRoleHeadPanel.BindLuaRedPoint()
    UIRoleHeadPanel.RefreshCutDamage()
end

--function UIRoleHeadPanel:Show()
--for i = 1, 3 do
--    CS.Utility.ShowTips("像素尺寸：" .. UIRoleHeadPanel:GetRolehpbottom_UISprite().width .. "  " .. UIRoleHeadPanel:GetRolehpbottom_UISprite().height)
--end
--end

function UIRoleHeadPanel.BindMessage()
    UIRoleHeadPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSwitchFightModelMessage, UIRoleHeadPanel.ResSwitchFightModelMessage)
    UIRoleHeadPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerAttributeChangeMessage, UIRoleHeadPanel.OnResPlayerAttributeChangeMessage)

    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdatePKMode, UIRoleHeadPanel.RefreshPkMode)
    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateVip, UIRoleHeadPanel.RefreshVip)
    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ChangeFightPowerUI, UIRoleHeadPanel.RefreshFight)
    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel, UIRoleHeadPanel.RefreshLevel)
    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapResourceLoaded, UIRoleHeadPanel.RefreshPK)
    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.FightPowerChange, UIRoleHeadPanel.RefreshFight)
    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIRoleHeadPanel.RefreshCutDamage)
    UIRoleHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.RoleSexChange, UIRoleHeadPanel.Refresh)
end

function UIRoleHeadPanel.BindUIEvents()
    local UIEventListener = CS.UIEventListener
    UIEventListener.Get(UIRoleHeadPanel:GetRoleIcon_UISprite().gameObject).onClick = UIRoleHeadPanel.RoleIcononClick
    UIEventListener.Get(UIRoleHeadPanel:GetPkMode_GameObject()).onClick = UIRoleHeadPanel.OnClickPkMode
    UIEventListener.Get(UIRoleHeadPanel:GetBtn_buff_UISprite().gameObject).onClick = UIRoleHeadPanel.OnChooseBuff

    UIEventListener.Get(UIRoleHeadPanel:GetPkAll_GameObject().gameObject).onClick = UIRoleHeadPanel.PKAllModeonClick
    UIEventListener.Get(UIRoleHeadPanel:GetPkPeace_GameObject().gameObject).onClick = UIRoleHeadPanel.PKPeaceModeonClick
    UIEventListener.Get(UIRoleHeadPanel:GetPkGoodness_GameObject().gameObject).onClick = UIRoleHeadPanel.PKGoodnessModeonClick
    UIEventListener.Get(UIRoleHeadPanel:GetPkGroup_GameObject().gameObject).onClick = UIRoleHeadPanel.PKGroupModeonClick
    UIEventListener.Get(UIRoleHeadPanel:GetPkGuild_GameObject().gameObject).onClick = UIRoleHeadPanel.PKGuildModeonClick
    UIEventListener.Get(UIRoleHeadPanel:GetPkOption_GameObject()).onClick = UIRoleHeadPanel.OpenPkOption

    UIEventListener.Get(UIRoleHeadPanel:GetBtnVip_GameObject()).onClick = UIRoleHeadPanel.BtnVIPonClick

    UIRoleHeadPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnCloseFinished, UIRoleHeadPanel.OnNavCloseFinished)
    UIRoleHeadPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshCutDmg, UIRoleHeadPanel.RefreshCutDamage)
end

--endregion

--region UI点击事件
function UIRoleHeadPanel.RoleIcononClick()
    local navPanel = uimanager:GetPanel("UINavigationPanel");
    local medalinlayPanel = uimanager:GetPanel("UIMedalInlayPanel");
    if medalinlayPanel ~= nil then
        uimanager:ClosePanel('UIMedalInlayPanel')
    end
    if (navPanel ~= nil) then
        if (navPanel:GetNavIsOpen()) then
            UIRoleHeadPanel.mIsHeadClickedWithNavClose = true
            if (luaEventManager.HasCallback(LuaCEvent.Navigation_CloseNavAndPanel)) then
                luaEventManager.DoCallback(LuaCEvent.Navigation_CloseNavAndPanel)
            end
        else
            UIRoleHeadPanel.mIsHeadClickedWithNavClose = false
            uimanager:CreatePanel("UIRolePanelTagPanel", nil)
        end
    else
        UIRoleHeadPanel.mIsHeadClickedWithNavClose = false
        uimanager:CreatePanel("UIRolePanelTagPanel", nil)
    end
end

function UIRoleHeadPanel.CallOnClosePanel(msgId, panel)
    if (UIRoleHeadPanel.mIsHeadClickedWithNavClose) then
        uimanager:CreatePanel("UIRolePanelTagPanel", nil);
        UIRoleHeadPanel.mIsHeadClickedWithNavClose = false;
    end
end

function UIRoleHeadPanel.OnNavCloseFinished()
    if (UIRoleHeadPanel.mIsHeadClickedWithNavClose and uimanager:GetPanel("UIRolePanel") == nil) then
        uimanager:CreatePanel("UIRolePanelTagPanel", nil)
        UIRoleHeadPanel.mIsHeadClickedWithNavClose = false;
    end
end

function UIRoleHeadPanel.BtnVIPonClick()
    --uimanager:CreatePanel("UIMonthCardPanel", nil)
end

function UIRoleHeadPanel.OnClickPkMode(go)
    UIRoleHeadPanel.OpenPkOption()
end

function UIRoleHeadPanel.OpenPkOption()
    local state = UIRoleHeadPanel:GetPkOption_GameObject().gameObject.activeSelf == false
    UIRoleHeadPanel:GetPkOption_GameObject():SetActive(state)
    if CS.StaticUtility.IsNull(UIRoleHeadPanel:GetPkOption_UIPanel()) == false then
        if state == true then
            ---开启时设置层级为当前层的最高层级+1
            UIRoleHeadPanel:GetPkOption_UIPanel().depth = CS.UILayerMgr.Instance:GetLayerMaxDepth(CS.UILayerType.AisstPlane) + 1
        else
            ---关闭时设置层级为较低层级
            UIRoleHeadPanel:GetPkOption_UIPanel().depth = 1
        end
    end
end

function UIRoleHeadPanel.OnStrongerClick()

end

--endregion

--region 刷新信息

---头像icon上动态绑定lua红点
---@private
function UIRoleHeadPanel.BindLuaRedPoint()
    local magicEquip_AllKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MagicEquip_All);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(magicEquip_AllKey)
    local BloodSuit_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_All);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(BloodSuit_All)
    local SealMark = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SealMark);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(SealMark)
    local Potential = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Potential);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(Potential)
    local OfficialMark = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.OfficialState);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(OfficialMark)
    local LianZhi_XiuWei = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_XiuWei);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(LianZhi_XiuWei)
    local LianZhi_GongXun = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_GongXun);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(LianZhi_GongXun)
    local collectionRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection);
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(collectionRedPoint)
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.NewAppearance))
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.TitleTalentMark))
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LuaRoleReinRedPoint))
    UIRoleHeadPanel:GetRedPoint_RedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ExpExchange))
end

function UIRoleHeadPanel.RefreshPK()

    --if UIRoleHeadPanel.IsspecialMap() then
    --    return
    --end
    --UIRoleHeadPanel.RefreshPkMode(CS.CSScene.MainPlayerInfo.PKMode)
end

function UIRoleHeadPanel.IsspecialMap()
    --9801 女神赐福
    --10016 武道会馆
    if CS.CSScene.Sington:IsOnGoddesMap() or LuaGlobalTableDeal.IsWuDaoHuiMapId(CS.CSScene.getMapID()) then
        return true;
    end
    return false;
end
--region 人物信息
function UIRoleHeadPanel.RefreshLevel(eventId, level, curlevel)
    local info = CS.CSScene.MainPlayerInfo
    if (UIRoleHeadPanel.IsCanUpLevel == false) then
        return
    end
    if (curlevel ~= nil) then
        UIRoleHeadPanel:GetRoleLevel_UILabel().text = tostring(curlevel)
        if UIRoleHeadPanel:GetRoleLevel_Blink() ~= nil then
            UIRoleHeadPanel:GetRoleLevel_Blink():Play()
        end
    else
        if (CS.CSScene.MainPlayerInfo ~= nil) then
            UIRoleHeadPanel:GetRoleLevel_UILabel().text = tostring(info.Level)
        end
    end

end

---刷新vip等级
function UIRoleHeadPanel.RefreshVipLevel()
    local vipLevel = CS.CSScene.MainPlayerInfo.VipLevel
    UIRoleHeadPanel:GetVipLevel_UILabel().text = tostring(vipLevel)
end

--endregion
--endregion

--region 客户端事件
---刷新PK模式
function UIRoleHeadPanel.RefreshPkMode(mode)
    networkRequest.ReqSwitchFightModel(mode)
end

---刷新VIP
function UIRoleHeadPanel.RefreshVip(eventid, preVipLevel, nowVipLevel)
    UIRoleHeadPanel:GetVipLevel_UILabel().text = tostring(nowVipLevel)
end

---刷新战力
function UIRoleHeadPanel.RefreshFight(id, isinit)
    UIRoleHeadPanel:GetRoleFight_UILabel().text = tostring(UIRoleHeadPanel:GetPlayerInfo().FightPower)
    if isinit == nil or not isinit then
        UIRoleHeadPanel.LoadeEffect('700052', UIRoleHeadPanel.fightPowerEffect, UIRoleHeadPanel:GetRoleFight_UILabel().transform, function(path, obj)
            UIRoleHeadPanel.fightPowerEffect = obj
            UIRoleHeadPanel.fightPowerEffect_Path = path

        end)
    end
    UIRoleHeadPanel:GetCutDamage_UILabel():UpdateAnchors()
    UIRoleHeadPanel:RefreshCutDamage()
end

function UIRoleHeadPanel.RefreshCutDamage()
    local attrData = CS.CSScene.MainPlayerInfo:GetAttrValue(Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax))
    if attrData ~= 0 then
        UIRoleHeadPanel:GetCutDamage_GameObject():SetActive(true)
        UIRoleHeadPanel:GetCutDamage_UILabel().text = tostring(attrData)
    else
        UIRoleHeadPanel:GetCutDamage_GameObject():SetActive(false)
        UIRoleHeadPanel:GetCutDamage_UILabel().text = tostring(0)
    end
end

--endregion

--region 服务器事件
---通知属性发生变化
function UIRoleHeadPanel.OnResPlayerAttributeChangeMessage(id, data)
    if data == nil then
        return
    end
    local info = UIRoleHeadPanel:GetPlayerInfo()
    info.FightPower = data.power
end

--region PK模式
--和平
function UIRoleHeadPanel.PKPeaceModeonClick()
    UIRoleHeadPanel.RefreshPkMode(0)
    UIRoleHeadPanel.OpenPkOption()
end

--组队
function UIRoleHeadPanel.PKGroupModeonClick(go)
    if Utility.TryChangeMode(go, 1, 1) then
        UIRoleHeadPanel.RefreshPkMode(1)
        UIRoleHeadPanel.OpenPkOption()
    end
end

--帮会
function UIRoleHeadPanel.PKGuildModeonClick(go)
    if Utility.TryChangeMode(go, 2, 1) then
        UIRoleHeadPanel.RefreshPkMode(2)
        UIRoleHeadPanel.OpenPkOption()
    end
end

--善恶
function UIRoleHeadPanel.PKGoodnessModeonClick()
    UIRoleHeadPanel.RefreshPkMode(4)
    UIRoleHeadPanel.OpenPkOption()
end

--全体
function UIRoleHeadPanel.PKAllModeonClick()
    UIRoleHeadPanel.RefreshPkMode(3)
    UIRoleHeadPanel.OpenPkOption()
end

function UIRoleHeadPanel.ResSwitchFightModelMessage(id, data)
    --攻击模式 0和平 1组队 2帮会 3全体 4善恶 5阵营
    if (data ~= nil) then
        if data.changedManId ~= CS.CSScene.MainPlayerInfo.ID then
            return
        end
        CS.CSScene.MainPlayerInfo.PKMode = tonumber(data.fightModel)
        if (data.fightModel == 0) then
            UIRoleHeadPanel:GetPkModeLabel_UILabel().text = "和平"
        elseif (data.fightModel == 1) then
            UIRoleHeadPanel:GetPkModeLabel_UILabel().text = "[B9ECFF]组队"
        elseif (data.fightModel == 2) then
            UIRoleHeadPanel:GetPkModeLabel_UILabel().text = "[2977EB]行会"
        elseif (data.fightModel == 3) then
            UIRoleHeadPanel:GetPkModeLabel_UILabel().text = "[FF2F2F]全体"
        elseif (data.fightModel == 4) then
            UIRoleHeadPanel:GetPkModeLabel_UILabel().text = "善恶"
        end
    end
end

--endregion

--region buff
function UIRoleHeadPanel.RefreshBuff()
    UIRoleHeadPanel.buff = templatemanager.GetNewTemplate(UIRoleHeadPanel.go, luaComponentTemplates.UIHeadPanel_Buff)
    UIRoleHeadPanel.buff:Show(LuaEnumRolePanelType.MainPlayer, nil)
end
--endregion
--endregion

--region 特效


function UIRoleHeadPanel.InitShowEffect()
    if UIRoleHeadPanel.fightPowerEffect ~= nil then
        UIRoleHeadPanel.fightPowerEffect.gameObject:SetActive(false)
    end
    if UIRoleHeadPanel.levleEffect ~= nil then
        UIRoleHeadPanel.levleEffect.gameObject:SetActive(false)
    end
end

function UIRoleHeadPanel.LoadeEffect(effectCode, obj, parent, callback)
    if obj ~= nil then
        obj.gameObject:SetActive(false)
        obj.gameObject:SetActive(true)
        return
    end

    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectCode, CS.ResourceType.UIEffect, function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            if parent == nil or CS.StaticUtility.IsNull(parent) then
                return
            end
            local obj = res:GetObjInst()
            obj.transform.parent = parent
            obj.transform.localPosition = CS.UnityEngine.Vector3.zero
            obj.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
            if callback ~= nil then
                callback(res.Path, obj, effectCode)
            end
            if effectCode == '700052' then
                res.IsCanBeDelete = false
            end
        end
    end, CS.ResourceAssistType.UI)
end


--endregion

--region otherFunc



--endregion

function UIRoleHeadPanel.OnDestroy()
    if CS.CSResourceManager.Instance ~= nil and self ~= nil then
        if UIRoleHeadPanel.fightPowerEffect ~= nil or UIRoleHeadPanel.fightPowerEffect_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UIRoleHeadPanel.fightPowerEffect_Path)
        end
        if UIRoleHeadPanel.levleEffect ~= nil or UIRoleHeadPanel.levleEffect_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UIRoleHeadPanel.levleEffect_Path)
        end
    end
end

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSwitchFightModelMessage, UIRoleHeadPanel.ResSwitchFightModelMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPlayerAttributeChangeMessage, UIRoleHeadPanel.OnResPlayerAttributeChangeMessage)
    --luaEventManager.RemoveCallback(LuaCEvent.Navigation_OnCloseFinished, UIRoleHeadPanel.OnNavCloseFinished);
    UIRoleHeadPanel.OnDestroy()
end

return UIRoleHeadPanel