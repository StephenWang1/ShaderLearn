---@class LuaPotentialInvestInfo:luaobject
local LuaPotentialInvestInfo = {}

---@type rechargeV2.ResFashionInvestInfo
LuaPotentialInvestInfo.InvestInfo = nil

function LuaPotentialInvestInfo:Init()
    self.InvestInfo = nil
end

--- @param tblData rechargeV2.ResFashionInvestInfo
function LuaPotentialInvestInfo:RefreshData(tblData)
    self.InvestInfo = tblData
end

--- @param tblData rechargeV2.ResFashionInvest
function LuaPotentialInvestInfo:RefreshInvestTypeData(tblData)
    if self.InvestInfo ~= nil and self.InvestInfo.invest ~= nil then
        local type = tblData.type
        self.InvestInfo.invest[type] = tblData
    end
end

-- 存在可领取的
function LuaPotentialInvestInfo:IsShowRedPoint()
    local type = self:GetAvailableType()

    return type ~= nil
end

-- 查找可领取奖励的潜能投资类型
---@return number
function LuaPotentialInvestInfo:GetAvailableType()
    if self.InvestInfo == nil then
        return nil
    end
    local invest = self.InvestInfo.invest
    if invest then
        for i = 1, #invest do
            if invest[i].isOpen then
                for j = 1, #invest[i].rewards do
                    local reward = invest[i].rewards[j]
                    if reward.state == LuaSpecailActivityRewardState.Get then
                        return invest[i].type
                    end
                end
            end
        end
    end
    return nil
end

---获取最近的可领取和不可领取的类型
function LuaPotentialInvestInfo:GetLatelyGetAndNotGetType()
    local GetType = nil
    local NotGetType = nil
    local invest = self.InvestInfo.invest
    for i = 1, #invest do
        for j = 1, #invest[i].rewards do
            local reward = invest[i].rewards[j]
            if GetType == nil and invest[i].isOpen and reward.state == LuaSpecailActivityRewardState.Get then
                GetType = invest[i].type
            end
            if NotGetType == nil and reward.state == LuaSpecailActivityRewardState.NotGet then
                NotGetType = invest[i].type
            end
        end
    end
    return GetType, NotGetType
end

--潜能投资页签是否显示
function LuaPotentialInvestInfo:IsShowPotentialInvest()
    -- -- 当前时间小于活动结束时间显示
    -- local curTime = CS.CSServerTime.Instance.TotalMillisecond
    -- if curTime <= self.InvestInfo.endTime  then
    --     return true
    -- end
    -- --活动时间已结束，还存在未达成或未领取的奖励时显示
    -- local invest = self.InvestInfo.invest
    -- for i=1, #invest do
    --     if invest[i].isOpen == 1 then
    --         for j=1,#invest[i].rewards do
    --             local reward = invest[i].rewards[j]
    --             if reward.state == LuaSpecailActivityRewardState.Get or reward.state == LuaSpecailActivityRewardState.NotGet then
    --                 return true
    --             end
    --         end
    --     end
    -- end
    -- return false
    local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22885)
    if isFind then
        local strs = string.Split(tbl_global.value, '#')
        for i = 1, #strs do
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(tonumber(strs[i])) then
                return false
            end
        end
    end
    --return true
    local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23070)
    --是否在限制时间范围中 wxs
    local isOnTime = false

    if isFind then
        local strs = string.Split(tbl_global.value, '#')
        for i = 1, #strs do
            --开服时间超过7天 需要判断是否购买过
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(tonumber(strs[i])) then
                isOnTime = true
                break
            end
        end
    end
    --isOnTime = true
    local invest = self.InvestInfo.invest
    if isOnTime then
         for i=1, #invest do
             for j=1,#invest[i].rewards do
                 local reward = invest[i].rewards[j]
                 if reward.state == LuaSpecailActivityRewardState.Get or reward.state == LuaSpecailActivityRewardState.NotGet then
                    return true
                 end
             end
         end
    else
        for i = 1, #invest do
            if invest[i].isOpen == 1 then
                for j=1,#invest[i].rewards do
                    local reward = invest[i].rewards[j]
                    if reward.state == LuaSpecailActivityRewardState.Get or reward.state == LuaSpecailActivityRewardState.NotGet then
                        return true
                    end
                end
            end
        end
    end
    return false
end

---是否购买过
---@return boolean
function LuaPotentialInvestInfo:IsPurchased()
    local invest = self.InvestInfo.invest
    for i = 1, #invest do
        if invest[i].isOpen == 1 then
            return true
        end
    end
    return false
end

return LuaPotentialInvestInfo