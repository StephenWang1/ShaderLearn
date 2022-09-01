---复婚面板
local UIReMarryPanel = {}

--region 局部变量
UIReMarryPanel.needCoinCount = 0
UIReMarryPanel.needItemName = ''
--UIReMarryPanel.needItemTabel = nil
--endregion

--region 初始化

function UIReMarryPanel:Init()
    self:InitComponents()
    UIReMarryPanel.BindUIEvents()
    UIReMarryPanel.BindNetMessage()
    UIReMarryPanel.InitUI()
    UIReMarryPanel.ienumRefreshTime = nil
end

function UIReMarryPanel:InitComponents()
    ---@type UnityEngine.GameObject
    UIReMarryPanel.btn_help = self:GetCurComp("WidgetRoot/event/btn_help", "GameObject")
    ---@type UnityEngine.GameObject
    UIReMarryPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    ---@type UnityEngine.GameObject
    UIReMarryPanel.btn_remarry = self:GetCurComp("WidgetRoot/event/btn_remarry", "GameObject")
    ---@type Top_UILabel 悔婚所需货币数量文本
    UIReMarryPanel.cost = self:GetCurComp("WidgetRoot/view/cost", "Top_UILabel")
    ---@type Top_UISprite 悔婚所需货币icon
    UIReMarryPanel.cost_icon = self:GetCurComp("WidgetRoot/view/cost/cost_icon", "Top_UISprite")
    ---@type Top_UISprite 悔婚所需道具icon
    UIReMarryPanel.needIcon = self:GetCurComp("WidgetRoot/view/needIcon", "Top_UISprite")
    ---@type Top_UILabel  悔婚所需道具数量文本
    UIReMarryPanel.costNumber = self:GetCurComp("WidgetRoot/view/needIcon/costNumber", "Top_UILabel")
    ---@type Top_UILabel 倒计时
    UIReMarryPanel.time = self:GetCurComp("WidgetRoot/view/time", "Top_UILabel")
    ---@type UICountdownLabel
    UIReMarryPanel.time_UICountdownLabel = self:GetCurComp("WidgetRoot/view/time", "UICountdownLabel")
end

function UIReMarryPanel.BindUIEvents()
    --点击帮助事件
    CS.UIEventListener.Get(UIReMarryPanel.btn_help).onClick = UIReMarryPanel.OnClickbtn_help
    --点击关闭事件
    CS.UIEventListener.Get(UIReMarryPanel.btn_close).onClick = UIReMarryPanel.OnClickbtn_close
    --点击悔婚事件
    CS.UIEventListener.Get(UIReMarryPanel.btn_remarry).onClick = UIReMarryPanel.OnClickbtn_remarry
    --点击icon事件
    CS.UIEventListener.Get(UIReMarryPanel.needIcon.gameObject).onClick = UIReMarryPanel.OnClickNeedIcon
end

function UIReMarryPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)

end

--endregion

--region 函数监听
--点击帮助函数
---@param go UnityEngine.GameObject
function UIReMarryPanel.OnClickbtn_help(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(89)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIReMarryPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIReMarryPanel')
end

--点击icon函数
---@param go UnityEngine.GameObject
function UIReMarryPanel.OnClickcost_icon(go)
end

--点击悔婚函数
---@param go UnityEngine.GameObject
function UIReMarryPanel.OnClickbtn_remarry(go)
    if UIReMarryPanel.CheckCanReMarry(go) then
        networkRequest.ReqRegretMarriage()
    end
end

--点击所需物品icon函数
---@param go UnityEngine.GameObject
function UIReMarryPanel.OnClickNeedIcon(go)
    if UIReMarryPanel.needItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UIReMarryPanel.needItemInfo, showRight = false })
    end
end

--endregion

--region 网络消息处理

--endregion

--region UI

function UIReMarryPanel.InitUI()
    if CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    local isFind = false
    local marryInfo = CS.CSScene.MainPlayerInfo.MarryInfo
    if marryInfo.RemarriageNeedRingInfo ~= nil then
        isFind, UIReMarryPanel.needItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(marryInfo.RemarriageNeedRingInfo.itemId)
        if isFind then
            UIReMarryPanel.needIcon.spriteName = UIReMarryPanel.needItemInfo.icon
        end
        UIReMarryPanel.costNumber.text = marryInfo.RemarriageNeedRingInfo.needCount
    end

    local isFill, _, count, itemID = CS.Cfg_ConditionManager.Instance:IsMatchConditionOfIDAndReturInfo(marryInfo.RemarriageConditionId)
    UIReMarryPanel.needCoinCount = count
    UIReMarryPanel.cost.text = tostring(UIReMarryPanel.needCoinCount)

    isFind, UIReMarryPanel.needCoinItemTabel = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemID)
    if isFind then
        UIReMarryPanel.cost_icon.spriteName = UIReMarryPanel.needCoinItemTabel.icon
        UIReMarryPanel.needItemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemID)
    end

    UIReMarryPanel.StartRefreshTime()
end

--endregion

--region otherFunction

--检查货币是否足够
function UIReMarryPanel.CheckCanReMarry(go)
    if CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    local marryInfo = CS.CSScene.MainPlayerInfo.MarryInfo
    local isFill = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionOfID(marryInfo.RemarriageConditionId)
    if not isFill then
        UIReMarryPanel.ShowBubbleTips(go, 125, UIReMarryPanel.needItemName)
        return false
    end
    return true
end

function UIReMarryPanel.StartRefreshTime()
    if UIReMarryPanel.ienumRefreshTime ~= nil then
        StopCoroutine(UIReMarryPanel.ienumRefreshTime)
        UIReMarryPanel.ienumRefreshTime = nil
    end
    UIReMarryPanel.ienumRefreshTime = StartCoroutine(UIReMarryPanel.IEnumRefreshTime)
end

function UIReMarryPanel.IEnumRefreshTime()
    local meetTime = true
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    local endTime = CS.CSScene.MainPlayerInfo.MarryInfo.remarriageTime
    local totalTime = endTime - serverNowTime
    while meetTime do
        if totalTime <= 0 then
            meetTime = false
            UIReMarryPanel.time_UICountdownLabel:StopCountDown()
            UIReMarryPanel.time .text = "00:00:00"
            uimanager:ClosePanel('UIReMarryPanel')
        else
            UIReMarryPanel.time_UICountdownLabel:StartCountDown(nil, 8, endTime, luaEnumColorType.TimeCountRed, "[-]", nil, nil)
            --[[            local hour, minute, second = Utility.MillisecondToFormatTime(totalTime)
                        UIReMarryPanel.time .text = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)]]
        end
        totalTime = totalTime - 1000
        coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
    end
end

function UIReMarryPanel.ShowBubbleTips(go, id, ...)
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
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

--endregion

--region ondestroy

function ondestroy()
    if UIReMarryPanel.ienumRefreshTime ~= nil then
        StopCoroutine(UIReMarryPanel.ienumRefreshTime)
        UIReMarryPanel.ienumRefreshTime = nil
    end

    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIReMarryPanel