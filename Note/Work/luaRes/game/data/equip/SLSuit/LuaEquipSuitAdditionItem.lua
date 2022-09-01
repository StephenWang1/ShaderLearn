---@class LuaEquipSuitAdditionItem 套装的加成
local LuaEquipSuitAdditionItem = {}

LuaEquipSuitAdditionItem.IsActivate = nil

---已激活这个套装属性的个数数据
---@type table<number:套装等级, 数量>
LuaEquipSuitAdditionItem.ActivateData = nil
---激活这个套装属性需要的限定个数
LuaEquipSuitAdditionItem.ActivateLimitCount = nil

---@type TABLE.cfg_divinesuitattribute 套装表的加成属性
LuaEquipSuitAdditionItem.DivineSuitAttribute = nil

---@type TABLE.cfg_divinesuitattribute 套装表的默认加成属性(灰色)
LuaEquipSuitAdditionItem.DivineSuitAttributeBase = nil

---@type number 套装的type
LuaEquipSuitAdditionItem.SuitType = 0

---@type number 套装的subType
LuaEquipSuitAdditionItem.SuitSubType = 1

---@type number 激活的属性等级
LuaEquipSuitAdditionItem.ActivateAttributeLevel = nil

function LuaEquipSuitAdditionItem:Init()
    self.IsActivate = false
    self.ActivateLimitCount = 0
end

---初始化数据
---@param type 套装类型
---@param level 激活等级
---@param limitCount 激活所需的数量
---@param divineSuitAttribute 激活属性TABLE.cfg_divinesuitattribute的ID
function LuaEquipSuitAdditionItem:InitData(type, level, limitCount, divineSuitAttributeID, subType)
    self.SuitType = type ~= nil and type or 0;
    self.SuitSubType = subType ~= nil and subType or 1;
    self.ActivateLimitCount = limitCount;
    self.ActivateAttributeLevel = level;
    self:UpdateSuitAttribute(divineSuitAttributeID)
    self.DivineSuitAttributeBase = self.DivineSuitAttribute;
end

---设置属性的激活状态
---@param data table<number:套装等级, 数量>
function LuaEquipSuitAdditionItem:SetActivateData(data)
    self.ActivateData = data;
    if (self.ActivateData == nil) then
        return ;
    end
    if (self.ActivateData[1] ~= nil) then
        self.IsActivate = self.ActivateData[1] >= self.ActivateLimitCount
    else
        self.IsActivate = false
    end

    for i = 12, 1, -1 do
        local count = self.ActivateData[i];
        ---由高到低,条件数量满足的时候,激活最高的等级
        if (count ~= nil and count >= self.ActivateLimitCount) then
            self:SetActivateLevel(i);
            return ;
        end
    end
end

---设置属性的激活等级
function LuaEquipSuitAdditionItem:SetActivateLevel(level)
    if (self.ActivateAttributeLevel ~= level) then
        self.ActivateAttributeLevel = level
        ---@return table<number:激活所需数量, number:激活属性TABLE.cfg_divinesuitattribute的ID>
        local attributesDic = clientTableManager.cfg_divinesuitattributeManager.GetDivineSuitAddition(self.SuitType + self.SuitSubType - 1, level, 999)
        local attributesID = attributesDic[self.ActivateLimitCount]
        if (attributesID == nil) then
            self.DivineSuitAttribute = self.DivineSuitAttributeBase
        else
            self:UpdateSuitAttribute(attributesID)
        end
    end
end

---更新当前的加成属性
function LuaEquipSuitAdditionItem:UpdateSuitAttribute(id)
    local divinesuitattributeData = clientTableManager.cfg_divinesuitattributeManager:TryGetValue(id)
    if (divinesuitattributeData == nil) then
        CS.UnityEngine.Debug.LogError("没有在cfg_divineSuitAttribute表格中找到对应的" .. tostring(id));
    else
        self.DivineSuitAttribute = divinesuitattributeData
    end
end

---得到Tip上面的描述
function LuaEquipSuitAdditionItem:GetTipDesc()
    return self.DivineSuitAttribute:GetDes()
end

---得到技能信息
---@return number,number 技能ID,技能等级,套装激活数量
function LuaEquipSuitAdditionItem:GetSkill()
    if (self.DivineSuitAttribute == nil or self.DivineSuitAttribute:GetSkill() == nil) then
        return 0, 0
    end
    local skillInfo = self.DivineSuitAttribute:GetSkill().list;
    return skillInfo[1], skillInfo[2], self.IsActivate, self.ActivateLimitCount;
end

return LuaEquipSuitAdditionItem