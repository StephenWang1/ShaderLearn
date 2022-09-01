---@class UISocial_LastChatPanel
local UISocial_LastChatPanel = {}

--region 局部变量

--endregion

--region 组件
function UISocial_LastChatPanel:GetSocialLastChatList_UIGridContainer()
    if (self.mLastChatList == nil) then
        self.mLastChatList = self:Get("bgleft/Scroll View/player", "UIGridContainer")
    end
    return self.mLastChatList
end

function UISocial_LastChatPanel:GetBGright_GameObject()
    if (self.mBGright == nil) then
        self.mBGright = self:Get("bgright", "GameObject")
    end
    return self.mBGright
end
function UISocial_LastChatPanel:GetSecretary_GameObject()
    if (self.mSecretary == nil) then
        self.mSecretary = self:Get("Secretary", "GameObject")
    end
    return self.mSecretary
end

function UISocial_LastChatPanel:GetTopName_UILabel()
    if (self.mTopName_UILabel == nil) then
        self.mTopName_UILabel = self:Get("bgright/TopName/Label", "UILabel")
    end
    return self.mTopName_UILabel
end

function UISocial_LastChatPanel:GetBag_UIToggle()
    if (self.mBagUIToggle == nil) then
        self.mBagUIToggle = self:Get("bgright/BtnGroup/ItemWindow/tg_bag", "UIToggle")
    end
    return self.mBagUIToggle
end

function UISocial_LastChatPanel:GetLingShou_UIToggle()
    if (self.mLingShouUIToggle == nil) then
        self.mLingShouUIToggle = self:Get("bgright/BtnGroup/ItemWindow/tg_lingshou", "UIToggle")
    end
    return self.mLingShouUIToggle
end

function UISocial_LastChatPanel:GetBtnGroup_GameObject()
    if (self.mBtnGroup == nil) then
        self.mBtnGroup = self:Get("bgright/BtnGroup", "GameObject")
    end
    return self.mBtnGroup
end

function UISocial_LastChatPanel:GetBtnVoice_GameObject()
    if (self.mBtnVoice == nil) then
        self.mBtnVoice = self:Get("bgright/btn_voice", "GameObject")
    end
    return self.mBtnVoice
end

function UISocial_LastChatPanel:GetBody_UIToggle()
    if (self.mBodyUIToggle == nil) then
        self.mBodyUIToggle = self:Get("bgright/BtnGroup/ItemWindow/tg_Body", "UIToggle")
    end
    return self.mBodyUIToggle
end

function UISocial_LastChatPanel:GetLocationBtn_GameObject()
    if (self.mLocationBtn == nil) then
        self.mLocationBtn = self:Get("bgright/BtnGroup/btn_location", "GameObject")
    end
    return self.mLocationBtn
end

function UISocial_LastChatPanel:GetTianJiaBtn_GameObject()
    if (self.mTianJiaBtn == nil) then
        self.mTianJiaBtn = self:Get("bgright/btn_tianjia", "GameObject")
    end
    return self.mTianJiaBtn
end

function UISocial_LastChatPanel:GetBagBtn_GameObject()
    if (self.mBagBtn == nil) then
        self.mBagBtn = self:Get("bgright/BtnGroup/btn_bag", "GameObject")
    end
    return self.mBagBtn
end

function UISocial_LastChatPanel:GetItemGrid_UIGridContainer()
    if (self.mItemGrid == nil) then
        self.mItemGrid = self:Get("bgright/BtnGroup/ItemWindow/Scroll View/Grild", "UIGridContainer")
    end
    return self.mItemGrid
end

function UISocial_LastChatPanel:GetBagScrollView_UIScrollView()
    if (self.mBagScrollView == nil) then
        self.mBagScrollView = self:Get("bgright/BtnGroup/ItemWindow/Scroll View", "UIScrollView")
    end
    return self.mBagScrollView
end

function UISocial_LastChatPanel:GetGrild_ChatListView()
    if (self.mChatListView == nil) then
        self.mChatListView = self:Get("bgright/ChatArea/Chat Area/GameObject/Grild", "ChatListView")
    end
    return self.mChatListView
end

function UISocial_LastChatPanel:GetChatInput_UIInput()
    if (self.mChatInput_UIInput == nil) then
        self.mChatInput_UIInput = self:Get("bgright/Chat Input", "UIInput")
    end
    return self.mChatInput_UIInput
end

function UISocial_LastChatPanel:GetChatBtn_GameObject()
    if (self.mChatBtn_GameObject == nil) then
        self.mChatBtn_GameObject = self:Get("bgright/btn_fasong", "GameObject")
    end
    return self.mChatBtn_GameObject
end

function UISocial_LastChatPanel:GetEmotionWindow_GameObject()
    if (self.mEmotionWindow == nil) then
        self.mEmotionWindow = self:Get("bgright/BtnGroup/EmotionWindow", "GameObject")
    end
    return self.mEmotionWindow
end

function UISocial_LastChatPanel:GetEmoticonBtn_GameObject()
    if (self.mEmotionBtn == nil) then
        self.mEmotionBtn = self:Get("bgright/BtnGroup/btn_emoticon", "GameObject")
    end
    return self.mEmotionBtn
