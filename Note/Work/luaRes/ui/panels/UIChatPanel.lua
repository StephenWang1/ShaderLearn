---@class UIChatPanel:UIBase 聊天面板
local UIChatPanel = {}
UIChatPanel.ResChatDic = nil
UIChatPanel.GeneralChatList = nil
UIChatPanel.transMapInfos = {}
UIChatPanel.chatItemInfos = {}
UIChatPanel.pattern = "\\[[0-9A-Fa-f]{6}\\]|\\[-\\]";
UIChatPanel.pattern_2 = "\\[[0-9A-Fa-f]{6,8}\\]|\\[-\\]|\\[u\\]|\\[/u\\]";
UIChatPanel.temp_delate_x = 0
UIChatPanel.accuracy = 100
UIChatPanel.curPageIndex = 1
UIChatPanel.DelayCoroutine = nil
UIChatPanel.ItemWinTogList = {}
UIChatPanel.faceOldList = {}
UIChatPanel.faceNewList = {}
UIChatPanel.LastTogGo = nil
UIChatPanel.mInitSearchPopList = false
---私聊对象
UIChatPanel.mPrivateFriendDic = {}
---当前选择的私聊对象
UIChatPanel.mSelectPrivateFriend = nil;
---当前锁定标识
UIChatPanel.mLiaoGo = nil
---频道对应Go
UIChatPanel.mChannelGoTable = {}

UIChatPanel.mDefaultVoiceBtnPos = CS.UnityEngine.Vector3(-756, -290, 0)
---右移语音按钮
UIChatPanel.mRightVoiceBtnPos = CS.UnityEngine.Vector3(-561, -290, 0)
---帮会模式语音按钮位置
UIChatPanel.mMiddleVoiceBtnPos = CS.UnityEngine.Vector3(-665, -290, 0)

UIChatPanel.switch = {
    ["tg_synthesize"] = function()
        -- 综合
        return 0
    end,
    ["tg_nearby"] = function()
        -- 附近
        return 2
    end,
    ["tg_world"] = function()
        -- 世界
        return 1
    end,
    ["tg_private"] = function()
        -- 私聊
        return 5
    end,
    ["tg_team"] = function()
        -- 组队
        return 6
    end,
    ["tg_guild"] = function()
        -- 帮会
        return 4
    end,
    ["tg_system"] = function()
        -- 系统
        return 3
    end,
    ["tg_league"] = function()
        -- 联盟
        return 8
    end,
}

UIChatPanel.mDefaultChartSearchInputText = "请输入角色名字";

---@type UnityEngine.GameObject 当前选中目录
UIChatPanel.mCurrentChooseMenu = nil

---@private 是否是搜索返回
---@type boolean
UIChatPanel.mIsSearch = false;

---@private 是否是第一次搜索
------@type boolean
UIChatPanel.mIsFirstSearch = true;

---@private 私聊搜索返回列表
UIChatPanel.mSearchCacheList = nil;

--region parameters

--endregion

--region components
function UIChatPanel:GetPrivateChatcontent_GameObject()
    if (self.mPrivateChatcontent_GameObject == nil) then
        self.mPrivateChatcontent_GameObject = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/panel2/privateChat/content", "GameObject");
    end
    return self.mPrivateChatcontent_GameObject;
end

function UIChatPanel:GetPrivateChatArrow_GameObject()
    if (self.mPrivateChatArrow_GameObject == nil) then
        self.mPrivateChatArrow_GameObject = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/panel2/privateChat/content/Sprite", "GameObject");
    end
    return self.mPrivateChatArrow_GameObject;
end

function UIChatPanel:GetPrivateChatSearch_UIInput()
    if (self.mPrivateChatSearch_UIInput == nil) then
        self.mPrivateChatSearch_UIInput = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/panel2/privateChat/SearchInput", "UIInput");
    end
    return self.mPrivateChatSearch_UIInput;
end

function UIChatPanel:GetChooseChatArea_GameObject()
    if (self.mChooseChatArea_Go == nil) then
        self.mChooseChatArea_Go = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/ChooseChatArea", "GameObject");
    end
    return self.mChooseChatArea_Go;
end

function UIChatPanel:GetChooseChatArea_UIDropDown()
    if (self.mChooseChatArea_UIDropDown == nil) then
        self.mChooseChatArea_UIDropDown = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/ChooseChatArea/DropDown", "Top_UIDropDown");
    end
    return self.mChooseChatArea_UIDropDown;
end

function UIChatPanel:GetChooseChatAreaCaptionLabel_UILabel()
    if (self.mChooseChatAreaCaptionLabel_UILabel == nil) then
        self.mChooseChatAreaCaptionLabel_UILabel = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/ChooseChatArea/DropDown/Caption/CaptionLabel", "Top_UILabel");
    end
    return self.mChooseChatAreaCaptionLabel_UILabel;
end

function UIChatPanel:GetSynthesizeCheck_UISprite()
    if (self.SynthesizeCheck_UISprite == nil) then
        self.SynthesizeCheck_UISprite = self:GetCurComp("WidgetRoot/Root/ToggleGroup/tg_synthesize/check", "UISprite");
    end
    return self.SynthesizeCheck_UISprite;
end

function UIChatPanel:GetPrivateCheck_UISprite()
    if (self.PrivateCheck_UISprite == nil) then
        self.PrivateCheck_UISprite = self:GetCurComp("WidgetRoot/Root/ToggleGroup/tg_private/check", "UISprite");
    end
    return self.PrivateCheck_UISprite;
end

function UIChatPanel:GetBtnProgram_UISprite()
    if (self.BtnProgram_UISprite == nil) then
        self.BtnProgram_UISprite = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/ChooseChatArea/DropDown/Caption/Btn_program", "UISprite");
    end
    return self.BtnProgram_UISprite;
end
--endregion

--region init
--endregion

