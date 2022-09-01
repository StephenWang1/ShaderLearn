--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_hidden_weapon
local cfg_hidden_weapon = {}

cfg_hidden_weapon.__index = cfg_hidden_weapon

function cfg_hidden_weapon:UUID()
    return self.id
end

---@return number id#客户端#C  编号
function cfg_hidden_weapon:GetId()
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

---@return string 暗器名称#客户端  对应的暗器名称
function cfg_hidden_weapon:GetName()
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

---@return number 暗器品级#客户端  暗器品级
function cfg_hidden_weapon:GetStage()
    if self.stage ~= nil then
        return self.stage
    else
        if self:CsTABLE() ~= nil then
            self.stage = self:CsTABLE().stage
            return self.stage
        else
            return nil
        end
    end
end

---@return number 击落马概率增加#客户端  万分比
function cfg_hidden_weapon:GetFallHorse()
    if self.fallHorse ~= nil then
        return self.fallHorse
    else
        if self:CsTABLE() ~= nil then
            self.fallHorse = self:CsTABLE().fallHorse
            return self.fallHorse
        else
            return nil
        end
    end
end

---@return number 是否必中#客户端  0否；1是 默认为1
function cfg_hidden_weapon:GetHit()
    if self.hit ~= nil then
        return self.hit
    else
        if self:CsTABLE() ~= nil then
            self.hit = self:CsTABLE().hit
            return self.hit
        else
            return nil
        end
    end
end

---@return number 穿透伤害#客户端  直接填造成的伤害固定值
function cfg_hidden_weapon:GetRealAtk()
    if self.realAtk ~= nil then
        return self.realAtk
    else
        if self:CsTABLE() ~= nil then
            self.realAtk = self:CsTABLE().realAtk
            return self.realAtk
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_HIDDEN_WEAPON C#中的数据结构
function cfg_hidden_weapon:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_hidden_weapon lua中的数据结构
function cfg_hidden_weapon:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.stage = decodedData.stage
    
    ---@private
    self.fallHorse = decodedData.fallHorse
    
    ---@private
    self.hit = decodedData.hit
    
    ---@private
    self.realAtk = decodedData.realAtk
end

return cfg_hidden_weapon