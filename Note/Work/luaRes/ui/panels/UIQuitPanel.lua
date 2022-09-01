---@class UIQuitPanel:UIBase 退出面板
local UIQuitPanel = {}

--region组件

---@type UnityEngine.GameObject 取消按钮
function UIQuitPanel:GetCancelBtn_GameObject()
    if self.mCancelBtn == nil then
        self.mCancelBtn = self:GetCurComp("WidgetRoot/events/LeftBtn", "GameObject")
    end
    return self.mCancelBtn
end

---@type UnityEngine.GameObject 确认按钮
function UIQuitPanel:GetConfirmBtn_GameObject()
    if self.mConfirmBtn == nil then
        self.mConfirmBtn = self:GetCurComp("WidgetRoot/events/RightBtn", "GameObject")
    end
    return self.mConfirmBtn
end

--endregion

--region 初始化
function UIQuitPanel:Init()
    self:BindEvents()
end

function UIQuitPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCancelBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetConfirmBtn_GameObject()).onClick = function()
        --CS.UnityEngine.Application:Quit()
        CS.SDKManager.GameInterface:killProcess();
    end
end
--endregion

return UIQuitPanel