end

function UISocial_LastChatPanel:GetItemWindow_GameObject()
    if (self.mItemWindow == nil) then
        self.mItemWindow = self:Get("bgright/BtnGroup/ItemWindow", "GameObject")
    end
    return self.mItemWindow
end

function UISocial_LastChatPanel:GetBtnGroup_GameObject()
    if (self.mBtnGroup == nil) then
        self.mBtnGroup = self:Get("bgright/BtnGroup", "GameObject")
    end
    return self.mBtnGroup
end

function UISocial_LastChatPanel:ItemWinTogGroup()
    if (self.mItemWinTogGroup == nil) then
        self.mItemWinTogGroup = self:Get("bgright/BtnGroup/ItemWindow/ToggleGroup", "Transform")
    end
    return self.mItemWinTogGroup
end

function UISocial_LastChatPanel:SecretaryTemplate()
    if self.secretaryTemplate == nil then
        self.secretaryTemplate = templatemanager.GetNewTemplate(self:GetSecretary_GameObject(), luaComponentTemplates.UISecretaryTemplates, self.SocialContactPanel)
    end
    return self.secretaryTemplate
end

function UISocial_LastChatPanel:GetNewInfoList()
    return CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList
end
--endregion

--region 初始化
function UISocial_LastChatPanel:Init(panel)
    ---@type UISocialContactPanel
    self.SocialContactPanel = panel
    self.momentTemRid = nil
    self.transMapInfos = {}
    self.chatItemInfos = {}
    self.mChatRecordDic = {}
    self.ItemWinTogList = {}
    self.FriendTemplates = {}
    self.FriendTemplatesID = {}
    self.temPrivateID = 0
    self.faceOldList = {}
    self.faceNewList = {}
    self.usetime = 0
    self.temp_delate_x = 0
    self.curPageIndex = 1
    self.accuracy = 100
    self.pattern = "\\[[0-9A-Fa-f]{6}\\]|\\[-\\]";
    self.pattern_2 = "\\[[0-9A-Fa-f]{6,8}\\]|\\[-\\]|\\[u\\]|\\[/u\\]";
    self.IsAllowUseVoice = false
    self.mCoroutineShowDefaultPanel = nil
    self.mCurChooseTem = nil

    self.voicestate = self:Get("bgright/btn_voice/voicestate", "GameObject")
    self.voicestateReturn = self:Get("bgright/btn_voice/voicestate/Return", "GameObject")
    self.voiceLoading = self:Get("bgright/btn_voice/voicestate/voice/Start", "TweenFillAmount")
    self.voiceLabel = self:Get("bgright/btn_voice/voicestate/Label", "UILabel")
    self:BindUIEvents()
    self.voiceTemplate = templatemanager.GetNewTemplate(self:GetBGright_GameObject(), luaComponentTemplates.UIVoiceBaseTemplate, self, self.SocialContactPanel)
    self.voiceTemplate:SwitchVoice(LuaEnumVoiceType.VoiceMessage)
    self:SecretaryTemplate()
    CS.CSScene.MainPlayerInfo.SecretaryInfo:ReqSeeSecretaryInfoMessage();
end

function UISocial_LastChatPanel:Show()
    self.go:SetActive(true)
    self:ResFriendList(self.SocialContactPanel.GetCSFriendInfoV2FriendDic(LuaEnumSocialLieBiaoType.ZuiJinLieBiao))
    if (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.SocialChat) and self:GetSocialLastChatList_UIGridContainer().controlList.Count > 1) then
        if (self:GetNewInfoList().Count > 0) then
            self:ChooseFirstUnReadFriend()
        end
    else
        if (self:GetSocialLastChatList_UIGridContainer().controlList.Count > 0 and self.FriendTemplates[self:GetSocialLastChatList_UIGridContainer().controlList[0]] ~= nil) then
            self.FriendTemplates[self:GetSocialLastChatList_UIGridContainer().controlList[0]]:SocialLastChatFriendOnClick()
        end
    end
end

function UISocial_LastChatPanel:ChooseFirstUnReadFriend()
    if (self.FriendTemplates ~= nil) then
        for i = 1, self:GetSocialLastChatList_UIGridContainer().controlList.Count do
            if (self:GetNewInfoList():Contains(self.FriendTemplates[self:GetSocialLastChatList_UIGridContainer().controlList[i - 1]].rid)) then
                self.FriendTemplates[self:GetSocialLastChatList_UIGridContainer().controlList[i - 1]]:SocialLastChatFriendOnClick()
                break
            end
        end
    end
end

function UISocial_LastChatPanel:Hide()
    uiStaticParameter.PrivateChatID = 0
    if (self.temPrivateID ~= 0) then
        self.FriendTemplates[self.FriendTemplatesID[self.temPrivateID]] = nil
        self.temPrivateID = 0
    end
    CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = false;
    self.go:SetActive(false)
    if (self.mCurChooseTem ~= nil) then
        self.mCurChooseTem.di_GameObject:SetActive(false)
        self.mCurChooseTem = nil
    end

    self:GetBGright_GameObject():SetActive(false)
