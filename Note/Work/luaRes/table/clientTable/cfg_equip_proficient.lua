--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_equip_proficient
local cfg_equip_proficient = {}

cfg_equip_proficient.__index = cfg_equip_proficient

function cfg_equip_proficient:UUID()
    return self.id
end

---@return number id#客户端#C  id#客户端
function cfg_equip_proficient:GetId()
    if self.id ~= nil then
        return self.id
    else
        if self:CsTABLE() ~= nil then
            self.id = self:CsTABLE().id
            return self.id
        else
            return nil
        end
    end
end

---@return number 类型#客户端  1.武器 2.衣服 3.头盔 4.项链 5.手镯左 6.手镯右 7.戒指左 8.戒指右 9.腰带 10.鞋子 11.灯座 12.玉 13.勋章 14.宝饰 15.秘宝
function cfg_equip_proficient:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            self.type = self:CsTABLE().type
            return self.type
        else
            return nil
        end
    end
end

---@return number 等级#客户端  等级
function cfg_equip_proficient:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            self.level = self:CsTABLE().level
            return self.level
        else
            return nil
        end
    end
end

---@return string 专精名称#客户端  名称
function cfg_equip_proficient:GetName()
    if self.name ~= nil then
        return self.name
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().name
        else
            return nil
        end
    end
end

---@return number 界面显示排序#客户端  按类型分
function cfg_equip_proficient:GetOrder()
    if self.order ~= nil then
        return self.order
    else
        if self:CsTABLE() ~= nil then
            self.order = self:CsTABLE().order
            return self.order
        else
            return nil
        end
    end
end

---@return string 技能图标#客户端  图标
function cfg_equip_proficient:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 升级消耗#客户端  升到当前等级所需消耗（itemid#数量）
function cfg_equip_proficient:GetCost()
    if self.cost ~= nil then
        return self.cost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cost
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升级条件#客户端  conditionID#conditionID
function cfg_equip_proficient:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().condition
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 生效装备要求#客户端  角色等级#角色转生等级
function cfg_equip_proficient:GetEquipmentLimit()
    if self.equipmentLimit ~= nil then
        return self.equipmentLimit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().equipmentLimit
        else
            return nil
        end
    end
end

---@return string 效果描述#客户端  描述
function cfg_equip_proficient:GetTips()
    if self.tips ~= nil then
        return self.tips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具子类型#客户端  对应item表里的subtype类型id
function cfg_equip_proficient:GetSubtype()
    if self.subtype ~= nil then
        return self.subtype
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().subtype
        else
            return nil
        end
    end
end

---@return number 生效装备等级要求#客户端
function cfg_equip_proficient:GetLevelLimit()
    if self.levelLimit ~= nil then
        return self.levelLimit
    else
        if self:CsTABLE() ~= nil then
            self.levelLimit = self:CsTABLE().levelLimit
            return self.levelLimit
        else
            return nil
        end
    end
end

---@return number 生效装备转生要求#客户端
function cfg_equip_proficient:GetReinlLimit()
    if self.reinlLimit ~= nil then
        return self.reinlLimit
    else
        if self:CsTABLE() ~= nil then
            self.reinlLimit = self:CsTABLE().reinlLimit
            return self.reinlLimit
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_EQUIP_PROFICIENT C#中的数据结构
function cfg_equip_proficient:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_equip_proficient lua中的数据结构
function cfg_equip_proficient:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.icon = decodedData.icon
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.condition = decodedData.condition
    
    ---@private
    self.equipmentLimit = decodedData.equipmentLimit
    
    ---@private
    self.tips = decodedData.tips
    
    ---@private
    self.subtype = decodedData.subtype
    
    ---@private
    self.levelLimit = decodedData.levelLimit
    
    ---@private
    self.reinlLimit = decodedData.reinlLimit
end

return cfg_equip_proficient