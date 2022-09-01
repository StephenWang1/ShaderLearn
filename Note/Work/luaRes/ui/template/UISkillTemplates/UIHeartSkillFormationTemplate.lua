---@class UIHeartSkillFormationTemplate
local UIHeartSkillFormationTemplate = {};

---心法视图类
UIHeartSkillFormationTemplate.mHearSkillView = nil;
---技能icon单元字典
UIHeartSkillFormationTemplate.mSkillIconUnitDic = nil;
---心阵特效对象父节点字典
UIHeartSkillFormationTemplate.mFormationEffectLoadDic = nil
---心阵使用特效对象
UIHeartSkillFormationTemplate.mUseEffectLoadDic = nil;
---技能描述单元字典
UIHeartSkillFormationTemplate.mSkillShowTextUnitDic = nil;
---心法类型字典
UIHeartSkillFormationTemplate.mShowHeartSkillTypes = nil;
---当前选择的类型
UIHeartSkillFormationTemplate.mSelectType = nil;

--UIHeartSkillFormationTemplate.mIsShowUseEffectDic = nil;

UIHeartSkillFormationTemplate.mLongPressTimer = 0;

--region Components

--region GameObject

function UIHeartSkillFormationTemplate:GetSkillFormation_GameObject()
    if (self.mSkillFormation_GameObject == nil) then
        self.mSkillFormation_GameObject = self:Get("skillFormation", "GameObject");
    end
    return self.mSkillFormation_GameObject;
end

function UIHeartSkillFormationTemplate:GetNotHas_GameObject()
    if (self.mNotHas_GameObject == nil) then
        self.mNotHas_GameObject = self:Get("notHas", "GameObject");
    end
    return self.mNotHas_GameObject;
end

function UIHeartSkillFormationTemplate:GetFormationInfo_GameObject()
    if (self.mFormationInfo_GameObject == nil) then
        self.mFormationInfo_GameObject = self:Get("attribute", "GameObject");
    end
    return self.mFormationInfo_GameObject;
end

function UIHeartSkillFormationTemplate:GetBtnFormation_GameObject()
    if (self.mBtnFormation_GameObject == nil) then
        self.mBtnFormation_GameObject = self:Get("events/btnFormation", "GameObject");
    end
    return self.mBtnFormation_GameObject;
end

function UIHeartSkillFormationTemplate:GetFormationIconEffect_GameObject()
    if (self.mFormationIconEffect_GameObject == nil) then
        self.mFormationIconEffect_GameObject = self:Get("window/formationIconEffect", "GameObject");
    end
    return self.mFormationIconEffect_GameObject;
end

function UIHeartSkillFormationTemplate:GetFormationIconActiveEffect_GameObject()
    if (self.mFormationIconActiveEffect_GameObject == nil) then
        self.mFormationIconActiveEffect_GameObject = self:Get("window/activeEffect", "GameObject");
    end
    return self.mFormationIconActiveEffect_GameObject;
end

function UIHeartSkillFormationTemplate:GetFormationMidEffect_GameObject()
    if (self.mFormationMidEffect_GameObject == nil) then
        self.mFormationMidEffect_GameObject = self:Get("window/midEffect", "GameObject");
    end
    return self.mFormationMidEffect_GameObject;
end

--endregion

--region UILabel

function UIHeartSkillFormationTemplate:GetFormationName_Text()
    if (self.mFormationName_Text == nil) then
        self.mFormationName_Text = self:Get("attribute/Label", "UILabel");
    end
    return self.mFormationName_Text;
end

--endregion

--region UISprite

function UIHeartSkillFormationTemplate:GetFormationIcon_UISprite()
    if (self.mFormationIcon_UISprite == nil) then
        self.mFormationIcon_UISprite = self:Get("window/formationIcon", "UISprite");
    end
    return self.mFormationIcon_UISprite;
end

function UIHeartSkillFormationTemplate:GetFormationStaticIcon_UISprite()
    if (self.mFormationStaticIcon_UISprite == nil) then
        self.mFormationStaticIcon_UISprite = self:Get("window/formationStaticIcon", "UISprite");
    end
    return self.mFormationStaticIcon_UISprite;
end

--endregion

