---@class UIGuildSendRedPackPanel:UIBase
local UIGuildSendRedPackPanel = {}

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIGuildSendRedPackPanel:GetCloseBtn_Go()
    if self.mCloseBtnGo == nil then
        self.mCloseBtnGo = self:GetCurComp("WidgetRoot/view/close", "GameObject")
    end
    return self.mCloseBtnGo
end

---@return UnityEngine.GameObject 模板节点
function UIGuildSendRedPackPanel:ShowRoot_Go()
    if self.mShowRoot == nil then
        self.mShowRoot = self:GetCurComp("WidgetRoot/events", "GameObject")
    end
    return self.mShowRoot
end
--endregion

--region 初始化
function UIGuildSendRedPackPanel:Init()
    self:BindEvent()
end

function UIGuildSendRedPackPanel:Show(customData)
    if customData == nil then
        self:ClosePanel()
        return
    end
    ---@type UIGuildSendRedPanelTemplate
    local normalTemplate = luaComponentTemplates.UIGuildSendRedPanelTemplate
    if customData.Template then
        normalTemplate = customData.Template
    end
    self.mTemplate = templatemanager.GetNewTemplate(self:ShowRoot_Go(), normalTemplate, customData)
end

function UIGuildSendRedPackPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

return UIGuildSendRedPackPanel