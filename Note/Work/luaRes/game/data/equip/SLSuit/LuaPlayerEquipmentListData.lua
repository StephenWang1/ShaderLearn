---玩家的装备数据类(这里面包括了人物的基本装备列表以及神力套装列表)
---@class LuaPlayerEquipmentListData
local LuaPlayerEquipmentListData = {}

---装备列表类型@
---@type LuaEquipmentListType
LuaPlayerEquipmentListData.EquipmentListType = LuaEquipmentListType.Base

---当前装备列表的字典
---@type table<LuaEquipDataItem>
LuaPlayerEquipmentListData.EquipmentDic = nil

---一个套装的最大数量
--LuaPlayerEquipmentListData.SuitEquipMaxCount = 0;

---所有套装数据加载
---@type table<number,LuaEquipSuitAdditionItem> subType
LuaPlayerEquipmentListData.AllSuitAddition = nil;

---已激活的等级数量字典
---@type table<number<number,number> <subType,<套装等级,数量>>
LuaPlayerEquipmentListData.ActivateEquipLevelDic = nil

---是否进行过设置
LuaPlayerEquipmentListData.IsActivate = nil

---初始化套装的数据类型
---在divineSuit表中,ID的填写规则为(类型*1000+套装等级)  所以每件套装的第一级ID为type*1000+1
---@param subtype number 套装子类型
function LuaPlayerEquipmentListData:InitDivineSuit(type, subtype)
    self.EquipmentDic = {}
    self.EquipmentListType = type;

    self.AllSuitAddition = {}
    self.ActivateEquipLevelDic = {}

    self:RefreshDivineSuit(type, subtype)
end

---刷新套装的数据类型
---在divineSuit表中,ID的填写规则为(类型*1000+套装等级)  所以每件套装的第一级ID为type*1000+1
---@param subtype number 套装子类型
function LuaPlayerEquipmentListData:RefreshDivineSuit(type, subtype)
    if (type == LuaEquipmentListType.Base) then
        --这个类型属于正常的装备,和套装无关
        return ;
    end
    if (self.AllSuitAddition == nil) then
        self.AllSuitAddition = {}
    end
    subtype = subtype ~= nil and subtype or 1
    ---下面开始初始化这个套装的激活数据,在初始化的阶段,直接先获取到默认状态下1级的所有激活属性
    ---(后续的套装升级只是每个属性进行升级,但是属性的数量不会发生变化,所以在这里直接初始化属性加成的table,避免后续反复new)
    ---@type table<number:激活所需数量, number:激活属性TABLE.cfg_divinesuitattribute的ID>
    local AllSuitAdditionTbl = clientTableManager.cfg_divinesuitattributeManager.GetDivineSuitAddition(type + subtype - 1, 1, 999)
    local temAllSuitAddition = {}
    for activeCount, ActiveAttributeID in pairs(AllSuitAdditionTbl) do
        ---@type LuaEquipSuitAdditionItem
        local SuitAdditionItem = luaclass.LuaEquipSuitAdditionItem:New()
        SuitAdditionItem:InitData(type, 1, activeCount, ActiveAttributeID, subtype)
        table.insert(temAllSuitAddition, SuitAdditionItem)
    end
    self.AllSuitAddition[subtype] = temAllSuitAddition
    table.sort(self.AllSuitAddition[subtype], function(a, b)
        return a.ActivateLimitCount < b.ActivateLimitCount
    end)
end

function LuaPlayerEquipmentListData:Activate()
    self.IsActivate = true
end

--region 装备列表的基础数据  里面包含的列表装备的穿戴/卸载后的处理  外部对这些数据的获取操作

---插入装备数到指定列表清单中 神力套装的下标格式为100000 +(1000 * 套装类型) + subType
---@param index LuaEquipmentItemType 装备所在基础下标值
---@param bagItemInfo bagV2.BagItemInfo 道具数据信息
function LuaPlayerEquipmentListData:SetEquipItem(index, bagItemInfo)
    if (self.EquipmentDic[index] == nil) then
        self.EquipmentDic[index] = luaclass.LuaEquipDataItem:New()
    end
    ---@type LuaEquipDataItem
    local equipItem = self.EquipmentDic[index];
    equipItem:SetEquipData(bagItemInfo)
    --装备发生了变动,更新套装的属性加成
    self:UpdateDivineSuitAddition(index);
end

---获取到这个装备列表下的所有
---@return table<LuaEquipDataItem>
function LuaPlayerEquipmentListData:GetAllEquips()
    return self.EquipmentDic
end

---获取到这个装备列表下的某个装备
---@param index number lua枚举 装备的完成下标值
---@return LuaEquipDataItem
function LuaPlayerEquipmentListData:GetEquipItem(index)
    return self.EquipmentDic[index]
