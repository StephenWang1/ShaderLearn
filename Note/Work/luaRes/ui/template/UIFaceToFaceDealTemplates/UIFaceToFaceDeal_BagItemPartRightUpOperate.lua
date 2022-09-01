---面对面交易背包道具左侧模板
---@class UIFaceToFaceDeal_BagItemPartRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIFaceToFaceDeal_BagItemPartRightUpOperate = {}
setmetatable(UIFaceToFaceDeal_BagItemPartRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

function UIFaceToFaceDeal_BagItemPartRightUpOperate:FaceToFaceDealPanel()
    if self.UIFaceToFaceDealPanel == nil then
        self.UIFaceToFaceDealPanel = uimanager:GetPanel("UIFaceToFaceDealPanel")
    end
    return self.UIFaceToFaceDealPanel
end

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIFaceToFaceDeal_BagItemPartRightUpOperate:RefreshWithInfo(commonData)
    self:GetBtns_UIGridContainer().MaxCount = 1
    local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
    self:SetButtonShow(buttonGO)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIFaceToFaceDeal_BagItemPartRightUpOperate:SetButtonShow(buttonGO)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = "放入"
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self.OnClicked
end

---放入
function UIFaceToFaceDeal_BagItemPartRightUpOperate:OnClicked(go)
    if self:FaceToFaceDealPanel() ~= nil and self:FaceToFaceDealPanel().IsReachTraderLimit then
        local name = "UIItemInfoPanel"
        if uimanager:GetPanel("UIItemInfoPanel") == nil then
            name = "UIPetInfoPanel"
        end
        Utility.ShowPopoTips(go.gameObject.transform, nil, 296, name)
        return
    end
    networkRequest.ReqAddItemToTrade(self.mBagItemInfo.lid, self.mBagItemInfo.count)
    self:OnQuitClicked()
end
---取消（关闭TIps）
function UIFaceToFaceDeal_BagItemPartRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

return UIFaceToFaceDeal_BagItemPartRightUpOperate