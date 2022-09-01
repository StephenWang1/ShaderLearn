---寻宝面板（新）
---@class UITreasurePanel
local UITreasurePanel = {}

function UITreasurePanel:InitComponents()
    ---@type UnityEngine.GameObject 寻宝面板
    UITreasurePanel.SeekTreasure = self:GetCurComp("WidgetRoot/SeekTreasure", "GameObject")
    ---@type UIPanel 寻宝面板Panel
    UITreasurePanel.SeekTreasure_UIPanel = self:GetCurComp("WidgetRoot/SeekTreasure", "Top_UIPanel")
    ---@type TemplateBase 寻宝模板
    UITreasurePanel.SeekTreasureTemplates = templatemanager.GetNewTemplate(UITreasurePanel.SeekTreasure, luaComponentTemplates.UITreasurePanel_SeekTreasure, UITreasurePanel)

    ---@type UnityEngine.GameObject 奖品箱子
    UITreasurePanel.DepositoryToggle = self:GetCurComp("WidgetRoot/SeekTreasure/events/DepositoryToggle", "GameObject")
    ---@type UnityEngine.GameObject 奖品箱面板
    UITreasurePanel.Warehouse = self:GetCurComp("WidgetRoot/Warehouse", "GameObject")
    ---@type UIPanel 奖品箱面板UIPanel
    UITreasurePanel.Warehouse_UIPanel = self:GetCurComp("WidgetRoot/Warehouse", "Top_UIPanel")

    ---@type UnityEngine.GameObject 获奖列表
    UITreasurePanel.Record = self:GetCurComp("WidgetRoot/SeekTreasure/RecordItem", "GameObject")
    ---@type TemplateBase 获奖列表模板
    UITreasurePanel.RecordItemTemplates = templatemanager.GetNewTemplate(UITreasurePanel.Record, luaComponentTemplates.UITreasurePanel_Record, self)

    ---@type Top_UILabel /*寻宝钥匙数量*/现为塔罗牌数量
    UITreasurePanel.TicketValue = self:GetCurComp("WidgetRoot/SeekTreasure/events/TicketValue", "Top_UILabel")
    ---@type UISprite /*寻宝钥匙Icon*/现为塔罗牌Icon
    UITreasurePanel.TicketValueIcon = self:GetCurComp("WidgetRoot/SeekTreasure/events/TicketValue/Sprite2", "UISprite")
    ---@type Top_UILabel 钻石数量
    UITreasurePanel.HoldIngot = self:GetCurComp("WidgetRoot/SeekTreasure/events/HoldIngot", "Top_UILabel")
    ---@type UISprite 钻石Icon
    UITreasurePanel.HoldIngotIcon = self:GetCurComp("WidgetRoot/SeekTreasure/events/HoldIngot/Sprite2", "UISprite")
    ---@type Top_UILabel /*积分数量*/现为创造宝石在背包中的数量
    UITreasurePanel.IntegralValue = self:GetCurComp("WidgetRoot/SeekTreasure/events/ShopValue", "Top_UILabel")
    ---@type UISprite /*积分Icon*/现为创造宝石Icon
    UITreasurePanel.IntegralValueIcon = self:GetCurComp("WidgetRoot/SeekTreasure/events/ShopValue/Sprite2", "UISprite")

    ---底图1
    UITreasurePanel.costbg = self:GetCurComp("WidgetRoot/SeekTreasure/costbg", "GameObject")
    ---底图2
    UITreasurePanel.costbg2 = self:GetCurComp("WidgetRoot/SeekTreasure/costbg2", "GameObject")

    ---@type UnityEngine.GameObject 关闭按钮
    UITreasurePanel.CloseBtn = self:GetCurComp("WidgetRoot/SeekTreasure/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 帮助按钮
    UITreasurePanel.HelpBtn = self:GetCurComp("WidgetRoot/SeekTreasure/events/HelpBtn", "GameObject")

end

function UITreasurePanel.WarehouseTemplates()
    if UITreasurePanel.mWarehouseTemplates == nil then
        UITreasurePanel.mWarehouseTemplates = templatemanager.GetNewTemplate(UITreasurePanel.Warehouse, luaComponentTemplates.UITreasurePanel_Warehouse, UITreasurePanel)
    end
    return UITreasurePanel.mWarehouseTemplates
end

function UITreasurePanel:InitOther()
    UITreasurePanel.InitCurrencyIconInfo()

    UITreasurePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_RenewalPrivatelyPanel, UITreasurePanel.OnResTreasureCardMessage)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTreasureCardMessage, UITreasurePanel.OnResTreasureCardMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTreasureFailMessage, UITreasurePanel.OnResTreasureFailMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTreasureStorehouseMessage, UITreasurePanel.OnResTreasureItemChangedMessage)
    ---刷新背包数据
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UITreasurePanel.InitCurrencyIconInfo)

    CS.UIEventListener.Get(UITreasurePanel.DepositoryToggle).onClick = UITreasurePanel.OnClickDepositoryToggle
    CS.UIEventListener.Get(UITreasurePanel.CloseBtn).onClick = UITreasurePanel.OnClickCloseBtn
    CS.UIEventListener.Get(UITreasurePanel.HelpBtn).onClick = UITreasurePanel.OnClickHelpBtn

    UITreasurePanel.HoldIngotIcon.spriteName = UITreasurePanel:GetItemIcon(LuaEnumCoinType.Diamond)
    ---钻石icon点击事件
    CS.UIEventListener.Get(UITreasurePanel.HoldIngotIcon.gameObject).onClick = UITreasurePanel.OnHoldIngotIcon

    UITreasurePanel.IntegralValueIcon.spriteName = UITreasurePanel:GetItemIcon(6210001)
    ---创造宝石icon点击事件
    CS.UIEventListener.Get(UITreasurePanel.IntegralValueIcon.gameObject).onClick = UITreasurePanel.OnIntegralValueIcon

    UITreasurePanel.TicketValueIcon.spriteName = UITreasurePanel:GetItemIcon(6110001)
    ---塔罗牌icon点击事件
    CS.UIEventListener.Get(UITreasurePanel.TicketValueIcon.gameObject).onClick = UITreasurePanel.OnTicketValueIcon
