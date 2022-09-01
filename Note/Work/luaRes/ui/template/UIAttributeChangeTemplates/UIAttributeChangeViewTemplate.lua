local UIAttributeChangeViewTemplate = {};

UIAttributeChangeViewTemplate.mUnitPool = nil;

UIAttributeChangeViewTemplate.mTipsQueue = nil;

---战力滚动时间
UIAttributeChangeViewTemplate.duration = 0;

---给播放特效的回调
UIAttributeChangeViewTemplate.mPlayEffectCallBack = nil

UIAttributeChangeViewTemplate.mIsPlayServantStateTween = false;

UIAttributeChangeViewTemplate.mServantState = 0;

--region Components

--region GameObject

function UIAttributeChangeViewTemplate:GetUnitTemplate_GameObject()
    if (self.mUnitTemplate_GameObject == nil) then
        self.mUnitTemplate_GameObject = self:Get("template", "GameObject");
    end
    return self.mUnitTemplate_GameObject;
end

function UIAttributeChangeViewTemplate:GetStateTween_GameObject()
    if (self.mStateTween_GameObject == nil) then
        self.mStateTween_GameObject = self:Get("stateTween", "GameObject");
    end
    return self.mStateTween_GameObject;
end

--endregion

--region UILabel
function UIAttributeChangeViewTemplate:GetCombatValue_Text()
    if (self.mCombatValue_Text == nil) then
        self.mCombatValue_Text = self:Get("rolefight_down", "UILabel");
    end
    return self.mCombatValue_Text;
end

function UIAttributeChangeViewTemplate:GetCombatAddValue_Text()
    if (self.mCombatAddValue_Text == nil) then
        self.mCombatAddValue_Text = self:Get("deltaFight/num", "UILabel");
    end
    return self.mCombatAddValue_Text;
end
--endregion

function UIAttributeChangeViewTemplate:GetServantSate_UISprite()
    if (self.mServantState_UISprite == nil) then
        self.mServantState_UISprite = self:Get("stateTween/state", "UISprite");
    end
    return self.mServantState_UISprite;
end

function UIAttributeChangeViewTemplate:GetServantStateTweenTemplate()
    if (self.mServantStateTweenTemplate == nil) then
        self.mServantStateTweenTemplate = templatemanager.GetNewTemplate(self:GetStateTween_GameObject(), luaComponentTemplates.UIAttributeChangeUnitTweenTemplate);
    end
    return self.mServantStateTweenTemplate;
end

function UIAttributeChangeViewTemplate:GetGridContainer_UIGridContainer()
    if (self.mGridContainer_UIGridContainer == nil) then
        self.mGridContainer_UIGridContainer = self:Get("changeValues", "UIGridContainer");
    end
    return self.mGridContainer_UIGridContainer;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public
---@param attributeData 服务端数据
function UIAttributeChangeViewTemplate:AttributeChange(attributeData, isServant, callBack)
    ----region 显示信息筛选
    if attributeData == nil then
        return
    end
    if (attributeData.changeAttr ~= nil) then
        local addAttrs = {};
        local count = 0;

        local showAttackMinType = nil;
        local showAttackMaxType = nil;

        if (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior) then
            showAttackMinType = CS.roleV2.AttributeType.PhyAttackMin;
            showAttackMaxType = CS.roleV2.AttributeType.PhyAttackMax;
        elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master) then
            showAttackMinType = CS.roleV2.AttributeType.MagicAttackMin;
            showAttackMaxType = CS.roleV2.AttributeType.MagicAttackMax;
        elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist) then
            showAttackMinType = CS.roleV2.AttributeType.TaoAttackMin;
            showAttackMaxType = CS.roleV2.AttributeType.TaoAttackMax;
        end

        --for k, v in pairs(attributeData.changeAttr) do
        for i = 0, attributeData.changeAttr.Count - 1 do
            local v = attributeData.changeAttr[i];
            if (v.num ~= 0) then
                ---变动类型 1:增量 2:减量
                local tableUnit = {};
                tableUnit.changeType = v.num > 0 and 1 or 2;
                local value = math.abs(v.num);
                --region 属性变动
                if (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.MaxHp)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.MaxMp)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.InnerPowerMax)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                    --- 显示攻击力
                elseif (v.type == Utility.EnumToInt(showAttackMinType) or v.type == Utility.EnumToInt(showAttackMaxType)) then
                    if (v.type == Utility.EnumToInt(showAttackMinType)) then
                        if (addAttrs[Utility.EnumToInt(showAttackMaxType)] == nil) then
                            tableUnit.type = Utility.EnumToInt(showAttackMaxType)
                            tableUnit.minValue = 0
                            tableUnit.maxValue = "";
                            addAttrs[Utility.EnumToInt(showAttackMaxType)] = tableUnit;
                            count = count + 1;
                        end
                        addAttrs[Utility.EnumToInt(showAttackMaxType)].minValue = value;
                    else
                        if (addAttrs[Utility.EnumToInt(showAttackMaxType)] == nil) then
                            tableUnit.type = Utility.EnumToInt(showAttackMaxType)
                            tableUnit.minValue = 0
                            tableUnit.maxValue = "";
                            addAttrs[Utility.EnumToInt(showAttackMaxType)] = tableUnit;
                            count = count + 1;
                        end
                        addAttrs[Utility.EnumToInt(showAttackMaxType)].maxValue = value;
                    end

                    self.mPlayEffectCallBack = callBack
                    ---物理防御
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMin) or v.type == Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)) then
                    if (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMin)) then
                        if (addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)] == nil) then
                            tableUnit.type = Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)
                            tableUnit.minValue = 0
                            tableUnit.maxValue = "";
                            addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)] = tableUnit;
                            count = count + 1;
                        end
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)].minValue = value;
                    else
                        if (addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)] == nil) then
                            tableUnit.type = Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)
                            tableUnit.minValue = 0
                            tableUnit.maxValue = "";
                            addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)] = tableUnit;
                            count = count + 1;
                        end
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.PhyDefenceMax)].maxValue = value;
                    end
                    ---魔法防御
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMin) or v.type == Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)) then
                    if (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMin)) then
                        if (addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)] == nil) then
                            tableUnit.type = Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)
                            tableUnit.minValue = 0
                            tableUnit.maxValue = "";
                            addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)] = tableUnit;
                            count = count + 1;
                        end
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)].minValue = value;
                    else
                        if (addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)] == nil) then
                            tableUnit.type = Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)
                            tableUnit.minValue = 0
                            tableUnit.maxValue = "";
                            addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)] = tableUnit;
                            count = count + 1;
                        end
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.MagicDefenceMax)].maxValue = value;
                    end
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.showCritical)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = (value / 100) .. "%";
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.CriticalDamage)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.Accurate)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.Dodge)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HpRecover)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.MpRecover)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.Luck)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    addAttrs[v.type].maxValue = value
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.ResistanceCrit)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[v.type] = tableUnit;
                        count = count + 1;
                    end
                    local temp = math.floor(value * 0.01) == value * 0.01 and math.floor(value * 0.01) or value * 0.01
                    addAttrs[v.type].maxValue = tostring(temp) .. "%"
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax) or v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMin)) then
                    if (addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax)] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax)] = tableUnit;
                        count = count + 1;
                    end

                    if (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax)) then
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax)].maxValue = value
                    elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMin)) then
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyAttackMax)].minValue = value
                    end
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMin) or v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMax)) then
                    if (addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMin)] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMin)] = tableUnit;
                        count = count + 1;
                    end

                    if (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMin)) then
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMin)].minValue = value
                    elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMax)) then
                        addAttrs[Utility.EnumToInt(CS.roleV2.AttributeType.HolyDefenceMin)].maxValue = value
                    end
                elseif (v.type == Utility.EnumToInt(CS.roleV2.AttributeType.PenetrationAttributes)) then
                    if (addAttrs[v.type] == nil) then
                        tableUnit.type = v.type
                        tableUnit.minValue = ""
                        tableUnit.maxValue = "";
                        count = count + 1;
                    end
                    tableUnit.maxValue = value
                end
                --endregion
            end
        end

        local sortTable = {};
        for k, v in pairs(addAttrs) do
            table.insert(sortTable, v);
        end

        local function Sort(a, b)
            return a.type < b.type;
        end
        table.sort(sortTable, Sort)

        for k, v in pairs(sortTable) do
            v.isServant = isServant;
            table.insert(self.mTipsQueue, v);
        end
        if (#self.mTipsQueue > 0) then
            if (self.mIsPlayServantStateTween) then
                self:GetStateTween_GameObject():SetActive(true);
                self:GetServantSate_UISprite().spriteName = self.mServantState == 1 and "servant_battle" or "servant_combine";
                local pos = self:GetGridContainer_UIGridContainer().transform.localPosition;
                self:GetServantStateTweenTemplate():ResetPosition(CS.UnityEngine.Vector3(pos.x + 15, pos.y + self:GetGridContainer_UIGridContainer().CellHeight + 10, pos.z));
                self:GetServantStateTweenTemplate():PlayTweenAction(function()
                    self:GetStateTween_GameObject():SetActive(false);
                    self.mIsPlayServantStateTween = false;
                end);
            end
        else
            self.mIsPlayServantStateTween = false;
        end

        if (self.mCoroutineCreateUnit == nil) then
            self.mCoroutineCreateUnit = StartCoroutine(self.IEnumCreateUnit, self);
        end
    end

    if (self.mPlayEffectCallBack ~= nil) then
        self.mPlayEffectCallBack(true);
        self.mPlayEffectCallBack = nil;
    end
    ----endregion
end

---战力变动
---@param intervalValue 变动值
function UIAttributeChangeViewTemplate:CombatValueChange(oldNum, targetNum)
    if (targetNum - oldNum <= 0) then
        return
    end
    if (self.mCoroutineCombatValueChange ~= nil) then
        StopCoroutine(self.mCoroutineCombatValueChange);
        self.mCoroutineCombatValueChange = nil;
    end
    self.mCoroutineCombatValueChange = StartCoroutine(self.IEnumCombatValueChange, self, oldNum, targetNum);
end

--endregion

--region Private

---战力变动协程
function UIAttributeChangeViewTemplate:IEnumCombatValueChange(oldNum, targetNum)
    local intervalValue = targetNum - oldNum
    local tempTime = self.duration / intervalValue;
    local time = 0;
    local startValue = oldNum;
    self.go:SetActive(true);
    --self:GetGridContainer_UIGridContainer().gameObject:SetActive(true);
    self:GetCombatValue_Text().gameObject:SetActive(true);
    self:GetCombatValue_Text().text = startValue;
    self:GetCombatAddValue_Text().text = intervalValue;
    while time < self.duration do
        coroutine.yield(0);
        time = time + CS.UnityEngine.Time.deltaTime;
        local deltaTime = CS.UnityEngine.Time.deltaTime
        startValue = startValue + deltaTime / tempTime;
        self:GetCombatValue_Text().text = math.floor(startValue);
    end
    self:GetCombatValue_Text().text = math.floor(targetNum);
    self:GetPlayTween_UIPlayTween():PlayTween();
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
    --self:GetGridContainer_UIGridContainer().gameObject:SetActive(false);
    self:GetCombatValue_Text().gameObject:SetActive(false);
end

function UIAttributeChangeViewTemplate:IEnumCreateUnit()
    while #self.mTipsQueue > 0 do
        local index = 0;
        local showCount = 0;
        local count = 0;
        local isNotEnd = true;
        while isNotEnd do
            if (count < 5) then
                local tipsData = self.mTipsQueue[1];
                if (tipsData ~= nil) then
                    table.remove(self.mTipsQueue, 1);
                    local unitTemplate = self:GetUnitInPool();
                    showCount = showCount + 1;
                    count = count + 1;
                    unitTemplate:ResetPosition(CS.UnityEngine.Vector3(0, index * -self:GetGridContainer_UIGridContainer().CellHeight, 0))
                    unitTemplate:SetAttribute(tipsData, function()
                        self:RecoveryUnit(unitTemplate);
                        showCount = showCount - 1;
                        if (showCount == 0) then
                            isNotEnd = false;
                        end
                    end);
                    index = index + 1;
                end
            end
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.2));
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.2));
    end

    StopCoroutine(self.mCoroutineCreateUnit);
    self.mCoroutineCreateUnit = nil;
