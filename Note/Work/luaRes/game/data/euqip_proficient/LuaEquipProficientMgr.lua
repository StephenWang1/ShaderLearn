---@class LuaEquipProficientMgr 装备精通数据
local LuaEquipProficientMgr = {}

---@class LuaProficientItem
---@field baseIndex number 类型
---@field type number 类型
---@field level number 等级
---@field maxLevel number 最大等级
---@field tbl TABLE.cfg_equip_proficient 装备精通数据
---@field nextTbl TABLE.cfg_equip_proficient 装备精通数据
---@field needCheckRoleEquip boolean 是否需要去人物身上查找装备位

---@type table<number, LuaProficientItem>
LuaEquipProficientMgr.ProficientTypeList = nil

---道具表的SubType对应的专精的类型
---@type table<number, number>
LuaEquipProficientMgr.ProficientTypeDicByItemSubType = nil

---总等级
---@type number
LuaEquipProficientMgr.AllLevel = 0

---初始化
function LuaEquipProficientMgr:Init()
    self:InitProficientTypeList()
end

---从表中遍历,获取到所有类型的技能
function LuaEquipProficientMgr:InitProficientTypeList()
    self.RedActive=false
    self.ProficientTypeList = {}
    self.AllLevel = 0
    clientTableManager.cfg_equip_proficientManager:ForPair(function(key, value)
        ---@type TABLE.cfg_equip_proficient
        local equip_proficient = value

        local type = equip_proficient:GetType()
        local level = equip_proficient:GetLevel();

        if (self.ProficientTypeList[type] == nil) then
            ---@type LuaProficientItem
            self.ProficientTypeList[type] = {}
            self.ProficientTypeList[type].level = 0
            self.ProficientTypeList[type].maxLevel = 0
            self.ProficientTypeList[type].type = type

            if (type == 11) then
                self.ProficientTypeList[type].needCheckRoleEquip = LuaEquipmentItemType.POS_LAMP
            elseif (type == 12) then
                self.ProficientTypeList[type].needCheckRoleEquip = LuaEquipmentItemType.POS_SOULJADE
            elseif (type == 13) then
                self.ProficientTypeList[type].needCheckRoleEquip = LuaEquipmentItemType.POS_MEDAL
            elseif (type == 14) then
                self.ProficientTypeList[type].needCheckRoleEquip = LuaEquipmentItemType.POS_GEMGLOVE
            elseif (type == 15) then
                self.ProficientTypeList[type].needCheckRoleEquip = LuaEquipmentItemType.POS_RAWANIMA
            end
        end
        if (level == 1) then
            self.ProficientTypeList[type].nextTbl = equip_proficient
            self.ProficientTypeList[type].baseIndex = equip_proficient:GetId() - 1
        end

        if (self.ProficientTypeList[type].maxLevel < level) then
            self.ProficientTypeList[type].maxLevel = level;
        end

    end);
end

---@param tblData skillV2.AllEquipProficientInfo lua table类型消息数据
function LuaEquipProficientMgr:ResProficientInfo(tblData)
    if (tblData == nil or tblData.infos == nil) then
        return
    end
    ---已学习的ID
    ---@param info skillV2.EquipProficientInfo
    for i, info in pairs(tblData.infos) do
        self:ResEquipProficientInfoMessage(info);
    end
end

---@param tblData skillV2.EquipProficientInfo lua table类型消息数据
function LuaEquipProficientMgr:ResEquipProficientInfoMessage(tblData)
    if (tblData == nil) then
        return
    end
    if (self.ProficientTypeDicByItemSubType == nil) then
        self.ProficientTypeDicByItemSubType = {}
        self.ProficientTypeDicByItemSubType[51] = 6
        self.ProficientTypeDicByItemSubType[61] = 8
    end

    ---已学习的ID
    ---@type TABLE.cfg_equip_proficient
    local tbl = clientTableManager.cfg_equip_proficientManager:TryGetValue(tblData.id);
    if (tbl == nil) then
        CS.UnityEngine.Debug.LogError("服务器发了一个不存在的装备精通ID:" .. tostring(tblData.id));
    else
        local type = tbl:GetType()
        local level = tbl:GetLevel();

        if (self.ProficientTypeList[type] == nil) then
            CS.UnityEngine.Debug.LogError("没有在初始化的时候初始化装备精通类型:" .. tostring(type))
        else
            self.AllLevel = self.AllLevel + (level - self.ProficientTypeList[type].level)
            self.ProficientTypeList[type].level = level;
            self.ProficientTypeList[type].tbl = tbl;
            self.ProficientTypeList[type].nextTbl = clientTableManager.cfg_equip_proficientManager:TryGetValue(tblData.id + 1);
        end
        if (tbl:GetSubtype() ~= nil and tbl:GetSubtype().list ~= nil) then
            local list = tbl:GetSubtype().list
            for i, subType in pairs(list) do
                if (tbl:GetType() ~= 6
                        and tbl:GetType() ~= 8) then
                    self.ProficientTypeDicByItemSubType[subType] = tbl:GetType()
                end
            end
        end
    end

end

---@return table<number, LuaProficientItem>
function LuaEquipProficientMgr:GetProficientList()
    return self.ProficientTypeList
end

---@return LuaProficientItem
function LuaEquipProficientMgr:GetProficientData(id)
    local tbl = clientTableManager.cfg_equip_proficientManager:TryGetValue(id);
    if (tbl == nil) then
        CS.UnityEngine.Debug.LogError("服务器发了一个不存在的装备精通ID:" .. tostring(id));
    else
        local type = tbl:GetType()

        return self.ProficientTypeList[type]
    end
