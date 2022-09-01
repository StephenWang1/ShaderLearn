local UILvPackPanel_LeftIconTemplate = {}
--region 初始化
function UILvPackPanel_LeftIconTemplate:Init()
    self:InitComponent()
    self:BindEvents()
    self:InitTryOpenLeftPanel()
end

function UILvPackPanel_LeftIconTemplate:InitComponent()
    self.leftIcon_UISprite = self:Get("lefticon", "UISprite")
    self.main_TweenPosition = self:Get("main", "TweenPosition")
end

function UILvPackPanel_LeftIconTemplate:BindEvents()
    CS.UIEventListener.Get(self.leftIcon_UISprite.gameObject).onClick = function()
        self:ChangeStage(LuaEnuLvPackPanelStage.NORMAL)
        self:OpenLeftPanel()
    end
end

function UILvPackPanel_LeftIconTemplate:OpenLeftPanel()
    if self.activityType == nil then
        return
    end
    if self.activityType == LuaEnmumDailyActivityType.UnionDartCar then
        CS.CSScene.MainPlayerInfo.ActivityInfo.unionShowRank = true
        networkRequest.ReqJoinUnionCart()
    elseif self.activityType == LuaEnmumDailyActivityType.DefendKing then
        uimanager:CreatePanel('UIDefendKingRankPanel')
    end
end

function UILvPackPanel_LeftIconTemplate:CloseLeftPanel()
    if self.activityType == nil then
        return
    end
    if self.activityType == LuaEnmumDailyActivityType.UnionDartCar then
        networkRequest.ReqWithdrawUnionCart()
    elseif self.activityType == LuaEnmumDailyActivityType.DefendKing then
        uimanager:ClosePanel('UIDefendKingRankPanel')
    end
end

function UILvPackPanel_LeftIconTemplate:InitTryOpenLeftPanel()
    local list = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetRunningActivityIdList()
    if list ~= nil and list.Count > 0 then
        local dailyActivityTimeId = list[0]
        if dailyActivityTimeId == luaEnumActivityTypeByActivityTimeTable.DartCar then
            self:TryOpenLeftIcon({ dailyActivityTimeId = dailyActivityTimeId })
        elseif dailyActivityTimeId == luaEnumActivityTypeByActivityTimeTable.DefendKing then
            self:TryOpenLeftIcon({ dailyActivityTimeId = dailyActivityTimeId })
        end
    end
end
--endregion

--region 刷新
function UILvPackPanel_LeftIconTemplate:TryOpenLeftIcon(commonData)
    self:ClearParams()
    if self:AnalysisParams(commonData) == false then
        self:ChangeStage(LuaEnuLvPackPanelStage.NORMAL)
        self:CloseLeftPanel()
        return
    end
    self:ChangeStage(LuaEnuLvPackPanelStage.LEFTICON)
end

---清理数据
function UILvPackPanel_LeftIconTemplate:ClearParams()
    self.dailyActivityInfo = nil
    self.activityType = nil
    self.dailyActivityTimeId = nil
end

---解析数据
function UILvPackPanel_LeftIconTemplate:AnalysisParams(commonData)
    if commonData ~= nil then
        if commonData.dailyActivityTimeId == nil then
            return false
        end
        self.dailyActivityTimeId = commonData.dailyActivityTimeId
        ---@type TABLE.cfg_daily_activity_time
        local dayActivityTbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(self.dailyActivityTimeId)
        if(dayActivityTbl == nil) then
            return false
        end
        ---@type LuaActivityItem
        local activityItem = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarActivity(dayActivityTbl:GetActivityType())

        if activityItem==nil then
            return false
        end
        local activityRunningState,activityItemSubInfo = activityItem:GetRunningState()
        if(activityRunningState ~= LuaActivityRunningState.IsRunning) then
            return false
        end

        -----活动状态判断
        --local calendarInfo = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetTodayActivityWithActivityId(self.dailyActivityTimeId)
        --if calendarInfo == nil then
        --    return false
        --end
        --local activityStateCode = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetActivityState(calendarInfo)
        --if activityStateCode ~= 0 then
        --    return false
        --end

        local dailyActivityInfoIsFind, dailyActivityInfo = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self.dailyActivityTimeId)
        if dailyActivityInfoIsFind == false then
            return false
        end
        self.dailyActivityInfo = dailyActivityInfo
        self.activityType = self.dailyActivityInfo.activityType
        if self:ExtraCondition() == false then
            return false
        end
        return true
    end
    return false
end

---额外条件处理
function UILvPackPanel_LeftIconTemplate:ExtraCondition()
    if self.dailyActivityTimeId == luaEnumActivityTypeByActivityTimeTable.DartCar then
        if CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) then
            return false
        end
        return CS.Cfg_GlobalTableManager.Instance:IsUnionDartCarMapId(CS.CSScene.MainPlayerInfo.MapID)
    end
end
--endregion

--region 状态切换
function UILvPackPanel_LeftIconTemplate:CloseLeftIcon()
    self:ChangeStage(LuaEnuLvPackPanelStage.NORMAL)
end

---@param LuaEnuLvPackPanelStage luaEnuLvPackPanelStage
function UILvPackPanel_LeftIconTemplate:ChangeStage(luaEnuLvPackPanelStage)
    self.luaEnuLvPackPanelStage = luaEnuLvPackPanelStage
    if self.luaEnuLvPackPanelStage == LuaEnuLvPackPanelStage.NORMAL then
        if self.leftIcon_UISprite ~= nil then
            self.leftIcon_UISprite.gameObject:SetActive(false)
        end
        if self.main_TweenPosition ~= nil then
            self.main_TweenPosition:PlayReverse()
        end
    elseif self.luaEnuLvPackPanelStage == LuaEnuLvPackPanelStage.LEFTICON then
        if self.leftIcon_UISprite ~= nil then
            self.leftIcon_UISprite.gameObject:SetActive(true)
            if self.dailyActivityInfo ~= nil then
                self.leftIcon_UISprite.spriteName = self.dailyActivityInfo.leftName
            end
        end
        if self.main_TweenPosition ~= nil then
            self.main_TweenPosition:PlayForward()
        end
    end
end
--endregion
return UILvPackPanel_LeftIconTemplate