---@class UICompetitionPanel_Type5Template:TeemplateBase 竞技-装备回收
local UICompetitionPanel_Type5Template = {}

---@param panel UICompetitionPanel
function UICompetitionPanel_Type5Template:Init(panel)
    self.rootPanel = panel
    self:InitComponent()
    self:BindEvent()
    self.mGetBtn_Lb.text = "可回收"
end

function UICompetitionPanel_Type5Template:InitComponent()
    ---@type UISprite
    ---背景
    self.mBg_UISprite = self:Get("backGround", "UISprite")

    ---icon1 图片
    ---@type UISprite
    self.mIcon1_Sprite = self:Get("icon1", "UISprite")

    ---icon2 背景
    ---@type UISprite
    self.mIcon2_Sprite = self:Get("icon2", "UISprite")

    ---icon3 标签
    ---@type UISprite
    self.mIcon3_Sprite = self:Get("icon3", "UISprite")

    ---描述
    ---@type UILabel
    self.mDescription = self:Get("Root1/description", "UILabel")

    ---@type UILabel 剩余数目
    self.mRemain_Lb = self:Get("Root1/remain", "UILabel")

    ---@type UnityEngine.GameObject 领完
    self.mRemainNumm_Go = self:Get("Root1/remainNull", "GameObject")

    ---@type UIGridContainer
    ---奖励列表
    self.rewardList_UIGridContainer = self:Get("Root1/rewardList", "UIGridContainer")

    ---@type UnityEngine.GameObject
    ---领奖按钮
    self.mGetBtn_Go = self:Get("Root1/btn_get", "GameObject")

    ---@type UILabel
    self.mGetBtn_Lb = self:Get("Root1/btn_get/Label", "UILabel")

    ---未完成GO
    ---@type UnityEngine.GameObject
    self.UnFinish_GO = self:Get("Root1/unFinish", "GameObject")

    ---@type UnityEngine.GameObject 完成
    self.mFinish_GO = self:Get("Root1/finish", "GameObject")
end

function UICompetitionPanel_Type5Template:BindEvent()
    CS.UIEventListener.Get(self.mGetBtn_Go).onClick = function()
        self:OnRewardBtnClicked()
    end
end

---刷新
---@param data activityV2.ActivityDataInfo 活动数据
---@param tableData TABLE.CFG_ACTIVITY_COMMON 活动表数据
function UICompetitionPanel_Type5Template:Refresh(data, tableData, registerNum)
    ---@type table<number,activityV2.ActivityDataInfo>
    self.childData = {}
    self.data = data
    self.tblData = tableData
    ---是否有剩余奖励可领
    self.hasLeft = true
    if tableData and data then
        self:RefreshBasicShow(tableData, data)--有设置剩余奖励必须最先调用
        self:ShowReward(tableData)
        self:RefreshBtnState()
    end
    self:RefreshColorEct()
end

---@return boolean 任务是否玩成
function UICompetitionPanel_Type5Template:HasGetReward()
    if self.data and self.data.roleGoalInfo then
        return self.data.roleGoalInfo.rewardState == 2
    end
    return false
end

--region 左边部分显示
---刷新基础显示
------@param data activityV2.ActivityDataInfo 活动数据
---@param tblData TABLE.CFG_ACTIVITY_COMMON 活动表数据
function UICompetitionPanel_Type5Template:RefreshBasicShow(tblData, data)
    if data == nil or tblData == nil then
        return
    end

    self.mIcon1_Sprite.spriteName = tblData.icon
    self.mIcon2_Sprite.spriteName = tblData.icon2
    self.mIcon3_Sprite.spriteName = tblData.icon3

    local leftCount = data.leftCount
    self.hasLeft = leftCount > 0
    local color = leftCount > 0 and luaEnumColorType.Green or luaEnumColorType.Red
    self.mRemain_Lb.text = luaEnumColorType.Gray .. string.format(tblData.smallname, color .. leftCount)
    self:RefreshGoalInfo(tblData)
end

---刷新目标显示
function UICompetitionPanel_Type5Template:RefreshGoalInfo(tblData)
    if tblData and tblData.goalIds and tblData.goalIds.list then
        local goal = tblData.goalIds.list[0]
        if goal then
            local goalInfo = self:GetGoalInfoCache(goal)
            if goalInfo then
                local itemId = goalInfo.goalParam
                local color = self.hasLeft and "" or luaEnumColorType.Gray
                local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
                if res then
                    self.mDescription.text = color .. itemInfo.name
                    self.mIcon2_Sprite.spriteName = itemInfo.icon
                    CS.UIEventListener.Get(self.mIcon2_Sprite.gameObject).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                    end
                    return
                end
            end
        end
    end
    self.mDescription.text = ""
end
--endregion

--region 中间部分奖励显示
---刷新奖励显示
---@param tableData TABLE.CFG_ACTIVITY_COMMON
function UICompetitionPanel_Type5Template:ShowReward(tableData)
    if tableData.award then
        self.rewardList_UIGridContainer.MaxCount = tableData.award.list.Count
        for i = 0, self.rewardList_UIGridContainer.controlList.Count - 1 do
            if tableData.award.list[i].list.Count >= 2 then
                local itemId = tableData.award.list[i].list[0]
                ---@type UnityEngine.GameObject
                local go = self.rewardList_UIGridContainer.controlList[i]
                ---@type bagV2.CoinInfo
                local boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(itemId)
                if boxInfo then
                    ---替换宝箱
                    local res, boxItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(boxInfo.itemId)
                    if res then
                        self:ShowItemInfo(boxItemInfo, boxInfo.count, go)
                    end
                else
                    ---普通道具
                    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
                    if res then
                        local num = tableData.award.list[i].list[1]
                        self:ShowItemInfo(itemInfo, num, go)
                    end
                end
            end
        end
    end
end

---刷新单个格子显示
---@param info TABLE.CFG_ITEMS 道具信息
---@param num number 数目
---@param go UnityEngine.GameObject 格子
function UICompetitionPanel_Type5Template:ShowItemInfo(info, num, go)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    if not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = info.icon
        icon.color = self.hasLeft and LuaEnumUnityColorType.Normal or LuaEnumUnityColorType.DarkGray
    end

    ---@type UILabel
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    if not CS.StaticUtility.IsNull(count) then
        local showNum = ternary(num == 1, "", num)
        count.text = showNum
    end

    ---@type UnityEngine.GameObject
    local show = CS.Utility_Lua.Get(go.transform, "Sprite", "GameObject")
    show:SetActive(false)

    self.mRewardInfo = {}
    self.mRewardInfo.icon = info.icon
    self.mRewardInfo.showNum = num == 1 and "" or num

    CS.UIEventListener.Get(go).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info, showRight = false })
    end
end
--endregion

--region 右边按钮状态
---@param data activityV2.ActivityDataInfo 活动数据
---刷新按钮数据
function UICompetitionPanel_Type5Template:RefreshBtnState()
    ---@type table<number,bagV2.BagItemInfo> 可回收道具列表
    self.mAllRecycleInfo = nil
    if self.tblData and self.tblData.goalIds and self.tblData.goalIds.list then
        self.goal = self.tblData.goalIds.list[0]
        if self.goal then
            local goalInfo = self:GetGoalInfoCache(self.goal)
            if goalInfo then
                local aim = goalInfo.goalParam
                if aim then
                    self.mAllRecycleInfo = self:GetBagItemInfo(aim)
                end
            end
        end
    end
    self:RefreshBtnShow()
    self:RefreshRewardShow()
end

---刷新按钮显示
function UICompetitionPanel_Type5Template:RefreshBtnShow()
    self.mRemainNumm_Go:SetActive(not self.hasLeft and not self:HasGetReward())
    local canReward = self.mAllRecycleInfo and #self.mAllRecycleInfo > 0
    self.mGetBtn_Go:SetActive(canReward and self.hasLeft and not self:HasGetReward())
    self.UnFinish_GO:SetActive(not canReward and self.hasLeft and not self:HasGetReward())
    self.mFinish_GO:SetActive(self:HasGetReward())
    if not self.hasLeft and self.mCurrentPanel then
        uimanager:ClosePanel(self.mCurrentPanel)
        self.mCurrentPanel = nil
    end
end

---@return table<number,bagV2.BagItemInfo> 获取背包中可回收道具
function UICompetitionPanel_Type5Template:GetBagItemInfo(aim)
    local info = {}
    if self.rootPanel and self.rootPanel:GetBagInfoV2() and aim then
        local allBagItemInfo = self.rootPanel:GetBagInfoV2():GetBagItemList()
        for j = 0, allBagItemInfo.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = allBagItemInfo[j]
            local itemId = bagItemInfo.itemId
            if itemId then
                if aim == itemId then
                    table.insert(info, bagItemInfo)
                end
            end
        end
    end
    return info
end
--endregion

--region 按钮点击事件
---领奖
function UICompetitionPanel_Type5Template:OnRewardBtnClicked()
    if self.data and self.tblData and self.mAllRecycleInfo and self.goal and self.mRewardInfo then
        uimanager:CreatePanel("UIRecyclePushPanel", function(panel)
            self.mCurrentPanel = panel
        end, self.mAllRecycleInfo, self.data, self.tblData, self.goal, self.mRewardInfo)
    end
end

function UICompetitionPanel_Type5Template:RefreshRewardShow()
    local currentPanel = uimanager:GetPanel("UIRecyclePushPanel")
    if currentPanel and self.mCurrentPanel == currentPanel then
        currentPanel:Show(self.mAllRecycleInfo, self.data, self.tblData, self.goal, self.mRewardInfo)
    end
end

--endregion

---设置背景颜色
function UICompetitionPanel_Type5Template:SetBGColor(isShow)
    local color = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
    self.mBg_UISprite.color = color
end

---刷新额外颜色显示
function UICompetitionPanel_Type5Template:RefreshColorEct()
    local color = self.hasLeft and LuaEnumUnityColorType.Normal or LuaEnumUnityColorType.DarkGray
    self.mIcon1_Sprite.color = color
    self.mIcon2_Sprite.color = color
    self.mIcon3_Sprite.color = color
end

--region 获取数据
---@return TABLE.CFG_ACTIVITY_GOALS 缓存目标数据
function UICompetitionPanel_Type5Template:GetGoalInfoCache(id)
    if self.rootPanel then
        return self.rootPanel:TemporaryCacheGoalTableData(id)
    end
end
--endregion

return UICompetitionPanel_Type5Template