---@class UICombineServerFristSBKPanel:UIBase 合服活动-占领皇宫活动面板
local UICombineServerFristSBKPanel = {}

--region组件
---@return UICountdownLabel 倒计时
function UICombineServerFristSBKPanel:GetTimeCount_UICountdownLabel()
    if self.mTimeCount == nil then
        self.mTimeCount = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCount
end

---@return UILabel 倒计时文本
function UICombineServerFristSBKPanel:GetTimeCount_UILabel()
    if self.mTimeCountLb == nil then
        self.mTimeCountLb = self:GetCurComp("WidgetRoot/view/TimeCount", "UILabel")
    end
    return self.mTimeCountLb
end

---@return UIGridContainer 获胜奖励
function UICombineServerFristSBKPanel:GetWinReward_UIGridContainer()
    if self.mWinReward == nil then
        self.mWinReward = self:GetCurComp("WidgetRoot/view/Reward/Occupy/template/dropScroll/DropItem", "UIGridContainer")
    end
    return self.mWinReward
end

---@return UIGridContainer 参与奖励
function UICombineServerFristSBKPanel:GetJoinReward_UIGridContainer()
    if self.mJoinReward == nil then
        self.mJoinReward = self:GetCurComp("WidgetRoot/view/Reward/Join/template/dropScroll/DropItem", "UIGridContainer")
    end
    return self.mJoinReward
end

---@return UnityEngine.GameObject 跳转历法按钮
function UICombineServerFristSBKPanel:GetTransferCalendarBtn_GO()
    if self.mTransCalendarBtn == nil then
        self.mTransCalendarBtn = self:GetCurComp("WidgetRoot/events/btn_go", "GameObject")
    end
    return self.mTransCalendarBtn
end
--endregion

--region 初始化
function UICombineServerFristSBKPanel:Init()
    self:BindEvents()
end

---@param activityData SpecialActivityPanelData
function UICombineServerFristSBKPanel:Show(activityData)
    if activityData == nil then
        self:ClosePanel()
        return
    end
    self.mActivityData = activityData
    self:RefreshPanelShow()
    self:RefreshReward()
end

function UICombineServerFristSBKPanel:BindEvents()
    CS.UIEventListener.Get(self:GetTransferCalendarBtn_GO()).onClick = function()
        ---@param panel UICalendarPanel
        uimanager:CreatePanel("UICalendarPanel", function(panel)
            panel:JumpTargetNextActivityType(LuaEnumDailyActivityType.ShaBaKe)
            uimanager:ClosePanel("UIActivityCurrentPanel")
        end)
    end
end
--endregion

--region 刷新界面显示
---刷新界面显示
function UICombineServerFristSBKPanel:RefreshPanelShow()
    --[[    if self.mActivityData == nil then
            return
        end
        local finishTime = self.mActivityData.mFinishTime
        if finishTime then
            self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 8, finishTime * 1000, "活动倒计时", nil, nil, function()
                self:GetTimeCount_UILabel().text = "已结束"
            end)
        end]]
    ---秒
    local combineTime = gameMgr:GetLuaTimeMgr():GetCombineServerTime()
    local openTime = combineTime + 2 * 24 * 60 * 60
    local stamp = CS.CSServerTime.StampToDateTime(openTime * 1000)
    self:GetTimeCount_UILabel().text = stamp.Year .. "年" .. stamp.Month .. "月" .. stamp.Day .. "日" .. " 20:00:00"
end

---刷新奖励显示
function UICombineServerFristSBKPanel:RefreshReward()
    local winReward = LuaGlobalTableDeal:GetSpecialActivity_SBKWinRewardList()
    if #winReward > 0 then
        self:RefreshRewardContainer(self:GetWinReward_UIGridContainer(), winReward)
    end
    local joinReward = LuaGlobalTableDeal:GetSpecialActivity_SBKJoinRewardList()
    if #joinReward > 0 then
        self:RefreshRewardContainer(self:GetJoinReward_UIGridContainer(), joinReward)
    end
end

---@param container UIGridContainer
---@param rewardList table<number,RewardItemInfo>
---刷新奖励显示
function UICombineServerFristSBKPanel:RefreshRewardContainer(container, rewardList)
    if container == nil or rewardList == nil then
        return
    end
    container.MaxCount = #rewardList
    for i = 0, container.controlList.Count - 1 do
        local reward = rewardList[i + 1]
        local go = container.controlList[i]
        ---@type UISprite
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        ---@type UILabel
        local num = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
        if reward then
            local itemId = tonumber(reward.mItemID)
            local info = self:CacheLuaItemInfo(itemId)
            if info then
                icon.spriteName = info:GetIcon()
            end
            local CSInfo = self:CacheCSITemInfo(itemId)
            CS.UIEventListener.Get(icon.gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CSInfo, showRight = false })
            end

            num.text = reward.mNum
        end
    end
end

---@return TABLE.cfg_items 缓存item表数据
function UICombineServerFristSBKPanel:CacheLuaItemInfo(itemId)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local data = self.mItemIdToInfo[itemId]
    if data == nil then
        data = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = data
    end
    return data
end

---@return TABLE.CFG_ITEMS
function UICombineServerFristSBKPanel:CacheCSITemInfo(itemId)
    if self.mItemIdToCSInfo == nil then
        self.mItemIdToCSInfo = {}
    end
    local data = self.mItemIdToCSInfo[itemId]
    if data == nil then
        ___, data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        self.mItemIdToCSInfo[itemId] = data
    end
    return data
end

return UICombineServerFristSBKPanel