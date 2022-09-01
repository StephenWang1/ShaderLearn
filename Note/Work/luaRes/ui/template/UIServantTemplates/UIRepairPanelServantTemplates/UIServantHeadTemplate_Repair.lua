---维修重写灵兽头像模板
---@class UIServantHeadTemplate_Repair:UIServantInfoTemplate
local UIServantHeadTemplate_Repair = {}

setmetatable(UIServantHeadTemplate_Repair, luaComponentTemplates.UIServantInfoTemplate)

function UIServantHeadTemplate_Repair:Init(panel, index, openServantPanelType)
    self:RunBaseFunction("Init", panel, index, openServantPanelType)
    self:GetBtnUse_GameObject():SetActive(false)
end

---灵兽按钮点击事件
---@param openSourceType LuaEnumPanelOpenSourceType
function UIServantHeadTemplate_Repair:IconOnClick(openSourceType)
    if (self.ServantPanel ~= nil) then
        self.ServantPanel:SwitchServant(self.index)
    end
end

return UIServantHeadTemplate_Repair