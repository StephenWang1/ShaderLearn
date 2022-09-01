---@class UIBagMain_BloodSuitSmelt:UIBagMain_Normal 血继熔炼背包
local UIBagMain_BloodSuitSmelt = {}

setmetatable(UIBagMain_BloodSuitSmelt, luaComponentTemplates.UIBagMainNormal)

---当前熔炼界面选中道具lid
UIBagMain_BloodSuitSmelt.mCurrentChooseItemId = nil

---当前熔炼界面选中选中格子
UIBagMain_BloodSuitSmelt.mCurrentChooseGrid = nil

--region 属性
---获取当前灵兽强化是否开启
function UIBagMain_BloodSuitSmelt:IsServantStrengthOpen()
    if self.mServantStrengthenOpen == nil then
        self.mServantStrengthenOpen = self:GetServantInfoV2():IsOpenServantStrength()
    end
    return self.mServantStrengthenOpen
end

---获取背包信息
function UIBagMain_BloodSuitSmelt:GetBagInfoV2()
    if self.mBagInfoV2 == nil then
        self.mBagInfoV2 = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfoV2
end

---获取灵兽信息
function UIBagMain_BloodSuitSmelt:GetServantInfoV2()
    if self.mServantInfoV2 == nil then
        self.mServantInfoV2 = CS.CSScene.MainPlayerInfo.ServantInfoV2
    end
    return self.mServantInfoV2
end
--endregion

--region重写初始化方法
function UIBagMain_BloodSuitSmelt:OnInit()
    self:RunBaseFunction("OnInit")
    ---锻造道具改变事件
    ---@type function
    self.OnBloodSuitSmeltChooseItemChange = function(msgId, bagItemInfo)
        self:OnBloodSuitSmeltChooseItemChangeFun(msgId, bagItemInfo)
    end
    ---背包关闭事件
    ---@type function
    self.OnBagClose = function()
        self:OnBagCloseFun()
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.BloodSuitSmeltChooseItemChange, self.OnBloodSuitSmeltChooseItemChange)
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end

function UIBagMain_BloodSuitSmelt:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    self:OnBagCloseFun()
end

--endregion

--region 消息监听
---熔炼道具改变
---@param bagItemInfo bagV2.BagItemInfo 改变道具信息
function UIBagMain_BloodSuitSmelt:OnBloodSuitSmeltChooseItemChangeFun(msgId, bagItemInfo)
    if bagItemInfo == nil then
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

---背包关闭消息
function UIBagMain_BloodSuitSmelt:OnBagCloseFun()
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.BloodSuitSmeltChooseItemChange, self.OnBloodSuitSmeltChooseItemChange)
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end
--endregion

--region重写属性
---是否使用服务器排序
function UIBagMain_BloodSuitSmelt:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_BloodSuitSmelt:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
function UIBagMain_BloodSuitSmelt:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_BloodSuitSmelt:IsShowRecycleButton()
    return false
end

function UIBagMain_BloodSuitSmelt:IsItemDoubleClickedAvailable()
    return false
end
--endregion

--region 重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_BloodSuitSmelt:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    local canSmelt = self:GetBagItemInfoCanSmelt(bagItemInfo.itemId)
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
function UIBagMain_BloodSuitSmelt:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    self:SetItemChoose(bagGrid, bagItemInfo)
    self:RefreshSmeltGridState(bagGrid, bagItemInfo, itemTbl)
end

---刷新背包格子选中状态
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_BloodSuitSmelt:SetItemChoose(bagGrid, bagItemInfo)
    if bagItemInfo.lid == self.mCurrentChooseItemId then
        bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
    end
end

---根据lid找到背包格子并设置选中
---@return UIBagGrid 找到的格子（没找到返回空）
function UIBagMain_BloodSuitSmelt:FindItemByLidAndSetChoose(lid, isChoose)
    local bagPanel = self:GetBagPanel()
    local grid = bagPanel:GetBagGrid(lid)
    if grid then
        grid:SetCompActive(grid.Components.ChosenEffect, isChoose)
    end
    return grid
end

--region 重写方法
---对维修装备排序
---@param leftItem bagV2.BagItemInfo
---@param rightItem bagV2.BagItemInfo
function UIBagMain_BloodSuitSmelt:BagItemListSortFunction(leftItem, rightItem)
    if self:GetBagItemInfoCanSmelt(leftItem.itemId) and not self:GetBagItemInfoCanSmelt(rightItem.itemId) then
        return true
    end
    return false
end

---@return boolean 道具是否可血炼
---@param itemId number 道具id
function UIBagMain_BloodSuitSmelt:GetBagItemInfoCanSmelt(itemId)
    if self.mItemIdToCanSmelt == nil then
        self.mItemIdToCanSmelt = {}
    end
    local canSmelt = self.mItemIdToCanSmelt[itemId]
    if canSmelt == nil then
        local data = self:CacheBloodSuitInfo(itemId)
        canSmelt = data ~= nil
        self.mItemIdToCanSmelt[itemId] = canSmelt
    end
    return canSmelt
end

---维修格子显示置灰
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_BloodSuitSmelt:RefreshSmeltGridState(bagGrid, bagItemInfo, itemTbl)
    local canSmelt = self:GetBagItemInfoCanSmelt(bagItemInfo.itemId)
    if canSmelt == false then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

---@return TABLE.cfg_bloodsuit 道具数据
function UIBagMain_BloodSuitSmelt:CacheBloodSuitInfo(itemId)
    if self.mItemIDToBloodSuitInfo == nil then
        self.mItemIDToBloodSuitInfo = {}
    end
    local data = self.mItemIDToBloodSuitInfo[itemId]
    if data == nil then
        data = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemId)
        self.mItemIDToBloodSuitInfo[itemId] = data
    end
    return data
end
--endregion

return UIBagMain_BloodSuitSmelt