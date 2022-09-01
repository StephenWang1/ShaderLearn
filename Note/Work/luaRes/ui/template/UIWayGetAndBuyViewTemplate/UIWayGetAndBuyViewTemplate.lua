---@class UIWayGetAndBuyViewTemplate:TemplateBase
local UIWayGetAndBuyViewTemplate = {}

--region 组件
---礼包快捷购买的GridContainer
---@return UIGridContainer
function UIWayGetAndBuyViewTemplate:GetGiftGridContainer()
    if (self.mGiftGridContainer == nil) then
        self.mGiftGridContainer = self:Get("ScrollView/gifts", "UIGridContainer");
    end
    return self.mGiftGridContainer;
end

---商店快捷购买的GridContainer
---@return UIGridContainer
function UIWayGetAndBuyViewTemplate:GetShopGridContainer()
    if (self.mShopGridContainer == nil) then
        self.mShopGridContainer = self:Get("ScrollView/items", "UIGridContainer");
    end
    return self.mShopGridContainer;
end

---获取途径Tips的GameObject
---@return GameObject
function UIWayGetAndBuyViewTemplate:GetItemNumBuyObj()
    if (self.mItemNumBuyObj == nil) then
        self.mItemNumBuyObj = self:Get("ScrollView/itemNumBuy", "GameObject");
    end
    return self.mItemNumBuyObj;
end

---获取途径的GridContainer
---@return UIGridContainer
function UIWayGetAndBuyViewTemplate:GetWayGetUnitGridContainer()
    if (self.mWayGetUnitGridContainer == nil) then
        self.mWayGetUnitGridContainer = self:Get("ScrollView/itemGrid", "UIGridContainer");
    end
    return self.mWayGetUnitGridContainer;
end

---交易行快捷购买的GridContainer
---@return UIGridContainer
function UIWayGetAndBuyViewTemplate:GetAuctionItemsGridContainer()
    if self.mAuctionItemsGridContainer == nil then
        self.mAuctionItemsGridContainer = self:Get("ScrollView/auctionItems", "UIGridContainer")
    end
    return self.mAuctionItemsGridContainer
end

---boss增加次数的GridContainer
function UIWayGetAndBuyViewTemplate:GetBossAddTimesReqGridContainer()
    if self.mBossAddTimesReqContainer == nil then
        self.mBossAddTimesReqContainer = self:Get("ScrollView/itemsNum", "UIGridContainer")
    end
    return self.mBossAddTimesReqContainer
end
--endregion

--region 初始化
function UIWayGetAndBuyViewTemplate:Init(EntranceType, panel)
    self.EntranceType = EntranceType
    ---@type UIFurnaceWayAndBuyPanel
    self.mOwnerPanel = panel
    self:InitEvents();
end

function UIWayGetAndBuyViewTemplate:InitEvents()
    self.OnResSendStoreInfoChangeMessage = function(msgId, msgData)
        self:UpdateShop();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendStoreInfoChangeMessage, self.OnResSendStoreInfoChangeMessage);
end
--endregion

--region 刷新UI
function UIWayGetAndBuyViewTemplate:UpdateView(wayGetDic)
    self.mWayGetDic = wayGetDic;
    self:UpdateGift();
    self:UpdateShop();
    self:UpdateWayGet();
    self:UpdateAuctionBuy();
    self:UpdateBossTimeBuy()
end
--endregion

--region 排版
function UIWayGetAndBuyViewTemplate:GetContentHeight()
    local firstGrid = self:GetShopGridContainer();
    local secondGrid = self:GetWayGetUnitGridContainer();
    local thirdGrid = self:GetGiftGridContainer();
    local fourthGrid = self:GetAuctionItemsGridContainer();
    local fifthGrid = self:GetBossAddTimesReqGridContainer()
    return firstGrid.MaxCount * firstGrid.CellHeight
            + secondGrid.MaxCount * secondGrid.CellHeight
            + thirdGrid.MaxCount * thirdGrid.CellHeight
            + fourthGrid.MaxCount * fourthGrid.CellHeight
            + fifthGrid.MaxCount * fifthGrid.CellHeight
end

function UIWayGetAndBuyViewTemplate:GetGridUnitIntervalCount()
    local firstGrid = self:GetShopGridContainer();
    local secondGrid = self:GetWayGetUnitGridContainer();
    local thirdGrid = self:GetGiftGridContainer();
    local fourthGrid = self:GetAuctionItemsGridContainer();
    local fifthGrid = self:GetBossAddTimesReqGridContainer()
    local count = (firstGrid.MaxCount > 0 and firstGrid.MaxCount + 1 or 0)
            + (secondGrid.MaxCount > 0 and secondGrid.MaxCount + 1 or 0)
            + (thirdGrid.MaxCount > 0 and thirdGrid.MaxCount + 1 or 0)
            + (fourthGrid.MaxCount > 0 and fourthGrid.MaxCount + 1 or 0)
            + (fifthGrid.MaxCount > 0 and fifthGrid.MaxCount + 1 or 0)
            - 1;
    count = count <= 0 and 0 or count;
    return count;
end
--endregion

--region 刷新礼包快捷购买
UIWayGetAndBuyViewTemplate.mGiftUnitDic = nil;

function UIWayGetAndBuyViewTemplate:UpdateGift()
    if (self.mWayGetDic ~= nil) then
        if (self.mGiftUnitDic == nil) then
            self.mGiftUnitDic = {};
        end
        local wayGetIds = self.mWayGetDic[LuaEnumWayGetType.Gift];
        local gridContainer = self:GetGiftGridContainer();
        if (wayGetIds ~= nil) then
            gridContainer.MaxCount = #wayGetIds;
            local index = 0;
            for k, v in pairs(wayGetIds) do
                local gobj = gridContainer.controlList[index];
                if (self.mGiftUnitDic[gobj] == nil) then
                    self.mGiftUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIWayGetGiftUnitTemplate, self.EntranceType);
                end
                self.mGiftUnitDic[gobj]:UpdateUnit(v);
                index = index + 1;
            end
        else
            gridContainer.MaxCount = 0;
        end
        gridContainer.gameObject:SetActive(gridContainer.MaxCount > 0);
    end
end
--endregion

--region 刷新商店快捷购买
UIWayGetAndBuyViewTemplate.mShopUnitDic = nil;

function UIWayGetAndBuyViewTemplate:UpdateShop()
    if (self.mWayGetDic ~= nil) then
        if (self.mShopUnitDic == nil) then
            self.mShopUnitDic = {};
        end
        local wayGetIds = self:ParseShopTabel(self.mWayGetDic[LuaEnumWayGetType.QuickBuy]);
        local gridContainer = self:GetShopGridContainer();
        if (wayGetIds ~= nil) then
            gridContainer.MaxCount = #wayGetIds;
            uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.QuickShopBuy
            local index = 0;
            for k, v in pairs(wayGetIds) do
                local gobj = gridContainer.controlList[index];
                if (self.mShopUnitDic[gobj] == nil) then
                    self.mShopUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIWayGetShopUnitTemplate, self.mOwnerPanel);
                end
                self.mShopUnitDic[gobj]:SetViewUnit(v, function(go, priceId)
                    self:ShowPropTips(go, priceId);
                end);
                index = index + 1;
            end
        else
            gridContainer.MaxCount = 0;
        end
        gridContainer.gameObject:SetActive(gridContainer.MaxCount > 0);
        if (self:GetItemNumBuyObj()) then
            self:GetItemNumBuyObj():SetActive(gridContainer.MaxCount > 0);
        end
    end
end

---处理互斥商品
function UIWayGetAndBuyViewTemplate:ParseShopTabel(wayGetIDs)
    if #wayGetIDs <= 1 then
        return wayGetIDs
    end
    ---@type table<number,number>
    local newWayGetIds = {}
    ---@type table<number,number> 需要移除的id
    local deltaIds = {}
    ---@type table<number,TABLE.cfg_way_get>
    local wayGetTables = {}

    ---获取需要互斥的所有id，存储表结构
    for i = 1, #wayGetIDs do
        ---@type TABLE.cfg_way_get
        local wayGetTable = clientTableManager.cfg_way_getManager:TryGetValue(wayGetIDs[i])
        if wayGetTable then
            if (wayGetTable:GetPriority() ~= nil and wayGetTable:GetPriority().list.Count > 0) then
                for i2 = 0, wayGetTable:GetPriority().list.Count - 1 do
                    table.insert(deltaIds, wayGetTable:GetPriority().list[i2])
                end
            end
            table.insert(wayGetTables, wayGetTable)
        end
    end

    ---排序
    table.sort(wayGetTables, function(a, b)
        if a and b and a:GetOrder() ~= nil and b:GetOrder() ~= nil then
            return a:GetOrder() < b:GetOrder()
        end
        return false
    end)

    ---添加需要添加的waygetid
    for i = 1, #wayGetTables do
        local isNeedDelta = false
        for i2 = 1, #deltaIds do
            ---是否需要移除
            if wayGetTables[i]:GetId() == deltaIds[i2] then
                isNeedDelta = true
            end
        end
        if not isNeedDelta then
            table.insert(newWayGetIds, wayGetTables[i]:GetId())
        end
    end

    return newWayGetIds
end

function UIWayGetAndBuyViewTemplate:ShowPropTips(go, priceId)
    local priceItemInfoIsFind, priceItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(priceId)

    ---货币跳转到首冲或者充值界面
    if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(priceId)) then
        Utility.TryShowFirstRechargePanel()
        return
    end

    local tipsId = 63
    local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(tipsId)
    local content = ""
    if isfind and priceItemInfoIsFind then
        content = string.format(data.content, priceItemInfo.name)
    end
    Utility.ShowPopoTips(go.transform, content, tipsId, "UIFurnaceWayAndBuyPanel");
end
--endregion

--region 刷新获取途径
UIWayGetAndBuyViewTemplate.mWayGetUnitDic = nil;

function UIWayGetAndBuyViewTemplate:UpdateWayGet()
    if (self.mWayGetDic ~= nil) then
        if (self.mWayGetUnitDic == nil) then
            self.mWayGetUnitDic = {};
        end
        local gridContainer = self:GetWayGetUnitGridContainer();
        local pos = gridContainer.transform.localPosition;
        local y = self:GetShopGridContainer().transform.localPosition.y - self:GetShopGridContainer().CellHeight * self:GetShopGridContainer().MaxCount - 2;
        gridContainer.transform.localPosition = CS.UnityEngine.Vector3(pos.x, y, pos.z);
        local wayGetIds = self.mWayGetDic[LuaEnumWayGetType.QuickGet];
        if (wayGetIds ~= nil) then
            gridContainer.MaxCount = #wayGetIds;
            local index = 0;
            for k, v in pairs(wayGetIds) do
                local gobj = gridContainer.controlList[index];
                if (self.mWayGetUnitDic[gobj] == nil) then
                    self.mWayGetUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIWayGetUnitTemplate);
                end
                self.mWayGetUnitDic[gobj]:UpdateUnit(v);
                index = index + 1;
            end
        else
            gridContainer.MaxCount = 0;
        end
        gridContainer.gameObject:SetActive(gridContainer.MaxCount > 0);
    end
end
--endregion

--region 刷新交易行快捷购买
UIWayGetAndBuyViewTemplate.mAuctionBuyUnitDic = nil

---刷新交易行快捷购买
function UIWayGetAndBuyViewTemplate:UpdateAuctionBuy()
    if self.mWayGetDic ~= nil then
        if (self.mAuctionBuyUnitDic == nil) then
            self.mAuctionBuyUnitDic = {};
        end

        local wayGetIds = self.mWayGetDic[LuaEnumWayGetType.QuickAuctionBuy]
        local gridContainer = self:GetAuctionItemsGridContainer()
        if wayGetIds ~= nil and #wayGetIds > 0 then
            uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.QuickAuctionBuy
            gridContainer.MaxCount = #wayGetIds
            for i = 1, #wayGetIds do
                local data = wayGetIds[i]
                local gobj = gridContainer.controlList[i - 1];
                ---@type UIWayGetQuickAuctionBuyTemplate
                local template = self.mWayGetUnitDic[gobj]
                if template == nil then
                    template = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIWayGetQuickAuctionBuyTemplate, self.mOwnerPanel);
                    if self.mBuyButtonCallBack == nil then
                        self.mBuyButtonCallBack = function(...)
                            self:OnAuctionBuyButtonClicked(...)
                        end
                    end
                    template:BindBuyButtonClickCallBack(self.mBuyButtonCallBack)
                    self.mWayGetUnitDic[gobj] = template
                end
                template:Update(data)
            end
        else
            gridContainer.MaxCount = 0;
        end
        gridContainer.gameObject:SetActive(gridContainer.MaxCount > 0);
    end
end

---播放交易行购买结果动画
---@param data auctionV2.ItemMsg
function UIWayGetAndBuyViewTemplate:PlayAuctionBuyResultAnimation(data)
    if data.item == nil then
        return
    end
    for i, v in pairs(self.mWayGetUnitDic) do
        ---@type UIWayGetQuickAuctionBuyTemplate
        local template = v
        if template ~= nil and CS.StaticUtility.IsNull(template.go) == false and template.go.activeInHierarchy then
            if template.mAuctionItemInfo ~= nil and template.mAuctionItemInfo.item ~= nil
                    and template.mIsRequestedBuy and template.mAuctionItemInfo.item.itemId == data.item.itemId then
                template:PlayBuySucceedAnimation(data)
                return
            end
        end
    end
end

---购买按钮点击事件
---@param go UnityEngine.GameObject
---@param template UIWayGetQuickAuctionBuyTemplate
---@param auctionItem auctionV2.AuctionItemInfo
---@param count number
function UIWayGetAndBuyViewTemplate:OnAuctionBuyButtonClicked(go, template, auctionItem, count)
    if auctionItem == nil or auctionItem.item == nil then
        return
    end
    template.mIsRequestedBuy = true
    if count == nil then
        count = 1
    end
    networkRequest.ReqBuyAuctionAuction(auctionItem.item.lid, count, 1)
end
--endregion

--region 刷新boss次数购买
---刷新boss次数购买
function UIWayGetAndBuyViewTemplate:UpdateBossTimeBuy()
    if self.mWayGetDic ~= nil then
        local wayGetIds = self.mWayGetDic[LuaEnumWayGetType.BossTimeAdd]
        local gridContainer = self:GetBossAddTimesReqGridContainer()
        if wayGetIds ~= nil and #wayGetIds > 0 then
            gridContainer.MaxCount = #wayGetIds
            for i = 1, #wayGetIds do
                local data = wayGetIds[i]
                local gobj = gridContainer.controlList[i - 1];
                local template = self:GetAddBossTimeTemplate(gobj)
                if template then
                    template:RefreshItem(data, self.mOwnerPanel.mPanelParams.bossType)
                end
            end
        else
            gridContainer.MaxCount = 0;
        end
        gridContainer.gameObject:SetActive(gridContainer.MaxCount > 0);
        if (self:GetItemNumBuyObj()) then
            self:GetItemNumBuyObj():SetActive(gridContainer.MaxCount > 0);
        end
    end
end

---@return UIWayGetAddBossTimeTemplate 增加boss次数模板
function UIWayGetAndBuyViewTemplate:GetAddBossTimeTemplate(go)
    if (self.mBossTimeBuyUnitDic == nil) then
        self.mBossTimeBuyUnitDic = {};
    end
    local template = self.mBossTimeBuyUnitDic[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIWayGetAddBossTimeTemplate, self.mOwnerPanel);
        self.mBossTimeBuyUnitDic[go] = template
    end
    return template
end
--endregion

--region 销毁
function UIWayGetAndBuyViewTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSendStoreInfoChangeMessage, self.OnResSendStoreInfoChangeMessage)
end

function UIWayGetAndBuyViewTemplate:OnDestroy()
    self:RemoveEvents();
end
--endregion

return UIWayGetAndBuyViewTemplate;