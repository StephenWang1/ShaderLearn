---@class UIMainChatPanel:UIBase
local UIMainChatPanel = {}

---@type Utility
local Utility = Utility

--region parameters
UIMainChatPanel.PanelLayerType = CS.UILayerType.BasicPlane
UIMainChatPanel.InnerClosePanel = false
UIMainChatPanel.curSelectChanel = 0
UIMainChatPanel.inGridDic = {}
UIMainChatPanel.outGridDic = {}
UIMainChatPanel.ResChatDic = {}
UIMainChatPanel.ChatRecordDic = {}
UIMainChatPanel.GeneralChatList = CS.System.Collections.Generic["List`1[chatV2.ResChat]"]()
UIMainChatPanel.TeamPanel = nil
UIMainChatPanel.mNewInfos = LuaEnumMainChatType.Friend--1为邮件2为好友申请3为好友信息
UIMainChatPanel.mExpSlider = nil    --经验条控制器
UIMainChatPanel.SocialBtnCanClick = true
UIMainChatPanel.GMCount = 0
UIMainChatPanel.UIOpenTogNum = 4
UIMainChatPanel.UIOpenTogWidth = 78
UIMainChatPanel.mCurShowPanelName = ""
UIMainChatPanel.IsTeamApply = false
UIMainChatPanel.BubleTime = 0;
---组队到期时间
UIMainChatPanel.TeamOutTime = nil
---玩家收到邀请信息
UIMainChatPanel.mInviteInfo = nil
---当前面板
UIMainChatPanel.mCurChoosePanel = nil
---离线Buble特效
UIMainChatPanel.mOffLineBubleEffect = nil
---离线Bubble特效轮次
UIMainChatPanel.mOffLineBubleEffectCount = 0
---主界面背包物品不足提示是否创建
UIMainChatPanel.isBagItemHintCreated = false
UIMainChatPanel.BesizerPointCen1X = 0
UIMainChatPanel.BesizerPointCen2X = 0

---@type UIFlashTipsViewTemplate
UIMainChatPanel.flashTipsTemplate = nil

---选中图片
UIMainChatPanel.SpriteChooseName = {
    [LuaEnumSocialPanelType.MailPanel] = "l2",
    [LuaEnumSocialPanelType.SocialChatPanel] = "l1",
    [LuaEnumSocialPanelType.TeamPanel] = "l3",
    [LuaEnumSocialPanelType.GuildPanel] = "l4",
}

---未选中图片
UIMainChatPanel.SpriteNotChooseName = {
    [LuaEnumSocialPanelType.MailPanel] = "t2",
    [LuaEnumSocialPanelType.SocialChatPanel] = "t1",
    [LuaEnumSocialPanelType.TeamPanel] = "t3",
    [LuaEnumSocialPanelType.GuildPanel] = "t4",
}

---@type chatV2.ResChat 聊天数据
UIMainChatPanel.RedPackChatInfo = nil

---聊天点击最小尺寸
UIMainChatPanel.ChatClickMinSize = {
    x = 0,
    y = 37,
    z = 385,
    w = 75,
}
--endregion

--region 组件
function UIMainChatPanel.GetUIMainMenusPanel()
    if (UIMainChatPanel.mUIMainMenusPanel == nil) then
        UIMainChatPanel.mUIMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    end
    return UIMainChatPanel.mUIMainMenusPanel
end

function UIMainChatPanel.GetBesizerPoint_GameObject()
    if (UIMainChatPanel.mBesizerPoint == nil) then
        UIMainChatPanel.mBesizerPoint = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizerPoint", "GameObject")
    end
    return UIMainChatPanel.mBesizerPoint
end

function UIMainChatPanel.GetBesizerPointup_GameObject()
    if (UIMainChatPanel.mBesizerPointup == nil) then
        UIMainChatPanel.mBesizerPointup = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizerPoint/BesizerPointup", "GameObject")
    end
    return UIMainChatPanel.mBesizerPointup
end

function UIMainChatPanel.GetBesizerPointcenter1_GameObject()
    if (UIMainChatPanel.BesizerPointcenter1 == nil) then
        UIMainChatPanel.BesizerPointcenter1 = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizerPoint/BesizerPointcenter1", "GameObject")
    end
    return UIMainChatPanel.BesizerPointcenter1
end

function UIMainChatPanel.GetBesizerPointcenter2_GameObject()
    if (UIMainChatPanel.BesizerPointcenter2 == nil) then
        UIMainChatPanel.BesizerPointcenter2 = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizerPoint/BesizerPointcenter2", "GameObject")
    end
    return UIMainChatPanel.BesizerPointcenter2
end

function UIMainChatPanel.GetBesizerPointdown_GameObject()
    if (UIMainChatPanel.BesizerPointdown == nil) then
        UIMainChatPanel.BesizerPointdown = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizerPoint/BesizerPointdown", "GameObject")
    end
    return UIMainChatPanel.BesizerPointdown
end

function UIMainChatPanel.GetOffLinePointLeft_GameObject()
    if (UIMainChatPanel.mOffLinePointLeft == nil) then
        UIMainChatPanel.mOffLinePointLeft = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizeOffLinePoint/OffLineEffectPointLeft", "GameObject")
    end
    return UIMainChatPanel.mOffLinePointLeft
end

function UIMainChatPanel.GetOffLinePointCenter_GameObject()
    if (UIMainChatPanel.mOffLinePointCenter == nil) then
        UIMainChatPanel.mOffLinePointCenter = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizeOffLinePoint/OffLineEffectPointMiddle", "GameObject")
    end
    return UIMainChatPanel.mOffLinePointCenter
end

function UIMainChatPanel.GetOffLinePointRight_GameObject()
    if (UIMainChatPanel.mOffLinePointRight == nil) then
        UIMainChatPanel.mOffLinePointRight = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizeOffLinePoint/OffLineEffectPointRight", "GameObject")
    end
    return UIMainChatPanel.mOffLinePointRight
end

function UIMainChatPanel.GetOffLineEndPoint_GameObject()
    if (UIMainChatPanel.mOffLineEndPoint == nil) then
        UIMainChatPanel.mOffLineEndPoint = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/BesizeOffLinePoint/OffLineEffectEndPoint", "GameObject")
    end
    return UIMainChatPanel.mOffLineEndPoint
end

---@return UnityEngine.GameObject 帮会按钮
function UIMainChatPanel:GetGuildBtn_GameObject()
    if self.mGuildBtn == nil then
        self.mGuildBtn = self:GetCurComp("WidgetRoot/UIopen/btn_guild", "GameObject")
    end
    return self.mGuildBtn
end

---@return UISprite 帮会背景图片
function UIMainChatPanel:GetGuildBg_UISprite()
    if self.mGuildBg == nil then
        self.mGuildBg = self:GetCurComp("WidgetRoot/UIopen/btn_guild/bg", "UISprite")
    end
    return self.mGuildBg
end

---@return UnityEngine.GameObject 好友选中
function UIMainChatPanel:GetChatCheck_GameObject()
    if self.mChatCheck == nil then
        self.mChatCheck = self:GetCurComp("WidgetRoot/UIopen/btn_chat/Checkmark", "GameObject")
    end
    return self.mChatCheck
end

---@return UnityEngine.GameObject 队伍选中
function UIMainChatPanel:GetTeamCheck_GameObject()
    if self.mTeamCheck == nil then
        self.mTeamCheck = self:GetCurComp("WidgetRoot/UIopen/btn_team/Checkmark", "GameObject")
    end
    return self.mTeamCheck
end

---@return UnityEngine.GameObject 邮件选中
function UIMainChatPanel:GetMailCheck_GameObject()
    if self.mMailCheck == nil then
        self.mMailCheck = self:GetCurComp("WidgetRoot/UIopen/btn_mail/Checkmark", "GameObject")
    end
    return self.mMailCheck
end

---@return UnityEngine.GameObject 帮会选中
function UIMainChatPanel:GetGuildCheck_GameObject()
    if self.mGuildCheck == nil then
        self.mGuildCheck = self:GetCurComp("WidgetRoot/UIopen/btn_guild/Checkmark", "GameObject")
    end
    return self.mGuildCheck
end
--endregion

--region 属性
---@return CSMainPlayerInfo 玩家信息
function UIMainChatPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2 帮会信息
function UIMainChatPanel:GetUnionInfo()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

---@return CSChatInfoV2 聊天数据
function UIMainChatPanel:GetChatV2()
    if self.mChatV2 == nil and self:GetPlayerInfo() then
        self.mChatV2 = self:GetPlayerInfo().ChatInfoV2
    end
    return self.mChatV2
end

---@return number 打开帮会等级限制
function UIMainChatPanel:GetOpenUnionLimit()
    if self.mOpenUnionLimitLevel == nil then
        self.mOpenUnionLimitLevel = CS.Cfg_GlobalTableManager.Instance:OpenUnionLevel()
    end
    return self.mOpenUnionLimitLevel
end

---@return string  打开帮会等级不足提示
function UIMainChatPanel:GetOpenPanelLevelNotEnoughDes()
    if self.mOpenGuildDes == nil then
        local res1, bubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(235)
        if res1 then
            self.mOpenGuildDes = string.format(bubbleInfo.content, self:GetOpenUnionLimit())
        end
    end
    return self.mOpenGuildDes
end
--endregion

