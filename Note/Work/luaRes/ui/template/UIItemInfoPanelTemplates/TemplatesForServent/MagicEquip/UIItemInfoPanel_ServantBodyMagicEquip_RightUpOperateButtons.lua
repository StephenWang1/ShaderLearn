---@class UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons:UIItemInfoPanel_Info_RightUpOperateButtons 灵兽身上的灵兽法宝右上角按钮模板
local UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons = {}

setmetatable(UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons,luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---获取需要显示的按钮列表
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return table<number>,number 按钮id列表，初始显示数量
function UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons:GetBtnTable(bagItemInfo, itemInfo)
    local baseBtnTable,btnCount = self:RunBaseFunction("GetBtnTable",bagItemInfo,itemInfo)
    local operationButtons = {}
    if itemInfo == nil then
        return operationButtons,0
    end
    local isServantMagicEquip = Utility.IsServantMagicEquip(itemInfo.id)
    local isDefaultServantMagicEquip = LuaGlobalTableDeal.IsServantDefaultMagicEquip(itemInfo.id)
    if isServantMagicEquip == true and isDefaultServantMagicEquip == false and Utility.IsContainsValue(baseBtnTable,26) then
        return {26},1
    end
    return operationButtons,0
end

return UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons