---@class UITrainingHorseHintTarget:TemplateBase 驯马提示
local UITrainingHorseHintTarget = {}

---@return UISprite
function UITrainingHorseHintTarget:GetCoinSp()
    if self.mCoinSp == nil then
        self.mCoinSp = self:Get("trainingHorse/Cost/icon", "UISprite")
    end
    return self.mCoinSp
end

---@return UILabel
function UITrainingHorseHintTarget:GetCoinNum()
    if self.mTrainingNum == nil then
        self.mTrainingNum = self:Get("trainingHorse/Cost/count", "UILabel")
    end
    return self.mTrainingNum
end

---@return UnityEngine.GameObject
function UITrainingHorseHintTarget:GetTrainingBtn()
    if self.mTrainingBtn == nil then
        self.mTrainingBtn = self:Get("trainingHorse", "GameObject")
    end
    return self.mTrainingBtn
end

---@return UILabel
function UITrainingHorseHintTarget:GetTrainingTime_Lb()
    if self.mTrainingTime == nil then
        self.mTrainingTime = self:Get("trainingHorse/Num", "UILabel")
    end
    return self.mTrainingTime
end

---@param panel UIFlyShoesPanel
function UITrainingHorseHintTarget:Init(panel)
    self.mOwnerPanel = panel

    self.mOwnerPanel:GetClientEventHandler():AddEvent(CS.CEvent.TrainingHorseHintTargetRefreshed, function()
        self:OnTrainingHorseHintTargetRefreshed()
    end)
    self.mOwnerPanel:GetClientEventHandler():AddEvent(CS.CEvent.GatherSelectAvatarAvoid, function(msgId, type, avatar)
        if type == LuaEnumGatherType.TrainingHorse then
            self:RunForGather(avatar)
        end
    end)
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.TrainingHorseTimeChange, function()
        self:RefreshCoin()
    end)

    CS.UIEventListener.Get(self:GetTrainingBtn()).onClick = function()
        self:OnButtonClicked()
    end
end

function UITrainingHorseHintTarget:IsShowing()
    return self.mIsShowHint and self.mIsTargetExist
end

function UITrainingHorseHintTarget:Initialize()
    self.go:SetActive(false)
    self:RefreshHintTargetLid()
    self:Refresh()
    self:RefreshCoin()
    ---@type CSSceneExt
    local scene = CS.CSSceneExt.Sington
    scene.GatherController:ChangeAvoidRunForGatherState(LuaEnumGatherType.TrainingHorse, false)
end

---绑定状态变化回调
---@param callback function
function UITrainingHorseHintTarget:BindStateChangedCallBack(callback)
    self.mStateChangedCallBack = callback
end

---@private
function UITrainingHorseHintTarget:OnTrainingHorseHintTargetRefreshed()
    self:RefreshHintTargetLid()
    self:Refresh()
end

---@private
function UITrainingHorseHintTarget:RefreshHintTargetLid()
    if CS.CSSceneExt.Sington == nil or CS.CSSceneExt.Sington.TrainingHorseHint == nil then
        self.hintTargetLid = nil
    else
        self.hintTargetLid = CS.CSSceneExt.Sington.TrainingHorseHint.CurrentHintTarget
    end
end

---刷新全部
---@public
function UITrainingHorseHintTarget:Refresh()
    if self:RefreshData() then
        self:RefreshUI()
    end
end

---@private
---@return boolean 是否有变化
function UITrainingHorseHintTarget:RefreshData()
    ---@type CSSceneExt
    local scene = CS.CSSceneExt.Sington
    if scene:getAvatar(self.hintTargetLid) == nil then
        self.hintTargetLid = nil
    end
    local isTargetExist = scene ~= nil and self.hintTargetLid ~= nil and self.hintTargetLid ~= 0
    local isChanged = false
    if self.mIsTargetExist ~= isTargetExist then
        ---目标是否存在
        self.mIsTargetExist = isTargetExist
        isChanged = true
    end
    ---在玩家处于采集或正在前往采集时才显示提示
    local isShowHint = scene ~= nil and scene.GatherController.IsGatheringOrAboutToGathering == false
    if self.mIsShowHint ~= isShowHint then
        ---是否显示提示
        self.mIsShowHint = isShowHint
        isChanged = true
    end
    return isChanged
end

---@private
function UITrainingHorseHintTarget:RefreshUI()
    if CS.StaticUtility.IsNull(self.go) then
        return
    end

    if self:IsShowing() then
        ---显示按钮
        self.go:SetActive(true)
    else
        ---隐藏按钮
        self.go:SetActive(false)
    end
    if self.mStateChangedCallBack ~= nil then
        self.mStateChangedCallBack()
    end
end

---@private
function UITrainingHorseHintTarget:OnUpdate()
    local currentTime = CS.UnityEngine.Time.time
    if self.mTimer ~= nil and currentTime < self.mTimer then
        return
    end
    self.mTimer = currentTime + 0.1
    ---每0.1s刷新一次
    self:Refresh()
end

---@private
function UITrainingHorseHintTarget:OnButtonClicked()
    if self:GetCSScene() == nil then
        return
    end
    if self.hintTargetLid == nil or self.hintTargetLid == 0 then
        self:Refresh()
        return
    end
    local avatar = self:GetCSScene():getAvatar(self.hintTargetLid)
    if avatar == nil then
        self:Refresh()
        return
    end
    self:RunForGather(avatar)
end

function UITrainingHorseHintTarget:RunForGather(avatar)
    if self:GetCSScene() == nil then
        return
    end
    ---尝试前往采集目标
    if self:GetCSScene().GatherController:RunForGather(avatar, true, false, self:GetTrainingHorseCostType()) then
        ---尝试进入自动暂停状态
        CS.CSAutoPauseMgr.Instance:TryEnterPausedState()
    end
end

---@return CSSceneExt
function UITrainingHorseHintTarget:GetCSScene()
    return CS.CSSceneExt.Sington
end

---@return number 驯马消耗 1元宝 2钻石
function UITrainingHorseHintTarget:GetTrainingHorseCostType()
    local currentCost = self:GetCurrentTrainingCost()
    if currentCost == nil then
        return 0
    end
    if currentCost.coinId == LuaEnumCoinType.YuanBao then
        return 1
    else
        return 2
    end
end

---@class TrainingHorseCost
---@field coinId number 货币类型
---@field num number 货币数目
---@field times number 消耗次数

---@return TrainingHorseCost 返回当前驯马消耗道具信息
function UITrainingHorseHintTarget:GetCurrentTrainingCost()
    local info = gameMgr:GetPlayerDataMgr():GetGatherInfo():GetTrainingHorseInfo()
    if info then
        local yuanBaoCost = self:GetYuanBaoCostInfo()
        if yuanBaoCost and yuanBaoCost.times > info.goldTameCount then
            return yuanBaoCost
        end
        return self:GetDiamondCostInfo(info.diamondTameCount + 1)
    end
end

---@return TrainingHorseCost 获得元宝消耗信息
function UITrainingHorseHintTarget:GetYuanBaoCostInfo()
    local skillInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic[800001]
    if skillInfo then
        local costTbl = skillInfo:GetNowSkillsConditionTable()
        local cost = costTbl:GetTameTime()
        if cost and cost.list and #cost.list >= 3 then
            ---@type TrainingHorseCost
            local horseCost = {}
            horseCost.coinId = cost.list[1]
            horseCost.num = cost.list[2]
            horseCost.times = cost.list[3]
            return horseCost
        end
    end
    return self:GetGlobalHorseCostInfo(22846)
end

---@class TrainingDiamondTimes
---@field minTime number 多少次数以前
---@field cost number 每次消耗货币数目
---@field costId number 消耗货币id

---@return TrainingHorseCost 获得钻石消耗信息
function UITrainingHorseHintTarget:GetDiamondCostInfo(times)
    if self.mCostToDiamondInfo == nil then
        self.mCostToDiamondInfo = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22847)
        if info then
            local strs = string.Split(info.value, '&')
            for i = 1, #strs do
                local singleInfo = string.Split(strs[i], '#')
                if #singleInfo >= 3 then
                    ---@type TrainingDiamondTimes
                    local data = {}
                    data.minTime = tonumber(singleInfo[1])
                    data.cost = tonumber(singleInfo[2])
                    data.costId = tonumber(singleInfo[3])
                    table.insert(self.mCostToDiamondInfo, data)
                end
            end
        end
    end
    ---@type TrainingHorseCost
    local CostInfo = {}
    local currentCost = 0
    local currentMinTimes = 0
    local coinId = 0
    for i = 1, #self.mCostToDiamondInfo do
        ---@type TrainingDiamondTimes
        local singleCost = self.mCostToDiamondInfo[i]
        if times > singleCost.minTime then
            currentCost = currentCost + ((singleCost.minTime - currentMinTimes) * singleCost.cost)
            currentMinTimes = singleCost.minTime
        else
            local leaveTime = times - currentMinTimes
            if leaveTime > 0 then
                currentCost = currentCost + (leaveTime * singleCost.cost)
            end
            currentMinTimes = singleCost.minTime
        end
        if coinId == 0 then
            coinId = singleCost.costId
        end
    end
    CostInfo.times = -1
    CostInfo.num = currentCost
    CostInfo.coinId = coinId
    return CostInfo
end

---@return TrainingHorseCost
function UITrainingHorseHintTarget:GetGlobalHorseCostInfo(globalId)
    if self.mGlobalIdToCostInfo == nil then
        self.mGlobalIdToCostInfo = {}
    end
    local horseCost = self.mGlobalIdToCostInfo[globalId]
    if horseCost == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(globalId)
        if info then
            local strs = string.Split(info.value, '#')
            if #strs >= 2 then
                ---@type TrainingHorseCost
                horseCost = {}
                horseCost.coinId = tonumber(strs[1])
                horseCost.num = tonumber(strs[2])
                if #strs >= 3 then
                    horseCost.times = tonumber(strs[3])
                else
                    horseCost.times = -1
                end
                self.mGlobalIdToCostInfo[globalId] = horseCost
            end
        end
    end
    return horseCost
end

---刷新驯马货币信息
function UITrainingHorseHintTarget:RefreshCoin()
    local currentCost = self:GetCurrentTrainingCost()
    if currentCost == nil then
        return
    end

    self.mCurrentCost = currentCost

    local isYuanBao = currentCost.coinId == LuaEnumCoinType.YuanBao
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(currentCost.coinId)
    if luaItemInfo then
        self:GetCoinSp().spriteName = luaItemInfo:GetIcon()
    end
    local info = gameMgr:GetPlayerDataMgr():GetGatherInfo():GetTrainingHorseInfo()
    if info then
        self:GetCoinNum().text = currentCost.num
        self:GetTrainingTime_Lb().gameObject:SetActive(isYuanBao)
        if isYuanBao then
            self:GetTrainingTime_Lb().text = Utility.CombineStringQuickly(luaEnumColorType.Green, "(", currentCost.times - info.goldTameCount, "/", currentCost.times, ")")
        end
    end
end

return UITrainingHorseHintTarget