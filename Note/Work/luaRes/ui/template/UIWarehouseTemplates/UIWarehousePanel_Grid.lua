---@class UIWarehousePanel_Grid:UIBagTypeGrid
local UIWarehousePanel_Grid = {}

setmetatable(UIWarehousePanel_Grid, luaComponentTemplates.UIBagType_Grid)

function UIWarehousePanel_Grid:RefreshSingleGrid(bagItemInfo, itemTbl)
    ---刷新icon
    self:SetCompSpriteName(self.Components.Icon, itemTbl.icon)
    ---刷新物品数量/剩余使用次数
    local count = bagItemInfo.count
    if count <= 1 then
        count = bagItemInfo.leftUseNum
    end
    self:SetCompLabelContent(self.Components.Count, (count > 1) and tostring(count) or nil)
    ---刷新绿色箭头标记
    self:RefreshBagGridIsGood(self, bagItemInfo, itemTbl)
    ---刷新强化标记
    self:RefreshBagGridStrength(self, bagItemInfo, itemTbl)
    ---刷新聚灵珠的百分比
    self:RefreshJuLingZhuFillAmount(self, bagItemInfo, itemTbl)
    ---刷新血继套装标识
    self:RefreshBloodSuitSign(self, bagItemInfo, itemTbl)
    ---刷新投保标识
    self:RefreshInsureSign(self, bagItemInfo, itemTbl)
end

---刷新绿色箭头标记
---@param bagGrid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIWarehousePanel_Grid:RefreshBagGridIsGood(bagGrid, bagItemInfo, itemTbl)
    if CS.Utility_Lua.CheckShowBetterArrow(itemTbl) == false then
        return
    end
    local arrowType = Utility.GetArrowType(bagItemInfo)
    if arrowType ~= LuaEnumArrowType.NONE then
        bagGrid:SetCompActive(bagGrid.Components.Good, true)
        bagGrid:SetCompSpriteName(bagGrid.Components.Good, CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(arrowType))
    end
end

---刷新强化标记
---@param bagGrid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIWarehousePanel_Grid:RefreshBagGridStrength(bagGrid, bagItemInfo, itemTbl)
    if bagItemInfo.intensify > 0 then
        local str, icon = Utility.GetIntensifyShow(bagItemInfo.intensify)
        bagGrid:SetCompLabelContent(bagGrid.Components.Strengthen, str)
        bagGrid:SetCompSpriteName(bagGrid.Components.Star, icon)
    end
end

---刷新聚灵珠百分比
---@protected
---@param bagGrid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIWarehousePanel_Grid:RefreshJuLingZhuFillAmount(bagGrid, bagItemInfo, itemTbl)
    local CSMainPlayerInfo = CS.CSScene.MainPlayerInfo
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 4 then
        ---聚灵珠类型需要显示聚灵珠的百分比
        if bagItemInfo.maxStar > 0 and bagItemInfo.luck > 0 then
            bagGrid:SetCompSpriteName(bagGrid.Components.Icon2, CS.Cfg_GlobalTableManager.Instance:GetJuLingZhuIcon2SpriteName(itemTbl.id))
            bagGrid:SetCompSpriteFillAmount(bagGrid.Components.Icon2, CSMainPlayerInfo.BagInfo:GetJvLingZhuShowIcon2FillAmountValue(bagItemInfo))
        end
    end
end

---刷新血继套装标识
---@protected
---@param bagGrid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIWarehousePanel_Grid:RefreshBloodSuitSign(bagGrid, bagItemInfo, itemTbl)
    local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemTbl.id)
    local bloodLevel = bagItemInfo.bloodLevel
    if bloodsuitTbl and bloodLevel > 0 then
        bagGrid:SetCompActive(bagGrid.Components.BloodLv, true)
        bagGrid:SetCompLabelContent(bagGrid.Components.BloodLvLabel, tostring(bloodLevel))
    else
        bagGrid:SetCompActive(bagGrid.Components.BloodLv, false)
        bagGrid:SetCompActive(bagGrid.Components.BloodLvLabel, false)
    end
end

---刷新保险标识
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIWarehousePanel_Grid:RefreshInsureSign(bagGrid, bagItemInfo, itemTbl)
    if (gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)) then
        bagGrid:SetCompActive(bagGrid.Components.Insure, true)
    else
        bagGrid:SetCompActive(bagGrid.Components.Insure, false)
    end
end

return UIWarehousePanel_Grid