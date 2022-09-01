---对比物品管理
---@class CompareDataManager
local CompareDataManager = {}

--region 人物装备
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS
function CompareDataManager:GetCompareData_RoleEquip(bagItemInfo, itemInfo)
    if itemInfo ~= nil then
        --region 显示数据特殊处理
        ---有灵兽面板的情况下
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBodyEquipTable = Utility.ListChangeTable(CS.CSServantInfoV2.GetServantEquipInfoListByServantType(itemInfo.subType, uiStaticParameter.SelectedServantType))
            if servantBodyEquipTable ~= nil and type(servantBodyEquipTable) == 'table' and #servantBodyEquipTable > 0 then
                local lowrAssistBagItemInfo, lowAssistItemInfo = nil, nil
                if #servantBodyEquipTable >= 1 then
                    lowrAssistBagItemInfo, lowAssistItemInfo = self:GetLowData_RoleEquip(servantBodyEquipTable)
                end
                return lowrAssistBagItemInfo, lowAssistItemInfo
            end
            return
        end
        --endregion
        local equipIndex = CS.CSScene.MainPlayerInfo.EquipInfo:GetLowEquipIndexByEquipSubtype(itemInfo.subType)
        local assistBagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(equipIndex)
        if assistBagItemInfo == nil then
            return
        end
        local assistItemInfoIsFind, assistItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(assistBagItemInfo.itemId)
        return assistBagItemInfo, assistItemInfo
    end
end

---获取最差的角色装备
function CompareDataManager:GetLowData_RoleEquip(bagItemInfoTable)
    if bagItemInfoTable ~= nil and #bagItemInfoTable > 0 then
        local lowEquipBagItemInfo = nil
        local lowEquipItemInfo = nil
        for k, v in pairs(bagItemInfoTable) do
            if lowEquipBagItemInfo == nil then
                lowEquipBagItemInfo = v
            end
            if lowEquipBagItemInfo ~= nil and lowEquipBagItemInfo ~= v then
                local firstIsGood = CS.CSScene.MainPlayerInfo.EquipInfo:CompareEquip(lowEquipBagItemInfo, v)
                if firstIsGood == true then
                    lowEquipBagItemInfo = v
                end
                local left = clientTableManager.cfg_itemsManager:TryGetValue(lowEquipBagItemInfo.itemId)
                local right = clientTableManager.cfg_itemsManager:TryGetValue(v.itemId)
                clientTableManager.cfg_itemsManager:TryGetValue(lowEquipBagItemInfo.itemId)

                lowEquipBagItemInfo = self:GetCompareLowEquip(lowEquipBagItemInfo, v)
                local final = clientTableManager.cfg_itemsManager:TryGetValue(lowEquipBagItemInfo.itemId)
            end
        end
        if lowEquipBagItemInfo ~= nil then
            lowEquipItemInfo = lowEquipBagItemInfo.ItemTABLE
        end
        return lowEquipBagItemInfo, lowEquipItemInfo
    end
end

---@param left bagV2.BagItemInfo
---@param right bagV2.BagItemInfo
function CompareDataManager:GetCompareLowEquip(left, right)
    if left and right then
        if clientTableManager.cfg_itemsManager:IsDivineSuitEquip(left.itemId) then
            local isBetter = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():ItemCompare(left, right)
            return isBetter and left or right
        else
            local firstIsGood = CS.CSScene.MainPlayerInfo.EquipInfo:CompareEquip(left, right)
            return firstIsGood and right or left
        end
    end
    return left
end

--endregion

--region 灵兽蛋
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS
function CompareDataManager:GetCompareData_ServantEgg(bagItemInfo, itemInfo)
    if itemInfo ~= nil and itemInfo.useParam ~= nil and itemInfo.useParam.list.Count > 0 then
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBodyEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBodyEquipInfoByServantType(itemInfo.subType, uiStaticParameter.SelectedServantType)
            if servantBodyEquip ~= nil then
                return servantBodyEquip, servantBodyEquip.ItemTABLE
            end
        else
            local servantType = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetSeravntTypeByItemInfo(itemInfo)
            local servantIndex = 0
            if Utility.EnumToInt(servantType) == luaEnumServantType.COMMON then
                local servantPanel = uimanager:GetPanel("UIServantPanel")
                if servantPanel ~= nil then
                    servantIndex = uiStaticParameter.SelectedServantType
                else
                    servantIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBodyLowServantIndex()
                end
            else
                servantIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEmptyServentCfgId(itemInfo.useParam.list[0])
            end
            if servantIndex == 0 then
                return
            end
            local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServentIndexByDic(servantIndex)
            if servantInfo == nil then
                return
            end
            local assistBagItemInfo = servantInfo.servantEgg
            if assistBagItemInfo == nil then
                return
            end
            local assistItemInfoIsFind, assistItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(assistBagItemInfo.itemId)
            return assistBagItemInfo, assistItemInfo
        end
    end
end
--endregion

--region 灵兽装备,灵兽肉身
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS
function CompareDataManager:GetCompareData_ServantEquip(bagItemInfo, itemInfo)
    if itemInfo ~= nil and CS.CSServantInfoV2.IsServantEquip(itemInfo) then
        local servantEquipBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsEquipOnServant(itemInfo.subType)
        if servantEquipBagItemInfo == nil then
            return
        end
        local servantEquipItemInfoIsFind, servantEquipItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(servantEquipBagItemInfo.itemId)
        if servantEquipItemInfoIsFind then
            return servantEquipBagItemInfo, servantEquipItemInfo
        end
    end
end

---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS 通用肉身获取灵兽身上最差装备
function CompareDataManager:GetCompareData_ServantCommonBody(bagItemInfo, itemInfo)
    if itemInfo ~= nil and CS.CSServantInfoV2.IsServantCommonBody(itemInfo) then
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBodyEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBodyEquipInfoByServantType(itemInfo.subType, uiStaticParameter.SelectedServantType)
            if servantBodyEquip ~= nil then
                return servantBodyEquip, servantBodyEquip.ItemTABLE
            end
        else
            local servantEquipBagItemInfo

            local servantType = 0
            local servantPanel = uimanager:GetPanel("UIServantPanel")
            if servantPanel then
                servantType = servantPanel:GetSelectHeadInfo():GetServantType()
                servantEquipBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBodyEquipInfoByServantType(itemInfo.subType, servantType)
            else
                servantEquipBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBadEquipOnServantBySubtype(itemInfo)
            end

            if servantEquipBagItemInfo == nil then
                return
            end

            local servantEquipItemInfoIsFind, servantEquipItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(servantEquipBagItemInfo.itemId)
            if servantEquipItemInfoIsFind then
                return servantEquipBagItemInfo, servantEquipItemInfo
            end
        end
    end
end
--endregion

--region 额外装备列表
---@return table
function CompareDataManager:GetExtraEquipTable(bagItemInfo, itemInfo)
    local extraEquipList = {};
    if itemInfo.type ~= luaEnumItemType.Equip then
        return extraEquipList
    end
    local equipIndex = itemInfo.subType
    if equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LAMP) then
        local DengxinId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_DengXin
        if (DengxinId ~= 0) then
            table.insert(extraEquipList, DengxinId);
        end
        --魂玉
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE) then
        local ShengMingJingPoId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShengMingJingPo
        if (ShengMingJingPoId ~= 0) then
            table.insert(extraEquipList, ShengMingJingPoId);
        end
        --灵兽秘宝
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA) then
        local JinGongZhiYuanId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan
        local ShouHuZhiYuanId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan
        if (JinGongZhiYuanId ~= 0) then
            table.insert(extraEquipList, JinGongZhiYuanId);
        end
        if (ShouHuZhiYuanId ~= 0) then
            table.insert(extraEquipList, ShouHuZhiYuanId);
        end
        --宝石
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE) then
        local BaoshiId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_BaoShi
        if (BaoshiId ~= 0) then
            table.insert(extraEquipList, BaoshiId);
        end
    end
    return extraEquipList;
end
--endregion

--region 法宝
---法宝获取对比的物品
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS 对比的法宝数据
function CompareDataManager:GetCompareData_MagicEquip(bagItemInfo, itemInfo)
    local uiOtherPlayerMessagePanel = uimanager:GetPanel("UIOtherPlayerMessagePanel")
    local compareBagItemInfo = nil
    if uiOtherPlayerMessagePanel ~= nil and bagItemInfo ~= nil then
        ---有其他玩家界面的时候
        local equipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(itemInfo.id)
        if equipIndex == nil then
            return
        end
        local otherPlayerSameEquipIndexItem = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipItemInfo(equipIndex)
        if otherPlayerSameEquipIndexItem == nil or otherPlayerSameEquipIndexItem.BagItemInfo == nil or otherPlayerSameEquipIndexItem.BagItemInfo.lid == bagItemInfo.lid then
            return
        end
        compareBagItemInfo = otherPlayerSameEquipIndexItem.BagItemInfo
    else
        if itemInfo ~= nil then
            local equipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(itemInfo.id)
            ---@type LuaMagicEquipDataItem
            local bodyBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipItemInfo(equipIndex)
            if bodyBagItemInfo ~= nil and bodyBagItemInfo.BagItemInfo ~= nil then
                compareBagItemInfo = bodyBagItemInfo.BagItemInfo
            end
        end
    end
    if compareBagItemInfo == nil or bagItemInfo == nil or compareBagItemInfo.lid == bagItemInfo.lid then
        return
    end
    if type(compareBagItemInfo) == 'table' then
        compareBagItemInfo = protobufMgr.DecodeTable.bag.BagItemInfo(compareBagItemInfo)
    end
    itemInfo = compareBagItemInfo.ItemTABLE
    if compareBagItemInfo ~= nil and itemInfo == nil then
        itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(compareBagItemInfo.itemId)
    end
    return compareBagItemInfo, itemInfo
end
--endregion

--region 藏品
---藏品对比
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS 对比的藏品数据
function CompareDataManager:GetCompareData_Collection(bagItemInfo, itemInfo)
    if bagItemInfo and itemInfo and itemInfo.type == luaEnumItemType.Collection then
        if gameMgr:GetPlayerDataMgr() ~= nil then
            local sameCollectionItem = gameMgr:GetPlayerDataMgr():GetCollectionInfo():GetCollectionItemByCollectionID(itemInfo.id)
            if sameCollectionItem and sameCollectionItem:GetCollectionLid() ~= bagItemInfo.lid then
                return sameCollectionItem:GetCollectionBagItem()
            end
        end
    end
end
--endregion

--region 通用
---获取表里第一个物品
function CompareDataManager:GetFirstBagItemInfo(assistPanelBagItemInfoTable)
    if assistPanelBagItemInfoTable ~= nil and type(assistPanelBagItemInfoTable) == 'table' then
        for k, v in pairs(assistPanelBagItemInfoTable) do
            local bagItemInfo = v
            local itemInfo = bagItemInfo.ItemTABLE
            return bagItemInfo, itemInfo
        end
    end
end
--endregion

--region 外部调用
---获取对比物品
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS
function CompareDataManager:GetCompareData(commonData)
    self.type = commonData.type
    self.bagItemInfo = commonData.bagItemInfo
    self.itemInfo = commonData.itemInfo
    if self.type == LuaEnumItemInfoPanelItemType.RoleEquip or self.type == LuaEnumItemInfoPanelItemType.DoubleMedal then
        return self:GetCompareData_RoleEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_Egg then
        return self:GetCompareData_ServantEgg(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_Equip or self.type == LuaEnumItemInfoPanelItemType.Servant_BodyEquip then
        return self:GetCompareData_ServantEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_BodyCommon then
        return self:GetCompareData_ServantCommonBody(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.MagicEquip then
        return self:GetCompareData_MagicEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Collection then
        return self:GetCompareData_Collection(self.bagItemInfo, self.itemInfo)
    end
end

---获取对比物品中最弱的一件
function CompareDataManager:GetLowData(commonData)
    self.type = commonData.type
    self.assistPanelBagItemInfoTable = commonData.assistPanelBagItemInfoTable
    if self.type == LuaEnumItemInfoPanelItemType.RoleEquip or self.type == LuaEnumItemInfoPanelItemType.DoubleMedal or self.type == LuaEnumItemInfoPanelItemType.DivineEquip then
        return self:GetLowData_RoleEquip(self.assistPanelBagItemInfoTable)
    else
        return self:GetFirstBagItemInfo(self.assistPanelBagItemInfoTable)
    end
end
--endregion

return CompareDataManager