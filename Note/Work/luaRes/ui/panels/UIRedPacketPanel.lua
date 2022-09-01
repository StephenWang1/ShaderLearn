---@class UIRedPacketPanel:UIBase 红包界面
local UIRedPacketPanel = {}

--region 组件
---@return UnityEngine.GameObject 关闭界面按钮
function UIRedPacketPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/Panel/close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject 打开红包按钮
function UIRedPacketPanel:GetOpenRedPacketBtn_Go()
    if self.mOpenBtn == nil then
        self.mOpenBtn = self:GetCurComp("WidgetRoot/Panel/bg1/CenterBtn", "GameObject")
    end
    return self.mOpenBtn
end

---@return UnityEngine.GameObject 首页显示
function UIRedPacketPanel:GetCoverPage_Go()
    if self.mCoverPage == nil then
        self.mCoverPage = self:GetCurComp("WidgetRoot/Panel/bg1", "GameObject")
    end
    return self.mCoverPage
end

---@return UISprite 头像icon
function UIRedPacketPanel:GetPlayerHead_UISprite()
    if self.mHeadSp == nil then
        self.mHeadSp = self:GetCurComp("WidgetRoot/Panel/Player/first", "UISprite")
    end
    return self.mHeadSp
end

---@return UILabel 首杀/首爆玩家名字
function UIRedPacketPanel:GetPlayerName_UILabel()
    if self.mPlayerNameLb == nil then
        self.mPlayerNameLb = self:GetCurComp("WidgetRoot/Panel/Player/first/value", "UILabel")
    end
    return self.mPlayerNameLb
end

---@return UILabel 标题名字
function UIRedPacketPanel:GetTitleName_UILabel()
    if self.mTitleLb == nil then
        self.mTitleLb = self:GetCurComp("WidgetRoot/Panel/bg1/thrid", "UILabel")
    end
    return self.mTitleLb
end

---@return UILoopScrollViewPlus 领奖列表
function UIRedPacketPanel:GetRewardList_UILoopScrollViewPlus()
    if self.mGetRewardList == nil then
        self.mGetRewardList = self:GetCurComp("WidgetRoot/Scroll/Grid", "UILoopScrollViewPlus")
    end
    return self.mGetRewardList
end

---@return UnityEngine.GameObject 个人领奖节点
function UIRedPacketPanel:GetSelfGet_Go()
    if self.mSelfGetGo == nil then
        self.mSelfGetGo = self:GetCurComp("WidgetRoot/Panel/Player/second", "GameObject")
    end
    return self.mSelfGetGo
end

---@return UILabel 获取领奖数目
function UIRedPacketPanel:GetRewardNum_UILabel()
    if self.mRewardNumLb == nil then
        self.mRewardNumLb = self:GetCurComp("WidgetRoot/Panel/Player/second/value", "UILabel")
    end
    return self.mRewardNumLb
end

---@return UILabel 领奖道具名字
function UIRedPacketPanel:GetRewardName_UILabel()
    if self.mRewardNameLb == nil then
        self.mRewardNameLb = self:GetCurComp("WidgetRoot/Panel/Player/second/label", "UILabel")
    end
    return self.mRewardNameLb
end

---@return UnityEngine.GameObject 特效
function UIRedPacketPanel:GetEffect_Go()
    if self.mEffect == nil then
        self.mEffect = self:GetCurComp("WidgetRoot/Panel/effect", "GameObject")
    end
    return self.mEffect
end

---@return CSUIEffectLoad
function UIRedPacketPanel:GetEffectLoad()
    if self.mEffectLoad == nil then
        self.mEffectLoad = self:GetCurComp("WidgetRoot/Panel/effect", "CSUIEffectLoad")
    end
    return self.mEffectLoad
end

--endregion

--region  初始化
function UIRedPacketPanel:Init()
    self:AddCollider()
    self:BindEvent()
    self:BindMessage()
end

---@param customData 玩家信息
function UIRedPacketPanel:Show(customData)
    if customData then
        self:RefreshPanel(customData)
    end
end

function UIRedPacketPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetOpenRedPacketBtn_Go()).onClick = function(go)
        self:OpenRedPacket(go)
    end
    CS.UIEventListener.Get(self:GetPlayerHead_UISprite().gameObject).onClick = function(go)
        self:OnPlayerClicked(go)
    end
end

function UIRedPacketPanel:BindMessage()
    UIRedPacketPanel.ResServerRoleRewardMessage = function(msgId, tblData)
        self:RefreshRewardInfo(tblData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServerRoleRewardMessage, UIRedPacketPanel.ResServerRoleRewardMessage)
end

--endregion

--region  UI事件
---点击打开红包
function UIRedPacketPanel:OpenRedPacket(go)
    if self.activityId and self.activityType and self.goalId and self.type and self.clientType then
        networkRequest.ReqGetActivityReward(self.activityId, self.activityType, self.goalId, 1)
        networkRequest.ReqOpenPanel(self.clientType)
        if not CS.StaticUtility.IsNull(self:GetEffect_Go()) then
            self:GetEffect_Go():SetActive(true)
        end
    end
end

---点击玩家
function UIRedPacketPanel:OnPlayerClicked(go)
    if self.playerId and self.playerName then
        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
            roleId = self.playerId,
            roleName = self.playerName,
        })
        -- uimanager:ClosePanel(self)
    end
end

---刷新界面
---@param customData
function UIRedPacketPanel:RefreshPanel(customData)
    --请求用数据
    self.activityId = customData.ActivityId
    self.activityType = customData.ActivityType
    self.goalId = customData.GoalId
    self.type = customData.Type
    self.clientType = customData.ClientType
    self.playerId = customData.PlayerInfo.PlayerId

    self.playerInfo = customData.PlayerInfo

    self:ShowPlayerInfo(customData.PlayerInfo)
    self:ShowOtherInfo(customData)
    self:RefreshName(customData.PlayerInfo, false)
end

---刷新玩家信息
function UIRedPacketPanel:ShowPlayerInfo(playerInfo)
    if playerInfo == nil then
        return
    end
    local sex = playerInfo.Sex
    local career = playerInfo.Career
    if sex and career then
        local head = Utility.GetPlayerHeadIconSpriteName(sex, career)
        self:GetPlayerHead_UISprite().spriteName = head
    end
end

---刷新玩家名字
---@param isOpen boolean 是否开启红包
---@param playerInfo table 玩家信息
function UIRedPacketPanel:RefreshName(playerInfo, isOpen)
    if playerInfo == nil then
        return
    end
    local color = isOpen and luaEnumColorType.Brown or luaEnumColorType.SimpleYellow2
    self.playerName = playerInfo.PlayerName
    if self.playerName then
        self:GetPlayerName_UILabel().text = color .. self.playerName
    end
end

---刷新其他数据
function UIRedPacketPanel:ShowOtherInfo(customData)
    local title = customData.Title
    if title then
        self:GetTitleName_UILabel().text = title
    end
end

---@param tblData activityV2.ServerRoleReward
function UIRedPacketPanel:RefreshRewardInfo(tblData)
    if tblData == nil then
        return
    end
    self:RefreshName(self.playerInfo, true)
    --显示领奖结果
    self:GetCoverPage_Go():SetActive(false)
    --刷新获得奖励
    ---@type activityV2.ItemCountInfo
    local rewardInfos = tblData.randomRewards
    if rewardInfos then
        local rewardInfo = rewardInfos[1]
        if rewardInfo then
            self:RefreshSelfRewardInfo(rewardInfo.count, rewardInfo.itemId)
        end
    end
    local history = tblData.rewardHistorys
    if history then
        history = self:ReverseHistory(history)
        self:RefreshOtherRewardInfo(history)
    end
end

function UIRedPacketPanel:ReverseHistory(history)
    local data = {}
    for i = #history, 1, -1 do
        table.insert(data, history[i])
    end
    return data
end

---刷新个人领奖数据
function UIRedPacketPanel:RefreshSelfRewardInfo(num, itemId)
    self:GetRewardNum_UILabel().text = num
    local itemInfo = self:GetItemInfoCache(itemId)
    if itemInfo then
        self:GetRewardName_UILabel().text = itemInfo.name
    end
end

---刷新其他获得奖励
function UIRedPacketPanel:RefreshOtherRewardInfo(rewardList)

    if rewardList == nil then
        return false
    end
    ---@type activityV2.ServerRoleRed
    if #rewardList > 0 then
        self:GetRewardList_UILoopScrollViewPlus():Init(function(go, line)
            if line < #rewardList then
                local data = rewardList[line + 1]
                if data then
                    self:RefreshRewardLine(go, data)
                    return true
                else
                    return false
                end
            else
                return false
            end
        end)
    end
end

---刷新领奖列表
---@param go UnityEngine.GameObject
---@param serverRoleRed activityV2.ServerRoleRed
function UIRedPacketPanel:RefreshRewardLine(go, serverRoleRed)
    if not CS.StaticUtility.IsNull(go) and serverRoleRed then
        local name = CS.Utility_Lua.Get(go.transform, "player", "UILabel")
        local num = CS.Utility_Lua.Get(go.transform, "value", "UILabel")
        if not CS.StaticUtility.IsNull(name) and not CS.StaticUtility.IsNull(num) then
            name.text = self:GetShowRewardNum(serverRoleRed)
            num.text = self:GetShowRewardInfo(serverRoleRed)
        end
    end
end

---@param data activityV2.ServerRoleRed
function UIRedPacketPanel:GetShowRewardNum(data)
    return data.name
end

function UIRedPacketPanel:GetShowRewardInfo(serverRoleRed)
    ---@type activityV2.ItemCountInfo
    local rewards = serverRoleRed.rewards
    if rewards then
        local reward = rewards[1]
        if reward then
            local itemInfo = self:GetItemInfoCache(reward.itemId)
            if itemInfo then
                return reward.count .. itemInfo.name
            end
        end
    end
    return ""
end

---@return TABLE.CFG_ITEMS 道具信息
function UIRedPacketPanel:GetItemInfoCache(id)
    if id == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToInfo[id] = info
    end
    return info
end

--endregion

--region ondestroy
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServerRoleRewardMessage, UIRedPacketPanel.ResServerRoleRewardMessage)
end
--endregion

return UIRedPacketPanel