---@class UIHuanJingLeftMainPanel
local UIHuanJingLeftMainPanel = {}

--region 局部变量
UIHuanJingLeftMainPanel.mDuplicateInfo = nil
UIHuanJingLeftMainPanel.mHideBtnEnd = false
UIHuanJingLeftMainPanel.mCurFloor = 0
--endregion

--region 组件
function UIHuanJingLeftMainPanel.GetExitBtn_GameObject()
    if (UIHuanJingLeftMainPanel.mExitBtn == nil) then
        UIHuanJingLeftMainPanel.mExitBtn = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/events/btn_center", "GameObject")
    end
    return UIHuanJingLeftMainPanel.mExitBtn
end

function UIHuanJingLeftMainPanel.GetHideBtn_GameObject()
    if (UIHuanJingLeftMainPanel.mHideBtn == nil) then
        UIHuanJingLeftMainPanel.mHideBtn = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject")
    end
    return UIHuanJingLeftMainPanel.mHideBtn
end

function UIHuanJingLeftMainPanel.GetHelpBtn_GameObject()
    if (UIHuanJingLeftMainPanel.mHelpBtn == nil) then
        UIHuanJingLeftMainPanel.mHelpBtn = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/events/helpBtn", "GameObject")
    end
    return UIHuanJingLeftMainPanel.mHelpBtn
end

function UIHuanJingLeftMainPanel.GetHideBtn_TweenRotation()
    if (UIHuanJingLeftMainPanel.mHideBtnTweenRotation == nil) then
        UIHuanJingLeftMainPanel.mHideBtnTweenRotation = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/events/BtnHide", "Top_TweenRotation")
    end
    return UIHuanJingLeftMainPanel.mHideBtnTweenRotation
end

function UIHuanJingLeftMainPanel.GetFloor_UILabel()
    if (UIHuanJingLeftMainPanel.mFloorText == nil) then
        UIHuanJingLeftMainPanel.mFloorText = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/window/floor/value", "UILabel")
    end
    return UIHuanJingLeftMainPanel.mFloorText
end

function UIHuanJingLeftMainPanel.GetbossCount_UILabel()
    if (UIHuanJingLeftMainPanel.mbossCountText == nil) then
        UIHuanJingLeftMainPanel.mbossCountText = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/window/bossCount/value", "UILabel")
    end
    return UIHuanJingLeftMainPanel.mbossCountText
end

function UIHuanJingLeftMainPanel.GetIsExit_UILabel()
    if (UIHuanJingLeftMainPanel.mIsExit == nil) then
        UIHuanJingLeftMainPanel.mIsExit = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/window/exit/value", "UILabel")
    end
    return UIHuanJingLeftMainPanel.mIsExit
end

function UIHuanJingLeftMainPanel.GetPlayerName_UILabel()
    if (UIHuanJingLeftMainPanel.mPlayerName == nil) then
        UIHuanJingLeftMainPanel.mPlayerName = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/view/Belong/name", "UILabel")
    end
    return UIHuanJingLeftMainPanel.mPlayerName
end

function UIHuanJingLeftMainPanel.GetPanelTweenPosition_UITweenPosition()
    if (UIHuanJingLeftMainPanel.PanelTweenPosition == nil) then
        UIHuanJingLeftMainPanel.PanelTweenPosition = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")
    end
    return UIHuanJingLeftMainPanel.PanelTweenPosition
end

function UIHuanJingLeftMainPanel.GetActivesTime_UILabel()
    if (UIHuanJingLeftMainPanel.mActivesTime == nil) then
        UIHuanJingLeftMainPanel.mActivesTime = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/view/lb_activesTime", "Top_UILabel")
    end
    return UIHuanJingLeftMainPanel.mActivesTime
end

function UIHuanJingLeftMainPanel.GetActivesTime_UICountdownLabel()
    if (UIHuanJingLeftMainPanel.mActivesTimeCountdownLabel == nil) then
        UIHuanJingLeftMainPanel.mActivesTimeCountdownLabel = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/view/lb_activesTime", "UICountdownLabel")
    end
    return UIHuanJingLeftMainPanel.mActivesTimeCountdownLabel
end

function UIHuanJingLeftMainPanel.GetRankBtn_GameObject()
    if (UIHuanJingLeftMainPanel.mRankBtn == nil) then
        UIHuanJingLeftMainPanel.mRankBtn = UIHuanJingLeftMainPanel:GetCurComp("WidgetRoot/Tween/events/btn_rank", "GameObject")
    end
    return UIHuanJingLeftMainPanel.mRankBtn
end
--endregion

--region 初始化
function UIHuanJingLeftMainPanel:Init()
    UIHuanJingLeftMainPanel:BindMessage()
    UIHuanJingLeftMainPanel:BindUIEvents()
end

