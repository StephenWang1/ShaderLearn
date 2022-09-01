---@class UIReforgedPanelTemplates_LevelEffect:TemplateBase 等级特效
local UIReforgedPanelTemplates_LevelEffect = {}

--region 初始化
function UIReforgedPanelTemplates_LevelEffect:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIReforgedPanelTemplates_LevelEffect:InitComponent()
    ---@type UnityEngine.GameObject 等级特效
    self.levelEffect_GameObject = self:Get("label2","GameObject")
    ---@type UILabel
    self.levelName_UILabel = self:Get("bg/lv","UILabel")
end

function UIReforgedPanelTemplates_LevelEffect:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.go,function()
        if self.buffTbl ~= nil then
            uimanager:CreatePanel("TextHintPanel",nil,{ title = self.buffTbl:GetName(), str = self.buffTbl:GetTipsTxt()})
        end
    end)
end
--endregion

--region 刷新
---@param commonData TABLE.cfg_recast_skill
function UIReforgedPanelTemplates_LevelEffect:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self:RefreshState()
    if self.effectInfo ~= nil then
        luaclass.UIRefresh:RefreshLabel(self.levelName_UILabel,self.effectInfo:GetRecastLevel())
    end
end


---@param levelEffectInfo TABLE.cfg_recast_skill
---@return boolean
function UIReforgedPanelTemplates_LevelEffect:AnalysisParams(levelEffectInfo)
    if type(levelEffectInfo) ~= 'table' or levelEffectInfo:GetBuffTips() == nil then
        return false
    end
    self.effectInfo = levelEffectInfo
    self.buffTbl = clientTableManager.cfg_buffManager:TryGetValue(self.effectInfo:GetBuffTips())
    return true
end

---刷新特效状态
function UIReforgedPanelTemplates_LevelEffect:RefreshState()
    luaclass.UIRefresh:RefreshActive(self.levelEffect_GameObject, self.effectInfo:GetEffect() == 1)
end

--endregion

return UIReforgedPanelTemplates_LevelEffect