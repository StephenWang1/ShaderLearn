---@class UIConfigPanel_Base:UIConfigPanel_PartBasic
local UIConfigPanel_Base = {}
setmetatable(UIConfigPanel_Base, luaComponentTemplates.UIConfigPanel_PartBasic)

--region 初始设置
function UIConfigPanel_Base:Init(uiConfigPanel)
    self:RunBaseFunction("Init", uiConfigPanel, LuaEnumConfigPanelOpenType.BasePanel)
    ---声音
    self.Transform_Sound = self:Get("sound", "Transform")
    self:SetSlider(self.Transform_Sound, "BgMusic", CS.EConfigOption.BgMusic, self.SetVolume)
    self:SetSlider(self.Transform_Sound, "EffectSound", CS.EConfigOption.EffectSound, self.SetVolume)
    self:SetSlider(self.Transform_Sound, "Voice", CS.EConfigOption.VoiceLoudspeaker, self.SetVolume)
    ---其他
    self.Transform_Other = self:Get("other", "Transform")

    self:SetToogle(self.Transform_Other, "PushActivity", CS.EConfigOption.ShowItemShortcut, UIConfigPanel_Base.SetTooleFunc)
    self:SetToogle(self.Transform_Other, "ClickBtnToSelectTarget", CS.EConfigOption.ClickBtnToSelectTarget, UIConfigPanel_Base.SetTooleFunc)
    self:SetToogle(self.Transform_Other, "SkillSchemeShortcut", CS.EConfigOption.SkillSchemeShortcut, UIConfigPanel_Base.SetTooleFunc)
    self:SetToogle(self.go.transform, "SelectRoleLevel", CS.EConfigOption.SelectRoleLevel, UIConfigPanel_Base.SetTooleFunc)
    self.Transform_SelectRoleLevel = self:Get("SelectRoleLevel", "Transform")
    self:SetDropDown(self.Transform_SelectRoleLevel, "DropDown", CS.EConfigOption.AttackPlayerList)
    --双摇杆
    self:SetToogle(self.Transform_Other, "ForbidSociety", CS.EConfigOption.DoubleJoysticks, UIConfigPanel_Base.SetTooleFunc, 3)
    --固定遥杆
    self:SetToogle(self.Transform_Other, "FixJoystick", CS.EConfigOption.FixJoystick, UIConfigPanel_Base.SetTooleFunc, 3)
    --自由遥杆
    self:SetToogle(self.Transform_Other, "FreedomSociety", CS.EConfigOption.FreedomJoyStick, UIConfigPanel_Base.SetTooleFunc, 3)

    self.attckmodel = self:Get("attckmodel", "GameObject")
    self.attckModelDropDown = self:Get("attckmodel/DropDown", "Top_UIDropDown")
    self.moshi_ArrowBtn = self:Get("attckmodel/DropDown/Caption/Btn_program", "GameObject")
    if self.attckmodel ~= nil and not CS.StaticUtility.IsNull(self.attckmodel) then
        self:SetDropDown(self.attckmodel, "DropDown", CS.EConfigOption.PkMode, function(type, pkmode)
            networkRequest.ReqSwitchFightModel(pkmode)
        end)
    end
    ---返回登录/返回选角/恢复默认
    self.BtnRestoreDefault = self:Get("btn_RestoreDefault", "GameObject")
    self.BtnReturnLogin = self:Get("btn_ReturnLoginUI", "GameObject")
    self.BtnReturnRole = self:Get("btn_ReturnRole", "GameObject")
    CS.UIEventListener.Get(self.BtnRestoreDefault).onClick = function()
        uiConfigPanel.RestoreDefault()
        self:BaseRefreshPanel()
    end
    CS.UIEventListener.Get(self.BtnReturnLogin).onClick = uiConfigPanel.OnClickBtnReturnLogin
    CS.UIEventListener.Get(self.BtnReturnRole).onClick = uiConfigPanel.OnClickBtnReturnRole
    self.attckModelDropDown.LuaEventTable = self
    self.attckModelDropDown:AddClickArrowEvent(self.CheckCanChange)
end

--endregion

--region 刷新面板
function UIConfigPanel_Base:RefreshPanel()
    if self:CheckIsRefresh() == false then
        self:BaseRefreshPanel()
    end
    self:InitRefresh()
