---@class UIWeddingMoreInfoPanelTemplates:TemplateBase
local UIWeddingMoreInfoPanelTemplates = {}

--region 组件
function UIWeddingMoreInfoPanelTemplates:GetHelpBtn_GameObject()
    if (self.mHelpBtn == nil) then
        self.mHelpBtn = self:Get("help", "GameObject")
    end
    return self.mHelpBtn
end

function UIWeddingMoreInfoPanelTemplates:GetWriteBtn_GameObject()
    if (self.mWriteBtn == nil) then
        self.mWriteBtn = self:Get("Oath/OathContent/write", "GameObject")
    end
    return self.mWriteBtn
end

function UIWeddingMoreInfoPanelTemplates:GetOathContent_UILabel()
    if (self.mOathContent == nil) then
        self.mOathContent = self:Get("Oath/OathContent/Chat Input/Label", "UILabel")
    end
    return self.mOathContent
end

function UIWeddingMoreInfoPanelTemplates:GetOathContent_UIInput()
    if (self.mOathContent_UIInput == nil) then
        self.mOathContent_UIInput = self:Get("Oath/OathContent/Chat Input", "UIInput")
    end
    return self.mOathContent_UIInput
end

function UIWeddingMoreInfoPanelTemplates:GetOathContent_BoxCollider()
    if (self.mOathContent_BoxCollider == nil) then
        self.mOathContent_BoxCollider = self:Get("Oath/OathContent/Chat Input", "BoxCollider")
    end
    return self.mOathContent_BoxCollider
end

function UIWeddingMoreInfoPanelTemplates:GetHeadSprite_UISprite()
    if (self.mHeadSprite == nil) then
        self.mHeadSprite = self:Get("HeadOath/HeadSprite", "UISprite")
    end
    return self.mHeadSprite
end

function UIWeddingMoreInfoPanelTemplates:GetHeadLetter_UIInput()
    if (self.mHeadLetter_UIInput == nil) then
        self.mHeadLetter_UIInput = self:Get("HeadOath/HeadSprite/Chat Input", "UIInput")
    end
    return self.mHeadLetter_UIInput
end

function UIWeddingMoreInfoPanelTemplates:GetHeadLetter_UILabel()
    if (self.mHeadLetter == nil) then
        self.mHeadLetter = self:Get("HeadOath/HeadSprite/Chat Input/Label", "UILabel")
    end
    return self.mHeadLetter
end

function UIWeddingMoreInfoPanelTemplates:GetChangeOathBtn_GameObject()
    if (self.mChangeOathBtn == nil) then
        self.mChangeOathBtn = self:Get("Oath/ChangeOathBtn", "GameObject")
    end
    return self.mChangeOathBtn
end

function UIWeddingMoreInfoPanelTemplates:GetChangeHeadOathBtn_GameObject()
    if (self.mChangeHeadOathBtn == nil) then
        self.mChangeHeadOathBtn = self:Get("HeadOath/ChangeHeadOathBtn", "GameObject")
    end
    return self.mChangeHeadOathBtn
end

function UIWeddingMoreInfoPanelTemplates:OathGo_GameObject()
    if (self.mOathGo == nil) then
        self.mOathGo = self:Get("Oath", "GameObject")
    end
    return self.mOathGo
end

function UIWeddingMoreInfoPanelTemplates:HeadOathGo_GameObject()
    if (self.mHeadOathGo == nil) then
        self.mHeadOathGo = self:Get("HeadOath", "GameObject")
    end
    return self.mHeadOathGo
end
--endregion

--region 初始化
---@param panel UIWeddingRingUpPanel
function UIWeddingMoreInfoPanelTemplates:Init(panel)
    self.panel = panel
    self:BindUIEvents()
end

function UIWeddingMoreInfoPanelTemplates:Start()
    self:BindMessage()
end

