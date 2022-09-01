---@class UIRefineItemAttributeUnitTemplate
local UIRefineItemAttributeUnitTemplate = {};

--region Components

function UIRefineItemAttributeUnitTemplate:GetAttributeName_Text()
    if(self.mAttributeName_Text == nil) then
        self.mAttributeName_Text = self:Get("AttrName","UILabel");
    end
    return self.mAttributeName_Text;
end

function UIRefineItemAttributeUnitTemplate:GetAttributeValue_Text()
    if(self.mAttributeValue_Text == nil) then
        self.mAttributeValue_Text = self:Get("AttrValue/AttrValue","UILabel");
    end
    return self.mAttributeValue_Text;
end

--endregion

--region Method

--region Public

function UIRefineItemAttributeUnitTemplate:UpdateUnit(nameStr, valueStr)
    self:GetAttributeName_Text().text = nameStr;
    self:GetAttributeValue_Text().text = valueStr;
    self:GetAttributeValue_Text():UpdateAnchors();
end

--endregion

--region Private


--endregion

--endregion

--function UIRefineItemAttributeUnitTemplate:Init()
--
--end
--
--function UIRefineItemAttributeUnitTemplate:OnDestroy()
--
--end

return UIRefineItemAttributeUnitTemplate;