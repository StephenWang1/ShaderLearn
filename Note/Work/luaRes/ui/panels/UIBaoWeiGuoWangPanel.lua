---@class UIBaoWeiGuoWangPanel:UIActivityManEnterPanel
local UIBaoWeiGuoWangPanel = {};

setmetatable(UIBaoWeiGuoWangPanel, luaPanelModules.UIActivityManEnterPanel);

--region Override

function UIBaoWeiGuoWangPanel:Show()
    self:RunBaseFunction("Show")
end

function UIBaoWeiGuoWangPanel:InitEvents()
    self:RunBaseFunction("InitEvents")
    UIBaoWeiGuoWangPanel.lastRankRefreshCallback = function()
        self:LastRankInfoCallBack()
    end
    UIBaoWeiGuoWangPanel.OnResDefendLastRankListCallBack = function(id, luadata)
        self:DefendLastRankListCallBack(id, luadata)
    end
    --self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDefendLastRankMessage, UIBaoWeiGuoWangPanel.lastRankRefreshCallback)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDefendLastRankListMessage, UIBaoWeiGuoWangPanel.OnResDefendLastRankListCallBack)
    networkRequest.ReqDefendLastRankList()
end

function UIBaoWeiGuoWangPanel:GetActivityId()
    return 237;
end

function UIBaoWeiGuoWangPanel:GetHelpId()
    return 133;
end

function UIBaoWeiGuoWangPanel:OnCloseSelf()
    uimanager:ClosePanel("UIBaoWeiGuoWangPanel");
end

function UIBaoWeiGuoWangPanel:OnClickBtnEnter()
    local stateCode = self:GetEnterActivityStateCode();
    if (stateCode ~= 0) then
        self:RunBaseFunction("OnClickBtnEnter");
    else
        if (CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0) then
            local temp = {}
            temp.Content = "当前活动需要加入行会, 建议先加入行会, 是否传送至活动";
            temp.CallBack = function()
                self:RunBaseFunction("OnClickBtnEnter");
            end
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        else
            self:RunBaseFunction("OnClickBtnEnter");
        end
    end
end

function UIBaoWeiGuoWangPanel:OnClickBtnLast()
    uimanager:CreatePanel("UIActivityRankPanel", nil, {
        id = LuaEnuActivityRankID.DefendKing
    })
end

function UIBaoWeiGuoWangPanel:RemoveEvents()
    self:RunBaseFunction("RemoveEvents")
end

--endregion

function UIBaoWeiGuoWangPanel:LastRankInfoCallBack()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local defendkingCommonInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.defendKingOtherInfo
    local id = defendkingCommonInfo ~= nil and defendkingCommonInfo.lastFirstUnionName ~= "" and 147 or 152
    local isfind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isfind and self:GetDes_Label() ~= nil and not CS.StaticUtility.IsNull(self:GetDes_Label()) then
        self:GetDes_Label().text = string.format(string.gsub(info.value, '\\n', '\n'), defendkingCommonInfo.lastFirstUnionName)
    end
end

--请求期数响应
function UIBaoWeiGuoWangPanel:DefendLastRankListCallBack(id, luadata)
    if luadata == nil or luadata.time == nil then
        return
    end
    local rankInfoList = luadata.time
    self:GetGrid_GridContainer().MaxCount = #rankInfoList
    table.sort(rankInfoList, function(a, b)
        return a and b and a > b
    end)
    for i, v in pairs(rankInfoList) do
        local go = self:GetGrid_GridContainer().controlList[i - 1]
        if go then
            local label = CS.Utility_Lua.GetComponent(go, "UILabel")
            if label then
                local dayTime = v / 1000
                dayTime = dayTime - dayTime % 1
                label.text = os.date("[u]%m%d期 战绩回顾[/u]", tonumber(dayTime))
            end
        end
        CS.UIEventListener.Get(go).onClick = nil
        CS.UIEventListener.Get(go).onClick = function()
            networkRequest.ReqDefendLastRank(v)
            uiStaticParameter.CurDefendKingTimeStamp = v
            uimanager:CreatePanel("UIActivityRankPanel", nil, {
                id = LuaEnuActivityRankID.DefendKing
            })
        end
    end
end

function ondestroy()
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.ActivityInfo:ClearDefendKingRankInfo()
    end

    UIBaoWeiGuoWangPanel:OnDestroy();
end

return UIBaoWeiGuoWangPanel