--region 初始化
function UIMainChatPanel:Init()
    ---@type UnityEngine.GameObject
    UIMainChatPanel.btn_bag = self:GetCurComp("WidgetRoot/infarea/btn_bag", "GameObject")
    ---@type UnityEngine.Transform
    UIMainChatPanel.bagPos = self:GetCurComp("WidgetRoot/bagpos", "Transform")
    ---@type TweenAlpha 背包TweenAlpha
    UIMainChatPanel.btn_bag_tweenAlpha = self:GetCurComp("WidgetRoot/infarea/btn_bag", "TweenAlpha")
    ---@type TweenPosition TweenPosition
    UIMainChatPanel.btn_bag_tweenPosition = self:GetCurComp("WidgetRoot/infarea/btn_bag", "TweenPosition")
    ---@type UnityEngine.GameObject 社交红点
    UIMainChatPanel.socialRedPoint = self:GetCurComp("WidgetRoot/infarea/btn_social/redpoint", "UIRedPoint")
    ---@type UnityEngine.GameObject 背包红点
    UIMainChatPanel.bagRedPoint = self:GetCurComp("WidgetRoot/infarea/btn_bag/redPoint", "GameObject")
    ---@type UnityEngine.GameObject 背包格子剩余数量
    UIMainChatPanel.emptyGridCount = self:GetCurComp("WidgetRoot/infarea/btn_bag/redPoint/EmptyGridCount", "UILabel")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.btn_social = self:GetCurComp("WidgetRoot/infarea/btn_social", "GameObject")
    --UIMainChatPanel.showIcon_SpriteAnimation = self:GetCurComp("WidgetRoot/infarea/btn_social/showicon", "Top_UISpriteAnimation")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.btn_bgsocial = self:GetCurComp("WidgetRoot/infarea/btn_social/bg", "GameObject")
    ---@type UISprite
    UIMainChatPanel.btn_socialBG = self:GetCurComp("WidgetRoot/infarea/btn_social", "UISprite")
    ---@type UISprite
    UIMainChatPanel.btn_socialIcon = self:GetCurComp("WidgetRoot/infarea/btn_social/bg", "UISprite")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.UIBubleEffectRoot = self:GetCurComp("WidgetRoot/UIBubleOnLinePanelEffectRoot", "GameObject")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.UIExpSliderEndPoint = self:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg/SliderEndPoint", "GameObject")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.UIOpen = self:GetCurComp("WidgetRoot/UIopen", "GameObject")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.outInfo = self:GetCurComp("WidgetRoot/infarea/outInfo", "GameObject")
    ---@type Top_UIGridContainer
    self.outGrid = self:GetCurComp("WidgetRoot/infarea/outInfo/GameObject/Chat Area/GameObject/outGrid", "Top_UIGridContainer")

    ---@type Top_UIPanel
    UIMainChatPanel.Panel = self:GetCurComp("WidgetRoot/infarea/ChatArea/Chat Area", "Top_UIPanel")

    ---@type Top_ChatListView
    UIMainChatPanel.Grild = self:GetCurComp("WidgetRoot/infarea/ChatArea/Chat Area/Grild", "Top_ChatListView")
    ---@type Top_UIWidget
    UIMainChatPanel.GrildWidget = self:GetCurComp("WidgetRoot/infarea/ChatArea/Chat Area/Grild", "Top_UIWidget")

    ---@type UnityEngine.GameObject
    UIMainChatPanel.btn_team = self:GetCurComp("WidgetRoot/infarea/btn_team", "GameObject")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.btn_mail = self:GetCurComp("WidgetRoot/UIopen/btn_mail", "GameObject")
    ---@type UIRedPoint
    UIMainChatPanel.mailRedPoint = self:GetCurComp("WidgetRoot/UIopen/btn_mail/redpoint", "UIRedPoint")
    ---@type UISprite
    UIMainChatPanel.UIOpenBG = self:GetCurComp("WidgetRoot/UIopen/bg", "UISprite")
    ---@type UISprite
    UIMainChatPanel.btn_mailBG = self:GetCurComp("WidgetRoot/UIopen/btn_mail/bg", "UISprite")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.btn_chat = self:GetCurComp("WidgetRoot/UIopen/btn_chat", "GameObject")
    ---@type UISprite
    UIMainChatPanel.btn_chatBG = self:GetCurComp("WidgetRoot/UIopen/btn_chat/bg", "UISprite")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.btn_teamPanel = self:GetCurComp("WidgetRoot/UIopen/btn_team", "GameObject")
    ---@type UISprite
    UIMainChatPanel.btn_teamPanelBG = self:GetCurComp("WidgetRoot/UIopen/btn_team/bg", "UISprite")
    ---@type UnityEngine.GameObject
    UIMainChatPanel.exp = self:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/expbg", "GameObject")
    UIMainChatPanel.mExpSlider = templatemanager.GetNewTemplate(UIMainChatPanel.exp, luaComponentTemplates.UIExpSlider, UIMainChatPanel)

    ---@type UnityEngine.GameObject
    UIMainChatPanel.UIDragScrollView = self:GetCurComp("WidgetRoot/infarea/ChatArea/UIDragScrollView", "GameObject")
    UIMainChatPanel.UIDragBox = self:GetCurComp("WidgetRoot/infarea/ChatArea/UIDragScrollView", "BoxCollider")

    ---@type Top_UIWidget 闪烁提示
    UIMainChatPanel.flashTips_Widget = self:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/flashTips", "Top_UIWidget")

    CS.UIEventListener.Get(UIMainChatPanel.UIDragScrollView).onClick = UIMainChatPanel.ChatBtnOnClick
    CS.UIEventListener.Get(UIMainChatPanel.btn_bgsocial).onClick = UIMainChatPanel.OnSocialButtonClicked
    CS.UIEventListener.Get(UIMainChatPanel.btn_bag).onClick = UIMainChatPanel.OnBagButtonClicked
    CS.UIEventListener.Get(UIMainChatPanel.btn_mail).onClick = UIMainChatPanel.MailBtnonClick
    CS.UIEventListener.Get(UIMainChatPanel.btn_chat).onClick = UIMainChatPanel.BtnChatBtnonClick
    CS.UIEventListener.Get(UIMainChatPanel.btn_teamPanel).onClick = UIMainChatPanel.OpenUITeamPanel
    CS.UIEventListener.Get(UIMainChatPanel.btn_team).onClick = UIMainChatPanel.TeamReq
    CS.UIEventListener.Get(self:GetGuildBtn_GameObject()).onClick = function(go)
        self:OnGuildBtnClicked(go)
    end

    UIMainChatPanel.Panel.depth = 1
    UIMainChatPanel.InitFlash()
    self:InitOther()
    networkRequest.ReqGetMailList()
    networkRequest.ReqBubbleOfflineExp()
    networkRequest.ReqUnLookApplicant()
    uiStaticParameter.UIChatPanel_SelectIndex = 0
end

--初始化 变量 按钮点击 服务器消息事件等
function UIMainChatPanel:InitOther()
    CS.UIEventListener.Get(UIMainChatPanel.outInfo).onClick = UIMainChatPanel.ChatBtnOnClick

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResNewMailMessage, UIMainChatPanel.onResNewMailMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCheckCallBackMessage, UIMainChatPanel.onResCallBackMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareCheckCallBackMessage, UIMainChatPanel.onResCallBackMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareInvitationListMessage, UIMainChatPanel.ResInvitationMonitor)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInvitationListMessage, UIMainChatPanel.ResInvitationMonitor)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResApplyListMessage, UIMainChatPanel.ResApplyListMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareApplyListMessage, UIMainChatPanel.ResApplyListMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionMagicCallBossMessage, UIMainChatPanel.ResMagicStoneMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResApplyTeamMessage, UIMainChatPanel.ResApplyTeamMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareApplyTeamMessage, UIMainChatPanel.ResApplyTeamMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResChatMessage, UIMainChatPanel.OnResChatMessage)
    --删除在线泡点
    --self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBubbleOnlineExpMessage, UIMainChatPanel.OnResBubbleOnlineExpMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBubbleOfflineExpMessage, UIMainChatPanel.OnResBubbleOfflineExpMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIMainChatPanel.OnResBagChangeMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInterruptSwornMessage, UIMainChatPanel.OnResInterruptSwornMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMainTaskPushMessage, UIMainChatPanel.OnResMainTaskPushMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTaskStrategyMessage, UIMainChatPanel.OnResTaskStrategyMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIMainChatPanel.onCommentMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionRedBagInfoMessage, UIMainChatPanel.ResUnionRedBagInfoMessageReceived)
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.ResChatMessage, UIMainChatPanel.OnResChatMessage)
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ShowItemTip, UIMainChatPanel.OnShowItemTip)
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIMainChatPanel.OnBagItemChanged)
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.AutoFightStateChange, UIMainChatPanel.AutoFightEvent);
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.AutoPathFindStateChanged, UIMainChatPanel.AutoFindEvent);
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_GatherBeadChange, UIMainChatPanel.CheckBeadsFlashState)
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIMainChatPanel.CheckBeadsFlashState)
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_CalendarActivityIsOpen, UIMainChatPanel.OnResCalendarActivityIsOpen);
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.UI_PlayAllScreenEffect, UIMainChatPanel.ShowScreenEffect);
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefreshMagicCircleActivity, UIMainChatPanel.HideMagicStoneTips);
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MagicCircleHintEnd, UIMainChatPanel.MagicCircleHintTimeEnd)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_SendClickUnionRedPackInfo, function(msgId, data)
        if self.Grild.RefreshAllPlayerList then
            self.Grild:RefreshAllPlayerList()
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshJuLingZhuPush, UIMainChatPanel.CheckBeadsFlashState)


    --UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, UIMainChatPanel.OnBagCoinsChanged)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RemoveBuyPushFlash, function()
        self:RemoveBuyPush()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AuctionRemovePush, function()
        self:RemoveShelfPush()
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.UI_ClickChatInfoBtn, UIMainChatPanel.OnChatInfoBtnCallBack)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_OpenSocialPanel, UIMainChatPanel.OnOpenSocialPanel)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.CloseMainChatPanel, UIMainChatPanel.CloseMainChatPanel)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Push_Task, UIMainChatPanel.Push_Task)

    UIMainChatPanel.InitExpBg()
    UIMainChatPanel.isBagItemHintCreated = false
    UIMainChatPanel.InitBreakStatu()
    UIMainChatPanel.CheckBeadsFlashState()
    UIMainChatPanel.originPos = UIMainChatPanel.flashTips_Widget.transform.localPosition
    UIMainChatPanel.CheckIsNeedUp()
    UIMainChatPanel.BindBatteryAndWifiStateMessage()
end

function UIMainChatPanel:Show()
    UIMainChatPanel.BesizerPointCen1X = UIMainChatPanel.GetBesizerPointcenter1_GameObject().transform.localPosition.x
    UIMainChatPanel.BesizerPointCen2X = UIMainChatPanel.GetBesizerPointcenter2_GameObject().transform.localPosition.x
    --UIMainChatPanel.UIOpenBG.width = UIMainChatPanel.UIOpenTogNum * UIMainChatPanel.UIOpenTogWidth
    UIMainChatPanel.mNewInfos = uiStaticParameter.mNewInfos
