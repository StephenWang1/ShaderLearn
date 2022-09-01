---@class UIGuildPalaceLeftMainPanel:UIBase 行会地宫左侧面板
local UIGuildPalaceLeftMainPanel = {}

function UIGuildPalaceLeftMainPanel:InitComponents()

    ---Top_TweenPosition
    self.tween = self:GetCurComp('WidgetRoot/Tween', 'Top_TweenPosition')
    ---倒计时
    self.Time = self:GetCurComp('WidgetRoot/Tween/view/Time', 'UICountdownLabel')
    ---行会地宫名称
    self.lb_name = self:GetCurComp('WidgetRoot/Tween/view/lb_name', 'UILabel')
    ---剩余怪物数量
    self.monsterNum = self:GetCurComp('WidgetRoot/Tween/view/monsterNum', 'UILabel')
    ---下层入口状态
    self.nextenterValue = self:GetCurComp('WidgetRoot/Tween/view/nextenter/nextenterValue', 'UILabel')

    ---@type UnityEngine.GameObject 下一层GO
    self.nextenterGO = self:GetCurComp('WidgetRoot/Tween/view/nextenter', 'GameObject')

    ---帮助按钮
    self.btn_help = self:GetCurComp('WidgetRoot/Tween/events/btn_help', 'Top_UISprite')
    ---缩进按钮
    self.BtnHide = self:GetCurComp('WidgetRoot/Tween/events/BtnHide', 'GameObject')
    ---退出
    self.btn_sure = self:GetCurComp('WidgetRoot/Tween/events/btn_sure', 'GameObject')
    ---进入下一层
    self.btn_EnterLower = self:GetCurComp('WidgetRoot/Tween/events/btn_EnterLower', 'GameObject')


end
function UIGuildPalaceLeftMainPanel:InitOther()
    UIGuildPalaceLeftMainPanel.showTips_bool = true
    ---点击帮助按钮
    CS.UIEventListener.Get(self.btn_help.gameObject).onClick = self.OnClickBtn_help
    ---点击缩进按钮
    CS.UIEventListener.Get(self.BtnHide.gameObject).onClick = self.OnClickBtnHide
    ---点击退出按钮
    CS.UIEventListener.Get(self.btn_sure.gameObject).onClick = self.OnClickBtn_sure
    ---进入下一层
    CS.UIEventListener.Get(self.btn_EnterLower.gameObject).onClick = self.OnClickBtn_EnterLower

    UIGuildPalaceLeftMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUndergroundDuplicateInfoMessage, UIGuildPalaceLeftMainPanel.OnResUndergroundDuplicateInfoMessage)
    UIGuildPalaceLeftMainPanel:GetClientEventHandler():AddEvent(CS.CEvent.Scene_EnterSceneAfter,
            function()
                self:RefresBtnInfo()
            end)
    self:RefresBtnInfo();
end

function UIGuildPalaceLeftMainPanel:Init()
    self:InitComponents()
    self:InitOther()
    self:RefreshUI()
end

function UIGuildPalaceLeftMainPanel:RefreshUI()
    Utility.RemoveFlashPrompt(1, 35)
    UIGuildPalaceLeftMainPanel.monsterNum.text = ""
    UIGuildPalaceLeftMainPanel.nextenterValue.text = ""
    UIGuildPalaceLeftMainPanel.RefeshTime()
end

function UIGuildPalaceLeftMainPanel.RefeshTime()
    UIGuildPalaceLeftMainPanel.SurplusTime = Utility.GetActivitySurplusTime(Utility.GetNowGuildDungeonAtciveID())
    UIGuildPalaceLeftMainPanel.Time:StartCountDown(nil, 7, UIGuildPalaceLeftMainPanel.SurplusTime, "", "")
end

function UIGuildPalaceLeftMainPanel:RefresBtnInfo()
    local currentMapId = CS.CSScene:getMapID()
    local endMap = currentMapId == tonumber(LuaGlobalTableDeal:GetUnionDungeonEndMapID())
    self.btn_EnterLower.gameObject:SetActive(not endMap)
    if endMap then
        self.btn_sure.transform.localPosition = CS.UnityEngine.Vector3(-525, 29, 0);
    else
        self.btn_sure.transform.localPosition = CS.UnityEngine.Vector3(-586, 29, 0);
    end
    local isFind, MapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(CS.CSScene:getMapID())
    if isFind then
        self.lb_name.text = MapInfo.name
        self.btn_help:UpdateAnchors()
    end


    --刷新剩余怪物和下层入口显示（第一层不显示剩余怪物,最后一层不显示下层入口）
    local startMap = false
    local startMapId = LuaGlobalTableDeal:GetUnionDungeonStartMapID()
    if startMapId then
        startMap = currentMapId == startMapId
    end
    self.monsterNum.gameObject:SetActive(not startMap)
    self.nextenterGO:SetActive(not endMap)

    local posMonsterNumPos = self.monsterNum.gameObject.transform.localPosition
    posMonsterNumPos.y = endMap and 103 or 120
    self.monsterNum.gameObject.transform.localPosition = posMonsterNumPos

    local posNextenterGO = self.nextenterGO.transform.localPosition
    posNextenterGO.y = startMap and 103 or 87
    self.nextenterGO.transform.localPosition = posNextenterGO
end

---帮助按钮
function UIGuildPalaceLeftMainPanel.OnClickBtn_help()
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(175)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

---缩进按钮
function UIGuildPalaceLeftMainPanel.OnClickBtnHide()
    UIGuildPalaceLeftMainPanel.tween:SetOnFinished(UIGuildPalaceLeftMainPanel.ClinkHideBtnCallBack)
    if UIGuildPalaceLeftMainPanel.showTips_bool then
        UIGuildPalaceLeftMainPanel.tween:PlayForward()
        UIGuildPalaceLeftMainPanel.showTips_bool = false
    else
        UIGuildPalaceLeftMainPanel.tween:PlayReverse()
        UIGuildPalaceLeftMainPanel.showTips_bool = true
    end
end
---缩进回调
function UIGuildPalaceLeftMainPanel.ClinkHideBtnCallBack(go)
    local v3 = CS.UnityEngine.Vector3.zero
    if not UIGuildPalaceLeftMainPanel.showTips_bool then
        v3.z = 180
    end
    UIGuildPalaceLeftMainPanel.BtnHide.transform.localEulerAngles = v3
end

---退出按钮
function UIGuildPalaceLeftMainPanel.OnClickBtn_sure()
    Utility.ReqExitDuplicate()
end

---进入下一层
function UIGuildPalaceLeftMainPanel.OnClickBtn_EnterLower()
    local nowData = clientTableManager.cfg_map_eventsManager:GetGuildTypeMap_EventTbl()
    if nowData == nil or nowData.list == nil or nowData.list.Count ~= 3 then
        return
    end
    local temp = CS.SFMiscBase.Dot2(nowData.list[1], nowData.list[2])
    local isfind = CS.CSPathFinderManager.Instance:SetFixedDestination(nowData.list[0], temp, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardPoint)
    --CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(120013)
end

function UIGuildPalaceLeftMainPanel.OnResUndergroundDuplicateInfoMessage(id, data)
    if data == nil then
        return
    end
    local color = "[e85038]"
    local start = "消灭剩余怪物开启"
    if data.monsterLiveLeft == 0 then
        color = "[00ff00]"
        start = "开启"
    end
    UIGuildPalaceLeftMainPanel.monsterNum.text = color .. data.monsterLiveLeft
    UIGuildPalaceLeftMainPanel.nextenterValue.text = color .. start
end

---得到剩余时间
function UIGuildPalaceLeftMainPanel.GetSurplusTime(activeID)
    local TodayTimeStamp = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    local activityTbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activeID)
    if activityTbl then
        local endTime = activityTbl:GetOverTime()
        return TodayTimeStamp + endTime * 60 * 1000
    end
    return TodayTimeStamp
end


return UIGuildPalaceLeftMainPanel