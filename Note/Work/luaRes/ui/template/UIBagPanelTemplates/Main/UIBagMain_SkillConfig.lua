---背包与灵兽界面组合时
---@class UIBagMain_SkillConfig:UIBagMain_Normal
local UIBagMain_SkillConfig = {}

setmetatable(UIBagMain_SkillConfig, luaComponentTemplates.UIBagMainNormal)

UIBagMain_SkillConfig.itemIDList = nil
function UIBagMain_SkillConfig:GetItemIDList()
    if self.itemIDList == nil then
        self.itemIDList = CS.Cfg_GlobalTableManagerBase.Instance:GetShortcutUseItemIDList();
    end
    return self.itemIDList
end
--region重写属性
---是否使用服务器排序
function UIBagMain_SkillConfig:IsUseServerOrder()
    return false
end

---是都显示扩展按钮
function UIBagMain_SkillConfig:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_SkillConfig:IsShowRecycleButton()
    return false
end

---是否显示关闭按钮
---@public
---@return boolean
function UIBagMain_SkillConfig:IsShowCloseButton()
    return false
end

---是否可双击
function UIBagMain_SkillConfig:IsItemDoubleClickedAvailable()
    return false
end

---是否可拖拽
function UIBagMain_SkillConfig:IsItemDragAvailable()
    return true
end
--endregion

--region 重写初始化方法
function UIBagMain_SkillConfig:OnInit()
end
--endregion

--region 重写交互方法
---格子结束被拖拽
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@param position UnityEngine.Vector3
---@param isDestroyed boolean 是否因被销毁导致的格子拖拽结束
function UIBagMain_SkillConfig:OnGridEndBeingDragged(bagGrid, bagItemInfo, itemTbl, position, isDestroyed)
    if isDestroyed == false then
        self.mPositionTemp = position
        if luaEventManager.HasCallback(LuaCEvent.Bag_GirdEndDrag) then
            luaEventManager.DoCallback(LuaCEvent.Bag_GirdEndDrag, {bagItemInfo = bagItemInfo,itemInfo = itemTbl,position = position})
        end
    end
end
--endregion

--region 重写格子筛选方法
---背包筛选方法
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_SkillConfig:BagItemFilterFunction(bagItemInfo, itemInfo)
    return self:FilterItemsInBag(bagItemInfo)
end
--endregion

---技能设置面板物品筛选
function UIBagMain_SkillConfig:FilterItemsInBag(bagItem)
    if self:GetItemIDList() == nil then
        return false
    end
    for i = 0, self:GetItemIDList().Length - 1 do
        if bagItem.itemId == tonumber(self:GetItemIDList()[i]) then
            return true
        end
    end
    return false
end

function UIBagMain_SkillConfig:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if luaEventManager.HasCallback(LuaCEvent.Bag_GridSingleClicked) then
        luaEventManager.DoCallback(LuaCEvent.Bag_GridSingleClicked, itemTbl)
    end
end

return UIBagMain_SkillConfig