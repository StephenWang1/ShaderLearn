---收藏家界面(高级回收)
---@class UIHighRecyclePanel:UIBase
local UIHighRecyclePanel = {}

--region 基础属性
---最大页数
---@return number
function UIHighRecyclePanel:GetMaxPageCount()
    return 1
end

---每页格子数量
---@return number
function UIHighRecyclePanel:GetMaxGridCountPerPage()
    return 20
end

---获取物品最大数量
---@return number
function UIHighRecyclePanel:GetMaxItemCount()
    return self:GetMaxPageCount() * self:GetMaxGridCountPerPage()
end
--endregion

--region 组件
---获取关闭按钮
function UIHighRecyclePanel:GetCloseButtonGO()
    if self.mCloseButtonGO == nil then
        self.mCloseButtonGO = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseButtonGO
end

---获取页ScrollView
---@return UIScrollView
function UIHighRecyclePanel:GetPageScrollView()
    if self.mPageScrollView == nil then
        self.mPageScrollView = self:GetCurComp("WidgetRoot/Awards", "UIScrollView")
    end
    return self.mPageScrollView
end

---被拖拽的物品
---@return UIBagDraggedItem
function UIHighRecyclePanel:GetBagDraggedItem()
    if self.mBagDraggedItem == nil then
        local mBagDraggedItemGO = self:GetCurComp("WidgetRoot/dragItem", "GameObject")
        if CS.StaticUtility.IsNull(mBagDraggedItemGO) == false then
            self.mBagDraggedItem = templatemanager.GetNewTemplate(mBagDraggedItemGO, luaComponentTemplates.UIHighRecycleDraggableItem, self)
        end
    end
    return self.mBagDraggedItem
end

---格子组件预设根节点
---@return UnityEngine.GameObject
function UIHighRecyclePanel:GetGridItemComponentsRootGO()
    if self.mGridItemComponentsRootGO == nil then
        self.mGridItemComponentsRootGO = self:GetCurComp("WidgetRoot/UIItemTemplate", "GameObject")
    end
    return self.mGridItemComponentsRootGO
end

---获取交互
---@return UIHighRecycleContainerInteraction
function UIHighRecyclePanel:GetBagInteraction()
    if self.mBagInteraction == nil then
        self.mBagInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIHighRecycleContainerInteraction, self, self:GetBagDraggedItem(), self:GetPageScrollView())
    end
    return self.mBagInteraction
end

---出售按钮
---@return UnityEngine.GameObject
function UIHighRecyclePanel:GetSaleButtonGO()
    if self.mSaleButtonGO == nil then
        self.mSaleButtonGO = self:GetCurComp("WidgetRoot/btn_sale", "GameObject")
    end
    return self.mSaleButtonGO
end

---获取收益
---@private
---@return UIGridContainer
function UIHighRecyclePanel:GetMoneyGain()
    if self.mMoneyGain == nil then
        self.mMoneyGain = self:GetCurComp("WidgetRoot/getmoney/Grid", "UIGridContainer")
    end
    return self.mMoneyGain
end

---获取收益Table
---@private
---@return UITable
function UIHighRecyclePanel:GetMoneyGain_UITable()
    if self.mMoneyGain_UITable == nil then
        self.mMoneyGain_UITable = self:GetCurComp("WidgetRoot/getmoney/Grid", "UITable")
    end
    return self.mMoneyGain_UITable
end
--endregion

--region 初始化
function UIHighRecyclePanel:Init()
    self:BindUIEvents()
    self:InitializePages()
    if CS.StaticUtility.IsNull(self:GetGridItemComponentsRootGO()) == false then
        self:GetGridItemComponentsRootGO():SetActive(false)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_MonthCardInfoRefresh, function()
        self:RefreshGain()
    end)
    ---@type number 赎回时间间隔
    self.mRedeemTimeIntervalSecond = 0
    ---@type TABLE.CFG_GLOBAL
    local globalTbl
    ___, globalTbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22332)
    if globalTbl ~= nil then
        self.mRedeemTimeIntervalSecond = tonumber(globalTbl.value)
    end
    ---向服务器发送一次请求
    networkRequest.ReqMostResyclePanel()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMostResyclePanelMessage, UIHighRecyclePanel.OnResMostResyclePanelReceived)
end

function UIHighRecyclePanel:Show()
    uimanager:CreatePanel("UIBagPanel", function(panel)
        UIHighRecyclePanel.BagPanelCache = panel
    end, {
        type = LuaEnumBagType.HighRecycle
    })
end

---页循环容器
---@public
---@return UIPageRecyclingContainer1T
function UIHighRecyclePanel:GetPageRecycleContainer()
    if self.mPageRecycleContainer == nil then
        self.mPageRecycleContainer = self:GetCurComp("WidgetRoot/Awards", "UIPageRecyclingContainerForGameObject")
    end
    return self.mPageRecycleContainer
end

---绑定UI事件
---@private
function UIHighRecyclePanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGO()).onClick = function()
        self:OnCloseButtonClicked()
    end
    CS.UIEventListener.Get(self:GetSaleButtonGO()).onClick = function()
        self:OnSaleButtonClicked()
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.HighRecycleRemoveItemInHighRecyclePanel, UIHighRecyclePanel.OnRemoveItemInHighRecyclePanelReceive)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.HighRecycleClearPreviewItems, UIHighRecyclePanel.OnClearPreviewItemsReceive)
    UIHighRecyclePanel.RefreshBindLuaEventState()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UIHighRecyclePanel.OnMainChatPanel_BtnBagClicked)
end

---初始化页
function UIHighRecyclePanel:InitializePages()
    self:GetPageRecycleContainer():Initialize(self:GetMaxPageCount(), function(obj, pageIndex)
        self:OnPageEnterView(obj, pageIndex)
    end, function(obj, pageIndex)
        self:OnPageExitView(obj, pageIndex)
    end, nil, 0)
end

---主界面背包按钮点击事件
function UIHighRecyclePanel.OnMainChatPanel_BtnBagClicked()

end
--endregion

--region 网络事件
---高级回收面板下发
function UIHighRecyclePanel.OnResMostResyclePanelReceived(evtID, tblData)
    UIHighRecyclePanel.mServerData = tblData.item
    if UIHighRecyclePanel.mServerData ~= nil then
        ---预处理一下
        for i = 1, #UIHighRecyclePanel.mServerData do
            UIHighRecyclePanel.AddClientDataToServerItem(UIHighRecyclePanel.mServerData[i])
        end
    end
    UIHighRecyclePanel.RefreshPages()
    UIHighRecyclePanel.RefreshBindLuaEventState()
end
--endregion

--region 事件
---关闭按钮事件
function UIHighRecyclePanel:OnCloseButtonClicked()
    uimanager:ClosePanel(self)
    uimanager:ClosePanel("UIBagPanel")
end

---是否是预览物品
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIHighRecyclePanel:IsPreviewItem(bagItemInfo)
    if bagItemInfo == nil then
        return false
    end
    for i, v in pairs(self:GetSelectedItemInBag()) do
        if v == bagItemInfo then
            return true
        end
    end
    return false
end

---某页进入视野事件
function UIHighRecyclePanel:OnPageEnterView(obj, pageIndex)
    local pageCtrl = self:GetPageCtrl(obj)
    pageCtrl:RefreshPage(self.GetBagItemList(), pageIndex, self:GetMaxItemCount());
end

---某页退出视野事件
function UIHighRecyclePanel:OnPageExitView(obj, pageIndex)
    --遇到再说
end

---向高级回收界面增加背包物品事件
---@param bagItemInfo bagV2.BagItemInfo
function UIHighRecyclePanel.OnAddItemInHighRecyclePanelReceive(eventID, bagItemInfo)
    local tbl = UIHighRecyclePanel:GetSelectedItemInBag()
    for i = 1, #tbl do
        if tbl[i] == bagItemInfo then
            return
        end
    end
    table.insert(tbl, bagItemInfo)
    UIHighRecyclePanel.RefreshBindLuaEventState()
    UIHighRecyclePanel.RefreshPages()
    UIHighRecyclePanel:RefreshGain()
