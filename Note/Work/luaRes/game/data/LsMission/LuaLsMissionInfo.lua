---@class LuaLsMissionInfo 灵兽任务信息
local LuaLsMissionInfo = {}

--region Get

---获取灵兽任务字典
---@return table<number,table<number,LsMission>>  <章节,<索引,任务信息>>
function LuaLsMissionInfo:GetAllMissionDic()
    if self.allMissionDic == nil then
        self.allMissionDic = {}
    end
    return self.allMissionDic
end

---获取章节信息字典
---@return table<number,lingshouV2.LinshouSectionInfo>
function LuaLsMissionInfo:GetSecStateDic()
    if self.allSecStateDic == nil then
        self.allSecStateDic = {}
    end
    return self.allSecStateDic
end

function LuaLsMissionInfo:GetSecCount()
    if self.secCount == nil then
        self.secCount = 0
    end
    return self.secCount
end

---根据章节获取任务所有完成目标个数
---@param sec number 章节
---@return number 任务完成个数
function LuaLsMissionInfo:GetFulfillMissionCount(sec)
    local count = 0
    if self:GetAllMissionDic()[sec] ~= nil then
        for i, v in pairs(self:GetAllMissionDic()[sec]) do
            if v.rewardState == LuaLsMissionStateEnum.CanGet or v.rewardState == LuaLsMissionStateEnum.Geted then
                count = count + 1
            end
        end
    end
    return count
end

---根据章节获取任务所有已完成个数
---@param sec number 章节
---@return number 任务已完成个数
function LuaLsMissionInfo:GetFulfilledMissionCount(sec)
    local count = 0
    if self:GetAllMissionDic()[sec] ~= nil then
        for i, v in pairs(self:GetAllMissionDic()[sec]) do
            if v.rewardState == LuaLsMissionStateEnum.Geted then
                count = count + 1
            end
        end
    end
    return count
end

---获得一个本章节的任务信息
---@return LsMission |nil
function LuaLsMissionInfo:GetLsMissionBySecAndTaskID(sec, taskID)
    for i, v in pairs(self:GetAllMissionDic()[sec]) do
        if v.lsTaskId == taskID then
            return v
        end
    end
    return nil
end

---获取当前应该显示的章节
---@return number
function LuaLsMissionInfo:GetCurShowMissionSec()
    local sec = 0
    ---判断章节奖励有无可领
    for i, v in pairs(self:GetSecStateDic()) do
        if v.lockState == LuaLsMissionSecStateEnum.CanGet then
            return i
        end
    end
    --[[    ---判断任务有无可领：有可领奖页签 领奖优先 否则 后页签权重大于前页签，前提此页签为解锁状态
        for i, v in pairs(self:GetAllMissionDic()) do
            ---此页签为解锁状态
            if self:GetSecStateDic()[i] ~= nil and self:GetSecStateDic()[i].lockState ~= LuaLsMissionSecStateEnum.Lock then

                sec = i
                for j = 1, #v do
                    if v[j].rewardState == LuaLsMissionStateEnum.CanGet then
                        return i
                    end
                end
            end
        end]]
    local getedCount
    for i, v in pairs(self:GetAllMissionDic()) do
        ---此页签为解锁状态
        if self:GetSecStateDic()[i] ~= nil and self:GetSecStateDic()[i].lockState ~= LuaLsMissionSecStateEnum.Lock then
            sec = i
            getedCount = self:GetFulfilledMissionCount(sec)
            if getedCount < #v then
                return sec
            end
        end
    end

    return sec
end

---获取左侧任务栏当前应该显示的章节
---@return number
function LuaLsMissionInfo:GetCurLeftShowMissionSec()
    local sec = 0
    ---判断章节奖励有无可领
    --[[    for i, v in pairs(self:GetSecStateDic()) do
            if v.lockState == LuaLsMissionSecStateEnum.UnLock then
                return i
            end
        end]]
    local getedCount
    for i, v in pairs(self:GetAllMissionDic()) do
        ---此页签为解锁状态
        if self:GetSecStateDic()[i] ~= nil and self:GetSecStateDic()[i].lockState ~= LuaLsMissionSecStateEnum.Lock then
            sec = i
            getedCount = self:GetFulfilledMissionCount(sec)
            if getedCount < #v then
                return sec
            end
        end
    end

    return sec
