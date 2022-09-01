--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bloodsuit_resonance_attribute
local cfg_bloodsuit_resonance_attribute = {}

cfg_bloodsuit_resonance_attribute.__index = cfg_bloodsuit_resonance_attribute

function cfg_bloodsuit_resonance_attribute:UUID()
    return self.id
end

---@return number 编号#客户端  编号
function cfg_bloodsuit_resonance_attribute:GetId()
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

---@return string 技能描述#客户端  技能描述（&特殊颜色文字&）
function cfg_bloodsuit_resonance_attribute:GetTips()
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

---@return number 属性参数类型#客户端  决定属性加成为固定属性还是万分比加成属性：1固定值；2万分比
function cfg_bloodsuit_resonance_attribute:GetAttributeType()
    if self.attributeType ~= nil then
        return self.attributeType
    else
        if self:CsTABLE() ~= nil then
            self.attributeType = self:CsTABLE().attributeType
            return self.attributeType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BLOODSUIT_RESONANCE_ATTRIBUTE C#中的数据结构
function cfg_bloodsuit_resonance_attribute:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bloodsuit_resonance_attribute lua中的数据结构
function cfg_bloodsuit_resonance_attribute:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.tips = decodedData.tips
    
    ---@private
    self.attributeType = decodedData.attributeType
end

return cfg_bloodsuit_resonance_attribute