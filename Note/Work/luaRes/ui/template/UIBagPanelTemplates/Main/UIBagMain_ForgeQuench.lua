---@class UIBagMain_ForgeQuench:UIBagMain_Normal
local UIBagMain_ForgeQuench = {}
setmetatable(UIBagMain_ForgeQuench, luaComponentTemplates.UIBagMainNormal)

---是否显示扩展按钮
---@public
---@return boolean
function UIBagMain_ForgeQuench:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_ForgeQuench:IsShowRecycleButton()
    return false
end

---是否使用服务器排序
function UIBagMain_ForgeQuench:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_ForgeQuench:IsShowCloseButton()
    return false
end

function UIBagMain_ForgeQuench:BagItemListSortFunction(leftItem, rightItem)
    if leftItem ~= nil and rightItem ~= nil then
        local lAcailable = self:IsAvailableForForgeQuench(leftItem)
        local rAcailable = self:IsAvailableForForgeQuench(rightItem)
        if lAcailable == rAcailable then
            local lShow = self:IsShow(leftItem)
            local rShow = self:IsShow(rightItem)
            if lShow == rShow then
                return leftItem.bagIndex < rightItem.bagIndex
            else
                return lShow
            end
        else
            return lAcailable
        end
    else
        return false
    end
end

---重写最基础的格子刷新
function UIBagMain_ForgeQuench:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if not self:IsAvailableForForgeQuench(bagItemInfo) or (not self:IsShow(bagItemInfo) or self:IsInsurance(bagItemInfo)) then
        ---置灰显示
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

---重写格子点击
function UIBagMain_ForgeQuench:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagItemInfo then
        if not self:IsAvailableForForgeQuench(bagItemInfo) then
            Utility.ShowPopoTips(bagGrid.go.transform, nil, 499, "UIBagPanel")
        elseif not self:IsShow(bagItemInfo) then
            Utility.ShowPopoTips(bagGrid.go.transform, nil, 500, "UIBagPanel")
        elseif self:IsInsurance(bagItemInfo) then
            Utility.ShowPopoTips(bagGrid.go.transform, nil, 499, "UIBagPanel")
        else
            if bagItemInfo.ItemTABLE.type == luaEnumItemType.Equip then
                luaEventManager.DoCallback(LuaCEvent.ForgeQuenchItemCheck, {
                    type = LuaEnumForgeQuenchItemCheckReason.Bag,
                    id = bagItemInfo.ItemTABLE.id,
                    itemId = bagItemInfo.ItemTABLE.id
                })
            end
        end
    end
end

---双击点击时,尝试使用物品
function UIBagMain_ForgeQuench:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)

end

---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_ForgeQuench:IsAvailableForForgeQuench(bagItemInfo)
    return gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():IsAvailableForForgeQuench(bagItemInfo)
end

---是否满足显示
---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_ForgeQuench:IsShow(bagItemInfo)
    if bagItemInfo and bagItemInfo.itemId then
        if bagItemInfo.ItemTABLE and bagItemInfo.ItemTABLE.type == luaEnumItemType.Equip then
            local forgeQuenchId = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetCuiLianIdByMaterialId(bagItemInfo.itemId)
            ---@type LuaForgeQuenchItemData
            local data = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetAllForgeQuenchItemByIdDic()[forgeQuenchId]
            if data then
                return data:IsShow()
            end
        else
            return true
        end
    end
    return false
end

return UIBagMain_ForgeQuench