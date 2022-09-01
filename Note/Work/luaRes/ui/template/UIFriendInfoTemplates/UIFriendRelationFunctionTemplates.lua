local UIFriendRelationFunctionTemplates = {}

--region 局部变量

--endregion

--region 组件

--endregion

--region 初始化
function UIFriendRelationFunctionTemplates:Init(panel, ownerPanel)
    self.SocialContactPanel = panel
    ---@type UIBase
    self.mOwnerPanel = ownerPanel
    self.index = 0
    self.icon = self:Get("icon", "UISprite")
    self.Label = self:Get("Label", "UILabel")
    self.info = nil
    self.type = nil
    self.teamFunc = nil
    self.unionFunc = nil
    self:BindNetMessage()
end

function UIFriendRelationFunctionTemplates:InitTemplates(info, type)
    self.info = info
    self.type = type
    if (self.type == LuaEnumFriendRelationFuncType.FriendCircle) then
        self.icon.spriteName = "Social_icon8"
        self.Label.text = "朋友圈"
    elseif (self.type == LuaEnumFriendRelationFuncType.SpouseBuff) then
        self.icon.spriteName = "icon1"
        self.Label.text = ""
    elseif (self.type == LuaEnumFriendRelationFuncType.BrotherBuff) then
        self.icon.spriteName = "icon1"
        self.Label.text = ""
    elseif (self.type == LuaEnumFriendRelationFuncType.Flower) then
        self.icon.spriteName = "Social_icon3"
        self.Label.text = "送花"
    elseif (self.type == LuaEnumFriendRelationFuncType.Finger) then
        self.icon.spriteName = "Social_icon4"
        self.Label.text = "猜拳"
    elseif (self.type == LuaEnumFriendRelationFuncType.Deal) then
        self.icon.spriteName = "Social_icon2"
        self.Label.text = "交易"
    elseif (self.type == LuaEnumFriendRelationFuncType.Summon) then
        self.icon.spriteName = "Social_icon6"
        self.Label.text = "支援"
    elseif (self.type == LuaEnumFriendRelationFuncType.Chat) then
        self.icon.spriteName = "Social_icon1"
        self.Label.text = "私聊"
    elseif (self.type == LuaEnumFriendRelationFuncType.Team) then
        self.icon.spriteName = "Social_icon6"
        self:ChangeTeamLabel()
    elseif (self.type == LuaEnumFriendRelationFuncType.Union) then
        self.icon.spriteName = "Social_icon5"
        self:ChangeUnionLabel()
    elseif (self.type == LuaEnumFriendRelationFuncType.PlayerMessage) then
        self.icon.spriteName = "Social_icon9"
        self.Label.text = "查看装备"
    end
end

function UIFriendRelationFunctionTemplates:BindUIEvents()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.RelationFunc
end

function UIFriendRelationFunctionTemplates:BindNetMessage()
    self.onCommentMessage = function(msgId, serverData)
        if serverData and self.type ~= LuaEnumFriendRelationFuncType.Flower then
            return
        end
        self:OnResCommentMessage(msgId, serverData)
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, self.onCommentMessage)
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareCommonMessage, self.onCommentMessage)

end

--endregion

