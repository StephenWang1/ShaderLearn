---问题反馈
local UISecretaryFeedbackTemplates = {}

function UISecretaryFeedbackTemplates:InitComponents()
    ---问题标题
    self.questionTitle = self:Get("chat/questionTitle", "Top_UILabel")
    ---问题确定描述
    self.questionDes = self:Get("chat/questionDes", "Top_UILabel")
    --个人信息标题
    self.selfInfoTitle = self:Get("chat/selfInfoTitle", "Top_UILabel")
    --个人信息确认描述
    self.selfInfoDes = self:Get("chat/selfInfoDes", "Top_UILabel")
    ---问题输入
    self.questionChatInput = self:Get("chat/questionChat Input", "Top_UIInput")
    ---个人信息输入
    self.selfInfoChatInput = self:Get("chat/selfInfoChat Input", "Top_UIInput")

    ---提交信息
    self.submit = self:Get("chat/submit", "GameObject")
    ---提示
    self.tip = self:Get("chat/tip", "Top_UILabel")
    ---背景图片
    self.Bg = self:Get("chat/Bg", "Top_UISprite")

    self.widget = self:Get("widget", "GameObject")
end
function UISecretaryFeedbackTemplates:InitOther()
    self.distance = 0
    self.topDis = 7
    self.interval = 0

    self.questionDesPosition = self.questionDes.transform.localPosition
    self.selfInfoDesPosition = self.selfInfoDes.transform.localPosition
    self.selfInfoTitlePosition = self.selfInfoTitle.transform.localPosition
    self.widgetPosition = self.widget.transform.localPosition
    self.tipPosition = self.tip.transform.localPosition
    CS.UIEventListener.Get(self.submit.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.submit.gameObject).OnClickLuaDelegate = self.OnSubmit
end

function UISecretaryFeedbackTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

function UISecretaryFeedbackTemplates:RefreshUI(SecretaryDialogueData)
    if SecretaryDialogueData == nil then
        return
    end
    self.SecretaryDialogueData = SecretaryDialogueData
    self.ProblemFeedbackType = self.SecretaryDialogueData.FeedbackType
    self.tip.text=CS.Cfg_GlobalTableManager.Instance.SecretarySubmitFeedbackDownStr
    Utility.RequestCharactersInTexture(self.tip)
    if self.ProblemFeedbackType == CS.ProblemFeedbackType.Feedback then
        self:SetFeedback()
    elseif self.ProblemFeedbackType == CS.ProblemFeedbackType.PresentationContent then
        self:SetPresentationContent()
    end
    if self.distance < 0 then
        self.distance = self.distance * -1
    end
    return self.distance

end

---问题反馈
function UISecretaryFeedbackTemplates:SetFeedback()
    self.questionDes.text = ""
    self.selfInfoDes.text = ""
    self.distance = self.topDis
    self.distance = self.distance - self.Bg.height+15
end

---内容显示
function UISecretaryFeedbackTemplates:SetPresentationContent()
    self.questionDes.text = self.SecretaryDialogueData.FeedbackStr
    self.selfInfoDes.text = self.SecretaryDialogueData.SelfInfoStr
    Utility.RequestCharactersInTexture(self.questionDes)
    Utility.RequestCharactersInTexture(self.selfInfoDes)
    self.questionChatInput.gameObject:SetActive(false)
    self.selfInfoChatInput.gameObject:SetActive(false)
    self.submit.gameObject:SetActive(false)

    self.distance = self.topDis
    self.distance = self.distance - self.questionTitle.height - self.interval+5

    self.questionDesPosition.y = self.distance
    self.questionDes.transform.localPosition = self.questionDesPosition
    self.distance = self.distance - self.questionDes.height - self.interval

    self.selfInfoTitlePosition.y = self.distance
    self.selfInfoTitle.transform.localPosition = self.selfInfoTitlePosition
    self.distance = self.distance - self.selfInfoTitle.height - self.interval

    self.selfInfoDesPosition.y = self.distance
    self.selfInfoDes.transform.localPosition = self.selfInfoDesPosition
    self.distance = self.distance - self.selfInfoDes.height - self.interval - 20

    self.tipPosition.y = self.distance
    self.tip.transform.localPosition = self.tipPosition
    self.distance = self.distance - self.tip.height - self.interval

    if self.distance < 0 then
        self.distance = self.distance * -1
    end
    self.distance = self.distance + 25
    self.Bg.height = self.distance

    self.distance = self.distance -17
    -- self.widgetPosition.y=-self.distance+10
    -- self.widget.transform.localPosition=self.widgetPosition
end

---提交
function UISecretaryFeedbackTemplates:OnSubmit()
    local feedbackStr = self.questionChatInput.text
    local selfInfoStr = self.selfInfoChatInput.text
    if feedbackStr == "" then
        self:Showbubble(self.submit.transform)
        return
    end
    local ProblemFeedbackType = CS.ProblemFeedbackType.PresentationContent
    CS.CSScene.MainPlayerInfo.SecretaryInfo:ChangeDialogueInfo(self.SecretaryDialogueData, ProblemFeedbackType, feedbackStr, selfInfoStr);
end


function UISecretaryFeedbackTemplates:Showbubble(trans)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 64
    TipsInfo[LuaEnumTipConfigType.Describe] = "请输入问题"
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UISocialContactPanel"
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end




return UISecretaryFeedbackTemplates