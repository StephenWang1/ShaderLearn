---背包与买卖材料组合时
---@class UIBagMainMaterial:UIBagMain_Normal
local UIBagMain_Material = {}

setmetatable(UIBagMain_Material, luaComponentTemplates.UIBagMainNormal)

--region 初始化
function UIBagMain_Material:OnInit()
    self:RunBaseFunction("OnInit")
    if self.mCustomData ~= nil and self.mCustomData.materialSubtype ~= nil then
        self.mSubMaterialType = self.mCustomData.materialSubtype
    end
end
--endregion

--region 重写属性
function UIBagMain_Material:IsUseServerOrder()
    return false
end
--endregion

---是否显示关闭按钮
---@public
---@return boolean
function UIBagMain_Material:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
---@public
---@return boolean
function UIBagMain_Material:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Material:IsShowRecycleButton()
    return false
end

--region 重写格子筛选方法
---只筛选出相同子类的材料
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Material:BagItemFilterFunction(bagItemInfo, itemInfo)

    if CS.Cfg_NpcShopManager.Instance.ShopItemDic:ContainsKey(itemInfo.id) then
        return true
    elseif itemInfo.recoverShop == self.mSubMaterialType then
        return true
    else
        return false
    end
end
--endregion

return UIBagMain_Material