end

function UISocial_LastChatPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetChatBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetChatBtn_GameObject()).OnClickLuaDelegate = self.ChatBtnOnClick

    CS.UIEventListener.Get(self:GetLocationBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetLocationBtn_GameObject()).OnClickLuaDelegate = self.LocationBtnOnClick

    CS.UIEventListener.Get(self:GetBagBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBagBtn_GameObject()).OnClickLuaDelegate = self.BagBtnOnClick

    CS.UIEventListener.Get(self:GetBody_UIToggle().gameObject).onClick = function(go)
        self:SwitchBodyAndBag(2)
    end
    CS.UIEventListener.Get(self:GetBag_UIToggle().gameObject).onClick = function(go)
        self:SwitchBodyAndBag(1)
    end
    CS.UIEventListener.Get(self:GetLingShou_UIToggle().gameObject).onClick = function(go)
        self:SwitchBodyAndBag(3)
    end

    CS.UIEventListener.Get(self:GetTianJiaBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetTianJiaBtn_GameObject()).OnClickLuaDelegate = self.TianJiaOnClick

    CS.UIEventListener.Get(self:GetItemWindow_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetItemWindow_GameObject()).OnClickLuaDelegate = self.ItemWindowOnClick

    CS.UIEventListener.Get(self:GetEmotionWindow_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetEmotionWindow_GameObject()).OnClickLuaDelegate = self.OnClickEmotionWindow

    CS.UIEventListener.Get(self:GetEmoticonBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetEmoticonBtn_GameObject()).OnClickLuaDelegate = self.EmoticonBtnOnClick

    CS.UIEventListener.Get(self:GetBtnGroup_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtnGroup_GameObject()).OnClickLuaDelegate = self.BtnGroupOnClick

    if (self.btn_listen ~= nil) then
        CS.UIEventListener.Get(self.btn_listen.gameObject).onClick = function(go)
            self:ReciveVoiceBtnClick(go)
        end
    end

    if (self.btn_realtimevoice ~= nil) then
        CS.UIEventListener.Get(self.btn_realtimevoice).onPress = function(go, state)
            self:SendVoiceBtnOnPress(go, state)
        end
    end

    self.SocialContactPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_Social_ClickFriendHeadInLastChat, function(id, rid)
        self:HeadIconOnClick(rid)
    end)
    self.SocialContactPanel:GetClientEventHandler():AddEvent(CS.CEvent.VoiceRecordEnd, function()
        self:OnVoiceRecordEnd()
    end)
    self.SocialContactPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SecretaryChange, function()
        self:SecretarySelectChange()
    end)
    self.SocialContactPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SecretaryDialogueChange, function(id, data)
        CS.CSScene.MainPlayerInfo.FriendInfoV2:ChangeSecretarylatelyTime()
        if (CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic:ContainsKey(LuaEnumSocialLieBiaoType.ZuiJinLieBiao) and CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic[LuaEnumSocialLieBiaoType.ZuiJinLieBiao] ~= nil) then
            self:ResFriendList(CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic[LuaEnumSocialLieBiaoType.ZuiJinLieBiao])
        end
        if self:SecretaryTemplate() ~= nil then
            self:SecretaryTemplate():SecretaryDialogueAll(data)
        end
    end)
    self:InitItemWinTogGroup()
end
--endregion

--region 刷新界面
function UISocial_LastChatPanel:ResFriendList(list, info)
    if CS.StaticUtility.IsNull(self:GetSocialLastChatList_UIGridContainer()) then
        return
    end
    if (list == nil or list.Count == 0) then
        self:GetSocialLastChatList_UIGridContainer().MaxCount = 0
        return
    end
    self:GetSocialLastChatList_UIGridContainer().MaxCount = list.Count
    if (self.mCurChooseTem ~= nil) then
        if (info ~= nil and info.rid == self.mCurChooseTem.rid) then
            self.mCurChooseTem:InitParameters(info)
            self.mCurChooseTem.unread_GameObject:SetActive(false)
            self.momentTemRid = self.mCurChooseTem.rid
        else
            self.momentTemRid = self.mCurChooseTem.rid
        end
    else
        self.momentTemRid = nil
    end
    self:FriendListSort()
    for k = 0, list.Count - 1 do
        local go = self:GetSocialLastChatList_UIGridContainer().controlList[k]
        if (self.FriendTemplates[go] == nil) then
            self.FriendTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISocialLastChatFriendTemplates, self)
        end
        self.FriendTemplates[go]:InitParameters(list[k])
        self.FriendTemplates[go]:SetRoleHeadIcon(list[k].sex, list[k].career)
        self.FriendTemplatesID[list[k].rid] = go
        self.FriendTemplates[go].index = k + 1
        self.FriendTemplates[go]:RefreshUI()
        if self.FriendTemplates[go]:IsSecretaryType() then
            --先暂时注释，之后问李永超有没有用
            --self.FriendTemplates[go]:Secretary_InitOpen(k == 0)
            self.FriendTemplates[go]:Secretary_PartialRefresh()
        end
    end
    if (self.momentTemRid ~= nil and CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel == false) then
        self.FriendTemplates[self.FriendTemplatesID[self.momentTemRid]]:SocialLastChatFriendOnClick(false)
    end
    if (self.mCoroutineShowDefaultPanel == nil and self.mCurChooseTem == nil) then
        self.mCoroutineShowDefaultPanel = StartCoroutine(self.IEnumShowDefaultPanel, self, list);
    end
