---@class UIFriendCircle_BagPanel:UIChatPanel_BagPanel 朋友圈背包
local UIFriendCircle_BagPanel = {}

setmetatable(UIFriendCircle_BagPanel, luaComponentTemplates.UIChatPanel_BagPanel)

---交互
---@return UIFriendCircle_BagPanel_Interaction
function UIFriendCircle_BagPanel:GetChatBagInteraction()
    if self.mInteraction == nil then
        self.mInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIFriendCircle_BagPanel_Interaction, self, nil, nil)
    end
    return self.mInteraction
end

return UIFriendCircle_BagPanel