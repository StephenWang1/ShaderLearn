---@class UIBossView:luaobject
local UIBossView = {};

UIBossView.mBossUnitDic = nil;
UIBossView.lastSelectId = 0;

UIBossView.mBossVoList = nil;

UIBossView.mScrollViewOriginY = 0;

UIBossView.mIsFirst = true;

--region Components

--region GameObject
function UIBossView:GetGoMapBtnViewTemplate_GameObject()
    if (self.mGoMapBtnViewTemplate_GameObject == nil) then
        self.mGoMapBtnViewTemplate_GameObject = self:Get("selectMap", "GameObject");
    end
    return self.mGoMapBtnViewTemplate_GameObject;
end

--endregion

function UIBossView:GetGoMapBtnViewTemplate()
    if (self.mGoMapBtnViewTemplate == nil) then
        self.mGoMapBtnViewTemplate = luaclass.UIGoMapBtnView:NewWithGO(self:GetGoMapBtnViewTemplate_GameObject())
        --self.mGoMapBtnViewTemplate = templatemanager.GetNewTemplate(self:GetGoMapBtnViewTemplate_GameObject(), luaComponentTemplates.UIGoMapBtnViewTemplate);
    end
    return self.mGoMapBtnViewTemplate;
end

function UIBossView:GetUIGridContainer_UIGridContainer()
    if (self.mUIGridContainer_UIGridContainer == nil) then
        self.mUIGridContainer_UIGridContainer = self:Get("scroll/gc_buttons", "UIGridContainer");
    end
    return self.mUIGridContainer_UIGridContainer;
end

---@return UIScrollView
function UIBossView:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:Get("scroll", "UIScrollView");
    end
    return self.mScrollView;
end

function UIBossView:GetLoopScrollView()
    if (self.mLoopScrollView == nil) then
        self.mLoopScrollView = self:Get("scroll/loopScrollView", "Top_LoopScrollView");
    end
    return self.mLoopScrollView;
end

function UIBossView:GetSpringPanel()
    if (self.mSpringPanel == nil) then
        self.mSpringPanel = self:Get("scroll", "SpringPanel");
    end
    return self.mSpringPanel;
end

---@return  UILoopScrollViewPlus
function UIBossView:GetLoopScrollViewPlus()
    if self.mLoopScrollViewPlus == nil then
        self.mLoopScrollViewPlus = self:Get("scroll/content", "UILoopScrollViewPlus")
    end
    return self.mLoopScrollViewPlus
end

--endregion

--region Method

---@param bossType number boss类型
---@param OnClickUnitCallBack function
function UIBossView:ShowBossUnits(bossType, OnClickUnitCallBack, targetMonsterId, taskMonsterId)
    self.mTargetMonsterId = targetMonsterId;
    self.mTaskMonsterId = taskMonsterId;
    self.mMeetCheatPushBossIdList = CS.Cfg_BossTableManager.Instance:GetMeetCheatPushBoss(bossType)
    self.mBossVoList = CS.CSScene.MainPlayerInfo.BossInfoV2:GetSortBossInfo(bossType);
    self:RefreshCurrentPage()
    --[[
    if (self.mBossUnitDic == nil) then
        self.mBossUnitDic = {};
    end
    self.mTargetMonsterId = targetMonsterId;
    self:GetLoopScrollView():ResetToBegining(true);

    local recommendIndex = -1;
    local gridContainer = self:GetUIGridContainer_UIGridContainer();
    local meetCheatPushBossIdList = CS.Cfg_BossTableManager.Instance:GetMeetCheatPushBoss(bossType)
    self.mBossVoList = CS.CSScene.MainPlayerInfo.BossInfoV2:GetSortBossInfo(bossType);
    if (self.mBossVoList ~= nil and self.mBossVoList.Count > 0) then
        gridContainer.MaxCount = self.mBossVoList.Count;
        for i = 0, self.mBossVoList.Count - 1 do
            local isContains = false
            if meetCheatPushBossIdList and meetCheatPushBossIdList.Count > 0 then
                for t = 0, meetCheatPushBossIdList.Count - 1 do
                    if meetCheatPushBossIdList[t] == self.mBossVoList[i][0].configId then
                        isContains = true
                    end
                end
            end
            local gobj = gridContainer.controlList[i];
            if (self.mBossUnitDic[gobj] == nil) then
                self.mBossUnitDic[gobj] = luaclass.UIBossUnit:NewWithGO(gobj)
                --self.mBossUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIBossUnitTemplate);
            end
            self.mBossUnitDic[gobj]:ShowWithData(self.mBossVoList[i], i, isContains)
            if isContains then
                if (recommendIndex < 0) then
                    recommendIndex = i;
                end
            end
        end
    end
    --local recommendIndex = 0;
    --if(self.mBossVoList ~= nil) then
    --    local list = CS.Cfg_BossTableManager.Instance:GetGradeApproachingBoss(CS.CSScene.MainPlayerInfo.Level, bossType, 1);
    --    if(list ~= nil) then
    --        for i = 0, list.Count - 1 do
    --            for j = 0, self.mBossVoList.Count - 1 do
    --                if(self.mBossVoList[j].Count > 0) then
    --                    local configId = self.mBossVoList[j][0].configId;
    --                    if(configId == list[i].id) then
    --                        recommendIndex = j;
    --                        break;
    --                    end
    --                end
    --            end
    --        end
    --    end
    --    self:GetLoopScrollView():Init(self.mBossVoList, function(item, data)
    --        local gobj = item.widget.gameObject;
    --        local template = luaclass.UIBossUnit:NewWithGO(gobj)
    --        template:ShowWithData(data, item.dataIndex);
    --        template:IsChoose(self.mTargetMonsterId);
    --    end);
    --end
    if (self.mTargetMonsterId ~= nil) then
        self:ChooseTargetMonster(self.mTargetMonsterId);
    else
        if (recommendIndex > 2) then
            local targetIndex = recommendIndex - 2;
            self:SetSpringPanel(targetIndex);
        end
    end
    --]]
end

function UIBossView:RefreshCurrentPage()
    if (self.mIsFirst) then
        self.mIsFirst = false;
        self:GetLoopScrollViewPlus():Init(
                function(go, line)
                    return self:RefreshItem(go, line, self.mMeetCheatPushBossIdList)
                end, function(line)
                    self.mTopLine = line
                end)
    else
        self:GetLoopScrollViewPlus():ResetPage();
    end

    if self.missionLine ~= nil then
        self:MissionJumpToAimLine(self.missionLine)
    else
        self:JumpToAimLine(self.mMeetCheatPushBossIdList)
    end

end

---刷新单个格子
function UIBossView:RefreshItem(go, line)
    if (self.mBossVoList == nil) then
        return false;
    end

    if line < self.mBossVoList.Count then
        local isContains = false
        if self.mMeetCheatPushBossIdList and self.mMeetCheatPushBossIdList.Count > 0 then
            for t = 0, self.mMeetCheatPushBossIdList.Count - 1 do
                if self.mMeetCheatPushBossIdList[t] == self.mBossVoList[line][0].configId then
                    isContains = true
                end
                if self.mTaskMonsterId == self.mBossVoList[line][0].configId then
                    local data = {}
                    data.monstersID = self.mTaskMonsterId
                    data.baseGo = go
                    self.missionLine = line
                    uimanager:CreatePanel('UIBossKillTipsPanel', nil, data)
                end
            end
        end
        local temp = self:GetGridTemplate(go)
        if temp then
            temp:ShowWithData(self.mBossVoList[line], line, isContains)
            temp:IsChoose(self.mTargetMonsterId)
            return true
        end
    end
    return false
end

---@return UIBossUnit
function UIBossView:GetGridTemplate(go)
    if (self.mBossUnitDic == nil) then
        self.mBossUnitDic = {}
    end
    local temp = self.mBossUnitDic[go]
    if temp == nil then
        temp = luaclass.UIBossUnit:NewWithGO(go, self)
        self.mBossUnitDic[go] = temp
    end
    return temp
end

---@return number 跳转
function UIBossView:JumpToAimLine(meetCheatPushBossIdList)
    local line = self:GetBossTargetMonsterLine(meetCheatPushBossIdList)
    if line then
        if line + 5 >= self.mBossVoList.Count then
            line = self.mBossVoList.Count - 5
        end
        local pos = self:GetLoopScrollViewPlus():GetJumpToLineV3(line)
        self:GetScrollView():Begin(pos, 8)
    end
end

function UIBossView:MissionJumpToAimLine(line)
    if line then
        if line + 5 >= self.mBossVoList.Count then
            line = self.mBossVoList.Count - 5
        end
        local pos = self:GetLoopScrollViewPlus():GetJumpToLineV3(line)
        self:GetScrollView():Begin(pos, 8)
    end
end

---@return number 获得跳转行
function UIBossView:GetBossTargetMonsterLine(meetCheatPushBossIdList)
    if (self.mTargetMonsterId ~= nil) then
        return self:GetBoosTargetLine(self.mTargetMonsterId)
    else
        local recommendIndex = self:GetRecommendIndex(meetCheatPushBossIdList)
        if (recommendIndex > 2) then
            local targetIndex = recommendIndex - 2;
            return targetIndex
        end
    end
end

---@return number 获得跳转行
function UIBossView:GetBoosTargetLine(monsterId)
    local line = 0
    if monsterId then
        if (self.mBossVoList ~= nil and self.mBossVoList.Count > 0 and self.mBossUnitDic ~= nil) then
            if self.mBossVoList.Count <= 5 then
                return 0
            end
            for i = 0, self.mBossVoList.Count - 1 do
                if (self.mBossVoList[i].Count > 0) then
                    if (self.mBossVoList[i][0].configId == monsterId) then
                        local center = i - 2
                        if center < 0 then
                            center = 0
                        end
                        if center > self.mBossVoList.Count - 5 then
                            center = self.mBossVoList.Count - 5
                        end
                        return center
                    end
                end
            end
        end
    end
    return line
end

---@return number 获得跳转行
function UIBossView:GetRecommendIndex(meetCheatPushBossIdList)
    local recommendIndex = -1;
    local isContains = false
    if self.mBossVoList == nil then
        return recommendIndex
    end
    for i = 0, self.mBossVoList.Count - 1 do
        local isContains = false
        if meetCheatPushBossIdList and meetCheatPushBossIdList.Count > 0 then
            for t = 0, meetCheatPushBossIdList.Count - 1 do
                if meetCheatPushBossIdList[t] == self.mBossVoList[i][0].configId then
                    isContains = true
                end
            end
        end
        if isContains then
            if (recommendIndex < 0) then
                recommendIndex = i
            end
        end
    end
    return recommendIndex
end

function UIBossView:ChooseTargetMonster(monsterId)
    if (monsterId == nil) then
        return ;
    end
    if (self.mBossVoList ~= nil and self.mBossVoList.Count > 0 and self.mBossUnitDic ~= nil) then
        for i = 0, self.mBossVoList.Count - 1 do
            if (self.mBossVoList[i].Count > 0) then
                if (self.mBossVoList[i][0].configId == monsterId) then
                    self:SetSpringPanel(i);
                    break ;
                end
            end
        end

        for k, v in pairs(self.mBossUnitDic) do
            if (v:IsChoose(monsterId)) then
                break ;
            end
        end
    end
end

function UIBossView:SetSpringPanel(index)
    local maxIndex = self.mBossVoList.Count - 5;
    index = index > maxIndex and maxIndex or index;
    index = index < 0 and 0 or index;
    --local addY = index * self:GetUIGridContainer_UIGridContainer().CellHeight - self:GetUIGridContainer_UIGridContainer().CellHeight/2;
    local addY = index * self:GetUIGridContainer_UIGridContainer().CellHeight;
    local pos = self:GetScrollView().transform.localPosition;
    local targetPos = CS.UnityEngine.Vector3(pos.x, pos.y + addY, pos.z);
    self:TryStartDelayTimer(targetPos);
end

function UIBossView:TryStartDelayTimer(pos)
    if (self.mCoroutineDelayTimer ~= nil) then
        StopCoroutine(self.mCoroutineDelayTimer);
        self.mCoroutineDelayTimer = nil;
    end
    self.mCoroutineDelayTimer = StartCoroutine(self.CDelayTimer, self, pos);
end

function UIBossView:CDelayTimer(pos)
    coroutine.yield(0);
    coroutine.yield(0);
    coroutine.yield(0);
    coroutine.yield(0);
    --CS.NGUIAssist.GetWaitForSeconds(0.5)

    self:GetSpringPanel().target = pos;
    self:GetSpringPanel().enabled = true;
end

function UIBossView:Initialize()
    self.mScrollViewOriginY = self:GetScrollView().transform.localPosition.y;
end

function UIBossView:RemoveEvents()
    if (self.mCoroutineDelayTimer ~= nil) then
        StopCoroutine(self.mCoroutineDelayTimer);
        self.mCoroutineDelayTimer = nil;
    end
end

function UIBossView:Clear()
    self.mUIGridContainer_UIGridContainer = nil;
    self.mGoMapBtnViewTemplate_GameObject = nil;
    self.mGoMapBtnViewTemplate = nil;
    self.mBossUnitDic = nil;
    self.mSpringPanel = nil;
    self.mScrollView = nil;
end
--endregion

---@param panel UIBossPanel
function UIBossView:Init(panel)
    --luaDebug.LogError("UIBossView Init")
    self.mOwnerPanel = panel
    self:Initialize();
end

function UIBossView:OnDestruct()
    --luaDebug.Log("UIBossView OnDestruct")
    self:Clear();
end

return UIBossView;