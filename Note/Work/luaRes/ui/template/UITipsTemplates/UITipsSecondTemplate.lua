--第二种提示面板
local UITipsSecondTemplate = {  }


--region Components

--region UILabel
function UITipsSecondTemplate:GetAttributeName_Text()
    if(self.mAttributeName_Text == nil) then
        self.mAttributeName_Text = self:Get("lb_name", "UILabel");
    end
    return self.mAttributeName_Text;
end

function UITipsSecondTemplate:GetAttributeValue_Text()
    if(self.mAttributeValue_Text == nil) then
        self.mAttributeValue_Text = self:Get("lb_value", "UILabel");
    end
    return self.mAttributeValue_Text;
end
--endregion

--endregion

function UITipsSecondTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

function UITipsSecondTemplate:InitComponents()

end

function UITipsSecondTemplate:InitOther()
    self.mTween_UIPlayTween = CS.Utility_Lua.GetComponent(self.go,"UIPlayTween")
end

function UITipsSecondTemplate:Show(data)
    --local name = data[1]
    --local content = data[2]
    self:GetAttributeName_Text().text = data[1];
    self:GetAttributeValue_Text().text = data[2];
    self.mTween_UIPlayTween:Play(true)
end



return UITipsSecondTemplate