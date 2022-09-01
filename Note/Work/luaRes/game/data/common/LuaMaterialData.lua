---@class LuaMaterialData Lua内的合成材料相关数据(里面存放着指定材料的所有道具列表以及位置)
local LuaMaterialData = {}

---@type table<LuaItemSavePos, bagV2.BagItemInfo:C的类型> 有些数据目前Lua没有同步,这个时候在这个里面去取
LuaMaterialData.ItemSaveDic = nil

---@type table<LuaItemSavePos, bagV2.BagItemInfo> 这个时候在这个里面去取
LuaMaterialData.LuaItemSaveDic = nil

---@type table<number,number> 货币缓存数据
LuaMaterialData.mCoinsSaveDic = nil;

---@type TABLE.cfg_items lua道具表
LuaMaterialData.ItemTbl = nil

---目标材料ID
LuaMaterialData.TargetItemID = nil
---目标替换道具ID
LuaMaterialData.TargetReplaceItemID = nil

---这个材料的数据位置保存的可能性(背包是通用,就不用额外说明了)
---@class LuaMaterialSavePossibility
---@field IsRoleEquip boolean 是否为人物装备(可以在灵兽装备位/人物装备位上找)
---@field IsServant boolean 是否为灵兽(可以在血继/灵兽位上找)
---@field IsServantEquip boolean 是否为灵兽装备(可以在灵兽装备位/血继上找)
---@field IsImprint boolean 是否为印记(只能在印记里面找)
---@field IsElements boolean 是否为元素上(只能在元素里面找)
---@field IsMagicWeapon boolean 是否为法宝(只能在法宝里面找)
---@field IsCoin boolean 是否为货币

---@type LuaMaterialSavePossibility
LuaMaterialData.MaterialSavePossibility = nil

---@param itemId 生成itemId对应的材料数据
function LuaMaterialData:GenerateData(itemId)
    self.TargetItemID = itemId;

    self.ItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)

    ---这个道具存在替换材料(例如创造宝石,存在绑定与非绑定的区别,但是这个都是创造宝石,可以一起被消耗)
    if (self.ItemTbl ~= nil) then
        self.TargetReplaceItemID = self.ItemTbl:GetLinkItemId()
    end

    self.ItemSaveDic = {}
    self.LuaItemSaveDic = {}
    self.mCoinsSaveDic = {};

    self.MaterialSavePossibility = self:GetMaterialSavePossibility(self.ItemTbl)
end

---得到道具可能存在的位置
---@param itemTbl TABLE.cfg_items
function LuaMaterialData:GetMaterialSavePossibility(itemTbl)
    if (itemTbl == nil) then
        return {}
    end
    ---@type LuaMaterialSavePossibility
    local MaterialSavePossibility = {}

    if (itemTbl:GetType() == luaEnumItemType.Coin) then
        MaterialSavePossibility.IsCoin = true
    end

    ---元素
    if (itemTbl:GetType() == luaEnumItemType.Element) then
        MaterialSavePossibility.IsElements = true
    end

    ---印记
    if (itemTbl:GetType() == luaEnumItemType.Signet) then
        MaterialSavePossibility.IsImprint = true
    end

    ---灵兽
    if (itemTbl:GetType() == luaEnumItemType.Assist and itemTbl:GetSubType() == 8) then
        MaterialSavePossibility.IsServant = true
    end

    ---装备
    if (itemTbl:GetType() == luaEnumItemType.Equip) then
        ---人物法宝
        if (itemTbl:GetSubType() == 160) then
            MaterialSavePossibility.IsMagicWeapon = true
        elseif (itemTbl:GetSubType() == 151 or itemTbl:GetSubType() == 152 or itemTbl:GetSubType() == 153 or itemTbl:GetSubType() == 154) then
            ---灵兽肉身
            MaterialSavePossibility.IsServantEquip = true
        elseif (itemTbl:GetSubType() == 86 or itemTbl:GetSubType() == 96 or itemTbl:GetSubType() == 106) then
            ---灵兽法宝
            MaterialSavePossibility.IsServantEquip = true
        end
        MaterialSavePossibility.IsRoleEquip = self:IsItemSubtypeRoleEquip(itemTbl:GetSubType())
    end
    return MaterialSavePossibility
end

---@return boolean 是否是需要加入计算的角色装备subType
function LuaMaterialData:IsItemSubtypeRoleEquip(subType)
    if self.mSubTypeToValue == nil then
        self.mSubTypeToValue = {}
        local info = LuaGlobalTableDeal.GetIntListJingHaoTypeList(22830)
        if info then
            for i = 1, #info do
                local sub = tonumber(info[i])
                self.mSubTypeToValue[sub] = true
            end
        end
    end
    return self.mSubTypeToValue[subType]
end

---这个道具ID是否为当前这个材料的道具(或者替换道具)
function LuaMaterialData:IsExitMaterial(itemId)
    if (self.TargetItemID == itemId or self.TargetReplaceItemID == itemId) then
        return true
    end
    return false
end

---重置数据.(简易版本)特定道具变动的时候,重置掉数据.再下次获取的时候再重新取拿
function LuaMaterialData:Reset()
    self.ItemSaveDic = {}
    self.LuaItemSaveDic = {}
    self.mCoinsSaveDic = {};
end


--region 进行查询目标道具所在的地方

function LuaMaterialData:FindAndInsertToCoins(itemId)
    if (itemId == nil or itemId == 0) then
        return ;
    end

    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId);
    if (itemTbl ~= nil and itemTbl:GetType() == luaEnumItemType.Coin) then
        table.insert(self.mCoinsSaveDic[LuaItemSavePos.Bag], itemId);
    end
end

---从背包中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调)
---@private
function LuaMaterialData:FindAndInsertToItemsFromBag(itemId)

    if (itemId == nil or itemId == 0) then
        return ;
    end

    ---@type table<lid,bagV2.BagItemInfo> 背包数据 lua的bagV2.BagItemInfo
    local items = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetAllBagItemData()
    if (items == nil) then
        return
    end
    local InsureMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr()
    ---@param bagItemInfo bagV2.BagItemInfo
    for i, bagItemInfo in pairs(items) do
        if bagItemInfo.itemId == itemId and (not InsureMgr:IsInsurance(bagItemInfo)) then
            table.insert(self.LuaItemSaveDic[LuaItemSavePos.Bag], bagItemInfo)
        end
    end
end

---从人物装备中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调)
---@private
function LuaMaterialData:FindAndInsertToItemsFromRoleEquip(itemId)

    if (itemId == nil or itemId == 0 or self.MaterialSavePossibility.IsRoleEquip == nil) then
        return ;
    end

    ---@type table<bagV2.BagItemInfo> lua的bagV2.BagItemInfo
    local items = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetAllEquipmentItemList()

    if (items == nil) then
        return
    end
    local InsureMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr()
    ---@param bagItemInfo bagV2.BagItemInfo
    for i, bagItemInfo in pairs(items) do
        if bagItemInfo.itemId == itemId and (not InsureMgr:IsInsurance(bagItemInfo)) then
            table.insert(self.LuaItemSaveDic[LuaItemSavePos.RoleEquip], bagItemInfo)
        end
    end

end

---从人物镶嵌的魂装中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调)
---@private
function LuaMaterialData:FindAndInsertToItemsFromSoulEquip(itemId)
    if (itemId == nil or itemId == 0 or self.MaterialSavePossibility.IsRoleEquip == nil) then
        return
    end

    ---@type table<number,bagV2.BagItemInfo> lua的bagV2.BagItemInfo
    local items = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSetSoulEquipList(itemId)

    if (items == nil) then
        return
    end
    local InsureMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr()

    for i = 1, #items do
        if (not InsureMgr:IsInsurance(items[i])) then
            table.insert(self.LuaItemSaveDic[LuaItemSavePos.RoleEquip], items[i])
        end
    end
end

---从人物身上的灵兽位中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调) 目前没有Lua数据同步,从C#里面取
---@private
function LuaMaterialData:FindAndInsertToItemsFromRoleServant(itemId)

    if (itemId == nil or itemId == 0 or self.MaterialSavePossibility.IsServant == nil) then
        return ;
    end
    local list = CS.CSSynthesisData.GetSynthesisMaterialFromServant(itemId)
    if (list == nil) then
        return
    end

    for i = 0, list.Count - 1 do
        table.insert(self.ItemSaveDic[LuaItemSavePos.RoleServant], list[i])
    end
end

---从寒芒灵兽中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调) 目前没有Lua数据同步,从C#里面取
---@private
function LuaMaterialData:FindAndInsertToItemsFromServant_HM(itemId)

    if (itemId == nil or itemId == 0 or (self.MaterialSavePossibility.IsRoleEquip == nil and self.MaterialSavePossibility.IsServantEquip == nil)) then
        return ;
    end
    local list = CS.CSSynthesisData.GetSynthesisMaterialFromServantEquip(Utility.EnumToInt(CS.ServantSeatType.HanMang), itemId)
    if (list == nil) then
        return
    end
    for i = 0, list.Count - 1 do
        table.insert(self.ItemSaveDic[LuaItemSavePos.ServantEquip_HM], list[i])
    end
