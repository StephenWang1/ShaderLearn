---@class UIHeartSkillViewTemplate
local UIHeartSkillViewTemplate = {};

UIHeartSkillViewTemplate.mHeartSkillUnitDic = nil;

UIHeartSkillViewTemplate.mCurHeartShowType = nil;

UIHeartSkillViewTemplate.mOriginScrollPosition = nil;

UIHeartSkillViewTemplate.mCoroutineDelay = nil;

UIHeartSkillViewTemplate.mLastIsOpenHeartFormation = true;

--region Components

--region GameObject

function UIHeartSkillViewTemplate:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnClose_GameObject = self:Get("UIHeartSkillFormationPanel/events/btn_help", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UIHeartSkillViewTemplate:GetSkillInfoPanelMask_GameObject()
    if (self.mSkillInfoPanelMask_GameObject == nil) then
        self.mSkillInfoPanelMask_GameObject = self:Get("UISkillColumn/mask", "GameObject");
    end
    return self.mSkillInfoPanelMask_GameObject;
end

--endregion

function UIHeartSkillViewTemplate:GetHeartSkillInfoViewTemplate()
    if (self.mHeartSkillInfoViewTemplate == nil) then
        self.mHeartSkillInfoViewTemplate = templatemanager.GetNewTemplate(self:Get("infoPanel", "GameObject"), luaComponentTemplates.UIHeartSkillInfoViewTemplate, self.mOwnerPanel)
    end
    return self.mHeartSkillInfoViewTemplate;
end

function UIHeartSkillViewTemplate:GetUnitGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("UISkillColumn/Scroll View/skills", "UIGridContainer");
    end
    return self.mUnitGridContainer;
end

function UIHeartSkillViewTemplate:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:Get("UISkillColumn/Scroll View", "UIScrollView");
    end
    return self.mScrollView;
end

function UIHeartSkillViewTemplate:GetScrollViewPanel()
    if (self.mScrollViewPanel == nil) then
        self.mScrollViewPanel = self:Get("UISkillColumn/Scroll View", "UIPanel");
    end
    return self.mScrollViewPanel;
end

function UIHeartSkillViewTemplate:GetHeartSkillSpringPanel()
    if (self.mHeartSkillSpringPanel == nil) then
        self.mHeartSkillSpringPanel = self:Get("UISkillColumn/Scroll View", "SpringPanel");
    end
    return self.mHeartSkillSpringPanel;
end

function UIHeartSkillViewTemplate:GetClipShaderComponent()
    if (self.mClipShaderComponent == nil) then
        self.mClipShaderComponent = self:Get("UISkillColumn/Scroll View", "Top_OptimizeClipShaderScript");
    end
    return self.mClipShaderComponent;
end

---@return UIHeartSkillFormationTemplate
function UIHeartSkillViewTemplate:GetHeartSkillFormationTemplate()
    if (self.mHeartSkillFormationTemplate == nil) then
        self.mHeartSkillFormationTemplate = templatemanager.GetNewTemplate(self:Get("UIHeartSkillFormationPanel", "GameObject"), luaComponentTemplates.UIHeartSkillFormationTemplate, self, self.mOwnerPanel);
    end
    return self.mHeartSkillFormationTemplate;
end

function UIHeartSkillViewTemplate:GetClientEventHandler()
    if (self.mClientHandler == nil) then
        self.mClientHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    end
    return self.mClientHandler;
end

function UIHeartSkillViewTemplate:GetDragRootPanel_UIPanel()
    if (self.mDragRootPanel_UIPanel == nil) then
        self.mDragRootPanel_UIPanel = CS.Utility_Lua.GetComponent(CS.UIDragDropRoot.root, "UIPanel");
        self.mDragRootPanel_UIPanel.depth = 1000;
    end
    return self.mDragRootPanel_UIPanel;
end

function UIHeartSkillViewTemplate:GetRoot()
    if self.mRoot == nil then
        self.mRoot = CS.Utility_Lua.GetComponent(CS.UnityEngine.GameObject.Find("UI Root"), "UIRoot")
    end
    return self.mRoot
end

--endregion

--region Method

--region CallFunction

function UIHeartSkillViewTemplate:OnResSecretSkillInfoMessage(msgId, tableData)
    self:TryDelayUpdate();
end

--region 心阵拖拽事件

function UIHeartSkillViewTemplate:OnHeartSkillFormationUnitDragStart(heartSkillType)
    local unit = self:GetHeartSkillFormationTemplate():GetSkillIconUnitTemplateWithHeartSkillType(heartSkillType)
    if (unit ~= nil and unit:GetSkillIcon_UISprite().gameObject.activeSelf) then
        local targetIconSprite = Utility.TryGetDragSkillSprite();
        if (targetIconSprite ~= nil) then
            targetIconSprite.spriteName = unit:GetSkillIcon_UISprite().spriteName;
            targetIconSprite.transform.position = unit:GetSkillIcon_UISprite().transform.position;
            unit:GetSkillIcon_UISprite().gameObject:SetActive(false);
            targetIconSprite.gameObject:SetActive(true);
        end
    end
end

function UIHeartSkillViewTemplate:OnHeartSkillFormationUnitDrag(heartSkillType, delta)
    local targetIconSprite = Utility.TryGetDragSkillSprite();
    if (targetIconSprite ~= nil) then
        targetIconSprite.transform.localPosition = targetIconSprite.transform.localPosition + CS.UnityEngine.Vector3(delta.x, delta.y, 0) * self:GetRoot().pixelSizeAdjustment;
    end
end

function UIHeartSkillViewTemplate:OnHeartSkillFormationUnitDragEnd(heartSkillType)
    local unit = self:GetHeartSkillFormationTemplate():GetSkillIconUnitTemplateWithHeartSkillType(heartSkillType)
    if (unit ~= nil) then
        local targetIconSprite = Utility.TryGetDragSkillSprite();
        if (targetIconSprite ~= nil) then
            targetIconSprite.gameObject:SetActive(false);
        end

        local skillFormationIconUnitDic = self:GetHeartSkillFormationTemplate():GetSkillFormationIconUnitDic();
        if (skillFormationIconUnitDic ~= nil) then
            for k, v in pairs(skillFormationIconUnitDic) do
                local distance = CS.UnityEngine.Vector3.Distance(targetIconSprite.transform.position, v:GetSkillIcon_UISprite().transform.position);
                if (distance < 0.1 and k ~= heartSkillType) then
                    local usedSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
                    local isFind, skillId = usedSkillDic:TryGetValue(heartSkillType);
                    if (isFind) then
                        self:GetHeartSkillFormationTemplate():OnSelectHeartSkillType(k);
                        luaEventManager.DoCallback(LuaCEvent.Skill_OnHeartSkillUseButtonClick, heartSkillType);
                        networkRequest.ReqSecretSkillUpdate(skillId, CS.CSScene.MainPlayerInfo.SkillInfoV2.SelectHeartSkillType);
                    end
                    return ;
                end
            end
        end

        local distance = CS.UnityEngine.Vector3.Distance(unit:GetSkillIcon_UISprite().transform.position, targetIconSprite.transform.position);
        if (distance > 0.1) then
            local usedSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
            local isFind, skillId = usedSkillDic:TryGetValue(heartSkillType);
            if (isFind) then
                networkRequest.ReqTakeOffSecret(skillId);
            end
        else
            unit:GetSkillIcon_UISprite().gameObject:SetActive(true);
        end
    end
end

--endregion

--region 心法拖拽事件

function UIHeartSkillViewTemplate:OnHeartSkillUnitDragStart(unit)
    if (unit ~= nil and self.mCurHeartShowType == LuaEnumHeartSkillShowType.HeartFormation) then
        local targetIconSprite = Utility.TryGetDragSkillSprite();
        local iconSprite = unit:GetSkillIconUnitTemplate():GetSkillIcon_UISprite();
        if (targetIconSprite ~= nil) then
            targetIconSprite.spriteName = iconSprite.spriteName;
            targetIconSprite.transform.position = iconSprite.transform.position;
            targetIconSprite.gameObject:SetActive(true);
        end
    end
end

function UIHeartSkillViewTemplate:OnHeartSkillUnitDrag(unit, delta)
    local targetIconSprite = Utility.TryGetDragSkillSprite();
    if (targetIconSprite ~= nil) then
        targetIconSprite.transform.localPosition = targetIconSprite.transform.localPosition + CS.UnityEngine.Vector3(delta.x, delta.y, 0) * self:GetRoot().pixelSizeAdjustment;
    end
end

function UIHeartSkillViewTemplate:OnHeartSkillUnitDragEnd(unit)
    if (unit ~= nil) then
        local targetIconSprite = Utility.TryGetDragSkillSprite();
        if (targetIconSprite ~= nil) then
            targetIconSprite.gameObject:SetActive(false);
        end
        local skillFormationIconUnitDic = self:GetHeartSkillFormationTemplate():GetSkillFormationIconUnitDic();
        if (skillFormationIconUnitDic ~= nil) then
            for k, v in pairs(skillFormationIconUnitDic) do
                local distance = CS.UnityEngine.Vector3.Distance(targetIconSprite.transform.position, v:GetSkillIcon_UISprite().transform.position);
                if (distance < 0.1) then
                    self:GetHeartSkillFormationTemplate():OnSelectHeartSkillType(k);
                    return unit:OnClickBtnUse();
                end
            end
        end
    end
end

--endregion

--endregion

--region Public

--function UIHeartSkillViewTemplate:OnUpdate()
--    self:GetHeartSkillFormationTemplate():OnUpdate();
--end

function UIHeartSkillViewTemplate:TryDelayUpdate()
    local isDelay = false;
    if (self.mHeartSkillUnitDic ~= nil) then
        for k, v in pairs(self.mHeartSkillUnitDic) do
            if (v.mIsShowStudyEffect) then
                isDelay = true;
                break ;
            end
        end
    end
    if (isDelay) then
        if (self.mCoroutineDelay ~= nil) then
            StopCoroutine(self.mCoroutineDelay);
            self.mCoroutineDelay = nil;
        end
        self.mCoroutineDelay = StartCoroutine(self.CDelayTimeUpdate, self, 1.2);
    else
        self:UpdateHeartSkill(self.mCurHeartShowType);
    end
end

function UIHeartSkillViewTemplate:ShowHeartSkill()
    self:GetHeartSkillSpringPanel().target = self.mOriginScrollPosition;
    self:GetHeartSkillSpringPanel().enabled = true;
    self.mCurHeartShowType = LuaEnumHeartSkillShowType.HeartSkill;
    networkRequest.ReqSecretSkillInfo();
    self:GetHeartSkillFormationTemplate():SetIsShow(false);
end

function UIHeartSkillViewTemplate:ShowSkillFormation()
    self:GetHeartSkillSpringPanel().target = self.mOriginScrollPosition;
    self:GetHeartSkillSpringPanel().enabled = true;
    self.mCurHeartShowType = LuaEnumHeartSkillShowType.HeartFormation;
    networkRequest.ReqSecretSkillInfo();
    self:GetHeartSkillFormationTemplate():SetIsShow(true);
    uimanager:ClosePanel("UIBagPanel");
end

function UIHeartSkillViewTemplate:ShowSkillInfoView(template)
    self:GetSkillInfoPanelMask_GameObject():SetActive(true);
    self:GetHeartSkillInfoViewTemplate().go:SetActive(true);
    self:GetHeartSkillInfoViewTemplate():ShowHeartSkill(template);
end

function UIHeartSkillViewTemplate:CloseSkillInfoView()
    self:GetHeartSkillInfoViewTemplate().go:SetActive(false);
    self:GetSkillInfoPanelMask_GameObject():SetActive(false);
end

function UIHeartSkillViewTemplate:SelectWithType(heartSkillType)
    local index = 0;
    for k, v in pairs(self.mHeartSkillUnitDic) do
        if (v.mSkillTable ~= nil and v.mSkillTable.secretSkillType == heartSkillType) then
            index = index + 1;
            index = index > 0 and index or 0;
            break ;
        end
    end
    local viewHeight = self:GetScrollViewPanel():GetViewSize().y;
    local viewCount = math.floor(viewHeight / self:GetUnitGridContainer().CellHeight);
    local intervalHeight = (math.floor(viewHeight / self:GetUnitGridContainer().CellHeight) - viewCount) * self:GetUnitGridContainer().CellHeight;
    if (viewCount < index) then
        local distance = (index - viewCount) * self:GetUnitGridContainer().CellHeight + intervalHeight;
        local maxHeight = self:GetUnitGridContainer().MaxCount * self:GetUnitGridContainer().CellHeight;
        local interval = maxHeight - self:GetScrollViewPanel().height;
        distance = distance > math.abs(interval) and interval or distance;

        self:GetHeartSkillSpringPanel().target = CS.UnityEngine.Vector3(self.mOriginScrollPosition.x, self.mOriginScrollPosition.y + distance, self.mOriginScrollPosition.z);
        self:GetHeartSkillSpringPanel().enabled = true;
    end
end

--endregion

--region Private

function UIHeartSkillViewTemplate:CDelayTimeUpdate(delayTime)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(delayTime));
    if (self.mCurHeartShowType ~= nil) then
        self:UpdateHeartSkill(self.mCurHeartShowType);
    end
