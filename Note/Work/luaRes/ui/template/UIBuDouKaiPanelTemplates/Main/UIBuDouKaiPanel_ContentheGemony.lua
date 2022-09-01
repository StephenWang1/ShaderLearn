local UIBuDouKaiPanel_ContentheGemony = {}
setmetatable(UIBuDouKaiPanel_ContentheGemony,luaComponentTemplates.UIBuDouKaiPanel_Base)

--region 刷新
function UIBuDouKaiPanel_ContentheGemony:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
    self:RefreshLabel(self:GetMainPlayerStageDescribe_UILabel(),CS.Cfg_WuDaoHuiTableManager.Instance:GetMainPlayerStageDes(tostring(self.buDouKaiInfo.ServivalPlayerNum)))
    self:CloseCountDown()
end

function UIBuDouKaiPanel_ContentheGemony:RefreshTime()
    self:RefreshLabel(self:GetCountDown_UILabel(),self:GetRemainTimeText())
end
--endregion
return UIBuDouKaiPanel_ContentheGemony