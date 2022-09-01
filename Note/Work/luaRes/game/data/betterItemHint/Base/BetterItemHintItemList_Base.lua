---@class BetterItemHintItemList_Base:luaobject 更好物品提示物品列表基类
local BetterItemHintItemList_Base = {}

--region 数据
---@type table<BetterItemHintItem_Base> 更好的物品信息表
BetterItemHintItemList_Base.BetterItemList = nil
---@type LuaEnumMainHint_BetterBagItemType
BetterItemHintItemList_Base.ItemType = nil
---@type BetterItemBagItemChangePackage 推送包
BetterItemHintItemList_Base.hintPackage = nil
---@type bagV2.BagItemInfo 新获取到的物品
BetterItemHintItemList_Base.newItem = nil
---@type table<number,bagV2.BagItemInfo> 指定物品背包物品筛选表
BetterItemHintItemList_Base.AssignItemBagItemTable = nil
---@type AssignItemBagItemChangeData 指定物品是否再背包中有变动
---@alias AssignItemBagItemChangeData{addBagItemInfoList table<bagV2.BagItemInfo>,removeItemInfoList table<bagV2.BagItemInfo>}
BetterItemHintItemList_Base.AssignItemBagItemChangeDataTable = nil
---@type boolean 更好物品列表是否有数据变动
BetterItemHintItemList_Base.betterItemHaveDataChange = nil
--endregion

--region 初始化
function BetterItemHintItemList_Base:Init()
    self.ItemType = self:GetItemType()
end
--endregion

--region 刷新
---刷新更好物品列表
---@param hintPackage BetterItemBagItemChangePackage 推送包
function BetterItemHintItemList_Base:RefreshItemList(hintPackage)
    if self.isInit ~= true then
        self:Init()
        self.isInit = true
    end
    if self.BetterItemList == nil then
        self.BetterItemList = {}
    end
    self.hintPackage = hintPackage
    self.newItem = nil
    self.AssignItemBagItemChangeDataTable = {}
    self.betterItemHaveDataChange = false
    self:StatisticsAssignItem(hintPackage)
    self:BagDataChange(hintPackage)
    if hintPackage ~= nil or hintPackage.AnalysisState == true and self:AssignItemBagItemDataHaveChange() == true then
        self:RefreshBetterItemList(hintPackage.TriggerHintItemType)
    end
end

---统计指定物品（相当于将背包中自己类型的东西进行缓存）
---@param hintPackage BetterItemBagItemChangePackage 推送包
function BetterItemHintItemList_Base:StatisticsAssignItem(hintPackage)
    if self.AssignItemBagItemTable == nil then
        self.AssignItemBagItemTable = {}
    end
    if hintPackage.AddBagItemInfoTable ~= nil and type(hintPackage.AddBagItemInfoTable) == 'table' and Utility.GetLuaTableCount(hintPackage.AddBagItemInfoTable) > 0 then
        for k, v in pairs(hintPackage.AddBagItemInfoTable) do
            ---@type bagV2.BagItemInfo
            local addBagItemInfo = v
            if self:NeedRefreshItem(addBagItemInfo) then
                self.AssignItemBagItemTable[addBagItemInfo.lid] = addBagItemInfo
                if self.AssignItemBagItemChangeDataTable.addBagItemInfoList == nil then
                    self.AssignItemBagItemChangeDataTable.addBagItemInfoList = {}
                end
                self.AssignItemBagItemChangeDataTable.addBagItemInfoList[addBagItemInfo.lid] = addBagItemInfo
                self.newItem = addBagItemInfo
            end
        end
    end
    if hintPackage.RemoveBagItemInfoTable ~= nil and type(hintPackage.RemoveBagItemInfoTable) == 'table' and Utility.GetLuaTableCount(hintPackage.RemoveBagItemInfoTable) > 0 then
        for k, v in pairs(hintPackage.RemoveBagItemInfoTable) do
            ---@type bagV2.BagItemInfo
            local removeBagItemInfo = v
            if removeBagItemInfo ~= nil and self:NeedRefreshItem(removeBagItemInfo) and self.AssignItemBagItemTable[removeBagItemInfo.lid] ~= nil then
                self.AssignItemBagItemTable[removeBagItemInfo.lid] = nil
                if self.AssignItemBagItemChangeDataTable.removeItemInfoList == nil then
                    self.AssignItemBagItemChangeDataTable.removeItemInfoList = {}
                end
                self.AssignItemBagItemChangeDataTable.removeItemInfoList[removeBagItemInfo.lid] = removeBagItemInfo
            end
        end
    end
end