function UIChatPanel:Init()
    ---@type UnityEngine.GameObject
    UIChatPanel.btn = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/btn", "GameObject")
    CS.UIEventListener.Get(self.btn).onClick = UIChatPanel.OnClickSend
    ---@type Top_ChatListView
    UIChatPanel.Grild = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/Chat Area/GameObject/Grild", "Top_ChatListView")

    ---@type Top_UIInput
    UIChatPanel.ChatInput = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/Chat Input", "Top_UIInput")
    ---@type UISprite
    UIChatPanel.chatInputSprite = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/Chat Input/Sprite", "UISprite")

    ---@type UnityEngine.GameObject
    UIChatPanel.BtnGroup = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup", "GameObject")
    ---@type UnityEngine.GameObject
    UIChatPanel.btn_emoticon = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup/btn_emoticon", "GameObject")
    ---@type UnityEngine.GameObject
    UIChatPanel.btn_bag = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup/btn_bag", "GameObject")
    ---@type UnityEngine.GameObject
    UIChatPanel.btn_location = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup/btn_location", "GameObject")
    ---@type UnityEngine.GameObject
    UIChatPanel.btn_Setting = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup/btn_Setting", "GameObject")
    ---@type UnityEngine.GameObject
    ---红包
    UIChatPanel.btn_RedPacket = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup/btn_redbag", "GameObject")
    ---@type UISprite
    ---背景
    UIChatPanel.BtnGroupBG = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup/BG", "UISprite")
    ---@type UnityEngine.GameObject
    ---节点
    UIChatPanel.BtnGroupGO = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/BtnGroup", "GameObject")

    ---@type UnityEngine.GameObject
    self.btn_add = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/btn_add", "GameObject")

    ---@type UnityEngine.Transform
    UIChatPanel.btn_voice = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/btn_voice", "Transform")
    ---@type UnityEngine.GameObject
    UIChatPanel.btn_close = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/btn_close", "GameObject")
    ---@type UnityEngine.GameObject
    UIChatPanel.btn_slider = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/btn_slider", "GameObject")

    ---@type UnityEngine.GameObject
    UIChatPanel.ItemWindow = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/ItemWindow", "GameObject")
    ---@type UnityEngine.GameObject
    UIChatPanel.SettingWindow = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/SettingWindow", "GameObject")
    UIChatPanel.SettingWindowTemplate = templatemanager.GetNewTemplate(self.SettingWindow, luaComponentTemplates.UIChatPanel_Setting)
    ---@type UnityEngine.GameObject
    UIChatPanel.EmotionWindow = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/EmotionWindow", "GameObject")

    UIChatPanel.PrivateChat_GameObject = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/panel2/privateChat", "GameObject")
    UIChatPanel.PrivateChatUILabel_UILabel = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/panel2/privateChat/content/Label", "UILabel")

    ---@type UIPopupList
    UIChatPanel.PrivateChatList = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/panel2/privateChat/btPriChatList", "UIPopupList")
    ---@type UIPopupList
    --UIChatPanel.SearchPrivateChatList = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea/panel2/privateChat/btSearchOverList", "UIPopupList")

    self:GetPrivateChatSearch_UIInput().gameObject:SetActive(false);

    --self.mDefaultChartSearchInputText = self:GetPrivateChatSearch_UIInput().value;

    ---@type UnityEngine.GameObject
    self.chatArea = self:GetCurComp("WidgetRoot/Root/Chat Window/ChatArea", "GameObject")
    ---@type UIVoiceBaseTemplate
    UIChatPanel.voiceTemplate = templatemanager.GetNewTemplate(self.chatArea, luaComponentTemplates.UIVoiceBaseTemplate, self, UIChatPanel)
    UIChatPanel.voiceTemplate:SetAutoPlayVoiceState(true)
    ---@type UnityEngine.Transform
    self.ToggleGroup = self:GetCurComp("WidgetRoot/Root/ToggleGroup", "Transform")
    self:InitTogGroup()

    ---@type UnityEngine.Transform
    UIChatPanel.Filter = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/SettingWindow/Root/Filter", "Transform")
    ---@type Top_UILabel
    UIChatPanel.SocialChatRedPointCount = self:GetCurComp("WidgetRoot/Root/ToggleGroup/tg_private/redpoint/Label", "Top_UILabel")
    UIChatPanel:InitFiter()

    --点击事件
    CS.UIEventListener.Get(UIChatPanel.BtnGroup).onClick = UIChatPanel.OnClickBtnGroup
    CS.UIEventListener.Get(UIChatPanel.ItemWindow).onClick = UIChatPanel.OnClickItemWindow
    CS.UIEventListener.Get(UIChatPanel.SettingWindow).onClick = UIChatPanel.OnClickSettingWindow
    CS.UIEventListener.Get(UIChatPanel.EmotionWindow).onClick = UIChatPanel.OnClickEmotionWindow
    CS.UIEventListener.Get(UIChatPanel.btn_emoticon).onClick = UIChatPanel.OnClickbtn_emoticon
    CS.UIEventListener.Get(UIChatPanel.btn_bag).onClick = UIChatPanel.OnClickbtn_bag
    CS.UIEventListener.Get(UIChatPanel.btn_location).onClick = UIChatPanel.OnClickbtn_location
    CS.UIEventListener.Get(UIChatPanel.btn_Setting).onClick = UIChatPanel.OnClickbtn_Setting
    CS.UIEventListener.Get(UIChatPanel.btn_close).onClick = UIChatPanel.OnCloseBtn
    --CS.UIEventListener.Get(self.btn_slider).onPress = UIChatPanel.OnCloseBtn
    CS.UIEventListener.Get(UIChatPanel.btn_add).onClick = UIChatPanel.OnClickbtn_add
    CS.UIEventListener.Get(UIChatPanel.btn_RedPacket).onClick = function()
        self:OnClickRedPacketBtn()
    end

    self.CallOnSearchUIInputSubmit = function()
        if (self:GetPrivateChatSearch_UIInput().value ~= "") then
            if (self:GetPrivateChatSearch_UIInput().value == CS.CSScene.MainPlayerInfo.Name) then
                CS.Utility.ShowTips("不可输入自己")
                self:GetPrivateChatSearch_UIInput().value = self.mDefaultChartSearchInputText
            else
                if (self:GetPrivateChatSearch_UIInput().value == self.mDefaultChartSearchInputText) then
                else
                    networkRequest.ReqAccurateSearch(self:GetPrivateChatSearch_UIInput().value);
                    self:GetPrivateChatSearch_UIInput().value = self.mDefaultChartSearchInputText;
                end
            end
        end
    end

    CS.EventDelegate.Add(UIChatPanel.PrivateChatList.onChange, function()
        UIChatPanel:OnPopupListValueChanged();
    end);
    --CS.EventDelegate.Add(UIChatPanel.SearchPrivateChatList.onChange, function()
    --    if (UIChatPanel.mInitSearchPopList) then
    --        UIChatPanel:OnPopupSearchListValueChanged();
    --    else
    --        UIChatPanel.mInitSearchPopList = true
    --        UIChatPanel.PrivateChatUILabel_UILabel.text = self.mDefaultChartSearchInputText
    --    end
    --end);

    UIChatPanel.PrivateChatList.onClose = function()

        if (not CS.StaticUtility.IsNull(self:GetPrivateChatSearch_UIInput().gameObject)) then
            self:GetPrivateChatSearch_UIInput().gameObject:SetActive(false);
        end

        if (not CS.StaticUtility.IsNull(self:GetPrivateChatArrow_GameObject())) then
            self:GetPrivateChatArrow_GameObject().transform.localRotation = CS.UnityEngine.Quaternion(0, 0, 0, 1);
        end

        if (self.mIsSearch) then
            self.mIsSearch = false;
        else
            self.UpdatePrivateChatList();
        end
    end

    UIChatPanel.PrivateChatList.onShow = function()
        if (not CS.StaticUtility.IsNull(self:GetPrivateChatSearch_UIInput().gameObject)) then
            self:GetPrivateChatSearch_UIInput().gameObject:SetActive(true);
        end
        if (not CS.StaticUtility.IsNull(self:GetPrivateChatArrow_GameObject())) then
            self:GetPrivateChatArrow_GameObject().transform.localRotation = CS.UnityEngine.Quaternion(0, 0, 180, 1);
        end
    end

    --UIChatPanel.SearchPrivateChatList.onClose = function()
    --    local privateFriendList = CS.CSScene.MainPlayerInfo.FriendInfoV2:GetPrivateChatList();
    --    if (privateFriendList.Count <= 0) then
    --        self.SearchPrivateChatList.gameObject:SetActive(false)
    --        self.SearchPrivateChatList:Clear()
    --        self:GetPrivateChatSearch_UIInput().gameObject:SetActive(true);
    --        self:GetPrivateChatSearch_UIInput().transform.localPosition = CS.UnityEngine.Vector3(-690, -290, 0);
    --        self:GetPrivateChatcontent_GameObject():SetActive(false)
    --    else
    --        self:GetPrivateChatSearch_UIInput().gameObject:SetActive(false);
    --    end
    --    self:GetPrivateChatArrow_GameObject().transform.localRotation = CS.UnityEngine.Quaternion(0, 0, 0, 1);
    --end
    --
    --UIChatPanel.SearchPrivateChatList.onShow = function()
    --    self:GetPrivateChatSearch_UIInput().gameObject:SetActive(true);
    --    self:GetPrivateChatArrow_GameObject().transform.localRotation = CS.UnityEngine.Quaternion(0, 0, 180, 1);
    --end

    self:GetPrivateChatSearch_UIInput().submitOnUnselect = true;
    CS.EventDelegate.Add(self:GetPrivateChatSearch_UIInput().onSubmit, self.CallOnSearchUIInputSubmit);

    ---@type Top_UIToggle
    UIChatPanel.tg_Body = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/ItemWindow/tg_Body", "Top_UIToggle")
    CS.UIEventListener.Get(UIChatPanel.tg_Body.gameObject).onClick = function(go)
        UIChatPanel.SwitchBodyAndBag(2)
    end
    ---@type Top_UIToggle
    UIChatPanel.tg_bag = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/ItemWindow/tg_bag", "Top_UIToggle")
    CS.UIEventListener.Get(UIChatPanel.tg_bag.gameObject).onClick = function(go)
        UIChatPanel.SwitchBodyAndBag(1)
    end

    ---@type Top_UIGridContainer
    UIChatPanel.ItemGrid = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/ItemWindow/Scroll View/Grild", "Top_UIGridContainer")

    ---@type Top_UIScrollView
    UIChatPanel.bagScrollView = self:GetCurComp("WidgetRoot/Root/BtnGroupPanel/ItemWindow/Scroll View", "Top_UIScrollView")
    ---@type UnityEngine.Transform
    UIChatPanel.ItemWinTogGroup = CS.Utility_Lua.Get(self.go.transform, "WidgetRoot/Root/BtnGroupPanel/ItemWindow/ToggleGroup", "Transform")
    UIChatPanel.InitItemWinTogGroup()

    UIChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ShowUIGuildTipsPanel, UIChatPanel.resShowUIGuildTipsPanel)
    UIChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.VoiceRecordEnd, UIChatPanel.OnVoiceRecordEnd)
    UIChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_PrivateChatCount, UIChatPanel.OnPrivateChatEvent)
    UIChatPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionVoiceEndpointsUpdateRefreSh, function(id, data)
        if UIChatPanel.voiceTemplate ~= nil then
            UIChatPanel.voiceTemplate:RefereshRealTimeVoiceActive(data)
        end
    end)

    UIChatPanel:GetChooseChatArea_UIDropDown().LuaEventTable = self
    UIChatPanel:GetChooseChatArea_UIDropDown():AddClickArrowEvent(self.SetDropDownArrow)
    UIChatPanel:GetChooseChatArea_UIDropDown().HideOptionAction = function()
        UIChatPanel:GetBtnProgram_UISprite().flip = CS.UIBasicSprite.Flip.Vertically
    end

    UIChatPanel:GetChooseChatArea_UIDropDown().OnValueChange:Add(function(eventTemp)
        UIChatPanel:GetBtnProgram_UISprite().flip = CS.UIBasicSprite.Flip.Vertically
        if (eventTemp.index == 5) then
            if (UIChatPanel.mLiaoGo ~= nil) then
                UIChatPanel.mLiaoGo:SetActive(false)
            end
            UIChatPanel:GetSynthesizeCheck_UISprite().alpha = 0
            UIChatPanel:GetPrivateCheck_UISprite().alpha = 1
            UIChatPanel.OnClickTog(UIChatPanel.mChannelGoTable[eventTemp.index])
        else
            if (UIChatPanel.mLiaoGo ~= nil) then
                UIChatPanel.mLiaoGo:SetActive(false)
            end
            if (Utility.GetLuaTableCount(UIChatPanel.mChannelGoTable) ~= 0) then
                local temgo = UIChatPanel.mChannelGoTable[eventTemp.index]
                UIChatPanel.mLiaoGo = temgo.transform:Find("liao").gameObject
            end
            UIChatPanel.mLiaoGo:SetActive(true)
            uiStaticParameter.UIChatPanel_SelectIndex_Default = eventTemp.index
        end
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_SendClickUnionRedPackInfo, function(msgId, data)
        ---@type chatV2.ResChat
        self:RefreshCurrentChannel()
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionVoiceStatusMessage, UIChatPanel.SetVoice)

    self.CallOnResAccurateSearchMessage = function(msgId, msgData, csData)
        --if (msgData ~= nil and msgData.info ~= nil) then
        --    local count = Utility.GetLuaTableCount(msgData.info)
        --    if (count > 1) then
        --        UIChatPanel.mInitSearchPopList = false
        --        UIChatPanel.ShowChoosePrivateChat(csData.info);
        --    elseif (count == 1) then
        --        uiStaticParameter.mSocialChatFriendName = csData.info[0].name;
        --        UIChatPanel.ShowPrivateChat(csData.info);
        --    end
        --end
        if (self.mIsFirstSearch) then
            self.mIsFirstSearch = false;
        else
            self.mIsSearch = true;
        end

        if (csData ~= nil and csData.info ~= nil) then
            if (csData.info.Count > 0) then
                if (csData.info[0].hostId == 0) then
                    uiStaticParameter.mSocialChatFriendName = csData.info[0].name;
                else
                    uiStaticParameter.mSocialChatFriendName = luaclass.RemoteHostDataClass:GetLianFuPrefixNameByHostId(csData.info[0].hostId) .. csData.info[0].name
                end
                CS.CSScene.MainPlayerInfo.FriendInfoV2.lastPrivateChatRoleId = csData.info[0].rid;
                UIChatPanel.ShowPrivateChat(csData.info);
                UIChatPanel.mSearchCacheList = csData.info;
            end
        end
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAccurateSearchMessage, self.CallOnResAccurateSearchMessage)
    --UIChatPanel.SocialChatRedPointCount.text = CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount > 99 and "99+" or CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount
    self:BindClientEvent()
end

function UIChatPanel:BindClientEvent()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.OnClickChatBagItem, UIChatPanel.OnBagItemClicked)
end

function UIChatPanel.SetDropDownArrow()
    if (UIChatPanel:GetChooseChatArea_UIDropDown().IsOpen) then
        UIChatPanel:GetBtnProgram_UISprite().flip = CS.UIBasicSprite.Flip.Vertically
    else
        UIChatPanel:GetBtnProgram_UISprite().flip = CS.UIBasicSprite.Flip.Nothing
    end
end

function UIChatPanel.InitItemWinTogGroup()
    for i = 0, UIChatPanel.ItemWinTogGroup.childCount - 1 do
        local tr = UIChatPanel.ItemWinTogGroup:GetChild(i)
        local count = Utility.GetLuaTableCount(UIChatPanel.ItemWinTogList)
        UIChatPanel.ItemWinTogList[count] = CS.Utility_Lua.GetComponent(tr.gameObject, "UIToggle")
    end
    local c2 = Utility.GetLuaTableCount(UIChatPanel.ItemWinTogList)
end

function UIChatPanel.SetVoice(id, data)
    if UIChatPanel.voiceTemplate ~= nil then
        UIChatPanel.voiceTemplate:RefreshRealTimeVoiceBtnActive()
    end

end
function UIChatPanel.SelectItemWinTog(index)
    local count = Utility.GetLuaTableCount(UIChatPanel.ItemWinTogList)
    --luaDebug.Log("SelectItemWinTog = "..index.." count = "..count)
    ---@type UIToggle
    local tog = UIChatPanel.ItemWinTogList[index]
    if tog ~= nil then
        tog.value = true
        tog.startsActive = true
    end
end

--点击函数
---@param go UnityEngine.GameObject
function UIChatPanel.OnClickItemWindow(go)
    UIChatPanel.ItemWindow:SetActive(false)
end
---@param go UnityEngine.GameObject
function UIChatPanel.OnClickSettingWindow(go)
    UIChatPanel.SettingWindow:SetActive(false)
end
---@param go UnityEngine.GameObject
function UIChatPanel.OnClickEmotionWindow(go)
    UIChatPanel.EmotionWindow:SetActive(false)
end

function UIChatPanel.OnClickBtnGroup(go)
    UIChatPanel.BtnGroup:SetActive(false)
end

---@param go UnityEngine.GameObject
function UIChatPanel.OnClickbtn_emoticon(go)
    UIChatPanel.EmotionWindow:SetActive(true)
    UIChatPanel.SettingWindow:SetActive(false)
    UIChatPanel.ItemWindow:SetActive(false)
    ---@type UnityEngine.Transform
    local grild = UIChatPanel.EmotionWindow.transform:Find("Grild")
    for i = 0, grild.childCount - 1 do
        CS.UIEventListener.Get(grild:GetChild(i).gameObject).onClick = UIChatPanel.OnClickEmotionGrid
    end
end
---@param go UnityEngine.GameObject
function UIChatPanel.OnClickEmotionGrid(go)
    ---@type UISprite
    local uisprite = CS.Utility_Lua.GetComponent(go, "UISprite")
    local spriteNmae = uisprite.spriteName
    table.insert(UIChatPanel.faceOldList, spriteNmae)
    spriteNmae = CS.Cfg_EmojiTableManager.Instance:GetEmojiName(spriteNmae);
    table.insert(UIChatPanel.faceNewList, spriteNmae)
    if spriteNmae ~= nil and spriteNmae ~= "" then
        --if uiStaticParameter.UIChatPanel_SelectIndex == 5 then
        --    UIChatPanel.ChatInput.SetValue = UIChatPanel.ChatInput.value.Length
        --end
        UIChatPanel.ChatInput:InsertText(spriteNmae)
    end
    UIChatPanel.EmotionWindow:SetActive(false)
    UIChatPanel.BtnGroup:SetActive(false)
end

---@param go UnityEngine.GameObject
function UIChatPanel.OnClickbtn_bag(go)
    UIChatPanel.ItemWindow:SetActive(true)
    UIChatPanel.EmotionWindow:SetActive(false)
    UIChatPanel.SettingWindow:SetActive(false)
    UIChatPanel.SwitchBodyAndBag(1);
end

function UIChatPanel:OnPopupListValueChanged()
    UIChatPanel.mSelectPrivateFriend = UIChatPanel.mPrivateFriendDic[UIChatPanel.PrivateChatList.value];
    if (UIChatPanel.mSelectPrivateFriend ~= nil) then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddPrivateChatFriend(LuaEnumSocialLieBiaoType.ZuiJinLieBiao, UIChatPanel.mSelectPrivateFriend)
        CS.CSScene.MainPlayerInfo.FriendInfoV2.lastPrivateChatRoleId = UIChatPanel.mSelectPrivateFriend.rid;
    end
    if UIChatPanel.voiceTemplate ~= nil and UIChatPanel.mSelectPrivateFriend ~= nil then
        UIChatPanel.voiceTemplate:SetPrivateRoleId(UIChatPanel.mSelectPrivateFriend.rid, UIChatPanel.mSelectPrivateFriend.name)
    end
end

--function UIChatPanel:OnPopupSearchListValueChanged()
--    UIChatPanel.mSelectPrivateFriend = UIChatPanel.mPrivateFriendDic[UIChatPanel.SearchPrivateChatList.value];
--    uiStaticParameter.mLastSelectPrivateFriendName = UIChatPanel.SearchPrivateChatList.value;
--    if UIChatPanel.voiceTemplate ~= nil and UIChatPanel.mSelectPrivateFriend ~= nil then
--        UIChatPanel.voiceTemplate:SetPrivateRoleId(UIChatPanel.mSelectPrivateFriend.rid, UIChatPanel.mSelectPrivateFriend.name)
--        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddPrivateChatFriend(LuaEnumSocialLieBiaoType.ZuiJinLieBiao, UIChatPanel.mSelectPrivateFriend)
--        if (not UIChatPanel.PrivateChatList.items:Contains(UIChatPanel.SearchPrivateChatList.value)) then
--            UIChatPanel.PrivateChatList:AddItem(UIChatPanel.SearchPrivateChatList.value)
--        end
--        UIChatPanel.PrivateChatUILabel_UILabel.text = UIChatPanel.SearchPrivateChatList.value
--    end
--
--    UIChatPanel.SearchPrivateChatList:Clear()
--    UIChatPanel.SearchPrivateChatList:CloseSelfBase()
--    UIChatPanel.PrivateChatList.gameObject:SetActive(true)
--    UIChatPanel.SearchPrivateChatList.gameObject:SetActive(false)
--end

