---@class UIGuildListPanel:UIBase 帮会列表界面 （此面板已弃用（UIUnionManagerPanel代替））
local UIGuildListPanel = {}

local Utility = Utility

--region 属性
---@return CSUnionInfoV2 玩家帮会信息
function UIGuildListPanel:GetUnionInfoV2()
    if self.mGuildV2Info == nil then
        if self:GetPlayerInfo() then
            self.mGuildV2Info = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mGuildV2Info
end

---@return CSMainPlayerInfo 玩家信息
function UIGuildListPanel:GetPlayerInfo()
    if self.playerInfo == nil then
        self.playerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.playerInfo
end

---@return CSBagInfoV2
function UIGuildListPanel:GetBagInfoV2()
    if self.mBagInfo == nil and self:GetPlayerInfo() then
        self.mBagInfo = self:GetPlayerInfo().BagInfo
    end
    return self.mBagInfo
end

--endregion

--region 组件
---@return UnityEngine.GameObject 创建帮会按钮
function UIGuildListPanel:GetCreateGuildButton_GameObject()
    if self.mCreateGuildButton == nil then
        self.mCreateGuildButton = self:GetCurComp("WidgetRoot/event/btn_create", "GameObject")
    end
    return self.mCreateGuildButton
end
---@return LoopScrollView 循环组件
function UIGuildListPanel.GetLoopScrollView()
    if UIGuildListPanel.mLoopScrollView == nil then
        UIGuildListPanel.mLoopScrollView = UIGuildListPanel:GetCurComp("WidgetRoot/view/ScrollView/Content", "LoopScrollView")
    end
    return UIGuildListPanel.mLoopScrollView
end
---会长在线帮会按钮
function UIGuildListPanel:GetOnlineSelectToggle_UIToggle()
    if self.mOnlineSelectToggle == nil then
        self.mOnlineSelectToggle = self:GetCurComp("WidgetRoot/event/tg_select", "UIToggle")
    end
    return self.mOnlineSelectToggle
end

---ScrollView
function UIGuildListPanel.GetScrollView_UIScrollView()
    if UIGuildListPanel.mScrollView == nil then
        UIGuildListPanel.mScrollView = UIGuildListPanel:GetCurComp("WidgetRoot/view/ScrollView", "UIScrollView")
    end
    return UIGuildListPanel.mScrollView
end

--endregion

--region 初始化
function UIGuildListPanel:Init()
    self:BindUIEvents()
    self:BindMessage()
end

function UIGuildListPanel:Show()
    networkRequest.ReqSendAllUnionInfo()
    UIGuildListPanel.GetLoopScrollView():ResetToBegining(true)
    self:OnResSendAllUnionInfoMessageReceived()
end

function UIGuildListPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCreateGuildButton_GameObject()).onClick = function(go)
        self:OnButtonClicked(go)
    end
    CS.EventDelegate.Add(self:GetOnlineSelectToggle_UIToggle().onChange, function()
        self:OnlineSelectToggleClicked()
    end)
end

function UIGuildListPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AllUnionInfoChange, function()
        self:OnResSendAllUnionInfoMessageReceived()
    end)
end
--endregion

--region 服务器消息
---收到所有帮会信息
---@param tblData unionV2.ResSendAllUnionInfo
function UIGuildListPanel:OnResSendAllUnionInfoMessageReceived()
    self:RefreshGuildList()
end
--endregion

--region UI事件

---显示帮会列表
---@param allUnionInfo unionV2.ResSendAllUnionInfo 所有帮会信息
function UIGuildListPanel:RefreshGuildList()
    if self:GetUnionInfoV2() then
        UIGuildListPanel.GetScrollView_UIScrollView():ResetPosition()
        UIGuildListPanel.GetLoopScrollView():ResetToBegining(true)
        --帮会信息
        ---@type table<number,unionV2.UnionInfo>
        local unionInfoList = self:GetUnionInfoV2().AllUnionInfo
        if unionInfoList then
            local showList = self:GetIsOnlineList(unionInfoList)
            local objList = CS.System.Collections.Generic["List`1[System.Object]"]()
            for i = 1, #showList do
                objList:Add(showList[i])
            end
            UIGuildListPanel.GetLoopScrollView():Init(objList, function(item, data)
                self:InitGuildItem(item, data)
            end)
        end
        self:GetCreateGuildButton_GameObject():SetActive(self:GetUnionInfoV2().UnionID == 0)
    end
end

---刷新每一條幫會信息
function UIGuildListPanel:InitGuildItem(item, data)
    local myLine = item.dataIndex + 1
    local rootGo = item.widget.gameObject
    local template = self:GetGridTemplate(rootGo)
    if template then
        template:RefreshItem(data, myLine)
    end
end

---@return UIGuildListPanel_GirdTemplate
function UIGuildListPanel:GetGridTemplate(go)
    if CS.StaticUtility.IsNull(go) then
        return
    end
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildListPanel_GirdTemplate, self)
    end
    return template
end

---得到当前显示列表
---@param GuildList table<number,unionV2.UnionInfo>
function UIGuildListPanel:GetIsOnlineList(GuildList)
    local list = {}
    local mOnline = self:GetOnlineSelectToggle_UIToggle().value
    for i = 0, GuildList.Count - 1 do
        if mOnline then
            if GuildList[i].leaderOnline then
                table.insert(list, GuildList[i])
            end
        else
            table.insert(list, GuildList[i])
        end
    end
    return list
end

---打开创建帮会界面
function UIGuildListPanel:OnButtonClicked(go)
    if Utility.IsSabacActivityNotOpen(go) then
        local cd = self:GetUnionInfoV2():GetCancelCD()
        if CS.StaticUtility.IsNullOrEmpty(cd) then
            local mGuildNum = self:GetUnionInfoV2().AllUnionInfoDic.Count
            uimanager:CreatePanel("UICreateGuildPanel", nil, mGuildNum)
        else
            if self:GetCancelUnionCDDes() then
                Utility.ShowPopoTips(go, string.format(self:GetCancelUnionCDDes(), cd), 211)
            end
        end
    end
end

---@return string 退会CD提示
function UIGuildListPanel:GetCancelUnionCDDes()
    if self.mCancelUnionCD == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(211)
        if res then
            self.mCancelUnionCD = desInfo.content
        end
    end
    return self.mCancelUnionCD
end

---点击了获取在线帮会列表
function UIGuildListPanel:OnlineSelectToggleClicked()
    self:RefreshGuildList()
end
--endregion

return UIGuildListPanel