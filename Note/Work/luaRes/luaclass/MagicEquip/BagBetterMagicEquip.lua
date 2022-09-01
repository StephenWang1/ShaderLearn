---@class BagBetterMagicEquip 背包中更好法宝装备管理
local BagBetterMagicEquip = {}

--region 数据
---@type table<number,bagV2.BagItemInfo> 背包中更好法宝物品列表
BagBetterMagicEquip.BetterMagicEquipTable = nil
--endregion

--region 刷新
---刷新所有背包中好的法宝
function BagBetterMagicEquip:RefreshBagBetterMagicEquip()
    self.BetterMagicEquipTable = {}
    local bagItemInfoList = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetAllBagItemData()
    if bagItemInfoList ~= nil and type(bagItemInfoList) == 'table' then
        for k,v in pairs(bagItemInfoList) do
            self:CheckAndAddItem(v,1)
        end
    end
    luaEventManager.DoCallback(LuaCEvent.RefreshAllMagicEquip)
    self:CallRedPoint()
end

---尝试添加物品列表
---@param addItemTable table<bagV2.BagItemInfo>
function BagBetterMagicEquip:TryAddItems(addItemTable)
    if self.addListUpdate ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.addListUpdate)
        self.addListUpdate = nil
    end
    self.addListUpdate = CS.CSListUpdateMgr.Add(200, nil, function()
        if addItemTable ~= nil and type(addItemTable) == 'table' and Utility.GetTableCount(addItemTable) > 0 then
            for k,v in pairs(addItemTable) do
                self:CheckAndAddItem(v,1)
            end
        end
    end)
end

---尝试移除的物品列表
---@param removeItemTable table<bagV2.BagItemInfo>
function BagBetterMagicEquip:TryRemoveItems(removeItemTable)
    if self.removeListUpdate ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.removeListUpdate)
        self.removeListUpdate = nil
    end
    self.removeListUpdate = CS.CSListUpdateMgr.Add(200, nil, function()
        if removeItemTable ~= nil and type(removeItemTable) == 'table' and Utility.GetTableCount(removeItemTable) > 0 then
            for k,v in pairs(removeItemTable) do
                self:CheckAndAddItem(v,2)
            end
        end
    end)
end

---尝试添加或者移除物品
---@param bagItemInfo bagV2.BagItemInfo
---@param action number 1:添加 2:移除
function BagBetterMagicEquip:CheckAndAddItem(bagItemInfo,action)
    if action == 1 then
        if bagItemInfo ~= nil and clientTableManager.cfg_itemsManager:IsMagicEquip(bagItemInfo.itemId)
                and gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckMagicEquipBetterThanBody(bagItemInfo) then
            local equipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(bagItemInfo.itemId)
            local cacheBagItemInfo = self.BetterMagicEquipTable[equipIndex]
            local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
            local cacheItemInfo = nil
            if cacheBagItemInfo ~= nil then
                cacheItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(cacheBagItemInfo.itemId)
            end
            if clientTableManager.cfg_itemsManager:CanUseMagicEquip(bagItemInfo.itemId) == LuaEnumUseItemParam.CanUse and (cacheBagItemInfo == nil or clientTableManager.cfg_itemsManager:CompareMagicEquip(itemInfo,cacheItemInfo) == 1) then
                self.BetterMagicEquipTable[equipIndex] = bagItemInfo
                luaEventManager.DoCallback(LuaCEvent.BagMagicEquipItemChange, { equipIndex = equipIndex })
                self:CallRedPoint()
            end
        end
    elseif action == 2 then
        local equipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(bagItemInfo.itemId)
        local cacheBagItemInfo = self.BetterMagicEquipTable[equipIndex]
        if cacheBagItemInfo ~= nil and bagItemInfo ~= nil and cacheBagItemInfo.lid == bagItemInfo.lid then
            self.BetterMagicEquipTable[equipIndex] = nil
            luaEventManager.DoCallback(LuaCEvent.BagMagicEquipItemChange, { equipIndex = equipIndex })
            self:CallRedPoint()
        end
    end
end


---数据清理
function BagBetterMagicEquip:ClearParams()
    self.BetterMagicEquipTable = {}
end

function BagBetterMagicEquip:CallRedPoint()
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_All)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_XL)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_Power)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_Soul)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_SX)
end
--endregion

--region 获取
---通过装备位获取背包中更好的法宝
---@param equipIndex number 装备位
---@return bagV2.BagItemInfo 更好的法宝/nil
function BagBetterMagicEquip:GetBagBetterMagicEquip(equipIndex)
    if equipIndex == nil then
        return
    end
    if self.BetterMagicEquipTable == nil then
        self.BetterMagicEquipTable = {}
    end
    return self.BetterMagicEquipTable[equipIndex]
end
--endregion

--region 查询
---查询物品列表中是否有法宝
---@param itemList table<bagV2.BagItemInfo>
---@return boolean 物品列表中是否有法宝
function BagBetterMagicEquip:CheckItemListHaveMagicEquip(itemList)
    if itemList == nil or type(itemList) ~= 'table' then
        return
    end
    for k,v in pairs(itemList) do
        if v ~= nil and clientTableManager.cfg_itemsManager:IsMagicEquip(v.itemId) then
            return true
        end
    end
    return false
end
--endregion

---游戏场景退回到登录/选角界面时触发
function BagBetterMagicEquip:OnExitDestroy()
    self:ClearParams()
end
return BagBetterMagicEquip