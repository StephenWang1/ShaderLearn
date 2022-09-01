---好友信息展示模板
local UISocialFriendInfoTemplates = {}

--region 局部变量

--endregion

--region 组件
function UISocialFriendInfoTemplates.GetffPlayerInfo_GameObject()
    if (self.mPlayerInfo == nil) then
        self.mPlayerInfo = self:Get("bgright/PlayerInfo", "GameObject")
    end
    return self.mPlayerInfo
end

--endregion

--region 初始化
function UISocialFriendInfoTemplates:Init(panel)
    self.UISocial_FriendInfoPanel = panel
    self:InitComponents()
    self:BindUIEvents()
    self.index = 0
end

function UISocialFriendInfoTemplates:InitComponents()
    self.icon_UISprite = self:Get("icon", "Top_UISprite")
    self.name_UILabel = self:Get("name", "Top_UILabel")
    self.level_UILabel = self:Get("level", "Top_UILabel")
    self.contact_UILabel = self:Get("contact", "Top_UILabel")
    self.di_GameObject = self:Get("check", "GameObject")
    self.bg = self:Get("background", "GameObject")
    self.menu = nil
    self.friendShip_GameObject = self:Get("haogandu", "GameObject")
    self.friendShip_Sprite = self:Get("haogandu", "UISprite")
    self.friendShip_UILabel = self:Get("haogandu/shuzhi", "Top_UILabel")
    self.HeadLetter_UILabel = self:Get("icon/letter", "Top_UILabel")
    self.DeleteBtn_GameObject = self:Get("btn_del", "GameObject")
end

function UISocialFriendInfoTemplates:InitParameters(info)
    self.info = info
    self.rid = info.rid
    self.name = info.name
    if (info.rid == CS.CSScene.MainPlayerInfo.ID) then
        self.friendShip_GameObject:SetActive(false)
    else
        self.friendShip_GameObject:SetActive(true)
    end
end

--region 好友列表界面
function UISocialFriendInfoTemplates:BindUIEvents()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.SocialFriendOnClick
end

--endregion

--region 事件
function UISocialFriendInfoTemplates:SocialFriendOnClick()
    if (self.UISocial_FriendInfoPanel.mAddBtncheck ~= nil) then
        self.UISocial_FriendInfoPanel.mAddBtncheck:SetActive(false)
    end
    if (self.UISocial_FriendInfoPanel:GetSearchInfoRoot_GameObject() ~= nil) then
        self.UISocial_FriendInfoPanel:GetSearchInfoRoot_GameObject():SetActive(false)
    end

    if (self.UISocial_FriendInfoPanel.mCurChooseTem ~= nil and self.UISocial_FriendInfoPanel.mCurChooseTem ~= self) then
        self.UISocial_FriendInfoPanel.mCurChooseTem.di_GameObject:SetActive(false)
    end
    self.di_GameObject:SetActive(true)
    self.UISocial_FriendInfoPanel.mCurChooseTem = self
    networkRequest.ReqLookFriendInfo(self.rid)
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareHasPlayerSomeInfo(self.rid)
    else
        networkRequest.ReqHasPlayerSomeInfo(self.rid)
    end
    self.UISocial_FriendInfoPanel:GetMyFriendPlayerInfoOther_UIInput().value = ""

end
--endregion

--region 刷新UI
function UISocialFriendInfoTemplates:RefreshUI()
    if (self.name_UILabel ~= nil) then
        self.name_UILabel.text = self.info.name
    end
    if (self.level_UILabel ~= nil) then
        self.level_UILabel.text = self.info.level
    end
    if (self.contact_UILabel ~= nil) then
        if (self.info.relation == LuaEnumSocialFriendRelationType.Brother or self.info.relation == LuaEnumSocialFriendRelationType.Spouse) then
            self.contact_UILabel.text = uiStaticParameter.FriendRelation[self.info.relation]
        else
            self.contact_UILabel.text = ""
        end
    end
    if (self.friendShip_UILabel ~= nil) then
        if (self.info.friendLove < 0) then
            self.friendShip_Sprite.spriteName = "hatred"
        else
            self.friendShip_Sprite.spriteName = "redxin"
        end
        self.friendShip_UILabel.text = math.abs(self.info.friendLove)
    end
    if (self.bg ~= nil) then
        self.bg:SetActive(self.index % 2 == 0)
    end
    if (CS.System.String.IsNullOrEmpty(self.info.roleLettering)) then
        self.HeadLetter_UILabel.gameObject:SetActive(false)
    else
        self.HeadLetter_UILabel.gameObject:SetActive(true)
        self.HeadLetter_UILabel.text = self.info.roleLettering
    end
end

function UISocialFriendInfoTemplates:SocialContactRefreshUI()
    if (self.name_UILabel ~= nil) then
        self.name_UILabel.text = self.info.name
    end
    if (self.level_UILabel ~= nil) then
        self.level_UILabel.text = self.info.level
    end
end

function UISocialFriendInfoTemplates:SetRoleHeadIcon(sex, career)
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

function UISocialFriendInfoTemplates:SetPlayerDetails()

end
--endregion

--region 好友列表界面


--endregion

--region 服务器消息处理

--endregion

return UISocialFriendInfoTemplates

