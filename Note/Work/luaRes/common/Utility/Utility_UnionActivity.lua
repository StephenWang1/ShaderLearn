---@type Utility
local Utility = Utility

--region 行会地宫活动
---得到当前生效的行会地宫活动数据
---@return number|nil
function Utility.GetNowGuildDungeonAtciveID()
    local activeTimeList = LuaGlobalTableDeal:GetUnionDungeonOpenActiveList()
    if activeTimeList ~= nil then
        local nowM = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
        --print("当前时间", nowM)
        for i, v in pairs(activeTimeList) do
            if v.startTime <= nowM and v.endTime > nowM then
                return v.activeID
            end
        end
    end
end

---行会地宫进入限制
---@return boolean true 可以进入 false 不可进入
function Utility.UnionDungeonEnterLimit()
    if CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    if CS.CSScene.MainPlayerInfo.Level >= LuaGlobalTableDeal:GetUnionDungeonEnterLevelLimit() then
        return true
    end
    return false
end
--endregion

--region 行会秘境活动
---获取当前行会秘境活动相对于玩家是否显示
---@return boolean
function Utility.GetIsHangHuiMiJingShowInGuild()
    ---行会前三才能显示行会秘境活动，行会秘境针对排名前三的行会开放，非排名前三的行会无法进入该玩法
    ---行会秘境不再限制前三行会,只要有行会就能开启
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0 then
        return false
    else
        return true
    end
    local currentUnionRank = Utility.GetMainPlayerUnionRank()

    if currentUnionRank <= 0 then
        return false
    end
    local unionRankLimit, minProsPerity = Utility.GetThirdUnionHangHuiMiJingLimitCondition()
    if currentUnionRank <= unionRankLimit and currentUnionRank >= 1 then
        return true
    end
    return false
end

---获取主角的帮会排名
---@return number 返回排名,1表示第一帮会 -1表示主角信息不存在 0一般表示主角没有加入行会
function Utility.GetMainPlayerUnionRank()
    if CS.CSScene.MainPlayerInfo == nil then
        return -1
    end
    return CS.CSScene.MainPlayerInfo.UnionInfoV2.Ranking
end

---获取当前的行会秘境活动ID和当前的实际状态
---@return number|nil
function Utility.GetCurrentEnabledHangHuiMiJingID()
    local currentUnionRank = Utility.GetMainPlayerUnionRank()
    ---行会排名限制
    local unionRankLimit, minProsPerity = Utility.GetThirdUnionHangHuiMiJingLimitCondition()
    if currentUnionRank > unionRankLimit or currentUnionRank <= 0 then
        ---如果当前行会不处于最后一个行会排名限制，即为第三以下的行会,则不显示行会秘境活动
        return nil
    else
        return 429
    end
end

---获取行会合并小时数(此小时为从开服首日0时开始到行会第一次自动合并的小时数)
---@return number
function Utility.GetUnionCombineHours()
    if Utility.mUnionCombineHours == nil then
        local isExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22657)
        local strs = string.Split(tbl.value, '#')
        if #strs > 0 then
            Utility.mUnionCombineHours = tonumber(strs[1])
        else
            Utility.mUnionCombineHours = 48
        end
    end
    return Utility.mUnionCombineHours
end

---获取第三行会的行会秘境限制条件
---@return number, number 行会排名 进入秘境的行会最小繁荣度
function Utility.GetThirdUnionHangHuiMiJingLimitCondition()
    if Utility.mThirdUnionHangHuiMiJingLimitConditions == nil then
        ---此处虽然命名为第三行会,但是3来源于global表中22742定义
        Utility.mThirdUnionHangHuiMiJingLimitConditions = {}
        ---@type TABLE.CFG_GLOBAL
        local tbl
        ___, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22742)
        if tbl then
            local strs = string.Split(tbl.value, '#')
            if #strs >= 2 then
                Utility.mThirdUnionHangHuiMiJingLimitConditions[1] = tonumber(strs[1])
                Utility.mThirdUnionHangHuiMiJingLimitConditions[2] = tonumber(strs[2])
            end
        end
    end
    if #Utility.mThirdUnionHangHuiMiJingLimitConditions <= 0 then
        return 0, 0
    end
    local unionRank = Utility.mThirdUnionHangHuiMiJingLimitConditions[1]
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionProsPerityYesterday == nil
            or not CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionProsPerityYesterday:ContainsKey(1) then
        return unionRank, 0
    end
    ---取第一行会前一日的繁荣度
    local firstUnionProsPerity = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionProsPerityYesterday[1]
    ---服务器是以浮点数进行比较的,所以此处客户端显示整数的话,需要向上取整
    local minUnionProsPerity = math.ceil(Utility.mThirdUnionHangHuiMiJingLimitConditions[2] * firstUnionProsPerity / 10000)
    return unionRank, minUnionProsPerity
end
--endregion

--region 行会首领
---获取当前行会首领相对于玩家是否显示
---@return boolean
function Utility.GetIsHangHuiShouLingShowInGuild()
    ---行会前三才能显示行会首领活动，行会首领针对排名前三的行会开放，非排名前三的行会无法进入该玩法
    local currentUnionRank = Utility.GetMainPlayerUnionRank()
    if currentUnionRank <= 0 then
        return false
    end
    local unionRankLimit, minProsPerity = Utility.GetThirdUnionHangHuiMiJingLimitCondition()
    if currentUnionRank <= unionRankLimit and currentUnionRank >= 1 then
        return true
    end
    return false
end

---得到当前生效的行会地宫活动数据
---@return number|nil
function Utility.GetNowShouLingAtciveID()
    local activeTimeList = {}

    local ids = {}
    table.insert(ids, 434)
    table.insert(ids, 435)

    for i, id in pairs(ids) do
        local tbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(id)
        if (tbl ~= nil) then
            local activityId = 0
            if (id == 434) then
                activityId = 433
            elseif (id == 435) then
                activityId = 434
            end

            local activeInfo = {
                startTime = tonumber(tbl:GetStartTime()),
                endTime = tonumber(tbl:GetOverTime()),
                activeID = tonumber(activityId),
            }
            table.insert(activeTimeList, activeInfo)
        end
    end

    if activeTimeList ~= nil then
        local nowM = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
        for i, v in pairs(activeTimeList) do
            if v.startTime <= nowM and v.endTime > nowM then
                return v.activeID
            end
        end
    end
    return nil
end
--endregion