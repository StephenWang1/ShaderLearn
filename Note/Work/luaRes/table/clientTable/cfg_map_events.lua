--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_map_events
local cfg_map_events = {}

cfg_map_events.__index = cfg_map_events

function cfg_map_events:UUID()
    return self.id
end

---@return number 地图事件ID#客户端#C#不存在共同参与合并的字段  地图事件
function cfg_map_events:GetId()
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

---@return number 事件id#客户端#C#不存在共同参与合并的字段  关联event表里id字段
function cfg_map_events:GetEventids()
    if self.eventids ~= nil then
        return self.eventids
    else
        if self:CsTABLE() ~= nil then
            self.eventids = self:CsTABLE().eventids
            return self.eventids
        else
            return nil
        end
    end
end

---@return number 地图ID#客户端#C#不存在共同参与合并的字段  地图ID
function cfg_map_events:GetMapid()
    if self.mapid ~= nil then
        return self.mapid
    else
        if self:CsTABLE() ~= nil then
            self.mapid = self:CsTABLE().mapid
            return self.mapid
        else
            return nil
        end
    end
end

---@return string 客户端显示控制#客户端#C  0显示，不填不显示
function cfg_map_events:GetShowparam()
    if self.showparam ~= nil then
        return self.showparam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showparam
        else
            return nil
        end
    end
end

---@return number 小地图传送阵显示限制#客户端#C#不存在共同参与合并的字段  关联cfg_conditions
function cfg_map_events:GetConditionId()
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

---@return number x坐标_C
function cfg_map_events:GetX()
    if self.x ~= nil then
        return self.x
    else
        if self:CsTABLE() ~= nil then
            self.x = self:CsTABLE().x
            return self.x
        else
            return nil
        end
    end
end
---@return number y坐标_C
function cfg_map_events:GetY()
    if self.y ~= nil then
        return self.y
    else
        if self:CsTABLE() ~= nil then
            self.y = self:CsTABLE().y
            return self.y
        else
            return nil
        end
    end
end
---@return number 传送阵生效条件_C
function cfg_map_events:GetShowcondition()
    if self.showcondition ~= nil then
        return self.showcondition
    else
        if self:CsTABLE() ~= nil then
            self.showcondition = self:CsTABLE().showcondition
            return self.showcondition
        else
            return nil
        end
    end
end
---@return number 传送阵是否生效_C
function cfg_map_events:GetEffective()
    if self.effective ~= nil then
        return self.effective
    else
        if self:CsTABLE() ~= nil then
            self.effective = self:CsTABLE().effective
            return self.effective
        else
            return nil
        end
    end
end
---@return number 是否显示小地图icon_C
function cfg_map_events:GetShowIcon()
    if self.showIcon ~= nil then
        return self.showIcon
    else
        if self:CsTABLE() ~= nil then
            self.showIcon = self:CsTABLE().showIcon
            return self.showIcon
        else
            return nil
        end
    end
end

---@return number 联盟地宫下层传送阵标记#客户端  仅行会地宫使用：1第一行会2第二行会3其他行会及散人
function cfg_map_events:GetGuildType()
    if self.guildType ~= nil then
        return self.guildType
    else
        if self:CsTABLE() ~= nil then
            self.guildType = self:CsTABLE().guildType
            return self.guildType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_MAP_EVENTS C#中的数据结构
function cfg_map_events:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_MapEventsTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_map_events lua中的数据结构
function cfg_map_events:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.guildType = decodedData.guildType
end

return cfg_map_events