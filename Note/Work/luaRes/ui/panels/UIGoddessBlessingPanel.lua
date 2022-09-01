---@class UIGoddessBlessingPanel:UIActivityManEnterPanel
local UIGoddessBlessingPanel = {};

setmetatable(UIGoddessBlessingPanel, luaPanelModules.UIActivityManEnterPanel);

--region Override
function UIGoddessBlessingPanel:InitEvents()
    self:RunBaseFunction("InitEvents")
    networkRequest.ReqGBPreviousPeriodTime(LuaEnumDailyActivityType.Goddess)
    UIGoddessBlessingPanel.OnResDefendLastRankListCallBack = function(id, luadata)
        if luadata.activityType == LuaEnumDailyActivityType.Goddess then
            self:DefendLastRankListCallBack(id, luadata)
        end
    end

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGBPreviousPeriodTimeMessage, UIGoddessBlessingPanel.OnResDefendLastRankListCallBack)

end

function UIGoddessBlessingPanel:DefendLastRankListCallBack(id, luadata)
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
        local myIndex=index
        CS.UIEventListener.Get(go).onClick = nil
        CS.UIEventListener.Get(go).onClick = function()
           -- networkRequest.ReqLookDuboRank(0,myIndex)
           CS.CSScene.MainPlayerInfo.ActivityInfo.rankTime=v
            uiStaticParameter.CurGoddessActivityTime = v
            networkRequest.ReqGBPreviousPeriodInfo(v)
        end
    end
end

function UIGoddessBlessingPanel:RefreshLastDes(data)
    if data == nil then
        return
    end
    if data.rankType ~= 3 then
        return
    end
    local winName = nil
    if data.rankType == 3 then
        if (data.players ~= nil) then
            for k, v in pairs(data.players) do
                if winName == nil then
                    winName = v.roleName
                end
            end
        end
    end
    local id = winName ~= nil and winName ~= "" and 151 or 152
    local isfind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isfind and self:GetDes_Label() ~= nil and not CS.StaticUtility.IsNull(self:GetDes_Label()) then
        self:GetDes_Label().text = string.format(string.gsub(info.value, '\\n', '\n'), winName)
    end
end

function UIGoddessBlessingPanel:GetActivityId()

    return 235;
end

function UIGoddessBlessingPanel:GetHelpId()
    return 135;
end

function UIGoddessBlessingPanel:OnClickBtnLast()
    networkRequest.ReqGetGoddessBlessingRankInfo(2)
end

function UIGoddessBlessingPanel:OnCloseSelf()
    uimanager:ClosePanel("UIGoddessBlessingPanel");
end

function UIGoddessBlessingPanel:RemoveEvents()
    -- commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGoddessBlessingRankInfoMessage, UIGoddessBlessingPanel.ResGoddessBlessingRankInfoMessage)
    -- commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGBPreviousPeriodTimeMessage, UIGoddessBlessingPanel.OnResDefendLastRankListCallBack)
end

function ondestroy()
    UIGoddessBlessingPanel:OnDestroy();
end


--endregion
return UIGoddessBlessingPanel;