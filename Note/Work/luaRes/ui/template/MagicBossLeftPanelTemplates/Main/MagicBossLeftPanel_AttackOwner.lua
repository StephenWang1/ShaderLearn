local MagicBossLeftPanel_AttackOwner = {}

setmetatable(MagicBossLeftPanel_AttackOwner,luaComponentTemplates.MagicBossLeftPanel_Base)

--region 刷新
function MagicBossLeftPanel_AttackOwner:RefreshCurPanel()
    self:RunBaseFunction("RefreshCurPanel")
    self:RefreshSize(self:GetBG_UIWidget(),CS.UnityEngine.Vector2(270,278))
    self:RefreshActive(self:GetCenterBtn_GameObject(),true)
    self:UpdateAnchors(self:GetCenterBtn_GameObject())
end
--endregion

return MagicBossLeftPanel_AttackOwner