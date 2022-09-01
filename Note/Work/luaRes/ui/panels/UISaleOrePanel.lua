local UISaleOrePanel = {}

--region 局部变量
UISaleOrePanel.type = 0
---贸易类型 1：购买 2：出售
---@private
UISaleOrePanel.tradType = 1
--当前显示的商品信息列表
UISaleOrePanel.curCommodityInfoList = {}
--任务信息
UISaleOrePanel.taskMessage = nil
--点击显示背包
UISaleOrePanel.isClickShowBag = true
--隐藏回购页签
UISaleOrePanel.isHideSale = false
--隐藏购买页签
UISaleOrePanel.isHideBuy = false
---购买面板
---@type UISaleOrePanel_BuyPanelTemplate
UISaleOrePanel.buyPanelTemplate = nil

---出售面板
---@type UISaleOrePanel_SalePanelTemplate
UISaleOrePanel.salePanelTemplate = nil

--endregion

--region 初始化

function UISaleOrePanel:Init()
    self:InitComponents()
    UISaleOrePanel.BindUIEvents()
    UISaleOrePanel.BindNetMessage()
end
---{
---@field info table
---@param info.type           string  日常任务类型
---@param info.showID         number  npcShopId
---@param info.tradType       number  默认显示页签     （默认为 1 购买）
---@param info.isOpenBag      boolean 初始化是否打开背包（默认打开）
---@param info.isHideCloseBtn boolean 是否隐藏关闭按钮  （默认不隐藏）
---@param info.isHideSale     boolean 是否隐藏回购页签  （默认不隐藏）
---@param info.isClickShowBag boolean 点击是否显示背包  （默认显示）
---}
function UISaleOrePanel:Show(info)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.NPCStore
    if info then
        UISaleOrePanel.type = tonumber(info.type)
        UISaleOrePanel.tradType = info.tradType == nil and 1 or info.tradType
        UISaleOrePanel.RefreshTag()
        UISaleOrePanel.isClickShowBag = info.isClickShowBag == nil or info.isClickShowBag
        UISaleOrePanel.isHideSale = info.isHideSale ~= nil and info.isHideSale or false
        UISaleOrePanel.ShowBagPanel(info.isOpenBag == nil or info.isOpenBag)
        UISaleOrePanel.SetCloseState(info.isHideCloseBtn == nil or not info.isHideCloseBtn)
        UISaleOrePanel.InitUI(info.showID)
        -- UISaleOrePanel.RefreshTask()
        UISaleOrePanel.BindTemplates()
        UISaleOrePanel.ChangePanelState()
        networkRequest.ReqGetNpcStoreSellList(UISaleOrePanel.type)
        networkRequest.ReqGetNpcStore(UISaleOrePanel.type, 1, UISaleOrePanel.buyPanelTemplate.countPerPage, UISaleOrePanel.buyPanelTemplate.needPageNumber)
    end
end

--- 初始化组件
function UISaleOrePanel:InitComponents()
    ---@type UnityEngine.GameObject  购买页签
    UISaleOrePanel.btn_buy = self:GetCurComp("WidgetRoot/events/btn_buy", "GameObject")
    ---@type UnityEngine.GameObject  出售页签
    UISaleOrePanel.btn_sale = self:GetCurComp("WidgetRoot/events/btn_sale", "GameObject")
    ---@type UnityEngine.GameObject  关闭按钮
    UISaleOrePanel.btn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    ---@type Top_UILabel 任务进度
    --UISaleOrePanel.taskInfo = self:GetCurComp("WidgetRoot/Mission/Label", "Top_UILabel")
    ---@type Top_UISprite 购买高亮
    UISaleOrePanel.buy_Checkmark = self:GetCurComp("WidgetRoot/events/btn_buy/Checkmark", "Top_UISprite")
    ---@type Top_UISprite 出售高亮
    UISaleOrePanel.sale_Checkmark = self:GetCurComp("WidgetRoot/events/btn_sale/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject 任务信息
    UISaleOrePanel.Mission = self:GetCurComp("WidgetRoot/Mission", "GameObject")
    ---@type Top_UILabel 购买页签lable
    UISaleOrePanel.buyOriLabel = self:GetCurComp("WidgetRoot/events/btn_buy/Background/Label", "Top_UILabel")
    ---@type Top_UILabel 购买页签高亮label
    UISaleOrePanel.buyCheckLabel = self:GetCurComp("WidgetRoot/events/btn_buy/Checkmark/Label", "Top_UILabel")
    ---@type Top_UILabel 出售页签lable
    UISaleOrePanel.saleOriLabel = self:GetCurComp("WidgetRoot/events/btn_sale/Background/Label", "Top_UILabel")
    ---@type Top_UILabel 出售页签高亮lable
    UISaleOrePanel.saleCheckLabel = self:GetCurComp("WidgetRoot/events/btn_sale/Checkmark/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject 购买面板
    UISaleOrePanel.Buy = self:GetCurComp("WidgetRoot/Buy", "GameObject")
    ---@type UnityEngine.GameObject 出售面板
    UISaleOrePanel.Sale = self:GetCurComp("WidgetRoot/Sale", "GameObject")

end

function UISaleOrePanel.BindUIEvents()
    --点击购买页签事件
    CS.UIEventListener.Get(UISaleOrePanel.btn_buy).onClick = UISaleOrePanel.OnClickbtn_buy
    --点击出售页签事件
    CS.UIEventListener.Get(UISaleOrePanel.btn_sale).onClick = UISaleOrePanel.OnClickbtn_sale
    --点击关闭事件
    CS.UIEventListener.Get(UISaleOrePanel.btn_close).onClick = UISaleOrePanel.OnClickbtn_close

end

function UISaleOrePanel.BindNetMessage()
    UISaleOrePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResNpcStoreMessage, UISaleOrePanel.onResNpcStoreMessageCallback)
    UISaleOrePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResNpcStoreSellListMessage, UISaleOrePanel.onResNpcSaleStoreMessageCallback)
    UISaleOrePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResNpcStorePutOnMessage, UISaleOrePanel.onResNpcStorePutOnMessageCallback)
    UISaleOrePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResNpcStoreBuyMessage, UISaleOrePanel.onResNpcStoreBuyMessageCallback)
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResDailyTaskInfoMessage, UISaleOrePanel.RefreshTask)
    UISaleOrePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UISaleOrePanel.MainPlayerBeginWalk)
