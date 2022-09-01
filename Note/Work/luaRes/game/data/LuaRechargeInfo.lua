---充值类
---@class LuaRechargeInfo:luaobject
local LuaRechargeInfo = {}

LuaRechargeInfo.recivedGiftRecharId = nil
---@type table<number,TABLE.cfg_recharge>
LuaRechargeInfo.firstRechargeDic = {}
function LuaRechargeInfo:Init()
    self.CallShowFirstRechargeRedPoint = function()
        return self:ShowFirstRechargeRedPoint();
    end
    CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(CS.RedPointKey.Recharge_FirstReward, self.CallShowFirstRechargeRedPoint)
    self:SetFirstRechargeTable()
end

---获取充值信息
---@return rechargeV2.ResSendRechargeInfo
function LuaRechargeInfo:GetResSendRechargeInfo()
    if (self.mResSendRechargeInfo == nil) then
        self.mResSendRechargeInfo = {}
    end
    return self.mResSendRechargeInfo
end

---设置充值信息
---@param info rechargeV2.ResSendRechargeInfo
function LuaRechargeInfo:SetResSendRechargeInfo(info)
    self.mResSendRechargeInfo = info
end

---获取充值礼包信息
---@return rechargegiftboxV2.RechargeGiftBoxInfo
function LuaRechargeInfo:GetRechargeGiftBoxInfo()
    if (self.mRechargeGiftBoxInfo == nil) then
        self.mRechargeGiftBoxInfo = {}
    end
    return self.mRechargeGiftBoxInfo
end

---是否存在可以领取的每日累购礼包
LuaRechargeInfo.IsExitdailyRechargeGiftBoxReward = false
---设置充值礼包信息
---@param info rechargegiftboxV2.RechargeGiftBoxInfo
function LuaRechargeInfo:SetRechargeGiftBoxInfo(info)
    self.mRechargeGiftBoxInfo = info

    local dailyRechargeGiftBoxInfo = info.dailyRechargeGiftBoxInfo
    self.IsExitdailyRechargeGiftBoxReward = false
    if (dailyRechargeGiftBoxInfo == nil) then
        return ;
    end

    local dailyRechargeGiftBoxRewardInfoList = dailyRechargeGiftBoxInfo.rewardInfo
    if (dailyRechargeGiftBoxRewardInfoList == nil) then
        return
    end
    for i, dailyRechargeGiftBoxRewardInfo in pairs(dailyRechargeGiftBoxRewardInfoList) do
        if (dailyRechargeGiftBoxRewardInfo.status == 1) then
            self.IsExitdailyRechargeGiftBoxReward = true
            return ;
        end
    end
end


--region 首充
--region 首冲赠送
---返回已经领取的首冲赠送
---@param tblData rechargeV2.FirstRechargeGive lua table类型消息数据
function LuaRechargeInfo:ResFirstRechargeGiveMessage(tblData)
    if (tblData == nil) then
        self.recivedGiftRecharId = nil
        return ;
    end
    self.recivedGiftRecharId = tblData.recivedId
end

---这个档位是否已经领取过礼物
function LuaRechargeInfo:IsRecivedGive(id)
    if (self.recivedGiftRecharId == nil) then
        return false
    end
    for i, v in pairs(self.recivedGiftRecharId) do
        if (v == id) then
            return true
        end
    end
    return false
end
--endregion

---是否首充过
---@return boolean
function LuaRechargeInfo:IsFirstRecharge()
    if (self:GetResSendRechargeInfo().firstRechargeRmb == nil) then
        return false
    else
        return (self:GetResSendRechargeInfo().firstRechargeRmb >= 98) or (self:GetResSendRechargeInfo().firstRechargeGetLevel == 3)
    end
end

---是否领取了该档位奖励(true表示已经领取)
function LuaRechargeInfo:IsRecivedFirstRechargeGift(index)
    if (self:GetResSendRechargeInfo().firstRechargeReward ~= nil) then
        return ((self:GetResSendRechargeInfo().firstRechargeReward >> index) & 1) == 1
    end
end

