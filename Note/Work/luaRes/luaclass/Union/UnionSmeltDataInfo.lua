local UnionSmeltDataInfo = {}
--region 数据
---@param UnionSmeltWarehouseTable table<number,auctionV2.AuctionItemInfo>
UnionSmeltDataInfo.UnionSmeltWarehouseTable = {}
--endregion

--region 数据刷新
---刷新所有行会熔炼仓库物品
---@param tblData auctionV2.AuctionItemList
function UnionSmeltDataInfo:RefreshUnionSmeltWarehouseTable(tblData)
    if tblData == nil or tblData.isUnionSmelt == false then
        return
    end
    self.UnionSmeltWarehouseTable = {}
    if tblData.isUnionSmelt == true and tblData.items ~= nil and type(tblData.items) == 'table' and #tblData.items > 0 then
        for k,v in pairs(tblData.items) do
            self:ChangeCSBagItemInfo(v)
            self.UnionSmeltWarehouseTable[v.item.lid] = v
        end
    end
    luaEventManager.DoCallback(LuaCEvent.RefreshUnionSmeltWarehouse);
end

---刷新个别熔炼仓库物品
---@param tblData auctionV2.UnionSmeltGoodsChange
function UnionSmeltDataInfo:RefreshSeveralAuctionItem(tblData)
    if tblData == nil or tblData.items == nil or type(tblData.items) ~= 'table' or #tblData.items <= 0 or self.UnionSmeltWarehouseTable == nil or type(self.UnionSmeltWarehouseTable) ~= 'table' or Utility.GetTableCount(self.UnionSmeltWarehouseTable) <= 0 then
        return
    end
    local itemIsChange = false
    if tblData.changeType == LuaEnumUnionSmeltItemChangeType.Add then
        itemIsChange = true
        for k,v in pairs(tblData.items) do
            self:ChangeCSBagItemInfo(v)
            self.UnionSmeltWarehouseTable[v.item.lid] = v
        end
    elseif tblData.changeType == LuaEnumUnionSmeltItemChangeType.Remove then
        itemIsChange = true
        for k,v in pairs(tblData.items) do
            self.UnionSmeltWarehouseTable[v.item.lid] = nil
        end
    end
    luaEventManager.DoCallback(LuaCEvent.RefreshUnionSmeltWarehouse);
end

---检测商品数据是否有ItemTABLE
function UnionSmeltDataInfo:ChangeCSBagItemInfo(auctionItemInfo)
    if auctionItemInfo ~= nil and auctionItemInfo.item ~= nil and auctionItemInfo.item then
        auctionItemInfo.item = protobufMgr.DecodeTable.bag.BagItemInfo(auctionItemInfo.item)
    end
end
--endregion

--region 获取
---获取行会熔炼仓库数据
function UnionSmeltDataInfo:GetUnionSmeltWarehuoseTable()
    return self.UnionSmeltWarehouseTable
end

---获取行会熔炼仓库中的商品
---@param lid number 背包物品唯一id
---@return auctionV2.AuctionItemInfo
function UnionSmeltDataInfo:GetUnionSmeltWareHouseAuctionItem(lid)
    if self.UnionSmeltWarehouseTable ~= nil and type(self.UnionSmeltWarehouseTable) == 'table' then
        for k,v in pairs(self.UnionSmeltWarehouseTable) do
            if k == lid then
                return v
            end
        end
    end
    return nil
end
--endregion

--region 查询
---查询是否有lid对应物品
---@param lid number 背包物品唯一id
---@return boolean
function UnionSmeltDataInfo:HaveUnionSmeltWareHouseAuctionItem(lid)
    return self:GetUnionSmeltWareHouseAuctionItem(lid) ~= nil
end
--endregion

--region 数据清理
---游戏场景退回到登录/选角界面时触发
function UnionSmeltDataInfo:OnExitDestroy()
    self.UnionSmeltWarehouseTable = {}
end
--endregion

return UnionSmeltDataInfo