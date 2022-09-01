---@class UIFriendCirclePublishPanel:UIBase
local UIFriendCirclePublishPanel = {};

---@type UIFriendCirclePublishPanel
local this = nil;

UIFriendCirclePublishPanel.mMaxTextLength = nil;

UIFriendCirclePublishPanel.mLastMaxText = nil;

---@type table<number,table<string,string>> 发送数据
UIFriendCirclePublishPanel.mBagItemInfoList = nil

--region Components

function UIFriendCirclePublishPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIFriendCirclePublishPanel:GetBtnPublish_GameObject()
    if (this.mBtnPublish_GameObject == nil) then
        this.mBtnPublish_GameObject = this:GetCurComp("WidgetRoot/events/PublishBtn", "GameObject");
    end
    return this.mBtnPublish_GameObject;
end

function UIFriendCirclePublishPanel:GetBtnEmoticon_GameObject()
    if (this.mBtnEmoticon_GameObject == nil) then
        this.mBtnEmoticon_GameObject = this:GetCurComp("WidgetRoot/events/btn_emoticon", "GameObject");
    end
    return this.mBtnEmoticon_GameObject;
end

---@return UnityEngine.GameObject
function UIFriendCirclePublishPanel:GetBtnBag_GameObject()
    if (this.mBtnBag_GameObject == nil) then
        this.mBtnBag_GameObject = this:GetCurComp("WidgetRoot/events/btn_bag", "GameObject");
    end
    return this.mBtnBag_GameObject;
end

---@return UIToggle
function UIFriendCirclePublishPanel:GetBtnBag_UIToggle()
    if self.mBtnBagToggle == nil then
        self.mBtnBagToggle = self:GetCurComp("WidgetRoot/view/ItemWindow/tg_bag", "UIToggle");
    end
    return self.mBtnBagToggle
end

---@return UIToggle
function UIFriendCirclePublishPanel:GetBtnBody_UIToggle()
    if self.mBtnBody == nil then
        self.mBtnBody = self:GetCurComp("WidgetRoot/view/ItemWindow/tg_Body", "UIToggle")
    end
    return self.mBtnBody
end

---@return UIInput
function UIFriendCirclePublishPanel:GetContentInput_UIInput()
    if (this.mContentInput_UIInput == nil) then
        this.mContentInput_UIInput = this:GetCurComp("WidgetRoot/view/Input/ChatInput", "UIInput");
    end
    return this.mContentInput_UIInput;
end

function UIFriendCirclePublishPanel:GetTextLength_Text()
    if (this.mTextLength_Text == nil) then
        this.mTextLength_Text = this:GetCurComp("WidgetRoot/view/number", "UILabel");
    end
    return this.mTextLength_Text;
end

function UIFriendCirclePublishPanel:GetEmotionComponent()
    if (this.mEmotionComponent == nil) then
        this.mEmotionComponent = this:GetCurComp("WidgetRoot/view/EmotionWindow", "UIEmotionComponent");
    end
    return this.mEmotionComponent;
end

--[[function UIFriendCirclePublishPanel:GetChatItemViewComponent()
    if (this.mChatItemViewComponent == nil) then
        this.mChatItemViewComponent = this:GetCurComp("WidgetRoot/view/ItemWindow", "UIChatItemViewComponent");
    end
    return this.mChatItemViewComponent;
end]]

function UIFriendCirclePublishPanel:GetMaxTextLength()
    if (this.mMaxTextLength == nil) then
        this.mMaxTextLength = CS.Cfg_GlobalTableManager.Instance:GetFriendCircleMaxTextNum();
    end
    return this.mMaxTextLength;
end

---@return UnityEngine.GameObject 背包界面
function UIFriendCirclePublishPanel:GetBagPanel_Go()
    if self.mBagPanelGo == nil then
        self.mBagPanelGo = self:GetCurComp("WidgetRoot/view/ItemWindow", "GameObject")
    end
    return self.mBagPanelGo
end


--endregion

--region Method


--region CallFunction

function UIFriendCirclePublishPanel:OnUIInputValueChanged()
    local lastLength = this:GetReplaceVoListLength();
    if (lastLength > this:GetMaxTextLength()) then
        this:GetContentInput_UIInput().value = this.mLastMaxText;
        lastLength = this:GetReplaceVoListLength();
    else
        this.mLastMaxText = this:GetContentInput_UIInput().value;
    end
    this:GetTextLength_Text().text = lastLength .. "/" .. this:GetMaxTextLength();
end

--endregion

--region Public

--endregion

--region Private
function UIFriendCirclePublishPanel:GetReplaceVoListLength()
    --local value = this:GetContentInput_UIInput().value;
    --local replaceVoList = this:GetChatItemViewComponent():GetReplaceVoList();
    --local lastLength = 0;
    --local length = 0;
    --if(replaceVoList ~= nil and replaceVoList.Count ~= 0) then
    --    for i = 0, replaceVoList.Count - 1 do
    --        local list = replaceVoList[i];
    --        if(list.Count > 1) then
    --            local from = list[0];
    --            local to = list[1];
    --            value = CS.Utility_Lua.StringReplace(value, from, to);
    --            length = Utility.GetStringLength(value);
    --            lastLength = lastLength + length;
    --            if(lastLength <= this:GetMaxTextLength()) then
    --                this.mLastMaxText = this:GetContentInput_UIInput().value;
    --            end
    --        end
    --    end
    --else
    --    length = Utility.GetStringLength(value);
    --    lastLength = length;
    --    if(lastLength <= this:GetMaxTextLength()) then
    --        this.mLastMaxText = this:GetContentInput_UIInput().value;
    --    end
    --end
    --return lastLength;

    local length = Utility.GetStringLength(this:GetContentInput_UIInput().value);
    return length;
end

function UIFriendCirclePublishPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIFriendCirclePublishPanel");
    end

    --[[    CS.UIEventListener.Get(this:GetBtnPublish_GameObject()).onClick = function()
            local value = this:GetContentInput_UIInput().value;
            local replaceVoList = this:GetChatItemViewComponent():GetReplaceVoList();
            if (replaceVoList ~= nil) then
                for i = 0, replaceVoList.Count - 1 do
                    local list = replaceVoList[i];
                    if (list.Count > 1) then
                        local from = list[0];
                        local to = list[1];
                        value = CS.Utility_Lua.StringReplace(value, from, to);
                    end
                end
            end
            value = this:GetEmotionComponent():ReplaceEmojiNameToEmoji(value);
            networkRequest.ReqFriendCirclePost(value);
            this:GetChatItemViewComponent():ClearVoList();
            uimanager:ClosePanel("UIFriendCirclePublishPanel");
        end]]

    CS.UIEventListener.Get(this:GetBtnEmoticon_GameObject()).onClick = function()
        this:GetEmotionComponent().gameObject:SetActive(true);
    end

    this:GetEmotionComponent().onClickEmotion = function(spriteName)
        local length = this:GetReplaceVoListLength() + Utility.GetStringLength(spriteName);
        if (length <= this:GetMaxTextLength()) then
            this:GetContentInput_UIInput():InsertText(spriteName)
        end
    end
    CS.UIEventListener.Get(this:GetBtnBag_GameObject()).onClick = function()
        --  this:GetChatItemViewComponent():SetActive(true);
        -- this:GetChatItemViewComponent():SwitchBodyAndBag(1);
        self:GetBagPanel_Go():SetActive(true)
        self:GetBtnBag_UIToggle():Set(true)
    end

    this.CallOnUIInputValueChanged = function()
        this:OnUIInputValueChanged();
    end
    CS.EventDelegate.Add(this:GetContentInput_UIInput().onChange, self.CallOnUIInputValueChanged);

    CS.EventDelegate.Add(self:GetBtnBag_UIToggle().onChange, function()
        if self:GetBtnBag_UIToggle().value then
            self:GetBagTemplate():SwitchToBagState()
        end
    end)

    CS.EventDelegate.Add(self:GetBtnBody_UIToggle().onChange, function()
        if self:GetBtnBody_UIToggle().value then
            self:GetBagTemplate():SwitchToBodyState()
        end
    end)

    CS.UIEventListener.Get(self:GetBagPanel_Go()).onClick = function()
        self:GetBagPanel_Go():SetActive(false)
    end

    CS.UIEventListener.Get(this:GetBtnPublish_GameObject()).onClick = function()
        local value = this:GetContentInput_UIInput().value;
        local replaceVoList = self.mBagItemInfoList
        if (replaceVoList ~= nil) then
            for i = 1, #replaceVoList do
                local list = replaceVoList[i];
                if list then
                    local from = list.showStr;
                    local to = list.sendStr;
                    if from and to then
                        value = CS.Utility_Lua.StringReplace(value, from, to);
                    end
                end
            end
        end
        value = this:GetEmotionComponent():ReplaceEmojiNameToEmoji(value);
        networkRequest.ReqFriendCirclePost(value);
        --this:GetChatItemViewComponent():ClearVoList();
        self:ClearData()
        uimanager:ClosePanel("UIFriendCirclePublishPanel");
    end
