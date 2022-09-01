---@class LuaSfMissionManager 私服任务管理 调用实例    gameMgr:GetPlayerDataMgr():GetSfMissionMgr()
local LuaSfMissionManager = {}

---@return LusSfChallengeBossData 挑战首领数据类
function LuaSfMissionManager:GetChallengeBossData()
    if self.mChallengeBossData == nil then
        self.mChallengeBossData = luaclass.LusSfChallengeBossData:New()
    end
    return self.mChallengeBossData
end

---@return LuaSfMonsterArrestData 怪物悬赏数据类
function LuaSfMissionManager:GetMonsterArrestData()
    if self.mMonsterArrestData == nil then
        self.mMonsterArrestData = luaclass.LuaSfMonsterArrestData:New()
    end
    return self.mMonsterArrestData
end

---@return LuaSfMonsterArrestData 灵魂任务数据类
function LuaSfMissionManager:GetLingHunMissionData()
    if self.mLingHunData == nil then
        self.mLingHunData = luaclass.LuaLingHunMissionData:New()
    end
    return self.mLingHunData
end


function LuaSfMissionManager:Init()

end

return LuaSfMissionManager