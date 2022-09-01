---@class UISocialContactPanel:UIBase
---私聊、好友面板
local UISocialContactPanel = {}

--region 老局部变量
UISocialContactPanel.UIMainChatPanel = nil
UISocialContactPanel.transMapInfos = {}
UISocialContactPanel.mCurChatInfo = nil
UISocialContactPanel.mCurFriendTemplate = nil
UISocialContactPanel.mFriendList = nil
UISocialContactPanel.mLoadCoroutine = nil
UISocialContactPanel.mCurFriendSex = nil
UISocialContactPanel.mCurFriendCarrer = nil
UISocialContactPanel.TeamID = 0
UISocialContactPanel.GuildID = 0
UISocialContactPanel.LieBiaoType = LuaEnumSocialLieBiaoType.HaoYouLieBiao
---删除好友提示信息
UISocialContactPanel.DeleteFriendTipsInfo = nil
--endregion

--region 老组件
---@protected
function UISocialContactPanel.GetUIMainMenusPanel()
    local uiMainMenus = uimanager:GetPanel("UIMainMenusPanel")
    if (uiMainMenus ~= nil) then
        return uiMainMenus
    end
    return nil
end
--endregion

--region 局部变量
UISocialContactPanel.SocialBranchPanelType = nil;
UISocialContactPanel.BranchPanel = nil;
--endregion

--region 组件
--region 获取模板
function UISocialContactPanel.GetCurBranchPanel()
    if (UISocialContactPanel.SocialBranchPanelType ~= nil) then
        return UISocialContactPanel.BranchPanel[UISocialContactPanel.SocialBranchPanelType]
    end
end

function UISocialContactPanel.GetBranchPanel(type)
    if (UISocialContactPanel.BranchPanel[type] ~= nil) then
        return UISocialContactPanel.BranchPanel[type]
    end
end
--endregion

--region 子界面节点
function UISocialContactPanel.GetUILastChatPanelRoot_GameObject()
    if (UISocialContactPanel.mLastChatPanelRoot == nil) then
        UISocialContactPanel.mLastChatPanelRoot = UISocialContactPanel:GetCurComp("WidgetRoot/window/UILastChatPanel", "GameObject")
    end
    return UISocialContactPanel.mLastChatPanelRoot
end

function UISocialContactPanel.GetUIFriendInfoPanelRoot_GameObject()
    if (UISocialContactPanel.mFriendInfoPanelRoot == nil) then
        UISocialContactPanel.mFriendInfoPanelRoot = UISocialContactPanel:GetCurComp("WidgetRoot/window/UIFriendInfoPanel", "GameObject")
    end
    return UISocialContactPanel.mFriendInfoPanelRoot
end

function UISocialContactPanel.GetUIAddFriendPanel_GameObject()
    if (UISocialContactPanel.mUIAddFriendPanel == nil) then
        UISocialContactPanel.mUIAddFriendPanel = UISocialContactPanel:GetCurComp("WidgetRoot/window/UIAddFriendPanel", "GameObject")
    end
    return UISocialContactPanel.mUIAddFriendPanel
end

function UISocialContactPanel.GetUIFriendCirclePanel_GameObject()
    if (UISocialContactPanel.mUIFriendCirclePanel == nil) then
        UISocialContactPanel.mUIFriendCirclePanel = UISocialContactPanel:GetCurComp("WidgetRoot/window/UIFriendCirclePanel", "GameObject")
    end
    return UISocialContactPanel.mUIFriendCirclePanel
end
--endregion

--region Btn
function UISocialContactPanel.GetLastChatPanelBtn_GameObject()
    if (UISocialContactPanel.mLastChatBtn == nil) then
        UISocialContactPanel.mLastChatBtn = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/LastChatBtn", "GameObject")
    end
    return UISocialContactPanel.mLastChatBtn
end

function UISocialContactPanel.GetLastChatPanelBtn_UISprite()
    if (UISocialContactPanel.mLastChatBtnUIToggle == nil) then
        UISocialContactPanel.mLastChatBtnUIToggle = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/LastChatBtn", "UIToggle")
    end
    return UISocialContactPanel.mLastChatBtnUIToggle
