---玩家的血继装备数据类
---@class LuaPlayerEquipBloodSuitListData
local LuaPlayerEquipBloodSuitListData = {}

---装备套装类型
---@type LuaEquipmentListType
LuaPlayerEquipBloodSuitListData.type = nil

---@type table<LuaEquipBloodSuitItemType,LuaEquipDataBloodSuitItem>
LuaPlayerEquipBloodSuitListData.SingleBloodSuitDic = nil

---已经穿戴的血继数量
---@type table<LuaEquipBloodSuitItemType,LuaEquipDataBloodSuitItem>
LuaPlayerEquipBloodSuitListData.equippedBloodSuit = nil

LuaPlayerEquipBloodSuitListData.ServantCount = nil

---@param type LuaEquipmentListType 套装类型
function LuaPlayerEquipBloodSuitListData:Init(type)
    self.type = type
    self.ServantCount = 0
    self.equippedBloodSuit = {}
    self:InitSuitAttribute();
end

---初始化血继数据
---@param tblData bagV2.BagItemInfo
---@param pos LuaEquipBloodSuitItemType
function LuaPlayerEquipBloodSuitListData:RefreShData(tblData, pos)
    if self.SingleBloodSuitDic == nil then
        ---@type table<LuaEquipBloodSuitItemType,LuaEquipDataBloodSuitItem>
        self.SingleBloodSuitDic = {}
    end
    if self.SingleBloodSuitDic[pos] == nil then
        self.SingleBloodSuitDic[pos] = luaclass.LuaEquipDataBloodSuitItem:New()
    end
    self.SingleBloodSuitDic[pos]:RefreShData(tblData, pos)
    if (tblData ~= nil) then
        self.equippedBloodSuit[pos] = self.SingleBloodSuitDic[pos]
    else
        self.equippedBloodSuit[pos] = nil
    end
    self:UpdateDivineSuitAddition()
end

---清理数据
function LuaPlayerEquipBloodSuitListData:CleanData()
    if self.SingleBloodSuitDic == nil then
        return
    end
    for i, v in pairs(self.SingleBloodSuitDic) do
        if v ~= nil then
            v:RevertData()
        end
    end
end

---得到对应装备位上面的装备数据
---@param  index 装备位ID
---@return LuaEquipDataBloodSuitItem
function LuaPlayerEquipBloodSuitListData:GetBloodSuitItem(index)
    if LuaPlayerEquipBloodSuitListData.BloodSuitDic == nil then
        return nil
    end
    return LuaPlayerEquipBloodSuitListData.BloodSuitDic[index]
end

---@type table<LuaEquipBloodSuitItemType,LuaEquipDataBloodSuitItem>
function LuaPlayerEquipBloodSuitListData:GetAllEquippedBloodSuit()
    return self.equippedBloodSuit
end

---@class BloodSuitAttributeData
---@field attributeType LuaEnumAttributeType 属性类型
---@field min number 最低属性
---@field max number 最高属性
---@field sort number 顺序

---得到当前血继套装的总属性
---@return table<LuaEnumAttributeType,BloodSuitAttributeData>
function LuaPlayerEquipBloodSuitListData:GetBloodSuitAttribute()
    ---这个是所有穿戴的列表
    local equippedBloodSuit = self:GetAllEquippedBloodSuit()
    if (equippedBloodSuit == nil) then
        return nil
    end
    ---@type table<number,BloodSuitAttributeData>
    local allAttribute = {}
    for i, v in pairs(equippedBloodSuit) do
        ---@type LuaEquipDataBloodSuitItem
        local temp = v;
        ---@type bagV2.BagItemInfo
        local bagItemInfo = temp.BagItemInfo
        if bagItemInfo then
            for i = 1, #uiStaticParameter.mBloodSuitUseData do
                local attributeType = uiStaticParameter.mBloodSuitUseData[i]
                local attributeName, min, max = Utility.GetBloodSuitEquipAttribute(bagItemInfo.itemId, bagItemInfo.bloodLevel, attributeType)
                local data = allAttribute[attributeType]
                if data == nil then
                    data = {}
                    data.attributeType = attributeType
                    data.sort = i
                    if min then
                        data.min = 0
                    end
                    if max then
                        data.max = 0
                    end
                    allAttribute[attributeType] = data
                end
                if min then
                    data.min = data.min + min
                end
                if max then
                    data.max = data.max + max
                end
            end
        end
    end
    return allAttribute
end

--region 套装激活

---@type table<number:血继装备的等级, number:这个等级血继装备的数量(向上获取)>
LuaPlayerEquipBloodSuitListData.ActivateSuitLevelDic = nil

---套装更新属性加成(每次装备变动的时候,会去更新)
function LuaPlayerEquipBloodSuitListData:UpdateDivineSuitAddition()
    self.mCurrentMaxLevel = 0
    self.ActivateSuitLevelDic = {};
    self.ServantCount = 0
    local equippedBloodSuit = self:GetAllEquippedBloodSuit()
    for i, v in pairs(equippedBloodSuit) do
        ---@type LuaEquipDataBloodSuitItem
        local item = v;
        if item.BagItemInfo then
            local baseIndex = math.floor(item.BagItemInfo.index % 1000)
            if (baseIndex ~= 109 and baseIndex ~= 110 and baseIndex ~= 111 and baseIndex ~= 112) then
                --脑心骨血
                self.ServantCount = self.ServantCount + 1
            end

            ---激活属性的时候,高等级装备覆盖低等级   例如  12件1级属性   当你存在11件0级装备  1件1级装备的时候  属性计算会认为存在 12件0级  1件1级
            for i = 0, item.BagItemInfo.bloodLevel do
                local level = i

                if (self.ActivateSuitLevelDic[level] == nil) then
                    self.ActivateSuitLevelDic[level] = 1
                else
                    self.ActivateSuitLevelDic[level] = self.ActivateSuitLevelDic[level] + 1
                end
            end
        end
    end
end

---得到套装的激活数量
---传入血继等级
function LuaPlayerEquipBloodSuitListData:GetSuitActivateCount(level)
    if (self.ActivateSuitLevelDic == nil) then
        return 0
    end
    local num = self.ActivateSuitLevelDic[level]
    if num == nil then
        num = 0
    end
    return num
end

---@return number 获取当前套装等级
function LuaPlayerEquipBloodSuitListData:GetCurrentMaxSuitLevel()
    if self.mCurrentMaxLevel == nil then
        return 0
    end
    return self.mCurrentMaxLevel
end

LuaPlayerEquipBloodSuitListData.ActivateSkill = nil
LuaPlayerEquipBloodSuitListData.ActivateSkillConditions = nil
---激活套装的属性
function LuaPlayerEquipBloodSuitListData:InitSuitAttribute()
    if (self.type == nil) then
        return
    end
    local BloodSuit = clientTableManager.cfg_bloodsuit_combinationManager:TryGetValue(self.type)
    if BloodSuit == nil then
        return
    end
    local skillID = BloodSuit:GetGroupSkill().list[1]
    self.ActivateSkillConditions = {}

    local isFindSkill, skill = CS.Cfg_SkillTableManager.Instance:TryGetValue(skillID);
    if (isFindSkill) then
        self.ActivateSkill = skill;
    end
    for i = 1, 5 do
        ---血继套装会有5个等级技能,分别对应不同的属性
        local data = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillID, i);
        if (data ~= nil) then
            table.insert(self.ActivateSkillConditions, data);
        end
    end
end

--endregion

return LuaPlayerEquipBloodSuitListData