--- DateTime: 2021/04/27 11:34
--- Description 皇陵挖宝

---@class UIDigTreasureActivityPanel:UIBase
local UIDigTreasureActivityPanel = {}

UIDigTreasureActivityPanel.rewards = {}
--region parameters
--endregion

--region Init
function UIDigTreasureActivityPanel:Init(panel)
    self.rootPanel = panel
    self:InitParameters()
    self:InitComponents()
    self:BindMessage()
end

function UIDigTreasureActivityPanel:InitParameters()
    self.rewards = self:GetRewardDisplayListByGlobalID(23065)
end

function UIDigTreasureActivityPanel:InitComponents()
    ---
    ---@type UnityEngine.GameObject
    self.go_btn_leaveFor = self:GetCurComp("WidgetRoot/view/MainView/btn_leaveFor", "GameObject")
    ---
    ---@type Top_UIGridContainer
    self.grid_Awards = self:GetCurComp("WidgetRoot/view/MainView/Reward/ScrollView/Awards", "Top_UIGridContainer")
    ---
    ---@type UnityEngine.GameObject
    self.go_btn_help = self:GetCurComp("WidgetRoot/view/MainView/Reward/btn_help", "GameObject")
    ---
    ---@type UICountdownLabel 倒计时组件
    self.countdown_label=self:GetCurComp("WidgetRoot/view/MainView/TimeCount","UICountdownLabel")
end
--endregion

--region public methods

---@param activityData SpecialActivityPanelData
function UIDigTreasureActivityPanel:Show(activityData)
    self.mActivityData = activityData
    self:RefreshPanel()
end
--endregion

--region private methods
function UIDigTreasureActivityPanel:RefreshPanel()
    self:RefreshReward()
    self:StartCountDown()
end

---刷新奖励展示
function UIDigTreasureActivityPanel:RefreshReward()
    if (self.grid_Awards == nil) then
        return
    end
    ---@type table
    if (self.rewards == nil or #self.rewards == 0) then
        return
    end
    self.grid_Awards.MaxCount = #self.rewards
    for i = 0, self.grid_Awards.MaxCount - 1 do
        self:RefreshRewardItem(self.grid_Awards.controlList[i], self.rewards[i + 1])
    end
end

---刷新奖励展示Item
---@param go UnityEngine.GameObject
---@param reward CommonShowRewards
function UIDigTreasureActivityPanel:RefreshRewardItem(go, reward)
    if (go == nil or reward == nil) then
        return
    end
    local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(reward.itemID)
    if template ~= nil and itemInfoIsFind then
        template:RefreshUIWithItemInfo(itemInfo, reward.itemCount)
        CS.UIEventListener.Get(go.gameObject).onClick = function(go)
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
        end
    end
end

---活动倒计时
function UIDigTreasureActivityPanel:StartCountDown()
    self.countdown_label: StartCountDown(nil, 8, UIDigTreasureActivityPanel.mActivityData.mFinishTime * 1000,
            '活动倒计时', "", nil, nil)
end
--endregion

--region processing data
local temRewardList = nil
---根据GlobalID获取奖励展示列表
---@return table{} 奖励
function UIDigTreasureActivityPanel:GetRewardDisplayListByGlobalID(globalID)
    if (globalID == nil or type(globalID) ~= 'number') then
        return nil
    end
    if (temRewardList == nil) then
        local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(globalID)
        if (tbl ~= nil) then
            temRewardList = string.Split(tbl.value, '&')
        end
    end

    if (temRewardList ~= nil) then
        ---玩家职业
        local playerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        ---玩家性别
        local playerSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
        for i = 1, #temRewardList do
            local allRewardStr = string.Split(temRewardList[i], '#')
            if (allRewardStr ~= nil and #allRewardStr > 1) then
                local sucess = true
                ---判断奖励条件
                for j = 1, 2 do
                    local conditions = Utility.IsMainPlayerMatchCondition(tonumber(allRewardStr[j]))
                    if (conditions == nil or conditions.success == false) then
                        sucess = false
                    end
                end
                ---这条奖励满足显示条件
                if (sucess) then
                    ---@type table 奖励列表
                    local rewardTable = {}
                    for j = 3, #allRewardStr do
                        local reward = string.Split(allRewardStr[j], '-')
                        if (#reward > 3) then
                            ---职业，性别
                            if ((tonumber(reward[3]) == 0 or playerCareer == tonumber(reward[3])) and (tonumber(reward[4]) == 0 or playerSex == tonumber(reward[4]))) then
                                ---@type CommonShowRewards
                                local temReward = {}
                                temReward.itemID = tonumber(reward[1])
                                temReward.itemCount = tonumber(reward[2])
                                table.insert(rewardTable, temReward)
                            end
                        end
                    end
                    return rewardTable
                end
            end
        end
    end
    return nil
end
--endregion

--region bind event
function UIDigTreasureActivityPanel:BindMessage()
    luaclass.UIRefresh:BindClickCallBack(self.go_btn_leaveFor, function()
        self:OnTransfer()
    end)
    luaclass.UIRefresh:BindClickCallBack(self.go_btn_help, function()
        self:OnHelp()
    end)
end

function UIDigTreasureActivityPanel:OnTransfer()
    self:GetTransferID()
    if (self.transferID ~= nil and type(self.transferID) == 'number') then
        Utility.TryTransfer(self.transferID, false)
    end
end

function UIDigTreasureActivityPanel:GetTransferID()
    if (self.transferID == nil) then
        local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23066)
        if isFind and not Utility.IsNilOrEmptyString(tbl_global.value) then
            self.transferID = tonumber(tbl_global.value)
        end
    end
end

function UIDigTreasureActivityPanel:OnHelp()
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(235)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

function UIDigTreasureActivityPanel:OnClose()
    uimanager:ClosePanel('UIRechargeMainPanel')
end
--endregion

--region destroy
--endregion

return UIDigTreasureActivityPanel