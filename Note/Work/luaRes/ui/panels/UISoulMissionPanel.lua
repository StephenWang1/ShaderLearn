---
--- Created by Olivier.
--- DateTime: 2021/2/26 14:50
--- 灵魂任务界面
---@class UISoulMissionPanel:UIBase
local UISoulMissionPanel = {}
UISoulMissionPanel.TaskCount = 4
UISoulMissionPanel.ChooseBgName = "SoulMission_missionbg2"
UISoulMissionPanel.UnChooseBgName = "SoulMission_missionbg1"

function UISoulMissionPanel:Init()
    self:InitVariable()
    self:InitComponent()
    self:BindEvents()
    self:BindMessage()
end

function UISoulMissionPanel:Show(customData)
    for i = 1, UISoulMissionPanel.TaskCount do
        local taskItem = templatemanager.GetNewTemplate(self.Com.grid_Tasks.controlList[i-1], luaComponentTemplates.UILingHunRenWu_TaskItemTemplate)
        table.insert(self.TaskItemList,taskItem)
    end
    self:RefreshPanel()
end


function UISoulMissionPanel:InitVariable()
    self.Com = {}
    self.data = nil
    self.itemList = {}
    self.TaskItemList = {}
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22970)
    if isFind then
        self.totalLeftCount = tonumber(tbl.value)
    end
    self.IsInitRewardItem = false
    self.CurrentTaskItem = nil
end

function UISoulMissionPanel:InitComponent()
    self.Com.btn_CloseBtn = self:GetCurComp("WidgetRoot/window/btn_close", "GameObject")
    self.Com.label_LeftCount = self:GetCurComp("WidgetRoot/view/slogan/num", "UILabel")
    --Reward
    self.Com.go_CompleteReward = self:GetCurComp("WidgetRoot/view/complete", "GameObject")
    self.Com.go_GetReward = self:GetCurComp("WidgetRoot/view/Reward", "GameObject")
    self.Com.btn_GetReward = self:GetCurComp("WidgetRoot/view/Reward/btn_get", "GameObject")
    self.Com.eff_BtnGetReward = self:GetCurComp("WidgetRoot/view/Reward/btn_get/Effect", "CSUIEffectLoad")
    self.Com.scroll_GetReward = self:GetCurComp("WidgetRoot/view/Reward/ScrollView", "UIScrollView")
    self.Com.grid_GetReward = self:GetCurComp("WidgetRoot/view/Reward/ScrollView/Awards", "UIGridContainer")
    --task
    self.Com.scroll_GetReward = self:GetCurComp("WidgetRoot/view/mission/scroll", "UIScrollView")
    self.Com.grid_Tasks = self:GetCurComp("WidgetRoot/view/mission/scroll/Grid", "UIGridContainer")
    self.Com.grid_Tasks.MaxCount = UISoulMissionPanel.TaskCount
    self.Com.eff_BtnGetReward.enabled = true
    self.Com.eff_BtnGetReward.gameObject:SetActive(false)
end

--region 按钮事件
function UISoulMissionPanel:BindEvents()
    CS.UIEventListener.Get(self.Com.btn_CloseBtn).onClick = UISoulMissionPanel.CloseBtnClick
    CS.UIEventListener.Get(self.Com.btn_GetReward).onClick = UISoulMissionPanel.GetRewardBtnClick
end

function UISoulMissionPanel.CloseBtnClick()
    uimanager:ClosePanel("UISoulMissionPanel")
end

function UISoulMissionPanel.GetRewardBtnClick()
    networkRequest.ReqGetSoulTaskReward()
end

function UISoulMissionPanel:ClickTaskItem(taskItem)
    if self.CurrentTaskItem ~= nil and self.CurrentTaskItem.Com.bg ~= nil then
        self.CurrentTaskItem.Com.bg.spriteName = UISoulMissionPanel.UnChooseBgName
    end
    self.CurrentTaskItem = taskItem
    self.CurrentTaskItem.Com.bg.spriteName = UISoulMissionPanel.ChooseBgName
end
--endregion

function UISoulMissionPanel:BindMessage()
    UISoulMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSoulTaskStateMessage, function()
        self:RefreshPanel()
    end)
end

function UISoulMissionPanel.GetNetMsg(id, tblData)
    self:RefreshPanel()
end

function UISoulMissionPanel:RefreshPanel()
    local data = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetLingHunMissionData():GetData()
    if data == nil then
        return
    end
    self.data = data
    local rewardState = self:IsRewardCompleted()
    self.Com.go_CompleteReward:SetActive(rewardState)
    self.Com.go_GetReward:SetActive(not rewardState)
    self.Com.eff_BtnGetReward.gameObject:SetActive(self:IsAllTaskCompleted())
    self:ShowRewardItem()
    self:RefreshLeftCount()
    self:RefreshTaskState()
end

---判断奖励显示情况
function UISoulMissionPanel:IsRewardCompleted()
    return self.totalLeftCount <= self.data.count
end

---判断任务是否全部完成
function UISoulMissionPanel:IsAllTaskCompleted()
    if self.data == nil then
        return false
    end
    local num = 0
    for i = 1, #self.data.taskState do
        if self.data.taskState[i].state == 2 then
            num = num + 1
        end
    end
    return num == #self.data.taskState
end

---显示奖励道具
function UISoulMissionPanel:ShowRewardItem()
    if self.IsInitRewardItem == true then
        return
    end
    if not  self.IsInitRewardItem then
        self.IsInitRewardItem = true
    end
    local totalCount = #clientTableManager.cfg_soul_rewardManager.dic
    self.Com.grid_GetReward.MaxCount = totalCount
    for i = 1, totalCount do
        local item = templatemanager.GetNewTemplate(self.Com.grid_GetReward.controlList[i-1], luaComponentTemplates.UIItem)
        table.insert(self.itemList,item)
        ---@param tbl TABLE.cfg_items
        local tbl = clientTableManager.cfg_soul_rewardManager:TryGetValue(i)
        if tbl ~= nil then
            local id = tbl:GetItemId().list[1].list[1]
            local count = tbl:GetItemId().list[1].list[2]
            local itemCfg = clientTableManager.cfg_itemsManager:TryGetValue(id)
            if itemCfg ~= nil then
                item:RefreshUIWithItemInfo(itemCfg:CsTABLE(), count)
                item:GetItemSign_UISprite().gameObject:SetActive(tbl:GetRewardIcon() == 1)
                item:RefreshOtherUI({showItemInfo = itemCfg:CsTABLE() })
            end
        end
    end
end

---刷新剩余次数
function UISoulMissionPanel:RefreshLeftCount()
    local leftCount = (self.totalLeftCount - self.data.count) < 0 and 0 or self.totalLeftCount - self.data.count
    local str = leftCount > 0 and "" or "[ff0000]"
    self.Com.label_LeftCount.text = str..leftCount..("[-]/")..self.totalLeftCount
end

---刷新任务转态
function UISoulMissionPanel:RefreshTaskState()
    for i = 1, #self.TaskItemList do
        self.TaskItemList[i]:SetData(
                function(item) self:ClickTaskItem(item) end ,self.data.taskState[i])
    end
end


return UISoulMissionPanel