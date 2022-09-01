---夫妻称谓修改面板
local UIReCallnamePanel = {}

--region 局部变量
UIReCallnamePanel.originText = ''
UIReCallnamePanel.id = 0
--endregion

--region 初始化

function UIReCallnamePanel:Init()
    self:AddCollider()
    self:InitComponents()
    UIReCallnamePanel.BindUIEvents()
end

--- 初始化组件
function UIReCallnamePanel:InitComponents()
    ---@type Top_UIInput 输入框
    UIReCallnamePanel.rename = self:GetCurComp("WidgetRoot/view/rename", "Top_UIInput")
    ---@type Top_UILabel 输入内容
    UIReCallnamePanel.Label = self:GetCurComp("WidgetRoot/view/rename/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject 关闭
    UIReCallnamePanel.close = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    ---@type UnityEngine.GameObject 左按钮
    UIReCallnamePanel.LeftBtn = self:GetCurComp("WidgetRoot/events/LeftBtn", "GameObject")
    ---@type UnityEngine.GameObject
    UIReCallnamePanel.RightBtn = self:GetCurComp("WidgetRoot/events/RightBtn", "GameObject")

    UIReCallnamePanel.originText = UIReCallnamePanel.Label.text
end

function UIReCallnamePanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIReCallnamePanel.close).onClick = UIReCallnamePanel.OnClickclose
    --点击事件
    CS.UIEventListener.Get(UIReCallnamePanel.LeftBtn).onClick = UIReCallnamePanel.OnClickclose
    --点击事件
    CS.UIEventListener.Get(UIReCallnamePanel.RightBtn).onClick = UIReCallnamePanel.OnClickRightBtn
end

function UIReCallnamePanel:Show(id)
    if id then
        UIReCallnamePanel.id = id
    end
end

--endregion

--region 函数监听
--点击关闭函数
---@param go UnityEngine.GameObject
function UIReCallnamePanel.OnClickclose(go)
    uimanager:ClosePanel('UIReCallnamePanel')
end

--点击右按钮函数
---@param go UnityEngine.GameObject
function UIReCallnamePanel.OnClickRightBtn(go)
    if UIReCallnamePanel.Label.text == '' or UIReCallnamePanel.Label.text == "" or UIReCallnamePanel.Label.text == UIReCallnamePanel.originText then
        UIReCallnamePanel.ShowBubbleTips(go, 148)
        return
    end
    networkRequest.ReqModifyTitle(UIReCallnamePanel.id, UIReCallnamePanel.Label.text)
     uimanager:ClosePanel('UIReCallnamePanel')
end

--endregion

--region otherFunction
---显示气泡
function UIReCallnamePanel.ShowBubbleTips(go, id)
    if go == nil then
        return
    end
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIReCallnamePanel";
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion
--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIReCallnamePanel