--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_mapeffect
local cfg_mapeffect = {}

cfg_mapeffect.__index = cfg_mapeffect

function cfg_mapeffect:UUID()
    return self.id
end

---@return number 编号#客户端#C  编号
function cfg_mapeffect:GetId()
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

---@return string 名字#客户端#C  是哪个方向的特效
function cfg_mapeffect:GetName()
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

---@return string 图标#客户端#C  如果需要在编辑器中放入你喜欢的图标，可以在这里填写
function cfg_mapeffect:GetIcon()
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

---@return number 特殊参数#客户端#C  特殊参数
function cfg_mapeffect:GetExtra()
    if self.extra ~= nil then
        return self.extra
    else
        if self:CsTABLE() ~= nil then
            self.extra = self:CsTABLE().extra
            return self.extra
        else
            return nil
        end
    end
end

---@return number 类型#客户端#C  type
function cfg_mapeffect:GetType()
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

--@return  TABLE.CFG_MAPEFFECT C#中的数据结构
function cfg_mapeffect:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_mapeffect lua中的数据结构
function cfg_mapeffect:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_mapeffect