end

---从落星灵兽中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调) 目前没有Lua数据同步,从C#里面取
---@private
function LuaMaterialData:FindAndInsertToItemsFromServant_LX(itemId)

    if (itemId == nil or itemId == 0 or (self.MaterialSavePossibility.IsRoleEquip == nil and self.MaterialSavePossibility.IsServantEquip == nil)) then
        return ;
    end
    local list = CS.CSSynthesisData.GetSynthesisMaterialFromServantEquip(Utility.EnumToInt(CS.ServantSeatType.LuoXing), itemId)
    if (list == nil) then
        return
    end
    for i = 0, list.Count - 1 do
        table.insert(self.ItemSaveDic[LuaItemSavePos.ServantEquip_LX], list[i])
    end
end

---从天成灵兽中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调) 目前没有Lua数据同步,从C#里面取
---@private
function LuaMaterialData:FindAndInsertToItemsFromServant_TC(itemId)

    if (itemId == nil or itemId == 0 or (self.MaterialSavePossibility.IsRoleEquip == nil and self.MaterialSavePossibility.IsServantEquip == nil)) then
        return ;
    end
    local list = CS.CSSynthesisData.GetSynthesisMaterialFromServantEquip(Utility.EnumToInt(CS.ServantSeatType.TianCheng), itemId)
    if (list == nil) then
        return
    end
    for i = 0, list.Count - 1 do
        table.insert(self.ItemSaveDic[LuaItemSavePos.ServantEquip_TC], list[i])
    end
end

---从元素中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调) 目前没有Lua数据同步,从C#里面取
---@private
function LuaMaterialData:FindAndInsertToItemsFromElements(itemId)

    if (itemId == nil or itemId == 0 or self.MaterialSavePossibility.IsElements == nil) then
        return ;
    end
    local list = CS.CSSynthesisData.GetSynthesisMaterialFromElementInfo(itemId)
    if (list == nil) then
        return
    end
    for i = 0, list.Count - 1 do
        table.insert(self.ItemSaveDic[LuaItemSavePos.Elements], list[i])
    end
end

---从印记中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调) 目前没有Lua数据同步,从C#里面取
---@private
function LuaMaterialData:FindAndInsertToItemsFromImprintInfo(itemId)

    if (itemId == nil or itemId == 0 or self.MaterialSavePossibility.IsImprint == nil) then
        return ;
    end
    local list = CS.CSSynthesisData.GetSynthesisMaterialFromImprintInfo(itemId)
    if (list == nil) then
        return
    end
    for i = 0, list.Count - 1 do
        table.insert(self.ItemSaveDic[LuaItemSavePos.Imprint], list[i])
    end
end

---从法宝中找寻Items的数据并插入单曲的道具列表中(注意,这个东西不外调)
---@private
function LuaMaterialData:FindAndInsertToItemsFromMagicInfo(itemId)

    if (itemId == nil or itemId == 0 or self.MaterialSavePossibility.IsMagicWeapon == nil) then
        return ;
    end
    ---@type table<bagV2.BagItemInfo>
    local items = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetAllMagicEquipItems()
    if (items == nil) then
        return
    end
    local InsureMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr()

    ---@param bagItemInfo bagV2.BagItemInfo lua的道具数据
    for i, bagItemInfo in pairs(items) do
        if bagItemInfo.itemId == itemId and (not InsureMgr:IsInsurance(bagItemInfo)) then
            table.insert(self.LuaItemSaveDic[LuaItemSavePos.MagicWeapon], bagItemInfo)
        end
    end
end

--endregion

--region 外部获取数据

