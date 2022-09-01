---@class UIGuildEscortPanel:UIActivityManEnterPanel
local UIGuildEscortPanel = {};

setmetatable(UIGuildEscortPanel, luaPanelModules.UIActivityManEnterPanel);

--region Override
function UIGuildEscortPanel:Init()
    self:RunBaseFunction("Init")
    self:BindExtraEvents()
    networkRequest.ReqBodyGuardInfo()
    self:RefreshNoCarState()
end

function UIGuildEscortPanel:InitEvents()
    self:RunBaseFunction("InitEvents")
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionDartCarSettleParamsRefresh, function()
        self:RefreshLastDes()
    end)
    CS.CSScene.MainPlayerInfo.ActivityInfo.unionShowRank = false
    networkRequest.ReqUnionCartLastRank(1)
    networkRequest.ReqGBPreviousPeriodTime(LuaEnumDailyActivityType.GuildEscort)

    UIGuildEscortPanel.OnResDefendLastRankListCallBack = function(id, luadata)
        if luadata.activityType == LuaEnumDailyActivityType.GuildEscort then
            self:DefendLastRankListCallBack(luadata)
        end
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGBPreviousPeriodTimeMessage, UIGuildEscortPanel.OnResDefendLastRankListCallBack)
end

function UIGuildEscortPanel:GetActivityId()
    return 224;
end

function UIGuildEscortPanel:GetHelpId()
    return 134;
end
function UIGuildEscortPanel:OnCloseSelf()
    uimanager:ClosePanel("UIGuildEscortPanel");
    uimanager:ClosePanel("UIActivitiesManPanel");
end

function UIGuildEscortPanel:OnClickBtnEnter()
    if self.carState == false then
        Utility.ShowPopoTips(self:GetBtnEnter_GameObject(), nil, 133)
        return
    elseif Utility.ReqJoinUnionDartCarActivity(self:GetBtnEnter_GameObject()) == true then
        uimanager:ClosePanel(self)
        uimanager:ClosePanel("UIActivitiesManPanel");
    end
end

function UIGuildEscortPanel:OnClickBtnLast()
    CS.CSScene.MainPlayerInfo.ActivityInfo.unionShowRank = true
    networkRequest.ReqUnionCartLastRank(1)
end

function UIGuildEscortPanel:RemoveEvents()
end
--endregion

--region 拓展部分
function UIGuildEscortPanel:BindExtraEvents()
    self.OnResBodyGuardInfoMessageReceived = function(msgID, tblData, csData)
        self:RefreshCarState(tblData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBodyGuardInfoMessage, self.OnResBodyGuardInfoMessageReceived)
end

---组件
function UIGuildEscortPanel:GetCarState_UIGridContainer()
    if self.mCarState_UIGridContainer == nil then
        self.mCarState_UIGridContainer = self:GetCurComp("WidgetRoot/events/event", "UIGridContainer")
    end
    return self.mCarState_UIGridContainer
end

---刷新镖车状态（活动未开启时）
function UIGuildEscortPanel:RefreshNoCarState()
    if self:GetCarState_UIGridContainer() ~= nil then
        self:GetCarState_UIGridContainer().MaxCount = 1
        local template = templatemanager.GetNewTemplate(self:GetCarState_UIGridContainer().controlList[0], luaComponentTemplates.UIActivityDuplicateTitleTeamplate)
        template:Refresh({ titleName = "当前镖车状态", content = CS.Cfg_GlobalTableManager.Instance:GetNoCarStateText() })
    end
    self.carState = false
end

---刷新镖车状态（活动开启时）
function UIGuildEscortPanel:RefreshCarState(tblData)
    if self:GetCarState_UIGridContainer() ~= nil then
        self:GetCarState_UIGridContainer().MaxCount = 2
        local template = templatemanager.GetNewTemplate(self:GetCarState_UIGridContainer().controlList[0], luaComponentTemplates.UIActivityDuplicateTitleTeamplate)
        local carStateText = CS.Cfg_GlobalTableManager.Instance:GetCarStateTextByCarState(tblData.cartState)
        template:Refresh({ titleName = "当前镖车状态", content = carStateText })
        local template = templatemanager.GetNewTemplate(self:GetCarState_UIGridContainer().controlList[1], luaComponentTemplates.UIActivityDuplicateTitleTeamplate)
        local positionContent = tblData.mapName .. tostring(tblData.x) .. "," .. tostring(tblData.y)
        template:Refresh({ titleName = "当前镖车位置", content = positionContent })
    end
    self.carState = true
end

function UIGuildEscortPanel:RefreshLastDes()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local winUnionName = CS.CSScene.MainPlayerInfo.ActivityInfo:GetWinUnionName()
    local id = winUnionName ~= nil and winUnionName ~= "" and 149 or 152
    local isfind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isfind and self:GetDes_Label() ~= nil and not CS.StaticUtility.IsNull(self:GetDes_Label()) then
        self:GetDes_Label().text = string.format(string.gsub(info.value, '\\n', '\n'), winUnionName)
    end
end

function UIGuildEscortPanel:DefendLastRankListCallBack(luadata)
    if luadata == nil or luadata.times == nil then
        return
    end
    local rankInfoList = luadata.times
    if rankInfoList then
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
            CS.UIEventListener.Get(go).onClick = nil
            CS.UIEventListener.Get(go).onClick = function()
                CS.CSScene.MainPlayerInfo.ActivityInfo.unionShowRank = true
                uiStaticParameter.CurUnionDartCarActivityTime = i - 1
                networkRequest.ReqUnionCartLastRank(i - 1)
            end
        end
    end
end
--endregion

function ondestroy()
    UIGuildEscortPanel:RemoveEvents()

    UIGuildEscortPanel:OnDestroy();
end
return UIGuildEscortPanel;