--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_refine_master
local cfg_refine_master = {}

cfg_refine_master.__index = cfg_refine_master

function cfg_refine_master:UUID()
    return self.id
end

---@return number id#客户端#C  排序无意义
function cfg_refine_master:GetId()
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

---@return number 类型#客户端#C  1经验炼修为 2经验池经验换灵力 3经验炼功勋
function cfg_refine_master:GetType()
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

---@return number 封印等级#客户端#C  炼制需求的最低等级，跟
function cfg_refine_master:GetLimitLv()
    if self.limitLv ~= nil then
        return self.limitLv
    else
        if self:CsTABLE() ~= nil then
            self.limitLv = self:CsTABLE().limitLv
            return self.limitLv
        else
            return nil
        end
    end
end

---@return string 花费#客户端#C  兑换时需要花费的货币数量，1倍#2倍#3倍
function cfg_refine_master:GetCostNum()
    if self.costNum ~= nil then
        return self.costNum
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costNum
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 基准获得#客户端#C  兑换后能获得的货币的基准数量，1倍#2倍#3倍
function cfg_refine_master:GetGainNum()
    if self.gainNum ~= nil then
        return self.gainNum
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().gainNum
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 数值浮动#客户端#C  数量浮动值区间，万分比#分隔
function cfg_refine_master:GetNumFloat()
    if self.numFloat ~= nil then
        return self.numFloat
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().numFloat
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 兑换比例#客户端  炼制大师，经验和修为、灵力的兑换比例：XXXX点经验兑换1点修为/灵力；倍率#分割
function cfg_refine_master:GetRatio()
    if self.ratio ~= nil then
        return self.ratio
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().ratio
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 消耗道具#客户端  道具id#数量&道具id#数量，1倍&2倍&3倍
function cfg_refine_master:GetCost()
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

---@return TABLE.IntListList 限制条件#客户端  读取cfg_condtions表，1倍&2倍&3倍
function cfg_refine_master:GetCondtions()
    if self.condtions ~= nil then
        return self.condtions
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().condtions
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 消耗道具兑换系数#客户端  消耗道具的系数，灵兽经验不足时计算消耗公式：（经验/比例*兑换系数）*1000000
function cfg_refine_master:GetCostRate()
    if self.costRate ~= nil then
        return self.costRate
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costRate
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_REFINE_MASTER C#中的数据结构
function cfg_refine_master:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_RefineMasterTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_refine_master lua中的数据结构
function cfg_refine_master:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.ratio = decodedData.ratio
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.condtions = decodedData.condtions
    
    ---@private
    self.costRate = decodedData.costRate
end

return cfg_refine_master