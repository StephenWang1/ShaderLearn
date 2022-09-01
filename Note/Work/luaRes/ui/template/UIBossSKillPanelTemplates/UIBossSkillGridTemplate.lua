---@class UIBossSkillGridTemplate:TemplateBase boss技能格子模板
local UIBossSkillGridTemplate = {}

--region 初始化
function UIBossSkillGridTemplate:Init()
    self:InitComponents()
    self:BindEvents()
end

function UIBossSkillGridTemplate:InitComponents()
    ---@type UnityEngine.GameObject
    self.go = self:Get("","GameObject")
    ---@type UISprite
    self.icon_UISprite = self:Get("icon","UISprite")
end

function UIBossSkillGridTemplate:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.go,function()
        ---@type skillInfoPanelCommonData
        local commonData = {}
        commonData.bossSkillDesTable = self.bossSkillDesTable
        uimanager:CreatePanel("UIBossSkillPanel",nil,commonData)
    end)
end
--endregion

--region 刷新
---@class BossSkillGridCommonData
---@field bossSkillDesTable TABLE.cfg_boss_skill_describe

---刷新面板
---@param BossSkillGridCommonData BossSkillGridCommonData
function UIBossSkillGridTemplate:RefreshPanel(BossSkillGridCommonData)
    if self:AnalysisParams(BossSkillGridCommonData) == false then
        return
    end
    luaclass.UIRefresh:RefreshSprite(self.icon_UISprite,self.bossSkillDesTable:GetIcon())
end

---解析数据
---@param BossSkillGridCommonData BossSkillGridCommonData
---@return boolean
function UIBossSkillGridTemplate:AnalysisParams(BossSkillGridCommonData)
    if type(BossSkillGridCommonData) ~= 'table' or BossSkillGridCommonData.bossSkillDesTable == nil then
        return false
    end
    self.bossSkillDesTable = BossSkillGridCommonData.bossSkillDesTable
    return true
end
--endregion

return UIBossSkillGridTemplate