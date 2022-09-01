---@class UICarnivalPanel_MissionTemplate:TemplateBase
local UICarnivalPanel_MissionTemplate = {}

---@return UILabel 任务目标
function UICarnivalPanel_MissionTemplate:GetMissionAim_UILabel()
    if self.mDesLb == nil then
        self.mDesLb = self:Get("description", "UILabel")
    end
    return self.mDesLb
end

---@return UILabel 可完成次数
function UICarnivalPanel_MissionTemplate:GetFinishTime_UILabel()
    if self.mFinishTime == nil then
        self.mFinishTime = self:Get("missionNum", "UILabel")
    end
    return self.mFinishTime
end

---@return UISprite 奖励
function UICarnivalPanel_MissionTemplate:GetRewardIcon_UISprite()
    if self.mRewardIcon == nil then
        self.mRewardIcon = self:Get("RewardItem/icon", "UISprite")
    end
    return self.mRewardIcon
end

---@return UILabel 奖励数目
function UICarnivalPanel_MissionTemplate:GetRewardNum_UILabel()
    if self.mRewardNum == nil then
        self.mRewardNum = self:Get("RewardItem/count", "UILabel")
    end
    return self.mRewardNum
end

---@return UnityEngine.GameObject 奖励按钮
function UICarnivalPanel_MissionTemplate:GetRewardBtn_Go()
    if self.mRewardBtn == nil then
        self.mRewardBtn = self:Get("btn_get", "GameObject")
    end
    return self.mRewardBtn
end

---@return UILabel 按钮文本
function UICarnivalPanel_MissionTemplate:GetRewardBtn_Lb()
    if self.mRewardBtnLb == nil then
        self.mRewardBtnLb = self:Get("btn_get/Label", "UILabel")
    end
    return self.mRewardBtnLb
end

---@return UISprite 按钮背景
function UICarnivalPanel_MissionTemplate:GetRewardBtn_UISprite()
    if self.mRewardBtnSprite == nil then
        self.mRewardBtnSprite = self:Get("btn_get", "UISprite")
    end
    return self.mRewardBtnSprite
end

---@return UnityEngine.GameObject 奖励特效
function UICarnivalPanel_MissionTemplate:GetRewardBtnEffect_Go()
    if self.mRewardBtnEffect == nil then
        self.mRewardBtnEffect = self:Get("btn_get/effect", "GameObject")
    end
    return self.mRewardBtnEffect
end

---@return UnityEngine.GameObject 领完
function UICarnivalPanel_MissionTemplate:GetRewarded_Go()
    if self.mRewardedGo == nil then
        self.mRewardedGo = self:Get("geted", "GameObject")
    end
    return self.mRewardedGo
end

---@return UILabel 完成次数
function UICarnivalPanel_MissionTemplate:GetFinishTime_Lb()
    if self.mFinishTimeLb == nil then
        self.mFinishTimeLb = self:Get("finishTime", "UILabel")
    end
    return self.mFinishTimeLb
end

---@param panel UICarnivalPanel
function UICarnivalPanel_MissionTemplate:Init(panel)
    self:BindEvents()
    self.mRootPanel = panel
end

function UICarnivalPanel_MissionTemplate:BindEvents()
    CS.UIEventListener.Get(self:GetRewardBtn_Go()).onClick = function(go)
        self:OnRewardBtnClicked(go)
    end
end

---@param data activitiesV2.OneActivitiesInfo
function UICarnivalPanel_MissionTemplate:RefreshMission(data)
    self.mMissionData = data
    local id = data.configId
    local activityInfo = self:GetActivityInfo(id)
    if activityInfo == nil then
        return
    end

    self:GetMissionAim_UILabel().text = activityInfo:GetSmallName()

    if data.goalInfo == nil then
        return
    end

    local aim = activityInfo:GetAwardType().list
    if aim == nil or #aim < 2 then
        return
    end

    local color = ""
    local finishTime = data.goalInfo.finishCount
    local receivedCount = data.goalInfo.receivedCount
    local AimTime = aim[2]
    local rewardTime = finishTime - receivedCount
    local state = receivedCount == AimTime and LuaEnumFinishState.Finish or (rewardTime <= 0 and LuaEnumFinishState.UnFinish or LuaEnumFinishState.CanReceive)
    self.mFinishState = state
    self:SetGray(state == LuaEnumFinishState.Finish)
    color = (state == LuaEnumFinishState.CanReceive) and luaEnumColorType.Green or ""
    self:GetFinishTime_UILabel().text = Utility.CombineStringQuickly(color, finishTime, "[-]/", AimTime)
    self:RefreshReward(activityInfo)

    local btnShow = ""
    local btnSp = "anniu13"
    if state == LuaEnumFinishState.Finish then

    elseif state == LuaEnumFinishState.UnFinish then
        btnShow = "前往"
    else
        btnSp = "anniu12"
        btnShow = rewardTime > 1 and "快速领取" or "领取"
    end

    self:GetRewardBtn_Lb().text = btnShow
    self:GetRewardBtn_UISprite().spriteName = btnSp
    self:GetRewardBtn_Go():SetActive(state ~= LuaEnumFinishState.Finish)
    self:GetRewarded_Go():SetActive(state == LuaEnumFinishState.Finish)
    self:GetRewardBtnEffect_Go():SetActive(state == LuaEnumFinishState.CanReceive)
    --self:GetFinishTime_Lb().text = luaEnumColorType.Gray .. "已完成[-]" .. luaEnumColorType.Green .. "3" .. luaEnumColorType.Gray .. "次[-]"
