---@class UIServerSelfSellPanel:UIBase 跨服摆摊页面
local UIServerSelfSellPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIServerSelfSellPanel:Init()
    self:InitComponents()
    UIServerSelfSellPanel.InitParameters()
    UIServerSelfSellPanel.BindUIEvents()
    UIServerSelfSellPanel.BindNetMessage()
    UIServerSelfSellPanel.BindTemplate()
    UIServerSelfSellPanel.InitView()
end

function UIServerSelfSellPanel:Show()
    UIServerSelfSellPanel.ReqServerData()
end

--- 初始化变量
function UIServerSelfSellPanel.InitParameters()
    ---@type LuaEnumAuctionSelfSellType
    UIServerSelfSellPanel.curToggleType = uiStaticParameter.curShareSellType
    ---@type table<UnityEngine.GameObject, UIServerSelfSellPanel_UnitTemplate>
    UIServerSelfSellPanel.mGoToTemplate = {}
    ---@type table<number,auctionV2.AuctionItemInfo>
    UIServerSelfSellPanel.showList = {}
    ---@type bagV2.BagItemInfo
    UIServerSelfSellPanel.mChooseBagItemInfo = nil
    ---@type number
    UIServerSelfSellPanel.mCurrentReAddShelfItemID = 0

end

--- 初始化组件
function UIServerSelfSellPanel:InitComponents()
    ---@type UIToggle 上架按钮
    UIServerSelfSellPanel.mShelfToggle = self:GetCurComp("WidgetRoot/btn/Btn_mode1", "UIToggle")
    ---@type UIToggle 摆摊按钮
    UIServerSelfSellPanel.mStallToggle = self:GetCurComp("WidgetRoot/btn/Btn_mode2", "UIToggle")
    ---@type UnityEngine.GameObject 前往苍月岛摆摊
    UIServerSelfSellPanel.mGOCangYueBtn = self:GetCurComp("WidgetRoot/btn/BackBtn", "GameObject")
    ---@type UnityEngine.GameObject 上架界面
    UIServerSelfSellPanel.mShelfPanel = self:GetCurComp("WidgetRoot/SellPanel", "GameObject")
    ---@type UnityEngine.GameObject 摆摊界面
    UIServerSelfSellPanel.mStallPanel = self:GetCurComp("WidgetRoot/StallPanel", "GameObject")
    ---@type UIGridContainer 上架组件
    UIServerSelfSellPanel.mShelfContainer = self:GetCurComp("WidgetRoot/SellPanel/Scroll View/TradeSellList", "UIGridContainer")
    ---@type UILoopScrollViewPlus 循环组件
    UIServerSelfSellPanel.mLoopScrollViewPlus = self:GetCurComp("WidgetRoot/SellPanel/Scroll View/TradeSellList", "UILoopScrollViewPlus")
    ---@type UnityEngine.GameObject 无物品上架
    UIServerSelfSellPanel.mNoSaleGo = self:GetCurComp("WidgetRoot/SellPanel/NoSaleItem", "GameObject")
    ---@type UnityEngine.GameObject 未在苍月岛地图
    UIServerSelfSellPanel.mNotInCangYue = self:GetCurComp("WidgetRoot/Des", "GameObject")
end

function UIServerSelfSellPanel.BindUIEvents()
    CS.EventDelegate.Add(UIServerSelfSellPanel.mShelfToggle.onChange, UIServerSelfSellPanel.ToggleChenged)
    CS.EventDelegate.Add(UIServerSelfSellPanel.mStallToggle.onChange, UIServerSelfSellPanel.ToggleChenged)

    CS.UIEventListener.Get(UIServerSelfSellPanel.mGOCangYueBtn).onClick = UIServerSelfSellPanel.OnClickGOCangYueBtn
end

function UIServerSelfSellPanel.BindNetMessage()
    UIServerSelfSellPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefreshAuction_StallPanel, UIServerSelfSellPanel.OnRefreshAuctionStallPanelCallBack)
    UIServerSelfSellPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_TradeSellInfoChange, UIServerSelfSellPanel.OnTradeSellInfoChangeCallBack)
    UIServerSelfSellPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMarketPriceSectionMessage, UIServerSelfSellPanel.OnResMarketPriceSectionMessageCallBack)
    UIServerSelfSellPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetAuctionShelfMessage, UIServerSelfSellPanel.OnTradeSellInfoChangeCallBack)
    UIServerSelfSellPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionBagItemClicked, UIServerSelfSellPanel.OnBagGridClickedCallBack)
end

function UIServerSelfSellPanel.BindTemplate()
    UIServerSelfSellPanel.mStallViewTemplate = templatemanager.GetNewTemplate(UIServerSelfSellPanel.mStallPanel, luaComponentTemplates.UIServerSelfSellPanel_StallViewTemplate)