end

function UIHeartSkillViewTemplate:UpdateHeartSkill(heartShowType)
    if (self.mHeartSkillUnitDic == nil) then
        self.mHeartSkillUnitDic = {};
    end
    local gridContainer = self:GetUnitGridContainer();
    local showTables, count;
    if (self.mCurHeartShowType == LuaEnumHeartSkillShowType.HeartSkill) then
        showTables, count = self:GetShowHeartSkills();
    elseif (self.mCurHeartShowType == LuaEnumHeartSkillShowType.HeartFormation) then
        showTables, count = self:GetHasSkills();
    end
    gridContainer.MaxCount = count;
    local index = 0;
    for k0, v0 in pairs(showTables) do
        for k1, v1 in pairs(v0) do
            local gobj = gridContainer.controlList[index];
            if (self.mHeartSkillUnitDic[gobj] == nil) then
                self.mHeartSkillUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIHeartSkillUnitTemplate, self);
            end
            self.mHeartSkillUnitDic[gobj]:ShowHeartSkillUnit(v1.id, heartShowType, index);
            index = index + 1;
        end
    end

    self:GetHeartSkillFormationTemplate():ShowHeartSkillFormation();
    local useHeartSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
    self:GetBtnHelp_GameObject():SetActive(useHeartSkillDic.Count > 0 and CS.CSScene.MainPlayerInfo.SkillInfoV2.CurUseHeartSkillFormationId == 0);
