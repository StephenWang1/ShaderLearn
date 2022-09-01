local UILeftSecretaryHeadTemplates = {}

function UILeftSecretaryHeadTemplates:InitComponents()
    self.name_UILabel = self:Get("name", "UILabel")
    self.icon = self:Get("icon", "Top_UISprite")
    self.time = self:Get("time", "UILabel")
    self.chatinfo = self:Get("chatinfo", "UILabel")
    self.secretaryName = self:Get("secretaryName", "UILabel")
    self.di_GameObject = self:Get("check/di1", "GameObject")
    self.slh_GameObject = self:Get("slh", "GameObject")
    self.level_UILabel = self:Get("level", "Top_UILabel")
    self.mRedPointComponent = self:Get("redpoint", "UIRedPoint");
end
function UILeftSecretaryHeadTemplates:InitOther()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClick

    self.secretaryName.gameObject:SetActive(false)
    self.level_UILabel.gameObject:SetActive(false)

    self.name_UILabel.gameObject:SetActive(true)
    self.chatinfo.gameObject:SetActive(true)
    self.time.gameObject:SetActive(true)
    self.name_UILabel.text="小敏姐姐"
    self.chatinfo.text =CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalk();
    self.time.text =CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalkTime();
    self.slh_GameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
    self.mRedPointComponent:AddRedPointKey(CS.RedPointKey.Secretary)
    self.icon.spriteName="headicon99"
end

function UILeftSecretaryHeadTemplates:Init()
    self:InitComponents()
    self:InitOther()
    self:Show()
end

function UILeftSecretaryHeadTemplates:Show()
    local isShow = true;
    local isChatRead = CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.SocialChat)
    if uiStaticParameter.PrivateChatID ~= 0 or isChatRead then
        isShow = false;
    end
    CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = isShow;
end

function UILeftSecretaryHeadTemplates:PartialRefresh()
    self.chatinfo.text =CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalk();
    self.time.text =CS.CSScene.MainPlayerInfo.SecretaryInfo:GetLastTalkTime();
    self.slh_GameObject:SetActive(CS.Utility_Lua.ParseLastInfoWithToLong(self.chatinfo))
    if CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel then
        CS.CSScene.MainPlayerInfo.SecretaryInfo.isHaveNewpush = false
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Secretary);
    end
    self.di_GameObject.gameObject:SetActive(CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel)
end

function UILeftSecretaryHeadTemplates:OnClick()
    CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel = true
end
return UILeftSecretaryHeadTemplates