end
--endregion

--endregion

function UIFriendCirclePublishPanel:Init()
    this = self;
    this:InitEvents();
    --this:GetChatItemViewComponent():InitStrMaxLength(this:GetMaxTextLength());
    self:BindMessage()
end

function UIFriendCirclePublishPanel:Show(customData)
    this:OnUIInputValueChanged();
    self.mBagItemInfoList = {}
end

function UIFriendCirclePublishPanel:BindMessage()
    UIFriendCirclePublishPanel.ClickBagItemCallBack = function(msgId, data)
        self:OnBagItemClicked(data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.OnClickFriendCircle, UIFriendCirclePublishPanel.ClickBagItemCallBack)
end

--region 聊天背包
---@return UIFriendCircle_BagPanel
---获取聊天背包模板
function UIFriendCirclePublishPanel:GetBagTemplate()
    if self.mBagTemplate == nil then
        self.mBagTemplate = templatemanager.GetNewTemplate(self:GetBagPanel_Go(), luaComponentTemplates.UIFriendCircle_BagPanel)
    end
    return self.mBagTemplate
end

---@return CSMainPlayerInfo
function UIFriendCirclePublishPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---点击背包格子
---@param info bagV2.BagItemInfo
function UIFriendCirclePublishPanel:OnBagItemClicked(info)
    local sendStr
    local showStr
    local bagItemInfo = info
    if bagItemInfo and self:GetMainPlayerInfo() then
        local itemTable = info.ItemTABLE
        if itemTable then
            local reverseStr = CS.Utility_Lua.ReverseItemInfoToString(bagItemInfo);
            sendStr = "[url=event:open|UIItemInfoPanel|0|" .. reverseStr  .."|" .. tostring(CS.CSScene.MainPlayerInfo.ID) .. "|" .. tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)) .. "][u]" .. itemTable.name .. "[/u][/url]"
            showStr = "【" .. CS.Cfg_ItemsTableManager.Instance:GetItemName(itemTable.id) .. "】"

            if this:GetMaxTextLength() ~= 0 then
                self:AddInputData(showStr, sendStr)
                self:GetContentInput_UIInput():InsertText(showStr)
            else
                self:AddInputData(showStr, sendStr)
                self:GetContentInput_UIInput():InsertText(showStr)
            end
            self:GetBagPanel_Go():SetActive(false)
        end
    end
end

---存储数据
function UIFriendCirclePublishPanel:AddInputData(showStr, sendStr)
    if self.mBagItemInfoList == nil then
        self.mBagItemInfoList = {}
    end
    local info = {}
    info.showStr = showStr
    info.sendStr = sendStr
    table.insert(self.mBagItemInfoList, info)
end

function UIFriendCirclePublishPanel:ClearData()
    self.mBagItemInfoList = nil
end
--endregion

--region update
function update()
    if UIFriendCirclePublishPanel:GetBagTemplate() then
        UIFriendCirclePublishPanel:GetBagTemplate():GetChatBagInteraction():OnUpdate(CS.UnityEngine.Time.time)
    end
end
--endregion

return UIFriendCirclePublishPanel;