--region 事件
function UIFriendRelationFunctionTemplates:RelationFunc(go)
    if (self.type == LuaEnumFriendRelationFuncType.FriendCircle) then
        local customData = {};
        customData.subCustomData = {};
        customData.subCustomData.targetId = self.info.rid;
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Friend_CircleOfFriends, customData);
    elseif (self.type == LuaEnumFriendRelationFuncType.SpouseBuff) then
    elseif (self.type == LuaEnumFriendRelationFuncType.BrotherBuff) then
    elseif (self.type == LuaEnumFriendRelationFuncType.Flower) then
        if (self.SocialContactPanel.mCurChooseTem.info.isOnline == false) then
            self:ShowTips(go, 268)
        else
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, self.info.rid)
            else
                networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, self.info.rid)
            end
        end
    elseif (self.type == LuaEnumFriendRelationFuncType.Finger) then
        if (self.SocialContactPanel.mCurChooseTem.info.isOnline == false) then
            self:ShowTips(go, 268)
        else
            self:Fist()
        end
    elseif (self.type == LuaEnumFriendRelationFuncType.Deal) then
        uimanager:CreatePanel("UISendDiamondPanel", nil, self.info.name)
    elseif (self.type == LuaEnumFriendRelationFuncType.Summon) then
    elseif (self.type == LuaEnumFriendRelationFuncType.Chat) then
        self:ChatBtnOnClick()
    elseif (self.type == LuaEnumFriendRelationFuncType.Team) then
        if (self.SocialContactPanel.mCurChooseTem.info.isOnline == false) then
            self:ShowTips(go, 268)
        else
            if (self.teamFunc ~= nil) then
                self.teamFunc()
            end
        end
    elseif (self.type == LuaEnumFriendRelationFuncType.Union) then
        if (self.SocialContactPanel.mCurChooseTem.info.isOnline == false) then
            self:ShowTips(go, 268)
        else
            if (self.unionFunc ~= nil) then
                self.unionFunc()
            end
        end
    elseif (self.type == LuaEnumFriendRelationFuncType.PlayerMessage) then
        if (self.SocialContactPanel.mCurChooseTem.info.isOnline == false) then
            self:ShowTips(go, 268)
        else
            CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(self.SocialContactPanel.mCurChooseTem.info.rid, LuaEnumOtherPlayerBtnType.ROLE, LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
        end
    end
end

--region 送花

function UIFriendRelationFunctionTemplates:CheckFlower()
    local isshowSendPanel, isShowPromptPanel = Utility.TryOpenSendFlowerPanel({
        Sex = self.info.sex,
        rid = self.info.rid,
        name = self.info.name,
        PromptClickFunc = function()
            uimanager:ClosePanel("UIGuildTipsPanel")
        end
    })
end
--endregion

--region 划拳
---划拳
function UIFriendRelationFunctionTemplates:Fist()
    if (self.info.rid ~= 0) then
        networkRequest.ReqInviteFinger(self.info.rid, self.info.name)
    end
end
--endregion

--region 私聊
function UIFriendRelationFunctionTemplates:ChatBtnOnClick()
    self.SocialContactPanel.SocialContactPanel.GetBranchPanel(LuaEnumSocialFriendPanelType.LastChatPanel).mCurChooseTem = self.mCurChooseTem
    self.SocialContactPanel.SocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.LastChatPanel)
    local go = self.SocialContactPanel.SocialContactPanel.GetCurBranchPanel().FriendTemplatesID[self.SocialContactPanel.mCurChooseTem.rid]
    if (go ~= nil and self.SocialContactPanel.SocialContactPanel.GetCurBranchPanel().FriendTemplates[go] ~= nil) then
        self.SocialContactPanel.SocialContactPanel.GetCurBranchPanel().FriendTemplates[go]:SocialLastChatFriendOnClick(false)
    else
        local lastchatpanel = self.SocialContactPanel.SocialContactPanel.GetCurBranchPanel()
        local grid = lastchatpanel:GetSocialLastChatList_UIGridContainer()
        grid.MaxCount = grid.MaxCount + 1
        local gos = grid.controlList[grid.MaxCount - 1]
        if (lastchatpanel.FriendTemplates[gos] == nil) then
            lastchatpanel.FriendTemplates[gos] = templatemanager.GetNewTemplate(gos, luaComponentTemplates.UISocialLastChatFriendTemplates, lastchatpanel)
        end
        lastchatpanel.temPrivateID = self.SocialContactPanel.mCurChooseTem.rid
        lastchatpanel.FriendTemplates[gos]:InitParameters(self.SocialContactPanel.mCurChooseTem.info)
        lastchatpanel.FriendTemplates[gos]:SetRoleHeadIcon(self.SocialContactPanel.mCurChooseTem.sex, self.SocialContactPanel.mCurChooseTem.career)
        lastchatpanel.FriendTemplatesID[self.SocialContactPanel.mCurChooseTem.rid] = gos
        lastchatpanel.FriendTemplates[gos].index = grid.MaxCount
        lastchatpanel.FriendTemplates[gos]:RefreshUI()
        lastchatpanel.FriendTemplates[gos]:SocialLastChatFriendOnClick(true)
    end
    networkRequest.ReqAddSendChat(self.SocialContactPanel.mCurChooseTem.rid)
