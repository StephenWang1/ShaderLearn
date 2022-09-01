---背包主控制器基类
---背包主控制器基类
---@class UIBagMainBasic:TemplateBase
local UIBagMainBasic = {}

local Utility = Utility

--region 基础数据
---背包物品列表
---@type table<number,bagV2.BagItemInfo>
UIBagMainBasic.mBagItemList = nil
---打开/刷新时传入的数据
---@type UIBagPanelInputParam
UIBagMainBasic.mCustomData = nil
---锁定的背包物品
UIBagMainBasic.mFocusedBagItem = nil

---获取控制器对应的背包类型
---@public
---@return LuaEnumBagType
function UIBagMainBasic:GetBagType()
    return self.mBagType
end

---当前背包主控制器是否正在生效
---@public
---@return boolean
function UIBagMainBasic:IsOn()
    return self.mIsOn == true
end

---该背包主导对应的背包界面
---@public
---@return UIBagPanel
function UIBagMainBasic:GetBagPanel()
    return self.mBagPanel
end

---页索引标识容器
---@public
---@return UIPageRecyclingContainer1T
function UIBagMainBasic:GetPageRecycleContainer()
    if self:GetBagPanel() ~= nil then
        return self:GetBagPanel():GetPageRecycleContainer()
    end
    return nil
end

---背包每页格子数量
---@public
---@return number
function UIBagMainBasic:GetGridCountPerPage()
    return self.gridCountPerPage
end

---获取当前最大页数
---@return number
function UIBagMainBasic:GetCurrentMaxPageCount()
    return self.mCurrentMaxPageCount
end

---设置当前最大页数
---@private
---@param pageCount number
function UIBagMainBasic:SetCurrentMaxPageCount(pageCount)
    self.mCurrentMaxPageCount = pageCount
end

---计算最大页数
---@protected
---@return number
function UIBagMainBasic:CalculateMaxPageCount()
    local maxPageCount = 0
    if self:GetGridCountPerPage() ~= 0 then
        maxPageCount = math.ceil(self:GetBagMaxGridCount() / self:GetGridCountPerPage())
    end
    if maxPageCount <= 0 then
        maxPageCount = 1
    end
    --if self:IsMonthCardOpen() then
    --    if not self:HasMengZhongMonthCard() then
    --        maxPageCount = maxPageCount + 1
    --    end
    --end

    return maxPageCount
end

---@return boolean 是否有盟重月卡
function UIBagMainBasic:HasMengZhongMonthCard()
    ---@type vipV2.CardInfo
    local MonthCard = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(LuaEnumCardType.Coceral)
    if MonthCard then
        local cardType = MonthCard.cardType
        if cardType == LuaEnumCoceralCardType.MengZhongMonthCard then
            return true
        end
    end
    return false
end

---@return boolean 商会开启
function UIBagMainBasic:IsMonthCardOpen()
    return Utility.GetActivityOpen(29)
end

---获取中心页索引(从0开始),默认为0
---@public
---@return number
function UIBagMainBasic:GetCenterPageIndex()
    if self.mCenterPageIndex == nil then
        self.mCenterPageIndex = 0
    end
    return self.mCenterPageIndex
end

---获取视野内的页索引集合(索引从0开始)
---@public
---@return table<number,UnityEngine.GameObject>
function UIBagMainBasic:GetPagesInViewRange()
    if self.mPageIndexesInViewRange == nil then
        self.mPageIndexesInViewRange = {}
    end
    return self.mPageIndexesInViewRange
end
--endregion

