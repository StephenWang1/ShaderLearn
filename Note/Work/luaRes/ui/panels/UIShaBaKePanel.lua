---@class UIShaBaKePanel:UIActivityManEnterPanel;
local UIShaBaKePanel = {};

setmetatable(UIShaBaKePanel, luaPanelModules.UIActivityManEnterPanel);

function UIShaBaKePanel:GetGrid_GridContainer()
    if (self.mGrid == nil) then
        self.mGrid = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/Grid", "Top_UIGridContainer")
    end
    return self.mGrid;
end

--region Override
function UIShaBaKePanel:InitEvents()
    self:RunBaseFunction("InitEvents")
    networkRequest.ReqGBPreviousPeriodTime(LuaEnumDailyActivityType.ShaBaKe)
    UIShaBaKePanel.CallUIActivityRankPanelBack = function(id, luadata)
        if luadata.activityType == LuaEnumDailyActivityType.ShaBaKe then
            self:DefendLastRankListCallBack(id, luadata)
        end
    end

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGBPreviousPeriodTimeMessage, UIShaBaKePanel.CallUIActivityRankPanelBack)
end

function UIShaBaKePanel:UpdateRewardName()
    if(CS.CSScene.MainPlayerInfo ~= nil) then
        if(gameMgr:GetPlayerDataMgr():GetActivityMgr():IsFirstSabacActivity(self.mCalendarItem)) then
            self:GetRewardName_Text().text = "开服首次占沙奖励";
        elseif(gameMgr:GetPlayerDataMgr():GetActivityMgr():IsCombineFirstSabacActivity(self.mCalendarItem)) then
            self:GetRewardName_Text().text = "合服首次占沙奖励";
        else
            self:GetRewardName_Text().text = "占沙奖励";
        end
    end
end

function UIShaBaKePanel:UpdateAwards()
    if (self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end

    local gridContainer = self:GetAwardGridContainer();
    --if (self.mActivityTimeTable ~= nil) then
    --    self:GetName_Text().text = self.mActivityTimeTable.name;
    --    local itemIds, nums = CS.Cfg_DailyActivityTimeTableManager.Instance:GetActivityAwardShow(self.mActivityTimeTable);
    --    if(gameMgr:GetPlayerDataMgr():GetActivityMgr():IsFirstSabacActivity(self.mCalendarItem)) then
    --        local idAndNum = CS.Cfg_GlobalTableManager.Instance:GetOpenServerFirstShaBaKReward();
    --        itemIds = idAndNum[0];
    --        nums = idAndNum[1];
    --    elseif(gameMgr:GetPlayerDataMgr():GetActivityMgr():IsCombineFirstSabacActivity(self.mCalendarItem)) then
    --        local idAndNum = CS.Cfg_GlobalTableManager.Instance:GetCombineServerFirstShaBaKReward();
    --        itemIds = idAndNum[0];
    --        nums = idAndNum[1];
    --    end
    --
    --    if (itemIds ~= nil) then
    --        gridContainer.MaxCount = itemIds.Count;
    --        for i = 0, itemIds.Count - 1 do
    --            local gobj = gridContainer.controlList[i];
    --            if (self.mUIItemDic[gobj] == nil) then
    --                self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
    --            end
    --            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemIds[i]);
    --            if (isFind) then
    --                self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, nums[i]);
    --
    --                CS.UIEventListener.Get(gobj).onClick = function()
    --                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, showRight = false })
    --                end
    --            end
    --        end
    --    end
    --else
    --    gridContainer.MaxCount = 0;
    --end

    local rewards = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetShaBaKWinRewards(self.mCalendarItem);
    if(rewards ~= nil and #rewards > 0) then
        gridContainer.MaxCount = #rewards;
        for k,v in pairs(rewards) do
            if(#v > 1) then
                local itemId = v[1];
                local num = v[2];
                local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                if(isFindItem) then
                    local gobj = gridContainer.controlList[k - 1];
                    if(self.mUIItemDic[gobj] == nil) then
                        self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                        CS.UIEventListener.Get(gobj).onClick = function()
                            uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemTable})
                        end
                    end
                    self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, num);
                end
            end
        end
    else
        gridContainer.MaxCount = 0;
    end
end

function UIShaBaKePanel:DefendLastRankListCallBack(id, luadata)
    if luadata == nil or luadata.times == nil then
        return
    end
    local rankInfoList = luadata.times
    self:GetGrid_GridContainer().MaxCount = #rankInfoList
    table.sort(rankInfoList, function(a, b)
        return a and b and a > b
    end)
    local index = 0
    for i, v in pairs(rankInfoList) do
        local go = self:GetGrid_GridContainer().controlList[index]
        index = index + 1
        if go then
            local label = CS.Utility_Lua.GetComponent(go, "UILabel")
            if label then
                local dayTime = v / 1000
                dayTime = dayTime - dayTime % 1
                label.text = os.date("[u]%m%d期 战绩回顾[/u]", tonumber(dayTime))
            end
        end
        local myIndex=index - 1;
        myIndex = myIndex < 0 and 0 or myIndex;
        CS.UIEventListener.Get(go).onClick = nil
        CS.UIEventListener.Get(go).onClick = function()
            uiStaticParameter.mIsCurrentShaBaK = false;
            uiStaticParameter.CurShaBaKRankIndex = myIndex;
            networkRequest.ReqSabacRecord(v)
        end
    end
end

function UIShaBaKePanel:GetActivityId()
    return 101;
end

function UIShaBaKePanel:GetHelpId()
    return 137;
end

function UIShaBaKePanel:GetShaBaKRankType()
    return CS.duplicateV2.SabacRankType.Kill;
end
function UIShaBaKePanel:OnCloseSelf()
    uimanager:ClosePanel("UIShaBaKePanel");
end

function UIShaBaKePanel:OnClickBtnEnter()
    --local stateCode = self:GetEnterActivityStateCode();

    local activity = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarActivity(LuaEnumDailyActivityType.ShaBaKe)
    if(activity ~= nil and activity:IsInOpenTime() == false) then
        self:RunBaseFunction("OnClickBtnEnter");
    else
        if(CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0) then
            local temp = {}
            temp.Content = "当前活动需要加入行会, 建议先加入行会, 是否传送至活动";
            temp.CallBack = function()
                self:RunBaseFunction("OnClickBtnEnter");
            end
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        else
            self:RunBaseFunction("OnClickBtnEnter");
        end
    end
end

function UIShaBaKePanel:OnClickBtnLast()
    uimanager:ClosePanel("UIActivityManEnterPanel");
    uimanager:CreatePanel("UIActivityRankPanel", function()
        networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(self:GetShaBaKRankType()), 1, uiStaticParameter.mShaBaKRankOnePageCount);
    end, {
        id = LuaEnuActivityRankID.ShaBaK,
        refreshCallBack = function()
            networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(self:GetShaBaKRankType()), 1, uiStaticParameter.mShaBaKRankOnePageCount);
        end
    })

    --uimanager:CreatePanel("UICityWarRankingPanel");
    --uimanager:ClosePanel("UIActivityManEnterPanel");
end

--endregion

function UIShaBaKePanel:Init()
    self:RunBaseFunction("Init");
end

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGBPreviousPeriodTimeMessage, UIShaBaKePanel.CallUIActivityRankPanelBack)
    UIShaBaKePanel:OnDestroy();
end

return UIShaBaKePanel;