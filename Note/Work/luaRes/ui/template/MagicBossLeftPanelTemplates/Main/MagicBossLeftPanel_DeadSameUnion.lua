local MagicBossLeftPanel_DeadSameUnion = {}

setmetatable(MagicBossLeftPanel_DeadSameUnion,luaComponentTemplates.MagicBossLeftPanel_Base)

--region 刷新
function MagicBossLeftPanel_DeadSameUnion:RefreshCurPanel()
    self:RunBaseFunction("RefreshCurPanel")
    self:RefreshSize(self:GetBG_UIWidget(),CS.UnityEngine.Vector2(270,278))
    self:RefreshActive(self:GetReward_GameObject(),true)
    self:RefreshActive(self:GetGetRewardBtn_GameObject(),true)
    self:UpdateAnchors(self:GetCenterBtn_GameObject())
end
--endregion

return MagicBossLeftPanel_DeadSameUnion