---@class cfg_daily_activity_timeManager:TableManager
local cfg_daily_activity_timeManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_daily_activity_time
function cfg_daily_activity_timeManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_daily_activity_time> 遍历方法
function cfg_daily_activity_timeManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_daily_activity_timeManager:PostProcess()
    ---历法的初始化,先挪过来  之后再进行优化
    --if (CS.CSServerTime.OpenServerTime ~=0) then
    --    CS.CSCalendarInfoV2.Instance:InitializeCalendar();
    --    local loadName =  CS.CSCalendarInfoV2.Instance:GetLoadingTextureName();
    --    CS.CSCalendarInfoV2.LoadingTextureName = loadName;
    --    if (loadName ~= nil and loadName ~= "") then
    --        local res = CS.CSResourceManager.Instance:AddQueueCannotDelete(loadName, CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.ForceLoad);
    --        CS.UILoading.resPreLoadPath = res.Path;
    --    end
    --end
end

return cfg_daily_activity_timeManager