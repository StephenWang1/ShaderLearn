local UIGuildChangeIconPanel = {}

--region 初始化
function UIGuildChangeIconPanel:Init()

end

function UIGuildChangeIconPanel:Show(unionId)
    if unionId then
        networkRequest.ReqGetUnionAttribute(unionId)
    else
        uimanager:ClosePanel("UIGuildChangeIconPanel")
    end
end

--function UIGuildChangeIconPanel.BindMessage()
--    commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResGetUnionAttributeMessage, UIGuildChangeIconPanel.OnResGetUnionAttributeMessageReceived)
--end
--endregion

--region UI事件
function UIGuildChangeIconPanel.OnResGetUnionAttributeMessageReceived()
    
end
--endregion

return UIGuildChangeIconPanel