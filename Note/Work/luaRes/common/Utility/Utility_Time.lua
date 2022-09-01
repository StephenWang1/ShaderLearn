---@type Utility
local Utility = Utility

---@param addDays number 加几天
---@return number 返回从开服时间的零点到加addDays之后的时间戳
function Utility.GetEndTimeStamp(addDays)
    local finalStamp = -1
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local startTime = mainPlayerInfo.OpenServerTime - (mainPlayerInfo.OpenServerTime + 8 * 3600) % 86400;
        finalStamp = startTime + addDays * 24 * 60 * 60
    end
    return finalStamp
end

---判断传入的时间戳是否过期
---@param timeStamp number 毫秒时间戳
---@return boolean   true过期/false没过期
function Utility.IsTimeOverByMillisecondTimeStamp(timeStamp)
    return timeStamp - CS.CSServerTime.Instance.TotalSeconds <= 0
end

---判断传入的时间戳是否过期
---@param timeStamp number 秒时间戳
---@return boolean   true过期/false没过期
function Utility.IsTimeOverBySecondTimeStamp(timeStamp)
    return timeStamp - CS.CSServerTime.Instance.TotalSeconds * 1000 <= 0
end

return