function UIChatPanel.SwitchBodyAndBag(index)
    if index == 1 then
        UIChatPanel:GetBagTemplate():SwitchToBagState()
    else
        UIChatPanel:GetBagTemplate():SwitchToBodyState()
    end
    if index == 1 then
        UIChatPanel.tg_bag.value = true
        UIChatPanel.tg_bag.startsActive = true
        UIChatPanel.tg_Body.value = false
        UIChatPanel.tg_Body.startsActive = false
    else
        UIChatPanel.tg_bag.value = false
        UIChatPanel.tg_bag.startsActive = false
        UIChatPanel.tg_Body.value = true
        UIChatPanel.tg_Body.startsActive = true
    end

    --[[    if index == 1 then
            UIChatPanel.tg_bag.value = true
            UIChatPanel.tg_bag.startsActive = true
            UIChatPanel.tg_Body.value = false
            UIChatPanel.tg_Body.startsActive = false

            ---@type CSBagInfoV2
            local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
            if CS.CSScene.MainPlayerInfo == nil or bagInfo == nil then
                return
            end

            local tempList = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
            local templist1 = bagInfo:GetBagItemInfoExceptForCollection()
            local templist2 = bagInfo:GetBagItemInfoOnlyCollection()
            tempList:AddRange(templist2)
            tempList:AddRange(templist1)
            if UIChatPanel.currBagInfoList ~= nil then
                UIChatPanel.currBagInfoList:Clear()
            else
                UIChatPanel.currBagInfoList = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
            end
            for i = 0, tempList.Count - 1 do

                ---@type bagV2.BagItemInfo
                local bagItem = tempList[i]
                local isFind
                local tbl
                isFind, tbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItem.itemId)
                if tbl ~= nil then
                    UIChatPanel.currBagInfoList:Add(bagItem)
                end
            end
        else
            UIChatPanel.tg_bag.value = false
            UIChatPanel.tg_bag.startsActive = false
            UIChatPanel.tg_Body.value = true
            UIChatPanel.tg_Body.startsActive = true

            ---@type CSEquipInfoV2
            local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo
            if CS.CSScene.MainPlayerInfo == nil or equipInfo == nil then
                return
            end
            if UIChatPanel.currBagInfoList ~= nil then
                UIChatPanel.currBagInfoList:Clear()
            else
                UIChatPanel.currBagInfoList = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
            end
            local list = equipInfo:GetBodyEquipsList()
            for i = 0, list.Count - 1 do
                ---@type bagV2.BagItemInfo
                local equipData = list[i]
                if equipData ~= nil then
                    UIChatPanel.currBagInfoList:Add(equipData)
                end
            end
        end
        UIChatPanel.OnUpdateItems(1)]]
end

--[[function UIChatPanel.OnUpdateItems(index)
    if index < 1 or index > 6 then
        return
    end
    UIChatPanel.curPageIndex = index
    UIChatPanel.ItemGrid.MaxCount = 12
    UIChatPanel.SelectItemWinTog(index - 1)
    local count = (index - 1) * 12;
    for i = 0, 11 do
        local tempGo = UIChatPanel.ItemGrid.controlList[i]
        ---@type UIItem
        local item = CS.Utility_Lua.GetComponent(tempGo, "UIItem")
        CS.UIEventListener.Get(tempGo).onDrag = function(go, delta)
            UIChatPanel.temp_delate_x = UIChatPanel.temp_delate_x + delta.x;
        end
        CS.UIEventListener.Get(tempGo).onDragEnd = function(go)
            if UIChatPanel.temp_delate_x < -UIChatPanel.accuracy then
                if UIChatPanel.curPageIndex < 6 then
                    UIChatPanel.curPageIndex = UIChatPanel.curPageIndex + 1
                    UIChatPanel.OnUpdateItems(UIChatPanel.curPageIndex)
                end
            elseif UIChatPanel.temp_delate_x > UIChatPanel.accuracy then
                if UIChatPanel.curPageIndex > 1 then
                    UIChatPanel.curPageIndex = UIChatPanel.curPageIndex - 1
                    UIChatPanel.OnUpdateItems(UIChatPanel.curPageIndex)
                end
            end
            UIChatPanel.temp_delate_x = 0;
            UIChatPanel.bagScrollView:ResetPosition();
        end

        local bagIndex = count + i
        local itemData = {}
        if bagIndex < UIChatPanel.currBagInfoList.Count then
            ---@type bagV2.BagItemInfo
            local bagItemInfo = UIChatPanel.currBagInfoList[bagIndex]
            local isFind
            ---@type TABLE.CFG_ITEMS
            local tbl
            isFind, tbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            if tbl ~= nil then
                ---@type UISprite
                local icon = CS.Utility_Lua.GetComponent(tempGo.transform:Find("icon").gameObject, "UISprite")
                icon.gameObject:SetActive(true)
                icon.spriteName = tbl.icon
                itemData.bagItemInfo = bagItemInfo
                itemData.tbl = tbl
            end
        else
            local icon = CS.Utility_Lua.GetComponent(tempGo.transform:Find("icon").gameObject, "UISprite")
            icon.gameObject:SetActive(false)
        end

        CS.UIEventListener.Get(tempGo).onClick = function(go)
            UIChatPanel.SendItemData(itemData)
        end
    end
    UIChatPanel.bagScrollView:ResetPosition()
end]]

function UIChatPanel.SendItemData(itemData)
    if itemData == nil or itemData.tbl == nil then
        return
    end
    ---@type TABLE.CFG_ITEMS
    local tbl = itemData.tbl
    local strName = tbl.name

    strName = UIChatPanel.MatchAndReplaceColor(strName, UIChatPanel.pattern)
    local strValue = "【" .. strName .. "】";
    if UIChatPanel.ChatInput ~= nil then
        if uiStaticParameter.UIChatPanel_SelectIndex == 5 then
            UIChatPanel.ChatInput.SetValue = UIChatPanel.ChatInput.Length
        end
        UIChatPanel.ChatInput:InsertText(strValue)
    end
    local count = Utility.GetLuaTableCount(UIChatPanel.chatItemInfos)
    UIChatPanel.chatItemInfos[count] = itemData
    UIChatPanel.ItemWindow:SetActive(false)
    UIChatPanel.BtnGroup:SetActive(false)
end

function UIChatPanel.MatchAndReplaceColor(strName, pattern)
    local matches = CS.System.Text.RegularExpressions.Regex.Matches(strName, pattern)
    if matches.Count > 1 then
        local ms0 = string.gsub(matches[0].Value, "[%[%]]", "")
        local ms1 = string.gsub(matches[1].Value, "[%[%]]", "")
        strName = string.gsub(strName, "[%[" .. ms0 .. "%]]", "");
        strName = string.gsub(strName, "[%[" .. ms1 .. "%]]", "");
    end
    return strName
end

function UIChatPanel.CheckItem(id)
    for i = 0, UIChatPanel.currBagInfoList.Count - 1 do
        if UIChatPanel.currBagInfoList[i].itemId == id then
            return true
        end
    end
    return false
end

---@param go UnityEngine.GameObject
function UIChatPanel.OnClickbtn_location(go)
    UIChatPanel.BtnGroup:SetActive(false)
    UIChatPanel.ItemWindow:SetActive(false)
    UIChatPanel.EmotionWindow:SetActive(false)
    UIChatPanel.SettingWindow:SetActive(false)

    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil then
        local mainPlayer = CS.CSScene.Sington.MainPlayer
        local isFind
        ---@type TABLE.CFG_MAP
        local tbl
        isFind, tbl = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mainPlayer.Info.MapID)
        if tbl ~= nil then
            local temp = string.format("我的坐标【%s %d,%d】", UIChatPanel.MatchAndReplaceColor(tbl.name, UIChatPanel.pattern), mainPlayer.NewCell.Coord.x, mainPlayer.NewCell.Coord.y)
            local tableCount = Utility.GetLuaTableCount(UIChatPanel.transMapInfos)
            UIChatPanel.transMapInfos[tableCount] = {}
            UIChatPanel.transMapInfos[tableCount].mapId = CS.CSScene.MainPlayerInfo.MapID
            UIChatPanel.transMapInfos[tableCount].mapName = tbl.name
            UIChatPanel.transMapInfos[tableCount].coord = mainPlayer.NewCell.Coord
            --UIChatPanel.ChatInput.SetValue = UIChatPanel.ChatInput.value.Length
            UIChatPanel.ChatInput:InsertText(temp)
        end
    end

end
---@param go UnityEngine.GameObject
function UIChatPanel.OnClickbtn_Setting(go)
    UIChatPanel.SettingWindow:SetActive(true)
    UIChatPanel.ItemWindow:SetActive(false)
    UIChatPanel.EmotionWindow:SetActive(false)
