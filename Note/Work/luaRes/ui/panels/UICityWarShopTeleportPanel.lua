---@class UICityWarShopTeleportPanel:UIBase 商店传送员
local UICityWarShopTeleportPanel = {}
---@type UICityWarShopTeleportPanel
local this = nil;

---@type table<number,UIToggle>
UICityWarShopTeleportPanel.mAllToggle = {}

--region 屬性
---@return CSMainPlayerInfo
function UICityWarShopTeleportPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSUnionInfoV2
function UICityWarShopTeleportPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mUnionInfoV2 = self:GetMainPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end
--endregion

--region Components

function UICityWarShopTeleportPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/Root/events/CloseBtn", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UICityWarShopTeleportPanel:GetFirstGridContainer()
    if (this.mFirstGridContainer == nil) then
        this.mFirstGridContainer = self:GetCurComp("WidgetRoot/Root/view/Table/ShopArea", "UIGridContainer");
    end
    return this.mFirstGridContainer;
end

function UICityWarShopTeleportPanel:GetSecondGridContainer()
    if (this.mSecondtGridContainer == nil) then
        this.mSecondtGridContainer = self:GetCurComp("WidgetRoot/Root/view/Table/ShopArea2", "UIGridContainer");
    end
    return this.mSecondtGridContainer;
end

function UICityWarShopTeleportPanel:GetGridTabel()
    if self.mGridTabel == nil then
        self.mGridTabel = self:GetCurComp("WidgetRoot/Root/view/Table", "UITable")
    end
    return self.mGridTabel
end

function UICityWarShopTeleportPanel:GetPanelRoot()
    if self.mPanelRoot == nil then
        self.mPanelRoot = self:GetCurComp("WidgetRoot/Root", "GameObject")
    end
    return self.mPanelRoot
end

---@return UIGridContainer 页签
function UICityWarShopTeleportPanel:GetBookMarkToggle_UIGridContainer()
    if self.mBookMarkContainer == nil then
        self.mBookMarkContainer = self:GetCurComp("WidgetRoot/Root/events/BookMark", "UIGridContainer")
    end
    return self.mBookMarkContainer
end

function UICityWarShopTeleportPanel:GetFristCoin_UIlabel()
    if self.mFirstCoinLabel == nil then
        self.mFirstCoinLabel = self:GetCurComp("WidgetRoot/Root/view/Table/title/lb_cost1", "UILabel")
    end
    return self.mFirstCoinLabel
end

function UICityWarShopTeleportPanel:GetSecondCoin_UIlabel()
    if self.mSecondCoinLabel == nil then
        self.mSecondCoinLabel = self:GetCurComp("WidgetRoot/Root/view/Table/title2/lb_cost2", "UILabel")
    end
    return self.mSecondCoinLabel
end

--endregion

--region Method

--region Public

function UICityWarShopTeleportPanel:UpdateUI(num)
    local mDeliverIdList = CS.Cfg_GlobalTableManager.Instance:GetUnionManagerDeliderIDList();
    self:GetBookMarkToggle_UIGridContainer().MaxCount = mDeliverIdList.Count
    for i = 0, mDeliverIdList.Count - 1 do
        local go = self:GetBookMarkToggle_UIGridContainer().controlList[i]
        ---@type UIToggle
        local toggle = CS.Utility_Lua.GetComponent(go, "UIToggle")
        ---@type UILabel
        local toggleName = CS.Utility_Lua.Get(go.transform, "TitleName", "UILabel")
        local info = mDeliverIdList[i]
        toggleName.text = info[0]
        CS.EventDelegate.Add(toggle.onChange, function()
            if toggle.value then
                self:RefreshDeliverIDList(info)
            end
        end)
        self.mAllToggle[i] = toggle
    end
    self.mAllToggle[num]:Set(true)
end

---@param deliverInfo System.Array 第一个是标题所以从1开始取
function UICityWarShopTeleportPanel:RefreshDeliverIDList(deliverInfo)
    if deliverInfo == nil or CS.StaticUtility.IsNull(self:GetFirstGridContainer()) then
        return
    end
    self:GetFirstGridContainer().MaxCount = deliverInfo.Length - 1
    for i = 0, deliverInfo.Length - 2 do
        local go = self:GetFirstGridContainer().controlList[i]
        local temp = self:GetDeleverItemTemplate(go)
        if temp then
            local deliverId = tonumber(deliverInfo[i + 1])
            if deliverId then
                temp:UpdateUnit(deliverId)
            end
        end
    end
end

---@return UIShaBaKShopDeliveryUnitTemplate 单个传送格子面板
function UICityWarShopTeleportPanel:GetDeleverItemTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIShaBaKShopDeliveryUnitTemplate, self)
        self.mGoToTemplate[go] = template
    end
    return template
end

function UICityWarShopTeleportPanel:InitShowCityDeliver()
    if self:GetPanelRoot() ~= nil and not CS.StaticUtility.IsNull(self:GetPanelRoot()) then
        self:GetPanelRoot().transform.localPosition = CS.UnityEngine.Vector3(10000, 0, 0)
    end
    local mDeliverIdList = CS.Cfg_GlobalTableManager.Instance:GetUnionManagerDeliderIDList();
    local deliverInfo = nil
    if mDeliverIdList.Count > 0 then
        deliverInfo = mDeliverIdList[0]
        self:GetFirstGridContainer().MaxCount = deliverInfo.Length - 1
        for i = 0, deliverInfo.Length - 2 do
            local go = self:GetFirstGridContainer().controlList[i]
            local temp = self:GetDeleverItemTemplate(go)
            if temp then
                local deliverId = tonumber(deliverInfo[i + 1])
                if deliverId then
                    temp:UpdateUnit(deliverId)
                end
            end
            if i == 0 and self:GetFristCoin_UIlabel() ~= nil and not CS.StaticUtility.IsNull(self:GetFristCoin_UIlabel()) then
                self:GetFristCoin_UIlabel().text = self:GetCoinInfo(tonumber(deliverInfo[i + 1]))
            end
        end
    end
    if mDeliverIdList.Count > 1 then
        deliverInfo = mDeliverIdList[1]
        self:GetSecondGridContainer().MaxCount = deliverInfo.Length - 1
        for i = 0, deliverInfo.Length - 2 do
            local go = self:GetSecondGridContainer().controlList[i]
            local temp = self:GetDeleverItemTemplate(go)
            if temp then
                local deliverId = tonumber(deliverInfo[i + 1])
                if deliverId then
                    temp:UpdateUnit(deliverId)
                end
            end
            if i == 0 and self:GetSecondCoin_UIlabel() ~= nil and not CS.StaticUtility.IsNull(self:GetSecondCoin_UIlabel()) then
                self:GetSecondCoin_UIlabel().text = self:GetCoinInfo(tonumber(deliverInfo[i + 1]))
            end
        end
    end
    self:InitTabel()
end

function UICityWarShopTeleportPanel:InitTabel()
    UICityWarShopTeleportPanel.delayRefresh = CS.CSListUpdateMgr.Add(100, nil, function()
        CS.CSListUpdateMgr.Instance:Remove(UICityWarShopTeleportPanel.delayRefresh)
        UICityWarShopTeleportPanel.delayRefresh = nil
        if self.go ~= nil and not CS.StaticUtility.IsNull(self.go) then
          self:GetGridTabel():Reposition()
            if self:GetPanelRoot() ~= nil and not CS.StaticUtility.IsNull(self:GetPanelRoot()) then
                self:GetPanelRoot().transform.localPosition = CS.UnityEngine.Vector3.zero
            end
        end
    end, false)
end

function UICityWarShopTeleportPanel:GetCoinInfo(deliverId)
    local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(deliverId);
    if (isFind) then
        local isOccupyShaBaK = false;
        if (CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID ~= 0 and CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo.unionInfo ~= nil) then
            isOccupyShaBaK = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo.unionInfo.seizeCityId == 1002;
        end
        local coinData
        if isOccupyShaBaK and deliverTable.special == 1 and deliverTable.speciaItem ~= nil then
            coinData = deliverTable.speciaItem
        else
            if deliverTable.item then
                coinData = deliverTable.item
            end
        end
        local info = string.Split(coinData, '#')
        if info and #info >= 2 then
            local mCostItemId = tonumber(info[1])
            local mCostItemNum = tonumber(info[2])

            local coinName = CS.Cfg_ItemsTableManager.Instance:GetItemName(mCostItemId)
            return tostring(mCostItemNum) .. coinName

        end
    end
    return ""
end

--endregion

--region Private

function UICityWarShopTeleportPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarShopTeleportPanel");
    end
end

function UICityWarShopTeleportPanel:RemoveEvents()

end

--endregion

--endregion

function UICityWarShopTeleportPanel:Init()
    self:AddCollider()
    this = self;

    this:InitEvents();
end

function UICityWarShopTeleportPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.type == nil) then
        customData.type = LuaEnumShaBaKShopDeliveryOpenType.ShopDelivery;
    end

    this.mDeliveryType = customData.type;

    --this:UpdateUI(0);
    self:InitShowCityDeliver()

end

function ondestroy()
    this:RemoveEvents();
    if UICityWarShopTeleportPanel.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UICityWarShopTeleportPanel.delayRefresh)
        UICityWarShopTeleportPanel.delayRefresh = nil
    end
    this = nil;
end

return UICityWarShopTeleportPanel;