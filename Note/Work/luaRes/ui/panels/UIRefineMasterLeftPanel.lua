local UIRefineMasterLeftPanel = {}

--region 变量
UIRefineMasterLeftPanel.title = "";
UIRefineMasterLeftPanel.content = "";
UIRefineMasterLeftPanel.btnListid = 0;
UIRefineMasterLeftPanel.mOpenServerLimit = true
UIRefineMasterLeftPanel.mOpenServerLimitLevel = 0
--endregion
--region 组件
function UIRefineMasterLeftPanel.GetPanelName_UILabel()
    if (UIRefineMasterLeftPanel.mPanelName == nil) then
        UIRefineMasterLeftPanel.mPanelName = UIRefineMasterLeftPanel:GetCurComp("WidgetRoot/view/lb_name", "Top_UILabel")
    end
    return UIRefineMasterLeftPanel.mPanelName
end

function UIRefineMasterLeftPanel.GetPanelContent_UILabel()
    if (UIRefineMasterLeftPanel.mPanelContent == nil) then
        UIRefineMasterLeftPanel.mPanelContent = UIRefineMasterLeftPanel:GetCurComp("WidgetRoot/view/lb_describe", "Top_UILabel")
    end
    return UIRefineMasterLeftPanel.mPanelContent
end

function UIRefineMasterLeftPanel.GetCloseBtn_GameObject()
    if (UIRefineMasterLeftPanel.mCloseBtnGo == nil) then
        UIRefineMasterLeftPanel.mCloseBtnGo = UIRefineMasterLeftPanel:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return UIRefineMasterLeftPanel.mCloseBtnGo
end

function UIRefineMasterLeftPanel.GetHelpBtn_GameObject()
    if (UIRefineMasterLeftPanel.mHelpBtnGo == nil) then
        UIRefineMasterLeftPanel.mHelpBtnGo = UIRefineMasterLeftPanel:GetCurComp("WidgetRoot/event/btn_help", "GameObject")
    end
    return UIRefineMasterLeftPanel.mHelpBtnGo
end

function UIRefineMasterLeftPanel.GetBtnList_UIGridContainer()
    if (UIRefineMasterLeftPanel.mBtnList == nil) then
        UIRefineMasterLeftPanel.mBtnList = UIRefineMasterLeftPanel:GetCurComp("WidgetRoot/view/Daily/BtnList", "Top_UIGridContainer")
    end
    return UIRefineMasterLeftPanel.mBtnList
end
--endregion

--region 初始化
function UIRefineMasterLeftPanel:Init()
    UIRefineMasterLeftPanel:InitData()
    UIRefineMasterLeftPanel:BindMessage()
    UIRefineMasterLeftPanel:BindUIEvents()

end

function UIRefineMasterLeftPanel:BindMessage()

end

function UIRefineMasterLeftPanel:BindUIEvents()
    CS.UIEventListener.Get(UIRefineMasterLeftPanel.GetCloseBtn_GameObject()).onClick = UIRefineMasterLeftPanel.CloseBtnOnClick
    CS.UIEventListener.Get(UIRefineMasterLeftPanel.GetHelpBtn_GameObject()).onClick = UIRefineMasterLeftPanel.HelpBtnOnClick
end

function UIRefineMasterLeftPanel:InitData()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22026)
    if (isFind) then
        local value = info.value:Split("#")
        if (Utility.GetLuaTableCount(value) > 0) then
            UIRefineMasterLeftPanel.title = value[1]
        end
        if (Utility.GetLuaTableCount(value) > 1) then
            UIRefineMasterLeftPanel.content = string.gsub(value[2], "\\n", '\n')
        end
        if (Utility.GetLuaTableCount(value) > 2) then
            UIRefineMasterLeftPanel.btnListid = tonumber(value[3])
        end
    end
    UIRefineMasterLeftPanel.UpdateOpenServerLimit()
end

function UIRefineMasterLeftPanel.UpdateOpenServerLimit()
    UIRefineMasterLeftPanel.mOpenServerLimit = false
    local difDay = CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1
    local isFind, item = CS.Cfg_GlobalTableManagerBase.Instance:TryGetValue(22224)
    if isFind then
        local value = string.Split(item.value, "&")
        for i = 1, #value do
            local info = string.Split(value[i], "#")
            if difDay >= tonumber(info[1]) and difDay <= tonumber(info[2]) then
                UIRefineMasterLeftPanel.mOpenServerLimit = true
                UIRefineMasterLeftPanel.mOpenServerLimitLevel = tonumber(info[3])
                break
            end
        end
    end
end

function UIRefineMasterLeftPanel:Show()
    UIRefineMasterLeftPanel:RefreshUIPanel()
end
--endregion

--region 客户端事件
function UIRefineMasterLeftPanel:RefreshUIPanel()
    UIRefineMasterLeftPanel.GetPanelName_UILabel().text = UIRefineMasterLeftPanel.title
    UIRefineMasterLeftPanel.GetPanelContent_UILabel().text = UIRefineMasterLeftPanel.content
    UIRefineMasterLeftPanel:RefreshLeftBtn(UIRefineMasterLeftPanel.btnListid)
end

function UIRefineMasterLeftPanel:RefreshLeftBtn(id)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if (isFind) then
        local value = info.value:Split("&")
        UIRefineMasterLeftPanel.GetBtnList_UIGridContainer().MaxCount = Utility.GetLuaTableCount(value)
        local count = Utility.GetLuaTableCount(value) - 1
        --local isDayOpen = false
        --local isLevelOpen = false
        --if (CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1 >= CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterOpenDay) then
        --    isDayOpen = true
        --end
        --if (CS.CSScene.MainPlayerInfo.Level >= CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterOpenLevel) then
        --    isLevelOpen = true
        --end
        --if (isDayOpen and isLevelOpen) then
        --else
        --    count = 0
        --    UIRefineMasterLeftPanel.GetBtnList_UIGridContainer().MaxCount = 1
        --end

        for i = 0, count do
            local go = UIRefineMasterLeftPanel.GetBtnList_UIGridContainer().controlList[i]
            local btnInfo = value[i + 1]:Split("#")
            CS.Utility_Lua.GetComponent(go.transform:Find("label"), "UILabel").text = btnInfo[1]
            CS.UIEventListener.Get(go).onClick = function()
                UIRefineMasterLeftPanel.curMarrageBtnType = tonumber(btnInfo[2])
                UIRefineMasterLeftPanel.SetLeftClickBtnFunc(go)
            end
        end
    end

end

function UIRefineMasterLeftPanel.SetLeftClickBtnFunc(go)
    if UIRefineMasterLeftPanel.curMarrageBtnType == LuaEnumRefineMasterLeftPanelBtnType.RoleExp then
        if (CS.CSScene.Sington.MainPlayer.BaseInfo.Level >= UIRefineMasterLeftPanel.mOpenServerLimitLevel) then
            local customData = { type = LuaEnumLeftTagType.UIRoleTurnGrowPanel }
            uimanager:CreatePanel("UIRolePanelTagPanel", function(panel)
                panel.SetAvoidCheckPanelName("UIRefineMasterLeftPanel")
                uimanager:CreatePanel("UIRefineMasterPanel", nil)
            end, customData)

            uimanager:ClosePanel("UIRefineMasterLeftPanel", nil)
        else
            UIRefineMasterLeftPanel.ShowTips(go, 237, "达到" .. UIRefineMasterLeftPanel.mOpenServerLimitLevel .. "级后可炼制")
        end

    elseif UIRefineMasterLeftPanel.curMarrageBtnType == LuaEnumRefineMasterLeftPanelBtnType.ServantExp then
        local isLevelOpen = false
        for k = 0, CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count - 1 do
            if (CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[k].level >= CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterLevel) then
                isLevelOpen = true
            end
        end
        if (isLevelOpen) then
            local customData = {};
            customData.servantIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2.BattleServantList.Count > 0 and CS.CSScene.MainPlayerInfo.ServantInfoV2.BattleServantList[0].type - 1 or 0
            customData.type = LuaEnumServantPanelType.ReinPanel
            customData.openSourceType = LuaEnumPanelOpenSourceType.ByRefineMaster;
            uimanager:CreatePanel("UIServantTagPanel", function()
                uimanager:CreatePanel("UIRefineServantPanel", nil)
            end, customData)

            uimanager:ClosePanel("UIRefineMasterLeftPanel", nil)
        else
            UIRefineMasterLeftPanel.ShowTips(go, 237, "灵兽达到" .. CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterLevel .. "级后可炼制")
        end
    elseif UIRefineMasterLeftPanel.curMarrageBtnType == LuaEnumRefineMasterLeftPanelBtnType.GongXun then
        if Utility.IsOpenLianZhiGongXun(true, go) then
            local customData = { type = LuaEnumLeftTagType.UIOfficialPositionPanel }
            uimanager:CreatePanel("UIRolePanelTagPanel", function(panel)
                uimanager:CreatePanel("UIRefineOfficialPanel", nil)
            end, customData)

            uimanager:ClosePanel("UIRefineMasterLeftPanel", nil)
        end
    end
end

function UIRefineMasterLeftPanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIRefineMasterLeftPanel", nil)
end

function UIRefineMasterLeftPanel.HelpBtnOnClick()
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(130)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

function UIRefineMasterLeftPanel.ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIRefineMasterLeftPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 服务器事件

--endregion

function ondestroy()

end
return UIRefineMasterLeftPanel