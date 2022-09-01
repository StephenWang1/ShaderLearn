---@class cfg_itemsManager:TableManager
local cfg_itemsManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_items
function cfg_itemsManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_items> 遍历方法
function cfg_itemsManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_itemsManager:PostProcess()
end

---@return Cfg_ItemsTableManager
function cfg_itemsManager:GetCSItemTblMgr()
    if self.mCSItemTblMgr == nil then
        self.mCSItemTblMgr = CS.Cfg_ItemsTableManager.Instance
    end
    return self.mCSItemTblMgr
end

--region 神力套装
--region 查询
---是否是神力套装
---@param itemId number 道具id
---@return boolean 是否是神力套装
function cfg_itemsManager:IsDivineSuitEquip(itemId)
    local divineId = self:GetDivineSuitId(itemId)
    return divineId ~= nil and divineId > 0
end
--endregion

--region 获取
---获取神力套装套装id
---@param itemId number 道具id
---@return number 套装id
function cfg_itemsManager:GetDivineSuitId(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl ~= nil then
        return tbl:GetDivineId()
    end
end

---获取神力套装套装类型
---@param itemId number 道具id
---@return LuaEquipmentListType 神力套装类型
function cfg_itemsManager:GetDivineSuitType(itemId)
    local suitId = self:GetDivineSuitId(itemId)
    if suitId ~= nil and suitId > 0 then
        return clientTableManager.cfg_divinesuitManager:GetSuitType(suitId)
    end
end
--endregion
--endregion

--region 法宝
--region 查询
---是否是法宝装备
---@param itemId number 物品id
---@return boolean 是否是法宝
function cfg_itemsManager:IsMagicEquip(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl ~= nil then
        return tbl:GetSubType() == LuaEnumEquipSubType.Equip_MagicWeapon
    end
    return false
end

---是否可以使用法宝装备
---@param itemId number 物品id
---@return LuaEnumUseItemParam 使用参数
function cfg_itemsManager:CanUseMagicEquip(itemId)
    if self:IsMagicEquip(itemId) then
        local tbl = self:TryGetValue(itemId)
        local suitType = self:GetMagicEquipSuitType(itemId)
        local suitTypeIsUnLock = LuaGlobalTableDeal:MagicEquipTypeIsUnLock(suitType)
        if suitTypeIsUnLock == false then
            return LuaEnumUseItemParam.MagicEquipSuitTypeLocked
        end
        return self:MainPlayerCanUseItem(itemId)
    end
    return LuaEnumUseItemParam.NoConfigItem
end

---对比两个法宝
---@param firstItemInfo TABLE.CFG_ITEMS 第一个对比物品
---@param secondItemInfo TABLE.CFG_ITEMS 第二个对比物品
---@return number -1:传入数据有问题 0:firstItemInfo = secondItemInfo 1:firstItemInfo > secondItemInfo 2:firstItemInfo < secondItemInfo
function cfg_itemsManager:CompareMagicEquip(firstItemInfo, secondItemInfo)
    if firstItemInfo == nil or secondItemInfo == nil or firstItemInfo.id == nil or secondItemInfo.id == nil
            or self:IsMagicEquip(firstItemInfo.id) == false or self:IsMagicEquip(secondItemInfo.id) == false then
        --基础参数检测
        return -1
    end
    local compareParam = -1
    ---@type TABLE.cfg_magicweapon
    local firstItemSuitTableInfo = self:GetMagicEquipSuitInfo(firstItemInfo.id)
    ---@type TABLE.cfg_magicweapon
    local secondItemSuitTableInfo = self:GetMagicEquipSuitInfo(secondItemInfo.id)
    if firstItemSuitTableInfo == nil or secondItemSuitTableInfo == nil then
        --检测是否有套装表数据
        return compareParam
    end
    local firstItemEquipIndex = self:GetMagicEquipEquipIndex(firstItemInfo.id)
    local secondItemEquipIndex = self:GetMagicEquipEquipIndex(secondItemInfo.id)
    if firstItemEquipIndex ~= secondItemEquipIndex then
        --检测装备位
        return compareParam
    end
    if firstItemSuitTableInfo:GetLevel() == secondItemSuitTableInfo:GetLevel() then
        compareParam = 0
    elseif firstItemSuitTableInfo:GetLevel() > secondItemSuitTableInfo:GetLevel() then
        compareParam = 1
    else
        compareParam = -1
    end
    return compareParam
end
--endregion

--region 获取
---获取法宝的杂项参数
---@param itemId number 物品id
---@return table 杂项参数
function cfg_itemsManager:GetMagicEquipParams(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl ~= nil and tbl:GetUseParam() ~= nil and tbl:GetUseParam().list.Count > 1 then
        local paramsTable = {}
        ---@type number 套装id
        paramsTable.suitId = tonumber(tbl:GetUseParam().list[0])
        ---@type LuaEquipmentItemType 基础装备位
        paramsTable.baseEquipIndex = tonumber(tbl:GetUseParam().list[1])
        return paramsTable
    end
end

---获取法宝套装表
---@param itemId number 物品id
---@return TABLE.cfg_magicweapon 法宝套装表
function cfg_itemsManager:GetMagicEquipSuitInfo(itemId)
    if self:IsMagicEquip(itemId) == true then
        local magicEquipParams = self:GetMagicEquipParams(itemId)
        if magicEquipParams ~= nil and magicEquipParams.suitId ~= nil and type(magicEquipParams.suitId) == 'number' then
            return clientTableManager.cfg_magicweaponManager:TryGetValue(magicEquipParams.suitId)
        end
    end
end

---获取法宝套装类型
---@param itemId number 物品id
---@return LuaEnumMagicEquipSuitType 法宝套装类型
function cfg_itemsManager:GetMagicEquipSuitType(itemId)
    local suitTableInfo = self:GetMagicEquipSuitInfo(itemId)
    if suitTableInfo ~= nil then
        return suitTableInfo:GetType()
    end
end

---获取法宝的装备位
---@param itemId number 物品id
---@return number 装备位
function cfg_itemsManager:GetMagicEquipEquipIndex(itemId)
    if self:IsMagicEquip(itemId) == true then
        local magicEquipParams = self:GetMagicEquipParams(itemId)
        local magicEquipSuitTableInfo = self:GetMagicEquipSuitInfo(itemId)
        if magicEquipParams ~= nil and magicEquipParams.baseEquipIndex ~= nil and magicEquipSuitTableInfo ~= nil then
            return magicEquipSuitTableInfo:GetType() * 1000 + magicEquipParams.baseEquipIndex
        end
    end
end

---获取法宝的基础装备位
---@param itemId number 物品id
---@return LuaEquipmentItemType 基础装备位
function cfg_itemsManager:GetMagicEquipBaseEquipIndex(itemId)
    if self:IsMagicEquip(itemId) == true then
        local magicEquipParams = self:GetMagicEquipParams(itemId)
        if magicEquipParams ~= nil then
            return magicEquipParams.baseEquipIndex
        end
    end
end

---itemInfo转BagItemInfo
---@param itemId number 物品id
---@return bagV2.BagItemInfo
function cfg_itemsManager:GetBagItemInfoByItemId(itemId)
    local customData = { itemId = itemId }
    local ItemTbl = self:TryGetValue(itemId)
    if ItemTbl ~= nil then
        local bagItemInfo = protobufMgr.AdjustTable.bag_adj.AdjustBagItemInfo(customData)
        bagItemInfo.ItemTABLE = ItemTbl
        return bagItemInfo
    end
end
--endregion
--endregion

--region 血继
---是否是血继装备
---@param itemId number
---@return boolean 是否是血继装备
function cfg_itemsManager:IsBloodSuitEquip(itemId)
    if itemId == nil then
        return
    end
    local bloodSuitTable = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemId)
    return bloodSuitTable ~= nil
end
--endregion

--region 虎符/官印
---是否是虎符
function cfg_itemsManager:IsHuFuEquip(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl ~= nil then
        return tbl:GetSubType() == LuaEnumEquipSubType.Equip_hufu and tbl:GetType() ~= 8
    end
    return false
end

---是否是官印
function cfg_itemsManager:IsOfficialSealEquip(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl ~= nil then
        return tbl:GetSubType() == LuaEnumEquipSubType.Equip_seal
    end
    return false
end

---是否是暗器
function cfg_itemsManager:IsAnQiEquip(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl ~= nil then
        return tbl:GetSubType() == LuaEnumEquipSubType.Equip_AnQi
    end
    return false
end

---是否是马牌
function cfg_itemsManager:IsMaPaiEquip(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl ~= nil then
        return tbl:GetSubType() == LuaEnumEquipSubType.Equip_maPai
    end
    return false
end

--endregion

--region 魂装
function cfg_itemsManager:IsXianZhuangEquip(itemId)
    local info = self:TryGetValue(itemId)
    if info and info:GetSuitBelong() == LuaEnumSoulEquipType.XianZhuang then
        return true
    end
    return false
end
--endregion

--region 道具基础数据使用查询
---灵兽装备是否可以被装备
---@param equipItemId number 灵兽装备ItemId
---@param servantInfo servantV2.ServantInfo 灵兽信息
---@return LuaEnumUseItemParam 是否可以使用
function cfg_itemsManager:ServantEquipCanEquiped(equipItemId, servantInfo)
    return Utility.EnumToInt(self:GetCSItemTblMgr():ServantEquipCanEquiped(equipItemId, servantInfo))
end

---装备是否可以使用元素
---@param elementItemId number 元素itemId
---@param equipItemId number 装备itemId
---@return LuaEnumUseItemParam 是否可以使用
function cfg_itemsManager:EquipCanUseElement(elementItemId, equipItemId)
    return Utility.EnumToInt(self:GetCSItemTblMgr():EquipCanUseElement(elementItemId, equipItemId))
end

---装备是否可以使用印记
---@param signetItemId number 印记itemId
---@param equipItemId number 装备itemId
---@return LuaEnumUseItemParam 是否可以使用
function cfg_itemsManager:EquipCanUseSignet(signetItemId, equipItemId)
    return Utility.EnumToInt(self:GetCSItemTblMgr():EquipCanUseSignet(signetItemId, equipItemId))
end

---主角是否可以使用道具
---@param itemId number itemId
---@return LuaEnumUseItemParam 是否可以使用
function cfg_itemsManager:MainPlayerCanUseItem(itemId)
    return Utility.EnumToInt(self:GetCSItemTblMgr():MainPlayerCanUseItem(itemId))
end

---是否可以使用道具
---@param itemId number itemId
---@param useLv number 对比等级
---@param reinLv number 对比转生等级
---@return LuaEnumUseItemParam 是否可以使用
function cfg_itemsManager:CanUseItem(itemId, useLv, reinLv)
    return Utility.EnumToInt(self:GetCSItemTblMgr():CanUseItem(itemId, useLv, reinLv))
end

---是否是主角职业可以使用的物品
---@param itemId number itemId
---@return boolean
function cfg_itemsManager:IsMainPlayerCareerUseItem(itemId)
    local itemTbl = self:TryGetValue(itemId)
    if itemTbl == nil then
        return false
    end
    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    if career == nil then
        return false
    end
    return itemTbl:GetCareer() == LuaEnumCareer.Common or itemTbl:GetCareer() == career
end

---主角是否可以使用物品
---@param itemId number itemId
---@return boolean
function cfg_itemsManager:MainPlayerCanUseItemAndCareer(itemId)
    return self:IsMainPlayerCareerUseItem(itemId) and self:MainPlayerCanUseItem(itemId) == LuaEnumUseItemParam.CanUse
end
--endregion

--region 通用
---是否是同类型物品
---@param leftItemId number 物品id
---@param rightItemId number 物品id
---@return boolean 是否是同类型物品
function cfg_itemsManager:IsSameItem(leftItemId, rightItemId)
    if leftItemId == nil or rightItemId == nil then
        return false
    end
    local leftItemTbl = self:TryGetValue(leftItemId)
    local rightItemTbl = self:TryGetValue(rightItemId)
    if leftItemTbl == nil or rightItemTbl == nil then
        return false
    end
    return leftItemTbl:GetType() == rightItemTbl:GetType() and leftItemTbl:GetSubType() == rightItemTbl:GetSubType()
end

---检查物品使用条件
---@param id number
---@return LuaMatchConditionResult
function cfg_itemsManager:CheckItemsConditions(id)
    local itemTbl = self:TryGetValue(id)
    if itemTbl ~= nil and itemTbl:GetConditions() ~= nil and itemTbl:GetConditions().list ~= nil and Utility.GetLuaTableCount(itemTbl:GetConditions().list) > 0 then
        local conditionIdList = itemTbl:GetConditions().list
        return Utility.IsMainPlayerMatchConditionList_AND(conditionIdList)
    end
    return { success = true, type = 0, txt = "没有配置限制ConditionId列表" }
end

---是否包含buff效果
---@param id number
---@return boolean
function cfg_itemsManager:HaveBuffer(id)
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return false
    end
    local buffTblList = self:GetBufferTblListByItemId()
    return type(buffTblList) == 'table' and Utility.GetTableCount(buffTblList) > 0
end

---获取buff表列表
---@param id number
---@return table<TABLE.cfg_buff>
function cfg_itemsManager:GetBufferTblListByItemId(id)
    local tbl = self:TryGetValue(id)
    if tbl == nil or type(tbl:GetBuffers()) ~= 'table' or tbl:GetBuffers().list == nil or Utility.GetTableCount(tbl:GetBuffers().list) <= 0 then
        return
    end
    local buffIdList = tbl:GetBuffers().list
    local buffTblList = {}
    for k, v in pairs(buffIdList) do
        local buffTbl = clientTableManager.cfg_buffManager:TryGetValue(v)
        if buffTbl ~= nil then
            table.insert(buffTblList, buffTbl)
        end
    end
    return buffTblList
end

---获取buff描述内容
---@param id number
---@return string
function cfg_itemsManager:GetBuffDes(id)
    local buffTblTable = self:GetBufferTblListByItemId(id)
    local des = ""
    if type(buffTblTable) == 'table' then
        for k, v in pairs(buffTblTable) do
            ---@type TABLE.cfg_buff
            local buffTbl = v
            local curDes = clientTableManager.cfg_buffManager:GetBuffTipsDes(buffTbl:GetId())
            if CS.StaticUtility.IsNullOrEmpty(curDes) == false then
                if #buffTblTable == k then
                    des = des .. curDes
                else
                    des = des .. curDes .. "\n"
                end
            end
        end
    end
    return des
end
--endregion

--region 回收
---获取回收固定收益
---@param itemID number
---@return table<number, number>
function cfg_itemsManager:GetRecycleFixEarning(itemID)
    if self.mRecycleFixEarningDic == nil then
        self.mRecycleFixEarningDic = {}
    end
    local result = self.mRecycleFixEarningDic[itemID]
    if result ~= nil then
        return result
    end
    local itemTbl = self:TryGetValue(itemID)
    if itemTbl == nil then
        return
    end
    ---@type table<number, number>
    result = {}
    self.mRecycleFixEarningDic[itemID] = result
    local equal = itemTbl:GetEqual()
    local strs1 = string.Split(equal, '&')
    for i = 1, #strs1 do
        local strs2 = string.Split(strs1[i], '#')
        if strs2 ~= nil and #strs2 > 1 then
            local itemId = tonumber(strs2[1])
            local count = tonumber(strs2[2])
            if itemId ~= nil and count ~= nil then
                if result[itemId] ~= nil then
                    result[itemId] = result[itemId] + count
                else
                    result[itemId] = count
                end
            end
        end
    end
    return result
end
--endregion

--region 仓库
---是否是随身仓库
---@return boolean
function cfg_itemsManager:IsStorage(itemId)
    local tbl = self:TryGetValue(itemId)
    if tbl == nil then
        return false
    end
    if tbl:GetType() == luaEnumItemType.Assist and tbl:GetSubType() == 35 then
        return true
    end
    return false
end
--endregion

--region 设置
---存储可设置item
---@param itemInfo TABLE.cfg_items
function cfg_itemsManager:TrySaveItemConfig(itemInfo)
    if self.mItemPickTypeToItemIdList == nil then
        self.mItemPickTypeToItemIdList = {}
    end
    if itemInfo and itemInfo:GetPickUpType() then
        local typeItemList = self.mItemPickTypeToItemIdList[itemInfo:GetPickUpType()]
        if typeItemList == nil then
            typeItemList = {}
            self.mItemPickTypeToItemIdList[itemInfo:GetPickUpType()] = typeItemList
        end
        table.insert(typeItemList, itemInfo:GetId())
    end
end

---获取拾取类型对应的道具列表
---@return table<number,number>
function cfg_itemsManager:GetPickTypeItemList(pickId)
    if self.mItemPickTypeToItemIdList == nil then
        self:ForPair(function(k, v)
            self:TrySaveItemConfig(v)
        end)
        for k, v in pairs(self.mItemPickTypeToItemIdList) do
            ---@param left number itemId
            ---@param right number itemId
            table.sort(v, function(left, right)
                if left == nil or right == nil then
                    return false
                end
                return left < right
            end)
        end
    end
    if self.mItemPickTypeToItemIdList then
        return self.mItemPickTypeToItemIdList[pickId]
    end
end
--endregion

--region 时装
---是否是时装外观
---@param itemId number 道具id
---@return boolean
function cfg_itemsManager:IsAppearance(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return false
    end
    return itemTbl:GetType() == luaEnumItemType.Appearance
end
--endregion

--region 阵法装备
---是否是阵法装备
---@param itemId number 道具id
---return boolean
function cfg_itemsManager:IsZhenFaEquip(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return false
    end
    return itemTbl:GetType() == luaEnumItemType.Equip and LuaGlobalTableDeal:IsConfigZhenFaEquipIndex(itemTbl:GetSubType())
end
--endregion

--region 斗笠盾牌装备
---是否是阵法装备
---@param itemId number 道具id
---return boolean
function cfg_itemsManager:IsShieldorHatEquip(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return false
    end
    return itemTbl:GetType() == luaEnumItemType.Equip and (itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_Shield or itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_Hat), itemTbl
end
--endregion

return cfg_itemsManager