---首充价格档位
function LuaRechargeInfo:GetFirstRechargeCostByIndex(index)
    if (index == nil) then
        index = 1
    end
    local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23016);
    if (isFind) then
        local info = string.Split(globalTable.value, "#")
        if (#info >= index) then
            return tonumber(info[index])
        end
    end
    return 0
end

---开服前7天98元首充是否领取完
---@return boolean
function LuaRechargeInfo:IsFinishReceivingTheFirstRechargeReward()
    local openDays = gameMgr:GetLuaTimeMgr():GetOpenServerDay();
    if (openDays > 7) then
        return true
    end
    return self:IsFirstRecharge()
end

---首充红点逻辑
function LuaRechargeInfo:ShowFirstRechargeRedPoint()
    local result = false
    if (self:GetResSendRechargeInfo().firstRechargeRmb == nil) then
        return result
    end

    for i = 0, 2 do
        result = self:GetResSendRechargeInfo().firstRechargeRmb >= self:GetFirstRechargeCostByIndex(i + 1) and not self:IsRecivedFirstRechargeGift(i)
        if (result) then
            return result
        end
    end
    return result
    --if (self:IsFirstRecharge() and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.RechargeInfo:IsCanReceiveTodayFirstRecharge()) then
    --    return true
    --else
    --    return false
    --end
end

---存储首充表数据
function LuaRechargeInfo:SetFirstRechargeTable()
    clientTableManager.cfg_rechargeManager:ForPair(function(key, value)
        if (value:GetType() == 15) then
            table.insert(self.firstRechargeDic, value)
        end
    end)
end

---获取当前首充应付的tableId
function LuaRechargeInfo:GetFirstRechargeCurRechargeTable(rmb)
    if (self.firstRechargeDic ~= nil) then
        for i = 1, #self.firstRechargeDic do
            if (self.firstRechargeDic[i]:GetRmb() == rmb * 100) then
                return self.firstRechargeDic[i]
            end
        end
    end
    return nil
end
--endregion

---根剧开服天数获得充值奖励
function LuaRechargeInfo:GetTargetRechargeReward(rechargeId, openServerDay)
    local rechargeTable = clientTableManager.cfg_rechargeManager:TryGetValue(rechargeId);
    if (rechargeTable ~= nil and rechargeTable:GetRebateBoxClient() ~= nil) then
        local count = #rechargeTable:GetRebateBoxClient().list;
        if (count > 0) then
            for i = 1, #rechargeTable:GetRebateBoxClient().list do
                if (#rechargeTable:GetRebateBoxClient().list[i].list > 2) then
                    local minOpenServerDay = rechargeTable:GetRebateBoxClient().list[i].list[1];
                    local maxOpenServerDay = rechargeTable:GetRebateBoxClient().list[i].list[2];
                    local rewardBoxId = rechargeTable:GetRebateBoxClient().list[i].list[3];
                    if (openServerDay >= minOpenServerDay and openServerDay <= maxOpenServerDay) then
                        return rewardBoxId
                    end
                end
            end
        end
    end
    return 0;
end

---获取通用充值返利金额（对应读取bind字段进行判断）
function LuaRechargeInfo:GetRechargeNormalRewardNum(rechargeId, vipLv)
    local rechargeTable = clientTableManager.cfg_rechargeManager:TryGetValue(rechargeId);
    if rechargeTable ~= nil and rechargeTable:GetBind() ~= nil then
        local count = rechargeTable:GetBind().list.Count
        if count > 0 then
            for k = 0, rechargeTable:GetBind().list.Count - 1 do
                if rechargeTable:GetBind().list[k].list.Count > 2 then
                    local minVipLv = rechargeTable:GetBind().list[k].list[0]
                    local maxVipLv = rechargeTable:GetBind().list[k].list[1]
                    local coinNum = rechargeTable:GetBind().list[k].list[2]
                    if vipLv >= minVipLv and minVipLv <= maxVipLv then
                        return coinNum
                    end
                end
            end
        end
    end
    return 0
end

---获取通用充值返利金额（对应读取rewardBox字段进行判断）
function LuaRechargeInfo:GetRechargeDiamondRewardNum(rechargeId, day)
    local rechargeTable = clientTableManager.cfg_rechargeManager:TryGetValue(rechargeId);
    if rechargeTable ~= nil and rechargeTable:GetRewardBox() ~= nil then
        local count = #rechargeTable:GetRewardBox().list
        if count > 0 then
            for k = 1, #rechargeTable:GetRewardBox().list do
                if #rechargeTable:GetRewardBox().list[k].list > 2 then
                    local minDay = rechargeTable:GetRewardBox().list[k].list[1]
                    local maxDay = rechargeTable:GetRewardBox().list[k].list[2]
                    local boxId = rechargeTable:GetRewardBox().list[k].list[3]
                    if day >= minDay and day <= maxDay then
                        return boxId
                    end
                end
            end
        end
    end
    return 0
end

--region 连充
--region 连充红点

---获取首充时的时间戳
---@return number
function LuaRechargeInfo:GetFirstRechargeTimestamp()
    if self.mFirstRechargeTimestamp == nil then
        self.mFirstRechargeTimestamp = 0
    end
    return self.mFirstRechargeTimestamp
end

---设置首充时间戳
---@param value rechargeV2.ResCompleteFirstChargeTime
function LuaRechargeInfo:SetFirstRechargeTimestamp(value)
    uiStaticParameter.InitializedLCRedPoint = false
    self.mFirstRechargeTimestamp = value.firstRechargeTime
    gameMgr:GetLuaRedPointManager():CallRedPoint(Utility.EnumToInt(CS.RedPointKey.Recharge_ContinueReward))
end

---lua中连充红点逻辑
---完成首充的玩家，第2，3，4，每日首次登录，连充奖励界面要有小红点推送，点开后红点消失
---@return boolean
function LuaRechargeInfo:ShowLuaLCRedPoint()
    ---完成首充的玩家
    if not self:IsFirstRecharge() then
        return false
    end

    ---登陆仅显示一次
    if uiStaticParameter.InitializedLCRedPoint then
        return false
    end
    ---系统开启判定
    if self.openCondition == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22195)
        self.openCondition = info
    end
    if self.openCondition ~= nil then
        if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(self.openCondition) == false then
            return false
        end
    end

    ---判断天数第2、3、4天（即充值后的 1、2、3天）
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    local remainTime = serverNowTime - self:GetFirstRechargeTimestamp()
    local day = remainTime / 1000 / 3600 / 24
    day = Utility.GetPreciseDecimal(day, 1)
    if day > 0 and day < 4 then
        return true
    end

    return false
end

--endregion

function LuaRechargeInfo:Cfg_ContinueRechargeTableManager_GetRewardSmallID(groupid, id)
    local datadic = CS.Cfg_ContinueRechargeTableManager.Instance.ContinueRechargeDic[groupid]
    for i = 1, datadic.Count do
        if (datadic[i].id == id) then
            return datadic[i].smallId
        end
    end
    return 0
end
--endregion

---在PlayerDataManager中调用销毁函数
function LuaRechargeInfo:OnDestroy()
    CS.CSUIRedPointManager.GetInstance():RemoveLuaCallRedPointFunction(CS.RedPointKey.Recharge_FirstReward)
end

return LuaRechargeInfo