---背包整体变动刷新(只处理了清空背包的情况)
---@param hintPackage BetterItemBagItemChangePackage 推送包
function BetterItemHintItemList_Base:BagDataChange(hintPackage)
    if hintPackage ~= nil and hintPackage.TriggerHintItemType == LuaEnumBetterItemHintReason.BagDataChange and (hintPackage.AddBagItemInfoTable == nil or Utility.GetTableCount(hintPackage.AddBagItemInfoTable) <= 0) then
        self.AssignItemBagItemChangeDataTable = {}
        self.betterItemHaveDataChange = true
        self.newItem = nil
        self.BetterItemList = {}
        self.AssignItemBagItemTable = {}
    end
end

---条件式刷新当前推送列表
---@param hintReason LuaEnumBetterItemHintReason
function BetterItemHintItemList_Base:RefreshBetterItemListByReason(hintReason)
    if self:IsNeedRefreshBetterListByReason(hintReason) then
        self:RefreshBetterItemList(hintReason)
    end
end

---刷新推送对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
function BetterItemHintItemList_Base:RefreshBetterItemList(hintReason)
    if self.AssignItemBagItemTable ~= nil and type(self.AssignItemBagItemTable) == 'table' and Utility.GetTableCount(self.AssignItemBagItemTable) > 0 then
        self.BetterItemList = {}
        ---@type boolean 更好物品是否有变化
        self.betterItemHaveDataChange = true
        ---刷新更好物品列表
        for k,v in pairs(self.AssignItemBagItemTable) do
            ---@type bagV2.BagItemInfo
            local singleItem = v
            if singleItem ~= nil then
                local isHintItem = self:IsHintItem(singleItem,hintReason)
                if isHintItem == true then
                    ---是否是推荐的物品（通常相对于主角进行判断）
                    local betterSingleItemClass = self:NewHintItemClass(singleItem)
                    if betterSingleItemClass ~= nil then
                        ---更好物品缓存列表中是否包含同类型物品
                        local betterListHaveSameTypeItem,betterListCacheItem = self:BetterItemListHaveSameTypeItem(betterSingleItemClass.BagItemInfo)
                        if betterListHaveSameTypeItem == true and betterListCacheItem ~= nil then
                            if betterListCacheItem:InputItemBetterSelf(betterSingleItemClass.BagItemInfo,self.newItem) == true then
                                ---同类型且比缓存中的物品好，则替换刷新
                                betterListCacheItem:RefreshData(betterSingleItemClass.BagItemInfo)
                            end
                        else
                            table.insert(self.BetterItemList,betterSingleItemClass)
                        end
                    end
                end
            end
        end
    end
    ---新获取的物品置前
    local needFrontNewItem,lid = self:NeedBringFrontNewItem()
    if needFrontNewItem then
        if type(lid) == 'number' then
            self:BringInFrontItemByLid(lid)
        else
            self:BringInFrontNewItem()
        end
    end
end
--endregion

--region 查询
---是否是推送的物品
---@param lid number 物品唯一ID
---@return boolean
function BetterItemHintItemList_Base:IsContainItem(lid)
    if self.BetterItemList ~= nil and type(self.BetterItemList) == 'table' then
        for k, v in pairs(self.BetterItemList) do
            ---@type BetterItemHintItem_Base
            local BetterItem = v
            if BetterItem ~= nil and BetterItem.BagItemInfo ~= nil and BetterItem.BagItemInfo.lid == lid then
                return true
            end
        end
        return false
    end
end

---是否有更好物品
---@return boolean 是否有更好的物品
function BetterItemHintItemList_Base:HaveBetterItem()
    if self.BetterItemList ~= nil and type(self.BetterItemList) == 'table' and Utility.GetLuaTableCount(self.BetterItemList) > 0 then
        return true
    end
    return false
end

---指定物品的背包物品列表是否有变动
---@return boolean 是否有数据变动
function BetterItemHintItemList_Base:AssignItemBagItemDataHaveChange()
    if self.AssignItemBagItemChangeDataTable == nil or (type(self.AssignItemBagItemChangeDataTable.addBagItemInfoList) ~= 'table' and type(self.AssignItemBagItemChangeDataTable.removeItemInfoList) ~= 'table') then
        return false
    end
    return Utility.GetLuaTableCount(self.AssignItemBagItemChangeDataTable.addBagItemInfoList) > 0 or Utility.GetLuaTableCount(self.AssignItemBagItemChangeDataTable.removeItemInfoList) > 0
end

---更好物品列表中是否有同样类型的道具
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean,BetterItemHintItem_Base 缓存中是否包含，同类型物品
function BetterItemHintItemList_Base:BetterItemListHaveSameTypeItem(bagItemInfo)
    if bagItemInfo == nil or type(self.BetterItemList) ~= 'table' or Utility.GetLuaTableCount(self.BetterItemList) <= 0 then
        return false
    end
    for k,v in pairs(self.BetterItemList) do
        ---@type BetterItemHintItem_Base
        local betterItemData = v
        if betterItemData:IsSameTypeItem(bagItemInfo) == true then
            return true,betterItemData
        end
    end
    return false
