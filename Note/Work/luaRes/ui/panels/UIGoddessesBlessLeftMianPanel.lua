---@class UIGoddessesBlessLeftMianPanel:UIBase
local UIGoddessesBlessLeftMianPanel = {}

function UIGoddessesBlessLeftMianPanel:Init()
    self:InitComponents()
    self:InitOther()
end
--通过工具生成 控件变量
function UIGoddessesBlessLeftMianPanel:InitComponents()
    ---@type Top_UILabel 剩余时间
    UIGoddessesBlessLeftMianPanel.time = self:GetCurComp("WidgetRoot/Tween/view/lb_time/value", "UICountdownLabel")
    ---@type Top_UILabel 收益倍率
    UIGoddessesBlessLeftMianPanel.lb_magnification = self:GetCurComp("WidgetRoot/Tween/view/lb_magnification/value", "Top_UILabel")
    ---@type Top_UILabel 累计元宝
    UIGoddessesBlessLeftMianPanel.lb_currency = self:GetCurComp("WidgetRoot/Tween/view/lb_currency/value", "Top_UILabel")
    ---@type UnityEngine.GameObject 累计元宝图标
    UIGoddessesBlessLeftMianPanel.currencyGameObject = self:GetCurComp("WidgetRoot/Tween/view/lb_currency/icon", "GameObject")
    ---@type UnityEngine.GameObject 退出副本
    UIGoddessesBlessLeftMianPanel.btn_center = self:GetCurComp("WidgetRoot/Tween/events/btn_center", "GameObject")
    ---@type UnityEngine.GameObject 右侧缩进按钮
    UIGoddessesBlessLeftMianPanel.BtnHide = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject")
    ---@type UnityEngine.GameObject 兑换元宝
    UIGoddessesBlessLeftMianPanel.btn_exchange = self:GetCurComp("WidgetRoot/Tween/view/btn_exchange", "GameObject")
    UIGoddessesBlessLeftMianPanel.btn_exchangeEffect = self:GetCurComp("WidgetRoot/Tween/view/btn_exchange/effect", "GameObject")
    ---@type UnityEngine.GameObject 详细排行
    UIGoddessesBlessLeftMianPanel.btn_rank = self:GetCurComp("WidgetRoot/Tween/events/btn_rank", "GameObject")
    ---@type UnityEngine.GameObject 帮助
    UIGoddessesBlessLeftMianPanel.btn_helpBtn = self:GetCurComp("WidgetRoot/Tween/events/helpBtn", "GameObject")
    ---动画
    UIGoddessesBlessLeftMianPanel.tween = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")

    UIGoddessesBlessLeftMianPanel.WidgetRoot = self:GetCurComp("WidgetRoot", "GameObject")
end
--初始化 变量 按钮点击 服务器消息事件等
function UIGoddessesBlessLeftMianPanel:InitOther()
    UIGoddessesBlessLeftMianPanel.showTips_bool = true
    CS.UIEventListener.Get(UIGoddessesBlessLeftMianPanel.btn_rank.gameObject).onClick = UIGoddessesBlessLeftMianPanel.OnClickRank
    CS.UIEventListener.Get(UIGoddessesBlessLeftMianPanel.btn_exchange.gameObject).onClick = UIGoddessesBlessLeftMianPanel.OnClickExchange
    CS.UIEventListener.Get(UIGoddessesBlessLeftMianPanel.BtnHide.gameObject).onClick = UIGoddessesBlessLeftMianPanel.OnClickBtnHide
    CS.UIEventListener.Get(UIGoddessesBlessLeftMianPanel.btn_center.gameObject).onClick = UIGoddessesBlessLeftMianPanel.OnClickQuit
    CS.UIEventListener.Get(UIGoddessesBlessLeftMianPanel.btn_helpBtn.gameObject).onClick = UIGoddessesBlessLeftMianPanel.OnClickHelpBtn

    UIGoddessesBlessLeftMianPanel:GetClientEventHandler():AddEvent(CS.CEvent.AccessOrderCountChange, UIGoddessesBlessLeftMianPanel.RefreShUIEffect)

    UIGoddessesBlessLeftMianPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateItemMessage, UIGoddessesBlessLeftMianPanel.RefeshUI)
    UIGoddessesBlessLeftMianPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGoddessBlessingInfoMessage, UIGoddessesBlessLeftMianPanel.RefeshTime)
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResGoddessBlessingRankInfoMessage, UIGoddessesBlessLeftMianPanel.ResGoddessBlessingRankInfoMessage)
end

