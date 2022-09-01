---高级回收放入右上角操作按钮
---@class UIHighRecyclePanel_TakeOutRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIHighRecyclePanel_TakeOutRightUpOperate = {}

setmetatable(UIHighRecyclePanel_TakeOutRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---@param commonData UIItemTipInfoCommonData
function UIHighRecyclePanel_TakeOutRightUpOperate:RefreshWithInfo(commonData)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    if self.mBagItemInfo and self.mItemInfo then
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = 1
            local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
            local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
            btnLabel.text = "取出"
            CS.UIEventListener.Get(buttonGO).onClick = function()
                luaEventManager.DoCallback(LuaCEvent.HighRecycleRemoveItemInHighRecyclePanel, self.mBagItemInfo)
                uimanager:ClosePanel("UIItemInfoPanel")
            end
            self:GetShowClose_GameObject():SetActive(false)
            self:BGSelfAdaptaion()
        end
    end
end

return UIHighRecyclePanel_TakeOutRightUpOperate