function UIHuanJingLeftMainPanel:Show()
    UIHuanJingLeftMainPanel.RefreshPanel()
end

function UIHuanJingLeftMainPanel:BindMessage()
    UIHuanJingLeftMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDreamlandInfoMessage, UIHuanJingLeftMainPanel.RefreshPanel)
end

function UIHuanJingLeftMainPanel:BindUIEvents()
    CS.UIEventListener.Get(UIHuanJingLeftMainPanel.GetExitBtn_GameObject()).onClick = UIHuanJingLeftMainPanel.ExitBtnOnClick
    CS.UIEventListener.Get(UIHuanJingLeftMainPanel.GetHideBtn_GameObject()).onClick = UIHuanJingLeftMainPanel.HideBtnOnClick
    CS.UIEventListener.Get(UIHuanJingLeftMainPanel.GetHelpBtn_GameObject()).onClick = UIHuanJingLeftMainPanel.HelpBtnOnClick
    CS.UIEventListener.Get(UIHuanJingLeftMainPanel.GetRankBtn_GameObject()).onClick = UIHuanJingLeftMainPanel.RankBtnOnClick
end
--endregion

--region 客户端事件
function UIHuanJingLeftMainPanel.ExitBtnOnClick()
    networkRequest.ReqExitDuplicate(0)
end

function UIHuanJingLeftMainPanel.HideBtnOnClick()
    if (not UIHuanJingLeftMainPanel.mHideBtnEnd) then
        UIHuanJingLeftMainPanel.GetHideBtn_TweenRotation():PlayForward()
        UIHuanJingLeftMainPanel.GetPanelTweenPosition_UITweenPosition():PlayForward()
    else
        UIHuanJingLeftMainPanel.GetHideBtn_TweenRotation():PlayReverse()
        UIHuanJingLeftMainPanel.GetPanelTweenPosition_UITweenPosition():PlayReverse()
    end
    UIHuanJingLeftMainPanel.mHideBtnEnd = not UIHuanJingLeftMainPanel.mHideBtnEnd
end

function UIHuanJingLeftMainPanel.HelpBtnOnClick()
    local info
    local isFind = nil
    isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(138)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

function UIHuanJingLeftMainPanel.RankBtnOnClick()
    uimanager:CreatePanel("UIActivityRankPanel", function()
        networkRequest.ReqPlayerActivityDataRank()
    end, {
        id = LuaEnuActivityRankID.DreamLandMaze,
        closeCallback = function()
            CS.CSScene.MainPlayerInfo.ActivityInfo.dreamLandState = 1
        end,
        refreshCallBack = function()
            networkRequest.ReqPlayerActivityDataRank()
        end
    })
end
--endregion

--region 服务器消息
function UIHuanJingLeftMainPanel.RefreshPanel()
    ---@type duplicateV2.ResDreamlandInfo
    UIHuanJingLeftMainPanel.mDuplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2.DreamLandInfo
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil or CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo == nil then
        return
    end
    local isFind, Info = CS.Cfg_MiGongTableManager.Instance.dic:TryGetValue(CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo.cfgId)
    if (isFind) then
        UIHuanJingLeftMainPanel.mCurFloor = Info.floor
        local showFloor = UIHuanJingLeftMainPanel.mCurFloor
        if Info.maze == 1 then
            showFloor = "幻境迷宫"
        end
        UIHuanJingLeftMainPanel.GetFloor_UILabel().text = showFloor

        UIHuanJingLeftMainPanel.GetbossCount_UILabel().text = Utility.GetBBCode(UIHuanJingLeftMainPanel.mDuplicateInfo.bossCount ~= 0) .. UIHuanJingLeftMainPanel.mDuplicateInfo.bossCount
        UIHuanJingLeftMainPanel.GetIsExit_UILabel().text = UIHuanJingLeftMainPanel.mDuplicateInfo.exitIsOpen == 0 and "[FF0000FF]否" or "[3EFF00FF]是"
        if (UIHuanJingLeftMainPanel.mDuplicateInfo.isMessenger == 0) then
            UIHuanJingLeftMainPanel.GetPlayerName_UILabel().text = "无"
        else
            UIHuanJingLeftMainPanel.GetPlayerName_UILabel().text = UIHuanJingLeftMainPanel.mDuplicateInfo.name
        end
    end

    UIHuanJingLeftMainPanel.GetActivesTime_UICountdownLabel():StartCountDown(0, 6, UIHuanJingLeftMainPanel.mDuplicateInfo.endTime, "" .. "", "[-]", nil, nil)
end

function UIHuanJingLeftMainPanel.RefreshRankPanel()

end
--endregion

--region 刷新界面

--endregion

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDreamlandInfoMessage, UIHuanJingLeftMainPanel.RefreshPanel)
end

return UIHuanJingLeftMainPanel