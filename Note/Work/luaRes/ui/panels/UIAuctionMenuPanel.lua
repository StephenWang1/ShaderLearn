---@class UIAuctionMenuPanel:UIBase 交易行目录界面
local UIAuctionMenuPanel = {}

UIAuctionMenuPanel.mManagePanel = nil
UIAuctionMenuPanel.mTemplate = nil
UIAuctionMenuPanel.mCurrentTemplate = nil

--region 组件
function UIAuctionMenuPanel:GetTemplateRoot()
    if self.mTemplateRoot == nil then
        self.mTemplateRoot = self:GetCurComp("ToggleArea", "GameObject")
    end
    return self.mTemplateRoot
end
--endregion

--region 初始化
---@param customData AuctionMenuData
function UIAuctionMenuPanel:Show(customData)
    self.mTemplate = nil
    ---@type UIAuctionMenuPanelTemplateBase
    self.mCurrentTemplate = nil
    if customData then
        if customData.managePanel then
            self.mManagePanel = customData.managePanel
        end
        if customData.template then
            self.mTemplate = customData.template
        end
    end
    self:RefreshMenu()
    if customData.mSelectItemNameData and self:GetCurrentTemplate()  then
        self:GetCurrentTemplate():ClickFirstMenu()
    end
end
--endregion

function UIAuctionMenuPanel:RefreshMenu()
    if self.mTemplate and self:GetCurrentTemplate() == nil then
        self.mCurrentTemplate = templatemanager.GetNewTemplate(self:GetTemplateRoot(), self.mTemplate, self.mManagePanel)
    end
    if self:GetCurrentTemplate() then
        self:GetCurrentTemplate():ResetMenu()
    end
end

---@return UIAuctionMenuPanelTemplateBase
function UIAuctionMenuPanel:GetCurrentTemplate()
    return self.mCurrentTemplate
end

return UIAuctionMenuPanel