end

function UIChatPanel.OnClickbtn_add(go)
    UIChatPanel.BtnGroup:SetActive(true)
end

function UIChatPanel.OnCloseBtn(go)
    if UIChatPanel.DelayCoroutine ~= nil then
        StopCoroutine(UIChatPanel.DelayCoroutine)
        UIChatPanel.DelayCoroutine = nil
    end
    local uimainChat = uimanager:GetPanel("UIMainChatPanel")
    if uimainChat ~= nil then
        uimainChat.btn_bag:SetActive(true)
        uimainChat.btn_social:SetActive(true)
        uimainChat.GrildWidget.alpha = 1
    end
    uimanager:ClosePanel("UIChatPanel");
end

---点击红包
function UIChatPanel:OnClickRedPacketBtn()
    local customData = {}
    ---@type UIPersonSendDiamondRedPackTemplate
    customData.Template = luaComponentTemplates.UIPersonSendDiamondRedPackTemplate
    uimanager:CreatePanel("UIGuildSendRedPackPanel", nil, customData)
end

function UIChatPanel:InitTogGroup()
    local defaultSelect = nil;
    for i = 0, UIChatPanel.ToggleGroup.transform.childCount - 1 do
        ---@type UnityEngine.Transform
        local t = UIChatPanel.ToggleGroup.transform:GetChild(i)
        local tog = CS.Utility_Lua.GetComponent(t.gameObject, "UIToggle")
        if tog ~= nil then
            local find = false
            local f = UIChatPanel.switch[t.name]
            if f ~= nil then
                UIChatPanel.mChannelGoTable[f()] = t.gameObject
                local index = f()
                if uiStaticParameter.UIChatPanel_SelectIndex == index then
                    if (defaultSelect == nil) then
                        defaultSelect = t.gameObject;
                    end
                    tog.startsActive = true
                    tog.value = true
                    find = true
                end

            end
            if not find then
                tog.startsActive = false
                tog.value = false
            end
        end
        CS.UIEventListener.Get(t.gameObject).onClick = UIChatPanel.OnClickTog
    end
    if (defaultSelect ~= nil) then
        UIChatPanel.OnClickTog(defaultSelect);
    end
end

function UIChatPanel:RefreshTogGroup()
    --for i = 0, UIChatPanel.ToggleGroup.transform.childCount - 1 do
    --@type UnityEngine.Transform
    --local t = UIChatPanel.ToggleGroup.transform:GetChild(i)
    --@type UnityEngine.Transform
    --local liao = t:Find("liao")
    --if liao ~= nil then
    --    local f = UIChatPanel.switch[t.name]
    --    if f ~= nil then
    --        local show = uiStaticParameter.UIChatPanel_FiterIndexList[f()]
    --        liao.gameObject:SetActive(t:GetComponent("UIToggle").value)
    --    end
    --end
    --end
end

function UIChatPanel:InitFiter()
    for i = 0, UIChatPanel.Filter.childCount - 1 do
        ---@type UnityEngine.GameObject
        local t = UIChatPanel.Filter:GetChild(i).gameObject
        ---@type UIToggle
        local tog = CS.Utility_Lua.GetComponent(t, "UIToggle")
        if tog ~= nil then
            local f = UIChatPanel.switch[tog.name]
            if f ~= nil then
                local index = f()
                tog.value = uiStaticParameter.UIChatPanel_FiterIndexList[index] == nil or uiStaticParameter.UIChatPanel_FiterIndexList[index]
                tog.startsActive = tog.value

                CS.EventDelegate.Add(tog.onChange, function()
                    uiStaticParameter.UIChatPanel_FiterIndexList[index] = tog.value
                    --UIChatPanel:RefreshTogGroup()
                end)
            end
        end
    end
end

function UIChatPanel.OnClickTog(go)
    UIChatPanel:GetChooseChatArea_UIDropDown().clickAnythingToClose = false
    UIChatPanel:GetBtnProgram_UISprite().flip = CS.UIBasicSprite.Flip.Vertically
    if (UIChatPanel.LastTogGo ~= nil and UIChatPanel.LastTogGo ~= go) then
        UIChatPanel.SetTogSpriteAlpha(UIChatPanel.LastTogGo, 0)
        UIChatPanel.SetTogSpriteAlpha(go, 1)
    else
        UIChatPanel.SetTogSpriteAlpha(go, 1)
    end
    UIChatPanel.LastTogGo = go

    UIChatPanel:GetChooseChatAreaCaptionLabel_UILabel().text = CS.Utility_Lua.Get(UIChatPanel.mChannelGoTable[uiStaticParameter.UIChatPanel_SelectIndex_Default].transform, "Label", "UILabel").text
    UIChatPanel.mCurrentChooseMenu = go
    local f = UIChatPanel.switch[go.name]
    if f ~= nil then
        uiStaticParameter.UIChatPanel_SelectIndex = f()
        if (f() ~= 0) then
            if (f() == 5 or f() == 3) then
                if (UIChatPanel.mLiaoGo ~= nil) then
                    UIChatPanel.mLiaoGo:SetActive(false)
                end
            else
                uiStaticParameter.UIChatPanel_SelectIndex_Default = f()
                if (UIChatPanel.mLiaoGo ~= nil) then
                    UIChatPanel.mLiaoGo:SetActive(false)
                end
                UIChatPanel.mLiaoGo = go.transform:Find("liao").gameObject
                UIChatPanel.mLiaoGo:SetActive(true)
            end
        else
            if (UIChatPanel.mLiaoGo == nil) then
                if (Utility.GetLuaTableCount(UIChatPanel.mChannelGoTable) ~= 0) then
                    local temgo = UIChatPanel.mChannelGoTable[uiStaticParameter.UIChatPanel_SelectIndex_Default]
                    UIChatPanel.mLiaoGo = temgo.transform:Find("liao").gameObject
                end
            end
            UIChatPanel.mLiaoGo:SetActive(true)
        end
        if (uiStaticParameter.UIChatPanel_SelectIndex == 5 or uiStaticParameter.UIChatPanel_SelectIndex == 0) then
            CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount = 0
            uiStaticParameter.UnReadChatCount = 0
            for i = 0, CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList.Count - 1 do
                networkRequest.ReqSetRead(CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList[i])
            end
            CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Clear()
            CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.AllSocialChat)
            CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SocialChat)
        end
        if (UIChatPanel.Grild ~= nil) then
            UIChatPanel.Grild.onRepressRevertTime = 0
            --UIChatPanel.Grild.mScrollV:SetDragAmount(1, 1, false)
        end
    end
    local privateIsShow = go.name == "tg_private";
    if (not privateIsShow) then
        UIChatPanel.PrivateChatList:CloseSelfBase();
    end
    UIChatPanel.PrivateChat_GameObject:SetActive(privateIsShow);

    UIChatPanel.UpdateChatInputWidth(uiStaticParameter.UIChatPanel_SelectIndex)

    if (privateIsShow) then
        UIChatPanel.ShowPrivateChat()
    else
        uiStaticParameter.mLastSelectPrivateFriendName = nil;
    end
    UIChatPanel.EnterVoiceGroup(go)
    UIChatPanel:RefreshRedBagGo()
    UIChatPanel:Show()
end

function UIChatPanel:RefreshRedBagGo()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end
    local f = UIChatPanel.switch[UIChatPanel.mCurrentChooseMenu.name]
    local hasUnion = mainPlayerInfo.UnionInfoV2.UnionID ~= 0
    local isGuild = f ~= nil and f() == 4 and hasUnion
    self.btn_RedPacket:SetActive(isGuild)
    self.BtnGroupBG.width = isGuild and 240 or 180
    local pos = self.BtnGroupGO.transform.localPosition
    pos.x = isGuild and 164 or 224
    self.BtnGroupGO.transform.localPosition = pos
end

function UIChatPanel.SetTogSpriteAlpha(go, alpha)
    local sprite = CS.Utility_Lua.Get(go.transform, "check", "Top_UISprite")
    sprite.alpha = alpha
end

function UIChatPanel.EnterVoiceGroup(go)
    if go.name == "tg_guild" then
        if CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID ~= 0 then
            uiStaticParameter.voiceMgr:Login(LuaEnumVoiceRoomType.UnionRoon)
        else
            CS.Utility.ShowTips("没有行会")
            uiStaticParameter.voiceMgr:Logout()
        end
    elseif go.name == "tg_team" then
        if CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo ~= nil then
            -- uiStaticParameter.voiceMgr:Login(LuaEnumVoiceRoomType.TeamRoom)
        else
            CS.Utility.ShowTips("没有队伍")
            uiStaticParameter.voiceMgr:Logout()
        end
    elseif go.name == "tg_league" then
        if (gameMgr:GetPlayerDataMgr():GetLeagueInfo():GetLeagueType() == 0) then
            CS.Utility.ShowTips("没有联盟")
            uiStaticParameter.voiceMgr:Logout()
        else

        end
    else
        uiStaticParameter.voiceMgr:Logout()
    end
    UIChatPanel.voiceTemplate:RefreshRealTimeVoiceBtnActive()
end

function UIChatPanel.UpdateChatInputWidth(type)

    UIChatPanel:GetChooseChatArea_GameObject():SetActive(false)
    if (type == 5) then
        UIChatPanel.chatInputSprite.width = 432;
        UIChatPanel.btn_voice.localPosition = UIChatPanel.mRightVoiceBtnPos
    elseif (type == 4) then
        UIChatPanel.chatInputSprite.width = 626;
        UIChatPanel.btn_voice.localPosition = UIChatPanel.mDefaultVoiceBtnPos
    elseif (type == 0) then
        UIChatPanel:GetChooseChatArea_GameObject():SetActive(true)
        UIChatPanel.chatInputSprite.width = 535;
        UIChatPanel.btn_voice.localPosition = UIChatPanel.mMiddleVoiceBtnPos
    else
        UIChatPanel.chatInputSprite.width = 626;
        UIChatPanel.btn_voice.localPosition = UIChatPanel.mDefaultVoiceBtnPos
    end
    UIChatPanel.ChatInput.label:UpdateAnchors();
end

function UIChatPanel.ShowPrivateChat(list)
    UIChatPanel.UpdatePrivateChatList(list);
    if (uiStaticParameter.mSocialChatFriendName ~= nil and uiStaticParameter.mSocialChatFriendName ~= "") then
        if (not CS.StaticUtility.IsNull(UIChatPanel.PrivateChatList.gameObject)) then
            UIChatPanel.PrivateChatList:CloseSelfBase()
            UIChatPanel.PrivateChatList.value = uiStaticParameter.mSocialChatFriendName;
            uiStaticParameter.mLastSelectPrivateFriendName = uiStaticParameter.mSocialChatFriendName;
            --if(list ~= nil) then
            --    if(list.Count > 1) then
            --        UIChatPanel.PrivateChatList:Show()
            --    else
            --        UIChatPanel:GetPrivateChatSearch_UIInput().gameObject:SetActive(false);
            --    end
            --elseif(UIChatPanel.PrivateChatList.items.Count > 1) then
            --    UIChatPanel.PrivateChatList:Show()
            --else
            --    UIChatPanel:GetPrivateChatSearch_UIInput().gameObject:SetActive(false);
            --end
            UIChatPanel.PrivateChatList:Show()
        end
    else
        if (uiStaticParameter.mLastSelectPrivateFriendName ~= nil and UIChatPanel.mPrivateFriendDic[uiStaticParameter.mLastSelectPrivateFriendName] ~= nil) then
            if (not CS.StaticUtility.IsNull(UIChatPanel.PrivateChatList.gameObject)) then
                UIChatPanel.PrivateChatList:CloseSelfBase()
                UIChatPanel.PrivateChatList.value = uiStaticParameter.mLastSelectPrivateFriendName;
                --if(list ~= nil) then
                --    if(list.Count > 1) then
                --        UIChatPanel.PrivateChatList:Show()
                --    else
                --        UIChatPanel:GetPrivateChatSearch_UIInput().gameObject:SetActive(false);
                --    end
                --elseif(UIChatPanel.PrivateChatList.items.Count > 1) then
                --    UIChatPanel.PrivateChatList:Show()
                --else
                --    UIChatPanel:GetPrivateChatSearch_UIInput().gameObject:SetActive(false);
                --end

                UIChatPanel.PrivateChatList:Show()
            end
        end
    end
    UIChatPanel.mSelectPrivateFriend = UIChatPanel.mPrivateFriendDic[UIChatPanel.PrivateChatList.value];
    uiStaticParameter.mSocialChatFriendName = ""
    if (UIChatPanel.mSelectPrivateFriend ~= nil) then
        UIChatPanel.voiceTemplate:SetPrivateRoleId(UIChatPanel.mSelectPrivateFriend.rid, UIChatPanel.mSelectPrivateFriend.name)
    end
end

function UIChatPanel.UpdatePrivateChatList(list)
    UIChatPanel.PrivateChatList.items:Clear();
    local privateFriendList = CS.CSScene.MainPlayerInfo.FriendInfoV2:GetPrivateChatList();
    if (list ~= nil and list.Count > 1) then
        privateFriendList = list
    end
    UIChatPanel.UpdateChatInputWidth(5);
    if (privateFriendList.Count <= 0) then
        if (not CS.StaticUtility.IsNull(UIChatPanel.PrivateChat_GameObject)) then
            UIChatPanel.PrivateChat_GameObject:SetActive(true);
        end

        if (not CS.StaticUtility.IsNull(UIChatPanel.PrivateChatList.gameObject)) then
            UIChatPanel.PrivateChatList.gameObject:SetActive(false);
        end

        UIChatPanel.PrivateChatUILabel_UILabel.transform.parent.gameObject:SetActive(false);
        --UIChatPanel.PrivateChatUILabel_UILabel.text = "[e85038]暂无私聊对象"
        UIChatPanel:GetPrivateChatSearch_UIInput().gameObject:SetActive(true);
        UIChatPanel:GetPrivateChatSearch_UIInput().transform.localPosition = CS.UnityEngine.Vector3(-690, -290, 0);
        UIChatPanel:GetPrivateChatArrow_GameObject():SetActive(false);
        return ;
    end
    if (not CS.StaticUtility.IsNull(UIChatPanel.PrivateChatList.gameObject)) then
        UIChatPanel.PrivateChatList.gameObject:SetActive(true);
    end
    UIChatPanel.PrivateChatUILabel_UILabel.transform.parent.gameObject:SetActive(true);
    UIChatPanel:GetPrivateChatSearch_UIInput().transform.localPosition = CS.UnityEngine.Vector3(-690, -248, 0);
    UIChatPanel:GetPrivateChatArrow_GameObject():SetActive(privateFriendList.Count > 1);
    local rotationZ = privateFriendList.Count > 1 and 0 or 180;
    UIChatPanel:GetPrivateChatArrow_GameObject().transform.localRotation = CS.UnityEngine.Quaternion(0, 0, rotationZ, 1);
    if (privateFriendList.Count > 0) then
        for i = 0, privateFriendList.Count - 1 do
            local name = ""
            local hostId = privateFriendList[i].hostId;
            if (hostId == 0 or hostId == CS.CSScene.MainPlayerInfo.RemoteHostInfo.RemoteHostId) then
                name = privateFriendList[i].name
            else
                name = luaclass.RemoteHostDataClass:GetLianFuPrefixNameByHostId(privateFriendList[i].hostId) .. privateFriendList[i].name
            end
            if (not UIChatPanel.PrivateChatList.items:Contains(name)) then
                UIChatPanel.PrivateChatList:AddItem(name)
                UIChatPanel.mPrivateFriendDic[name] = privateFriendList[i];
            end
        end
    end
end

---@param info friendV2.ResAccurateSearch
--function UIChatPanel.ShowChoosePrivateChat(info)
--    UIChatPanel.PrivateChatList:CloseSelfBase()
--    --UIChatPanel.SearchPrivateChatList.items:Clear();
--    --UIChatPanel.SearchPrivateChatList.gameObject:SetActive(true)
--
--    local Count = info.Count
--    UIChatPanel.UpdateChatInputWidth(5);
--
--    UIChatPanel.PrivateChatList.gameObject:SetActive(false);
--    --UIChatPanel.SearchPrivateChatList.gameObject:SetActive(true);
--
--    UIChatPanel.PrivateChatUILabel_UILabel.transform.parent.gameObject:SetActive(true);
--    UIChatPanel:GetPrivateChatSearch_UIInput().transform.localPosition = CS.UnityEngine.Vector3(-690, -248, 0);
--    UIChatPanel:GetPrivateChatArrow_GameObject():SetActive(Count > 1);
--    local rotationZ = Count > 1 and 0 or 180;
--    UIChatPanel:GetPrivateChatArrow_GameObject().transform.localRotation = CS.UnityEngine.Quaternion(0, 0, rotationZ, 1);
--    for i = 0, Count - 1 do
--        local name = ""
--        if (info[i].hostId == 0) then
--            name = info[i].name
--        else
--            name = luaclass.RemoteHostDataClass:GetLianFuPrefixNameByHostId(info[i].hostId) .. info[i].name
--        end
--        if (not UIChatPanel.PrivateChatList.items:Contains(name)) then
--            if name ~= nil then
--                UIChatPanel.PrivateChatList:AddItem(name)
--                uiStaticParameter.mSocialChatFriendName = name
--            end
--            UIChatPanel.mPrivateFriendDic[name] = info[i];
--        end
--    end
--    --UIChatPanel.SearchPrivateChatList:Show()
--    UIChatPanel.PrivateChatUILabel_UILabel.text = "请输入角色名字"
--end

function UIChatPanel:ChatLimit(go)
    if (go == nil) then
        go = UIChatPanel.btn
    end
    if (uiStaticParameter.UIChatPanel_SelectIndex == 5) then
        if (UIChatPanel.mSelectPrivateFriend ~= nil) then
            if (CS.CSScene.MainPlayerInfo.FriendInfoV2:GetFriend(UIChatPanel.mSelectPrivateFriend.rid)) then
                if (CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(uiStaticParameter.UIChatPanel_SelectIndex)) then
                    UIChatPanel:ShowTips(go, 314, "达到" .. tostring(CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(uiStaticParameter.UIChatPanel_SelectIndex)) .. "级可在该频道发言")
                    return false
                end
            else
                if (CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(7)) then
                    UIChatPanel:ShowTips(go, 314, "达到" .. tostring(CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(7)) .. "级可在该频道发言")
                    return false
                end
            end
        else
            if (CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(uiStaticParameter.UIChatPanel_SelectIndex)) then
                UIChatPanel:ShowTips(go, 314, "达到" .. tostring(CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(uiStaticParameter.UIChatPanel_SelectIndex)) .. "级可在该频道发言")
            else
                UIChatPanel:ShowTips(go, 318)
                return false
            end
        end
    else
        if (CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(uiStaticParameter.UIChatPanel_SelectIndex)) then
            UIChatPanel:ShowTips(go, 314, "达到" .. tostring(CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(uiStaticParameter.UIChatPanel_SelectIndex)) .. "级可在该频道发言")
            return false
        end
    end
    return true
end

function UIChatPanel.OnClickSend()
    local text = UIChatPanel.ChatInput.value
    if uiStaticParameter.UIChatPanel_SelectIndex == 3 then
        if (text == "@opengmpanel") then
            uimanager:CreatePanel("UIGMToolPanel")
            uimanager:ClosePanel("UIChatPanel")
        end
        local firstChart = string.sub(text, 1, 1)
        if (firstChart == "@" and CS.Constant.IsWhiteIp) then
            networkRequest.ReqGM(text)
        end
        UIChatPanel:ShowTips(UIChatPanel.btn, 315)
        return
    end
    --if (CS.CSScene.MainPlayerInfo.BudowillInfo:IsChangeModelAndName(CS.CSScene.MainPlayerInfo.ID)) then
    --    CS.Utility.ShowTips("参赛选手不能发言")
    --    return
    --end
    if uiStaticParameter.UIChatPanel_SelectIndex == 2 then
        local mapId = CS.CSScene.getMapID()
        local isLangyanmengjing = CS.Cfg_GlobalTableManager.Instance:IsLangYanMengJingMap(mapId)
        if isLangyanmengjing then
            CS.Utility.ShowTips("此地图无法近聊")
            return
        end
    end

    if (UIChatPanel:ChatLimit() == false) then
        return
    end

    local faceListCount = Utility.GetLuaTableCount(UIChatPanel.faceOldList)
    for i = 1, faceListCount do
        UIChatPanel.ChatInput.value = CS.Utility_Lua.StringReplace(UIChatPanel.ChatInput.value, UIChatPanel.faceNewList[i], UIChatPanel.faceOldList[i]);
    end
    text = UIChatPanel.ChatInput.value
    UIChatPanel.faceOldList = {}
    UIChatPanel.faceNewList = {}

    if text == nil or string.len(text) <= 0 then
        UIChatPanel:ShowTips(UIChatPanel.btn, 319)
        return
    end
    if string.len(CS.NGUIText.StripSymbols(text)) >= CS.Cfg_GlobalTableManager.Instance:GetChatMaxLength() then
        UIChatPanel:ShowTips(UIChatPanel.btn, 202)
        return
    end

    local chatItemCount = Utility.GetLuaTableCount(UIChatPanel.chatItemInfos)
    for i = 0, chatItemCount - 1 do
        local itemData = UIChatPanel.chatItemInfos[i]
        ---@type bagV2.BagItemInfo
        local bagItemInfo = itemData.bagItemInfo
        ---@type TABLE.CFG_ITEMS
        local tbl = itemData.tbl
        local str_new = ""
        str_new = "[url=event:open|UIItemInfoPanel|0|" .. CS.Utility_Lua.ReverseItemInfoToString(bagItemInfo, CS.CSScene.MainPlayerInfo.ID) .. "|" .. tostring(CS.CSScene.MainPlayerInfo.ID) .. "|" .. tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)) .. "][u]" .. tbl.name .. "[/u][/url]"
        str_new = string.gsub(str_new, "]", "^", 3)
        local str_old = "【" .. tbl.name .. "】"
        str_old = UIChatPanel.MatchAndReplaceColor(str_old, UIChatPanel.pattern)
        local originalstr_old = str_old
        str_old = string.gsub(str_old, " ", "");
        str_new = string.gsub(str_new, " ", "");
        text = string.gsub(text, originalstr_old, str_old);
        if (text == str_old) then
            text = str_new
        else
            str_old = CS.Utility_Lua.StringReplace(str_old, "(", "%(")
            str_old = CS.Utility_Lua.StringReplace(str_old, ")", "%)")
            text = string.gsub(text, str_old, str_new, 1)
        end

    end

    UIChatPanel.chatItemInfos = {}
    local count = Utility.GetLuaTableCount(UIChatPanel.transMapInfos)
    for i = 0, count - 1 do
        local mapInfo = UIChatPanel.transMapInfos[i]
        --地图色[2bcfed][-]
        --text = string.gsub(text, "-", " ")
        local str_new = string.format("我在[url=find:%d:%d:%d:%d][u][%s %d,%d][/u][/url]",
                mapInfo.mapId, mapInfo.coord.x, mapInfo.coord.y, CS.CSScene.MainPlayerInfo.Line, UIChatPanel.MatchAndReplaceColor(mapInfo.mapName, UIChatPanel.pattern), mapInfo.coord.x, mapInfo.coord.y)
        local str_old = "我的坐标【" .. UIChatPanel.MatchAndReplaceColor(mapInfo.mapName, UIChatPanel.pattern) .. " " .. mapInfo.coord.x .. "," .. mapInfo.coord.y .. "】"
        --str_new = string.gsub(str_new, "-", " ")
        --str_old = string.gsub(str_old, "-", " ")

        str_old = CS.Utility_Lua.StringReplace(str_old, "(", "%(")
        str_old = CS.Utility_Lua.StringReplace(str_old, ")", "%)")
        --str_new = UIChatPanel.MatchAndReplaceColor(str_new, UIChatPanel.pattern)
        text = CS.Utility_Lua.StringReplace(text, str_old, str_new)
        --text = string.gsub(text, str_old, str_new)
    end
    UIChatPanel.transMapInfos = {}

    local privateRoleId = 0
    local privateName = ""
    if (UIChatPanel.mSelectPrivateFriend ~= nil) then
        privateRoleId = uiStaticParameter.UIChatPanel_SelectIndex == 5 and UIChatPanel.mSelectPrivateFriend.rid or 0;
        privateName = uiStaticParameter.UIChatPanel_SelectIndex == 5 and UIChatPanel.mSelectPrivateFriend.name or "";
    end
    text = CS.Utility_Lua.RemoveStringColor(text)
    if uiStaticParameter.UIChatPanel_SelectIndex == 0 then
        networkRequest.ReqChat(uiStaticParameter.UIChatPanel_SelectIndex_Default, text, 0, false, "", 0)
    elseif (uiStaticParameter.UIChatPanel_SelectIndex == 1) then
        networkRequest.ReqChat(uiStaticParameter.UIChatPanel_SelectIndex, text, 0, false, "", 0)
    else
        if (uiStaticParameter.UIChatPanel_SelectIndex == 5) then
            CS.CSScene.MainPlayerInfo.FriendInfoV2.lastPrivateChatRoleId = privateRoleId;
            --UIChatPanel.ShowPrivateChat();
        end
        networkRequest.ReqChat(uiStaticParameter.UIChatPanel_SelectIndex, text, privateRoleId, false, privateName, 0)
    end

    --region 聊天收费tips
    --if CS.UnityEngine.PlayerPrefs.HasKey("ServerTimeDay" .. CS.CSScene.MainPlayerInfo.ID) then
    --    if (CS.UnityEngine.PlayerPrefs.GetInt("ServerTimeDay" .. CS.CSScene.MainPlayerInfo.ID) ~= CS.CSServerTime.Now.Day) then
    --        uimanager:CreatePanel("UIPromptPanel", nil, {
    --            Title = "提示",
    --            Content = "聊天过于频繁将收取金币",
    --            CallBack = function(panel)
    --                if uiStaticParameter.UIChatPanel_SelectIndex == 0 or uiStaticParameter.UIChatPanel_SelectIndex == 1 then
    --                    networkRequest.ReqChat(1, text, 0, false, "", 0)
    --                else
    --                    networkRequest.ReqChat(uiStaticParameter.UIChatPanel_SelectIndex, text, privateRoleId, false, privateName, 0)
    --                end
    --            end
    --        })
    --        CS.UnityEngine.PlayerPrefs.SetInt("ServerTimeDay" .. CS.CSScene.MainPlayerInfo.ID, CS.CSServerTime.Now.Day)
    --    else
    --        local test = CS.Utility_Lua.ReverseMessage(text)
    --        if uiStaticParameter.UIChatPanel_SelectIndex == 0 or uiStaticParameter.UIChatPanel_SelectIndex == 1 then
    --            networkRequest.ReqChat(1, text, 0, false, "", 0)
    --        else
    --            networkRequest.ReqChat(uiStaticParameter.UIChatPanel_SelectIndex, text, privateRoleId, false, privateName, 0)
    --        end
    --    end
    --else
    --    CS.UnityEngine.PlayerPrefs.SetInt("ServerTimeDay" .. CS.CSScene.MainPlayerInfo.ID, CS.CSServerTime.Now.Day)
    --    uimanager:CreatePanel("UIPromptPanel", nil, {
    --        Title = "提示",
    --        Content = "聊天过于频繁将收取金币",
    --        CallBack = function(panel)
    --            if uiStaticParameter.UIChatPanel_SelectIndex == 0 or uiStaticParameter.UIChatPanel_SelectIndex == 1 then
    --                networkRequest.ReqChat(1, text, 0, false, "", 0)
    --            else
    --                networkRequest.ReqChat(uiStaticParameter.UIChatPanel_SelectIndex, text, privateRoleId, false, privateName, 0)
    --            end
    --        end
    --    })
    --end
    --endregion

    if (string.sub(text, 1, 1) == "@") then
        networkRequest.ReqGM(text)
    end
    UIChatPanel.ChatInput.value = ""
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIChatPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIChatPanel.resShowUIGuildTipsPanel(id, data)
    if (data ~= nil) then
        if (data.playerid == CS.CSScene.MainPlayerInfo.ID) then
        else
            local paneltype
            if (data.remote == 1) then
                paneltype = LuaEnumPanelIDType.RemoteChatPanel
            else
                paneltype = LuaEnumPanelIDType.ChatPanel
            end
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = paneltype,
                roleId = data.playerid,
                roleName = data.playerName,
                roleSex = data.playersex,
                roleCareer = data.playercarrer,
                hostId = data.playerRemoteHostId,
            })
        end
    end
