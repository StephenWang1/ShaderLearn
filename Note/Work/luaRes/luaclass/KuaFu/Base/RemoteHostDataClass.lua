local RemoteHostDataClass = {}

--region 查询
---主角是否在跨服地图
---@return boolean 获取自己当前是否在跨服地图
function RemoteHostDataClass:IsKuaFuMap()
    local mapId = CS.CSScene:getMapID()
    if mapId ~= self.CurrentPlayerMapId then
        self.PlayerInKuaFu = self:IsKuaFuMapByMapId(mapId)
        self.CurrentPlayerMapId = mapId
        return self.PlayerInKuaFu
    else
        return self.PlayerInKuaFu
    end
end

---@boolean 获取某个地图是否是跨服地图
function RemoteHostDataClass:IsKuaFuMapByMapId(mapId)
    if mapId then
        local res, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mapId)
        if res then
            return mapInfo.serverType == 2
        end
    end
    return false
end

--endregion

--region 获取
---获取连服前缀名
---@param platformId number 平台id
---@param serverId number 服务器id
---@return string 连服前缀
function RemoteHostDataClass:GetLianFuPrefixName(platformId, serverId)
    return CS.CSRemoteHostInfo.GetLianFuPrefixName(platformId, serverId)
end

---获取平台名字
---@param platformId number 平台id
---@return string 平台名字
function RemoteHostDataClass:GetPlatformName(platformId)
    return CS.CSRemoteHostInfo.GetPlatformName(platformId)
end

---获取服务器名字
---@param serverId number 服务器id
---@return string 服务器名字
function RemoteHostDataClass:GetServerName(serverId)
    if serverId == nil or type(serverId) ~= 'number' then
        return serverId
    end
    local serverItem = CS.HttpRequest.Instance.ServerFile:GetServerItem(serverId)
    if serverItem ~= nil then
        return serverItem.ServerName
    end
    return tostring(serverId)
end

--- 通过服务器主机id获取联服前缀名
---@param hostId number 主机id
---@return string 联服前缀名
function RemoteHostDataClass:GetLianFuPrefixNameByHostId(hostId)
    if hostId == nil or type(hostId) ~= 'number' then
        return ''
    end
    local platformId = self:GetPlatformIdByHostId(hostId)
    local serverId = self:GetServerIdByHostId(hostId)
    return self:GetLianFuPrefixName(tonumber(platformId), tonumber(serverId))
end

--- 通过服务器主机id解析serverid
---@param hostId number 主机id
---@return number 服务器id
function RemoteHostDataClass:GetServerIdByHostId(hostId)
    if hostId == nil or type(hostId) ~= 'number' then
        return hostId
    end
    local serverid = CS.CSRemoteHostInfo.GetServerIdByHostId(hostId)
    if serverid ~= nil then
        return serverid
    end
    return tostring(hostId)
end

--- 通过服务器主机id解析platformId
---@param hostId number 主机id
---@return number platformId
function RemoteHostDataClass:GetPlatformIdByHostId(hostId)
    if hostId == nil or type(hostId) ~= 'number'  then
        return hostId
    end
    local platformId = CS.CSRemoteHostInfo.GetPlatformIdByHostId(hostId)
    if platformId ~= nil then
        return platformId
    end
    return tostring(hostId)
end

--- 通过服务器主机id获取平台名 和 serverID
---@param hostId number 主机id
---@return string 平台名
---@return string serverID
---@return string 服务器名字
function RemoteHostDataClass:GetLianFuShowInfoByHostId(hostId)
    if hostId == nil or type(hostId) ~= 'number' or hostId == 0 then
        return ''
    end
    local platformId = self:GetPlatformIdByHostId(hostId)
    local serverId = self:GetServerIdByHostId(hostId)
    return self:GetPlatformName(platformId), tostring(serverId), self:GetServerName(serverId)
end

--- 通过服务器主机id获取平台名 和 serverID 包括 s前缀
---@param hostId number 主机id
---@return string 平台名
---@return string serverID
---@return string 服务器名字
function RemoteHostDataClass:GetLianFuShowSInfoByHostId(hostId)
    if hostId == nil or type(hostId) ~= 'number' or hostId == 0 then
        return ''
    end
    local platformId = self:GetPlatformIdByHostId(hostId)
    local serverId = self:GetServerIdByHostId(hostId)
    return self:GetPlatformName(platformId), "S" .. tostring(serverId), self:GetServerName(serverId)
end

--- 通过服务器主机id获取社交前缀格式：[XY001]
---@param hostId number 主机id
---@return string 前缀
function RemoteHostDataClass:GetLianFuShowSocialInfoByHostId(hostId)
    if hostId == nil or type(hostId) ~= 'number' or hostId == 0 then
        return ''
    end
    local platformId = self:GetPlatformIdByHostId(hostId)
    local serverId = self:GetServerIdByHostId(hostId)
    if platformId == 0 then
        return '[' .. self:GetServerName(serverId) .. ']'
    end
    return '[' .. self:GetPlatformName(platformId) .. tostring(serverId) .. ']'
end

---和主角是否是同一个hostid
---@param hostId number 主机id
---@return boolean 是否相同
function RemoteHostDataClass:SameMainPlayerHostId(hostId)
    if hostId == nil or hostId == 0 then
        return false
    end
    if gameMgr:GetLuaMainPlayer() ~= nil then
        local mainPlayerRemoteHostInfo = gameMgr:GetLuaMainPlayer():GetMainPlayerRemoteHostInfo()
        if mainPlayerRemoteHostInfo ~= nil then
            return mainPlayerRemoteHostInfo.RemoteHostId == hostId
        end
    end
    return false
end
--endregion

--- 通过服务器主机id获取排行榜联服前缀名格式
---@param hostId number 主机id
---@return string 联服前缀名
function RemoteHostDataClass:GetLianFuRankNameFormatByHostId(hostId)
    if hostId == nil or type(hostId) ~= 'number' then
        return ''
    end
    --local platformId = self:GetPlatformIdByHostId(hostId)
    local serverId = self:GetServerIdByHostId(hostId)
    return 's' .. tostring(serverId) .. '.'
end

---游戏场景退回到登录/选角界面时触发
function RemoteHostDataClass:OnExitDestroy()
    self.CurrentPlayerMapId = nil
    self.PlayerInKuaFu = nil
end
return RemoteHostDataClass