--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_magicweapon
local cfg_magicweapon = {}

cfg_magicweapon.__index = cfg_magicweapon

function cfg_magicweapon:UUID()
    return self.id
end

---@return number id#客户端  唯一id  决定套装类型和等级  前两位为类型 后两位为等级
function cfg_magicweapon:GetId()
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

---@return number 套装类型#客户端  套装类型  1 生肖 2神器  4 心灵
function cfg_magicweapon:GetType()
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

---@return number 套装等级#客户端  套装等级，同类型套装不可一致
function cfg_magicweapon:GetLevel()
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

---@return number 套装数量#客户端  当前套装的装备位最大上限
function cfg_magicweapon:GetPosition()
    if self.position ~= nil then
        return self.position
    else
        if self:CsTABLE() ~= nil then
            self.position = self:CsTABLE().position
            return self.position
        else
            return nil
        end
    end
end

---@return number 激活技能#客户端  激活技能，索引skill表中技能id  5类型读取buffid
function cfg_magicweapon:GetSkill()
    if self.skill ~= nil then
        return self.skill
    else
        if self:CsTABLE() ~= nil then
            self.skill = self:CsTABLE().skill
            return self.skill
        else
            return nil
        end
    end
end

---@return string 技能描述#客户端  技能描述 程序根据穿戴情况 显示相应穿戴的数量
function cfg_magicweapon:GetSkillDes()
    if self.skillDes ~= nil then
        return self.skillDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skillDes
        else
            return nil
        end
    end
end

---@return number 下一级id#客户端  本id对应的下一级id  无下一级则不填
function cfg_magicweapon:GetNextId()
    if self.nextId ~= nil then
        return self.nextId
    else
        if self:CsTABLE() ~= nil then
            self.nextId = self:CsTABLE().nextId
            return self.nextId
        else
            return nil
        end
    end
end

---@return number 额外属性#客户端  索引到extra_mon_effect中
function cfg_magicweapon:GetExtraEffect()
    if self.extraEffect ~= nil then
        return self.extraEffect
    else
        if self:CsTABLE() ~= nil then
            self.extraEffect = self:CsTABLE().extraEffect
            return self.extraEffect
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_MAGICWEAPON C#中的数据结构
function cfg_magicweapon:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_magicweapon lua中的数据结构
function cfg_magicweapon:Init(decodedData)
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
    self.position = decodedData.position
    
    ---@private
    self.skill = decodedData.skill
    
    ---@private
    self.skillDes = decodedData.skillDes
    
    ---@private
    self.nextId = decodedData.nextId
    
    ---@private
    self.extraEffect = decodedData.extraEffect
end

return cfg_magicweapon