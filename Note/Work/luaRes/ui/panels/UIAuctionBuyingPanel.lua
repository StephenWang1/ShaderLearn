---@class UIAuctionBuyingPanel:UIBase 拍卖行求购界面Tips
local UIAuctionBuyingPanel = {}

--region 组件
---@return UnityEngine.GameObject 父节点用于刷新模板用
function UIAuctionBuyingPanel:GetRoot_GO()
    if self.mRootGo == nil then
        self.mRootGo = self:GetCurComp("WidgetRoot/view", "GameObject")
    end
    return self.mRootGo
end

---@return UnityEngine.GameObject 关闭按钮
function UIAuctionBuyingPanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end
--endregion

--region  初始化
function UIAuctionBuyingPanel:Init()
    self:BindEvent()
end

function UIAuctionBuyingPanel:Show(customData)
    ---@type UIAuctionBuyingTemplate 默认模板
    local template = luaComponentTemplates.UIAuctionBuyingTemplate
    if customData.Template then
        template = customData.Template
    end
    if customData then
        local RootTemplate = templatemanager.GetNewTemplate(self:GetRoot_GO(), template, customData, self)
    end
end

function UIAuctionBuyingPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

return UIAuctionBuyingPanel