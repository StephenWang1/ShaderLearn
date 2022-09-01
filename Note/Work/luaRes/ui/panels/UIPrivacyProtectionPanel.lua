---@class UIPrivacyProtectionPanel:UIBase 隐私保护界面
local UIPrivacyProtectionPanel = {}

function UIPrivacyProtectionPanel:Init()
    self.btn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    self.btn_know = self:GetCurComp("WidgetRoot/events/btn_know", "GameObject")
    self.content = self:GetCurComp("WidgetRoot/view/scrollview/content", "Top_UILabel")
    self:BindUIEvents()
end

function UIPrivacyProtectionPanel:Show()
    local filePath = ''
    local fileName = 'PrivacyProtection.txt'

    if (isUnityEditor) then
        filePath = CS.CSEditorPath.Get(CS.EEditorPath.LocalResourcesLoadPath)
    else
        filePath = CS.CSStaticAssist.persistentDataPath
    end
    filePath = filePath .. "/" .. CS.CSResource.GetModelTypePath(CS.ResourceType.Picture) .. fileName;

    local text = self:ReadFile(filePath)
    if (not CS.System.String.IsNullOrEmpty(text)) then
        self.content.text = text
    end
end

function UIPrivacyProtectionPanel:ReadFile(fileName)
    local f = io.open(fileName, 'r')
    if (f == nil) then
        CS.UnityEngine.Debug.Log("文件路径不存在:" .. tostring(fileName))
        return ""
    else
        local content = f:read('*all')
        f:close()
        return content
    end

end

function UIPrivacyProtectionPanel:BindUIEvents()
    CS.UIEventListener.Get(self.btn_close).onClick = self.CloseBtnOnClick
    CS.UIEventListener.Get(self.btn_know).onClick = self.CloseBtnOnClick
end

function UIPrivacyProtectionPanel:CloseBtnOnClick()
    uimanager:ClosePanel("UIPrivacyProtectionPanel")
end

return UIPrivacyProtectionPanel