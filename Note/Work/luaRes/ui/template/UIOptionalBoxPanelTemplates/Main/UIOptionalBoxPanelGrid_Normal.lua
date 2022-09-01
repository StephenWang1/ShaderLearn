local UIOptionalBoxPanelGrid_Normal = {}

setmetatable(UIOptionalBoxPanelGrid_Normal,luaComponentTemplates.UIOptionalBoxPanelGrid_Base)

--region 刷新
function UIOptionalBoxPanelGrid_Normal:RefreshPanel(commonData)
    self.refreshSuccess = self:RunBaseFunction("RefreshPanel",commonData)
    self.maxChooseCount = commonData.maxChooseCount
    return self.refreshSuccess
end
--endregion

--region 事件
function UIOptionalBoxPanelGrid_Normal:ItemChooseClick()
    local curChoose = not self.isChoose
    self:RefreshChooseState(curChoose)
    if curChoose == true then
        CS.Cfg_BoxTableManager.Instance:AddItemIdChooseList(self.itemInfo.id,self.maxChooseCount)
    else
        CS.Cfg_BoxTableManager.Instance:RemoveItemIdToChooseList(self.itemInfo.id)
    end
end
--endregion

--region OnDestroy
function UIOptionalBoxPanelGrid_Normal:OnDestroy()
    CS.Cfg_BoxTableManager.Instance:ClearChooseList()
end
--endregion

return UIOptionalBoxPanelGrid_Normal