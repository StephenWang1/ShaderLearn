---@class cfg_magicweaponManager:TableManager
local cfg_magicweaponManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_magicweapon
function cfg_magicweaponManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_magicweapon> 遍历方法
function cfg_magicweaponManager:ForPair(action)
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
function cfg_magicweaponManager:PostProcess()
end

--region 解析
---通过装备位解析装备类型
---@param equipIndex number 装备位
---@return LuaEnumMagicEquipSuitType 法宝套装类型
function cfg_magicweaponManager:AnalysisTypeByEquipIndex(equipIndex)
    if equipIndex == nil then
        return
    end
    return Utility.GetIntPart(equipIndex * 0.001)
end

---通过套装id和各自下表获取装备位
---@param suitType LuaEnumMagicEquipSuitType 套装类型
---@param index number 装备位
---@return number 装备位
function cfg_magicweaponManager:GetEquipIndexBySuitType(suitType,index)
    return suitType * 1000 + (400 + index)
end

---通过装备位解析基础装备位
---@param equipIndexx number 装备位
---@return LuaEquipmentItemType 基础装备位
function cfg_magicweaponManager:GetBaseEquipIndexByEquipIndex(equipIndex)
    if equipIndex == nil then
        return
    end
    local suitType = self:AnalysisTypeByEquipIndex(equipIndex)
    return equipIndex - suitType * 1000
end
--endregion

--region 获取
---通过套装类型获取最低等级的套装信息表
---@param suitType LuaEnumMagicEquipSuitType 套装类型
---@return TABLE.cfg_magicweapon 套装表信息
function cfg_magicweaponManager:GetDefaultLowSuitInfo(suitType)
    if suitType ~= nil then
        local defaultLowLevel = 1
        for k,v in pairs(self.dic) do
            ---@type TABLE.cfg_magicweapon
            local tbl = v
            if tbl:GetType() == suitType and defaultLowLevel == defaultLowLevel then
                return tbl
            end
        end
    end
end

---获取技能套装描述内容格式
---@param id number
---@return string
function cfg_magicweaponManager:GetCurSkillDes(id)
    if type(id) ~= 'number' then
        return ""
    end
    local magicWeaponTbl = clientTableManager.cfg_magicweaponManager:TryGetValue(id)
    if magicWeaponTbl == nil or CS.StaticUtility.IsNullOrEmpty(magicWeaponTbl:GetSkillDes()) then
        return ""
    end
    return string.gsub(magicWeaponTbl:GetSkillDes(), '\\n', '\n')
end

---获取属性描述
---@param id number
---@param career LuaEnumCareer
---@return string
function cfg_magicweaponManager:GetAttributeDes(id,career)
    if type(id) ~= 'number' or type(career) ~= 'number' then
        return ""
    end
    local magicWeaponTbl = clientTableManager.cfg_magicweaponManager:TryGetValue(id)
    if magicWeaponTbl == nil or magicWeaponTbl:GetExtraEffect() <= 0 then
        return ""
    end
    return clientTableManager.cfg_extra_mon_effectManager:GetAllAttributeShow(magicWeaponTbl:GetExtraEffect(),career)
end
--endregion

return cfg_magicweaponManager