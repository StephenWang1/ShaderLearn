---@class UIGuessChoosePanel:UIBase 划拳请求面板
local UIGuessChoosePanel = {}

--region 局部变量
--当前选中请求猜拳人id
UIGuessChoosePanel.curId = 0
UIGuessChoosePanel.curGuessName = ''
--endregion

--region 初始化

function UIGuessChoosePanel:Init()
    self:InitComponents()
    UIGuessChoosePanel.BindUIEvents()
    UIGuessChoosePanel.BindNetMessage()
    networkRequest.ReqLatelyFingerPlayers()
end

--- 初始化组件
function UIGuessChoosePanel:InitComponents()
    ---@type Top_UILabel  划拳名字显示
    UIGuessChoosePanel.Label = self:GetCurComp("WidgetRoot/inputname/Label", "Top_UILabel")
    ---@type Top_UIDropDown  下拉框
    UIGuessChoosePanel.DropDown = self:GetCurComp("WidgetRoot/DropDown", "Top_UIDropDown")
    ---@type UnityEngine.GameObject 取消按钮
    UIGuessChoosePanel.LeftBtn = self:GetCurComp("WidgetRoot/event/LeftBtn", "GameObject")
    ---@type UnityEngine.GameObject 确认按钮
    UIGuessChoosePanel.RightBtn = self:GetCurComp("WidgetRoot/event/RightBtn", "GameObject")
end

function UIGuessChoosePanel.BindUIEvents()
    --点击取消按钮事件
    CS.UIEventListener.Get(UIGuessChoosePanel.LeftBtn).onClick = UIGuessChoosePanel.OnClickLeftBtn
    --点击确认按钮事件
    CS.UIEventListener.Get(UIGuessChoosePanel.RightBtn).onClick = UIGuessChoosePanel.OnClickRightBtn
    UIGuessChoosePanel.DropDown.OnValueChange:Add(UIGuessChoosePanel.OnChangeDropDown)
end

function UIGuessChoosePanel.BindNetMessage()
    UIGuessChoosePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLatelyFingerPlayersMessage, UIGuessChoosePanel.onResLatelyFingerPlayersMessageCallback)
end

--endregion

--region 函数监听

--点击取消按钮函数
---@param go UnityEngine.GameObject
function UIGuessChoosePanel.OnClickLeftBtn(go)
    uimanager:ClosePanel('UIGuessChoosePanel')
end

--点击确认按钮函数
---@param go UnityEngine.GameObject
function UIGuessChoosePanel.OnClickRightBtn(go)
    --请求进入划拳
    local str = UIGuessChoosePanel.Label.text
    networkRequest.ReqInviteFinger(0, str)
    local guessFistInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo
    guessFistInfo.guessCamp = 1
    uimanager:ClosePanel('UIGuessChoosePanel')
end

function UIGuessChoosePanel.OnChangeDropDown(data)
    UIGuessChoosePanel.curId = tonumber(data.ExtraData)
    UIGuessChoosePanel.curGuessName = data.Label
    UIGuessChoosePanel.RefreshNameLabel()
end

--endregion


--region 网络消息处理

function UIGuessChoosePanel.onResLatelyFingerPlayersMessageCallback(id, data)
    if data then
        UIGuessChoosePanel.InitUI(data.players)
    end
end

--endregion

--region UI

function UIGuessChoosePanel.InitUI(playerInfos)
    if playerInfos == nil then
        return
    end
    local isFirst = true
    local namelist = {}
    local idList = {}
    for i, v in pairs(playerInfos) do
        if isFirst and UIGuessChoosePanel.curId == 0 then
            isFirst = not isFirst
            UIGuessChoosePanel.DropDown:SetCaptionLabel(v.name, tostring(v.lid))
        end
        table.insert(idList, v.lid)
        table.insert(namelist, v.name)
    end
    UIGuessChoosePanel.DropDown:SetOptions(namelist, idList)
    UIGuessChoosePanel.RefreshNameLabel()
end

function UIGuessChoosePanel.RefreshNameLabel()
    UIGuessChoosePanel.Label.text = UIGuessChoosePanel.curGuessName
end
--endregion

return UIGuessChoosePanel