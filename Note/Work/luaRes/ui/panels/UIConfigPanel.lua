-- 设置面板
-- Author: Zhoujiachuag
-- Date: XXXX-XX-XX
-- 进行基础功能的设置
---@class UIConfigPanel:UIBase
local UIConfigPanel = {}

--region 自定义变量
--- @type boolean
UIConfigPanel.mInitBasePanel = false
UIConfigPanel.mInitPickupPanel = false
UIConfigPanel.mInitShowPanel = false
UIConfigPanel.mInitProtectPanel = false
--- @type CSConfigInfo
UIConfigPanel.PlayerConfigInfo = nil

UIConfigPanel.BranchPanel = {}
--endregion

--region parameters
UIConfigPanel.AutoShieldLevel = {}

UIConfigPanel.AutoPickLevelTable = {}

UIConfigPanel.AutoItemUseTable = {}
UIConfigPanel.AutoItemUseList = {}

UIConfigPanel.Config = nil

UIConfigPanel.mCustomData = {};
--endregion

--region 组件
---@return UnityEngine.GameObject
function UIConfigPanel:GetProtectPanel_GO()
    if self.mProtectPanelGo == nil then
        self.mProtectPanelGo = self:GetCurComp("WidgetRoot/ProtectPanel", "GameObject")
    end
    return self.mProtectPanelGo
end
--endregion

--region 初始化
---切换面板
---@param customData.type LuaEnumConfigPanelOpenType
---@param customData.SkillKeyPosParams  {type:技能键位面版打开类型}
function UIConfigPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end
    if (customData.type == nil) then
        customData.type = LuaEnumConfigPanelOpenType.BasePanel;
    end
    local selectId = customData.type;

    UIConfigPanel.mCustomData = customData;
    if (selectId == LuaEnumConfigPanelOpenType.BasePanel) then
        --UIConfigPanel.Toggle_SwitchBasePanel.isChecked = true;
        UIConfigPanel.OnChangeToggle_SwitchBasePanel();
    elseif (selectId == LuaEnumConfigPanelOpenType.FeedbackPanel) then
        --UIConfigPanel.Toggle_SwitchPickPanel.isChecked = true;
        UIConfigPanel.OnChangeToggle_SwitchFeedbackPanel();
    elseif (selectId == LuaEnumConfigPanelOpenType.PickupPanel) then
        --UIConfigPanel.Toggle_SwitchPickPanel.isChecked = true;
        UIConfigPanel.OnChangeToggle_SwitchPickPanel();
    elseif (selectId == LuaEnumConfigPanelOpenType.ShowPanel) then
        --UIConfigPanel.Toggle_SwitchShowPanel.isChecked = true;
        UIConfigPanel.OnChangeToggle_SwitchShowPanel();
    elseif (selectId == LuaEnumConfigPanelOpenType.SkillConfigPanel) then
        UIConfigPanel.OnChangeToggle_SwitchSkillConfigPanel();
    elseif selectId == LuaEnumConfigPanelOpenType.ProtectPanel then
        UIConfigPanel.RefreshUI(Utility.EnumToInt(CS.EConfigPanelType.ProtectPanel))
    end

    if (CS.CSMapAreaDialogTips.Instance ~= nil and CS.CSMapAreaDialogTips.Instance.PanelType == CS.RedPointType.MainSetting) then
        CS.CSMapAreaDialogTips.Instance.CloseAndRemove(CS.RedPointType.MainSetting)
    end
end

---配置面板初始化
function UIConfigPanel:Init()
    if CS.CSScene.Sington == nil or CS.CSScene.Sington.MainPlayer == nil then
        return
    else
        UIConfigPanel.PlayerConfigInfo = CS.CSScene.MainPlayerInfo.ConfigInfo
    end
    ---获取Config
    UIConfigPanel.Config = CS.CSScene.MainPlayerInfo.ConfigInfo
    ---初始化面板
    UIConfigPanel:InitCommonComponent()
    ---绑定事件
    self:BindEvents()
end

