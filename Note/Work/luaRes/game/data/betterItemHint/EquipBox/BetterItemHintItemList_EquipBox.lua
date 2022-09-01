---@class BttterItemHintItemList_EquipBox:BetterItemHintItemList_Base 装备宝箱推送物品列表
local BetterItemHintItemList_EquipBox = {}

setmetatable(BetterItemHintItemList_EquipBox, luaclass.BetterItemHintItemList_Base)

---获取宝箱数据配置表
function BetterItemHintItemList_EquipBox:GetSpecialBoxTableInfoList()
    if self.mSpecialBoxTableInfoList == nil then
        self.mSpecialBoxTableInfoList = CS.Cfg_GlobalTableManager.CfgInstance.SpecialBoxTableInfoList
    end
    return self.mSpecialBoxTableInfoList
end

--region 查询

---是否需要刷新推送列表
function BetterItemHintItemList_EquipBox:IsNeedRefreshBetterListByReason(hintReason)
    return hintReason == LuaEnumBetterItemHintReason.GameStart or
            hintReason == LuaEnumBetterItemHintReason.LevelUp or
            hintReason == LuaEnumBetterItemHintReason.ServantLevelUp
end

---是否是需要刷新的物品
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_EquipBox:NeedRefreshItem(bagItemInfo)
    return bagItemInfo ~= nil and bagItemInfo.ItemTABLE ~= nil and
            CS.Cfg_GlobalTableManager.Instance:GetSpecialBoxTableInfoByBoxItemId(bagItemInfo.ItemTABLE.id)
end

---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_EquipBox:GetItemType()
    return LuaEnumMainHint_BetterBagItemType.EquipBox
end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_EquipBox:IsHintItem(bagItemInfo, hintReason)
    if bagItemInfo.ItemTABLE ~= nil then
        local boxId = bagItemInfo.ItemTABLE.id
        ---判断宝箱限制是否足够使用
        if clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(boxId) == LuaEnumUseItemParam.CanUse then
            ---@type CS.Cfg_GlobalTableManager.SpecialBoxTableInfo
            local boxInfo = CS.Cfg_GlobalTableManager.Instance:GetSpecialBoxTableInfoByBoxItemId(boxId)
            local useNum = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemDayUseCount(boxInfo.KeyItemId)
            ---判断使用次数
            if boxInfo.BoxTotalUseNum == 0 or (useNum ~= nil and useNum < boxInfo.BoxTotalUseNum) then
                local keyCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(boxInfo.KeyItemId)
                local canUseKey = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(boxInfo.KeyItemId) == LuaEnumUseItemParam.CanUse
                ---判断对应的钥匙数量足够且钥匙能够使用
                return keyCount > 0 and canUseKey
            end
        end
    end
    return false
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_EquipBox:NewHintItemClass(bagItemInfo)
    local betterEquipBoxClass = luaclass.BetterItemHintItem_EquipBox:New()
    betterEquipBoxClass:RefreshData(bagItemInfo)
    return betterEquipBoxClass
end

--endregion

--region 支持重写
---更好物品列表中是否有同样类型的道具
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean,BetterItemHintItem_Base 缓存中是否包含，同类型物品
function BetterItemHintItemList_EquipBox:BetterItemListHaveSameTypeItem(bagItemInfo)
    return false
end
--endregion

return BetterItemHintItemList_EquipBox