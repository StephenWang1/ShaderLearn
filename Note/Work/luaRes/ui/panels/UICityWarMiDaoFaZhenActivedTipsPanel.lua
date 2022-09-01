local UICityWarMiDaoFaZhenActivedTipsPanel = {};

local this = nil;

function UICityWarMiDaoFaZhenActivedTipsPanel:GetFaZhenWarringTips_Text()
    if(this.mFaZhenActivedTips_Text == nil) then
        this.mFaZhenActivedTips_Text = this:GetCurComp("WidgetRoot/activedText","UILabel");
    end
    return this.mFaZhenActivedTips_Text;
end

function UICityWarMiDaoFaZhenActivedTipsPanel:GetFlagDieTips_GameObject()
    if(this.mFlagDieTips_GameObject == nil) then
        this.mFlagDieTips_GameObject = this:GetCurComp("WidgetRoot/DestroyStatuePrompt","GameObject");
    end
    return this.mFlagDieTips_GameObject;
end

--region Method

--region Public

function UICityWarMiDaoFaZhenActivedTipsPanel:UpdateFlagDieTips()
    this:TryStartFlagDieTimer();
end

function UICityWarMiDaoFaZhenActivedTipsPanel:UpdateMiDaoFaZhenWarringTips()
    this:TryStartWarringTimer();
end

function UICityWarMiDaoFaZhenActivedTipsPanel:TryStartWarringTimer()
    if(this.mCoroutineWarringTimer == nil) then
        this.mCoroutineWarringTimer = StartCoroutine(this.CWarringTipsTimer, this);
    end
end

function UICityWarMiDaoFaZhenActivedTipsPanel:TryStartFlagDieTimer()
    if(this.mCoroutineFlagDieTimer == nil) then
        this.mCoroutineFlagDieTimer = StartCoroutine(this.CFlagDieTipsTimer, this);
    end
end

--endregion

--region Private

function UICityWarMiDaoFaZhenActivedTipsPanel:CWarringTipsTimer()
    local configList = CS.Cfg_GlobalTableManager.Instance:GetShaBakMiDaoConfig();
    this.mCurrentTime = (configList ~= nil and configList.Count > 2) and configList[2] or 2000;
    this:GetFaZhenWarringTips_Text().text = "皇宫法阵激活中: "..math.floor(this.mCurrentTime / 1000).."秒";
    this:GetFaZhenWarringTips_Text().gameObject:SetActive(true);
    while(this.mCurrentTime >= 0) do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
        this.mCurrentTime = this.mCurrentTime - 1000;
        this:GetFaZhenWarringTips_Text().text = "皇宫法阵激活中: "..math.floor(this.mCurrentTime / 1000).."秒";
    end
    this.mCurrentTime = 0;
    this:GetFaZhenWarringTips_Text().text = "皇宫法阵激活中: "..math.floor(this.mCurrentTime / 1000).."秒";
    this:GetFaZhenWarringTips_Text().gameObject:SetActive(false);
    this.mCoroutineWarringTimer = nil;
    this:CheckIsCloseSelf();
end

function UICityWarMiDaoFaZhenActivedTipsPanel:CFlagDieTipsTimer()
    local maxTime = 3;
    this:GetFlagDieTips_GameObject():SetActive(true);
    while(maxTime >= 0) do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
        maxTime = maxTime - 1;
    end
    this:GetFlagDieTips_GameObject():SetActive(false);
    this.mCoroutineFlagDieTimer = nil;
    this:CheckIsCloseSelf();
end

function UICityWarMiDaoFaZhenActivedTipsPanel:CheckIsCloseSelf()
    local isWarringTipsActive = this:GetFaZhenWarringTips_Text().gameObject.activeSelf;
    local isFlagDieTipsActive = this:GetFlagDieTips_GameObject().activeSelf;

    if(not isFlagDieTipsActive and not isWarringTipsActive) then
        uimanager:ClosePanel("UICityWarMiDaoFaZhenActivedTipsPanel");
    end
end

function UICityWarMiDaoFaZhenActivedTipsPanel:RemoveEvents()
    if(this.mCoroutineWarringTimer ~= nil) then
        StopCoroutine(this.mCoroutineWarringTimer);
        this.mCoroutineWarringTimer = nil;
    end

    if(this.mCoroutineFlagDieTimer ~= nil) then
        StopCoroutine(this.mCoroutineFlagDieTimer);
        this.mCoroutineFlagDieTimer = nil;
    end
end

--endregion

--endregion

function UICityWarMiDaoFaZhenActivedTipsPanel:Init()
    this = self;
end

function UICityWarMiDaoFaZhenActivedTipsPanel:Show(customData)
    if(customData ~= nil) then
        if(customData.type ~= nil) then
            if(customData.type == luaEnumShaBakTipsType.FlagDie) then
                this:UpdateFlagDieTips();
            elseif(customData.type == luaEnumShaBakTipsType.MiDaoFaZhenWarring) then
                this:UpdateMiDaoFaZhenWarringTips();
            end
        end
    end
end

function ondestroy()
    this:RemoveEvents();

    this = nil;
end

return UICityWarMiDaoFaZhenActivedTipsPanel;