--region 初始化
---初始化
---@private
---@param bagPanel UIBagPanel
---@param bagType LuaEnumBagType
---@param gridCountPerPage number
---@param mCustomData UIBagPanelInputParam
function UIBagMainBasic:Init(bagPanel, bagType, gridCountPerPage, mCustomData)
    self.mBagPanel = bagPanel
    self.mBagType = bagType
    self.gridCountPerPage = gridCountPerPage
    self.mCustomData = mCustomData
    ---第一次打开时,切换到锁定的背包物品所在的页
    if self.mCustomData then
        self.mFocusedBagItem = self.mCustomData.focusedBagItemInfo
        --if self.mFocusedBagItem ~= nil then
        --    print("self.mFocusedBagItem", self.mFocusedBagItem.ItemTABLE.name)
        --else
        --    print("self.mFocusedBagItem nil")
        --end
    else
        self.mFocusedBagItem = nil
        --print("self.mFocusedBagItem nil")
    end
    self.mOnPageEnterViewRangeFunction = function(obj, pageIndex)
        self:OnPageEnterViewRange(obj, pageIndex)
    end
    self.mOnPageExitViewRangeFunction = function(obj, pageIndex)
        self:OnPageExitViewRange(obj, pageIndex)
    end
    self.mOnCenterPageIndexChangedFunction = function(centerPageIndex)
        self:OnCenterPageIndexChanged(centerPageIndex)
    end
    self:OnInit()
end
--endregion

--region 虚属性
---是否使用服务器顺序,若为false则紧密排序,排序方法需要重写BagItemListSortFunction方法
---@public
---@return boolean
function UIBagMainBasic:IsUseServerOrder()
    return true
end

---是否显示关闭按钮
---@public
---@return boolean
function UIBagMainBasic:IsShowCloseButton()
    return true
end

---是否显示扩展按钮
---@public
---@return boolean
function UIBagMainBasic:IsShowExpandButton()
    return true
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMainBasic:IsShowRecycleButton()
    return true
end

---是否显示扩展按钮2
---@public
---@return boolean
function UIBagMainBasic:IsShowExpandButton2()
    return self:IsShowExpandButton() == true and self:GetBagType() ~= LuaEnumBagType.Recycle
end

---是否显示整理按钮
---@public
---@return boolean
function UIBagMainBasic:IsShowTrimButton()
    return true
end

---是否是扩展的背包界面
---@public
---@return boolean
function UIBagMainBasic:IsExpandBagPanel()
    return false
end

---扩展背包类型,非扩展背包无效,默认返回回收,新增一个类型需要在UIBagPanel中注册该类型对应的子物体
---@return LuaEnumBagPanelExpandType
function UIBagMainBasic:GetExpandType()
    return LuaEnumBagPanelExpandType.Recycle
end

---获取相反的扩展/非扩展背包类型,用于扩展箭头点击后,获取当前背包类型对应的扩展相反的背包类型
---@public
---@return LuaEnumBagType
function UIBagMainBasic:GetReversedExpandBagType()
    return nil
end

---背包信息是否已过时
---@return boolean true表示已过时,下次获取背包列表时会重新读取数据
function UIBagMainBasic:IsBagInfoDirty()
    if self.mIsBagInfoDirty == nil then
        return true
    end
    return self.mIsBagInfoDirty
end

---设置背包信息已过时标志位
function UIBagMainBasic:SetBagInfoIsDirty()
    self.mIsBagInfoDirty = true
end

---物品双击是否可用,当此属性被置为true时,单击的响应时间会稍稍长一点时间,以响应双击
---@public
---@return boolean
function UIBagMainBasic:IsItemDoubleClickedAvailable()
    return true
end

---物品拖拽是否可用,当此属性被置为true时,格子中物品的拖拽被启用,但格子中物品的长按被禁用
---@public
---@return boolean
function UIBagMainBasic:IsItemDragAvailable()
    return false
end

---左侧货币的物品ID,默认为金币,-1表示隐藏该货币
---@public
---@return 货币类型
function UIBagMainBasic:GetLeftCoinItemID()
    return LuaEnumCoinType.JinBi
end

---右侧货币的物品ID,默认为元宝,-1表示隐藏该货币
---@public
---@return 货币类型
function UIBagMainBasic:GetRightCoinItemID()
    return LuaEnumCoinType.YuanBao
end

---左下侧货币的物品ID,默认为装备币,-1表示隐藏该货币
---@public
---@return 货币类型
function UIBagMainBasic:GetLeftDownCoinItemID()
    return LuaEnumCoinType.BangYuan
end

---右下侧货币的物品ID,默认为钻石,-1表示隐藏该货币
---@public
---@return 货币类型
function UIBagMainBasic:GetRightDownCoinItemID()
    return LuaEnumCoinType.Diamond