end
--endregion

function start()
    UIMainChatPanel.OnBagItemChanged()
end

function update()
    UIMainChatPanel.UpdateWifiState()
    UIMainChatPanel.UpdateBatteryState()
end

--region luaEvent

function UIMainChatPanel.OnOpenSocialPanel(msgId, customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.type == nil) then
        customData.type = LuaEnumSocialPanelType.SocialChatPanel;
    end
    if (customData.subCustomData == nil) then
        customData.subCustomData = {};
    end

    UIMainChatPanel.RefreshUIPanel(customData.type, true, customData.subCustomData, nil)
end

--endregion

--region Other

---在线泡点
function UIMainChatPanel.OnResBubbleOnlineExpMessage(uiEvtID, data, csdata)
    uimanager:CreatePanel("UIBubleOnLinePanel", nil, data)
end

---离线泡点
---@param data roleV2.BubbleOfflineExp
function UIMainChatPanel.OnResBubbleOfflineExpMessage(uiEvtID, data, csdata)
    if (data.exp ~= 0) then
        ---离线泡点闪烁提示
        local temp = {}
        temp.id = 3
        temp.panelPriority = data
        Utility.AddFlashPrompt(temp)
    end
end

function UIMainChatPanel.OnResBagChangeMessage(uiEvtID, data, csdata)
    ---回收后背包货币变化触发聚灵珠气泡状态更新
    if data ~= nil then
        if (data.action == 12001 or data.action == 13028 or data.action == 45002) then
            CS.CSScene.MainPlayerInfo.BagInfo:CheckEndRecoveryBeads();
            UIMainChatPanel.CheckBeadsFlashState(luaEnumGetBeadsJvLingZhuType.PRICE)
        end
        if data.action == 2093 then
            UIMainChatPanel.CheckBeadsFlashState()
        end
    end
end

--function UIMainChatPanel.OnBagCoinsChanged(uiEvtID, data, csdata)
--    CS.CSScene.MainPlayerInfo.BagInfo:CheckBeadsOfCoinChanged();
--    UIMainChatPanel.CheckBeadsFlashState(luaEnumGetBeadsJvLingZhuType.CoinsChange)
--end

function UIMainChatPanel.OffLineBubbleOnlineExpMessage(uiEvtID, data, csdata)
    if UIMainChatPanel.mOffLineBubleEffect == nil then
        UIMainChatPanel.RefreshEffect("700083", UIMainChatPanel.UIBubleEffectRoot.transform, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.one, UIMainChatPanel.BubbleOfflineEffectLoadCallback)
    else
        UIMainChatPanel.mOffLineBubleEffect:SetActive(true)
        UIMainChatPanel.BubbleOfflineEffectLoadCallback(
                nil, UIMainChatPanel.mOffLineBubleEffect)
    end
end

---收到消息响应
---@param csdata chatV2.ResChat
function UIMainChatPanel.OnResChatMessage(uiEvtID, data, csdata)
    if luaclass.ChatData:ShowChatData(csdata) == false then
        return
    end
    if uiStaticParameter.voiceMgr and csdata.sound then
        uiStaticParameter.voiceMgr:AddDownLoadList(csdata)
    else
        UIMainChatPanel.OriginEvent_SendChat(data, csdata)
    end

    if CS.StaticUtility.IsNull(UIMainChatPanel.Panel) == false then
        local chatPanelSize = UIMainChatPanel.Panel.finalClipRegion
        if chatPanelSize == nil or chatPanelSize.w < UIMainChatPanel.ChatClickMinSize.w then
            chatPanelSize = UIMainChatPanel.ChatClickMinSize
        end
        UIMainChatPanel.UIDragBox.center = CS.UnityEngine.Vector3(chatPanelSize.x, chatPanelSize.y, 0)
        UIMainChatPanel.UIDragBox.size = CS.UnityEngine.Vector3(chatPanelSize.z, chatPanelSize.w, 0)
    end
end

---原始消息聊天发送方法
function UIMainChatPanel.OriginEvent_SendChat(data, csdata)
    --处理道具屏蔽字问题
    if csdata == nil then
        return
    end
    csdata.message = CS.Utility_Lua.ReverseMessage(tostring(csdata.message))
    if UIMainChatPanel.ResChatDic[csdata.channel] == nil then
        UIMainChatPanel.ResChatDic[csdata.channel] = CS.System.Collections.Generic["List`1[chatV2.ResChat]"]()
    end
    ---私聊进行特殊处理，保存聊天记录到本地
    if (csdata.channel == 5) then
        UIMainChatPanel.mNewInfos = LuaEnumMainChatType.Friend
    end
    UIMainChatPanel.ResChatDic[csdata.channel]:Add(csdata)

    if UIMainChatPanel.GeneralChatList.Count >= uiStaticParameter.UIChatPanel_GenericMaxCount then
        UIMainChatPanel.GeneralChatList:RemoveAt(0)
    end
    if (uiStaticParameter.UIChatPanel_FiterIndexList[csdata.channel] == nil or uiStaticParameter.UIChatPanel_FiterIndexList[csdata.channel] == true) and UIMainChatPanel.Grild ~= nil and CS.StaticUtility.IsNull(UIMainChatPanel.Grild) == false then
        UIMainChatPanel.GeneralChatList:Add(csdata)
        UIMainChatPanel.Grild:AddMessage(csdata)
        UIMainChatPanel.Grild.transform.localPosition = UIMainChatPanel.Grild.transform.localPosition + CS.UnityEngine.Vector3(-7, 0, 0)
        UIMainChatPanel.CheckIsNeedUp()
    end

    if (uiStaticParameter.UIChatPanel_SelectIndex == 0 or uiStaticParameter.UIChatPanel_SelectIndex == csdata.channel) then
        local chatPanel = uimanager:GetPanel("UIChatPanel")
        if chatPanel ~= nil then
            chatPanel:AddMessage(csdata)
        end
    end
end

function UIMainChatPanel.OnShowItemTip(uiEvtID, data)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = data, showRight = false })
end

function UIMainChatPanel:RefreshInOut()
    if UIMainChatPanel.outInfo.gameObject.activeSelf == true then
        UIMainChatPanel:RefreshUIChatGrid(UIMainChatPanel.outGrid, UIMainChatPanel.outGridDic, 3)
    else
        UIMainChatPanel:RefreshUIChatGrid(UIMainChatPanel.inGrid, UIMainChatPanel.inGridDic, 50)
    end

end

function UIMainChatPanel:RefreshUIChatGrid(grid, dic, totalCount)
    --local count = math.min(3,UIMainChatPanel.ResChatList.Count)
    for i = 0, totalCount - 1 do
        local go = grid.controlList[totalCount - 1 - i]
        if dic[go] == nil then
            dic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIChatItem)
            dic[go]:Init()
        end
        if i < UIMainChatPanel.ResChatDic.Count then
            dic[go]:RefreshUI(UIMainChatPanel.ResChatDic[UIMainChatPanel.ResChatDic.Count - 1 - i])
        else
            dic[go]:RefreshUI(nil)
        end

    end
end

function UIMainChatPanel.onResNewMailMessage(info, data)
    if (data.type == 1) then
        UIMainChatPanel.mNewInfos = LuaEnumMainChatType.Mail
    else
        UIMainChatPanel.mNewInfos = LuaEnumMainChatType.Friend
    end
end

function UIMainChatPanel.onResCallBackMessage(info, data)
    if (data.isSuccess) then
        if (data.type == 1) then
            --1队伍2帮会
            Utility.RemoveFlashPrompt(1, 4)
        elseif (data.type == 2) then
            Utility.RemoveFlashPrompt(1, 5)
        elseif (data.type == 3) then
            Utility.RemoveFlashPrompt(1, 12)
        end
    end
end

---适配经验条
function UIMainChatPanel.InitExpBg()
    local spriteBG = CS.Utility_Lua.GetComponent(UIMainChatPanel.exp.transform, 'Top_UISprite')
    local slider = CS.Utility_Lua.GetComponent(UIMainChatPanel.exp.transform:Find('Slider'), 'Top_UISprite')
    spriteBG.width = CS.CSGame.Sington.ContentSize.x
    slider.width = CS.CSGame.Sington.ContentSize.x
end

--endregion

--region 组队
function UIMainChatPanel.ResApplyTeamMessage(msgId, tblData, csData)
    if tblData then
        if tblData.type then
            local TeamRequestType = tblData.type
            if TeamRequestType == 2 then
                ---邀请玩家加入队伍↑
                if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                    networkRequest.ReqShareInvitationList()
                else
                    networkRequest.ReqInvitationList()
                end
            elseif TeamRequestType == 1 or TeamRequestType == 3 then
                ---队伍收到请求↑
                if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                    networkRequest.ReqShareApplyList()
                else
                    networkRequest.ReqApplyList()
                end
            end
        end
        if tblData.endTime then
            UIMainChatPanel.TeamOutTime = tblData.endTime
        end
    end
end

