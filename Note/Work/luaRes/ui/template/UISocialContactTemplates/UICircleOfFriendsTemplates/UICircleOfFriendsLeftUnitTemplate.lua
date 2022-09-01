local UICircleOfFriendsLeftUnitTemplate = {};

UICircleOfFriendsLeftUnitTemplate.mFriendVo = nil;

--region Components

function UICircleOfFriendsLeftUnitTemplate:GetBtnSelf_GameObject()
    return self.go;
end

function UICircleOfFriendsLeftUnitTemplate:GetPlayerName_Text()
    if(self.mPlayerName_Text == nil) then
        self.mPlayerName_Text = self:Get("name", "UILabel");
    end
    return self.mPlayerName_Text;
end

function UICircleOfFriendsLeftUnitTemplate:GetPlayerRelation_Text()
    if(self.mPlayerRelation_Text == nil) then
        self.mPlayerRelation_Text = self:Get("contact", "UILabel");
    end
    return self.mPlayerRelation_Text;
end

function UICircleOfFriendsLeftUnitTemplate:GetPlayerIcon_UISprite()
    if(self.mPlayerIcon_UISprite == nil) then
        self.mPlayerIcon_UISprite = self:Get("icon","UISprite");
    end
    return self.mPlayerIcon_UISprite;
end

function UICircleOfFriendsLeftUnitTemplate:GetUpdateCircleText_GameObject()
    if(self.mUpdateCircleText_GameObject == nil) then
        self.mUpdateCircleText_GameObject = self:Get("dynamicinfo", "GameObject")
    end
    return self.mUpdateCircleText_GameObject;
end

function UICircleOfFriendsLeftUnitTemplate:GetBackGround_GameObject()
    if(self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("background","GameObject");
    end
    return self.mBackGround_GameObject;
end

function UICircleOfFriendsLeftUnitTemplate:GetChoose_GameObject()
    if(self.mChoose_GameObject == nil) then
        self.mChoose_GameObject = self:Get("check","GameObject");
    end
    return self.mChoose_GameObject;
end

--endregion

--region Method

--region Public

function UICircleOfFriendsLeftUnitTemplate:UpdateUnit(mFriendVo, index)
    self.mFriendVo = mFriendVo;
    self:GetBackGround_GameObject():SetActive(index % 2 == 0);
    self:GetChoose_GameObject():SetActive(false);
    self:UpdateUI();
end

function UICircleOfFriendsLeftUnitTemplate:UpdateUI()
    if(self.mFriendVo ~= nil) then
        local relationStr = Utility.GetRelationName(self.mFriendVo.relation);
        relationStr = relationStr == "" and relationStr or relationStr;
        self:GetPlayerName_Text().text = luaEnumColorType.White..self.mFriendVo.name;
        self:GetPlayerRelation_Text().gameObject:SetActive(relationStr ~= "");
        self:GetPlayerRelation_Text().text = relationStr;
        self:GetPlayerIcon_UISprite().spriteName = Utility.GetPlayerHeadIconSpriteName(self.mFriendVo.sex, self.mFriendVo.career)
    end
end

--endregion

--region Private

function UICircleOfFriendsLeftUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnSelf_GameObject()).onClick = function()
        luaEventManager.DoCallback(LuaCEvent.Friend_OnCircleOfFriendsUpdateTipsClick,self.mFriendVo);
    end
end

function UICircleOfFriendsLeftUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UICircleOfFriendsLeftUnitTemplate:Init()
    self:InitEvents();
end

function UICircleOfFriendsLeftUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UICircleOfFriendsLeftUnitTemplate;