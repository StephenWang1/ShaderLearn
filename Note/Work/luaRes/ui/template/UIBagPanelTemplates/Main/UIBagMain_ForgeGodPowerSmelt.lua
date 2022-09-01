---由神炼组合背包的时候
---@class UIBagMain_ForgeGodPowerSmelt:UIBagMain_Normal
local UIBagMain_ForgeGodPowerSmelt = {}
---继承UIBagMainNormal
setmetatable(UIBagMain_ForgeGodPowerSmelt, luaComponentTemplates.UIBagMainNormal)

---当前神炼界面选中道具lid
UIBagMain_ForgeGodPowerSmelt.mCurrentChooseItemId = nil

--region重写初始化方法
function UIBagMain_ForgeGodPowerSmelt:OnInit()
    self:RunBaseFunction("OnInit")
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.ChangeForgeGodPowerTarget, function(magID, bagItemInfo)
        self:OnForgeGodPowerSmeltChange(bagItemInfo)
    end)
end

function UIBagMain_ForgeGodPowerSmelt:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    --self:OnBagCloseFun()
end
--endregion

---是否显示扩展按钮
---@public
---@return boolean
function UIBagMain_ForgeGodPowerSmelt:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_ForgeGodPowerSmelt:IsShowRecycleButton()
    return false
end

---是否使用服务器排序
function UIBagMain_ForgeGodPowerSmelt:IsUseServerOrder()
    return false
end

---对维修装备排序
---@param leftItem bagV2.BagItemInfo
---@param rightItem bagV2.BagItemInfo
function UIBagMain_ForgeGodPowerSmelt:BagItemListSortFunction(leftItem, rightItem)
    if self:IsDivineSuit(leftItem) and not self:IsDivineSuit(rightItem) then
        return true
    end
    return false
end

---神炼目标道具改变
---@param bagItemInfo bagV2.BagItemInfo 改变道具信息
function UIBagMain_ForgeGodPowerSmelt:OnForgeGodPowerSmeltChange(bagItemInfo)
    if bagItemInfo == nil then
        self.mCurrentChooseItemId = nil
        return
    end
    local lid = bagItemInfo.lid
    if lid and lid ~= self.mCurrentChooseItemId then
        local grid = self:FindItemByLidAndSetChoose(lid, true)
        if self.mCurrentChooseGrid then
            self.mCurrentChooseGrid:SetCompActive(self.mCurrentChooseGrid.Components.ChosenEffect, false)
        end
        if self.mCurrentChooseItemId then
            self:FindItemByLidAndSetChoose(self.mCurrentChooseItemId, false)
        end
        self.mCurrentChooseItemId = lid
        self.mCurrentChooseGrid = grid
    end
end


---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_ForgeGodPowerSmelt:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    local canSmelt = self:GetBagItemInfoCanSmelt(bagItemInfo)
    if not canSmelt then
        return
    end

    if bagItemInfo.lid ~= self.mCurrentChooseItemId then
        luaEventManager.DoCallback(LuaCEvent.Bag_GridSingleClicked, bagItemInfo)
    end
end

---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_ForgeGodPowerSmelt:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    self:SetItemChoose(bagGrid, bagItemInfo)
    self:RefreshSmeltGridState(bagGrid, bagItemInfo, itemTbl)
end

---刷新背包格子选中状态
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_ForgeGodPowerSmelt:SetItemChoose(bagGrid, bagItemInfo)
    if bagItemInfo.lid == self.mCurrentChooseItemId then
        bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
    end
end

---格子显示置灰
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_ForgeGodPowerSmelt:RefreshSmeltGridState(bagGrid, bagItemInfo, itemTbl)
    local canSmelt = self:IsDivineSuit(bagItemInfo)
    if canSmelt == false then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_ForgeGodPowerSmelt:IsDivineSuit(bagItemInfo)
    return Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineId() ~= nil and Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineId() ~= 0
end


---根据lid找到背包格子并设置选中
---@return UIBagGrid 找到的格子（没找到返回空）
function UIBagMain_ForgeGodPowerSmelt:FindItemByLidAndSetChoose(lid, isChoose)
    local bagPanel = self:GetBagPanel()
    local grid = bagPanel:GetBagGrid(lid)
    if grid then
        grid:SetCompActive(grid.Components.ChosenEffect, isChoose)
    end
    return grid
end


---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 道具是否可神炼
function UIBagMain_ForgeGodPowerSmelt:GetBagItemInfoCanSmelt(bagItemInfo)
    if(bagItemInfo == nil) then
        return false
    end
    local DivineId = Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineId()
    if(DivineId ~= nil and DivineId ~= 0) then
        return true
    end
    return false
end

return UIBagMain_ForgeGodPowerSmelt