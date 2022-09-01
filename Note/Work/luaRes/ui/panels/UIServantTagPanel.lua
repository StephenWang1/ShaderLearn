local UIServantTagPanel = {};

UIServantTagPanel.PanelLayerType = CS.UILayerType.WindowsPlane;

UIServantTagPanel.mCurSelect = LuaEnumServantPanelType.BasePanel;

UIServantTagPanel.mViewTemplateDic = {};

--region Components

--region GameObject

function UIServantTagPanel:GetEquip_GameObject()
    if (self.mEquip_GameObject == nil) then
        self.mEquip_GameObject = self:GetCurComp("WidgetRoot/Equip", "GameObject");
    end
    return self.mEquip_GameObject;
end

function UIServantTagPanel:GetLevel_GameObject()
    if (self.mLevel_GameObject == nil) then
        self.mLevel_GameObject = self:GetCurComp("WidgetRoot/Level", "GameObject");
    end
    return self.mLevel_GameObject;
end

function UIServantTagPanel:GetRein_GameObject()
    if (self.mRein_GameObject == nil) then
        self.mRein_GameObject = self:GetCurComp("WidgetRoot/Rein", "GameObject");
    end
    return self.mRein_GameObject;
end

function UIServantTagPanel:GetLeftTagBg_UISprite()
    if (self.mLeftBGSprite == nil) then
        self.mLeftBGSprite = self:GetCurComp("WidgetRoot/Tab/LeftTabBg", "UISprite")
    end
    return self.mLeftBGSprite
end

function UIServantTagPanel:GetTglEquip_GameObject()
    if (self.mTglEquip_GameObject == nil) then
        self.mTglEquip_GameObject = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_equip", "GameObject");
    end
    return self.mTglEquip_GameObject;
end

function UIServantTagPanel:GetTglLevel_GameObject()
    if (self.mTglLevel_GameObject == nil) then
        self.mTglLevel_GameObject = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_level", "GameObject");
    end
    return self.mTglLevel_GameObject;
end

function UIServantTagPanel:GetTglRein_GameObject()
    if (self.mTglRein_GameObject == nil) then
        self.mTglRein_GameObject = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_rein", "GameObject");
    end
    return self.mTglRein_GameObject;
end

---@return UnityEngine.GameObject
function UIServantTagPanel:GetTglHunJi_GameObject()
    if self.mTglHunJi_GameObject == nil then
        self.mTglHunJi_GameObject = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_hunji", "GameObject")
    end
    return self.mTglHunJi_GameObject
end
--endregion

--region UIToggle

function UIServantTagPanel:GetEquip_UIToggle()
    if (self.mEquip_UIToggle == nil) then
        self.mEquip_UIToggle = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_equip", "UIToggle");
    end
    return self.mEquip_UIToggle;
end

function UIServantTagPanel:GetLevel_UIToggle()
    if (self.mLevel_UIToggle == nil) then
        self.mLevel_UIToggle = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_level", "UIToggle");
    end
    return self.mLevel_UIToggle;
end

function UIServantTagPanel:GetRein_UIToggle()
    if (self.mRein_UIToggle == nil) then
        self.mRein_UIToggle = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_rein", "UIToggle");
    end
    return self.mRein_UIToggle;
end

function UIServantTagPanel:GetHunJi_UIToggle()
    if (self.mHunJi_UIToggle == nil) then
        self.mHunJi_UIToggle = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_hunji", "UIToggle");
    end
    return self.mHunJi_UIToggle;
end
--endregion

function UIServantTagPanel:GetServantEquipViewTemplate()
    if (self.mServantEquipViewTemplate == nil) then
        self.mServantEquipViewTemplate = templatemanager.GetNewTemplate(self:GetEquip_GameObject(), luaComponentTemplates.UIServantEquipViewTemplate)
    end
    return self.mServantEquipViewTemplate;
end

function UIServantTagPanel:GetServantInfo()
    if (self.mServantInfo == nil) then
        self.mServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    end
    return self.mServantInfo
end

---@return UIRedPoint
function UIServantTagPanel:GetLevelRedPoint_UIRedPoint()
    if self.mLevelRedPoint == nil then
        self.mLevelRedPoint = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_level/redpoint", "UIRedPoint")
    end
    return self.mLevelRedPoint
end

---@return UIRedPoint
function UIServantTagPanel:GetReinRedPoint_UIRedPoint()
    if self.mReinRedPoint_UIRedPoint == nil then
        self.mReinRedPoint_UIRedPoint = self:GetCurComp("WidgetRoot/Tab/LeftTabBg/btn_rein/redpoint", "UIRedPoint")
    end
    return self.mReinRedPoint_UIRedPoint
end
--endregion

--region Method

--region CallFunction

function UIServantTagPanel:OnTglEquipClicked()
    self:SelectWithServantType(LuaEnumServantPanelType.BasePanel);
end

function UIServantTagPanel:OnTglLevelClicked()
    self:SelectWithServantType(LuaEnumServantPanelType.LevelPanel);
end

