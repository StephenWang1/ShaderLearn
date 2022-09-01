local UISecretaryDialogueTemplates = {}

function UISecretaryDialogueTemplates:InitComponents()
    --秘书面板
    self.uichat = self:Get("uichat", "GameObject")
    ---玩家头像
    self.HeadIcon = self:Get("HeadIcon", "Top_UISprite")
    ---跟节点
    self.root = self:Get("root", "GameObject")

end
function UISecretaryDialogueTemplates:InitOther()
    self.SecretaryDialogueData = nil
    self.gobj = nil
    self.playerPosition = CS.UnityEngine.Vector3(500, 0, 0);
    self.SecretaryPosition = CS.UnityEngine.Vector3.zero;
    self.UISecretaryPlayerChatTemplates = nil
    self.UISecretaryAnswerTemplates = nil
    self.UISecretaryFeedbackTemplates = nil
end

function UISecretaryDialogueTemplates:Init()
    self:InitComponents()
    self:InitOther()
    self:SetHeadIcon()

end

function UISecretaryDialogueTemplates:SetHeadIcon()
 
end
--CS.SecretaryDialogueData
function UISecretaryDialogueTemplates:RefreshUI(SecretaryDialogueData, ProblemFeedback, Answer, Questions)

    self.SecretaryDialogueData = SecretaryDialogueData
    if SecretaryDialogueData == nil then
        return
    end
    self:SetHead()
    if self.gobjTemplate == nil or self.gobjTemplate.SecretaryDialogueData.DialogueType ~= SecretaryDialogueData.DialogueType then
      
        ---提问
        if SecretaryDialogueData.DialogueType == CS.SecretaryDialogueType.Questions then
            if self.UISecretaryPlayerChatTemplates == nil then
                self.gobj = CS.UnityEngine.GameObject.Instantiate(Questions, self.root.transform);
                self.UISecretaryPlayerChatTemplates = templatemanager.GetNewTemplate(self.gobj, luaComponentTemplates.UISecretaryPlayerChatTemplates);
            end
            self.gobjTemplate = self.UISecretaryPlayerChatTemplates
            self.gobjTemplate.go.transform.localPosition= CS.UnityEngine.Vector3.zero 
          
            ---回答
        elseif SecretaryDialogueData.DialogueType == CS.SecretaryDialogueType.Answer then
            if self.UISecretaryAnswerTemplates == nil then
                self.gobj = CS.UnityEngine.GameObject.Instantiate(Answer, self.root.transform);
                self.UISecretaryAnswerTemplates = templatemanager.GetNewTemplate(self.gobj, luaComponentTemplates.UISecretaryAnswerTemplates);
            end
            self.gobjTemplate = self.UISecretaryAnswerTemplates
            self.gobjTemplate.go.transform.localPosition= CS.UnityEngine.Vector3(10, 0, 0);
            ---问题反馈
        elseif SecretaryDialogueData.DialogueType == CS.SecretaryDialogueType.ProblemFeedback then
            if self.UISecretaryFeedbackTemplates == nil then
                self.gobj = CS.UnityEngine.GameObject.Instantiate(ProblemFeedback, self.root.transform);
                self.UISecretaryFeedbackTemplates = templatemanager.GetNewTemplate(self.gobj, luaComponentTemplates.UISecretaryFeedbackTemplates);
            end
            self.gobjTemplate = self.UISecretaryFeedbackTemplates
            self.gobjTemplate.go.transform.localPosition= CS.UnityEngine.Vector3(10, 0, 0);
        end
        self:InitRoot()
    end
    return self.gobjTemplate:RefreshUI(SecretaryDialogueData)
end

function UISecretaryDialogueTemplates:LocalPosition()
    if self.gobjTemplate ~= nil then
        return self.gobjTemplate.distance
    else
        return 0
    end
end

function UISecretaryDialogueTemplates:InitRoot()
    if self.gobjTemplate==nil then
        return
    end
    if self.UISecretaryPlayerChatTemplates ~= nil then
        self.UISecretaryPlayerChatTemplates.go.gameObject:SetActive(self.gobjTemplate == self.UISecretaryPlayerChatTemplates)
    end
    if self.UISecretaryAnswerTemplates ~= nil then
        self.UISecretaryAnswerTemplates.go.gameObject:SetActive(self.gobjTemplate == self.UISecretaryAnswerTemplates)
    end
    if self.UISecretaryFeedbackTemplates ~= nil then
        self.UISecretaryFeedbackTemplates.go.gameObject:SetActive(self.gobjTemplate == self.UISecretaryFeedbackTemplates)
    end
  --  self.gobjTemplate.go.transform.localPosition = CS.UnityEngine.Vector3.zero
end

function UISecretaryDialogueTemplates:SetHead()
    local isMainPlayer = self.SecretaryDialogueData.IsMainPlayer
    if CS.CSScene.MainPlayerInfo==nil then
        return
    end
    if isMainPlayer then
        self.HeadIcon.transform.localPosition = self.playerPosition
        local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        local Sex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) 
        self.HeadIcon.spriteName= "headicon"..Sex..career
    else
        self.HeadIcon.transform.localPosition = self.SecretaryPosition
        self.HeadIcon.spriteName= "headicon99"
    end
end

return UISecretaryDialogueTemplates