local UIDemonLeftlMainPanel = {}

--region 数据
UIDemonLeftlMainPanel.MagicBossLeftPanelTemplates = {
    [LuaEnumMagicBossAttackTypeForMainPlayerType.Normal] = luaComponentTemplates.MagicBossLeftPanel_Normal,
    [LuaEnumMagicBossAttackTypeForMainPlayerType.BossAttack_Mine] = luaComponentTemplates.MagicBossLeftPanel_AttackOwner,
    [LuaEnumMagicBossAttackTypeForMainPlayerType.BossAttack_OtherPlayer] = luaComponentTemplates.MagicBossLeftPanel_AttackOther,
    [LuaEnumMagicBossAttackTypeForMainPlayerType.BossDead_Mine] = luaComponentTemplates.MagicBossLeftPanel_DeadOwner,
    [LuaEnumMagicBossAttackTypeForMainPlayerType.BossDead_SameUnion] = luaComponentTemplates.MagicBossLeftPanel_DeadSameUnion,
}
--endregion


--region 初始化
function UIDemonLeftlMainPanel:Init()
    self:InitComponent()
    self:BindNetEvents()
    self:BindEvents()
    self:InitParams()
end

function UIDemonLeftlMainPanel:InitComponent()
    self.helpBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/events/helpBtn", "GameObject")
    self.hideBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject")
    self.centerBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/events/btn_center", "GameObject")
    self.addBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/view/add", "GameObject")

    self.panel_TweenPosition = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")
    self.hideBtn_TweenRotation = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "Top_TweenRotation")

    self.getRewardBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/view/down/HelpReward/btn_get", "GameObject")
    self.killRewardBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/view/down/KillReward/btn_get", "GameObject")
end

function UIDemonLeftlMainPanel:BindNetEvents()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDemonBossHelpFailureMessage, function(id, tblData)
        self:ReqHelpDefault(tblData)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshMagicBossTime, function()
        self:RefreshPanel()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_OwenerNameChange, function(eventid, id, value)
        self:RefreshPanel()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshCanGetReward, function()
        self:RefreshPanel()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        if self.curPanelTemplate ~= nil and self.curPanelTemplate.RefreshAddBtnState ~= nil then
            self.curPanelTemplate:RefreshAddBtnState()
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshPanel()
    end)
end

function UIDemonLeftlMainPanel:BindEvents()
    CS.UIEventListener.Get(self.helpBtn_GameObject).onClick = function(go)
        self:HelpBtnOnClick(go)
    end
    CS.UIEventListener.Get(self.hideBtn_GameObject).onClick = function(go)
        self:HideBtnOnClick(go)
    end
    CS.UIEventListener.Get(self.centerBtn_GameObject).onClick = function(go)
        self:CenterBtnOnClick(go)
    end
    CS.UIEventListener.Get(self.addBtn_GameObject).onClick = function(go)
        self:AddKillNumBtnOnClick(go)
    end
    CS.UIEventListener.Get(self.getRewardBtn_GameObject).onClick = function(go)
        self:ReqGetReward(go)
    end
    CS.UIEventListener.Get(self.killRewardBtn_GameObject).onClick = function(go)
        self:ReqGetReward(go)
    end
end

function UIDemonLeftlMainPanel:InitParams()
    self.IsOpen = true
    self:RefreshUpdate(function()
        if self.curPanelTemplate ~= nil and self.curPanelTemplate.Update ~= nil then
            self.curPanelTemplate:Update()
        end
    end)
end
--endregion

--region 刷新
function UIDemonLeftlMainPanel:Show()
    self:RefreshPanel()
end

---解析显示数据
function UIDemonLeftlMainPanel:AnalysisShowParams()
    if luaclass.MagicBossDataInfo == nil or luaclass.MagicBossDataInfo.analysisMagicBossSuccess == false then
        self:ResetParams()
        return false
    end
    local magicBossAttackType = luaclass.MagicBossDataInfo:GetMagicBossAttackTypeForMainPlayer()
    if self.magicBossAttackType ~= magicBossAttackType then
        local template = self:GetTemplateByMagicBossAttackType(magicBossAttackType)
        if template ~= nil and CS.StaticUtility.IsNull(self.panel_TweenPosition) == false then
            self.curPanelTemplate = templatemanager.GetNewTemplate(self.panel_TweenPosition.gameObject, template)
        end
    end
    self.magicBossAttackType = magicBossAttackType
    if self.curPanelTemplate == nil then
        return false
    end
    self.magicBossAvater = luaclass.MagicBossDataInfo.magicBossAvater
    self.magicBossTableInfo = luaclass.MagicBossDataInfo.magicBossTableInfo
    if self. magicBossTableInfo == nil then
        return false
    end
    self.magicBossType = self.magicBossTableInfo.dropType
    return true
end

function UIDemonLeftlMainPanel:RefreshPanel()
    if self:AnalysisShowParams() == false then
        uimanager:ClosePanel(self)
    end
    self:RefreshCurPanel()
end

---刷新当前类型的模板
function UIDemonLeftlMainPanel:RefreshCurPanel()
    if self.curPanelTemplate == nil or self.curPanelTemplate.RefreshPanel == nil then
        return
    end
    self.curPanelTemplate:RefreshPanel()
