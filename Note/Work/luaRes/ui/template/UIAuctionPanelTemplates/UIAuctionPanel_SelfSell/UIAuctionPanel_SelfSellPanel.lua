---個人出售界面
---@class UIAuctionPanel_SelfSellPanel:TemplateBase
local UIAuctionPanel_SelfSellPanel = {}

UIAuctionPanel_SelfSellPanel.mSellList = nil

--region属性

---@return CSMainPlayerInfo
function UIAuctionPanel_SelfSellPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSAuctionInfoV2
function UIAuctionPanel_SelfSellPanel:GetAuctionInfoV2()
    if self.mAuctionInfo == nil and self:GetMainPlayerInfo() then
        self.mAuctionInfo = self:GetMainPlayerInfo().AuctionInfo
    end
    return self.mAuctionInfo
end
--endregion

--region 组件
---@return UIToggle 上架按钮
function UIAuctionPanel_SelfSellPanel:GetShelfToggle_UIToggle()
    if self.mShelfToggle == nil then
        self.mShelfToggle = self:Get("btn/Btn_mode1", "UIToggle")
    end
    return self.mShelfToggle
end

---@return UIToggle 摆摊按钮
function UIAuctionPanel_SelfSellPanel:GetStallToggle_UIToggle()
    if self.mStallToggle == nil then
        self.mStallToggle = self:Get("btn/Btn_mode2", "UIToggle")
    end
    return self.mStallToggle
end

---@return UILabel 摆摊按钮名字1
function UIAuctionPanel_SelfSellPanel:GetStallBtn1Name_UILabel()
    if self.mStallBtn1Name_UILabel == nil then
        self.mStallBtn1Name_UILabel = self:Get("btn/Btn_mode2/Label", "UILabel")
    end
    return self.mStallBtn1Name_UILabel
end

---@return UILabel 摆摊按钮名字2
function UIAuctionPanel_SelfSellPanel:GetStallBtn2Name_UILabel()
    if self.mStallBtn2Name_UILabel == nil then
        self.mStallBtn2Name_UILabel = self:Get("btn/Btn_mode2/Label2", "UILabel")
    end
    return self.mStallBtn2Name_UILabel
end

---@return UnityEngine.GameObject 返回按钮
function UIAuctionPanel_SelfSellPanel:GetBackBtn_GameObject()
    if self.backButton_GameObject == nil then
        self.backButton_GameObject = self:Get("btn/BackBtn", "GameObject")
    end
    return self.backButton_GameObject
end

---@return UnityEngine.GameObject 上架界面
function UIAuctionPanel_SelfSellPanel:GetSelfSellPanel_Go()
    if self.mShelfPanel == nil then
        self.mShelfPanel = self:Get("SellPanel", "GameObject")
    end
    return self.mShelfPanel
end

---@return UnityEngine.GameObject 摆摊界面
function UIAuctionPanel_SelfSellPanel:GetStallPanel_GO()
    if self.mStallPanel == nil then
        self.mStallPanel = self:Get("StallPanel", "GameObject")
    end
    return self.mStallPanel
end

---@return UIGridContainer 上架组件
function UIAuctionPanel_SelfSellPanel:GetShelf_UIGridContainer()
    if self.mShelfContainer == nil then
        self.mShelfContainer = self:Get("SellPanel/Scroll View/TradeSellList", "UIGridContainer")
    end
    return self.mShelfContainer
end

---@return UILoopScrollViewPlus 循环组件
function UIAuctionPanel_SelfSellPanel:GetSelfTrade_UILoopScrollViewPlus()
    if self.mLoopScrollViewPlus == nil then
        self.mLoopScrollViewPlus = self:Get("SellPanel/Scroll View/TradeSellList", "UILoopScrollViewPlus")
    end
    return self.mLoopScrollViewPlus
end

function UIAuctionPanel_SelfSellPanel:GetNoSaleItem_GO()
    if self.mNoSaleGo == nil then
        self.mNoSaleGo = self:Get("SellPanel/NoSaleItem", "GameObject")
    end
    return self.mNoSaleGo
end

--endregion

--region 初始化
---@param panel UIAuctionPanel
function UIAuctionPanel_SelfSellPanel:Init(panel)
    self.AuctionPanel = panel
    self:BindEvents()
end

function UIAuctionPanel_SelfSellPanel:ShowPanel(type)
    ---请求数据
    self:ReqData()
    self:GetShelfToggle_UIToggle():Set(type ~= LuaEnumAuctionSelfSellType.Stall, true)
    self:GetStallToggle_UIToggle():Set(type == LuaEnumAuctionSelfSellType.Stall, true)
    if (type == LuaEnumAuctionSelfSellType.Stall) then
        self:SwitchToStallState()
    else
        self:SwitchToShelfState()
    end
    -- self:RefreshStallBtnName()
end
function UIAuctionPanel_SelfSellPanel:ReqData()
    networkRequest.ReqGetAuctionShelf(Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS))
end

function UIAuctionPanel_SelfSellPanel:BindEvents()
    CS.UIEventListener.Get(self:GetBackBtn_GameObject()).onClick = function()
        self:OnBackButtonClicked()
    end
    CS.EventDelegate.Add(self:GetShelfToggle_UIToggle().onChange, function()
        if self:GetShelfToggle_UIToggle().value then
            self:SwitchToShelfState()
        end
    end)
    CS.EventDelegate.Add(self:GetStallToggle_UIToggle().onChange, function()
        if self:GetStallToggle_UIToggle().value then
            --if CS.CSScene.MainPlayerInfo.AuctionInfo.ShowPitchPanel == false then
            --    Utility.ShowPopoTips(self:GetStallToggle_UIToggle().transform,nil,425)
            --    return
            --end
            self:SwitchToStallState()
        end
    end)
end

--region 按钮事件
---返回交易界面
function UIAuctionPanel_SelfSellPanel:OnBackButtonClicked()
    if self.AuctionPanel then
        self.AuctionPanel.mOpenBagChooseItemLid = nil
        self.AuctionPanel:SwitchToTradePanel()
    end
end

---切换摆摊界面
function UIAuctionPanel_SelfSellPanel:SwitchToStallState()
    self:SwitchState(LuaEnumAuctionSelfSellType.Stall)
end

---切换上架界面
function UIAuctionPanel_SelfSellPanel:SwitchToShelfState()
    self:SwitchState(LuaEnumAuctionSelfSellType.Shelf)
    self:RefreshSelfSellList()
end

---切换界面显示
function UIAuctionPanel_SelfSellPanel:SwitchState(type)
    self:GetStallPanel_GO():SetActive(type == LuaEnumAuctionSelfSellType.Stall)
    self:GetSelfSellPanel_Go():SetActive(type == LuaEnumAuctionSelfSellType.Shelf)
    self.AuctionPanel.ShelfType = type
end
--endregion

--region 客户端事件
---拍卖行当前点击背包格子
---@param bagItemInfo bagV2.BagItemInfo
function UIAuctionPanel_SelfSellPanel:OnBagGridClickedFunc(msgID, bagItemInfo)
    if bagItemInfo then
        if(gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo))then
            gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():ShowInsurancePopup()
            return
        end
        self.mChooseBagItemInfo = bagItemInfo
        networkRequest.ReqMarketPriceSection(bagItemInfo.lid, Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD), Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS), 0)
    end
end

---收到出售信息
---@param csData auctionV2.MarketPriceSection
function UIAuctionPanel_SelfSellPanel:GetSellInfoFunc(csData)
    if csData and csData.MarketPriceSectionType then
        local data = {}
        if csData.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.RE_ADD) then
            if self.mCurrentReAddShelfItemID then
                local state = self:GetItemState(self.mCurrentReAddShelfItemID)
                if state then
                    data.ItemState = state
                else
                    return
                end
            else
                return
            end
            ---@type UIAuctionPanel_AuctionItem_TradeReAddShelf
            data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeReAddShelf
        elseif csData.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD) then
            if self.mChooseBagItemInfo then
                local itemId = self.mChooseBagItemInfo.itemId
                local state = self:GetItemState(itemId)
                if state then
                    data.ItemState = state
                else
                    return
                end
            end
            ---@type UIAuctionPanel_AuctionItem_TradAddShelfMix
            data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_TradAddShelfMix
        end
        data.BagItemInfo = self.mChooseBagItemInfo
        data.PriceData = csData
        uimanager:CreatePanel("UIAuctionItemPanel", nil, data)
    end
end

function UIAuctionPanel_SelfSellPanel:GetItemState(itemId)
    local CanYuanBao = CS.CSServerItemInfo.CanYuanBaoDeal(itemId)
    local CanDiamond = CS.CSServerItemInfo.CanDiamondDeal(itemId)
    local state
    if CanYuanBao and CanDiamond then
        state = LuaEnumAuctionTradeShelfType.Mix
    elseif CanYuanBao then
        state = LuaEnumAuctionTradeShelfType.YuanBao
    elseif CanDiamond then
        state = LuaEnumAuctionTradeShelfType.Diamond
    end
    return state
end

---存储当前重新上架类型（钻石/元宝）
function UIAuctionPanel_SelfSellPanel:SaveCurrentReAddShelfState(itemId)
    self.mCurrentReAddShelfItemID = itemId
end

--endregion

--region 刷新上架
---@return  number 上架数目
function UIAuctionPanel_SelfSellPanel:GetShelfNum()
    if self.mMaxSellNum == nil then
        self.mMaxSellNum = CS.Cfg_VipTableManager.Instance:GetCurrentAuctionShelfNum(0)
    end
    return self.mMaxSellNum
