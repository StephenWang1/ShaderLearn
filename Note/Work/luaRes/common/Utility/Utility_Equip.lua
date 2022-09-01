---@type Utility
local Utility = Utility

---是否为神力套装
---神力的的套装在100000-200000之间  一个套装列表赞占位1000个下标  10W个=100套
---@param index number 装备的下标
---@param isReturnTypeValue boolean 是否返回具体的类型值
---@return LuaEquipmentListType 神力类型 注意如果isReturnTypeValue不为true,那么返回的就是boolean(减少频繁调用 math.floor的消耗)
function Utility.IsSLEquip(index, isReturnTypeValue)
    if (index == nil) then
        return index.Base
    end
    ---神力套装的下标格式为100000 +(1000 * 套装类型) + subType
    ---注意神力套装的装备下标从300开始
    if (index > 100000 and index < 200000) then
        if (isReturnTypeValue == true) then
            return math.floor(((index - 100000) / 1000));
        end
        return true
    end
    return LuaEquipmentListType.Base
end

---得到神力装备的装备位
---@param type 神力的套装类型
---@param itemSubType 道具表里面的SubType字段
---@param isRight 是否为右手装备
function Utility.GetSLEquipIndex(type, itemSubType, isRight)
    if (itemSubType == nil) then
        itemSubType = 0
    end
    local index = 100000 + type * 1000 + itemSubType
    --右手装备的下标比左手的装备多50,别问我为什么,服务器定的
    if (isRight == true) then
        index = index + 50
    end

    return index
end

---得到神力装备的基础装备位
---@param index 神力装备的装备位
function Utility.GetSLEquipBasicIndex(index)
    index = (index - 100000) % 1000
    return index
end

---是否为血继套装（这个是静态方法）
---血继的的套装在300000-400000之间  一个套装列表赞占位100个下标  10W个=1000套
---@param index number 装备的下标
---@param isReturnTypeValue boolean 是否返回具体的类型值
---@return LuaEquipBloodSuitType 血继类型  注意如果isReturnTypeValue不为true,那么返回的就是boolean(减少频繁调用 math.floor的消耗)
function Utility.IsXJEquip(index, isReturnTypeValue)
    if (index == nil) then
        return LuaEquipBloodSuitType.None
    end
    ---这个是装备位的下标,每个装备的下标是存在规则的
    ---血继装备的下标格式为300000 + 100 * type + pos
    if (index > 300000 and index < 400000) then
        if (isReturnTypeValue == true) then
            return math.floor((index - 300000) % 100);
        end
        return true
    end
    return LuaEquipBloodSuitType.None
end

---根据装备的装备位获取装备道具的SubType  用来替代utility.EnumToInt(CS.CSScene.MainPlayerInfo.EquipInfo:GetSubTypeByEquipIndex(index))
---@param index 装备的下标
function Utility.GetItemSubTypeByEquipIndex(index)
    if (Utility.IsSLEquip(index)) then
        ---判定神力套装的装备位
        index = Utility.GetSLEquipBasicIndex(index);
        if ((index % 100) / 50 >= 1) then
            ---神力装备为十分位为5的时候  说明是右手装备,这个时候 SubType是需要-50的
            index = index - 50
        end
    elseif (index == LuaEquipmentItemType.POS_RIGHT_RING) then
        --右手戒子
        return LuaEnumEquiptype.Ring
    elseif (index == LuaEquipmentItemType.POS_RIGHT_HAND) then
        --右手手镯
        return LuaEnumEquiptype.Bracelet
    end
    return index
end

--region 获取装备的数据字典

---根据装备的装备数据获取装备的属性
---@param bagItemInfo bagV2.BagItemInfo lua的BagItemInfo类
---@param career number 职业(如果指定了职业,那么只会获取对应职业有用的属性)0:通用 1战士 2法师 3道士
---@return table<number:属性类型, number:属性值>
function Utility.GetItemAttributesByBagItemInfo(bagItemInfo, career)

end

---根据装备的装备数据获取装备的属性
---@param itemTable TABLE.cfg_items
---@param career number 职业(如果指定了职业,那么只会获取对应职业有用的属性) 0:通用 1战士 2法师 3道士
---@return table<number:属性类型, number:属性值>
function Utility.GetItemAttributesByItemTable(itemTable, career)
    if (itemTable == nil) then
        return {}
    end
    local data = {}
    local value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.MaxHp, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.MaxHp] = value
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.MaxMp, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.MaxMp] = value
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.InnerPowerMax, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.InnerPowerMax] = value
    end

    if (career == nil or career == 1) then
        value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.PhyAttackMin, career)
        if (value ~= 0) then
            data[LuaEnumAttributeType.PhyAttackMin] = value
        end

        value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.PhyAttackMax, career)
        if (value ~= 0) then
            data[LuaEnumAttributeType.PhyAttackMax] = value
        end
    end

    if (career == nil or career == 2) then
        value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.MagicAttackMin, career)
        if (value ~= 0) then
            data[LuaEnumAttributeType.MagicAttackMin] = value
        end

        value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.MagicAttackMax, career)
        if (value ~= 0) then
            data[LuaEnumAttributeType.MagicAttackMax] = value
        end
    end

    if (career == nil or career == 3) then
        value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.TaoAttackMin, career)
        if (value ~= 0) then
            data[LuaEnumAttributeType.TaoAttackMin] = value
        end

        value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.TaoAttackMax, career)
        if (value ~= 0) then
            data[LuaEnumAttributeType.TaoAttackMax] = value
        end
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.PhyDefenceMin, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.PhyDefenceMin] = value
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.PhyDefenceMax, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.PhyDefenceMax] = value
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.MagicDefenceMin, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.MagicDefenceMin] = value
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.MagicDefenceMax, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.MagicDefenceMax] = value
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.Critical, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.Critical] = value
    end

    value = Utility.TryGetItemTableAttribute(itemTable, LuaEnumAttributeType.CriticalDamage, career)
    if (value ~= 0) then
        data[LuaEnumAttributeType.CriticalDamage] = value
    end

    return data
end

---获取装备基础属性
---@param tblData TABLE.cfg_items
---@param type LuaEnumAttributeType
---@param career number 职业(如果指定了职业,那么只会获取对应职业有用的属性) 0:通用 1战士 2法师 3道士
---@return number 值
function Utility.TryGetItemTableAttribute(tblData, type, career)
    if (tblData == nil) then
        return 0
    end
    if (type == LuaEnumAttributeType.MaxHp) and career ~= nil then
        --最大HP
        return Utility.GetCareerValue(tblData:GetMaxHp(), career)
    elseif (type == LuaEnumAttributeType.MaxMp) then
        --最大MP
        return tblData:GetMaxMp()
    elseif (type == LuaEnumAttributeType.InnerPowerMax) then
        --内力
        return tblData:GetInnerPowerMax()
    elseif (type == LuaEnumAttributeType.PhyAttackMin) then
        --最小物理攻击力
        return tblData:GetPhyAttackMin()
    elseif (type == LuaEnumAttributeType.PhyAttackMax) then
        --最大物理攻击力
        return tblData:GetPhyAttackMax()
    elseif (type == LuaEnumAttributeType.MagicAttackMin) then
        --最小魔法攻击力
        return tblData:GetMagicAttackMin()
    elseif (type == LuaEnumAttributeType.MagicAttackMax) then
        --最大魔法攻击力
        return tblData:GetMagicAttackMax()
    elseif (type == LuaEnumAttributeType.TaoAttackMin) then
        --道术攻击下限
        return tblData:GetTaoAttackMin()
    elseif (type == LuaEnumAttributeType.TaoAttackMax) then
        --道术攻击上限
        return tblData:GetTaoAttackMax()
    elseif (type == LuaEnumAttributeType.PhyDefenceMin) then
        --最小物防
        return tblData:GetPhyDefenceMin()
    elseif (type == LuaEnumAttributeType.PhyDefenceMax) then
        --最大物防
        return tblData:GetPhyDefenceMax()
    elseif (type == LuaEnumAttributeType.MagicDefenceMin) then
        --最小魔法防御力
        return tblData:GetMagicDefenceMin()
    elseif (type == LuaEnumAttributeType.MagicDefenceMax) then
        --最小魔法防御力
        return tblData:GetMagicDefenceMax()
    elseif (type == LuaEnumAttributeType.Critical) then
        --暴击
        return tblData:GetCritical()
    elseif (type == LuaEnumAttributeType.CriticalDamage) then
        --爆伤
        return tblData:GetCriticalDamage()
    elseif (type == LuaEnumAttributeType.HolyAttackMin) then
        --最小神圣攻击
        return tblData:GetHolyAttackMin()
    elseif (type == LuaEnumAttributeType.HolyAttackMax) then
        --最大神圣攻击
        return tblData:GetHolyAttackMax()
    end
    return 0
end

---获取装备的浮动属性
---@param bagItemInfo bagV2.BagItemInfo
---@param attributeType LuaEnumAttributeType
---@return number 属性值
function Utility.GetRateAttribute(bagItemInfo, attributeType)
    local rateAttributeTable = bagItemInfo.rateAttribute
    if type(rateAttributeTable) == 'table' and Utility.GetTableCount(rateAttributeTable) > 0 then
        for k, v in pairs(rateAttributeTable) do
            if v.type == attributeType then
                return v.num
            end
        end
    end
    return 0
end

---获取装备总属性值（基础是 + 浮动之）
---@param bagItemInfo bagV2.BagItemInfo
---@param attributeType LuaEnumAttributeType
---@param career LuaEnumCareer
---@return number 总属性值
function Utility.GetEquipTotalAttr(bagItemInfo, attributeType, career)
    if bagItemInfo == nil or attributeType == nil then
        return 0
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if bagItemInfo.itemId == nil then
        itemTbl = bagItemInfo
    end
    if itemTbl == nil then
        return 0
    end
    local baseAttribute = Utility.TryGetItemTableAttribute(itemTbl, attributeType, career)
    local rateAttribute = Utility.GetRateAttribute(bagItemInfo, attributeType)
    return baseAttribute + rateAttribute
end

---获取物品提升属性价值
---@param bagItemInfo bagV2.BagItemInfo 物品
---@param career LuaEnumCareer 职业
---@return number 提升值
function Utility.GetItemUpAttributeValue(bagItemInfo, career)
    local attackMax, phyDefenceMax, magicDefenceMax, minAttackType, maxAttackType
    local proportion = 0.0001
    local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    local career = gameMgr:GetLuaMainPlayer():GetCareer()
    local attributeComputingCoefficientTable = LuaGlobalTableDeal.GetAttributeComputingCoefficient()
    if itemTbl == nil or career == nil or attributeComputingCoefficientTable == nil or type(attributeComputingCoefficientTable) ~= 'table' or Utility.GetLuaTableCount(attributeComputingCoefficientTable) < 2 then
        return 0
    end
    local corfficient_1, corfficient_2 = attributeComputingCoefficientTable[1] * proportion, attributeComputingCoefficientTable[2] * proportion
    if career == LuaEnumCareer.Warrior then
        minAttackType = LuaEnumAttributeType.PhyAttackMin
        maxAttackType = LuaEnumAttributeType.PhyAttackMax
    elseif career == LuaEnumCareer.Master then
        minAttackType = LuaEnumAttributeType.MagicAttackMin
        maxAttackType = LuaEnumAttributeType.MagicAttackMax
    elseif career == LuaEnumCareer.Taoist then
        minAttackType = LuaEnumAttributeType.TaoAttackMin
        maxAttackType = LuaEnumAttributeType.TaoAttackMax
    end
    attackMax = Utility.TryGetItemTableAttribute(itemTbl, minAttackType, career) + Utility.TryGetItemTableAttribute(itemTbl, maxAttackType, career) +
            Utility.GetRateAttribute(bagItemInfo, minAttackType) + Utility.GetRateAttribute(bagItemInfo, maxAttackType)
    phyDefenceMax = Utility.TryGetItemTableAttribute(itemTbl, LuaEnumAttributeType.PhyDefenceMin, career) + Utility.TryGetItemTableAttribute(itemTbl, LuaEnumAttributeType.PhyDefenceMax, career) +
            Utility.GetRateAttribute(bagItemInfo, LuaEnumAttributeType.PhyDefenceMin) + Utility.GetRateAttribute(bagItemInfo, LuaEnumAttributeType.PhyDefenceMax)
    magicDefenceMax = Utility.TryGetItemTableAttribute(itemTbl, LuaEnumAttributeType.MagicDefenceMin, career) + Utility.TryGetItemTableAttribute(itemTbl, LuaEnumAttributeType.MagicDefenceMax, career) +
            Utility.GetRateAttribute(bagItemInfo, LuaEnumAttributeType.MagicDefenceMin) + Utility.GetRateAttribute(bagItemInfo, LuaEnumAttributeType.MagicDefenceMax)
    return attackMax * corfficient_1 + (phyDefenceMax + magicDefenceMax) * corfficient_2