end

---获取当前正在进行的任务根据章节
---如果所有任务都已经完成 章节奖励未领取默认显示最后一个
---@return LsMission|nil
function LuaLsMissionInfo:GetCurShowMissionBySec(sec)

    local tbl = self:GetAllMissionDic()[sec]
    if tbl == nil or #tbl == 0 then
        return nil
    end

    local length = #tbl
    for i = 1, length do
        if tbl[i].rewardState ~= LuaLsMissionStateEnum.Geted then
            return tbl[i]
        end
    end
    local missionState = self:GetSecStateDic()[sec]
    if sec <= self:GetSecCount() and missionState.lockState == LuaLsMissionSecStateEnum.CanGet then
        return tbl[length]
    end
    return nil
end

---根据章节和任务id 获得认任务数据
function LuaLsMissionInfo:GetMissionInfoBySecAndLsId(sec, id)
    local tbl = self:GetAllMissionDic()[sec]
    if tbl == nil or #tbl == 0 then
        return nil
    end
    local length = #tbl
    for i = 1, length do
        if tbl[i].lsTaskId == id then
            return tbl[i]
        end
    end
end

--endregion

--region Set

---初始化灵兽章节信息
---@param info lingshouV2.ResLingShouTaskPanel
function LuaLsMissionInfo:InitLsTaskData(info)

    self:ResetDic()

    if info.taskInfo ~= nil and #info.taskInfo > 0 then
        for i = 1, #info.taskInfo do
            self:SetLsTaskData(info.taskInfo[i])
        end
    end

    if info.secInfo ~= nil and #info.secInfo > 0 then
        self.allSecStateDic = {}
        local count = #info.secInfo
        for i = 1, count do
            self:SetSecData(info.secInfo[i])
        end
        self:InitRedPointKeyData(count)
        self.secCount = count
    end

    --[[    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LsMission_All))
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LsMission_First))
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LsMission_Second))]]
end

---刷新任务信息
---@param info lingshouV2.ResLingShouTaskInfo
function LuaLsMissionInfo:RefreshLsMission(info)
    if info.taskInfo == nil or #info.taskInfo == 0 then
        return
    end
    for i = 1, #info.taskInfo do
        self:SetLsTaskData(info.taskInfo[i])
    end
    self:RefrshAllRedPoint()
end

---设置任务信息
---@param info lingshouV2.LinshouTaskInfo
function LuaLsMissionInfo:SetLsTaskData(info)
    local secMissions = self:GetAllMissionDic()[info.section]
    if secMissions == nil then
        secMissions = {}
        ---@type LsMission
        local mission = self:CreatLsMissionTemplate(info)
        if mission then
            table.insert(secMissions, mission)
            self:GetAllMissionDic()[info.section] = secMissions
        end
    else
        local isNeedSort = false
        local isChanged = false

        for i = 1, #secMissions do
            if secMissions[i].lsTaskId == info.id then
                isChanged = true
                isNeedSort = secMissions[i].rewardState ~= info.state
                secMissions[i].rewardState = info.state
                if info.goalInfo ~= nil then
                    secMissions[i].curFillValue = info.goalInfo.curCount
                end
            end
        end

        if not isChanged then
            local mission = self:CreatLsMissionTemplate(info)
            if mission then
                table.insert(secMissions, mission)
                self:GetAllMissionDic()[info.section] = secMissions
            end
        end

        --region 排序（暂不需要）
        --if isNeedSort then
        --    if self.sortFunc == nil then
        --        self.sortFunc = function(l, r)
        --            return self:SortMission(l, r)
        --        end
        --    end
        --
        --    table.sort(secMissions, self.sortFunc)
        --end
        --endregion

    end
end

