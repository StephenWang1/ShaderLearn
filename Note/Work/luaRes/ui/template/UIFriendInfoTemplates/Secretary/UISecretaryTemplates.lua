local UISecretaryTemplates = {}

function UISecretaryTemplates:InitComponents()
    ---发送按钮
    self.btn_fasong = self:Get("btn_fasong", "GameObject")
    ---发送按钮BG
    self.btn_fasongBackground = self:Get("btn_fasong/Background", "GameObject")
    ---输入信息
    self.ChatInput = self:Get("Chat Input", "Top_UIInput")
    ---对话信息
    self.Grild = self:Get("ChatArea/Chat Area/Grild", "Top_UIGridContainer")
    ---SpringPanel
    self.ChatAreaSpringPanel = self:Get("ChatArea/Chat Area", "SpringPanel")
    ---ChatArea节点
    self.ChatAreaSpring = self:Get("ChatArea/Chat Area", "GameObject")
    ---ChatArea
    self.ChatAreaPanel = self:Get("ChatArea/Chat Area", "UIPanel")
    ---快捷提问列表
    self.shortcutGrild = self:Get("ChatArea/shortcutGrild", "Top_UIGridContainer")

    ---问题反馈
    self.ProblemFeedbackchat = self:Get("ChatArea/Chat Area/ProblemFeedbackchat", "GameObject")
    ---秘书回答
    self.SecretaryChat = self:Get("ChatArea/Chat Area/SecretaryChat", "GameObject")
    ---玩家提问
    self.Playerchat = self:Get("ChatArea/Chat Area/Playerchat", "GameObject")
    ---没有问题背景
    self.noProblemBG = self:Get("ChatArea/noProblemBG", "GameObject")

    self.voice = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIVoiceBaseTemplate, nil, self.mOwnerPanel)
end

function UISecretaryTemplates:InitOther()

    self.ChatAreaSpringPosition = self.ChatAreaSpring.transform.localPosition
    self.SecretaryDialogue = {}
    self.sumDistancePosition = nil
    self.IsStart = true
    self.IsCanOnClick = true
    self.PanelSizeY = self.ChatAreaPanel:GetViewSize().y - 60
    self.voice:SwitchVoiceType(LuaEnumVoiceMessageType.NOSERVER)

    CS.UIEventListener.Get(self.btn_fasong.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_fasong.gameObject).OnClickLuaDelegate = self.OnClickbtn_fasong
end

function UISecretaryTemplates:Init(panel)
    ---@type UISocialContactPanel
    self.mOwnerPanel = panel
    self:InitComponents()
    self:InitOther()
    self:SetShortcutGrild()
end

function UISecretaryTemplates:Start()

end

function UISecretaryTemplates:RefreshUI()

end

function UISecretaryTemplates:CreatDialoguePanel()

end

