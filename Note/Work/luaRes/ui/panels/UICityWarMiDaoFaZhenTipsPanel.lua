local UICityWarMiDaoFaZhenTipsPanel = {}

local this = nil;

UICityWarMiDaoFaZhenTipsPanel.mFaZhenState = nil;

--region Components

function UICityWarMiDaoFaZhenTipsPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/CloseBtn","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UICityWarMiDaoFaZhenTipsPanel:GetTime_Text()
    if(this.mTime_Text == nil) then
        this.mTime_Text = this:GetCurComp("WidgetRoot/view/lab_time","UILabel");
    end
    return this.mTime_Text;
end

function UICityWarMiDaoFaZhenTipsPanel:GetGridContainer()
    if(this.mGridContainer == nil) then
        this.mGridContainer = this:GetCurComp("WidgetRoot/Scroll View/ActivateList","UIGridContainer");
    end
    return this.mGridContainer;
end

--endregion

--region Method

--region Public

function UICityWarMiDaoFaZhenTipsPanel:TryStartTimer()
    if(this.mCoroutineTimer == nil) then
        this.mCoroutineTimer = StartCoroutine(this.CTimer);
    end
end

function UICityWarMiDaoFaZhenTipsPanel:UpdateUI()
    if(this.mFaZhenState ~= nil) then
        this.mTacticsEndTime = this.mFaZhenState.tacticsEndTime;
        this:TryStartTimer();

        if(this.mUnitDic == nil) then
            this.mUnitDic = {};
        end
        local gridContainer = this:GetGridContainer();
        if(this.mFaZhenState.tactics ~= nil) then
            local configDic = CS.Cfg_GlobalTableManager.Instance:GetShaBakSkillConfig();
            if(configDic ~= nil) then
                gridContainer.MaxCount = this.mFaZhenState.tactics.Count;
                local config = configDic[this.mFaZhenState.tactics.Count];
                if(config ~= nil) then
                    for i = 0, gridContainer.MaxCount - 1 do
                        local gobj = gridContainer.controlList[i];
                        if(this.mUnitDic[gobj] == nil) then
                            this.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICityWarMiDaoFaZhenTipsUnitTemplate);
                        end
                        this.mUnitDic[gobj]:UpdateUnit(this.mFaZhenState.tactics[i], config);
                    end
                end
            end
        end
    end
end

--endregion

--region Private

function UICityWarMiDaoFaZhenTipsPanel:CTimer()
    local list = CS.Cfg_GlobalTableManager.Instance:GetShaBakMiDaoConfig();
    this.mCurrentTime = (list ~= nil and list.Count > 1) and list[0] or 60;
    this:GetTime_Text().text = tostring(this.mCurrentTime);
    while(this.mCurrentTime > 0) do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
        this.mCurrentTime = this.mCurrentTime - 1;
        this:GetTime_Text().text = tostring(this.mCurrentTime);
    end
    this.mCurrentTime = 0;
    uimanager:ClosePanel("UICityWarMiDaoFaZhenTipsPanel");
    this.mCoroutineTimer = nil;
end

function UICityWarMiDaoFaZhenTipsPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarMiDaoFaZhenTipsPanel");
    end
end

function UICityWarMiDaoFaZhenTipsPanel:RemoveEvents()
    if(this.mCoroutineTimer ~= nil) then
        StopCoroutine(this.mCoroutineTimer);
    end
    this.mCoroutineTimer = nil;
end

--endregion

--endregion

function UICityWarMiDaoFaZhenTipsPanel:Init()
    this = self;

    this:InitEvents();
end

function UICityWarMiDaoFaZhenTipsPanel:Show(customData)
    this.mFaZhenState = customData.faZhenState;
    this:UpdateUI();
end

function ondestroy()
    this:RemoveEvents();

    this = nil;
end

return UICityWarMiDaoFaZhenTipsPanel;