end

function UIHeartSkillViewTemplate:GetIndexBySecretType(secretSkillType)
    if (secretSkillType == LuaEnumSecretSkillType.SecretLife) then
        return 1;
    elseif (secretSkillType == LuaEnumSecretSkillType.SecretElementalAttack) then
        return 3;
    elseif (secretSkillType == LuaEnumSecretSkillType.SecretDefense) then
        return 2;
    elseif (secretSkillType == LuaEnumSecretSkillType.SecretElementalDefense) then
        return 4;
    elseif (secretSkillType == LuaEnumSecretSkillType.SecretResistanceToOccupation) then
        return 5;
    elseif (secretSkillType == LuaEnumSecretSkillType.SecretResistanceToSkill) then
        return 6;
    end
end

function UIHeartSkillViewTemplate:GetShowHeartSkills()
    local showSkills = {};
    local showCount = 0;
    local skillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic;
    for k, v in pairs(skillDic) do
        local isFind, skillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(v.skillId);
        if (isFind) then
            if (skillTable.cls == 3) then
                local index = self:GetIndexBySecretType(skillTable.secretSkillType);
                if (showSkills[index] == nil) then
                    showSkills[index] = {};
                end
                showCount = showCount + 1;
                table.insert(showSkills[index], skillTable);
            end
        end
    end

    local bagSkillIds = CS.CSScene.MainPlayerInfo.BagInfo:GetSkillIdList(1);
    if (bagSkillIds ~= nil and bagSkillIds.Count > 0) then
        for i = 0, bagSkillIds.Count - 1 do
            local v = bagSkillIds[i];
            local isFind, skillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(v);
            local hasSkill = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic:TryGetValue(v);
            if (isFind) then
                if (skillTable.cls == 3 and not hasSkill) then
                    local index = self:GetIndexBySecretType(skillTable.secretSkillType);
                    if (showSkills[index] == nil) then
                        showSkills[index] = {};
                    end
                    showCount = showCount + 1;
                    table.insert(showSkills[index], skillTable);
                end
            end
        end
    end

    local function Sort(a, b)
        return tonumber(a.index) < tonumber(b.index)
    end

    for k0, v0 in pairs(showSkills) do
        table.sort(showSkills[k0], Sort);
    end

    return showSkills, showCount;
