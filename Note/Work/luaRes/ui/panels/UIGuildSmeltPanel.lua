local UIGuildSmeltPanel = {}

setmetatable(UIGuildSmeltPanel,luaPanelModules.UIGuildBagPanel)

--region 初始化
function UIGuildSmeltPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshUnionSmeltWarehouse, function()
        self:InitWarehouseRecycleController()
        self:RefreshPanelShow()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:InitBagRecycleController()
    end)
end
--endregion

--region 刷新
function UIGuildSmeltPanel:Show()
    networkRequest.ReqGetUnionSmeltItem()
    self:InitBagRecycleController()
    self:InitBagPage()
    self:InitWarehouseRecycleController()
    self:RefreshPanelShow()
    self:GetAllToggle():Set(true)
end
--endregion

--region 属性
---@return table<number,bagV2.BagItemInfo> 获取背包物品列表
function UIGuildSmeltPanel:GetBagInfoList()
    local list = self:GetBagInfo():GetBagItemList()
    local showList = {}
    for i = 0, list.Count - 1 do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = list[i]
        if bagItemInfo and bagItemInfo.ItemTABLE then
            if Utility.IsAvailableForSemelt(bagItemInfo.ItemTABLE) then
                table.insert(showList, bagItemInfo)
            end
        end
    end
    return showList
end

---交互
---@return UIGuildBagPanel_Interaction
function UIGuildSmeltPanel:GetGuildBagInteraction()
    if self.mInteraction == nil then
        self.mInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIGuildSmeltBagPanel_Interaction, self, nil, nil)
    end
    return self.mInteraction
end

--region 仓库
---刷新仓库显示
function UIGuildSmeltPanel:InitWarehouseRecycleController()
    local page = 1;
    local targetPage = self.mCurrentWarehousePage == nil and 0 or self.mCurrentWarehousePage;
    if self:GetUnionInfoV2() then
        self.storageList = self:GetFilteredStorageList()
        local curPage = math.ceil(#self.storageList / self:GetPerPageGridNum())
        page = ternary(curPage == 0,1,curPage)
        self.guildGridMaxIndex = page * self:GetPerPageGridNum()
    end
    self:GetWarehouseRecycleController():Initialize(page, function(pageObj, pageIndex)
        self:OnWarehousePageEnterView(pageObj, pageIndex)
    end, nil, function(page)
        self:OnWarehouseCenterPageIndexChanged(page)
    end, targetPage);
    self:InitWarehousePage(page, targetPage)
end

---@return table<number,unionV2.AuctionItemInfo>获取需要显示仓库道具
function UIGuildSmeltPanel:GetFilteredStorageList()
    local list = luaclass.UnionSmeltDataInfo:GetUnionSmeltWarehuoseTable()
    local showList = {}
    for k,v in pairs(list) do
        if v ~= nil and v.item ~= nil then
            ---@type auctionV2.AuctionItemInfo
            local auctionItemInfo = v
            ---@type bagV2.BagItemInfo
            local bagItemInfo = v.item
            if bagItemInfo and bagItemInfo.ItemTABLE then
                if Utility.IsAvailableForSemelt(bagItemInfo.ItemTABLE) then
                    if self:GetAllToggle().value then
                        table.insert(showList, bagItemInfo)
                    elseif self:GetServantEggToggle().value then
                        ---人物装备
                        if CS.CSScene.MainPlayerInfo.EquipInfo:CheckIsRoleEquip(bagItemInfo.ItemTABLE) then
                            table.insert(showList, bagItemInfo)
                        end
                    elseif self:GetServantBodyToggle().value then
                        ---灵兽
                        if CS.CSServantInfoV2.isServantEgg(bagItemInfo.ItemTABLE) then
                            table.insert(showList, bagItemInfo)
                        end
                    elseif self:GetOtherEquipToggle().value then
                        ---灵兽装备
                        if CS.CSServantInfoV2.IsServantBody(bagItemInfo.ItemTABLE.subType) or CS.CSServantInfoV2.IsServantJustEquip(bagItemInfo.ItemTABLE.subType) then
                            table.insert(showList, bagItemInfo)
                        end
                    end
                end
            end
        end
    end
    return showList
end

---@return UIGuildBagPanel_StorageGridTemplate 获取帮会熔炼仓库格子模板
function UIGuildSmeltPanel:GetGuildBagGridTemplate(go)
    if self.mGuildBagGridToTemplate == nil then
        self.mGuildBagGridToTemplate = {}
    end
    local template = self.mGuildBagGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildSmeltBagPanel_StorageGridTemplate)
        self.mGuildBagGridToTemplate[go] = template
    end
    return template
end
--endregion
--endregion

--region 点击
---点击帮助按钮
function UIGuildSmeltPanel:OnHelpBtnClicked()
    local isFind, desInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(172)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, desInfo)
    end
end
--endregion

--region 刷新
---刷新熔炼积分
function UIGuildSmeltPanel:RefreshPanelShow()
    if self:GetUnionInfoV2() then
        local score = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(1000026)
        if score then
            self:GetContributionLabel().text = "我的背包(熔炼积分" .. score .. ")"
        end
    end
end
--endregion

--region Update
function update()
    UIGuildSmeltPanel:GetGuildBagInteraction():OnUpdate(CS.UnityEngine.Time.time)
end
--endregion

--region ondestroy
--function ondestroy()
--    uiStaticParameter.mUnionSmeltBagItemInfoLid = 0
--end
--endregion

return UIGuildSmeltPanel