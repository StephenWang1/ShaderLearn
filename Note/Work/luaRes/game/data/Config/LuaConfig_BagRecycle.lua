---@class LuaConfig_BagRecycle 背包回收
local LuaConfig_BagRecycle = {}

--region 回收
---@param tblData roleV2.CollectionSetting lua table类型消息数据
---@private
function LuaConfig_BagRecycle:ResCollectionSetting(tblData)
    if tblData == nil then
        return
    end
    for i = 1, #tblData.setting do
        local bean = tblData.setting[i]
        self:SetServerSettingState(bean.id, bean.state == 1)
    end
end

---@return boolean 获取服务器存储的数据
---@private
function LuaConfig_BagRecycle:GetServerSettingState(recoverId)
    if self.mServerSettingState then
        return self.mServerSettingState[recoverId]
    end
end

---存储服务器设置
---@private
function LuaConfig_BagRecycle:SetServerSettingState(recoverId, state)
    if self.mServerSettingState == nil then
        self.mServerSettingState = {}
    end
    self.mServerSettingState[recoverId] = state
end

---@param recoverId number recover表id
---@return boolean 当前是否选中改id
---@public
function LuaConfig_BagRecycle:GetRecoverState(recoverId)
    local statePlayer = self:GetPlayerSettingState(recoverId)
    if statePlayer ~= nil then
        return statePlayer
    end
    local stateServer = self:GetServerSettingState(recoverId)
    if stateServer ~= nil then
        return stateServer
    end
    local coverInfo = clientTableManager.cfg_recoverManager:TryGetValue(recoverId)
    if coverInfo and coverInfo:GetAutoChooseCondition() == 1 then
        return true
    end
    return false
end

---玩家设置数据
---@public
function LuaConfig_BagRecycle:PlayerSettingRecoverState(recoverId, state)
    if self.mPlayerSettingState == nil then
        self.mPlayerSettingState = {}
    end
    self.mPlayerSettingState[recoverId] = state
end

---@return boolean 获取玩家设置的数据
---@private
function LuaConfig_BagRecycle:GetPlayerSettingState(recoverId)
    if self.mPlayerSettingState then
        return self.mPlayerSettingState[recoverId]
    end
end

---请求保存玩家设置的数据
---@public
function LuaConfig_BagRecycle:ReqSavePlayerData()
    if self.mPlayerSettingState == nil then
        return
    end

    local settings = {}
    for k, v in pairs(self.mPlayerSettingState) do
        self:SetServerSettingState(k, v)
        ---@type roleV2.SettingBean
        local item = {}
        item.id = k
        item.state = v and 1 or 0
        table.insert(settings, item)
    end
    if #settings > 0 then
        networkRequest.ReqCollectionSetting(settings)
    end
    self.mPlayerSettingState = {}
end
--endregion

--region 自动回收
function LuaConfig_BagRecycle:IsPlayerOpenAutoRecycle()
    local memberCondition = LuaGlobalTableDeal:GetAutoRecyclePlayerCondition()
    if memberCondition == nil then
        return false
    end
    local buff = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():GetTimeLimitRecycleBuff()
    if buff ~= true then
        local fullState = Utility.IsMainPlayerMatchCondition(memberCondition)
        if fullState == nil or fullState.success == false then
            return false
        end
    end
    local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
    local state = configInfo:GetInt(CS.EConfigOption.AutoRecycle) == 1
    return state
end

--endregion

return LuaConfig_BagRecycle