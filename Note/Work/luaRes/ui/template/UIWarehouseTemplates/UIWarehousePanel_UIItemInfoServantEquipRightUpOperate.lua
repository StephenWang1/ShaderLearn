---仓库打开灵兽装备右上角显示模板（其他仓库道具Tips右上角按钮模板均继承此模板）
---@class UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIWarehousePanel_UIItemInfoServantEquipRightUpOperate = {}

setmetatable(UIWarehousePanel_UIItemInfoServantEquipRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---按钮类型名称
UIWarehousePanel_UIItemInfoServantEquipRightUpOperate.Button = {
    --[LuaEnumStorageTipsType.Quit] = "取消",
    [LuaEnumStorageTipsType.Deposit] = "存入",
    [LuaEnumStorageTipsType.TakeOut] = "取出",
}

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:RefreshWithInfo(commonData)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    if self.mBagItemInfo and self.mItemInfo then
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = 1
            local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
            --local buttonGOQuit = self:GetBtns_UIGridContainer().controlList[1]
            self:SetButtonShow(buttonGO, LuaEnumStorageTipsType.Deposit)
            --self:SetButtonShow(buttonGOQuit, LuaEnumStorageTipsType.Quit)
            ---右上角按钮展开收起自适应
            --self:AdaptButton()
            self:GetShowClose_GameObject():SetActive(false)
            self:BGSelfAdaptaion()
        end
    end
end

---适应按钮显示
function UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:AdaptButton()
    self.btnListOpenAndClose = templatemanager.GetNewTemplate(self:GetBtns_UIGridContainer(), luaComponentTemplates.UIItemInfoPanel_Info_OpenCloseBtnList)
end

---设置按钮显示及事件
function UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:SetButtonShow(buttonGO, type)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"),"UILabel")
    btnLabel.text = self.Button[type]
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self:GetButtonEvent(type)
end

---根据类型获取按钮事件
function UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:GetButtonEvent(type)
    if type == LuaEnumStorageTipsType.Quit then
        return self.OnQuitClicked
    elseif type == LuaEnumStorageTipsType.TakeOut then
        return self.OnTakeOutClicked
    elseif type == LuaEnumStorageTipsType.Deposit then
        return self.OnDepositClicked
    end
end

---取消（关闭TIps）
function UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

---取出
function UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:OnTakeOutClicked()
    self:OnQuitClicked()
    networkRequest.ReqStorageOutItem(self.mBagItemInfo.lid)
end

---存入
function UIWarehousePanel_UIItemInfoServantEquipRightUpOperate:OnDepositClicked()
    self:OnQuitClicked()
    networkRequest.ReqStorageInItem(self.mBagItemInfo.lid)
end

return UIWarehousePanel_UIItemInfoServantEquipRightUpOperate