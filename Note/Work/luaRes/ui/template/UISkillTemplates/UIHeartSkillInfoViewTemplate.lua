local UIHeartSkillInfoViewTemplate = {};

UIHeartSkillInfoViewTemplate.mSkillTable = nil;

UIHeartSkillInfoViewTemplate.mCurSkillCondition = nil;

UIHeartSkillInfoViewTemplate.mNextSkillCondition = nil;

UIHeartSkillInfoViewTemplate.mTweenStartPos = nil;

UIHeartSkillInfoViewTemplate.mTweenEndPos = nil;

UIHeartSkillInfoViewTemplate.mSelectHeartSkillUnit = nil;

--region Components

--region GameObject

function UIHeartSkillInfoViewTemplate:GetCurSkillData_GameObject()
    if (self.mCurSkillData_GameObject == nil) then
        self.mCurSkillData_GameObject = self:Get("currentSkill", "GameObject");
    end
    return self.mCurSkillData_GameObject;
end

function UIHeartSkillInfoViewTemplate:GetNextSkillData_GameObject()
    if (self.mNextSkillData_GameObject == nil) then
        self.mNextSkillData_GameObject = self:Get("nextSkill", "GameObject");
    end
    return self.mNextSkillData_GameObject;
end

function UIHeartSkillInfoViewTemplate:GetMaxLevelTips_GameObject()
    if (self.mMaxLevelTips_GameObject == nil) then
        self.mMaxLevelTips_GameObject = self:Get("nextSkill/maxLevelTips", "GameObject");
    end
    return self.mMaxLevelTips_GameObject;
end

function UIHeartSkillInfoViewTemplate:GetUnLearned_GameObject()
    if (self.mUnLearned_GameObject == nil) then
        self.mUnLearned_GameObject = self:Get("UnLearned", "GameObject");
    end
    return self.mUnLearned_GameObject;
end

function UIHeartSkillInfoViewTemplate:GetSkillState_GameObject()
    if (self.mSkillState_GameObject == nil) then
        self.mSkillState_GameObject = self:Get("SkillState", "GameObject");
    end
    return self.mSkillState_GameObject;
end

--endregion

--region UILabel

function UIHeartSkillInfoViewTemplate:GetSkillStateLabel_Text()
    if (self.mSkillStateLabel_Text == nil) then
        self.mSkillStateLabel_Text = self:Get("stateLabel", "UILabel");
    end
    return self.mSkillStateLabel_Text;
end

function UIHeartSkillInfoViewTemplate:GetCurSkillLevel_Text()
    if (self.mCurSkillLevel_Text == nil) then
        self.mCurSkillLevel_Text = self:Get("currentSkill/skillLevel", "UILabel");
    end
    return self.mCurSkillLevel_Text;
end

function UIHeartSkillInfoViewTemplate:GetCurSkillDescription_Text()
    if (self.mCurSkillDescription_Text == nil) then
        self.mCurSkillDescription_Text = self:Get("currentSkill/skillDescription", "UILabel");
    end
    return self.mCurSkillDescription_Text;
end

function UIHeartSkillInfoViewTemplate:GetNextSkillLevel_Text()
    if (self.mNextSkillLevel_Text == nil) then
        self.mNextSkillLevel_Text = self:Get("nextSkill/skillLevel", "UILabel");
    end
    return self.mNextSkillLevel_Text;
end

function UIHeartSkillInfoViewTemplate:GetNextSkillDescription_Text()
    if (self.mNextSkillDescription_Text == nil) then
        self.mNextSkillDescription_Text = self:Get("nextSkill/skillDescription", "UILabel");
    end
    return self.mNextSkillDescription_Text;
end

function UIHeartSkillInfoViewTemplate:GetNextSkillNeedLevel_Text()
    if (self.mNextSkillNeedLevel_Text == nil) then
        self.mNextSkillNeedLevel_Text = self:Get("nextSkill/upgradeRequire/requireLevel", "UILabel");
    end
    return self.mNextSkillNeedLevel_Text;
end
--endregion

function UIHeartSkillInfoViewTemplate:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("bg", "Top_UISprite");
    end
    return self.mBackGround_UISprite;
end

function UIHeartSkillInfoViewTemplate:GetSkillState_UISprite()
    if (self.mSkillState_UISprite == nil) then
        self.mSkillState_UISprite = self:Get("SkillState/Sprite", "UISprite");
    end
    return self.mSkillState_UISprite;
end

function UIHeartSkillInfoViewTemplate:GetMatchNode_Transform()
    if (self.mMatchNode_Transform == nil) then
        self.mMatchNode_Transform = self:Get("skillIconTemplate/matchNode", "Transform");
    end
    return self.mMatchNode_Transform;
end

function UIHeartSkillInfoViewTemplate:GetHeartSkillStateTweePosition()
    if (self.mHeartSkillStateTweePosition == nil) then
        self.mHeartSkillStateTweePosition = self:Get("SkillState/thumb", "TweenPosition");
    end
    return self.mHeartSkillStateTweePosition;
end

function UIHeartSkillInfoViewTemplate:GetSkillIconUnitTemplate()
    if (self.mSkillIconUnitTemplate == nil) then
        self.mSkillIconUnitTemplate = templatemanager.GetNewTemplate(self:Get("skillIconTemplate", "GameObject"), luaComponentTemplates.UISkillIconUnitTemplate);
    end
    return self.mSkillIconUnitTemplate;
end

function UIHeartSkillInfoViewTemplate:GetNextSkillDescriptionWidget()
    if (self.mNextSkillDescriptionWidget == nil) then
        self.mNextSkillDescriptionWidget = self:Get("nextSkill", "UIWidget");
    end
    return self.mNextSkillDescriptionWidget;
end

function UIHeartSkillInfoViewTemplate:GetWidgets()
    if (self.mWidgets == nil) then
        self.mWidgets = self.go:GetComponentsInChildren(typeof(CS.UIWidget));
    end
    return self.mWidgets;
end

function UIHeartSkillInfoViewTemplate:GetClientEventHandler()
    if (self.mClientHandler == nil) then
        self.mClientHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    end
    return self.mClientHandler;
end

--endregion

--region Method

--region Public

function UIHeartSkillInfoViewTemplate:ShowHeartSkill(heartSkillUnit)
    self.mSelectHeartSkillUnit = heartSkillUnit;
    self:UpdateHeartSkillInfo(heartSkillUnit.mSkillTable.id);
    if (self.mUpdateAnchorsCoroutine ~= nil) then
        StopCoroutine(self.mUpdateAnchorsCoroutine);
        self.mUpdateAnchorsCoroutine = nil;
    end
    self.mUpdateAnchorsCoroutine = StartCoroutine(self.UpdateAnchors, self);
end

function UIHeartSkillInfoViewTemplate:UpdateHeartSkillInfo(heartSkillId)
    local isFind, heartSkillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(heartSkillId);
    if (isFind) then
        self.mSkillTable = heartSkillTable;
        if (self.mSkillTable ~= nil) then
            local skillBean = nil;
            self.mHasSkill, skillBean = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic:TryGetValue(self.mSkillTable.id);
            self.mIsMax = false;
            self.mIsUsed = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic:ContainsValue(heartSkillId);
            self:GetSkillIconUnitTemplate():ShowSkill(self.mSkillTable, not self.mHasSkill);
            self:SetSkillState(self.mIsUsed);
            if (not self.mHasSkill) then
                skillBean = {};
                skillBean.skillId = self.mSkillTable.id;
                skillBean.level = 0;
            end
            self.mCurSkillCondition = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillBean.skillId, skillBean.level);
            self.mNextSkillCondition = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillBean.skillId, skillBean.level + 1);
            self.mIsMax = self.mNextSkillCondition == nil;
            local nextNeedLevel = 0;
            if (not self.mIsMax) then
                nextNeedLevel = CS.Cfg_ConditionManager.Instance:GetCanLearnSkillLevel(self.mNextSkillCondition.id);
                local isConditionEnough = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(self.mNextSkillCondition.condition);
                self:GetNextSkillNeedLevel_Text().gameObject.transform.parent.gameObject:SetActive(not isConditionEnough);
            else
                self:GetNextSkillNeedLevel_Text().gameObject.transform.parent.gameObject:SetActive(false);
            end
            self:GetSkillState_GameObject():SetActive(self.mHasSkill);
            self:GetNextSkillNeedLevel_Text().text = nextNeedLevel;
            self:GetCurSkillData_GameObject():SetActive(self.mHasSkill);
            --self:GetNextSkillData_GameObject():SetActive(not self.mIsMax);
            self:GetMaxLevelTips_GameObject():SetActive(self.mIsMax);
            self:SetCurSkillCondition();
            self:SetNextSkillCondition();
        end
    end
end

--endregion

--region Private

function UIHeartSkillInfoViewTemplate:SetSkillState(isUsed)
    self:GetSkillStateLabel_Text().text = isUsed and "已启用" or "未启用";
    self:GetSkillState_UISprite().spriteName = isUsed and "slbg2" or "slbg";
    local endPosition = isUsed and self.mTweenEndPos or self.mTweenStartPos;
    self:GetHeartSkillStateTweePosition().from = self:GetHeartSkillStateTweePosition().gameObject.transform.localPosition;
    self:GetHeartSkillStateTweePosition().to = endPosition;
    self:GetHeartSkillStateTweePosition():PlayTween();
end

