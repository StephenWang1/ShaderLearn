---@class UIMonsterHunterActivePanel:UIBase 猎魔人激活面板
local UIMonsterHunterActivePanel = {}

UIMonsterHunterActivePanel.ShowWord = {
    [1] = "激活猎魔人可领取累计的奖励:",
    [2] = "激活高级猎魔人认证\n可领取高级猎魔人奖励",
}

UIMonsterHunterActivePanel.cardID = 21

--region 属性
---@return CSMainPlayerInfo 主角信息
function UIMonsterHunterActivePanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSActivityInfoV2
function UIMonsterHunterActivePanel:GetActivityInfo()
    if self.mActivityInfo == nil and self:GetMainPlayerInfo() then
        self.mActivityInfo = self:GetMainPlayerInfo().ActivityInfo
    end
    return self.mActivityInfo
end


--endregion

--region 组件

---@return UnityEngine.GameObject 关闭按钮
function UIMonsterHunterActivePanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return self.mCloseBtn
end

--region ActiveHunterPanel

---@return UnityEngine.GameObject panel整体
function UIMonsterHunterActivePanel:GetActiveHunterPanel_GameObject()
    if self.mActiveHunterPanel == nil then
        self.mActiveHunterPanel = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel", "GameObject")
    end
    return self.mActiveHunterPanel
end

---@return UnityEngine.GameObject 有卡标记
function UIMonsterHunterActivePanel:GetHasCardSign_GameObject()
    if self.mHasCardSign == nil then
        self.mHasCardSign = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Sign", "GameObject")
    end
    return self.mHasCardSign
end

---@return UnityEngine.GameObject 认证标记
function UIMonsterHunterActivePanel:GetAuthenticationSign_GameObject()
    if self.mAuthenticationSign == nil then
        self.mAuthenticationSign = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/authentication", "GameObject")
    end
    return self.mAuthenticationSign
end

---@return UnityEngine.GameObject 锁标记
function UIMonsterHunterActivePanel:GetLock_GameObject()
    if self.mLockGo == nil then
        self.mLockGo = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Lock", "GameObject")
    end
    return self.mLockGo
end

---@return UILabel 有效日期
function UIMonsterHunterActivePanel:GetTime_UILabel()
    if self.mTimeLabel == nil then
        self.mTimeLabel = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Time", "UILabel")
    end
    return self.mTimeLabel
end

---@return UISprite 背景
function UIMonsterHunterActivePanel:GetActiveBg_UISprite()
    if self.mActiveBgObj == nil then
        self.mActiveBgObj = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/active/bg", "UISprite")
    end
    return self.mActiveBgObj
end

---@return UILabel 显示内容
function UIMonsterHunterActivePanel:GetShowLabel_UILabel()
    if self.mShowLabel == nil then
        self.mShowLabel = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/active/Label", "UILabel")
    end
    return self.mShowLabel
end

---@return GameObject 无可获取
function UIMonsterHunterActivePanel:GetNoGet_GameObject()
    if self.mNoGetObj == nil then
        self.mNoGetObj = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/NoGet", "GameObject")
    end
    return self.mNoGetObj
end

---奖励scroll
function UIMonsterHunterActivePanel:GetRewardScroll_GameObject()
    if self.mRewardScroll == nil then
        self.mRewardScroll = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/active/Scroll", "GameObject")
    end
    return self.mRewardScroll
end

---@return UnityEngine.GameObject 可领奖特效Go
function UIMonsterHunterActivePanel:GetCanRewardEffect_Go()
    if self.mCanRewardGo == nil then
        self.mCanRewardGo = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Btn/Background/effect", "GameObject")
    end
    return self.mCanRewardGo
end

--endregion

---@return UIGridContainer 激活累计奖励
function UIMonsterHunterActivePanel:GetRewardList_UIGridContainer()
    if self.mRewardList == nil then
        self.mRewardList = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/active/Scroll/rewardlist", "UIGridContainer")
    end
    return self.mRewardList
end

---@return UnityEngine.GameObject 激活按钮
function UIMonsterHunterActivePanel:GetCenterBtn_GameObject()
    if self.mCenterBtn == nil then
        self.mCenterBtn = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Btn", "GameObject")
    end
    return self.mCenterBtn
end

---@return UILabel 激活按钮文字
function UIMonsterHunterActivePanel:GetCenterBtnLabel_UILabel()
    if self.mCenterBtnLabel == nil then
        self.mCenterBtnLabel = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Btn/Label", "UILabel")
    end
    return self.mCenterBtnLabel
end

---@return UILabel 激活按钮文BG
function UIMonsterHunterActivePanel:GetCenterBtnBg_UISprite()
    if self.mCenterBtnBg == nil then
        self.mCenterBtnBg = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Btn/Background", "UISprite")
    end
    return self.mCenterBtnBg
end

---@return UnityEngine.GameObject 可领文本
function UIMonsterHunterActivePanel:GetCanGetWord_Go()
    if self.mCanGetGo == nil then
        self.mCanGetGo = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/canget", "GameObject")
    end
    return self.mCanGetGo
end
--endregion

--region ActiveItemPanel

function UIMonsterHunterActivePanel:GetItemInfo_GridContainer()
    if self.mRewardCont == nil then
        self.mRewardCont = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/active/Scroll/rewardlist", "UIGridContainer")
    end
    return self.mRewardCont
end

---@return UISprite icon
function UIMonsterHunterActivePanel:GetIcon_UISprite()
    if self.mItemIcon == nil then
        self.mItemIcon = self:GetCurComp("WidgetRoot/view/ActiveItemPanel/UIItem/icon", "UISprite")
    end
    return self.mItemIcon
end

---@return UILabel count
function UIMonsterHunterActivePanel:GetItemNum_UILabel()
    if self.mItemNumLabel == nil then
        self.mItemNumLabel = self:GetCurComp("WidgetRoot/view/ActiveItemPanel/UIItem/count", "UILabel")
    end
    return self.mItemNumLabel
end

--endregion

--region 初始化
function UIMonsterHunterActivePanel:Init()
    self:BindEvent()
    self:InitData()
    self.bgHeight = self:GetActiveBg_UISprite().height
    self.ScroolPos = self:GetRewardScroll_GameObject().transform.localPosition
end

function UIMonsterHunterActivePanel:InitData()
    self.ShowTxtWord = CS.Cfg_GlobalTableManager.Instance.bossScoreViewTxtArray
    self.ShowBtnWord = CS.Cfg_GlobalTableManager.Instance.bossScoreBtnTxtArray
end

function UIMonsterHunterActivePanel:Show(customData)
    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.LieMoRen
    if customData.type then
        self:GetActiveHunterPanel_GameObject():SetActive(true)
        self.isCard = customData.isCard
        self.data = customData
        local needChange = false
        local coinList
        if self.isCard then
            coinList = self:GetCurrentCanReward()
        else
            needChange = true
            coinList = self:GetCurrentCanReward()
            if #coinList <= 0 then
                coinList = self:GetAllCanReward()
                needChange = false
            end
        end
        self:RefreshRewardInfo(coinList)
        self:GetCanGetWord_Go():SetActive(self.data.isCard and coinList and #coinList > 0)
        local hasReward = coinList ~= nil and #coinList ~= 0
        self:RefershActiveHunterPanel(hasReward, needChange)
    end
end

function UIMonsterHunterActivePanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetCenterBtn_GameObject()).onClick = function()
        if self.isCard then
            networkRequest.ReqLieMoRenGetReward()
        else
            self:ReqRecharge()
        end
        self:ClosePanel()
    end
end
--endregion

--region UI事件
function UIMonsterHunterActivePanel:RefershActiveHunterPanel(hasReward, needChange)
    if self.data == nil then
        return
    end
    local getTxt = ''
    if self.ShowTxtWord ~= nil and self.ShowTxtWord.Length > 0 then
        if not self.data.isCard then
            if hasReward then
                getTxt = self.ShowTxtWord[0]
            else
                getTxt = self.ShowTxtWord[1]
            end
        else
            if hasReward then
                getTxt = self.ShowTxtWord[2]
            else
                getTxt = self.ShowTxtWord[3]
            end
        end
    end
    getTxt = string.gsub(getTxt, '\\n', '\n')
    if needChange then
        getTxt = "[fffab3]已累计奖励"
    end

    local btnTxt = ''
    if self.ShowBtnWord ~= nil and self.ShowBtnWord.Length > 0 then
        if not self.data.isCard then
            if hasReward then
                btnTxt = self.ShowBtnWord[0]
            else
                btnTxt = self.ShowBtnWord[1]
            end
        else
            if hasReward then
                btnTxt = self.ShowBtnWord[2]
            else
                btnTxt = self.ShowBtnWord[3]
            end
        end
    end
    if self.ShowTxtWord ~= nil and self.ShowTxtWord.Length > 4 then
        local dataTxt = self:GetActivityInfo():GetEffectiveDate()
        self:GetTime_UILabel().text = string.format(self.ShowTxtWord[4], dataTxt)
    end
    local isShowBtn = not self.data.isCard or (hasReward)
    self:GetShowLabel_UILabel().text = getTxt
    self:GetCenterBtnLabel_UILabel().text = btnTxt
    self:GetCenterBtnBg_UISprite().spriteName = self.data.isCard and 'anniu11' or 'anniu14'
    self:GetTime_UILabel().gameObject:SetActive(self.data.isCard)
    self:GetNoGet_GameObject():SetActive(not isShowBtn)

    self:GetCanRewardEffect_Go():SetActive(self.data.isCard and hasReward)

    self:GetActiveBg_UISprite().gameObject:SetActive(isShowBtn)
    --有卡不显示文本
    local IsShowLabel = isShowBtn and not self.data.isCard
    self:GetShowLabel_UILabel().gameObject:SetActive(IsShowLabel)
    --设置位置
    if self.bgHeight then
        -- self:GetActiveBg_UISprite().height = ternary(IsShowLabel, self.bgHeight, self.bgHeight / 2)
    end
    self:GetRewardScroll_GameObject().transform.localPosition = ternary(IsShowLabel, self.ScroolPos, CS.UnityEngine.Vector3.zero)

    --self:GetHasCardSign_GameObject():SetActive(self.data.isCard)
    self:GetLock_GameObject():SetActive(not self.data.isCard)
    self:GetCenterBtn_GameObject().gameObject:SetActive(isShowBtn)
    self:GetAuthenticationSign_GameObject():SetActive(self.data.isCard)
end

---猎魔人奖励
function UIMonsterHunterActivePanel:RefreshReward(coinList)
    if coinList and coinList.Count > 0 then
        self:GetRewardList_UIGridContainer().MaxCount = coinList.Count
        for i = 0, coinList.Count - 1 do
            local go = self:GetRewardList_UIGridContainer().controlList[i]
            ---@type UISprite
            local icon = CS.Utility_Lua.Get(go.transform, "Sprite2", "UISprite")
            ---@type UILabel
            local num = CS.Utility_Lua.GetComponent(go, "UILabel")

            local head = CS.Utility_Lua.Get(go.transform, "name", "GameObject")
            head:SetActive(i == 0)
            ---@type bagV2.CoinInfo
            local data = coinList[i]
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(data.itemId)
            if res then
                icon.spriteName = itemInfo.icon
            end
            num.text = "x" .. data.count
        end
    end
end

---@return  TABLE.CFG_RECHARGE 充值信息
function UIMonsterHunterActivePanel:GetChargeInfo()
    if self.mChargeInfo == nil then
        ___, self.mChargeInfo = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(self.cardID)
    end
    return self.mChargeInfo
end

---跳转充值
function UIMonsterHunterActivePanel:ReqRecharge()
    if (self:GetChargeInfo() ~= nil) then
        if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
            if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                networkRequest.ReqGM("@43 " .. tostring(self:GetChargeInfo().id))
            else
                local data = Utility:GetPayData(self:GetChargeInfo())
                if (data ~= nil) then
                    CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                end
            end
        end
    end
end

---刷新奖励信息
---@param  showList TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIMonsterHunterActivePanel:RefreshRewardInfo(rewardShow)
    table.sort(rewardShow, self.SortReward)
    self:GetItemInfo_GridContainer().MaxCount = #rewardShow
    for i = 1, #rewardShow do
        local go = self:GetItemInfo_GridContainer().controlList[i - 1]
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        local numShow = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
        local id = rewardShow[i].id
        local num = rewardShow[i].num
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        if res then
            icon.spriteName = itemInfo.icon
            CS.UIEventListener.Get(icon.gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
            end
        end
        numShow.text = num > 1 and num or ""
    end
end

---排序
function UIMonsterHunterActivePanel.SortReward(left, right)
    if left == nil or right == nil then
        return false
    end
    if left.id == right.id then
        return false
    else
        if left.id == LuaEnumCoinType.YuanBao then
            return true
        elseif right.id == LuaEnumCoinType.YuanBao then
            return false
        else
            return false
        end
    end
end

---刷新总奖励
function UIMonsterHunterActivePanel:RefreshTotalReward(showList)
    if showList == nil then
        return
    end
    local rewardShow = self:CountReward(showList)
    self:RefreshRewardInfo(rewardShow)
end

---@param  showList TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIMonsterHunterActivePanel:CountReward(showList)
    local show = {}
    local levle1 = showList.rewardShow1
    local levle2 = showList.rewardShow2
    local levle3 = showList.rewardShow3
    self:AddShowInfo(show, levle1)
    self:AddShowInfo(show, levle2)
    self:AddShowInfo(show, levle3)
    local finalData = self:GetTableTypeData(show)
    return finalData
end

---@param info TABLE.IntListList
function UIMonsterHunterActivePanel:AddShowInfo(show, info)
    if show and info then
        for i = 0, info.list.Count - 1 do
            local reward = info.list[i].list
            if reward and reward.Count >= 2 then
                local id = reward[0]
                local num = reward[1]
                local curNum = show[id]
                if curNum then
                    show[id] = num + curNum
                else
                    show[id] = num
                end
            end
        end
    end
end

---刷新可领奖奖励
function UIMonsterHunterActivePanel:RefreshCanReward(coinList)
    local showList = {}
    for i = 0, coinList.Count - 1 do
        local info = {}
        info.id = coinList[i].itemId
        info.num = coinList[i].count
        table.insert(showList, info)
    end
    self:RefreshRewardInfo(showList)
end

---转换数据
function UIMonsterHunterActivePanel:GetTableTypeData(show)
    local finalData = {}
    for k, v in pairs(show) do
        local info = {}
        info.id = k
        info.num = v
        table.insert(finalData, info)
    end
    return finalData
end

---@return TABLE.CFG_ITEMS
function UIMonsterHunterActivePanel:GetItemInfoCache(itemId)
    if itemId then
        if self.mItemIdToInfo == nil then
            self.mItemIdToInfo = {}
        end
        local info = self.mItemIdToInfo[itemId]
        if info == nil then
            ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
            self.mItemIdToInfo[itemId] = info
        end
        return info
    end
end

---@return table 当前可领奖励
function UIMonsterHunterActivePanel:GetCurrentCanReward()
    local showList = {}
    local allData = self:GetActivityInfo().BoosIntegral
    for i = 0, allData.Count - 1 do
        ---@type activityV2.BossScoreRewards
        local data = allData[i]
        if data.state == 2 or data.state == 1 then
            local tableInfo = self:GetBossIntegralReward(data.id)
            if tableInfo then
                if data.state == 1 then
                    self:AddRewardInfo(showList, tableInfo.chargeReward)
                    self:AddRewardInfo(showList, tableInfo.freeReward)
                elseif data.state == 2 then
                    self:AddRewardInfo(showList, tableInfo.chargeReward)
                end
            end
        end
    end
    local finalInfo = self:GetTableTypeData(showList)
    return finalInfo
end

---@param info TABLE.IntListList
function UIMonsterHunterActivePanel:AddRewardInfo(showList, infos)
    for i = 0, infos.list.Count - 1 do
        local info = infos.list[i].list
        if info and info.Count >= 2 then
            local id = info[0]
            local num = info[1]
            local curNum = showList[id]
            if curNum then
                showList[id] = curNum + num
            else
                showList[id] = num
            end
        end
    end
end

---@return table 所有可领奖励
function UIMonsterHunterActivePanel:GetAllCanReward()
    local showList = {}
    local allData = self:GetActivityInfo().BoosIntegral
    for i = 0, allData.Count - 1 do
        ---@type activityV2.BossScoreRewards
        local data = allData[i]
        local tableInfo = self:GetBossIntegralReward(data.id)
        if tableInfo then
            self:AddRewardInfo(showList, tableInfo.chargeReward)
        end
    end
    local finalInfo = self:GetTableTypeData(showList)
    return finalInfo
end

---@return TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIMonsterHunterActivePanel:GetBossIntegralReward(id)
    if id == nil then
        return
    end
    if self.mBossIntegralIDToData == nil then
        self.mBossIntegralIDToData = {}
    end
    local info = self.mBossIntegralIDToData[id]
    if info == nil then
        ___, info = CS.Cfg_Boss_Integral_Reward.Instance.dic:TryGetValue(id)
        self.mBossIntegralIDToData[id] = info
    end
    return info
end
--endregion

return UIMonsterHunterActivePanel