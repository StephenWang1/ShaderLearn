---@class UIGangEscortLeftPanel:UIBase
local UIGangEscortLeftPanel = {}

--region 属性
---@return CSMainPlayerInfo 玩家信息
function UIGangEscortLeftPanel:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSUnionInfoV2 帮会信息
function UIGangEscortLeftPanel:GetUnionInfo()
    if self.mUnionInfo == nil and self:GetPlayerInfo() then
        self.mUnionInfo = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfo
end
--endregion

--region 初始化
function UIGangEscortLeftPanel:Init()
    self:InitConpoment()
    self:BindButtonEvents()
    self:BindNetMsg()
    self:BindClientEvents()
    self:UpdateRefresh()
end

function UIGangEscortLeftPanel:InitConpoment()
    self.btn_Hide_Go = self:GetCurComp("WidgetRoot/Tween/btn_hide", "GameObject")
    self.followBtn_UISprite = self:GetCurComp("WidgetRoot/Tween/btn_follow", "UISprite")
    self.UnionName_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_hold", "UILabel")
    self.UnionPlayerCount_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_playerCount", "UILabel")
    self.CarSpeed_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_carSpeed", "UILabel")
    self.CarDistance_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_carDistance", "UILabel")
    self.Contribute_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/Shadow/lb_contribute", "UILabel")
    self.successEffect = self:GetCurComp("WidgetRoot/Tween/Effect", "GameObject")
    self.helpBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_help", "GameObject")
    self.rankBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_rank", "GameObject")
    self.time_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_activesTime", "UILabel")
    self.Tween_TweenPosition = self:GetCurComp("WidgetRoot/Tween", "TweenPosition")
    self.UnionPlayerCountTitle_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_playerCount/title", "UILabel")
    self.followBtn_State1 = self:GetCurComp("WidgetRoot/Tween/btn_follow/label", "GameObject")
    self.followBtn_State2 = self:GetCurComp("WidgetRoot/Tween/btn_follow/findPathLabel", "GameObject")
end

function UIGangEscortLeftPanel:BindButtonEvents()
    CS.UIEventListener.Get(self.btn_Hide_Go).onClick = function()
        --self:ChangeUnionDartCarLeftPanelStage(false)
        self:TryOpenLvPackPanelLeftIcon()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self.followBtn_UISprite.gameObject).onClick = function()
        --self:FollowCar()
        self:TryFindPath()
    end
    CS.UIEventListener.Get(self.helpBtn_GameObject).onClick = function()
        local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(115)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
        end
    end
    CS.UIEventListener.Get(self.rankBtn_GameObject).onClick = function()
        if CS.CSScene.MainPlayerInfo.ActivityInfo.HaveData == true then
            CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_OpenUnionDartCarSettlePanel)
        end
        networkRequest.ReqUnionCartRank()
    end
end

function UIGangEscortLeftPanel:BindNetMsg()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionCartInfoMessage, UIGangEscortLeftPanel.OnResUnionCartInfoMessageReceived)
end

function UIGangEscortLeftPanel:BindClientEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionDartFindPath, function(id, state)
        self:RefreshBtnState(state)
    end)
end

function UIGangEscortLeftPanel:UpdateRefresh()
    if self.delayRefresh then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh:Reset()
        self.delayRefresh = nil
    end
    self.delayRefresh = CS.CSListUpdateMgr.Add(200, nil, function()
        local remainTime = 0
        if self.endTime ~= nil and self.endTime ~= 0 then
            remainTime = self.endTime * 1000 - CS.CSScene.MainPlayerInfo.serverTime
        end
        local timeText
        if remainTime > 0 then
            local hours, min, second = Utility.MillisecondToFormatTime(remainTime)
            timeText = string.format("%02d", Utility.GetIntPart(min)) .. ":" .. string.format("%02d", Utility.GetIntPart(second))
        else
            timeText = "00:00"
            CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        end
        if self.time_UILabel ~= nil then
            self.time_UILabel.text = timeText
        end
    end, true)
end
--endregion

--region 刷新
function UIGangEscortLeftPanel:Show(luaTable)
    self:RedMsgAndRefreshUI(luaTable)
end

function UIGangEscortLeftPanel.OnResUnionCartInfoMessageReceived(msgId, luaTable)
    UIGangEscortLeftPanel:RedMsgAndRefreshUI(luaTable)
end