end

function UISaleOrePanel.BindTemplates()
    local temp = {}
    if not UISaleOrePanel.isHideBuy then
        temp.type = UISaleOrePanel.type
        ---@type UISaleOrePanel_BuyPanelTemplate
        UISaleOrePanel.buyPanelTemplate = templatemanager.GetNewTemplate(UISaleOrePanel.Buy, luaComponentTemplates.UISaleOrePanel_BuyPanelTemplate)
        UISaleOrePanel.buyPanelTemplate:SetTemplate(temp)
    end

    if not UISaleOrePanel.isHideSale then
        temp = {}
        --temp.taskInfo = UISaleOrePanel.taskMessage
        temp.type = UISaleOrePanel.type
        UISaleOrePanel.salePanelTemplate = templatemanager.GetNewTemplate(UISaleOrePanel.Sale, luaComponentTemplates.UISaleOrePanel_SalePanelTemplate)
        UISaleOrePanel.salePanelTemplate:SetTemplate(temp)
    end
end


--endregion

--region 函数监听

---点击购买页签函数
---@param go UnityEngine.GameObject
function UISaleOrePanel.OnClickbtn_buy(go)
    --UISaleOrePanel.ShowBagPanel(UISaleOrePanel.isClickShowBag)
    if UISaleOrePanel.tradType == 1 then
        return
    end
    UISaleOrePanel.tradType = 1
    UISaleOrePanel.RefreshTag()
    UISaleOrePanel.ChangePanelState()
    --uimanager:ClosePanel('UISpecialMissionPanel')
end

---点击出售页签函数
---@param go UnityEngine.GameObject
function UISaleOrePanel.OnClickbtn_sale(go)
    --UISaleOrePanel.ShowBagPanel(UISaleOrePanel.isClickShowBag)
    if UISaleOrePanel.tradType == 2 then
        return
    end
    UISaleOrePanel.tradType = 2
    UISaleOrePanel.RefreshTag()
    UISaleOrePanel.ChangePanelState()
    --uimanager:ClosePanel('UISpecialMissionPanel')
end

---点击关闭函数
---@param go UnityEngine.GameObject
function UISaleOrePanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UISaleOrePanel')
end

--endregion

--region 网络消息处理

---请求购买列表回调
function UISaleOrePanel.onResNpcStoreMessageCallback(id, tableData, csData)
    if csData then
        UISaleOrePanel.RefreshBuyComList(csData)
    end
end

---请求回购列表回调
function UISaleOrePanel.onResNpcSaleStoreMessageCallback(id, data, csData)
    if csData then
        UISaleOrePanel.RefreshSaleComList(csData)
    end
end

---上架（回购）
function UISaleOrePanel.onResNpcStorePutOnMessageCallback(id, data)
    if UISaleOrePanel.tradType ~= 2 or data == nil or data.success == 2 then
        return
    end
    local curPage = UISaleOrePanel.buyPanelTemplate.curPage == 1 and 1 or UISaleOrePanel.buyPanelTemplate.curPage - 1
    networkRequest.ReqGetNpcStore(UISaleOrePanel.type, curPage, UISaleOrePanel.buyPanelTemplate.countPerPage, UISaleOrePanel.buyPanelTemplate.needPageNumber)
    networkRequest.ReqGetNpcStoreSellList(UISaleOrePanel.type)
end

