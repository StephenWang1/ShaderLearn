local UISocialLastChatFriendTemplates = {}

--region 局部变量

--endregion

--region 组件

--endregion

--region 初始化
function UISocialLastChatFriendTemplates:Init(panel)
    self.UISocial_LastChatPanel = panel
    self:InitComponents()
    self:BindUIEvents()
    self.index = 0
end

function UISocialLastChatFriendTemplates:InitComponents()
    self.icon_UISprite = self:Get("icon", "UISprite")
    self.icon_Go = self:Get("icon", "GameObject")
    self.name_UILabel = self:Get("name", "UILabel")
    self.level_UILabel = self:Get("level", "UILabel")
    self.time = self:Get("time", "UILabel")
    self.chatinfo = self:Get("chatinfo", "UILabel")
    self.slh_gameObject = self:Get("slh", "GameObject")
    self.bg = self:Get("background/di1", "GameObject")
    self.di_GameObject = self:Get("check/di1", "GameObject")
    self.unread_GameObject = self:Get("unread", "GameObject")
    self.unreadnum_UILabel = self:Get("unread/unreadnum", "UILabel")
    self.HeadLetter_UILabel = self:Get("icon/letter", "UILabel")
end

function UISocialLastChatFriendTemplates:InitParameters(info)
    self.info = info
    self.rid = info.rid
    self.rolename = info.name
    if self:IsSecretaryType() then
        self:Secretary_InitParameters()
        return
    end
    if (info.latelyChat ~= nil) then
        if (info.latelyChat.time == 0) then
            self.time.text = ""
        else
            self.time.text = CS.Utility_Lua.GetChatInfoIntervalTime(info.latelyChat.time)
        end
    else
        self.time.text = ""
    end
    if (info.unreadNum ~= nil) then
        if (info.unreadNum > 0) then
            self.unread_GameObject:SetActive(true)
            self.unreadnum_UILabel.text = info.unreadNum
            self.chatinfo.text = "[未读]" .. CS.Utility_Lua.ParseLastChatInfoNews(info.latelyChat, self.chatinfo)
            self.slh_gameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
        else
            self.unread_GameObject:SetActive(false)
            self.unreadnum_UILabel.text = self.info.unreadNum
            if (info.latelyChat ~= nil) then
                self.chatinfo.text = CS.Utility_Lua.ParseLastChatInfoNews(info.latelyChat, self.chatinfo)
            else
                self.chatinfo.text = ""
            end
            self.slh_gameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
        end
    else
        self.unread_GameObject:SetActive(false)
        self.unreadnum_UILabel.text = ""
        self.chatinfo.text = ""
        self.slh_gameObject:SetActive(false)
    end

end

function UISocialLastChatFriendTemplates:BindUIEvents()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.SocialLastChatFriendOnClick
    CS.UIEventListener.Get(self.icon_Go).LuaEventTable = self
    CS.UIEventListener.Get(self.icon_Go).OnClickLuaDelegate = self.HeadIconClick
end
--endregion

--region 界面刷新
function UISocialLastChatFriendTemplates:RefreshUI()
    if self:IsSecretaryType() then
        return
    end
    if (self.name_UILabel ~= nil) then
        --if (CS.System.String.IsNullOrEmpty(self.info.remark)) then
        self.name_UILabel.text = self.info.name
        --else
        --    self.name_UILabel.text = self.info.remark
        --end
    end
    if (self.level_UILabel ~= nil) then
        self.level_UILabel.text = self.info.level
    end
    if (self.haogan_UILabel ~= nil) then
        self.haogan_UILabel.text = self.info.friendLove
    end
    if (self.contact_UILabel ~= nil) then
        self.contact_UILabel.text = uiStaticParameter.FriendRelation[self.info.relation]
    end
    if (self.bg ~= nil) then
        self.bg:SetActive(self.index % 2 == 0)
    end
    if self.di_GameObject ~= nil and self.UISocial_LastChatPanel.mCurChooseTem ~= self then
        self.di_GameObject:SetActive(false)
    end
    if (CS.System.String.IsNullOrEmpty(self.info.roleLettering)) then
        self.HeadLetter_UILabel.gameObject:SetActive(false)
    else
        self.HeadLetter_UILabel.gameObject:SetActive(true)
        self.HeadLetter_UILabel.text = self.info.roleLettering
    end
