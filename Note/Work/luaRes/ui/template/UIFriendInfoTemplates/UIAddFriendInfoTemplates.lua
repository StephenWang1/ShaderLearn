---好友信息展示模板
local UIAddFriendInfoTemplates = {}

function UIAddFriendInfoTemplates.GetUISocialContactPanel()
    local panel = uimanager:GetPanel("UISocialContactPanel")
    if (panel ~= nil) then
        return panel
    end
end
--region 初始化
function UIAddFriendInfoTemplates:Init(panel)
    self.panel = panel
    self:InitComponents()
    self.index = 0
end

function UIAddFriendInfoTemplates:InitComponents()
    self.icon_UISprite = self:Get("icon", "UISprite")
    self.name_UILabel = self:Get("name", "UILabel")
    self.level_UILabel = self:Get("level", "UILabel")
    self.di_GameObject = self:Get("background", "GameObject")
    self.redPoint = self:Get("redpoint", "GameObject")
    self.addbtn_GameObject = self:Get("btn_jieshou", "GameObject")
    self.tongyibtn_GameObject = self:Get("btn_tongyi", "GameObject")
    self.juejuebtn_GameObject = self:Get("btn_jujue", "GameObject")
    self.addbtnLabel_UILabel = self:Get("btn_jieshou/Label", "UILabel")
    self.isReceive_GameObject = self:Get("successadd", "GameObject")
    self.knowcause = self:Get("info", "UILabel")
    self.menu = nil
    self.knowcausetype = nil
    self.HeadLetter_UILabel = self:Get("icon/letter", "UILabel")
end

function UIAddFriendInfoTemplates:InitParameters(info)
    self.info = info
    self.listID = info.rid
    self.rolename = info.name
end

--region 好友列表界面

--endregion

--region 事件
function UIAddFriendInfoTemplates:RespondBtnonClickEvent(responCallback)
    self.mresponCallback = responCallback
end

function UIAddFriendInfoTemplates:AddFriendBtnonClickEvent(addFriendCallback)
    self.mAddFriendCallback = addFriendCallback
end
--endregion

--region 刷新UI
function UIAddFriendInfoTemplates:RefreshApplyUI()
    if (self.name_UILabel ~= nil) then
        self.name_UILabel.text = self.info.name
    end
    if (self.level_UILabel ~= nil) then
        self.level_UILabel.text = self.info.level
    end
    --if (self.di_GameObject ~= nil) then
    --    self.di_GameObject:SetActive(false)
    --end
    if (self.knowcause ~= nil and self.knowcausetype ~= nil) then
        self.addbtnLabel_UILabel.text = "添加"
        self.addbtn_GameObject:SetActive(true)
        self.tongyibtn_GameObject:SetActive(false)
        self.juejuebtn_GameObject:SetActive(false)
        self.isReceive_GameObject:SetActive(false)
        self.knowcause.text = uiStaticParameter.MayKnowFriendCause[self.knowcausetype]
    else
        --self.addbtnLabel_UILabel.text = "同意"
        if (self.info.isReceive) then
            self.addbtn_GameObject:SetActive(false)
            self.tongyibtn_GameObject:SetActive(false)
            self.juejuebtn_GameObject:SetActive(false)
            self.isReceive_GameObject:SetActive(true)
        else
            self.tongyibtn_GameObject:SetActive(true)
            self.juejuebtn_GameObject:SetActive(true)
            self.addbtn_GameObject:SetActive(false)
            self.isReceive_GameObject:SetActive(false)
        end
        self.knowcause.text = "请求添加你为好友"
    end

    if (self.HeadLetter_UILabel ~= nil) then
        if (CS.System.String.IsNullOrEmpty(self.info.roleLettering)) then
            self.HeadLetter_UILabel.gameObject:SetActive(false)
        else
            self.HeadLetter_UILabel.gameObject:SetActive(true)
            self.HeadLetter_UILabel.text = self.info.roleLettering
        end
    end
end

function UIAddFriendInfoTemplates:RefreshAddUI()
    if (self.addbtnLabel_UILabel ~= nil) then
        self.addbtnLabel_UILabel.text = "添加"
    end
    if (self.name_UILabel ~= nil) then
        self.name_UILabel.text = self.info.name
    end
    if (self.level_UILabel ~= nil) then
        self.level_UILabel.text = self.info.level
    end
    --if (self.di_GameObject ~= nil) then
    --    self.di_GameObject:SetActive(false)
    --end
    if (self.knowcause ~= nil) then
        self.knowcause.text = "查询到的玩家"
    end
    if (self.HeadLetter_UILabel ~= nil) then
        if (CS.System.String.IsNullOrEmpty(self.info.roleLettering)) then
            self.HeadLetter_UILabel.gameObject:SetActive(false)
        else
            self.HeadLetter_UILabel.gameObject:SetActive(true)
            self.HeadLetter_UILabel.text = self.info.roleLettering
        end
    end
end

function UIAddFriendInfoTemplates:SocialContactRefreshUI()
    if (self.name_UILabel ~= nil) then
        self.name_UILabel.text = self.info.name
    end
    if (self.level_UILabel ~= nil) then
        self.level_UILabel.text = self.info.level
    end
end

function UIAddFriendInfoTemplates:SetRoleHeadIcon(sex, career)
    self.sex = sex;
    self.career = career;
    self.icon_UISprite.spriteName = "headicon" .. sex .. career
end
--endregion

--region 申请好友界面
function UIAddFriendInfoTemplates:BindAddUIEvents()
    CS.UIEventListener.Get(self.addbtn_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.addbtn_GameObject).OnClickLuaDelegate = self.AddFriendBtnOnClick
end

function UIAddFriendInfoTemplates:BindMayUIEvents()
    CS.UIEventListener.Get(self.addbtn_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.addbtn_GameObject).OnClickLuaDelegate = self.AddMayFriendBtnOnClick
end

function UIAddFriendInfoTemplates:BindApplyUIEvents()
    CS.UIEventListener.Get(self.tongyibtn_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.tongyibtn_GameObject).OnClickLuaDelegate = self.ConsentBtnOnClick
    CS.UIEventListener.Get(self.juejuebtn_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.juejuebtn_GameObject).OnClickLuaDelegate = self.ConfuseBtnOnClick
end

---添加好友（查询到的）
function UIAddFriendInfoTemplates:AddFriendBtnOnClick()
    networkRequest.ReqAddFriend(LuaEnumSocialLieBiaoType.HaoYouLieBiao, self.info.rid)
    self.panel:GetAddFriendList_UIGridContainer():ClearItem(self.index)
    self.panel:RefreshAddControListTemIndex()
end

---添加可能认识的好友（系统推荐）
function UIAddFriendInfoTemplates:AddMayFriendBtnOnClick()
    networkRequest.ReqAddFriend(LuaEnumSocialLieBiaoType.HaoYouLieBiao, self.info.rid)
    CS.CSScene.MainPlayerInfo.FriendInfoV2:RemoveMayKnowFriend(self.info.rid)
    networkRequest.ReqMayKnowFriend()
    --self.panel:GetMayKnowFriendList_UIGridContainer():ClearItem(self.index)
    --self.panel:ResFriendList(LuaEnumSocialLieBiaoType.ShenQingLieBiao)
end

---同意添加好友（对方主动添加）
function UIAddFriendInfoTemplates:ConsentBtnOnClick()
    local list = CS.System.Collections.Generic["List`1[System.Int64]"]()
    list:Add(self.info.rid)
    self.panel.isJumpToFriend = true

    networkRequest.ReqCheckApply(list, true)
    if (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FriendApply)) then
        CS.CSScene.MainPlayerInfo.ChatInfoV2.NewFriendApplyList:Remove(1)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.FriendApply)
    end
end

---拒绝添加好友（对方主动添加）
function UIAddFriendInfoTemplates:ConfuseBtnOnClick()
    local list = CS.System.Collections.Generic["List`1[System.Int64]"]()
    list:Add(self.info.rid)
    networkRequest.ReqCheckApply(list, false)
    if (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FriendApply)) then
        CS.CSScene.MainPlayerInfo.ChatInfoV2.NewFriendApplyList:Remove(1)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.FriendApply)
    end
end
--endregion

return UIAddFriendInfoTemplates

