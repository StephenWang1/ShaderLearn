---@class UIChatPanel_BagPanel_Interaction:UIBagTypeContainerInteraction
local UIChatPanel_BagPanel_Interaction = {}

setmetatable(UIChatPanel_BagPanel_Interaction, luaComponentTemplates.UIBagType_Interaction)

function UIChatPanel_BagPanel_Interaction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIChatPanel_BagPanel_Interaction:DoSingleClick(grid, bagItemInfo, itemTbl)
    luaEventManager.DoCallback(LuaCEvent.OnClickChatBagItem, bagItemInfo)
end

return UIChatPanel_BagPanel_Interaction