end

---向高级回收界面移除背包物品事件
---@param bagItemInfo bagV2.BagItemInfo
function UIHighRecyclePanel.OnRemoveItemInHighRecyclePanelReceive(eventID, bagItemInfo)
    local tbl = UIHighRecyclePanel:GetSelectedItemInBag()
    for i = 1, #tbl do
        if tbl[i] == bagItemInfo then
            table.remove(tbl, i)
            break
        end
    end
    UIHighRecyclePanel.RefreshBindLuaEventState()
    UIHighRecyclePanel.RefreshPages()
    UIHighRecyclePanel:RefreshGain()
end

---清空预览物品事件
function UIHighRecyclePanel.OnClearPreviewItemsReceive(eventID, data)
    Utility.ClearTable(UIHighRecyclePanel:GetSelectedItemInBag())
    UIHighRecyclePanel.RefreshBindLuaEventState()
    UIHighRecyclePanel.RefreshPages()
    UIHighRecyclePanel:RefreshGain()
end

---刷新绑定lua事件的状态
function UIHighRecyclePanel.RefreshBindLuaEventState()
    local count = #UIHighRecyclePanel.GetBagItemList()
    local maxCount = UIHighRecyclePanel:GetMaxItemCount()
    if count < maxCount then
        UIHighRecyclePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.HighRecycleAddItemInHighRecyclePanel, UIHighRecyclePanel.OnAddItemInHighRecyclePanelReceive)
    else
        --luaEventManager.RemoveCallback(LuaCEvent.HighRecycleAddItemInHighRecyclePanel, UIHighRecyclePanel.OnAddItemInHighRecyclePanelReceive)
    end
end

---出售按钮点击事件
function UIHighRecyclePanel:OnSaleButtonClicked()
    local msg = {}
    for i, v in pairs(self:GetSelectedItemInBag()) do
        if v ~= nil then
            table.insert(msg, v.lid)
        end
    end
    if #msg > 0 then
        ---如果向服务器发送了消息,则先清空预览列表
        if networkRequest.ReqMostResycle(msg) then
            luaEventManager.DoCallback(LuaCEvent.HighRecycleReqSaleEvent, self:GetGain())
            luaEventManager.DoCallback(LuaCEvent.HighRecycleClearPreviewItems)
        end
    end
end
--endregion

--region 刷新
---刷新所有页
function UIHighRecyclePanel.RefreshPages()
    UIHighRecyclePanel.mIsDirty = true
end

function update()
    ---延迟刷新
    if UIHighRecyclePanel.mIsDirty then
        UIHighRecyclePanel.mIsDirty = nil
        local list = UIHighRecyclePanel.GetBagItemList()
        for i, v in pairs(UIHighRecyclePanel.mPageGOToPageCtrlTemplate) do
            v:RefreshPage(list, v:GetCurrentPageIndex(), UIHighRecyclePanel:GetMaxItemCount())
        end
    end
    ---刷新交互
    if UIHighRecyclePanel:GetBagInteraction() ~= nil then
        UIHighRecyclePanel:GetBagInteraction():OnUpdate(CS.UnityEngine.Time.time)
    end
    ---延迟一段时间请求
    if UIHighRecyclePanel.mNextReqPanelDataTime ~= nil then
        if CS.UnityEngine.Time.time > UIHighRecyclePanel.mNextReqPanelDataTime then
            UIHighRecyclePanel.mNextReqPanelDataTime = nil
            networkRequest.ReqMostResyclePanel()
        end
    end
    ---每3秒检测一次是否有脏数据,若有脏数据则向服务器请求一次界面数据
    if UIHighRecyclePanel.mNextCheckTime == nil then
        UIHighRecyclePanel.mNextCheckTime = CS.UnityEngine.Time.time + 3
    else
        if CS.UnityEngine.Time.time > UIHighRecyclePanel.mNextCheckTime then
            UIHighRecyclePanel.mNextCheckTime = nil
            if UIHighRecyclePanel:IsAnyDirtyServerItems() then
                networkRequest.ReqMostResyclePanel()
            end
        end
    end
