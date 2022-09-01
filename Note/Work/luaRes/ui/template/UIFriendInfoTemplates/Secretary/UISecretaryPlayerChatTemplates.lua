local UISecretaryPlayerChatTemplates = {}

function UISecretaryPlayerChatTemplates:InitComponents()
        ---标尺
    self.scaleplate = self:Get("chat/scaleplate", "Top_UILabel")
    --玩家聊天面板
    self.playerchat = self:Get("chat", "GameObject")
    self.playerchat_details = self:Get("chat/details", "Top_UILabel")
    self.playerchat_Bg = self:Get("chat/Bg", "Top_UISprite")
    

end
function UISecretaryPlayerChatTemplates:InitOther()
    self.SecretaryDialogueData = nil
    self.topDis = 7
    self.distance = 0;
end

function UISecretaryPlayerChatTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

--CS.SecretaryDialogueData
function UISecretaryPlayerChatTemplates:RefreshUI(SecretaryDialogueData)
    if SecretaryDialogueData == nil then
        return
    end
    self.SecretaryDialogueData = SecretaryDialogueData
    self:SetDetails()
    self:RefreShlocation()
    self.distance=self.distance+2
    return self.distance

end

---内容描述
function UISecretaryPlayerChatTemplates:SetDetails()
    if self.SecretaryDialogueData == nil then
        return
    end
    local str=self.SecretaryDialogueData.Details;
    local strOut=str
    if string.len(str)>=60 then
        strOut= string.sub(str,1,60)
    end
    self.playerchat_details.text = CS.Utility_Lua.RemoveStringColor(strOut) 
    self.scaleplate.text = CS.Utility_Lua.RemoveStringColor(strOut) 
    Utility.RequestCharactersInTexture(self.playerchat_details)
    Utility.RequestCharactersInTexture(self.scaleplate)
end

function UISecretaryPlayerChatTemplates:RefreShlocation()
    self.distance = self.topDis
    self.distance = self.distance - self.playerchat_details.height
    if self.distance < 0 then
        self.distance = self.distance * -1
    end
    self.distance=self.distance + 20
    self.playerchat_Bg.width = self.scaleplate.width + 35
end

return UISecretaryPlayerChatTemplates