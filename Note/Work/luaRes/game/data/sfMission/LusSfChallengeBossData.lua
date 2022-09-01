---@class LusSfChallengeBossData
local LusSfChallengeBossData = {}

--region 服务器消息
---刷新私服首领挑战消息
---@param tblData taskV2.ResAllNewDailyTaskInfo lua table类型消息数据
function LusSfChallengeBossData:ResAllNewDailyTaskInfo(tblData)
    self.mAllMission = tblData
    ---当前是否有任务完成
    ---当前正在进行的任务
    self.mHasFinishMission, self.mCurrentMission = self:SaveCurrentMission(tblData)

    luaEventManager.DoCallback(LuaCEvent.ChallengeBossDataChange)
end

---@param tblData taskV2.ResAllNewDailyTaskInfo lua table类型消息数据
---@return boolean,taskV2.NewDailyTaskState 是否有任务完成未领，当前正在进行的任务
function LusSfChallengeBossData:SaveCurrentMission(tblData)
    local hasFinish = false
    local currentMission = nil
    for i = 1, #tblData.state do
        local singleMission = tblData.state[i]
        if singleMission.state == 3 then
            hasFinish = true
        end
        if singleMission.state == 2 then
            currentMission = singleMission
        end
    end
    return hasFinish, currentMission
end
--endregion

---@return taskV2.ResAllNewDailyTaskInfo
function LusSfChallengeBossData:GetAllChallengeBossData()
    return self.mAllMission
end

---@return taskV2.NewDailyTaskState 当前正在进行的活动
function LusSfChallengeBossData:GetCurrentMission()
    return self.mCurrentMission
end

---@return boolean 是否有任意任务完成了
function LusSfChallengeBossData:IsAnyMissionFinish()
    return self.mHasFinishMission
end

return LusSfChallengeBossData