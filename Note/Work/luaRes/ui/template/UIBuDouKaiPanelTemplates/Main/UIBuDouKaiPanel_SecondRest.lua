local UIBuDouKaiPanel_SecondRest = {}
setmetatable(UIBuDouKaiPanel_SecondRest,luaComponentTemplates.UIBuDouKaiPanel_Base)

--region 刷新
function UIBuDouKaiPanel_SecondRest:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
    self:RefreshLabel(self:GetMainPlayerStageDescribe_UILabel(),CS.Cfg_WuDaoHuiTableManager.Instance:GetMainPlayerStageDes(tostring(self.buDouKaiInfo.Rank)))
end

function UIBuDouKaiPanel_SecondRest:RefreshTime()
    self:RunBaseFunction("RefreshTime")
    self:RefreshLabel(self:GetCountDown_UILabel(),self:GetRemainTimeText())
end

---最后剩余时间在10秒内触发（触发一次）
function UIBuDouKaiPanel_SecondRest:RefreshTenTime()
    self:OpenStartCountDownTimeEffect()
    self:OpenStartCountDownBackGround()
end

---最后剩余时间在配置的时间内（触发一次）
function UIBuDouKaiPanel_SecondRest:RefreshConfigTime()

end
--endregion
return UIBuDouKaiPanel_SecondRest