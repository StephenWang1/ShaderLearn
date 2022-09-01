---@class UIBossPanel_PersonalViewTemplate:UIBossPanel_BaseViewTemplate 个人boss视图
local UIBossPanel_PersonalViewTemplate = {}

setmetatable(UIBossPanel_PersonalViewTemplate, luaComponentTemplates.UIBossPanel_BaseViewTemplate)

function UIBossPanel_PersonalViewTemplate:InitTemplate(customData)
    self:RunBaseFunction('InitTemplate', customData)
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_PersonalBossTemplate
end

---是否显示左侧页签
---@protected
function UIBossPanel_PersonalViewTemplate:IsShowLeftPageView()
    if not self.initialized then
        self.initialized = true
        uiStaticParameter.PersonalBossRedPointLock = true
        gameMgr:GetLuaRedPointManager():CallPersonalBossRedPoint()
    end
    return true
end

---boss副页签是否显示boss击杀进度
---@return boolean
function UIBossPanel_PersonalViewTemplate:BookMarkIsShowBossFill()
    return true
end


return UIBossPanel_PersonalViewTemplate