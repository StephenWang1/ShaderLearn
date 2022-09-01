---@class UIChallengeBoss_AncientBossTemplates:UIChallengeBoss_FinalBossBaseTemplate 远古boss单元模板
local UIChallengeBoss_AncientBossTemplates = {}

setmetatable(UIChallengeBoss_AncientBossTemplates, luaComponentTemplates.UIChallengeBoss_FinalBossBaseTemplate)

--region 刷新
function UIChallengeBoss_AncientBossTemplates:RefreshUI(data, ClipShader)
    self:RunBaseFunction("RefreshUI", data, ClipShader)
    self:RefreshKillProgress()
end

---刷新击杀进度
function UIChallengeBoss_AncientBossTemplates:RefreshKillProgress()
    if self.bossTable == nil or self.fieldBossInfo == nil then
        return
    end
    local monsterID = self.bossTable:GetConfId()
    if monsterID == nil or type(monsterID) ~= 'number' then
        return
    end
    local ancientBossTableInfoIsFind,ancientBossTableInfo = CS.Cfg_AncientBossTableManager.Instance:TryGetValue(monsterID)
    if ancientBossTableInfo == nil then
        return
    end
    local totalKillNum = ancientBossTableInfo.num
    if totalKillNum == nil or type(totalKillNum) ~= 'number' then
        return
    end
    local progressValue = self.fieldBossInfo.killCount / totalKillNum
    local progressTextDes = luaEnumColorType.Green .. tostring(self.fieldBossInfo.killCount) .. "/" .. tostring(totalKillNum)
    luaclass.UIRefresh:RefreshActive(self.bossNum_Slider,true)
    luaclass.UIRefresh:SetSliderProgress(self.bossNum_Slider,progressValue)
    luaclass.UIRefresh:RefreshLabel(self.bossNumSlider_UIlabel,progressTextDes)
end
--endregion

return UIChallengeBoss_AncientBossTemplates