end

---是否有任何脏服务器物品(指过了时间而未被服务器删除的)
function UIHighRecyclePanel:IsAnyDirtyServerItems()
    if UIHighRecyclePanel:GetServerData() ~= nil and #UIHighRecyclePanel:GetServerData() > 0 then
        local currentServerTime = CS.CSServerTime.Instance.TotalMillisecond
        for i = 1, #UIHighRecyclePanel:GetServerData() do
            if UIHighRecyclePanel:GetServerData()[i].FinishRedeemTimeStamp < currentServerTime then
                return true
            end
        end
        return false
    end
end
--endregion

--region 数据
---获取服务器数据
---@private
---@return table<number,table>
function UIHighRecyclePanel:GetServerData()
    return self.mServerData
end

---获取背包中选中的物品列表
---@private
---@return table<number, bagV2.BagItemInfo>
function UIHighRecyclePanel:GetSelectedItemInBag()
    if self.mSelectedItemsInBag == nil then
        self.mSelectedItemsInBag = {}
    end
    return self.mSelectedItemsInBag
end

--获取一个背包列表
function UIHighRecyclePanel.GetBagItemList()
    if UIHighRecyclePanel.mItemList == nil then
        UIHighRecyclePanel.mItemList = {}
    else
        Utility.ClearTable(UIHighRecyclePanel.mItemList)
    end
    local serverData = UIHighRecyclePanel:GetServerData()
    if serverData and #serverData > 0 then
        for i = 1, #serverData do
            table.insert(UIHighRecyclePanel.mItemList, serverData[i])

        end
    end
    --[[测试table
    local testTbl = {
        id = 1234124124,
        configId = 2010021,
        count = 5,
        subTime = 100,
    }
    UIHighRecyclePanel.AddClientDataToServerItem(testTbl)
    table.insert(UIHighRecyclePanel.mItemList, testTbl)
    --]]
    local bagSelectedItems = UIHighRecyclePanel:GetSelectedItemInBag()
    if #bagSelectedItems > 0 then
        for i = 1, #bagSelectedItems do
            table.insert(UIHighRecyclePanel.mItemList, bagSelectedItems[i])
        end
    end
    return UIHighRecyclePanel.mItemList
end

---向服务器物品数据中加入客户端数据,以减少后续对C#的访问
---@param serverItem table
function UIHighRecyclePanel.AddClientDataToServerItem(serverItem)
    if serverItem == nil then
        return
    end
    serverItem.IsServerData = true
    if serverItem.configId ~= nil then
        ___, serverItem.ItemTABLE = CS.Cfg_ItemsTableManager.Instance:TryGetValue(serverItem.configId)
    end
    ---结束赎回时间戳
    ---@type number
    serverItem.FinishRedeemTimeStamp = serverItem.time + UIHighRecyclePanel.mRedeemTimeIntervalSecond * 1000
end

---请求赎回物品
---@param id number 待赎回物品的id
---@param btnGO UnityEngine.GameObject
---@return boolean 是否赎回成功
function UIHighRecyclePanel:RequestRedeemItem(id, btnGO)
    local serverItem
    if self:GetServerData() ~= nil and CS.CSServerTime.Instance ~= nil then
        local currentTime = CS.CSServerTime.Instance.TotalMillisecond
        for i = 1, #self:GetServerData() do
            local serverItemTemp = self:GetServerData()[i]
            if serverItemTemp.id == id and currentTime < serverItemTemp.FinishRedeemTimeStamp then
                ---当前时间小于最终赎回时间戳,认为可以赎回
                serverItem = serverItemTemp
                break
            end
        end
    end
    if serverItem then
        ---向服务器请求赎回物品
        networkRequest.ReqMostRedeem(serverItem.id)
        return true
    else
        Utility.ShowPopoTips(btnGO.transform, "物品已不可赎回", 290, "UIAuctionItemPanel")
        return false
    end
end

---倒计时结束时,需要向服务器请求一次数据
---@private
function UIHighRecyclePanel:OnCountDownFinished()
    ---下次请求界面数据的时间
    ---倒计时结束后,1s后再发一次请求
    self.mNextReqPanelDataTime = CS.UnityEngine.Time.time + 1
    networkRequest.ReqMostResyclePanel()
end
--endregion

--region 收益
function UIHighRecyclePanel:GetGain()
    if self.gainMoney == nil then
        self.gainMoney = {}
    end
    return self.gainMoney
end

---刷新收益
---@private
function UIHighRecyclePanel:RefreshGain()
    if self.gainMoney == nil then
        ---@type table<number,number>
        self.gainMoney = {}
    else
        Utility.ClearTable(self.gainMoney)
    end
    for i = 1, #self:GetSelectedItemInBag() do
        local bagItemTemp = self:GetSelectedItemInBag()[i]
        if bagItemTemp.ItemTABLE ~= nil and bagItemTemp.ItemTABLE.highRecycle ~= nil and bagItemTemp.ItemTABLE.highRecycle.list.Count > 0 then
            local coinID, coinAmount
            local list = bagItemTemp.ItemTABLE.highRecycle.list
            for j = 0, list.Count - 1 do
                if coinID == nil then
                    coinID = list[j]
                else
                    coinAmount = list[j]
                    if coinAmount > 0 then
                        if self.gainMoney[coinID] ~= nil then
                            self.gainMoney[coinID] = self.gainMoney[coinID] + coinAmount
                        else
                            self.gainMoney[coinID] = coinAmount
                        end
                    end
                    coinID = nil
                    coinAmount = nil
                end
            end
        end
    end
    local count = Utility.GetLuaTableCount(self.gainMoney)
    self:GetMoneyGain().MaxCount = count
    if count > 0 then
        ---是否有商会成员的元宝加成
        ---@type boolean
        local addMultiple
        if self.gainMoney[LuaEnumCoinType.YuanBao] ~= nil then
            ---向下取整
            self.gainMoney[LuaEnumCoinType.YuanBao] = math.floor(self.gainMoney[LuaEnumCoinType.YuanBao] * (1 + CS.CSScene.MainPlayerInfo.MonthCardInfo:GetMonthCardRecycleMultiple(LuaEnumCoinType.YuanBao)))
        end
        if self.gainMoney[LuaEnumCoinType.PlayerExp] ~= nil then
            ---向下取整
            self.gainMoney[LuaEnumCoinType.PlayerExp] = math.floor(self.gainMoney[LuaEnumCoinType.PlayerExp] * (1 + CS.CSScene.MainPlayerInfo.MonthCardInfo:GetMonthCardRecycleMultiple(LuaEnumCoinType.PlayerExp)))
        end
        local index = 0
        for i, v in pairs(self.gainMoney) do
            ---@type UnityEngine.GameObject
            local go = self:GetMoneyGain().controlList[index]
            ---@type TABLE.CFG_ITEMS
            local tbl
            ___, tbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(i)
            if tbl ~= nil then
                ---@type UISprite
                local iconSprite = self:GetComp(go.transform, "icon", "UISprite")
                iconSprite.spriteName = tostring(tbl.icon)
                ---@type UILabel
                local numLabel = self:GetComp(go.transform, "num", "UILabel")
                if i == LuaEnumCoinType.YuanBao or i == LuaEnumCoinType.PlayerExp then
                    addMultiple = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetMonthCardRecycleMultiple(i)
                    ---向下取整
                    numLabel.text = tostring(v) .. "[878787]商会+" .. tostring(math.floor(addMultiple * 100)) .. "%[-]"
                else
                    numLabel.text = tostring(v)
                end
            else
                ---@type UISprite
                local iconSprite = self:GetComp(go.transform, "icon", "UISprite")
                iconSprite.spriteName = ""
                ---@type UILabel
                local numLabel = self:GetComp(go.transform, "num", "UILabel")
                numLabel.text = ""
            end
            index = index + 1
        end
        if CS.StaticUtility.IsNull(self:GetMoneyGain_UITable()) == false then
            self:GetMoneyGain_UITable():Reposition()
        end
    end
end

---主角是否是商会成员
---@return boolean,number|nil
function UIHighRecyclePanel:IsMainPlayerCoceralMember()
    local cardInfos = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfoList(1)
    if cardInfos == nil or cardInfos.Count == 0 then
        return false
    end
    local info = cardInfos[0]
    local multiple = CS.Cfg_MonthCardTableManager.Instance:GetRecycleEarningMultiple(info)
    multiple = multiple - 1000
    return multiple > 0, multiple
end
--endregion

--region 组件/页控制器获取
---获取页控制器
---@return UIHighRecyclePageCtrl
function UIHighRecyclePanel:GetPageCtrl(go)
    if self.mPageGOToPageCtrlTemplate == nil then
        ---@type table<UnityEngine.GameObject, UIHighRecyclePageCtrl>
        self.mPageGOToPageCtrlTemplate = {}
    end
    local template = self.mPageGOToPageCtrlTemplate[go]
    if template == nil then
        ---@type UIHighRecyclePageCtrl
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIHighRecyclePageCtrl, self, self:GetMaxGridCountPerPage())
        self.mPageGOToPageCtrlTemplate[go] = template
    end
    return template
end

---获取格子组件预设(方法名不能更改,由pageCtrl调用)
---@param compName string 组件名
---@return UnityEngine.GameObject
function UIHighRecyclePanel:GetGridComponentPrefab(compName)
    if self.mGridComponentPrefabTbl == nil then
        self.mGridComponentPrefabTbl = {}
    end
    local comp = self.mGridComponentPrefabTbl[compName]
    if comp == nil then
        local isNullFunc = CS.StaticUtility.IsNull
        if isNullFunc(self:GetGridItemComponentsRootGO()) == false then
            comp = self:GetComp(self:GetGridItemComponentsRootGO().transform, compName, "GameObject")
            self.mGridComponentPrefabTbl[compName] = comp
        end
    end
    return comp
end
--endregion

--region 格子事件
---格子被单击事件
function UIHighRecyclePanel:OnGridClicked(grid, bagItemInfo, itemTbl)
    if bagItemInfo.IsServerData ~= true then
        ---背包预览物品的单击事件
        uiStaticParameter.UIItemInfoManager:CreatePanel({
            bagItemInfo = bagItemInfo,
            itemInfo = itemTbl,
            showRight = true,
            showBind = true,
            rightUpButtonsModule = luaComponentTemplates.UIHighRecyclePanel_TakeOutRightUpOperate,
        })
    else
        ---服务器待赎回物品的单击事件
        local data = {}
        data.Template = luaComponentTemplates.UIHighRecyclePanel_RedeemItemTemplate
        data.itemInfo = bagItemInfo.ItemTABLE
        data.mServerItem = bagItemInfo
        data.mRedeemCallBack = function(id, btnGO)
            return self:RequestRedeemItem(id, btnGO)
        end
        uimanager:CreatePanel("UIAuctionItemPanel", nil, data)
    end
end
--endregion

--region 析构
function UIHighRecyclePanel:OnPanelReleased()
    uimanager:ClosePanel(UIHighRecyclePanel.BagPanelCache)
    --luaEventManager.RemoveCallback(LuaCEvent.HighRecycleAddItemInHighRecyclePanel, UIHighRecyclePanel.OnAddItemInHighRecyclePanelReceive)
    --luaEventManager.RemoveCallback(LuaCEvent.HighRecycleRemoveItemInHighRecyclePanel, UIHighRecyclePanel.OnRemoveItemInHighRecyclePanelReceive)
    --luaEventManager.RemoveCallback(LuaCEvent.HighRecycleClearPreviewItems, UIHighRecyclePanel.OnClearPreviewItemsReceive)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMostResyclePanelMessage, UIHighRecyclePanel.OnResMostResyclePanelReceived)
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, UIHighRecyclePanel.OnMainChatPanel_BtnBagClicked)
end
--endregion

return UIHighRecyclePanel