---@class UIStrongerMainBtnGrid:TemplateBase  设置主按钮
local UIStrongerMainBtnGrid ={}
UIStrongerMainBtnGrid.type =0
function UIStrongerMainBtnGrid:Init()
    self:InitComponents()
end
function UIStrongerMainBtnGrid:InitComponents()
    self.Check = self:Get("checkmark", "GameObject")
    self.Back = self:Get("background", "GameObject")
    self.CheckLb = self:Get("checkmark/Label", "UILabel")
    self.BackLb = self:Get("background/Label", "UILabel")
    self.CheckSp = self:Get("checkmark/icon", "UISprite")
    self.BackSp = self:Get("background/icon", "UISprite")
    self:SetBg(self.type)
end
function UIStrongerMainBtnGrid:ShowData(Type,Name)
    self.type =Type
    if(self.CheckLb~=nil)then
        self.CheckLb.text =Name
    end
    if(self.BackLb~=nil)then
        self.BackLb.text =Name
    end
    if(self.CheckSp~=nil)then
        self.CheckSp.spriteName ='Strengthen_icon'..self.type
    end
    if(self.BackSp~=nil)then
        self.BackSp.spriteName ='Strengthen_icon'..self.type
    end
end
function UIStrongerMainBtnGrid:SetBg(Type)
    local act = self.type ==Type and self.type~=0
    if(CS.StaticUtility.IsNull(self.Check)==false)then
        self.Check:SetActive(act)
    end
    if(CS.StaticUtility.IsNull(self.Back)==false)then
        self.Back:SetActive(not act)
    end
end
return UIStrongerMainBtnGrid