end

---获取到这个装备列表下的某个装备
---@param index LuaEquipmentItemType lua枚举 装备的下标值
---@return LuaEquipDataItem
function LuaPlayerEquipmentListData:GetEquipItemByBasicIndex(index)
    if (self.EquipmentListType ~= LuaEquipmentListType.Base) then
        index = Utility.GetSLEquipIndex(self.EquipmentListType, index)
    end
    return self.EquipmentDic[index]
end

--endregion

--region 套装


---套装更新属性加成(每次装备变动的时候,会去更新)  注意下,这个更新套装加成的方法后期需要去优化下,现在先这样而已,功能没有问题,但是会导致额外的性能消耗
---@param index number 装备下标,用来判定是添加,移除,还是替换的处理
function LuaPlayerEquipmentListData:UpdateDivineSuitAddition(index)
    if (self.EquipmentListType == LuaEquipmentListType.Base) then
        --普通装备没有套装属性
        return
    end

    -----先写简单一点,循环条件10件装备最多也50次循环
    --for i, v in pairs(self.ActivateEquipLevelDic) do
    --    v = 0
    --end
    self.ActivateEquipLevelDic = {}
    ---循环所有的装备栏
    for i, v in pairs(self.EquipmentDic) do
        ---@type LuaEquipDataItem
        local equip = v
        if (equip.BagItemInfo ~= nil) then
            ---@type TABLE.cfg_divinesuit
            local suitData = equip:GetSuitData();
            if suitData then
                local level = suitData:GetLevel();
                local subtype = suitData:GetSubType()

                ---当前子类型已激活的等级数量字典
                local temActivateEquipLevelDic = self.ActivateEquipLevelDic[subtype]
                temActivateEquipLevelDic = temActivateEquipLevelDic ~= nil and temActivateEquipLevelDic or {}

                for i = 1, level do
                    if (temActivateEquipLevelDic[i] == nil) then
                        temActivateEquipLevelDic[i] = 0
                    end
                    temActivateEquipLevelDic[i] = temActivateEquipLevelDic[i] + 1
                end
                self.ActivateEquipLevelDic[subtype] = temActivateEquipLevelDic
            end
        end
    end

    for subType, v in pairs(self.AllSuitAddition) do
        for i, j in pairs(v) do
            ---@type LuaEquipSuitAdditionItem
            local SuitAdditionItem = j
            if (SuitAdditionItem ~= nil) then
                SuitAdditionItem:SetActivateData(self.ActivateEquipLevelDic[subType])
            end
        end
    end
end

---@param index number 装备下标,用来判定是添加,移除,还是替换的处理
---@param bagItemInfo bagV2.BagItemInfo 道具数据信息
---设置激活道具
function LuaPlayerEquipmentListData:SetActivateItem(index, bagItemInfo)
    if (bagItemInfo ~= nil) then
        self.ActivateEquips[index] = bagItemInfo;
        local DivineId = bagItemInfo.ItemTABLE:GetDivineId()
        self.ActivateEquipDivineSuit[index] = clientTableManager.cfg_divinesuitManager:TryGetValue(DivineId)
    else
        self.ActivateEquipDivineSuit[index] = nil
    end
    for i, v in pairs(self.ActivateEquipDivineSuit) do
        ---@type TABLE.cfg_divinesuit
        local tbl = v
        local count = self.SetActivateItemCache[tbl:GetLevel()]
        if (count == nil) then
            count = 0
            self.SetActivateItemCache[tbl:GetLevel()] = count
        end
        self.SetActivateItemCache[tbl:GetLevel()] = count + 1
    end
end

---得到满足套装等级数量的装备
---@return table<LuaEquipDataItem> 满足套装等级的装备
function LuaPlayerEquipmentListData:GetMeetSuitLevelEquip(level)
    local meetList = {}
    for i, v in pairs(self.EquipmentDic) do
        ---@type TABLE.cfg_divinesuit
        local suitData = v:GetSuitData();
        if (suitData:GetLevel() >= level) then
            table.insert(meetList, v)
        end
    end
    return meetList
end

---得到当前套装的加成数据列表(这个列表里面会包含着已激活以及未激活的,只要去显示就好了)
---@param subtype number 套装子类型
---@return table<LuaEquipSuitAdditionItem>
function LuaPlayerEquipmentListData:GetAdditionDataList(subtype)
    if (self.AllSuitAddition == nil) then
        return nil
    end
    subtype = subtype ~= nil and subtype or 1
    return self.AllSuitAddition[subtype];
end

--endregion

return LuaPlayerEquipmentListData