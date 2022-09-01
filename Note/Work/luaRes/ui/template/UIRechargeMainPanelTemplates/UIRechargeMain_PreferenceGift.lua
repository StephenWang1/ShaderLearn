---充值主面板--特惠礼包
---@class UIRechargeMain_PreferenceGift:TemplateBase
local UIRechargeMain_PreferenceGift = {}

UIRechargeMain_PreferenceGift.AllTotalRechargeCount = 0

---@return UnityEngine.GameObject
function UIRechargeMain_PreferenceGift:GetRewardBG_GameObject()
    if self.mRewardBG_GameObject == nil then
        self.mRewardBG_GameObject = self:Get("Sprite_reward", "GameObject")
    end
    return self.mRewardBG_GameObject
end

---@return UnityEngine.GameObject 领奖标题
function UIRechargeMain_PreferenceGift:GetRewardTitle_GameObject()
    if self.mRewardTitle == nil then
        self.mRewardTitle = self:Get("Sprite_reward/title", "GameObject")
    end
    return self.mRewardTitle
end

---@return UnityEngine.GameObject 领奖描述
function UIRechargeMain_PreferenceGift:GetRewardContent_GameObject()
    if self.mRewardContent == nil then
        self.mRewardContent = self:Get("Sprite_reward/slogan_bg", "GameObject")
    end
    return self.mRewardContent
end

---@return UnityEngine.GameObject
function UIRechargeMain_PreferenceGift:GetLastRechargeSlogan_GameObject()
    if (self.mLastRechargeSlogan_GameObject == nil) then
        self.mLastRechargeSlogan_GameObject = self:Get("Sprite_reward/slogan_lastbuy", "GameObject")
    end
    return self.mLastRechargeSlogan_GameObject
end

---@param go UnityEngine.GameObject
---@return UIRechargeRewardTemplate
function UIRechargeMain_PreferenceGift:GetRewardTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIRechargeRewardTemplate, self.rootPanel)
    end
    return template
end

---@return UIScrollView
function UIRechargeMain_PreferenceGift:GetScrollViewReward()
    if self.mScrollViewReward == nil then
        self.mScrollViewReward = self:Get("ScrollViewReward", "UIScrollView")
    end
    return self.mScrollViewReward
end

---@return UILoopScrollViewPlus 领奖格子控制组件
function UIRechargeMain_PreferenceGift:GetReward_UILoopScrollViewPlus()
    if self.mRewardGridContainer == nil then
        self.mRewardGridContainer = self:Get("ScrollViewReward/Grid", "UILoopScrollViewPlus")
    end
    return self.mRewardGridContainer
end

---@return CSMainPlayerInfo
function UIRechargeMain_PreferenceGift:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@type UICompetitionPanel
function UIRechargeMain_PreferenceGift:Init(panel)
    self.rootPanel = panel
end

function UIRechargeMain_PreferenceGift:Refresh()
    self:RefreshData()
    self:GetRewardBG_GameObject():SetActive(true)
    self:GetRewardTitle_GameObject():SetActive(true)
    self:GetRewardContent_GameObject():SetActive(true)
    self:GetLastRechargeSlogan_GameObject():SetActive(false)
    self:RefreshRewardShow(self:GetPreferenceShowList(), self.onlineTime)
    if (#self:GetPreferenceShowList() == 0) then
        self.rootPanel.showBookMark = nil
        self.rootPanel:Init()
        self.rootPanel:RefreshUI()
    end
end

function UIRechargeMain_PreferenceGift:RefreshData()
    self.ShowPreferenceList = {}
    ---@type rechargegiftboxV2.RechargeGiftBoxInfo
    local csData = self:GetPlayerInfo().RechargeInfo.CurrentRechargeGiftBoxInfo
    local buyRewardList = csData.buyTimes

    --region 添加元宝礼包
    local openserverDays = CS.CSScene.MainPlayerInfo.ActualOpenDays
    self:AddIngotPurchaseReward(buyRewardList, openserverDays)
    --endregion

    --region 添加直购列表
    local buyInfo
    self.GMId = 0
    buyInfo, self.GMId = CS.CSRechargeInfoV2.GetBuyRewardInfo(buyRewardList)
    local gminfo, info = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(self.GMId)
    if (gminfo) then
        self.mBuyAllRewardInfo = info
    end
    self:AddBuyingReward(buyInfo, self.ShowPreferenceList, self.LastRechargeList)
    --endregion
end

---刷新列表显示
function UIRechargeMain_PreferenceGift:RefreshRewardShow(ShowList, onlineTime)
    if not CS.StaticUtility.IsNull(self:GetReward_UILoopScrollViewPlus()) then
        self:GetReward_UILoopScrollViewPlus():Init(function(go, line)
            local count = #ShowList <= 5 and #ShowList or 5
            if line < count then
                ---只显示4个礼包
                local data = ShowList[line + 1]
                local template = self:GetRewardTemplate(go)
                if template then
                    template:Refresh(data, onlineTime, self.selectRewardID)
                end
                return true
            else
                return false
            end

            self.NeedShowArrow = #ShowList > 3
            self:RewardRefreshArrow()
        end, nil)
    end
end

---添加直购礼包
function UIRechargeMain_PreferenceGift:AddBuyingReward(buyInfo, ShowList, LastRechargeList)
    --local addNum = 0
    local sortTable = {}
    for i = 0, buyInfo.Count - 1 do
        local id = buyInfo[i]
        table.insert(sortTable, id)
    end
    table.sort(sortTable, self.SortBuyingReward)
    CS.CSRechargeInfoV2.LastRechargeTableList:Clear()
    for j = 1, #sortTable do
        local id = sortTable[j]
        local data = {}
        data.id = id
        local tableInfo = self:GetBuyTableData(id)
        data.tableInfo = tableInfo
        if (tableInfo.isTimeLimit == 2) then
            --终生限购礼包
            if (LastRechargeList ~= nil) then
                data.type = luaEnumRechargeRewardType.LastRecharge
                table.insert(LastRechargeList, data)
                CS.CSRechargeInfoV2.LastRechargeTableList:Add(tableInfo)
            end
        else
            data.type = tableInfo.isTimeLimit == 1 and luaEnumRechargeRewardType.LimitBuy or luaEnumRechargeRewardType.Buy
            if tableInfo.isTimeLimit == 1 then
                if (tableInfo.conditions ~= nil) then
                    local conditionList = string.Split(tableInfo.conditions, '&')
                    if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(conditionList)) then
                        local days = tableInfo.effectiveTime
                        if CS.CSRechargeInfoV2.IsShowReward(days) then
                            table.insert(ShowList, data)
                        end
                    end
                else
                    local days = tableInfo.effectiveTime
                    if CS.CSRechargeInfoV2.IsShowReward(days) then
                        table.insert(ShowList, data)
                    end
                end
            else
                if (self.AllTotalRechargeCount >= 500) then
                    table.insert(ShowList, data)
                else
                    --if addNum < 4 then
                    table.insert(ShowList, data)
                    --addNum = addNum + 1
                    --end
                end
            end
        end
    end
end

---添加元宝礼包
function UIRechargeMain_PreferenceGift:AddIngotPurchaseReward(buyInfo, openServerDay)
    for i = 0, buyInfo.Count - 1 do
        local tableinfo = self:GetBuyTableData(buyInfo[i].id)
        if (tableinfo ~= nil and tableinfo.type == LuaEnumRechargeType.IngotPurchase) then
            ---@type TABLE.CFG_RECHARGE
            if (tableinfo ~= nil and self:IsOpenDaysEnough(openServerDay, tableinfo.effectiveTime) and buyInfo[i].todayBuyTimes < 1) then
                local data = {}
                data.id = tableinfo.id
                data.type = luaEnumRechargeRewardType.IngotRecharge
                data.tableInfo = tableinfo
                if (tableinfo.storeIndex ~= 0) then
                    if (CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(LuaEnumStoreType.DiamondRechargeGift)
                            and CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic[LuaEnumStoreType.DiamondRechargeGift].storeUnitDic:TryGetValue(tableinfo.storeIndex)) then
                        table.insert(self.ShowPreferenceList, data)
                    end
                else
                    table.insert(self.ShowPreferenceList, data)
                end
            end
        end
    end
