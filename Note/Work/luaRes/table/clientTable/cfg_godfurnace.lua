--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_godfurnace
local cfg_godfurnace = {}

cfg_godfurnace.__index = cfg_godfurnace

function cfg_godfurnace:UUID()
    return self.id
end

---@return number 前一行的id#客户端#C  升级前的id
function cfg_godfurnace:GetId()
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

---@return TABLE.IntListList 扩展基数物品#客户端#C  升级需要用到物品ID#数量
function cfg_godfurnace:GetAssist()
    if self.assist ~= nil then
        return self.assist
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().assist
        else
            return nil
        end
    end
end

---@return number 升级后的物品id#客户端#C  升级后的物品id
function cfg_godfurnace:GetNewid()
    if self.newid ~= nil then
        return self.newid
    else
        if self:CsTABLE() ~= nil then
            self.newid = self:CsTABLE().newid
            return self.newid
        else
            return nil
        end
    end
end

---@return number 开服时间#客户端#C  开服时间限制
function cfg_godfurnace:GetOpenTime()
    if self.openTime ~= nil then
        return self.openTime
    else
        if self:CsTABLE() ~= nil then
            self.openTime = self:CsTABLE().openTime
            return self.openTime
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 货币消耗#客户端#C  升级货币消耗
function cfg_godfurnace:GetCost()
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

---@return number 升级条件#客户端#C  升级条件，连conditionid
function cfg_godfurnace:GetConditionId()
    if self.conditionId ~= nil then
        return self.conditionId
    else
        if self:CsTABLE() ~= nil then
            self.conditionId = self:CsTABLE().conditionId
            return self.conditionId
        else
            return nil
        end
    end
end

---@return number 基数_C
function cfg_godfurnace:GetCount()
    if self.count ~= nil then
        return self.count
    else
        if self:CsTABLE() ~= nil then
            self.count = self:CsTABLE().count
            return self.count
        else
            return nil
        end
    end
end
---@return number 子类型_C
function cfg_godfurnace:GetSubType()
    if self.subType ~= nil then
        return self.subType
    else
        if self:CsTABLE() ~= nil then
            self.subType = self:CsTABLE().subType
            return self.subType
        else
            return nil
        end
    end
end

---@return number 道具等级_C
function cfg_godfurnace:GetLv()
    if self.lv ~= nil then
        return self.lv
    else
        if self:CsTABLE() ~= nil then
            self.lv = self:CsTABLE().lv
            return self.lv
        else
            return nil
        end
    end
end
---@return number 使用等级_C
function cfg_godfurnace:GetUselv()
    if self.uselv ~= nil then
        return self.uselv
    else
        if self:CsTABLE() ~= nil then
            self.uselv = self:CsTABLE().uselv
            return self.uselv
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_GODFURNACE C#中的数据结构
function cfg_godfurnace:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_godfurnace lua中的数据结构
function cfg_godfurnace:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_godfurnace