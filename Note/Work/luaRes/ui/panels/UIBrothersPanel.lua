---结义左侧面板
local UIBrothersPanel = {}

--region 局部变量
UIBrothersPanel.Index = 0
--endregion

--region 初始化

function UIBrothersPanel:Init()
    self:InitComponents()
    networkRequest.ReqBreakOffRelations()
    UIBrothersPanel.BindUIEvents()
    UIBrothersPanel.BindNetMessage()
end

---外部接口
function UIBrothersPanel:Show(index)
    if index then
        UIBrothersPanel.Index = index
    end
    UIBrothersPanel.InitUI()
end

--- 初始化组件
function UIBrothersPanel:InitComponents()
    ---@type Top_UILabel  title
    UIBrothersPanel.lb_name = self:GetCurComp("WidgetRoot/view/lb_name", "Top_UILabel")
    ---@type Top_UILabel 内容
    UIBrothersPanel.lb_describe = self:GetCurComp("WidgetRoot/view/lb_describe", "Top_UILabel")
    ---@type Top_UIGridContainer btn列表
    UIBrothersPanel.BtnList = self:GetCurComp("WidgetRoot/view/Daily/BtnList", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 帮助按钮
    UIBrothersPanel.btn_help = self:GetCurComp("WidgetRoot/event/btn_help", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIBrothersPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
end

function UIBrothersPanel.BindUIEvents()
    --点击帮助事件
    CS.UIEventListener.Get(UIBrothersPanel.btn_help).onClick = UIBrothersPanel.OnClickbtn_help
    --点击关闭事件
    CS.UIEventListener.Get(UIBrothersPanel.btn_close).onClick = UIBrothersPanel.OnClickbtn_close
end

function UIBrothersPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.SendSwornInfoMessage, UIBrothersPanel.OnSendSwornInfoMessageCallBack)
end
--endregion

--region 函数监听

--点击帮助函数
---@param go UnityEngine.GameObject
function UIBrothersPanel.OnClickbtn_help(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(80)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIBrothersPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIBrothersPanel')
end

--点击结义函数
---@param go UnityEngine.GameObject
function UIBrothersPanel.OnClickbtn_conclusion(go)
    if UIBrothersPanel.CheckCanConclusion(go) then
        --发送结义消息
        networkRequest.ReqHasSworn()
    end
end

--点击断义函数
---@param go UnityEngine.GameObject
function UIBrothersPanel.OnClickbtn_absolute(go)
    if UIBrothersPanel.checkCanSworn(go) then
        --显示兄弟面板列表
        UIBrothersPanel.CreateSeverPanel()
    end
end

--endregion


--region 网络消息处理

--endregion

--region UI

function UIBrothersPanel.InitUI()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20442)
    if isFind then
        local strs = string.Split(info.value, '#')
        UIBrothersPanel.lb_name.text = strs[1]
        UIBrothersPanel.lb_describe.text = strs[2]
        isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(strs[3])
        if isFind then
            UIBrothersPanel.InitBtn(info.value)
        end
    end
end

function UIBrothersPanel.InitBtn(str)
    if str == nil then
        return
    end
    local btns = string.Split(str, '&')
    local count = 0
    for i, v in pairs(btns) do
        count = count + 1
        UIBrothersPanel.BtnList.MaxCount = count
        local btnInfo = string.Split(v, '#')
        local go = UIBrothersPanel.BtnList.controlList[count - 1]
        if go == nil then
            return
        end
        local btnLabel = CS.Utility_Lua.GetComponent(go.transform:Find('label'),"Top_UILabel")
        if btnLabel then
            btnLabel.text = btnInfo[1]
        end
        if btnInfo[2] ~= nil then
            if tonumber(btnInfo[2]) == LuaEnumSwornType.Swore then
                --添加委托
                CS.UIEventListener.Get(go).onClick = nil
                CS.UIEventListener.Get(go).onClick = UIBrothersPanel.OnClickbtn_conclusion
                if UIBrothersPanel.index == 1 then
                    UIBrothersPanel.OnClickbtn_conclusion(go)
                end
            elseif tonumber(btnInfo[2]) == LuaEnumSwornType.Absolute then
                CS.UIEventListener.Get(go).onClick = nil
                CS.UIEventListener.Get(go).onClick = UIBrothersPanel.OnClickbtn_absolute
                if UIBrothersPanel.index == 2 then
                    UIBrothersPanel.OnClickbtn_absolute(go)
                end
            end
        end
    end
end

--endregion

--region otherFunction

--判断是否能够结义
function UIBrothersPanel.CheckCanConclusion(go)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil or CS.CSScene.MainPlayerInfo.GroupInfoV2 == nil then
        return false
    end
    local GroupInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2
    local friendInfo = CS.CSScene.MainPlayerInfo.FriendInfoV2
    --判断是否到达等级
    if friendInfo.LimitLevel > CS.CSScene.MainPlayerInfo.Level then
        UIBrothersPanel.ShowBubbleTips(go, 94, friendInfo.LimitLevel)
        return false
    end
    --判断是否有队伍
    if not GroupInfo.IsHaveGroup then
        UIBrothersPanel.ShowBubbleTips(go, 87)
        return false
    end
    --判断是否为队长
    if not GroupInfo.IsCaptain then
        UIBrothersPanel.ShowBubbleTips(go, 88)
        return false
    end
    --判断人数大于时
    if GroupInfo.PlayerInfoList.Count > friendInfo.MaxGroupCount then
        UIBrothersPanel.ShowBubbleTips(go, 89, friendInfo.MaxGroupCount)
        return false
    end
    --人数小于时
    if GroupInfo.PlayerInfoList.Count < friendInfo.MinGroupCount then
        UIBrothersPanel.ShowBubbleTips(go, 104, friendInfo.MinGroupCount)
        return false
    end
    return true
end

function UIBrothersPanel.checkCanSworn(go)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return false
    end
    local friendInfo = CS.CSScene.MainPlayerInfo.FriendInfoV2
    if friendInfo.AssertionDic.Count == 0 then
        UIBrothersPanel.ShowBubbleTips(go, 93)
        return false
    end
    return true
end


--创建结义面板
function UIBrothersPanel.CreateSwornPanel()
    --uimanager:CreatePanel("UIBrothersSwornPanel")
end

--创建断义面板
function UIBrothersPanel.CreateSeverPanel()
    uimanager:CreatePanel("UIBrothersSeverPanel")
end

function UIBrothersPanel.ShowBubbleTips(go, id, ...)
    if go == nil then
        return
    end
    local TipsInfo = {}
    if ... ~= nil then
        local str = ''
        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
        if isfind then
            str = string.format(data.content, ...)
        end
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIBrothersPanel";
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

--endregion

--region ondestroy

function ondestroy()
    -- networkRequest.ReqInterruptSworn()
    -- commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.SendSwornInfoMessage, UIBrothersPanel.OnSendSwornInfoMessageCallBack)
end

--endregion

return UIBrothersPanel