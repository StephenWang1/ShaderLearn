---@class   UITreasureBagPanelBase:UIBase 掠宝袋
local UITreasureBagPanelBase = {}

--region 局部变量定义
---Index对应物品信息（物品位置对应信息）
---@type table<number,bagV2.BagItemInfo>
UITreasureBagPanelBase.IndexToItemInfo = {}

---格子对应Index
---@type table<UnityEngine.GameObject,number>
UITreasureBagPanelBase.GridGoToIndex = {}
---Index对应选中
UITreasureBagPanelBase.GridFlickerDic = {}
---格子对应icon
UITreasureBagPanelBase.GridToItemGameobject = {}
---闪烁时间
UITreasureBagPanelBase.flickerTime = 0.15
---协程
UITreasureBagPanelBase.mFlickerCoroutine = nil
---当前抽中的奖品
---@type bagV2.BagItemInfo
UITreasureBagPanelBase.mCurLottery = nil
---避免二次选中
---@type number
UITreasureBagPanelBase.mCurChoose = 0
---抽中奖品ID
UITreasureBagPanelBase.mRewardIndex = nil
---是否领取奖励
UITreasureBagPanelBase.mIsReward = false
---背包位置
UITreasureBagPanelBase.mBagPosition = nil
---中心item
UITreasureBagPanelBase.mRewardShow = nil
---掠宝袋ItemID
UITreasureBagPanelBase.mTreasureBagID = nil
---格子数目
UITreasureBagPanelBase.mGridNum = 9
---闪烁顺序
UITreasureBagPanelBase.mShowIndex = {
    1, 2, 3, 6, 9, 8, 7, 4
}
---奖励位置
UITreasureBagPanelBase.mRewardPos = 5
---lid
UITreasureBagPanelBase.lid = nil

---格子对应信息
---@type table<UnityEngine.GameObject,bagV2.BagItemInfo>
UITreasureBagPanelBase.GridGoToItemInfo = nil

---闪烁格子次数区间
UITreasureBagPanelBase.flickerMinCount = 6
UITreasureBagPanelBase.flickerMaxCount = 12
---总的格子个数
UITreasureBagPanelBase.allFlickerCount = 8

UITreasureBagPanelBase.mCurrentBagState = nil

UITreasureBagPanelBase.mNextBagItemInfo = nil
--endregion

--region 数据
---@return CSMainPlayerInfo
function UITreasureBagPanelBase:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2
function UITreasureBagPanelBase:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return CSStoreInfoV2
function UITreasureBagPanelBase:GetStoreInfoV2()
    if self.mStoreInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mStoreInfoV2 = self:GetMainPlayerInfo().StoreInfoV2
    end
    return self.mStoreInfoV2
end

--endregion

--region 组件
---关闭按钮
function UITreasureBagPanelBase:GetCloseButton()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return self.mCloseButton
end

---@return UnityEngine.GameObject 抽奖/领取按钮
function UITreasureBagPanelBase:GetReceiveButton()
    if self.mReceiveButton == nil then
        self.mReceiveButton = self:GetCurComp("WidgetRoot/event/btn_Open", "GameObject")
    end
    return self.mReceiveButton
end

---抽奖/领取文字
function UITreasureBagPanelBase:GetReceiveLabel()
    if self.mReceiveLabel == nil then
        self.mReceiveLabel = self:GetCurComp("WidgetRoot/event/btn_Open/Label", "UILabel")
    end
    return self.mReceiveLabel
end

---@return UISprite 右按钮背景
function UITreasureBagPanelBase:GetReceive_UISprite()
    if self.mReceiveSp == nil then
        self.mReceiveSp = self:GetCurComp("WidgetRoot/event/btn_Open/Background", "UISprite")
    end
    return self.mReceiveSp
end

---@return UIGridContainer 所有道具GridContainer
function UITreasureBagPanelBase:GetGridContainer_GridContainer()
    if self.mGridContainer == nil then
        self.mGridContainer = self:GetCurComp("WidgetRoot/view/root", "UIGridContainer")
    end
    return self.mGridContainer
end

---中间物品
function UITreasureBagPanelBase:GetTemp_GameObject()
    if self.mTemp_GameObject == nil then
        self.mTemp_GameObject = self:GetCurComp("WidgetRoot/view/temp", "GameObject")
    end
    return self.mTemp_GameObject
end

---中间物品
function UITreasureBagPanelBase:GetCenter_GameObject()
    if self.mCenterObj == nil then
        self.mCenterObj = self:GetCurComp("WidgetRoot/view/temp1", "GameObject")
    end
    return self.mCenterObj