end

function UIHeartSkillViewTemplate:GetHasSkills()
    local showSkills = {};
    local showCount = 0;
    local skillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic;
    for k, v in pairs(skillDic) do
        local isFind, skillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(v.skillId);
        if (isFind) then
            if (skillTable.cls == 3) then
                local index = self:GetIndexBySecretType(skillTable.secretSkillType);
                if (showSkills[index] == nil) then
                    showSkills[index] = {};
                end
                showCount = showCount + 1;
                table.insert(showSkills[index], skillTable);
            end
        end
    end

    local function Sort(a, b)
        return tonumber(a.index) < tonumber(b.index)
    end

    for k0, v0 in pairs(showSkills) do
        table.sort(showSkills[k0], Sort);
    end

    return showSkills, showCount;
end

function UIHeartSkillViewTemplate:Initialize()
    self.mCurHeartShowType = LuaEnumHeartSkillShowType.HeartSkill;
    self.mOriginScrollPosition = self:GetScrollViewPanel().gameObject.transform.localPosition;
    self.mLastIsOpenHeartFormation = CS.Cfg_NavigationTableManager.Instance:IsOpenHeartFormation();
end

function UIHeartSkillViewTemplate:InitEvents()

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(43)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end

    self.CallOnHeartSkillUnitClicked = function(msgId, template)
        self:ShowSkillInfoView(template)
    end

    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Skill_OnHeartSkillUnitClicked, self.CallOnHeartSkillUnitClicked);

    self.CallOnHeartSkillFormationUnitClicked = function(msgId, heartSkillType)
        --self:SelectWithType(heartSkillType);
    end

    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Skill_OnHeartSkillFormationUnitClicked, self.CallOnHeartSkillFormationUnitClicked)

    CS.UIEventListener.Get(self:GetSkillInfoPanelMask_GameObject()).onClick = function()
        self:CloseSkillInfoView();
    end

    self.CallUpdateSkillState = function(msgId, msgData)
        local isOpenHeartFormation = CS.Cfg_NavigationTableManager.Instance:IsOpenHeartFormation();
        if (not self.mLastIsOpenHeartFormation and self.mLastIsOpenHeartFormation ~= isOpenHeartFormation) then
            luaEventManager.DoCallback(LuaCEvent.Navigation_UpdateUnit);
            self.mLastIsOpenHeartFormation = isOpenHeartFormation;
        end
        self:TryDelayUpdate();
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, self.CallUpdateSkillState);

    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, self.CallUpdateSkillState);

    self.CallOnResOneSkillChangeMessage = function(msgId, msgData)
        if (msgData ~= nil and msgData.skillBean ~= nil and CS.Cfg_SkillTableManager.Instance:IsSecretSkill(msgData.skillBean.skillId)) then
            self:TryDelayUpdate();
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneSkillChangeMessage, self.CallOnResOneSkillChangeMessage);

    self.CallOnResSecretSkillInfoMessage = function(msgId, tableData)
        self:OnResSecretSkillInfoMessage(msgId, tableData)
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSecretSkillInfoMessage, self.CallOnResSecretSkillInfoMessage);
end

function UIHeartSkillViewTemplate:RemoveEvents()

    if (self.mCoroutineDelay ~= nil) then
        StopCoroutine(self.mCoroutineDelay);
        self.mCoroutineDelay = nil;
    end

    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Skill_OnHeartSkillUnitClicked, self.CallOnHeartSkillUnitClicked);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Skill_OnHeartSkillFormationUnitClicked, self.CallOnHeartSkillFormationUnitClicked)

    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_BagItemChanged, self.CallUpdateSkillState);

    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, self.CallUpdateSkillState);
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResOneSkillChangeMessage, self.CallOnResOneSkillChangeMessage);

    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSecretSkillInfoMessage, self.CallOnResSecretSkillInfoMessage);
end

function UIHeartSkillViewTemplate:Clear()
    self.mHeartSkillFormationTemplate = nil;
    self.mHeartSkillSpringPanel = nil;
    self.mScrollViewPanel = nil;
    self.mScrollView = nil;
    self.mUnitGridContainer = nil;
    self.mHeartSkillInfoViewTemplate = nil;
    self.mSkillInfoPanelMask_GameObject = nil;

    self.mHeartSkillUnitDic = nil;
    self.mCurHeartShowType = nil;
    self.mOriginScrollPosition = nil;

    self.mClientHandler = nil;
end

--endregion

function UIHeartSkillViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:Initialize();
end

function UIHeartSkillViewTemplate:OnEnable()
    self:InitEvents();
end

function UIHeartSkillViewTemplate:OnDisable()
    self:RemoveEvents();
end

function UIHeartSkillViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

--endregion

return UIHeartSkillViewTemplate;