end

function UISocial_LastChatPanel:ResFriendIsOnLine(type)
    local friends = self.SocialContactPanel.GetCSFriendInfoV2FriendDic(type)
    if (friends == nil or friends.Count == 0) then
        return
    end
    local Length = friends.Count - 1
    for k = 0, Length do
        local go = self:GetSocialLastChatList_UIGridContainer().controlList[k]
        if (self.FriendTemplates[go] ~= nil) then
            self.FriendTemplates[go]:SetRoleHeadIcon(friends[k].sex, friends[k].career)
        end
    end
end

---刷新小秘书面板
function UISocial_LastChatPanel:RefreshSecretary(go)
    -- for k, v in pairs(self.FriendTemplates) do
    --     if v:IsSecretaryType() then
    --         v:Secretary_PartialRefresh()
    --     end
    -- end
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2:ChangeSecretarylatelyTime()
    local dic = CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic
    if dic == nil then
        return
    end
    local isFetchValue, value = dic:TryGetValue(LuaEnumSocialLieBiaoType.ZuiJinLieBiao)
    if isFetchValue and value ~= nil then
        self:ResFriendList(value)
    end
    -- UISocial_LastChatPanel:FriendListSort(index, tem)
end

function UISocial_LastChatPanel:SecretarySelectChange()
    self:FriendListSort()
    for k, v in pairs(self.FriendTemplates) do
        if v:IsSecretaryType() then
            v:Secretary_PartialRefresh()
        else
            v:PartialRefresh()
        end
    end
    local isopen = CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel
    self:GetBGright_GameObject().gameObject:SetActive(not isopen)
    self:GetSecretary_GameObject().gameObject:SetActive(isopen)
end

---刷新聊天记录
function UISocial_LastChatPanel:ResPersonalChat(info)
    if (info == nil) then
        return
    end
    local Length = info.chatList.Count
    --处理道具屏蔽字问题
    for i = 0, Length - 1 do
        info.chatList[i].message = CS.Utility_Lua.ReverseMessage(tostring(info.chatList[i].message))
    end
    self:GetGrild_ChatListView():Init(info.chatList)
    self.mChatRecordDic[info.targetId] = info.chatList
end

function UISocial_LastChatPanel:ReFreshUIPanel()
    self.mCurChooseTem.unread_GameObject:SetActive(false)
    self:GetBGright_GameObject():SetActive(true and not CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel)
    --if (CS.System.String.IsNullOrEmpty(self.mCurChooseTem.info.remark)) then
    self:GetTopName_UILabel().text = self.mCurChooseTem.info.name
    --else
    --    self:GetTopName_UILabel().text = self.mCurChooseTem.info.remark
    --end
end

function UISocial_LastChatPanel:ReFreshUILeftPanel(targetId)
    if (self.FriendTemplatesID[targetId] ~= nil) then
        self.FriendTemplates[self.FriendTemplatesID[targetId]]:RefreshUIChatInfo()
    end
end

function UISocial_LastChatPanel:InitItemWinTogGroup()
    for i = 0, self:ItemWinTogGroup().childCount - 1 do
        local tr = self:ItemWinTogGroup():GetChild(i)
        local count = Utility.GetLuaTableCount(self.ItemWinTogList)
        self.ItemWinTogList[count] = tr.gameObject:GetComponent("UIToggle")
    end
    local c2 = Utility.GetLuaTableCount(self.ItemWinTogList)
end
--endregion

--region 事件
--region 聊天拓展事件
function UISocial_LastChatPanel:LocationBtnOnClick()
    self:GetEmotionWindow_GameObject():SetActive(false)
    self:GetItemWindow_GameObject():SetActive(false)
    self:GetBtnGroup_GameObject():SetActive(false)

    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil then
        local mainPlayer = CS.CSScene.Sington.MainPlayer
        local isFind
        ---@type TABLE.CFG_MAP
        local tbl
        isFind, tbl = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mainPlayer.Info.MapID)
        if tbl ~= nil then
            local temp = string.format("我的坐标【%s %d,%d】", self:MatchAndReplaceColor(tbl.name, self.pattern), mainPlayer.NewCell.Coord.x, mainPlayer.NewCell.Coord.y)
            local tableCount = Utility.GetLuaTableCount(self.transMapInfos)
            self.transMapInfos[tableCount] = {}
            self.transMapInfos[tableCount].mapId = CS.CSScene.MainPlayerInfo.MapID
            self.transMapInfos[tableCount].mapName = tbl.name
            self.transMapInfos[tableCount].coord = mainPlayer.NewCell.Coord
            --self:GetChatInput_UIInput().SetValue = self:GetChatInput_UIInput().value.Length
            self:GetChatInput_UIInput():InsertText(temp)
        end
    end
end

function UISocial_LastChatPanel:SwitchBodyAndBag(index)
    if index == 1 then
        self:GetBag_UIToggle().value = true
        self:GetBag_UIToggle().startsActive = true
        self:GetBody_UIToggle().value = false
        self:GetBody_UIToggle().startsActive = false

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
        if self.currBagInfoList ~= nil then
            self.currBagInfoList:Clear()
        else
            self.currBagInfoList = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
        end
        for i = 0, tempList.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItem = tempList[i]
            local isFind
            local tbl
            isFind, tbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItem.itemId)
            if tbl ~= nil then
                self.currBagInfoList:Add(bagItem)
            end
        end
    elseif (index == 2) then
        self:GetBag_UIToggle().value = false
        self:GetBag_UIToggle().startsActive = false
        self:GetBody_UIToggle().value = true
        self:GetBody_UIToggle().startsActive = true

        ---@type CSEquipInfoV2
        local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo
        if CS.CSScene.MainPlayerInfo == nil or equipInfo == nil then
            return
        end
        if self.currBagInfoList ~= nil then
            self.currBagInfoList:Clear()
        else
            self.currBagInfoList = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
        end
        local list = equipInfo:GetBodyEquipsList()
        for i = 0, list.Count - 1 do
            local equipData = list[i]
            if equipData ~= nil then
                self.currBagInfoList:Add(equipData)
            end
        end
    elseif (index == 3) then

    end
    self:OnUpdateItems(1)
end

function UISocial_LastChatPanel:OnUpdateItems(index)
    if index < 1 or index > 6 then
        return
    end
    self.curPageIndex = index
    self:GetItemGrid_UIGridContainer().MaxCount = 12
    self:SelectItemWinTog(index - 1)
    local count = (index - 1) * 12;
    for i = 0, 11 do
        local tempGo = self:GetItemGrid_UIGridContainer().controlList[i]
        ---@type UIItem
        local item = tempGo:GetComponent("UIItem")
        CS.UIEventListener.Get(tempGo).onDrag = function(go, delta)
            self.temp_delate_x = self.temp_delate_x + delta.x;
        end
        CS.UIEventListener.Get(tempGo).onDragEnd = function(go)
            if self.temp_delate_x < -self.accuracy then
                if self.curPageIndex < 6 then
                    self.curPageIndex = self.curPageIndex + 1
                    self:OnUpdateItems(self.curPageIndex)
                end
            elseif self.temp_delate_x > self.accuracy then
                if self.curPageIndex > 1 then
                    self.curPageIndex = self.curPageIndex - 1
                    self:OnUpdateItems(self.curPageIndex)
                end
            end
            self.temp_delate_x = 0
            self:GetBagScrollView_UIScrollView():ResetPosition();
            self:GetBagScrollView_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(-10, 25, 0)
        end

        local bagIndex = count + i
        local itemData = {}
        if bagIndex < self.currBagInfoList.Count then
            ---@type bagV2.BagItemInfo
            local bagItemInfo = self.currBagInfoList[bagIndex]
            local isFind
            ---@type TABLE.CFG_ITEMS
            local tbl
            isFind, tbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            if tbl ~= nil then
                ---@type UISprite
                local icon = tempGo.transform:Find("icon").gameObject:GetComponent("UISprite")
                icon.gameObject:SetActive(true)
                icon.spriteName = tbl.icon
                itemData.bagItemInfo = bagItemInfo
                itemData.tbl = tbl
            end
        else
            local icon = tempGo.transform:Find("icon").gameObject:GetComponent("UISprite")
            icon.gameObject:SetActive(false)
        end

        CS.UIEventListener.Get(tempGo).onClick = function(go)
            self:SendItemData(itemData)
        end
    end
    self:GetBagScrollView_UIScrollView():ResetPosition()
    self:GetBagScrollView_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(-10, 25, 0)
end

function UISocial_LastChatPanel:SelectItemWinTog(index)
    local count = Utility.GetLuaTableCount(self.ItemWinTogList)
    ---@type UIToggle
    local tog = self.ItemWinTogList[index]
    if tog ~= nil then
        tog.value = true
        tog.startsActive = true
    end
end

function UISocial_LastChatPanel:SendItemData(itemData)
    if itemData == nil or itemData.tbl == nil then
        return
    end
    ---@type TABLE.CFG_ITEMS
    local tbl = itemData.tbl
    local strName = tbl.name

    strName = self:MatchAndReplaceColor(strName, self.pattern)
    local strValue = "【" .. strName .. "】";
    if self:GetChatInput_UIInput() ~= nil then
        self:GetChatInput_UIInput():InsertText(strValue)
    end
    local count = Utility.GetLuaTableCount(self.chatItemInfos)
    self.chatItemInfos[count] = itemData
    self:GetBtnGroup_GameObject():SetActive(false)
end

function UISocial_LastChatPanel:BagBtnOnClick()
    self:GetEmotionWindow_GameObject():SetActive(false)
    self:GetItemWindow_GameObject():SetActive(true)
    self:SwitchBodyAndBag(1)
end

function UISocial_LastChatPanel:TianJiaOnClick()
    self:GetBtnGroup_GameObject():SetActive(true)
end

function UISocial_LastChatPanel:ItemWindowOnClick()
    self:GetItemWindow_GameObject():SetActive(false)
end

function UISocial_LastChatPanel:OnClickEmotionWindow(go)
    self:GetEmotionWindow_GameObject():SetActive(false)
end

function UISocial_LastChatPanel:EmoticonBtnOnClick()
    self:GetEmotionWindow_GameObject():SetActive(true)
    self:GetItemWindow_GameObject():SetActive(false)

    local grild = self:GetEmotionWindow_GameObject().transform:Find("Grild")
    for i = 0, grild.childCount - 1 do
        CS.UIEventListener.Get(grild:GetChild(i).gameObject).onClick = function(go)
            self:OnClickEmotionGrid(go)
        end
    end
end

function UISocial_LastChatPanel:BtnGroupOnClick()
    self:GetBtnGroup_GameObject():SetActive(false)
end

function UISocial_LastChatPanel:MatchAndReplaceColor(strName, pattern)
    local matches = CS.System.Text.RegularExpressions.Regex.Matches(strName, pattern)
    if matches.Count > 1 then
        local ms0 = string.gsub(matches[0].Value, "[%[%]]", "")
        local ms1 = string.gsub(matches[1].Value, "[%[%]]", "")
        strName = string.gsub(strName, "[%[" .. ms0 .. "%]]", "");
        strName = string.gsub(strName, "[%[" .. ms1 .. "%]]", "");
    end
    return strName
end

--endregion

--region 语音消息功能
--region 播放状态
function UISocial_LastChatPanel:onVoiceBtnPress(go, state)
    if state then
        if self:CheckUseCondition() then
            self.IsAllowUseVoice = true
            self.recordState = LuaEnumRecordState.Record
            uiStaticParameter.voiceMgr:StartRecord(uiStaticParameter.voiceMgr:GetVoicePath(), "", uiStaticParameter.UIChatPanel_SelectIndex, 0, nil, nil)
            self:SetVoiceState(true)
        else
            self.IsAllowUseVoice = false
        end
    else
        self.IsAllowUseVoice = false
        if self.recordState == LuaEnumRecordState.Record then
            uiStaticParameter.voiceMgr:StopRecord()
            self.timerCoroutine = StartCoroutine(function(time)
                self:CalculateTime(time)
            end, 5)
        elseif self.recordState == LuaEnumRecordState.CallOff then
            uiStaticParameter.voiceMgr:CancleRecord()
        end
        self.voicestate.gameObject:SetActive(false)
    end
end

function UISocial_LastChatPanel:onVoiceBtnDrag()
    if self.IsAllowUseVoice then
        local mouseWorldPosition = self.uiCamera:ScreenToWorldPoint(CS.UnityEngine.Input.mousePosition)
        mouseWorldPosition.z = 0
        local btnPosition = self.btn_voice.transform.position
        btnPosition.z = 0
        local distance = CS.UnityEngine.Vector3.Distance(mouseWorldPosition, btnPosition)
        if distance <= 0.15 then
            if self.recordState ~= LuaEnumRecordState.Record then
                self.recordState = LuaEnumRecordState.Record
                uiStaticParameter.voiceMgr:ResumeRecord()
                self:SetVoiceState(true)
            end
        else
            if self.recordState ~= LuaEnumRecordState.CallOff then
                self.recordState = LuaEnumRecordState.CallOff
                uiStaticParameter.voiceMgr:PauseRecord()
                self:SetVoiceState(false)
            end
        end
    end
end

function UISocial_LastChatPanel:SetVoiceState(state)
    self.voicestate.gameObject:SetActive(true)
    self.voiceLabel.gameObject:SetActive(true)
    if (state) then
        self.voicestateReturn.gameObject:SetActive(false)
        self.voiceLabel.text = "正在录音..."
        self.voiceLoading.enabled = true
    else
        self.voicestateReturn.gameObject:SetActive(true)
        self.voiceLabel.text = "取消录音..."
        self.voiceLoading.enabled = false
    end
end
--endregion

--region 限制条件
---使用条件
function UISocial_LastChatPanel:CheckUseCondition()
    local level = CS.CSScene.MainPlayerInfo.Level
    if level <= 75 then
        CS.Utility.ShowRedTips("人物等级不足")
        return false
    end
    if self.usetime > 0 then
        CS.Utility.ShowRedTips("发送太过频繁，请稍后再试")
        return false
    end
    return true
end
--endregion

---使用间隔
function UISocial_LastChatPanel:CalculateTime(time)
    self.usetime = time
    while self.usetime > 0 do
        self.usetime = self.usetime - CS.UnityEngine.Time.deltaTime
        coroutine.yield(0)
    end
end
--endregion

---接收消息
function UISocial_LastChatPanel:OnResChatMessage(id, data)
    data.message = CS.Utility_Lua.ReverseMessage(tostring(data.message))
    if (data.senderId == CS.CSScene.MainPlayerInfo.ID) then
        --自己发送
        if (self.mChatRecordDic[data.privateRoleId] ~= nil) then
            --table.insert(self.mChatRecordDic[data.privateRoleId], data)
            self.mChatRecordDic[data.privateRoleId]:Add(data)
        end
        --self:GetGrild_ChatListView():Init(self.mChatRecordDic[data.privateRoleId])
    else
        --自己接收
        if (self.mChatRecordDic[data.senderId] ~= nil) then
            --列表中已经存在
            --table.insert(self.mChatRecordDic[data.senderId], data)
            self.mChatRecordDic[data.senderId]:Add(data)
        end
        if (self.mCurChooseTem ~= nil) then
            if (self.mCurChooseTem.rid ~= data.senderId) then
                return
            else
                --CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount = CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount - 1 > 0 and CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount - 1 or 0
                if (CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Contains(data.senderId)) then
                    --如果新的列表中有发送者ID
                    uiStaticParameter.UnReadChatCount = uiStaticParameter.UnReadChatCount - 1
                    CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Remove(data.senderId)
                    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SocialChat)
                end
            end
        end
        --self:GetGrild_ChatListView():Init(self.mChatRecordDic[data.senderId])
    end
end

---好友列表排序
function UISocial_LastChatPanel:FriendListSort(index, tem)
    CS.CSScene.MainPlayerInfo.FriendInfoV2:SortListInType(LuaEnumSocialLieBiaoType.ZuiJinLieBiao)
end

---聊天框内头像点击事件
function UISocial_LastChatPanel:HeadIconOnClick(rid)
    if (rid == CS.CSScene.MainPlayerInfo.ID) then
        self.SocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.AddFriendPanel)
    else
        self.SocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.FriendInfoPanel)
        local go = self.SocialContactPanel.GetCurBranchPanel().FriendTemplatesID[rid]
        if (go ~= nil and self.SocialContactPanel.GetCurBranchPanel().FriendTemplates[go] ~= nil) then
            self.SocialContactPanel.GetCurBranchPanel().FriendTemplates[go]:SocialFriendOnClick()
        end
    end
end

function UISocial_LastChatPanel:OnClickEmotionGrid(go)
    self:GetBtnGroup_GameObject():SetActive(false)
    local uisprite = go:GetComponent("UISprite")
    local spriteNmae = uisprite.spriteName
    table.insert(self.faceOldList, spriteNmae)
    spriteNmae = CS.Cfg_EmojiTableManager.Instance:GetEmojiName(spriteNmae);
    table.insert(self.faceNewList, spriteNmae)
    if spriteNmae ~= nil and spriteNmae ~= "" then
        --self:GetChatInput_UIInput().SetValue = self:GetChatInput_UIInput().value.Length
        self:GetChatInput_UIInput():InsertText(spriteNmae)
    end
end

---发送按钮
function UISocial_LastChatPanel:ChatLimit(go)
    if (CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(5)) then
        self:ShowTips(go, 314, "达到" .. tostring(CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(5)) .. "级可在该频道发言")
        return false
    end
end

function UISocial_LastChatPanel:ChatBtnOnClick()
    if (self.mCurChooseTem == nil) then
        CS.Utility.ShowTips("请先选择聊天对象", 1.5, CS.ColorType.Red)
        return
    end
    if (CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(5)) then
        self:ShowTips(self:GetChatBtn_GameObject(), 317, "达到" .. tostring(CS.Cfg_GlobalTableManager.Instance:GetChannelChatLimitLevel(5)) .. "级可在该频道发言")
        return
    end
    local info = self.mCurChooseTem.info

    local faceListCount = Utility.GetLuaTableCount(self.faceOldList)
    for i = 1, faceListCount do
        self:GetChatInput_UIInput().value = CS.Utility_Lua.StringReplace(self:GetChatInput_UIInput().value, self.faceNewList[i], self.faceOldList[i]);
    end
    UISocial_LastChatPanel.faceOldList = {}
    UISocial_LastChatPanel.faceNewList = {}

    local text = self:GetChatInput_UIInput().value
    if text == nil or string.len(text) <= 0 then
        CS.Utility.ShowTips("[ff0000]请输入文字")
        return
    end
    if string.len(CS.NGUIText.StripSymbols(text)) >= CS.Cfg_GlobalTableManager.Instance:GetChatMaxLength() then
        self:ShowTips(self:GetChatBtn_GameObject(), 202)
        return
    end
    --if (CS.CSScene.MainPlayerInfo.BudowillInfo:IsChangeModelAndName(CS.CSScene.MainPlayerInfo.ID)) then
    --    CS.Utility.ShowTips("参赛选手不能发言")
    --    return
    --end

    local chatItemCount = Utility.GetLuaTableCount(self.chatItemInfos)
    for i = 0, chatItemCount - 1 do
        local itemData = self.chatItemInfos[i]
        ---@type bagV2.BagItemInfo
        local bagItemInfo = itemData.bagItemInfo
        ---@type TABLE.CFG_ITEMS
        local tbl = itemData.tbl
        local str_new = ""
        str_new = "[url=event:open|UIItemInfoPanel|0|" .. CS.Utility_Lua.ReverseItemInfoToString(bagItemInfo, CS.CSScene.MainPlayerInfo.ID) .. "|" .. tostring(CS.CSScene.MainPlayerInfo.ID) .. "|" .. tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)) .. "][u]" .. tbl.name .. "[/u][/url]"
        str_new = string.gsub(str_new, "]", "^", 3)
        local str_old = "【" .. tbl.name .. "】"
        str_old = self:MatchAndReplaceColor(str_old, self.pattern)
        if (text == str_old) then
            text = str_new
        else
            str_old = CS.Utility_Lua.StringReplace(str_old, "(", "%(")
            str_old = CS.Utility_Lua.StringReplace(str_old, ")", "%)")
            text = string.gsub(text, str_old, str_new, 1)
        end
    end

    local count = Utility.GetLuaTableCount(self.transMapInfos)
    for i = 0, count - 1 do
        local mapInfo = self.transMapInfos[i]
        --地图色[2bcfed][-]
        --text = string.gsub(text, "-", " ")
        local str_new = string.format("我在[url=find:%d:%d:%d:%d][u][%s %d,%d][/u][/url]",
                mapInfo.mapId, mapInfo.coord.x, mapInfo.coord.y, CS.CSScene.MainPlayerInfo.Line, self:MatchAndReplaceColor(mapInfo.mapName, self.pattern), mapInfo.coord.x, mapInfo.coord.y)
        local str_old = "我的坐标【" .. self:MatchAndReplaceColor(mapInfo.mapName, self.pattern) .. " " .. mapInfo.coord.x .. "," .. mapInfo.coord.y .. "】"
        --str_new = string.gsub(str_new, "-", " ")
        --str_old = string.gsub(str_old, "-", " ")
        str_old = CS.Utility_Lua.StringReplace(str_old, "(", "%(")
        str_old = CS.Utility_Lua.StringReplace(str_old, ")", "%)")
        text = CS.Utility_Lua.StringReplace(text, str_old, str_new)
    end
    self.transMapInfos = {}
    text = CS.Utility_Lua.RemoveStringColor(text)
    networkRequest.ReqChat(5, text, info.rid, false, info.name, 0)

    self:GetChatInput_UIInput().value = ""
    self.chatItemInfos = {}
