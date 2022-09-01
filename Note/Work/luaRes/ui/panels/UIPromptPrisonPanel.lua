---确认顶罪面板
local UIPromptPrisonPanel = {}

--region 局部变量
UIPromptPrisonPanel.rid = 0
--endregion

--region 初始化

function UIPromptPrisonPanel:Init()
    self:InitComponents()
    UIPromptPrisonPanel.BindUIEvents()
    UIPromptPrisonPanel.BindNetMessage()
end
function UIPromptPrisonPanel:Show(targetid, name)
    if name and targetid then
        UIPromptPrisonPanel.InitLabel(name)
        UIPromptPrisonPanel.rid = targetid
    else
        uimanager:ClosePanel('UIPromptPrisonPanel')
    end
end

--- 初始化组件
function UIPromptPrisonPanel:InitComponents()
    ---@type Top_UILabel
    UIPromptPrisonPanel.Content = self:GetCurComp("view/Content", "Top_UILabel")
    ---@type UnityEngine.GameObject
    UIPromptPrisonPanel.LeftBtn = self:GetCurComp("events/LeftBtn", "GameObject")
    ---@type UnityEngine.GameObject
    UIPromptPrisonPanel.RightBtn = self:GetCurComp("events/RightBtn", "GameObject")
    ---@type UnityEngine.GameObject
    UIPromptPrisonPanel.CloseBtn = self:GetCurComp("events/close", "GameObject")
end

function UIPromptPrisonPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIPromptPrisonPanel.LeftBtn).onClick = UIPromptPrisonPanel.OnClickLeftBtn
    --点击事件
    CS.UIEventListener.Get(UIPromptPrisonPanel.RightBtn).onClick = UIPromptPrisonPanel.OnClickRightBtn
    --点击事件
    CS.UIEventListener.Get(UIPromptPrisonPanel.CloseBtn).onClick = UIPromptPrisonPanel.OnClickLeftBtn
end

function UIPromptPrisonPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end
--endregion

--region 函数监听
--点击函数
---@param go UnityEngine.GameObject
function UIPromptPrisonPanel.OnClickLeftBtn(go)
    uimanager:ClosePanel('UIPromptPrisonPanel')
end
--点击函数
---@param go UnityEngine.GameObject
function UIPromptPrisonPanel.OnClickRightBtn(go)
    networkRequest.ReqEarlyLeavePrison(3, UIPromptPrisonPanel.rid)
    uimanager:ClosePanel('UIPromptPrisonPanel')
end

--endregion


--region 网络消息处理

--endregion

--region UI
function UIPromptPrisonPanel.InitLabel(name)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20567)
    if isFind then
        UIPromptPrisonPanel.Content.text = string.format(info.value, name)
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

return UIPromptPrisonPanel