end

---刷新货币是否用tween，当此属性被置为true时,货币刷新时用tween
---@public
---@return boolean
function UIBagMainBasic:RefreshCionByTween()
    return false
end

---获取初始化时使用的页索引(从0开始)
---@public
---@return number
function UIBagMainBasic:GetInitializePageIndex()
    if self.mFocusedBagItem ~= nil then
        local index = self:GetPageIndexOfBagItem(self.mFocusedBagItem)
        self.mFocusedBagItem = nil
        if index >= 0 then
            return index
        end
    end
    return self:GetCenterPageIndex()
end

---面板关闭
---@public
function UIBagMainBasic:PanelClose(panelName)

end
--endregion

--region 虚方法
---初始化,只执行一次
---@protected
function UIBagMainBasic:OnInit()
end

---逐帧刷新
---@protected
---@param time number 时间,CS.UnityEngine.Time.time
function UIBagMainBasic:OnUpdate(time)
end

---本背包主界面控制器生效时触发
---@protected
function UIBagMainBasic:OnEnable()
    self.mIsOn = true
    ---设置背包信息已过时
    self:SetBagInfoIsDirty()
    ---设置背包按钮的显示与隐藏
    if self:GetBagPanel() ~= nil then
        ---扩展关闭按钮显示设置
        self:GetBagPanel():GetExpandCloseButton_GameObject():SetActive(self:IsShowCloseButton())
        ---基础关闭按钮显示设置
        self:GetBagPanel():GetBaseCloseButton_GameObject():SetActive(self:IsShowCloseButton())
        ---扩展按钮
        self:GetBagPanel():GetExpandButton_GameObject():SetActive(self:IsShowExpandButton())
        ---回收按钮
        self:GetBagPanel():GetExpandButton2_GameObject():SetActive(self:IsShowRecycleButton())
        ---整理按钮
        self:GetBagPanel():GetTrimButton_GameObject():SetActive(self:IsShowTrimButton())
        ---根据当前是否是扩展界面及扩展界面类型刷新界面框架
        self:GetBagPanel():ShowExpandByExpandType(self:IsExpandBagPanel(), self:GetExpandType())
    end
    ---清空页索引集合
    Utility.ClearTable(self:GetPagesInViewRange())
    ---刷新货币
    self:RefreshCoins(true)
    ---刷新整理按钮文本
    self:RefreshTrimLabel()
    ---初始化页
    self:InitializePages()
end

---当前主界面控制器失效或界面关闭时触发
---@protected
function UIBagMainBasic:OnDisable()
    self.mIsOn = false
end

---析构方法
---@protected
function UIBagMainBasic:OnDestroy()
end

---在刷新所有格子之前
---@protected
function UIBagMainBasic:BeforeRefreshAllGrids()
end

---背包物品列表排序方法
---仅在self:IsUseServerOrder()为false时生效
---返回true表明leftItem放在rightItem前面,否则返回leftItem放在rightItem后面
---@protected
---@param leftItem bagV2.BagItemInfo
---@param rightItem bagV2.BagItemInfo
---@return boolean
function UIBagMainBasic:BagItemListSortFunction(leftItem, rightItem)
    if leftItem ~= nil and rightItem ~= nil and leftItem.bagIndex < rightItem.bagIndex then
        return true
    else
        return false
    end
end

---背包物品筛选方法
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
function UIBagMainBasic:BagItemFilterFunction(bagItemInfo, itemInfo)
    return true
end

---刷新格子,该方法中可通过bagGrid的SetCompxxxx方法对其组件的状态,属性进行任意次操作,该方法结束后才会对所有修改的属性进行相应的修改,所有的组件均需要提前在UIBagGrid的Component表中提前定义
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMainBasic:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    ---在此方法中写单个格子的刷新
end

---面板打开事件
---@protected
---@param panelName string
function UIBagMainBasic:OnPanelOpened(panelName)

end

---背包关闭按钮点击事件
---@protected
---@return boolean 是否关闭背包,默认返回true,表示关闭背包
function UIBagMainBasic:OnBagCloseButtonClicked()
    return true
