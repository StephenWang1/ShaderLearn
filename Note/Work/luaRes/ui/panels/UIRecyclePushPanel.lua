---@class UIRecyclePushPanel:UIBase
local UIRecyclePushPanel = {}

UIRecyclePushPanel.mPerLineNum = 3

--region 组件
---@return UILoopScrollViewPlus 界面显示
function UIRecyclePushPanel:GetPanelShow_LoopScrollViewPlus()
    if self.mLoopScroll == nil then
        self.mLoopScroll = self:GetCurComp("WidgetRoot/view/ScrollView/Content", "UILoopScrollViewPlus")
    end
    return self.mLoopScroll
end

---@return UnityEngine.GameObject
function UIRecyclePushPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject
function UIRecyclePushPanel:GetRecycleBtn_Go()
    if self.mRecycleBtn == nil then
        self.mRecycleBtn = self:GetCurComp("WidgetRoot/view/MiddleBtn", "GameObject")
    end
    return self.mRecycleBtn
end

---@return UILabel
function UIRecyclePushPanel:GetShowReward_Lb()
    if self.mShowRewardLb == nil then
        self.mShowRewardLb = self:GetCurComp("WidgetRoot/view/SellShow/showLabal1", "UILabel")
    end
    return self.mShowRewardLb
end

---@return UISprite 奖励图片
function UIRecyclePushPanel:GetRewardIcon_UISprite()
    if self.mRewardIcon == nil then
        self.mRewardIcon = self:GetCurComp("WidgetRoot/view/itemgold/Sprite", "UISprite")
    end
    return self.mRewardIcon
end

---@return UILabel 奖励数目
function UIRecyclePushPanel:GetRewardNum_UILabel()
    if self.mRewardNum == nil then
        self.mRewardNum = self:GetCurComp("WidgetRoot/view/itemgold", "UILabel")
    end
    return self.mRewardNum
end

--endregion

--region 初始化
function UIRecyclePushPanel:Init()
    self:BindEvent()
    ---@type bagV2.BagItemInfo
    self.mChooseBagItemInfo = nil
    self.mFirstToggle = nil
end

function UIRecyclePushPanel:Show(ChooseList, data, tblData, goalId, rewardInfo)
    self.mBagItemList = ChooseList
    if self.mBagItemList == nil or #self.mBagItemList <= 0 then
        --self:ClosePanel()
        --return
    end

    self.data = data
    self.tblData = tblData
    self.goalId = goalId

    self.mLidToToggle = {}
    self.mGoToToggle = {}
    self.mToggleToInfo = {}
    if self.mChooseBagItemInfo then
        self:GetPanelShow_LoopScrollViewPlus():RefreshCurrentPage()
    else
        self:RefreshPanelShow()
    end
    if rewardInfo then
        self:GetRewardIcon_UISprite().spriteName = rewardInfo.icon
        self:GetRewardNum_UILabel().text = rewardInfo.showNum
    end
    self:ChooseFirstToggle()
    self:SuitPanel()
end

function UIRecyclePushPanel:ChooseFirstToggle()
    if self.mChooseBagItemInfo then
        local toggle = self.mLidToToggle[self.mChooseBagItemInfo.lid]
        if toggle then
            self:ClickToggle(toggle)
            return
        end
    end
    local toggle = self.mFirstToggle
    if toggle then
        self:ClickToggle(toggle)
        return
    end
    self:ClosePanel()
end

function UIRecyclePushPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetRecycleBtn_Go()).onClick = function()
        if self.mChooseLid ~= -1 and self.data and self.tblData and self.goalId and self.mChooseBagItemInfo then
            networkRequest.ReqGetActivityReward(self.data.activityId, self.tblData.activityType, self.goalId, 1, self.mChooseBagItemInfo.lid)
            networkRequest.ReqOpenPanel(self.tblData.clientType)
            self:ClosePanel()
        end
    end
end
--endregion

--region 界面显示
function UIRecyclePushPanel:RefreshPanelShow()
    self:GetPanelShow_LoopScrollViewPlus():Init(function(go, line)
        return self:RefreshSingleLine(go, line)
    end, nil)
end

function UIRecyclePushPanel:RefreshSingleLine(go, line)
    local data = self:GetLineData(line)
    if data and #data > 0 then
        ---@type UIGridContainer
        local container = CS.Utility_Lua.Get(go.transform, "Grid", "UIGridContainer")
        container.MaxCount = #data
        for i = 0, container.controlList.Count - 1 do
            local go = container.controlList[i]
            ---@type bagV2.BagItemInfo
            local bagItemInfo = data[i + 1]
            if not CS.StaticUtility.IsNull(go) and bagItemInfo then
                local info = self:GetItemInfoCache(bagItemInfo.itemId)
                if info then
                    ---@type UISprite
                    local sp = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
                    if not CS.StaticUtility.IsNull(sp) then
                        sp.spriteName = info.icon
                    end
                    ---@type UIToggle
                    local toggle = CS.Utility_Lua.Get(go.transform, "background", "UIToggle")
                    if not CS.StaticUtility.IsNull(toggle) then
                        self.mLidToToggle[bagItemInfo.lid] = toggle
                        self.mToggleToInfo[toggle] = bagItemInfo
                        self.mGoToToggle[go] = toggle
                        CS.UIEventListener.Get(toggle.gameObject).onClick = function()
                            self:ClickToggle(toggle)
                        end
                        if line == 0 and i == 0 then
                            self.mFirstToggle = toggle
                        end
                    end
                end
            end
        end
        return true
    end
    return false
end

function UIRecyclePushPanel:ClickToggle(toggle)
    if toggle and not CS.StaticUtility.IsNull(toggle) then
        local bagItemInfo = self.mToggleToInfo[toggle]
        if bagItemInfo then
            self.mChooseBagItemInfo = bagItemInfo
            self:RefreshOtherShow()
            toggle:Set(true)
        end
    end
end

function UIRecyclePushPanel:RefreshOtherShow()
    if self.mChooseBagItemInfo then
        local itemInfo = self.mChooseBagItemInfo.ItemTABLE
        if itemInfo then
            self:GetShowReward_Lb().text = "[fffff0]确认回收" .. itemInfo.name
        end
    end
end

function UIRecyclePushPanel:GetLineData(line)
    local lineInfo = {}
    if self.mBagItemList then
        for i = line * self. mPerLineNum, (line + 1) * self.mPerLineNum - 1 do
            if i < #self.mBagItemList then
                table.insert(lineInfo, self.mBagItemList[i + 1])
            end
        end
    end
    return lineInfo
end

function UIRecyclePushPanel:SuitPanel()
    if self.mBagItemList then
        local startPos = self:GetPanelShow_LoopScrollViewPlus().gameObject.transform.localPosition
        local num = #self.mBagItemList
        if num <= self.mPerLineNum then
            startPos.y = -40
            startPos.x = 40 * (3 - num)
        else
            startPos.y = 0
            startPos.x = 0
        end
        self:GetPanelShow_LoopScrollViewPlus().gameObject.transform.localPosition = startPos
    end
end

---@return TABLE.CFG_ITEMS
function UIRecyclePushPanel:GetItemInfoCache(itemId)
    if itemId == nil then
        return
    end

    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[itemId]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = info
    end
    return info
end
--endregion

return UIRecyclePushPanel