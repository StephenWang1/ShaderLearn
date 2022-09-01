---回答导航
local UISecretaryAnswerNavigationTemplates = {}


function UISecretaryAnswerNavigationTemplates:InitComponents()
    self.label = CS.Utility_Lua.GetComponent(self.go, "Top_UILabel");
    self.SelectBg = self:Get("SelectBg", "Top_UISprite")
    self.Bg = self:Get("Bg", "Top_UISprite")
end
function UISecretaryAnswerNavigationTemplates:InitOther()
    self.index = 0
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickThis
end

function UISecretaryAnswerNavigationTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

function UISecretaryAnswerNavigationTemplates:RefreshUI(info, Selectsecond, Selectthirdly, index, SecretaryDialogueData)
    self.index = index
    self.info = info
    self.IsSecond = info == Selectsecond
    self.isThirdly = info == Selectthirdly
    self.SecretaryDialogueData = SecretaryDialogueData
    self.isSelect = self.IsSecond or self.isThirdly
    self.SelectBg.gameObject:SetActive(self.isSelect)
    self.Bg.gameObject:SetActive(not self.isSelect)
    self.label.text = info
    Utility.RequestCharactersInTexture(self.label)
    self:SetBtn(index)
end

function UISecretaryAnswerNavigationTemplates:SetBtn(index)
    if index == 0 then
        self.Bg.spriteName = "Secretary_infotypebtn1"
        self.SelectBg.spriteName = "Secretary_infotypebtn2"
    else
        self.Bg.spriteName = "Secretary_second_infotypebtn1"
        self.SelectBg.spriteName = "Secretary_second_infotypebtn2"
    end
end

function UISecretaryAnswerNavigationTemplates:OnClickThis()
    if self.IsSecond then
        return
    end
    local Tab = self.SecretaryDialogueData.SelectTab
    if self.index == 0 then
        CS.CSScene.MainPlayerInfo.SecretaryInfo:ChangeDialogueInfo(self.SecretaryDialogueData, Tab.mainTitle, self.info, "")
    else
        CS.CSScene.MainPlayerInfo.SecretaryInfo:ChangeDialogueInfo(self.SecretaryDialogueData, Tab.mainTitle, Tab.secondTitle, self.info)
    end


end
return UISecretaryAnswerNavigationTemplates