function UIHeartSkillFormationTemplate:GetFormationSkillContainer()
    if (self.mFormationSkillContainer == nil) then
        self.mFormationSkillContainer = self:Get("attribute", "UIGridContainer");
    end
    return self.mFormationSkillContainer;
end

--endregion

--region Method

--region Public

function UIHeartSkillFormationTemplate:SetIsShow(isShow)
    self.go:SetActive(isShow);
end

function UIHeartSkillFormationTemplate:ShowHeartSkillFormation()
    self:UpdateHeartSkillFormation();
    self:OnSelectHeartSkillType(CS.CSScene.MainPlayerInfo.SkillInfoV2.SelectHeartSkillType);
    --if(self.mSelectType == nil) then
    --self:OnSelectHeartSkillType(self:GetSecretSkillTypeBySelectIndex(0));
    --end
end

function UIHeartSkillFormationTemplate:GetSkillFormationIconUnitDic()
    return self.mSkillIconUnitDic;
end

--function UIHeartSkillFormationTemplate:OnUpdate()
--    self.mLongPressTimer = self.mLongPressTimer + CS.UnityEngine.Time.deltaTime;
--    if(self.mLongPressTimer > 0.1) then
--        if(self.mIsPress) then
--            self.mIsPress = false;
--            local usedSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
--            local isFind, skillId = usedSkillDic:TryGetValue(self.mClickHeartSkillType);
--            if(isFind) then
--                uimanager:CreatePanel("UIHeartSkillInfoPanel", nil, {skillId = skillId});
--            end
--        end
--    end
--end

function UIHeartSkillFormationTemplate:PlayUseEffect(heartSkillType)
    if (not CS.StaticUtility.IsNull(self:GetUseEffectLoad(heartSkillType).gameObject)) then
        self:GetUseEffectLoad(heartSkillType).gameObject:SetActive(false);
        self:GetUseEffectLoad(heartSkillType).gameObject:SetActive(true);
    end
end

function UIHeartSkillFormationTemplate:PlayUseFormationEffect(isActive)
    if (isActive) then
        self:GetFormationIconActiveEffect_GameObject():SetActive(false);
        self:GetFormationIconActiveEffect_GameObject():SetActive(true);
    else
        self:GetFormationIconActiveEffect_GameObject():SetActive(false);
    end

    if (self.mCoroutineIconDelay ~= nil) then
        StopCoroutine(self.mCoroutineIconDelay);
        self.mCoroutineIconDelay = nil;
    end
    self.mCoroutineIconDelay = StartCoroutine(self.IEnumDelayFormationIcon, self, 1, isActive);
end

--endregion

--region Private

function UIHeartSkillFormationTemplate:UpdateHeartSkillFormation()
    self.mFormationId = CS.CSScene.MainPlayerInfo.SkillInfoV2.CurUseHeartSkillFormationId;
    self.mFormationLevel = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillFormationLevel;
    local usedSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
    local isFind, formationTable = CS.Cfg_SkillHeartFormationTableManager.Instance:TryGetValue(self.mFormationId);
    self:GetFormationIcon_UISprite().gameObject:SetActive(isFind);
    self:GetFormationStaticIcon_UISprite().gameObject:SetActive(isFind);
    self:GetFormationIconEffect_GameObject():SetActive(isFind);
    self:GetFormationMidEffect_GameObject():SetActive(isFind);
    if (isFind) then
        self:GetFormationIcon_UISprite().spriteName = formationTable.icon;
        self:GetFormationStaticIcon_UISprite().spriteName = formationTable.icon2;
    end

    for k, v in pairs(self.mShowHeartSkillTypes) do
        local isFind0, skillId = usedSkillDic:TryGetValue(v);
        if (isFind0) then
            local isFind1, skillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(skillId);
            if (isFind1) then
                self:GetSkillIconUnitTemplateWithHeartSkillType(k):ShowSkill(skillTable, false);
            else
                self:GetSkillIconUnitTemplateWithHeartSkillType(k):UnShow();
            end
        else
            self:GetSkillIconUnitTemplateWithHeartSkillType(k):UnShow();
        end
        local gobj = self:GetFormationEffectLoad(v).gameObject;
        if (gobj ~= nil and not CS.StaticUtility.IsNull(gobj)) then
            if (gobj.activeSelf ~= isFind) then
                gobj:SetActive(isFind);
            end
        end

        --local isShowUseEffect = self:GetIsShowUseEffect(v);
        --if(self:GetUseEffectLoad(v).EffectObject ~= nil) then
        --    self:GetUseEffectLoad(v).EffectObject:SetActive(isShowUseEffect);
        --    if(isShowUseEffect) then
        --        self:SetIsShowUseEffect(v, false);
        --    end
        --end
    end
    self:UpdateHeartFormationUnitShowText();
    self:GetNotHas_GameObject():SetActive(usedSkillDic.Count <= 0);
