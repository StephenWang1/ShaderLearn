---@class UIGuildRedPacketPanel:UIRedPacketPanel 帮会红包界面
local UIGuildRedPacketPanel = {}
setmetatable(UIGuildRedPacketPanel, luaPanelModules.UIRedPacketPanel)

UIGuildRedPacketPanel.mCoinType = LuaEnumCoinType.YuanBao

--region 组件
function UIGuildRedPacketPanel:GetFinishShow_Go()
    if self.mFinishGo == nil then
        self.mFinishGo = self:GetCurComp("WidgetRoot/Panel/Player/noRedPacket", "GameObject")
    end
    return self.mFinishGo
end
--endregion


---@return CSMainPlayerInfo
function UIGuildRedPacketPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSUnionInfoV2
function UIGuildRedPacketPanel:GetUnionInfoV2()
    if self.mUnionInfo == nil and self:GetMainPlayerInfo() then
        self.mUnionInfo = self:GetMainPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfo
end

function UIGuildRedPacketPanel:Init()
    self:AddCollider()
    self:BindEvent()
end

---刷新界面
---@param customData unionV2.ResUnionRedBagInfo 帮会红包数据
function UIGuildRedPacketPanel:RefreshPanel(customData)
    self.Data = customData
    self.mCoinType = customData.moneyId
    local playerInfo = {}
    playerInfo.Sex = customData.sex
    playerInfo.Career = customData.career
    playerInfo.PlayerName = customData.roleName

    self.playerId = customData.rid
    self.playerName = customData.roleName
    self.playerSex = customData.sex
    self.playerCareer = customData.career
    self.mType = customData.type --1=红包券发送 2=扣除自身货币发送

    self:ShowPlayerInfo(playerInfo)
    self:ShowOtherInfo(customData)
    self:RefreshName(playerInfo, customData.state ~= 0)
    --设置特效id
    self:GetEffectLoad().effectId = Utility.IsDiamondItemId(self.mCoinType) and "700264" or "700219"
end

---@param customData unionV2.ResUnionRedBagInfo 帮会红包数据
function UIGuildRedPacketPanel:ShowOtherInfo(customData)
    self:GetTitleName_UILabel().gameObject:SetActive(false)
    self:GetCoverPage_Go():SetActive(customData.state == 0)
    local selfData = self:GetSelfReward(customData.info)
    self:RefreshSelfRewardInfo(selfData, self.mCoinType)
    self:GetSelfGet_Go():SetActive(selfData ~= 0)
    self:GetFinishShow_Go():SetActive(selfData == 0)
    local rewardList = customData.info
    if rewardList then
        table.sort(rewardList, self.SortOtherReward)
        self:RefreshOtherRewardInfo(rewardList)
    end
end

---@param left unionV2.RedBagRoleInfo
---@param right unionV2.RedBagRoleInfo
function UIGuildRedPacketPanel.SortOtherReward(left, right)
    if left == nil or right == nil then
        return false
    end
    if left.time <= right.time then
        return false
    else
        return true
    end
end

---@param rewardList table<number,unionV2.RedBagRoleInfo>
function UIGuildRedPacketPanel:GetSelfReward(rewardList)
    if rewardList then
        for i = 1, #rewardList do
            if self:GetMainPlayerInfo() and rewardList[i].rid == self:GetMainPlayerInfo().ID then
                return rewardList[i].money
            end
        end
    end
    return 0
end

---@param data unionV2.RedBagRoleInfo
function UIGuildRedPacketPanel:GetShowRewardNum(data)
    return data.name
end

---@param data unionV2.RedBagRoleInfo
function UIGuildRedPacketPanel:GetShowRewardInfo(data)
    if data then
        local itemInfo = self:GetItemInfoCache(self.mCoinType)
        if itemInfo then
            return data.money .. CS.Cfg_ItemsTableManager.Instance:GetItemName(itemInfo.id)
        end
    end
    return ""
end

function UIGuildRedPacketPanel:OpenRedPacket(go)
    if self.Data and self.Data.id then
        if self:GetUnionInfoV2() then
            if self.mType == 2 then
                local condition = LuaGlobalTableDeal:GetPersonalRedPackRewardCondition()
                if condition then
                    local result = Utility.IsMainPlayerMatchCondition(condition)
                    if result and result.success == false then
                        ---@type TABLE.CFG_PROMPTFRAME
                        local res, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(490)
                        if res then
                            local str = string.format(info.content, result.param)
                            Utility.ShowPopoTips(go, str, 490)
                            return
                        end
                    end
                end
            else
                if not (self:GetUnionInfoV2():CanMainPlayerGetRedPack()) then
                    Utility.ShowPopoTips(go, self:GetLevelNotEnoughDes(), 303)
                    return
                end
                if not self:GetUnionInfoV2():CanPlayerJoinUnionDayGetRedPack() then
                    local time = self:GetUnionInfoV2():GetPlayerJoinTimeGetRewardDes()
                    if time then
                        local content = self:GetTimeNotEnoughDes()
                        local str = string.format(content, time)
                        Utility.ShowPopoTips(go, str, 310)
                    end
                    return
                end
            end
            networkRequest.ReqRecieveUnionRedBag(self.Data.id)
            self:GetEffect_Go():SetActive(true)
        end
    end
end

---点击玩家
function UIGuildRedPacketPanel:OnPlayerClicked(go)
    if self.playerId and self.playerName and self.playerId ~= self:GetMainPlayerInfo().ID then
        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
            roleId = self.playerId,
            roleName = self.playerName,
            roleSex = self.playerSex,
            roleCareer = self.playerCareer
        })
    end
end

---刷新个人领奖数据
function UIGuildRedPacketPanel:RefreshSelfRewardInfo(num, itemId)
    self:GetRewardNum_UILabel().text = num
    local itemInfo = self:GetItemInfoCache(itemId)
    if itemInfo then
        self:GetRewardName_UILabel().text = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemInfo.id)
    end
end

---获取等级不足提示
function UIGuildRedPacketPanel:GetLevelNotEnoughDes()
    if self.mLevelDes == nil then
        local level = CS.Cfg_GlobalTableManager.Instance:GetReceiveUnionRedPackLevel()
        local res, des = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(303)
        if res then
            self.mLevelDes = string.format(des.content, level)
        end
    end
    return self.mLevelDes
end

---获取时间不足提示
function UIGuildRedPacketPanel:GetTimeNotEnoughDes()
    if self.mTimeDes == nil then
        local res, des = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(310)
        if res then
            self.mLevelDes = des.content
        end
    end
    return self.mLevelDes
end

return UIGuildRedPacketPanel