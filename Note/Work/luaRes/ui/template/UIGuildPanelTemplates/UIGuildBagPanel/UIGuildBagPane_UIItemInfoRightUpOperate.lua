---帮会仓库打开装备右上角显示模板
---@class UIGuildBagPane_UIItemInfoRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIGuildBagPane_UIItemInfoRightUpOperate = {}
setmetatable(UIGuildBagPane_UIItemInfoRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---按钮类型名称
UIGuildBagPane_UIItemInfoRightUpOperate.Button = {
    [LuaEnumStorageTipsType.Quit] = "取消",
    [LuaEnumStorageTipsType.Donate] = "捐献",
}

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIGuildBagPane_UIItemInfoRightUpOperate:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    if bagItemInfo and itemInfo then
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = 2
            local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
            local buttonGOQuit = self:GetBtns_UIGridContainer().controlList[1]
            self:SetButtonShow(buttonGO, LuaEnumStorageTipsType.Donate)
            self:SetButtonShow(buttonGOQuit, LuaEnumStorageTipsType.Quit)
            ---右上角按钮展开收起自适应
            self:AdaptButton()
        end
    end
end

---适应按钮显示
function UIGuildBagPane_UIItemInfoRightUpOperate:AdaptButton()
    self.btnListOpenAndClose = templatemanager.GetNewTemplate(self:GetBtns_UIGridContainer(), luaComponentTemplates.UIItemInfoPanel_Info_OpenCloseBtnList)
end

---设置按钮显示及事件
function UIGuildBagPane_UIItemInfoRightUpOperate:SetButtonShow(buttonGO, type)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    btnLabel.text = self.Button[type]
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self:GetButtonEvent(type)
end

---根据类型获取按钮事件
function UIGuildBagPane_UIItemInfoRightUpOperate:GetButtonEvent(type)
    if type == LuaEnumStorageTipsType.Quit then
        return self.OnQuitClicked
    elseif type == LuaEnumStorageTipsType.Donate then
        return self.OnDonateClicked
    end
end

---取消（关闭TIps）
function UIGuildBagPane_UIItemInfoRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

---捐献
function UIGuildBagPane_UIItemInfoRightUpOperate:OnDonateClicked(go)
    self:OnQuitClicked()
    if self.mBagItemInfo then
        networkRequest.ReqDonateEquip(self.mBagItemInfo.lid)
    end
end

return UIGuildBagPane_UIItemInfoRightUpOperate