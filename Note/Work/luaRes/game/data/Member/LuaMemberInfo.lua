---@class LuaMemberInfo
local LuaMemberInfo = {}

--region 局部变量

--endregion

--region 数据处理
---@return vipV2.VipMemberInfo
function LuaMemberInfo:GetPlayerMemberInfo()
    return self.mPlayerMemberInfo
end

---@param data vipV2.VipMemberInfo
function LuaMemberInfo:SetPlayerMemberInfo(data)
    self.mPlayerMemberInfo = data
    gameMgr:GetLuaRedPointManager():CallPersonalBossRedPoint()
end

function LuaMemberInfo:GetPlayerMemberLevel()
    if self:GetPlayerMemberInfo() == nil then
        return 0
    end
    return self:GetPlayerMemberInfo().level
end

---@return TABLE.cfg_member 获取会员表
function LuaMemberInfo:GetMemberTbl()
    local playerMemberLevel = self:GetPlayerMemberLevel()
    if type(playerMemberLevel) ~= 'number' or playerMemberLevel <= 0 then
        return nil
    end
    return clientTableManager.cfg_memberManager:TryGetValue(playerMemberLevel)
end

function LuaMemberInfo:IsShowRedPoint()
    return self:IsShowLevelRedPoint() or self:IsShowDailyRedPoint()
end

function LuaMemberInfo:IsShowLevelRedPoint()
    if (self:GetPlayerMemberInfo() ~= nil and self:GetPlayerMemberInfo().receivedLevelReward ~= nil) then
        return self:GetPlayerMemberLevel() > #self:GetPlayerMemberInfo().receivedLevelReward
    else
        if (self:GetPlayerMemberLevel() ~= nil) then
            return self:GetPlayerMemberLevel() > 0
        else
            return false
        end
    end
end

function LuaMemberInfo:IsShowDailyRedPoint()
    if (self:GetPlayerMemberInfo() ~= nil and self:GetMemberTbl() ~= nil and self:GetMemberTbl():GetDailyReward() ~= nil and self:GetMemberTbl():GetDailyReward().list ~= nil and #self:GetMemberTbl():GetDailyReward().list >= 2) then
        return self:GetPlayerMemberInfo().dailyReceivedCount < self:GetMemberTbl():GetDailyReward().list[2]
    end
    return false
end

---获取当前会员的表数据,未找到表格内数据时返回1级会员数据
function LuaMemberInfo:GetCurLevelMemberTableData()
    local data = clientTableManager.cfg_memberManager:TryGetValue(self:GetPlayerMemberLevel())
    if (data == nil) then
        data = clientTableManager.cfg_memberManager:TryGetValue(1)
    end
    return data
end
--endregion

return LuaMemberInfo