end

---@param data  C#的IntListList
---@param career number 职业(如果指定了职业,那么只会获取对应职业有用的属性) 0:通用 1战士 2法师 3道士
function Utility.GetCareerValue(data, career)
    if (data == nil) then
        return 0
    end
    local careerList = data.list
    if careerList then
        --所有职业统一加成,那么这个时候直接取值
        if (careerList.Count == 1 and careerList[0].Count == 1) then
            return careerList[0].list[0]
        else
            for i = 0, data.list.Count - 1 do
                local d = data.list[i]
                local c = d.list[0]
                local v = d.list[1]
                if (c == career) then
                    return v
                end
            end
            return 0
        end
    end
    return 0
end

function Utility.GetItemAttribute(type)
    if (type == LuaEnumAttributeType.MaxHp) then
        return "最大血量"
    elseif (type == LuaEnumAttributeType.MaxMp) then
        return "最大魔力"
    elseif (type == LuaEnumAttributeType.InnerPowerMax) then
        return "内力"
    elseif (type == LuaEnumAttributeType.PhyAttackMin) then
        return "攻击下限"
    elseif (type == LuaEnumAttributeType.PhyAttackMax) then
        return "攻击上限"
    elseif (type == LuaEnumAttributeType.MagicAttackMin) then
        return "攻击下限"
    elseif (type == LuaEnumAttributeType.MagicAttackMax) then
        return "攻击上限"
    elseif (type == LuaEnumAttributeType.TaoAttackMin) then
        return "攻击下限"
    elseif (type == LuaEnumAttributeType.TaoAttackMax) then
        return "攻击上限"
    elseif (type == LuaEnumAttributeType.PhyDefenceMin) then
        return "最小物防"
    elseif (type == LuaEnumAttributeType.PhyDefenceMax) then
        return "最大物防"
    elseif (type == LuaEnumAttributeType.MagicDefenceMin) then
        return "最小魔防"
    elseif (type == LuaEnumAttributeType.MagicDefenceMax) then
        return "最大魔防"
    elseif (type == LuaEnumAttributeType.Critical) then
        return "暴击"
    elseif (type == LuaEnumAttributeType.CriticalDamage) then
        return "爆伤"
    end
    return ""
end

---这里得到的只是一个特效的基础ID,还需要加上等级
---@param type LuaEquipmentItemType
---@param index 装备下标
function Utility.GetSLEquipIndexEffectID(type, index)
    local id = 0;
    if (index == LuaEquipmentItemType.POS_SL_WEAPON) then
        --武器
        id = 23010001
    elseif (index == LuaEquipmentItemType.POS_SL_HEAD) then
        --头盔
        id = 23020001
    elseif (index == LuaEquipmentItemType.POS_SL_CLOTHES) then
        --衣服
        id = 23030001
    elseif (index == LuaEquipmentItemType.POS_SL_NECKLACE) then
        --项链
        id = 23040001
    elseif (index == LuaEquipmentItemType.POS_SL_FABAO) then
        --法宝
        id = 23050001
    elseif (index == LuaEquipmentItemType.POS_SL_MEDAL) then
        --勋章
        id = 23060001
    elseif (index == LuaEquipmentItemType.POS_SL_LEFT_HAND) then
        --手镯
        id = 23070001
    elseif (index == LuaEquipmentItemType.POS_SL_RIGHT_HAND) then
        --手镯
        id = 23070001
    elseif (index == LuaEquipmentItemType.POS_SL_LEFT_RING) then
        --戒子
        id = 23080001
    elseif (index == LuaEquipmentItemType.POS_SL_RIGHT_RING) then
        --戒子
        id = 23080001
    end
    if (id == 0) then
        return ""
    end

    id = id + 1000 * type
    return tostring(id)