function UIGoddessesBlessLeftMianPanel:Show()
    CS.CSScene.MainPlayerInfo.ActivityInfo.IsOpenGoddess = false
    UIGoddessesBlessLeftMianPanel.RefeshTime()
    UIGoddessesBlessLeftMianPanel.lb_magnification.text = " "
    UIGoddessesBlessLeftMianPanel.lb_currency.text = "0"
    UIGoddessesBlessLeftMianPanel.RefreShUIEffect()
end

function UIGoddessesBlessLeftMianPanel.RefreShUIEffect()

    local maxNumber = CS.Cfg_GlobalTableManager.Instance.GoddessHeadUpperLimit;
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.DuplicateV2 ~= nil and CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem ~= nil and CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem.count >= maxNumber then
        UIGoddessesBlessLeftMianPanel.btn_exchangeEffect.gameObject:SetActive(true)
        Utility.ShowPopoTips(UIGoddessesBlessLeftMianPanel.btn_exchangeEffect.gameObject.transform, "", 354)
    else
        UIGoddessesBlessLeftMianPanel.btn_exchangeEffect.gameObject:SetActive(false)
    end

end

function UIGoddessesBlessLeftMianPanel.RefeshTime()
    UIGoddessesBlessLeftMianPanel.duplicateBasicInfo = CS.CSScene.MainPlayerInfo.DuplicateV2.GoddessBlessingInfo
    if UIGoddessesBlessLeftMianPanel.duplicateBasicInfo ~= nil then
        local time = UIGoddessesBlessLeftMianPanel.duplicateBasicInfo.openTime + UIGoddessesBlessLeftMianPanel.duplicateBasicInfo.totalTime * 1000
        UIGoddessesBlessLeftMianPanel.time:StartCountDown(nil, 2, time, "", "")
    end
end

---刷新UI
function UIGoddessesBlessLeftMianPanel.RefeshUI(id, data)
    if data ~= nil and CS.CSScene.MainPlayerInfo ~= nil and data.playerId == CS.CSScene.MainPlayerInfo.ID then
        if data.count == nil or data.count == "" then
            UIGoddessesBlessLeftMianPanel.lb_currency.text = 0
        else
            UIGoddessesBlessLeftMianPanel.lb_currency.text = UIGoddessesBlessLeftMianPanel.GetYuanBaoColor() .. data.count
        end

        local waidth = UIGoddessesBlessLeftMianPanel.lb_currency.width
        UIGoddessesBlessLeftMianPanel.currencyGameObject.transform.localPosition = CS.UnityEngine.Vector3(220 - waidth, 0, 0);

        UIGoddessesBlessLeftMianPanel.lb_magnification.text = UIGoddessesBlessLeftMianPanel.GetDes(math.modf(data.param / 100))
    end

end

function UIGoddessesBlessLeftMianPanel.GetYuanBaoColor()
    local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.YuanBao)
    if isfind then
        --print(LuaEnumCoinType.YuanBao,itemInfo.quality,CS.Utility_Lua.GetItemColorByQualityValue(itemInfo.quality))
        return CS.Utility_Lua.GetItemColorByQualityValue(itemInfo.quality)
    end
    return ""
end

function UIGoddessesBlessLeftMianPanel.GetDes(number)
    local color = ''
    if number == 1 then
        color = '[dde6eb]'
    elseif number == 2 then
        color = '[00ff00]'
    elseif number == 5 then
        color = '[e85038]'
    end
    return color .. number .. " 倍"
end

---点击排行榜
function UIGoddessesBlessLeftMianPanel.OnClickRank()
    --local customData = {}
    --customData.id = 3
    --customData.myRankId = 1
    -- uimanager:CreatePanel("UIActivityPersonalRankPanel",nil,customData)
    --networkRequest.ReqGetGoddessBlessingRankInfo(1)
    uimanager:CreatePanel("UIActivityRankPanel", function()
        networkRequest.ReqGetGoddessBlessingRankInfo(1)
    end, {
        id = LuaEnuActivityRankID.Goddess,
        activityId = luaEnumActivityTypeByActivityTimeTable.GoddessesBless,
        refreshCallBack = function()
            networkRequest.ReqGetGoddessBlessingRankInfo(1)
        end
    })
end