end

function UIServerSelfSellPanel.ReqServerData()
    networkRequest.ReqGetShelfBoothInfo(1)
    networkRequest.ReqGetAuctionShelf(Utility.EnumToInt(CS.auctionV2.AuctionItemType.MOON_BOOTH))
    networkRequest.ReqBoothMaps(1)
end

--endregion

--region 函数监听

function UIServerSelfSellPanel.ToggleChenged()
    local curType = UIServerSelfSellPanel.mShelfToggle.value and LuaEnumAuctionSelfSellType.Shelf or LuaEnumAuctionSelfSellType.Stall
    if curType == UIServerSelfSellPanel.curToggleType then
        return
    end
    UIServerSelfSellPanel.curToggleType = curType
    UIServerSelfSellPanel.SwitchView()
end

function UIServerSelfSellPanel.OnClickGOCangYueBtn()
    networkRequest.ReqDeliverByConfig(310010)
    uimanager:ClosePanel("UIAuctionPanel")
end

--endregion

--region 网络消息处理

---摊位地图信息改变...
function UIServerSelfSellPanel.OnRefreshAuctionStallPanelCallBack()
    if UIServerSelfSellPanel.go == nil or CS.StaticUtility.IsNull(UIServerSelfSellPanel.go) or not UIServerSelfSellPanel.go.activeSelf then
        return
    end
    UIServerSelfSellPanel.RefreshStallView()
end

---拍卖行格子点击回调
function UIServerSelfSellPanel.OnBagGridClickedCallBack(msgID, bagItemInfo)
    if UIServerSelfSellPanel.go == nil or CS.StaticUtility.IsNull(UIServerSelfSellPanel.go) or not UIServerSelfSellPanel.go.activeSelf then
        return
    end
    if not UIServerSelfSellPanel.IsInCangYue() then
        return
    end
    if bagItemInfo then
        UIServerSelfSellPanel.mChooseBagItemInfo = bagItemInfo
        networkRequest.ReqMarketPriceSection(bagItemInfo.lid, Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD), Utility.EnumToInt(CS.auctionV2.AuctionItemType.MOON_BOOTH), 0)
    end
end

---价格区间响应
function UIServerSelfSellPanel.OnResMarketPriceSectionMessageCallBack(msgId, tblData, csData)
    if UIServerSelfSellPanel.go == nil or CS.StaticUtility.IsNull(UIServerSelfSellPanel.go) or not UIServerSelfSellPanel.go.activeSelf then
        return
    end
    if csData then
        UIServerSelfSellPanel.ShowShelfItemTips(csData)
    end
end

---出售物品改变消息
function UIServerSelfSellPanel.OnTradeSellInfoChangeCallBack()
    if UIServerSelfSellPanel.go == nil or CS.StaticUtility.IsNull(UIServerSelfSellPanel.go) or not UIServerSelfSellPanel.go.activeSelf then
        return
    end
    UIServerSelfSellPanel.RefreshShelfView()
end


--endregion

--region View

function UIServerSelfSellPanel.InitView()
    local inCangYue = UIServerSelfSellPanel.IsInCangYue()
    UIServerSelfSellPanel.mShelfToggle.gameObject:SetActive(inCangYue)
    UIServerSelfSellPanel.mStallToggle.gameObject:SetActive(inCangYue)
    UIServerSelfSellPanel.mGOCangYueBtn:SetActive(not inCangYue)
    UIServerSelfSellPanel.mNotInCangYue:SetActive(not inCangYue)
    UIServerSelfSellPanel.SwitchView()
    if inCangYue then
        UIServerSelfSellPanel.mShelfToggle:Set(UIServerSelfSellPanel.curToggleType ~= LuaEnumAuctionSelfSellType.Stall, true)
        UIServerSelfSellPanel.mStallToggle:Set(UIServerSelfSellPanel.curToggleType == LuaEnumAuctionSelfSellType.Stall, true)
    end
end

function UIServerSelfSellPanel.SwitchView()
    if not UIServerSelfSellPanel.IsInCangYue() then
        return
    end

    local isStallType = UIServerSelfSellPanel.curToggleType == LuaEnumAuctionSelfSellType.Stall

    if UIServerSelfSellPanel.mStallPanel.activeSelf ~= isStallType then
        UIServerSelfSellPanel.mStallPanel:SetActive(isStallType)
    end
    if UIServerSelfSellPanel.mShelfPanel.activeSelf ~= not isStallType then
        UIServerSelfSellPanel.mShelfPanel:SetActive(not isStallType)
    end

    if not isStallType then
        UIServerSelfSellPanel.RefreshShelfView()
    end
end

