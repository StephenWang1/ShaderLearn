---@class SpecialActivity_CarnivalShop:SpecialActivityBase
local SpecialActivity_CarnivalShop = {}

setmetatable(SpecialActivity_CarnivalShop, luaclass.SpecialActivityBase)

SpecialActivity_CarnivalShop.mEventID = 8

---@return LuaSpecialActivityData
function SpecialActivity_CarnivalShop:GetOwner()
    return self.mOwner
end

---@param owner LuaSpecialActivityData
function SpecialActivity_CarnivalShop:Init(owner)
    self.mOwner = owner
end

function SpecialActivity_CarnivalShop:GetRedPointState()
    local serverData = self:GetOwner():GetSingleActivityData(self.mEventID)
    if serverData == nil or serverData.oneActivitiesInfo == nil then
        ---没有服务器数据时使用服务器红点数据
        return nil
    end
    if self.mIsRedPointDoNotShow then
        ---如果狂欢商店某一次触发过红点且打开过狂欢商店界面,那么不再触发红点
        return false
    end
    ---缓存一次红点计算结果
    self.mForwardRedPointResult = self:IsExchangeAbleItemExist(serverData)
    return self.mForwardRedPointResult
end

function SpecialActivity_CarnivalShop:TryHideRedPoint()
    if self.mForwardRedPointResult == true then
        ---如果上一次红点状态为true,那么将mIsRedPointDoNotShow置为true,表明狂欢商店的红点已经触发过一次了,不需要再次显示红点了
        self.mIsRedPointDoNotShow = true
    end
end

function SpecialActivity_CarnivalShop:GetItemAmount(costItemID)
    local luaBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    if costItemID == 8310001 or costItemID == 8310002 then
        return luaBagMgr:GetCoinAmount(8310001) + luaBagMgr:GetItemCount(8310001) +
                luaBagMgr:GetCoinAmount(8310002) + luaBagMgr:GetItemCount(8310002)
    end
    return luaBagMgr:GetCoinAmount(costItemID) + luaBagMgr:GetItemCount(costItemID)
end

---是否有可兑换物品
---@private
---@param serverData activitiesV2.ResOneActivitiesInfo
---@return boolean
function SpecialActivity_CarnivalShop:IsExchangeAbleItemExist(serverData)
    if serverData == nil or serverData.oneActivitiesInfo == nil then
        return false
    end
    local luaBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    for i = 1, #serverData.oneActivitiesInfo do
        local activityInfo = serverData.oneActivitiesInfo[i]
        local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityInfo.configId)
        if specialActivityTbl ~= nil then
            ---可以兑换数量
            local currentExchangeCount = 0
            if specialActivityTbl:GetAwardType() ~= nil
                    and specialActivityTbl:GetAwardType().list ~= nil
                    and #specialActivityTbl:GetAwardType().list >= 2 then
                currentExchangeCount = specialActivityTbl:GetAwardType().list[2] - activityInfo.dataParam
            end
            ---如果可兑换数量大于0时才认为可以兑换
            if currentExchangeCount > 0 then
                ---兑换开销
                local goals = specialActivityTbl:GetGoal()
                if goals ~= nil and goals.list ~= nil and #goals.list >= 2 then
                    ---花费的物品ID
                    local costItemID = goals.list[1]
                    ---花费的数量
                    local costCount = goals.list[2]
                    ---背包中的当前数量
                    local currentCountInBag = self:GetItemAmount(costItemID)
                    ---如果当前背包中的物品数量超过需要花费的数量则认为可以兑换
                    if currentCountInBag ~= nil and costCount ~= nil and currentCountInBag >= costCount then
                        return true
                    end
                end
            end
        end
    end
    return false
end

return SpecialActivity_CarnivalShop