---队长收到申请信息列表 8
---@param tblData.players groupV2.ApplyList 申请列表信息
function UIMainChatPanel.ResApplyListMessage(MsgId, tblData, csData)
    if tblData then
        if (tblData.players and #tblData.players > 0) or (tblData.twoAgree and #tblData.twoAgree > 0) then
            local temp = {}
            temp.id = 8
            temp.clickCallBack = function()
                --Utility.RemoveFlashPrompt(1, 8)
            end
            Utility.AddFlashPrompt(temp)
            UIMainChatPanel.mInviteInfo = tblData.players
        else
            Utility.RemoveFlashPrompt(1, 8)
        end
    end
    UIMainChatPanel.IsTeamApply = true
end

---玩家收到组队邀请 7
---@param tblData.players groupV2.InvitationPlayerInfo 邀请信息
function UIMainChatPanel.ResInvitationMonitor(MsgId, tblData, csData)
    if tblData then
        if tblData.players and #tblData.players > 0 then
            --UIMainChatPanel.btn_team.gameObject:SetActive(true)
            local temp = {}
            temp.id = 7
            temp.clickCallBack = function()
                UIMainChatPanel:OpenTipPanel();
                --Utility.RemoveFlashPrompt(1, 7)
            end
            Utility.AddFlashPrompt(temp)
            UIMainChatPanel.mInviteInfo = tblData.players
        else
            Utility.RemoveFlashPrompt(1, 7)
            --UIMainChatPanel.btn_team.gameObject:SetActive(false)
            UIMainChatPanel.mInviteInfo = nil
        end
    end
    UIMainChatPanel.IsTeamApply = false
end

---组队请求
function UIMainChatPanel.TeamReq()
    if UIMainChatPanel.IsTeamApply then
        UIMainChatPanel.RefreshUIPanel(LuaEnumSocialPanelType.TeamPanel, true, UIMainChatPanel.OpenUITeamCallBack)
    else
        UIMainChatPanel:OpenTipPanel()
    end
end

---打开组队面板回调
function UIMainChatPanel.OpenUITeamCallBack(uipanel)
    UIMainChatPanel.btn_team.gameObject:SetActive(false)
    if UIMainChatPanel.IsTeamApply then
        uipanel:EquestTeam()
    else
        uipanel:OpenTipPanel()
    end
end

---打开组队提示面板
function UIMainChatPanel:OpenTipPanel()
    if UIMainChatPanel.mInviteInfo and #UIMainChatPanel.mInviteInfo > 0 then
        local data = UIMainChatPanel.mInviteInfo[#UIMainChatPanel.mInviteInfo]
        if (data ~= nil) then
            local isFind, wordInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(98)
            if not isFind then
                if isOpenLog then
                    luaDebug.Log("PromptWord表中未找到id为98的数据")
                end
                return
            end
            local AdjustInfo = {
                Title = wordInfo.title,
                Content = string.format(wordInfo.des, data.playerName),
                IsShowCloseBtn = true,
                LeftDescription = wordInfo.leftButton,
                RightDescription = wordInfo.rightButton,
                ID = 98,
                CallBack = function()
                    --networkRequest.ReqJoinGroup(data.groupId, 2)
                    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                        networkRequest.ReqShareAcceptInvitation(1, data.groupId, data.targetId)
                    else
                        networkRequest.ReqAcceptInvitation(1, data.groupId, data.targetId)
                    end
                    if UIMainChatPanel.TeamOutTime and UIMainChatPanel.TeamOutTime ~= 0 then
                        local outTime = CS.CSServerTime.StampToDateTimeForSecond(UIMainChatPanel.TeamOutTime)
                        local desTime = CS.CSServerTime.Now - outTime
                        if desTime.Hours * 60 * 60 + desTime.Minutes * 60 + desTime.Seconds > 0 then
                            UIMainChatPanel.btn_team.gameObject:SetActive(false)
                        end
                    end
                    Utility.RemoveFlashPrompt(1, 8)
                    Utility.RemoveFlashPrompt(1, 7)
                end,
                CancelCallBack = function()
                    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                        networkRequest.ReqShareAcceptInvitation(2, data.groupId, data.targetId)
                    else
                        networkRequest.ReqAcceptInvitation(2, data.groupId, data.targetId)
                    end
                    UIMainChatPanel.btn_team.gameObject:SetActive(false)
                    Utility.RemoveFlashPrompt(1, 8)
                    Utility.RemoveFlashPrompt(1, 7)
                end
            }
            uimanager:CreatePanel("UIPromptPanel", nil, AdjustInfo)

        end
    end
end
--endregion

--region 魔法神石
function UIMainChatPanel.ResMagicStoneMessage(MsgId, tblData, csData)
    if (CS.Cfg_GlobalTableManager.Instance:IsHideMagicStoneTips(CS.CSScene.MainPlayerInfo.MapID)) then
        return
    else
        local level = CS.CSScene.MainPlayerInfo.Level
        if CS.Cfg_GlobalTableManager.Instance:CanEnterMagicCircleLevel(level) and level <= CS.Cfg_GlobalTableManager.Instance.MagicCircleHintLevel then
            local temp = {}
            temp.id = 26
            temp.clickCallBack = function()
                if (CS.CSScene.MainPlayerInfo.MagicCircleInfo.HaveMonster) then
                    local tem = {}
                    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(88)
                    if isFind then
                        tem.Content = info.des
                        if (CS.CSScene.MainPlayerInfo.MagicCircleInfo.MonsterInfo ~= nil) then
                            tem.Content = CS.Utility_Lua.StringReplace(tem.Content, "{0}", CS.CSScene.MainPlayerInfo.MagicCircleInfo.MonsterInfo.name)
                        end
                    end
                    tem.LeftDescription = info.leftButton
                    tem.RightDescription = info.rightButton
                    tem.IsShowCloseBtn = true
                    tem.IsShowGoldLabel = true
                    tem.ID = 88
                    tem.Time = CS.CSScene.MainPlayerInfo.MagicCircleInfo.MonsterHintRemainTime
                    if tem.Time <= 0 then
                        Utility.RemoveFlashPrompt(1, 26)
                    end
                    tem.TimeType = LuaEnumSecondComfirmTimeType.MinuteAndSecond
                    tem.TimeText = CS.Cfg_GlobalTableManager.Instance:GetMagicCircleHintTimeFormat()
                    tem.TimeEndCallBack = function()
                        uimanager:ClosePanel("UIPromptPanel")
                    end
                    tem.CloseCallBack = function(panel)
                        --Utility.RemoveFlashPrompt(1, 26)
                    end
                    tem.CancelCallBack = function(panel)
                        Utility.RemoveFlashPrompt(1, 26)
                    end
                    tem.CallBack = function(panel)
                        networkRequest.ReqEnterDuplicate(6001)
                        Utility.RemoveFlashPrompt(1, 26)
                    end
                    uimanager:CreatePanel("UIPromptPanel", nil, tem)
                else
                    Utility.RemoveFlashPrompt(1, 26)
                end
            end
            Utility.AddFlashPrompt(temp)
        end
    end

end

function UIMainChatPanel.HideMagicStoneTips()
    if (CS.CSScene.MainPlayerInfo.MagicCircleInfo.HaveMonster == false) then
        Utility.RemoveFlashPrompt(1, 26)
    end
end

function UIMainChatPanel:MagicCircleHintTimeEnd()
    if CS.CSScene.MainPlayerInfo.MagicCircleInfo.MonsterHintRemainTime <= 0 then
        Utility.RemoveFlashPrompt(1, 26)
    end
end
--endregion

--region UI事件
function UIMainChatPanel.HideMainChatPanel()
    UIMainChatPanel.btn_bag:SetActive(false)
    UIMainChatPanel.btn_social:SetActive(false)
    UIMainChatPanel.GrildWidget.alpha = 0.01
end

function UIMainChatPanel.ChatBtnOnClick()
    uimanager:CreatePanel("UIChatPanel", function()
        UIMainChatPanel.HideMainChatPanel()
    end)
end

function UIMainChatPanel.OnSocialButtonClicked()
    UIMainChatPanel.socialRedPoint:RemoveRedPointKey(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
    UIMainChatPanel.socialRedPoint:AddRedPointKey(CS.RedPointKey.MAIL_MailsToBeRead)
    if (UIMainChatPanel.SocialBtnCanClick) then
        UIMainChatPanel.UIOpenIsShow()
        UIMainChatPanel.SocialBtnCanClick = false
        if (UIMainChatPanel.NewMailShowEffect ~= nil and UIMainChatPanel.NewMailShowEffect ~= 0) then
            UIMainChatPanel.NewMailShowEffect.gameObject:SetActive(false)
        end
        --有红点的情况下,社交->队伍->邮件
        --1为邮件2为队伍3为社交
        --等待都有红点的情况下再做处理
        if (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.SocialChat) or CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FriendApply) or CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FRIEND_CIRCLEOFFRIENDS)) then
            UIMainChatPanel.ChatBtnonClick()
            return
        elseif (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.Team_Main)) then
            UIMainChatPanel.OpenUITeamPanel()
            return
        elseif (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.MAIL_MailsToBeRead) or CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)) then
            UIMainChatPanel.MailBtnonClick()
            return
        elseif (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.UNION_ALL)) then
            UIMainChatPanel:OnGuildBtnClicked()
            return
        else
            UIMainChatPanel.BtnChatBtnonClick()
            return
        end
    else
        UIMainChatPanel.SocialBtnCanClick = true
        UIMainChatPanel.CloseAllPanel()
    end
end

function UIMainChatPanel.ShowSocialTipsIcon(str)
    if (str ~= nil) then
        UIMainChatPanel.showIcon_SpriteAnimation.namePrefix = str
    end
end
---得到聊天栏默认打开优先级
---红点:100
---最后收到消息:10
---即当同时有红点的情况下,最后收到消息的优先打开(最后收到的消息没有打开即使有红点,所有消息阅读后,红点消失,同时最后收到的优先级重置)
function UIMainChatPanel:GetDefaultOpenPriority()

end

function UIMainChatPanel:TweenBag(uiOpenActiveSelf)
    if uiOpenActiveSelf then
        UIMainChatPanel.btn_bag_tweenPosition:PlayReverse()
        UIMainChatPanel.btn_bag_tweenAlpha:PlayReverse()
    else
        UIMainChatPanel.btn_bag_tweenPosition:PlayForward()
        UIMainChatPanel.btn_bag_tweenAlpha:PlayForward()
    end
end

function UIMainChatPanel.NewFriendFun()
    UIMainChatPanel.ChatBtnonClick()
    yield_return(0.1)
    local panel = uimanager:GetPanel("UISocialContactPanel")
    if (panel ~= nil) then
        panel.AddFriendBtnOnClick()
    end
end

function UIMainChatPanel.OnBagButtonClicked()
    if luaEventManager.HasCallback(LuaCEvent.MainChatPanel_BtnBag) then
        luaEventManager.DoCallback(LuaCEvent.MainChatPanel_BtnBag)
    else
        if CS.CSMissionManager.Instance:IsCompletedAssignMainTask(Utility.GetOpenBagPanelShowRecycleBtnTaskId()) then
            --uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.Normal)
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Bag_Base);
        else
            uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.UnFinishFirstMission)
        end
        uimanager:ClosePanel("UIDailyMissionAwardPanel")
    end
    --先暂时用这个字段判定是否开启GM
    if (CS.SDKManager.PlatformData.IsOpenTranslate or CS.Constant.IsWhiteIp) then
        --GM命令
        if (UIMainChatPanel.GMCount == 0) then
            local co = coroutine.create(UIMainChatPanel.ResetGMCount)
            coroutine.resume(co)
        end
        UIMainChatPanel.GMCount = UIMainChatPanel.GMCount + 1
        if (UIMainChatPanel.GMCount == 3) then
            uimanager:CreatePanel("UIGMToolPanel")
            return
        end
    end
