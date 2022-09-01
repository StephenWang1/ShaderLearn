local UIBuDouKaiPanel_FirstRest = {}
setmetatable(UIBuDouKaiPanel_FirstRest,luaComponentTemplates.UIBuDouKaiPanel_Base)
--region 刷新
function UIBuDouKaiPanel_FirstRest:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
    if self.buDouKaiInfo.Rank == nil then
        self.buDouKaiInfo.Rank = 999
    end
    self:RefreshLabel(self:GetMainPlayerStageDescribe_UILabel(),CS.Cfg_WuDaoHuiTableManager.Instance:GetMainPlayerStageDes(tostring(self.buDouKaiInfo.Rank)))
end

function UIBuDouKaiPanel_FirstRest:RefreshTime()
    self:RunBaseFunction("RefreshTime")
    self:RefreshLabel(self:GetCountDown_UILabel(),self:GetRemainTimeText())
end

---最后剩余时间在10秒内触发（触发一次）
function UIBuDouKaiPanel_FirstRest:RefreshTenTime()
    self:OpenStartCountDownTimeEffect()
    self:OpenStartCountDownBackGround()
end

---最后剩余时间在配置的时间内（触发一次）
function UIBuDouKaiPanel_FirstRest:RefreshConfigTime()

end
--endregion
return UIBuDouKaiPanel_FirstRest