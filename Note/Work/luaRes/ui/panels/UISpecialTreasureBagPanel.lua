---@class UISpecialTreasureBagPanel:UITreasureBagPanelBase 白银/黄金宝箱
local UISpecialTreasureBagPanel = {}

setmetatable(UISpecialTreasureBagPanel, luaPanelModules.UITreasureBagPanelBase)

UISpecialTreasureBagPanel.mCurrentFlickerCenter = nil
UISpecialTreasureBagPanel.mFlickerCoroutine = nil
UISpecialTreasureBagPanel.mIEnumMiddleUpShopReward = nil

UISpecialTreasureBagPanel.mEffectPos = CS.UnityEngine.Vector3(0, 76, 0)

---@return number 使用全部数目上限
function UISpecialTreasureBagPanel:GetUseAllNumMax()
    return self:GetUseAllNumInfo(2)
end

---@return number 使用全部数目下限
function UISpecialTreasureBagPanel:GetUseAllNumMin()
    return self:GetUseAllNumInfo(1)
end

---@param type number 下限1/上限2
function UISpecialTreasureBagPanel:GetUseAllNumInfo(type)
    if self.mUseAllInfo == nil then
        self.mUseAllInfo = {}
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22416)
        if res then
            local strs = string.Split(info.value, '#')
            if #strs >= 2 then
                self.mUseAllInfo[1] = tonumber(strs[1])
                self.mUseAllInfo[2] = tonumber(strs[2])
            end
        end
    end
    return self.mUseAllInfo[type]
end

--region 组件
---@return UISprite 宝箱icon
function UISpecialTreasureBagPanel:Title_UISprite()
    if self.mTitleSp == nil then
        self.mTitleSp = self:GetCurComp("WidgetRoot/window/icon", "UISprite")
    end
    return self.mTitleSp
end

---@return UILabel 宝箱数目
function UISpecialTreasureBagPanel:Title_UILabel()
    if self.mTitleLb == nil then
        self.mTitleLb = self:GetCurComp("WidgetRoot/window/icon/count", "UILabel")
    end
    return self.mTitleLb
end

---@return UnityEngine.GameObject 消耗道具
function UISpecialTreasureBagPanel:GetCost_Go()
    if self.mCostGo == nil then
        self.mCostGo = self:GetCurComp("WidgetRoot/CostItem", "GameObject")
    end
    return self.mCostGo
end

---@return UnityEngine.GameObject  单个道具GO
function UISpecialTreasureBagPanel:GetSingleKey_Go()
    if self.mSingleCostGo == nil then
        self.mSingleCostGo = self:GetCurComp("WidgetRoot/CostItem/single", "GameObject")
    end
    return self.mSingleCostGo
end

---@return UISprite 多个道具icon
function UISpecialTreasureBagPanel:GetAllCost_UISprite()
    if self.mAllCostSp == nil then
        self.mAllCostSp = self:GetCurComp("WidgetRoot/CostItem/all/icon", "UISprite")
    end
    return self.mAllCostSp
end

---@return UILabel 多个道具数目
function UISpecialTreasureBagPanel:GetAllCost_UILabel()
    if self.mAllCostSLb == nil then
        self.mAllCostSLb = self:GetCurComp("WidgetRoot/CostItem/all/Label", "UILabel")
    end
    return self.mAllCostSLb
end

---@return UnityEngine.GameObject 多个道具Add
function UISpecialTreasureBagPanel:GetAllAdd_UISprite()
    if self.mAllAdd == nil then
        self.mAllAdd = self:GetCurComp("WidgetRoot/CostItem/all/add", "UISprite")
    end
    return self.mAllAdd
end

---@return UnityEngine.GameObject 宝箱获取途径
function UISpecialTreasureBagPanel:GetBoxAdd_Go()
    if self.mBoxAddGo == nil then
        self.mBoxAddGo = self:GetCurComp("WidgetRoot/window/icon/add", "GameObject")
    end
    return self.mBoxAddGo
end

---@return UnityEngine.GameObject 领取奖励按钮
function UISpecialTreasureBagPanel:GetRewardBtn_Go()
    if self.mRewardBtn == nil then
        self.mRewardBtn = self:GetCurComp("WidgetRoot/event/btn_Reward", "GameObject")
    end
    return self.mRewardBtn
end

---@return UILabel 领奖按钮文本
function UISpecialTreasureBagPanel:GetRewardBtn_UILabel()
    if self.mRewardBtnLb == nil then
        self.mRewardBtnLb = self:GetCurComp("WidgetRoot/event/btn_Reward/Label", "UILabel")
    end
    return self.mRewardBtnLb
end

---@return UISprite 领奖按钮背景
function UISpecialTreasureBagPanel:GetRewardBtn_UISprite()
    if self.mRewardBtnSp == nil then
        self.mRewardBtnSp = self:GetCurComp("WidgetRoot/event/btn_Reward/Background", "UISprite")
    end
    return self.mRewardBtnSp
