---高级回收放入右上角操作按钮
---@class UIHighRecyclePanel_PutInRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIHighRecyclePanel_PutInRightUpOperate = {}

setmetatable(UIHighRecyclePanel_PutInRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---@param commonData UIItemTipInfoCommonData
function UIHighRecyclePanel_PutInRightUpOperate:RefreshWithInfo(commonData)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    if self.mBagItemInfo and self.mItemInfo then
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = 1
            local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
            local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
            btnLabel.text = "放入"
            CS.UIEventListener.Get(buttonGO).onClick = function()
                if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BagInfo:HasItem(self.mBagItemInfo) then
                    ---@type UIBagPanel
                    local bagPanel = uimanager:GetPanel("UIBagPanel")
                    if bagPanel ~= nil and bagPanel:GetBagType() == LuaEnumBagType.HighRecycle then
                        if bagPanel:GetBagMainController():AddItemToPreviewList(self.mBagItemInfo) then
                            CS.Utility.ShowTips("寄售已满", 1.5, CS.ColorType.Yellow)
                        else
                            uimanager:ClosePanel("UIItemInfoPanel")
                        end
                    end
                else
                    uimanager:ClosePanel("UIItemInfoPanel")
                end
            end
            self:GetShowClose_GameObject():SetActive(false)
            self:BGSelfAdaptaion()
        end
    end
end

return UIHighRecyclePanel_PutInRightUpOperate