end
--endregion

--region 人物装备
---获取推荐的装备位
---@param bagItemInfo bagV2.BagItemInfo
---@return LuaEnumRecommendEquippedAvatarType,number
function Utility.GetRecommendEquippedIndex(bagItemInfo)
    if bagItemInfo == nil then
        return
    end
    ---@type TABLE.CFG_ITEMS
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if itemInfo == nil then
        return
    end
    local arrowType = Utility.GetArrowType(bagItemInfo)
    if arrowType == nil then
        return
    end
    ---推荐的目标
    local recommendAvatarType = nil
    ---推荐的装备位
    local recommendEquipIndex = nil
    ---灵兽可以穿的人物装备
    if CS.CSServantInfoV2.IsRoleEquipAvailableForServant(itemInfo) then
        recommendEquipIndex = CS.CSScene.MainPlayerInfo.BagInfo:GetUseEquipIndex(bagItemInfo)
        if arrowType == LuaEnumArrowType.NONE then
            ---没有箭头时,未打开角色和灵兽界面时,双击装备,只替换角色的装备
            recommendAvatarType = LuaEnumRecommendEquippedAvatarType.MainPlayer
        else
            ---@type bagV2.BagItemInfo
            local currentEquippedBagItem
            ___, currentEquippedBagItem = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(recommendEquipIndex)
            if (currentEquippedBagItem ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:EquipBaseAttributeCompare(currentEquippedBagItem, bagItemInfo) >= 0) then
                ---如果角色装备位上最差的装备位上的装备不为空且比当前处理的装备好,那么考虑装备到灵兽身上
                recommendAvatarType = Utility.GetEquipTargetType(bagItemInfo)
                recommendEquipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetRecommendedEquipIndexForRoleEquip(itemInfo, recommendAvatarType)
            else
                recommendAvatarType = LuaEnumRecommendEquippedAvatarType.MainPlayer
            end
        end
    end
    return recommendAvatarType, recommendEquipIndex
end

