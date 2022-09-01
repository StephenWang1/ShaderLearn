---@class UIDefendKingRankPanel:UIBase 保卫国王左侧面板
local UIDefendKingRankPanel = {}

--region 局部变量
UIDefendKingRankPanel.isShow = true
UIDefendKingRankPanel.IEnumRefreshTime = nil
--endregion

--region 初始化

function UIDefendKingRankPanel:Init()
    self:InitComponents()
    UIDefendKingRankPanel.BindUIEvents()
    UIDefendKingRankPanel.BindNetMessage()
    UIDefendKingRankPanel.RefreshUI()
end

--- 初始化组件
function UIDefendKingRankPanel:InitComponents()
    ---@type Top_UIGridContainer
    UIDefendKingRankPanel.SecondList = self:GetCurComp("WidgetRoot/Tween/ScrollView/SecondList", "Top_UIGridContainer")
    ---@type Top_UILabel 国王状态
    UIDefendKingRankPanel.KingHpPer = self:GetCurComp("WidgetRoot/Tween/secondOurRankItem/firstValue", "Top_UILabel")
    ---@type Top_UILabel 间谍积分
    --UIDefendKingRankPanel.spyPoints = self:GetCurComp("WidgetRoot/Tween/secondOurRankItem/secondValue", "Top_UILabel")
    ---@type UnityEngine.GameObject 帮助按钮
    UIDefendKingRankPanel.helpBtn = self:GetCurComp("WidgetRoot/Tween/helpBtn", "GameObject")
    ---@type UnityEngine.GameObject 隐藏按钮
    UIDefendKingRankPanel.BtnHide = self:GetCurComp("WidgetRoot/Tween/BtnHide", "GameObject")
    ---@type Top_TweenPosition  Tween
    UIDefendKingRankPanel.tween = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")
    ---@type Top_TweenRotation tween
    UIDefendKingRankPanel.BtnHideTween = self:GetCurComp("WidgetRoot/Tween/BtnHide", "Top_TweenRotation")
    ---@type UnityEngine.GameObject 详细排行
    UIDefendKingRankPanel.LastBtn = self:GetCurComp("WidgetRoot/Tween/LastBtn", "GameObject")
    ---@type Top_UILabel 时间
    UIDefendKingRankPanel.time = self:GetCurComp("WidgetRoot/Tween/time", "Top_UILabel")
end

function UIDefendKingRankPanel.BindUIEvents()
    --点击帮助事件
    CS.UIEventListener.Get(UIDefendKingRankPanel.helpBtn).onClick = UIDefendKingRankPanel.OnClickhelpBtn

    --点击事件隐藏按钮
    CS.UIEventListener.Get(UIDefendKingRankPanel.BtnHide).onClick = UIDefendKingRankPanel.OnClickBtnHide

    --点击详细排行按钮
    CS.UIEventListener.Get(UIDefendKingRankPanel.LastBtn).onClick = UIDefendKingRankPanel.OnClickLastBtn
end

function UIDefendKingRankPanel.BindNetMessage()
    UIDefendKingRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDefendKingActivityInfoMessage, UIDefendKingRankPanel.OnRedRefreshDefInfo)
end
--endregion

--region 函数监听

