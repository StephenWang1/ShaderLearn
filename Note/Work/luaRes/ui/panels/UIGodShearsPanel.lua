local UIGodShearsPanel = {}
--region 数据
--endregion

--region 初始化
function UIGodShearsPanel:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvents()
    self:RefreshDeliverTable()
    self:RefreshCostLabel()
end

function UIGodShearsPanel:InitComponent()
    self.UIGridContainer = self:GetCurComp("WidgetRoot/Scroll View/SafeArea","UIGridContainer")
    self.closeBtn_GameObject = self:GetCurComp("WidgetRoot/CloseBtn","GameObject")
    self.costLabel = self:GetCurComp("WidgetRoot/introduce/labelGroup/costDes","UILabel")
end

function UIGodShearsPanel:InitParams()
    self.deliverTable = LuaGlobalTableDeal.GetTianGongShenJianNpcDeliverInfoTable()
    self.commonEnterCostItemId,self.commonEnterCostPrice = LuaGlobalTableDeal.GetTianGongShenJianCost()
    if self.commonEnterCostItemId ~= nil then
        local priceItemInfoIsFind,priceItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(self.commonEnterCostItemId))
        self.priceItemInfo = priceItemInfo
    end
end

function UIGodShearsPanel:BindEvents()
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function()
        uimanager:ClosePanel(self)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function() self:RefreshDeliverTable() end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function() self:RefreshCostLabel() end)
end
--endregion

--region 刷新
---刷新列表
---@param 数据是否刷新 boolean
function UIGodShearsPanel:RefreshDeliverTable()
    if CS.StaticUtility.IsNull(self.UIGridContainer) == true or self.deliverTable == nil or type(self.deliverTable) ~= 'table' then
        return
    end
    local length = #self.deliverTable
    self.UIGridContainer.MaxCount = length
    for k = 0,length - 1 do
        local go = self.UIGridContainer.controlList[k]
        local info = self.deliverTable[k + 1]
        if info then
            local deliverBtnTemplate = templatemanager.GetNewTemplate(go,luaComponentTemplates.UIGodShearsPanel_Button)
            if deliverBtnTemplate ~= nil then
                deliverBtnTemplate:RefreshPanel({deliverTableInfo = info,index = k})
            end
        end
    end
end

---刷新花费
function UIGodShearsPanel:RefreshCostLabel()
    local cost = ""
    if self.commonEnterCostItemId ~= nil and self.commonEnterCostPrice ~= nil and self.priceItemInfo then
        local priceName = CS.Utility.RemoveColorCode(self.priceItemInfo.name)
        local price = tonumber(self.commonEnterCostPrice)
        local priceItemId = self.priceItemInfo.id
        local bagPriceCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(priceItemId)
        local color = ternary(bagPriceCount >= price,luaEnumColorType.Gray,luaEnumColorType.Red)
        cost = color .. price .. priceName
    end
    if CS.StaticUtility.IsNull(self.costLabel) == false then
        self.costLabel.text = cost
    end
end
--endregion
return UIGodShearsPanel