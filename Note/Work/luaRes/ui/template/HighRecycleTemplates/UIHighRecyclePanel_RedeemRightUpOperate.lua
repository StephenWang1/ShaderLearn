---高级回收赎回右上角操作按钮
---@class UIHighRecyclePanel_RedeemRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIHighRecyclePanel_RedeemRightUpOperate = {}

setmetatable(UIHighRecyclePanel_RedeemRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---@param commonData UIItemTipInfoCommonData
function UIHighRecyclePanel_RedeemRightUpOperate:RefreshWithInfo(commonData)
    self.mItemInfo = commonData.itemInfo
    if self.mItemInfo then
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = 1
            local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
            local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
            btnLabel.text = "赎回"
            CS.UIEventListener.Get(buttonGO).onClick = function()
                ---@type UIHighRecyclePanel
                local uihighRecyclePanel = uimanager:GetPanel("UIHighRecyclePanel")
                if commonData.commonData ~= nil and commonData.commonData.mRedeemItem ~= nil
                        and uihighRecyclePanel:RequestRedeemItem(commonData.commonData.mRedeemItem.id, buttonGO) then
                    uimanager:ClosePanel("UIItemInfoPanel")
                end
            end
            self:GetShowClose_GameObject():SetActive(false)
            self:BGSelfAdaptaion()
        end
    end
end

return UIHighRecyclePanel_RedeemRightUpOperate