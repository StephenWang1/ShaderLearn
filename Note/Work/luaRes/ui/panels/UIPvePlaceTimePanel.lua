local UIPvePlaceTimePanel = {}

--region 局部变量

--endregion

--region 初始化

function UIPvePlaceTimePanel:Init()
    self:InitComponents()
    UIPvePlaceTimePanel.BindUIEvents()
    UIPvePlaceTimePanel.BindNetMessage()
    UIPvePlaceTimePanel.InitUI()
end

--- 初始化组件
function UIPvePlaceTimePanel:InitComponents()
    ---@type Top_UILabel 时间文本
    UIPvePlaceTimePanel.time = self:GetCurComp("WidgetRoot/view/time", "Top_UILabel")
end

function UIPvePlaceTimePanel.BindUIEvents()

end

function UIPvePlaceTimePanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end
--endregion

--region 函数监听

--endregion


--region 网络消息处理

--endregion

--region UI
function UIPvePlaceTimePanel.InitUI()
    UIPvePlaceTimePanel.time.text = ''
end

function UIPvePlaceTimePanel.RefreshText(str)
    UIPvePlaceTimePanel.time.text = str
    if not UIPvePlaceTimePanel.time.gameObject.activeSelf then
        UIPvePlaceTimePanel.time.gameObject:SetActive(true)
    end
end
--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIPvePlaceTimePanel