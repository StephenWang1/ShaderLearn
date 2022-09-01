---@class UIActivitiesDesPanel:UIBase
local UIActivitiesDesPanel = {};

---@type UIActivitiesDesPanel
local this = nil;

---@type LuaActivityItem
UIActivitiesDesPanel.mActivity = nil;

---@type CalendarItem
UIActivitiesDesPanel.mCalendarItem = nil;

--UIActivitiesDesPanel.mCalendarVO = nil;

UIActivitiesDesPanel.mBackGroundName = nil;

---@type TABLE.cfg_daily_activity_time
UIActivitiesDesPanel.mActivityTable = nil;

--region Components

function UIActivitiesDesPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/window/Btn_Close", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIActivitiesDesPanel:GetBtnLast_GameObject()
    if (this.mBtnLast_GameObject == nil) then
        this.mBtnLast_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/events/LastBtn", "GameObject");
    end
    return this.mBtnLast_GameObject;
end

function UIActivitiesDesPanel:GetBtnGetGift_GameObject()
    if (this.mBtnGetGift_GameObject == nil) then
        this.mBtnGetGift_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/events/btn_get", "GameObject");
    end
    return this.mBtnGetGift_GameObject;
end

function UIActivitiesDesPanel:GetUnLockGiftDes_GameObject()
    if (this.mUnLockGiftDes == nil) then
        this.mUnLockGiftDes = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/text", "GameObject")
    end
    return this.mUnLockGiftDes;
end

function UIActivitiesDesPanel:GetReceivedText_GameObject()
    if (this.mReceivedText_GameObject == nil) then
        this.mReceivedText_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/Received", "GameObject")
    end
    return this.mReceivedText_GameObject;
end

--function UIActivitiesDesPanel:GetAwardText_GameObject()
--    if(this.mAwardText_GameObject == nil) then
--        this.mAwardText_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/text","GameObject");
--    end
--    return this.mAwardText_GameObject;
--end

function UIActivitiesDesPanel:GetActivityName_Text()
    if (this.mActivityName_Text == nil) then
        this.mActivityName_Text = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/window/title", "UILabel");
    end
    return this.mActivityName_Text;
end

function UIActivitiesDesPanel:GetUITable()
    if (this.mUITable == nil) then
        this.mUITable = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/ScrollView/Grid", "UITable");
        this.mUITable.IsDealy = true;
    end
    return this.mUITable;
end

---@return UIActivitiesDesViewTemplate
function UIActivitiesDesPanel:GetActivitiesViewTemplate()
    if (this.mActivitiesViewTemplate == nil) then
        this.mActivitiesViewTemplate = templatemanager.GetNewTemplate(this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view", "GameObject"), luaComponentTemplates.UIActivitiesDesViewTemplate);
    end
    return this.mActivitiesViewTemplate;
end

function UIActivitiesDesPanel:GetActivityBG_Texture()
    if (this.mActivityBG_Texture == nil) then
        this.mActivityBG_Texture = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/texture", "Top_UISprite");
    end
    return this.mActivityBG_Texture;
end

--function UIActivitiesDesPanel:GetBackGround_Texture()
--    if(this.mBackGround_Texture == nil) then
--        this.mBackGround_Texture = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/window/Texture","UITexture");
--    end
--    return this.mBackGround_Texture;
--end

--function UIActivitiesDesPanel:GetAwardGridContainer()
--    if(this.mAwardGridContainer == nil) then
--        this.mAwardGridContainer = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/Awards","UIGridContainer");
--    end
--    return this.mAwardGridContainer;
--end

function UIActivitiesDesPanel:GetSelectMapGridContainer()
    if (this.mSelectMapGridContainer == nil) then
        this.mSelectMapGridContainer = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/Teleport/selectMapScroll/selectMap", "UIGridContainer");
    end
    return this.mSelectMapGridContainer;
end

---@return LuaActivityItemSubInfo
function UIActivitiesDesPanel:GetActivitySubData()
    local state;
    if (this.mActivitySubData == nil) then
        if (this.mActivity ~= nil) then
            state, this.mActivitySubData = this.mActivity:GetRunningState();
            if (this.mActivitySubData == nil) then
                this.mActivitySubData = this.mActivity:GetLastActivity()
            end
        end
    end
    return state, this.mActivitySubData;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public

function UIActivitiesDesPanel:UpdateUI()
    if (this.mUIItemDic == nil) then
        this.mUIItemDic = {};
    end
    this:UpdateGetBtnGift();

    this:GetBtnLast_GameObject():SetActive(false);
    if (this.mActivityTable ~= nil) then
        ---@type TABLE.cfg_daily_activity_time
        local tableData = this.mActivityTable;
        this:GetActivityName_Text().text = tableData:GetName();
        ---是否在活动大使中显示
        local isInActivityMan = gameMgr:GetPlayerDataMgr():GetActivityMgr():IsShowInActivityMan(tableData);
        this:GetBtnLast_GameObject():SetActive(not this:GetBtnGetGift_GameObject().activeSelf and isInActivityMan and this:SetLastBtnActive(tableData:GetActivityType()) and not CS.Cfg_GlobalTableManager.Instance:SpecialActivityTypeList():Contains(tableData:GetActivityType()));
        this:GetActivityBG_Texture().spriteName = tableData:GetRuleBackGround()
    end
end

function UIActivitiesDesPanel:UpdateGetBtnGift()
    local isToday = this.mCalendarItem.dayTime == gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
    local isBefore = this.mCalendarItem.dayTime < gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
    ---是否未达标日期
    local dateNotReached = not (isToday or isBefore);
    ---@type LuaActivityItemSubInfo
    local state, activitySubData = this:GetActivitySubData();
    local hasReward =activitySubData.Tbl:GetRewardShow() ~= nil and activitySubData.Tbl:GetRewardShow() ~= "";
    local canGetCalendarGift = false;
    local hasCalendarGift = false;
    if (activitySubData ~= nil) then
        canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(activitySubData.Tbl:GetId()) == 1 and hasReward;
        if (this.mLastCanGetCalendarGift and not canGetCalendarGift) then
            local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
            if mainChatPanel ~= nil and mainChatPanel.btn_bag ~= nil then
                ---@param v UIItem
                for k, v in pairs(this:GetActivitiesViewTemplate().mUIItemDic) do
                    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = v.ItemInfo.id, from = v.go.transform.position, to = mainChatPanel.btn_bag.transform.position });
                end
            end
        end
        this.mLastCanGetCalendarGift = canGetCalendarGift;
    end
    if (this.mActivityTable ~= nil) then
        hasCalendarGift = this.mActivityTable:GetHaveGift() == 1 and hasReward;
    end
    this:GetReceivedText_GameObject():SetActive(hasCalendarGift and not canGetCalendarGift);
    this:GetBtnGetGift_GameObject():SetActive(hasCalendarGift and canGetCalendarGift and state ~= LuaActivityRunningState.NoOpen and not dateNotReached);
    if (hasCalendarGift) then
        this:GetActivitiesViewTemplate():SetAwardActive(hasCalendarGift and not dateNotReached);
    end

    this:GetUnLockGiftDes_GameObject():SetActive(hasCalendarGift and not dateNotReached);
end

function UIActivitiesDesPanel:SetLastBtnActive(activityType)
    if (activityType ~= 48 and activityType ~= 47 and activityType ~= 46 and activityType ~= 43 and activityType ~= 37 and activityType ~= 30 and activityType ~= 29) then
        return true
    else
        return false
    end
end

function UIActivitiesDesPanel:UpdateBackGroundTexture()
    if (this.mBackGroundName ~= nil) then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(this.mBackGroundName, CS.ResourceType.UIEffect, function(res)
            if res ~= nil and res.MirrorObj ~= nil then
                this:GetBackGround_Texture().enabled = false;
                this:GetBackGround_Texture().mainTexture = res.MirrorObj;
                this:GetBackGround_Texture().enabled = true;
            end
        end, CS.ResourceAssistType.UI)
    end
end

--endregion

--region Private

function UIActivitiesDesPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActivitiesDesPanel");
    end

    CS.UIEventListener.Get(this:GetBtnLast_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActivitiesDesPanel");
        uimanager:ClosePanel("UICalendarPanel");
        ---不知道为啥反正移动位置不对 我看了一下都是固定去一个地方的我就写死了
        --local mapNpcId = CS.CSScene.MainPlayerInfo.MapInfoV2:GetLastMainCityMapNpcId(tonumber(323));

        local mapNpcId = 340
        CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(mapNpcId, this.mCalendarVO);
    end

    CS.UIEventListener.Get(this:GetBtnGetGift_GameObject()).onClick = function()
        if (this.mActivityTable ~= nil) then
            networkRequest.ReqReceiveCalendarGift(this.mActivityTable:GetId());
        end
    end

    this:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAllCalendarGiftStateMessage, function(id, data)
        this:UpdateGetBtnGift();
    end);
    this:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOmenComeBossInfoMessage, function(id, data)
        this:RefreshSelectMapGrid(data);
    end);
end

--endregion

--endregion

function UIActivitiesDesPanel:Init()
    this = self;
    this:InitEvents();
end

function UIActivitiesDesPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.calendarItem == nil) then
        uimanager:ClosePanel("UIActivitiesDesPanel");
        return
    end
    this.mCalendarItem = customData.calendarItem;
    ---@type LuaActivityItem
    this.mActivity = this.mCalendarItem.ActivityItem;
    ---@type LuaActivityItemSubInfo
    local ActivityItemSubInfo = this.mActivity:GetTargetTimeActivity(this.mCalendarItem.dayTime);
    if (ActivityItemSubInfo == nil) then
        ActivityItemSubInfo = this.mActivity:GetLastActivity()
    end
    --this.mActivity = this.mCalendarItem.ActivityItem;
    ---@type LuaActivityItemSubInfo
    --local state, activitySubData = this:GetActivitySubData();
    if (ActivityItemSubInfo ~= nil) then
        this.mActivityTable = ActivityItemSubInfo.Tbl
        this:GetActivitiesViewTemplate():UpdateView(this.mActivityTable);
    end
    this:UpdateUI();
    this:GetUITable():Reposition();
end

---@param data bossV2.ResOmenComeBossInfo
function UIActivitiesDesPanel:RefreshSelectMapGrid(data)
    -- 天魔降临特殊处理
    if this.mActivity.Type ~= LuaEnumDailyActivityType.DemonsComing then
        return
    end
    if data == nil then
        return
    end

    this:GetSelectMapGridContainer().MaxCount = #data.boss
    for i = 1, #data.boss do
        local go = this:GetSelectMapGridContainer().controlList[i - 1]
        ---@type UISprite
        local bg = CS.Utility_Lua.Get(go.transform, "backGround", "UISprite")
        ---@type UILabel
        local mapname = CS.Utility_Lua.Get(go.transform, "lab_name", "UILabel")
        ---@type UILabel
        local monsternum = CS.Utility_Lua.Get(go.transform, "lab_num", "UILabel")

        local mapNameStr = ""

        local isFind, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(data.boss[i].mapId);
        if (isFind) then
            mapNameStr = mapTable.name
        end
        mapname.text = mapNameStr

        local monsterNum = data.boss[i].hasCount
        if monsterNum > 0 then
            monsternum.text = luaEnumColorType.Green .. monsterNum .. '只'
            bg.color = LuaEnumUnityColorType.White
        else
            monsternum.text = luaEnumColorType.Gray .. monsterNum .. '只'
            bg.color = LuaEnumUnityColorType.Gray
        end
        CS.UIEventListener.Get(go).onClick = function(go)

            this:OnClickMap(go, data.boss[i])
        end
    end

end

---@param info bossV2.OmenComeBoss
function UIActivitiesDesPanel:OnClickMap(go, info)
    --[[
    uimanager:ClosePanel("UIActivitiesDesPanel")
    if uimanager:GetPanel("UICalendarPanel") ~= nil then
        uimanager:ClosePanel("UICalendarPanel")
    end
    networkRequest.ReqDeliverByConfig(info.deliver)
    --]]
    ---[[
    if Utility.TryDeliver(go, info.deliver) then
        uimanager:ClosePanel("UIActivitiesDesPanel")
        if uimanager:GetPanel("UICalendarPanel") ~= nil then
            uimanager:ClosePanel("UICalendarPanel")
        end
    end
    --]]
end

function update()
    -- 天魔降临每隔5秒刷新一次
    if this.mActivity ~= nil and this.mActivity.Type == LuaEnumDailyActivityType.DemonsComing then
        local time = CS.UnityEngine.Time.time
        if this.mUpdateTime == nil then
            this.mUpdateTime = time
        end
        if time >= this.mUpdateTime then
            this.mUpdateTime = time + 5
            networkRequest.ReqOmenComeBossInfo()
        end
    end

end

function ondestroy()
    this = nil;
end

return UIActivitiesDesPanel;