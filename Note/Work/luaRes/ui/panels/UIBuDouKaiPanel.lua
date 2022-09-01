local UIBuDouKaiPanel = {}
--region 初始化
function UIBuDouKaiPanel:Init()
    self:InitComponent()
    self:InitEvents()
    self:InitParams()
    self:InitCountDownEffect()
end

function UIBuDouKaiPanel:InitComponent()
    self.hideBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_hide","GameObject")
    self.panelTween_TweenPosition = self:GetCurComp("WidgetRoot/Tween","TweenPosition")
    self.arrow_TweenRotation = self:GetCurComp("WidgetRoot/Tween/btn_hide","TweenRotation")
    self.helpBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_help","GameObject")
    self.countDownEffect_CSUIEffectLoad = self:GetCurComp("WidgetRoot/GameBeginEffect/CountDownEffect","CSUIEffectLoad")
end

function UIBuDouKaiPanel:InitEvents()
    CS.UIEventListener.Get(self.hideBtn_GameObject).onClick = function() self:HideBtnOnClick() end
    CS.UIEventListener.Get(self.helpBtn_GameObject).onClick = function() self:HelpBtnOnClick() end
end

function UIBuDouKaiPanel:InitParams()
    self.IsOpen = true
    CS.CSScene.MainPlayerInfo.BudowillInfo.InBuDouKaiActivity = true
end

---初始化倒计时特效
function UIBuDouKaiPanel:InitCountDownEffect()
    if self.countDownEffect_CSUIEffectLoad ~= nil then
        self.countDownEffect_CSUIEffectLoad.onLoadFinish = function()
            CS.CSScene.MainPlayerInfo.BudowillInfo:InitBuDouKaiCountDown(self.countDownEffect_CSUIEffectLoad.EffectObject)
        end
    end
    self.countDownEffect_CSUIEffectLoad.gameObject:SetActive(true)
end
--endregion

--region 刷新
function UIBuDouKaiPanel:Show()
    self.BuDouKaiStage = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage)
    if self.panelTemplate ~= nil and self.panelTemplate.CloseUpdate ~= nil then
        self.panelTemplate:CloseUpdate()
    end
    self.panelTemplate = templatemanager.GetNewTemplate(self.go,self:GetTemplateByBuDouKaiStage())
    if self.panelTemplate ~= nil then
        self.panelTemplate:RefreshPanel()
    end
end

function UIBuDouKaiPanel:RefreshData()
    if self.panelTemplate ~= nil then
        self.panelTemplate:RefreshPanel()
    end
end
--endregion

--region UI事件
function UIBuDouKaiPanel:HideBtnOnClick()
    if self.panelTween_TweenPosition == nil then
        return
    end
    if self.IsOpen then
        self.panelTween_TweenPosition:PlayForward()
        self.arrow_TweenRotation:PlayReverse()
    else
        self.panelTween_TweenPosition:PlayReverse()
        self.arrow_TweenRotation:PlayForward()
    end
    self.IsOpen = not self.IsOpen
end

function UIBuDouKaiPanel:HelpBtnOnClick()
    local info
    local isFind = nil
    isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(118)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end
--endregion

--region 获取
function UIBuDouKaiPanel:GetTemplateByBuDouKaiStage()
    if self.BuDouKaiStage == nil then
        return
    end
    if self.BuDouKaiStage == luaEnumBuDouKaiStage.WAIT then
        return luaComponentTemplates.UIBuDouKaiPanel_Wait
    elseif self.BuDouKaiStage == luaEnumBuDouKaiStage.TRIIALS then
        return luaComponentTemplates.UIBuDouKaiPanel_Trials
    elseif self.BuDouKaiStage == luaEnumBuDouKaiStage.FRISTREST or self.BuDouKaiStage == luaEnumBuDouKaiStage.FRISTRESTOVER then
        return luaComponentTemplates.UIBuDouKaiPanel_FristRest
    elseif self.BuDouKaiStage == luaEnumBuDouKaiStage.PROMOTION then
        return luaComponentTemplates.UIBuDouKaiPanel_Promotion
    elseif self.BuDouKaiStage == luaEnumBuDouKaiStage.SCEONDREST or self.BuDouKaiStage == luaEnumBuDouKaiStage.SCEONDRESTOVER  then
        return luaComponentTemplates.UIBuDouKaiPanel_SecondRest
    elseif self.BuDouKaiStage == luaEnumBuDouKaiStage.FINAL then
        return luaComponentTemplates.UIBuDouKaiPanel_ContentheGemony
    elseif self.BuDouKaiStage == luaEnumBuDouKaiStage.FINALOVERR then
        return luaComponentTemplates.UIBuDouKaiPanel_FinalOver
    end
end
--endregion

--region 查询
function UIBuDouKaiPanel:BuDouKaiIsOpen()
end
--endregion

function ondestroy()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BudowillInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BudowillInfo.InBuDouKaiActivity = false
    end
end
return UIBuDouKaiPanel