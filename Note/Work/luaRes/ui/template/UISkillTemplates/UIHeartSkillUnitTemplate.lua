local UIHeartSkillUnitTemplate = {};

UIHeartSkillUnitTemplate.mSkillTable = nil;

UIHeartSkillUnitTemplate.mHeartShowType = nil;

UIHeartSkillUnitTemplate.mIsShowStudyEffect = false;

UIHeartSkillUnitTemplate.mEffectDic = nil;

--region Components

--region GameObject

function UIHeartSkillUnitTemplate:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("background", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UIHeartSkillUnitTemplate:GetBtnUse_GameObject()
    if (self.mBtnUse_GameObject == nil) then
        self.mBtnUse_GameObject = self:Get("Btn_Use", "GameObject");
    end
    return self.mBtnUse_GameObject;
end

function UIHeartSkillUnitTemplate:GetBtnUnUse_GameObject()
    if (self.mBtnUnUse_GameObject == nil) then
        self.mBtnUnUse_GameObject = self:Get("Btn_UnUse", "GameObject");
    end
    return self.mBtnUnUse_GameObject;

end

function UIHeartSkillUnitTemplate:GetBtnLearn_GameObject()
    if (self.mBtnLearn_GameObject == nil) then
        self.mBtnLearn_GameObject = self:Get("Btn_Learn", "GameObject");
    end
    return self.mBtnLearn_GameObject

end

function UIHeartSkillUnitTemplate:GetBtnUseSkillBook_GameObject()
    if (self.mBtnUseSkillBook_GameObject == nil) then
        self.mBtnUseSkillBook_GameObject = self:Get("UseSkillBookBtn", "GameObject");
    end
    return self.mBtnUseSkillBook_GameObject;

end

function UIHeartSkillUnitTemplate:GetBtnUpLevel_GameObject()
    if (self.mBtnUpLevel_GameObject == nil) then
        self.mBtnUpLevel_GameObject = self:Get("Btn_UpLevel", "GameObject");
    end
    return self.mBtnUpLevel_GameObject;
end

function UIHeartSkillUnitTemplate:GetUpLevelEffect_GameObject()
    if (self.mUpLevelEffect_GameObject == nil) then
        self.mUpLevelEffect_GameObject = self:Get("upLevelEffect", "GameObject");
    end
    return self.mUpLevelEffect_GameObject;
end

function UIHeartSkillUnitTemplate:GetSkillUnitTemplate_GameObject()
    if (self.mSkillUnitTemplate_GameObject == nil) then
        self.mSkillUnitTemplate_GameObject = self:Get("skillUnitTemplate", "GameObject");
    end
    return self.mSkillUnitTemplate_GameObject;
end

--function UIHeartSkillUnitTemplate:GetStudyEffect_GameObject()
--    if(self.mStudyEffect_GameObject == nil) then
--        self.mStudyEffect_GameObject = self:Get("studyEffect", "GameObject");
--    end
--    return self.mStudyEffect_GameObject;
--end

function UIHeartSkillUnitTemplate:GetSkillUpTips_Text()
    if (self.mSkillUpTips_Text == nil) then
        self.mSkillUpTips_Text = self:Get("Tips", "UILabel");
    end
    return self.mSkillUpTips_Text;
end

--endregion

--region UILabel

function UIHeartSkillUnitTemplate:GetSkillLevel_Text()
    if (self.mSkillLevel_Text == nil) then
        self.mSkillLevel_Text = self:Get("skillLevel", "UILabel");
    end
    return self.mSkillLevel_Text;
end

function UIHeartSkillUnitTemplate:GetSkillExp_Text()
    if (self.mSkillExp_Text == nil) then
        self.mSkillExp_Text = self:Get("skillExpStripe/Label", "UILabel");
    end
    return self.mSkillExp_Text;
end

--endregion

function UIHeartSkillUnitTemplate:GetSkillIconUnitTemplate()
    if (self.mSkillIconUnitTemplate == nil) then
        self.mSkillIconUnitTemplate = templatemanager.GetNewTemplate(self:GetSkillUnitTemplate_GameObject(), luaComponentTemplates.UISkillIconUnitTemplate);
    end
    return self.mSkillIconUnitTemplate;
end

--endregion

--region Method

--region CallFunction

function UIHeartSkillUnitTemplate:OnClickBtnUpLevel()
    if (self:GetSkillUpLevelCode() == LuaEnumSkillUpLevelErrorCode.Non) then
        networkRequest.ReqLevelUpSkill(self.mSkillTable.id);
        self:PlayEffect("700028", self:GetSkillIconUnitTemplate():GetSkillIcon_UISprite().gameObject.transform, 100);
    elseif (self:GetSkillUpLevelCode() == LuaEnumSkillUpLevelErrorCode.NotGet) then
        self:OnClickBtnUseSkillBook();
    else
        CS.Utility.ShowTips(self:GetSkillUpLevelCode(), 1, CS.ColorType.Red);
    end
end

function UIHeartSkillUnitTemplate:OnClickBtnUse()
    if (self.mSkillTable ~= nil) then
        luaEventManager.DoCallback(LuaCEvent.Skill_OnHeartSkillUseButtonClick, self.mSkillTable.secretSkillType);
        networkRequest.ReqSecretSkillUpdate(self.mSkillTable.id, CS.CSScene.MainPlayerInfo.SkillInfoV2.SelectHeartSkillType);
    end
end

function UIHeartSkillUnitTemplate:OnClickBtnUnUse()
    if (self.mSkillTable ~= nil) then
        networkRequest.ReqTakeOffSecret(self.mSkillTable.id);
    end
end

function UIHeartSkillUnitTemplate:OnClickBtnLearn()
    if (self:GetSkillUpLevelCode() == LuaEnumSkillUpLevelErrorCode.Non) then
        networkRequest.ReqLevelUpSkill(self.mSelectSkillTable.id);
    elseif (self:GetSkillUpLevelCode() == LuaEnumSkillUpLevelErrorCode.NotGet) then
        self:OnClickBtnUseSkillBook();
        self.mIsShowStudyEffect = true;
        self:PlayEffect("700037", self:GetSkillIconUnitTemplate():GetSkillIconEffect_GameObject().transform, 1);
        self:GetSkillIconUnitTemplate():PlayTweenAlpha();
    else
        return CS.Utility.ShowTips(self:GetSkillUpLevelCode(), 1, CS.ColorType.Red);
    end
end

function UIHeartSkillUnitTemplate:OnClickBtnUseSkillBook()
    if (self.mSkillBookItemInfo == nil) then
        self:GetBtnUseSkillBook_GameObject():SetActive(false);
        return CS.Utility.ShowTips("没有技能书!", 1, CS.ColorType.Red);
    else
        self:GetBtnLearn_GameObject():SetActive(false);
        networkRequest.ReqUseItem(1, self.mSkillBookItemInfo.lid, 1);
    end
end

--endregion

--region Public

function UIHeartSkillUnitTemplate:ShowHeartSkillUnit(heartSkillId, heartShowType, index)
    if (heartShowType == nil) then
        heartShowType = LuaEnumHeartSkillShowType.HeartSkill;
    end
    self.mHeartShowType = heartShowType;
    self:GetBackGround_GameObject():SetActive(index % 2 == 0)
    if (self.mSkillTable ~= nil and self.mSkillTable.id ~= heartSkillId) then
        local studyEffect = self.mEffectDic["700037"];
        if (studyEffect ~= nil) then
            studyEffect:SetActive(false);
        end
    end
    local isFind, skillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(heartSkillId);
    if (isFind) then
        self.mSkillTable = skillTable;
        self:UpdateSkillState();
    end
end

--endregion

--region Private

function UIHeartSkillUnitTemplate:UpdateSkillState()
    if (self.mSkillTable == nil) then
        return ;
    end
    self.mSkillBookItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagSkillBookItemInfo(self.mSkillTable.id);
    local hasSkill, skillBean = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic:TryGetValue(self.mSkillTable.id);
    self:GetSkillIconUnitTemplate():ShowSkill(self.mSkillTable, not hasSkill or self.mIsShowStudyEffect);
    if (not hasSkill) then
        skillBean = {}
        skillBean.level = 0;
        skillBean.exp = 0;
    end
    self.mIsUsed = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic:ContainsValue(self.mSkillTable.id);
    local skillCondition = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(self.mSkillTable.id, skillBean.level);
    self:GetSkillExp_Text().gameObject:SetActive(hasSkill and self.mHeartShowType == LuaEnumHeartSkillShowType.HeartSkill);
    self:GetBtnLearn_GameObject():SetActive(not hasSkill and self.mHeartShowType == LuaEnumHeartSkillShowType.HeartSkill);

    local skillStateCode, des = self:GetSkillUpLevelCode();
    local isMaxOrNotGet = (skillStateCode == LuaEnumSkillUpLevelErrorCode.NotGet or skillStateCode == LuaEnumSkillUpLevelErrorCode.Max);
    local maxExp = CS.Cfg_SkillsConditionManager.Instance:GetEXP(skillCondition);
    self:GetBtnUseSkillBook_GameObject():SetActive(not isMaxOrNotGet and skillBean.exp < maxExp and self.mSkillBookItemInfo ~= nil and self.mHeartShowType == LuaEnumHeartSkillShowType.HeartSkill);

    local isExpFull = skillBean.exp == maxExp;
    local expStr = isExpFull and luaEnumColorType.Green .. skillBean.exp .. "/" .. maxExp .. "(满)[-]" or skillBean.exp .. "/" .. maxExp;
    local expColor = (isExpFull and not isMaxOrNotGet) and luaEnumColorType.White or luaEnumColorType.Gray;
    self:GetSkillExp_Text().text = (skillStateCode == LuaEnumSkillUpLevelErrorCode.Max and "已满级" or expStr);
    self:GetSkillLevel_Text().text = expColor .. skillBean.level .. "级[-]";

    if (des == nil) then
        des = "";
    end
    self:GetSkillUpTips_Text().text = des;
    self:GetSkillUpTips_Text().gameObject:SetActive(skillStateCode == LuaEnumSkillUpLevelErrorCode.ConditionNotEnough and self.mHeartShowType == LuaEnumHeartSkillShowType.HeartSkill);
    self:GetBtnUpLevel_GameObject():SetActive(skillStateCode == LuaEnumSkillUpLevelErrorCode.Non and not isMaxOrNotGet and skillBean.exp >= maxExp and self.mHeartShowType == LuaEnumHeartSkillShowType.HeartSkill);
    self:GetBtnUse_GameObject():SetActive(hasSkill and not self.mIsUsed and self.mHeartShowType == LuaEnumHeartSkillShowType.HeartFormation);
    self:GetSkillIconUnitTemplate():SetIsSelect(self.mIsUsed);
    local stateCode = CS.CSScene.MainPlayerInfo.SkillInfoV2:GetSkillState(self.mSkillTable.id);
    self:GetUpLevelEffect_GameObject():SetActive(stateCode == LuaEnumSkillStateCode.UpLevel and self.mHeartShowType == LuaEnumHeartSkillShowType.HeartSkill);
end

function UIHeartSkillUnitTemplate:GetSkillUpLevelCode()
    local skillId = self.mSkillTable.id;
    local isFind, skillBean = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic:TryGetValue(skillId);
    if (not isFind) then
        return LuaEnumSkillUpLevelErrorCode.NotGet;
    else
        local curSkillCondition = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillBean.skillId, skillBean.level);
        local nextSkillCondition = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillBean.skillId, skillBean.level + 1);
        if (nextSkillCondition == nil) then
            return LuaEnumSkillUpLevelErrorCode.Max;
        elseif (skillBean.exp < CS.Cfg_SkillsConditionManager.Instance:GetEXP(curSkillCondition)) then
            return LuaEnumSkillUpLevelErrorCode.SkillExpNotEnough;
        elseif (not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(nextSkillCondition.condition)) then
            local isFind, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(nextSkillCondition.condition);
            local des = "";
            if (isFind) then
                if (conditionTable.conditionType == 1) then
                    local level = 1;
                    if (conditionTable.conditionParam ~= nil and conditionTable.conditionParam.list.Count > 0) then
                        level = conditionTable.conditionParam.list[0]
                    end
                    des = level .. "级 可升级";
                end
            end
            return LuaEnumSkillUpLevelErrorCode.ConditionNotEnough, des;
        end
    end
    return LuaEnumSkillUpLevelErrorCode.Non;
end

function UIHeartSkillUnitTemplate:TryChangeEffectIcon()
    local effectId = "700037"
    if (self.mEffectDic[effectId] == nil) then
        return false;
    end
    local studyTrans = self.mEffectDic[effectId].transform:Find("icon/icon")
    if studyTrans ~= nil then
        ---@type UnityEngine.MeshRenderer
        local meshRenderer = CS.Utility_Lua.GetComponent(studyTrans, "MeshRenderer")
        if meshRenderer ~= nil then
            --meshRenderer.material.renderQueue = 3100;
            ---@type UISprite
            local skillIcon = self:GetSkillIconUnitTemplate():GetSkillIcon_UISprite();
            local spriteData = skillIcon.atlas:GetSprite(self.mSkillTable.icon);
            local width = spriteData.width;
            local height = spriteData.height;
            local sumWidth = skillIcon.atlas.texture.width;
            local sumHeight = skillIcon.atlas.texture.height;

            meshRenderer.material:SetTexture("_MainTex", skillIcon.mainTexture);
            if meshRenderer.material:HasProperty("_AlphaTex") then
                if skillIcon.material:IsKeywordEnabled("_AlphaTexOn") then
                    meshRenderer.material:EnableKeyword("_AlphaTexOn")
                    meshRenderer.material:SetInt("_AlphaTexOn", 1)
                    meshRenderer.material:SetTexture("_AlphaTex", skillIcon.material:GetTexture("_AlphaTex"))
                else
                    meshRenderer.material:DisableKeyword("_AlphaTexOn")
                    meshRenderer.material:SetInt("_AlphaTexOn", 0)
                    meshRenderer.material:SetTexture("_AlphaTex", nil)
                end
            end
            local offset = CS.UnityEngine.Vector2((spriteData.x) / sumWidth, 1 - (spriteData.y + height) / sumHeight);
            meshRenderer.sharedMaterial:SetTextureOffset("_MainTex", offset);
            local tiling = CS.UnityEngine.Vector2(width / sumWidth, height / sumHeight);
            meshRenderer.material:SetTextureScale("_MainTex", tiling);
            if skillIcon and skillIcon.drawCall then
                meshRenderer.material.renderQueue = skillIcon.drawCall.renderQueue + 1;
            end
            return true;
        end
    end
    return false;
end

function UIHeartSkillUnitTemplate:PlayEffect(effectId, parent, scale)
    if (scale == nil) then
        scale = 100;
    end
    if (self.mEffectDic[effectId] == nil) then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectId, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                --local poolItem = res:GetUIPoolItem()
                --self.mEffectDic[effectId] = poolItem.go
                self.mEffectDic[effectId] = res:GetObjInst();
                if self.mEffectDic[effectId] ~= nil then
                    self.mEffectDic[effectId].transform.parent = parent;
                    self.mEffectDic[effectId].transform.localPosition = CS.UnityEngine.Vector3(-0.0045, 0, 0);
                    self.mEffectDic[effectId].transform.localScale = CS.UnityEngine.Vector3(scale, scale, scale);
                    if (self.mClipShaderComponent ~= nil) then
                        self.mClipShaderComponent:AddRenderList(self.mEffectDic[effectId], true);
                    end
                    if (effectId == "700037") then
                        if (self:TryChangeEffectIcon()) then
                            self:OnStudyEffectPlayed();
                        end
                    end
                end
            end
        end, CS.ResourceAssistType.UI);
    else
        self.mEffectDic[effectId]:SetActive(false);
        self.mEffectDic[effectId]:SetActive(true);
        if (self:TryChangeEffectIcon()) then
            self:OnStudyEffectPlayed();
        end
    end
end

function UIHeartSkillUnitTemplate:OnStudyEffectPlayed()
    if (self.mCoroutineStudyEffectDelay ~= nil) then
        self.mCoroutineStudyEffectDelay = StopCoroutine(self.mCoroutineStudyEffectDelay);
        self.mCoroutineStudyEffectDelay = nil;
    end
    self.mCoroutineStudyEffectDelay = StartCoroutine(self.IEnumStudyEffectDelay, self, 1);
end

function UIHeartSkillUnitTemplate:IEnumStudyEffectDelay(delayTime)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(delayTime));
    self.mIsShowStudyEffect = false;
    self:GetSkillIconUnitTemplate():StopTweenAlpha();
    local studyEffect = self.mEffectDic["700037"];
    if (CS.StaticUtility.IsNull(studyEffect) == false and studyEffect ~= nil) then
        studyEffect:SetActive(false);
    end
end

function UIHeartSkillUnitTemplate:Initialize()
    self.mSkillTable = {};
    self.mHeartShowType = LuaEnumHeartSkillShowType.HeartSkill;
    self.mEffectDic = {};
end

function UIHeartSkillUnitTemplate:InitEvents()

    CS.UIEventListener.Get(self:GetBtnUse_GameObject()).onClick = function()
        self:OnClickBtnUse();
    end

    CS.UIEventListener.Get(self:GetBtnUnUse_GameObject()).onClick = function()
        self:OnClickBtnUnUse();
    end

    CS.UIEventListener.Get(self:GetBtnLearn_GameObject()).onClick = function()
        self:OnClickBtnLearn();
    end

    CS.UIEventListener.Get(self:GetBtnUseSkillBook_GameObject()).onClick = function()
        self:OnClickBtnUseSkillBook();
    end

    CS.UIEventListener.Get(self:GetBtnUpLevel_GameObject()).onClick = function()
        self:OnClickBtnUpLevel();
    end

    CS.UIEventListener.Get(self:GetSkillIconUnitTemplate():GetSkillIcon_UISprite().gameObject).onClick = function()
        if (luaEventManager.HasCallback(LuaCEvent.Skill_OnHeartSkillUnitClicked)) then
            luaEventManager.DoCallback(LuaCEvent.Skill_OnHeartSkillUnitClicked, self);
        end
    end
    local gobj = self:GetSkillIconUnitTemplate():GetSkillIcon_UISprite().gameObject;
    CS.UIEventListener.Get(gobj).onDragStart = function(go)
        self.mHearSkillView:OnHeartSkillUnitDragStart(self);
    end
    CS.UIEventListener.Get(gobj).onDrag = function(go, delta)
        if (self.mSkillTable ~= nil) then
            self.mHearSkillView:OnHeartSkillUnitDrag(self, delta);
        end
    end
    CS.UIEventListener.Get(gobj).onDragEnd = function(go)
        if (self.mSkillTable ~= nil) then
            self.mHearSkillView:OnHeartSkillUnitDragEnd(self);
        end
    end