end

function UISocialLastChatFriendTemplates:PartialRefresh()
    if self:IsSecretaryType() then
        return
    end
    if (self.di_GameObject ~= nil) and CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel then
        self.di_GameObject:SetActive(false)
    end
end

function UISocialLastChatFriendTemplates:RefreshUIChatInfo()
    if self:IsSecretaryType() then
        return
    end
    if (self.UISocial_LastChatPanel.mCurChooseTem == self) then
        self.unread_GameObject:SetActive(false)
        if (self.info.latelyChat.time == 0) then
            self.time.text = ""
        else
            self.time.text = CS.Utility_Lua.GetChatInfoIntervalTime(self.info.latelyChat.time)
        end
        self.chatinfo.text = CS.Utility_Lua.ParseLastChatInfoNews(self.info.latelyChat, self.chatinfo)
        self.slh_gameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
        self.unreadnum_UILabel.text = self.info.unreadNum
        --if (self.info.unreadNum ~= 0) then
        --    networkRequest.ReqSetRead(self.rid)
        --end
    else
        self.unread_GameObject:SetActive(true)
        if (self.info.latelyChat.time == 0) then
            self.time.text = ""
        else
            self.time.text = CS.Utility_Lua.GetChatInfoIntervalTime(self.info.latelyChat.time)
        end
        self.chatinfo.text = "[未读]" .. CS.Utility_Lua.ParseLastChatInfoNews(self.info.latelyChat, self.chatinfo)
        self.slh_gameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
        self.unreadnum_UILabel.text = tonumber(self.unreadnum_UILabel.text) + 1
    end
end

function UISocialLastChatFriendTemplates:SetRoleHeadIcon(sex, career)
    if self:IsSecretaryType() then
        return
    end
    self.sex = sex;
    self.career = career;
    self.icon_UISprite.spriteName = "headicon" .. sex .. career
    if (self.info ~= nil) then
        if (self.info.isOnline) then
            self.icon_UISprite.color = CS.UnityEngine.Color.white
        else
            self.icon_UISprite.color = CS.UnityEngine.Color.black
        end
    end
end
--endregion

--region 事件
function UISocialLastChatFriendTemplates:HeadIconClick()
    if self:IsSecretaryType() then
        return
    end
    CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_Social_ClickFriendHeadInLastChat, self.rid)
end