end

function UISocialContactPanel.GetFriendInfoPanelBtn_GameObject()
    if (UISocialContactPanel.mFriendInfoBtn == nil) then
        UISocialContactPanel.mFriendInfoBtn = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/FriendInfoBtn", "GameObject")
    end
    return UISocialContactPanel.mFriendInfoBtn
end

function UISocialContactPanel.GetFriendInfoPanelBtn_UISprite()
    if (UISocialContactPanel.mFriendInfoBtnUIToggle == nil) then
        UISocialContactPanel.mFriendInfoBtnUIToggle = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/FriendInfoBtn", "UIToggle")
    end
    return UISocialContactPanel.mFriendInfoBtnUIToggle
end

function UISocialContactPanel.GetAddFriendPanelBtn_GameObject()
    if (UISocialContactPanel.mAddFriendBtn == nil) then
        UISocialContactPanel.mAddFriendBtn = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/AddFriendBtn", "GameObject")
    end
    return UISocialContactPanel.mAddFriendBtn
end

function UISocialContactPanel.GetFriendCirclePanelBtn_GameObject()
    if (UISocialContactPanel.mFriendCircleBtn == nil) then
        UISocialContactPanel.mFriendCircleBtn = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/FriendCircleBtn", "GameObject")
    end
    return UISocialContactPanel.mFriendCircleBtn
end

function UISocialContactPanel.GetCloseBtn_GameObject()
    if (UISocialContactPanel.mCloseBtn == nil) then
        UISocialContactPanel.mCloseBtn = UISocialContactPanel:GetCurComp("WidgetRoot/events/tg_close", "GameObject")
    end
    return UISocialContactPanel.mCloseBtn
end
--endregion

--region Toggle

function UISocialContactPanel.GetToggleLastChat_UIToggle()
    if (UISocialContactPanel.mToggleLastChat_UIToggle == nil) then
        UISocialContactPanel.mToggleLastChat_UIToggle = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/LastChatBtn", "UIToggle")
    end
    return UISocialContactPanel.mToggleLastChat_UIToggle;
end

function UISocialContactPanel.GetToggleFriendInfo_UIToggle()
    if (UISocialContactPanel.mToggleFriendInfo_UIToggle == nil) then
        UISocialContactPanel.mToggleFriendInfo_UIToggle = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/FriendInfoBtn", "UIToggle")
    end
    return UISocialContactPanel.mToggleFriendInfo_UIToggle;
end

function UISocialContactPanel.GetToggleFriendCircle_UIToggle()
    if (UISocialContactPanel.mToggleFriendCircle_UIToggle == nil) then
        UISocialContactPanel.mToggleFriendCircle_UIToggle = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/FriendCircleBtn", "UIToggle")
    end
    return UISocialContactPanel.mToggleFriendCircle_UIToggle;
end

function UISocialContactPanel.GetToggleAddFriend_UIToggle()
    if (UISocialContactPanel.mToggleAddFriend_UIToggle == nil) then
        UISocialContactPanel.mToggleAddFriend_UIToggle = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/AddFriendBtn", "UIToggle")
    end
    return UISocialContactPanel.mToggleAddFriend_UIToggle;
end

function UISocialContactPanel.GetSocialChatRedpointCount_UILabel()
    if (UISocialContactPanel.mSocialChatRedpointCount == nil) then
        UISocialContactPanel.mSocialChatRedpointCount = UISocialContactPanel:GetCurComp("WidgetRoot/events/TopToggle/ToggleList/LastChatBtn/background/redpoint/Label", "Top_UILabel")
    end
    return UISocialContactPanel.mSocialChatRedpointCount
end
--endregion

--region 数据
function UISocialContactPanel.GetCSFriendInfoV2FriendDic(type)
    if (CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic:ContainsKey(type)) then
        return CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic[type]
    end
end
--endregion
--endregion

--region 初始化
function UISocialContactPanel:Init()
    UISocialContactPanel.BindUIEvents()
    UISocialContactPanel:InitPanel();
    UISocialContactPanel.BindMessage()

    UISocialContactPanel.UIMainChatPanel = uimanager:GetPanel("UIMainChatPanel")
    if (UISocialContactPanel.UIMainChatPanel ~= nil) then
        UISocialContactPanel.UIMainChatPanel.mCurChoosePanel = LuaEnumSocialPanelType.SocialChatPanel
        UISocialContactPanel.UIMainChatPanel.SocialBtnCanClick = false
        UISocialContactPanel.UIMainChatPanel.UIOpenIsShow()
    end
end

function UISocialContactPanel:Show(customData)
    uiStaticParameter.UIChatPanel_SelectIndex = 5
    if (customData == nil) then
        customData = {};
    end

    if (customData.type == nil) then
        if (not CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.SocialChat) and not CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FriendApply) and not CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FRIEND_CIRCLEOFFRIENDS)) then
            customData.type = LuaEnumSocialFriendPanelType.LastChatPanel
        else
            if (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.SocialChat)) then
                customData.type = LuaEnumSocialFriendPanelType.LastChatPanel
            elseif (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FriendApply)) then
                customData.type = LuaEnumSocialFriendPanelType.FriendInfoPanel
            elseif (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FRIEND_CIRCLEOFFRIENDS)) then
                customData.type = LuaEnumSocialFriendPanelType.FriendCirclePanel
            end
            if (customData.type == nil) then
                customData.type = LuaEnumSocialFriendPanelType.LastChatPanel
            end
        end
    end
    UISocialContactPanel.GetSocialChatRedpointCount_UILabel().text = uiStaticParameter.UnReadChatCount > 99 and "99+" or uiStaticParameter.UnReadChatCount
    UISocialContactPanel.mCustomData = customData;
    UISocialContactPanel.SwitchSocialPanel(customData.type)

    if (UISocialContactPanel.mCoroutineDelayCallBack == nil) then
        UISocialContactPanel.mCoroutineDelayCallBack = StartCoroutine(UISocialContactPanel.IEnumCallBack, customData)
    end
end

function UISocialContactPanel.IEnumCallBack(customData)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.2));
    if (customData.CallBack ~= nil) then
        customData.CallBack(UISocialContactPanel)
    end
end

function UISocialContactPanel:InitPanel()
    if (UISocialContactPanel.BranchPanel == nil) then
        UISocialContactPanel.BranchPanel = {};
    end
    UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.LastChatPanel] = templatemanager.GetNewTemplate(UISocialContactPanel.GetUILastChatPanelRoot_GameObject(), luaComponentTemplates.UISocial_LastChatPanel, self)
    UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.FriendInfoPanel] = templatemanager.GetNewTemplate(UISocialContactPanel.GetUIFriendInfoPanelRoot_GameObject(), luaComponentTemplates.UISocial_FriendInfoPanel, self)
    UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.AddFriendPanel] = templatemanager.GetNewTemplate(UISocialContactPanel.GetUIAddFriendPanel_GameObject(), luaComponentTemplates.UISocial_AddFriendPanel, self)
    UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.FriendCirclePanel] = templatemanager.GetNewTemplate(UISocialContactPanel.GetUIFriendCirclePanel_GameObject(), luaComponentTemplates.UISocial_FriendCirclePanel, self)
end

function UISocialContactPanel.BindUIEvents()
    CS.UIEventListener.Get(UISocialContactPanel.GetCloseBtn_GameObject()).onClick = UISocialContactPanel.OnCloseBtnClick
    CS.UIEventListener.Get(UISocialContactPanel.GetLastChatPanelBtn_GameObject()).onClick = UISocialContactPanel.OnLastChatBtnClick
    CS.UIEventListener.Get(UISocialContactPanel.GetFriendInfoPanelBtn_GameObject()).onClick = UISocialContactPanel.OnFriendInfoBtnClick
    CS.UIEventListener.Get(UISocialContactPanel.GetAddFriendPanelBtn_GameObject()).onClick = UISocialContactPanel.OnAddFriendBtnClick
    CS.UIEventListener.Get(UISocialContactPanel.GetFriendCirclePanelBtn_GameObject()).onClick = UISocialContactPanel.OnFriendCircleBtnClick
end

function UISocialContactPanel.BindMessage()
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSearchFriendMessage, UISocialContactPanel.ResSearchFriend)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFriendChangeMessage, UISocialContactPanel.ResFriendChangeInfo)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPersonalInfoMessage, UISocialContactPanel.ResPersonalInfo)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPersonalChatMessage, UISocialContactPanel.ResPersonalChat)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResChatMessage, UISocialContactPanel.OnResChatMessage)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFriendLoginMessage, UISocialContactPanel.OnFriendLoginMessage)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResHasPlayerSomeInfoMessage, UISocialContactPanel.OnResHasPlayerSomeInfoMessage)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareHasPlayerSomeInfoMessage, UISocialContactPanel.OnResHasPlayerSomeInfoMessage)
    UISocialContactPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SocialChatCount, UISocialContactPanel.SetUnReadCount);
    UISocialContactPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SecretaryDialogueChange, UISocialContactPanel.OnSecretaryDialogueChange);
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMayKnowFriendMessage, UISocialContactPanel.OnResMayKnowFiendMessage)
    UISocialContactPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFriendLoveChangeMessage, UISocialContactPanel.OnFriendLoveChangeMessage)

end

--endregion

--region UI事件
--region 界面切换
function UISocialContactPanel.OnCloseBtnClick()
    uimanager:ClosePanel("UISocialContactPanel")
end

function UISocialContactPanel.OnLastChatBtnClick()
    if (UISocialContactPanel.SocialBranchPanelType ~= LuaEnumSocialFriendPanelType.LastChatPanel) then
        UISocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.LastChatPanel)
    end
end

function UISocialContactPanel.OnFriendInfoBtnClick()
    if (UISocialContactPanel.SocialBranchPanelType ~= LuaEnumSocialFriendPanelType.FriendInfoPanel) then
        UISocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.FriendInfoPanel)
    end
end

function UISocialContactPanel.OnAddFriendBtnClick()
    if (UISocialContactPanel.SocialBranchPanelType ~= LuaEnumSocialFriendPanelType.AddFriendPanel) then
        UISocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.AddFriendPanel)
    end
end

function UISocialContactPanel.OnFriendCircleBtnClick()
    if (UISocialContactPanel.SocialBranchPanelType ~= LuaEnumSocialFriendPanelType.FriendCirclePanel) then
        UISocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.FriendCirclePanel)
    end
end

---打开子界面
function UISocialContactPanel.SwitchSocialPanel(type)
    if (UISocialContactPanel.mCoroutineDelaySelectToggle ~= nil) then
        StopCoroutine(UISocialContactPanel.mCoroutineDelaySelectToggle);
        UISocialContactPanel.mCoroutineDelaySelectToggle = nil;
    end

    if (UISocialContactPanel.SocialBranchPanelType == nil) then
        UISocialContactPanel.SocialBranchPanelType = type
    else
        if (UISocialContactPanel.SocialBranchPanelType == type) then
            UISocialContactPanel.GetCurBranchPanel():Show(UISocialContactPanel.mCustomData)
            UISocialContactPanel.mCoroutineDelaySelectToggle = StartCoroutine(UISocialContactPanel.IDelaySelectToggle, type);
            return ;
        else
            if (UISocialContactPanel.GetCurBranchPanel() ~= nil) then
                --刷新真实等级
                UISocialContactPanel.GetCurBranchPanel():Hide()
            end
            UISocialContactPanel.SocialBranchPanelType = type
        end
    end
    if (UISocialContactPanel.GetCurBranchPanel() ~= nil) then
        UISocialContactPanel.GetCurBranchPanel():Show(UISocialContactPanel.mCustomData)
        UISocialContactPanel.mCustomData = nil;
    end
    UISocialContactPanel.mCoroutineDelaySelectToggle = StartCoroutine(UISocialContactPanel.IDelaySelectToggle, type);
end

function UISocialContactPanel.IDelaySelectToggle(type)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.1));
    if (type == LuaEnumSocialFriendPanelType.LastChatPanel) then
        UISocialContactPanel.GetToggleLastChat_UIToggle().value = true;
    elseif (type == LuaEnumSocialFriendPanelType.FriendInfoPanel) then
        UISocialContactPanel.GetToggleFriendInfo_UIToggle().value = true;
    elseif (type == LuaEnumSocialFriendPanelType.AddFriendPanel) then
        UISocialContactPanel.GetToggleAddFriend_UIToggle().value = true;
    elseif (type == LuaEnumSocialFriendPanelType.FriendCirclePanel) then
        UISocialContactPanel.GetToggleFriendCircle_UIToggle().value = true;
    end
end
--endregion

---获取Prompt表数据
function UISocialContactPanel.GetPromptData(dataId)
    local res, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(dataId)
    if res then
        return info
    end
    return nil
end
--endregion

--region 客户端处理
--聊天记录
function UISocialContactPanel:ReadChatRecords(info)
    if (info == nil) then
        UISocialContactPanel.GetGrild_ChatListView():Init(nil)
        return
    end
    local res, chatRecordInfo = CS.CSScene.MainPlayerInfo.ChatInfoV2.ChatRecordDic:TryGetValue(info.rid)
    if not res then
        UISocialContactPanel.GetGrild_ChatListView():Init(nil)
        return
    end
    for i = 1, chatRecordInfo.Count do
        chatRecordInfo[i - 1].privateName = info.name
        chatRecordInfo[i - 1].sendName = info.name
    end
    UISocialContactPanel.GetUIMainMenusPanel().ChatPrivateName = info.name

    UISocialContactPanel.mLoadCoroutine = StartCoroutine(UISocialContactPanel.LoadChatRecord, info.rid)
end

function UISocialContactPanel.LoadChatRecord(rid)
    coroutine.yield((CS.NGUIAssist.GetWaitForSeconds(0.1)))
    UISocialContactPanel.GetGrild_ChatListView():Init(CS.CSScene.MainPlayerInfo.ChatInfoV2.ChatRecordDic[rid])
end

function UISocialContactPanel.SetUnReadCount(id, count)
    UISocialContactPanel.GetSocialChatRedpointCount_UILabel().text = count > 99 and "99+" or count
end

function UISocialContactPanel.OnSecretaryDialogueChange()
    if UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.LastChatPanel] ~= nil then
        UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.LastChatPanel]:RefreshSecretary()
    end
end
--endregion

--region 服务器消息处理
---查询好友响应
function UISocialContactPanel.ResSearchFriend(id, data, csdata)
    if (UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.FriendInfoPanel] ~= nil) then
        UISocialContactPanel.BranchPanel[LuaEnumSocialFriendPanelType.FriendInfoPanel]:ResAddFriendInfo(id, csdata)
    end
end

function UISocialContactPanel.ResPersonalInfo(id, data, csdata)
    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.FriendInfoPanel or UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.AddFriendPanel) then
        UISocialContactPanel.GetCurBranchPanel():ResPersonalInfo(data, csdata)
    end
end

---刷新聊天记录
function UISocialContactPanel.ResPersonalChat(id, data, info)
    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.LastChatPanel) then
        UISocialContactPanel.GetCurBranchPanel():ResPersonalChat(info)
    end
end

---好友信息变化
function UISocialContactPanel.ResFriendChangeInfo(id, data, csdata)
    --返回好友信息变化
    if (csdata.addOrRemove == 3) then
        UISocialContactPanel.GetCurBranchPanel():ReFreshTemplateInfo(id, csdata)
    else
        if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.FriendInfoPanel) then
            UISocialContactPanel.GetCurBranchPanel():ResFriendList(csdata.type)
        end

        if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.LastChatPanel) and csdata.friend.Count > 0 then
            UISocialContactPanel.GetCurBranchPanel():ResFriendList(CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic[LuaEnumSocialLieBiaoType.ZuiJinLieBiao], csdata.friend[0])
        end
    end
end

function UISocialContactPanel.OnResMayKnowFiendMessage(id, data, csdata)
    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.FriendInfoPanel) then
        UISocialContactPanel.GetCurBranchPanel():ResFriendList(LuaEnumSocialLieBiaoType.ShenQingLieBiao)
    end
end

