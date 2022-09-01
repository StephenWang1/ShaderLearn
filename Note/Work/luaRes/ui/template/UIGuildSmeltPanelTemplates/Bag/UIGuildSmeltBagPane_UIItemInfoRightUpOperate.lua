local UIGuildSmeltBagPane_UIItemInfoRightUpOperate = {}

setmetatable(UIGuildSmeltBagPane_UIItemInfoRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---按钮类型名称
UIGuildSmeltBagPane_UIItemInfoRightUpOperate.Button = {
    [LuaEnumItemOperateType.Semelt] = "熔炼",
}

---展开关闭按钮
function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:GetOnFold_GameObject()
    if self.mOnFold_GameObject == nil then
        self.mOnFold_GameObject = self:Get("btns/showclose/Label", "GameObject")
    end
    return self.mOnFold_GameObject
end

function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:GetBackGround_GameObject()
    if self.mBackGround_GameObject == nil then
        self.mBackGround_GameObject = self:Get("btns/showclose/backGround", "GameObject")
    end
    return self.mBackGround_GameObject
end

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:RefreshWithInfo(commonData)
--[[    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    if bagItemInfo and itemInfo then
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = 1
            local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
            self:SetButtonShow(buttonGO, LuaEnumItemOperateType.Semelt)
            ---右上角按钮展开收起自适应
            self:BGSelfAdaptaion()
            self:GetOnFold_GameObject():SetActive(false)
            self:GetBackGround_GameObject():SetActive(false)
        end
    end]]
end

---适应按钮显示
function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:AdaptButton()
    self.btnListOpenAndClose = templatemanager.GetNewTemplate(self:GetBtns_UIGridContainer(), luaComponentTemplates.UIItemInfoPanel_Info_OpenCloseBtnList)
end

---设置按钮显示及事件
function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:SetButtonShow(buttonGO, type)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    btnLabel.text = self.Button[type]
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self:GetButtonEvent(type)
end

---根据类型获取按钮事件
function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:GetButtonEvent(type)
    if type == LuaEnumStorageTipsType.Quit then
        return self.OnQuitClicked
    elseif type == LuaEnumItemOperateType.Semelt then
        return self.OnSemeltClicked
    end
end

---取消（关闭TIps）
function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

---捐献
function UIGuildSmeltBagPane_UIItemInfoRightUpOperate:OnSemeltClicked(go)
    if self.mBagItemInfo then
        self:OnButtonClicked_Semelt(go)
        uimanager:ClosePanel("UIGuildPanel")
        --local uiGuildPanel = uimanager:GetPanel("UIGuildPanel")
        --
        --if uiGuildPanel ~= nil and CS.StaticUtility.IsNull(uiGuildPanel.go) == false then
        --    uiGuildPanel.go:SetActive(false)
        --end
    end
end

return UIGuildSmeltBagPane_UIItemInfoRightUpOperate