---显示上架物品tips
---@param data auctionV2.MarketPriceSection
function UIServerSelfSellPanel.ShowShelfItemTips(data)
    local tbl = {}
    if data.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.RE_ADD) then
        if UIServerSelfSellPanel.mCurrentReAddShelfItemID then
            local state = UIServerSelfSellPanel.GetItemState(UIServerSelfSellPanel.mCurrentReAddShelfItemID)
            if state then
                tbl.ItemState = state
            else
                return
            end
        else
            return
        end
        ---@type UIServerSelfSellPanel_TradeReAddShelfTemplate
        tbl.Template = luaComponentTemplates.UIServerSelfSellPanel_TradeReAddShelfTemplate
    elseif data.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD) then
        if UIServerSelfSellPanel.mChooseBagItemInfo then
            local itemId = UIServerSelfSellPanel.mChooseBagItemInfo.itemId
            local state = UIServerSelfSellPanel.GetItemState(itemId)
            if state then
                tbl.ItemState = state
            else
                return
            end
        end
        ---@type UIServerSelfSellPanel_TradAddShelfMixTemplate
        tbl.Template = luaComponentTemplates.UIServerSelfSellPanel_TradAddShelfMixTemplate
    end
    tbl.BagItemInfo = UIServerSelfSellPanel.mChooseBagItemInfo
    tbl.PriceData = data
    uimanager:CreatePanel("UIAuctionItemPanel", nil, tbl)
end

--region 上架视图

---刷新上架列表
---@private
function UIServerSelfSellPanel.RefreshShelfView()
    local ShowInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.TradeSellInfo
    UIServerSelfSellPanel.showList = UIServerSelfSellPanel.GetShowSellInfo(ShowInfo)
    UIServerSelfSellPanel.RefreshShelfListView()
end

---刷新列表显示
---@private
function UIServerSelfSellPanel.RefreshShelfListView()
    if CS.StaticUtility.IsNull(UIServerSelfSellPanel.mLoopScrollViewPlus) then
        return
    end
    if not CS.StaticUtility.IsNull(UIServerSelfSellPanel.mNoSaleGo) then
        UIServerSelfSellPanel.mNoSaleGo:SetActive(#UIServerSelfSellPanel.showList == 0)
    end
    UIServerSelfSellPanel.mLoopScrollViewPlus:Init(UIServerSelfSellPanel.RrefreshUnitCallBack, nil)
end

---刷新单元回调
---@private
function UIServerSelfSellPanel.RrefreshUnitCallBack(go, line)
    if line >= #UIServerSelfSellPanel.showList / 2 then
        return false
    end

    ---@type UIGridContainer
    local container = CS.Utility_Lua.GetComponent(go.transform, "UIGridContainer")
    local lineNum = (2 * line + 2 <= #UIServerSelfSellPanel.showList) and 2 or 1
    container.MaxCount = lineNum
    for i = 0, lineNum - 1 do
        local itemGo = container.controlList[i]
        local info = UIServerSelfSellPanel.showList[2 * line + i + 1]
        local temp = UIServerSelfSellPanel.mGoToTemplate[itemGo]
        if temp == nil then
            temp = templatemanager.GetNewTemplate(itemGo, luaComponentTemplates.UIServerSelfSellPanel_UnitTemplate)
            UIServerSelfSellPanel.mGoToTemplate[itemGo] = temp
        end
        temp:RefreshUI(info)
    end
    return true
end


--endregion

--region 摆摊视图

function UIServerSelfSellPanel.RefreshStallView()
    if UIServerSelfSellPanel.mStallViewTemplate then
        UIServerSelfSellPanel.mStallViewTemplate:RefreshStallPanel()
    end
end

--endregion

--endregion

--region otherFunction

---@return  number 上架数目(弃用)
function UIServerSelfSellPanel.GetShelfNum()
    if UIServerSelfSellPanel.mMaxSellNum == nil then
        UIServerSelfSellPanel.mMaxSellNum = CS.Cfg_VipTableManager.Instance:GetCurrentAuctionShelfNum(0)
    end
    return UIServerSelfSellPanel.mMaxSellNum
end

---将字典转换成table
---@return table<number,auctionV2.AuctionItemInfo>
function UIServerSelfSellPanel.GetShowSellInfo(dic)
    local list = {}
    CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
        table.insert(list, v)
    end)
    return list
end

---是否在苍月岛
---@return boolean
function UIServerSelfSellPanel.IsInCangYue()
    local mapId = CS.CSScene.getMapID()
    return mapId == 1010
end

function UIServerSelfSellPanel.GetItemState(itemId)
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
function UIServerSelfSellPanel.SaveCurrentReAddShelfState(itemId)
    UIServerSelfSellPanel.mCurrentReAddShelfItemID = itemId
end

--endregion

--region ondestroy

function ondestroy()
    uiStaticParameter.curShareSellType = LuaEnumAuctionSelfSellType.Stall
end

--endregion

return UIServerSelfSellPanel