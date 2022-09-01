---@class LuaPlayerBloodSuitResonanceItem
local LuaPlayerBloodSuitResonanceItem = {}

---初始化
---@param table TABLE.cfg_bloodsuit_resonance
function LuaPlayerBloodSuitResonanceItem:Init(table)
    if table == nil then
        self:RevertData()
        return
    end
    ---@type TABLE.cfg_bloodsuit_resonance
    self.bloodsuit_resonance = table
end

---得到血继套装表
function LuaPlayerBloodSuitResonanceItem:GetBloodsuitResonanceTable()
    return self.bloodsuit_resonance
end

---得到道具表
---@return TABLE.cfg_items
function LuaPlayerBloodSuitResonanceItem:GetItemTable()
    if self.mItemTable == nil and self.bloodsuit_resonance ~= nil then
        self.mItemTable = clientTableManager.cfg_itemsManager:TryGetValue(self.bloodsuit_resonance:GetItemid())
    end
    return self.mItemTable
end

---得到没有颜色的道具名称
---@return string
function LuaPlayerBloodSuitResonanceItem:GetItemTableName()
    if self.mItemTableName == nil and self.bloodsuit_resonance ~= nil then
        self.mItemTableName = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.bloodsuit_resonance:GetItemid())
    end
    return self.mItemTableName
end

-----得到技能表
-----@return TABLE.cfg_skills
--function LuaPlayerBloodSuitResonanceItem:GetSkillTable()
--    if self.mSkillTable == nil and self.bloodsuit_resonance ~= nil then
--        self.mSkillTable = clientTableManager.cfg_skillsManager:TryGetValue(self.bloodsuit_resonance:GetSkills())
--    end
--    return self.mSkillTable
--end

-----得到技能信息表
-----@return table<number,TABLE.cfg_skills_condition>
--function LuaPlayerBloodSuitResonanceItem:GetSkillConditionTableDic()
--    if self.mskillConditionTable == nil and self.bloodsuit_resonance ~= nil and self.bloodsuit_resonance:GetSkills() ~= nil then
--        self.mskillConditionTable = {}
--        for i, v in pairs(self.bloodsuit_resonance:GetSkills().list) do
--            local Table = clientTableManager.cfg_skills_conditionManager:GetSkillsCondition(self.bloodsuit_resonance:GetSkills().list[1], 1)
--            table.insert(self.mskillConditionTable, Table)
--        end
--    end
--    return self.mskillConditionTable
--end

---得到血继共鸣属性信息表
---@return table<number,TABLE.cfg_bloodsuit_resonance_attribute>
function LuaPlayerBloodSuitResonanceItem:GetResonance_AttributeTableDic()
    if self.mResonance_AttributeTable == nil and self.bloodsuit_resonance ~= nil and self.bloodsuit_resonance:GetSkills() ~= nil then
        self.mResonance_AttributeTable = {}
        for i, v in pairs(self.bloodsuit_resonance:GetSkills().list) do
            local Table = clientTableManager.cfg_bloodsuit_resonance_attributeManager:TryGetValue(v)
            table.insert(self.mResonance_AttributeTable, Table)
        end
    end
    return self.mResonance_AttributeTable
end

---是否穿戴
function LuaPlayerBloodSuitResonanceItem:IsWear()
    if self.bloodsuit_resonance ~= nil then
        return gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():IsWearBloodSuitSpecifyItemID(self.bloodsuit_resonance:GetItemid())
    end
    return false
end

---重置数据
function LuaPlayerBloodSuitResonanceItem:RevertData()
    self.bloodsuit_resonance = nil
    self.mSkillTable = nil
    self.mskillConditionTable = nil
    self.mItemTable = nil
    self.mItemTableName = nil
end

return LuaPlayerBloodSuitResonanceItem