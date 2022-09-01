local UIAttributeCompareUnitTemplate = {};

--region Components

function UIAttributeCompareUnitTemplate:GetCurName_Text()
    if(self.mCurName_Text == nil) then
        self.mCurName_Text = self:Get("cur/value", "UILabel");
    end
    return self.mCurName_Text;
end

function UIAttributeCompareUnitTemplate:GetCurValue_Text()
    if(self.mCurValue_Text == nil) then
        self.mCurValue_Text = self:Get("curarribute/value", "UILabel");
    end
    return self.mCurValue_Text;
end

function UIAttributeCompareUnitTemplate:GetNextValue_Text()
    if(self.mNextValue_Text == nil)then
        self.mNextValue_Text = self:Get("nextarribute/value", "UILabel");
    end
    return self.mNextValue_Text;
end

function UIAttributeCompareUnitTemplate:GetArrow_UISprite()
    if(self.mArrow_UISprite == nil)then
        self.mArrow_UISprite = self:Get("Arrow", "UISprite");
    end
    return self.mArrow_UISprite;
end

--endregion

--region Method

--region Public

function UIAttributeCompareUnitTemplate:ShowAttributeCompare(customData)
    local name = customData.name == nil and "" or customData.name;
    local curValue = customData.curValue == nil and "-" or customData.curValue;
    local nextValue = customData.nextValue == nil and "-" or customData.nextValue;
    local spriteName = ternary( customData.maxTotalValue ~= nil and customData.minTotalValue  ~= nil and customData.maxTotalValue > customData.minTotalValue ,"arrow","arrow3")

    self:GetCurName_Text().text = name;
    self:GetCurValue_Text().text = curValue;
    self:GetNextValue_Text().text = luaEnumColorType.Green..nextValue.."[-]";
    self:GetArrow_UISprite().spriteName = spriteName
end

--endregion

--region Private

function UIAttributeCompareUnitTemplate:Clear()
    self.mNextValue_Text = nil;
    self.mCurValue_Text = nil;
    self.mCurName_Text = nil;
end

--endregion

--endregion

function UIAttributeCompareUnitTemplate:OnDestroy()
    self:Clear();
end

return UIAttributeCompareUnitTemplate;