end

---中间物品ICon
function UITreasureBagPanelBase:GetCenterIcon_UISprite()
    if self.mCenterIcon == nil then
        self.mCenterIcon = self:GetCurComp("WidgetRoot/view/temp1/icon", "UISprite")
    end
    return self.mCenterIcon
end

---@return UILabel 中间物品数目
function UITreasureBagPanelBase:GetCenterNum_UILabel()
    if self.mCenterNum == nil then
        self.mCenterNum = self:GetCurComp("WidgetRoot/view/temp1/count", "UILabel")
    end
    return self.mCenterNum
end

---@return UISprite 中奖物品更好标记
function UITreasureBagPanelBase:GetCenterGoodSign_Go()
    if self.mCenterGood == nil then
        self.mCenterGood = self:GetCurComp("WidgetRoot/view/temp1/good", "UISprite")
    end
    return self.mCenterGood
end

---中间物品选中
function UITreasureBagPanelBase:CenterChoose_GameObject()
    if self.mCenterChoose == nil then
        self.mCenterChoose = self:GetCurComp("WidgetRoot/view/temp1/choose", "GameObject")
    end
    return self.mCenterChoose
end

---@return UnityEngine.GameObject 购买宝箱按钮
function UITreasureBagPanelBase:GetBuyBoxBtn_Go()
    if self.mBuyBoxGo == nil then
        self.mBuyBoxGo = self:GetCurComp("WidgetRoot/event/btn_Buy", "GameObject")
    end
    return self.mBuyBoxGo
end

---@return UILabel 购买宝箱文本
function UITreasureBagPanelBase:GetBuyBoxBtn_UILabel()
    if self.mBuyBoxLB == nil then
        self.mBuyBoxLB = self:GetCurComp("WidgetRoot/event/btn_Buy/Label", "UILabel")
    end
    return self.mBuyBoxLB
end

---@return UISprite 左按钮背景
function UITreasureBagPanelBase:GetBuyBoxBtn_UISprite()
    if self.mBuyBoxSP == nil then
        self.mBuyBoxSP = self:GetCurComp("WidgetRoot/event/btn_Buy/Background", "UISprite")
    end
    return self.mBuyBoxSP
end

---@return UISprite 中间道具背景
function UITreasureBagPanelBase:GetCenterItemBg_UISprite()
    if self.mCenterItemBgSp == nil then
        self.mCenterItemBgSp = self:GetCurComp("WidgetRoot/window/shadow", "UISprite")
    end
    return self.mCenterItemBgSp
end

---@return UISprite 背景
function UITreasureBagPanelBase:GetPanelBg_UISprite()
    if self.mPanelBgSp == nil then
        self.mPanelBgSp = self:GetCurComp("WidgetRoot/window/background", "UISprite")
    end
    return self.mPanelBgSp
end
--endregion

--region 初始化
function UITreasureBagPanelBase:Init()
    self:GetCenterIcon_UISprite().spriteName = ""
    self.GridGoToItemInfo = {}
    self:InitParams()
    self:InitPanel()
    self:BindMessage()
    self:BindEvents()
end

function UITreasureBagPanelBase:Show(customData)
    if customData then
        --uimanager:ClosePanel("UIBagPanel")
        self:InitPanelInfo(customData.bagItemInfo)
    end
end

function UITreasureBagPanelBase:BindEvents()
    CS.UIEventListener.Get(self:GetCloseButton()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetReceiveButton()).onClick = function(go)
        self:OnReceiveButtonClicked(go)
    end
    CS.UIEventListener.Get(self:GetBuyBoxBtn_Go()).onClick = function(go)
        self:OnBuyTreasureBoxClicked(go)
    end
end

function UITreasureBagPanelBase:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPreyTreasureBagMessage, UITreasureBagPanelBase.OnResPreyTreasureBagMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDrawPreyTreasureBagMessage, UITreasureBagPanelBase.OnResDrawPreyTreasureBagMessageReceived)
end

---初始化参数
function UITreasureBagPanelBase:InitParams()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20426)
    if isFind then
        local flickerInfo = string.Split(info.value, '#')
        UITreasureBagPanelBase.flickerTime = tonumber(flickerInfo[1]) / 2000
        UITreasureBagPanelBase.flickerMinCount = tonumber(flickerInfo[2])
        UITreasureBagPanelBase.flickerMaxCount = tonumber(flickerInfo[3])
    end
end

---初始化界面
function UITreasureBagPanelBase:InitPanel()
    self:GetGridContainer_GridContainer().MaxCount = self.mGridNum
    self.GridGoToIndex = {}
    self.GridFlickerDic = {}
    self.GridToItemGameobject = {}
    for i = 0, self:GetGridContainer_GridContainer().controlList.Count - 1 do
        local item = self:GetGridContainer_GridContainer().controlList[i]
        local choose = item.transform:Find("choose").gameObject
        local sp = CS.Utility_Lua.Get(item.transform, "icon", "UISprite")
        sp.spriteName = ""
        self.GridGoToIndex[i + 1] = item
        self.GridFlickerDic[i + 1] = choose
        self.GridToItemGameobject[item] = item.transform
        self:ChooseItem(i + 1, false)
    end
    local panel = uimanager:GetPanel('UIMainChatPanel')
    if panel then
        self.mBagPosition = panel.btn_bag.transform
    end
    self.mRewardShow = self.GridGoToIndex[self.mRewardPos]
end

---初始化界面（宝箱）数据
function UITreasureBagPanelBase:InitPanelInfo(bagItemInfo)
    if bagItemInfo then
        ---@type bagV2.BagItemInfo
        self.bagItemInfo = bagItemInfo
        self.lid = self.bagItemInfo.lid
        if self.lid then
            networkRequest.ReqUseItem(1, self.lid, 0)
        end
    end
end
--endregion

--region 服务器消息
---打开掠宝袋消息
function UITreasureBagPanelBase.OnResPreyTreasureBagMessageReceived(msgId, tblData, csData)
    UITreasureBagPanelBase:RefreshJackpot(tblData, csData)
end

---刷新奖池
---@param csData bagV2.PreyTreasureBagResponse
---@param tblData bagV2.PreyTreasureBagResponse
function UITreasureBagPanelBase:RefreshJackpot(tblData, csData)
    self.GridGoToItemInfo = {}
    self.mRewardIndex = csData.rewardIndex
    local info = csData.jackpot
    if info == nil then
        return
    end
    self.IndexToItemInfo = {}
    --刷新奖池显示
    for i = 0, info.Count - 1 do
        local gridIndex = self.mShowIndex[i + 1]
        local go = self.GridGoToIndex[gridIndex]
        if info[i] then
            self.IndexToItemInfo[gridIndex] = info[i]
            CS.UIEventListener.Get(go).onClick = function(go)
                self:OnItemClicked(go)
            end
            self:ShowIcon(go, info[i])
        end
    end
    ---中间Index隐藏
    self.GridGoToIndex[self.mRewardPos]:SetActive(false)
    local isRaffle = tblData.isRaffle --为true
    self:RefreshBtnShow(isRaffle)
    if self.mCurrentBagState ~= LuaEnumTreasureBagState.Next then
        self.mCurrentBagState = isRaffle and LuaEnumTreasureBagState.Open or LuaEnumTreasureBagState.UnOpen
    end
    self:GetCenter_GameObject():SetActive(isRaffle)
    self:SetCenterChooseGoState(isRaffle)
    local reward = info[csData.rewardIndex]
    self.mCurLottery = reward
    self:ShowCenter(reward)
end

---设置中间选中状态
---@param isShow boolean 是否显示中间选中框
function UITreasureBagPanelBase:SetCenterChooseGoState(isShow)
    self:CenterChoose_GameObject():SetActive(isShow)
    self.mCanClickCenter = isShow
end

---刷新按钮
function UITreasureBagPanelBase:RefreshBtnShow(isRaffle)
    self:GetReceiveLabel().text = ternary(isRaffle, "[FFF0C2]领取奖励", "[C3F4FF]开启宝箱")
    UITreasureBagPanelBase:GetReceive_UISprite().spriteName = ternary(isRaffle, "anniu10", "anniu1")
end

---领取掠宝袋
function UITreasureBagPanelBase.OnResDrawPreyTreasureBagMessageReceived()
    UITreasureBagPanelBase:FlySingleItem(UITreasureBagPanelBase.mCurLottery.itemId)
    UITreasureBagPanelBase:OpenNextBox()
end

---单个物品飞入背包
function UITreasureBagPanelBase:FlySingleItem(itemId)
    local startPos = self.mRewardShow.transform.position
    local endPos = self.mBagPosition.position
    if startPos and endPos and itemId then
        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = itemId, from = startPos, to = endPos })
    end
end

---开启下一个宝箱
function UITreasureBagPanelBase:OpenNextBox()
    local bagItemInfo = self:IsAnyBoxInBag()
    if bagItemInfo then
        self.mCurrentBagState = LuaEnumTreasureBagState.Next
        self.mNextBagItemInfo = bagItemInfo
        self:GetReceiveLabel().text = luaEnumColorType.Gray .. "[C3F4FF]开启下个"
        self:GetReceive_UISprite().spriteName = "anniu1"
    else
        self:ClosePanel()
    end
end

---刷新中心Icon显示
function UITreasureBagPanelBase:ShowCenter(info)
    if info then
        self:GetCenterIcon_UISprite().gameObject:SetActive(true)
        self:GetCenterNum_UILabel().gameObject:SetActive(true)
        local ItemInfo = self:GetItemInfoCache(info.itemId)
        if ItemInfo then
            self:GetCenterIcon_UISprite().spriteName = ItemInfo.icon
            if not CS.StaticUtility.IsNull(self:GetCenterGoodSign_Go()) then
                local arrowType = Utility.GetArrowType(info)
                self:GetCenterGoodSign_Go().gameObject:SetActive(arrowType ~= LuaEnumArrowType.NONE)
                if arrowType ~= LuaEnumArrowType.NONE then
                    self:GetCenterGoodSign_Go().spriteName = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(arrowType)
                end
            end
            self:GetCenterNum_UILabel().text = self:GetShowNum(info.count)
            CS.UIEventListener.Get(self:GetCenterIcon_UISprite().gameObject).onClick = function(go)
                -- if self.mCanClickCenter then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = ItemInfo, showRight = false })
                --   end
            end
        end
        if self.GridGoToItemInfo then
            self.GridGoToItemInfo[self:GetCenter_GameObject()] = info
        end
    else
        self:GetCenterIcon_UISprite().gameObject:SetActive(false)
        self:GetCenterGoodSign_Go().gameObject:SetActive(false)
        self:GetCenterNum_UILabel().gameObject:SetActive(false)
    end
end

---刷新Icon显示
function UITreasureBagPanelBase:ShowIcon(go, info)
    if go and info and self.GridGoToItemInfo then
        self.GridGoToItemInfo[go] = info
        ---@type UISprite
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        local itemInfo = self:GetItemInfoCache(info.itemId)
        if itemInfo then
            icon.spriteName = itemInfo.icon
        end
        ---@type UILabel
        local label = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
        label.text = self:GetShowNum(info.count)
        ---@type UISprite
        local good = CS.Utility_Lua.Get(go.transform, "good", "UISprite")
        local arrowType = Utility.GetArrowType(info)
        good.gameObject:SetActive(arrowType ~= LuaEnumArrowType.NONE)
        if arrowType ~= LuaEnumArrowType.NONE then
            good.spriteName = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(arrowType)
        end
    end
end

function UITreasureBagPanelBase:GetShowNum(num)
    if (num == 1) then
        return ""
    elseif (num > 1 and num < 10000) then
        return num
    elseif (num >= 10000) then
        return math.floor(num / 10000) .. "W"
    end
    return 0
end

---设置第Index个物品选中
function UITreasureBagPanelBase:ChooseItem(index, isShow)
    if self.mCurrentChooseIndex then
        local chooseLast = self.GridFlickerDic[self.mCurrentChooseIndex]
        chooseLast:SetActive(false)
    end
    self.mCurrentChooseIndex = index
    local choose = self.GridFlickerDic[index]
    if choose and CS.StaticUtility.IsNull(choose) == false then
        choose:SetActive(isShow)
    end
end

--endregion

--region UI事件
---关闭界面
function UITreasureBagPanelBase.OnCloseButtonClicked()
    uimanager:ClosePanel("UITreasureBagPanelBase")
end

---开启协程前
function UITreasureBagPanelBase:BeforeFlicker()
    self:GetReceiveLabel().text = "[878787]开启宝箱"
    self:GetReceive_UISprite().spriteName = "anniu19"
end

---协程闪烁
function UITreasureBagPanelBase:StartFlicker()
    if self.mRewardIndex ~= nil then
        self:BeforeFlicker()
        self.mCurChoose = self.mCurChoose + 1
        local isRun = true
        local flickerCount = 0
        local lastChoose = 0
        self.flickerCount = math.ceil(CS.UnityEngine.Random.Range(self.flickerMinCount, self.flickerMaxCount)) + 1
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
            --中心物品根据当前选中改变
            local currentInfo = self.IndexToItemInfo[index]
            if currentInfo then
                self:ShowCenter(currentInfo)
            end
            --结束选中
            if flickerCount >= self.flickerCount then
                --and index == UITreasureBagPanelBase.mRewardIndex + 1
                self:ChooseItem(index, false)
                break
            end
            flickerCount = flickerCount + 1
            arrayIndex = arrayIndex + 1 > self.allFlickerCount and self.allFlickerCount - (arrayIndex - 1) or arrayIndex + 1
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self.flickerTime))
        end
        self.mCurChoose = self.mCurChoose - 1
        self:AfterFlicker()
    end
