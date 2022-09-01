---血继面板道具左侧显示模板
---@class UIRoleBloodSuit_PanelRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIRoleBloodSuit_PanelRightUpOperate = {}
setmetatable(UIRoleBloodSuit_PanelRightUpOperate,luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)


---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIRoleBloodSuit_PanelRightUpOperate:RefreshWithInfo(commonData)
    self:GetBtns_UIGridContainer().MaxCount = 2
    local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
    local buttonGO2 = self:GetBtns_UIGridContainer().controlList[1]
    self:SetButtonShow(buttonGO,"血炼",self.OnClickRONGLIAN)
    self:SetButtonShow(buttonGO2,"取出",self.OnClicked)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIRoleBloodSuit_PanelRightUpOperate:SetButtonShow(buttonGO,des,OnClick)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"),"UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text =des
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = OnClick
end

---取出
function UIRoleBloodSuit_PanelRightUpOperate:OnClicked(go)
    networkRequest.ReqPutOffTheEquip(gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():GetNowSelectEquipIndex())
    self:OnQuitClicked()
end

---熔炼
function UIRoleBloodSuit_PanelRightUpOperate:OnClickRONGLIAN(go)
    uimanager:ClosePanel("UIRoleBloodSuitPanel")
    uiTransferManager:TransferToPanel(LuaEnumTransferType.BloodSuitSmelt_BloodSuit)
    self:OnQuitClicked()
end

---取消（关闭TIps）
function UIRoleBloodSuit_PanelRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

return UIRoleBloodSuit_PanelRightUpOperate