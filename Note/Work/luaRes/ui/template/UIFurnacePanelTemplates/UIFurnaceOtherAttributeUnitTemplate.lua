local UIFurnaceOtherAttributeUnitTemplate = {};

UIFurnaceOtherAttributeUnitTemplate.mIsMax = false;

--region Components

function UIFurnaceOtherAttributeUnitTemplate:GetArrow_GameObject()
    if (self.mArrow_GameObject == nil) then
        self.mArrow_GameObject = self:Get("arrow1", "GameObject");
    end
    return self.mArrow_GameObject;
end

function UIFurnaceOtherAttributeUnitTemplate:GetCurAttributeName_Text()
    if (self.mCurAttributeName_Text == nil) then
        self.mCurAttributeName_Text = self:Get("curLevelAttribute/AttributeName", "UILabel");
    end
    return self.mCurAttributeName_Text;
end

function UIFurnaceOtherAttributeUnitTemplate:GetCurAttributeValue_Text()
    if (self.mCurAttributeValue_Text == nil) then
        self.mCurAttributeValue_Text = self:Get("curLevelAttribute/AttributeValue", "UILabel");
    end
    return self.mCurAttributeValue_Text;
end

function UIFurnaceOtherAttributeUnitTemplate:GetNextAttributeValue_Text()
    if (self.mNexAttributeValue_Text == nil) then
        self.mNexAttributeValue_Text = self:Get("nextLevelAttribute/AttributeValue", "UILabel");
    end
    return self.mNexAttributeValue_Text;
end

function UIFurnaceOtherAttributeUnitTemplate:GetNextAttributeEffect_Text()
    if (self.mNextAttributeEffect_Text == nil) then
        self.mNextAttributeEffect_Text = self:Get("nextLevelAttribute/HighlightEffect", "UILabel");
    end
    return self.mNextAttributeEffect_Text;
end

function UIFurnaceOtherAttributeUnitTemplate:GetMaxAttributeValue_Text()
    if (self.mMaxAttributeValue_Text == nil) then
        self.mMaxAttributeValue_Text = self:Get("maxLevelAttribute/AttributeValue", "UILabel");
    end
    return self.mMaxAttributeValue_Text;
end

function UIFurnaceOtherAttributeUnitTemplate:GetMaxAttributeEffect_Text()
    if (self.mMaxAttributeEffect_Text == nil) then
        self.mMaxAttributeEffect_Text = self:Get("maxLevelAttribute/HighlightEffect", "UILabel");
    end
    return self.mMaxAttributeEffect_Text;
end

function UIFurnaceOtherAttributeUnitTemplate:GetNextAttributeEffect_TweenAlpha()
    if (self.mNextAttributeEffect_TweenAlpha == nil) then
        self.mNextAttributeEffect_TweenAlpha = self:Get("nextLevelAttribute/HighlightEffect", "TweenAlpha");
    end
    return self.mNextAttributeEffect_TweenAlpha;
end

function UIFurnaceOtherAttributeUnitTemplate:GetMaxAttributeEffect_TweenAlpha()
    if (self.mMaxAttributeEffect_TweenAlpha == nil) then
        self.mMaxAttributeEffect_TweenAlpha = self:Get("maxLevelAttribute/HighlightEffect", "TweenAlpha");
    end
    return self.mMaxAttributeEffect_TweenAlpha;
end

--endregion

--region Method

--region Public

function UIFurnaceOtherAttributeUnitTemplate:UpdateUnit(curShowData, nextShowData)
    if CS.StaticUtility.IsNull(self:GetNextAttributeValue_Text()) then
        return
    end
    local isShowArrow = true
    self.mIsMax = false;
    if (nextShowData ~= nil) then
        if (nextShowData.nextValueStr ~= nil) then
            if (nextShowData.nextValueStr == "已满级") then
                self.mIsMax = true;
                self:GetNextAttributeValue_Text().text = "";
            else
                self:GetNextAttributeValue_Text().text ="[00FF00]".. nextShowData.nextValueStr;
            end
        else
            self:GetNextAttributeValue_Text().text = "";
        end
        self:GetArrow_GameObject():SetActive(true);
    else
        isShowArrow = false
        self:GetNextAttributeValue_Text().text = "";
        self:GetArrow_GameObject():SetActive(false);
    end

    if (curShowData ~= nil) then
        if (curShowData.curNameStr ~= nil) then
            self:GetCurAttributeName_Text().text = curShowData.curNameStr;
        end

        if (curShowData.curValueStr ~= nil) then
            self:GetCurAttributeValue_Text().text = curShowData.curValueStr;
        end
    end

    if (self.mIsMax) then
        self:GetMaxAttributeValue_Text().text = self:GetCurAttributeValue_Text().text;
        self:GetCurAttributeValue_Text().text = "";
    else
        self:GetMaxAttributeValue_Text().text = "";
    end
    self:GetArrow_GameObject():SetActive(not self.mIsMax and isShowArrow);

end

function UIFurnaceOtherAttributeUnitTemplate:PlayerNextLevelEffect()
    if (self:GetNextAttributeEffect_Text().text ~= self:GetNextAttributeValue_Text().text) then
        if (self.mIsMax) then
            self:GetMaxAttributeEffect_Text().text = self:GetMaxAttributeValue_Text().text;
            self:GetMaxAttributeEffect_TweenAlpha():PlayTween();
        else
            self:GetNextAttributeEffect_Text().text = self:GetNextAttributeValue_Text().text;
            self:GetNextAttributeEffect_TweenAlpha():PlayTween();
        end
    end
end

--endregion

--endregion

return UIFurnaceOtherAttributeUnitTemplate;