end

function UIHeartSkillFormationTemplate:UpdateHeartFormationUnitShowText()
    self.mSkillShowTextUnitDic = {};
    local gridContainer = self:GetFormationSkillContainer()
    --gridContainer.MaxCount = #self.mShowHeartSkillTypes + 1;
    --for i = 0, gridContainer.MaxCount - 1 do
    --    local gobj = gridContainer.controlList[i];
    --    local key = i + 1;
    --    if(self.mSkillShowTextUnitDic[key] == nil) then
    --        self.mSkillShowTextUnitDic[key] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIHeartFormationUnitShowTextTemplate);
    --    end
    --    if(i == 0) then
    --        self.mSkillShowTextUnitDic[key]:ShowFormationText(self.mFormationId, self.mFormationLevel);
    --    else
    --        self.mSkillShowTextUnitDic[key]:ShowText(self:GetSecretSkillTypeBySelectIndex(i - 1));
    --    end
    --end

    local usedSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
    gridContainer.MaxCount = usedSkillDic.Count > 0 and usedSkillDic.Count + 1 or 0;
    if (gridContainer.MaxCount > 0) then
        local gobj0 = gridContainer.controlList[0];
        if (self.mSkillShowTextUnitDic[gobj0] == nil) then
            self.mSkillShowTextUnitDic[gobj0] = templatemanager.GetNewTemplate(gobj0, luaComponentTemplates.UIHeartFormationUnitShowTextTemplate);
        end
        self.mSkillShowTextUnitDic[gobj0]:ShowFormationText(self.mFormationId, self.mFormationLevel);

        local list = {};
        CS.Utility_Lua.luaForeachCsharp:Foreach(usedSkillDic, function(k, v)
            table.insert(list, { type = k, skillId = v });
        end);
        table.sort(list, function(a, b)
            local aOrder = self.mHearSkillView:GetIndexBySecretType(a.type);
            local bOrder = self.mHearSkillView:GetIndexBySecretType(b.type);
            return aOrder < bOrder;
        end);

        for k, v in pairs(list) do
            local gobj = gridContainer.controlList[k];
            if (self.mSkillShowTextUnitDic[gobj] == nil) then
                self.mSkillShowTextUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIHeartFormationUnitShowTextTemplate);
            end
            self.mSkillShowTextUnitDic[gobj]:ShowHeartSkillText(v.skillId);
        end
    end
end

function UIHeartSkillFormationTemplate:IEnumDelayFormationIcon(delayTime, isFind)
    self:GetFormationIcon_UISprite().enabled = false;
    self:GetFormationMidEffect_GameObject():SetActive(false);
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(delayTime))
    if self:GetFormationIcon_UISprite() ~= nil and CS.StaticUtility.IsNull(self:GetFormationIcon_UISprite()) == false then
        self:GetFormationIcon_UISprite().enabled = true;
    end
    self:GetFormationMidEffect_GameObject():SetActive(isFind);
    self:GetFormationIconActiveEffect_GameObject():SetActive(false);
end

function UIHeartSkillFormationTemplate:GetSkillIconUnitTemplateWithHeartSkillType(heartSkillType)
    if (self.mSkillIconUnitDic == nil) then
        self.mSkillIconUnitDic = {};
    end

    if (self.mSkillIconUnitDic[heartSkillType] == nil) then
        local gobj = self:Get("skillFormation/skill" .. self:GetIndexBySecretType(heartSkillType), "GameObject");
        self.mSkillIconUnitDic[heartSkillType] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UISkillIconUnitTemplate);
    end
    return self.mSkillIconUnitDic[heartSkillType];
end