function UIServantTagPanel:OnTglReinClicked()
    self:SelectWithServantType(LuaEnumServantPanelType.ReinPanel);
    if gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_LingShou == true then
        gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_LingShou = false
        gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():CallRed(LuaRedPointName.LianZhi_LingShou)
    end
end

function UIServantTagPanel:OnTglHunJiClicked()
    self:SelectWithServantType(LuaEnumServantPanelType.HunJiPanel);
end
--endregion

--region CallFunction
function UIServantTagPanel:OnResServantLevelUpMessage()
    self:ShowButtons();
    --self:PlayButtonsFadeIn();
end
--endregion

--region Public

function UIServantTagPanel:SelectWithServantType(servantType, servantIndex, redpoint)
    local servantPanel = uimanager:GetPanel("UIServantPanel");
    if (servantPanel ~= nil) then
        local data = {}
        data.servantPanelType = servantType
        data.IsOpenPracticePanel = self.IsOpenPracticePanel
        data.IsOpenGatherSoulPanel = self.IsOpenGatherSoulPanel
        luaEventManager.DoCallback(LuaCEvent.Servant_OnClickServantTag, data);
    else
        local customData = {};
        customData.pos = servantIndex;
        if (not redpoint) then
            customData.topOpenType = servantType;
        end
        customData.openServantPanelType = self.mServantOpenType
        customData.isCreatedWithTag = true
        customData.IsOpenPracticePanel = self.IsOpenPracticePanel
        customData.IsOpenGatherSoulPanel = self.IsOpenGatherSoulPanel
        customData.SpecialOpen = self.SpecialOpen
        uimanager:CreatePanel("UIServantPanel", nil, customData);
    end
end

function UIServantTagPanel:PlayButtonsFadeIn()
    if (self.mButtonsFadeInCoroutine ~= nil) then
        self.mButtonsFadeInCoroutine = StopCoroutine(self.mButtonsFadeInCoroutine);
        self.mButtonsFadeInCoroutine = nil;
    end
    self.mButtonsFadeInCoroutine = StartCoroutine(self.IEnumButtonsFadeIn, self);
end

--endregion

--region Private

--region 按钮渐入动画

function UIServantTagPanel:IEnumButtonsFadeIn()
    for k, v in pairs(self.mButtonList) do
        v:SetActive(false);
    end

    for k, v in pairs(self.mButtonList) do
        v:SetActive(true);
        if (self.mTweenPositionList == nil) then
            self.mTweenPositionList = {};
        end
        if (self.mTweenAlphaList == nil) then
            self.mTweenAlphaList = {};
        end

        if (self.mTweenPositionList[k] == nil) then
            self.mTweenPositionList[k] = CS.Utility_Lua.GetComponent(v, "TweenPosition");
            if (self.mTweenPositionList[k] == nil) then
                self.mTweenPositionList[k] = v:AddComponent(typeof(CS.TweenPosition));
                self.mTweenPositionList[k].duration = 0.2;
            end
        end

        if (self.mTweenAlphaList[k] == nil) then
            self.mTweenAlphaList[k] = CS.Utility_Lua.GetComponent(v, "TweenAlpha");
            if (self.mTweenAlphaList[k] == nil) then
                self.mTweenAlphaList[k] = v:AddComponent(typeof(CS.TweenAlpha));
                self.mTweenAlphaList[k].duration = 0.2;
            end
        end

        local originPosition = self.mButtonOriginPositionList[k] == nil and CS.UnityEngine.Vector3.zero or self.mButtonOriginPositionList[k];
        self.mTweenPositionList[k].from = CS.UnityEngine.Vector3(originPosition.x - 50, originPosition.y, originPosition.z);
        self.mTweenPositionList[k].to = originPosition;
        self.mTweenPositionList[k]:PlayTween();

        self.mTweenAlphaList[k].from = 0;
        self.mTweenAlphaList[k].to = 1;
        self.mTweenAlphaList[k]:PlayTween();
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.05));
    end
end

function UIServantTagPanel:ResetTweenOriginParameter()
    self.mButtonOriginPositionList = {};
    for k, v in pairs(self.mButtonList) do
        table.insert(self.mButtonOriginPositionList, v.transform.localPosition);
    end
end
--endregion

function UIServantTagPanel:ShowButtons()
    self.mButtonList = {};
    ----装备
    table.insert(self.mButtonList, self:GetTglEquip_GameObject().gameObject);
    ----等级
    --table.insert(self.mButtonList, self:GetTglLevel_GameObject().gameObject);
    ---转生
    local isOpenRein = self:IsOpenButtons(LuaEnumServantPanelType.ReinPanel);
    self:GetTglRein_GameObject().gameObject:SetActive(false)
    if (isOpenRein) then
        --table.insert(self.mButtonList, self:GetTglRein_GameObject().gameObject);
    end
    ---魂继
    local isOpenHunJi = self:IsOpenButtons(LuaEnumServantPanelType.HunJiPanel)
    self:GetTglHunJi_GameObject():SetActive(isOpenHunJi)
    if isOpenHunJi then
        table.insert(self.mButtonList, self:GetTglHunJi_GameObject())
    end
    local originY = -47;
    local interval = 75;
    local index = 0;
    for k, v in pairs(self.mButtonList) do
        v.transform.localPosition = CS.UnityEngine.Vector3(v.transform.localPosition.x, originY - interval * index, v.transform.localPosition.z);
        index = index + 1;
    end
    self:GetLeftTagBg_UISprite().height = 80 + interval * (index - 1)
    self:ResetTweenOriginParameter();
end

---三只灵兽中任意一只打到等级开启转生页签
function UIServantTagPanel:IsOpenButtons(type)
    if (type == LuaEnumServantPanelType.ReinPanel) then
        local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20233)
        if (isFind) then
            local ShowReinLevel = tonumber(string.Split(globalTable.value, "#")[1])
            if ShowReinLevel then
                for i = 0, self:GetServantInfo().ServantInfoList.Count - 1 do
                    if self:GetServantInfo().ServantInfoList[i].level >= ShowReinLevel then
                        return true
                    end
                end
            end
        end
    elseif type == LuaEnumServantPanelType.HunJiPanel then
        return CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData.IsHunJiSystemOpened
    else
        return true;
    end
    return false
end

function UIServantTagPanel:Initialize()
    self:ShowButtons();
    self:ResetTweenOriginParameter();
    self:PlayButtonsFadeIn();
end

function UIServantTagPanel:InitEvents()
    CS.UIEventListener.Get(self:GetTglEquip_GameObject()).onClick = function()
        uimanager:ClosePanel("UIServantPracticePanel")
        uimanager:ClosePanel("UIServantGatherSoulPanel")
        uimanager:ClosePanel("UIRefineServantPanel")
        self:OnTglEquipClicked();
    end;
    CS.UIEventListener.Get(self:GetTglLevel_GameObject()).onClick = function()
        self:OnTglLevelClicked()
        uimanager:ClosePanel("UIServantGatherSoulPanel")
        uimanager:ClosePanel("UIRefineServantPanel")
    end
    CS.UIEventListener.Get(self:GetTglRein_GameObject()).onClick = function()
        uimanager:ClosePanel("UIServantPracticePanel")
        self:OnTglReinClicked()
        uimanager:ClosePanel("UIBagPanel")
        if gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isNeedopen_LianzhiLingShou then
            uimanager:CreatePanel("UIRefineServantPanel")
        end
    end;
    CS.UIEventListener.Get(self:GetTglHunJi_GameObject()).onClick = function()
        uimanager:ClosePanel("UIServantPracticePanel")
        uimanager:ClosePanel("UIServantGatherSoulPanel")
        uimanager:ClosePanel("UIRefineServantPanel")
        self:OnTglHunJiClicked()
    end

    self:GetClientEventHandler():AddEvent(CS.CEvent.UpdateOrientationState, function()
        self:ResetTweenOriginParameter()
    end);
    self.mResServantLevelUpMsgFunction = function()
        self:OnResServantLevelUpMessage()
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantLevelUpMessage, self.mResServantLevelUpMsgFunction)
end

function UIServantTagPanel:RemoveEvents()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantLevelUpMessage, self.mResServantLevelUpMsgFunction)
end

--endregion

--endregion

function UIServantTagPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end
    if (customData.servantIndex == nil) then
        customData.servantIndex = 0;
    end
    if (customData.type == nil) then
        customData.type = LuaEnumServantPanelType.BasePanel;
    end
    if (customData.IsOpenPracticePanel == nil) then
        customData.IsOpenPracticePanel = false;
    end
    if (customData.IsOpenGatherSoulPanel == nil) then
        customData.IsOpenGatherSoulPanel = false;
    end

    self.mIndex = customData.servantIndex;
    self.mServantType = customData.type;
    self.mServantOpenType = customData.openSourceType
    self.IsOpenPracticePanel = customData.IsOpenPracticePanel
    self.IsOpenGatherSoulPanel = customData.IsOpenGatherSoulPanel
    self.SpecialOpen = customData.SpecialOpen
    self:SelectWithServantType(self.mServantType, self.mIndex, customData.redpoint);
    --Utility.TryFadeOutMainMenusLeft("UIServantTagPanel");
    --self:GetReinRedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_LingShou))
end

function UIServantTagPanel:Init()
    self:Initialize();
    self:InitEvents();
    self:AddRedPoint()
end

function start()
    Utility.TryFadeOutMainMenusLeft("UIRolePanelTagPanel");
end

function ondestroy()
    UIServantTagPanel:RemoveEvents();
    luaEventManager.DoCallback(LuaCEvent.MainMenus_LeftFadeIn, "UIServantTagPanel");
end

function UIServantTagPanel:AddRedPoint()
    --if not CS.StaticUtility.IsNull(self:GetLevelRedPoint_UIRedPoint()) then
    --    self:GetLevelRedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_HM))
    --    self:GetLevelRedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_LX))
    --    self:GetLevelRedPoint_UIRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_TC))
    --end
end

return UIServantTagPanel;