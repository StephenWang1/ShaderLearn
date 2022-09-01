local UISocial_FriendCirclePanel = {}

--region Components

function UISocial_FriendCirclePanel:GetCircleOfFriendsViewTemplate_GameObject()
    return self.go;
end

function UISocial_FriendCirclePanel:GetCircleOfFriendsViewTemplate()
    if (self.mCircleOfFriendsViewTemplate == nil) then
        self.mCircleOfFriendsViewTemplate = templatemanager.GetNewTemplate(self:GetCircleOfFriendsViewTemplate_GameObject(), luaComponentTemplates.UICircleOfFriendsViewTemplate, self.mOwnerPanel)
    end
    return self.mCircleOfFriendsViewTemplate;
end

--endregion

---@param panel UISocialContactPanel
function UISocial_FriendCirclePanel:Init(panel)
    self.mOwnerPanel = panel
end

function UISocial_FriendCirclePanel:Show(customData)
    self.go:SetActive(true)
    self:GetCircleOfFriendsViewTemplate():UpdateView(customData);
end

function UISocial_FriendCirclePanel:Hide()
    self.go:SetActive(false)
    self:GetCircleOfFriendsViewTemplate():HideView();
end

--region 刷新
function UISocial_FriendCirclePanel:ResFriendList(list)

end

function UISocial_FriendCirclePanel:ReFreshTemplateInfo(id, csdata)

end
--endregion

function UISocial_FriendCirclePanel:OnDestroy()
    self.mCircleOfFriendsViewTemplate = nil;
end

return UISocial_FriendCirclePanel