function UIHeartSkillFormationTemplate:GetFormationEffectLoad(heartSkillType)
    if (self.mFormationEffectLoadDic[heartSkillType] == nil) then
        self.mFormationEffectLoadDic[heartSkillType] = self:Get("skillFormation/skill" .. self:GetIndexBySecretType(heartSkillType) .. "/skillFormationEffect", "CSUIEffectLoad");
    end
    return self.mFormationEffectLoadDic[heartSkillType];
end

function UIHeartSkillFormationTemplate:GetUseEffectLoad(heartSkillType)
    if (self.mUseEffectLoadDic[heartSkillType] == nil) then
        self.mUseEffectLoadDic[heartSkillType] = self:Get("skillFormation/skill" .. self:GetIndexBySecretType(heartSkillType) .. "/effect", "CSUIEffectLoad");
    end
    return self.mUseEffectLoadDic[heartSkillType];
end

--function UIHeartSkillFormationTemplate:GetIsShowUseEffect(heartSkillType)
--    if(self.mIsShowUseEffectDic[heartSkillType] ~= nil) then
--        return self.mIsShowUseEffectDic[heartSkillType]
--    end
--    return false
--end

--function UIHeartSkillFormationTemplate:SetIsShowUseEffect(heartSkillType, isShow)
--    if(self.mIsShowUseEffectDic == nil) then
--        self.mIsShowUseEffectDic = {};
--    end
--    self.mIsShowUseEffectDic[heartSkillType] = isShow;
--end

function UIHeartSkillFormationTemplate:GetIndexBySecretType(secretSkillType)
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

function UIHeartSkillFormationTemplate:GetSecretSkillTypeBySelectIndex(selectIndex)
    if (selectIndex == 0) then
        return LuaEnumSecretSkillType.SecretLife;
    elseif (selectIndex == 2) then
        return LuaEnumSecretSkillType.SecretElementalAttack;
    elseif (selectIndex == 1) then
        return LuaEnumSecretSkillType.SecretDefense;
    elseif (selectIndex == 3) then
        return LuaEnumSecretSkillType.SecretElementalDefense;
    elseif (selectIndex == 4) then
        return LuaEnumSecretSkillType.SecretResistanceToOccupation;
    elseif (selectIndex == 5) then
        return LuaEnumSecretSkillType.SecretResistanceToSkill;
    end
    return LuaEnumSecretSkillType.SecretLife;
end

function UIHeartSkillFormationTemplate:Initialize()
    self.mShowHeartSkillTypes = {};
    table.insert(self.mShowHeartSkillTypes, LuaEnumSecretSkillType.SecretLife);
    table.insert(self.mShowHeartSkillTypes, LuaEnumSecretSkillType.SecretElementalAttack);
    table.insert(self.mShowHeartSkillTypes, LuaEnumSecretSkillType.SecretDefense);
    table.insert(self.mShowHeartSkillTypes, LuaEnumSecretSkillType.SecretElementalDefense);
    table.insert(self.mShowHeartSkillTypes, LuaEnumSecretSkillType.SecretResistanceToOccupation);
    table.insert(self.mShowHeartSkillTypes, LuaEnumSecretSkillType.SecretResistanceToSkill);

    self.mSkillIconUnitDic = {};
    for k, v in pairs(self.mShowHeartSkillTypes) do
        self:GetSkillIconUnitTemplateWithHeartSkillType(v);
    end

    self.mFormationEffectLoadDic = {};
    self.mUseEffectLoadDic = {};
    self.mSkillShowTextUnitDic = {};
    --self.mIsShowUseEffectDic = {};
    self.mSelectType = nil;
    --self:PlayUseFormationEffect(false);
    self:GetFormationIconActiveEffect_GameObject():SetActive(false);
end