--regiopn 刷新对话信息
---刷新全部对话信息
function UISecretaryTemplates:SecretaryDialogueAll(isAdd)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.SecretaryInfo == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.SecretaryInfo.IsOpenSecretaryPanel then
        CS.CSScene.MainPlayerInfo.SecretaryInfo.isHaveNewpush = false
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Secretary);
    end
    local dialoguelList = CS.CSScene.MainPlayerInfo.SecretaryInfo.DialoguelList
    if dialoguelList == nil then
        return
    end
    if dialoguelList.Count == 0 then
        CS.CSScene.MainPlayerInfo.SecretaryInfo:AddSecretaryDialogue(100000001);
        return
    end
    local Oldcount = 0
    self.Grild.MaxCount = dialoguelList.Count
    self.ChatAreaPanel.alpha = 0;
    local SpringY = 0
    local endSpringY = 0
    for i = Oldcount, self.Grild.MaxCount - 1 do

        local item = self.Grild.controlList[i].gameObject

        if self.SecretaryDialogue[item] == nil then
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UISecretaryDialogueTemplates)
            self.SecretaryDialogue[item] = template
        end
        if i == 0 then
            self.sumDistancePosition = item.transform.localPosition
        else
            item.transform.localPosition = self.sumDistancePosition
        end
        if i == self.Grild.MaxCount - 2 then
            SpringY = self.sumDistancePosition.y
        end
        if dialoguelList[i].IsChange or self.IsStart then
            dialoguelList[i].IsChange = false
            self.SecretaryDialogue[item]:RefreshUI(dialoguelList[i], self.ProblemFeedbackchat, self.SecretaryChat, self.Playerchat)
        end
        local LocalPosition = self.SecretaryDialogue[item]:LocalPosition()
        if i == self.Grild.MaxCount - 1 and LocalPosition >= 350 then
            LocalPosition = 350
        end
        self.sumDistancePosition.y = self.sumDistancePosition.y - LocalPosition - 30
        endSpringY = self.SecretaryDialogue[item]:LocalPosition()
    end
    local SpringY = self.sumDistancePosition.y
    if self.sumDistancePosition.y < 0 then
        SpringY = self.sumDistancePosition.y * -1
    end
    if SpringY > self.PanelSizeY then
        local springY = self.ChatAreaSpringPosition.y + SpringY - self.PanelSizeY
        local intervalY = springY - self.ChatAreaSpring.transform.localPosition.y;
        self.ChatAreaSpring.transform.localPosition = CS.UnityEngine.Vector3(0, springY, 0);
        self.ChatAreaPanel.clipOffset = CS.UnityEngine.Vector2(0, self.ChatAreaPanel.clipOffset.y - intervalY);
        -- if  self.ChatAreaSpring.transform.localPosition.y>springY+20 then

        -- else
        --     self.ChatAreaSpringPanel.target = CS.UnityEngine.Vector3(0, springY, 0);
        --     self.ChatAreaSpringPanel.enabled = true;
        -- end

    end
    self.ChatAreaPanel.alpha = 1;
    self.IsStart = false
end

---刷新新添加对话新消息
function UISecretaryTemplates:SecretaryAddDialogue()

end

--endregion
--region 设置快捷提问列表
function UISecretaryTemplates:SetShortcutGrild()
    local infoList = CS.Cfg_Secret_GameSecretary_PlaystrategyTableManager.Instance.TypenameList
    self.shortcutGrild.MaxCount = infoList.Count
    local index = 0
    for i = 0, self.shortcutGrild.MaxCount - 1 do
        local reverseIndex = self.shortcutGrild.MaxCount - 1 - i
        local item = self.shortcutGrild.controlList[i].gameObject
        local label = CS.Utility_Lua.GetComponent(item.transform:Find('Label'), "Top_UILabel");
        label.text = infoList[reverseIndex];
        label.trueTypeFont:RequestCharactersInTexture(label.text, label.fontSize, label.fontStyle)
        CS.UIEventListener.Get(item.gameObject).onClick = function()
            if label.text == infoList[0] then
                if self.IsCanOnClick == false then

                    -- CS.CSListUpdateMgr.Instance:Remove(self.mIsCanOnClickUpdateItem)
                    -- self.mIsCanOnClickUpdateItem.timeDelay = 10000
                    -- CS.CSListUpdateMgr.Instance:Add(self.mIsCanOnClickUpdateItem)
                    self:Showbubble(item.transform, "操作过于频繁，请稍后再试")
                    return
                else
                    self.IsCanOnClick = false
                    CS.CSListUpdateMgr.Add(10000, nil, function()
                        self.IsCanOnClick = true
                    end, false)
                    -- if self.mIsCanOnClickUpdateItem == nil then
                    --     self.mIsCanOnClickUpdateItem = 
                    -- end
                end
            end
            CS.Cfg_Secret_GameSecretary_PlaystrategyTableManager.Instance:GetSecretaryID(infoList[reverseIndex]);
            -- CS.CSScene.MainPlayerInfo.SecretaryInfo:AddSecretaryDialogue(id);
        end
    end
end

--endregion
--region 点击函数
--发送
function UISecretaryTemplates:OnClickbtn_fasong(go)
    if self.ChatInput.text == "" then
        self:Showbubble(self.btn_fasongBackground.transform, "请输入问题")
        return
    end
    CS.CSScene.MainPlayerInfo.SecretaryInfo:AddPlayerDialogue(self.ChatInput.text)
    self.ChatInput.text = "";
end

function UISecretaryTemplates:Showbubble(trans, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 64
    TipsInfo[LuaEnumTipConfigType.Describe] = str
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UISocialContactPanel"
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end
--endregion
return UISecretaryTemplates