---@class UIBagMain_AgainRefine:UIBagMain_Normal 洗炼背包
local UIBagMain_AgainRefine = {}

setmetatable(UIBagMain_AgainRefine, luaComponentTemplates.UIBagMainNormal)

---当前熔炼界面选中道具lid
UIBagMain_AgainRefine.mCurrentChooseItemId = nil

---当前熔炼界面选中选中格子
UIBagMain_AgainRefine.mCurrentChooseGrid = nil

--region 属性
---获取背包信息
function UIBagMain_AgainRefine:GetBagInfoV2()
    if self.mBagInfoV2 == nil then
        self.mBagInfoV2 = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfoV2
end
--endregion

--region重写初始化方法
function UIBagMain_AgainRefine:OnInit()
    self:RunBaseFunction("OnInit")
    ---锻造道具改变事件
    ---@type function
    self.OnAgainSoulChooseItemChange = function(msgId, bagItemInfo)
        self:OnAgainSoulChooseItemChangeFun(msgId, bagItemInfo)
    end
    ---背包关闭事件
    ---@type function
    self.OnBagClose = function()
        self:OnBagCloseFun()
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.AgainSoulChangeChooseItem, self.OnAgainSoulChooseItemChange)
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end

function UIBagMain_AgainRefine:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    self:OnBagCloseFun()
end

--endregion

--region 消息监听
---熔炼道具改变
---@param bagItemInfo bagV2.BagItemInfo 改变道具信息
function UIBagMain_AgainRefine:OnAgainSoulChooseItemChangeFun(msgId, bagItemInfo)
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
function UIBagMain_AgainRefine:OnBagCloseFun()
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.AgainSoulChangeChooseItem, self.OnAgainSoulChooseItemChange)
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end
--endregion

--region重写属性
---是否使用服务器排序
function UIBagMain_AgainRefine:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_AgainRefine:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
function UIBagMain_AgainRefine:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_AgainRefine:IsShowRecycleButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_AgainRefine:IsShowRecycleButton()
    return false
end


function UIBagMain_AgainRefine:IsItemDoubleClickedAvailable()
    return false
end
--endregion

--region 重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_AgainRefine:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    local canSoul = self:GetBagItemInfoIsSoul(bagItemInfo.itemId)
    if not canSoul then
        return
    end
    if bagItemInfo.lid ~= self.mCurrentChooseItemId then
        local luaBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(bagItemInfo.lid)
        luaEventManager.DoCallback(LuaCEvent.Bag_GridSingleClicked, luaBagItemInfo)
    end
end

---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_AgainRefine:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    self:SetItemChoose(bagGrid, bagItemInfo)
    self:RefreshSmeltGridState(bagGrid, bagItemInfo, itemTbl)
end

---刷新背包格子选中状态
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_AgainRefine:SetItemChoose(bagGrid, bagItemInfo)
    if bagItemInfo.lid == self.mCurrentChooseItemId then
        bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
    end
end

---根据lid找到背包格子并设置选中
---@return UIBagGrid 找到的格子（没找到返回空）
function UIBagMain_AgainRefine:FindItemByLidAndSetChoose(lid, isChoose)
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
function UIBagMain_AgainRefine:BagItemListSortFunction(leftItem, rightItem)
    if self:GetBagItemInfoIsSoul(leftItem.itemId) and not self:GetBagItemInfoIsSoul(rightItem.itemId) then
        return true
    end
    return false
end

---@return boolean 道具是否是魂装
---@param itemId number 道具id
function UIBagMain_AgainRefine:GetBagItemInfoIsSoul(itemId)
    if self.mItemIdToIsSoul == nil then
        self.mItemIdToIsSoul = {}
    end
    local isSoul = self.mItemIdToIsSoul[itemId]
    if isSoul == nil then
        local luaItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        if luaItemTbl ~= nil then
            isSoul = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsSoulEquip(luaItemTbl)
        else
            isSoul = false
        end
        self.mItemIdToIsSoul[itemId] = isSoul
    end
    return isSoul
end

---格子显示置灰
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_AgainRefine:RefreshSmeltGridState(bagGrid, bagItemInfo, itemTbl)
    local canSmelt = self:GetBagItemInfoIsSoul(bagItemInfo.itemId)
    if canSmelt == false then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

--endregion

return UIBagMain_AgainRefine