end
--endregion

--region 队伍
function UIFriendRelationFunctionTemplates:ChangeTeamLabel()
    local GroupInfoV2 = CS.CSScene.MainPlayerInfo.GroupInfoV2
    if GroupInfoV2 ~= nil then
        --主角无队伍
        local TeamID = self.SocialContactPanel.SocialContactPanel.TeamID
        if GroupInfoV2.PlayerInfoList.Count == 0 and TeamID ~= 0 then
            self.Label.text = "入队"
            self.teamFunc = function(go)
                local mapId = CS.CSScene.getMapID()
                local meetLYMJ = CS.Cfg_GlobalTableManager.Instance:IsLangYanMengJingMap(mapId)
                if meetLYMJ then
                    Utility.ShowPopoTips(self.go, nil, 280, "UITeamPanel")
                    return
                end
                if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                    networkRequest.ReqShareJoinGroup(TeamID);
                else
                    networkRequest.ReqJoinGroup(TeamID)
                end
            end
        elseif TeamID == 0 then
            --GroupInfoV2.PlayerInfoList.Count ~= 0 and
            self.Label.text = "邀入队"
            self.teamFunc = function(go)
                local mapId = CS.CSScene.getMapID()
                local meetLYMJ = CS.Cfg_GlobalTableManager.Instance:IsLangYanMengJingMap(mapId)
                if meetLYMJ then
                    Utility.ShowPopoTips(self.go, nil, 280, "UITeamPanel")
                    return
                end
                local reqID = self.SocialContactPanel.mCurChooseTem.rid
                if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                    networkRequest.ReqShareInvitationPlayer(reqID)
                else
                    networkRequest.ReqInvitationPlayer(reqID)
                end
            end
        end
    end
end
--endregion

--region 行会
function UIFriendRelationFunctionTemplates:ChangeUnionLabel()
    --主角无队伍
    local UnionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2
    local GuildID = self.SocialContactPanel.SocialContactPanel.GuildID

    local levelArrive = CS.CSUnionInfoV2.IsLevelCanJoinUnion(CS.CSScene.MainPlayerInfo.Level)
    -- 本人无行会且达到入会等级，对方有行会，则点击对方头像，显示申请入会
    if UnionInfo and UnionInfo.UnionInfo then
        local myPos = UnionInfo:GetCurrentPosition()
        local canInvite = CS.CSUnionInfoV2.HasUnionApprovalAuthority(myPos)
        --本人有行会且达到审批职位，对方无行会且达到入会等级，点击对方头像，显示邀请入会
        if UnionInfo.UnionID == 0 and GuildID ~= 0 and levelArrive then
            self.Label.text = "入会"
            self.unionFunc = function()
                networkRequest.ReqJoinOrWithdrawUnion(GuildID, 1)
            end
        elseif UnionInfo.UnionID ~= 0 and GuildID == 0 and canInvite and levelArrive then
            self.Label.text = "邀入会"
            self.unionFunc = function()
                networkRequest.ReqInviteForEnterUnion(self.SocialContactPanel.mCurChooseTem.rid)
            end
        end
    elseif GuildID ~= 0 and levelArrive then
        self.Label.text = "入会"
        self.unionFunc = function()
            networkRequest.ReqJoinOrWithdrawUnion(GuildID, 1)
        end
    end
end
--endregion

function UIFriendRelationFunctionTemplates:OnResCommentMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.PlayIsOnLine then
        if serverData.data == nil then
            return
        end
        if serverData.data64 ~= self.info.rid then
            return
        end
        ---不在线
        if serverData.data == 0 then
            CS.Utility.ShowTips("玩家不在线", 1.5, CS.ColorType.Yellow)
            ---在线
        elseif serverData.data == 1 then
            self:CheckFlower()
        end
    end
end

function UIFriendRelationFunctionTemplates:ShowTips(go, id)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform

    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end

function UIFriendRelationFunctionTemplates:OnDestroy()
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResCommonMessage, self.onCommentMessage)
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResShareCommonMessage, self.onCommentMessage)
end

--endregion

return UIFriendRelationFunctionTemplates