---对比人物通用装备
---@param leftBagItemInfo bagV2.BagItemInfo
---@param rightBagItemInfo bagV2.BagItemInfo
---@return number 1(left > right) 0(left == right) -1(left < right) -2(出错)
function Utility.ComparePlayerNormalEquip(leftBagItemInfo, rightBagItemInfo)
    if leftBagItemInfo == nil or rightBagItemInfo == nil or clientTableManager.cfg_itemsManager:IsSameItem(leftBagItemInfo.itemId, rightBagItemInfo.itemId) == false then
        return -2
    end
    local minAttackType = LuaEnumAttributeType.NULL
    local maxAttackType = LuaEnumAttributeType.NULL
    local mainPlayerCareer = gameMgr:GetLuaMainPlayer():GetCareer()
    if mainPlayerCareer == nil then
        return -2
    end
    if mainPlayerCareer == LuaEnumCareer.Warrior then
        minAttackType = LuaEnumAttributeType.PhyAttackMin
        maxAttackType = LuaEnumAttributeType.PhyAttackMax
    elseif mainPlayerCareer == LuaEnumCareer.Master then
        minAttackType = LuaEnumAttributeType.MagicAttackMin
        maxAttackType = LuaEnumAttributeType.MagicAttackMax
    elseif mainPlayerCareer == LuaEnumCareer.Taoist then
        minAttackType = LuaEnumAttributeType.TaoAttackMin
        maxAttackType = LuaEnumAttributeType.TaoAttackMax
    end
    ---攻击下限
    local leftEquipMinAttack = Utility.GetEquipTotalAttr(leftBagItemInfo, minAttackType,mainPlayerCareer)
    local rightEquipMinAttack = Utility.GetEquipTotalAttr(rightBagItemInfo, minAttackType,mainPlayerCareer)
    ---攻击上限
    local leftEquipMaxAttack = Utility.GetEquipTotalAttr(leftBagItemInfo, maxAttackType,mainPlayerCareer)
    local rightEquipMaxAttack = Utility.GetEquipTotalAttr(rightBagItemInfo, maxAttackType,mainPlayerCareer)
    ---对比总属性值
    local compareId = Utility.NumberCompare(leftEquipMinAttack + leftEquipMaxAttack, rightEquipMinAttack + rightEquipMaxAttack)
    if compareId ~= 0 then
        return compareId
    end
    ---对比攻击属性上限
    compareId = Utility.NumberCompare(leftEquipMaxAttack, rightEquipMaxAttack)
    if compareId ~= 0 then
        return compareId
    end
    ---物防下限
    local leftEquipMinPhyDefence = Utility.GetEquipTotalAttr(leftBagItemInfo, LuaEnumAttributeType.PhyDefenceMin,mainPlayerCareer)
    local rightEquipMinPhyDefence = Utility.GetEquipTotalAttr(rightBagItemInfo, LuaEnumAttributeType.PhyDefenceMin,mainPlayerCareer)
    ---物防上限
    local leftEquipMaxPhyDefence = Utility.GetEquipTotalAttr(leftBagItemInfo, LuaEnumAttributeType.PhyDefenceMax,mainPlayerCareer)
    local rightEquipMaxPhyDefence = Utility.GetEquipTotalAttr(rightBagItemInfo, LuaEnumAttributeType.PhyDefenceMax,mainPlayerCareer)
    ---魔防下限
    local leftEquipMinMagicDefence = Utility.GetEquipTotalAttr(leftBagItemInfo, LuaEnumAttributeType.MagicDefenceMin,mainPlayerCareer)
    local rightEquipMinMagicDefence = Utility.GetEquipTotalAttr(rightBagItemInfo, LuaEnumAttributeType.MagicDefenceMin,mainPlayerCareer)
    ---魔防上限
    local leftEquipMaxMagicDefence = Utility.GetEquipTotalAttr(leftBagItemInfo, LuaEnumAttributeType.MagicDefenceMax,mainPlayerCareer)
    local rightEquipMaxMagicDefence = Utility.GetEquipTotalAttr(rightBagItemInfo, LuaEnumAttributeType.MagicDefenceMax,mainPlayerCareer)
    ---对比总防御值
    local leftEquipTotalDefence = leftEquipMinPhyDefence + leftEquipMaxPhyDefence + leftEquipMinMagicDefence + leftEquipMaxMagicDefence
    local rightEquipTotalDefence = rightEquipMinPhyDefence + rightEquipMaxPhyDefence + rightEquipMinMagicDefence + rightEquipMaxMagicDefence
    compareId = Utility.NumberCompare(leftEquipTotalDefence, rightEquipTotalDefence)
    if compareId ~= 0 then
        return compareId
    end
    ---对比更好的防御值
    local leftEquipBetterDefence = math.max(leftEquipMinPhyDefence + leftEquipMaxPhyDefence, leftEquipMinMagicDefence + leftEquipMaxMagicDefence)
    local rightEquipBetterDefence = math.max(rightEquipMinPhyDefence + rightEquipMaxPhyDefence, rightEquipMinMagicDefence + rightEquipMaxMagicDefence)
    compareId = Utility.NumberCompare(leftEquipBetterDefence, rightEquipBetterDefence)
    if compareId ~= 0 then
        return compareId
    end
    ---对比更好的防御最大值
    local leftEquipBetterMaxDefence = math.max(leftEquipMaxPhyDefence, leftEquipMaxMagicDefence)
    local rightEquipBetterMaxDefence = math.max(rightEquipMaxPhyDefence, rightEquipMaxMagicDefence)
    compareId = Utility.NumberCompare(leftEquipBetterMaxDefence, rightEquipBetterMaxDefence)
    if compareId ~= 0 then
        return compareId
    end
    ---基础数值
    local leftItemTbl = Utility.GetItemTblByBagItemInfo(leftBagItemInfo)
    local rightItemTbl = Utility.GetItemTblByBagItemInfo(rightBagItemInfo)
    if leftItemTbl == nil or rightItemTbl == nil then
        return -2
    end
    ---对比转生需求
    compareId = Utility.NumberCompare(leftItemTbl:GetReinLv(), rightItemTbl:GetReinLv())
    if compareId ~= 0 then
        return compareId
    end
    ---对比等级需求
    compareId = Utility.NumberCompare(leftItemTbl:GetUseLv(), rightItemTbl:GetUseLv())
    return compareId
