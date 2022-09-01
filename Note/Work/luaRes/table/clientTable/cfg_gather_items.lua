--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_gather_items
local cfg_gather_items = {}

cfg_gather_items.__index = cfg_gather_items

function cfg_gather_items:UUID()
    return self.id
end

---@return number id#客户端#C  本表唯一id
function cfg_gather_items:GetId()
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

---@return number gatherId#客户端#C#不存在共同参与合并的字段  对应cfg_gather表
function cfg_gather_items:GetGatherId()
    if self.gatherId ~= nil then
        return self.gatherId
    else
        if self:CsTABLE() ~= nil then
            self.gatherId = self:CsTABLE().gatherId
            return self.gatherId
        else
            return nil
        end
    end
end

---@return string 名称#客户端#C  怪物名称
function cfg_gather_items:GetName()
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

---@return string 挖掘时间参数#客户端#C  对应前面类型1.开始天数#结束天数2.开始天数#结束天数3.开始时间戳#结束时间戳4.开始时间戳#结束时间戳
function cfg_gather_items:GetStartTime()
    if self.startTime ~= nil then
        return self.startTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().startTime
        else
            return nil
        end
    end
end

---@return number 限制等级_C
function cfg_gather_items:GetLevel()
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
---@return number 掉落数量_C
function cfg_gather_items:GetCount()
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
---@return number 挖掘时间类型_C
function cfg_gather_items:GetTimeType()
    if self.timeType ~= nil then
        return self.timeType
    else
        if self:CsTABLE() ~= nil then
            self.timeType = self:CsTABLE().timeType
            return self.timeType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_GATHER_ITEMS C#中的数据结构
function cfg_gather_items:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_gather_items lua中的数据结构
function cfg_gather_items:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_gather_items