end

---@return TABLE.CFG_RECHARGE 充值表
function UIRechargeMain_PreferenceGift:GetBuyTableData(id)
    if self.mIdToBuyTableInfo == nil then
        self.mIdToBuyTableInfo = {}
    end
    local data = self.mIdToBuyTableInfo[id]
    if data == nil then
        ___, data = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(id)
        self.mIdToBuyTableInfo[id] = data
    end
    return data
end

function UIRechargeMain_PreferenceGift:IsOpenDaysEnough(OpenDays, LimitTime)
    if (LimitTime.list.Count >= 2 and OpenDays >= LimitTime.list[0] and OpenDays <= LimitTime.list[1]) then
        return true
    end
    return false
end

---获取特惠礼包
function UIRechargeMain_PreferenceGift:GetPreferenceShowList()
    local finalShowList = {}
    if (self.ShowPreferenceList ~= nil) then
        for i = 1, #self.ShowPreferenceList do
            table.insert(finalShowList, self.ShowPreferenceList[i])
        end
    end
    self:SortShowList(finalShowList)
    return finalShowList
end

---对显示的列表进行排序,直购和限时按照
function UIRechargeMain_PreferenceGift:SortShowList(showList)
    if showList == nil then
        return
    end
    ---当前仅对直购和限时礼包进行排序(领奖中当前只有这两个类型礼包),根据礼包的价格从前往后排序
    table.sort(showList, function(left, right)
        if left == nil or right == nil or left.tableInfo == nil or right.tableInfo == nil then
            return false
        end
        left.priority = self:GetRechargeTypePriority(left.tableInfo.type);
        right.priority = self:GetRechargeTypePriority(right.tableInfo.type);

        if (left.priority < right.priority) then
            return true
        elseif (left.priority > right.priority) then
            return false
        end
        if (left.tableInfo.type == 3) then
            return true
        end

        if left.tableInfo.type ~= 6 and right.tableInfo.type == 6 then
            return false
        end
        if left.tableInfo.type == 6 and right.tableInfo.type ~= 6 then
            return true
        end

        if ((left.tableInfo.type == 13 and right.tableInfo.type == 13)) then
            return left.tableInfo.index < right.tableInfo.index
        end

        if ((left.tableInfo.index == 1 and right.tableInfo.index ~= 1) or (left.tableInfo.index ~= 1 and right.tableInfo.index == 1)) then
            return left.tableInfo.index < right.tableInfo.index
        end

        if left.rmbCount == nil then
            if left.tableInfo.clientPrice ~= 0 then
                left.rmbCount = left.tableInfo.clientPrice
            else
                left.rmbCount = left.tableInfo.rmb
            end
        end
        if right.rmbCount == nil then
            if right.tableInfo.clientPrice ~= 0 then
                right.rmbCount = right.tableInfo.clientPrice
            else
                right.rmbCount = right.tableInfo.rmb
            end
        end
        if left.rmbCount ~= right.rmbCount then
            return left.rmbCount < right.rmbCount
        else
            if left.tableInfo.isTimeLimit == right.tableInfo.isTimeLimit then
                return false
            else
                if left.tableInfo.isTimeLimit == 1 then
                    return true
                else
                    return false
                end
            end
        end
    end)
end

---根据类型筛选不同的充值优先级, 数值越小越优先
function UIRechargeMain_PreferenceGift:GetRechargeTypePriority(type)
    if (type == 1) then
        return 10;
    end
    if (type == 4) then
        return 100;
    end

    return 1000
end

return UIRechargeMain_PreferenceGift