---@class UIGuildInfoPanel_ChatPanel_BagPanel:UIChatPanel_BagPanel
local UIGuildInfoPanel_ChatPanel_BagPanel = {}

setmetatable(UIGuildInfoPanel_ChatPanel_BagPanel, luaComponentTemplates.UIChatPanel_BagPanel)

---交互
---@return UIGuildInfoPanel_ChatPanel_BagPanel_Interaction
function UIGuildInfoPanel_ChatPanel_BagPanel:GetChatBagInteraction()
    if self.mInteraction == nil then
        self.mInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIGuildInfoPanel_ChatPanel_BagPanel_Interaction, self, nil, nil)
    end
    return self.mInteraction
end

return UIGuildInfoPanel_ChatPanel_BagPanel