end

---@private
---@return string
function UITreasurePanel:GetItemIcon(itemID)
    ---@type TABLE.CFG_ITEMS
    local itemTbl
    ___, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemID)
    return itemTbl.icon
end

function UITreasurePanel:Init()
    self:InitComponents()
    self:InitOther()
    self:RefreshUI()
    networkRequest.ReqTreasureStorehouse()
    -- self.OnResTreasureCardMessage()
end

function UITreasurePanel.InitCurrencyIconInfo()
    ---刷新金币数据
    ---钻石item表数据
    UITreasurePanel.tabDiamond = CS.Cfg_ItemsTableManager.Instance:GetItems(LuaEnumCoinType.Diamond)
    ---创造宝石item表数据
    UITreasurePanel.tabIntegral = CS.Cfg_ItemsTableManager.Instance:GetItems(6210001)
    ---塔罗牌item表数据
    UITreasurePanel.ticket = CS.Cfg_ItemsTableManager.Instance:GetItems(6110001)

    ---@type CSBagInfoV2
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo

    local Diamond = bagInfo.DiamondNum;
    UITreasurePanel.HoldIngot.text = Diamond

    ---创造宝石数量
    local TreasureIntegral = bagInfo:GetItemCount(6210001) + bagInfo:GetItemCount(6210002);
    UITreasurePanel.IntegralValue.text = TreasureIntegral

    ---塔罗牌数量
    local ticketIntegral = bagInfo:GetItemCount(6110001) + bagInfo:GetItemCount(6110002);
    UITreasurePanel.TicketValue.text = ticketIntegral

    --local IsHaveTicket = TreasureIntegral > 0
    ---创造宝石先隐藏掉
    local IsHaveTicket = false
    UITreasurePanel.IntegralValue.gameObject:SetActive(IsHaveTicket)

    UITreasurePanel.costbg.gameObject:SetActive(IsHaveTicket)
    UITreasurePanel.costbg2.gameObject:SetActive(not IsHaveTicket)

end

---是否可以翻牌
---@param num number|nil 牌的数量
function UITreasurePanel:IsAvailableForTicket(num)
    ---@type CSBagInfoV2
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    if bagInfo == nil then
        return false
    end
    if num == nil then
        num = 1
    end
    ---塔罗牌数量
    local taluopaiNumber = bagInfo:GetItemCount(6110001) + bagInfo:GetItemCount(6110002);
    ---钻石数量,20个钻石才能买一张塔罗牌
    local diamondNumber = bagInfo:GetCoinAmount(LuaEnumCoinType.Diamond)
    return (math.floor(diamondNumber / 20) + taluopaiNumber) >= num
end

function update()
    UITreasurePanel.SeekTreasureTemplates:Update()
end

function UITreasurePanel:RefreshUI()

end

--region 服务器消息
function UITreasurePanel.OnResTreasureCardMessage(id, data)
    UITreasurePanel.SeekTreasureTemplates:RefreshAllCard(data)
end

function UITreasurePanel.OnResTreasureFailMessage(id, data)
    if data == 1 then

    elseif data == 2 then

    elseif data == 0 then

    end

end
---寻宝仓库信息
function UITreasurePanel:OnResTreasureItemChangedMessage(id, data)
    --  CS.CSScene.MainPlayerInfo.TreasureInfo:InitWarehouseDic()
    UITreasurePanel.WarehouseTemplates():RefreshWarehouseList()
end

--endregion

--region UI点击事件
---打开奖品箱点击事件
function UITreasurePanel.OnClickDepositoryToggle(go)
    UITreasurePanel.Warehouse_UIPanel.alpha = 1;
    networkRequest.ReqTreasureStorehouse()
end

---钻石点击事件
function UITreasurePanel.OnHoldIngotIcon(go)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UITreasurePanel.tabDiamond, showRight = false })
end

---创造宝石点击事件
function UITreasurePanel.OnIntegralValueIcon(go)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UITreasurePanel.tabIntegral, showRight = false })
end

--塔罗牌点击事件(表示背包内剩余数量的塔罗牌icon)
function UITreasurePanel.OnTicketValueIcon(go)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UITreasurePanel.ticket, showRight = false })
end

---关闭面板点击事件
function UITreasurePanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UITreasurePanel')
end

---帮助按钮点击事件
function UITreasurePanel.OnClickHelpBtn(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(85)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

function ondestroy()
    networkRequest.ReqTreasurePrivateCardOver(false)
    UITreasurePanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_RenewalPrivatelyPanel, UITreasurePanel.OnResTreasureCardMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResTreasureCardMessage, UITreasurePanel.OnResTreasureCardMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResTreasureStorehouseMessage, UITreasurePanel.OnResTreasureItemChangedMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UITreasurePanel.InitCurrencyIconInfo)
end
--endregion

return UITreasurePanel