function UIGangEscortLeftPanel:RedMsgAndRefreshUI(luaTable)
    if luaTable == nil then
        return
    end
    --设置颜色
    local color = luaEnumColorType.Red
    self.noUnionOccupy = CS.StaticUtility.IsNullOrEmpty(luaTable.unionName)
    self.isSameUnion = false
    self.joinPlayer = 0
    if not self.noUnionOccupy then
        local playerUnionName = self:GetUnionInfo().UnionName
        if luaTable.unionName == playerUnionName then
            self.isSameUnion = true
            color = luaEnumColorType.Blue2
        else
            color = luaEnumColorType.Orange
        end
    end
    if self.noUnionOccupy == false then
        self.joinPlayer = ternary(self.isSameUnion == true, luaTable.joinNum, luaTable.opposeNum)
    end
    self.noColorUnionName = ternary(self.noUnionOccupy, "无人占领", luaTable.unionName)
    self.unionName = ternary(self.noUnionOccupy, color .. "无人占领", color .. luaTable.unionName)
    self.PlayerNum = color .. tostring(self.joinPlayer)
    --self.speed = CS.Cfg_GlobalTableManager.Instance:GetSpeedTextBySpeedValue(ternary(CS.StaticUtility.IsNullOrEmpty(luaTable.unionName), 0, luaTable.moveInterval))
    self.speed = CS.Cfg_GlobalTableManager.Instance:GetUnionDartCarSpeedBySameUnionPlayerNum(luaTable.joinNum)
    self.distance = luaTable.distance
    self.totalDistance = luaTable.totalDis
    self.myScore = luaTable.myScore
    self.mapId = luaTable.mapId
    self.x = luaTable.x
    self.y = luaTable.y
    self.endTime = luaTable.endTime
    self:RefreshUI()
    if self.firstTryFindDartCar == nil or self.firstTryFindDartCar == true then
        self.firstTryFindDartCar = false
        self:TryFindPath()
    else
        self:RefreshFindPathData()
    end
end
--endregion

--region ButtonEvents
---关闭面板
function UIGangEscortLeftPanel:ClosePanel()
    --self:RefreshSelfState(false)
    uimanager:ClosePanel(self)
    networkRequest.ReqWithdrawUnionCart()
end

---尝试寻路
function UIGangEscortLeftPanel:TryFindPath()
    local dot2 = CS.SFMiscBase.Dot2(self.x, self.y)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.DartCarFindPathOperation:DoOperation(self.mapId, dot2)
end

---刷新寻路数据
function UIGangEscortLeftPanel:RefreshFindPathData()
    local dot2 = CS.SFMiscBase.Dot2(self.x, self.y)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.DartCarFindPathOperation:RefreshPosition(self.mapId, dot2)
end

---停止寻路
function UIGangEscortLeftPanel:StopFindPath()
    CS.CSScene.MainPlayerInfo.AsyncOperationController.PersonDartCarFindPathOperation:StopOperation()
end
--endregion

--region UI设置
---刷新UI
function UIGangEscortLeftPanel:RefreshUI()
    self:SetUnionName(self.unionName)
    self:SetPlayerCount(self.PlayerNum)
    self:SetCarSpeed(luaEnumColorType.Gray .. self.speed)
    --self:SetCarDistance(luaEnumColorType.Green1 .. tostring(self.distance) .. "[-]/" .. luaEnumColorType.Gray .. tostring(self.totalDistance) .. "米")
    self:SetCarDistance(luaEnumColorType.Green1 .. tostring(self.distance) .. "米")
    self:SetContribute(tostring(self.myScore))
end

function UIGangEscortLeftPanel:RefreshSelfState(state)
    if self.go ~= nil then
        self.go:SetActive(state)
    end
end

---设置帮会名字
function UIGangEscortLeftPanel:SetUnionName(text)
    if self.UnionName_UILabel ~= nil and text ~= nil then
        self.UnionName_UILabel.text = text
    end
end

---设置帮会成员数量
function UIGangEscortLeftPanel:SetPlayerCount(text)
    if self.UnionPlayerCount_UILabel ~= nil and text ~= nil then
        self.UnionPlayerCount_UILabel.text = text
    end
    if self.UnionPlayerCountTitle_UILabel ~= nil then
        self.UnionPlayerCountTitle_UILabel.text = ternary(self.noColorUnionName == "无人占领" or self.noColorUnionName == CS.CSScene.MainPlayerInfo.UIUnionName, luaEnumColorType.Gray .. "同会成员", luaEnumColorType.Gray .. "[878787]敌会人数")
    end