end
---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UISocial_LastChatPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---好友变化 刷新模板
function UISocial_LastChatPanel:ReFreshTemplateInfo(id, data)
    self:ResFriendList(CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic[LuaEnumSocialLieBiaoType.ZuiJinLieBiao])
    local Length = data.friend.Count
    for k = 0, Length - 1 do
        --变化的好友是当前选中的好友
        if (self.mCurChooseTem ~= nil) then
            if (self.mCurChooseTem.rid == data.friend[k].rid) then
                self.mCurChooseTem:SocialLastChatFriendOnClick(false)
                self.mCurChooseTem:SetBGAndResetCurTem()
            else

            end
            self:GetGrild_ChatListView():Init(self.mChatRecordDic[self.mCurChooseTem.rid])
        end
    end
end

function UISocial_LastChatPanel:SwitchFriendTemplate(id)
    if (self.FriendTemplatesID[id] ~= nil and self.FriendTemplates[self.FriendTemplatesID[id]] ~= nil) then
        self.FriendTemplates[self.FriendTemplatesID[id]]:SocialLastChatFriendOnClick(false)
    else
        local grid = self:GetSocialLastChatList_UIGridContainer()
        grid.MaxCount = grid.MaxCount + 1
        local gos = grid.controlList[grid.MaxCount - 1]
        if (self.FriendTemplates[gos] == nil) then
            self.FriendTemplates[gos] = templatemanager.GetNewTemplate(gos, luaComponentTemplates.UISocialLastChatFriendTemplates, self)
        end
        self.temPrivateID = id
        local info = CS.CSScene.MainPlayerInfo.FriendInfoV2:GetFriend(id)
        self.FriendTemplates[gos]:InitParameters(info)
        self.FriendTemplates[gos]:SetRoleHeadIcon(info.sex, info.career)
        self.FriendTemplatesID[id] = gos
        self.FriendTemplates[gos].index = grid.MaxCount
        self.FriendTemplates[gos]:RefreshUI()
        self.FriendTemplates[gos]:SocialLastChatFriendOnClick(true)
        gos:SetActive(true)
    end
end

function UISocial_LastChatPanel:OnVoiceRecordEnd()
    if (self.voiceTemplate ~= nil) then
        self.voiceTemplate:OnEnd()
    end
end
--endregion

--region 协程
function UISocial_LastChatPanel:IEnumShowDefaultPanel(list)
    coroutine.yield(0.1);
    local Length = list.Count - 1
    if (Length >= 0) then
        --  self.FriendTemplates[self.FriendTemplatesID[list[0].rid]]:SocialLastChatFriendOnClick()
    end
    StopCoroutine(self.mCoroutineShowDefaultPanel);
    self.mCoroutineShowDefaultPanel = nil
end
--endregion

--region OnDestroy
function ondestroy()
    UISocial_LastChatPanel:OnDestroy()
end

function UISocial_LastChatPanel:OnDestroy()
    self.voiceTemplate:SwitchVoiceType(LuaEnumVoiceMessageType.COMMON)
end
--endregion

return UISocial_LastChatPanel