---@class UIBagMain_Strengthen:UIBagMain_Normal
local UIBagMain_Strengthen = {}

setmetatable(UIBagMain_Strengthen, luaComponentTemplates.UIBagMainNormal)

---当前选中格子id
UIBagMain_Strengthen.mCurrentChooseItemId = nil
---当前选中格子
UIBagMain_Strengthen.mCurrentChooseGrid = nil

--region 属性
---获取当前灵兽强化是否开启
function UIBagMain_Strengthen:IsServantStrengthOpen()
    if self.mServantStrengthenOpen == nil then
        self.mServantStrengthenOpen = self:GetServantInfoV2():IsOpenServantStrength()
    end
    return self.mServantStrengthenOpen
end

---获取背包信息
function UIBagMain_Strengthen:GetBagInfoV2()
    if self.mBagInfoV2 == nil then
        self.mBagInfoV2 = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfoV2
end

---获取灵兽信息
function UIBagMain_Strengthen:GetServantInfoV2()
    if self.mServantInfoV2 == nil then
        self.mServantInfoV2 = CS.CSScene.MainPlayerInfo.ServantInfoV2
    end
    return self.mServantInfoV2
end
--endregion

--region重写初始化方法
function UIBagMain_Strengthen:OnInit()
    self:RunBaseFunction("OnInit")
    ---锻造道具改变事件
    ---@type function
    self.OnStrengthenBagItemChange = function(msgId, bagItemInfo)
        self:OnStrengthenBagItemChangeFun(msgId, bagItemInfo)
    end
    ---背包关闭事件
    ---@type function
    self.OnBagClose = function()
        self:OnBagCloseFun()
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.StrengthenBagItemChange, self.OnStrengthenBagItemChange)
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end

function UIBagMain_Strengthen:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    self:OnBagCloseFun()
end

--endregion

--region 消息监听
---锻造道具改变
---@param bagItemInfo bagV2.BagItemInfo 改变道具信息
function UIBagMain_Strengthen:OnStrengthenBagItemChangeFun(msgId, bagItemInfo)
    local lid = bagItemInfo.lid
    if lid and lid ~= self.mCurrentChooseItemId then
        local grid = self:FindItemByLidAndSetChoose(lid, true)
        if self.mCurrentChooseGrid then
            self.mCurrentChooseGrid:SetCompActive(self.mCurrentChooseGrid.Components.ChosenEffect, false)
        elseif self.mCurrentChooseItemId then
            self:FindItemByLidAndSetChoose(self.mCurrentChooseItemId, false)
        end
        self.mCurrentChooseItemId = lid
        self.mCurrentChooseGrid = grid
    end
end

---背包关闭消息
function UIBagMain_Strengthen:OnBagCloseFun()
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.StrengthenBagItemChange, self.OnStrengthenBagItemChange)
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_BagPanelIsClose, self.OnBagClose)
end
--endregion

--region重写属性
---是否使用服务器排序
function UIBagMain_Strengthen:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_Strengthen:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
function UIBagMain_Strengthen:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Strengthen:IsShowRecycleButton()
    return false
end

function UIBagMain_Strengthen:IsItemDoubleClickedAvailable()
    return false
end
--endregion

--region重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Strengthen:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagGrid and bagItemInfo and itemTbl then
        local canStrength = CS.CSScene.MainPlayerInfo.BagInfo:CanItemStrength(bagItemInfo)
        if canStrength then
            if bagItemInfo.lid ~= self.mCurrentChooseItemId then
                luaEventManager.DoCallback(LuaCEvent.Bag_GridSingleClicked, bagItemInfo)
            end
        else
            CS.Utility.ShowTips("此部位无法升星", 1)
        end
    end
end

---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Strengthen:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    self:SetItemChoose(bagGrid, bagItemInfo)
end

---刷新背包格子选中状态
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Strengthen:SetItemChoose(bagGrid, bagItemInfo)
    if bagItemInfo.lid == self.mCurrentChooseItemId then
        bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
    end
end

---根据lid找到背包格子并设置选中
---@return UIBagGrid 找到的格子（没找到返回空）
function UIBagMain_Strengthen:FindItemByLidAndSetChoose(lid, isChoose)
    local bagPanel = self:GetBagPanel()
    local grid = bagPanel:GetBagGrid(lid)
    if grid then
        grid:SetCompActive(grid.Components.ChosenEffect, isChoose)
    end
    return grid
end

---背包物品筛选方法
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Strengthen:BagItemFilterFunction(bagItemInfo, itemInfo)
    if itemInfo.type == luaEnumItemType.Equip then
        if not self:IsServantStrengthOpen() and CS.CSServantInfoV2.IsServantEquip(itemInfo.subType) then
            return false
        end
        return self:GetBagInfoV2():CanItemStrength(bagItemInfo)
    end
    return false
end
--endregion

return UIBagMain_Strengthen