end

---@return UnityEngine.GameObject 遮罩
function UISpecialTreasureBagPanel:GetShadow_Go()
    if self.mShadowGo == nil then
        self.mShadowGo = self:GetCurComp("WidgetRoot/blackbox", "GameObject")
    end
    return self.mShadowGo
end

--endregion

--region 初始化
function UISpecialTreasureBagPanel:Init()
    self:GetCenterIcon_UISprite().spriteName = ""
    self:SetShadowShow(false)
    self:GetRewardBtn_UILabel().text = "[FFF0C2]领取奖励"
    self:GetRewardBtn_UISprite().spriteName = "anniu23"
    self:InitParams()
    self:InitPanel()
    self:BindMessage()
    self:BindEvents()
    self:RefreshBoxPos()
end

---新需求隐藏钥匙
function UISpecialTreasureBagPanel:RefreshBoxPos()
    local pos = self:Title_UISprite().gameObject.transform.localPosition
    pos.x = 0
    self:Title_UISprite().gameObject.transform.localPosition = pos
    self:GetCost_Go():SetActive(false)
end

function UISpecialTreasureBagPanel:Show(customData)
    if customData then
        --uimanager:ClosePanel("UIBagPanel")
        self:InitPanelInfo(customData.bagItemInfo)
        self:RefreshPanelShow()
    end
end

---初始化界面（宝箱）数据
---@param bagItemInfo bagV2.BagItemInfo
function UISpecialTreasureBagPanel:InitPanelInfo(bagItemInfo)
    if bagItemInfo then
        --self.mCurrentBagState = LuaEnumTreasureBagState.FirstRefresh
        self:InitReqData(bagItemInfo)
        self:InitExtendInfo()
        self:SetBtnState(false)
    end
end

---@param bagItemInfo bagV2.BagItemInfo 钥匙/宝箱数据
function UISpecialTreasureBagPanel:InitReqData(bagItemInfo)
    self.bagItemInfo = bagItemInfo
    local itemInfo = bagItemInfo.ItemTABLE
    if Utility.IsSpecialEquipBox(itemInfo) then
        ---@type TABLE.CFG_ITEMS 宝箱itemInfo
        self.itemInfo = itemInfo
        self.lid = self.bagItemInfo.lid
    else
        local boxId = Utility.GetSpecialKeyBoxInfo(itemInfo.id)
        self.itemInfo = self:GetItemInfoCache(boxId)
        local boxInfo = self:IsAnyBoxInBag()
        if boxId then
            self.lid = boxInfo.lid
        end
    end
    if self.lid then
        networkRequest.ReqUseItem(1, self.lid, 0)
    end
end

---刷新额外数据
function UISpecialTreasureBagPanel:InitExtendInfo()
    if self.itemInfo then
        --设置宝箱数目
        self:Title_UISprite().spriteName = self.itemInfo.icon
        local boxNum = self:GetBagBoxNum()
        self:Title_UILabel().text = boxNum == 0 and "" or boxNum
        self:GetBoxAdd_Go():SetActive(false)
        --self:RefreshKeyState(boxNum)
    end
end

---刷新钥匙状态
function UISpecialTreasureBagPanel:RefreshKeyState(boxNum)
    local keyInfo = self:GetBoxExtendInfo(self.itemInfo.id)
    if keyInfo == nil then
        return
    end
    local keyId = keyInfo.keyId
    local keyItemInfo = self:GetItemInfoCache(keyId)
    if keyItemInfo then
        self:GetAllCost_UISprite().spriteName = keyItemInfo.icon
    end
    local hasKeyNum = self:GetBagItemNum(keyId)

    local leftUseNum = self:GetBoxCanUseNum()
    if leftUseNum and leftUseNum ~= -1 then
        self.mUseAllNum = math.min(boxNum, self:GetUseAllNumMax(), hasKeyNum, leftUseNum)
    else
        self.mUseAllNum = math.min(boxNum, self:GetUseAllNumMax(), hasKeyNum)
    end

    local costKeyNum = keyInfo.keyNum
    local allCost = costKeyNum * self.mUseAllNum

    local keyEnough = hasKeyNum >= allCost

    self:GetAllCost_UILabel().text = hasKeyNum == 0 and "" or hasKeyNum
    ---@type boolean 使用全部（5-10个）宝箱钥匙是否足够
    self.mKeyEnough = keyEnough

    local singleKeyEnough = hasKeyNum >= costKeyNum
    ---@type boolean 使用单个宝箱钥匙是否足够
    self.mSingleKeyEnough = singleKeyEnough

    self:GetAllAdd_UISprite().gameObject:SetActive(hasKeyNum <= 0)
end