end

---设置镖车速度
function UIGangEscortLeftPanel:SetCarSpeed(text)
    if self.CarSpeed_UILabel ~= nil and text ~= nil then
        self.CarSpeed_UILabel.text = text
    end
end

---设置镖车距离
function UIGangEscortLeftPanel:SetCarDistance(text)
    if self.CarDistance_UILabel ~= nil and text ~= nil then
        self.CarDistance_UILabel.text = text
    end
end

---设置贡献
function UIGangEscortLeftPanel:SetContribute(text)
    if self.Contribute_UILabel ~= nil and text ~= nil then
        self.Contribute_UILabel.text = text
    end
end
--endregion

--region 延迟关闭面板并成功特效
function UIGangEscortLeftPanel:TryClosePanelAndPlaySuccessEffect(luaData, csData)
    if luaData ~= nil and luaData.rank ~= nil and luaData.rank.common ~= nil and luaData.rank.common.isArrive ~= nil and not CS.StaticUtility.IsNullOrEmpty(luaData.rank.common.unionName) and luaData.rank.common.isArrive == true and luaData.rank.common.unionName == CS.CSScene.MainPlayerInfo.UIUnionName then
        self.playEffectCortinue = StartCoroutine(function()
            self:PlayEffectAndClosePanel(csData)
        end)
    else
        Utility.CloseUnionDartCarActivity()
        CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateUnionDartCarFinishRankInfo(csData)
    end
end

---播放特效并关闭面板
function UIGangEscortLeftPanel:PlayEffectAndClosePanel(csData)
    if self.successEffect ~= nil then
        self.successEffect:SetActive(true)
    end
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1.8))
    Utility.CloseUnionDartCarActivity()
    CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateUnionDartCarFinishRankInfo(csData)
    if self.playEffectCortinue ~= nil then
        StopCoroutine(self.playEffectCortinue)
        self.playEffectCortinue = nil
    end
end

--region 隐藏显示处理
function UIGangEscortLeftPanel:ChangeUnionDartCarLeftPanelStage(bool)
    if self.Tween_TweenPosition ~= nil then
        if bool == true then
            self.Tween_TweenPosition:PlayReverse()
        else
            self.Tween_TweenPosition:PlayForward()
        end
    end
end

---等级奖励面板显示活动展开按钮
function UIGangEscortLeftPanel:TryOpenLvPackPanelLeftIcon()
    local uiLvPackPanel = uimanager:GetPanel("UILvPackPanel")
    if uiLvPackPanel ~= nil and uiLvPackPanel.leftIconTemplate ~= nil then
        uiLvPackPanel.leftIconTemplate:TryOpenLeftIcon({ dailyActivityTimeId = 224 })
    end
end

---切换等级奖励面板状态
function UIGangEscortLeftPanel:ChangeLvPackPanelStage(luaEnuLvPackPanelStage)
    local uiLvPackPanel = uimanager:GetPanel("UILvPackPanel")
    if uiLvPackPanel ~= nil and uiLvPackPanel.leftIconTemplate ~= nil then
        uiLvPackPanel.leftIconTemplate:ChangeStage(luaEnuLvPackPanelStage)
    end
end

---刷新按钮状态
---@param 是否在寻路状态 boolean
function UIGangEscortLeftPanel:RefreshBtnState(isFindPath)
    if self.followBtn_UISprite ~= nil and self.followBtn_State1 ~= nil and self.followBtn_State2 ~= nil and isFindPath ~= nil then
        if isFindPath == true then
            self.followBtn_UISprite.spriteName = "anniu15"
            self.followBtn_State1:SetActive(false)
            self.followBtn_State2:SetActive(true)
        elseif isFindPath == false then
            self.followBtn_UISprite.spriteName = "anniu7"
            self.followBtn_State1:SetActive(true)
            self.followBtn_State2:SetActive(false)
        end
    end
end
--endregion
--endregion

function ondestroy()
    UIGangEscortLeftPanel:OnDestroy()
end

function UIGangEscortLeftPanel:OnDestroy()
    if self.delayRefresh then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh:Reset()
        self.delayRefresh = nil
    end
end
return UIGangEscortLeftPanel