end

---设置整条置灰
function UICarnivalPanel_MissionTemplate:SetGray(isGray)
    local color = isGray and LuaEnumUnityColorType.Grey or LuaEnumUnityColorType.Normal
    self:GetFinishTime_UILabel().color = color
    self:GetMissionAim_UILabel().color = color
    self:GetRewardNum_UILabel().color = color
    self:GetRewardIcon_UISprite().color = color

end

---@param activityInfo TABLE.cfg_special_activity
function UICarnivalPanel_MissionTemplate:RefreshReward(activityInfo)
    local reward = activityInfo:GetAward()
    if reward and reward.list and #reward.list >= 2 then
        local itemId = reward.list[1]
        local itemNum = reward.list[2]
        local itemInfo = self:CacheItemInfo(itemId)
        if itemInfo then
            self:GetRewardIcon_UISprite().spriteName = itemInfo.icon
            CS.UIEventListener.Get(self:GetRewardIcon_UISprite().gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
            end
        end
        self:GetRewardNum_UILabel().text = itemNum
    end
end

function UICarnivalPanel_MissionTemplate:GetActivityInfo(id)
    if self.mRootPanel then
        return self.mRootPanel:CacheActivityInfo(id)
    end
end

function UICarnivalPanel_MissionTemplate:CacheItemInfo(id)
    if self.mRootPanel then
        return self.mRootPanel:CacheItemInfo(id)
    end
end

function UICarnivalPanel_MissionTemplate:OnRewardBtnClicked(go)
    if self.mFinishState == LuaEnumFinishState.CanReceive then
        if self.mMissionData then
            networkRequest.ReqGetOneActivitiesAward(self.mMissionData.configId)
        end
    elseif self.mFinishState == LuaEnumFinishState.UnFinish then
        self:DealMission()
    end
end

function UICarnivalPanel_MissionTemplate:DealMission()
    if self.mMissionData == nil then
        return
    end
    local id = self.mMissionData.configId
    local activityInfo = self:GetActivityInfo(id)
    if activityInfo == nil then
        return
    end
    local way = activityInfo:GetOpenWay()
    if way == nil then
        return
    end
    local list = way.list
    if list == nil or #list < 2 then
        return
    end
    local type = list[1]
    local info = list[2]
    --类型1:1#cfg_deliverID（点击后直接传送到目标地图坐标）；
    --类型2:2#map_npcID（点击关闭当前界面，寻路到对应npc，然后打开npc面板）
    --类型3:3#npcid 上次去过的主城的npcid
    --类型4:4#jumpid
    if type == 1 then
        --networkRequest.ReqEnterDuplicate(duplicateId)
        local deliverID = tonumber(info)
        if deliverID then
            Utility.TryTransfer(deliverID)
        end
    elseif type == 2 then
        local mapNPCID = ""
        local panelName = ""
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ mapNPCID }, panelName, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, { mapNPCID })
    elseif type == 3 then
        local allList = {}
        for i = 2, #list do
            table.insert(allList, list[i])
        end
        local targetNpc, targetMap = CS.CSMissionManager.Instance:GetMinimumNodeCountNPC(allList)
        if targetNpc then
            ---@type TABLE.CFG_MAP_NPC
            local res, mapNpcInfo = CS.Cfg_MapNpcTableManager.Instance.dic:TryGetValue(targetNpc)
            if res then
                ---@type TABLE.CFG_NPC
                local res, npcInfo = CS.Cfg_NpcTableManager.Instance.dic:TryGetValue(mapNpcInfo.npcid)
                if res then
                    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ targetNpc }, npcInfo.openPanel, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, { targetNpc })
                end
            end
        end
    elseif type == 4 then
        ---特殊处理：充值优先跳转首冲面板
        if (2601 == tonumber(info)) then
            Utility.TryShowFirstRechargePanel()
        else
            uiTransferManager:TransferToPanel(info);
        end
    end
end

return UICarnivalPanel_MissionTemplate