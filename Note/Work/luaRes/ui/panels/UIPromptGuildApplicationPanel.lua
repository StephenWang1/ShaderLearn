---@class UIPromptGuildApplicationPanel:UIBase 帮会申请界面
local UIPromptGuildApplicationPanel = {}

--region 属性
---@return CSUnionInfoV2 玩家帮会信息
function UIPromptGuildApplicationPanel:GetUnionInfoV2()
    if self.mGuildV2Info == nil then
        if self:GetPlayerInfo() then
            self.mGuildV2Info = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mGuildV2Info
end

---@return CSMainPlayerInfo 玩家信息
function UIPromptGuildApplicationPanel:GetPlayerInfo()
    if self.playerInfo == nil then
        self.playerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.playerInfo
end

---@return CSBagInfoV2 背包信息
function UIPromptGuildApplicationPanel:GetBagInfoV2()
    if self.mBagV2Info == nil then
        self.mBagV2Info = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagV2Info
end

--endregion

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIPromptGuildApplicationPanel:GetCloseBtn()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return self.mCloseBtn
end

---@type UILabel 标题文本
function UIPromptGuildApplicationPanel:GetTitle_UILabel()
    if self.mTitleLabel == nil then
        self.mTitleLabel = self:GetCurComp("WidgetRoot/view/Title", "UILabel")
    end
    return self.mTitleLabel
end

---@type UILabel 会长文本
function UIPromptGuildApplicationPanel:GetLeader_UILabel()
    if self.mLeaderLabel == nil then
        self.mLeaderLabel = self:GetCurComp("WidgetRoot/view/lb_leaderName", "UILabel")
    end
    return self.mLeaderLabel
end

---@type UILabel 成员数文本
function UIPromptGuildApplicationPanel:GetMember_UILabel()
    if self.mMemberLabel == nil then
        self.mMemberLabel = self:GetCurComp("WidgetRoot/view/lb_guildmember", "UILabel")
    end
    return self.mMemberLabel
end

---@type UILabel 排名文本
function UIPromptGuildApplicationPanel:GetRank_UILabel()
    if self.mRankLabel == nil then
        self.mRankLabel = self:GetCurComp("WidgetRoot/view/lb_guildrank", "UILabel")
    end
    return self.mRankLabel
end

---@type UILabel 管辖城市文本
function UIPromptGuildApplicationPanel:GetManageCity_UILabel()
    if self.mManageCityLabel == nil then
        self.mManageCityLabel = self:GetCurComp("WidgetRoot/view/lb_managecity", "UILabel")
    end
    return self.mManageCityLabel
end

---@return UnityEngine.GameObject 申请按钮
function UIPromptGuildApplicationPanel:GetApplyBtn()
    if self.mApplyBtn == nil then
        self.mApplyBtn = self:GetCurComp("WidgetRoot/events/CenterBtn", "GameObject")
    end
    return self.mApplyBtn
end

---@type UILabel 申请按钮文本
function UIPromptGuildApplicationPanel:GetApplyBtn_UILabel()
    if self.mApplyBtnLabel == nil then
        self.mApplyBtnLabel = self:GetCurComp("WidgetRoot/events/CenterBtn/Label", "UILabel")
    end
    return self.mApplyBtnLabel
end

--endregion

--region 初始化
function UIPromptGuildApplicationPanel:Init()
    self:BindEvent()
end

---@param data unionV2.UnionInfo 帮会信息
function UIPromptGuildApplicationPanel:Show(data)
    self.unionInfo = data
    if data then
        self:RefreshPanelShow(data)
    end
end

function UIPromptGuildApplicationPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetApplyBtn()).onClick = function(go)
        self:OnApplyBtnClicked(go)
    end
end
--endregion

--regionUI事件

--region 发起申请
function UIPromptGuildApplicationPanel:OnApplyBtnClicked(go)
    if self.unionInfo then
        if Utility.IsSabacActivityNotOpen(go) then
            local notHasUnion = self:GetUnionInfoV2().UnionID == 0
            if notHasUnion then
                local cd = self:GetUnionInfoV2():GetExitCD()
                if CS.StaticUtility.IsNullOrEmpty(cd) then
                    networkRequest.ReqJoinOrWithdrawUnion(self.unionInfo.unionId, self.unionInfo.applyState)
                    self:ClosePanel()
                else
                    if self:GetExitUnionCDDes() then
                        Utility.ShowPopoTips(go, string.format(self:GetExitUnionCDDes(), cd), 210)
                    end
                end
            else
                local customData = {}
                customData.ID = 86
                customData.CenterCostID = self:GetCombineUnionCost(0)
                customData.CenterCostNum = self:GetCombineUnionCost(1)
                customData.CenterCallBack = function(go)
                    if self:IsCombineCostEnough() then
                        networkRequest.ReqCombineUnion(self.unionInfo.unionId)
                        self:ClosePanel()
                        uimanager:ClosePanel("UIGuildAccusePromptPanel")
                    else
                        Utility.ShowPopoTips(go, self:GetMoneyNotEnoughDes(), 160)
                    end
                end
                uimanager:CreatePanel("UIGuildAccusePromptPanel", nil, customData)
            end
        end
    end
end