function UIWeddingMoreInfoPanelTemplates:BindMessage()
    --誓言
    self.mResOathMsg = function(msgID, tblData, CSData)
        self:GetOathContent_UIInput().value = tblData.matchmaker
        self:GetOathContent_UILabel().text = tblData.matchmaker
    end
    self.panel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSeeOathMessage, self.mResOathMsg)

    self:GetOathContent_UIInput().submitOnUnselect = true
    CS.EventDelegate.Add(self:GetOathContent_UIInput().onSubmit, function(go)
        self:SendOath()
    end)
    --刻字

    self.mResLetteringMsg = function(msgID, tblData, CSData)
        self:GetHeadLetter_UIInput().value = tblData.lettering
        self:GetHeadLetter_UILabel().text = tblData.lettering
    end
    self.panel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSeeLetteringMessage, self.mResLetteringMsg)

    self:GetHeadLetter_UIInput().submitOnUnselect = true
    CS.EventDelegate.Add(self:GetHeadLetter_UIInput().onSubmit, function(go)
        self:SendLetter()
    end)
end

function UIWeddingMoreInfoPanelTemplates:BindUIEvents()
    CS.UIEventListener.Get(self:GetChangeOathBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetChangeOathBtn_GameObject()).OnClickLuaDelegate = self.ChangeOathBtnOnClick
    CS.UIEventListener.Get(self:GetChangeHeadOathBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetChangeHeadOathBtn_GameObject()).OnClickLuaDelegate = self.ChangeHeadOathBtnOnClick
    CS.UIEventListener.Get(self:GetWriteBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetWriteBtn_GameObject()).OnClickLuaDelegate = self.WriteBtnOnClick
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).OnClickLuaDelegate = self.HelpBtnOnClick
end
--endregion

--region 界面
function UIWeddingMoreInfoPanelTemplates:SendOath()
    networkRequest.ReqVerificationOath(self:GetOathContent_UILabel().text)
end

function UIWeddingMoreInfoPanelTemplates:SendLetter()
    networkRequest.ReqVerificationLettering(self:GetHeadLetter_UILabel().text)
end

function UIWeddingMoreInfoPanelTemplates:Show()
    self.go:SetActive(true)
    self:InitData()
    self:RefreshView()
end

function UIWeddingMoreInfoPanelTemplates:Hide()
    self.go:SetActive(false)
    self:WriteBtnReset()
end

function UIWeddingMoreInfoPanelTemplates:InitData()
    networkRequest.ReqSeeOath()
    networkRequest.ReqSeeLettering()
    local sex = tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex))
    local career = tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
    self:GetHeadSprite_UISprite().spriteName = "headicon" .. sex .. career
end

function UIWeddingMoreInfoPanelTemplates:RefreshView()
    local weddingItem = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(Utility.EnumToInt(CS.EEquipIndex.POS_MARRY_RING))
    local isFind, funcTypeList = CS.Cfg_GlobalTableManager.Instance.WeddingRingFuncDic:TryGetValue(weddingItem.itemId)
    if (isFind) then
        if (not funcTypeList:Contains(LuaEnumWeddingRingFuncType.HeadOath)) then
            self:HeadOathGo_GameObject():SetActive(false)
        else
            self:HeadOathGo_GameObject():SetActive(true)
        end
    end
end
--endregion

--region 客户端事件
function UIWeddingMoreInfoPanelTemplates:ChangeOathBtnOnClick(go)
    networkRequest.ReqUpdateOath(self:GetOathContent_UILabel().text)
end

function UIWeddingMoreInfoPanelTemplates:ChangeHeadOathBtnOnClick(go)
    networkRequest.ReqUpdateLettering(self:GetHeadLetter_UILabel().text)
end

---@param go UnityEngine.GameObject
function UIWeddingMoreInfoPanelTemplates:WriteBtnOnClick(go)
    self:GetWriteBtn_GameObject():SetActive(false)
    self:GetOathContent_BoxCollider().enabled = true
    self:GetOathContent_UIInput().isSelected = true
end

function UIWeddingMoreInfoPanelTemplates:WriteBtnReset()
    self:GetWriteBtn_GameObject():SetActive(true)
    self:GetOathContent_BoxCollider().enabled = false
    self:GetOathContent_UIInput().isSelected = false
end

function UIWeddingMoreInfoPanelTemplates.HelpBtnOnClick(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(96)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end
--endregion

--region 服务器消息

--endregion

function UIWeddingMoreInfoPanelTemplates:OnDestroy()
    self.panel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSeeLetteringMessage, self.mResLetteringMsg)
    self.panel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSeeOathMessage, self.mResOathMsg)
end

return UIWeddingMoreInfoPanelTemplates
