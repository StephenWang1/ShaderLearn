local UIShotcutConfigTemplate = {}
UIShotcutConfigTemplate.StartPoint = CS.UnityEngine.Vector3(-810, 260, 0);
UIShotcutConfigTemplate.Centre = CS.UnityEngine.Vector3(160, 240, 0);
UIShotcutConfigTemplate.IsPlay = false
UIShotcutConfigTemplate.IshavaOldlIcon = false
UIShotcutConfigTemplate.IsClickSkill = true
---@type UIMainSkillPanel
UIShotcutConfigTemplate.MainSkillPanel = nil
UIShotcutConfigTemplate.deltaPos = 0

---技能图标
function UIShotcutConfigTemplate:SkillIcon_UISprite()
    if self.mSkillIcon_UISprite == nil then
        self.mSkillIcon_UISprite = self:Get('skillIcon', 'UISprite')
    end
    return self.mSkillIcon_UISprite
end

---技能图标特效
function UIShotcutConfigTemplate:SkillIconEffect()
    if self.mSkillIconEffect == nil then
        self.mSkillIconEffect = self:Get('skillIcon/skillEffect', 'GameObject')
    end
    return self.mSkillIconEffect
end
---技能加号图标
function UIShotcutConfigTemplate:SkillIconAdd_UISprite()
    if self.mSkillIconAdd_UISprite == nil then
        self.mSkillIconAdd_UISprite = self:Get('skillFrame/Sprite', 'UISprite')
    end
    return self.mSkillIconAdd_UISprite
end

---道具图标
function UIShotcutConfigTemplate:SkillItemIcon_UISprite()
    if self.mSkillItemIcon_UISprite == nil then
        self.mSkillItemIcon_UISprite = self:Get('skillIcon/itemicon', 'UISprite')
    end
    return self.mSkillItemIcon_UISprite
end

---设置技能遮挡层
function UIShotcutConfigTemplate:additionSkill()
    if self.madditionSkill == nil then
        self.madditionSkill = self:Get('additionSkill', 'GameObject')
    end
    return self.madditionSkill
end

---技能图标
function UIShotcutConfigTemplate:OldlIcon_UISprite()
    if self.mSkillIconOld_UISprite == nil then
        self.mSkillIconOld_UISprite = self:Get('skillIconOld', 'UISprite')
        self.mSkillIconOld_UISprite.gameObject:SetActive(false)
    end
    return self.mSkillIconOld_UISprite
end

---技能CD图标
function UIShotcutConfigTemplate:CDMask()
    if self.mcdMask == nil then
        self.mcdMask = self:Get('cdMask', 'UISprite')
    end
    return self.mcdMask
end
---道具数量
function UIShotcutConfigTemplate:ItemCount_UILabel()
    if self.mItemCount == nil then
        self.mItemCount = self:Get('countLabel', 'UILabel')
    end
    return self.mItemCount
end

---道具数量
function UIShotcutConfigTemplate:ItemCount_UILabel()
    if self.mItemCount == nil then
        self.mItemCount = self:Get('countLabel', 'UILabel')
    end
    return self.mItemCount
end

function UIShotcutConfigTemplate:GetIntensifySkillIcon()
    if self.mIntensifySkillIcon == nil then
        self.mIntensifySkillIcon = self:Get('intensifySkillIcon', 'UISprite')
    end
    return self.mIntensifySkillIcon
end

function UIShotcutConfigTemplate:ID()
    return self.id
end

---获取灵兽信息列表
function UIShotcutConfigTemplate:GetServantInfoList()
    return CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList
end

---获取指定位置的灵兽
function UIShotcutConfigTemplate:SwitchServant(index)
    if (self:GetServantInfoList().Count > index) then
        return self:GetServantInfoList()[index]
    end
    return nil
end

function UIShotcutConfigTemplate:GetSkill(skillID)
    local isFind;
    if self.skill == nil then
        isFind, self.skill = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(skillID)
    elseif self.skill.id ~= skillID then
        isFind, self.skill = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(skillID)
    end
    return self.skill
end

function UIShotcutConfigTemplate:Init()
    self.IsSkill = true
    self.IshavaOldlIcon = false
    self.SkillCD = 0
    self.SurplusSkillCD = 0
    self.MainSkillPanel = nil
    self.autofightEffects = nil
    UIShotcutConfigTemplate.pressPosition = nil
    CS.UIEventListener.Get(self.go.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.go.gameObject).OnClickLuaDelegate = self.ReleaseSkill
    CS.UIEventListener.Get(self.go.gameObject).onPress = self.Down
    self:additionSkill().gameObject:SetActive(false);
end

---设置旧的Icon
function UIShotcutConfigTemplate:SetOldlIcon(skillID)
    self.IshavaOldlIcon = true
    if skillID == nil then
        return
    end
    local IsFind, skill = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(skillID)

    if IsFind then
        self:OldlIcon_UISprite().gameObject:SetActive(true)
        self:OldlIcon_UISprite().spriteName = skill.icon
        self:OldlIcon_UISprite().depth = 1
    end
end

--region 首次获得技能飞行动画
---设置技能初始位置-开启动画
function UIShotcutConfigTemplate:SetStartAnimationPoint()
    if self:SkillIcon_UISprite().transform.localPosition ~= CS.UnityEngine.Vector3(0, 0, 0) then
        return
    end
    -- CS.UnityEngine.Object.Instantiate(temp, temp.transform.parent);
    self:SkillIcon_UISprite().transform.localPosition = self.StartPoint - self:SkillIcon_UISprite().transform.parent.localPosition
    self.Centre.x = self:SkillIcon_UISprite().transform.localPosition.x / 2
    self.Coroutine = StartCoroutine(self.Delay, self)
end

---Icon飞入动画
function UIShotcutConfigTemplate:Delay()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    self.IsPlay = true
    while self.IsPlay do
        local iconPosition = self:SkillIcon_UISprite().transform.localPosition
        local x = CS.UnityEngine.Mathf.Lerp(iconPosition.x, 0, 0.1);
        local y_target = 0
        if x >= self.Centre.x then
            y_target = 0
        else
            y_target = self.Centre.y
        end
        local y = CS.UnityEngine.Mathf.Lerp(iconPosition.y, y_target, 0.1);
        if math.abs(x) <= 3 then
            x = 0
            y = 0
            self.IsPlay = false
            if self:OldlIcon_UISprite() ~= nil then
                self:OldlIcon_UISprite().gameObject:SetActive(false);
            end
            self:PlayEffect();
            StopCoroutine(self.Coroutine)
        end
        self:SkillIcon_UISprite().transform.localPosition = CS.UnityEngine.Vector3(x, y, 0);
        coroutine.yield(0)
    end
end

function UIShotcutConfigTemplate:Animation()
    local iconPosition = self:SkillIcon_UISprite().transform.localPosition
    local x = CS.UnityEngine.Mathf.MoveTowards(iconPosition.x, 0, 0.05);
    local y_target = 0
    if x >= self.Centre.x then
        y_target = 0
    else
        y_target = self.Centre.y
    end
    local y = CS.UnityEngine.Mathf.MoveTowards(iconPosition.y, y_target, 0.1);
    self:SkillIcon_UISprite().transform.localPosition = CS.UnityEngine.Vector3(x, y, 0);
    if math.abs(x) <= 0.1 then
        x, y = 0
        self.IsPlay = false

        StopCoroutine(self.Coroutine)
    end
end

