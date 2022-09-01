local UIAttributeChangeUnitTemplate = {};

--setmetatable(UIAttributeChangeUnitTemplate, luaComponentTemplates.UIAttributeChangeUnitTweenTemplate);

--region Components

--region UILabel
function UIAttributeChangeUnitTemplate:GetAttributeName_Text()
    if (self.mAttributeName_Text == nil) then
        self.mAttributeName_Text = self:Get("lb_name", "UILabel");
    end
    return self.mAttributeName_Text;
end

function UIAttributeChangeUnitTemplate:GetAttributeValue_Text()
    if (self.mAttributeValue_Text == nil) then
        self.mAttributeValue_Text = self:Get("lb_value", "UILabel");
    end
    return self.mAttributeValue_Text;
end
--endregion

function UIAttributeChangeUnitTemplate:GetAttributeBG_UISprite()
    if (self.mAttributeBG_UISprite == nil) then
        self.mAttributeBG_UISprite = self:Get("bg", "UISprite");
    end
    return self.mAttributeBG_UISprite;
end

function UIAttributeChangeUnitTemplate:GetArrow_UISprite()
    if(self.mArrow_UISprite == nil) then
        self.mArrow_UISprite = self:Get("Sprite","UISprite");
    end
    return self.mArrow_UISprite;
end

function UIAttributeChangeUnitTemplate:GetAttributeUnitTweenTemplate()
    if(self.mAttributeUnitTweenTemplate == nil) then
        self.mAttributeUnitTweenTemplate = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIAttributeChangeUnitTweenTemplate);
    end
    return self.mAttributeUnitTweenTemplate;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public

function UIAttributeChangeUnitTemplate:ResetUnit()
    self.go.transform.localScale = CS.UnityEngine.Vector3.one;
end

function UIAttributeChangeUnitTemplate:ResetPosition(position)
    self:GetAttributeUnitTweenTemplate():ResetPosition(position);
end

function UIAttributeChangeUnitTemplate:SetAttribute(addAttr, CallBack)
    local attributeName = self:GetSpecialName(Utility.GetRoleAttributeName(addAttr.type)) ;
    local showNameStr = (addAttr.isServant and "灵兽" or "") .. attributeName;
    local showValueStr = addAttr.minValue .. ((addAttr.minValue ~= "" and addAttr.maxValue ~= "") and " - " or "") .. addAttr.maxValue;
    self:GetAttributeName_Text().text = showNameStr .. '  ' .. showValueStr
    self:GetAttributeBG_UISprite().width = self:GetAttributeName_Text().printedSize.x + 40
    --self:GetAttributeValue_Text().text = showValueStr;
    local changeType = addAttr.changeType == nil and 1 or addAttr.changeType;
    self:GetArrow_UISprite().spriteName = changeType == 1 and "showTip_arrow" or "showTip_arrow2";
    self:GetAttributeUnitTweenTemplate():PlayTweenAction(CallBack);
end

function UIAttributeChangeUnitTemplate:GetSpecialName(attributeName)
    if(attributeName == "切割伤害") then
        attributeName = "切割";
    elseif(attributeName == "神圣防御") then
        attributeName = "神圣防"
    end
    return attributeName;
end

--endregion

--region Private

function UIAttributeChangeUnitTemplate:Initialize()
    self:RunBaseFunction("Initialize");
end

--function UIAttributeChangeUnitTemplate:InitEvents()
--
--end
--
--function UIAttributeChangeUnitTemplate:RemoveEvents()
--
--end

--endregion

--endregion

function UIAttributeChangeUnitTemplate:Init()
    self:Initialize();
    --self:InitEvents();
end

--function UIAttributeChangeUnitTemplate:OnDestroy()
--    self:RemoveEvents();
--end

return UIAttributeChangeUnitTemplate;