end
--endregion

--region 根据itemId获得这个装备应该装备的装备位
---@public
---@param itemId number 道具id
---@return table<number,LuaEquipmentItemType> 根据itemId获得这个装备应该装备的装备位列表
function Utility.GetEquipIndexByItemId(itemId)
    local aim = {}
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if luaItemInfo and luaItemInfo:GetType() == luaEnumItemType.Equip then
        local subType = luaItemInfo:GetSubType()
        if subType then
            if subType == LuaEnumEquipSubType.Equip_wuqi then
                table.insert(aim, LuaEquipmentItemType.POS_WEAPON)
            elseif subType == LuaEnumEquipSubType.Equip_toukui then
                table.insert(aim, LuaEquipmentItemType.POS_HEAD)
            elseif subType == LuaEnumEquipSubType.Equip_yifu then
                table.insert(aim, LuaEquipmentItemType.POS_CLOTHES)
            elseif subType == LuaEnumEquipSubType.Equip_yaodai then
                table.insert(aim, LuaEquipmentItemType.POS_BELT)
            elseif subType == LuaEnumEquipSubType.Equip_xiezi then
                table.insert(aim, LuaEquipmentItemType.POS_SHOES)
            elseif subType == LuaEnumEquipSubType.Equip_xianglian then
                table.insert(aim, LuaEquipmentItemType.POS_NECKLACE)
            elseif subType == LuaEnumEquipSubType.Equip_face then
                table.insert(aim, LuaEquipmentItemType.POS_FACE)
            elseif subType == LuaEnumEquipSubType.Equip_jiezhi then
                table.insert(aim, LuaEquipmentItemType.POS_LEFT_RING)
                table.insert(aim, LuaEquipmentItemType.POS_RIGHT_RING)
            elseif subType == LuaEnumEquipSubType.Equip_shouzhuo then
                table.insert(aim, LuaEquipmentItemType.POS_LEFT_HAND)
                table.insert(aim, LuaEquipmentItemType.POS_RIGHT_HAND)
            elseif subType == LuaEnumEquipSubType.Equip_yuanlingmibao then
                table.insert(aim, LuaEquipmentItemType.POS_POS_RAWANIMAHEAD)
            elseif subType == LuaEnumEquipSubType.Equip_chiyandeng then
                table.insert(aim, LuaEquipmentItemType.POS_LAMP)
            elseif subType == LuaEnumEquipSubType.Equip_hunyu then
                table.insert(aim, LuaEquipmentItemType.POS_SOULJADE)
            elseif subType == LuaEnumEquipSubType.Equip_baoshishoutao then
                table.insert(aim, LuaEquipmentItemType.POS_GEMGLOVE)
            elseif subType == LuaEnumEquipSubType.Equip_xunzhang or subType == LuaEnumEquipSubType.Equip_doublexunzhang then
                table.insert(aim, LuaEquipmentItemType.POS_MEDAL)
            elseif subType == LuaEnumEquipSubType.Equip_seal then
                table.insert(aim, LuaEquipmentItemType.POS_SEAL)
            elseif subType == LuaEnumEquipSubType.Equip_hufu then
                table.insert(aim, LuaEquipmentItemType.POS_HUFU)
            end
        end
    end
    return aim
end
--endregion

---请求穿装备
---@param BagItemInfo bagV2.BagItemInfo
function Utility.ReqEquipItem(BagItemInfo)
    networkRequest.ReqPutOnTheEquip(BagItemInfo.ItemTABLE.subType, BagItemInfo.lid)
end


---@class AttributeDesParams 属性描述参数
---@field attributeType LuaEnumAttributeType 属性类型
---@field minAttributeType LuaEnumEquipSubType 最小属性类型
---@field maxAttributeType LuaEnumEquipSubType 最大属性类型
---@field bagItemInfo bagV2.BagItemInfo 背包物品数据
---@field itemInfo TABLE.cfg_items 道具信息
---@field desColor string 描述内容颜色
---@field career LuaEnumCareer 职业