end

---请求拉令失败
function UIDemonLeftlMainPanel:ReqHelpDefault(tblData)
    if tblData ~= nil then
        if tblData.type == LuaEnumMagicBossReqHelpDefaultType.InTheCooling then
            uiStaticParameter.MagicBossReqHelpEndTime = tblData.cdEndTime
            self:ShowReqDefaultBubble()
        end
    end
end
--endregion

--region 点击事件
---帮助按钮点击事件
function UIDemonLeftlMainPanel:HelpBtnOnClick()
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(169)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

---隐藏按钮点击事件
function UIDemonLeftlMainPanel:HideBtnOnClick()
    self:ControlPanelOpenAndClose(self.IsOpen)
    self.IsOpen = not self.IsOpen
end

---请求协助按钮点击
function UIDemonLeftlMainPanel:CenterBtnOnClick()
    if self.magicBossAvater ~= nil then
        networkRequest.ReqDemonBossHelp(self.magicBossAvater.ID)
    end
end

---尝试创建队伍(发起援助后如果玩家在其他队伍, 则退出队伍并创建一个队伍)
function UIDemonLeftlMainPanel:TryCreateTeam()
    ---是否有一个自己的队伍(队长为自己)
    local hasMyTeam = false;

    if (CS.CSScene.MainPlayerInfo ~= nil) then
        if (CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup) then
            if (not CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain) then
                networkRequest.ReqExitGroup(CS.CSScene.MainPlayerInfo.ID);
            else
                hasMyTeam = true;
                ---如果有队伍但是队伍模式不是<同行会自动加入>则切换为<同行会自动加入>
                if (CS.CSScene.MainPlayerInfo.GroupInfoV2.captainAllowMode ~= LuaEnumTeamReqType.UnionAutoJoin) then
                    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                        networkRequest.ReqShareCommon(luaEnumReqServerCommonType.GROUP_CAPTION_SET_ALLOW_MODE, LuaEnumTeamReqType.UnionAutoJoin);
                    else
                        networkRequest.ReqCommon(luaEnumReqServerCommonType.GROUP_CAPTION_SET_ALLOW_MODE, LuaEnumTeamReqType.UnionAutoJoin);
                    end
                end
            end
        end
        ---如果没有自己的队伍就创建一个
        if (not hasMyTeam) then
            networkRequest.ReqCreatGroup();
        end
    end
end

---增加击杀次数按钮点击
function UIDemonLeftlMainPanel:AddKillNumBtnOnClick(go)
    luaclass.MagicBossDataInfo:TryAddKillNum(go, self.magicBossType)
end

---请求获取奖励
function UIDemonLeftlMainPanel:ReqGetReward(go)
    luaclass.MagicBossDataInfo:TryReqGetAward()
end
--endregion

--region tween动画
function UIDemonLeftlMainPanel:ControlPanelOpenAndClose(bool)
    if CS.StaticUtility.IsNull(self.panel_TweenPosition) == false and CS.StaticUtility.IsNull(self.hideBtn_TweenRotation) == false then
        if bool then
            self.panel_TweenPosition:PlayForward()
            self.hideBtn_TweenRotation:PlayForward()
        else
            self.panel_TweenPosition:PlayReverse()
            self.hideBtn_TweenRotation:PlayReverse()
        end
    end
end

---显示请求失败气泡
function UIDemonLeftlMainPanel:ShowReqDefaultBubble()
    local remainTime = uiStaticParameter.MagicBossReqHelpEndTime - CS.CSScene.MainPlayerInfo.serverTime
    remainTime = Utility.GetMaxIntPart(ternary(remainTime < 0, 0, remainTime) * 0.001)
    local des = CS.Cfg_PromptFrameTableManager.Instance:GetShowContent(402, remainTime)
    Utility.ShowPopoTips(self.centerBtn_GameObject.transform, des, 402)
end
--endregion

--region 通用刷新
---启动刷新
function UIDemonLeftlMainPanel:RefreshUpdate(action)
    self:RemoveUpdate()
    if action == nil then
        return
    end
    self.initListUpdate = CS.CSListUpdateMgr.Add(200, nil, action, true)
end

function UIDemonLeftlMainPanel:RemoveUpdate()
    if self.initListUpdate ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.initListUpdate)
        self.initListUpdate = nil
    end
end

--region 获取
---通过魔之boss对于主角而言的状态类型获取对应的模板
---@param attackType LuaEnumMagicBossAttackTypeForMainPlayerType 魔之boss对于主角而言的状态类型
---@return table 对应的模板/nil
function UIDemonLeftlMainPanel:GetTemplateByMagicBossAttackType(attackType)
    if attackType == nil then
        return
    end
    return self.MagicBossLeftPanelTemplates[attackType]
end
--endregion

--region ondestroy
function UIDemonLeftlMainPanel:OnDestroy()
    self:RemoveUpdate()
end

function ondestroy()
    UIDemonLeftlMainPanel:OnDestroy()
end
--endregion
--endregion

return UIDemonLeftlMainPanel