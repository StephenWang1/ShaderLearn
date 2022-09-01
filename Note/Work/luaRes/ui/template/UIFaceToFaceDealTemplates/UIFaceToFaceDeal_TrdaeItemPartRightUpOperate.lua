---面对面交易交易道具左侧模板
---@class UIFaceToFaceDeal_TrdaeItemPartRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIFaceToFaceDeal_TrdaeItemPartRightUpOperate = {}
setmetatable(UIFaceToFaceDeal_TrdaeItemPartRightUpOperate,luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)


---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIFaceToFaceDeal_TrdaeItemPartRightUpOperate:RefreshWithInfo(commonData)
    self:GetBtns_UIGridContainer().MaxCount = 1
    local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
    self:SetButtonShow(buttonGO)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIFaceToFaceDeal_TrdaeItemPartRightUpOperate:SetButtonShow(buttonGO)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"),"UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text ="取出"
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self.OnClicked
end

---放入
function UIFaceToFaceDeal_TrdaeItemPartRightUpOperate:OnClicked(go)
    networkRequest.ReqRemoveItemFromTrade(self.mBagItemInfo.lid)
    self:OnQuitClicked()
end
---取消（关闭TIps）
function UIFaceToFaceDeal_TrdaeItemPartRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

return UIFaceToFaceDeal_TrdaeItemPartRightUpOperate