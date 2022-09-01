---@class UISkillIconUnitTemplate:UIBaseTemplate
local UISkillIconUnitTemplate = {};

UISkillIconUnitTemplate.mSkillTable = nil;

--region Components

--region gameObject

function UISkillIconUnitTemplate:GetChoose_GameObject()
    if (self.mChoose_GameObject == nil) then
        self.mChoose_GameObject = self:Get("auto", "GameObject");
    end
    return self.mChoose_GameObject;
end

function UISkillIconUnitTemplate:GetSkillIconEffect_GameObject()
    if (self.mSkillIconEffect_GameObject == nil) then
        self.mSkillIconEffect_GameObject = self:Get("skillIcon/effect", "GameObject");
    end
    return self.mSkillIconEffect_GameObject;
end

--endregion

--region UISprite

function UISkillIconUnitTemplate:GetSkillIcon_UISprite()
    if (self.mSkillIcon_UISprite == nil) then
        self.mSkillIcon_UISprite = self:Get("skillIcon", "UISprite");
    end
    return self.mSkillIcon_UISprite;
end

function UISkillIconUnitTemplate:GetSkillFrame_UISprite()
    if (self.mSkillFrame_UISprite == nil) then
        self.mSkillFrame_UISprite = self:Get("frame", "UISprite");
    end
    return self.mSkillFrame_UISprite;
end

function UISkillIconUnitTemplate:GetSkillType_UISprite()
    if (self.mSkillType_UISprite == nil) then
        self.mSkillType_UISprite = self:Get("typeLogo", "UISprite");
    end
    return self.mSkillType_UISprite;
end

function UISkillIconUnitTemplate:GetSkillIcon_TweenAlpha()
    if (self.mSkillIcon_TweenAlpha == nil) then
        self.mSkillIcon_TweenAlpha = self:Get("skillIcon", "TweenAlpha")
    end
    return self.mSkillIcon_TweenAlpha;
end

--endregion

--region UILabel

function UISkillIconUnitTemplate:GetSkillName_Text()
    if (self.mSkillName_Text == nil) then
        self.mSkillName_Text = self:Get("skillName", "UILabel");
    end
    return self.mSkillName_Text;
end

--endregion

--endregion

--region Method

--region Public

function UISkillIconUnitTemplate:ShowSkill(skillTable, isGray)
    self.mSkillTable = skillTable

    if (isGray == nil) then
        isGray = false;
    end

    if (self.mSkillTable ~= nil) then

        if (self:GetSkillName_Text() ~= nil) then
            self:GetSkillName_Text().text = self.mSkillTable.name;
        end

        if (self:GetSkillIcon_UISprite() ~= nil) then
            self:GetSkillIcon_UISprite().gameObject:SetActive(true);
            self:GetSkillIcon_UISprite().spriteName = self.mSkillTable.icon;
        end

        if (self:GetSkillType_UISprite() ~= nil) then
            self:GetSkillType_UISprite().gameObject:SetActive(false);
        end

        self:SetIconIsGray(isGray);
    end
end

function UISkillIconUnitTemplate:UnShow()
    if (self:GetSkillIcon_UISprite() ~= nil) then
        self:GetSkillIcon_UISprite().gameObject:SetActive(false);
    end
end

function UISkillIconUnitTemplate:SetIconIsGray(isGray)
    if (self:GetSkillIcon_UISprite() ~= nil) then
        self:GetSkillIcon_UISprite().color = isGray and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white;
    end
end

function UISkillIconUnitTemplate:SetIsSelect(isSelect)
    if (self:GetChoose_GameObject() ~= nil) then
        self:GetChoose_GameObject():SetActive(isSelect);
    end
end

function UISkillIconUnitTemplate:PlayTweenAlpha()
    self:GetSkillIcon_TweenAlpha():PlayTween();
end

function UISkillIconUnitTemplate:StopTweenAlpha()
    self:GetSkillIcon_TweenAlpha().enabled = false;
    self:GetSkillIcon_UISprite().alpha = 1;
    self:SetIconIsGray(false);
end

--endregion

--region Private

function UISkillIconUnitTemplate:Clear()
    self.mSkillName_Text = nil;
    self.mSkillType_UISprite = nil;
    self.mSkillFrame_UISprite = nil;
    self.mSkillIcon_UISprite = nil;
    self.mChoose_GameObject = nil;
end

--endregion

--endregion

function UISkillIconUnitTemplate:OnDestroy()
    self:Clear();
end

return UISkillIconUnitTemplate;