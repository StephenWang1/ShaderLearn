local UIBuDouKaiPanel_FinalOver = {}
setmetatable(UIBuDouKaiPanel_FinalOver,luaComponentTemplates.UIBuDouKaiPanel_Base)

--region 刷新
function UIBuDouKaiPanel_FinalOver:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
    CS.CSScene.MainPlayerInfo.ActivityInfo.ShowRank = true
    self:CloseUpdate()
    if CS.CSScene.MainPlayerInfo.BudowillInfo.Rank <= 0 then
        self:RefreshLabel(self:GetMainPlayerStageDescribe_UILabel(),"")
    else
        self:RefreshLabel(self:GetMainPlayerStageDescribe_UILabel(),CS.Cfg_WuDaoHuiTableManager.Instance:GetMainPlayerStageDes(CS.CSScene.MainPlayerInfo.BudowillInfo.Rank))
    end

    self:RefreshLabel(self:GetCountDown_UILabel(),"已结束")
end
--endregion
return UIBuDouKaiPanel_FinalOver