end

function UIHeartSkillUnitTemplate:RemoveEvents()
    if (self.mCoroutineStudyEffectDelay ~= nil) then
        self.mCoroutineStudyEffectDelay = StopCoroutine(self.mCoroutineStudyEffectDelay);
        self.mCoroutineStudyEffectDelay = nil;
    end
end

function UIHeartSkillUnitTemplate:Clear()
    self.mSkillUnitTemplate_GameObject = nil;
    self.mSkillIconUnitTemplate = nil;
    self.mSkillExp_Text = nil;
    self.mSkillLevel_Text = nil;
    self.mUpLevelEffect_GameObject = nil;
    self.mBtnUseSkillBook_GameObject = nil;
    self.mBtnLearn_GameObject = nil;
    self.mBtnUnUse_GameObject = nil;
    self.mBtnUse_GameObject = nil;
    self.mBtnUpLevel_GameObject = nil;

    self.mIsShowStudyEffect = false;
    self.mSkillTable = nil;
    self.mHeartShowType = nil;
    self.mEffectDic = nil;
end
--endregion

--endregion

function UIHeartSkillUnitTemplate:Init(heartSkillView)
    self.mHearSkillView = heartSkillView;
    if (self.mHearSkillView) then
        self.mClipShaderComponent = self.mHearSkillView:GetClipShaderComponent();
    end

    self:Initialize()
    self:InitEvents();
end

function UIHeartSkillUnitTemplate:OnDestroy()
    self:RemoveEvents()
    self:Clear();
end

return UIHeartSkillUnitTemplate;