---@class UICollectWordsPanel:UIBase 限时活动-集字狂欢
local UICollectWordsPanel = {}

--region 组件
---@return Top_UIGridContainer 收集道具
function UICollectWordsPanel:GetRewardList_UIGridContainer()
    if self.rewardList_UIGridContainer == nil then
        self.rewardList_UIGridContainer = self:GetCurComp("WidgetRoot/view/Collect/rewardList/Grid","Top_UIGridContainer")
    end
    return self.rewardList_UIGridContainer
end

---@return UILabel 活动描述
function UICollectWordsPanel:GetActivityDes_UILabel()
    if self.mActivityDes == nil then
        self.mActivityDes = self:GetCurComp("WidgetRoot/view/desc", "UILabel")
    end
    return self.mActivityDes
end

---@return UICountdownLabel 倒计时
function UICollectWordsPanel:GetTimeCount_UICountdownLabel()
    if self.mTimeCountLabel == nil then
        self.mTimeCountLabel = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCountLabel
end

---@return UILabel 倒计时文本
function UICollectWordsPanel:GetTimeCount_UILabel()
    if self.mTimeCountLb == nil then
        self.mTimeCountLb = self:GetCurComp("WidgetRoot/view/TimeCount", "UILabel")
    end
    return self.mTimeCountLb
end

--endregion

--region 初始化
function UICollectWordsPanel:Init()
    self:BindEvents()
    self:BindNetEvents()
end

function UICollectWordsPanel:BindEvents()
    --[[
    CS.UIEventListener.Get(self:GetEnterActivityBtn_GO()).onClick = function()
        self:OnEnterActivityBtnClicked()
    end
    --]]
end

function UICollectWordsPanel:BindNetEvents()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSubTypeActivitiesInfoMessage, function(id, tblData)
        local serverSingleData = tblData
        if serverSingleData then
            for i, v in ipairs(self.serverData.oneActivitiesInfo) do
                if v.configId == serverSingleData.configId then
                    v.dataParam = serverSingleData.dataParam
                    break
                end
            end
            self:RefreshRewardList(self.serverData)
        end
    end)
end

---@param activityData SpecialActivityPanelData
function UICollectWordsPanel:Show(activityData)
    if activityData == nil then
        self:ClosePanel()
        return
    end
    self.mActivityData = activityData

    --self:RefreshActivityDes()
    self:RefreshCountdown()

    self.serverData = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(activityData.mEventID)
    if self.serverData then
        self:RefreshRewardList(self.serverData)
    end
end
--endregion

--region 刷新界面显示
---刷新界面显示
function UICollectWordsPanel:RefreshRewardList(data)
    if data.oneActivitiesInfo == nil then
        return
    end
    self:GetRewardList_UIGridContainer().MaxCount = #data.oneActivitiesInfo
    for i, v in ipairs(data.oneActivitiesInfo) do
        local configId = v.configId
        local tblData = clientTableManager.cfg_special_activityManager:TryGetValue(configId)
        local trans = self:GetRewardList_UIGridContainer().controlList[i - 1].transform

        --收集道具
        local isEnough = true
        local materialList = self:GetComp(trans, "reward", "Top_UIGridContainer")
        materialList.MaxCount = #tblData.goal.list
        for j = 0, #tblData.goal.list - 1 do
            local itemId = tonumber(tblData.goal.list[j + 1])
            local itemGo = materialList.controlList[j]
            local icon = self:GetComp(itemGo.transform, "icon", "Top_UISprite")
            ---@type LuaMainPlayerBagMgr
            local mainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
            local num = mainPlayerBagMgr:GetItemCount(itemId)
            if num > 0 then
                icon.color = LuaEnumUnityColorType.White
            else
                icon.color = LuaEnumUnityColorType.Black
                isEnough = false
            end
            local res2, itemTable = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId);
            if (res2) then
                local uiItem = templatemanager.GetNewTemplate(itemGo, luaComponentTemplates.UIItem)
                if uiItem then
                    uiItem:RefreshUIWithItemInfo(itemTable, num)
                    CS.UIEventListener.Get(itemGo).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = uiItem.ItemInfo, showRight = false })
                    end
                end
            end
        end

        --奖励道具
        local itemId = tblData.award.list[1]
        local itemCount = tblData.award.list[2]
        local itemGo = self:GetComp(trans, "Exchange/UIItem", "GameObject")
        local res3, itemTable = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        if (res3) then
            local uiItem = templatemanager.GetNewTemplate(itemGo, luaComponentTemplates.UIItem)
            if uiItem then
                uiItem:RefreshUIWithItemInfo(itemTable, itemCount)
                CS.UIEventListener.Get(itemGo).onClick = function()
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = uiItem.ItemInfo, showRight = false })
                end
            end
        end

        --兑换
        local countLabel = self:GetComp(trans, "Label", "UILabel")
        local getCount = v.dataParam
        local allCount = 2
        if tblData.awardType then
            allCount = tblData.awardType.list[2]
        end
        countLabel.text = string.CSFormat("剩余次数 {0}/{1}", getCount, allCount)
        local hasGotGo = self:GetComp(trans, "has_got", "GameObject")
        local getBtn = self:GetComp(trans, "btn_get", "GameObject")
        if getCount >= 50 then
            hasGotGo:SetActive(true)
            getBtn:SetActive(false)
        else
            hasGotGo:SetActive(false)
            getBtn:SetActive(true)
            CS.UIEventListener.Get(getBtn).onClick = function(go)
                if isEnough then
                    networkRequest.ReqGetOneActivitiesAward(configId)
                else
                    Utility.ShowPopoTips(go, nil, 59, "UICollectWordsPanel")
                end
            end
        end
    end
end

function UICollectWordsPanel:RefreshActivityDes()
    local activityId = self.mActivityData.mActivityID
    if activityId then
        local data = self:CacheActivityData(activityId)
        if data then
            local label = self:GetActivityDes_UILabel()
            if label then
                label.text = data:GetSmallName()
            end
        end
    end
end

function UICollectWordsPanel:RefreshCountdown()
    local finishTime = self.mActivityData.mFinishTime
    if finishTime then
        self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 8, finishTime * 1000, "活动倒计时", nil, nil, function()
            self:GetTimeCount_UILabel().text = "已结束"
        end)
    end
end
--endregion

--region 缓存数据
---@return TABLE.cfg_special_activity
function UICollectWordsPanel:CacheActivityData(activityId)
    if self.mActivityIdToInfo == nil then
        self.mActivityIdToInfo = {}
    end
    local data = self.mActivityIdToInfo[activityId]
    if data == nil then
        data = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
        self.mActivityIdToInfo[activityId] = data
    end
    return data
end
--endregion

return UICollectWordsPanel