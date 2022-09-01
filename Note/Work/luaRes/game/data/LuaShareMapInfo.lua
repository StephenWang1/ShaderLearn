---@class LuaShareMapInfo 玩家联服相关信息
local LuaShareMapInfo = {}

---@type roleV2.GameBasicShareInfo
LuaShareMapInfo.mBasicData = nil
---跨服开启次数
---@type number
LuaShareMapInfo.OpenKuaFuNum = 0

function LuaShareMapInfo:Init()
end

---@param tblData roleV2.GameBasicShareInfo
function LuaShareMapInfo:RefreshLuaShareMapData(tblData)
    self:BeforeRefreshFunc(tblData)
    self.mBasicData = tblData
    self.OpenKuaFuNum = tblData.shareNum
    self.shareOpenTime = tblData.shareOpenTime
    clientTableManager.cfg_mapManager:RefreshOpenKuaFuMapTable()
end

---获取本次联服时间
---@return number
function LuaShareMapInfo:GetShareOpenTime()
    return self.shareOpenTime
end

---@return roleV2.GameBasicShareInfo
function LuaShareMapInfo:GetShareMapData()
    return self.mBasicData;
end

---刷新跨服开启状态
---@param state boolean 开启状态
function LuaShareMapInfo:RefreshKuaFuOpenState(state)
    self.KuaFuState = state
end

---@return boolean 是否开启联服
function LuaShareMapInfo:IsOpenShareMap()
    return ternary(self.KuaFuState ~= nil, self.KuaFuState, false)
end

---获取开启跨服次数
---@return number 开启跨服次数
function LuaShareMapInfo:GetOpenKuaFuNum()
    if self.OpenKuaFuNum == nil then
        return 0
    end
    return self.OpenKuaFuNum
end

---获取联服历史记录
---@return table<number, roleV2.ShareOpenTimeInfo> 历史记录
function LuaShareMapInfo:GetCrossServerHistory()
    if (self.mBasicData ~= nil) then
        return self.mBasicData.shareOpenTimes
    end
    return nil
end

---获取下次联服开启时间
---@return number 时间
function LuaShareMapInfo:GetNextCrossServerTime()
    if (self.mBasicData ~= nil) then
        return self.mBasicData.willUniteUnionTimeOpen
    end
    return 0
end

---刷新时间数据之前的处理
---@param tblData roleV2.GameBasicShareInfo
function LuaShareMapInfo:BeforeRefreshFunc(tblData)
    self:CheckRegisteVoteTimeEvent(tblData)
end

--region 联盟投票时间相关

---获取联盟投票时间信息
---@return number 开始投票时间
---@return number 结束投票时间
function LuaShareMapInfo:GetUnionVoteTimeData()
    local beginTime, endTime = 0, 0
    if self.mBasicData ~= nil then
        if self.mBasicData.unionVoteBeginTime ~= nil then
            beginTime = self.mBasicData.unionVoteBeginTime
        end
        if self.mBasicData.unionVoteEndTime ~= nil then
            endTime = self.mBasicData.unionVoteEndTime
        end
    end
    return beginTime, endTime
end

---检测是否需要注册联盟投票事件
---@param timeData roleV2.GameBasicShareInfo
function LuaShareMapInfo:CheckRegisteVoteTimeEvent(timeData)
    --[[    ---如果是第二次联服不显示投票
        if timeData == nil or timeData.shareNum > 0 then
            return
        end
        ---判断服务器时间有无设置
        if not CS.CSServerTime.IsServerTimeReceived then
            return
        end

        if CS.CSScene.MainPlayerInfo == nil then
            return
        end

        local unionId = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID
        if unionId == 0 then
            Utility.RemoveClientSystem(luaEnumActivityBtnType.LeagueVote)
            gameMgr:GetLuaTimeMgr():RemoveTimeRespone(LuaRegisterTimeFinishEvent.LeagueVoteBegin)
            return
        end
        ---@type boolean 注册联盟投票开始时间线事件
        local isNeedRegisteVoteBeginEvent = true
        ---@type boolean 注册联盟投票结束时间线事件
        local isNeedRegisteVoteEndEvent = true

        local curServerTimeStamp = CS.CSServerTime.Instance.TotalMillisecond

        if isNeedRegisteVoteBeginEvent then
            ---当前时间是否在投票时间以内
            if curServerTimeStamp >= timeData.unionVoteBeginTime and curServerTimeStamp < timeData.unionVoteEndTime then
                isNeedRegisteVoteBeginEvent = false
                Utility.AddClientSystem(luaEnumActivityBtnType.LeagueVote)
            end
        end

        if isNeedRegisteVoteEndEvent then
            if curServerTimeStamp >= timeData.unionVoteEndTime then
                isNeedRegisteVoteEndEvent = false
                isNeedRegisteVoteBeginEvent = false
                Utility.RemoveClientSystem(luaEnumActivityBtnType.LeagueVote)
                gameMgr:GetLuaTimeMgr():RemoveTimeRespone(LuaRegisterTimeFinishEvent.LeagueVoteBegin)
            end
        end

        ---注册联盟开启投票时间线事件
        if isNeedRegisteVoteBeginEvent then
            gameMgr:GetLuaTimeMgr():RegisterTimeRespone(LuaRegisterTimeFinishEvent.LeagueVoteBegin, timeData.unionVoteBeginTime,
                    function()
                        gameMgr:GetLuaTimeMgr():RemoveTimeRespone(LuaRegisterTimeFinishEvent.LeagueVoteBegin)
                        Utility.AddClientSystem(luaEnumActivityBtnType.LeagueVote)
                    end)
        end

        ---注册联盟终止投票时间线事件
        if isNeedRegisteVoteEndEvent then
            gameMgr:GetLuaTimeMgr():RegisterTimeRespone(LuaRegisterTimeFinishEvent.LeagueVoteEnd, timeData.unionVoteEndTime,
                    function()
                        gameMgr:GetLuaTimeMgr():RemoveTimeRespone(LuaRegisterTimeFinishEvent.LeagueVoteEnd)
                        Utility.RemoveClientSystem(luaEnumActivityBtnType.LeagueVote)
                    end)
        end]]
end

---检测是否需要注册联盟投票事件
function LuaShareMapInfo:CheckRegisteVoteEvent()
    self:CheckRegisteVoteTimeEvent(self.mBasicData)
end

--endregion

return LuaShareMapInfo