end

---@param bagItemInfo bagV2.BagItemInfo
---@return TABLE.cfg_equip_proficient
function LuaEquipProficientMgr:GetProficientDataByBagItemInfo(bagItemInfo)
    if (self.ProficientTypeDicByItemSubType == nil) then
        return nil
    end

    ---@type TABLE.cfg_items
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    local type = bagItemInfo.index == 0 and itemTbl:GetSubType() or bagItemInfo.index
    type = self.ProficientTypeDicByItemSubType[type]
    if (type == nil) then
        return nil
    end
    ---@type LuaProficientItem
    local ProficientItem = self.ProficientTypeList[type]
    if (ProficientItem == nil) then
        return nil
    end
    local canTakeEffectProficient = nil
    for i = ProficientItem.level, 1, -1 do
        ---@type TABLE.cfg_equip_proficient
        local tbl = clientTableManager.cfg_equip_proficientManager:TryGetValue(ProficientItem.baseIndex + i);
        if (itemTbl:GetUseLv() >= tbl:GetLevelLimit() and itemTbl:GetReinLv() >= tbl:GetReinlLimit()) then
            canTakeEffectProficient = tbl
            break
        end
    end

    return canTakeEffectProficient
end

---@type LuaProficientItem
function LuaEquipProficientMgr:GetProficientDataByType(type)

    return self.ProficientTypeList[type]
end

---@type table<LuaMaterialData>
LuaEquipProficientMgr.CostMaterialDataList = {}


---@param items table<number,number> 指定刷新的道具ID列表
---@param isOnlyDetermineLevel boolean 是否只刷新等级
function LuaEquipProficientMgr:CallRed(items, isOnlyDetermineLevel)
    local nowRedActive = self:CalculateRed(items, isOnlyDetermineLevel)
    if self.RedActive ~= nowRedActive then
        local Equip_Proficient = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Equip_Proficient);
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(Equip_Proficient);
        ---红点显示状态
        self.RedActive = nowRedActive
    end
end

---计算红点
---@param items table<number,number> 指定刷新的道具ID列表
---@param isOnlyDetermineLevel boolean 是否只刷新等级
function LuaEquipProficientMgr:CalculateRed(items, isOnlyDetermineLevel)
    ---如果系统没开启则关闭红点
    if self:IsOpenSystem() == false then
        return false
    end
    if isOnlyDetermineLevel == nil then
        isOnlyDetermineLevel = false
    end
    ---@param MaterialData LuaMaterialData
    for i, MaterialData in pairs(self.CostMaterialDataList) do
        if (items ~= nil) then
            ---@type item bagV2.BagItemInfo
            for j, item in pairs(items) do
                if (MaterialData:IsExitMaterial(item.itemId)) then
                    MaterialData:Reset()
                end
            end
        else
            MaterialData:Reset()
        end
    end

    ---@type table<number, LuaProficientItem>
    local list = self:GetProficientList()
    ---遍历所有专精
    ---@param proficientItem LuaProficientItem
    for i, proficientItem in pairs(list) do
        ---@type TABLE.cfg_equip_proficient
        local tbl = proficientItem.nextTbl

        ---拿到升级下一家的专精表(用来判断是否能升级)
        if (tbl ~= nil) then
            --region 判定是否满足升级条件
            ---@type table<number>
            local conditionList = tbl:GetCondition().list
            ---@type LuaMatchConditionResult
            local errorResult = nil
            for i, conditionId in pairs(conditionList) do
                ---@type LuaMatchConditionResult
                local result = Utility.IsMainPlayerMatchCondition(conditionId)
                if (result.success == false) then
                    errorResult = result
                    break ;
                end
            end
            --endregion

            local isMeetMaterial = true
            --region 判定是否满足道具消耗 (注意只有当上级条件能满足的时候,再去判定材料消耗   因为材料消耗的查询比条件判定大) 只刷新等级的时候不进行道具获取刷新
            if (errorResult == nil) then
                ---获取消耗
                local itemCostItem = proficientItem.nextTbl:GetCost()
                if (itemCostItem ~= nil and itemCostItem.list ~= nil) then
                    ---@param list table<number, table<number>>
                    for i, list in pairs(itemCostItem.list) do
                        local itemId = list.list[1]
                        local needCount = list.list[2]
                        if (self.CostMaterialDataList[itemId] == nil) then
                            self.CostMaterialDataList[itemId] = luaclass.LuaMaterialData:New()
                            self.CostMaterialDataList[itemId]:GenerateData(itemId)
                        end
                        ---@type LuaMaterialData
                        local MaterialData = self.CostMaterialDataList[itemId]
                        ---当前所有位置的材料数量
                        local count = MaterialData:GetMaterialCount(LuaItemSavePos.Bag, true)
                        if (count < needCount) then
                            isMeetMaterial = false
                            break ;
                        end
                    end
                end
            end
            --endregion

            if (errorResult == nil and isMeetMaterial) then
                return true
            end
        end
    end
    return false
end

---是否开启专精系统
function LuaEquipProficientMgr:IsOpenSystem()
    if self.noticeTable == nil then
        self.noticeTable = clientTableManager.cfg_noticeManager:TryGetValue(69)
    end
    if self.noticeTable == nil then
        return false
    end
    local conditionIds = self.noticeTable:GetOpenCondition()
    if conditionIds == nil or conditionIds.list == nil then
        return true
    end
    for i = 0, conditionIds.list.Count - 1 do
        local v = conditionIds.list[i]
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) then
            return false
        end
    end
    return true
end

return LuaEquipProficientMgr;