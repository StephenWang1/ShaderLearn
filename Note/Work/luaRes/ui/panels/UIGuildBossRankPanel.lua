---@class UIGuildBossRankPanel 行会首领左侧数据面板
local UIGuildBossRankPanel = {}

--region 组件的获取

---点击打开奖励界面
function UIGuildBossRankPanel:GetBtnOpenRewardPanel()
    if (self.mGetBtnOpenRewardPanel == nil) then
        self.mGetBtnOpenRewardPanel = self:GetCurComp("WidgetRoot/Tween/root/Panel/BtnOpenRewardPanel", "GameObject")
    end
    return self.mGetBtnOpenRewardPanel
end

---点击help界面
function UIGuildBossRankPanel:GetBtnHelp()
    if (self.mGetBtnHelp == nil) then
        self.mGetBtnHelp = self:GetCurComp("WidgetRoot/Tween/events/btn_help", "GameObject")
    end
    return self.mGetBtnHelp
end

---得到鼓舞按钮
function UIGuildBossRankPanel:GetBtnInspire()
    if (self.mGetBtnInspire == nil) then
        self.mGetBtnInspire = self:GetCurComp("WidgetRoot/Tween/events/btn_inspire", "GameObject")
    end
    return self.mGetBtnInspire
end

---Top_UIScrollView
function UIGuildBossRankPanel:GetRankScrollView()
    if (self.mRankScrollView == nil) then
        self.mRankScrollView = self:GetCurComp("WidgetRoot/Tween/root/Panel/ScrollView", "Top_UIScrollView")
    end
    return self.mRankScrollView
end

---得到排行榜列表
function UIGuildBossRankPanel:GetRankGridContainer()
    if (self.mGetRankGridContainer == nil) then
        self.mGetRankGridContainer = self:GetCurComp("WidgetRoot/Tween/root/Panel/ScrollView/SecondList", "Top_UIGridContainer")
    end
    return self.mGetRankGridContainer
end

---得到自己的排行信息
function UIGuildBossRankPanel:GetSelfRankItem()
    if (self.mGetSelfRankItem == nil) then
        self.mGetSelfRankItem = self:GetCurComp("WidgetRoot/Tween/root/Panel/selfRankItem", "GameObject")
    end
    return self.mGetSelfRankItem
end

---得到公会排行切换按钮
function UIGuildBossRankPanel:GetBtnUnionRank()
    if (self.mGetBtnUnionRank == nil) then
        self.mGetBtnUnionRank = self:GetCurComp("WidgetRoot/Tween/root/Panel/BtnUnionRank", "GameObject")
    end
    return self.mGetBtnUnionRank
end

---得到个人排行切换按钮
function UIGuildBossRankPanel:GetBtnPersonRank()
    if (self.mGetBtnPersonRank == nil) then
        self.mGetBtnPersonRank = self:GetCurComp("WidgetRoot/Tween/root/Panel/BtnPersonRank", "GameObject")
    end
    return self.mGetBtnPersonRank
end

---得到隐藏界面
function UIGuildBossRankPanel:GetBtnHide()
    if (self.mGetBtnHide == nil) then
        self.mGetBtnHide = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject")
    end
    return self.mGetBtnHide
end

function UIGuildBossRankPanel:GetTweenPosition()
    if (self.mGetTween == nil) then
        self.mGetTween = self:GetCurComp("WidgetRoot/Tween", "TweenPosition")
    end
    return self.mGetTween
end

function UIGuildBossRankPanel:GetTweenRotation()
    if (self.mGetTweenRotation == nil) then
        self.mGetTweenRotation = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "TweenRotation")
    end
    return self.mGetTweenRotation
end

---@return UICountdownLabel 剩余时间
function UIGuildBossRankPanel:GetCountDownTimeLabel()
    if self.mGetCountDownTimeLabel == nil then
        self.mGetCountDownTimeLabel = self:GetCurComp("WidgetRoot/Tween/root/Panel/rewardTime", "UICountdownLabel")
    end
    return self.mGetCountDownTimeLabel
end
--endregion

GuildBossRankPanelRankType = {
    ---个人
    Person = 1,
    ---公会
    Union = 2
}

UIGuildBossRankPanel.RankType = GuildBossRankPanelRankType.Union

---@type table<UIGuildBossRankInfoItemTemp>
UIGuildBossRankPanel.GuildBossRankInfoItemTempList = {}

---@type UIGuildBossRankInfoItemTemp
UIGuildBossRankPanel.SelfRankInfoItemTemp = nil

---@type unionV2.UnionBossPlayerRankInfo
UIGuildBossRankPanel.UnionBossPlayerRankInfo = nil
---@type unionV2.UnionBossUnionRankInfo
UIGuildBossRankPanel.UnionBossUnionRankInfo = nil

--region 初始化
function UIGuildBossRankPanel:Init()
    self:BindEvent()
    self:BindMessage()
    self:InitCountDownTimeLabel();
    networkRequest.ReqUnionBossRank()
    uimanager:ClosePanel("UIGuildPanel");
end

function UIGuildBossRankPanel:BindEvent()
    --打开鼓舞界面
    CS.UIEventListener.Get(self:GetBtnInspire()).onClick = function()
        uimanager:CreatePanel("UIGuildBossInspirePanel");
    end

    --打开帮助界面
    CS.UIEventListener.Get(self:GetBtnHelp()).onClick = function()
        Utility.ShowHelpPanel({ id = 183 })
    end

    CS.UIEventListener.Get(self:GetBtnHide()).onClick = function()
        self:BtnHidClicked()
    end

    --点击打开奖励界面
    CS.UIEventListener.Get(self:GetBtnOpenRewardPanel()).onClick = function()
        local rankRewardType = self:GetRewardListType()
        uimanager:CreatePanel("UIGuildBossRankRewardPanel",nil,{rankRewardType = rankRewardType})
    end

    CS.UIEventListener.Get(self:GetBtnUnionRank()).onClick = function()
        self.RankType = GuildBossRankPanelRankType.Union
        self:GetRankScrollView():ResetPosition()
        self:UpdateRankGridPanel()
    end

    CS.UIEventListener.Get(self:GetBtnPersonRank()).onClick = function()
        self.RankType = GuildBossRankPanelRankType.Person
        self:GetRankScrollView():ResetPosition()
        self:UpdateRankGridPanel()
    end

end

function UIGuildBossRankPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionBossPlayerRankInfoMessage, function(id, tblData)
        self:OnResUnionBossPlayerRankInfoMessage(tblData)
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionBossUnionRankInfoMessage, function(id, tblData)
        self:OnResUnionBossUnionRankInfoMessage(tblData)
    end)
end
--endregion

UIGuildBossRankPanel.IsOpen = true

function UIGuildBossRankPanel:BtnHidClicked()
    self.IsOpen = not self.IsOpen
    self:ControlPanelOpenAndClose(self.IsOpen)
end

function UIGuildBossRankPanel:ControlPanelOpenAndClose(bool)
    if self:GetTweenRotation() ~= nil and self:GetTweenPosition() ~= nil then
        if bool then
            self:GetTweenRotation():PlayForward()
            self:GetTweenPosition():PlayForward()
        else
            self:GetTweenRotation():PlayReverse()
            self:GetTweenPosition():PlayReverse()
        end
    end
end

---刷新个人排行榜
---@param tblData unionV2.UnionBossPlayerRankInfo
function UIGuildBossRankPanel:OnResUnionBossPlayerRankInfoMessage(tblData)
    self.UnionBossPlayerRankInfo = tblData
    if (self.RankType == GuildBossRankPanelRankType.Union) then
        return ;
    end
    self:UpdateRankGridPanel()
end

---刷新公会排行榜
---@param tblData unionV2.UnionBossUnionRankInfo
function UIGuildBossRankPanel:OnResUnionBossUnionRankInfoMessage(tblData)
    self.UnionBossUnionRankInfo = tblData
    if (self.RankType == GuildBossRankPanelRankType.Person) then
        return ;
    end

    self:UpdateRankGridPanel()
end

---刷新排行榜信息
function UIGuildBossRankPanel:UpdateRankGridPanel()
    if (self.SelfRankInfoItemTemp == nil) then
        self.SelfRankInfoItemTemp = templatemanager.GetNewTemplate(self:GetSelfRankItem(), luaComponentTemplates.GuildBossRankInfoItemTemp)
    end
    ---@type UIGuildBossRankInfoItemTemp
    local selfTemp = self.SelfRankInfoItemTemp
    if (self.RankType == GuildBossRankPanelRankType.Person) then
        if (self.UnionBossPlayerRankInfo == nil) then
            return ;
        end
        ---更新自己的个人排行榜信息
        selfTemp:UpdatePersonUnit(self.UnionBossPlayerRankInfo.selfRank)
        if (self.UnionBossPlayerRankInfo.playerRanks ~= nil) then
            self:GetRankGridContainer().MaxCount = #self.UnionBossPlayerRankInfo.playerRanks
            local index = 0
            ---@param playerRank UnionBossPlayerRankStrcut
            for i, playerRank in pairs(self.UnionBossPlayerRankInfo.playerRanks) do
                local obj = self:GetRankGridContainer().controlList[index]
                if (self.GuildBossRankInfoItemTempList[obj] == nil) then
                    self.GuildBossRankInfoItemTempList[obj] = templatemanager.GetNewTemplate(obj, luaComponentTemplates.GuildBossRankInfoItemTemp)
                end
                ---@type UIGuildBossRankInfoItemTemp
                local temp = self.GuildBossRankInfoItemTempList[obj]

                temp:UpdatePersonUnit(playerRank)
                index = index + 1
            end
        else
            self:GetRankGridContainer().MaxCount = 0
        end
    else
        ---公会信息
        if (self.UnionBossUnionRankInfo == nil) then
            return ;
        end
        ---更新自己的公会信息排行榜信息
        selfTemp:UpdateUnionUnit(self.UnionBossUnionRankInfo.selfUnioRank)

        if (self.UnionBossUnionRankInfo.unionRanks ~= nil) then
            self:GetRankGridContainer().MaxCount = #self.UnionBossUnionRankInfo.unionRanks
            local index = 0
            ---@param unionRank UnionBossUnionRankStrcut
            for i, unionRank in pairs(self.UnionBossUnionRankInfo.unionRanks) do
                local obj = self:GetRankGridContainer().controlList[index]
                if (self.GuildBossRankInfoItemTempList[obj] == nil) then
                    self.GuildBossRankInfoItemTempList[obj] = templatemanager.GetNewTemplate(obj, luaComponentTemplates.GuildBossRankInfoItemTemp)
                end
                ---@type UIGuildBossRankInfoItemTemp
                local temp = self.GuildBossRankInfoItemTempList[obj]
                temp:UpdateUnionUnit(unionRank)
                index = index + 1
            end
        else
            self:GetRankGridContainer().MaxCount = 0
        end
    end

    ---切换到行会选项时，排名奖励按钮icon隐藏不显示
    --self:GetBtnOpenRewardPanel():SetActive(self.RankType == GuildBossRankPanelRankType.Person)
end

---@return LuaEnumRewardRankType 获取奖励排行类型
function UIGuildBossRankPanel:GetRewardListType()
    if self.RankType == GuildBossRankPanelRankType.Person then
        return LuaEnumRewardRankType.UnionBoss_PersonRank
    elseif self.RankType == GuildBossRankPanelRankType.Union then
        return LuaEnumRewardRankType.UnionBoss_UnionRank
    end
end

function UIGuildBossRankPanel:InitCountDownTimeLabel()
    if (self:GetCountDownTimeLabel() == nil) then
        return
    end

    local activityItem = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarActivity(LuaEnumDailyActivityType.GuildBoss);
    local runningState,activityItemSubInfo = activityItem:GetRunningState()

    if(activityItemSubInfo == nil) then
        self:GetCountDownTimeLabel().gameObject:SetActive(false)
        return;
    end

    local tbl = activityItemSubInfo.Tbl
    if (tbl ~= nil) then
        self:GetCountDownTimeLabel().gameObject:SetActive(true)
        local overTime = tbl:GetOverTime()
        local overTimeStamp = CS.Utility_Lua.GetActivityOverTimeStamp(overTime)
        local isOver = Utility.IsTimeOverBySecondTimeStamp(overTimeStamp)
        local leaveTime = overTimeStamp - CS.CSServerTime.Instance.TotalSeconds * 1000
        if isOver then
            uiStaticParameter.NeedPrintHeart = true
            CS.UnityEngine.Debug.LogError("运行的活动ID为:"..tbl:GetId().."  行会首领时间异常,客户端计算结束时间：" .. overTimeStamp .. "当前客户端获取的服务器时间：" .. CS.CSServerTime.Instance.TotalSeconds * 1000 .. "时间差" .. leaveTime .. "毫秒")
        end
        self:GetCountDownTimeLabel():StartCountDownUpdate(1000, 7, overTimeStamp, "[e85038]", "")
    else
        self:GetCountDownTimeLabel().gameObject:SetActive(false)
    end
end

function ondestroy()
    uimanager:ClosePanel("UIGuildBossRankRewardPanel")
    uimanager:ClosePanel("UIGuildBossInspirePanel")
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIHelpTipsPanel")
end

return UIGuildBossRankPanel