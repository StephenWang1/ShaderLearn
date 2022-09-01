---@class UIRechargeFirstSloganTipsPanel
local UIRechargeFirstSloganTipsPanel = {}

--region 变量
UIRechargeFirstSloganTipsPanel.mPushType = 0
UIRechargeFirstSloganTipsPanel.mNewPushTime = 0
UIRechargeFirstSloganTipsPanel.mPushTime = 0
UIRechargeFirstSloganTipsPanel.mReFreshBool = false
UIRechargeFirstSloganTipsPanel.mReFreshPos = false
UIRechargeFirstSloganTipsPanel.mReFreshState = false


UIRechargeFirstSloganTipsPanel.CountDown = nil
--endregion

--region 组件
function UIRechargeFirstSloganTipsPanel:GetTips_GameObject()
    if (self.mTipsGo == nil) then
        self.mTipsGo = self:GetCurComp("WidgetRoot/Tip", "GameObject")
    end
    return self.mTipsGo
end

function UIRechargeFirstSloganTipsPanel:GetBG_GameObject()
    if (self.mBG_Go == nil) then
        self.mBG_Go = self:GetCurComp("WidgetRoot/Tip/bg", "GameObject")
    end
    return self.mBG_Go
end

function UIRechargeFirstSloganTipsPanel:GetBG_UISprite()
    if (self.mBG_UISprite == nil) then
        self.mBG_UISprite = self:GetCurComp("WidgetRoot/Tip/bg", "Top_UISprite")
    end
    return self.mBG_UISprite
end

function UIRechargeFirstSloganTipsPanel:GetRes1()
    if (self.mRes1 == nil) then
        self.mRes1 = self:GetCurComp("WidgetRoot/Tip/res1", "CSUIEffectLoad")
    end
    return self.mRes1
end

function UIRechargeFirstSloganTipsPanel:GetRes2()
    if (self.mRes2 == nil) then
        self.mRes2 = self:GetCurComp("WidgetRoot/Tip/res2", "CSUIEffectLoad")
    end
    return self.mRes2
end

function UIRechargeFirstSloganTipsPanel:GetTime_Go()
    if (self.mTime_Go == nil) then
        self.mTime_Go = self:GetCurComp("WidgetRoot/Tip/Time", "GameObject")
    end
    return self.mTime_Go
end

function UIRechargeFirstSloganTipsPanel:GetTime_UICountdownLabel()
    if (self.mTime_UICountdownLabel == nil) then
        self.mTime_UICountdownLabel = self:GetCurComp("WidgetRoot/Tip/Time", "UICountdownLabel")
    end
    return self.mTime_UICountdownLabel
end

function UIRechargeFirstSloganTipsPanel:GetActivitiesPanel()
    if (self.mActivitiesPanel == nil) then
        self.mActivitiesPanel = uimanager:GetPanel("UIActivitiesPanel")
    end
    return self.mActivitiesPanel
end

function UIRechargeFirstSloganTipsPanel:GetTween_TweenPosition()
    if (self.mTweenPos == nil) then
        self.mTweenPos = self:GetCurComp("WidgetRoot/Tip", "Top_TweenPosition")
    end
    return self.mTweenPos
end

---@return TweenScale
function UIRechargeFirstSloganTipsPanel:GetTween_TweenScale()
    if (self.mTween_TweenScale == nil) then
        self.mTween_TweenScale = self:GetCurComp("WidgetRoot/Tip", "Top_TweenScale")
    end
    return self.mTween_TweenScale
end
--endregion

function UIRechargeFirstSloganTipsPanel:Init()
    UIRechargeFirstSloganTipsPanel.Self = self
    self:InitVariable()
    UIRechargeFirstSloganTipsPanel:BindMessage()
    UIRechargeFirstSloganTipsPanel:BindUIEvent()
end

function UIRechargeFirstSloganTipsPanel:InitVariable()
    self.CurrentTextureType = 1
    self.resConfig = string.SplitGlobalStrToIntListList(23009,'&','#')
    local TotalTimeIsFind, TotalTimeCfg = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23010)
    if TotalTimeIsFind then
        self.RefreshTime = tonumber(TotalTimeCfg.value)/10000
    end
end

function UIRechargeFirstSloganTipsPanel:InitIEnum()
    if (self.IEnumTime == nil) then
        self.IEnumTime = StartCoroutine(UIRechargeFirstSloganTipsPanel.IEnumTimeFun, CS.Cfg_GlobalTableManager.Instance.FirstPushTime)
    end
end

function UIRechargeFirstSloganTipsPanel:BindMessage()
    UIRechargeFirstSloganTipsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ActivityTween, UIRechargeFirstSloganTipsPanel.RefreshPos)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnOpenFinished, UIRechargeFirstSloganTipsPanel.OnHidePanel)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnCloseFinished, UIRechargeFirstSloganTipsPanel.ReShowPanel)
end

function UIRechargeFirstSloganTipsPanel:BindUIEvent()
    CS.UIEventListener.Get(UIRechargeFirstSloganTipsPanel:GetBG_GameObject()).onClick = UIRechargeFirstSloganTipsPanel.BGOnClick
end

function UIRechargeFirstSloganTipsPanel:Show(type, endTime)
    if self:AnalysisParams(type,endTime) == false then
        luaclass.UIRefresh:RefreshActive(self:GetTips_GameObject(),false)
        return
    end
    luaclass.UIRefresh:RefreshActive(self:GetTips_GameObject(),true)
    ---新服优势
    if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge()) then
        self:HidePanel()
        return
    end
    if (type == LuaEnumFirstRechargePushType.NewServerPush) then
        UIRechargeFirstSloganTipsPanel.mNewPushTime = endTime
        if (UIRechargeFirstSloganTipsPanel.mPushType ~= LuaEnumFirstRechargePushType.FirstRechargePush) then
            UIRechargeFirstSloganTipsPanel.mPushType = type
            UIRechargeFirstSloganTipsPanel.mPushTime = endTime
            UIRechargeFirstSloganTipsPanel:GetTween_TweenPosition().enabled = false
        else
            return
        end
        ---首充推荐
    elseif (type == LuaEnumFirstRechargePushType.FirstRechargePush) then
        UIRechargeFirstSloganTipsPanel.mPushType = type
        UIRechargeFirstSloganTipsPanel.mPushTime = endTime
        UIRechargeFirstSloganTipsPanel:GetTween_TweenPosition().enabled = true
        UIRechargeFirstSloganTipsPanel:InitIEnum()
    end
    if (UIRechargeFirstSloganTipsPanel:GetActivitiesPanel() ~= nil and UIRechargeFirstSloganTipsPanel:GetActivitiesPanel().GetFirstRechargeOut_Transform() ~= nil) then
        if (UIRechargeFirstSloganTipsPanel:GetActivitiesPanel().UIActivitiesPanelState) then
            self.RefreshPos(0, UIRechargeFirstSloganTipsPanel:GetActivitiesPanel().GetFirstRechargeOut_Transform().position, UIRechargeFirstSloganTipsPanel:GetActivitiesPanel().UIActivitiesPanelState)
        else
            if (UIRechargeFirstSloganTipsPanel:GetActivitiesPanel().mFirstRechargeTrans ~= nil) then
                self.RefreshPos(0, UIRechargeFirstSloganTipsPanel:GetActivitiesPanel().mFirstRechargeTrans.position, UIRechargeFirstSloganTipsPanel:GetActivitiesPanel().UIActivitiesPanelState)
            end
        end
    else
        self.go:SetActive(false)
        --self:HidePanel()
    end
    UIRechargeFirstSloganTipsPanel.RefreshBG(UIRechargeFirstSloganTipsPanel.mPushType)
    
    if UIRechargeFirstSloganTipsPanel.CountDown == nil then
        UIRechargeFirstSloganTipsPanel.CountDown = StartCoroutine(UIRechargeFirstSloganTipsPanel.CountDownFun)
    end
end

---解析参数
---@return boolean 解析状态
function UIRechargeFirstSloganTipsPanel:AnalysisParams(type, endTime)
    if type == nil or endTime == nil then
        return false
    end
    return true
end

