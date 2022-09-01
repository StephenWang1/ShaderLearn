local UICityWarMiDaoFaZhenPanel = {}

local this = nil;

--region Components

function UICityWarMiDaoFaZhenPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/CloseBtn", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UICityWarMiDaoFaZhenPanel:GetBtnActive_GameObject()
    if(this.mBtnActive_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/ActivateBtn","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UICityWarMiDaoFaZhenPanel:GetBtnActiveBg_UISprite()
    if(this.mBtnActiveBg_UISprite == nil) then
        this.mBtnActiveBg_UISprite = this:GetCurComp("WidgetRoot/ActivateBtn/Background","UISprite");
    end
    return this.mBtnActiveBg_UISprite;
end

--function UICityWarMiDaoFaZhenPanel:GetBtnActive_BoxCollider()
--    if(this.mBtnActive_BoxCollider == nil) then
--        this.mBtnActive_BoxCollider = this:GetCurComp("WidgetRoot/ActivateBtn","BoxCollider");
--    end
--    return this.mBtnActive_BoxCollider;
--end

function UICityWarMiDaoFaZhenPanel:GetGridContainer()
    if(this.mGridContainer == nil) then
        this.mGridContainer = this:GetCurComp("WidgetRoot/introduce/labelGroup/activate","UIGridContainer");
    end
    return this.mGridContainer;
end

function UICityWarMiDaoFaZhenPanel:GetUITimer()
    if(this.mUITimer == nil) then
        this.mUITimer = this:GetCurComp("WidgetRoot/introduce/labelGroup/lb_ActivateTime","UITimer");
    end
    return this.mUITimer;
end

--endregion

--region Method

--region Public

function UICityWarMiDaoFaZhenPanel:UpdateUI()
    if(this.mUnitDic == nil) then
        this.mUnitDic = {};
    end
    local LastTacticsActivedTime = CS.CSScene.MainPlayerInfo.DuplicateV2.LastTacticsActivedTime;
    local interval = this:GetRemainCDTime();
    if(LastTacticsActivedTime ~= 0 and interval > 0) then
        this:GetBtnActiveBg_UISprite().color = CS.UnityEngine.Color.black;
        --this:GetBtnActive_BoxCollider().enabled = false;
        this:GetUITimer():StartTimer(interval,function()
            this:GetBtnActiveBg_UISprite().color = CS.UnityEngine.Color.white;
            this:GetUITimer().mTimeText.text = luaEnumColorType.Green.."可激活[-]";
            --this:GetBtnActive_BoxCollider().enabled = true;
        end,function()
            return this:GetRemainCDTime();
        end);
    else
        this:GetBtnActiveBg_UISprite().color = CS.UnityEngine.Color.white;
        this:GetUITimer().mTimeText.text = luaEnumColorType.Green.."可激活[-]";
        --this:GetBtnActive_BoxCollider().enabled = true;
    end
    local configDic = CS.Cfg_GlobalTableManager.Instance:GetShaBakSkillConfig();
    if(configDic ~= nil) then
        local gridContainer = this:GetGridContainer();
        gridContainer.MaxCount = configDic.Count;
        local index = 0;
        for k,v in pairs(configDic) do
            local gobj = gridContainer.controlList[index];
            if(this.mUnitDic[gobj] == nil) then
                this.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj,luaComponentTemplates.UICityWarMiDaoSkillDesUnitTemplate);
            end
            this.mUnitDic[gobj]:UpdateUnit(v);
            index = index + 1;
        end
    end
end

function UICityWarMiDaoFaZhenPanel:GetRemainCDTime()
    local LastTacticsActivedTime = CS.CSScene.MainPlayerInfo.DuplicateV2.LastTacticsActivedTime;
    local configList = CS.Cfg_GlobalTableManager.Instance:GetShaBakMiDaoConfig();
    local cdTime = (configList ~= nil and configList.Count > 1) and configList[1] or 0;
    local interval = cdTime * 1000 - (CS.CSServerTime.Instance.TotalMillisecond - LastTacticsActivedTime);
    return interval;
end

--endregion

--region Private

function UICityWarMiDaoFaZhenPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarMiDaoFaZhenPanel");
    end

    CS.UIEventListener.Get(this:GetBtnActive_GameObject()).onClick = function()
        if(not Utility.IsOpenShaBaKe()) then
            return Utility.ShowPopoTips(this:GetBtnActive_GameObject(), nil, 261, "UICityWarMiDaoFaZhenPanel");
        elseif(CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0) then
            return Utility.ShowPopoTips(this:GetBtnActive_GameObject(), nil, 259, "UICityWarMiDaoFaZhenPanel");
        elseif(CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0) then
            return Utility.ShowPopoTips(this:GetBtnActive_GameObject(), nil, 259, "UICityWarMiDaoFaZhenPanel");
        elseif(this:GetRemainCDTime() > 0) then
            return Utility.ShowPopoTips(this:GetBtnActive_GameObject(), nil, 260, "UICityWarMiDaoFaZhenPanel");
        end
        networkRequest.ReqStartSabacTactics();
        uimanager:ClosePanel("UICityWarMiDaoFaZhenPanel");
    end
end

function UICityWarMiDaoFaZhenPanel:RemoveEvents()

end

--endregion

--endregion

function UICityWarMiDaoFaZhenPanel:Init()
    this = self;

    this:InitEvents();
end

function UICityWarMiDaoFaZhenPanel:Show(customData)
    this:UpdateUI();
end

function ondestroy()
    this:RemoveEvents();

    this = nil;
end

return UICityWarMiDaoFaZhenPanel;