---得到这个材料在所有位置的总数量
---@param isReGet boolean 是否重新获取数据
---@param itemSavePos LuaItemSavePos
---@param isContinueReGetBag boolean 是否重新获取背包数据
---@param isresolve boolean 是不是分解，分解只获取背包中的物品
function LuaMaterialData:GetAllMaterialCount(isReGet, itemSavePos, isContinueReGetBag, isresolve)
    local count = 0;
    if (isContinueReGetBag == nil or isContinueReGetBag) then
        count = count + self:GetMaterialCount(LuaItemSavePos.Bag, isReGet)
    end
    if (isresolve == true) then
        return count
    end
    if (itemSavePos == nil) then
        count = count + self:GetMaterialCount(LuaItemSavePos.RoleEquip, isReGet)
        if (uiStaticParameter.OpenEudemonsDetection) then
            count = count + self:GetMaterialCount(LuaItemSavePos.RoleServant, isReGet)
            count = count + self:GetMaterialCount(LuaItemSavePos.ServantEquip_HM, isReGet)
            count = count + self:GetMaterialCount(LuaItemSavePos.ServantEquip_LX, isReGet)
            count = count + self:GetMaterialCount(LuaItemSavePos.ServantEquip_TC, isReGet)
        end
        count = count + self:GetMaterialCount(LuaItemSavePos.Elements, isReGet)
        count = count + self:GetMaterialCount(LuaItemSavePos.Imprint, isReGet)
        count = count + self:GetMaterialCount(LuaItemSavePos.MagicWeapon, isReGet)
    else
        count = count + self:GetMaterialCount(itemSavePos, isReGet)
    end
    return count
end

---得到某个指定位置的道具数量
---@param ItemSavePos LuaItemSavePos
---@param isReGet boolean 是否强制重新获取
function LuaMaterialData:GetMaterialCount(ItemSavePos, isReGet)
    if (self.ItemTbl == nil) then
        return 0;
    end
    local count = 0
    if (self.ItemTbl:GetType() == luaEnumItemType.Coin) then
        if (ItemSavePos == LuaItemSavePos.Bag) then
            ---@type LuaMainPlayerBagMgr
            local mainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
            count = mainPlayerBagMgr:GetCoinAmount(self.ItemTbl:GetId())
        end
    else
        self:BeforeGetCheckIsInitData(ItemSavePos, isReGet)

        local list = self.LuaItemSaveDic[ItemSavePos]
        ---先看看是否这个类型是lua数据
        if (list ~= nil) then
            ---@param bagItemInfo bagV2.BagItemInfo lua的道具数据类型
            for i, bagItemInfo in pairs(list) do
                count = count + bagItemInfo.count
            end
        end

        local list = self.ItemSaveDic[ItemSavePos]
        ---先看看是否这个类型是lua数据
        if (list ~= nil) then
            ---@param bagItemInfo bagV2.BagItemInfo C#的道具数据类型
            for i, bagItemInfo in pairs(list) do
                count = count + bagItemInfo.count
            end
        end
    end

    return count
end

---得到这个材料在所有位置的总数量
function LuaMaterialData:GetAllCostItemLidList(lidTable, itemIdList, excludeID, isReGet)
    self:InsertCostItemLidList(lidTable, LuaItemSavePos.Bag, excludeID, isReGet)
    self:InsertCostItemLidList(lidTable, LuaItemSavePos.RoleEquip, excludeID, isReGet)
    if (uiStaticParameter.OpenEudemonsDetection) then
        self:InsertCostItemLidList(lidTable, LuaItemSavePos.RoleServant, isReGet)
        self:InsertCostItemLidList(lidTable, LuaItemSavePos.ServantEquip_HM, excludeID, isReGet)
        self:InsertCostItemLidList(lidTable, LuaItemSavePos.ServantEquip_LX, excludeID, isReGet)
        self:InsertCostItemLidList(lidTable, LuaItemSavePos.ServantEquip_TC, excludeID, isReGet)
    end
    self:InsertCostItemLidList(lidTable, LuaItemSavePos.Elements, excludeID, isReGet)
    self:InsertCostItemLidList(lidTable, LuaItemSavePos.Imprint, excludeID, isReGet)
    self:InsertCostItemLidList(lidTable, LuaItemSavePos.MagicWeapon, excludeID, isReGet)
    self:InsertCostCoinsIdList(itemIdList, LuaItemSavePos.Bag, isReGet);
    return lidTable, itemIdList
end

---@param excludeID number 合成的时候,有些时候是指定消耗某个材料的,这个时候,这个材料就不能在这个列表中,而是在另一边
function LuaMaterialData:InsertCostItemLidList(lidList, ItemSavePos, excludeID, isReGet)
    self:BeforeGetCheckIsInitData(ItemSavePos, isReGet)
    local list = self.LuaItemSaveDic[ItemSavePos]
    ---先看看是否这个类型是lua数据
    if (list ~= nil) then
        ---@param bagItemInfo bagV2.BagItemInfo lua的道具数据类型
        for i, bagItemInfo in pairs(list) do
            if (bagItemInfo.lid ~= excludeID) then
                table.insert(lidList, bagItemInfo.lid)
            end
        end
    end

    local list = self.ItemSaveDic[ItemSavePos]
    ---先看看是否这个类型是lua数据
    if (list ~= nil) then
        ---@param bagItemInfo bagV2.BagItemInfo C#的道具数据类型
        for i, bagItemInfo in pairs(list) do
            if (bagItemInfo.lid ~= excludeID) then
                table.insert(lidList, bagItemInfo.lid)
            end
        end
    end
    return lidList
end

function LuaMaterialData:InsertCostCoinsIdList(itemIdList, itemSavePos, isReGet)
    self:BeforeGetCheckIsInitData(itemSavePos, isReGet)
    local list = self.mCoinsSaveDic[itemSavePos]
    if (list ~= nil) then
        for k, v in pairs(list) do
            table.insert(itemIdList, v);
        end
    end
    return itemIdList;
end

function LuaMaterialData:GetAllBagItems(ItemSavePos, isReGet)

end

---在获取到数据之前,先进行检测是否已经初始化了
---(避免我本来只想要背包数据,但是我把所有的位置全部检测了一边,所以在获取那个位置的时候,去检测是否需要去获取那个位置的东西)
---@param ItemSavePos LuaItemSavePos
function LuaMaterialData:BeforeGetCheckIsInitData(ItemSavePos, force)
    if (self.LuaItemSaveDic[ItemSavePos] == nil or force) then
        self.ItemSaveDic[ItemSavePos] = {}
        self.LuaItemSaveDic[ItemSavePos] = {}
        self.mCoinsSaveDic[ItemSavePos] = {};
        if (ItemSavePos == LuaItemSavePos.Bag) then
            self:FindAndInsertToItemsFromBag(self.TargetItemID)
            self:FindAndInsertToItemsFromBag(self.TargetReplaceItemID)
            self:FindAndInsertToCoins(self.TargetItemID)
            self:FindAndInsertToCoins(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.RoleEquip) then
            self:FindAndInsertToItemsFromRoleEquip(self.TargetItemID)
            self:FindAndInsertToItemsFromRoleEquip(self.TargetReplaceItemID)
            self:FindAndInsertToItemsFromSoulEquip(self.TargetItemID)
            self:FindAndInsertToItemsFromSoulEquip(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.RoleServant and uiStaticParameter.OpenEudemonsDetection) then
            self:FindAndInsertToItemsFromRoleServant(self.TargetItemID)
            self:FindAndInsertToItemsFromRoleServant(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.ServantEquip_TC and uiStaticParameter.OpenEudemonsDetection) then
            self:FindAndInsertToItemsFromServant_TC(self.TargetItemID)
            self:FindAndInsertToItemsFromServant_TC(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.ServantEquip_LX and uiStaticParameter.OpenEudemonsDetection) then
            self:FindAndInsertToItemsFromServant_LX(self.TargetItemID)
            self:FindAndInsertToItemsFromServant_LX(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.ServantEquip_HM and uiStaticParameter.OpenEudemonsDetection) then
            self:FindAndInsertToItemsFromServant_HM(self.TargetItemID)
            self:FindAndInsertToItemsFromServant_HM(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.Imprint) then
            self:FindAndInsertToItemsFromImprintInfo(self.TargetItemID)
            self:FindAndInsertToItemsFromImprintInfo(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.Elements) then
            self:FindAndInsertToItemsFromElements(self.TargetItemID)
            self:FindAndInsertToItemsFromElements(self.TargetReplaceItemID)
        elseif (ItemSavePos == LuaItemSavePos.MagicWeapon) then
            self:FindAndInsertToItemsFromMagicInfo(self.TargetItemID)
            self:FindAndInsertToItemsFromMagicInfo(self.TargetReplaceItemID)
        end
    end
end

---检查材料是否足够
---@param itemId number 材料id
---@param count number 数量
---@param ItemSavePos LuaItemSavePos
---@param isReGet boolean
---@return boolean 数量是否足够
function LuaMaterialData:CheckMaterialIsEnough(itemId, count, ItemSavePos, isReGet)
    if itemId == nil or count == nil then
        return false
    end
    local itemSavePos = ternary(ItemSavePos == nil, LuaItemSavePos.Bag, ItemSavePos)
    local isReGet = ternary(isReGet == nil, true, isReGet)
    local curCount = self:GetMaterialCount(itemSavePos, isReGet)
    return curCount >= count
end
--endregion

return LuaMaterialData