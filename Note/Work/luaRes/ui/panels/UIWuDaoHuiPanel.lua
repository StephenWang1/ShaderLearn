local UIWuDaoHuiPanel = {};

setmetatable(UIWuDaoHuiPanel, luaPanelModules.UIActivityManEnterPanel);

--region Override
function UIWuDaoHuiPanel:InitEvents()
    self:RunBaseFunction("InitEvents")
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BuDouKaiSettleParamsRefresh, function()
        self:LastRankInfoCallBack()
    end)
    CS.CSScene.MainPlayerInfo.ActivityInfo.ShowRank = false
   -- networkRequest.ReqLookDuboRank(0)

    networkRequest.ReqGBPreviousPeriodTime(LuaEnumDailyActivityType.WuDaoHui)
    UIWuDaoHuiPanel.OnResDefendLastRankListCallBack = function(id, luadata)
        if luadata.activityType == LuaEnumDailyActivityType.WuDaoHui then
            self:DefendLastRankListCallBack(id, luadata)
        end
    end

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGBPreviousPeriodTimeMessage, UIWuDaoHuiPanel.OnResDefendLastRankListCallBack)
end

function UIWuDaoHuiPanel:GetActivityId()
    return 236;
end

function UIWuDaoHuiPanel:GetHelpId()
    return 136;
end

function UIWuDaoHuiPanel:OnClickBtnLast()
    CS.CSScene.MainPlayerInfo.ActivityInfo.ShowRank = true
  --  networkRequest.ReqLookDuboRank(0)
end

function UIWuDaoHuiPanel:OnCloseSelf()
    uimanager:ClosePanel("UIWuDaoHuiPanel");
end

function UIWuDaoHuiPanel:LastRankInfoCallBack()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local firstPlayerInfo = CS.CSScene.MainPlayerInfo.ActivityInfo:GetFirstBuDouKaiPlayer()
    local id = firstPlayerInfo ~= nil and 146 or 152
    local isfind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isfind and self:GetDes_Label() ~= nil and not CS.StaticUtility.IsNull(self:GetDes_Label()) then
        if firstPlayerInfo == nil then
            self:GetDes_Label().text = info.value
        else
            self:GetDes_Label().text = string.format(string.gsub(info.value, '\\n', '\n'), firstPlayerInfo.name)
        end
    end
end


function UIWuDaoHuiPanel:DefendLastRankListCallBack(id, luadata)
    if luadata == nil or luadata.times == nil then
        return
    end
    local rankInfoList = luadata.times
    self:GetGrid_GridContainer().MaxCount = #rankInfoList
    table.sort(rankInfoList, function(a, b)
        return a and b and a > b
    end)
    local index = 0
    for i, v in pairs(rankInfoList) do
        local go = self:GetGrid_GridContainer().controlList[index]
        index = index + 1
        if go then
            local label = CS.Utility_Lua.GetComponent(go, "UILabel")
            if label then
                local dayTime = v / 1000
                dayTime = dayTime - dayTime % 1
                label.text = os.date("[u]%m%d期 战绩回顾[/u]", tonumber(dayTime))
            end
        end
        local myIndex=index-1
        CS.UIEventListener.Get(go).onClick = nil
        CS.UIEventListener.Get(go).onClick = function()
            CS.CSScene.MainPlayerInfo.ActivityInfo.BuDouKaiShowLike = true
            CS.CSScene.MainPlayerInfo.ActivityInfo.ShowRank = true
            uiStaticParameter.CurBuDouKaiActivityTime = myIndex
            networkRequest.ReqLookDuboRank(0,myIndex)
        end
    end
end

--endregion

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGBPreviousPeriodTimeMessage, UIWuDaoHuiPanel.OnResDefendLastRankListCallBack)
    UIWuDaoHuiPanel:OnDestroy();
end

return UIWuDaoHuiPanel;