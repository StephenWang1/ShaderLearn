local UIActivitiesDesContentUnitTemplate = {};

--region Components

function UIActivitiesDesContentUnitTemplate:GetRuleName_Text()
    if(self.mRuleName_Text == nil) then
        self.mRuleName_Text = self:Get("title","UILabel");
    end
    return self.mRuleName_Text;
end

function UIActivitiesDesContentUnitTemplate:GetRuleContent_Text()
    if(self.mRuleContent_Text == nil) then
        self.mRuleContent_Text = self:Get("dec","UILabel");
    end
    return self.mRuleContent_Text;
end

function UIActivitiesDesContentUnitTemplate:GetSign_GameObject()
    if(self.mSign_GameObject == nil) then
        self.mSign_GameObject = self:Get("sign","GameObject");
    end
    return self.mSign_GameObject;
end

--endregion

--region Method

--region Public

function UIActivitiesDesContentUnitTemplate:UpdateUnit(ruleName, ruleContent)
    if(ruleName ~= "default") then
        if(self.mContentOriginPosition ~= nil) then
            self:GetRuleContent_Text().gameObject.transform.localPosition = self.mContentOriginPosition
        end
        self:GetRuleName_Text().text = ruleName;
        self:GetSign_GameObject():SetActive(true);
    else
        self:GetRuleName_Text().text = "";
        self:GetSign_GameObject():SetActive(false);
        self:GetRuleContent_Text().gameObject.transform.localPosition = self:GetRuleName_Text().gameObject.transform.localPosition;
    end
    self:GetRuleContent_Text().text = ruleContent;
end

--endregion

--region Private

--endregion

--endregion

function UIActivitiesDesContentUnitTemplate:Init()
    self.mContentOriginPosition = self:GetRuleContent_Text().gameObject.transform.localPosition;
end

return UIActivitiesDesContentUnitTemplate;