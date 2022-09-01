---单发
local UIGuildSendBenefitsPanel_OnePlayerList = {}
setmetatable(UIGuildSendBenefitsPanel_OnePlayerList,luaComponentTemplates.UIGuildSendBenefitsPanel_Base)

--region UI事件
function UIGuildSendBenefitsPanel_OnePlayerList:GridOnClick(grid)
    if self.lastChooseGrid ~= nil and self.lastChooseGrid.grantPlayerInfo ~= nil then
        self.lastChooseGrid:ChangeChoose(not self.lastChooseGrid.isChoose)
    end
    self.lastChooseGrid = grid
end

---发布按钮点击
function UIGuildSendBenefitsPanel_OnePlayerList:GrantBtnOnClick(go)
    self:RunBaseFunction("GrantBtnOnClick")
    if self.bagItemInfo == nil or self.itemInfo == nil then
        print("没有物品")
        return
    end
    if self.choosePlayerList == nil or self.choosePlayerList.Count == 0 then
        Utility.ShowPopoTips(go.transform,nil,180)
        return
    end
    Utility.ShowSecondConfirmPanel({PromptWordId = 50 ,des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(49,self.itemInfo.name,self.choosePlayerInfoList[0].playerInfo.name),ComfireAucion = function()
        networkRequest.ReqGiveSpoils(self.bagItemInfo.lid, 1, self.choosePlayerList)
        uimanager:ClosePanel("UIGuildSendBenefitsPanel")
    end})
end
--endregion
return UIGuildSendBenefitsPanel_OnePlayerList