---公告面板
local UINoticeSecondPanel = {}

--region 变量
UINoticeSecondPanel.NoticeDataList = {}
--endregion

--region 组件
function UINoticeSecondPanel.GetNoticeInfo_UILabel()
    if (UINoticeSecondPanel.mNoticeInfo == nil) then
        UINoticeSecondPanel.mNoticeInfo = UINoticeSecondPanel:GetCurComp("Scroll View/info", "UILabel")
    end
    return UINoticeSecondPanel.mNoticeInfo

end

function UINoticeSecondPanel.GetNoticeInfo_GameObject()
    if (UINoticeSecondPanel.mNoticeInfoGameObject == nil) then
        UINoticeSecondPanel.mNoticeInfoGameObject = UINoticeSecondPanel:GetCurComp("Scroll View/info", "GameObject")
    end
    return UINoticeSecondPanel.mNoticeInfoGameObject
end

function UINoticeSecondPanel.GetNoticeInfo_TweenPosition()
    if (UINoticeSecondPanel.mNoticeInfoTweenPosition == nil) then
        UINoticeSecondPanel.mNoticeInfoTweenPosition = UINoticeSecondPanel:GetCurComp("Scroll View/info", "TweenPosition")
    end
    return UINoticeSecondPanel.mNoticeInfoTweenPosition
end

---@type Top_UISprite
function UINoticeSecondPanel.GetNoticeInfo_UISprite()
    if (UINoticeSecondPanel.mNoticeInfoUISprite == nil) then
        UINoticeSecondPanel.mNoticeInfoUISprite = UINoticeSecondPanel:GetCurComp("window/background", "Top_UISprite")
    end
    return UINoticeSecondPanel.mNoticeInfoUISprite
end

--endregion

--region 初始化
function UINoticeSecondPanel:Init()
    UINoticeSecondPanel.BindUIEvents()
end

function UINoticeSecondPanel.BindMessage()

end

function UINoticeSecondPanel.BindUIEvents()
    CS.UIEventListener.Get(UINoticeSecondPanel.GetNoticeInfo_GameObject()).onClick = UINoticeSecondPanel.InfoOnClick
end

function UINoticeSecondPanel:Show(str)
    table.insert(UINoticeSecondPanel.NoticeDataList, str)
    UINoticeSecondPanel.GetNoticeInfo_UILabel().text = UINoticeSecondPanel.NoticeDataList[1]
    --Vector2 v = NGUIText.CalculatePrintedSize(Label.text, Label.width, 20);
    UINoticeSecondPanel.GetNoticeInfo_UISprite().width = UINoticeSecondPanel.GetNoticeInfo_UILabel().width + 10
    local co = coroutine.create(UINoticeSecondPanel.IEnum_DestroyPanel)
    coroutine.resume(co)
end
--endregion

--region UI事件
function UINoticeSecondPanel.InfoOnClick()
    --读取事件[url:]...[url/]
    local eventList = string.Split(tostring(UINoticeSecondPanel.GetNoticeInfo_UILabel():GetUrlAtPosition(CS.UICamera.lastWorldPosition)), '|')

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
function UINoticeSecondPanel.IEnum_DestroyPanel()
    table.remove(UINoticeSecondPanel.NoticeDataList, 1)
    yield_return(CS.NGUIAssist.GetWaitForSeconds(UINoticeSecondPanel.GetNoticeInfo_TweenPosition().duration))
    if (Utility.GetLuaTableCount(UINoticeSecondPanel.NoticeDataList) == 0) then
        uimanager:ClosePanel("UINoticeSecondPanel")
    else
        UINoticeSecondPanel:Show()
    end
end
--endregion

function ondestroy()

end

return UINoticeSecondPanel