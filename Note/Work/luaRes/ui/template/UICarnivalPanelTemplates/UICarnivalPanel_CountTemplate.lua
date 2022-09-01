---@class UICarnivalPanel_CountTemplate:TemplateBase
local UICarnivalPanel_CountTemplate = {}

---@return UILabel
function UICarnivalPanel_CountTemplate:GetScoreAim_UILabel()
    if self.mScoreAimLb == nil then
        self.mScoreAimLb = self:Get("title/Label", "UILabel")
    end
    return self.mScoreAimLb
end

---@return UIGridContainer 奖励container
function UICarnivalPanel_CountTemplate:GetRewardList_UIGridContainer()
    if self.mRewardContainer == nil then
        self.mRewardContainer = self:Get("reward", "UIGridContainer")
    end
    return self.mRewardContainer
end

---@return UnityEngine.GameObject 奖励按钮
function UICarnivalPanel_CountTemplate:GetRewardBtn_Go()
    if self.mRewardBtn == nil then
        self.mRewardBtn = self:Get("btn_get", "GameObject")
    end
    return self.mRewardBtn
end

---@return UnityEngine.GameObject 奖励特效
function UICarnivalPanel_CountTemplate:GetRewardBtnEffect_Go()
    if self.mRewardBtnEffect == nil then
        self.mRewardBtnEffect = self:Get("btn_get/effect", "GameObject")
    end
    return self.mRewardBtnEffect
end

---@return UILabel 按钮文本
function UICarnivalPanel_CountTemplate:GetRewardBtn_Lb()
    if self.mRewardBtnLb == nil then
        self.mRewardBtnLb = self:Get("btn_get/Label", "UILabel")
    end
    return self.mRewardBtnLb
end

---@return UISprite 按钮背景
function UICarnivalPanel_CountTemplate:GetRewardBtn_UISprite()
    if self.mRewardBtnSprite == nil then
        self.mRewardBtnSprite = self:Get("btn_get", "UISprite")
    end
    return self.mRewardBtnSprite
end

---@return UnityEngine.GameObject 奖励特效
function UICarnivalPanel_CountTemplate:GetRewardBtnEffect_Go()
    if self.mRewardBtnEffect == nil then
        self.mRewardBtnEffect = self:Get("btn_get/effect", "GameObject")
    end
    return self.mRewardBtnEffect
end

---@return UnityEngine.GameObject
function UICarnivalPanel_CountTemplate:GetHasReward_GO()
    if self.mHasRewardGo == nil then
        self.mHasRewardGo = self:Get("has_got", "GameObject")
    end
    return self.mHasRewardGo
end

---@return UnityEngine.GameObject
function UICarnivalPanel_CountTemplate:GetNotFinish_Go()
    if self.mNotFinish == nil then
        self.mNotFinish = self:Get("unfinish", "GameObject")
    end
    return self.mNotFinish
end

---@param panel UICarnivalPanel
function UICarnivalPanel_CountTemplate:Init(panel)
    self.mRootPanel = panel
    self:BindEvents()
end

function UICarnivalPanel_CountTemplate:BindEvents()
    CS.UIEventListener.Get(self:GetRewardBtn_Go()).onClick = function(go)
        self:OnRewardBtnClicked(go)
    end
end

---@param configId number 活动id
---@param state LuaEnumRewardState
---@param extData activitiesV2.ActivitiesPartInfo
function UICarnivalPanel_CountTemplate:RefreshShop(configId, state, extData)
    self.configId = configId
    self.extData = extData
    self.state = state
    if configId == nil or state == nil then
        return
    end
    local tblInfo = self:GetActivityInfo(configId)
    if tblInfo == nil or tblInfo:GetGoal() == nil or #tblInfo:GetGoal().list < 1 then
        return
    end
    local goal = tblInfo:GetGoal().list[1]
    self:GetScoreAim_UILabel().text = goal

    local recharge = extData.bloodOrgyRechargeUnlock == 1

    self:RefreshReward(tblInfo, recharge)

    local isFinish = extData.bloodOrgyPoint >= goal
    self:GetRewardBtn_Go():SetActive(state ~= LuaEnumRewardState.Higher and isFinish)

    local isShowEffect = isFinish and ((not recharge and state == LuaEnumRewardState.UnReward) or (recharge and state == LuaEnumRewardState.Normal))
    self:GetRewardBtnEffect_Go():SetActive(isShowEffect)

    local str = "领取"
    if not recharge and state == LuaEnumRewardState.Normal then
        str = "继续领取"
    end
    self:GetRewardBtn_Lb().text = str
    self:GetHasReward_GO():SetActive(state == LuaEnumRewardState.Higher)
    self:GetNotFinish_Go():SetActive(not isFinish)
end

---@class CarnivalRewardInfo
---@field itemId
---@field num
---@field isLock

---刷新奖励
---@param tblInfo TABLE.cfg_special_activity
---@param isRecharge boolean 是否解锁
function UICarnivalPanel_CountTemplate:RefreshReward(tblInfo, isRecharge)
    local rewardList = {}
    if tblInfo:GetAward() and #tblInfo:GetAward().list >= 2 then
        ---@type CarnivalRewardInfo
        local rewardInfo = {}
        rewardInfo.itemId = tblInfo:GetAward().list[1]
        rewardInfo.num = tblInfo:GetAward().list[2]
        rewardInfo.isLock = false
        table.insert(rewardList, rewardInfo)
    end

    if tblInfo:GetChargeReward() then
        for i = 1, #tblInfo:GetChargeReward().list do
            local info = tblInfo:GetChargeReward().list[i].list
            if #info >= 2 then
                ---@type CarnivalRewardInfo
                local rewardInfo = {}
                rewardInfo.itemId = info[1]
                rewardInfo.num = info[2]
                rewardInfo.isLock = not isRecharge
                table.insert(rewardList, rewardInfo)
            end
        end
    end

    self:GetRewardList_UIGridContainer().MaxCount = #rewardList
    for i = 0, self:GetRewardList_UIGridContainer().controlList.Count - 1 do
        local go = self:GetRewardList_UIGridContainer().controlList[i]
        local template = self:GetRewardTemplate(go)
        if template then
            template:RefreshReward(rewardList[i + 1])
        end
    end
end

---@return UICarnivalPanel_CountRewardTemplate
function UICarnivalPanel_CountTemplate:GetRewardTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICarnivalPanel_CountRewardTemplate, self)
    end
    return template
end

function UICarnivalPanel_CountTemplate:GetAllLockReward()
    if self.mRootPanel then
        return self.mRootPanel:GetAllLockReward()
    end
end

function UICarnivalPanel_CountTemplate:GetActivityInfo(id)
    if self.mRootPanel then
        return self.mRootPanel:CacheActivityInfo(id)
    end
end

function UICarnivalPanel_CountTemplate:OnRewardBtnClicked(go)
    if self.configId and self.state and self.extData then
        local recharge = self.extData.bloodOrgyRechargeUnlock == 1
        if not recharge and self.state == LuaEnumRewardState.Normal then
            uimanager:CreatePanel("UICarnivalItemActivePanel", nil, self:GetAllLockReward())
            return
        end
        networkRequest.ReqGetOneActivitiesAward(self.configId)

    end
end

return UICarnivalPanel_CountTemplate