--点击帮助函数
---@param go UnityEngine.GameObject
function UIDefendKingRankPanel.OnClickhelpBtn(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(116)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--点击隐藏函数
---@param go UnityEngine.GameObject
function UIDefendKingRankPanel.OnClickBtnHide(go)
    UIDefendKingRankPanel.tween:SetOnFinished(UIDefendKingRankPanel.ClinkHideBtnCallBack)
    if UIDefendKingRankPanel.isShow then
        UIDefendKingRankPanel.tween:PlayForward()
    else
        UIDefendKingRankPanel.tween:PlayReverse()
    end
end

--点击详细排行
---@param go UnityEngine.GameObject
function UIDefendKingRankPanel.OnClickLastBtn(go)
    uimanager:CreatePanel("UIActivityRankPanel", function()
        networkRequest.ReqDefendKingRank()
    end, {
        id = LuaEnuActivityRankID.DefendKing,
        activityId = luaEnumActivityTypeByActivityTimeTable.DefendKing,
        refreshCallBack = function()
            networkRequest.ReqDefendKingRank()
        end
    })
end


--endregion


--region 网络消息处理
function UIDefendKingRankPanel.OnRedRefreshDefInfo()
    UIDefendKingRankPanel.RefreshUI()
end
--endregion

--region UI

function UIDefendKingRankPanel.RefreshUI()
    local KingHp = CS.CSScene.MainPlayerInfo.ActivityInfo.KingHpPer
    UIDefendKingRankPanel.KingHpPer.text = KingHp > 30 and luaEnumColorType.Green .. tostring(KingHp) .. '%' or luaEnumColorType.Red .. tostring(KingHp) .. '%'
    --UIDefendKingRankPanel.spyPoints.text = CS.CSScene.MainPlayerInfo.ActivityInfo.SpyScore
    UIDefendKingRankPanel.RefreshRank()
    if UIDefendKingRankPanel.IEnumRefreshTime == nil then
        UIDefendKingRankPanel.IEnumRefreshTime = StartCoroutine(UIDefendKingRankPanel.IenumRefreshTime)
    end
end

function UIDefendKingRankPanel.RefreshRank()
    local rankList = CS.CSScene.MainPlayerInfo.ActivityInfo.CurDefUnionRankList
    UIDefendKingRankPanel.SecondList.MaxCount = rankList.Count
    local mainPlayerUnionId = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID
    for i = 0, rankList.Count - 1 do
        local go = UIDefendKingRankPanel.SecondList.controlList[i]
        if go then
            local secondValue = CS.Utility_Lua.GetComponent(go.transform:Find('secondValue'), "Top_UILabel")
            local thirdValue = CS.Utility_Lua.GetComponent(go.transform:Find('thirdValue'), "Top_UILabel")
            local str = ""
            local isMainUnion = rankList[i].unionId == mainPlayerUnionId and mainPlayerUnionId ~= 0
            local color = CS.Cfg_GlobalTableManager.Instance.HostileGuildStrColor
            if isMainUnion then
                color = luaEnumColorType.Blue2
            end
            str = i == 0 and color .. rankList[i].unionName .. "(守护)" or color .. rankList[i].unionName
            secondValue.text = str
            thirdValue.text = rankList[i].unionScore
        end
    end
end

--endregion

--region otherFunction

function UIDefendKingRankPanel.ClinkHideBtnCallBack()
    if UIDefendKingRankPanel.isShow then
        UIDefendKingRankPanel.BtnHideTween:PlayForward()
        UIDefendKingRankPanel.isShow = false
        uimanager:ClosePanel('UIDefendKingRankPanel')
        Utility.TryOpenActivityIcon(luaEnumActivityTypeByActivityTimeTable.DefendKing)
    else
        UIDefendKingRankPanel.BtnHideTween:PlayReverse()
        UIDefendKingRankPanel.isShow = true
        UIDefendKingRankPanel.BtnHide:SetActive(true)
    end
end

function UIDefendKingRankPanel.IenumRefreshTime()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local remainTime = CS.CSScene.MainPlayerInfo.ActivityInfo.RemainTime
    if remainTime <= 0 then
        UIDefendKingRankPanel.time.text = '00:00'
        return
    end

    local isRefresh = true
    local hour, minute, second
    while isRefresh do
        if remainTime <= 0 then
            isRefresh = false
            UIDefendKingRankPanel.time.text = '00:00'
            return
        end
        hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
        UIDefendKingRankPanel.time.text = string.format("%02.0f:%02.0f", minute, second)
        remainTime = remainTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

--endregion

--region ondestroy

function ondestroy()
    if UIDefendKingRankPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UIDefendKingRankPanel.IEnumRefreshTime)
        UIDefendKingRankPanel.IEnumRefreshTime = nil
    end
end

--endregion

return UIDefendKingRankPanel