function UIHeartSkillInfoViewTemplate:SetCurSkillCondition()
    if (self.mCurSkillCondition ~= nil) then
        --self:GetCurSkillLevel_Text().text = table.concat({ luaEnumColorType.Gray, self.mSkillTable.name, self.mCurSkillCondition.level, "级[-]" });
        self:GetCurSkillLevel_Text().text = table.concat({ luaEnumColorType.Gray, "当前等级  ", self.mCurSkillCondition.level, "级[-]" });
        self:GetCurSkillDescription_Text().text = table.concat({ '', CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(self.mCurSkillCondition.id, luaEnumColorType.Yellow) });
    end
end

function UIHeartSkillInfoViewTemplate:SetNextSkillCondition()
    if (self.mNextSkillCondition ~= nil) then
        self:GetNextSkillLevel_Text().text = table.concat({ luaEnumColorType.Gray, "下一等级  ", self.mNextSkillCondition.level, "级[-]" });
        self:GetNextSkillDescription_Text().text = table.concat({ '', CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(self.mNextSkillCondition.id, luaEnumColorType.Green) });
    else
        self:GetNextSkillLevel_Text().text = "";
        self:GetNextSkillDescription_Text().text = "";
    end
end

---设置infoPanel 的位置
function UIHeartSkillInfoViewTemplate:SetInfoPanelPosition()
    if (self.mSelectHeartSkillUnit ~= nil) then
        local pos_y = self.mSelectHeartSkillUnit:GetSkillIconUnitTemplate():GetSkillFrame_UISprite().transform.position.y;
        self.go.transform.position = CS.UnityEngine.Vector3(self.go.transform.position.x, pos_y, 0);
        local localPos = self.go.transform.localPosition;
        if localPos.y > 314 then
            localPos.y = 314
        end
        if localPos.y - self:GetBackGround_UISprite().height < -323 then
            localPos.y = -323 + self:GetBackGround_UISprite().height;
        end
        localPos.z = 0
        self.go.transform.localPosition = localPos;
    end
end

function UIHeartSkillInfoViewTemplate:UpdateAnchors()
    local time = 0;
    local maxTime = 0.3;
    local interval = CS.UnityEngine.Time.deltaTime;
    while (time < maxTime) do
        coroutine.yield(CS.NGUIAssist.waitForEndOfFrame)
        self:MatchAnchor();
        self:SetInfoPanelPosition();
        time = time + interval;
    end
end

function UIHeartSkillInfoViewTemplate:MatchAnchor()

    local matchAnchor = self.mHasSkill and self:GetCurSkillDescription_Text().gameObject.transform or self:GetMatchNode_Transform();
    --region 适配相关
    self:GetNextSkillDescriptionWidget():SetAnchor(matchAnchor);
    for i = 0, self:GetWidgets().Length - 1, 1 do
        local widget = self:GetWidgets()[i];
        widget:UpdateAnchors();
    end
    --endregion
end

function UIHeartSkillInfoViewTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetSkillState_GameObject()).onClick = function()
        if (not self.mIsUsed) then
            networkRequest.ReqSecretSkillUpdate(self.mSkillTable.id, CS.CSScene.MainPlayerInfo.SkillInfoV2.SelectHeartSkillType);
        else
            networkRequest.ReqTakeOffSecret(self.mSkillTable.id);
        end
        self.mIsUsed = not self.mIsUsed;
        self:SetSkillState(self.mIsUsed);
    end

    self.CallUpdateSkillState = function()
        if (self.mSkillTable ~= nil) then
            self:UpdateHeartSkillInfo(self.mSkillTable.id);
        end
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, self.CallUpdateSkillState);

    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, self.CallUpdateSkillState);
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneSkillChangeMessage, self.CallUpdateSkillState);
end

function UIHeartSkillInfoViewTemplate:RemoveEvents()

    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_BagItemChanged, self.CallUpdateSkillState);
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, self.CallUpdateSkillState);
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResOneSkillChangeMessage, self.CallUpdateSkillState);
end

--endregion

--region CallFunction
--endregion

--endregion

function UIHeartSkillInfoViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self.mTweenStartPos = self:GetHeartSkillStateTweePosition().gameObject.transform.localPosition;
    self.mTweenEndPos = CS.UnityEngine.Vector3(self.mTweenStartPos.x + 33, self.mTweenStartPos.y, self.mTweenStartPos.z);
    --region 颜色
    ---橘黄色---灰色
    self.Orange = '[787878]'
    ---绿色---白色
    self.Green = '[dde6eb]'
    ---白色
    self.White = '[dde6eb]'
    ---红色
    self.Red = '[FF0000]'
    ---空位
    self.BLANK = '   '
    --endregion
end

function UIHeartSkillInfoViewTemplate:OnEnable()
    self:InitEvents();
end

function UIHeartSkillInfoViewTemplate:OnDisable()
    self:RemoveEvents();
end

function UIHeartSkillInfoViewTemplate:OnDestroy()
    self:RemoveEvents();
    self.mClientHandler = nil;
end

return UIHeartSkillInfoViewTemplate;