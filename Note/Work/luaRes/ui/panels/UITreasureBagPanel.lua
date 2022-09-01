---@class   UITreasureBagPanel:UIBase 掠宝袋
local UITreasureBagPanel = {}

--region 局部变量定义
---Index对应物品信息（物品位置对应信息）
---@type table<number,bagV2.BagItemInfo>
UITreasureBagPanel.IndexToItemInfo = {}

---格子对应Index
---@type table<UnityEngine.GameObject,number>
UITreasureBagPanel.GridGoToIndex = {}
---Index对应选中
UITreasureBagPanel.GridFlickerDic = {}
---格子对应icon
UITreasureBagPanel.GridToItemGameobject = {}
---闪烁时间
UITreasureBagPanel.flickerTime = 0.05
---十连闪烁时间
UITreasureBagPanel.shilianFlickerTime = 0.03
---协程
UITreasureBagPanel.mFlickerCoroutine = nil
---当前抽中的奖品
---@type bagV2.BagItemInfo
UITreasureBagPanel.mCurLottery = nil
---避免二次选中
---@type number
UITreasureBagPanel.mCurChoose = 0
---抽中奖品ID
UITreasureBagPanel.mRewardIndex = nil
---是否领取奖励
UITreasureBagPanel.mIsReward = false
---背包位置
UITreasureBagPanel.mBagPosition = nil
---中心item
UITreasureBagPanel.mRewardShow = nil
---掠宝袋ItemID
UITreasureBagPanel.mTreasureBagID = nil
---格子数目
UITreasureBagPanel.mGridNum = 8
---闪烁顺序
UITreasureBagPanel.mShowIndex = {
    1, 3, 5, 7, 8, 6, 4, 2
}
---奖励位置
UITreasureBagPanel.mRewardPos = 5
---lid
UITreasureBagPanel.lid = nil

UITreasureBagPanel.nowItemID = 5770093

---格子对应信息
---@type table<UnityEngine.GameObject,bagV2.BagItemInfo>
UITreasureBagPanel.GridGoToItemInfo = nil

---闪烁格子次数区间
UITreasureBagPanel.flickerMinCount = 6
UITreasureBagPanel.flickerMaxCount = 12
---总的格子个数
UITreasureBagPanel.allFlickerCount = 8

UITreasureBagPanel.mCurrentBagState = nil

UITreasureBagPanel.mNextBagItemInfo = nil

---是不是批量领取
UITreasureBagPanel.isClickToReceiveConsecutively = false
---批量领取次数
UITreasureBagPanel.numberOfConsecutiveRewards = 0
--endregion

--region 数据
---@return CSMainPlayerInfo
function UITreasureBagPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2
function UITreasureBagPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return CSStoreInfoV2
function UITreasureBagPanel:GetStoreInfoV2()
    if self.mStoreInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mStoreInfoV2 = self:GetMainPlayerInfo().StoreInfoV2
    end
    return self.mStoreInfoV2
end

--endregion

--region 组件
---关闭按钮
function UITreasureBagPanel:GetCloseButton()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return self.mCloseButton
end

---@return UnityEngine.GameObject 抽奖/领取按钮
function UITreasureBagPanel:GetReceiveButton()
    if self.mReceiveButton == nil then
        self.mReceiveButton = self:GetCurComp("WidgetRoot/event/btn_Open", "GameObject")
    end
    return self.mReceiveButton
end

---抽奖/领取文字
function UITreasureBagPanel:GetReceiveLabel()
    if self.mReceiveLabel == nil then
        self.mReceiveLabel = self:GetCurComp("WidgetRoot/event/btn_Open/Label", "UILabel")
    end
    return self.mReceiveLabel
end

---@return UISprite 右按钮背景
function UITreasureBagPanel:GetReceive_UISprite()
    if self.mReceiveSp == nil then
        self.mReceiveSp = self:GetCurComp("WidgetRoot/event/btn_Open/Background", "UISprite")
    end
    return self.mReceiveSp
end

---@return UIGridContainer 所有道具GridContainer
function UITreasureBagPanel:GetGridContainer_GridContainer()
    if self.mGridContainer == nil then
        self.mGridContainer = self:GetCurComp("WidgetRoot/view/root", "UIGridContainer")
    end
    return self.mGridContainer
end

---中间物品
function UITreasureBagPanel:GetTemp_GameObject()
    if self.mTemp_GameObject == nil then
        self.mTemp_GameObject = self:GetCurComp("WidgetRoot/view/temp", "GameObject")
    end
    return self.mTemp_GameObject
end

---中间物品
function UITreasureBagPanel:GetCenter_GameObject()
    if self.mCenterObj == nil then
        self.mCenterObj = self:GetCurComp("WidgetRoot/view/temp1", "GameObject")
    end
    return self.mCenterObj
end

---中间物品ICon
function UITreasureBagPanel:GetCenterIcon_UISprite()
    if self.mCenterIcon == nil then
        self.mCenterIcon = self:GetCurComp("WidgetRoot/view/temp1/icon", "UISprite")
    end
    return self.mCenterIcon
end

---@return UILabel 中间物品数目
function UITreasureBagPanel:GetCenterNum_UILabel()
    if self.mCenterNum == nil then
        self.mCenterNum = self:GetCurComp("WidgetRoot/view/temp1/count", "UILabel")
    end
    return self.mCenterNum
end

---@return UISprite 中奖物品更好标记
function UITreasureBagPanel:GetCenterGoodSign_Go()
    if self.mCenterGood == nil then
        self.mCenterGood = self:GetCurComp("WidgetRoot/view/temp1/good", "UISprite")
    end
    return self.mCenterGood
end

---@return UISprite 中奖物品更好标记
function UITreasureBagPanel:GetCenterBest()
    if self.mCenterBest == nil then
        self.mCenterBest = self:GetCurComp("WidgetRoot/view/temp1/best", "GameObject")
    end
    return self.mCenterBest
end

---中间物品选中
function UITreasureBagPanel:CenterChoose_GameObject()
    if self.mCenterChoose == nil then
        self.mCenterChoose = self:GetCurComp("WidgetRoot/view/temp1/choose", "GameObject")
    end
    return self.mCenterChoose
end

---@return UnityEngine.GameObject 购买宝箱按钮
function UITreasureBagPanel:GetBuyBoxBtn_Go()
    if self.mBuyBoxGo == nil then
        self.mBuyBoxGo = self:GetCurComp("WidgetRoot/event/btn_Buy", "GameObject")
    end
    return self.mBuyBoxGo
end

---@return UILabel 购买宝箱文本
function UITreasureBagPanel:GetBuyBoxBtn_UILabel()
    if self.mBuyBoxLB == nil then
        self.mBuyBoxLB = self:GetCurComp("WidgetRoot/event/btn_Buy/Label", "UILabel")
    end
    return self.mBuyBoxLB
end

---@return UISprite 左按钮背景
function UITreasureBagPanel:GetBuyBoxBtn_UISprite()
    if self.mBuyBoxSP == nil then
        self.mBuyBoxSP = self:GetCurComp("WidgetRoot/event/btn_Buy/Background", "UISprite")
    end
    return self.mBuyBoxSP
end

---@return UISprite 中间道具背景
function UITreasureBagPanel:GetCenterItemBg_UISprite()
    if self.mCenterItemBgSp == nil then
        self.mCenterItemBgSp = self:GetCurComp("WidgetRoot/window/shadow", "UISprite")
    end
    return self.mCenterItemBgSp
end

---@return UISprite 背景
function UITreasureBagPanel:GetPanelBg_UISprite()
    if self.mPanelBgSp == nil then
        self.mPanelBgSp = self:GetCurComp("WidgetRoot/window/background", "UISprite")
    end
    return self.mPanelBgSp
end
--endregion

function UITreasureBagPanel:GetItemTable()
    if self.mItemTable == nil then
        self.mItemTable = clientTableManager.cfg_itemsManager:TryGetValue(UITreasureBagPanel.nowItemID)
    end
    return self.mItemTable
end

--region 初始化
function UITreasureBagPanel:Init()
    self:GetCenterIcon_UISprite().spriteName = ""
    self.GridGoToItemInfo = {}
    self:InitParams()
    --    self:InitPanel()
    self:SetGrid()
    self:BindMessage()
    self:BindEvents()
end

function UITreasureBagPanel:Show(customData)
    if customData then
        --uimanager:ClosePanel("UIBagPanel")
        self:InitPanelInfo(customData.bagItemInfo)
    end
end

function UITreasureBagPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseButton()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetReceiveButton()).onClick = function(go)
        self:OnReceiveButtonClicked(go)
    end
    CS.UIEventListener.Get(self:GetBuyBoxBtn_Go()).onClick = function(go)
        self:OnStartReceivingRewardsContinuously(go)
    end
    CS.UIEventListener.Get(self:GetCenter_GameObject()).onClick = function(go)
        self:OnGetCenter_GameObjectClicked(go)
    end

end

function UITreasureBagPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPreyTreasureBagMessage, UITreasureBagPanel.OnResPreyTreasureBagMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDrawPreyTreasureBagMessage, UITreasureBagPanel.OnResDrawPreyTreasureBagMessageReceived)
end

---初始化参数
function UITreasureBagPanel:InitParams()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20426)
    if isFind then
        local flickerInfo = string.Split(info.value, '#')
        if (flickerInfo ~= nil and #flickerInfo > 2) then
            UITreasureBagPanel.flickerTime = tonumber(flickerInfo[1]) / 2000
            UITreasureBagPanel.flickerMinCount = tonumber(flickerInfo[2])
            UITreasureBagPanel.flickerMaxCount = tonumber(flickerInfo[3])
        end
    end
    isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23021)
    if isFind then
        local flickerInfo = string.Split(info.value, '#')
        if (flickerInfo ~= nil and #flickerInfo > 0) then
            UITreasureBagPanel.shilianflickerTime = tonumber(flickerInfo[1]) / 2000
        end
    end
end

---初始化界面
function UITreasureBagPanel:InitPanel()
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

function UITreasureBagPanel:SetGrid()
    self.GridGoToIndex = {}
    self.GridFlickerDic = {}
    self.GridToItemGameobject = {}
    if (self.GridContainer == nil) then
        ---@type Lua_UICircleGridContainer
        self.GridContainer = templatemanager.GetNewTemplate(self:GetGridContainer_GridContainer().gameObject, luaComponentTemplates.Lua_UICircleGridContainer)
        self.GridContainer:InitControlTemplate(self:GetTemp_GameObject())
        local LayItemMaxCount = {}
        table.insert(LayItemMaxCount, self.mGridNum)
        self.GridContainer:SetLayItemMaxCount(LayItemMaxCount)

        local LayerWidthList = {}
        table.insert(LayerWidthList, 120)
        self.GridContainer:SetLayerWidthList(LayerWidthList)
    end
    self.GridContainer:SetMaxCount(self.mGridNum)
    local index = 1
    for i, obj in pairs(self.GridContainer.ControlList) do
        local item = obj
        item.gameObject.name = index
        local choose = item.transform:Find("choose").gameObject
        local sp = CS.Utility_Lua.Get(item.transform, "icon", "UISprite")
        sp.spriteName = ""
        self.GridGoToIndex[index] = item
        self.GridFlickerDic[index] = choose
        self.GridToItemGameobject[item] = item.transform
        self:ChooseItem(index, false)
        index = index + 1
    end

    local panel = uimanager:GetPanel('UIMainChatPanel')
    if panel then
        self.mBagPosition = panel.btn_bag.transform
    end
    self.mRewardShow = self.GridGoToIndex[self.mRewardPos]
end

---初始化界面（宝箱）数据
function UITreasureBagPanel:InitPanelInfo(bagItemInfo)
    if bagItemInfo then
        ---@type bagV2.BagItemInfo
        self.bagItemInfo = bagItemInfo
        self.itemInfo = bagItemInfo.ItemTABLE
        self.lid = self.bagItemInfo.lid
        if self.lid then
            networkRequest.ReqUseItem(1, self.lid, 0)
        end
    end
end
--endregion

--region 服务器消息
---打开掠宝袋消息
function UITreasureBagPanel.OnResPreyTreasureBagMessageReceived(msgId, tblData, csData)
    UITreasureBagPanel:RefreshJackpot(tblData, csData)
    UITreasureBagPanel:ReceivingRewardsContinuously()
end

---刷新奖池
---@param csData bagV2.PreyTreasureBagResponse
---@param tblData bagV2.PreyTreasureBagResponse
function UITreasureBagPanel:RefreshJackpot(tblData, csData)
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
function UITreasureBagPanel:SetCenterChooseGoState(isShow)
    self:CenterChoose_GameObject():SetActive(isShow)
    self.mCanClickCenter = isShow
end

---刷新按钮
function UITreasureBagPanel:RefreshBtnShow(isRaffle)
    self:GetReceiveLabel().text = ternary(isRaffle, "[FFF0C2]领取奖励", "[C3F4FF]开启宝箱")
    UITreasureBagPanel:GetReceive_UISprite().spriteName = ternary(isRaffle, "anniu10", "anniu1")
    self:SetBatchBtnState(isRaffle)
end

--region 批量领取
---设置批量领取按钮显示状态
function UITreasureBagPanel:SetBatchBtnState(isReward, isCloseAll)
    if self.mCurChoose ~= 0 then
        self:GetReceiveButton():SetActive(false)
        self:GetBuyBoxBtn_Go():SetActive(false)
    else
        local boxNum = self:GetBagBoxNum()
        local mUseAllNum = math.min(boxNum, self:GetUseAllNumMax())
        local canUseAll = mUseAllNum >= self:GetUseAllNumMin()
        self:GetBuyBoxBtn_Go():SetActive(not isReward and canUseAll)

        local startPos = self:GetReceiveButton().transform.localPosition
        startPos.x = (canUseAll and not isReward) and -95 or 0
        self:GetReceiveButton().transform.localPosition = startPos
        if (canUseAll == false) then
            self:GetBuyBoxBtn_Go():SetActive(canUseAll)
        end
        self:GetBuyBoxBtn_UILabel().text = "[FFCDA5]开启" .. mUseAllNum .. "个"

        self:GetBuyBoxBtn_UISprite().spriteName = "anniu22"
        --self:GetReceive_UISprite().spriteName = "anniu21"
        --self:GetReceiveLabel().text = "[C3F4FF]开启1个"

        --self:GetRewardBtn_Go():SetActive(isReward)
        --self:GetReceiveButton():SetActive(not isReward)
    end
end

---@return number 同类宝箱个数
function UITreasureBagPanel:GetBagBoxNum()
    local num = 0
    if self.itemInfo then
        num = self:GetBagItemNum(self.itemInfo.id)
    end
    return num
end

---@return number 背包中某种道具的数目
function UITreasureBagPanel:GetBagItemNum(id)
    if self:GetBagInfoV2() then
        return self:GetBagInfoV2():GetItemCountByItemId(id)
    end
    return 0
end

---@return number 使用全部数目上限
function UITreasureBagPanel:GetUseAllNumMax()
    return self:GetUseAllNumInfo(2)
end

---@return number 使用全部数目下限
function UITreasureBagPanel:GetUseAllNumMin()
    return self:GetUseAllNumInfo(1)
end

---@param type number 下限1/上限2
function UITreasureBagPanel:GetUseAllNumInfo(type)
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

--endregion

---领取掠宝袋
function UITreasureBagPanel.OnResDrawPreyTreasureBagMessageReceived()
    if (UITreasureBagPanel.numberOfConsecutiveRewards) then
        UITreasureBagPanel.numberOfConsecutiveRewards = UITreasureBagPanel.numberOfConsecutiveRewards - 1
    end
    UITreasureBagPanel:FlySingleItem(UITreasureBagPanel.mCurLottery.itemId)
    UITreasureBagPanel:OpenNextBox()
end

---点击开始连续领取奖励
function UITreasureBagPanel:OnStartReceivingRewardsContinuously()
    local boxNum = self:GetBagBoxNum()
    local mUseAllNum = math.min(boxNum, self:GetUseAllNumMax())
    self.numberOfConsecutiveRewards = mUseAllNum

    self.isClickToReceiveConsecutively = true
    self:ReceivingRewardsContinuously()
end

---连续领取奖励
function UITreasureBagPanel:ReceivingRewardsContinuously()
    if UITreasureBagPanel.mCurChoose ~= 0 then
        return
    end
    ---连续领取次数不足
    if (not UITreasureBagPanel.isClickToReceiveConsecutively or UITreasureBagPanel.numberOfConsecutiveRewards <= 0) then
        UITreasureBagPanel.isClickToReceiveConsecutively = false
        UITreasureBagPanel.numberOfConsecutiveRewards = 0
        return
    end

    if UITreasureBagPanel.mCurrentBagState == LuaEnumTreasureBagState.Open then
        if UITreasureBagPanel.lid then
            networkRequest.ReqDrawPreyTreasureBag(UITreasureBagPanel.lid)
        end
        UITreasureBagPanel:CloseAllSelect()
    elseif UITreasureBagPanel.mCurrentBagState == LuaEnumTreasureBagState.UnOpen then
        if self.IsonFlicker then
            return
        end
        UITreasureBagPanel:CloseAllSelect()
        UITreasureBagPanel.mCurrentBagState = LuaEnumTreasureBagState.Open
        UITreasureBagPanel.mFlickerCoroutine = StartCoroutine(function()
            UITreasureBagPanel:StartFlicker()
        end)
        UITreasureBagPanel:GetCenter_GameObject():SetActive(true)
        if UITreasureBagPanel.lid then
            networkRequest.ReqRafflePreyTreasureBag(UITreasureBagPanel.lid)
        end
    elseif UITreasureBagPanel.mCurrentBagState == LuaEnumTreasureBagState.Next then
        if UITreasureBagPanel.mNextBagItemInfo then
            UITreasureBagPanel.mCurrentBagState = LuaEnumTreasureBagState.UnOpen
            UITreasureBagPanel:InitPanelInfo(UITreasureBagPanel.mNextBagItemInfo)
        end
    end
end

---单个物品飞入背包
function UITreasureBagPanel:FlySingleItem(itemId)
    local startPos = self.mRewardShow.transform.position
    local endPos = self.mBagPosition.position
    if startPos and endPos and itemId then
        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = itemId, from = startPos, to = endPos })
    end
end

---开启下一个宝箱
function UITreasureBagPanel:OpenNextBox()
    local bagItemInfo = self:IsAnyBoxInBag()
    if bagItemInfo then
        self.mCurrentBagState = LuaEnumTreasureBagState.Next
        self.mNextBagItemInfo = bagItemInfo
        self:GetReceiveLabel().text = luaEnumColorType.Gray .. "[C3F4FF]开启下个"
        self:GetReceive_UISprite().spriteName = "anniu1"
    else
        self:ClosePanel()
    end
    if self.mNextBagItemInfo then
        self.mCurrentBagState = LuaEnumTreasureBagState.UnOpen
        self:InitPanelInfo(self.mNextBagItemInfo)
    end
end

---刷新中心Icon显示
function UITreasureBagPanel:ShowCenter(info)
    --if true then
    --    print("刷新中心Icon显示")
    --    return
    --end
    --self:GetCenter_GameObject():SetActive(true)
    --self:GetCenterIcon_UISprite().gameObject:SetActive(true)
    --self:GetCenterNum_UILabel().gameObject:SetActive(true)
    --if  self:GetItemTable()~=nil then
    --    self:GetCenterIcon_UISprite().spriteName=self:GetItemTable():GetIcon()
    --    self:GetCenterNum_UILabel().text= CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UITreasureBagPanel.nowItemID)
    --end

    if info then
        self:GetCenterIcon_UISprite().gameObject:SetActive(true)
        self:GetCenterNum_UILabel().gameObject:SetActive(true)
        self:GetCenterBest().gameObject:SetActive(self:IsRareItem(info.itemId))
        local ItemInfo = self:GetItemInfoCache(info.itemId)
        if ItemInfo then
            self.centerItemTable = ItemInfo
            self:GetCenterIcon_UISprite().spriteName = ItemInfo.icon
            if not CS.StaticUtility.IsNull(self:GetCenterGoodSign_Go()) then
                local arrowType = Utility.GetArrowType(info)
                self:GetCenterGoodSign_Go().gameObject:SetActive(arrowType ~= LuaEnumArrowType.NONE)
                if arrowType ~= LuaEnumArrowType.NONE then
                    self:GetCenterGoodSign_Go().spriteName = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(arrowType)
                end
            end
            self:GetCenterNum_UILabel().text = self:GetShowNum(info.count)
        end
        if self.GridGoToItemInfo then
            self.GridGoToItemInfo[self:GetCenter_GameObject()] = info
        end
    else
        self:GetCenterIcon_UISprite().gameObject:SetActive(false)
        self:GetCenterGoodSign_Go().gameObject:SetActive(false)
        self:GetCenterNum_UILabel().gameObject:SetActive(false)
        self:GetCenterBest().gameObject:SetActive(false)
    end
end

---刷新Icon显示
function UITreasureBagPanel:ShowIcon(go, info)
    if go and info and self.GridGoToItemInfo then
        self.GridGoToItemInfo[go] = info
        ---@type UISprite
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        local icon2 = CS.Utility_Lua.Get(go.transform, "icon2", "UISprite")
        local best = CS.Utility_Lua.Get(go.transform, "best", "UISprite")
        local itemInfo = self:GetItemInfoCache(info.itemId)
        local monsterInfo = self:GetMonsterItemInfoCache_Lua(info.itemId)
        local isRareItem = self:IsRareItem(info.itemId)
        best.gameObject:SetActive(isRareItem)
        icon.gameObject:SetActive(monsterInfo == nil)
        icon2.gameObject:SetActive(monsterInfo ~= nil)
        if itemInfo then
            icon.spriteName = itemInfo.icon
        end
        if monsterInfo then
            icon2.spriteName = monsterInfo:GetHead()
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

function UITreasureBagPanel:GetShowNum(num)
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
function UITreasureBagPanel:ChooseItem(index, isShow)
    local choose = self.GridFlickerDic[index]
    if choose and CS.StaticUtility.IsNull(choose) == false then
        choose:SetActive(isShow)
    end
end

---关闭所有物品选中
function UITreasureBagPanel:CloseAllSelect()
    for i, v in pairs(self.GridFlickerDic) do
        local choose = v
        if choose and CS.StaticUtility.IsNull(choose) == false then
            choose:SetActive(false)
        end
    end
end

--endregion

--region UI事件
---关闭界面
function UITreasureBagPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UITreasureBagPanel")
end

---开启协程前
function UITreasureBagPanel:BeforeFlicker()
    self:GetReceiveButton().gameObject:SetActive(false)
    self:GetReceiveLabel().text = "[878787]开启宝箱"
    self:GetReceive_UISprite().spriteName = "anniu19"
    self:GetBuyBoxBtn_Go():SetActive(false)
end

---协程闪烁
function UITreasureBagPanel:StartFlicker()
    self.IsonFlicker = true
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
            ----中心物品根据当前选中改变
            local currentInfo = self.IndexToItemInfo[index]
            if currentInfo then
                self:ShowCenter(currentInfo)
            end
            --结束选中
            if flickerCount >= self.flickerCount then
                --and index == UITreasureBagPanel.mRewardIndex + 1
                self:ChooseItem(index, true)
                break
            end
            flickerCount = flickerCount + 1
            arrayIndex = arrayIndex + 1 > self.allFlickerCount and self.allFlickerCount - (arrayIndex - 1) or arrayIndex + 1
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self.isClickToReceiveConsecutively and self.shilianflickerTime or self.flickerTime))
        end
        self.mCurChoose = self.mCurChoose - 1
        self:AfterFlicker()
    end
end

---结束协程闪烁后
function UITreasureBagPanel:AfterFlicker()
    self.IsonFlicker = false
    self:GetReceiveButton().gameObject:SetActive(not self.isClickToReceiveConsecutively or UITreasureBagPanel.numberOfConsecutiveRewards <= 1)
    self:CenterChoose_GameObject():SetActive(true)
    self:GetReceiveLabel().text = "[FFF0C2]领取奖励"
    self:GetReceive_UISprite().spriteName = "anniu10"
    local startPos = self:GetReceiveButton().transform.localPosition
    startPos.x = 0
    self:GetReceiveButton().transform.localPosition = startPos
    self:GetBuyBoxBtn_Go():SetActive(false)
    self:ReceivingRewardsContinuously()
end

---领取奖励
function UITreasureBagPanel:OnReceiveButtonClicked()
    if UITreasureBagPanel.mCurChoose ~= 0 then
        return
    end
    if UITreasureBagPanel.mCurrentBagState == LuaEnumTreasureBagState.Open then
        if self.lid then
            networkRequest.ReqDrawPreyTreasureBag(UITreasureBagPanel.lid)
        end
        UITreasureBagPanel:CloseAllSelect()
    elseif UITreasureBagPanel.mCurrentBagState == LuaEnumTreasureBagState.UnOpen then
        UITreasureBagPanel.mCurrentBagState = LuaEnumTreasureBagState.Open
        UITreasureBagPanel.mFlickerCoroutine = StartCoroutine(function()
            self:StartFlicker()
        end)
        UITreasureBagPanel:GetCenter_GameObject():SetActive(true)
        if UITreasureBagPanel.lid then
            networkRequest.ReqRafflePreyTreasureBag(UITreasureBagPanel.lid)
        end
    elseif UITreasureBagPanel.mCurrentBagState == LuaEnumTreasureBagState.Next then
        if UITreasureBagPanel.mNextBagItemInfo then
            UITreasureBagPanel.mCurrentBagState = LuaEnumTreasureBagState.UnOpen
            UITreasureBagPanel:InitPanelInfo(UITreasureBagPanel.mNextBagItemInfo)
        end
    end
end

---点击Item显示Tips
function UITreasureBagPanel:OnItemClicked(go)
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
function UITreasureBagPanel:GetIndexOfRewardID(id)
    return self.allFlickerCount - (self.flickerCount + (self.allFlickerCount - id)) % self.allFlickerCount
end

--endregion

--region 获取背包宝箱数据

---@return bagV2.BagItemInfo 背包中是否还有宝箱,没有不返回
function UITreasureBagPanel:IsAnyBoxInBag()
    if self:GetBagInfoV2() then
        local bagList = self:GetBagInfoV2():GetBagItemList()
        for i = 0, bagList.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = bagList[i]
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            local isLevelEnough = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(bagItemInfo.itemId) == LuaEnumUseItemParam.CanUse
            --if (itemInfo.useLv ~= 0) then
            --    isLevelEnough = itemInfo.useLv <= self:GetMainPlayerInfo().Level
            --elseif itemInfo.reinLv ~= 0 then
            --    isLevelEnough = itemInfo.reinLv <= self:GetMainPlayerInfo().ReinLevel
            --else
            --    isLevelEnough = true
            --end
            if res and Utility.IsEquipBox(itemInfo) and isLevelEnough then
                return bagItemInfo
            end
        end
    end
end

--endregion

--region 缓存表数据
---@return TABLE.CFG_ITEMS 获取item数据
function UITreasureBagPanel:GetItemInfoCache(itemId)
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

---@return TABLE.cfg_items 获取item_Lua数据
function UITreasureBagPanel:GetItemInfoCache_Lua(itemId)
    if itemId == nil then
        return
    end
    if self.mItemIdToInfo_Lua == nil then
        self.mItemIdToInfo_Lua = {}
    end
    local info = self.mItemIdToInfo_Lua[itemId]
    if info == nil then
        info = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        self.mItemIdToInfo_Lua[itemId] = info
    end
    return info
end

---@return TABLE.CFG_ITEMS 获取item_Lua灵兽数据
function UITreasureBagPanel:GetMonsterItemInfoCache_Lua(itemId)
    local itemInfo = self:GetItemInfoCache_Lua(itemId)
    if itemInfo == nil then
        return
    end
    if not (itemInfo:GetType() == 8 and itemInfo:GetSubType() == 8) then
        return
    end
    if self.mMonsterItemIdToInfo_Lua == nil then
        self.mMonsterItemIdToInfo_Lua = {}
    end
    local info = self.mMonsterItemIdToInfo_Lua[itemId]
    if info == nil then
        if itemInfo ~= nil and itemInfo:GetUseParam() ~= nil and itemInfo:GetUseParam().list[0] ~= nil then
            local temp = clientTableManager.cfg_huanshouManager:TryGetValue(itemInfo:GetUseParam().list[0])
            if temp ~= nil then
                info = clientTableManager.cfg_monstersManager:TryGetValue(temp:GetId())
            end
            self.mMonsterItemIdToInfo_Lua[itemId] = info
        end
    end
    return info
end
--endregion

--region 购买宝箱
---购买宝箱
function UITreasureBagPanel:OnBuyTreasureBoxClicked()
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

---点击中间的Icon
function UITreasureBagPanel:OnGetCenter_GameObjectClicked()
    if UITreasureBagPanel.mCurrentBagState == LuaEnumTreasureBagState.Open then
        if self.centerItemTable ~= nil then
            if self.IsonFlicker == false or self.IsonFlicker == nil then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.centerItemTable, showRight = false })
            end
        end
    end
end

---是否是稀有道具
function UITreasureBagPanel:IsRareItem(itemid)
    local rareItemList = LuaGlobalTableDeal.GetTreasureBagRareItemList()
    if rareItemList == nil then
        return false
    end
    for i, v in pairs(rareItemList) do
        if tonumber(v) == itemid then
            return true
        end
    end
    return false

end

--region OnDestroy
function ondestroy()
    if UITreasureBagPanel.mFlickerCoroutine ~= nil then
        StopCoroutine(UITreasureBagPanel.mFlickerCoroutine)
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPreyTreasureBagMessage, UITreasureBagPanel.OnResPreyTreasureBagMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDrawPreyTreasureBagMessage, UITreasureBagPanel.OnResDrawPreyTreasureBagMessageReceived)
end
--endregion

return UITreasureBagPanel