end

function UIAttributeChangeViewTemplate:GetUnitInPool()
    local poolCount = #self.mUnitPool;
    local unitTemplate = nil;
    if (poolCount > 0) then
        unitTemplate = self.mUnitPool[1];
        table.remove(self.mUnitPool, 1);
    else
        local gobj = CS.UnityEngine.GameObject.Instantiate(self:GetUnitTemplate_GameObject());
        gobj.transform.parent = self:GetGridContainer_UIGridContainer().gameObject.transform;
        local template = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIAttributeChangeUnitTemplate);
        table.insert(self.mUnitPool, template);
        return self:GetUnitInPool();
    end
    unitTemplate.go:SetActive(true);
    unitTemplate:ResetUnit();
    return unitTemplate;
end

function UIAttributeChangeViewTemplate:RecoveryUnit(unitTemplate)
    unitTemplate.go:SetActive(false);
    table.insert(self.mUnitPool, unitTemplate);
end

function UIAttributeChangeViewTemplate:InitEvents()
    self.CallOnResServantStateChangeMessage = function(msgId, msgData)
        if (msgData.newState ~= 1) then
            if (not self.mIsPlayServantStateTween) then
                self.mIsPlayServantStateTween = true;
                self.mServantState = msgData.newState;
            end
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantStateChangeMessage, self.CallOnResServantStateChangeMessage)
end

function UIAttributeChangeViewTemplate:RemoveEvents()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantStateChangeMessage, self.CallOnResServantStateChangeMessage);
end

function UIAttributeChangeViewTemplate:Clear()
    if (self.mCoroutineCombatValueChange ~= nil) then
        StopCoroutine(self.mCoroutineCombatValueChange);
        self.mCoroutineCombatValueChange = nil;
    end

    if (self.mCoroutineCreateUnit ~= nil) then
        StopCoroutine(self.mCoroutineCreateUnit);
        self.mCoroutineCreateUnit = nil;
    end

    self.mCombatValue_Text = nil;
    self.mCombatAddValue_Text = nil;
    self.mGridContainer_UIGridContainer = nil;
    self.mUIGrid_Grid = nil;
    self.mPlayTween_UIPlayTween = nil;
    self.mUnitPool = nil;
    self.mTipsQueue = nil;
end
--endregion

--endregion

function UIAttributeChangeViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitEvents();
    self.duration = 1;
    self.mUnitPool = {};
    self.mTipsQueue = {};
end

function UIAttributeChangeViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIAttributeChangeViewTemplate;