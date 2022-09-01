---@class UIFriendCircle_BagPanel_Interaction:UIChatPanel_BagPanel_Interaction 朋友圈背包交互
local UIFriendCircle_BagPanel_Interaction = {}

setmetatable(UIFriendCircle_BagPanel_Interaction, luaComponentTemplates.UIChatPanel_BagPanel_Interaction)

function UIFriendCircle_BagPanel_Interaction:DoSingleClick(grid, bagItemInfo, itemTbl)
    luaEventManager.DoCallback(LuaCEvent.OnClickFriendCircle, bagItemInfo)
end

return UIFriendCircle_BagPanel_Interaction