function UIShotcutConfigTemplate:PlayEffect()
    if (self.mChooseRoleEffect == nil) then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete("800016", CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                local poolItem = res:GetUIPoolItem(CS.EPoolType.Normal, 0, 5)
                if poolItem ~= nil then
                    self.mChooseRoleEffect = poolItem.go
                    if self.mChooseRoleEffect then
                        self.mChooseRoleEffect.transform.parent = self:SkillIcon_UISprite().gameObject.transform
                        self.mChooseRoleEffect.transform.localScale = CS.UnityEngine.Vector3(110, 110, 110);
                        self.mChooseRoleEffect.transform.localPosition = CS.UnityEngine.Vector3.zero;
                    end
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        self.mChooseRoleEffect:SetActive(false);
        self.mChooseRoleEffect:SetActive(true);
    end
end

function UIShotcutConfigTemplate:ClosePlayEffect()
    if CS.StaticUtility.IsNull(self.mChooseRoleEffect) == false then
        self.mChooseRoleEffect:SetActive(false);
    end
end

--endregion
---刷新UI
function UIShotcutConfigTemplate:Refresh(skillID, MainSkillPanel, index)
    self.index = index
    self.IsSkill = CS.Cfg_SkillTableManager.Instance:TryGetValue(skillID)
    self.id = skillID
    UIShotcutConfigTemplate.MainSkillPanel = MainSkillPanel
    self.MainSkillPanel = MainSkillPanel
    self:SkillIconAdd_UISprite().gameObject:SetActive(skillID == 0)
    if skillID == 0 then
        self:SkillIcon_UISprite().gameObject:SetActive(false)
        self:OldlIcon_UISprite().gameObject:SetActive(false);
    else
        self.SkillCD = CS.Cfg_SkillsConditionManager.Instance:GetSkillCD(skillID, 1);
        self:SkillIcon_UISprite().gameObject:SetActive(true)
        local tableInfo = CS.Cfg_SkillTableManager.Instance[skillID]
        if tableInfo == nil then
            tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(skillID)
            if tableInfo ~= nil then
                self:SkillItemIcon_UISprite().spriteName = tableInfo.icon
                self:SkillIcon_UISprite().spriteName = tableInfo.icon
            end
        else
            self:SkillItemIcon_UISprite().color = CS.UnityEngine.Color.white
            self:SkillItemIcon_UISprite().spriteName = tableInfo.icon
            self:SkillIcon_UISprite().spriteName = tableInfo.icon
        end
    end
    self:additionSkill():SetActive(false)
    self:CDMask().fillAmount = 0
    self:SetSkillChangeCommonAttack(skillID, true)
    self:AutofightEffectsController()
    self:RefreshItem()
    self:RefreshIntensifySkillIcon()
end

---刷新强化技能Icon
function UIShotcutConfigTemplate:RefreshIntensifySkillIcon()
    local skillID = self.id
    if self:GetIntensifySkillIcon() == nil then
        return
    end
    if skillID == 0 then
        self:GetIntensifySkillIcon().gameObject:SetActive(false)
        return
    end
    ---@type table<number,LuaSkillDetailedInfo>
    self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if self.SkillInfoDic ~= nil then
        ---@type LuaSkillDetailedInfo
        self.NowSkillInfo = self.SkillInfoDic[skillID]
    end
    if self.SkillInfoDic == nil or self.NowSkillInfo == nil then
        self:GetIntensifySkillIcon().gameObject:SetActive(false)
        return
    end
    local IntensifySkillInfo = self.NowSkillInfo:GetIntensifySkillInfo()
    self:GetIntensifySkillIcon().gameObject:SetActive(IntensifySkillInfo ~= nil)
    if IntensifySkillInfo ~= nil and IntensifySkillInfo:GetSkillTable() ~= nil then
        self:GetIntensifySkillIcon().spriteName = IntensifySkillInfo:GetSkillTable():GetIcon2()
    end
end

local unityTime = CS.UnityEngine.Time

function UIShotcutConfigTemplate:Down(IsDown)
    if CS.CSScene.MainPlayerInfo.IsSlipState then
        return
    end
    if UIShotcutConfigTemplate.MainSkillPanel == nil then
        return
    end
    local selfTemplate
    for k, Template in pairs(UIShotcutConfigTemplate.MainSkillPanel.ShotcutConfigList) do
        if Template.go == self then
            selfTemplate = Template
        end
    end
    if selfTemplate == nil then
        return
    end
    if IsDown then
        UIShotcutConfigTemplate.pressPosition = CS.UnityEngine.Input.mousePosition
        selfTemplate.deltaPos = 0;
    end
    --极光电影
    if selfTemplate.id == 102008 then

    end
    local OnDragDistance = CS.UnityEngine.Vector2
    if (IsDown) then
        selfTemplate.lastPressTime = unityTime.time
    else
        selfTemplate.upPressTime = unityTime.time;

        OnDragDistance = CS.UIEventListener.Get(self).OnDragDistance
    end
    --极光电影
    if (selfTemplate.id == 102008) then
        --正常来说应该读取技能表中的技能范围,先这样
        CS.CSSceneExt.Sington.SkillLinkEffectRang = 6
        CS.CSSceneExt.Sington.YMCZArrowIsNeedShow = IsDown
        if IsDown == false then
            local difTime = selfTemplate.upPressTime - selfTemplate.lastPressTime;
            if (difTime < 0.2) then
                selfTemplate:UseSkill(selfTemplate.id, true)
            elseif CS.UnityEngine.Vector2.Distance(CS.UnityEngine.Vector2.zero, OnDragDistance) < 30 then
                selfTemplate:UseSkill(selfTemplate.id, true, true)
            end
        end
    end

    --野蛮冲撞/
    if selfTemplate.id == 101004 then
        --正常来说应该读取技能表中的技能范围,先这样
        CS.CSSceneExt.Sington.SkillLinkEffectRang = 4
        CS.CSSceneExt.Sington.YMCZArrowIsNeedShow = IsDown
        if IsDown == false then
            if CS.UnityEngine.Vector2.Distance(CS.UnityEngine.Vector2.zero, OnDragDistance) < 30 then
                selfTemplate:UseSkill(selfTemplate.id, true, true)
            end
        end
    end
end

function UIShotcutConfigTemplate:onDragSkill(go, delta)
    self.deltaPos = self.deltaPos + delta;
end

function UIShotcutConfigTemplate:GetLastHpServant()

end

function UIShotcutConfigTemplate:ReleaseSkill()
    if CS.CSScene.MainPlayerInfo:SlipStateTip() then
        return
    end
    UIShotcutConfigTemplate.IsClickSkill = self.IsSkill
    if self:ID() == 0 then
        local customData = {};
        customData.targetId = luaEnumNavigationType.SkillKeyPos;
        uiStaticParameter.mSkillConfigSelectedIndex = self.index
        if luaEventManager.HasCallback(LuaCEvent.Navigation_OpenWithId) then
            luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, customData);
        end
    else
        if self:ID() == 102008 then
            return
        end
        self:UseSkill(self:ID())

        ---是否有晕眩buff
        if (CS.CSScene.MainPlayerInfo.BuffInfo:HasBuff(4)) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Parent] = self.go.transform;
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 65
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        end

        if self.SurplusSkillCD <= 0 then
            if self.MainSkillPanel:UseItem(self:ID()) then
                if self.ItemCD == nil then
                    local isFind, tableValue = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self:ID());
                    if isFind then
                        self.ItemCD = tableValue.resetTime * 1000
                    end
                end
            end
        end

    end
end

---使用技能
function UIShotcutConfigTemplate:UseSkill(skillID, IsUse, isSpecialSelectModel)
    if IsUse == false or IsUse == nil then
        if skillID == 101004 then
            return
        end
    end
    if LuaGlobalTableDeal.IsAnyAntiSkillReleaseBuffExistInMainPlayer() then
        --print("玩家身上有禁止施法的buff存在")
        ---玩家身上有禁止施法的buff存在
        return
    end
    if not CS.CSServerTime.IsServerTimeReceived then
        CS.Utility.ShowTips("服务器时间未初始化，技能中断释放", 1.5, CS.ColorType.Red);
        return
    end
    if self:SetSkillChangeCommonAttack(skillID, false) then
        return
    end

    if self:ID() ~= 0 then
        local mskill = CS.CSScene.Sington.MainPlayer.SkillEngine:GetSkill(skillID);
        if mskill ~= nil and mskill.SkillCondition ~= nil then
            if mskill.SkillCondition.costMp <= CS.CSScene.MainPlayerInfo.MP or self:IsReleaseDotType(skillID) then
                self:UseSkillCondition(skillID, isSpecialSelectModel)
            else
                CS.Utility.ShowTips("法力不足", 1.5, CS.ColorType.Red);
            end
        end
    end
end

---是否是对点类型的技能
function UIShotcutConfigTemplate:IsReleaseDotType(skillID)
    local isfind, SkillData = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(skillID)
    if isfind then
        if SkillData.releaseTypeClient == 2 then
            return true
        end
    end
    return false
