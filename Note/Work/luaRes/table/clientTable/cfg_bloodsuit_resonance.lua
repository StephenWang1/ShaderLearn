--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bloodsuit_resonance
local cfg_bloodsuit_resonance = {}

cfg_bloodsuit_resonance.__index = cfg_bloodsuit_resonance

function cfg_bloodsuit_resonance:UUID()
    return self.id
end

---@return number 编号#客户端  编号
function cfg_bloodsuit_resonance:GetId()
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

---@return number 共鸣组合#客户端  共鸣组合
function cfg_bloodsuit_resonance:GetGroup()
    if self.group ~= nil then
        return self.group
    else
        if self:CsTABLE() ~= nil then
            self.group = self:CsTABLE().group
            return self.group
        else
            return nil
        end
    end
end

---@return string 组合名称#客户端  组合名称
function cfg_bloodsuit_resonance:GetGroupName()
    if self.groupName ~= nil then
        return self.groupName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().groupName
        else
            return nil
        end
    end
end

---@return number 道具id#客户端  共鸣道具id
function cfg_bloodsuit_resonance:GetItemid()
    if self.itemid ~= nil then
        return self.itemid
    else
        if self:CsTABLE() ~= nil then
            self.itemid = self:CsTABLE().itemid
            return self.itemid
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 共鸣技能#客户端  共鸣技能
function cfg_bloodsuit_resonance:GetSkills()
    if self.skills ~= nil then
        return self.skills
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skills
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BLOODSUIT_RESONANCE C#中的数据结构
function cfg_bloodsuit_resonance:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bloodsuit_resonance lua中的数据结构
function cfg_bloodsuit_resonance:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.group = decodedData.group
    
    ---@private
    self.groupName = decodedData.groupName
    
    ---@private
    self.itemid = decodedData.itemid
    
    ---@private
    self.skills = decodedData.skills
end

return cfg_bloodsuit_resonance