end

---刷新自己上架列表
function UIAuctionPanel_SelfSellPanel:RefreshSelfSellList()
    local ShowInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.TradeSellInfo
    local list = self:GetShowSellInfo(ShowInfo)
    --self:RefreshShelfListOne(list)
    self:RefreshShelfListTwo(list)
end

---@return UIAuctionPanel_SelfSellGridTemplate 上架格子模板
function UIAuctionPanel_SelfSellPanel:GetShelfGridTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionPanel_SelfSellGridTemplate, self)
    end
    return template
end

---@return table<number,auctionV2.AuctionItemInfo> 将字典转换成table
function UIAuctionPanel_SelfSellPanel:GetShowSellInfo(dic)
    local list = {}
    CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
        table.insert(list, v)
    end)
    return list
end
--[[
--region 上架列表显示第二版
---@param list table<number,auctionV2.AuctionItemInfo>
function UIAuctionPanel_SelfSellPanel:RefreshShelfListTwo(list)
    if not CS.StaticUtility.IsNull(self:GetNoSaleItem_GO()) then
        self:GetNoSaleItem_GO():SetActive(#list == 0)
    end
    if #list == 0 then
        self:GetShelf_UIGridContainer().MaxCount = 0
    else
        --  local num = ternary(#list >= self:GetShelfNum(), #list, #list + 1)
        local num = #list
        self:GetShelf_UIGridContainer().MaxCount = num
        for i = 0, num - 1 do
            local go = self:GetShelf_UIGridContainer().controlList[i]
            local temp = self:GetShelfGridTemplate(go)
            if temp then
                temp:RefreshUI(list[i + 1])
            end
        end
    end
end]]

---上架列表显示第二版
---@param list table<number,auctionV2.AuctionItemInfo>
function UIAuctionPanel_SelfSellPanel:RefreshShelfListTwo(list)
    if CS.StaticUtility.IsNull(self:GetSelfTrade_UILoopScrollViewPlus()) then
        return
    end

    if not CS.StaticUtility.IsNull(self:GetNoSaleItem_GO()) then
        self:GetNoSaleItem_GO():SetActive(#list == 0)
    end
    self:GetSelfTrade_UILoopScrollViewPlus():Init(function(go, line)
        if line < #list / 2 then
            ---@type UIGridContainer
            local container = CS.Utility_Lua.GetComponent(go.transform, "UIGridContainer")
            local lineNum = (2 * line + 2 <= #list) and 2 or 1
            container.MaxCount = lineNum
            for i = 0, lineNum - 1 do
                local itemGo = container.controlList[i]
                local info = list[2 * line + i + 1]
                local temp = self:GetShelfGridTemplate(itemGo)
                if temp then
                    temp:RefreshUI(info)
                end
            end
            return true
        else
            return false
        end
    end, nil)
end

--endregion

--endregion

--region 刷新摆摊
---@return UIAuctionPanel_StallPanel 摊位模板
function UIAuctionPanel_SelfSellPanel:GetStallPanelTemplate()
    if self.stallTemplate == nil then
        self.stallTemplate = templatemanager.GetNewTemplate(self:GetStallPanel_GO(), luaComponentTemplates.UIAuctionPanel_StallPanel)
    end
    return self.stallTemplate
end

---设置摊位按钮名字
---@param name 切换摊位面板按钮名字
function UIAuctionPanel_SelfSellPanel:SetStallBtnName(name)
    print(name)
    if CS.StaticUtility.IsNull(self:GetStallBtn1Name_UILabel()) == false and CS.StaticUtility.IsNull(self:GetStallBtn2Name_UILabel()) == false then
        self:GetStallBtn1Name_UILabel().text = name
        self:GetStallBtn2Name_UILabel().text = name
    end
end

---刷新摊位按钮名字
function UIAuctionPanel_SelfSellPanel:RefreshStallBtnName()
    if self:GetAuctionInfoV2().MapList ~= nil and self:GetAuctionInfoV2().MapList.Count > 0 then
        local mapId = self:GetAuctionInfoV2().MapList[0]
        local mapName = clientTableManager.cfg_mapManager:GetMapNames(mapId)
        self:SetStallBtnName(mapName)
    end
end

---刷新摊位按钮切换状态
function UIAuctionPanel_SelfSellPanel:RefreshBtnChangeState()
    if CS.CSScene.MainPlayerInfo.AuctionInfo.ShowPitchPanel == false and CS.StaticUtility.IsNull(self:GetStallToggle_UIToggle()) == false then
        self:GetStallToggle_UIToggle().isSwitchSpriteState = false
    end
end
--endregion



return UIAuctionPanel_SelfSellPanel