---设置章节信息
---@param info lingshouV2.LinshouSectionInfo
function LuaLsMissionInfo:SetSecData(info)
    self:GetSecStateDic()[info.sec] = info
end

--endregion

--region Check
---是否有可领取的章节奖励
---@return boolean
function LuaLsMissionInfo:IsCanGetSecReward()
    if self.allSecStateDic ~= nil then
        for i, v in pairs(self.allSecStateDic) do
            if v == LuaLsMissionSecStateEnum.CanGet then
                return v
            end
        end
    end
    return false
end

---判断此章节是否有可领取的任务
---@param sec number 章节
---@return boolean   奖励可领
---@return number    可领奖励的任务id
function LuaLsMissionInfo:IsReveiveMissionOfSec(sec)
    if self:GetAllMissionDic()[sec] ~= nil then
        for i, v in pairs(self:GetAllMissionDic()[sec]) do
            if v.rewardState == LuaLsMissionStateEnum.CanGet then
                return true, v.lsTaskId
            end
        end
    end
    return false, 0
end

---是否含有任务信息
---@return boolean
function LuaLsMissionInfo:IsHasMission()
    local curSec = self:GetCurShowMissionSec()
    local mission = self:GetCurShowMissionBySec(curSec)
    return mission ~= nil
end

---是否显示任务到左侧任务栏
---@return boolean
function LuaLsMissionInfo:IsShowLeftMission()
    return self:IsHasMission()
end

--endregion

--region RedPoint
function LuaLsMissionInfo:GetAllRedPointList()
    if self.mAllRedPointList == nil then
        self.mAllRedPointList = {}
    end
    return self.mAllRedPointList
end

function LuaLsMissionInfo:InitRedPointKeyData(secCount)
    ---@type CSUIRedPointManager
    local csRedPointMgr = gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager()

    local key = self:GetRedPointKey()
    local callBack = function()
        return self:IsShowAllRedPoint()
    end
    csRedPointMgr:RegisterLuaCallRedPointFunction(key, callBack)
    table.insert(self:GetAllRedPointList(), key)

    for i = 1, secCount do
        local key, callBack
        key = self:GetRedPointKey(1, i)
        callBack = function()
            return self:IsShowSecRedPoint(i)
        end
        csRedPointMgr:RegisterLuaCallRedPointFunction(key, callBack)
        table.insert(self:GetAllRedPointList(), key)
    end
end

---获得红点key
function LuaLsMissionInfo:GetRedPointKey(type, id)
    if type == 0 or type == nil then
        return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LsMission_All)
    elseif type == 1 then
        return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey("LsMission_" .. tostring(id))
    end
end

---刷新所有红点
function LuaLsMissionInfo:RefrshAllRedPoint()
    local luaRedPointMgr = gameMgr:GetLuaRedPointManager()
    local count = #self:GetAllRedPointList()
    for i = 1, count do
        luaRedPointMgr:CallRedPointKey(self:GetAllRedPointList()[i])
    end
end

---是否显示主红点
---@return boolean
function LuaLsMissionInfo:IsShowAllRedPoint()
    ---判断章节奖励有无可领
    for i, v in pairs(self:GetSecStateDic()) do
        if v.lockState == LuaLsMissionSecStateEnum.CanGet then
            return true
        end
    end
    ---判断任务有无可领
    for i, v in pairs(self:GetAllMissionDic()) do
        if self:GetSecStateDic()[i] ~= nil and self:GetSecStateDic()[i].lockState ~= LuaLsMissionSecStateEnum.Lock then
            for j = 1, #v do
                if v[j].rewardState == LuaLsMissionStateEnum.CanGet then
                    return true
                end
            end
        end
    end
    return false
end

---是否显示章节红点
---@return boolean
function LuaLsMissionInfo:IsShowSecRedPoint(sec)

    ---如果章节未解锁则不显示
    if self:GetSecStateDic()[sec] ~= nil and self:GetSecStateDic()[sec].lockState ~= LuaLsMissionSecStateEnum.Lock then
        ---判断章节奖励有无可领
        for i, v in pairs(self:GetSecStateDic()) do
            if i == sec and v.lockState == LuaLsMissionSecStateEnum.CanGet then
                return true
            end
        end
        ---判断任务有无可领
        for i, v in pairs(self:GetAllMissionDic()) do
            for j = 1, #v do
                if v[j].sec == sec and v[j].rewardState == LuaLsMissionStateEnum.CanGet then
                    return true
                end
            end
        end
    end
    return false