---获取属性描述
---@param attributeDesParams AttributeDesParams
---@return string,string 属性描述内容，属性值描述内容
function Utility.GetAttributeDes(attributeDesParams)
    if attributeDesParams == nil or (attributeDesParams.attributeType == nil and attributeDesParams.maxAttributeType == nil and attributeDesParams.minAttributeType == nil) or (attributeDesParams.bagItemInfo == nil and attributeDesParams.itemInfo == nil) then
        return
    end
    --基础数据
    local bagItemInfo = attributeDesParams.bagItemInfo
    local itemInfo = attributeDesParams.itemInfo
    local minAttributeType = attributeDesParams.minAttributeType
    local maxAttributeType = attributeDesParams.maxAttributeType
    if attributeDesParams.attributeType ~= nil then
        maxAttributeType = attributeDesParams.attributeType
    end
    if itemInfo == nil then
        itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    end
    local attributeValueDesInputData = ternary(bagItemInfo == nil,itemInfo,bagItemInfo)
    --数据解析
    local attributeName = Utility.GetAttributeName(maxAttributeType)
    local attributeValueDes = Utility.GetAttributeValueDes(attributeValueDesInputData,minAttributeType,maxAttributeType,attributeDesParams.career)
    local rateAttributeDes = Utility.GetRateAttributeDes(bagItemInfo,minAttributeType,maxAttributeType)
    local desColor = clientTableManager.cfg_property_nameManager:GetAttributeColor(itemInfo:GetId(),maxAttributeType)
    if attributeDesParams.desColor ~= nil then
        desColor = attributeDesParams.desColor
    elseif CS.StaticUtility.IsNullOrEmpty(rateAttributeDes) == false then
        desColor = luaEnumColorType.Green2
    elseif CS.StaticUtility.IsNullOrEmpty(desColor) then
        desColor = luaEnumColorType.White
    end
    if CS.StaticUtility.IsNullOrEmpty(desColor) or CS.StaticUtility.IsNullOrEmpty(attributeName) or CS.StaticUtility.IsNullOrEmpty(attributeValueDes) then
        return
    end
    --数据合并
    local curAttributeNameDes = desColor .. attributeName .. "[-]"
    local curAttributeValueDes = desColor .. attributeValueDes .. rateAttributeDes
    return curAttributeNameDes,curAttributeValueDes
end

---获取属性值描述
---@param bagItemInfo bagV2.BagItemInfo 背包物品数
---@param minAttributeType LuaEnumEquipSubType 最小属性类型
---@param maxAttributeType LuaEnumEquipSubType 最小属性类型
---@param career LuaEnumCareer 职业
function Utility.GetAttributeValueDes(bagItemInfo,minAttributeType,maxAttributeType,career)
    if bagItemInfo == nil or (minAttributeType == nil and maxAttributeType == nil) then
        return ""
    end
    local minTotalAttributeValue = Utility.GetEquipTotalAttr(bagItemInfo,minAttributeType,career)
    local maxTotalAttributeValue = Utility.GetEquipTotalAttr(bagItemInfo,maxAttributeType,career)
    if minTotalAttributeValue > 0 and maxTotalAttributeValue > 0 then
        return tostring(minTotalAttributeValue) .. ' - ' .. tostring(maxTotalAttributeValue)
    elseif minTotalAttributeValue > 0 then
        return tostring(minTotalAttributeValue)
    elseif maxTotalAttributeValue > 0 then
        return tostring(maxTotalAttributeValue)
    end
    return ""
end

---获取浮动属性描述
---@param bagItemInfo bagV2.BagItemInfo 背包物品数
---@param minAttributeType LuaEnumEquipSubType 最小属性类型
---@param maxAttributeType LuaEnumEquipSubType 最小属性类型
function Utility.GetRateAttributeDes(bagItemInfo,minAttributeType,maxAttributeType)
    if bagItemInfo == nil or (minAttributeType == nil and maxAttributeType == nil) then
        return ""
    end
    local minAttributeValue = Utility.GetRateAttribute(bagItemInfo,minAttributeType)
    local maxAttributeValue = Utility.GetRateAttribute(bagItemInfo,maxAttributeType)
    if maxAttributeValue > 0 then
        return "(+" .. tostring(maxAttributeValue) .. ")[-]"
    end
    return ""
end