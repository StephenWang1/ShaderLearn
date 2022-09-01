---@class UICompetitionPanel_Type3Template:copytemplatebase 类型3模板 首爆
local UICompetitionPanel_Type3Template = {}

setmetatable(UICompetitionPanel_Type3Template, luaComponentTemplates.copytemplatebase)

local CheckNullFunction = CS.StaticUtility.IsNull
local CSUtility_Lua = CS.Utility_Lua

---@param panel UICompetitionPanel
function UICompetitionPanel_Type3Template:Init(panel)
    self.mOwnerPanel = panel
    self:InitComponent()
    self:BindEvents()
end

function UICompetitionPanel_Type3Template:GetPrefabGO()
    if self.mPrefabGo == nil and self.mOwnerPanel then
        self.mPrefabGo = self.mOwnerPanel:GetCurComp("WidgetRoot/view/scroll/type3/template", "GameObject")
    end
    return self.mPrefabGo
end

--region 组件
---@return UIGridContainer 奖励列表
function UICompetitionPanel_Type3Template:GetRewardListContainer()
    if self.mRewardListContainer == nil then
        self.mRewardListContainer = self:GetUIComponentController():GetCustomType(self.mRewardList_UIGridContainer, "UIGridContainer")
    end
    return self.mRewardListContainer
end

---@return UnityEngine.GameObject 领奖按钮
function UICompetitionPanel_Type3Template:GetBtn_Go()
    if self.mGetBtnGo == nil then
        self.mGetBtnGo = self:GetUIComponentController():GetCustomType(self.btnGet_GameObject, "GameObject")
    end
    return self.mGetBtnGo
end

---@return UILabel 领奖按钮文字
function UICompetitionPanel_Type3Template:GetBtn_UILabel()
    if self.mGetBtnLb == nil and CheckNullFunction(self:GetBtn_Go()) == false then
        self.mGetBtnLb = CSUtility_Lua.Get(self:GetBtn_Go().transform, "Label", "UILabel")
    end
    return self.mGetBtnLb
end

---@return UnityEngine.GameObject 特效
function UICompetitionPanel_Type3Template:GetBtnEffectGo()
    if self.mBtnEffect == nil and CheckNullFunction(self:GetBtn_Go()) == false then
        self.mBtnEffect = CSUtility_Lua.Get(self:GetBtn_Go().transform, "effect", "GameObject")
    end
    return self.mBtnEffect
end

---@return UnityEngine.GameObject icon1
function UICompetitionPanel_Type3Template:GetIcon1_Go()
    if self.mIcon1Go == nil then
        self.mIcon1Go = self:GetUIComponentController():GetCustomType(self.mIcon1_Sprite, "GameObject")
    end
    return self.mIcon1Go
end

--endregion

function UICompetitionPanel_Type3Template:InitComponent()
    ---@type UILabel
    ---标题文字
    self.title_UILabel = "title"

    ---@type UILabel
    ---描述
    self.des_UILabel = "description"

    ---@type UIGridContainer
    ---奖励列表
    self.mRewardList_UIGridContainer = "rewardList"

    ---@type UnityEngine.GameObject
    ---领奖按钮
    self.btnGet_GameObject = "btn_get"

    ---@type UnityEngine.GameObject
    ---领完文字
    self.finish_GameObject = "finish"

    ---@type UISprite
    ---背景图片
    self.Bg_UISprite = "backGround"

    ---@return UnityEngine.GameObject 红包按钮
    self.mRedPacket_Go = "redPacket"

    ---icon1 图片
    ---@type UISprite
    self.mIcon1_Sprite = "icon1"

    ---icon2 背景
    ---@type UISprite
    self.mIcon2_Sprite = "icon2"

    ---未完成GO
    ---@type UnityEngine.GameObject
    self.UnFinish_GO = "unFinish"

    ---@type UISprite 内容对应表icon3
    self.mIcon3_Sprite = "icon3"
    ---@type UISprite  内容对应表icon1
    self.mIcon4_Sprite = "icon4"
    ---@type UISprite 背景对应表icon2
    self.mIcon5_Sprite = "icon5"
end

function UICompetitionPanel_Type3Template:BindEvents()
    if CheckNullFunction(self:GetBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetBtn_Go()).onClick = function(go)
            self:OnGetBrnClicked(go)
        end
    end
    --CS.UIEventListener.Get(self.mRedPacket_Go).onClick = function(go)
    --    self:OnRedPackedClicked(go)
    --end
end

---@param data activityV2.ActivityDataInfo
---@param tableData TABLE.CFG_ACTIVITY_COMMON
function UICompetitionPanel_Type3Template:Refresh(data, tableData, registerNum)
    if tableData == nil then
        return
    end
    if tableData.clientType ~= luaEnumCompetitionType.FirstDrop then
        return
    end

    self.bubbleId = nil
    self.data = data
    self.tblData = tableData
    if data and tableData then
        --  self:ShowGoalInfo(data, tableData)
        self:SetActivityGoalIcon(tableData);
        self:ShowRewardInfo(tableData);
        self:UpdateActivityProcess(tableData, data);
        self:FlushCompleteBtnState(tableData, data);
        self:RefreshColorEct(tableData)
    end
end

--region 左侧的目标以及描述 入口 SetActivityGoalIcon
---@param tableData TABLE.CFG_ACTIVITY_COMMON
--- 设置显示的目标信息
function UICompetitionPanel_Type3Template:SetActivityGoalIcon(tableData)
    local isShowIcon3 = not self:IsItemType()
    if self:IsItemType() then
        local item = self:GetGoalItem(tableData)
        if (item == nil) then
            return
        end
        ---设置目标ICON
        self:GetUIComponentController():SetSpriteName(self.mIcon1_Sprite, item.icon)
        --设置标题名字
        self:GetUIComponentController():SetLabelContent(self.title_UILabel, item.name)

        CS.UIEventListener.Get(self:GetIcon1_Go()).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = item, showRight = false })
        end
    else
        if isShowIcon3 then
            self:GetUIComponentController():SetSpriteName(self.mIcon3_Sprite, tableData.icon3)
            self:GetUIComponentController():SetSpriteName(self.mIcon4_Sprite, tableData.icon)
            self:GetUIComponentController():SetSpriteName(self.mIcon5_Sprite, tableData.icon2)
        end
        self:GetUIComponentController():SetLabelContent(self.title_UILabel, tableData.name)
    end

    self:GetUIComponentController():SetObjectActive(self.mIcon1_Sprite, self:IsItemType())
    self:GetUIComponentController():SetObjectActive(self.mIcon2_Sprite, self:IsItemType())
    self:GetUIComponentController():SetObjectActive(self.mIcon3_Sprite, isShowIcon3)
    self:GetUIComponentController():SetObjectActive(self.mIcon4_Sprite, isShowIcon3)
    self:GetUIComponentController():SetObjectActive(self.mIcon5_Sprite, isShowIcon3)
end

---得到当前目标Item的数据
function UICompetitionPanel_Type3Template:GetGoalItem(tableData)
    local goalIds = tableData.goalIds
    if (goalIds ~= nil and goalIds.list.Count == 0) then
        return
    end
    self.goalId = goalIds.list[0]

    local itemId = self:GetActivityGoal(self.goalId)

    local item = self:GetItem(itemId)

    return item;
end

---根据目标获取目标的指向参数用来拿到Item表
function UICompetitionPanel_Type3Template:GetActivityGoal(id)
    local isExit, data
    isExit, data = CS.Cfg_ActivityGoalsTableManager.Instance:TryGetValue(id)
    if isExit then
        return data.goalParam
    end
    return nil
end

---得到对应道具
function UICompetitionPanel_Type3Template:GetItem(id)
    local isExit, data
    isExit, data = CS.Cfg_ItemsTableManager.Instance:TryGetValue(id)
    if isExit then
        return data
    end
    return nil
end

--endregion

--region 右侧的任务奖励列表 入口为 ShowRewardInfo
---显示奖励信息
---@param tableData TABLE.CFG_ACTIVITY_COMMON
function UICompetitionPanel_Type3Template:ShowRewardInfo(tableData)
    if CS.StaticUtility.IsNull(self:GetRewardListContainer()) then
        return ;
    end
    --刷新奖励
    local showList = self:GetRewardList(tableData);
    --刷新显示
    self:GetRewardListContainer().MaxCount = #showList
    for i = 1, #showList do
        local data = showList[i]
        local go = self:GetRewardListContainer().controlList[i - 1]
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        local num = CS.Utility_Lua.Get(go.transform, "count", "UILabel")

        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(data.id)
        if res then
            icon.spriteName = itemInfo.icon
            local gray = self.data and self.data.leftCount <= 0
            icon.color = gray and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.Normal
            CS.UIEventListener.Get(go).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
            end
        end
        if (data.num == 1) then
            num.text = ""
        else
            num.text = data.num
        end
    end
end

---得到奖励列表
function UICompetitionPanel_Type3Template:GetRewardList(tableData)
    local showList = {}
    --获取数据
    if tableData.award then
        for i = 0, tableData.award.list.Count - 1 do
            local single = tableData.award.list[i]
            if single.list.Count >= 2 then
                local data = {}
                data.id = single.list[0]
                data.num = single.list[1]
                data.type = 1
                data.index = i + 1
                table.insert(showList, data)
            end
        end
    end

    return showList
end

--endregion

--region 进度显示
---更新活动进度
function UICompetitionPanel_Type3Template:UpdateActivityProcess(tableData, data)
    local lastCount = data.leftCount;
    local progressShow = lastCount == 0 and (luaEnumColorType.Red .. tostring(lastCount) .. "[-]") or (luaEnumColorType.Green .. tostring(lastCount) .. "[-]")
    local des = luaEnumColorType.Gray .. string.format(tableData.smallname, progressShow)
    self:GetUIComponentController():SetLabelContent(self.des_UILabel, des)
end
--endregion

--region 奖励按钮状态处理
---刷新完成按钮的状态
function UICompetitionPanel_Type3Template:FlushCompleteBtnState(tableData, data)
    --[[    ---如果是首爆的界面,那么应该现在只有类型为2的(全服类型)
        if data.dataType ~= 1 then
            self:ShowBtnInfo(tableData, data)
            return
        end]]

    self:GetBtnEffectGo():SetActive(self:IsFinish())
    --按钮文字
    self:GetBtn_UILabel().text = ternary(self:IsFinish(), "可领取", luaEnumColorType.Gray .. "未完成")
    self:GetUIComponentController():SetObjectActive(self.btnGet_GameObject, self:IsFinish())
    self:GetBtn_UILabel().gameObject:SetActive(self:IsFinish())

    if self.data then
        local notLeft = self.data.leftCount <= 0
        self:GetUIComponentController():SetObjectActive(self.finish_GameObject, notLeft or self:HasGetReward())
        if notLeft then
            self:GetUIComponentController():SetLabelContent(self.finish_GameObject, luaEnumColorType.Gray .. "已领完")
        end
        self:GetUIComponentController():SetObjectActive(self.UnFinish_GO, self:UnFinishState())
    end
end
--endregion

---@return number 获得任务进度
function UICompetitionPanel_Type3Template:GetMissionState()
    if self.mOwnerPanel then
        return self.mOwnerPanel:GetActivityFinishState(self.data)
    end
end

---@return boolean 任务是完成状态
function UICompetitionPanel_Type3Template:IsFinish()
    return self:GetMissionState() == 1 and self.data.leftCount > 0
end

---@return boolean 任务是已领取状态
function UICompetitionPanel_Type3Template:HasGetReward()
    return self:GetMissionState() == 2
end

---@return boolean 任务是未完成状态
function UICompetitionPanel_Type3Template:UnFinishState()
    return self:GetMissionState() == 0
end

---点击领取奖励
function UICompetitionPanel_Type3Template:OnGetBrnClicked(go)
    if self.data and self.tblData then
        networkRequest.ReqGetActivityReward(self.data.activityId, self.tblData.activityType, self.goalId, 1)
        networkRequest.ReqOpenPanel(self.tblData.clientType)
    else
        if self.bubbleId then
            Utility.ShowPopoTips(go, nil, self.bubbleId)
        end
    end
end

---@return boolean  当前是否有任务可领
---@param data activityV2.ActivityDataInfo
function UICompetitionPanel_Type3Template:GetCurrentGoalInfo(data, tableData)
    local mainPlayer = CS.CSScene.MainPlayerInfo
    if tableData.activityType == LuaEnumCompetitionAimType.ServerFistDrop then
        --表示现在是全服数据
        if data.serverGoalInfo.serverGoalInfos then
            ---@type table<number,activityV2.ServerGoalInfo>
            local serverGoalList = data.serverGoalInfo.serverGoalInfos
            local hasRewardList = data.serverGoalInfo.roleCanRewardGoalId
            for i = 0, serverGoalList.Count - 1 do
                ---@type activityV2.ServerGoalInfo
                local info = serverGoalList[i]
                if info.ok then
                    local id = mainPlayer.ID
                    if id == info.finishRoleId then
                        if not info.award then
                            self.isFirstDropPlayer = true
                            if self.isFirstDropPlayer then
                                self.firstDropData = info
                                self.goalId = info.goalId
                            end
                            return true
                        end
                    end
                    if not self:IsGoalHasReward(hasRewardList, info.goalId) and self.mSecondGoalId == nil then
                        self.isFirstDropPlayer = false
                        self.mSecondGoalId = info.goalId
                        self.mFirstKillPlayerInfo.PlayerId = info.finishRoleId
                        self.mFirstKillPlayerInfo.PlayerName = info.finishName
                        self.mFirstKillPlayerInfo.Sex = info.finishSex
                        self.mFirstKillPlayerInfo.Career = info.finishCarrer
                        return true
                    end
                end
            end
        end
    else
        if (data.serverGoalInfo == nil) then
            return false
        end
        return data.serverGoalInfo.rewardState ~= 0
    end
    return false
end

---判断该目标是否可领
function UICompetitionPanel_Type3Template:IsGoalHasReward(rewardList, goalId)
    if rewardList and rewardList.Count > 0 then
        for i = 0, rewardList.Count - 1 do
            if goalId == rewardList[i] then
                return true
            end
        end
    end
    return false
end

---设置背景颜色
function UICompetitionPanel_Type3Template:SetBGColor(isShow)
    local color = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
    self:GetUIComponentController():SetSpriteColor(self.Bg_UISprite, color)
    self:GetUIComponentController():Apply()
end

---点击红包按钮
function UICompetitionPanel_Type3Template:OnRedPackedClicked()
    local data = {}
    data.ActivityId = self.data.activityId
    data.ActivityType = self.tblData.activityType
    data.GoalId = self.mSecondGoalId
    data.PlayerInfo = self.mFirstKillPlayerInfo
    data.ClientType = self.tblData.clientType
    data.Type = 3
    data.Title = self.redPacketTitle
    uimanager:CreatePanel("UIRedPacketPanel", nil, data)
end

---刷新颜色
---@param tableData TABLE.CFG_ACTIVITY_COMMON
function UICompetitionPanel_Type3Template:RefreshColorEct(tableData)
    local gray = self.data and self.data.leftCount <= 0
    local color = gray and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.Normal
    if self:IsItemType() then
        self:GetUIComponentController():SetSpriteColor(self.mIcon1_Sprite, color)
        self:GetUIComponentController():SetSpriteColor(self.mIcon2_Sprite, color)
    else
        self:GetUIComponentController():SetSpriteColor(self.mIcon3_Sprite, color)
        self:GetUIComponentController():SetSpriteColor(self.mIcon4_Sprite, color)
        self:GetUIComponentController():SetSpriteColor(self.mIcon5_Sprite, color)
    end
end

---@return boolean 是否是特定道具类型
function UICompetitionPanel_Type3Template:IsItemType()
    if self.tblData then
        return self.tblData.activityType == 3002
    end
end

return UICompetitionPanel_Type3Template