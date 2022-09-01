local UIMirageMazePanel = {};

setmetatable(UIMirageMazePanel, luaPanelModules.UIActivityManEnterPanel);

--region Override

function UIMirageMazePanel:Show()
    networkRequest.ReqGetPreviousReview()
    self:RunBaseFunction("Show")
end

function UIMirageMazePanel:InitEvents()
    self:RunBaseFunction("InitEvents")
    UIMirageMazePanel.OnResMazeLastRankListCallBack = function(id, luadata)
        self:ResMazeLastRankListCallBack(id, luadata)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetPreviousReviewMessage, UIMirageMazePanel.OnResMazeLastRankListCallBack)
end

function UIMirageMazePanel:GetActivityId()
    return 238;
end

function UIMirageMazePanel:GetHelpId()
    return 138;
end

function UIMirageMazePanel:OnCloseSelf()
    uimanager:ClosePanel("UIMirageMazePanel");
end

function UIMirageMazePanel:OnClickBtnEnter()
    local stateCode = self:GetEnterActivityStateCode();
    if (stateCode ~= 0) then
        self:EnterCopy(stateCode)
    else
        if (CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID ~= 0) then
            self:EnterCopy(stateCode)
        else
            local temp = {}
            temp.Content = "当前活动需要加入行会, 建议先加入行会, 是否传送至活动";
            temp.CallBack = function()
                self:RunBaseFunction("OnClickBtnEnter");
            end
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        end
    end
end

function UIMirageMazePanel:EnterCopy(stateCode)
    if (stateCode == 1) then
        return Utility.ShowPopoTips(self:GetBtnEnter_GameObject(), nil, 266, "UIActivityManEnterPanel");
    elseif (stateCode == 2) then
        return Utility.ShowPopoTips(self:GetBtnEnter_GameObject(), nil, 265, "UIActivityManEnterPanel");
    else
        self:OnClickBtnClose();
        networkRequest.ReqEnterDuplicate(9901)
    end
end

function UIMirageMazePanel:ResMazeLastRankListCallBack(id, luadata)
    if luadata == nil or luadata.activeTime == nil then
        return
    end
    local rankInfoList = luadata.activeTime
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
            uiStaticParameter.CurHUANJINGTimeStamp = v
            networkRequest.ReqGetSpecificPreviousReview(nil, v)
            uimanager:CreatePanel("UIActivityRankPanel", nil, {
                id = LuaEnuActivityRankID.DreamLandMaze
            })
        end
    end
end
--endregion

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGetPreviousReviewMessage, UIMirageMazePanel.OnResMazeLastRankListCallBack)
    UIMirageMazePanel:OnDestroy();
end

return UIMirageMazePanel;