local UIBuDouKaiPanel_Wait = {}
setmetatable(UIBuDouKaiPanel_Wait,luaComponentTemplates.UIBuDouKaiPanel_Base)

--region 刷新
function UIBuDouKaiPanel_Wait:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
end

function UIBuDouKaiPanel_Wait:RefreshTime()
    self:RunBaseFunction("RefreshTime")
    self:RefreshLabel(self:GetCountDown_UILabel(),self:GetRemainTimeText())
end

---最后剩余时间在10秒内触发（触发一次）
function UIBuDouKaiPanel_Wait:RefreshTenTime()
    self:OpenStartCountDownTimeEffect()
    self:OpenStartCountDownBackGround()
end

---最后剩余时间在配置的时间内（触发一次）
function UIBuDouKaiPanel_Wait:RefreshConfigTime()

end
--endregion
return UIBuDouKaiPanel_Wait