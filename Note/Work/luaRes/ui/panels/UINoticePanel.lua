---公告面板
local UINoticePanel = {}

--region 变量
UINoticePanel.NoticeDataList = {}
--endregion

--region 组件
function UINoticePanel.GetNoticeInfo_UILabel()
    if (UINoticePanel.mNoticeInfo == nil) then
        UINoticePanel.mNoticeInfo = UINoticePanel:GetCurComp("Scroll View/info", "UILabel")
    end
    return UINoticePanel.mNoticeInfo
end

function UINoticePanel.GetNoticeInfo_TweenPosition()
    if (UINoticePanel.mNoticeInfoTweenPosition == nil) then
        UINoticePanel.mNoticeInfoTweenPosition = UINoticePanel:GetCurComp("Scroll View/info", "TweenPosition")
    end
    return UINoticePanel.mNoticeInfoTweenPosition
end

function UINoticePanel.GetNoticeInfo_GameObject()
    if (UINoticePanel.mNoticeInfoGameObject == nil) then
        UINoticePanel.mNoticeInfoGameObject = UINoticePanel:GetCurComp("Scroll View/info", "GameObject")
    end
    return UINoticePanel.mNoticeInfoGameObject
end
--endregion

--region 初始化
function UINoticePanel:Init()
    UINoticePanel.BindUIEvents()
end

function UINoticePanel.BindMessage()

end

function UINoticePanel.BindUIEvents()
    --UINoticePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ClickURLAction, UINoticePanel.InfoOnClick)
    --CS.UIEventListener.Get(UINoticePanel.GetNoticeInfo_GameObject()).onClick = UINoticePanel.InfoOnClick
end

function UINoticePanel:Show(str)
    table.insert(UINoticePanel.NoticeDataList, str)
    if CS.StaticUtility.IsNull(UINoticePanel.GetNoticeInfo_TweenPosition()) == false then
        UINoticePanel.GetNoticeInfo_TweenPosition():PlayTween()
    end
    if CS.StaticUtility.IsNull(UINoticePanel.GetNoticeInfo_UILabel()) == false then
        UINoticePanel.GetNoticeInfo_UILabel().text = UINoticePanel.NoticeDataList[1]
    end
    local co = coroutine.create(UINoticePanel.IEnum_DestroyPanel)
    coroutine.resume(co)
end
--endregion

--region UI事件
function UINoticePanel.InfoOnClick()
    --读取事件[url:]...[url/]
    local eventList = string.Split(tostring(UINoticePanel.GetNoticeInfo_UILabel():GetUrlAtPosition(CS.UICamera.lastWorldPosition)), '|')

    local type = eventList[1]

    ---type为open表示打开面板，后续为参数
    ---type为deliver表示传送，暂时读表
    if (type == "event:open") then
        local parms = {}
        local count = Utility.GetLuaTableCount(eventList)
        if (count > 2) then
            if (eventList[2] == "UIGuildTipsPanel") then
                eventList[3] = tonumber(eventList[3])
                if (eventList[3] == CS.CSScene.Sington.MainPlayer.BaseInfo.ID) then
                    return
                end
                --eventList[4] = tonumber(eventList[4])
                --eventList[5] = tonumber(eventList[5])
                uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                    panelType = #eventList > 4 and tonumber(eventList[5]) or 0,
                    roleId = #eventList > 2 and eventList[3] or 0,
                    roleName = #eventList > 3 and eventList[4] or "",
                    roleSex = Utility.GetLuaTableCount(eventList) > 5 and eventList[6] or nil,
                    roleCareer = Utility.GetLuaTableCount(eventList) > 6 and eventList[7] or nil,
                })
                return
            elseif (eventList[2] == "UIItemInfoPanel") then
                local item = nil
                local itemid = tonumber(eventList[4])
                if (CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemid)) then
                    ___, item = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemid)
                end
                if (item ~= nil) then
                    eventList[4] = item
                else
                    eventList[4] = nil
                end
            elseif (eventList[2] == "UINavigationPanel") then
                if (luaEventManager.HasCallback(LuaCEvent.Navigation_OpenWithId)) then
                    local customData = {};
                    customData.targetId = eventList[3];
                    luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, customData)
                end
                return
            end
            for i = 3, Utility.GetLuaTableCount(eventList) do
                table.insert(parms, eventList[i])
            end
        end
        uimanager:CreatePanel(eventList[2], nil, table.unpack(parms))
    elseif (type == "event:deliver") then
        networkRequest.ReqDeliverByConfig(tonumber(eventList[2]), false)
    end
end
--endregion

--region 客户端事件处理
function UINoticePanel.IEnum_DestroyPanel()
    table.remove(UINoticePanel.NoticeDataList, 1)
    if CS.StaticUtility.IsNull(UINoticePanel.GetNoticeInfo_TweenPosition()) == false then
        yield_return(CS.NGUIAssist.GetWaitForSeconds(UINoticePanel.GetNoticeInfo_TweenPosition().duration))
    end
    if (Utility.GetLuaTableCount(UINoticePanel.NoticeDataList) == 0) then
        uimanager:ClosePanel("UINoticePanel")
    else
        UINoticePanel:Show()
    end
end
--endregion

function ondestroy()

end

return UINoticePanel