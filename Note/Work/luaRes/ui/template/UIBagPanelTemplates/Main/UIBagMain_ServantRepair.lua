---灵兽维修打开背包界面
---@class UIBagMain_ServantRepair:UIBagMain_Repair
local UIBagMain_ServantRepair = {}
setmetatable(UIBagMain_ServantRepair, luaComponentTemplates.UIBagMain_Repair)

---满足置灰条件（是本职业且耐久度未满）灵兽
---@param bagIemInfo bagV2.BagItemInfo
function UIBagMain_ServantRepair:IsItemLastingFull(bagIemInfo)
    if bagIemInfo then
        local itemInfo = bagIemInfo.ItemTABLE
        local lastingFull = bagIemInfo.currentLasting < itemInfo.maxLasting
        if lastingFull then
            return false
        end
    end
    return true
end

return UIBagMain_ServantRepair