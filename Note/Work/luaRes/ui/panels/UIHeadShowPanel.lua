---@class UIHeadShowPanel:UIBase
local UIHeadShowPanel = {}

---获取自己的组件
---@return UIPanel
function UIHeadShowPanel:GetSelfPanel()
    if self.mSelfPanel == nil then
        self.mSelfPanel = self:GetCurComp("", "UIPanel")
    end
    return self.mSelfPanel
end

function UIHeadShowPanel:Init()
    if CS.StaticUtility.IsNull(self:GetSelfPanel()) == false then
        ---头像界面需要低于所有主界面,故设置为-1
        self:GetSelfPanel().depth = -1
    end
end

return UIHeadShowPanel