function UISocialLastChatFriendTemplates:SocialLastChatFriendOnClick(IsNew)
    if self:IsSecretaryType() then
        self:Secretary_OnClick()
        return
    end
    self.di_GameObject:SetActive(true)
    CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = false
    if (self.UISocial_LastChatPanel.mCurChooseTem == self) then
        if (self.info.unreadNum > 0) then
            networkRequest.ReqPersonalChat(self.rid)
        end
        return
    end
    --if (self.info.unreadNum ~= 0) then
    --    networkRequest.ReqSetRead(self.rid)
    --end

    if (self.UISocial_LastChatPanel.mCurChooseTem ~= nil) then
        self.UISocial_LastChatPanel.mCurChooseTem.di_GameObject:SetActive(false)
        self.UISocial_LastChatPanel.mCurChooseTem:RefreshUI()
    end
    self.UISocial_LastChatPanel.mCurChooseTem = self
    self.UISocial_LastChatPanel:ReFreshUIPanel()
    if (self.info.latelyChat ~= nil) then
        self.chatinfo.text = CS.Utility_Lua.ParseLastChatInfoNews(self.info.latelyChat, self.chatinfo)
    else
        self.chatinfo.text = ""
    end
    self.slh_gameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
    if (IsNew ~= nil and IsNew == true) then
        self.UISocial_LastChatPanel:GetGrild_ChatListView():Init()
    else
        if (self.info.unreadNum > 0) then
            networkRequest.ReqPersonalChat(self.rid)
            --CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount = CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount - self.info.unreadNum > 0 and CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount - self.info.unreadNum or 0
            uiStaticParameter.UnReadChatCount = uiStaticParameter.UnReadChatCount - self.info.unreadNum > 0 and uiStaticParameter.UnReadChatCount - self.info.unreadNum or 0
            CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_SocialChatCount, uiStaticParameter.UnReadChatCount);
        else
            if (self.UISocial_LastChatPanel.mChatRecordDic[self.rid] ~= nil) then
                self.UISocial_LastChatPanel:GetGrild_ChatListView():Init(self.UISocial_LastChatPanel.mChatRecordDic[self.rid])
            else
                if (self.info.latelyChat ~= nil) then
                    networkRequest.ReqPersonalChat(self.rid)
                end
            end
        end
    end

    if (CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Contains(self.rid)) then
        CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Remove(self.rid)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SocialChat)
    end

    if self.UISocial_LastChatPanel.voiceTemplate ~= nil and self.UISocial_LastChatPanel.voiceTemplate.SetPrivateRoleId ~= nil then
        self.UISocial_LastChatPanel.voiceTemplate:SetPrivateRoleId(self.rid, self.info.name)
        self.UISocial_LastChatPanel.voiceTemplate:SwitchVoiceType(LuaEnumVoiceMessageType.COMMON)
    end
end

function UISocialLastChatFriendTemplates:SetBGAndResetCurTem()
    -- if self:IsSecretaryType() then
    --     return
    -- end
    self.UISocial_LastChatPanel.mCurChooseTem.di_GameObject:SetActive(false)
    --self.UISocial_LastChatPanel.mCurChooseTem = self
    self.UISocial_LastChatPanel.mCurChooseTem.di_GameObject:SetActive(true)
end
--endregion

--region 小秘书
---data  friendV2.FriendInfo
function UISocialLastChatFriendTemplates:IsSecretaryType()
    -- if  true then
    --     return false
    -- end
    if self.info == nil then
        return false
    end
    if self.info.relation == 9999 then
        return true
    else
        return false
    end
end

function UISocialLastChatFriendTemplates:Secretary_InitParameters()
    self.level_UILabel.gameObject:SetActive(false)

    self.name_UILabel.gameObject:SetActive(true)
    self.chatinfo.gameObject:SetActive(true)
    self.time.gameObject:SetActive(true)
    self.name_UILabel.text = "小敏姐姐"
    self.chatinfo.text = CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalk();
    self.time.text = CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalkTime();
    self.slh_gameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
    -- self.mRedPointComponent:AddRedPointKey(CS.RedPointKey.Secretary)
    self.icon_UISprite.spriteName = "headicon99"
    self.icon_UISprite.color = CS.UnityEngine.Color.white

    -- local isShow = true;
    -- local isChatRead = CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.SocialChat)
    -- if uiStaticParameter.PrivateChatID ~= 0 or isChatRead then
    --     isShow = false;
    -- end
    -- CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = isShow;
end

function UISocialLastChatFriendTemplates:Secretary_InitOpen(isShow)
    --local isShow = true;
    local isChatRead = CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.SocialChat)
    if uiStaticParameter.PrivateChatID ~= 0 or isChatRead then
        isShow = false;
    end
    -- -- print("小秘书：",isShow)
    CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = isShow;
    self.di_GameObject.gameObject:SetActive(isShow)
end

function UISocialLastChatFriendTemplates:Secretary_PartialRefresh()
    self.chatinfo.text = CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalk();
    self.time.text = CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalkTime();
    self.slh_gameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
    if CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel then
        CS.CSScene.MainPlayerInfo.SecretaryInfo.isHaveNewpush = false
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Secretary);
    end
    self.di_GameObject.gameObject:SetActive(CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel)
end

function UISocialLastChatFriendTemplates:Secretary_OnClick()
    CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = true
end

--endregion

return UISocialLastChatFriendTemplates