---@class UIBettingDivisionPanel:UIBase
local UIBettingDivisionPanel = {};

---@type UIBettingDivisionPanel
local this = nil;

UIBettingDivisionPanel.mUnitDic = nil;

--region Components

function UIBettingDivisionPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIBettingDivisionPanel:GetFirstToggle_UIToggle()
    if (this.mFirstToggle_UIToggle == nil) then
        this.mFirstToggle_UIToggle = this:GetCurComp("WidgetRoot/BookMark/firstBtn", "UIToggle");
    end
    return this.mFirstToggle_UIToggle;
end

function UIBettingDivisionPanel:GetSecondToggle_UIToggle()
    if (this.mSecondToggle_UIToggle == nil) then
        this.mSecondToggle_UIToggle = this:GetCurComp("WidgetRoot/BookMark/secondBtn", "UIToggle");
    end
    return this.mSecondToggle_UIToggle;
end

function UIBettingDivisionPanel:GetGridContainer()
    if (this.mGridContainer == nil) then
        this.mGridContainer = this:GetCurComp("WidgetRoot/Panel/firstRightView/Scroll View/firstRightList", "UIGridContainer")
    end
    return this.mGridContainer;
end

function UIBettingDivisionPanel:GetGridLoopScrollViewPlus()
    if (this.mGridLoopScrollViewPlus == nil) then
        this.mGridLoopScrollViewPlus = this:GetCurComp("WidgetRoot/Panel/firstRightView/Scroll View/firstRightList", "UILoopScrollViewPlus")
    end
    return this.mGridLoopScrollViewPlus
end
--endregion

--region Method
--region Public
function UIBettingDivisionPanel:SelectWithSate(state)
    local playerStage = CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage;
    
    this:GetSecondToggle_UIToggle().gameObject:SetActive(playerStage == CS.BuDouKaiStage.SCEONDREST or playerStage == CS.BuDouKaiStage.SCEONDRESTOVER
            or playerStage == CS.BuDouKaiStage.FINAL or playerStage == CS.BuDouKaiStage.FINALOVERR);

    local lastTargetState = this.targetState
    this.targetState = CS.BuDouKaiStage.FRISTREST;
    if (state == CS.BuDouKaiStage.SCEONDREST) then
        this.targetState = CS.BuDouKaiStage.SCEONDREST;
        this:GetSecondToggle_UIToggle().isChecked = true;
        this:GetFirstToggle_UIToggle().isChecked = false;
    else
        this:GetFirstToggle_UIToggle().isChecked = true;
        this:GetSecondToggle_UIToggle().isChecked = false;
    end
    this:RefreshCurTargetStageBetList(lastTargetState == state)
    --this:UpdateUIWithState(targetState);
end

function UIBettingDivisionPanel:UpdateUIWithState(state)
    local list = CS.CSScene.MainPlayerInfo.BudowillInfo:GetPlayerInfoByType(state);
    local gridContainer = this:GetGridContainer();
    if (list == nil) then
        gridContainer.MaxCount = 0;
        return ;
    end
    if (this.mUnitDic == nil) then
        this.mUnitDic = {};
    end

    gridContainer.MaxCount = list.Count;
    for i = 0, list.Count - 1 do
        local gobj = gridContainer.controlList[i];
        if (this.mUnitDic[gobj] == nil) then
            this.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIBettingDivisionUnitTemplate, self);
        end
        this.mUnitDic[gobj]:UpdateUnit(list[i], state);
    end
end

---刷新押注玩家列表
---@param refreshCurPage table 押注玩家信息表
function UIBettingDivisionPanel:RefreshBetPlayerList(refreshCurPage)
    if this.betPlayerInfoTable ~= nil then
        if CS.StaticUtility.IsNull(this:GetGridLoopScrollViewPlus()) == false then
            if refreshCurPage == false then
                this:GetGridLoopScrollViewPlus():Init(function(go, line)
                    local info = this.betPlayerInfoTable[line + 1]
                    if info then
                        local playerBetTemplate
                        if type(this.playerBetTemplateTable) == 'table' and this.playerBetTemplateTable[go] ~= nil then
                            playerBetTemplate = this.playerBetTemplateTable[go]
                        else
                            playerBetTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBettingDivisionUnitTemplate, self)
                            if this.playerBetTemplateTable == nil then
                                this.playerBetTemplateTable = {}
                            end
                            this.playerBetTemplateTable[go] = playerBetTemplate
                        end
                        if playerBetTemplate then
                            playerBetTemplate:UpdateUnit(info)
                        end
                        return true
                    else
                        return false
                    end
                end)
            else
                this:GetGridLoopScrollViewPlus():RefreshCurrentPage()
            end
        end
    end
end

---刷新当前选择的列表
---@param 是否全部刷新 boolean
function UIBettingDivisionPanel:RefreshCurTargetStageBetList(refreshCurPage)
    this.betPlayerInfoTable = nil
    if this.targetState == nil then
        this.targetState = CS.BuDouKaiStage.FRISTREST;
    end
    local refreshCurStage = Utility.EnumToInt(this.targetState)
    this.betPlayerInfoTable = luaclass.BuDouKaiBetDataClass:GetBetPlayerList(refreshCurStage)
    if this.betPlayerInfoTable == nil then
        this.betPlayerInfoTable = {}
    end
    this:RefreshBetPlayerList(refreshCurPage)
end

---通过押注玩家信息刷新对应的玩家信息
---@param betPlayerInfo duplicateV2.BetPlayerInfo 押注玩家信息 lua table类型消息数据
function UIBettingDivisionPanel:RefreshSingleBetPlayerInfo(betPlayerInfo)
    if betPlayerInfo ~= nil and this.playerBetTemplateTable ~= nil and type(this.playerBetTemplateTable) == 'table' then
        for k, v in pairs(this.playerBetTemplateTable) do
            if v ~= nil and v.mPlayerData ~= nil and Utility.EnumToInt(this.targetState) == betPlayerInfo.stage and v.mState == betPlayerInfo.stage and v.mPlayerData.playerId == betPlayerInfo.playerId then
                v:UpdateUnit(betPlayerInfo)
                break
            end
        end
    end
end

---通过押注玩家信息列表刷新对应的玩家信息
---@param betPlayerInfoTable table 押注玩家信息表
function UIBettingDivisionPanel:RefreshBetPlayerInfoList(betPlayerInfoTable)
    if betPlayerInfoTable ~= nil and type(betPlayerInfoTable) == 'table' then
        for k, v in pairs(betPlayerInfoTable) do
            if v ~= nil then
                self:RefreshSingleBetPlayerInfo(v)
            end
        end
    end
end
--endregion

--region Private

function UIBettingDivisionPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIBettingDivisionPanel");
    end

    CS.UIEventListener.Get(this:GetFirstToggle_UIToggle().gameObject).onClick = function()
        this:SelectWithSate(CS.BuDouKaiStage.FRISTREST);
    end

    CS.UIEventListener.Get(this:GetSecondToggle_UIToggle().gameObject).onClick = function()
        this:SelectWithSate(CS.BuDouKaiStage.SCEONDREST);
    end

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BuDouKaiBetPlayerListRefresh, function(id, playerBetListTypeTable)
        if this.targetState == nil then
            this.targetState = CS.BuDouKaiStage.FRISTREST
        end

        local playerStage = CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage;

        this:GetSecondToggle_UIToggle().gameObject:SetActive(playerStage == CS.BuDouKaiStage.SCEONDREST or playerStage == CS.BuDouKaiStage.SCEONDRESTOVER
                or playerStage == CS.BuDouKaiStage.FINAL or playerStage == CS.BuDouKaiStage.FINALOVERR);

        for k, v in pairs(playerBetListTypeTable) do
            if v == Utility.EnumToInt(this.targetState) then
                this:RefreshCurTargetStageBetList(false)
            end
        end

        local selectPage = ternary(Utility.EnumToInt(playerStage) >= luaEnumBuDouKaiStage.SCEONDREST,CS.BuDouKaiStage.SCEONDREST,CS.BuDouKaiStage.FRISTREST)
        self:SelectWithSate(selectPage)
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BuDouKaiBetSinglePlayerRefresh, function(id, commonData)
        this:RefreshSingleBetPlayerInfo(commonData.curBetPlayerInfo)
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BuDouKaiBetPlayerTableRefresh, function(id, commonData)
        this:RefreshBetPlayerInfoList(commonData.refreshBetPlayerInfoTable)
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMapCommonMessage,function()
        if type(this.playerBetTemplateTable) ~= 'table' then
            return
        end
        for k,v in pairs(this.playerBetTemplateTable) do
            v:TryOpenBettingDialogPanel()
        end
    end)
end
--endregion

--endregion

function UIBettingDivisionPanel:Init()
    this = self;
    this:InitEvents();
end

function UIBettingDivisionPanel:Show()
    networkRequest.ReqDuboLookBet();
end

return UIBettingDivisionPanel;