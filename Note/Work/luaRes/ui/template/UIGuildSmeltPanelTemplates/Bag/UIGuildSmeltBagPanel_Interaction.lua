local UIGuildSmeltBagPanel_Interaction = {}

setmetatable(UIGuildSmeltBagPanel_Interaction, luaComponentTemplates.UIBagType_Interaction)

function UIGuildSmeltBagPanel_Interaction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIGuildSmeltBagPanel_Interaction:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIGuildSmeltBagPanel_Interaction:DoSingleClick(grid, bagItemInfo, itemTbl)
    uiStaticParameter.mUnionSmeltBagItemInfoLid = bagItemInfo.lid
    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo,rightUpButtonsModule = luaComponentTemplates.UIGuildSmeltBagPane_UIItemInfoRightUpOperate})
end

---@param bagItemInfo bagV2.BagItemInfo
function UIGuildSmeltBagPanel_Interaction:DoDoubleClick(grid, bagItemInfo, itemTbl)

end

function UIGuildSmeltBagPanel_Interaction:OnDestroy()
    self:RunBaseFunction("OnDestroy")
end

return UIGuildSmeltBagPanel_Interaction