---副面板数据管理
---@class AssistDataManager
local AssistDataManager = {}
--region 人物装备
---@return Table<bagV2.BagItemInfo>,Table<TABLE.CFG_ITEMS>
function AssistDataManager:GetAssistData_RoleEquip(bagItemInfo, itemInfo)
    if itemInfo ~= nil then
        --region 显示数据特殊处理
        ---有灵兽面板的情况下
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBodyEquipTable = Utility.ListChangeTable(CS.CSServantInfoV2.GetServantEquipInfoListByServantType(itemInfo.subType, uiStaticParameter.SelectedServantType))
            if servantBodyEquipTable ~= nil and type(servantBodyEquipTable) == 'table' and #servantBodyEquipTable > 0 then
                local BodyEquipBagItemInfoTable = servantBodyEquipTable
                local BodyEquipItemInfoTable = {}
                for k, v in pairs(BodyEquipBagItemInfoTable) do
                    if v ~= nil and v.ItemTABLE ~= nil then
                        table.insert(BodyEquipItemInfoTable, v.ItemTABLE)
                    end
                end
                self.assistBagItemTable = BodyEquipBagItemInfoTable
                self.assistItemInfoTable = BodyEquipItemInfoTable
            end
            return
        end
        --endregion

        local bagItemInfoList = CS.CSScene.MainPlayerInfo.EquipInfo:GetBagItemInfoListByEquipSubType(itemInfo.subType)
        if bagItemInfoList == nil or bagItemInfoList.Count == 0 then
            return
        end
        self.assistBagItemTable = Utility.ListChangeTable(bagItemInfoList)
        for k, v in pairs(self.assistBagItemTable) do
            table.insert(self.assistItemInfoTable, v.ItemTABLE)
        end
    end
end
--endregion

--region 灵兽蛋
---@return Table<bagV2.BagItemInfo>,Table<TABLE.CFG_ITEMS>
function AssistDataManager:GetAssistData_ServantEgg(bagItemInfo, itemInfo)
    if itemInfo ~= nil and itemInfo.useParam ~= nil and itemInfo.useParam.list.Count > 0 then
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBagItemInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBagItemInfoByIndex(uiStaticParameter.SelectedServantType)
            if servantBagItemInfo ~= nil then
                table.insert(self.assistBagItemTable, servantBagItemInfo)
                table.insert(self.assistItemInfoTable, servantBagItemInfo.ItemTABLE)
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
            table.insert(self.assistBagItemTable, assistBagItemInfo)
            table.insert(self.assistItemInfoTable, assistItemInfo)
        end
    end
end
--endregion

--region 灵兽装备,灵兽肉身
---@return Table<bagV2.BagItemInfo>,Table<TABLE.CFG_ITEMS>
function AssistDataManager:GetAssistData_ServantEquip(bagItemInfo, itemInfo)
    if itemInfo ~= nil and CS.CSServantInfoV2.IsServantEquip(itemInfo) then
        local servantEquipBagItemInfoList = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetAllEquipByServant(itemInfo.subType)
        if servantEquipBagItemInfoList == nil or servantEquipBagItemInfoList.Count == 0 then
            return
        end
        self.assistBagItemTable = Utility.ListChangeTable(servantEquipBagItemInfoList)
        if self.assistBagItemTable ~= nil and type(self.assistBagItemTable) == 'table' then
            for k, v in pairs(self.assistBagItemTable) do
                table.insert(self.assistItemInfoTable, v.ItemTABLE)
            end
        end
    end
end

---通用肉身获取灵兽身上最差装备
---@return Table<bagV2.BagItemInfo>,Table<TABLE.CFG_ITEMS >
function AssistDataManager:GetAssistData_ServantCommonBody(bagItemInfo, itemInfo)
    if itemInfo ~= nil and CS.CSServantInfoV2.IsServantCommonBody(itemInfo) then
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            local servantBodyEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBodyEquipInfoByServantType(itemInfo.subType, uiStaticParameter.SelectedServantType)
            if servantBodyEquip ~= nil then
                table.insert(self.assistBagItemTable, servantBodyEquip)
                table.insert(self.assistItemInfoTable, servantBodyEquip.ItemTABLE)
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
                table.insert(self.assistBagItemTable, servantEquipBagItemInfo)
                table.insert(self.assistItemInfoTable, servantEquipItemInfo)
            end
        end
    end
end
--endregion

--region 额外装备列表
---@return table
function AssistDataManager:GetExtraEquipTable(bagItemInfo, itemInfo)
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
---获取副面板装备数据
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return table<bagV2.BagItemInfo>,table<TABLE.CFG_ITEMS> 副面板装备数据
function AssistDataManager:GetAssistData_MagicEquip(bagItemInfo, itemInfo)
    local compareBagItemInfom, compareItemInfo = uiStaticParameter.CompareDataManager:GetCompareData_MagicEquip(bagItemInfo, itemInfo)
    if compareBagItemInfom == nil then
        return
    end
    table.insert(self.assistBagItemTable, compareBagItemInfom)
    table.insert(self.assistItemInfoTable, compareItemInfo)
end
--endregion

--region 神力装备
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function AssistDataManager:GetCompareData_DivineEquip(bagItemInfo, itemInfo)
    if bagItemInfo and itemInfo then
        local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        if luaItemInfo == nil then
            return
        end
        local divineId = luaItemInfo:GetDivineId()
        local divineData = clientTableManager.cfg_divinesuitManager:TryGetValue(divineId)
        if divineData == nil then
            return
        end
        local divineType = divineData:GetType()
        if divineType ~= LuaEquipmentListType.Base then
            local leftIndex = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSLEquipIndex(divineType, itemInfo.subType, false)
            local rightIndex = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSLEquipIndex(divineType, itemInfo.subType, true)

            local mLeftPlayerDivineData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(divineType, leftIndex, true)
            local mRightPlayerDivineData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(divineType, rightIndex, true)

            if mLeftPlayerDivineData and mLeftPlayerDivineData.BagItemInfo and mLeftPlayerDivineData.BagItemInfo.lid ~= bagItemInfo.lid then
                local divineBagItemInfo = mLeftPlayerDivineData.BagItemInfo
                local res, divineItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(divineBagItemInfo.itemId)
                divineBagItemInfo = (type(divineBagItemInfo) == 'table')
                        and protobufMgr.DecodeTable.bag.BagItemInfo(divineBagItemInfo)
                        or divineBagItemInfo
                table.insert(self.assistBagItemTable, divineBagItemInfo)
                table.insert(self.assistItemInfoTable, divineItemInfo)
            end
            if mRightPlayerDivineData and mRightPlayerDivineData.BagItemInfo then
                local divineBagItemInfo = mRightPlayerDivineData.BagItemInfo
                local res, divineItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(divineBagItemInfo.itemId)
                divineBagItemInfo = (type(divineBagItemInfo) == 'table')
                        and protobufMgr.DecodeTable.bag.BagItemInfo(divineBagItemInfo)
                        or divineBagItemInfo
                table.insert(self.assistBagItemTable, divineBagItemInfo)
                table.insert(self.assistItemInfoTable, divineItemInfo)
            end
        end
    end
end
--endregion

--region 阵法装备
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return bagV2.BagItemInfo,TABLE.CFG_ITEMS
function AssistDataManager:GetCompareData_ZhengFaEquip(bagItemInfo, itemInfo)
    if itemInfo == nil then
        return
    end
    local compareBagItemInfo = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaEquipManager():GetSameTypeZhenFaEquip(itemInfo.id)
    if compareBagItemInfo == nil then
        return
    end
    local compareItemInfoIsFind,compareItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(compareBagItemInfo.itemId)
    table.insert(self.assistBagItemTable, compareBagItemInfo)
    table.insert(self.assistItemInfoTable, compareItemInfo)
end
--endregion

--region 外部调用
---获取副面板显示内容
---@return Table<bagV2.BagItemInfo>,Table<TABLE.CFG_ITEMS>
function AssistDataManager:GetAssistData(commonData)
    self.type = commonData.type
    self.bagItemInfo = commonData.bagItemInfo
    self.itemInfo = commonData.itemInfo
    self.assistBagItemTable = {}
    self.assistItemInfoTable = {}
    if self.type == LuaEnumItemInfoPanelItemType.RoleEquip or self.type == LuaEnumItemInfoPanelItemType.DoubleMedal then
        self:GetAssistData_RoleEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_Egg then
        self:GetAssistData_ServantEgg(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_Equip or self.type == LuaEnumItemInfoPanelItemType.Servant_BodyEquip then
        self:GetAssistData_ServantEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.Servant_BodyCommon then
        self:GetAssistData_ServantCommonBody(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.MagicEquip then
        self:GetAssistData_MagicEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.DivineEquip then
        self:GetCompareData_DivineEquip(self.bagItemInfo, self.itemInfo)
    elseif self.type == LuaEnumItemInfoPanelItemType.ZhengFaEquip then
        self:GetCompareData_ZhengFaEquip(self.bagItemInfo, self.itemInfo)
    end
    if self.assistItemInfoTable == nil or #self.assistItemInfoTable == 0 then
        return
    end
    return self.assistBagItemTable, self.assistItemInfoTable
end
--endregion
return AssistDataManager