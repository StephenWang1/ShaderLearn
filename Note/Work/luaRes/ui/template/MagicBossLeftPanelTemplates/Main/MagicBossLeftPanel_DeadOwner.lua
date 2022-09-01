local MagicBossLeftPanel_DeadOwner = {}

setmetatable(MagicBossLeftPanel_DeadOwner,luaComponentTemplates.MagicBossLeftPanel_Base)

--region 刷新
function MagicBossLeftPanel_DeadOwner:RefreshCurPanel()
    self:RunBaseFunction("RefreshCurPanel")
    self:RefreshSize(self:GetBG_UIWidget(),CS.UnityEngine.Vector2(270,215))
    self:RefreshActive(self:GetGetKillRewardBtn_GameObject(),true)
    self:UpdateAnchors(self:GetCenterBtn_GameObject())
end
--endregion

return MagicBossLeftPanel_DeadOwner