---@return number 获取剩余宝箱可用数目-1表示没有限制0表示没有可用宝箱次数了
function UISpecialTreasureBagPanel:GetBoxCanUseNum()
    local boxItemId = -1
    if Utility.IsSpecialEquipBox(self.itemInfo) then
        boxItemId = self.itemInfo.id
    elseif Utility.IsSpecialEquipBoxKey(self.itemInfo) then
        boxItemId = Utility.GetSpecialKeyBoxInfo(self.itemInfo.id)
    end
    if boxItemId ~= -1 then
        local maxNum = Utility.GetSpecialBoxUseCountLimitPerDay(boxItemId)
        local useNum = 0
        local res, useInfo = CS.CSScene.MainPlayerInfo.BagInfo.ItemUseTime:TryGetValue(boxItemId)
        if res then
            useNum = useInfo
        end
        if maxNum and maxNum ~= 0 then
            return maxNum - useNum
        end
    end
    return -1
end

function UISpecialTreasureBagPanel:BindEvents()
    self:RunBaseFunction("BindEvents")
    CS.UIEventListener.Get(self:GetAllAdd_UISprite().gameObject).onClick = function(go)
        self:OnAddClicked(go)
    end
    CS.UIEventListener.Get(self:GetBoxAdd_Go()).onClick = function(go)
        self:OnBoxWayGetClicked(go)
    end
    CS.UIEventListener.Get(self:GetAllCost_UISprite().gameObject).onClick = function(go)
        self:OnCoinItemClicked(go)
    end
    CS.UIEventListener.Get(self:Title_UISprite().gameObject).onClick = function(go)
        if self.itemInfo then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemInfo, showRight = false })
        end
    end
    CS.UIEventListener.Get(self:GetCenterIcon_UISprite().gameObject).onClick = function(go)
        if self.mCanClickCenter and self.mCurLottery then
            local itemInfo = self.mCurLottery.ItemTABLE
            if itemInfo then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
            end
        end
    end
    CS.UIEventListener.Get(self:GetRewardBtn_Go()).onClick = function(go)
        self:OnRewardBtmClicked(go)
    end
end

function UISpecialTreasureBagPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPreyTreasureBoxMessage, UISpecialTreasureBagPanel.OnResPreyTreasureBoxMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDrawPreyTreasureBoxMessage, function()
        self:OnResDrawPreyTreasureBoxMessageReceived()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAwardPreyTreasureBoxMultiMessage, function(msgId, tblData, csData)
        self:OnResAwardPreyTreasureBoxMultiMessageReceived(msgId, tblData, csData)
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self.mNeedRefreshBag = true
    end)
end
--endregion

--region 服务器消息
--region使用宝箱获取奖池之后的刷新消息
---打开掠宝袋消息
function UISpecialTreasureBagPanel.OnResPreyTreasureBoxMessageReceived(msgId, tblData, csData)
    UISpecialTreasureBagPanel:RefreshJackpot(tblData, csData)
    if UISpecialTreasureBagPanel.mNeedAutoOpenBox then
        UISpecialTreasureBagPanel.mNeedAutoOpenBox = false
        UISpecialTreasureBagPanel:OnBuyTreasureBoxClicked(UISpecialTreasureBagPanel:GetBuyBoxBtn_Go())
    end
end

---刷新奖池
---@param csData bagV2.PreyTreasureBagResponse
---@param tblData bagV2.PreyTreasureBagResponse
function UISpecialTreasureBagPanel:RefreshJackpot(tblData, csData)
    self.GridGoToItemInfo = {}
    self.mRewardIndex = csData.rewardIndex
    local info = csData.jackpot
    if info == nil then
        return
    end
    --self.IndexToItemInfo = {}
    --刷新奖池显示
    self:RefreshJackpotShow(info)
    ---中间Index隐藏
    self.GridGoToIndex[self.mRewardPos]:SetActive(false)
    local isRaffle = tblData.isRaffle --为true
    isRaffle = false
    --self:GetCenter_GameObject():SetActive(isRaffle)
    self:ShowCenter(nil)

    self:SetCenterChooseGoState(isRaffle)
    local rewardIndex = csData.rewardIndex
    if rewardIndex < info.Count and rewardIndex >= 0 then
        local reward = info[csData.rewardIndex]
        self.mCurLottery = reward
    else
        if isOpenLog then
            luaDebug.Log("服务器发的奖励index是" .. tostring(csData.rewardIndex) .. "越界了，看到请截图给程序")
        end
    end
    self.mCurrentBagState = isRaffle and LuaEnumTreasureBagState.Open or LuaEnumTreasureBagState.UnOpen
end

---刷新按钮
function UISpecialTreasureBagPanel:RefreshBtnShow(isRaffle)
end
--endregion

--region返回全部使用宝箱数据 用于设置闪烁
---@param csData bagV2.ResAwardPreyTreasureBoxMulti
function UISpecialTreasureBagPanel:OnResAwardPreyTreasureBoxMultiMessageReceived(msgId, tblData, csData)
    if csData and csData.awardItems then
        self.mFlickerCenterList = csData.awardItems
        self.mMultiJackpots = csData.package
        --[[        if self.mCurrentFlickerCenter then
                    StopCoroutine(self.mCurrentFlickerCenter)
                end
                self.mCurrentFlickerCenter = StartCoroutine(function()
                    self:StartFlickerCenterItem()
                end)]]
        self:StartFlickerCenterItem()
    end