end

function UIConfigPanel_Base:BaseRefreshPanel()
    ---声音
    self:GetSlider(self.Transform_Sound, "BgMusic", CS.EConfigOption.BgMusic)
    self:GetSlider(self.Transform_Sound, "EffectSound", CS.EConfigOption.EffectSound)
    self:GetSlider(self.Transform_Sound, "Voice", CS.EConfigOption.VoiceLoudspeaker)
    ---其他
    self:GetToogle(self.Transform_Other, "PushActivity", CS.EConfigOption.ShowItemShortcut)
    self:GetToogle(self.Transform_Other, "ClickBtnToSelectTarget", CS.EConfigOption.ClickBtnToSelectTarget)
    self:GetToogle(self.Transform_Other, "SkillSchemeShortcut", CS.EConfigOption.SkillSchemeShortcut)
    self:GetToogle(self.go.transform, "SelectRoleLevel", CS.EConfigOption.SelectRoleLevel)
    self:GetToogle(self.Transform_Other, "FixJoystick", CS.EConfigOption.FixJoystick)
    self:GetToogle(self.Transform_Other, "ForbidSociety", CS.EConfigOption.DoubleJoysticks)
    self:GetToogle(self.Transform_Other, "FreedomSociety", CS.EConfigOption.FreedomJoyStick)
    ---下拉列表
    self:GetDropDown(self.Transform_SelectRoleLevel, "DropDown", CS.EConfigOption.AttackPlayerList, self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.AttackPlayerList)), self.settingTableManager:GetDropDownTextFormat(Utility.EnumToInt(CS.EConfigOption.AttackPlayerList)))
    if self.attckmodel ~= nil and not CS.StaticUtility.IsNull(self.attckmodel) then
        self:GetDropDownByTextTable(self.attckmodel, "DropDown", CS.EConfigOption.PkMode, self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.PkMode)))
    end
end
--endregion

--region 设置音效
function UIConfigPanel_Base.SetVolume(Go_Enum, value)
    if Go_Enum == CS.EConfigOption.BgMusic then
        CS.CSAudioMgr.Instance:SetBgVolume(value)
    elseif Go_Enum == CS.EConfigOption.EffectSound then
        CS.CSAudioMgr.Instance:SetEffectVolume(value)
    elseif Go_Enum == CS.EConfigOption.VoiceLoudspeaker then
        CS.TencentMobileGaming.ITMGContext:GetInstance():GetAudioCtrl():SetSpeakerVolume(value * 100 * 2)
    end
end
--endregion

--region 对应功能
---设置Toogle
function UIConfigPanel_Base.SetTooleFunc(Go_Enum, value)
    --region 设置面板
    if Go_Enum == CS.EConfigOption.FixJoystick then
        --固定摇杆
        if value then
            CS.UIJoystickController.Singleton.FixJoystick = true
        end
    end
    if Go_Enum == CS.EConfigOption.DoubleJoysticks then
        --双摇杆
        if luaEventManager.HasCallback(LuaCEvent.DoubleJoysticksStatuChange) then
            luaEventManager.DoCallback(LuaCEvent.DoubleJoysticksStatuChange, value)
        end
        if value then
            CS.UIJoystickController.Singleton.FixJoystick = true
        end
    end
    if Go_Enum == CS.EConfigOption.FreedomJoyStick then
        --自由摇杆
        if value then
            CS.UIJoystickController.Singleton.FixJoystick = false
        end
    end
    if Go_Enum == CS.EConfigOption.FastItemUseExpand then
        --开启快捷栏
        uiStaticParameter.isShowNotice = value
    end
    if Go_Enum == CS.EConfigOption.ForbidFriend then
        --拒绝好友邀请
    end
    if Go_Enum == CS.EConfigOption.ClickBtnToSelectTarget then
        --按钮切换目标
    end
    if Go_Enum == CS.EConfigOption.SkillSchemeShortcut then
        --快捷切换技能方案
    end
    --endregion
end
--endregion

function UIConfigPanel_Base:CheckCanChange()
    return Utility.CheckChangePkMode({dropDown = self.attckModelDropDown,parent = self.moshi_ArrowBtn.transform})
end

return UIConfigPanel_Base