function UIConfigPanel:InitCommonComponent()
    ---基础面板
    --- @type UnityEngine.GameObject
    UIConfigPanel.BasePanel = UIConfigPanel:GetCurComp("WidgetRoot/basePanel", "GameObject")
    --- 显示面板
    --- @type UnityEngine.GameObject
    UIConfigPanel.ShowPanel = UIConfigPanel:GetCurComp("WidgetRoot/showPanel", "GameObject")
    --- 反馈面板
    --- @type UnityEngine.GameObject
    UIConfigPanel.FeedBackPanel = UIConfigPanel:GetCurComp("WidgetRoot/FeedbackPanel", "GameObject")
    --- 拾取面板
    --- @type UnityEngine.GameObject
    UIConfigPanel.PickupPanel = UIConfigPanel:GetCurComp("WidgetRoot/pickupPanel", "GameObject")
    --- 技能设置面板
    --- @type UnityEngine.GameObject
    UIConfigPanel.SkillConfigPanel = UIConfigPanel:GetCurComp("WidgetRoot/SkillConfigPanel", "GameObject")

    ----- 切换到基础面板按钮
    ----- @type UIToggle
    --UIConfigPanel.Toggle_SwitchBasePanel = UIConfigPanel:GetCurComp("WidgetRoot/events/bg/btn_jichu", "UIToggle")
    ----- 切换到显示面板按钮
    ----- @type UIToggle
    --UIConfigPanel.Toggle_SwitchShowPanel = UIConfigPanel:GetCurComp("WidgetRoot/events/bg/btn_xianshi", "UIToggle")
    ----- 切换到拾取面板按钮
    ----- @type UIToggle
    --UIConfigPanel.Toggle_SwitchPickPanel = UIConfigPanel:GetCurComp("WidgetRoot/events/bg/btn_shiqu", "UIToggle")
    --- 关闭配置文件面板按钮
    --- @type UnityEngine.GameObject
    UIConfigPanel.BtnClose = UIConfigPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")

    CS.UIEventListener.Get(UIConfigPanel.BtnClose).onClick = UIConfigPanel.OnClickBtnClose

    --UIConfigPanel.mFastItemSettingViewTemplate = templatemanager.GetNewTemplate(UIConfigPanel:GetCurComp("WidgetRoot/showPanel/item", "GameObject"), luaComponentTemplates.UIFastItemSettingViewTemplate);

    self.BranchPanel[LuaEnumConfigPanelOpenType.BasePanel] = templatemanager.GetNewTemplate(self.BasePanel, luaComponentTemplates.UIConfigPanel_Base, self)
    self.BranchPanel[LuaEnumConfigPanelOpenType.FeedbackPanel] = templatemanager.GetNewTemplate(self.FeedBackPanel, luaComponentTemplates.UIConfigPanel_Feedback, self)
    ---@type UIConfigPanel_Pickup
    self.BranchPanel[LuaEnumConfigPanelOpenType.PickupPanel] = templatemanager.GetNewTemplate(self.PickupPanel, luaComponentTemplates.UIConfigPanel_Pickup, self)
    self.BranchPanel[LuaEnumConfigPanelOpenType.ShowPanel] = templatemanager.GetNewTemplate(self.ShowPanel, luaComponentTemplates.UIConfigPanel_Show, self)
    self.BranchPanel[LuaEnumConfigPanelOpenType.SkillConfigPanel] = templatemanager.GetNewTemplate(self.SkillConfigPanel, luaComponentTemplates.UISkillConfigPanel, self)
    ---@type UIConfigPanel_ProtectPanel
    self.BranchPanel[LuaEnumConfigPanelOpenType.ProtectPanel] = templatemanager.GetNewTemplate(self:GetProtectPanel_GO(), luaComponentTemplates.UIConfigPanel_ProtectPanel, self)
end

function UIConfigPanel:BindEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.AutoDownAdapt, function(uiEvtID, data)
        if self.BranchPanel ~= nil and self.BranchPanel[LuaEnumConfigPanelOpenType.ShowPanel] ~= nil then
            local showPanelTemplate = self.BranchPanel[LuaEnumConfigPanelOpenType.ShowPanel]:RefreshModel()
        end
    end)
end
--endregion

--region 通用按钮和切换界面按钮的事件
---切换到基础面板
function UIConfigPanel.OnChangeToggle_SwitchBasePanel()
    UIConfigPanel.RefreshUI(Utility.EnumToInt(CS.EConfigPanelType.BasePanel))
end
---切换到反馈面板
function UIConfigPanel.OnChangeToggle_SwitchFeedbackPanel()
    UIConfigPanel.RefreshUI(Utility.EnumToInt(CS.EConfigPanelType.FeedbackPanel))
end
---切换到显示面板
function UIConfigPanel.OnChangeToggle_SwitchShowPanel()
    UIConfigPanel.RefreshUI(Utility.EnumToInt(CS.EConfigPanelType.ShowPanel))
end
--- 切换到拾取面板
function UIConfigPanel.OnChangeToggle_SwitchPickPanel()
    UIConfigPanel.RefreshUI(Utility.EnumToInt(CS.EConfigPanelType.PickupPanel))
end
--- 切换到技能设置面板
function UIConfigPanel.OnChangeToggle_SwitchSkillConfigPanel()
    UIConfigPanel.RefreshUI(Utility.EnumToInt(CS.EConfigPanelType.SkillConfigPanel))
end
--- 关闭配置面板
function UIConfigPanel.OnClickBtnClose(go)
    uimanager:ClosePanel("UIConfigPanel")
end
---默认恢复
function UIConfigPanel.OnClickBtnRestoreDefault()
    UIConfigPanel.NowPanelRestoreDefault()
end
--- 返回登录界面
function UIConfigPanel.OnClickBtnReturnLogin()
    --if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
    clientMessageDeal.OnReturnLogin(false)
    --else
    --    CS.SDKManager.GameInterface:LogoutAccount()
    --end
    UIConfigPanel:LogOutGame()
end
--- 返回选角界面
function UIConfigPanel.OnClickBtnReturnRole()
    networkRequest.ReqCommon(3)
    clientMessageDeal.OnReturnLogin(true)
    UIConfigPanel:LogOutGame()
end
--- 重置全部面板为默认
function UIConfigPanel.RestoreDefault()
    UIConfigPanel.PlayerConfigInfo:RestoreDefault()--恢复默认设置
    UIConfigPanel.mInitShowPanel = false
    UIConfigPanel.mInitPickupPanel = false
    UIConfigPanel.mInitBasePanel = false
    local temp = UIConfigPanel.mCurPanelType
    UIConfigPanel.mCurPanelType = CS.ConfigPanel.None
    UIConfigPanel.IEnumRefreshPanel(temp)
end
--- 重置当前面板为默认
function UIConfigPanel.NowPanelRestoreDefault()
    local temp = UIConfigPanel.mCurPanelType
    UIConfigPanel.PlayerConfigInfo:NowPageRestoreDefault(temp)  --当前页面恢复默认设置
    UIConfigPanel.CheckNowPanel(temp)
    UIConfigPanel.mCurPanelType = CS.ConfigPanel.None
    UIConfigPanel.IEnumRefreshPanel(temp)
end
---避免多次触发保存数据
function UIConfigPanel.CheckNowPanel(panel)
    if panel == Utility.EnumToInt(CS.EConfigPanelType.BasePanel) then
        UIConfigPanel.mInitBasePanel = false
    elseif panel == Utility.EnumToInt(CS.EConfigPanelType.PickupPanel) then
        UIConfigPanel.mInitPickupPanel = false
    elseif panel == Utility.EnumToInt(CS.EConfigPanelType.ShowPanel) then
        UIConfigPanel.mInitShowPanel = false
    elseif panel == Utility.EnumToInt(CS.EConfigPanelType.ShowPanel) then
        UIConfigPanel.mInitProtectPanel = false
    else
        if (CS.CSDebug.developerConsoleVisible) then
            CS.CSDebug.LogError("没有配置当前面板")
        end
    end
end
---返回选角界面
function UIConfigPanel.ReturnRoleBtn()
    uimanager:CloseAllPanel()
    ---存储玩家设置
    clientMessageDeal.OnReturnLogin(true);
end
--endregion

--region 刷新面板
---更新UI面板
function UIConfigPanel.RefreshUI(panelType)
    UIConfigPanel.BasePanel:SetActive(panelType == Utility.EnumToInt(CS.EConfigPanelType.BasePanel))
    UIConfigPanel.FeedBackPanel:SetActive(panelType == Utility.EnumToInt(CS.EConfigPanelType.FeedbackPanel))
    UIConfigPanel.PickupPanel:SetActive(panelType == Utility.EnumToInt(CS.EConfigPanelType.PickupPanel))
    UIConfigPanel.ShowPanel:SetActive(panelType == Utility.EnumToInt(CS.EConfigPanelType.ShowPanel))
    UIConfigPanel.SkillConfigPanel:SetActive(panelType == Utility.EnumToInt(CS.EConfigPanelType.SkillConfigPanel))
    UIConfigPanel:GetProtectPanel_GO():SetActive(panelType == Utility.EnumToInt(CS.EConfigPanelType.ProtectPanel))
    --UIConfigPanel.SetDownBtnActive(panelType ~= Utility.EnumToInt(CS.EConfigPanelType.SkillConfigPanel))
    --UIConfigPanel.coroutine = StartCoroutine(UIConfigPanel.IEnumRefreshPanel, panelType)


    UIConfigPanel.IEnumRefreshPanel(panelType)
    uimanager:PlayCloseUIAudio(UIConfigPanel)