end

---携程刷新中心闪烁
function UISpecialTreasureBagPanel:StartFlickerCenterItem()
    self:BeforeFlickerAllBox()
    --[[    if self.mFlickerCenterList and self.mFlickerCenterList.Count > 0 and self.mMultiJackpots and self.mMultiJackpots.Count > 0 then
            local isRun = true
            local flickerTime = self.flickerTime * 2
            local flickerCount = 0
            while isRun do
                --中心物品根据当前选中改变
                local currentInfo = self.mFlickerCenterList[flickerCount]
                if currentInfo then
                    self:ShowCenter(currentInfo)
                end
                --self:RandomUpdateTreasurePanel(currentInfo);

                local jackpot = self.mMultiJackpots[flickerCount].jackpot
                self:RefreshJackpotShow(jackpot)
                flickerCount = flickerCount + 1
                --结束选中
                if flickerCount >= self.mFlickerCenterList.Count then
                    break
                end
                coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(flickerTime))
            end
            self:StartFlickerItem(self.mMultiJackpots)
        end]]
    self:StartFlickerItem(self.mMultiJackpots)
    self:EndFlickerAllBox()
end

---在刷新中心闪烁的同时,进行周围格子的随机刷新
---currentInfo 当前刷新的中心物品,周围随机之一
function UISpecialTreasureBagPanel:RandomUpdateTreasurePanel(currentInfo)
    self:GetGridContainer_GridContainer().MaxCount = self.mGridNum
    currentInfo.index = -1
    local list = CS.Cfg_GlobalTableManager.Instance:GetRandomTreasureList(8, currentInfo);
    --table.insert(list, currentInfo)

    for i = 0, self:GetGridContainer_GridContainer().controlList.Count - 1 do
        local item = self:GetGridContainer_GridContainer().controlList[i]
        local info = list[i]
        self:ShowIcon(item, info)
        local choose = item.transform:Find("choose").gameObject
        choose:SetActive(info.index == -1)
        if info.index == -1 then
            self.mLeaveIndex = i
        end
    end
end

function UISpecialTreasureBagPanel:GetRandomTreasureList()
    local isReaden, str = CS.Cfg_GlobalTableManager.Instance:TryGetValue(997)
    if isReaden then
        ClientMessageDeal.mOffLineTime = {}
        local strs = string.Split(str.value, '#')
        table.insert(ClientMessageDeal.mOffLineTime, tonumber(strs[1]))
        table.insert(ClientMessageDeal.mOffLineTime, tonumber(strs[2]))
    end
end

function UISpecialTreasureBagPanel:BeforeFlickerAllBox()
    self.mCurChoose = self.mCurChoose + 1
    self.mCurrentRewardState = LuaEnumBoxRewardType.All
    self:SetCenterChooseGoState(true)
    self:ClearChoose()
    self:SetBtnState(nil, true)
    self:SetShadowShow(true)

end

function UISpecialTreasureBagPanel:EndFlickerAllBox()
    self.mCurChoose = self.mCurChoose - 1
    self:SetBtnState(true)
    self:SetShadowShow(false)
end

function UISpecialTreasureBagPanel.IEnumMiddleUpShopReward()

end

---显示获得奖励
function UISpecialTreasureBagPanel:MiddleUpShowReward()
    self.mCurChoose = self.mCurChoose + 1
    self:SetBtnState(false)
    if self.mFlickerCenterList and self.mFlickerCenterList.Count > 0 then
        local isRun = true
        local flickerTime = self.flickerTime * 4
        local flickerCount = 0
        while isRun do
            --中心物品根据当前选中改变
            local currentInfo = self.mFlickerCenterList[flickerCount]
            if currentInfo then
                self:ShowReward(currentInfo)
            end
            flickerCount = flickerCount + 1
            --结束选中
            if flickerCount >= self.mFlickerCenterList.Count then
                break
            end
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(flickerTime))
        end
        self.mCurChoose = self.mCurChoose - 1
    end
    self:CheckBag()
    self:SetBtnState(false)
    self:ShowCenter()
end
--endregion

--region 领取掠宝袋（收到服务器返回领奖后的飞入操作等）
function UISpecialTreasureBagPanel:OnResDrawPreyTreasureBoxMessageReceived()
    self:ShowReward(UISpecialTreasureBagPanel.mCurLottery)
    self:ShowCenter(nil)
    self:SetBtnState(false)
    self:CheckBag()
end

---显示领奖特效
function UISpecialTreasureBagPanel:ShowRewardEffect(itemId, bagItemInfo)
    local effectId = UISpecialTreasureBagPanel:IsItemCanFlyBag(itemId)
    if effectId == -1 then
        self:ShowCenter()
        self:FlySingleItem(itemId)
    else
        self:ShowCenter(bagItemInfo)
        Utility.ShowScreenEffect(effectId, nil, UISpecialTreasureBagPanel.mEffectPos)
    end