---接收消息
function UISocialContactPanel.OnResChatMessage(id, data, luadata)
    if (data == nil) then
        return
    end
    if luaclass.ChatData:ShowChatData(luadata) == false then
        return
    end
    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.LastChatPanel and data.channel == 5 and CS.CSScene.MainPlayerInfo.FriendInfoV2:GetFriend(data.senderId) ~= nil) then
        UISocialContactPanel.GetCurBranchPanel():OnResChatMessage(id, luadata)
    end
end

-----响应可能认识的人
--function UISocialContactPanel.OnResMayKnowFiendMessage(id, data, csdata)
--    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.AddFriendPanel) then
--        UISocialContactPanel.GetCurBranchPanel():ResKnowFriend(id, csdata)
--    end
--end

---好感度变化
function UISocialContactPanel.OnFriendLoveChangeMessage(id, data, csdata)
    CS.CSScene.MainPlayerInfo.FriendInfoV2:ChangeFriendLove(csdata)
    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.FriendInfoPanel) then
        UISocialContactPanel.GetCurBranchPanel():ResFriendLoveChange(csdata)
    end
end

---好友在线变化
function UISocialContactPanel.OnFriendLoginMessage(id, data, csdata)
    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.FriendInfoPanel) then
        UISocialContactPanel.GetCurBranchPanel():ResFriendIsOnLine(LuaEnumSocialLieBiaoType.HaoYouLieBiao)
    end
    if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.LastChatPanel) then
        UISocialContactPanel.GetCurBranchPanel():ResFriendIsOnLine(LuaEnumSocialLieBiaoType.ZuiJinLieBiao)
    end
end

function UISocialContactPanel.OnResHasPlayerSomeInfoMessage(id, data)
    if (data ~= nil) then
        UISocialContactPanel.TeamID = data.teamId
        UISocialContactPanel.GuildID = data.unionId
        if (UISocialContactPanel.SocialBranchPanelType == LuaEnumSocialFriendPanelType.FriendInfoPanel) then
            UISocialContactPanel.GetCurBranchPanel():ResRefreshInfoToggle()
        end
    end
end

---查看其他玩家信息响应
function UISocialContactPanel.OnResOtherRoleInfoMessageReceived(msgID, data, csData)
    uimanager:CreatePanel("UIRolePanel", function(panel)
        if (panel ~= nil) then
            --panel.SetWidgetEnable(false);
            panel.leftArrow:SetActive(false);
        end
    end, LuaEnumRolePanelType.OtherPlayer, csData)
end
--endregion

function ondestroy()
    uiStaticParameter.UIChatPanel_SelectIndex = 0
    luaEventManager.DoCallback(LuaCEvent.CloseMainChatPanel)

    if (UISocialContactPanel.mCoroutineDelaySelectToggle ~= nil) then
        StopCoroutine(UISocialContactPanel.mCoroutineDelaySelectToggle);
        UISocialContactPanel.mCoroutineDelaySelectToggle = nil;
    end
    if (UISocialContactPanel.mCoroutineDelayCallBack ~= nil) then
        StopCoroutine(UISocialContactPanel.mCoroutineDelayCallBack);
        UISocialContactPanel.mCoroutineDelayCallBack = nil;
    end

    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSearchFriendMessage, UISocialContactPanel.ResSearchFriend)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResFriendChangeMessage, UISocialContactPanel.ResFriendChangeInfo)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPersonalInfoMessage, UISocialContactPanel.ResPersonalInfo)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPersonalChatMessage, UISocialContactPanel.ResPersonalChat)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResChatMessage, UISocialContactPanel.OnResChatMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResFriendLoginMessage, UISocialContactPanel.OnFriendLoginMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMayKnowFriendMessage, UISocialContactPanel.OnResMayKnowFiendMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResFriendLoveChangeMessage, UISocialContactPanel.OnFriendLoveChangeMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResHasPlayerSomeInfoMessage, UISocialContactPanel.OnResHasPlayerSomeInfoMessage)
    if UISocialContactPanel.mLoadCoroutine ~= nil then
        StopCoroutine(UISocialContactPanel.mLoadCoroutine)
    end
end

return UISocialContactPanel