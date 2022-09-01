---@class UICompetitionPanel_Type4SmallAimTemplate:TemplateBase
local UICompetitionPanel_Type4SmallAimTemplate = {}

function UICompetitionPanel_Type4SmallAimTemplate:Init()
    self:InitComponent()
    self:BindEvent()

end

function UICompetitionPanel_Type4SmallAimTemplate:InitComponent()
    ---任务节点
    ---@type UnityEngine.GameObject
    self.mRoot1_Go = self:Get("Root1", "GameObject")

    ---完成节点
    ---@type UnityEngine.GameObject
    self.mRoot2_Go = self:Get("Root2", "GameObject")

    ---@type UILabel
    ---进度
    self.mProgress_UILabel = self:Get("Root1/progress", "UILabel")

    ---@type UILabel
    ---描述
    self.mDescription_UILabel = self:Get("description", "UILabel")

    ---@type UILabel
    ---奖励数目
    self.mRewardNum_UILabel = self:Get("Root1/Costgold", "UILabel")

    ---@type UISprite
    ---奖励Icon
    self.mRewardIcon_UISprite = self:Get("Root1/Costgold/icon", "UISprite")

    ---@type UnityEngine.GameObject
    ---领奖按钮
    self.mRewardBtn_Go = self:Get("Root1/btn_get", "GameObject")

    ---line
    ---@type UnityEngine.GameObject
    self.mLine_Go = self:Get("pointLine", "GameObject")

    ---完成点
    ---@type UnityEngine.GameObject
    self.mLinePoint_Go = self:Get("pointlight", "GameObject")

    ---@type UISprite
    ---小目标背景
    self.mSmallBg_UISprite = self:Get("smallBg", "UISprite")
end

function UICompetitionPanel_Type4SmallAimTemplate:BindEvent()
    CS.UIEventListener.Get(self.mRewardBtn_Go).onClick = function()
        self:OnRewardBtnClicked()
    end
end

---@param info activityV2.ActivityDataInfo 活动数据
---@param tblData TABLE.CFG_ACTIVITY_COMMON 活动表数据
---@param i number 行数
function UICompetitionPanel_Type4SmallAimTemplate:Refresh(info, tblData, i, isFinalLine)

    self.isFinish = false
    self.hasGet = false
    if info and tblData then
        self.tblData = tblData
        self.data = info
        self.isFinish = CS.CSActivityInfoV2.IsLevelUpAndPrefixCanReward(info)
        self.hasGet = CS.CSActivityInfoV2.IsLevelUpAndPrefixHasReceived(info)
        if not self.hasGet then
            local goalId = tblData.goalIds.list[0]
            local finish, aim = clientTableManager.cfg_activity_goalsManager:GetActivityProgress(goalId)
            if finish and aim then
                local color = finish >= aim and luaEnumColorType.Green or luaEnumColorType.Red
                self.mProgress_UILabel.text = color .. finish .. luaEnumColorType.White .. "/" .. aim
            end
            self:RefreshRewardInfo(tblData)
            self.mRewardBtn_Go:SetActive(self.isFinish)
        end
        self.mDescription_UILabel.text = tblData.smallname
        self.mRoot1_Go:SetActive(not self.hasGet)
        self.mRoot2_Go:SetActive(self.hasGet)
    end

    self.mLine_Go:SetActive(not isFinalLine)
    local isGreenPoint = self.isFinish or self.hasGet
    self.mLinePoint_Go:SetActive(isGreenPoint)

    self.mSmallBg_UISprite.color = i % 2 == 0 and LuaEnumUnityColorType.Transparent or LuaEnumUnityColorType.Normal

    return self.isFinish and not self.hasGet
end

---@param tblData TABLE.CFG_ACTIVITY_COMMON 活动表数据
function UICompetitionPanel_Type4SmallAimTemplate:RefreshRewardInfo(tblData)
    local rewardList = tblData.award.list[0].list
    if rewardList.Count >= 2 then
        local itemID = rewardList[0]
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemID)
        if res then
            self.mRewardIcon_UISprite.spriteName = itemInfo.icon
        end
        local num = rewardList[1]
        self.mRewardNum_UILabel.text = num
    end
end

---领奖
function UICompetitionPanel_Type4SmallAimTemplate:OnRewardBtnClicked()
    if self.data and self.tblData then
        local goalId = self.tblData.goalIds.list[0]
        networkRequest.ReqGetActivityReward(self.data.activityId, self.tblData.activityType, goalId, 1)
        networkRequest.ReqOpenPanel(self.tblData.clientType)
    end
end

return UICompetitionPanel_Type4SmallAimTemplate