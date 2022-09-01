---@class UIBagMain_Transfer:UIBagMain_Normal
local UIBagMain_Transfer = {}

setmetatable(UIBagMain_Transfer, luaComponentTemplates.UIBagMainNormal)

---左边道具id
UIBagMain_Transfer.OriginChooseBagItemId = nil
---左边道具格子
UIBagMain_Transfer.OriginChooseBagGrid = nil
---右边道具id
UIBagMain_Transfer.AimChooseBagItemId = nil
---右边道具格子
UIBagMain_Transfer.AimChooseBagGrid = nil

--region 属性
---获取背包信息
function UIBagMain_Transfer:GetBagInfoV2()
    if self.mBagInfoV2 == nil then
        self.mBagInfoV2 = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfoV2
end

---获取灵兽信息
function UIBagMain_Transfer:GetServantInfoV2()
    if self.mServantInfoV2 == nil then
        self.mServantInfoV2 = CS.CSScene.MainPlayerInfo.ServantInfoV2
    end
    return self.mServantInfoV2
end

---获取当前灵兽强化是否开启
function UIBagMain_Transfer:IsServantStrengthOpen()
    if self.mServantStrengthenOpen == nil then
        self.mServantStrengthenOpen = self:GetServantInfoV2():IsOpenServantStrength()
    end
    return self.mServantStrengthenOpen
end
--endregion


--region重写初始化方法
function UIBagMain_Transfer:OnInit()
    self:RunBaseFunction("OnInit")
    self.OriginTransferBagItemChange = function(msgId, lid)
        self:OriginTransferBagItemChangeFunc(msgId, lid)
    end
    self.AimTransferBagItemChange = function(msgId, lid)
        self:AimTransferBagItemChangeFunc(msgId, lid)
    end
    ---背包关闭事件
    ---@type function
    self.OnBagClose = function()
        self:OnBagCloseFun()
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.OriginTransferBagItemChange, self.OriginTransferBagItemChange)
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.AimTransferBagItemChange, self.AimTransferBagItemChange)
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end

function UIBagMain_Transfer:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    self:OnBagCloseFun()
end

--endregion

--region 消息监听
---左边选中道具改变信息
---@param lid number 當前選中道具lid，可以為空
function UIBagMain_Transfer:OriginTransferBagItemChangeFunc(msgId, lid)
    if lid ~= self.OriginChooseBagItemId then
        --关闭当前选中
        if not CS.StaticUtility.IsNull(self.OriginChooseBagGrid) then
            self.OriginChooseBagGrid:SetCompActive(self.OriginChooseBagGrid.Components.ChosenEffect, false)
        elseif self.OriginChooseBagItemId then
            self:FindItemByLidAndSetChoose(self.OriginChooseBagItemId, false)
        end
        --设置新选中
        local grid = self:FindItemByLidAndSetChoose(lid, true)
        self.OriginChooseBagItemId = lid
        self.OriginChooseBagGrid = grid
    end
end

---右边选中道具改变信息
---@param lid number 當前選中道具lid，可以為空
function UIBagMain_Transfer:AimTransferBagItemChangeFunc(msgId, lid)
    if lid ~= self.AimChooseBagItemId then
        --关闭当前选中
        if not CS.StaticUtility.IsNull(self.AimChooseBagGrid) then
            self.AimChooseBagGrid:SetCompActive(self.AimChooseBagGrid.Components.ChosenEffect, false)
        elseif self.AimChooseBagItemId then
            self:FindItemByLidAndSetChoose(self.AimChooseBagItemId, false)
        end
        --设置新选中
        local grid = self:FindItemByLidAndSetChoose(lid, true)
        self.AimChooseBagItemId = lid
        self.AimChooseBagGrid = grid
    end
end

---背包关闭消息
function UIBagMain_Transfer:OnBagCloseFun()
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.OriginTransferBagItemChange, self.OriginTransferBagItemChange)
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.AimTransferBagItemChange, self.AimTransferBagItemChange)
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end
--endregion

--region重写属性
---是否使用服务器排序
function UIBagMain_Transfer:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_Transfer:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
function UIBagMain_Transfer:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Transfer:IsShowRecycleButton()
    return false
end

function UIBagMain_Transfer:IsItemDoubleClickedAvailable()
    return false
end
--endregion

--region重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Transfer:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagItemInfo and bagItemInfo.lid ~= self.OriginChooseBagItemId and bagItemInfo.lid ~= self.AimChooseBagItemId then
        luaEventManager.DoCallback(LuaCEvent.Bag_GridSingleClicked, bagItemInfo)
    end
end

---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Transfer:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    self:SetItemChoose(bagGrid, bagItemInfo)
end

---刷新背包格子选中状态
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Transfer:SetItemChoose(bagGrid, bagItemInfo)
    if bagItemInfo .lid == self.OriginChooseBagItemId or bagItemInfo.lid == self.AimChooseBagItemId then
        bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
    end
end

---背包物品筛选方法
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Transfer:BagItemFilterFunction(bagItemInfo, itemInfo)
    if itemInfo.type == luaEnumItemType.Equip then
        if not self:IsServantStrengthOpen() and CS.CSServantInfoV2.IsServantEquip(itemInfo.subType) then
            return false
        end
        return self:GetBagInfoV2():CanItemStrength(bagItemInfo)
    end
    return false
end
--endregion

---根据lid找到背包格子并设置选中
---@return UIBagGrid 找到的格子（没找到返回空）
function UIBagMain_Transfer:FindItemByLidAndSetChoose(lid, isChoose)
    local bagPanel = self:GetBagPanel()
    local grid = bagPanel:GetBagGrid(lid)
    if grid then
        grid:SetCompActive(grid.Components.ChosenEffect, isChoose)
    end
    return grid
end

return UIBagMain_Transfer