end
--endregion

--region 客户端事件
---页进入视野事件
---@private
---@param obj UnityEngine.Object
---@param pageIndex number
function UIBagMainBasic:OnPageEnterViewRange(obj, pageIndex)
    self:RefreshPage(obj, pageIndex)
    self:GetPagesInViewRange()[pageIndex] = obj
end

---页退出视野事件
---@private
---@param obj UnityEngine.Object
---@param pageIndex number
function UIBagMainBasic:OnPageExitViewRange(obj, pageIndex)
    self:GetPagesInViewRange()[pageIndex] = nil
end

---中心页索引变化事件
---@private
---@param centerPageIndex number
function UIBagMainBasic:OnCenterPageIndexChanged(centerPageIndex)
    self.mCenterPageIndex = centerPageIndex
    self:GetBagPanel():RefreshPageSign(centerPageIndex, self:GetCurrentMaxPageCount())
end
--endregion

--region 内容刷新
---刷新所有格子
---@protected
function UIBagMainBasic:RefreshGrids()
    local pageCountTemp = self:CalculateMaxPageCount()
    if pageCountTemp ~= self:GetCurrentMaxPageCount() then
        ---总页数发生变化时,就得重新初始化所有页了
        self:InitializePages()
        return
    end
    self:BeforeRefreshAllGrids()
    for i, v in pairs(self:GetPagesInViewRange()) do
        self:RefreshPage(v, i)
    end
end
--endregion

--region 背包数据
---获取背包物品列表(索引从1开始)
---@public
---@return table<number,bagV2.BagItemInfo> 格子索引-格子内的背包物品
function UIBagMainBasic:GetBagItemList()
    if self:IsBagInfoDirty() == false then
        return self.mBagItemList
    end
    self.mIsBagInfoDirty = false
    ---@type table<number,bagV2.BagItemInfo>
    local bagItemList = {}
    ---@type CSBagInfoV2
    local bagInfo = self:GetBagPanel():GetBagInfo()
    local originList = bagInfo:GetBagItemList()
    if originList then
        ---@type boolean 是否使用服务器顺序
        local isUseServerOrder = self:IsUseServerOrder()
        for i = 0, originList.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = originList[i]
            if bagItemInfo then
                if bagItemInfo.ItemTABLE then
                    ---若在Items表里没有找到该物品,则不显示在背包中
                    if self:BagItemFilterFunction(bagItemInfo, bagItemInfo.ItemTABLE) then
                        if isUseServerOrder then
                            ---使用服务器顺序时,服务器定义的bagIndex是从0开始,而lua中的table作为list时索引是从1开始,统一为从1开始
                            bagItemList[bagItemInfo.bagIndex + 1] = bagItemInfo
                        else
                            ---不使用服务器顺序时,将被筛选出来的物品依次放到列表中
                            table.insert(bagItemList, bagItemInfo)
                        end
                    end
                else
                    if isOpenLog then
                        luaDebug.LogError("背包内物品ID对应的表数据为空: " .. tostring(bagItemInfo.itemId))
                    end
                end
            end
        end
        ---不使用服务器顺序时,将列表按照自定义的方法排序
        if not isUseServerOrder then
            table.sort(bagItemList, function(left, right)
                return self:BagItemListSortFunction(left, right)
            end)
        end
    end
    self.mBagItemList = bagItemList
    return bagItemList
end

---背包最大格子数量
---@public
---@return number
function UIBagMainBasic:GetBagMaxGridCount()
    return self:GetBagPanel():GetBagInfo().MaxGridCount
end
--endregion

--region 页刷新
---初始化页索引控制器
---@private
function UIBagMainBasic:InitializePages()
    if self:GetPageRecycleContainer() ~= nil then
        local pageCountTemp = self:CalculateMaxPageCount()
        self:SetCurrentMaxPageCount(pageCountTemp)
        self:BeforeRefreshAllGrids()
        self:GetPageRecycleContainer():Initialize(pageCountTemp, self.mOnPageEnterViewRangeFunction, self.mOnPageExitViewRangeFunction, self.mOnCenterPageIndexChangedFunction, self:GetInitializePageIndex())
    end
end

---刷新某一页
---@private
---@param obj UnityEngine.GameObject 页根物体
---@param pageIndex number 需要刷新的页索引
function UIBagMainBasic:RefreshPage(obj, pageIndex)
    if self:GetBagPanel() ~= nil then
        local template = self:GetBagPanel():GetPageControlTemplate(obj)
        if template then
            template:RefreshPage(self:GetBagItemList(), pageIndex, self:GetBagMaxGridCount())
        end
    end
end
--endregion

--region 工具方法
---根据背包物品获取背包物品所在的格子,nil表示物品不在当前格子视野内或被筛选掉了
---@public
---@param bagItemID number
---@return UIBagGrid
function UIBagMainBasic:GetBagGridByBagItemlid(bagItemID)
    local pages = self:GetPagesInViewRange()
    for i, v in pairs(pages) do
        if v and CS.StaticUtility.IsNull(v) == false then
            local pageCtrl = self:GetBagPanel():GetPageControlTemplate(v)
            local pageBagItems = pageCtrl:GetPageBagItems()
            local grid = pageBagItems[bagItemID]
            if grid then
                return grid
            end
        end
    end
    return nil
end

---切换到某一页(页索引从0开始),默认不使用动画
---@public
---@overload fun(pageIndex:number)
---@param pageIndex number 目标页索引,从0开始
---@param withAnimation boolean 是否使用动画切页
function UIBagMainBasic:SwitchToPage(pageIndex, withAnimation)
    if self:GetPageRecycleContainer() ~= nil then
        if withAnimation == true then
            self:GetPageRecycleContainer():SwitchToPageWithAnimation(pageIndex, 10)
        else
            self:GetPageRecycleContainer():SwitchToPageWithoutAnimation(pageIndex)
        end
    end
end

---获取背包物品对应的页索引(从0开始),-1表示未找到物品所在的页
---@public
---@param bagItemInfo bagV2.BagItemInfo
---@return number
function UIBagMainBasic:GetPageIndexOfBagItem(bagItemInfo)
    if self:GetBagPanel() == nil or self:GetBagPanel():GetBagGridCountPerPage() <= 0 then
        return -1
    end
    if bagItemInfo ~= nil then
        local bagIndex = self:GetBagItemIndexByBagItemInfo(bagItemInfo)
        if bagIndex and bagIndex ~= -1 then
            return math.floor((bagIndex - 1) / self:GetBagPanel():GetBagGridCountPerPage())
        end
    end
    return -1
end

---根据背包物品获取该物品在背包中的索引
---@public
---@param bagItemInfo bagV2.BagItemInfo
---@return number
function UIBagMainBasic:GetBagItemIndexByBagItemInfo(bagItemInfo)
    local bagItemList = self:GetBagItemList()
    for i, v in pairs(bagItemList) do
        if v and v.lid == bagItemInfo.lid then
            return i
        end
    end
    return -1
end

---根据背包物品lid获取该物品在背包中的索引
---@public
---@param lid number
---@return number
function UIBagMainBasic:GetBagItemIndexByBagItemLid(lid)
    local bagItemList = self:GetBagItemList()
    for i, v in pairs(bagItemList) do
        if v and v.lid == lid then
            return i
        end
    end
    return -1
end
--endregion

--region 货币刷新
---刷新货币数量
---@overload fun()
---@public
---@param isFirstTime boolean 是否是第一次刷新,若第一次刷新,则刷新icon和active状态
function UIBagMainBasic:RefreshCoins(isFirstTime)
    if isFirstTime then
        ---重置左货币和右货币数量
        self.mLeftCoinCountCache = -1
        self.mRightCoinCountCache = -1
        self.mLeftDownCoinCountCache = -1
        self.mRightDownCoinCountCache = -1
        ---刷新货币显示状态
        self:RefreshCoinsExistState()
        ---刷新货币ICON
        self:RefreshCoinsIcons()
    end
    if self:RefreshCionByTween() then
        self:RefreshCoinLabelByTween()
    else
        self:RefreshCoinLabel()
    end
end

---刷新货币ICON
---@private
function UIBagMainBasic:RefreshCoinsIcons()
    local itemTbl
    local cfgItemTblMgr = CS.Cfg_ItemsTableManager.Instance
    if self:GetLeftCoinItemID() ~= -1 then
        ___, itemTbl = cfgItemTblMgr:TryGetValue(self:GetLeftCoinItemID())
        if itemTbl then
            self:GetBagPanel():GetCoinLeftIcon_UISprite().spriteName = itemTbl.icon
        else
            self:GetBagPanel():GetCoinLeftIcon_UISprite().spriteName = ""
            if isOpenLog then
                luaDebug.LogError("Left Coin Item不存在 " .. self:GetLeftCoinItemID())
            end
        end
    end
    if self:GetRightCoinItemID() ~= -1 then
        ___, itemTbl = cfgItemTblMgr:TryGetValue(self:GetRightCoinItemID())
        if itemTbl then
            self:GetBagPanel():GetCoinRightIcon_UISprite().spriteName = itemTbl.icon
        else
            self:GetBagPanel():GetCoinRightIcon_UISprite().spriteName = ""
            if isOpenLog then
                luaDebug.LogError("Right Coin Item不存在 " .. self:GetRightCoinItemID())
            end
        end
    end
    if self:GetLeftDownCoinItemID() ~= -1 then
        ___, itemTbl = cfgItemTblMgr:TryGetValue(self:GetLeftDownCoinItemID())
        if itemTbl then
            self:GetBagPanel():GetCoinLeftDownIcon_UISprite().spriteName = itemTbl.icon
        else
            self:GetBagPanel():GetCoinLeftDownIcon_UISprite().spriteName = ""
            if isOpenLog then
                luaDebug.LogError("Left Coin Item不存在 " .. self:GetLeftDownCoinItemID())
            end
        end
    end
    if self:GetRightDownCoinItemID() ~= -1 then
        ___, itemTbl = cfgItemTblMgr:TryGetValue(self:GetRightDownCoinItemID())
        if itemTbl then
            self:GetBagPanel():GetCoinRightDownIcon_UISprite().spriteName = itemTbl.icon
        else
            self:GetBagPanel():GetCoinRightDownIcon_UISprite().spriteName = ""
            if isOpenLog then
                luaDebug.LogError("Right Coin Item不存在 " .. self:GetRightDownCoinItemID())
            end
        end
    end
end

---刷新货币的显示状态
---@private
function UIBagMainBasic:RefreshCoinsExistState()
    --self:GetBagPanel():GetCoinLeft_UILabel().gameObject:SetActive(self:GetLeftCoinItemID() ~= -1)
    self:GetBagPanel():GetCoinRight_UILabel().gameObject:SetActive(self:GetRightCoinItemID() ~= -1)
    --self:GetBagPanel():GetCoinLeftDown_UILabel().gameObject:SetActive(self:GetLeftDownCoinItemID() ~= -1)
    self:GetBagPanel():GetCoinRightDown_UILabel().gameObject:SetActive(self:GetRightDownCoinItemID() ~= -1)
end

