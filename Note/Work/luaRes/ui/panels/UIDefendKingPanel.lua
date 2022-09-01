---@class UIDefendKingPanel 保卫国王
local UIDefendKingPanel = {}

--region 局部变量
UIDefendKingPanel.isShowRule = false
UIDefendKingPanel.calendarInfo = nil
--endregion

--region 初始化

function UIDefendKingPanel:Init()
    self:AddCollider()
    self:InitComponents()
    UIDefendKingPanel .BindUIEvents()
    UIDefendKingPanel .BindNetMessage()
end

--- 初始化组件
function UIDefendKingPanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭btn
    UIDefendKingPanel.CloseBtn = self:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    ---@type Top_UIGridContainer 奖励列表
    UIDefendKingPanel.Rewards = self:GetCurComp("WidgetRoot/Rewards", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 上次排行btn
    UIDefendKingPanel.LastBtn = self:GetCurComp("WidgetRoot/event/LastBtn", "GameObject")
    ---@type UnityEngine.GameObject 游戏规则btn
    UIDefendKingPanel.RuleBtn = self:GetCurComp("WidgetRoot/event/RuleBtn", "GameObject")
    ---@type UnityEngine.GameObject 前往皇宫btn
    UIDefendKingPanel.TeleportBtn = self:GetCurComp("WidgetRoot/event/TeleportBtn", "GameObject")
    ---@type UnityEngine.GameObject 规则面板
    UIDefendKingPanel.RulePanel = self:GetCurComp("WidgetRoot/RulePanel", "GameObject")
    ---@type Top_UILabel 开始时间
    UIDefendKingPanel.StartTime = self:GetCurComp("WidgetRoot/CastellanPanel/StartTime", "Top_UILabel")
end

function UIDefendKingPanel .BindUIEvents()
    ---点击关闭事件
    CS.UIEventListener.Get(UIDefendKingPanel.CloseBtn).onClick = UIDefendKingPanel.OnClickCloseBtn
    ---点击上次排行事件
    CS.UIEventListener.Get(UIDefendKingPanel.LastBtn).onClick = UIDefendKingPanel.OnClickLastBtn
    ---点击游戏规则事件
    CS.UIEventListener.Get(UIDefendKingPanel.RuleBtn).onClick = UIDefendKingPanel.OnClickRuleBtn
    ---点击前往皇宫事件
    CS.UIEventListener.Get(UIDefendKingPanel.TeleportBtn).onClick = UIDefendKingPanel.OnClickTeleportBtn

end

function UIDefendKingPanel .BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end

function UIDefendKingPanel:Show(customData)
    if customData then
        UIDefendKingPanel.calendarInfo = customData.calendarInfo == nil and nil or customData.calendarInfo
    end
    UIDefendKingPanel.InitUI()
end

--endregion

--region 函数监听

---点击关闭函数
---@param go UnityEngine.GameObject
function UIDefendKingPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIDefendKingPanel')
end

---点击上次排行函数
---@param go UnityEngine.GameObject
function UIDefendKingPanel.OnClickLastBtn(go)
    uimanager:CreatePanel("UIDefendRankPanel")
    --uimanager:ClosePanel('UIDefendKingPanel')
end

---点击游戏规则函数
---@param go UnityEngine.GameObject
function UIDefendKingPanel.OnClickRuleBtn(go)
    UIDefendKingPanel.isShowRule = not UIDefendKingPanel.isShowRule
    UIDefendKingPanel.RulePanel:SetActive(UIDefendKingPanel.isShowRule)
end

---点击前往皇宫函数
---@param go UnityEngine.GameObject
function UIDefendKingPanel.OnClickTeleportBtn(go)
    -- networkRequest.ReqDeliverByConfig(mapID)
    if UIDefendKingPanel.calendarInfo and UIDefendKingPanel.calendarInfo.tableData then
        local mapId = UIDefendKingPanel.calendarInfo.tableData.deliverId
        networkRequest.ReqDeliverByConfig(mapId)
    end
    uimanager:ClosePanel('UIDefendKingPanel')
end

--endregion


--region 网络消息处理

--endregion

--region UI

---初始化UI
function UIDefendKingPanel.InitUI()
    UIDefendKingPanel.RulePanel:SetActive(UIDefendKingPanel.isShowRule)
    UIDefendKingPanel.InitRewards()
    UIDefendKingPanel.InitTimeStr()
end

---初始化奖励信息
function UIDefendKingPanel.InitRewards()
    if UIDefendKingPanel.calendarInfo == nil or UIDefendKingPanel.calendarInfo.tableData == nil then
        return
    end
    if UIDefendKingPanel.calendarInfo.tableData.rewardShow == nil or UIDefendKingPanel.calendarInfo.tableData.rewardShow == "" then
        return
    end
    local rewardList = string.Split(UIDefendKingPanel.calendarInfo.tableData.rewardShow, '&')
    UIDefendKingPanel.Rewards.MaxCount = #rewardList
    for i = 1, #rewardList do
        local rewardInfoList = string.Split(rewardList[i], '#')
        local go = UIDefendKingPanel.Rewards.controlList[i - 1]
        local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
        --local count = (tonumber(rewardInfoList[2]) == 1) and nil or tonumber(rewardInfoList[2])
        template:RefreshUI(rewardInfoList[1], nil)
    end
end

function UIDefendKingPanel.InitTimeStr()
    if UIDefendKingPanel.calendarInfo then
        UIDefendKingPanel.StartTime.text = UIDefendKingPanel.calendarInfo:GetMonth() .. '月' .. UIDefendKingPanel.calendarInfo:GetDay() .. '日' .. UIDefendKingPanel.calendarInfo:GetTimeString()
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

return UIDefendKingPanel