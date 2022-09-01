---@class cfg_mapManager:TableManager
local cfg_mapManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_map
function cfg_mapManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_map> 遍历方法
function cfg_mapManager:ForPair(action)
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
function cfg_mapManager:PostProcess()
end

---是否是跨服地图
---@param mapId number 地图id
---@return boolean 是否是跨服地图
function cfg_mapManager:IsKuaFuMap(mapId)
    local tbl = self:TryGetValue(mapId)
    if tbl ~= nil then
        return tbl:GetServerType() == 2
    end
    return false
end

---获取地图名字
---@param mapId number 地图id
---@return string 地图名字
function cfg_mapManager:GetMapNames(mapId)
    local tbl = self:TryGetValue(mapId)
    if tbl ~= nil then
        return tbl:GetName()
    end
    return ""
end

--region 开启跨服的地图
---是否是即将开启跨服的地图（与当前服务器开跨服次数有关）
---@param mapId number 地图id
---@return boolean 是否是即将开启跨服的地图
function cfg_mapManager:IsOpenKuaFuMap(mapId)
    if self.OpenKuaFuMapTable == nil or type(self.OpenKuaFuMapTable) ~= 'table' then
        return false
    end
    return Utility.IsContainsValue(self.OpenKuaFuMapTable,mapId)
end

---刷新打开跨服地图表（跨服地图id+将开跨服的地图id）
function cfg_mapManager:RefreshOpenKuaFuMapTable()
    self.OpenKuaFuMapTable = {}
    if self.dic == nil then
        return
    end
    for k,v in pairs(self.dic)do
        if v ~= nil and v:GetShareNum() ~= nil and type(v:GetShareNum()) == 'number' and v:GetShareNum() > 0 and gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetOpenKuaFuNum() + 1 >= v:GetShareNum() then
            ---添加跨服地图id
            table.insert(self.OpenKuaFuMapTable,v:GetId())
            ---添加本服地图id
            table.insert(self.OpenKuaFuMapTable,v:GetRealMapId())
        end
    end
end

---检测玩家是否可以进入地图
---@param mapId number
---@return boolean
function cfg_mapManager:CheckMainPlayerCanEnterMap(mapId)
    local tbl = self:TryGetValue(mapId)
    if tbl ~= nil and tbl:GetConditionId() ~= nil and type(tbl:GetConditionId().list) == 'table' and Utility.GetTableCount(tbl:GetConditionId().list) > 0 then
        local conditionResult = Utility.IsMainPlayerMatchConditionList_AND(tbl:GetConditionId().list)
        return conditionResult.success
    end
    return true
end
--endregion


return cfg_mapManager