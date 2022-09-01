---游戏数据管理器
---@class GameDataManager
local GameDataManager = {}

--region 初始化
---初始化
---@public
function GameDataManager:Initialize()
    self:InitBoothParams()
    self:InitConditionCheckCallBack()
end

---初始化摊位的一些数据
---@private
function GameDataManager:InitBoothParams()
    if CS.CSGame.Sington ~= nil then
        local Size = CS.CSGame.Sington.ContentSize
        if Size.x % 2 == 0 then
            CS.BoothModelLoad.boothPlayerOffsetPosition = CS.UnityEngine.Vector3.right * 0.5
        end
    end
end
--endregion

--region 商城数据
---获取商城数据
---@return LuaStoreData
function GameDataManager:GetLuaStoreData()
    if self.mLuaStoreData == nil then
        self.mLuaStoreData = luaclass.LuaStoreData:New()
    end
    return self.mLuaStoreData
end
--endregion

--region 篝火数据
---@type LuaBonfireInfo
function GameDataManager:GetLuaBonfireDataManager()
    if self.mLuaBonfireDataManager == nil then
        self.mLuaBonfireDataManager = luaclass.LuaBonfireInfo:New()
    end
    return self.mLuaBonfireDataManager
end
--endregion

---初始化Condition表新增类型判断
---@private
function GameDataManager:InitConditionCheckCallBack()
    if (CS.Cfg_ConditionManager.Instance.onOtherConditionChecked == nil) then
        CS.Cfg_ConditionManager.Instance.onOtherConditionChecked = function(conditionTbl)
            local vipLevel = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level()
            if (conditionTbl ~= nil) then
                local conditionType = conditionTbl.conditionType
                if (conditionType == 43) then
                    ---VIP等级达到
                    if (conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list ~= nil and conditionTbl.conditionParam.list.Count > 0) then
                        return vipLevel >= conditionTbl.conditionParam.list[0]
                    end
                    return false
                elseif conditionType == 44 then
                    ---VIP等级低于
                    if (conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list ~= nil and conditionTbl.conditionParam.list.Count > 0) then
                        return vipLevel < conditionTbl.conditionParam.list[0]
                    end
                    return false
                elseif conditionType == 54 then
                    ---判断时间周期
                    ---当前星期天数,0表示星期天,6表示星期六
                    local currentDayOfWeek = CS.CSServerTime.DayOfWeek
                    if (conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list ~= nil and conditionTbl.conditionParam.list.Count > 0) then
                        return currentDayOfWeek == conditionTbl.conditionParam.list[0]
                    end
                    return false
                elseif conditionType == 37 or conditionType == 78 or conditionType == 33 then
                    if gameMgr:GetPlayerDataMgr() == nil then
                        return false
                    end
                    ---判断物品消耗
                    if (conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list ~= nil and conditionTbl.conditionParam.list.Count > 1) then
                        local targetNum = conditionTbl.conditionParam.list[0]
                        local num = 0
                        for i = 1, conditionTbl.conditionParam.list.Count - 1 do
                            local id = conditionTbl.conditionParam.list[i]
                            local count = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(id)
                            num = num + count
                        end
                        return targetNum <= num;
                    end
                    return true
                elseif conditionType == LuaConditionType.RechargeDiamondAmountNotLowerThan then
                    ---充值钻石数量不低于
                    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.RechargeInfo ~= nil
                            and CS.CSScene.MainPlayerInfo.RechargeInfo.ResRechargeInfo ~= nil then
                        if (conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list ~= nil and conditionTbl.conditionParam.list.Count >= 1) then
                            local targetNum = conditionTbl.conditionParam.list[0]
                            return targetNum <= CS.CSScene.MainPlayerInfo.RechargeInfo.ResRechargeInfo.totalRechargeCount
                        end
                    end
                    return false
                elseif conditionType == 90 then
                    ---判定是否首充过
                    if gameMgr:GetPlayerDataMgr() == nil then
                        return false
                    end
                    if conditionTbl.conditionParam ~= nil and conditionTbl.conditionParam.list ~= nil
                            and conditionTbl.conditionParam.list.Count >= 1 then
                        local isFirstRecharged = gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge()
                        if isFirstRecharged then
                            return conditionTbl.conditionParam.list[0] == 1
                        else
                            return conditionTbl.conditionParam.list[0] == 0
                        end
                    end
                    return false
                else
                    local result = Utility.IsMainPlayerMatchCondition(conditionTbl.id)
                    if result == nil or result.success == nil then
                        return false
                    else
                        return result.success
                    end
                    --return (result == nil or result.success == nil) and false or result.success
                end
            end
            return false
        end
    end
end
--endregion

--region 进入场景事件
---(由登陆场景)进入场景时调用
---@private
function GameDataManager:OnEnterGameScene()
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint)
    self:GetLuaStoreData():Initialize()
end
--endregion

--region 退出场景事件
---退回到登录/选角场景时调用
---@private
function GameDataManager:OnExitGameScene()
    if self:GetLuaBonfireDataManager() ~= nil and self:GetLuaBonfireDataManager().OnDestroy ~= nil then
        self:GetLuaBonfireDataManager():OnDestroy()
    end
end
--endregion



return GameDataManager