end
function UIConfigPanel.SetDownBtnActive(isOpen)
    --UIConfigPanel.BtnRestoreDefault:SetActive(isOpen)
    --UIConfigPanel.BtnReturnLogin:SetActive(isOpen)
    --UIConfigPanel.BtnReturnRole:SetActive(isOpen)
end
---刷新面板协程
function UIConfigPanel.IEnumRefreshPanel(panelType_int)
    UIConfigPanel.mCurPanelType = panelType_int
    if (panelType_int == Utility.EnumToInt(CS.EConfigPanelType.PickupPanel)) then
        if (UIConfigPanel.mInitPickupPanel) then
            return
        end
        if UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.PickupPanel] ~= nil then
            UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.PickupPanel]:RefreshPanel()
            UIConfigPanel.mInitPickupPanel = true
        end
    elseif (panelType_int == Utility.EnumToInt(CS.EConfigPanelType.BasePanel)) then
        if (UIConfigPanel.mInitBasePanel) then
            return
        end
        if UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.BasePanel] ~= nil then
            UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.BasePanel]:RefreshPanel()
            UIConfigPanel.mInitBasePanel = true
        end
    elseif (panelType_int == Utility.EnumToInt(CS.EConfigPanelType.ShowPanel)) then
        if (UIConfigPanel.mInitShowPanel) then
            return
        end
        if UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.ShowPanel] ~= nil then
            UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.ShowPanel]:RefreshPanel()
            UIConfigPanel.mInitShowPanel = true
        end
    elseif (panelType_int == Utility.EnumToInt(CS.EConfigPanelType.SkillConfigPanel)) then
        if (UIConfigPanel.mInitModePanel) then
            return
        end
        if UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.SkillConfigPanel] ~= nil then
            if (UIConfigPanel.mCustomData.SkillKeyPosParams == nil) then
                UIConfigPanel.mCustomData.SkillKeyPosParams = {};
            end
            if (UIConfigPanel.mCustomData.SkillKeyPosParams.type == nil) then
                UIConfigPanel.mCustomData.SkillKeyPosParams.type = LuaEnumSkillConfigPanelOpenType.Skill;
            end
            local type = UIConfigPanel.mCustomData.SkillKeyPosParams.type;
            UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.SkillConfigPanel]:Refresh(type);
            UIConfigPanel.mInitModePanel = true
        end
    elseif (panelType_int == Utility.EnumToInt(CS.EConfigPanelType.ProtectPanel)) then
        if (UIConfigPanel.mInitProtectPanel) then
            return
        end
        ---@type UIConfigPanel_ProtectPanel
        local template = UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.ProtectPanel]
        if template ~= nil then
            template:RefreshPanel()
            UIConfigPanel.mInitProtectPanel = true
        end
    end

    if (panelType_int ~= Utility.EnumToInt(CS.EConfigPanelType.SkillConfigPanel)) then
        --UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.SkillConfigPanel]:Destroy()
    end
end
---由于在UIToggle.current属性为null的情况下,onChange事件才能执行。也就是同时只能执行一个uitoggle的事件
function UIConfigPanel.IEnumSetAllPickupOptions()
end
--endregion

function UIConfigPanel:LogOutGame()
    uimanager:CloseAllPanel()
    if uiStaticParameter.voiceMgr ~= nil then
        uiStaticParameter.voiceMgr:LogOutGame()
    end
    uiStaticParameter.InCarAcitivity = false
    uiStaticParameter.firstEnterScene = true
end

function ondestroy()
    ---@type UIConfigPanel_Pickup
    local template = UIConfigPanel.BranchPanel[LuaEnumConfigPanelOpenType.PickupPanel]
    if template ~= nil then
        template:DestroyPanel()
    end
    uimanager:ClosePanel("UIBagPanel")
end

return UIConfigPanel