end

--endregion

--region Other

---任务排序
---@param l LsMission
---@param r LsMission
function LuaLsMissionInfo:SortMission(l, r)
    if l.rewardState ~= r.rewardState then
        return l.rewardState < r.rewardState
    end
    return l.sort < r.sort
end

function LuaLsMissionInfo:ResetDic()
    self.allMissionDic = {}
    self.allSecStateDic = {}
end

---根据服务器消息创建客户端单个数据模板
---@param info lingshouV2.LinshouTaskInfo
---@return LsMission|nil
function LuaLsMissionInfo:CreatLsMissionTemplate(info)
    if info == nil then
        return nil
    end

    local lsTaskTbl = clientTableManager.cfg_lingshoutaskManager:TryGetValue(info.id)
    local taskgoalTbl = clientTableManager.cfg_taskgoalManager:TryGetValue(info.goalInfo.goalId)
    if lsTaskTbl == nil or taskgoalTbl == nil then
        return nil
    end

    --region 设置奖励
    local rewardTbl = {}

    if lsTaskTbl:GetRewards() ~= nil and lsTaskTbl:GetRewards().list ~= nil then

        for i = 0, lsTaskTbl:GetRewards().list.Count - 1 do
            local rewardInfo = lsTaskTbl:GetRewards().list[i]
            if rewardInfo.list.Count > 1 then
                local rewardItem = {
                    itemid = rewardInfo.list[0],
                    count = rewardInfo.list[1],
                }
                table.insert(rewardTbl, rewardItem)
            end
        end
    end
    --endregion

    ---@class LsMission 灵兽任务单个数据模板
    local lsMission = {
        ---任务表id
        goalId = info.goalInfo.goalId,
        ---灵兽任务id(暂用于发送领取奖励)
        lsTaskId = info.id,
        ---奖励物品信息
        rewardInfo = rewardTbl,
        ---奖励状态
        rewardState = info.state,
        ---当前进度
        curFillValue = info.goalInfo.curCount,
        ---最大进度
        maxFillValue = info.goalInfo.maxCount,
        ---章节id
        sec = lsTaskTbl:GetSection() == nil and 0 or lsTaskTbl:GetSection(),
        ---界面跳转id
        jumpId = lsTaskTbl:GetUipanel() == nil and 0 or lsTaskTbl:GetUipanel(),
        ---界面跳转类型
        jumpType = lsTaskTbl:GetJumptype() == nil and 0 or lsTaskTbl:GetJumptype(),
        ---完成文本
        targetDes = lsTaskTbl:GetTips() == nil and '' or lsTaskTbl:GetTips(),
        ---描述
        des = lsTaskTbl:GetTaskInfo() == nil and '' or lsTaskTbl:GetTaskInfo(),
        ---跳转限制
        conditon = lsTaskTbl:GetConditions() == nil and '' or lsTaskTbl:GetConditions(),
        ---气泡id
        bubbleID = lsTaskTbl:GetBubbleID(),
        ---单元所需参数 bg地图#posx#posy#地图偏转类型#
        unitParams = lsTaskTbl:GetUnitParam() == nil and {} or string.Split(lsTaskTbl:GetUnitParam(), '#'),
        ---怪物头像展示
        monsterIcon = lsTaskTbl:GetHead() == nil and {} or lsTaskTbl:GetHead(),
        ---左侧任务栏显示
        leftMission = lsTaskTbl:GetRemark() == nil and '' or lsTaskTbl:GetRemark()
        --排序
        --sort = lsTaskTbl:GetPriority() == nil and 0 or lsTaskTbl:GetPriority(),
    }

    return lsMission
end

--endregion

return LuaLsMissionInfo