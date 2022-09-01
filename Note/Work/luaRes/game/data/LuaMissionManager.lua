---@class LuaMissionManager
local LuaMissionManager = {};

function LuaMissionManager:Initialize()
    ---注册lua获得日常任务购买数量的方法
    self.CallGetDailyTaskMaxBuyCount = function(dailyTaskType)
        return self:GetDailyTaskMaxBuyCount();
    end
    CS.Cfg_TaskTableManager.Instance:RegisterLuaGetDailyTaskMaxBuyCountHandler(self.CallGetDailyTaskMaxBuyCount)
end

function LuaMissionManager:GetDailyTaskMaxBuyCount()
    local vipLevel = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level();
    local vipLevelTable = clientTableManager.cfg_vip_levelManager:TryGetValue(vipLevel);
    if (vipLevelTable ~= nil) then
        return vipLevelTable:GetDailyTaskjuanzhou();
    end
    return 0;
end

function LuaMissionManager:SetDailyExtraSurplusTimeDic(dailyTaskInfo)
    if dailyTaskInfo == nil or dailyTaskInfo.info == nil then
        return
    end
    self.DailyExtraSurplusTimeDic = {}
    for i = 1, #dailyTaskInfo.info do
        if dailyTaskInfo.info[i] ~= nil and dailyTaskInfo.info[i].type ~= nil then
            local type = dailyTaskInfo.info[i].type
            self.DailyExtraSurplusTimeDic[type] = dailyTaskInfo.info[i].extraCount
        end
    end
end

---得到日常任务新增额外次数道具
function LuaMissionManager:GetDailyTaskAddNumberItemId(subType)
    local dic = LuaGlobalTableDeal.DailyTaskAddTimeItemDic()
    if dic ~= nil then
        return dic[tonumber(subType)]
    end
end


--是否满足日常任务三倍领取条件限制
function LuaMissionManager:IsMeetDailyTaskThreeAwardLimit()
    local id = LuaGlobalTableDeal:DailyTaskThreeAwardLimit()
    if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(id) then
        return true
    end
    return false
end

return LuaMissionManager;