---@return string 退会CD提示
function UIPromptGuildApplicationPanel:GetExitUnionCDDes()
    if self.mExitUnionCD == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(210)
        if res then
            self.mExitUnionCD = desInfo.content
        end
    end
    return self.mExitUnionCD
end

---@return string 货币不足提示
function UIPromptGuildApplicationPanel:GetMoneyNotEnoughDes()
    if self.mMoneyDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(160)
        if res and self:GetUnionCostItemInfo() then
            self.mMoneyDes = string.format(desInfo.content, self:GetUnionCostItemInfo().name)
        end
    end
    return self.mMoneyDes
end

---@return boolean 合并帮会货币是否足够
function UIPromptGuildApplicationPanel:IsCombineCostEnough()
    if self:GetBagInfoV2() then
        local playerHas = self:GetBagInfoV2():GetCoinAmount(self:GetCombineUnionCost(0))
        --if res then
        return playerHas >= self:GetCombineUnionCost(1)
        --end
    end
    return false
end

---@return TABLE.CFG_ITEMS 获取花费道具ItemInfo
function UIPromptGuildApplicationPanel:GetUnionCostItemInfo()
    if self.mCostItemInfo == nil then
        ___, self.mCostItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self:GetCombineUnionCost(0))
    end
    return self.mCostItemInfo
end

---@return  number 获取合并帮会花费
---@param type number 货币id:0/货币数目:1
function UIPromptGuildApplicationPanel:GetCombineUnionCost(type)
    if self.mCombineCost == nil then
        self.mCombineCost = CS.Cfg_GlobalTableManager.Instance:CombineUnionCost()
    end
    if self.mCombineCost then
        return self.mCombineCost[type]
    end
    return 0
end

--endregion

--region 刷新显示
---刷新界面显示
---@param data unionV2.UnionInfo 帮会信息
function UIPromptGuildApplicationPanel:RefreshPanelShow(data)
    if not CS.StaticUtility.IsNull(self:GetTitle_UILabel()) then
        self:GetTitle_UILabel().text = data.unionName
    end
    if not CS.StaticUtility.IsNull(self:GetLeader_UILabel()) then
        local name = ternary(CS.StaticUtility.IsNullOrEmpty(data.leaderName), "待定", data.leaderName)
        self:GetLeader_UILabel().text = name
    end

    if not CS.StaticUtility.IsNull(self:GetRank_UILabel()) then
        self:GetRank_UILabel().text = data.rank
    end
    if not CS.StaticUtility.IsNull(self:GetMember_UILabel()) then
        self:GetMember_UILabel().text = Utility.GetUnionActiveValue(data.rank)
    end

    local showLabel = ""
    --是否显示按钮
    local isShowBtn = true
    local hasUnion = self:GetUnionInfoV2().UnionID ~= 0
    if hasUnion then
        --有帮会
        if self:GetUnionInfoV2():IsLeader() then
            --会长
            showLabel = "合并"
            local isCD = self:GetUnionInfoV2():IsCombineCD(self:GetUnionInfoV2().UnionInfo.unionInfo.lastCombineTime)
            local dataCD = self:GetUnionInfoV2():IsCombineCD(data.lastCombineTime)
            if isCD or dataCD then
                --本帮CD中或者对方CD中不显示
                isShowBtn = false
            else
                if data.unionId == self:GetUnionInfoV2().UnionID then
                    --本帮不显示
                    isShowBtn = false
                else
                    --本帮前二且对方前二 不显示
                    local selfRank = self:GetUnionInfoV2().UnionInfo.unionInfo.rank
                    local dataRank = data.rank
                    isShowBtn = not (selfRank and dataRank and selfRank <= 2 and dataRank <= 2)
                end
            end
            --对方或自己是沙城霸主不显示
            local sabacManagerId = self:GetPlayerInfo().Data.sabacUnionId
            local selfID = self:GetUnionInfoV2().UnionID
            local otherID = data.unionId
            if selfID == sabacManagerId or otherID == sabacManagerId then
                isShowBtn = false
            end
        else
            --非会长
            isShowBtn = false
        end
    else
        --没帮会
        showLabel = ternary(data.applyState == 2, "撤销申请", "申请加入")
        isShowBtn = true
    end
    if not CS.StaticUtility.IsNull(self:GetApplyBtn()) then
        self:GetApplyBtn_UILabel().text = showLabel
    end
    local unionMember = data.unionNum
    local limitMember = CS.Cfg_GlobalTableManager.Instance:GetMemberLimit()
    --人数上限不显示
    if limitMember > 0 and unionMember > limitMember then
        isShowBtn = false
    end

    self:GetApplyBtn():SetActive(isShowBtn)

    if not CS.StaticUtility.IsNull(self:GetManageCity_UILabel()) then
        if data.seizeCityId ~= 0 then
            ---@type TABLE.CFG_MAP
            local isFind, tbl = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(data.seizeCityId)
            if isFind then
                self:GetManageCity_UILabel().text = tbl.name
            else
                self:GetManageCity_UILabel().text = "无管辖城市"
            end
        else
            self:GetManageCity_UILabel().text = "无管辖城市"
        end
    end
end
--endregion

--endregion

return UIPromptGuildApplicationPanel