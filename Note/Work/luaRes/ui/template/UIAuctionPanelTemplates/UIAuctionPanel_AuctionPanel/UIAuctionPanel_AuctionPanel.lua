---拍卖行竞拍界面
---@class UIAuctionPanel_AuctionPanel:TemplateBase
local UIAuctionPanel_AuctionPanel = {}

--region组件属性

---@return UnityEngine.GameObject 目录Root
function UIAuctionPanel_AuctionPanel:GetToggleRoot()
    if self.mToggleRoot == nil then
        self.mToggleRoot = self:Get("ToggleArea", "GameObject")
    end
    return self.mToggleRoot
end

---@return UIAuctionPanel_AuctionPanel_Menu 竞拍目录模板
function UIAuctionPanel_AuctionPanel:GetMenuControllerTemplate()
    if self.MenuTemplate == nil then
        self.MenuTemplate = templatemanager.GetNewTemplate(self:GetToggleRoot(), luaComponentTemplates.UIAuctionPanel_AuctionPanel_Menu, self)
    end
    return self.MenuTemplate
end

---@return UIPageRecyclingContainerForGameObject 竞拍循环控制器
function UIAuctionPanel_AuctionPanel:GetAuctionRecycleComponent()
    if self.mGridController == nil then
        self.mGridController = self:Get("ItemsArea/Scroll View/UIGrid", "UIPageRecyclingContainerForGameObject")
    end
    return self.mGridController
end

---背包信息
function UIAuctionPanel_AuctionPanel:GetBagInfo()
    if self.mBagInfo == nil then
        self.mBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfo
end

---@return UILoopScrollViewPlus 循环组件
function UIAuctionPanel_AuctionPanel:GetLoopScroll_UILoopScrollViewPlus()
    if self.mLoopScroll == nil then
        self.mLoopScroll = self:Get("ItemsArea/Scroll View/UIGrid", "UILoopScrollViewPlus")
    end
    return self.mLoopScroll
end
--endregion

--region局部变量
---@type table<number,auctionV2.AuctionItemInfo> 页数对应信息
UIAuctionPanel_AuctionPanel.PageToInfo = {}

---@type table<number,auctionV2.AuctionItemInfo> 页数对应table信息
UIAuctionPanel_AuctionPanel.mPageToTableInfo = {}

---@type table<UnityEngine.GameObject,UIAuctionPanel_AuctionGrid> 格子对应模板
UIAuctionPanel_AuctionPanel.GoToTemplate = {}

---当前页
UIAuctionPanel_AuctionPanel.mCurrentPage = nil

---强制重刷新
UIAuctionPanel_AuctionPanel.mIsNeedRefreshData = false

---竞拍货币类型
UIAuctionPanel_AuctionPanel.mCoinType = LuaEnumCoinType.Diamond

--region 刷新面板数据
---@type number
---每行个数
UIAuctionPanel_AuctionPanel.mLineNum = 1

---每页4条，刷新超过n*12条时请求下一页
UIAuctionPanel_AuctionPanel.mMaxCountPrePage = 4

---@type number
---缓存数据页数
UIAuctionPanel_AuctionPanel.mSaveData = 8

---@type number 顶行
UIAuctionPanel_AuctionPanel.mTopLine = 0

UIAuctionPanel_AuctionPanel.hasRefresh = false
--endregion
--endregion

--region 初始化
---@param panel UIAuctionPanel
function UIAuctionPanel_AuctionPanel:Init(panel)
    ---@type UIAuctionPanel
    self.AuctionPanel = panel
    self:InitComponent()
    self:BindEvents()
    self:InitCoinInfo()
end

--region服务器消息
---刷新拍賣行列表顯示
---@param csData auctionV2.AuctionItemList
function UIAuctionPanel_AuctionPanel:RefreshItemShow(tblData, csData)
    if csData == nil then
        return
    end
    self.PageToInfo[csData.page] = csData.items
    self.mPageToTableInfo[tblData.page] = tblData.items
    self:SaveReqData(csData.page, false)
    self.nothingSprite:SetActive(csData.toatlPageCount == 0)
    if self.hasRefresh then
        self:GetLoopScroll_UILoopScrollViewPlus():RefreshCurrentPage()
    else
        self.hasRefresh = true
        self:InitAuctionComp()
    end

end
--endregion

function UIAuctionPanel_AuctionPanel:InitComponent()
    self.SellButton = self:Get("SellBtn", "GameObject")
    self.gridRoot_GameObject = self:Get("ItemsArea/Scroll View", "GameObject")
    self.nothingSprite = self:Get("ItemsArea/NoneTips", "GameObject")
    self.money_UILabel = self:Get("Coin", "UILabel")
    self.money_GameObject = self:Get("Coin/Sprite2", "GameObject")
    self.money_UISprite = self:Get("Coin/Sprite2", "UISprite")
    ---@type UILabel 消费额度
    self.money2_UILabel = self:Get("Coin2", "UILabel")
    self.money2_GameObject = self:Get("Coin2/Sprite2", "GameObject")
    self.money2_UISprite = self:Get("Coin2/Sprite2", "UISprite")
    self.money2_UILabel.gameObject:SetActive(Utility.IsAuctionDiamondQuotaOpen)

    self.money3_UILabel = self:Get("HoldIngot", "UILabel")
    self.money3_GameObject = self:Get("HoldIngot/Sprite2", "GameObject")
    self.money3_UISprite = self:Get("HoldIngot/Sprite2", "UISprite")
end

function UIAuctionPanel_AuctionPanel:BindEvents()
    CS.UIEventListener.Get(self.SellButton).onClick = function()
        self:OnSellButtonClicked()
    end
    CS.UIEventListener.Get(self.money_GameObject).onClick = function()
        self:ShowMoneyTips(self.IconInfo)
    end
    CS.UIEventListener.Get(self.money2_GameObject).onClick = function()
        if self.mDiamondIconInfo then
            self:ShowMoneyTips(self.mDiamondIconInfo)
        end
    end
    CS.UIEventListener.Get(self.money3_GameObject).onClick = function()
        if self.mYuanBaoInfo then
            self:ShowMoneyTips(self.mYuanBaoInfo)
        end
    end
end
--endregion

--region 数据相关
---默认打开界面显示
function UIAuctionPanel_AuctionPanel:ShowPanel()
    self:ClearData()
    self:GetMenuControllerTemplate():OpenPage(0)
    self:RefreshCoinShow()
    self.hasRefresh = false
end

---清除数据重新刷新
function UIAuctionPanel_AuctionPanel:ClearData()

end
--endregion

--region货币
---初始化货币信息
function UIAuctionPanel_AuctionPanel:InitCoinInfo()
    local res
    res, self.IconInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    if res then
        self.money_UISprite.spriteName = self.IconInfo.icon
    end
    local res2
    res2, self.mDiamondIconInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(1000023)
    if res2 then
        self.money2_UISprite.spriteName = self.mDiamondIconInfo.icon
    end

    local res3
    res3, self.mYuanBaoInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(LuaEnumCoinType.YuanBao)
    if res3 then
        self.money3_UISprite.spriteName = self.mYuanBaoInfo.icon
    end
end

---显示Tips
function UIAuctionPanel_AuctionPanel:ShowMoneyTips(itemInfo)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
end

---刷新钻石显示
function UIAuctionPanel_AuctionPanel:RefreshCoinShow()
    self.money_UILabel.text = Utility.GetAuctionDiamondNum()
    if Utility.IsAuctionDiamondQuotaOpen then
        local diamond = self.AuctionPanel:GetPlayerInfo().Data.auctionDiamond
        if diamond then
            self.money2_UILabel.text = diamond
        end
    end

    local yuanBao = self.AuctionPanel:GetBagInfoV2():GetAuctionIngotNum()
    if yuanBao then
        self.money3_UILabel.text = yuanBao
    end
end
--endregion

--regionUI事件
---点击跳转个人竞拍出售界面
function UIAuctionPanel_AuctionPanel:OnSellButtonClicked()
    if self.AuctionPanel and self.AuctionPanel.SwitchToSelfAuctionPanel then
        self.AuctionPanel:SwitchToSelfAuctionPanel()
    end
end
--endregion

--region 钻石交易行总面板显示
---初始化交易行组件
function UIAuctionPanel_AuctionPanel:InitAuctionComp()
    self:GetLoopScroll_UILoopScrollViewPlus():Init(function(go, line)
        return self:RefreshAuctionLine(go, line)
    end, function(line)
        self.mTopLine = line
    end)
end

---刷新单行数据
function UIAuctionPanel_AuctionPanel:RefreshAuctionLine(go, line)
    self:TradeDataManage(line)
    local lineData, tblLineData = self:GetLineDataFormTable(line)
    if #lineData > 0 and not CS.StaticUtility.IsNull(go) then
        for i = 1, #lineData do
            ---@type auctionV2.AuctionItemInfo
            local data = lineData[i]
            local tblData = tblLineData[i]
            local template = self:GetGridTemplate(go)
            if template then
                template:RefreshUI(data, tblData)
            end
        end
        return true
    end
    return false

end

---数据请求控制（存储8页数据）
function UIAuctionPanel_AuctionPanel:TradeDataManage(line)
    local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
    if self.PageToInfo[page] then
        return
    end
    self:ReqAuctionData(page, false)
    if page - self.mSaveData > 0 then
        self.PageToInfo[page - self.mSaveData] = nil
        self.mPageToTableInfo[page - self.mSaveData] = nil
    end
    self.PageToInfo[page + self.mSaveData] = nil
    self.mPageToTableInfo[page + self.mSaveData] = nil
end

---@return table<number,auctionV2.AuctionItemInfo>  统一处理数据 从table中取出某一行数据
function UIAuctionPanel_AuctionPanel:GetLineDataFormTable(line)
    local list = {}
    local tblList = {}
    if self.PageToInfo then
        local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
        local pageData = self.PageToInfo[page]
        local tblPageData = self.mPageToTableInfo[page]
        if pageData then
            local listLength = pageData.Count
            local index = (line * self.mLineNum) % (self.mMaxCountPrePage)
            for i = index, index + self.mLineNum - 1 do
                if listLength > i and pageData[i] then
                    table.insert(list, pageData[i])
                    if tblPageData then
                        table.insert(tblList, tblPageData[i + 1])
                    end
                end
            end
        end
    end
    return list, tblList
end

---请求页数数据
function UIAuctionPanel_AuctionPanel:ReqAuctionData(page)
    if not self:GetHasReqData(page) then
        self:GetMenuControllerTemplate():NetWorkReq(page)
        self:SaveReqData(page, true)
    end
end

---缓存当前已经请求过数据
function UIAuctionPanel_AuctionPanel:SaveReqData(page, isAdd)
    if self.mReqPage == nil then
        self.mReqPage = {}
    end
    if isAdd then
        self.mReqPage[page] = true
    else
        self.mReqPage[page] = false
    end
end

function UIAuctionPanel_AuctionPanel:GetHasReqData(page)
    if self.mReqPage == nil then
        self.mReqPage = {}
    end
    local hasReq = self.mReqPage[page]
    if hasReq == nil then
        hasReq = false
        self.mReqPage[page] = false
    end
    return hasReq
end

---@return UIAuctionPanel_AuctionGrid 拍卖行竞拍格子模板
function UIAuctionPanel_AuctionPanel:GetGridTemplate(go)
    if self.mGridToTemplate == nil then
        self.mGridToTemplate = {}
    end
    local template = self.mGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionPanel_AuctionGrid, self)
    end
    return template
end

---刷新当前页信息
function UIAuctionPanel_AuctionPanel:RefreshCurrentPage()
    local page = math.floor(self.mTopLine / (self.mMaxCountPrePage / self.mLineNum)) + 1
    self:ReqAuctionData(page)
    self:ReqAuctionData(page + 1)
end

---重置界面
function UIAuctionPanel_AuctionPanel:SetNeedRefresh()
    self.PageToInfo = {}
    self.mPageToTableInfo = {}
    self:InitAuctionComp()
end
--endregion

return UIAuctionPanel_AuctionPanel