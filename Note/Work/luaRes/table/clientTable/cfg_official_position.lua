--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_official_position
local cfg_official_position = {}

cfg_official_position.__index = cfg_official_position

function cfg_official_position:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  编号
function cfg_official_position:GetId()
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

---@return string 官职名称#客户端  对应的官品名称
function cfg_official_position:GetName()
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

---@return string 官阶名称#客户端  对应的官阶名称
function cfg_official_position:GetLastname()
    if self.lastname ~= nil then
        return self.lastname
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().lastname
        else
            return nil
        end
    end
end

---@return number 官品分类#客户端  官品分类
function cfg_official_position:GetStage()
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

---@return number 官阶分类#客户端  官阶分类
function cfg_official_position:GetPosition()
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

---@return TABLE.IntListJingHao 可升级条件#客户端  可升级条件，关联cfg_conditions表
function cfg_official_position:GetConditions()
    if self.conditions ~= nil then
        return self.conditions
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditions
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升级消耗#客户端  升级所需消耗，道具items#数量
function cfg_official_position:GetCost()
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

---@return number 最小攻击#客户端  最小攻击
function cfg_official_position:GetAtt()
    if self.att ~= nil then
        return self.att
    else
        if self:CsTABLE() ~= nil then
            self.att = self:CsTABLE().att
            return self.att
        else
            return nil
        end
    end
end

---@return number 最大攻击#客户端  最大攻击
function cfg_official_position:GetAttMax()
    if self.attMax ~= nil then
        return self.attMax
    else
        if self:CsTABLE() ~= nil then
            self.attMax = self:CsTABLE().attMax
            return self.attMax
        else
            return nil
        end
    end
end

---@return number 掉宝概率#客户端  掉宝概率（百分比）
function cfg_official_position:GetDropItemRate()
    if self.dropItemRate ~= nil then
        return self.dropItemRate
    else
        if self:CsTABLE() ~= nil then
            self.dropItemRate = self:CsTABLE().dropItemRate
            return self.dropItemRate
        else
            return nil
        end
    end
end

---@return number 官阶品阶颜色#客户端  颜色代码123456为道具品质颜色1白，2淡蓝，3黄，4嫩草绿，5紫红，6红
function cfg_official_position:GetQuality()
    if self.quality ~= nil then
        return self.quality
    else
        if self:CsTABLE() ~= nil then
            self.quality = self:CsTABLE().quality
            return self.quality
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_OFFICIAL_POSITION C#中的数据结构
function cfg_official_position:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_official_position lua中的数据结构
function cfg_official_position:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.lastname = decodedData.lastname
    
    ---@private
    self.stage = decodedData.stage
    
    ---@private
    self.position = decodedData.position
    
    ---@private
    self.conditions = decodedData.conditions
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.att = decodedData.att
    
    ---@private
    self.attMax = decodedData.attMax
    
    ---@private
    self.dropItemRate = decodedData.dropItemRate
    
    ---@private
    self.quality = decodedData.quality
end

return cfg_official_position