---购买
function UISaleOrePanel.onResNpcStoreBuyMessageCallback(id, data)
    if UISaleOrePanel.tradType ~= 1 or data == nil or data.success == 2 then
        return
    end
    local curPage = UISaleOrePanel.buyPanelTemplate.curPage == 1 and 1 or UISaleOrePanel.buyPanelTemplate.curPage - 1
    networkRequest.ReqGetNpcStoreSellList(UISaleOrePanel.type)
    networkRequest.ReqGetNpcStore(UISaleOrePanel.type, curPage, UISaleOrePanel.buyPanelTemplate.countPerPage, UISaleOrePanel.buyPanelTemplate.needPageNumber)
end

function UISaleOrePanel.MainPlayerBeginWalk()
    uimanager:ClosePanel('UISaleOrePanel')
end

--endregion

--region UI

function UISaleOrePanel.InitUI(id)
    local isFind, info = CS.Cfg_NpcPanelTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        UISaleOrePanel.buyOriLabel.text = info.tab1
        UISaleOrePanel.buyCheckLabel.text = info.tab1
        UISaleOrePanel.saleOriLabel.text = info.tab2
        UISaleOrePanel.saleCheckLabel.text = info.tab2
        if info.tab1 == nil or info.tab1 == "" then
            UISaleOrePanel.isHideBuy = true
            UISaleOrePanel.btn_sale.transform.localPosition = UISaleOrePanel.btn_buy.transform.localPosition
        end
        if info.tab2 == nil or info.tab2 == "" then
            UISaleOrePanel.isHideSale = true
        end
    end
    UISaleOrePanel.btn_buy:SetActive(not UISaleOrePanel.isHideBuy)
    UISaleOrePanel.btn_sale:SetActive(not UISaleOrePanel.isHideSale)
    UISaleOrePanel.RefreshTag()
end

function UISaleOrePanel.ChangePanelState()
    UISaleOrePanel.buyPanelTemplate:SetOpenState(UISaleOrePanel.tradType == 1)
    if UISaleOrePanel.salePanelTemplate ~= nil then
        UISaleOrePanel.salePanelTemplate:SetOpenState(UISaleOrePanel.tradType == 2)
    end
end

---刷新购买商品列表
function UISaleOrePanel.RefreshBuyComList(info)
    if UISaleOrePanel.buyPanelTemplate ~= nil then
        UISaleOrePanel.buyPanelTemplate:RefreshGrid(info)
    end
end

---刷新出售商品列表
function UISaleOrePanel.RefreshSaleComList(info)
    if UISaleOrePanel.salePanelTemplate ~= nil then
        UISaleOrePanel.salePanelTemplate:RefreshGrid(info)
    end
end

---显示背包页面
function UISaleOrePanel.ShowBagPanel(isOpenBag)
    if isOpenBag then
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Material, materialSubtype = UISaleOrePanel.type })
    end
end

---更新任务信息
function UISaleOrePanel.RefreshTask()
    local str = ''
    UISaleOrePanel.taskMessage = CS.CSMissionManager.Instance:GetDailyTaskOfType(UISaleOrePanel.type, true)
    if UISaleOrePanel.taskMessage ~= nil then
        str = string.gsub(UISaleOrePanel.taskMessage.taskDes, '#', "")
        str = '当前任务  ' .. str .. ' '
        if UISaleOrePanel.taskMessage .curFillValue >= UISaleOrePanel.taskMessage .fillMaxValue then
            str = str .. luaEnumColorType.White .. UISaleOrePanel.taskMessage .curFillValue .. '/' .. UISaleOrePanel.taskMessage .fillMaxValue .. '[-]'
        else
            str = str .. luaEnumColorType.Red .. UISaleOrePanel.taskMessage .curFillValue .. '/' .. UISaleOrePanel.taskMessage .fillMaxValue .. '[-]'
        end
        str = str .. luaEnumColorType.White .. UISaleOrePanel.taskMessage .curFillValue .. '/' .. UISaleOrePanel.taskMessage .fillMaxValue .. '[-]'
    end
    --    UISaleOrePanel.taskInfo.text = str
    --    UISaleOrePanel.Mission:SetActive(not (str == ''))
end

---刷新标签
function UISaleOrePanel.RefreshTag()
    UISaleOrePanel.buy_Checkmark.gameObject:SetActive(UISaleOrePanel.tradType == 1)
    UISaleOrePanel.sale_Checkmark.gameObject:SetActive(UISaleOrePanel.tradType ~= 1)
end

---设置关闭按钮状态
function UISaleOrePanel.SetCloseState(isShow)
    UISaleOrePanel.btn_close:SetActive(isShow)
end

--endregion

--region otherFunction


--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResNpcStoreMessage, UISaleOrePanel.onResNpcStoreMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResNpcStoreSellListMessage, UISaleOrePanel.onResNpcSaleStoreMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResNpcStorePutOnMessage, UISaleOrePanel.onResNpcStorePutOnMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResNpcStoreBuyMessage, UISaleOrePanel.onResNpcStoreBuyMessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDailyTaskInfoMessage, UISaleOrePanel.RefreshTask)
    uimanager:ClosePanel('UIDisposeOrePanel')
    uimanager:ClosePanel('UIAuctionItemPanel')
    uimanager:ClosePanel('UIItemInfoPanel')
end

--endregion

return UISaleOrePanel