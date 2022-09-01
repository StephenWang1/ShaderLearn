local UIApproveFriendInfoTemplates = {}

--region 局部变量

--endregion

--region 组件

--endregion

--region 初始化
function UIApproveFriendInfoTemplates:Init(panel)
    self.panel = panel
    self.index = 0
    self:InitComponents()
    self:BindUIEvents()
end

function UIApproveFriendInfoTemplates:InitParameters(info)
    self.info = info
    self.rid = info.rid
    self.rolename = info.name
end

function UIApproveFriendInfoTemplates:InitComponents()
    self.icon_UISprite = self:Get("icon", "UISprite")
    self.icon_GameObject = self:Get("icon", "GameObject")
    self.name_UILabel = self:Get("name", "UILabel")
    self.level_UILabel = self:Get("level", "UILabel")
    self.bg = self:Get("background", "GameObject")
    self.di_GameObject = self:Get("background", "GameObject")
    self.redPoint = self:Get("redpoint", "GameObject")
    self.addbtn_GameObject = self:Get("btn_agreejoin", "GameObject")
    self.joininfo = self:Get("Joininfo", "UILabel")
    self.HeadLetter_UILabel = self:Get("icon/letter", "UILabel")
end

function UIApproveFriendInfoTemplates:BindUIEvents()
    CS.UIEventListener.Get(self.addbtn_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.addbtn_GameObject).OnClickLuaDelegate = self.ConsentBtnOnClick
    CS.UIEventListener.Get(self.icon_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.icon_GameObject).OnClickLuaDelegate = self.IconOnClick
end
--endregion

--region 事件
function UIApproveFriendInfoTemplates:IconOnClick()
    self.panel.SocialContactPanel:GetLastChatPanelBtn_UISprite().value = false
    self.panel.SocialContactPanel:GetFriendInfoPanelBtn_UISprite().value = true
    self.panel.SocialContactPanel.SwitchSocialPanel(LuaEnumSocialFriendPanelType.FriendInfoPanel)
    local go = self.panel.SocialContactPanel.GetCurBranchPanel().FriendTemplatesID[self.rid]
    if (go ~= nil and self.panel.SocialContactPanel.GetCurBranchPanel().FriendTemplates[go] ~= nil) then
        self.panel.SocialContactPanel.GetCurBranchPanel().FriendTemplates[go]:SocialFriendOnClick()
    end
end
--endregion

--region 刷新界面
function UIApproveFriendInfoTemplates:RefreshUI()
    if (self.name_UILabel ~= nil) then
        self.name_UILabel.text = self.info.name
    end
    if (self.level_UILabel ~= nil) then
        self.level_UILabel.text = self.info.level
    end
    if (self.di_GameObject ~= nil) then
        self.di_GameObject:SetActive(false)
    end
    if (self.info.isReceive) then
        self.joininfo.text = "已添加"
        self.addbtn_GameObject:SetActive(false)
    else
        self.joininfo.text = "请求添加"
        self.addbtn_GameObject:SetActive(true)
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
function UIApproveFriendInfoTemplates:SetRoleHeadIcon(sex, career)
    self.sex = sex;
    self.career = career;
    self.icon_UISprite.spriteName = "headicon" .. sex .. career
end
--endregion

return UIApproveFriendInfoTemplates