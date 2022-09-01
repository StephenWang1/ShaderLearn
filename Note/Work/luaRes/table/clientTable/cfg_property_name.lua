--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_property_name
local cfg_property_name = {}

cfg_property_name.__index = cfg_property_name

function cfg_property_name:UUID()
    return self.id
end

---@return number id#客户端#C  对应协议id,id目前并不连续，增删时注意避免重复
function cfg_property_name:GetId()
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

---@return string 名称#客户端#C  正常显示用
function cfg_property_name:GetName()
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

---@return string 参数#客户端#C  在不同界面可能会使用特殊名称展示，预留一参数列，具体显示、配置规则自行协定，记得备注。
function cfg_property_name:GetParam()
    if self.param ~= nil then
        return self.param
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().param
        else
            return nil
        end
    end
end

---@return string 特殊颜色#客户端  tips内属性特殊颜色
function cfg_property_name:GetColor()
    if self.color ~= nil then
        return self.color
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().color
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_PROPERTY_NAME C#中的数据结构
function cfg_property_name:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_Property_NameTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_property_name lua中的数据结构
function cfg_property_name:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.color = decodedData.color
end

return cfg_property_name