end

function UIChatPanel.OnVoiceRecordEnd(id, data)
    if (UIChatPanel.voiceTemplate ~= nil) then
        UIChatPanel.voiceTemplate:OnEnd()
    end
end

function UIChatPanel.OnPrivateChatEvent(id, data)
    if (data ~= 0) then
        UIChatPanel.SocialChatRedPointCount.text = data > 99 and "99+" or data
    end
end

---链接点击事件处理
function UIChatPanel.InfoOnClick(id, data)
    local eventList = string.Split(tostring(data), '|')

    local type = eventList[1]

    ---type为open表示打开面板，后续为参数
    ---type为deliver表示传送，暂时读表
    if (type == "event:open") then
        local parms = {}
        local count = Utility.GetLuaTableCount(eventList)
        if (count > 2) then
            if (eventList[2] == "UIGuildTipsPanel") then
                eventList[3] = tonumber(eventList[3])
                if (eventList[3] == CS.CSScene.Sington.MainPlayer.BaseInfo.ID) then
                    return
                end
                uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                    panelType = #eventList > 4 and tonumber(eventList[5]) or 0,
                    roleId = #eventList > 2 and eventList[3] or 0,
                    roleName = #eventList > 3 and eventList[4] or "",
                    roleSex = Utility.GetLuaTableCount(eventList) > 5 and eventList[6] or nil,
                    roleCareer = Utility.GetLuaTableCount(eventList) > 6 and eventList[7] or nil,
                    hostId = Utility.GetLuaTableCount(eventList) > 7 and eventList[8] or nil,
                })
                return
            elseif (eventList[2] == "UIItemInfoPanel") then
                local bagItemInfo = CS.Utility_Lua.ReverseItemInfo(eventList[4])
                local roleId = nil
                local career = nil
                if eventList[5] ~= nil then
                    roleId = tonumber(eventList[5])
                end
                if eventList[6] ~= nil then
                    career = tonumber(eventList[6])
                end
                if bagItemInfo ~= nil then
                    eventList[4] = bagItemInfo
                else
                    eventList[4] = nil
                end
                if (CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)) then
                    UIChatPanel:ShowItemInfo(CS.Cfg_ItemsTableManager.Instance.dic[bagItemInfo.itemId], eventList[4], roleId, career)
                end
                return
            elseif (eventList[2] == "UINavigationPanel") then
                if (luaEventManager.HasCallback(LuaCEvent.Navigation_OpenWithId)) then
                    local customData = {};
                    customData.targetId = tonumber(eventList[3]);
                    luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, customData);
                end
                return
            elseif (eventList[2] == "UIAuctionPanel") then
                local customData = {};
                customData.type = tonumber(eventList[3]);
                uimanager:CreatePanel(eventList[2], nil, customData)
                return
            end
        end
        for i = 3, Utility.GetLuaTableCount(eventList) do
            table.insert(parms, eventList[i])
        end
        uimanager:CreatePanel(eventList[2], nil, table.unpack(parms))
    elseif (type == "event:deliver") then
        networkRequest.ReqDeliverByConfig(tonumber(eventList[2]), false)
    elseif (type == "role:") then
        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = #eventList > 3 and tonumber(eventList[4]) or 0,
            roleId = #eventList > 1 and eventList[2] or 0,
            roleName = #eventList > 2 and eventList[3] or "",
            roleSex = #eventList > 4 and eventList[5] or nil,
            roleCareer = #eventList > 5 and eventList[6] or nil,
            hostId = #eventList > 7 and eventList[8] or nil,
        })

    end
end

function UIChatPanel:ShowItemInfo(itemInfo, bagItemInfo, roleId, career)
    Utility.OpenItemInfoAndCheckMarryRing(bagItemInfo, roleId, career)
end

function UIChatPanel:Show()
    UIChatPanel.DelayCoroutine = StartCoroutine(UIChatPanel.RefreshUIPanel)
end

function UIChatPanel.RefreshUIPanel()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.01))
    if CS.StaticUtility.IsNull(UIChatPanel.go) then
        return
    end
    if UIChatPanel._PanelState == LuaEnumUIState.IsGoingToBeDestroyed then
        return
    end
    --UIChatPanel:RefreshTogGroup()
    local uimainChat = uimanager:GetPanel("UIMainChatPanel")
    if uimainChat == nil then
        return
    end
    UIChatPanel.ResChatDic = uimainChat.ResChatDic
    UIChatPanel.GeneralChatList = uimainChat.GeneralChatList

    local resChatList = nil
    if uiStaticParameter.UIChatPanel_SelectIndex == 0 then
        resChatList = UIChatPanel.GeneralChatList
    else
        resChatList = UIChatPanel.ResChatDic[uiStaticParameter.UIChatPanel_SelectIndex]
    end
    resChatList = UIChatPanel.Grild:CheckChatListMaxCount(resChatList)
    if resChatList == nil then
        UIChatPanel.Grild:Init(CS.System.Collections.Generic["List`1[chatV2.ResChat]"]())
        return
    end
    UIChatPanel.Grild:Init(resChatList)
end

---@param resChat chatV2.ResChat
function UIChatPanel:AddMessage(resChat)
    UIChatPanel:Show()
    --UIChatPanel.Grild:AddMessage(resChat)
end

---刷新当前频道
function UIChatPanel:RefreshCurrentChannel()
    if (self.mCurrentChooseMenu ~= nil) then
        UIChatPanel.OnClickTog(self.mCurrentChooseMenu);
    end
end


--region 聊天背包
---@return UIChatPanel_BagPanel
---获取聊天背包模板
function UIChatPanel:GetBagTemplate()
    if self.mBagTemplate == nil then
        self.mBagTemplate = templatemanager.GetNewTemplate(self.ItemWindow, luaComponentTemplates.UIChatPanel_BagPanel)
    end
    return self.mBagTemplate
end

---点击背包格子
---@param info bagV2.BagItemInfo
function UIChatPanel.OnBagItemClicked(msgId, info)
    local itemData = {}
    itemData.bagItemInfo = info
    itemData.tbl = info.ItemTABLE
    UIChatPanel.SendItemData(itemData)
end
--endregion

function update()
    if UIChatPanel:GetBagTemplate() then
        UIChatPanel:GetBagTemplate():GetChatBagInteraction():OnUpdate(CS.UnityEngine.Time.time)
    end
end

function ondestroy()
    if UIChatPanel.DelayCoroutine ~= nil then
        StopCoroutine(UIChatPanel.DelayCoroutine)
        UIChatPanel.DelayCoroutine = nil
    end
    local uimainChat = uimanager:GetPanel("UIMainChatPanel")
    if uimainChat ~= nil then
        uimainChat.btn_bag:SetActive(true)
        uimainChat.btn_social:SetActive(true)
        uimainChat.GrildWidget.alpha = 1
    end
    if UIChatPanel.voiceTemplate ~= nil then
        UIChatPanel.voiceTemplate:SetAutoPlayVoiceState(false)
    end
end

return UIChatPanel