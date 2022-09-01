--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_horse_card
local cfg_horse_card = {}

cfg_horse_card.__index = cfg_horse_card

function cfg_horse_card:UUID()
    return self.id
end

---@return number id#客户端#C  编号
function cfg_horse_card:GetId()
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

---@return string 马牌名称#客户端  对应的马牌名称
function cfg_horse_card:GetName()
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

---@return number 马牌品级#客户端  马牌品级
function cfg_horse_card:GetStage()
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

---@return number 攻击加成百分比#客户端  万分比
function cfg_horse_card:GetAtkPer()
    if self.atkPer ~= nil then
        return self.atkPer
    else
        if self:CsTABLE() ~= nil then
            self.atkPer = self:CsTABLE().atkPer
            return self.atkPer
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_HORSE_CARD C#中的数据结构
function cfg_horse_card:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_horse_card lua中的数据结构
function cfg_horse_card:Init(decodedData)
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
    self.atkPer = decodedData.atkPer
end

return cfg_horse_card