--function UIGoddessesBlessLeftMianPanel.ResGoddessBlessingRankInfoMessage(id,data)
--    if data==nil then
--        return
--    end
--    if data.rankType==3 then
--        return
--    end
--    local customData = {}
--    customData.id = 3
--    customData.myRankId = 1
--    uimanager:CreatePanel("UIActivityPersonalRankPanel", nil, customData)
--end

---兑换元宝点击事件
function UIGoddessesBlessLeftMianPanel:OnClickExchange()
    UIGoddessesBlessLeftMianPanel.FindNPC()
end

---寻找NPC
function UIGoddessesBlessLeftMianPanel.FindNPC()
    local goddessNpcPosition = CS.Cfg_MapNpcTableManager.Instance.GoddessNpcPosition
    local distance = 0
    local indxe = 0;
    local nowGoddessNpc = nil
    local mapNpcID = 0
    local myCoor = CS.CSScene.Sington.MainPlayer.OldCell.Coord
    for k, v in pairs(goddessNpcPosition) do
        local NowDistance = CS.SFMisc.Dot2.DistancePow2(myCoor, v.coordinate)
        if indxe == 0 then
            distance = NowDistance
            nowGoddessNpc = v
            mapNpcID = k
        end
        if NowDistance < distance then
            distance = NowDistance
            nowGoddessNpc = v
            mapNpcID = k
        end
        indxe = indxe + 1
    end
    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoddessesBlessFindNPC:FindStart(nowGoddessNpc.mapid, nowGoddessNpc.coordinate, mapNpcID)
    -- CS.CSPathFinderManager.Instance:SetFixedDestination(nowGoddessNpc.mapid, nowGoddessNpc.coordinate, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardPoint);
end

---右侧缩进按钮点击事件
function UIGoddessesBlessLeftMianPanel:OnClickBtnHide()
    UIGoddessesBlessLeftMianPanel.tween:SetOnFinished(UIGoddessesBlessLeftMianPanel.ClinkHideBtnCallBack)
    if UIGoddessesBlessLeftMianPanel.showTips_bool then
        UIGoddessesBlessLeftMianPanel.tween:PlayForward()
        UIGoddessesBlessLeftMianPanel.showTips_bool = false
    else
        UIGoddessesBlessLeftMianPanel.tween:PlayReverse()
        UIGoddessesBlessLeftMianPanel.showTips_bool = true
    end
end

function UIGoddessesBlessLeftMianPanel.ClinkHideBtnCallBack(go)
    local v3 = CS.UnityEngine.Vector3.zero
    if not UIGoddessesBlessLeftMianPanel.showTips_bool then
        v3.z = 180
    end
    UIGoddessesBlessLeftMianPanel.BtnHide.transform.localEulerAngles = v3
end
---退出副本点击事件
function UIGoddessesBlessLeftMianPanel:OnClickQuit()
    Utility.ReqExitDuplicate()
end

function UIGoddessesBlessLeftMianPanel.OnClickHelpBtn()
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(117)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

function UIGoddessesBlessLeftMianPanel.SetActive(isShow)
    if UIGoddessesBlessLeftMianPanel.WidgetRoot == nil or CS.StaticUtility.IsNull(UIGoddessesBlessLeftMianPanel.WidgetRoot) then
        return
    end
    UIGoddessesBlessLeftMianPanel.WidgetRoot.gameObject:SetActive(isShow)
end

function update()
    if UIGoddessesBlessLeftMianPanel.NowIntervalTime == nil then
        UIGoddessesBlessLeftMianPanel.NowIntervalTime = 0
    end

    if CS.UnityEngine.Time.time >= UIGoddessesBlessLeftMianPanel.NowIntervalTime then
        UIGoddessesBlessLeftMianPanel.NowIntervalTime = CS.UnityEngine.Time.time + CS.Cfg_GlobalTableManager.Instance.GoddessTiptime;
        local maxNumber = CS.Cfg_GlobalTableManager.Instance.GoddessHeadUpperLimit;
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.DuplicateV2 ~= nil and CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem ~= nil and CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem.count >= maxNumber then
            CS.Utility.ShowTips(CS.Cfg_GlobalTableManager.Instance.GoddessTipinfo)
        end
    end

end

function ondestroy()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ActivityInfo ~= nil then
        CS.CSScene.MainPlayerInfo.ActivityInfo.IsOpenGoddess = true
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGoddessBlessingRankInfoMessage, UIGoddessesBlessLeftMianPanel.ResGoddessBlessingRankInfoMessage)
end

return UIGoddessesBlessLeftMianPanel