end

function UIMainChatPanel.MailBtnonClick()
    UIMainChatPanel.mailRedPoint:RemoveRedPointKey(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
    UIMainChatPanel.mailRedPoint:AddRedPointKey(CS.RedPointKey.MAIL_MailsToBeRead)

    UIMainChatPanel.RefreshUIPanel(LuaEnumSocialPanelType.MailPanel, true, nil)
end

function UIMainChatPanel.ChatBtnonClick()
    UIMainChatPanel.RefreshUIPanel(LuaEnumSocialPanelType.SocialChatPanel, true, nil)
end

function UIMainChatPanel.BtnChatBtnonClick()
    uiStaticParameter.PrivateChatID = 0
    UIMainChatPanel.RefreshUIPanel(LuaEnumSocialPanelType.SocialChatPanel, true, nil)
end

---打开组队面板
function UIMainChatPanel.OpenUITeamPanel()
    UIMainChatPanel.RefreshUIPanel(LuaEnumSocialPanelType.TeamPanel, true, nil)
end

function UIMainChatPanel.CloseAllPanel()
    if (UIMainChatPanel.mCurChoosePanel ~= nil) then
        if (UIMainChatPanel.mCurChoosePanel == LuaEnumSocialPanelType.MailPanel) then
            uimanager:ClosePanel("UIMailPanel")
        elseif (UIMainChatPanel.mCurChoosePanel == LuaEnumSocialPanelType.SocialChatPanel) then
            uimanager:ClosePanel("UISocialContactPanel")
        elseif (UIMainChatPanel.mCurChoosePanel == LuaEnumSocialPanelType.TeamPanel) then
            uimanager:ClosePanel("UITeamPanel")
        elseif (UIMainChatPanel.mCurChoosePanel == LuaEnumSocialPanelType.GuildPanel) then
            uimanager:ClosePanel("UIGuildPanel")
        end
        UIMainChatPanel.UIOpenIsHide()
    end
end

---打开帮会面板
function UIMainChatPanel:OnGuildBtnClicked(go)
    --帮会等级限制
    --if self:GetPlayerInfo() then
    --    local level = self:GetPlayerInfo().Level
    --    local limitLevel = self:GetOpenUnionLimit()
    --    if level and limitLevel then
    --        if level < limitLevel then
    --            local des = self:GetOpenPanelLevelNotEnoughDes()
    --            if des then
    --                Utility.ShowPopoTips(go, des, 28)
    --            end
    --        else
    --            local hasGuild = self:GetUnionInfo().UnionID ~= 0
    --            if hasGuild then
    --                self.RefreshUIPanel(LuaEnumSocialPanelType.GuildPanel, true, nil)
    --            else
    --                Utility.ShowPopoTips(go, nil, 235)
    --            end
    --        end
    --    end
    --end

    self.RefreshUIPanel(LuaEnumSocialPanelType.GuildPanel, true, nil)
end

function UIMainChatPanel:TryOpenGuild(isShowTips, go)
    if (go == nil) then
        go = self:GetGuildBtn_GameObject();
    end

    if self:GetPlayerInfo() then
        local level = self:GetPlayerInfo().Level
        local limitLevel = self:GetOpenUnionLimit()
        if level and limitLevel then
            if level < limitLevel then
                local des = self:GetOpenPanelLevelNotEnoughDes()
                if des then
                    if (isShowTips) then
                        Utility.ShowPopoTips(go, des, 235)
                    end
                    return false
                end
            else
                local hasGuild = self:GetUnionInfo().UnionID ~= 0
                if hasGuild then
                    --self.RefreshUIPanel(LuaEnumSocialPanelType.GuildPanel, true, nil)
                    return true;
                else
                    if (isShowTips) then
                        --Utility.ShowPopoTips(go, nil, 235)
                    end
                    uimanager:ClosePanel(self.mCurShowPanelName)
                    luaEventManager.DoCallback(LuaCEvent.CloseMainChatPanel)
                    --二次确认弹窗
                    local isFind, showInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(74)
                    if isFind then
                        local data = {
                            Title = showInfo.title == nil and '' or showInfo.title,
                            Content = showInfo.des,
                            ID = 74,
                            CenterDescription = showInfo.leftButton,
                            CallBack = function()
                                Utility.TryTransfer(2005)
                                --寻路行会管理员
                                --  CS.CSScene.MainPlayerInfo.AsyncOperationController.UnionFindNPC:DoOperation({ 333 }, "UIUnionManagerPanel")
                            end
                        }
                        uimanager:CreatePanel("UIPromptPanel", nil, data)
                    end
                    return false
                end
            end
        end
    end
    return false;
end

--endregion

--region 打开排行榜界面

--endregion

--region 滿背包的提示相关
function UIMainChatPanel.OnBagItemChanged()
    UIMainChatPanel:RefreshEmptySlotCount()
end

---刷新空格数量
function UIMainChatPanel.RefreshEmptySlotCount()
    if CS.CSScene.MainPlayerInfo then
        local count = CS.CSScene.MainPlayerInfo.BagInfo.EmptyGridCount
        if count <= CS.Cfg_GlobalTableManager.Instance:GetRecycleHintEmptySlotCount() then
            UIMainChatPanel.emptyGridCount.text = count == 0 and "满" or tostring(count)
        else
            UIMainChatPanel.emptyGridCount.text = ""
        end
    end
end

---获取文本提示位置
function UIMainChatPanel.GetDialogTipsPos()
    return UIMainChatPanel.btn_bag.transform.position;
end
--endregion

--region 面板刷新
function UIMainChatPanel.UIOpenIsShow()
    UIMainChatPanel.Panel.gameObject:SetActive(false)
    UIMainChatPanel.UIOpen:SetActive(true)
    UIMainChatPanel.btn_bag:SetActive(false)
    --UIMainChatPanel.btn_socialBG.enabled = false
    --UIMainChatPanel.btn_socialIcon.spriteName = "friend1"
    UIMainChatPanel:TweenBag(true)
    UIMainChatPanel.socialRedPoint.isEnabled = false
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
end

function UIMainChatPanel.UIOpenIsHide()
    if (UIMainChatPanel.Panel ~= nil) then
        UIMainChatPanel.Panel.gameObject:SetActive(true)
    end
    UIMainChatPanel.UIOpen:SetActive(false)
    UIMainChatPanel.btn_bag:SetActive(true)
    --UIMainChatPanel.btn_socialIcon.spriteName = "friend"
    --UIMainChatPanel.btn_socialBG.enabled = true
    UIMainChatPanel.socialRedPoint.isEnabled = true
    UIMainChatPanel:TweenBag(false)
    if (CS.CSUIRedPointManager.GetInstance() ~= nil) then
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SocialChat)
    end
    UIMainChatPanel.mCurChoosePanel = nil
end

function UIMainChatPanel:TweenBag(uiOpenActiveSelf)
    if uiOpenActiveSelf then
        UIMainChatPanel.btn_bag_tweenPosition:PlayReverse()
        UIMainChatPanel.btn_bag_tweenAlpha:PlayReverse()
    else
        UIMainChatPanel.btn_bag_tweenPosition:PlayForward()
        UIMainChatPanel.btn_bag_tweenAlpha:PlayForward()
    end
end

function UIMainChatPanel.RefreshUIPanel(panelType, active, customData, callback)
    --暂时主界面屏蔽小红点
    if (panelType == UIMainChatPanel.mCurChoosePanel) then
        local curPanel = uimanager:GetPanel(UIMainChatPanel.mCurShowPanelName);
        if (curPanel ~= nil and not CS.StaticUtility.IsNull(curPanel.go) and panelType ~= LuaEnumSocialPanelType.GuildPanel) then
            curPanel:Show(customData);
        end
        return
    end
    ---region 验证
    if (panelType == LuaEnumSocialPanelType.GuildPanel) then
        if (not UIMainChatPanel:TryOpenGuild(true, UIMainChatPanel:GetGuildBtn_GameObject())) then
            --UIMainChatPanel.RefreshUIPanel(LuaEnumSocialPanelType.MailPanel);
            return false;
        end
    end
    --endregion

    if (CS.System.String.IsNullOrEmpty(UIMainChatPanel.mCurShowPanelName) == false) then
        local curPanel = uimanager:GetPanel(UIMainChatPanel.mCurShowPanelName);
        if (curPanel ~= nil) then
            UIMainChatPanel.InnerClosePanel = true;
            uimanager:ClosePanel(UIMainChatPanel.mCurShowPanelName)
        else
            UIMainChatPanel.InnerClosePanel = false;
        end
    end
    if (panelType == LuaEnumSocialPanelType.MailPanel) then
        uimanager:CreatePanel("UIMailPanel", function(panel)
            if (callback ~= nil) then
                callback();
            end
            luaEventManager.DoCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, "UIMailPanel");
        end, customData);
        UIMainChatPanel.mCurShowPanelName = "UIMailPanel"
    elseif (panelType == LuaEnumSocialPanelType.SocialChatPanel) then
        uimanager:CreatePanel("UISocialContactPanel", function(panel)
            if (callback ~= nil) then
                callback();
            end
            luaEventManager.DoCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, "UISocialContactPanel");
        end, customData);
        UIMainChatPanel.mCurShowPanelName = "UISocialContactPanel"
    elseif (panelType == LuaEnumSocialPanelType.TeamPanel) then
        uimanager:CreatePanel("UITeamPanel", function(panel)
            if (callback ~= nil) then
                callback();
            end
            luaEventManager.DoCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, "UITeamPanel");
        end, customData);
        UIMainChatPanel.mCurShowPanelName = "UITeamPanel"
    elseif (panelType == LuaEnumSocialPanelType.GuildPanel) then
        local guildPanel = uimanager:GetPanel("UIGuildPanel")
        if guildPanel == nil then
            uimanager:CreatePanel("UIGuildPanel", function(panel)
                if (callback ~= nil) then
                    callback();
                end
                luaEventManager.DoCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, "UIGuildPanel");
            end, customData)
        else
            luaEventManager.DoCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, "UIGuildPanel");
        end
        UIMainChatPanel.mCurShowPanelName = "UIGuildPanel"
        UIMainChatPanel.mCurChoosePanel = panelType
    end
    UIMainChatPanel:RefreshIcon(panelType)
end

---刷新页签图标
function UIMainChatPanel:RefreshIcon(panelType)
    local isMail = panelType == LuaEnumSocialPanelType.MailPanel
    self.btn_mailBG.spriteName = ternary(isMail, self.SpriteChooseName[LuaEnumSocialPanelType.MailPanel], self.SpriteNotChooseName[LuaEnumSocialPanelType.MailPanel])
    self:GetMailCheck_GameObject():SetActive(isMail)

    local isSocial = panelType == LuaEnumSocialPanelType.SocialChatPanel
    self:GetChatCheck_GameObject():SetActive(isSocial)
    self.btn_chatBG.spriteName = ternary(isSocial, self.SpriteChooseName[LuaEnumSocialPanelType.SocialChatPanel], self.SpriteNotChooseName[LuaEnumSocialPanelType.SocialChatPanel])

    local isTeam = panelType == LuaEnumSocialPanelType.TeamPanel
    self:GetTeamCheck_GameObject():SetActive(isTeam)
    self.btn_teamPanelBG.spriteName = ternary(isTeam, self.SpriteChooseName[LuaEnumSocialPanelType.TeamPanel], self.SpriteNotChooseName[LuaEnumSocialPanelType.TeamPanel])

    local isGuild = panelType == LuaEnumSocialPanelType.GuildPanel
    self:GetGuildCheck_GameObject():SetActive(isGuild)
    self:GetGuildBg_UISprite().spriteName = ternary(isGuild, self.SpriteChooseName[LuaEnumSocialPanelType.GuildPanel], self.SpriteNotChooseName[LuaEnumSocialPanelType.GuildPanel])
end

function UIMainChatPanel.ResetGMCount()
    yield_return(CS.NGUIAssist.GetWaitForSeconds(1))
    UIMainChatPanel.GMCount = 0
end

--region 刷新聚灵珠提示

--用于获取所有需要提示的infolist
function UIMainChatPanel.GetNeedShowInfoList()

end

function UIMainChatPanel.RefreshPromptItems()

end

--endregion

--region 离线泡点
function UIMainChatPanel.BubbleOfflineEffectLoadCallback(path, res)
    if (res ~= nil) then
        UIMainChatPanel.mOffLineBubleEffect = res
        local draw = CS.Utility_Lua.GetComponent(UIMainChatPanel.mOffLineBubleEffect, "DrawBesizerLine")
        if (draw == nil) then
            draw = UIMainChatPanel.mOffLineBubleEffect:AddComponent(typeof(CS.DrawBesizerLine))
        end
        draw = CS.Utility_Lua.SetBasePointCount(draw, 4)
        CS.Utility_Lua.SetBasePoint(draw, 0, UIMainChatPanel.UIBubleEffectRoot)
        CS.Utility_Lua.SetBasePoint(draw, 1, UIMainChatPanel.GetBesizerPointcenter1_GameObject())
        CS.Utility_Lua.SetBasePoint(draw, 2, UIMainChatPanel.GetBesizerPointcenter2_GameObject())
        CS.Utility_Lua.SetBasePoint(draw, 3, UIMainChatPanel.UIExpSliderEndPoint)
        --draw.BasePoint[0] = UIMainChatPanel.UIBubleEffectRoot
        --draw.BasePoint[1] = UIMainChatPanel.GetBesizerPointcenter1_GameObject()
        --draw.BasePoint[2] = UIMainChatPanel.GetBesizerPointcenter2_GameObject()
        --draw.BasePoint[3] = UIMainChatPanel.UIExpSliderEndPoint
        draw.IsInit = true
        draw.IsWorldPosition = true
        draw.CallBack = function()
            UIMainChatPanel.mOffLineBubleEffect:SetActive(false)
        end
        --draw.CallBack = UIMainChatPanel.BubbleOfflineEffectPlayCallback
    end
end

function UIMainChatPanel.BubbleOfflineEffectPlayCallback(go)
    UIMainChatPanel.mOffLineBubleEffectCount = UIMainChatPanel.mOffLineBubleEffectCount + 1
    if (UIMainChatPanel.mOffLineBubleEffectCount == 1) then
        go.BasePoint[1] = UIMainChatPanel.GetOffLinePointCenter_GameObject()
        go.IsInit = true
    elseif (UIMainChatPanel.mOffLineBubleEffectCount == 2) then
        go.BasePoint[1] = UIMainChatPanel.GetOffLinePointRight_GameObject()
        go.IsInit = true
    else
        UIMainChatPanel.mOffLineBubleEffectCount = 0
        CS.UnityEngine.GameObject.Destroy(go.gameObject)
    end
end
--endregion
--endregion

--region 加载特效
function UIMainChatPanel.RefreshEffect(effectName, parent, localPosition, localScale, callBack)
    local bagBtnEffectCallback = function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            if parent == nil or CS.StaticUtility.IsNull(parent) then
                return
            end
            res:ReleaseCallBack()
            local obj = res:GetObjInst()
            obj.transform.parent = parent
            obj.transform.localPosition = localPosition
            obj.transform.localScale = localScale
            if callBack ~= nil then
                callBack(res.Path, obj)
            end
        end
    end
    local csRes = CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.UI)
    if csRes.IsDone then
        bagBtnEffectCallback(csRes)
    else
        csRes.onLoaded:AddFrontCallBack(bagBtnEffectCallback)
    end
end
--endregion

--region 聚灵珠闪烁提示

--记录上个聚灵珠id
UIMainChatPanel.curJLZID = 0
function UIMainChatPanel.CheckBeadsFlashState(type)
    local curType = ternary(type == nil, 0, type)
    ---聚灵珠满经验闪烁提示
    if CS.CSScene.MainPlayerInfo then
        local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBeadsJuLingZhuInfo(curType)
        if itemInfo then
            local temp = {}
            temp.id = 1
            temp.icon = itemInfo.id
            temp.effectPlayInfo = { info = itemInfo }
            if UIMainChatPanel.curJLZID ~= itemInfo.id then
                UIMainChatPanel.curJLZID = itemInfo.id
                Utility.RemoveFlashPrompt(1, 1)
            end
            temp.clickCallBack = function()
                Utility.TryOpenJLZPanel({ info = itemInfo })
            end
            Utility.AddFlashPrompt(temp)
            uiStaticParameter.UpdataCheckJuLingZhuPush = false
            return
        end
        Utility.RemoveFlashPrompt(1, 1)
        uiStaticParameter.UpdataCheckJuLingZhuPush = true
        uiStaticParameter.LastCheckJuLingZhuTime = CS.UnityEngine.Time.time
    end
end

--endregion

--region 闪烁提示

function UIMainChatPanel.InitFlash()
    UIMainChatPanel.flashTipsTemplate = templatemanager.GetNewTemplate(UIMainChatPanel.flashTips_Widget, luaComponentTemplates.UIFlashTipsViewTemplate)
end

--聊天最低高度
UIMainChatPanel.minHight = 130
UIMainChatPanel.originPos = CS.UnityEngine.Vector3.zero

UIMainChatPanel.IenumSetPos = nil

function UIMainChatPanel.CheckIsNeedUp()
    if UIMainChatPanel.IenumSetPos == nil then
        StopCoroutine(UIMainChatPanel.IenumSetPos)
    end
    UIMainChatPanel.IenumSetPos = StartCoroutine(UIMainChatPanel.IEnumSetPos)
end

--自适应位置
function UIMainChatPanel.IEnumSetPos()
    coroutine.yield(0)
    local hight = UIMainChatPanel.Grild.GetHigh
    if UIMainChatPanel.flashTips_Widget ~= nil then
        UIMainChatPanel.flashTips_Widget.enabled = hight >= UIMainChatPanel.minHight
        if hight < UIMainChatPanel.minHight then
            UIMainChatPanel.flashTips_Widget.transform.localPosition = UIMainChatPanel.originPos
        end
    end
    coroutine.yield(CS.NGUIAssist.waitForEndOfFrame)
    if luaEventManager.HasCallback(LuaCEvent.MainChatPanel_UpAdaptive) then
        local messagepos = UIMainChatPanel.flashTips_Widget.transform.position
        luaEventManager.DoCallback(LuaCEvent.MainChatPanel_UpAdaptive, { isUp = hight >= UIMainChatPanel.minHight, pos = messagepos })
    end
end

--endregion

--region 聚灵珠特效

--聚灵珠特效父物体
function UIMainChatPanel.GetjlzParent_GameObject()
    if (UIMainChatPanel.mjlzParent == nil) then
        local panel = uimanager:GetPanel('UIAllTextTipsContainerPanel')
        if panel then
            UIMainChatPanel.mjlzParent = panel:GetCurComp("EffectRoot", "GameObject")
        end

    end
    return UIMainChatPanel.mjlzParent
end

UIMainChatPanel.posTween = nil
UIMainChatPanel.jlzEffect = nil
UIMainChatPanel.jlzEffect_Path = ''
UIMainChatPanel.finishCallBack = nil
UIMainChatPanel.IenumShowjlzEffect = nil
UIMainChatPanel.IenumWaitShow = nil

function UIMainChatPanel.GetJLZEffectStartPos()
    --if UIMainChatPanel.jlzeffectPos == nil then
    ---@type UIJuLingZhuPanel
    local panel = uimanager:GetPanel('UIJuLingZhuPanel')
    if panel then
        UIMainChatPanel.jlzeffectPos = UIMainChatPanel.GetjlzParent_GameObject().transform:InverseTransformPoint(panel.icon.transform.position)
    else
        UIMainChatPanel.jlzeffectPos = CS.UnityEngine.Vector3(3, 64, 0)
    end
    --end
    return UIMainChatPanel.jlzeffectPos
end

function UIMainChatPanel.ShowJLZEffect(callback)
    if callback then
        UIMainChatPanel.finishCallBack = callback
    end
    if UIMainChatPanel.jlzEffect == nil then
        UIMainChatPanel.RefreshEffect("700021", UIMainChatPanel.GetjlzParent_GameObject().transform, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.one, function(path, obj)
            UIMainChatPanel.jlzEffect = obj
            UIMainChatPanel.jlzEffect_Path = path
            UIMainChatPanel.jlzEffect.transform.localPosition = UIMainChatPanel.GetJLZEffectStartPos()
        end)
        return
    end
    UIMainChatPanel.jlzEffect.transform.localPosition = UIMainChatPanel.GetJLZEffectStartPos()
    UIMainChatPanel.jlzEffect.gameObject:SetActive(false)
    UIMainChatPanel.jlzEffect.gameObject:SetActive(true)
end

function UIMainChatPanel.IEnumShowJLZEffect()
    UIMainChatPanel.jlzEffect.gameObject:SetActive(true)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    UIMainChatPanel.posTween.enabled = true
    UIMainChatPanel.posTween:PlayTween()
end

---获得当前进度的位置
function UIMainChatPanel.GetCurExpAmountPos()
    local curLevel = CS.CSScene.MainPlayerInfo.Level
    local curMaxExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(curLevel)
    local curExp = CS.CSScene.MainPlayerInfo.Exp
    --当前进度
    local curAmount = curExp / curMaxExp
    curAmount = Utility.GetPreciseDecimal(curAmount, 3)
    --获取特效终点x
    local posX = -(CS.CSGame.Sington.ContentSize.x / 2) + (CS.CSGame.Sington.ContentSize.x * curAmount)
    --获取特效终点y
    local expPos = UIMainChatPanel.exp.transform.position
    expPos = UIMainChatPanel.GetjlzParent_GameObject().transform:InverseTransformPoint(expPos)
    return CS.UnityEngine.Vector3(posX, expPos.y, 0)
end

---聚灵珠达到指定位置回调
function UIMainChatPanel.ShowEffectFinishCallBack()
    UIMainChatPanel.jlzEffect.gameObject:SetActive(false)
    UIMainChatPanel.posTween.enabled = false
    if UIMainChatPanel.finishCallBack ~= nil then
        UIMainChatPanel.finishCallBack()
    end
    UIMainChatPanel.finishCallBack = nil
end

---中断特效并发送回调
---@param callback function  下次回调
function UIMainChatPanel.BreakEffectFinish(callback)
    UIMainChatPanel.ShowEffectFinishCallBack()
    if UIMainChatPanel.IenumShowjlzEffect ~= nil then
        StopCoroutine(UIMainChatPanel.IenumShowjlzEffect)
        UIMainChatPanel.IenumShowjlzEffect = nil
    end
    if callback then
        UIMainChatPanel.finishCallBack = callback
        -- luaDebug.Log("BreakEffectFinish   " .. CS.UnityEngine.Time.time)
    end
    if UIMainChatPanel.IenumWaitShow ~= nil then
        StopCoroutine(UIMainChatPanel.IenumWaitShow)
        UIMainChatPanel.IenumWaitShow = nil
    end
    UIMainChatPanel.IenumWaitShow = StartCoroutine(UIMainChatPanel.IEnumWaitShowEffect)
end

function UIMainChatPanel.InitBreakStatu()
    uiStaticParameter.isBreakjlzEffect = false
end

---等待聚灵珠特效
function UIMainChatPanel.IEnumWaitShowEffect()
    while true do
        if not uiStaticParameter.isBreakjlzEffect then
            StopCoroutine(UIMainChatPanel.IenumWaitShow)
            UIMainChatPanel.ShowJLZEffect(nil)
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.5))
    end
end

--endregion

--region 活动闪烁气泡
---活动开启消息
function UIMainChatPanel:OnResCalendarActivityIsOpen()
    --local allOpenCalendarList = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetTodayAllOpenCalendarVO()
    --local length = allOpenCalendarList.Count - 1
    --for k = 0, length do
    --    local calendar = allOpenCalendarList[k]
    --    ---押镖活动(限制条件1.有帮会2.等级达到规定等级)
    --    if calendar.tableData.id == luaEnumActivityTypeByActivityTimeTable.DartCar and not CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) and CS.CSScene.MainPlayerInfo.Level >= CS.Cfg_GlobalTableManager.Instance:GetDartCarPlayerLevel() then
    --        local nowTime = CS.CSScene.MainPlayerInfo.serverTime
    --        local durationTime = CS.Cfg_GlobalTableManager.Instance:GetDartCarDurationTime() * 1000
    --        local endTime = calendar:GetStartTimeStamp() + durationTime
    --        if endTime > nowTime then
    --            local dartCarFlashId = CS.Cfg_GlobalTableManager.Instance:GetDartCarFlashId()
    --            CS.CSListUpdateMgr.Add(endTime - nowTime, nil, function()
    --                Utility.RemoveFlashPrompt(1, dartCarFlashId)
    --            end)
    --            Utility.AddFlashPrompt({ id = dartCarFlashId, clickCallBack = function()
    --                Utility.ShowSecondConfirmPanel({ PromptWordId = LuaEnumSecondConfirmType.ComeDartActivity, ComfireAucion = function()
    --                    --CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(10001)
    --                    Utility.ReqJoinUnionDartCarActivity()
    --                    Utility.RemoveFlashPrompt(1, dartCarFlashId)
    --                end, CancelCallBack = function()
    --                    Utility.RemoveFlashPrompt(1, dartCarFlashId)
    --                end })
    --            end })
    --        end
    --    end
    --end

    local runningActivities = gameMgr:GetLuaActivityMgr():GetRunningActivity();
    ---@param v CalendarItem
    for k, v in pairs(runningActivities) do
        ---@param activitySubInfo LuaActivityItemSubInfo
        local state, activitySubInfo = v.ActivityItem:GetRunningState();
        if (state == LuaActivityRunningState.IsRunning and activitySubInfo ~= nil) then
            ---@type TABLE.cfg_daily_activity_time
            local tbl = activitySubInfo.Tbl;
            if tbl:GetId() == luaEnumActivityTypeByActivityTimeTable.DartCar and not CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) and CS.CSScene.MainPlayerInfo.Level >= CS.Cfg_GlobalTableManager.Instance:GetDartCarPlayerLevel() then
                local nowTime = CS.CSScene.MainPlayerInfo.serverTime
                local durationTime = CS.Cfg_GlobalTableManager.Instance:GetDartCarDurationTime() * 1000
                local endTime = v.dayTime + activitySubInfo:GetStartTime() * 60 * 1000 + durationTime
                if endTime > nowTime then
                    local dartCarFlashId = CS.Cfg_GlobalTableManager.Instance:GetDartCarFlashId()
                    CS.CSListUpdateMgr.Add(endTime - nowTime, nil, function()
                        Utility.RemoveFlashPrompt(1, dartCarFlashId)
                    end)
                    Utility.AddFlashPrompt({ id = dartCarFlashId, clickCallBack = function()
                        Utility.ShowSecondConfirmPanel({ PromptWordId = LuaEnumSecondConfirmType.ComeDartActivity, ComfireAucion = function()
                            --CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(10001)
                            Utility.ReqJoinUnionDartCarActivity()
                            Utility.RemoveFlashPrompt(1, dartCarFlashId)
                        end, CancelCallBack = function()
                            Utility.RemoveFlashPrompt(1, dartCarFlashId)
                        end })
                    end })
                end
            end
        end
    end
end
--endregion

--region 拍卖行
---移除购买推送闪烁
function UIMainChatPanel:RemoveBuyPush()
    Utility.RemoveFlashPrompt(1, 10)
end

---移除上架推送闪烁
function UIMainChatPanel:RemoveShelfPush()
    Utility.RemoveFlashPrompt(1, 9)
end
--endregion

--region 全屏特效
function UIMainChatPanel.ShowScreenEffect(msgId, effectid)
    if effectid then
        Utility.ShowScreenEffect(effectid)
    end
end

function UIMainChatPanel.OnResInterruptSwornMessage()
    Utility.RemoveScreenEffect()
end
--endregion

--region 聊天按钮点击

function UIMainChatPanel.onCommentMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.TransferFriendChat then
        uimanager:ClosePanel('UIChatPanel')
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Friend_FriendChat);
    end
end

function UIMainChatPanel.OnChatInfoBtnCallBack(msgId, go, chatMessage, btnType)
    if btnType == LuaEnumChatInfoBtnType.RebateFlower then
        UIMainChatPanel.RebatFlowerCallBack(go, chatMessage)
    elseif btnType == LuaEnumChatInfoBtnType.FlowerReply then
        if chatMessage ~= nil and chatMessage.sendItemInfo ~= nil then
            networkRequest.ReqReplyToThank(chatMessage.sendItemInfo.itemId, chatMessage.senderId)
        end
    elseif btnType == LuaEnumChatInfoBtnType.AddFriend then
        if chatMessage ~= nil then
            if chatMessage.senderId ~= CS.CSScene.MainPlayerInfo.ID then
                networkRequest.ReqSendFlowerAddFriend(chatMessage.senderId)
            else
                networkRequest.ReqSendFlowerAddFriend(chatMessage.privateRoleId)
            end
        end
    elseif btnType == LuaEnumChatInfoBtnType.Agree then
        if chatMessage ~= nil then
            networkRequest.ReqAgreeSendFlowerAddFriend(chatMessage.senderId)
        end
    end
end

function UIMainChatPanel.RebatFlowerCallBack(go, chatMessage)
    if chatMessage == nil or chatMessage.sendItemInfo == nil then
        return
    end
    local curFlowerId = chatMessage.sendItemInfo.itemId
    local meetFlowerId = CS.CSScene.MainPlayerInfo.BagInfo:GetMeetFlower(curFlowerId)
    if meetFlowerId == 0 then
        Utility.ShowPopoTips(go, nil, 233)
    elseif meetFlowerId > curFlowerId then
        local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(62)
        if isFind then
            local temp = {}
            temp.Content = info.des
            temp.LeftDescription = info.leftButton
            temp.RightDescription = info.rightButton
            temp.ID = 62
            temp.CallBack = function()
                networkRequest.ReqRebateFlower(chatMessage.senderId, chatMessage.sendItemInfo.itemId, 1)
            end
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        end
    else
        networkRequest.ReqRebateFlower(chatMessage.senderId, chatMessage.sendItemInfo.itemId, 1)
    end
end


--endregion

function UIMainChatPanel.AutoFightEvent()
    if (CS.CSAutoFightMgr.Instance.IsOn) then
        networkRequest.ReqChangeAutoOperate(false, true)
    else
        networkRequest.ReqChangeAutoOperate(false, false)
    end
