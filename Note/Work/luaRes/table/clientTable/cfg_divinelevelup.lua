--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_divinelevelup
local cfg_divinelevelup = {}

cfg_divinelevelup.__index = cfg_divinelevelup

function cfg_divinelevelup:UUID()
    return self.id
end

---@return number 道具id#客户端  道具id
function cfg_divinelevelup:GetId()
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

---@return number 下级道具id#客户端  下一级道具id  不填则说明已是最高级
function cfg_divinelevelup:GetNextId()
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

---@return number 需要经验#客户端  升到下一级道具需要的经验  不填则说明已是最高级
function cfg_divinelevelup:GetNeedExp()
    if self.needExp ~= nil then
        return self.needExp
    else
        if self:CsTABLE() ~= nil then
            self.needExp = self:CsTABLE().needExp
            return self.needExp
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 神力id#客户端  可以消耗升级的神力套装id （divinesuitid）divineid#divineid
function cfg_divinelevelup:GetCostDivineId()
    if self.costDivineId ~= nil then
        return self.costDivineId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costDivineId
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 道具类型#客户端  可以用来消耗的道具类型，type#subtype&type#subtype
function cfg_divinelevelup:GetCostType()
    if self.costType ~= nil then
        return self.costType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DIVINELEVELUP C#中的数据结构
function cfg_divinelevelup:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_divinelevelup lua中的数据结构
function cfg_divinelevelup:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.nextId = decodedData.nextId
    
    ---@private
    self.needExp = decodedData.needExp
    
    ---@private
    self.costDivineId = decodedData.costDivineId
    
    ---@private
    self.costType = decodedData.costType
end

return cfg_divinelevelup