end

---结束协程闪烁后
function UITreasureBagPanelBase:AfterFlicker()
    self:CenterChoose_GameObject():SetActive(true)
    self:GetReceiveLabel().text = "[FFF0C2]领取奖励"
    self:GetReceive_UISprite().spriteName = "anniu10"
end

---领取奖励
function UITreasureBagPanelBase:OnReceiveButtonClicked()
    if UITreasureBagPanelBase.mCurChoose ~= 0 then
        return
    end
    if UITreasureBagPanelBase.mCurrentBagState == LuaEnumTreasureBagState.Open then
        if self.lid then
            networkRequest.ReqDrawPreyTreasureBag(UITreasureBagPanelBase.lid)
        end
    elseif UITreasureBagPanelBase.mCurrentBagState == LuaEnumTreasureBagState.UnOpen then
        UITreasureBagPanelBase.mCurrentBagState = LuaEnumTreasureBagState.Open
        UITreasureBagPanelBase.mFlickerCoroutine = StartCoroutine(function()
            self:StartFlicker()
        end)
        UITreasureBagPanelBase:GetCenter_GameObject():SetActive(true)
        if UITreasureBagPanelBase.lid then
            networkRequest.ReqRafflePreyTreasureBag(UITreasureBagPanelBase.lid)
        end
    elseif UITreasureBagPanelBase.mCurrentBagState == LuaEnumTreasureBagState.Next then
        if UITreasureBagPanelBase.mNextBagItemInfo then
            UITreasureBagPanelBase.mCurrentBagState = LuaEnumTreasureBagState.UnOpen
            UITreasureBagPanelBase:InitPanelInfo(UITreasureBagPanelBase.mNextBagItemInfo)
        end
    end
end

---点击Item显示Tips
function UITreasureBagPanelBase:OnItemClicked(go)
    if self.GridGoToItemInfo == nil or self.GridGoToItemInfo[go] == nil then
        return
    end
    local info = self.GridGoToItemInfo[go]
    local itemInfo = self:GetItemInfoCache(info.itemId)
    if itemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
    end
end
--endregion

--region otherFunction

---根据目标id获取初始index
function UITreasureBagPanelBase:GetIndexOfRewardID(id)
    return self.allFlickerCount - (self.flickerCount + (self.allFlickerCount - id)) % self.allFlickerCount
end

--endregion

--region 获取背包宝箱数据

---@return bagV2.BagItemInfo 背包中是否还有宝箱,没有不返回
function UITreasureBagPanelBase:IsAnyBoxInBag()
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
            if itemInfo and Utility.IsEquipBox(itemInfo) and isLevelEnough then
                return bagItemInfo
            end
        end
    end
end

--endregion

--region 缓存表数据
---@return TABLE.CFG_ITEMS 获取item数据
function UITreasureBagPanelBase:GetItemInfoCache(itemId)
    if itemId == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[itemId]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = info
    end
    return info
end
--endregion

--region 购买宝箱
---购买宝箱
function UITreasureBagPanelBase:OnBuyTreasureBoxClicked()
    if self:GetStoreInfoV2() then
        local storType = 3--元宝
        self:GetStoreInfoV2():TryGetStore(storType, function()
            if self:GetStoreInfoV2().StoreDataDic:ContainsKey(storType) then
                local storeInfo = self:GetStoreInfoV2().StoreDataDic[storType]

                local boxID = CS.Cfg_GlobalTableManager.Instance:GetAllTreasureBoxId()
                if boxID then
                    for i = 0, boxID.Length - 1 do
                        local id = boxID[i]
                        for k, v in pairs(storeInfo.storeUnitDic) do
                            local res, storeInfo = CS.Cfg_StoreTableManager.Instance.dic:TryGetValue(k)
                            if res and storeInfo.itemId == id then
                                Utility.TransferShopChooseItem(id)
                                return
                            end
                        end
                    end
                end
            end
        end)
    end
end

--endregion

--region OnDestroy
function ondestroy()
    if UITreasureBagPanelBase.mFlickerCoroutine ~= nil then
        StopCoroutine(UITreasureBagPanelBase.mFlickerCoroutine)
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPreyTreasureBagMessage, UITreasureBagPanelBase.OnResPreyTreasureBagMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDrawPreyTreasureBagMessage, UITreasureBagPanelBase.OnResDrawPreyTreasureBagMessageReceived)
end
--endregion

return UITreasureBagPanelBase