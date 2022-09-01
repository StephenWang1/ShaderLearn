---实名制认证界面
---@class UIAntiAddictionPanel:UIBase
local UIAntiAddictionPanel = {}

---姓名输入
---@return UIInput
function UIAntiAddictionPanel:GetInputNameUIInput()
    if self.mInputNameUIInput == nil then
        self.mInputNameUIInput = self:GetCurComp("Name_Title/InputName", "UIInput")
    end
    return self.mInputNameUIInput
end

---身份证号输入
---@return UIInput
function UIAntiAddictionPanel:GetInputIdentityNumberUIInput()
    if self.mInputIdentityNumberUIInput == nil then
        self.mInputIdentityNumberUIInput = self:GetCurComp("IDCard_title/IDCard", "UIInput")
    end
    return self.mInputIdentityNumberUIInput
end

---提交按钮
---@return UnityEngine.GameObject
function UIAntiAddictionPanel:GetConfirmSubmitButton()
    if self.mConfirmSubmitButton == nil then
        self.mConfirmSubmitButton = self:GetCurComp("btn_sendPush", "GameObject")
    end
    return self.mConfirmSubmitButton
end

function UIAntiAddictionPanel:Init()
    self:BindUIEvents()
    self:BindClientEvents()
end

function UIAntiAddictionPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetConfirmSubmitButton()).onClick = function()
        self:OnConfirmSubmitButtonClicked()
    end
end

function UIAntiAddictionPanel:BindClientEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_FCMAuthorityStateRefresh, function()
        self:OnFCMAuthorityStateChanged()
    end)
end

function UIAntiAddictionPanel:OnConfirmSubmitButtonClicked()
    local name = self:GetInputNameUIInput().value
    local id = self:GetInputIdentityNumberUIInput().value
    if name and id and name ~= "" and id ~= "" then
        ---15位身份证或18位身份证
        local idNumCount = #id
        if idNumCount == 18 then
            networkRequest.ReqAuthority(name, id)
            --uimanager:ClosePanel("UIAntiAddictionPanel")
        else
            CS.Utility.ShowTips("请输入18位的身份证信息", 1.5, CS.ColorType.Yellow)
        end
    else
        CS.Utility.ShowTips("请输入正确的信息", 1.5, CS.ColorType.Yellow)
    end
end

function UIAntiAddictionPanel:OnFCMAuthorityStateChanged()
    if CS.CSGame.Sington ~= nil and CS.CSGame.Sington.AntiAddiction ~= nil then
        if CS.CSGame.Sington.AntiAddiction.AuthorityState > 0 then
            uimanager:ClosePanel("UIAntiAddictionPanel")
        end
    else
        uimanager:ClosePanel("UIAntiAddictionPanel")
    end
end

function ondestroy()
    if CS.CSGame.Sington ~= nil and CS.CSGame.Sington.AntiAddiction ~= nil then
        CS.CSGame.Sington.AntiAddiction:ResetAntiAddictionPanel()
    end
end

return UIAntiAddictionPanel