end

---使用技能条件
function UIShotcutConfigTemplate:UseSkillCondition(skillID, isSpecialSelectModel)
    self.MainSkillPanel:CloseUnlockedDotSkill(self)
    local isfind, SkillData = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(skillID)
    if isfind then
        local isActive = CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill == SkillData;
        self.MainSkillPanel:CloseSelectSkill()
        if isActive then
            return
        end
        if SkillData.releaseTypeClient == 1 then
            self:CastSkill(skillID, isSpecialSelectModel)
        elseif SkillData.releaseTypeClient == 2 then
            if CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill ~= SkillData then
                CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill = SkillData;
                self:SetAutofightEffects(true)
            else
                CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill = nil;
                self:SetAutofightEffects(false)
            end

        else
            self:CastSkill(skillID, isSpecialSelectModel)
        end
    end
end

function UIShotcutConfigTemplate:CastSkill(skillID, isSpecialSelectModel)
    if self:CDMask().fillAmount <= 0.01 then
        local avatar = CS.CSScene.Sington:getCurAttackAvatar();
        Utility.ShowChangAttackPatternTip(avatar, skillID)
        CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.NowSelectSkill.SkillID = skillID
        CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.NowSelectSkill.SkillReleaseType = CS.ESkillReleaseType.Target
        CS.CSAutoFight.IsOnClickButtonAttack = true;

        CS.CSAutoPauseMgr.Instance:CacheCurrentFrameStateData();
        CS.CSAutoPauseMgr.Instance:TryEnterPausedState();
        if (isSpecialSelectModel == true) then
            CS.CSScene.Sington.MainPlayer:CastSkillOrItem(skillID, true, true)
        else
            CS.CSScene.Sington.MainPlayer:CastSkillOrItem(skillID, false, true)
        end
    end
end

function UIShotcutConfigTemplate:AutofightEffectsController()

    local isfind, SkillData = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(self:ID())
    if isfind then
        if SkillData.releaseTypeClient == 2 then
            self:SetAutofightEffects(CS.CSScene.MainPlayerInfo.SkillInfo.UnlockedDotSkill == SkillData)
            return
        end
    end
    self:SetAutofightEffects(false)
end

---开启/关闭普通攻击附加技能
function UIShotcutConfigTemplate:SetSkillChangeCommonAttack(skillID, IsRefresh)
    local skillIdList = CS.Cfg_GlobalTableManager.Instance.AdditionSkillList
    local isfind = false
    for i = 0, skillIdList.Length - 1 do
        if tostring(skillID) == tostring(skillIdList[i]) then
            isfind = true
        end
    end
    if isfind == false then
        return false
    end
    local isOpen = CS.CSScene.MainPlayerInfo.SkillInfoV2:IsAutoSkillOpen(skillID);
    local IsadditionSkill = false;
    if IsRefresh == true then
        self:additionSkill():SetActive(not isOpen)
        return true
    end
    if isOpen then
        CS.CSScene.MainPlayerInfo.SkillInfoV2:SetSkillOptionsDic(skillID, false);
        IsadditionSkill = false;
    else
        CS.CSScene.MainPlayerInfo.SkillInfoV2:SetSkillOptionsDic(skillID, true);
        IsadditionSkill = true;
    end
    CS.Cfg_SkillTableManager.Instance:RefreshSkillList()
    local Skill = CS.Cfg_SkillTableManager.Instance.SkillList[skillID]
    local name
    if IsadditionSkill then
        name = "[00ff00]开启[-] [ffffff]" .. tostring(Skill.name)
    else
        name = "[ffffff]关闭[-] [ffffff]" .. tostring(Skill.name)
    end
    CS.Utility.ShowTips(name, 1.5, CS.ColorType.White)
    self:additionSkill():SetActive(not IsadditionSkill)
    --  self:CDMask().gameObject:SetActive(IsadditionSkill)
    -- if luaEventManager.HasCallback(LuaCEvent.Skill_AutoRelease) then
    --     luaEventManager.DoCallback(LuaCEvent.Skill_AutoRelease)
    -- end
    local list = CS.CSScene.MainPlayerInfo.SkillInfoV2:GetSkillOptionsList()
    networkRequest.ReqSaveRoleSkillSettings(list)
    return true
