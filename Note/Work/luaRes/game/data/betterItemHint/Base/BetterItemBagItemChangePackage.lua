---@class BetterItemBagItemChangePackage:luaobject 更好物品数据变动包
local BetterItemBagItemChangePackage = {}

--region 数据
---@type table 服务器源数据
BetterItemBagItemChangePackage.serverTblData = nil
---@type table<bagV2.BagItemInfo> 增加的物品数据表
BetterItemBagItemChangePackage.AddBagItemInfoTable = nil
---@type table<bagV2.BagItemInfo> 移除的物品数据表
BetterItemBagItemChangePackage.RemoveBagItemInfoTable = nil
---@type LuaEnumBetterItemHintReason 触发推送提示原因
BetterItemBagItemChangePackage.TriggerHintItemType = nil
---@type LuaEnumBetterItemDataSource 更好物品数据来源
BetterItemBagItemChangePackage.DataSource = nil
---@type boolean 数据解析状态
BetterItemBagItemChangePackage.AnalysisState = nil
---@type number 刷新时间
BetterItemBagItemChangePackage.RefreshTime = nil
--endregion

--region 数据解析
---解析返回请求背包数据
---@param tblData bagV2.ResBagInfo lua table类型消息数据
function BetterItemBagItemChangePackage:AnalysisBagInfoMessage(tblData)
    self.serverTblData = tblData
    self.TriggerHintItemType = LuaEnumBetterItemHintReason.BagDataChange
    self.LuaEnumBetterItemDataSource = LuaEnumBetterItemDataSource.Bag
    if tblData == nil then
        self.AnalysisState = false
        return
    end
    self.AddBagItemInfoTable = tblData.itemList
    self.AnalysisState = true
    self:BagItemInfoListAddItemTABLE(self.AddBagItemInfoTable)
end

---解析背包变化消息包
---@param tblData bagV2.ResBagChange lua table类型消息数据
function BetterItemBagItemChangePackage:AnalysisBagItemChange(tblData)
    self.serverTblData = tblData
    self.TriggerHintItemType = LuaEnumBetterItemHintReason.BagItemRefresh
    self.LuaEnumBetterItemDataSource = LuaEnumBetterItemDataSource.Bag
    if tblData == nil then
        self.AnalysisState = false
    end
    self.AddBagItemInfoTable = tblData.itemList
    self.RemoveBagItemInfoTable = tblData.removeItemList
    self.RefreshTime = CS.CSScene.MainPlayerInfo.serverTime + 100
    self.AnalysisState = true
    self:BagItemInfoListAddItemTABLE(self.AddBagItemInfoTable)
    self:BagItemInfoListAddItemTABLE(self.RemoveBagItemInfoTable)
end
--endregion

--region 查询
---查询当前是否可以刷新包数据
---@return boolean 是否可以刷新包
function BetterItemBagItemChangePackage:CheckCanRefreshPackage()
    if self.AnalysisState == nil or self.AnalysisState == false then
        return false
    end
    if self.RefreshTime ~= nil and type(self.RefreshTime) == 'number' and self.RefreshTime > 0 then
        return CS.CSScene.MainPlayerInfo.serverTime - self.RefreshTime > 0
    end
    return true
end

---查询当前包是否可以推送提示
---@return boolean 是否可以刷新推送
function BetterItemBagItemChangePackage:CheckCanPushHint()
    if self.TriggerHintItemType == LuaEnumBetterItemHintReason.BagItemRefresh and self.serverTblData ~= nil and self.serverTblData.action ~= nil then
        return CS.Cfg_GlobalTableManager.Instance:IsItemHint_BagItemChangeAction(self.serverTblData.action)
    end
    return false
end
--endregion

--region 数据处理
---背包物品列表数据中的BagItemInfo中添加ItemTABLE
---@param bagItemInfoList table<bagV2.BagItemInfo>
function BetterItemBagItemChangePackage:BagItemInfoListAddItemTABLE(bagItemInfoList)
    if bagItemInfoList == nil or type(bagItemInfoList) ~= 'table' or Utility.GetLuaTableCount(bagItemInfoList) <= 0 then
        return
    end
    for k,v in pairs(bagItemInfoList) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        if bagItemInfo ~= nil then
            if Utility.GetItemTblByBagItemInfo ~= nil then
                bagItemInfo.ItemTABLE = Utility.GetItemTblByBagItemInfo(bagItemInfo)
            else
                local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
                bagItemInfo.ItemTABLE = itemInfo
            end
        end
    end
end
--endregion

return BetterItemBagItemChangePackage