end

function UIMainChatPanel.AutoFindEvent()
    if (CS.CSPathFinderManager.Instance.IsPathFinding) then
        networkRequest.ReqChangeAutoOperate(true, false)
    else
        networkRequest.ReqChangeAutoOperate(false, false)
    end
end

function UIMainChatPanel.Ondestroy()
    if CS.CSResourceManager.Instance ~= nil and self ~= nil then
        if UIMainChatPanel.jlzEffect_Path ~= nil or UIMainChatPanel.jlzEffect_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UIMainChatPanel.jlzEffect_Path)
        end
    end
    if UIMainChatPanel.IenumShowjlzEffect ~= nil then
        StopCoroutine(UIMainChatPanel.IenumShowjlzEffect)
        UIMainChatPanel.IenumShowjlzEffect = nil
    end
    if UIMainChatPanel.IenumWaitShow ~= nil then
        StopCoroutine(UIMainChatPanel.IenumWaitShow)
        UIMainChatPanel.IenumWaitShow = nil
    end
    if UIMainChatPanel.IenumSetPos ~= nil then
        StopCoroutine(UIMainChatPanel.IenumSetPos)
        UIMainChatPanel.IenumSetPos = nil
    end
end

---关闭界面并打开背包面板
function UIMainChatPanel.CloseMainChatPanel()
    if (not UIMainChatPanel.InnerClosePanel) then
        UIMainChatPanel.UIOpenIsHide()
        UIMainChatPanel.mCurShowPanelName = ""
    end
    UIMainChatPanel.InnerClosePanel = false
    UIMainChatPanel.SocialBtnCanClick = true
end

---任务推送
function UIMainChatPanel.Push_Task(id, data)
    local taskPushDic = CS.Cfg_CheatPushManager.Instance.TaskPushDic
    if taskPushDic == nil then
        return
    end
    local isfind, push = taskPushDic:TryGetValue(data)
    if isfind == false then
        return
    end
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = UIMainChatPanel.btn_social.transform;
    -- TipsInfo[LuaEnumTipConfigType.Direction] = 2
    TipsInfo[LuaEnumTipConfigType.ConfigTable] = push
    TipsInfo[LuaEnumTipConfigType.Other] = push.id
    uimanager:CreatePanel("UISecretBookTipsPanel", nil, TipsInfo);
end

---推送小秘书消息
function UIMainChatPanel.OnResMainTaskPushMessage(id, data)
    if data.send == 1 then
        local isFind, push = CS.Cfg_CheatPushManager.Instance.TaskPushDic:TryGetValue(data.taskId)
        if isFind then
            -- CS.CSScene.MainPlayerInfo.SecretaryInfo:OnlyAddPlayerDialogue(push.inquiry)
            CS.CSScene.MainPlayerInfo.SecretaryInfo:AddSecretaryDialogue(tonumber(push.answer))
        end
    end
    UIMainChatPanel.ChatBtnonClick()
end

function UIMainChatPanel.OnResTaskStrategyMessage(id, data)
    UIMainChatPanel.Push_Task(id, data.task)
end

--region 行会/帮会Union
---收到红包消息
---@param tblData unionV2.ResUnionRedBagInfo 帮会红包数据
function UIMainChatPanel.ResUnionRedBagInfoMessageReceived(msgId, tblData, csData)
    ---@type UIGuildRedPacketPanel
    local panelName = "UIGuildRedPacketPanel"
    ---@type UIGuildRedPacketPanel
    local panel = uimanager:GetPanel(panelName)
    if panel then
        panel:RefreshPanel(tblData)
    else
        uimanager:CreatePanel(panelName, nil, tblData)
    end
    if UIMainChatPanel:GetChatV2() then
        --保存聊天红包状态
        UIMainChatPanel:GetChatV2():AddUnionRedPackData(tblData.id, tblData.state)
    end
    if tblData.state ~= 0 and UIMainChatPanel:GetUnionInfo() then
        --领了或者领完了移除红包提醒
        UIMainChatPanel:GetUnionInfo():RemoveRedPackId(tblData.id)
    end
end

---添加可领红包闪烁气泡
function UIMainChatPanel:AddCanRewardUnionRedPackMessage()

end

---添加帮会可发送红包闪烁气泡
function UIMainChatPanel:AddCanSendUnionRedPackMessage()

end
--endregion

--region 电池&wifi状态
---电池精灵图片
---@private
---@return UISprite
function UIMainChatPanel.GetBatterySprite()
    if UIMainChatPanel.mBatterySprite == nil then
        UIMainChatPanel.mBatterySprite = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/LeftDownRoot/battery", "UISprite")
    end
    return UIMainChatPanel.mBatterySprite
end

---WiFi精灵图片
---@private
---@return UISprite
function UIMainChatPanel.GetWifiSprite()
    if UIMainChatPanel.mWifiSprite == nil then
        UIMainChatPanel.mWifiSprite = UIMainChatPanel:GetCurComp("WidgetRoot/UIBottom/UIPhoneState/LeftDownRoot/network", "UISprite")
    end
    return UIMainChatPanel.mWifiSprite
end

---绑定电池和WiFi状态消息
---@private
function UIMainChatPanel.BindBatteryAndWifiStateMessage()
    UIMainChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.BATTERY_CHANGED, function(level)
        UIMainChatPanel:BatteryChangedEvent(level)
    end)
    UIMainChatPanel.RefreshBattery(CS.SDKManager.GameInterface:GetBattery())
    UIMainChatPanel.RefreshWifi()
end

---电池状态变化事件
---@param level number
---@private
function UIMainChatPanel:BatteryChangedEvent(level)
    UIMainChatPanel.RefreshBattery(level)
end

---刷新wifi状态
---@private
function UIMainChatPanel.UpdateWifiState()
    ---每隔一段时间刷新一次wifi状态
    local currentTime = CS.UnityEngine.Time.time
    ---刷新间隔(s)
    local refreshInterval = 3
    if UIMainChatPanel.mUpdateWifiStateTimer == nil then
        ---每隔3s刷新一次wifi状态
        UIMainChatPanel.mUpdateWifiStateTimer = currentTime + refreshInterval
    end
    if currentTime > UIMainChatPanel.mUpdateWifiStateTimer then
        UIMainChatPanel.mUpdateWifiStateTimer = currentTime + refreshInterval
        UIMainChatPanel.RefreshWifi()
    end
end

---刷新电池状态
---@private
function UIMainChatPanel.UpdateBatteryState()
    ---每隔一段时间刷新一次电池状态
    local currentTime = CS.UnityEngine.Time.time
    ---刷新间隔(s)
    local refreshInterval = 60
    if UIMainChatPanel.mUpdateBatteryStateTimer == nil then
        ---每隔60s刷新一次wifi状态
        UIMainChatPanel.mUpdateBatteryStateTimer = currentTime + refreshInterval
    end
    if currentTime > UIMainChatPanel.mUpdateBatteryStateTimer then
        UIMainChatPanel.mUpdateBatteryStateTimer = currentTime + refreshInterval
        UIMainChatPanel.RefreshBattery(CS.SDKManager.GameInterface:GetBattery())
    end
end

---刷新电池状态
---@param batteryLevel number 电量百分比的整数
---@private
function UIMainChatPanel.RefreshBattery(batteryLevel)
    if batteryLevel == nil then
        return
    end
    if batteryLevel >= 90 then
        ---1是一张接近满格的电量图标
        UIMainChatPanel.GetBatterySprite().spriteName = "battery1"
    elseif batteryLevel >= 65 then
        UIMainChatPanel.GetBatterySprite().spriteName = "battery2"
    elseif batteryLevel >= 30 then
        UIMainChatPanel.GetBatterySprite().spriteName = "battery3"
    elseif batteryLevel >= 10 then
        UIMainChatPanel.GetBatterySprite().spriteName = "battery4"
    else
        ---5是一张接近空电量的电量图标
        UIMainChatPanel.GetBatterySprite().spriteName = "battery5"
    end
end

---刷新wifi状态
---@private
function UIMainChatPanel.RefreshWifi()
    local isWifiConnected = CS.SDKManager.GameInterface:IsWifiConnect()
    UIMainChatPanel.GetWifiSprite().gameObject:SetActive(isWifiConnected)
end
--endregion

function ondestroy()
    UIMainChatPanel.Ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResNewMailMessage, UIMainChatPanel.onResNewMailMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCheckCallBackMessage, UIMainChatPanel.onResCallBackMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResInvitationListMessage, UIMainChatPanel.ResInvitationMonitor)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResApplyListMessage, UIMainChatPanel.ResApplyListMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUnionMagicCallBossMessage, UIMainChatPanel.ResMagicStoneMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResApplyTeamMessage, UIMainChatPanel.ResApplyTeamMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResChatMessage, UIMainChatPanel.OnResChatMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBubbleOnlineExpMessage, UIMainChatPanel.OnResBubbleOnlineExpMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBubbleOfflineExpMessage, UIMainChatPanel.OnResBubbleOfflineExpMessage)
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_OpenSocialPanel, UIMainChatPanel.OnOpenSocialPanel);
    --luaEventManager.RemoveCallback(LuaCEvent.CloseMainChatPanel, UIMainChatPanel.CloseMainChatPanel);
    --luaEventManager.RemoveCallback(LuaCEvent.Push_Task, UIMainChatPanel.Push_Task);
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIMainChatPanel.OnResBagChangeMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMainTaskPushMessage, UIMainChatPanel.OnResMainTaskPushMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResInterruptSwornMessage, UIMainChatPanel.OnResInterruptSwornMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResTaskStrategyMessage, UIMainChatPanel.OnResTaskStrategyMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCommonMessage, UIMainChatPanel.onCommentMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUnionRedBagInfoMessage, UIMainChatPanel.ResUnionRedBagInfoMessageReceived)
    if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.AuctionInfo then
        --移除对推送闪烁的计时（推送在两分钟后会移除）
        CS.CSScene.MainPlayerInfo.AuctionInfo:RemoveTimeCount()
    end

    --luaEventManager.RemoveCallback(LuaCEvent.RefreshJuLingZhuPush, UIMainChatPanel.CheckBeadsFlashState)

end

return UIMainChatPanel