end
--endregion

--region 获取
---获取列表中第一个物品类
---@return BetterItemHintItem_Base 物品类
function BetterItemHintItemList_Base:GetFirstItemClass()
    if self.BetterItemList ~= nil and type(self.BetterItemList) == 'table' and Utility.GetLuaTableCount(self.BetterItemList) > 0 then
        return self.BetterItemList[1]
    end
end

---通过来源获取物品类
---@param hintReason LuaEnumBetterItemHintReason
---@return BetterItemHintItem_Base 物品类
function BetterItemHintItemList_Base:GetItemClassByReason(hintReason)

end

---获取更好物品列表
---@return table<bagV2.BagItemInfo> 更好物品列表类
function BetterItemHintItemList_Base:GetBagItemInfoList()
    if self.BetterItemList ~= nil and type(self.BetterItemList) == 'table' then
        local bagItemInfoTable = {}
        for k, v in pairs(self.BetterItemList) do
            ---@type BetterItemHintItem_Base
            local betterItemClass = v
            if betterItemClass ~= nil and betterItemClass.BagItemInfo ~= nil then
                table.insert(bagItemInfoTable, betterItemClass.BagItemInfo)
            end
        end
        return bagItemInfoTable
    end
end

---获取更好物品Lid列表
---@return table<number> 更好物品列表类
function BetterItemHintItemList_Base:GetBagItemInfoLidList()
    local bagItemInfoList = self:GetBagItemInfoList()
    local bagItemInfoLidList = {}
    if type(bagItemInfoList) ~= 'table' or Utility.GetLuaTableCount(bagItemInfoList) <= 0 then
        return bagItemInfoLidList
    end
    for k,v in pairs(bagItemInfoList) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        if bagItemInfo ~= nil then
            table.insert(bagItemInfoLidList,bagItemInfo.lid)
        end
    end
    return bagItemInfoLidList
end
--endregion

--region 设置
---更好物品列表移除指定的物品
---@param bagItemInfo bagV2.BagItemInfo
function BetterItemHintItemList_Base:BetterListRemoveCurItem(bagItemInfo)
    Utility.GetAndRemoveTableValue(self.BetterItemList,bagItemInfo)
end
--endregion

--region 必须重写
---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_Base:GetItemType()

end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_Base:IsHintItem(bagItemInfo,hintReason)
    return false
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_Base:NewHintItemClass(bagItemInfo)

end

---是否是需要刷新的物品
---@protected
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_Base:NeedRefreshItem(bagItemInfo)
    return false
end

---是否需要刷新对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_Base:IsNeedRefreshBetterListByReason(hintReason)
    return false
end
--endregion

--region 支持重写
---是否需要置前新物品(第二个参数表示指定lid的物品置前)（只会在刷新更好物品列表结束后调用）
---@return boolean,number
function BetterItemHintItemList_Base:NeedBringFrontNewItem()
    return true
end

---获取需要提示的物品
---@return BetterItemHintItem_Base
function BetterItemHintItemList_Base:GetNeedHintItem()
    return self:GetFirstItemClass()
end

---更好物品列表是否有数据变动
---@return boolean 是否有数据变动
function BetterItemHintItemList_Base:BetterItemHaveDataChange()
    return self.betterItemHaveDataChange == true
end

---通过触发来源判断当前是否可以推送道具
---@param hintReason LuaEnumBetterItemHintReason 提示推送来源
---@return boolean 是否可以推送
function BetterItemHintItemList_Base:CanPushHintByReason(hintReason)
    if hintReason == nil then
        return false
    end
    return true
end
--endregion

--region 排序
---将新物品置前
function BetterItemHintItemList_Base:BringInFrontNewItem()
    if self.newItem ~= nil and self.newItem.lid ~= nil and Utility.GetTableCount(self.BetterItemList) > 0 then
        self:BringInFrontItemByLid(self.newItem.lid)
    end
end

---指定物品置前
---@param lid number 背包唯一id
---@return boolean 是否置前
function BetterItemHintItemList_Base:BringInFrontItemByLid(lid)
    if lid == nil or type(lid) ~= 'number' then
        return false
    end
    local changeIndex = 1
    for k, v in pairs(self.BetterItemList) do
        if v ~= nil and v.BagItemInfo ~= nil and v.BagItemInfo.lid == lid then
            changeIndex = k
            break
        end
    end
    if changeIndex == 1 then
        return false
    end
    local firstItemClass = self.BetterItemList[1]
    self.BetterItemList[1] = self.BetterItemList[changeIndex]
    self.BetterItemList[changeIndex] = firstItemClass
    return true
end
--endregion

return BetterItemHintItemList_Base