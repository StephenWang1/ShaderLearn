---@class LuaSfMonsterArrestData 怪物悬赏数据
local LuaSfMonsterArrestData = {}

---怪物数据改变（使用原C#数据，有需要再改）
function LuaSfMonsterArrestData:ResMonsterArrestInfoChange()
    self:MonsterArrestDataDeal()
    self:RedPointDataDeal()
    local MonsterArrest = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MonsterArrest)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(MonsterArrest)
    luaEventManager.DoCallback(LuaCEvent.MonsterArrestDataChange)
end

---处理数据
function LuaSfMonsterArrestData:MonsterArrestDataDeal()
    self:ClearAllData()
    local data = CS.CSMissionManager.Instance:GetMonsterTaskDic()
    if data then
        CS.Utility_Lua.luaForeachCsharp:Foreach(data, function(k, v)
            ---@type CSMission
            local mission = v
            local taskInfo = mission.tbl_tasks
            local group = taskInfo.subtype
            local groupInfos = self.mAllData[group]
            if groupInfos then
                table.insert(groupInfos, mission)
            else
                local groupInfo = {}
                table.insert(groupInfo, mission)
                self.mAllData[group] = groupInfo
                table.insert(self.mAllBookMark, group)
            end
        end)
        table.sort(self.mAllBookMark, function(a, b)
            local leftInfo = self:GetActivityBossTableInfoCache(a)
            local rightInfo = self:GetActivityBossTableInfoCache(b)
            if leftInfo == nil or rightInfo == nil then
                return false
            end
            return leftInfo.tableOrder < rightInfo.tableOrder
        end)
    end
end

---@return TABLE.CFG_ACTIVITY_BOSS 活动数据
function LuaSfMonsterArrestData:GetActivityBossTableInfoCache(id)
    if id then
        local res, info = CS.Cfg_Activity_BossTableManager.Instance.dic:TryGetValue(id)
        return info
    end
end

---处理红点
function LuaSfMonsterArrestData:RedPointDataDeal()
    local allData = self:GetAllMissionData()
    for k, v in pairs(allData) do
        local groupAllData = v
        local isAllFinish = true
        for i = 1, #groupAllData do
            local singleMission = groupAllData[i]
            if singleMission.State ~= CS.ETaskV2_TaskState.HAS_COMPLETE then
                isAllFinish = false
            end
        end
        if isAllFinish then
            self.mNeedShowRedPoint = true
            return
        end
    end
    self.mNeedShowRedPoint = false
end

---清空数据
function LuaSfMonsterArrestData:ClearAllData()
    ---@type table<number,table<number,CSMission>> 每一组对应的所有任务
    self.mAllData = {}
    ---@type table<number,number> 所有的页签数据
    self.mAllBookMark = {}
end

---@return table<number,table<number,CSMission>> 每一组对应的所有任务
function LuaSfMonsterArrestData:GetAllMissionData()
    return self.mAllData
end

---@return table<number,number> 所有的页签数据
function LuaSfMonsterArrestData:GetAllBookMark()
    return self.mAllBookMark
end

---@return boolean 是否有某一组任务完成了
function LuaSfMonsterArrestData:IsShowRedPoint()
    return self.mNeedShowRedPoint
end

---获取第一个怪物悬赏任务
---@return CSMission,number 第一个显示的任务,已经完成的组id
function LuaSfMonsterArrestData:GetCurrentShowMonsterArrestMission()
    local mAllData = self:GetAllMissionData()
    local mAllBookMark = self:GetAllBookMark()
    if mAllBookMark == nil then
        return
    end
    for i = 1, #mAllBookMark do
        local group = mAllBookMark[i]
        local missionList = mAllData[group]
        if missionList then
            table.sort(missionList, function(a, b)
                return self:SortMission(a, b)
            end)
            local isAllFinish = true
            if #missionList > 0 then
                for i = 1, #missionList do
                    ---@type CSMission
                    local singleMis = missionList[i]
                    if singleMis.State == CS.ETaskV2_TaskState.HAS_ACCEPT then
                        return singleMis, nil
                    end
                    if singleMis.State ~= CS.ETaskV2_TaskState.HAS_COMPLETE then
                        isAllFinish = false
                    end
                end
                if isAllFinish then
                    return missionList[1], group
                end
            end
        end
    end
end

---@param a CSMission
---@param b CSMission
function LuaSfMonsterArrestData:SortMission(a, b)
    --[[    if a.State ~= b.State then
            if a.State == CS.ETaskV2_TaskState.HAS_COMPLETE or b.State == CS.ETaskV2_TaskState.HAS_COMPLETE then
                return a.State == CS.ETaskV2_TaskState.HAS_COMPLETE and true or false
            elseif a.State == CS.ETaskV2_TaskState.HAS_ACCEPT or b.State == CS.ETaskV2_TaskState.HAS_ACCEPT then
                return a.State == CS.ETaskV2_TaskState.HAS_ACCEPT and true or false
            elseif a.State == CS.ETaskV2_TaskState.ETaskV2_TaskState.HAS_SUBMIT or b.State == CS.ETaskV2_TaskState.HAS_SUBMIT then
                return a.State == CS.ETaskV2_TaskState.HAS_SUBMIT and true or false
            end
        else
            local ataskTable = clientTableManager.cfg_taskManager:TryGetValue(a.tbl_tasks.id)
            local btaskTable = clientTableManager.cfg_taskManager:TryGetValue(b.tbl_tasks.id)
            if ataskTable and btaskTable then
                local aOrder = ataskTable:GetOrder() == nil and 0 or ataskTable:GetOrder()
                local bOrder = btaskTable:GetOrder() == nil and 0 or btaskTable:GetOrder()
                return aOrder < bOrder
            end
            return a.tbl_tasks.id < b.tbl_tasks.id
        end
        return false]]
    local ataskTable = clientTableManager.cfg_taskManager:TryGetValue(a.tbl_tasks.id)
    local btaskTable = clientTableManager.cfg_taskManager:TryGetValue(b.tbl_tasks.id)
    if ataskTable and btaskTable then
        local aOrder = ataskTable:GetOrder() == nil and 0 or ataskTable:GetOrder()
        local bOrder = btaskTable:GetOrder() == nil and 0 or btaskTable:GetOrder()
        return aOrder < bOrder
    end
    return a.tbl_tasks.id < b.tbl_tasks.id
end

---@return number 根据任务获取目标monsterId
---@param mission CSMission
function LuaSfMonsterArrestData:GetMonsterIdByMission(mission)
    if mission == nil then
        return
    end
    local tbl_taskGoalS = mission.tbl_taskGoalS
    if tbl_taskGoalS == nil or tbl_taskGoalS.Count == 0 then
        return
    end
    local nowGoalS = tbl_taskGoalS[0]
    if nowGoalS == nil then
        return
    end
    local globleID = nowGoalS.taskGoalParam
    local bossID = 0
    if nowGoalS.taskGoalType == 85 then
        bossID = self:GetMissionGoalInfo(globleID)
    elseif nowGoalS.taskGoalType == 1 then
        bossID = nowGoalS.taskGoalParam
    end
    return bossID
end

---@return number 任务bossId
function LuaSfMonsterArrestData:GetMissionGoalInfo(globleID)
    if self.mMissionGoalInfo == nil then
        self.mMissionGoalInfo = {}
    end
    local info = self.mMissionGoalInfo[globleID]
    if info == nil then
        local isfindG, dataG = CS.Cfg_GlobalTableManager.Instance:TryGetValue(globleID)
        if isfindG then
            local strList = _fSplit(dataG.value, '#')
            if strList ~= nil and #strList >= 1 then
                info = tonumber(strList[1])
                self.mMissionGoalInfo[globleID] = info
            end
        end
    end
    return info
end

---@return string 获得任务进度
---@param needColor boolean 是否需要颜色
function LuaSfMonsterArrestData:GetMissionProgress(csmission, needColor, needDes)
    if csmission == nil then
        return
    end
    local TaskShowInfo = csmission:GetDailyTaskShowInfo()
    if TaskShowInfo == nil or TaskShowInfo.Count == 0 then
        return
    end
    local Des = ""
    if needDes then
        if csmission.tbl_taskGoalS ~= nil and csmission.tbl_taskGoalS.Length > 0 then
            Des = csmission.tbl_taskGoalS[0].description
        end
    end
    local CurCount = TaskShowInfo[0].CurCount
    local MaxCount = TaskShowInfo[0].MaxCount
    local color = ""
    if needColor then
        if CurCount == 0 then
            color = luaEnumColorType.Red
        elseif CurCount == MaxCount then
            if csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT then
                color = "[878787]"
            else
                color = "[00ff00]"
            end
        end
    end
    return Des .. color .. CurCount .. "[-]/" .. MaxCount
end

return LuaSfMonsterArrestData