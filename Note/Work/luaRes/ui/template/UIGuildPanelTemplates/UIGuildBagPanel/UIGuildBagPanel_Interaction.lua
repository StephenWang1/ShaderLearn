---帮会背包交互控制
---@class UIGuildBagPanel_Interaction:UIBagTypeContainerInteraction
local UIGuildBagPanel_Interaction = {}

setmetatable(UIGuildBagPanel_Interaction, luaComponentTemplates.UIBagType_Interaction)

function UIGuildBagPanel_Interaction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIGuildBagPanel_Interaction:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIGuildBagPanel_Interaction:DoSingleClick(grid, bagItemInfo, itemTbl)
    --uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, rightUpButtonsModule = luaComponentTemplates.UIGuildBagPane_UIItemInfoRightUpOperate, showRight = true })
    Utility.CreateGuildBagItemPanel(bagItemInfo)
end

---@param bagItemInfo bagV2.BagItemInfo
function UIGuildBagPanel_Interaction:DoDoubleClick(grid, bagItemInfo, itemTbl)
    -- local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(bagItemInfo.itemId)
    if bagItemInfo.count > 1 then
        Utility.CreateGuildBagItemPanel(bagItemInfo)
        return
    end
    networkRequest.ReqDonateEquip(bagItemInfo.lid)
end

function UIGuildBagPanel_Interaction:OnDestroy()
    uiStaticParameter.UnionDonateOverlayItemLid = 0
end

return UIGuildBagPanel_Interaction