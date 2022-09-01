---请求退出当前地图界面
---@class UIPromptReqExitCurrentMapPanel:UIBase
local UIPromptReqExitCurrentMapPanel = {}

---内容文本
---@return UILabel
function UIPromptReqExitCurrentMapPanel:GetContentLabel()
    if self.mContentLabel == nil then
        self.mContentLabel = self:GetCurComp("view/Content", "UILabel")
    end
    return self.mContentLabel
end

---遮挡层box
---@return UnityEngine.GameObject
function UIPromptReqExitCurrentMapPanel:GetBlockBox()
    if self.mBlockBox == nil then
        self.mBlockBox = self:GetCurComp("box", "GameObject")
    end
    return self.mBlockBox
end

---关闭按钮
---@return UnityEngine.GameObject
function UIPromptReqExitCurrentMapPanel:GetCloseButton()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("events/close", "GameObject")
    end
    return self.mCloseBtn
end

---确认按钮
---@return UnityEngine.GameObject
function UIPromptReqExitCurrentMapPanel:GetConfirmButton()
    if self.mConfirmBtn == nil then
        self.mConfirmBtn = self:GetCurComp("events/ConfirmBtn", "GameObject")
    end
    return self.mConfirmBtn
end

function UIPromptReqExitCurrentMapPanel:Init()
    CS.UIEventListener.Get(self:GetBlockBox()).onClick = function()
        self:OnCloseButtonClicked()
    end
    CS.UIEventListener.Get(self:GetConfirmButton()).onClick = function()
        self:OnConfirmButtonClicked()
    end
    CS.UIEventListener.Get(self:GetCloseButton()).onClick = function()
        self:OnCloseButtonClicked()
    end
end

---type为1表示前往NPC失败,请求小飞鞋传送,传送完毕后打开界面
---@param param {content:string, confirmCallback:function,closeCallback:function}
function UIPromptReqExitCurrentMapPanel:Show(param)
    if param ~= nil then
        ---@type string
        self.mContent = param.content
        ---@type function
        self.mConfirmCallback = param.confirmCallback
        ---@type function
        self.mCloseCallback = param.closeCallback
    else
        self.mContent = ""
        self.mConfirmCallback = nil
        self.mCloseCallback = nil
    end
    if self.mContent then
        self:GetContentLabel().text = self.mContent
    end
end

---确认按钮点击事件
function UIPromptReqExitCurrentMapPanel:OnConfirmButtonClicked()
    uimanager:ClosePanel(self, false)
    if self.mConfirmCallback ~= nil then
        self.mConfirmCallback()
        self.mConfirmCallback = nil
    end
end

---关闭按钮点击事件
function UIPromptReqExitCurrentMapPanel:OnCloseButtonClicked()
    uimanager:ClosePanel(self, false)
    if self.mCloseCallback ~= nil then
        self.mCloseCallback()
        self.mCloseCallback = nil
    end
end

function ondestroy()
    UIPromptReqExitCurrentMapPanel.mConfirmCallback = nil
    UIPromptReqExitCurrentMapPanel.mCloseCallback = nil
end

return UIPromptReqExitCurrentMapPanel