end

---刷新物品,包括颜色等
function UIShotcutConfigTemplate:RefreshItem()
    self:RefreshItemCountLabel()
    if self.IsSkill then
        self:SkillItemIcon_UISprite().gameObject:SetActive(false)
        return
    end
    self:SkillItemIcon_UISprite().gameObject:SetActive(true)
    self:SetItemColor(self.MainSkillPanel:GetBagProp(self:ID()))
end

---刷新物品数量文字
function UIShotcutConfigTemplate:RefreshItemCountLabel()
    if self.IsSkill or self.id == 0 then
        self:ItemCount_UILabel().gameObject:SetActive(false)
    else
        local itemCount = 0
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BagInfo ~= nil then
            itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.id)
        end
        if itemCount and itemCount > 1 then
            self:ItemCount_UILabel().gameObject:SetActive(true)
            self:ItemCount_UILabel().text = tostring(itemCount)
        else
            self:ItemCount_UILabel().gameObject:SetActive(false)
        end
    end
end

---获取最少血量的灵兽
function UIShotcutConfigTemplate:GetSmallHPServant()
    if (UIShotcutConfigTemplate:GetServantInfoList().Count > 0) then
        local hp = UIShotcutConfigTemplate:GetServantInfoList()[0].hp
        local index = 0
        for i = 0, UIShotcutConfigTemplate:GetServantInfoList().Count - 1 do
            if (hp < UIShotcutConfigTemplate:GetServantInfoList()[i].hp) then
                index = i
            end
        end
        return UIShotcutConfigTemplate:GetServantInfoList()[index]
    end
    return nil
end

---设置道具颜色
function UIShotcutConfigTemplate:SetItemColor(IsHave)
    if IsHave then
        self:SkillItemIcon_UISprite().color = CS.UnityEngine.Color.white
    else
        self:SkillItemIcon_UISprite().color = CS.UnityEngine.Color.black
    end
end

---设置自动战斗特效
function UIShotcutConfigTemplate:SetAutofightEffects(IsOpen)
    self:SkillIconEffect().gameObject:SetActive(IsOpen)
    -- if self.autofightEffects == nil then
    --     CS.CSResourceManager.Singleton:AddQueueCannotDelete("800003", CS.ResourceType.UIEffect, function(res)
    --         if res and res.MirrorObj then
    --             if self.go ~= nil then
    --                 if self.autofightEffects == nil then
    --                     local poolItem = res:GetUIPoolItem()
    --                     self.autofightEffects = poolItem.go
    --                 end
    --                 if self.autofightEffects then
    --                     self.autofightEffects.transform.parent = self:SkillIcon_UISprite().gameObject.transform;
    --                     self.autofightEffects.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    --                     self.autofightEffects.transform.localScale = CS.UnityEngine.Vector3(60, 60, 100)
    --                 end
    --             end
    --             self.autofightEffects:SetActive(IsOpen)
    --         end
    --     end
    --     , CS.ResourceAssistType.UI)
    -- else
    --     self.autofightEffects:SetActive(IsOpen)
    -- end
end

function UIShotcutConfigTemplate:UISkillPanelBack()
    if UIShotcutConfigTemplate.IsClickSkill == true then
        uimanager:GetPanel("UISkillPanel").ShowPanel(1)
    else
        uimanager:GetPanel("UISkillPanel").OpenSkillConfigPanel_ShowProps();
    end
end

function UIShotcutConfigTemplate:RefeshSkillCD()
    self.SurplusSkillCD = self.SurplusSkillCD - CS.UnityEngine.Time.deltaTime * 1000
    if self.SurplusSkillCD <= 0 then
        self.SurplusSkillCD = 0
        self:CDMask().fillAmount = 0
    else
        self:CDMask().fillAmount = self.SurplusSkillCD / self.SkillCD
    end
end

function UIShotcutConfigTemplate:OnDisable()
    self:ClosePlayEffect()
end

function UIShotcutConfigTemplate:OnDestroy()
    StopCoroutine(self.Coroutine)
end
return UIShotcutConfigTemplate