---公告面板
local UINoticeSecondDownPanel = {}

--region 变量
UINoticeSecondDownPanel.NoticeDataList = {}
--endregion

--region 组件
function UINoticeSecondDownPanel.GetNoticeInfo_UILabel()
    if (UINoticeSecondDownPanel.mNoticeInfo == nil) then
        UINoticeSecondDownPanel.mNoticeInfo = UINoticeSecondDownPanel:GetCurComp("Scroll View/info", "UILabel")
    end
    return UINoticeSecondDownPanel.mNoticeInfo

end

function UINoticeSecondDownPanel.GetNoticeInfo_GameObject()
    if (UINoticeSecondDownPanel.mNoticeInfoGameObject == nil) then
        UINoticeSecondDownPanel.mNoticeInfoGameObject = UINoticeSecondDownPanel:GetCurComp("Scroll View/info", "GameObject")
    end
    return UINoticeSecondDownPanel.mNoticeInfoGameObject
end

function UINoticeSecondDownPanel.GetNoticeInfo_TweenPosition()
    if (UINoticeSecondDownPanel.mNoticeInfoTweenPosition == nil) then
        UINoticeSecondDownPanel.mNoticeInfoTweenPosition = UINoticeSecondDownPanel:GetCurComp("Scroll View/info", "TweenPosition")
    end
    return UINoticeSecondDownPanel.mNoticeInfoTweenPosition
end

---@type Top_UISprite
function UINoticeSecondDownPanel.GetNoticeInfo_UISprite()
    if (UINoticeSecondDownPanel.mNoticeInfoUISprite == nil) then
        UINoticeSecondDownPanel.mNoticeInfoUISprite = UINoticeSecondDownPanel:GetCurComp("window/background", "Top_UISprite")
    end
    return UINoticeSecondDownPanel.mNoticeInfoUISprite
end

--endregion

--region 初始化
function UINoticeSecondDownPanel:Init()
    UINoticeSecondDownPanel.BindUIEvents()
end

function UINoticeSecondDownPanel.BindMessage()

end

function UINoticeSecondDownPanel.BindUIEvents()
    CS.UIEventListener.Get(UINoticeSecondDownPanel.GetNoticeInfo_GameObject()).onClick = UINoticeSecondDownPanel.InfoOnClick
end

function UINoticeSecondDownPanel:Show(str)
    table.insert(UINoticeSecondDownPanel.NoticeDataList, str)
    UINoticeSecondDownPanel.GetNoticeInfo_UILabel().text = UINoticeSecondDownPanel.NoticeDataList[1]
    --Vector2 v = NGUIText.CalculatePrintedSize(Label.text, Label.width, 20);
    UINoticeSecondDownPanel.GetNoticeInfo_UISprite().width = UINoticeSecondDownPanel.GetNoticeInfo_UILabel().width + 10
    local co = coroutine.create(UINoticeSecondDownPanel.IEnum_DestroyPanel)
    coroutine.resume(co)
end
--endregion

--region UI事件
function UINoticeSecondDownPanel.InfoOnClick()
    --读取事件[url:]...[url/]
    local eventList = string.Split(tostring(UINoticeSecondDownPanel.GetNoticeInfo_UILabel():GetUrlAtPosition(CS.UICamera.lastWorldPosition)), '|')

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
            elseif (eventList[2] == "UIForgePanel") then
                eventList[3] = tonumber(eventList[3])
                eventList[4] = tonumber(eventList[4])
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
function UINoticeSecondDownPanel.IEnum_DestroyPanel()
    table.remove(UINoticeSecondDownPanel.NoticeDataList, 1)
    yield_return(CS.NGUIAssist.GetWaitForSeconds(UINoticeSecondDownPanel.GetNoticeInfo_TweenPosition().duration))
    if (Utility.GetLuaTableCount(UINoticeSecondDownPanel.NoticeDataList) == 0) then
        uimanager:ClosePanel("UINoticeSecondDownPanel")
    else
        UINoticeSecondDownPanel:Show()
    end
end
--endregion

function ondestroy()

end

return UINoticeSecondDownPanel