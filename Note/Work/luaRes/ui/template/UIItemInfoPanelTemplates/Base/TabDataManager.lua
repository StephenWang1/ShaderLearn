---页签物品数据管理
local TabDataManager = {}

--region 人物装备
function TabDataManager:GetTabData_RoleEquip(bagItemInfo, itemInfo)
    if itemInfo ~= nil then
        local bagItemInfoTable, itemInfoTable = {}, {}
        if self.showMoreAssistData == true then
            --region 显示数据特殊处理
            local UIRolePanel = uimanager:GetPanel("UIRolePanel")
            local UIServantPanel = uimanager:GetPanel("UIServantPanel")
            if UIRolePanel ~= nil or UIServantPanel ~= nil then
                bagItemInfoTable, itemInfoTable = uiStaticParameter.AssistDataManager:GetAssistData(self.commonData)
                if bagItemInfoTable ~= nil and itemInfoTable ~= nil and type(bagItemInfoTable) == 'table' and Utility.GetTableCount(bagItemInfoTable) > 0 then
                    self.assistBagItemTable[0] = bagItemInfoTable
                    self.assistItemInfoTable[0] = itemInfoTable
                end
                return
            end

            --region 通用处理
            ---人物装备列表
            bagItemInfoTable, itemInfoTable = uiStaticParameter.AssistDataManager:GetAssistData(self.commonData)
            if bagItemInfoTable ~= nil and itemInfoTable ~= nil and type(bagItemInfoTable) == 'table' and Utility.GetTableCount(bagItemInfoTable) > 0 then
                self.assistBagItemTable[0] = bagItemInfoTable
                self.assistItemInfoTable[0] = itemInfoTable
            end
            ---灵兽装备列表
            local equipIndexTable = Utility.ListChangeTable(CS.CSServantInfoV2.GetServantRoleEquipIndexList(itemInfo.subType))
            for k, v in pairs(equipIndexTable) do
                local servantBsgItemInfo = CS.CSServantInfoV2.GetServantEquipByEquipIndex(v)
                local servantSeatType = Utility.GetIntPart(v / 1000)
                if servantBsgItemInfo ~= nil and servantBsgItemInfo.ItemTABLE ~= nil and gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():ServantIndexCanUseRoleEquip(servantSeatType) then
                    if self.assistBagItemTable[servantSeatType] == nil then
                        self.assistBagItemTable[servantSeatType] = {}
                        self.assistItemInfoTable[servantSeatType] = {}
                    end
                    table.insert(self.assistBagItemTable[servantSeatType], servantBsgItemInfo)
                    table.insert(self.assistItemInfoTable[servantSeatType], servantBsgItemInfo.ItemTABLE)
                end
            end
            if self.index == nil then
                local servantRoleEquipPageIndex = Utility.GetRecommendEquippedIndex(self.bagItemInfo)
                if servantRoleEquipPageIndex ~= nil then
                    if self.assistBagItemTable[servantRoleEquipPageIndex] == nil then
                        self.index = 0
                    else
                        self.index = servantRoleEquipPageIndex
                    end
                end
            end
            ---设置当前选择的装备位
            if self.assistBagItemTable ~= nil and type(self.assistBagItemTable) == 'table' and Utility.GetTableCount(self.assistBagItemTable) > 0 then
                for k, v in pairs(self.assistBagItemTable) do
                    if self.assistBagItemTable[0] ~= nil then
                        uiStaticParameter.UIItemInfoManager:SetChooseIndex(0)
                        return
                    end
                    uiStaticParameter.UIItemInfoManager:SetChooseIndex(k)
                    return
                end
            end
            --endregion
        else
            local bagItemInfo, itemInfo = uiStaticParameter.CompareDataManager:GetCompareData(self.commonData)
            table.insert(bagItemInfoTable, bagItemInfo)
            table.insert(itemInfoTable, itemInfo)
            table.insert(self.assistBagItemTable, bagItemInfoTable)
            table.insert(self.assistItemInfoTable, itemInfoTable)
        end
    end
end
--endregion

--region 灵兽蛋
function TabDataManager:GetTabData_ServantEgg(bagItemInfo, itemInfo)
    if itemInfo ~= nil and itemInfo.useParam ~= nil and itemInfo.useParam.list.Count > 0 then
        ---有灵兽面板的情况下，对比面板显示选择的灵兽
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBagItemInfoByIndex(uiStaticParameter.SelectedServantType)
            if servantBagItemInfo ~= nil then
                local servantBagItemInfoTable = {}
                local seravntItemInfoTable = {}
                table.insert(servantBagItemInfoTable, servantBagItemInfo)
                table.insert(seravntItemInfoTable, servantBagItemInfo.ItemTABLE)
                self.assistBagItemTable[uiStaticParameter.SelectedServantType] = servantBagItemInfoTable
                self.assistItemInfoTable[uiStaticParameter.SelectedServantType] = seravntItemInfoTable
            end
        else
            local servantTableInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantInfoByItemInfo(itemInfo)
            if servantTableInfo ~= nil then
                local servantType = servantTableInfo.type
                ---通用灵兽对比所有的灵兽位上的灵兽
                if servantType == luaEnumServantType.COMMON then
                    local bodyAllServantDic = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBodyAllServant()
                    CS.Utility_Lua.luaForeachCsharp:Foreach(bodyAllServantDic, function(k, v)
                        local servantBagItemInfoTable = {}
                        local seravntItemInfoTable = {}
                        table.insert(servantBagItemInfoTable, v)
                        table.insert(seravntItemInfoTable, v.ItemTABLE)
                        self.assistBagItemTable[k] = servantBagItemInfoTable
                        self.assistItemInfoTable[k] = seravntItemInfoTable

                        ---默认选择最弱的灵兽
                        if Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.GreenArrow or Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.YellowArrow then
                            local nowServantBagItemInfo = self.assistBagItemTable[k][1]
                            if self.lowBagItemInfo == nil then
                                self.index = k
                                self.lowBagItemInfo = nowServantBagItemInfo
                            else
                                local goodParams = CS.CSScene.MainPlayerInfo.ServantInfoV2:CompareServant(self.lowBagItemInfo, nowServantBagItemInfo)
                                if goodParams ~= 1 then
                                    self.index = k
                                    self.lowBagItemInfo = nowServantBagItemInfo
                                end
                            end
                        end
                    end)
                else
                    ---常规灵兽对比对应灵兽位的灵兽
                    local servantBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBagItemInfoByIndex(servantType)
                    if servantBagItemInfo ~= nil then
                        local servantBagItemInfoTable = {}
                        local seravntItemInfoTable = {}
                        table.insert(servantBagItemInfoTable, servantBagItemInfo)
                        table.insert(seravntItemInfoTable, servantBagItemInfo.ItemTABLE)
                        self.assistBagItemTable[servantType] = servantBagItemInfoTable
                        self.assistItemInfoTable[servantType] = seravntItemInfoTable
                    end
                end
            end
        end
    end
end
--endregion

--region 灵兽装备,灵兽肉身
function TabDataManager:GetTabData_ServantEquip(bagItemInfo, itemInfo)
    if itemInfo ~= nil and CS.CSServantInfoV2.IsServantEquip(itemInfo) then
        local servantEquipBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsEquipOnServant(itemInfo.subType)
        if servantEquipBagItemInfo == nil then
            return
        end
        local bagItemInfoTable, itemInfoTable = uiStaticParameter.AssistDataManager:GetAssistData(self.commonData)
        table.insert(self.assistBagItemTable, bagItemInfoTable)
        table.insert(self.assistItemInfoTable, itemInfoTable)
    end
end
--endregion

--region 灵兽肉身
function TabDataManager:GetTabData_ServantCommonBody(bagItemInfo, itemInfo)
    if itemInfo ~= nil and CS.CSServantInfoV2.IsServantCommonBody(itemInfo) then
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBodyEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBodyEquipInfoByServantType(itemInfo.subType, uiStaticParameter.SelectedServantType)
            if servantBodyEquip ~= nil then
                local BodyEquipBagItemInfoTable = {}
                local BodyEquipItemInfoTable = {}
                table.insert(BodyEquipBagItemInfoTable, servantBodyEquip)
                table.insert(BodyEquipItemInfoTable, servantBodyEquip.ItemTABLE)
                self.assistBagItemTable[uiStaticParameter.SelectedServantType] = BodyEquipBagItemInfoTable
                self.assistItemInfoTable[uiStaticParameter.SelectedServantType] = BodyEquipItemInfoTable
            end
        else
            local bodyAllBodyEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetAllBodyEquipBySubType(itemInfo.subType)
            CS.Utility_Lua.luaForeachCsharp:Foreach(bodyAllBodyEquip, function(k, v)
                local BodyEquipBagItemInfoTable = {}
                local BodyEquipItemInfoTable = {}
                table.insert(BodyEquipBagItemInfoTable, v)
                table.insert(BodyEquipItemInfoTable, v.ItemTABLE)
                self.assistBagItemTable[k] = BodyEquipBagItemInfoTable
                self.assistItemInfoTable[k] = BodyEquipItemInfoTable

                ---默认选择最弱灵兽肉身
                if Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.GreenArrow or Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.YellowArrow then
                    local nowServantBodyBagItemInfo = self.assistBagItemTable[k][1]
                    if self.lowBagItemInfo == nil then
                        self.index = k
                        self.lowBagItemInfo = nowServantBodyBagItemInfo
                    else
                        local isGoodParams = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBetterBodyEquip(self.lowBagItemInfo, nowServantBodyBagItemInfo)
                        if isGoodParams == 1 then
                            self.index = k
                            self.lowBagItemInfo = nowServantBodyBagItemInfo
                        end
                    end
                end
            end)
        end
    end
end
--endregion

--region 法宝
function TabDataManager:GetTabData_MagicEquip(bagItemInfo, itemInfo)
    if itemInfo ~= nil then
        local bagItemInfoTable, itemInfoTable = uiStaticParameter.AssistDataManager:GetAssistData(self.commonData)
        table.insert(self.assistBagItemTable, bagItemInfoTable)
        table.insert(self.assistItemInfoTable, itemInfoTable)
    end
end
--endregion

--region 神力装备
---获得神力装备辅助面板显示（显示玩家身上）
function TabDataManager:GetTabData_DivineEquip(bagItemInfo, itemInfo)
    if itemInfo and bagItemInfo then
        local bagItemInfoTable, itemInfoTable = uiStaticParameter.AssistDataManager:GetAssistData(self.commonData)
        if bagItemInfoTable and itemInfoTable then
            table.insert(self.assistBagItemTable, bagItemInfoTable)
            table.insert(self.assistItemInfoTable, itemInfoTable)
        end
    end
end
--endregion

--region 外部调用
---@return 背包物品对比表,物品对比表,默认选择的index
function TabDataManager:GetTabData(commonData)
    self.commonData = commonData
    self.type = commonData.type
    ---@type bagV2.BagItemInfo
    self.bagItemInfo = commonData.bagItemInfo
    ---@type TABLE.CFG_ITEMS
    self.itemInfo = commonData.itemInfo
    self.showMoreAssistData = commonData.showMoreAssistData
    self.assistBagItemTable = {}
    self.assistItemInfoTable = {}
    self.index = nil
    self.lowBagItemInfo = nil
    if self.type == LuaEnumItemInfoPanelItemType.RoleEquip or self.type == LuaEnumItemInfoPanelItemType.DoubleMedal then
        self:GetTabData_RoleEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_Egg then
        self:GetTabData_ServantEgg(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_Equip or self.type == LuaEnumItemInfoPanelItemType.Servant_BodyEquip then
        self:GetTabData_ServantEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_BodyCommon then
        self:GetTabData_ServantCommonBody(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.MagicEquip then
        self:GetTabData_MagicEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.DivineEquip then
        self:GetTabData_DivineEquip(self.bagItemInfo, self.itemInfo)
    end

    if self.assistItemInfoTable == nil or Utility.GetTableCount(self.assistItemInfoTable) == 0 then
        return
    end
    self.index = ternary(self.index == nil,0,self.index)
    return self.assistBagItemTable, self.assistItemInfoTable, self.index
end
--endregion

--region 通用
---设置默认页签下标
---@param bagItemInfoTable table<bagV2.BagItemInfo>
---@param compareFunction function<bagV2.BagItemInfo,bagV2.BagItemInfo>
---@param pageIndex number 页签id
function TabDataManager:SetDefaultPageIndex(bagItemInfoTable,compareFunction,pageIndex)
    if self.bagItemInfo == nil or self.itemInfo == nil or type(bagItemInfoTable) ~= 'table' or Utility.GetLuaTableCount(bagItemInfoTable) <= 0 or compareFunction == nil or pageIndex == nil then
        return
    end
    for k,v in pairs(bagItemInfoTable) do
        if compareFunction(self.bagItemInfo,v) == 1 then
            self.index = pageIndex
            break
        end
    end
end
--endregion
return TabDataManager