function UIHeartSkillFormationTemplate:InitEvents()

    CS.UIEventListener.Get(self:GetFormationIcon_UISprite().gameObject).onClick = function()
        uimanager:CreatePanel("UIHeartSkillFormationInfoPanel", nil, { formationId = self.mFormationId, formationLevel = self.mFormationLevel });
    end

    self.CallOnSelectHeartSkillType = function(msgId, heartSkillType)
        if (self.mSelectType == heartSkillType) then
            local usedSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
            local isFind, skillId = usedSkillDic:TryGetValue(heartSkillType);
            if (isFind) then
                uimanager:CreatePanel("UIHeartSkillInfoPanel", nil, { skillId = skillId });
            end
        end

        self:OnSelectHeartSkillType(heartSkillType);
    end

    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Skill_OnHeartSkillFormationUnitClicked, self.CallOnSelectHeartSkillType);

    for k, v in pairs(self.mSkillIconUnitDic) do
        CS.UIEventListener.Get(v.go).onClick = function()
            if (luaEventManager.HasCallback(LuaCEvent.Skill_OnHeartSkillFormationUnitClicked)) then
                luaEventManager.DoCallback(LuaCEvent.Skill_OnHeartSkillFormationUnitClicked, k);
            end
        end

        CS.UIEventListener.Get(v.go).onDragStart = function(go)
            self.mIsPress = false;
            self.mHearSkillView:OnHeartSkillFormationUnitDragStart(k);
        end
        CS.UIEventListener.Get(v.go).onDrag = function(go, delta)
            self.mHearSkillView:OnHeartSkillFormationUnitDrag(k, delta);
        end
        CS.UIEventListener.Get(v.go).onDragEnd = function(go)
            self.mHearSkillView:OnHeartSkillFormationUnitDragEnd(k);
        end
    end

    CS.UIEventListener.Get(self:GetBtnFormation_GameObject()).onClick = function()
        self:OnClockBtnFormation();
    end;

    self.CallOnHeartSkillUseClick = function(msgId, heartSkillType)
        --self:SetIsShowUseEffect(CS.CSScene.MainPlayerInfo.SkillInfoV2.SelectHeartSkillType, true);
    end

    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Skill_OnHeartSkillUseButtonClick, self.CallOnHeartSkillUseClick);

    --commonNetMsgDeal.BindCallback()
end

function UIHeartSkillFormationTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Skill_OnHeartSkillFormationUnitClicked, self.CallOnSelectHeartSkillType);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Skill_OnHeartSkillUseButtonClick, self.CallOnHeartSkillUseClick);

    if (self.mCoroutineIconDelay ~= nil) then
        StopCoroutine(self.mCoroutineIconDelay);
        self.mCoroutineIconDelay = nil;
    end
end

function UIHeartSkillFormationTemplate:Clear()
    self.mFormationSkillContainer = nil;
    self.mFormationIcon_UISprite = nil;
    self.mFormationName_Text = nil;
    self.mFormationIconActiveEffect_GameObject = nil;
    self.mFormationIconEffect_GameObject = nil;
    self.mBtnFormation_GameObject = nil;
    self.mFormationInfo_GameObject = nil;
    self.mNotHas_GameObject = nil;
    self.mSkillFormation_GameObject = nil;

    self.mSkillIconUnitDic = nil;
    self.mFormationEffectLoadDic = nil
    self.mUseEffectLoadDic = nil;
    self.mSkillShowTextUnitDic = nil;
    self.mShowHeartSkillTypes = nil;
    self.mSelectType = nil;
    --self.mIsShowUseEffectDic = nil;
end
--endregion

--region CallFunction

function UIHeartSkillFormationTemplate:OnSelectHeartSkillType(heartSkillType)
    self.mSelectType = heartSkillType;
    CS.CSScene.MainPlayerInfo.SkillInfoV2.SelectHeartSkillType = heartSkillType;
    for k, v in pairs(self.mShowHeartSkillTypes) do
        local gobj = self:GetSkillIconUnitTemplateWithHeartSkillType(v).go;
        if (gobj ~= nil and not CS.StaticUtility.IsNull(gobj)) then
            self:GetSkillIconUnitTemplateWithHeartSkillType(v):SetIsSelect(v == heartSkillType);
        end
    end
end

function UIHeartSkillFormationTemplate:OnClockBtnFormation()
    uimanager:CreatePanel("UIHeartFormationChoosePanel");
end

--endregion

--endregion

function UIHeartSkillFormationTemplate:Init(heartSkillView, panel)
    self.mHearSkillView = heartSkillView;
    ---@type UIBase
    self.mOwnerPanel = panel
    self:Initialize();
    self:InitEvents();
end

function UIHeartSkillFormationTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIHeartSkillFormationTemplate;