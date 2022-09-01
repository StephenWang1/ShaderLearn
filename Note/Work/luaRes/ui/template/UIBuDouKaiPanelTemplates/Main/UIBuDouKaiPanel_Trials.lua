local UIBuDouKaiPanel_Trials = {}
setmetatable(UIBuDouKaiPanel_Trials,luaComponentTemplates.UIBuDouKaiPanel_Base)

--region 刷新
function UIBuDouKaiPanel_Trials:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
    local color = ternary(self.buDouKaiInfo.TrialsRank <= self.buDouKaiInfo.TrialsMaxPrmootedNum,luaEnumColorType.Green,luaEnumColorType.Red)
    self:RefreshLabel(self:GetMainPlayerStageDescribe_UILabel(),ternary(self.buDouKaiInfo.TrialsRank > 0,CS.Cfg_WuDaoHuiTableManager.Instance:GetMainPlayerStageDes(color .. tostring(self.buDouKaiInfo.TrialsRank),"")))
    self:CloseCountDown()
end

function UIBuDouKaiPanel_Trials:RefreshTime()
    self:RefreshLabel(self:GetCountDown_UILabel(),self:GetRemainTimeText())
end
--endregion
return UIBuDouKaiPanel_Trials