--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_recast
local cfg_recast = {}

cfg_recast.__index = cfg_recast

function cfg_recast:UUID()
    return self.id
end

---@return number id#客户端  重铸id
function cfg_recast:GetId()
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

---@return number 配饰类型#客户端  配饰对应subtype类型items表关联（22灵魂刻印 24面纱 13灯座 15玉佩 21宝饰 18秘宝）
function cfg_recast:GetType()
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

---@return TABLE.IntListList 升级消耗#客户端  升级所需消耗，道具items#数量
function cfg_recast:GetCost()
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

---@return TABLE.IntListJingHao 货币消耗#客户端  升级货币消耗
function cfg_recast:GetCost2()
    if self.cost2 ~= nil then
        return self.cost2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cost2
        else
            return nil
        end
    end
end

---@return number 重铸等级#客户端  对应配饰的重铸等级
function cfg_recast:GetLevel()
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

---@return number 属性id#客户端  属性表id 关联cfg_extra_mon_effect表
function cfg_recast:GetAtt()
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

---@return TABLE.IntListJingHao 重铸特殊技能显示id#客户端  重铸特殊技能显示索引cfg_recast_skill  id1#id2#id3#id4#id5
function cfg_recast:GetRecastSkill()
    if self.recastSkill ~= nil then
        return self.recastSkill
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().recastSkill
        else
            return nil
        end
    end
end

---@return number 附带特殊效果buffid#客户端  附带特殊效果填写buffid
function cfg_recast:GetBuffid()
    if self.buffid ~= nil then
        return self.buffid
    else
        if self:CsTABLE() ~= nil then
            self.buffid = self:CsTABLE().buffid
            return self.buffid
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升级条件#客户端  升级条件，连conditionid
function cfg_recast:GetConditionId()
    if self.conditionId ~= nil then
        return self.conditionId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditionId
        else
            return nil
        end
    end
end

---@return string 文本描述#客户端  特殊效果描述文本
function cfg_recast:GetDesc()
    if self.desc ~= nil then
        return self.desc
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().desc
        else
            return nil
        end
    end
end

---@return string 满级状态显示#客户端  满级状态显示 预设名
function cfg_recast:GetUiEffect()
    if self.uiEffect ~= nil then
        return self.uiEffect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().uiEffect
        else
            return nil
        end
    end
end

---@return string 未装备时的显示标题#客户端  未装备时的显示标题
function cfg_recast:GetName()
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

---@return TABLE.IntListJingHao 属性显示优先级#客户端  属性显示优先级配置 格式（属性id#属性id....)
function cfg_recast:GetAttriBute()
    if self.attriBute ~= nil then
        return self.attriBute
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attriBute
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_RECAST C#中的数据结构
function cfg_recast:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_recast lua中的数据结构
function cfg_recast:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.cost2 = decodedData.cost2
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.att = decodedData.att
    
    ---@private
    self.recastSkill = decodedData.recastSkill
    
    ---@private
    self.buffid = decodedData.buffid
    
    ---@private
    self.conditionId = decodedData.conditionId
    
    ---@private
    self.desc = decodedData.desc
    
    ---@private
    self.uiEffect = decodedData.uiEffect
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.attriBute = decodedData.attriBute
end

return cfg_recast