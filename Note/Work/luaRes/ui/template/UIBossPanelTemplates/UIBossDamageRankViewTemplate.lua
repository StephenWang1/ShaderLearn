local UIBossDamageRankViewTemplate = {};

UIBossDamageRankViewTemplate.mCounterAttackTargetTimer = 0;

UIBossDamageRankViewTemplate.mCounterAttackTarget = nil;

---@return CSMainPlayerInfo
function UIBossDamageRankViewTemplate:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2
function UIBossDamageRankViewTemplate:GetPlayerUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

--region Components

function UIBossDamageRankViewTemplate:GetCounterattackTip_GameObject()
    if (self.mCounterattackTip_GameObject == nil) then
        self.mCounterattackTip_GameObject = self:Get("secondOurRankItem/CounterattackTip", "GameObject");
    end
    return self.mCounterattackTip_GameObject;
end

function UIBossDamageRankViewTemplate:GetBtnCounterAttack_GameObject()
    if (self.mBtnCounterAttack_GameObject == nil) then
        self.mBtnCounterAttack_GameObject = self:Get("secondOurRankItem/killplayer", "GameObject");
    end
    return self.mBtnCounterAttack_GameObject;
end

function UIBossDamageRankViewTemplate:GetGridContainer_UIGridContainer()
    if (self.mGridContainer_UIGridContainer == nil) then
        self.mGridContainer_UIGridContainer = self:Get("ScrollView/SecondList", "UIGridContainer");
    end
    return self.mGridContainer_UIGridContainer;
end

function UIBossDamageRankViewTemplate:GetMyRankName_Text()
    if (self.mMyRankName_Text == nil) then
        self.mMyRankName_Text = self:Get("secondOurRankItem/secondValue", "UILabel");
    end
    return self.mMyRankName_Text;
end

function UIBossDamageRankViewTemplate:GetMyRankValue_Text()
    if (self.mMyRankValue_Text == nil) then
        self.mMyRankValue_Text = self:Get("secondOurRankItem/firstValue", "UILabel");
    end
    return self.mMyRankValue_Text;
end

function UIBossDamageRankViewTemplate:GetMyRankDamage_Text()
    if (self.mMyRankDamage_Text == nil) then
        self.mMyRankDamage_Text = self:Get("secondOurRankItem/thirdValue", "UILabel");
    end
    return self.mMyRankDamage_Text;
end

function UIBossDamageRankViewTemplate:GetBossRankPanel()
    local bossRankPanel = uimanager:GetPanel("UIBossRankPanel");
    if (bossRankPanel ~= nil) then
        return bossRankPanel;
    end
    return nil;
end

--endregion

--region Method

--region Public

function UIBossDamageRankViewTemplate:UpdateView()
    if (self.mUnitDic == nil) then
        ---@type table<UnityEngine.GameObject,UIBossDamageRankUnitTemplate>
        self.mUnitDic = {};
    end

    local list = CS.CSScene.MainPlayerInfo.BossInfoV2.BossBossDamageRankList;
    if (list ~= nil and list.Count > 0) then
        local gridContainer = self:GetGridContainer_UIGridContainer();
        gridContainer.MaxCount = list.Count;
        local playerUnionRank = -1
        if self:GetPlayerUnionInfoV2() and self:GetPlayerUnionInfoV2().UnionInfo then
            playerUnionRank = self:GetPlayerUnionInfoV2().UnionInfo.unionInfo.rank
        end
        for i = 0, list.Count - 1 do
            local gobj = gridContainer.controlList[i];
            if (self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIBossDamageRankUnitTemplate);
            end
            self.mUnitDic[gobj]:UpdateUnit(list[i],playerUnionRank);
        end
    end

    local mRankVo = CS.CSScene.MainPlayerInfo.BossInfoV2.SelfRankVO;

    if (mRankVo ~= nil) then
        self:GetMyRankValue_Text().text = mRankVo.rank;
        self:GetMyRankName_Text().text = mRankVo.roleName;
        self:GetMyRankDamage_Text().text = Utility.GetNumStr(mRankVo.hurt);
    else
        self:GetMyRankValue_Text().text = "未上榜";
        self:GetMyRankName_Text().text = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Name or "";
        self:GetMyRankDamage_Text().text = "0";
    end
end

function UIBossDamageRankViewTemplate:UpdateCounterAttackTarget(counterAttackTarget)
    if (counterAttackTarget ~= nil) then
        if not (CS.CSScene.Sington.MainPlayer ~= nil
                and CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater ~= nil
                and CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater.Target ~= nil
                and CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater.Target.AvatarType == CS.EAvatarType.Player) then
            if (not self:GetCounterattackTip_GameObject().activeSelf) then
                self:GetCounterattackTip_GameObject():SetActive(true);
            end
        else
            if (self:GetCounterattackTip_GameObject().activeSelf) then
                self:GetCounterattackTip_GameObject():SetActive(false);
            end
        end
        self.mCounterAttackTarget = counterAttackTarget;
        self.mCounterAttackTargetTimer = 5;
        self:TryStartCounterAttackTimer();

        if (self:GetBossRankPanel() ~= nil) then
            self:GetBossRankPanel():GetBtnArrowEffect_GameObject():SetActive(true and not self:GetBossRankPanel().showTips_bool);
        end
    else
        self:GetBtnCounterAttack_GameObject():SetActive(false);
        if (self.mCoroutineCounterTimer ~= nil) then
            StopCoroutine(self.mCoroutineCounterTimer);
            self.mCoroutineCounterTimer = nil;
        end
        if (self:GetBossRankPanel() ~= nil) then
            self:GetBossRankPanel():GetBtnArrowEffect_GameObject():SetActive(false);
        end
        self:GetCounterattackTip_GameObject():SetActive(false);
    end
end

function UIBossDamageRankViewTemplate:TryStartCounterAttackTimer()
    if (self.mCounterAttackTargetTimer > 0) then
        if (self.mCoroutineCounterTimer == nil) then
            self.mCoroutineCounterTimer = StartCoroutine(self.CCounterAttackTargetTimer, self)
        end
    else
        if (self.mCoroutineCounterTimer ~= nil) then
            StopCoroutine(self.mCoroutineCounterTimer);
            self.mCoroutineCounterTimer = nil;
        end
        if (self:GetBossRankPanel() ~= nil) then
            self:GetBossRankPanel():GetBtnArrowEffect_GameObject():SetActive(false);
        end
        self:GetCounterattackTip_GameObject():SetActive(false);
    end
end

function UIBossDamageRankViewTemplate:CCounterAttackTargetTimer()
    while (self.mCounterAttackTargetTimer > 0) do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(1));
        self:GetBtnCounterAttack_GameObject():SetActive(true)
        self.mCounterAttackTargetTimer = self.mCounterAttackTargetTimer - 1;
    end
    self:GetBtnCounterAttack_GameObject():SetActive(false);
    if (self:GetBossRankPanel() ~= nil) then
        self:GetBossRankPanel():GetBtnArrowEffect_GameObject():SetActive(false);
    end
    self:GetCounterattackTip_GameObject():SetActive(false);
    self.mCoroutineCounterTimer = nil;
end

function UIBossDamageRankViewTemplate:OnMainPlayerSelectUnit()
    if (CS.CSScene.Sington.MainPlayer ~= nil
            and CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater ~= nil
            and CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater.Target ~= nil
            and CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater.Target.AvatarType == CS.EAvatarType.Player) then
        self:GetCounterattackTip_GameObject():SetActive(false);
    end
end

--endregion

--endregion

function UIBossDamageRankViewTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnCounterAttack_GameObject()).onClick = function()
        if (self.mCounterAttackTarget ~= nil) then
            local targetAvatar = CS.CSScene.Sington:getAvatar(self.mCounterAttackTarget);
            if (targetAvatar ~= nil) then
                CS.CSScene.Sington.MainPlayer.TouchEvent:SetTarget(targetAvatar);
                self:GetCounterattackTip_GameObject():SetActive(false);
                --CS.CSAutoFightMgr.Instance:Toggle(true);
            end
        end
    end
end

function UIBossDamageRankViewTemplate:RemoveEvents()
    if (self.mCoroutineCounterTimer ~= nil) then
        StopCoroutine(self.mCoroutineCounterTimer);
        self.mCoroutineCounterTimer = nil;
    end
end

function UIBossDamageRankViewTemplate:Init()
    self:InitEvents();
    self:UpdateCounterAttackTarget(nil);
end

function UIBossDamageRankViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIBossDamageRankViewTemplate;