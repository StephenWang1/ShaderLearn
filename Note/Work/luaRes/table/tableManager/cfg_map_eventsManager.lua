---@class cfg_map_eventsManager:TableManager
local cfg_map_eventsManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_map_events
function cfg_map_eventsManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_map_events> 遍历方法
function cfg_map_eventsManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_map_eventsManager:PostProcess()
end

---得到当前地图类型的地图信息
function cfg_map_eventsManager:GetGuildTypeMap_EventTbl()
    local MyguildType =CS.CSScene.MainPlayerInfo.ActivityInfo.UninDungeonRank
    for i, v in pairs(self.dic) do
        local guildType = v:GetGuildType()
        local mapID = v:GetMapid()
        if mapID == CS.CSScene.getMapID() and guildType == MyguildType then
            local isfind,data=CS.Cfg_EventTableManager.Instance:TryGetValue(v:GetEventids())
            if isfind then
                return data.param
            end
        end
    end
    return nil
end

return cfg_map_eventsManager