function UIBagMainBasic:RefreshCoinLabel()
    local count, isGainCoin
    ---刷新右货币数量
    if self:GetRightCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetRightCoinItemID())
        --if isGainCoin == false then
        --    count = 0
        --end
        if self.mRightCoinCountCache ~= count then
            self.mRightCoinCountCache = count
            --if (self:GetRightCoinItemID() == LuaEnumCoinType.JinBi or self:GetRightCoinItemID() == LuaEnumCoinType.BangJin) then
            --    count = LuaEnumCoinsColor.JinBi .. tostring(count)
            --elseif (self:GetRightCoinItemID() == LuaEnumCoinType.YuanBao or self:GetRightCoinItemID() == LuaEnumCoinType.BangYuan) then
            --    count = LuaEnumCoinsColor.YuanBao .. tostring(count)
            --elseif (self:GetRightCoinItemID() == LuaEnumCoinType.Diamond or self:GetRightCoinItemID() == LuaEnumCoinType.Diamond1 or self:GetRightCoinItemID() == LuaEnumCoinType.Diamond2 or self:GetRightCoinItemID() == LuaEnumCoinType.Diamond3 or self:GetRightCoinItemID() == LuaEnumCoinType.Diamond4) then
            --    count = LuaEnumCoinsColor.ZuanShi .. tostring(count)
            --end
            self:GetBagPanel():GetCoinRight_UILabel().text = count
        end
    end
    ---刷新左货币数量
    if self:GetLeftCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetLeftCoinItemID())
        --if isGainCoin == false then
        --    count = 0
        --end
        if self.mLeftCoinCountCache ~= count then
            self.mLeftCoinCountCache = count
            --if (self:GetLeftCoinItemID() == LuaEnumCoinType.JinBi or self:GetLeftCoinItemID() == LuaEnumCoinType.BangJin) then
            --    count = LuaEnumCoinsColor.JinBi .. tostring(count)
            --elseif (self:GetLeftCoinItemID() == LuaEnumCoinType.YuanBao or self:GetLeftCoinItemID() == LuaEnumCoinType.BangYuan) then
            --    count = LuaEnumCoinsColor.YuanBao .. tostring(count)
            --elseif (self:GetLeftCoinItemID() == LuaEnumCoinType.Diamond or self:GetLeftCoinItemID() == LuaEnumCoinType.Diamond1 or self:GetLeftCoinItemID() == LuaEnumCoinType.Diamond2 or self:GetLeftCoinItemID() == LuaEnumCoinType.Diamond3 or self:GetLeftCoinItemID() == LuaEnumCoinType.Diamond4) then
            --    count = LuaEnumCoinsColor.ZuanShi .. tostring(count)
            --end
            self:GetBagPanel():GetCoinLeft_UILabel().text = tostring(count)
        end
    end
    ---刷新左下货币数量
    if self:GetLeftDownCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetLeftDownCoinItemID())
        --if isGainCoin == false then
        --    count = 0
        --end
        if self.mLeftDownCoinCountCache ~= count then
            self.mLeftDownCoinCountCache = count
            self:GetBagPanel():GetCoinLeftDown_UILabel().text = tostring(count)
        end
    end
    ---刷新右下货币数量
    if self:GetRightDownCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetRightDownCoinItemID())
        --if isGainCoin == false then
        --    count = 0
        --end
        if self.mRightDownCoinCountCache ~= count then
            self.mRightDownCoinCountCache = count
            self:GetBagPanel():GetCoinRightDown_UILabel().text = tostring(count)
        end
    end
end

function UIBagMainBasic:RefreshCoinLabelByTween()
    local count, isGainCoin
    ---刷新右货币数量
    if self:GetRightCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetRightCoinItemID())
        --if isGainCoin == false then
        --    count = 0
        --end
        if self.mRightCoinCountCache ~= count then
            self:GetBagPanel():GetCoinRight_TweenValue().from = tonumber(self:GetBagPanel():GetCoinRight_UILabel().text)
            self:GetBagPanel():GetCoinRight_TweenValue().to = count
            self:GetBagPanel():GetCoinRight_TweenValue():PlayTween()
            self.mRightCoinCountCache = count
        end
    end
    ---刷新左货币数量
    if self:GetLeftCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetLeftCoinItemID())
        if self.mLeftCoinCountCache ~= count then
            self:GetBagPanel():GetCoinLeft_TweenValue().from = tonumber(self:GetBagPanel():GetCoinLeft_UILabel().text)
            self:GetBagPanel():GetCoinLeft_TweenValue().to = count
            self:GetBagPanel():GetCoinLeft_TweenValue():PlayTween()
            self.mLeftCoinCountCache = count
        end
    end
    ---刷新左下货币数量
    if self:GetLeftDownCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetLeftDownCoinItemID())
        if self.mLeftDownCoinCountCache ~= count then
            self:GetBagPanel():GetCoinLeftDown_TweenValue().from = tonumber(self:GetBagPanel():GetCoinLeftDown_UILabel().text)
            self:GetBagPanel():GetCoinLeftDown_TweenValue().to = count
            self:GetBagPanel():GetCoinLeftDown_TweenValue():PlayTween()
            self.mLeftDownCoinCountCache = count
        end
    end

    ---刷新右下货币数量
    if self:GetRightDownCoinItemID() ~= -1 then
        count = self:GetBagPanel():GetBagInfo():GetCoinAmount(self:GetRightDownCoinItemID())
        if self.mRightDownCoinCountCache ~= count then
            self:GetBagPanel():GetCoinRightDown_TweenValue().from = tonumber(self:GetBagPanel():GetCoinRightDown_UILabel().text)
            self:GetBagPanel():GetCoinRightDown_TweenValue().to = count
            self:GetBagPanel():GetCoinRightDown_TweenValue():PlayTween()
            self.mRightDownCoinCountCache = count
        end
    end
end

---左货币点击事件
---@protected
function UIBagMainBasic:OnLeftCoinClicked()
    if self:GetLeftCoinItemID() == -1 then
        return
    end
    local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(self:GetLeftCoinItemID())
    if itemTbl then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl })
    end
end

---右货币点击事件
---@protected
function UIBagMainBasic:OnRightCoinClicked()
    if self:GetRightCoinItemID() == -1 then
        return
    end
    local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(self:GetRightCoinItemID())
    if itemTbl then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl })
    end
end

---左下货币点击事件
---@protected
function UIBagMainBasic:OnLeftDownCoinClicked()
    if self:GetLeftDownCoinItemID() == -1 then
        return
    end
    local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(self:GetLeftDownCoinItemID())
    if itemTbl then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl })
    end
end

---右下货币点击事件
---@protected
function UIBagMainBasic:OnRightDownCoinClicked()
    if self:GetRightDownCoinItemID() == -1 then
        return
    end
    local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(self:GetRightDownCoinItemID())
    if itemTbl then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl })
    end
end
--endregion

--region 整理
---整理按钮点击事件
---@protected
function UIBagMainBasic:DoTrim()
    if self:GetBagPanel() then
        networkRequest.ReqTidyItem(self:GetBagPanel():GetBagInfo():FilterItemByUseDuringTidy())
        self:GetBagPanel():GetBagInfo():ResetSortSign()
    end
end

---刷新整理文字
function UIBagMainBasic:RefreshTrimLabel()
    if self:GetBagPanel() then
        ---在玩家达到一定等级后，整理按钮文本调整
        local conditionID, contentStr, fontSize = CS.Cfg_GlobalTableManager.Instance:GetBagTrimButtonContentChangeInfo()
        if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) then
            self:GetBagPanel():GetTrimButtonLabel_UILabel().text = contentStr
            self:GetBagPanel():GetTrimButtonLabel_UILabel().fontSize = fontSize
        else
            self:GetBagPanel():GetTrimButtonLabel_UILabel().text = "整理"
        end
    end
end
--endregion

--region 格子交互虚方法
---格子被单击
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMainBasic:OnGridClicked(bagGrid, bagItemInfo, itemTbl)

end

---格子被双击
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMainBasic:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)

end

---格子被长时间按下
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMainBasic:OnGridLongPressed(bagGrid, bagItemInfo, itemTbl)

end

---格子是否可以被拖拽
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean 格子是否可以被拖拽,只有IsItemDragAvailable返回true的情况下才会调用,返回值决定该格子是否可以响应拖拽
function UIBagMainBasic:IsGridCanBeDragged(bagGrid, bagItemInfo, itemTbl)
    return true
end

---格子开始被拖拽
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param position UnityEngine.Vector3 Mouse/Touch世界坐标
function UIBagMainBasic:OnGridStartBeingDragged(bagGrid, bagItemInfo, itemTbl, position)

end

---格子被拖拽中
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param position UnityEngine.Vector3 Mouse/Touch世界坐标
function UIBagMainBasic:OnGridBeingDragged(bagGrid, bagItemInfo, itemTbl, position)

end

---格子结束拖拽
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param position UnityEngine.Vector3 Mouse/Touch世界坐标
---@param isDestroyed boolean 是否因被销毁导致的格子拖拽结束
function UIBagMainBasic:OnGridEndBeingDragged(bagGrid, bagItemInfo, itemTbl, position, isDestroyed)

end
--endregion

return UIBagMainBasic