end

---@return boolean 判断道具是否可以飞到背包
function UISpecialTreasureBagPanel:IsItemCanFlyBag(itemId)
    if self.mExpEffect == nil then
        self.mExpEffect = {}
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22429)
        if res then
            local strs = string.Split(info.value, '#')
            for i = 1, #strs do
                table.insert(self.mExpEffect, tonumber(strs[i]))
            end
        end
    end
    if self.mExpEffect and #self.mExpEffect > 0 then
        for i = 1, #self.mExpEffect - 1 do
            if self.mExpEffect[i] == itemId then
                return self.mExpEffect[#self.mExpEffect]
            end
        end
    end
    return -1
end
--endregion

---检查背包道具数目
function UISpecialTreasureBagPanel:CheckBag()
    local bagItemInfo = self:IsAnyBoxInBag()
    if bagItemInfo == nil then
        self:ClosePanel()
    end
    local leftNum = self:GetBoxCanUseNum()
    if leftNum == 0 then
        --没有可用次数关闭宝箱
        self:ClosePanel()
    end

    --[[    if self.itemInfo then
            local keyInfo = self:GetBoxExtendInfo(self.itemInfo.id)
            if keyInfo then
                local keyId = keyInfo.keyId
                local hasKeyNum = self:GetBagItemNum(keyId)
                if hasKeyNum <= 0 then
                    self:ClosePanel()
                end
            end
        end]]
    return true
end

--endregion

--region UI事件
---右边按钮 全部领取
function UISpecialTreasureBagPanel:OnReceiveButtonClicked(go)
    if self.mCurChoose ~= 0 then
        return
    end
    --[[    if not self.mKeyEnough then
            self:OnAddClicked(go)
            return
        end]]

    local boxNum = self:GetBagBoxNum()
    if boxNum <= 0 then
        self:OnBoxWayGetClicked(go)
        return
    end
    local num = math.min(boxNum, 10)
    if self.itemInfo then
        self.mCurrentBagState = LuaEnumTreasureBagState.Next
        networkRequest.ReqUsePreyTreasureBoxMulti(self.itemInfo.id, num)
    end
end

---左边按钮 领取单个
function UISpecialTreasureBagPanel:OnBuyTreasureBoxClicked(go)
    -- self:GetBuyBoxBtn_UILabel().text = "[ffcda5]开启下个"
    --[[    if not self.mSingleKeyEnough then
            self:OnAddClicked(go)
            return
        end]]

    local boxNum = self:GetBagBoxNum()
    if boxNum <= 0 then
        self:OnBoxWayGetClicked(go)
        return
    end
    if self.mCurChoose ~= 0 then
        return
    end
    if self.mCurrentBagState == LuaEnumTreasureBagState.Open then
        self:StartOpenNextBox()
    elseif self.mCurrentBagState == LuaEnumTreasureBagState.UnOpen then
        self.mCurrentBagState = LuaEnumTreasureBagState.Open
        if self.mFlickerCoroutine then
            StopCoroutine(self.mFlickerCoroutine)
        end
        self.mFlickerCoroutine = StartCoroutine(function()
            self:StartFlicker()
        end)
        if self.lid then
            networkRequest.ReqRafflePreyTreasureBox(self.lid)
        end
    elseif self.mCurrentBagState == LuaEnumTreasureBagState.Next then
        self.mCurrentBagState = LuaEnumTreasureBagState.AutoOpen
        self:StartOpenNextBox(go)
    end
end

---开始开启下个宝箱
function UISpecialTreasureBagPanel:StartOpenNextBox(go)
    local bagItemInfo = self:IsAnyBoxInBag()
    if bagItemInfo then
        self.mNeedAutoOpenBox = true
        self:InitPanelInfo(bagItemInfo)
    end
end

---协程闪烁
function UISpecialTreasureBagPanel:StartFlicker()
    if self.mRewardIndex ~= nil then
        self:BeforeFlicker()
        local isRun = true
        local flickerCount = 0
        local lastChoose = 0
        self.flickerCount = math.ceil(CS.UnityEngine.Random.Range(self.flickerMinCount, self.flickerMaxCount)) + 1
        if self.flickerCount < 0 then
            self.flickerCount = 6
        end
        local arrayIndex = self:GetIndexOfRewardID(self.mRewardIndex + 1)
        while isRun do
            local index = self.mShowIndex[arrayIndex]
            --隐藏上一次选中并选中当前物品
            if lastChoose ~= 0 then
                self:ChooseItem(lastChoose, false)
            end
            --选中当前
            self:ChooseItem(index, true)
            --存储上一次选中
            lastChoose = index
            --结束选中
            if flickerCount >= self.flickerCount then
                self.mLeaveIndex = index
                isRun = false
                break
            end
            flickerCount = flickerCount + 1
            arrayIndex = arrayIndex + 1 > self.allFlickerCount and self.allFlickerCount - (arrayIndex - 1) or arrayIndex + 1
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self.flickerTime))
        end
        self:AfterFlicker()
    end
end

---开启协程前
function UISpecialTreasureBagPanel:BeforeFlicker()
    self.mCurChoose = self.mCurChoose + 1
    self:ClearChoose()
    self.mCurrentRewardState = LuaEnumBoxRewardType.Single
    self:SetCenterChooseGoState(false)
    self:SetBtnState(nil, true)
    self:SetShadowShow(true)
    --[[    self:GetBuyBoxBtn_UILabel().text = "[878787]开启宝箱"
        self:GetBuyBoxBtn_UISprite().spriteName = "anniu19"]]
end

---结束协程闪烁后
function UISpecialTreasureBagPanel:AfterFlicker()
    self.mCurChoose = self.mCurChoose - 1
    self:SetCenterChooseGoState(true)
    --[[    self:GetBuyBoxBtn_UILabel().text = "[FFF0C2]领取奖励"
        self:GetBuyBoxBtn_UISprite().spriteName = "anniu10"]]
    self:SetBtnState(true)
    --self:GetCenter_GameObject():SetActive(true)
    self:SetShadowShow(false)
    self:ShowCenter(self.mCurLottery)
end

function UISpecialTreasureBagPanel:ClearChoose()
    if self.mLeaveIndex then
        self:ChooseItem(self.mLeaveIndex, false)
    end
end

---点击领取宝箱
function UISpecialTreasureBagPanel:OnRewardBtmClicked()
    if self.mCurrentRewardState == LuaEnumBoxRewardType.All then
        self.mCurrentRewardState = LuaEnumBoxRewardType.None
        if isOpenLog then
            luaDebug.Log("请求领取宝箱十连奖励,宝箱itemid：" .. tostring(self.itemInfo.id) .. "数目:" .. tostring(self.mUseAllNum))
        end
        networkRequest.ReqAwardPreyTreasureBoxMulti(self.itemInfo.id, self.mUseAllNum)
        if self.mIEnumMiddleUpShopReward ~= nil then
            StopCoroutine(self.mIEnumMiddleUpShopReward)
        end
        self.mIEnumMiddleUpShopReward = StartCoroutine(function()
            self:MiddleUpShowReward()
        end)
    elseif self.mCurrentRewardState == LuaEnumBoxRewardType.Single then
        self.mCurrentRewardState = LuaEnumBoxRewardType.None
        if self.mCurrentBagState == LuaEnumTreasureBagState.Open then
            if self.lid then
                local useNum = 0
                if self:GetMainPlayerInfo() and self.itemInfo then
                    local res, useInfo = self:GetMainPlayerInfo().BagInfo.ItemUseTime:TryGetValue(self.itemInfo.id)
                    if res then
                        useNum = useInfo
                    end
                end

                if isOpenLog then
                    luaDebug.Log("请求领取单个,宝箱lid：" .. tostring(self.lid) .. "当前使用次数" .. tostring(useNum))
                end
                networkRequest.ReqDrawPreyTreasureBox(self.lid, useNum)
            end
        end
        self.mCurrentBagState = LuaEnumTreasureBagState.Next
        -- self:SetBtnState(false)
    end
    self:ShowCenter(nil)
end

---设置按钮显示状态
function UISpecialTreasureBagPanel:SetBtnState(isReward, isCloseAll)
    if self.mCurChoose ~= 0 then
        self:GetRewardBtn_Go():SetActive(false)
        self:GetBuyBoxBtn_Go():SetActive(false)
        self:GetReceiveButton():SetActive(false)
    else
        local boxNum = self:GetBagBoxNum()
        local canUseAll = false
        local mUseAllNum = 1
        ---[[
        ---新版
        local mUseAllNum = math.min(boxNum, self:GetUseAllNumMax())
        local canUseAll = mUseAllNum >= self:GetUseAllNumMin()
        self:GetReceiveButton():SetActive(not isReward and canUseAll)
        --]]

        --[[
        --上一版
        --设置钥匙
        local keyInfo = self:GetBoxExtendInfo(self.itemInfo.id)
        if keyInfo then
            local keyId = keyInfo.keyId
            local hasKeyNum = self:GetBagItemNum(keyId)

            mUseAllNum = math.min(boxNum, self:GetUseAllNumMax(), hasKeyNum)
            local leftUseNum = self:GetBoxCanUseNum()
            if leftUseNum and leftUseNum ~= -1 then
                mUseAllNum = math.min(mUseAllNum, leftUseNum)
            end

            canUseAll = mUseAllNum >= self:GetUseAllNumMin() and self.mKeyEnough
            self:GetReceiveButton():SetActive(not isReward and canUseAll)
        end
        --]]

        local startPos = self:GetBuyBoxBtn_Go().transform.localPosition
        startPos.x = canUseAll and -95 or 0
        self:GetBuyBoxBtn_Go().transform.localPosition = startPos
        if (canUseAll == false) then
            self:GetReceiveButton():SetActive(canUseAll)
        end
        self:GetReceiveLabel().text = "[FFCDA5]开启" .. mUseAllNum .. "个"

        self:GetReceive_UISprite().spriteName = "anniu22"
        self:GetBuyBoxBtn_UISprite().spriteName = "anniu21"
        self:GetBuyBoxBtn_UILabel().text = "[C3F4FF]开启1个"

        self:GetRewardBtn_Go():SetActive(isReward)
        self:GetBuyBoxBtn_Go():SetActive(not isReward)
    end
end

---点击钥匙获取途径add
function UISpecialTreasureBagPanel:OnAddClicked(go)
    local EntranceWay = LuaEnumRechargePointType.BoxKey
    if self.itemInfo then
        local keyInfo = self:GetBoxExtendInfo(self.itemInfo.id)
        if keyInfo then
            local KeyID = keyInfo.keyId
            Utility.ShowItemGetWay(KeyID, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, EntranceWay)
        end
    end
end

---点击宝箱获取途径
function UISpecialTreasureBagPanel:OnBoxWayGetClicked(go)
    local EntranceWay = LuaEnumRechargePointType.SpecialBox
    if self.itemInfo then
        Utility.ShowItemGetWay(self.itemInfo.id, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, EntranceWay)
    end
end

---点击钥匙icon
function UISpecialTreasureBagPanel:OnCoinItemClicked(go)
    if self.itemInfo then
        local keyInfo = self:GetBoxExtendInfo(self.itemInfo.id)
        if keyInfo then
            local keyItemInfo = self:GetItemInfoCache(keyInfo.keyId)
            if keyItemInfo then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = keyItemInfo, showRight = false })
            end
        end
    end
end

---刷新界面背景显示
function UISpecialTreasureBagPanel:RefreshPanelShow()
    if self.itemInfo then
        local bg, centerBg = self:GetBgInfo(self.itemInfo.id)
        self:GetPanelBg_UISprite().spriteName = bg
        self:GetCenterItemBg_UISprite().spriteName = centerBg
    end
end

---显示获得奖励提示
---@param currentInfo bagV2.BagItemInfo
function UISpecialTreasureBagPanel:ShowReward(currentInfo)
    if currentInfo == nil then
        return
    end

    local itemInfo = currentInfo.ItemTABLE
    if itemInfo then
        local data = {}
        data.Str = "获得"
        data.IconName = itemInfo.icon
        local str = string.sub(itemInfo.name, 1, #itemInfo.name - 3)
        local num = self:GetShowNum(currentInfo.count)
        data.secondLabel = str .. num
        luaEventManager.DoCallback(LuaCEvent.SendMiddleTopTips, data)
        self:ShowRewardEffect(itemInfo.id, currentInfo)
    end
end

--endregion

--region 刷新界面显示
---@param type number 中间1/背景2
---@param boxId number 宝箱id
function UISpecialTreasureBagPanel:GetBgInfo(boxId)
    if self.mBgInfo == nil then
        self.mBgInfo = {}
        local res, globalInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22434)
        if res then
            local strs = string.Split(globalInfo.value, '&')
            for i = 1, #strs do
                local str = strs[i]
                local infos = string.Split(str, '#')
                if #infos >= 3 then
                    local info = {}
                    info.id = tonumber(infos[1])
                    info.bg = infos[2]
                    info.centerBg = infos[3]
                    table.insert(self.mBgInfo, info)
                end
            end
        end
    end
    if self.mBgInfo then
        for i = 1, #self.mBgInfo do
            local bgInfo = self.mBgInfo[i]
            if bgInfo.id == boxId then
                return bgInfo.bg, bgInfo.centerBg
            end
        end
    end
end

---设置遮罩状态
function UISpecialTreasureBagPanel:SetShadowShow(isShow)
    self:GetShadow_Go():SetActive(isShow)
end
--endregion

--region 获取背包宝箱数据
---@return bagV2.BagItemInfo 背包中是否还有宝箱,没有不返回
function UISpecialTreasureBagPanel:IsAnyBoxInBag()
    if self:GetBagInfoV2() then
        local bagList = self:GetBagInfoV2():GetBagItemList()
        for i = 0, bagList.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = bagList[i]
            local itemInfo = bagItemInfo.ItemTABLE
            local isLevelEnough = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id) == LuaEnumUseItemParam.CanUse
            --if (itemInfo.useLv ~= 0) then
            --    isLevelEnough = itemInfo.useLv <= self:GetMainPlayerInfo().Level
            --elseif itemInfo.reinLv ~= 0 then
            --    isLevelEnough = itemInfo.reinLv <= self:GetMainPlayerInfo().ReinLevel
            --else
            --    isLevelEnough = true
            --end
            if itemInfo and itemInfo.id == self.itemInfo.id and isLevelEnough then
                return bagItemInfo
            end
        end
    end
end

---@return number 同类宝箱个数
function UISpecialTreasureBagPanel:GetBagBoxNum()
    local num = 0
    if self.itemInfo then
        num = self:GetBagItemNum(self.itemInfo.id)
    end
    return num
end

---@return number 背包中某种道具的数目
function UISpecialTreasureBagPanel:GetBagItemNum(id)
    if self:GetBagInfoV2() then
        return self:GetBagInfoV2():GetItemCountByItemId(id)
    end
    return 0
end
--endregion

--region 缓存表数据
---获取宝箱额外数据 消耗资源数目背景icon等
---@return KeyInfo
function UISpecialTreasureBagPanel:GetBoxExtendInfo(itemId)
    return Utility.GetSpecialBoxKeyInfo(itemId)
end
--endregion

--region 刷新奖池显示
---刷新奖池显示
---@param jackpot table<number, bagV2.BagItemInfo>
function UISpecialTreasureBagPanel:RefreshJackpotShow(jackpot)
    for i = 0, jackpot.Count - 1 do
        local gridIndex = self.mShowIndex[i + 1]
        local go = self.GridGoToIndex[gridIndex]
        ---@type UnityEngine.GameObject
        local choose = CS.Utility_Lua.Get(go.transform, "choose", "GameObject")
        if jackpot[i] and go then
            --self.IndexToItemInfo[gridIndex] = jackpot[i]
            CS.UIEventListener.Get(go).onClick = function(go)
                self:OnItemClicked(go)
            end
            self:ShowIcon(go, jackpot[i])
        end
    end
end

---显示中心奖励
function UISpecialTreasureBagPanel:ShowCenterReward(needShow)


end
--endregion

---@param jackpots table<number, bagV2.PreyTreasureBoxResponse>
function UISpecialTreasureBagPanel:StartFlickerItem(jackpots)
    self.mStartFlicker = true
    self.mCurrentTime = nil
    self.mCurrentFlickerCount = 0
    self.mFlickerPot = jackpots
end

function UISpecialTreasureBagPanel:CheckFlicker()
    if self.mStartFlicker then
        if self.mCurrentTime then
            if CS.UnityEngine.Time.time - self.mCurrentTime >= self.flickerTime * 5 then
                self:TryFlickItem()
            end
        else
            self.mCurrentTime = CS.UnityEngine.Time.time
            self:TryFlickItem()
        end
    end
end

function UISpecialTreasureBagPanel:TryFlickItem()
    if self.mCurrentFlickerCount < self.mFlickerPot.Count then
        ---@type bagV2.PreyTreasureBoxResponse
        local potInfo = self.mFlickerPot[self.mCurrentFlickerCount]
        self:RefreshJackpotShow(potInfo.jackpot)
        local reward = potInfo.jackpot[potInfo.rewardIndex]
        self:ShowCenter(reward)
        local gridIndex = self.mShowIndex[potInfo.rewardIndex + 1]
        self:ChooseItem(gridIndex, true)
        self.mCurrentFlickerCount = self.mCurrentFlickerCount + 1
        self.mCurrentTime = CS.UnityEngine.Time.time
    else
        self:StopFlick()
    end
end

function UISpecialTreasureBagPanel:StopFlick()
    self.mStartFlicker = false
    self.mCurrentTime = nil
    self.mCurrentFlickerCount = 0
    self.mFlickerPot = nil
end

---延迟刷新背包，避免按钮闪烁
function update()
    UISpecialTreasureBagPanel:UpdateBagItemInfo()
    UISpecialTreasureBagPanel:CheckFlicker()
end

function UISpecialTreasureBagPanel:UpdateBagItemInfo()
    if self.mNeedRefreshBag then
        self.mNeedRefreshBag = false
        self:InitExtendInfo()
    end
end



--region OnDestroy
function ondestroy()
    UISpecialTreasureBagPanel:OnRewardBtmClicked()
    if UISpecialTreasureBagPanel.mFlickerCoroutine ~= nil then
        StopCoroutine(UISpecialTreasureBagPanel.mFlickerCoroutine)
    end
    if UISpecialTreasureBagPanel.mCurrentFlickerCenter ~= nil then
        StopCoroutine(UISpecialTreasureBagPanel.mCurrentFlickerCenter)
    end
    if UISpecialTreasureBagPanel.mIEnumMiddleUpShopReward ~= nil then
        StopCoroutine(UISpecialTreasureBagPanel.mIEnumMiddleUpShopReward)
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPreyTreasureBoxMessage, UISpecialTreasureBagPanel.OnResPreyTreasureBoxMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDrawPreyTreasureBoxMessage, UISpecialTreasureBagPanel.OnResDrawPreyTreasureBoxMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResAwardPreyTreasureBoxMultiMessage, UISpecialTreasureBagPanel.OnResAwardPreyTreasureBoxMultiMessageReceived)
end
--endregion

return UISpecialTreasureBagPanel