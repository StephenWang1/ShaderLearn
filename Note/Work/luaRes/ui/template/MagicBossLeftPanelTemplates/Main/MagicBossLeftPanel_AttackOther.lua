local MagicBossLeftPanel_AttackOther = {}

setmetatable(MagicBossLeftPanel_AttackOther,luaComponentTemplates.MagicBossLeftPanel_Base)

--region 刷新
function MagicBossLeftPanel_AttackOther:RefreshCurPanel()
    self:RunBaseFunction("RefreshCurPanel")
    self:RefreshSize(self:GetBG_UIWidget(),CS.UnityEngine.Vector2(270,278))
    self:RefreshActive(self:GetReward_GameObject(),true)
    self:UpdateAnchors(self:GetCenterBtn_GameObject())
end
--endregion

return MagicBossLeftPanel_AttackOther