function update()
    if (UIRechargeFirstSloganTipsPanel.mReFreshBool) then
        --UIRechargeFirstSloganTipsPanel:GetBG_GameObject():SetActive(UIRechargeFirstSloganTipsPanel.mReFreshState)
        UIRechargeFirstSloganTipsPanel.go.transform.position = UIRechargeFirstSloganTipsPanel.mReFreshPos
        UIRechargeFirstSloganTipsPanel.mReFreshBool = false
    end
end

function UIRechargeFirstSloganTipsPanel.BGOnClick(go)
    --uimanager:CreatePanel("UIRechargeFirstTips")
    local CurResCfg = UIRechargeFirstSloganTipsPanel.resConfig[UIRechargeFirstSloganTipsPanel.CurrentTextureType - 1]
    if CurResCfg ~= nil then
        uiTransferManager:TransferToPanel(CurResCfg[1])
    end

    if (UIRechargeFirstSloganTipsPanel.mPushType == LuaEnumFirstRechargePushType.FirstRechargePush) then
        if (UIRechargeFirstSloganTipsPanel.mNewPushTime ~= 0) then
            UIRechargeFirstSloganTipsPanel.mPushType = LuaEnumFirstRechargePushType.NewServerPush
            UIRechargeFirstSloganTipsPanel:Show(LuaEnumFirstRechargePushType.NewServerPush, UIRechargeFirstSloganTipsPanel.mNewPushTime)
            return
        end
        UIRechargeFirstSloganTipsPanel:HidePanel()
    end
end

function UIRechargeFirstSloganTipsPanel.RefreshPos(id, pos, bool)
    if (pos == CS.UnityEngine.Vector3.zero) then
        UIRechargeFirstSloganTipsPanel:HidePanel()
    else
        UIRechargeFirstSloganTipsPanel.go:SetActive(true)
        UIRechargeFirstSloganTipsPanel.mReFreshBool = true
        UIRechargeFirstSloganTipsPanel.mReFreshPos = pos + CS.UnityEngine.Vector3(-0.09, 0.02, 0)
        UIRechargeFirstSloganTipsPanel.mReFreshState = bool
    end
end

function UIRechargeFirstSloganTipsPanel.RefreshBG(type)
    if (type == LuaEnumFirstRechargePushType.NewServerPush) then
        UIRechargeFirstSloganTipsPanel:GetBG_UISprite().spriteName = "RechargeFirst_slogan1"
        UIRechargeFirstSloganTipsPanel:GetTime_Go():SetActive(true)
        if (UIRechargeFirstSloganTipsPanel.mPushTime ~= 0) then
            UIRechargeFirstSloganTipsPanel:GetTime_UICountdownLabel():StartCountDown(nil, 6, UIRechargeFirstSloganTipsPanel.mPushTime, nil, nil, nil, function()
                UIRechargeFirstSloganTipsPanel.OverDelayTime()
            end)
        end
    elseif (type == LuaEnumFirstRechargePushType.FirstRechargePush) then
        UIRechargeFirstSloganTipsPanel:GetBG_UISprite().spriteName = "RechargeFirst_slogan1"
        UIRechargeFirstSloganTipsPanel:GetTime_Go():SetActive(false)
    end
    UIRechargeFirstSloganTipsPanel:GetBG_UISprite():MakePixelPerfect()
end

function UIRechargeFirstSloganTipsPanel.IEnumTimeFun(time)
    local meetTime = true
    local totalTime = time * 0.001
    while meetTime do
        if totalTime <= 0 then
            meetTime = false
            if (UIRechargeFirstSloganTipsPanel.IEnumTime ~= nil) then
                StopCoroutine(UIRechargeFirstSloganTipsPanel.IEnumTime)
                UIRechargeFirstSloganTipsPanel.IEnumTime = nil
            end
            if (UIRechargeFirstSloganTipsPanel.mPushType == LuaEnumFirstRechargePushType.FirstRechargePush) then
                if (UIRechargeFirstSloganTipsPanel.mNewPushTime ~= 0) then
                    UIRechargeFirstSloganTipsPanel.mPushType = LuaEnumFirstRechargePushType.NewServerPush
                    UIRechargeFirstSloganTipsPanel:Show(LuaEnumFirstRechargePushType.NewServerPush, UIRechargeFirstSloganTipsPanel.mNewPushTime)
                    return
                end
            end
            UIRechargeFirstSloganTipsPanel:HidePanel()
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        totalTime = totalTime - 1
    end
