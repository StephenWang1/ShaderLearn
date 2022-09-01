--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_attribute_show
local cfg_attribute_show = {}

cfg_attribute_show.__index = cfg_attribute_show

function cfg_attribute_show:UUID()
    return self.id
end

---@return number id#客户端  id
function cfg_attribute_show:GetId()
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

---@return number 属性类型#客户端  属性类型，程序定
function cfg_attribute_show:GetType()
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

---@return string 显示#客户端  显示文本
function cfg_attribute_show:GetShow()
    if self.show ~= nil then
        return self.show
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().show
        else
            return nil
        end
    end
end

---@return number 显示类型#客户端  1 直接显示数值 2 万分数 3 百分数
function cfg_attribute_show:GetValueType()
    if self.valueType ~= nil then
        return self.valueType
    else
        if self:CsTABLE() ~= nil then
            self.valueType = self:CsTABLE().valueType
            return self.valueType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 关联属性#客户端  关联的属性  跟此属性组合的属性类型  type#type
function cfg_attribute_show:GetRelationAttribute()
    if self.relationAttribute ~= nil then
        return self.relationAttribute
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().relationAttribute
        else
            return nil
        end
    end
end

---@return number 关联显示类型#客户端  关联属性的显示类型  未配置则直接显示数值即可 1 属性间以-间隔
function cfg_attribute_show:GetRelationType()
    if self.relationType ~= nil then
        return self.relationType
    else
        if self:CsTABLE() ~= nil then
            self.relationType = self:CsTABLE().relationType
            return self.relationType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_ATTRIBUTE_SHOW C#中的数据结构
function cfg_attribute_show:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_attribute_show lua中的数据结构
function cfg_attribute_show:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.show = decodedData.show
    
    ---@private
    self.valueType = decodedData.valueType
    
    ---@private
    self.relationAttribute = decodedData.relationAttribute
    
    ---@private
    self.relationType = decodedData.relationType
end

return cfg_attribute_show