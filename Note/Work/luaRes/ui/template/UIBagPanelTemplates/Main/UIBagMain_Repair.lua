---维修背包模板
---@class UIBagMain_Repair:UIBagMain_Normal
local UIBagMain_Repair = {}

setmetatable(UIBagMain_Repair, luaComponentTemplates.UIBagMainNormal)

--region 数据
---背包道具lid对应选中状态
UIBagMain_Repair.mLidToItemChooseState = {}

--endregion

--region 初始化

function UIBagMain_Repair:OnInit()
    self:RunBaseFunction("OnInit")
    self:ResetItemChooseState()
end

function UIBagMain_Repair:OnEnable()
    self:RunBaseFunction("OnEnable")

    ---刷新整个面板选中
    self.RepairGetRefreshChooseList = function(msgId, type)
        if type == luaEnumRepairType.Bag then
            self:SendNewChooseList()
        end
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairGetRefreshChooseList, self.RepairGetRefreshChooseList)

    ---维修面板点击某格子
    self.OnRepairChooseListChange = function(msgId, lid)
        self:OnRepairListChange(lid)
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairChooseBagGridChange, self.OnRepairChooseListChange)
end

function UIBagMain_Repair:OnDisable()
    self:RunBaseFunction("OnDisable")
    self:RemoveEvent()
end

function UIBagMain_Repair:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    self:RemoveEvent()
end

function UIBagMain_Repair:RemoveEvent()
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.RepairGetRefreshChooseList, self.RepairGetRefreshChooseList)
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.RepairChooseBagGridChange, self.OnRepairChooseListChange)
end

--endregion

--region 重写属性
---是否使用服务器排序
function UIBagMain_Repair:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_Repair:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
function UIBagMain_Repair:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Repair:IsShowRecycleButton()
    return false
end

---是否可以双击
function UIBagMain_Repair:IsItemDoubleClickedAvailable()
    return false
end
--endregion

--region 重写方法
---对维修装备排序
function UIBagMain_Repair:BagItemListSortFunction(leftItem, rightItem)
    if not self:IsItemLastingFull(leftItem) and self:IsItemLastingFull(rightItem) then
        return true
    end
    return false
end

---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Repair:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    ---刷新格子状态
    self:RefreshRepairGridState(bagGrid, bagItemInfo, itemTbl)
    self:RefreshEquipDurabilityIsLess(bagGrid, bagItemInfo, itemTbl)
    self:SetItemChooseState(bagGrid, self.mLidToItemChooseState[bagItemInfo.lid])
end

---维修格子显示置灰
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Repair:RefreshRepairGridState(bagGrid, bagItemInfo, itemTbl)
    if self.mLidToItemChooseState and self.mLidToItemChooseState[bagItemInfo.lid] then
        local type = self.mLidToItemChooseState[bagItemInfo.lid]
        if type ~= LuaEnumRepairGridState.Gray then
            bagGrid:SetCompActive(bagGrid.Components.Check1, true)
        end
        local isShowShadow = type == LuaEnumRepairGridState.Gray
        if isShowShadow then
            self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
        end
    end
end

---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Repair:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if self.mLidToItemChooseState[bagItemInfo.lid] == LuaEnumRepairGridState.UnChoose then
        self.mLidToItemChooseState[bagItemInfo.lid] = LuaEnumRepairGridState.Choose
    elseif self.mLidToItemChooseState[bagItemInfo.lid] == LuaEnumRepairGridState.Choose then
        self.mLidToItemChooseState[bagItemInfo.lid] = LuaEnumRepairGridState.UnChoose
    end
    self:SetItemChooseState(bagGrid, self.mLidToItemChooseState[bagItemInfo.lid])
    if self.mLidToItemChooseState[bagItemInfo.lid] ~= LuaEnumRepairGridState.Gray then
        self:SendChooseListChangeMessage()
    end
end

---背包数据改变时候重新刷新数据
function UIBagMain_Repair:RefreshGrids()
    self:ResetItemChooseState()
    self:RunBaseFunction("RefreshGrids")
end
--endregion

--region 客户端消息

---重置格子选中状态
function UIBagMain_Repair:ResetItemChooseState()
    self.mLidToItemChooseState = {}
    self.bagItemList = self:GetBagItemList()
    for k, v in pairs(self.bagItemList) do
        ---屏蔽耐久度为-99999的装备
        if self:IsItemLastingFull(v) or (v.currentLasting ~= nil and v.currentLasting == -99999) then
            self.mLidToItemChooseState[v.lid] = LuaEnumRepairGridState.Gray
        else
            self.mLidToItemChooseState[v.lid] = LuaEnumRepairGridState.Choose
        end
    end
    self:SendChooseListChangeMessage()
end

---满足置灰条件（是本职业且耐久度未满）人物
---@param bagIemInfo bagV2.BagItemInfo
---@return boolean true是不需要维修 false是需要维修
function UIBagMain_Repair:IsItemLastingFull(bagIemInfo)
    if bagIemInfo then
        local itemInfo = bagIemInfo.ItemTABLE
        local career = CS.CSScene.MainPlayerInfo.Career
        ---维修有花费货币
        local costRepairNil = itemInfo.repairCost and itemInfo.repairCost.list and itemInfo.repairCost.list[0].list
        ---耐久度未满需要维修
        local lastingFull = bagIemInfo.currentLasting < bagIemInfo.ItemTABLE.maxLasting
        ---本职业可维修
        local Career = itemInfo.type == luaEnumItemType.Equip and (CS.ECareer.__CastFrom(itemInfo.career) == career or itemInfo.career == LuaEnumCareer.Common)
        if lastingFull and Career and costRepairNil then
            -- 耐久未满 --需要花钱 -- 本职业  --返回需要维修
            return false
        end
    end
    return true
end

---发送当前选中列表
function UIBagMain_Repair:SendChooseListChangeMessage()
    local repairList = nil
    if self.mLidToItemChooseState and self.bagItemList then
        repairList = {}
        for k, v in pairs(self.bagItemList) do
            if self.mLidToItemChooseState[v.lid] == LuaEnumRepairGridState.Choose then
                table.insert(repairList, v)
            end
        end
    end
    if repairList then
        luaEventManager.DoCallback(LuaCEvent.RepairChooseListChange, repairList)
    end
end

---维修取消某道具选中
function UIBagMain_Repair:OnRepairListChange(lid)
    local type = LuaEnumRepairGridState.UnChoose
    local bagPanel = self:GetBagPanel()
    ---@type UIBagGrid
    local grid = bagPanel:GetBagGrid(lid)
    if grid then
        self:SetItemChooseState(grid, type)
    end
    self.mLidToItemChooseState[lid] = type
    self:SendChooseListChangeMessage()
end
--endregion

---设置道具选中状态
---@param grid UIBagGrid 背包格子
---@param type number 类型
function UIBagMain_Repair:SetItemChooseState(grid, type)
    if type ~= LuaEnumRepairGridState.Gray then
        grid:SetCompSpriteName(grid.Components.Check1, ternary(type == LuaEnumRepairGridState.Choose, "check", "btnsssssdsfsdfsfwefwfewgsfer"))
    end
end

function UIBagMain_Repair:SendNewChooseList()
    self:ResetItemChooseState()
end

return UIBagMain_Repair