end

function UIRechargeFirstSloganTipsPanel.CountDownFun()
    while true do
        --coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(UIRechargeFirstSloganTipsPanel.RefreshTime))
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(5))
        UIRechargeFirstSloganTipsPanel.Self:ChangeShowTexture()
    end
end

function UIRechargeFirstSloganTipsPanel:ChangeShowTexture()
    if UIRechargeFirstSloganTipsPanel.Self.CurrentTextureType > #UIRechargeFirstSloganTipsPanel.Self.resConfig then
        UIRechargeFirstSloganTipsPanel.Self.CurrentTextureType = 1
    end
    UIRechargeFirstSloganTipsPanel.Self:GetRes1():ChangeEffect(nil)
    UIRechargeFirstSloganTipsPanel.Self:GetRes2():ChangeEffect(nil)
    local CurResCfg = UIRechargeFirstSloganTipsPanel.Self.resConfig[UIRechargeFirstSloganTipsPanel.Self.CurrentTextureType]
    if CurResCfg == nil then
        return
    end
    if CurResCfg[2] ~= nil then
        UIRechargeFirstSloganTipsPanel.Self:GetRes1():ChangeEffect(CurResCfg[2])
        UIRechargeFirstSloganTipsPanel.Self:GetRes1().enabled = true
        if CurResCfg[4] ~= nil and CurResCfg[5] ~= nil then
            local res1Position = CS.UnityEngine.Vector3(tonumber(CurResCfg[4]),tonumber(CurResCfg[5]))
            if res1Position ~= nil then
                UIRechargeFirstSloganTipsPanel.Self:GetRes1().transform.localPosition = res1Position
            end
        end
    end
    if CurResCfg[3] ~= nil then
        UIRechargeFirstSloganTipsPanel.Self:GetRes2():ChangeEffect(CurResCfg[3])
        UIRechargeFirstSloganTipsPanel.Self:GetRes2().enabled = true
    end
    UIRechargeFirstSloganTipsPanel.Self.CurrentTextureType = UIRechargeFirstSloganTipsPanel.Self.CurrentTextureType + 1
end

function UIRechargeFirstSloganTipsPanel.OnHidePanel()
    UIRechargeFirstSloganTipsPanel:GetBG_GameObject():SetActive(false)
end

function UIRechargeFirstSloganTipsPanel:PlayScaleTween()
    self:GetTween_TweenScale():PlayTween()
end

function UIRechargeFirstSloganTipsPanel.ReShowPanel()
    UIRechargeFirstSloganTipsPanel:GetBG_GameObject():SetActive(true)
end

function UIRechargeFirstSloganTipsPanel.OverDelayTime()
    if (UIRechargeFirstSloganTipsPanel.mPushType == LuaEnumFirstRechargePushType.FirstRechargePush) then
        if (UIRechargeFirstSloganTipsPanel.mNewPushTime ~= 0) then
            UIRechargeFirstSloganTipsPanel.mPushType = LuaEnumFirstRechargePushType.NewServerPush
            UIRechargeFirstSloganTipsPanel:Show(LuaEnumFirstRechargePushType.NewServerPush, UIRechargeFirstSloganTipsPanel.mNewPushTime)
            return
        end
    end
    UIRechargeFirstSloganTipsPanel:HidePanel()
end

---隐藏面板（作为常驻面板）
function UIRechargeFirstSloganTipsPanel:HidePanel()
    luaclass.UIRefresh:RefreshActive(self:GetTips_GameObject(),false)
end

function ondestroy()
    if (UIRechargeFirstSloganTipsPanel.IEnumTime ~= nil) then
        StopCoroutine(UIRechargeFirstSloganTipsPanel.IEnumTime)
        UIRechargeFirstSloganTipsPanel.IEnumTime = nil
    end
    if (UIRechargeFirstSloganTipsPanel.CountDown ~= nil) then
        StopCoroutine(UIRechargeFirstSloganTipsPanel.CountDown);
        UIRechargeFirstSloganTipsPanel.CountDown = nil;
    end
end

return UIRechargeFirstSloganTipsPanel