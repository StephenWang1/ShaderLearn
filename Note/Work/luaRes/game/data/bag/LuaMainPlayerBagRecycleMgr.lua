---@class LuaMainPlayerBagRecycleMgr:luaobject 背包回收数据管理
local LuaMainPlayerBagRecycleMgr = {}

---@return CSMainPlayerInfo
function LuaMainPlayerBagRecycleMgr:GetCSMainPlayerInfo()
    if self.csMainPlayerInfo == nil then
        self.csMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.csMainPlayerInfo
end

---@return CSBagInfoV2
function LuaMainPlayerBagRecycleMgr:GetCSBagInfo()
    if self.mCSBagInfo == nil then
        local mainPlayerInfo = self:GetCSMainPlayerInfo()
        self.mCSBagInfo = mainPlayerInfo.BagInfo
    end
    return self.mCSBagInfo
end

---@return TABLE.cfg_items 缓存表数据
function LuaMainPlayerBagRecycleMgr:CacheItemInfo(id)
    if id == nil then
        return
    end
    return clientTableManager.cfg_itemsManager:TryGetValue(id)
end

---@return TABLE.cfg_recover 缓存Recover表数据
function LuaMainPlayerBagRecycleMgr:CacheRecoverInfo(id)
    if id == nil then
        return
    end
    return clientTableManager.cfg_recoverManager:TryGetValue(id)
end


--region 回收装备默认回收状态列表
---@type table<lid,boolean>
LuaMainPlayerBagRecycleMgr.RecycleItemDefaultStateDic = nil

---添加回收物品默认回收状态
---@param lid number
function LuaMainPlayerBagRecycleMgr:AddRecycleItemDefaultState(lid, state)
    if self.RecycleItemDefaultStateDic == nil then
        self.RecycleItemDefaultStateDic = {}
    end
    --[[    if self:IsContainRecycleDefaultItem(lid) then
            return
        end]]
    self.RecycleItemDefaultStateDic[lid] = state
end

---获取回收物品默认回收状态
---@param lid number
---@return boolean
function LuaMainPlayerBagRecycleMgr:GetRecycleItemDefaultState(lid)
    if self.RecycleItemDefaultStateDic == nil then
        self.RecycleItemDefaultStateDic = {}
    end
    return self.RecycleItemDefaultStateDic[lid]
end

---是否以存储了回收物品
---@param lid number
---@return boolean
function LuaMainPlayerBagRecycleMgr:IsContainRecycleDefaultItem(lid)
    local state = self:GetRecycleItemDefaultState(lid)
    return state ~= nil
end

---清理回收物品默认状态
function LuaMainPlayerBagRecycleMgr:ClearRecycleItemDefaultStateDic()
    self.RecycleItemDefaultStateDic = {}
end
--endregion

--region 回收方法
---根据选中的页签判断道具是否需要选中
---@param bagItemInfo bagV2.BagItemInfo
function LuaMainPlayerBagRecycleMgr:IsBelongToToggle(bagItemInfo, optionCoverId)
    if bagItemInfo == nil then
        return false
    end
    local itemInfo = self:CacheItemInfo(bagItemInfo.itemId)
    if itemInfo == nil then
        return false
    end

    local coverId = itemInfo:GetRecoverType()
    if coverId == nil then
        return false
    end
    return optionCoverId == coverId
end

---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 判断单个道具是否需要选中
function LuaMainPlayerBagRecycleMgr:SelectRecommendItem(bagItemInfo)
    if bagItemInfo == nil then
        return false
    end
    local itemInfo = self:CacheItemInfo(bagItemInfo.itemId)
    if itemInfo == nil then
        return false
    end

    local coverId = itemInfo:GetRecoverType()
    if coverId == nil then
        return false
    end
    local recoverTbl = self:CacheRecoverInfo(coverId)
    if recoverTbl == nil then
        return false
    end
    local extCondition = recoverTbl:GetRecoverCondition()
    if extCondition then
        if extCondition == LuaEnumRecycleItemType.Equip then
            local level = self:SelectByUseLevelAndBetterThanEquip(bagItemInfo, 1, 999)
            local reinLevel = self:SelectByReinLevelAndBetterThanEquip(bagItemInfo, 1, 999)
            return level or reinLevel
        elseif extCondition == LuaEnumRecycleItemType.Gem then
            return self:SelectByBetterGem(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.Servant then
            return self:SelectServant(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.ServantBody then
            return self:SelectServantBody(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.ServantEquip then
            return self:SelectServantEquip(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.GodStone then
            return self:SelectLowLevelGodStone(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.Element then
            return self:SelectLowQualityElement(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.Signet then
            return self:SelectLowQualitySignet(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.Material then
            return self:SelectPartOfMaterial(bagItemInfo, 1, 999)
        elseif extCondition == LuaEnumRecycleItemType.Drug then
            return self:SelectLowQualityDrug(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.Collections then
            return self:SelectRecommendedCollections(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.XianZhuang then
            return self:SelectRecommendedXianZhuang(bagItemInfo)
        elseif extCondition == LuaEnumRecycleItemType.SkillBook then
            return self:SelectBySkillBookType(bagItemInfo)
        end
    end
    return true
end

---根据装备使用等级选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number
---@param maxLevel number
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectByUseLevel(bagItemInfo, minLevel, maxLevel)
    local itemInfo = bagItemInfo.ItemTABLE

    if clientTableManager.cfg_itemsManager:IsXianZhuangEquip(bagItemInfo.itemId) then
        return false
    end

    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo, itemInfo)
            and itemInfo.type == luaEnumItemType.Equip and CS.CSScene.MainPlayerInfo.EquipInfo:IsEquipSubTypeDefined(itemInfo.subType)
            and not CS.CSScene.MainPlayerInfo.EquipInfo:IsGem(itemInfo) then
        ---不考虑转生等级
        if bagItemInfo.ItemTABLE.reinLv >= 1 then
            return nil
        end
        return bagItemInfo.ItemTABLE.useLv >= minLevel and bagItemInfo.ItemTABLE.useLv <= maxLevel
    end
    return false
end

---是否可以被回收
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:IsCanBeRecycled(bagItemInfo)
    return true
end

---根据是否优于身上装备的物品选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectByBetterThanEquipedItem(bagItemInfo)
    local itemInfo = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and itemInfo.type == luaEnumItemType.Equip and CS.CSScene.MainPlayerInfo.EquipInfo:IsEquipSubTypeDefined(itemInfo.subType) then
        if self:GetCSMainPlayerInfo().EquipInfo ~= nil then
            return self:GetCSMainPlayerInfo().EquipInfo:IsBetterThanEquip(bagItemInfo, true)
        end
    end
    return false
end

---根据使用等级和弱与身上装备选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number
---@param maxLevel number
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectByUseLevelAndBetterThanEquip(bagItemInfo, minLevel, maxLevel)
    if self:SelectByUseLevel(bagItemInfo, minLevel, maxLevel) then
        return Utility.IsRecommendItem(bagItemInfo)
    end
    return false
end

---根据技能书职业类型和技能是否满级进行选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectBySkillBookType(bagItemInfo)
    if self:SelectBySkillBook(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---根据技能书选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectBySkillBook(bagItemInfo)
    local itemtbl = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and itemtbl.type == luaEnumItemType.SkillBook then
        return true
    end
    return false
end

---根据转生等级选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minReinLevel number
---@param maxReinLevel number
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectByReinLevelAndBetterThanEquip(bagItemInfo, minReinLevel, maxReinLevel)
    if self:SelectByReinLevel(bagItemInfo, minReinLevel, maxReinLevel) then
        return Utility.IsRecommendItem(bagItemInfo)
    end
end

---根据转生等级选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minReinLevel number
---@param maxReinLevel number
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectByReinLevel(bagItemInfo, minReinLevel, maxReinLevel)
    local itemtbl = bagItemInfo.ItemTABLE

    if clientTableManager.cfg_itemsManager:IsXianZhuangEquip(bagItemInfo.itemId) then
        return false
    end

    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and itemtbl.type == luaEnumItemType.Equip and CS.CSScene.MainPlayerInfo.EquipInfo:IsEquipSubTypeDefined(itemtbl.subType)
            and not CS.CSScene.MainPlayerInfo.EquipInfo:IsGem(itemtbl) then
        if self:GetCSMainPlayerInfo().EquipInfo:IsEquipSubTypeDefined(itemtbl.subType) and not self:GetCSMainPlayerInfo().EquipInfo:IsGem(itemtbl) then
            return itemtbl.reinLv >= minReinLevel and itemtbl.reinLv <= maxReinLevel
        end
    end
    return false
end

---根据更好宝物选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
function LuaMainPlayerBagRecycleMgr:SelectByBetterGem(bagItemInfo)
    if self:SelectGem(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---根据宝物类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectGem(bagItemInfo)
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo) then
        return self:GetCSMainPlayerInfo().EquipInfo:IsGem(bagItemInfo.ItemTABLE)
    end
end

---根据灵兽与当前佩戴的灵兽对比选择
function LuaMainPlayerBagRecycleMgr:SelectServant(bagItemInfo)
    if self:SelectServantRelated(bagItemInfo) then
        ---灵兽蛋
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---根据是否是灵兽类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectServantRelated(bagItemInfo)
    local servantInfo = self:GetCSMainPlayerInfo().ServantInfoV2
    local itemInfo = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and (itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 8) then
        return true
    end
    return false
end

---根据灵兽肉身与当前佩戴的灵兽肉身对比选择
function LuaMainPlayerBagRecycleMgr:SelectServantBody(bagItemInfo)
    if self:SelectServantBodyRelated(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---根据灵兽装备与当前佩戴的灵兽装备对比选择
function LuaMainPlayerBagRecycleMgr:SelectServantEquip(bagItemInfo)
    if self:SelectServantEquipRelated(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---根据是否是灵兽肉身类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectServantBodyRelated(bagItemInfo)
    local servantInfo = self:GetCSMainPlayerInfo().ServantInfoV2
    local itemInfo = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and CS.CSServantInfoV2.IsServantBody(itemInfo) then
        return true
    end
    return false
end

---根据是否是灵兽装备类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectServantEquipRelated(bagItemInfo)
    local servantInfo = self:GetCSMainPlayerInfo().ServantInfoV2
    local itemInfo = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and CS.CSServantInfoV2.IsServantJustEquip(itemInfo) then
        return true
    end
    return false
end

---选择低等级神石
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectLowLevelGodStone(bagItemInfo)
    if self:SelectGodStone(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---仅选择元素类型
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectElement(bagItemInfo)
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and bagItemInfo.ItemTABLE.type == luaEnumItemType.Element then
        return true
    end
    return false
end

---选择低等级元素
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectLowQualityElement(bagItemInfo)
    if self:SelectElement(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---仅选择神石类型
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectGodStone(bagItemInfo)
    local itemInfo = bagItemInfo.ItemTABLE;
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and itemInfo.type == luaEnumItemType.Material and itemInfo.subType == 7 then
        return true
    end
    return false
end

---选择低等级元素
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectLowQualityElement(bagItemInfo)
    if self:SelectElement(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---选择印记
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectSignet(bagItemInfo)
    local itemInfo = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and itemInfo.type == luaEnumItemType.Signet then
        return true
    end
    return false
end

---选择低等级印记
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectLowQualitySignet(bagItemInfo)
    if self:SelectSignet(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---根据任务材料选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number 最小使用等级
---@param maxLevel number 最大使用等级
---@return boolean 是否选择该物品
function LuaMainPlayerBagRecycleMgr:SelectTaskMaterial(bagItemInfo, minLevel, maxLevel)
    local itemInfo = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and (itemInfo.type == luaEnumItemType.Material or (itemInfo.type == luaEnumItemType.Assist and itemInfo.subType ~= 8))
            and CS.Cfg_GlobalTableManager.Instance:MaterialNeeedShildRecycleItem(itemInfo.type, itemInfo.subType) == false then
        return itemInfo.useLv <= maxLevel and itemInfo.useLv >= minLevel
    end
    return false
end

---选择一部分材料
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number 最小使用等级
---@param maxLevel number 最大使用等级
---@return boolean 是否选择该物品
function LuaMainPlayerBagRecycleMgr:SelectPartOfMaterial(bagItemInfo, minLevel, maxLevel)
    if self:SelectTaskMaterial(bagItemInfo, minLevel, maxLevel) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---选择药品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectDrug(bagItemInfo)
    local itemInfo = bagItemInfo.ItemTABLE
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
            and itemInfo.type == luaEnumItemType.Drug then
        return true
    end
    return false
end

---选择配置默认选择药品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectLowQualityDrug(bagItemInfo)
    if self:SelectDrug(bagItemInfo) then
        return self:GetCSBagInfo():IsRecommendRecycleItem(bagItemInfo, true)
    end
    return false
end

---选择值得回收的藏品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectRecommendedCollections(bagItemInfo)
    if bagItemInfo ~= nil and bagItemInfo.ItemTABLE ~= nil and bagItemInfo.ItemTABLE.type == luaEnumItemType.Collection then
        if gameMgr:GetPlayerDataMgr() ~= nil then
            local collectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
            local itemInCabinet = collectionInfo:GetCollectionItemByCollectionID(bagItemInfo.itemId)
            if itemInCabinet ~= nil and Utility.GetArrowType(bagItemInfo) ~= LuaEnumArrowType.GreenArrow then
                ---如果藏品阁中有相同藏品且箭头不为绿色,则勾选之
                return true
            end
        end
    end
    return false
end

---选择藏品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectCollections(bagItemInfo)
    if bagItemInfo ~= nil and bagItemInfo.ItemTABLE ~= nil and bagItemInfo.ItemTABLE.type == luaEnumItemType.Collection then
        return true
    end
    return false
end

---选择推荐回收仙装
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectRecommendedXianZhuang(bagItemInfo)
    if bagItemInfo == nil then
        return false
    end
    local dataManager = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
    local equipListData = dataManager:GetEquipmentList(LuaEquipmentListType.Base)
    if equipListData == nil then
        return false
    end

    local equipIndex = Utility.GetEquipIndexByItemId(bagItemInfo.itemId)
    if #equipIndex > 0 then
        --跟身上比
        --[[        for i = 1, #equipIndex do
                    local singleIndex = equipIndex[i]
                    local playerEquip = equipListData:GetEquipItem(singleIndex)
                    if playerEquip and playerEquip.BagItemInfo then
                        local isBetter = Utility.GetArrowType(bagItemInfo) ~= LuaEnumArrowType.NONE
                        if isBetter then
                            return false
                        end
                    else
                        return false
                    end
                end]]
        local csBagItemInfo = (type(bagItemInfo) == 'table')
                and protobufMgr.DecodeTable.bag.BagItemInfo(bagItemInfo)
                or bagItemInfo
        local isBetter = Utility.GetArrowType(bagItemInfo) ~= LuaEnumArrowType.NONE
        if isBetter then
            return false
        end

        --跟身上仙装比
        for j = 1, #equipIndex do
            local xianzhuangIndex = equipIndex[j]
            local equip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSingleTypeEquipByEquipIndex_All(LuaEnumSoulEquipType.XianZhuang, xianzhuangIndex)
            if equip then
                local bagLuaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
                for i, v in pairs(equip) do
                    local equipLuaItemInfo = v.cfg_items
                    if bagLuaItemInfo == nil or equipLuaItemInfo == nil then
                        return false
                    end
                    if bagLuaItemInfo:GetGroup() > equipLuaItemInfo:GetGroup() then
                        return false
                    end
                end
            else
                return false
            end
        end
    end
    return true
end

---选择仙装
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerBagRecycleMgr:SelectAllXianZhuang(bagItemInfo)
    if bagItemInfo ~= nil and bagItemInfo.ItemTABLE ~= nil and bagItemInfo.ItemTABLE.type == luaEnumItemType.Equip then
        return clientTableManager.cfg_itemsManager:IsXianZhuangEquip(bagItemInfo.itemId)
    end
    return false
end

---@param recover TABLE.cfg_recover
function LuaMainPlayerBagRecycleMgr:IsMainPlayerMatchAllRecoverCondition(recover)
    if recover:GetShowCondition() then
        local conditionList = recover:GetShowCondition().list
        for i = 1, #conditionList do
            local condition = conditionList[i]
            local result = Utility.IsMainPlayerMatchCondition_LuaAndCS(condition)
            if result == nil or result.success == false then
                return false
            end
        end
    end
    return true
end
--endregion

--region 自动回收
function LuaMainPlayerBagRecycleMgr:AutoRecycle()
    self.mNeedRecycle = true
end

---延迟回收
function LuaMainPlayerBagRecycleMgr:LateRecycle()
    local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
    local state = configInfo:GetInt(CS.EConfigOption.AutoRecycle) == 1
    if state == false then
        return
    end

    local currentBagGridNum = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetEmptyGridCount()
    local autoRecycleLimit = LuaGlobalTableDeal:GetAutoRecycleBagGridNum()
    if autoRecycleLimit == nil or currentBagGridNum > autoRecycleLimit then
        return
    end

    ---@type table<number,bagV2.BagItemInfo>
    local needRecycleItemList = {}
    local bagItemList = self:GetCSBagInfo():GetBagItemList()
    for i = 1, bagItemList.Count - 1 do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = bagItemList[i]
        if self:IsBagItemNeedRecycle(bagItemInfo) then
            table.insert(needRecycleItemList, bagItemInfo)
        end
    end
    if #needRecycleItemList > 0 then
        local recycleList = CS.System.Collections.Generic["List`1[System.Int64]"]()
        for i = 1, #needRecycleItemList do
            recycleList:Add(needRecycleItemList[i].lid)
        end
        networkRequest.ReqRecycleEquipment(recycleList, 0)
    end
end

function LuaMainPlayerBagRecycleMgr:UpdateRecycle()
    if self.mNeedRecycle then
        self:LateRecycle()
        self.mNeedRecycle = false
    end
end

---@return boolean 是否需要回收该道具
function LuaMainPlayerBagRecycleMgr:IsBagItemNeedRecycle(bagItemInfo)
    if bagItemInfo == nil then
        return false
    end
    local itemInfo = self:CacheItemInfo(bagItemInfo.itemId)
    if itemInfo == nil then
        return false
    end
    local coverId = itemInfo:GetRecoverType()
    local coverInfo = self:CacheRecoverInfo(coverId)
    if coverInfo == nil then
        return false
    end
    local isConditionFull = self:IsMainPlayerMatchAllRecoverCondition(coverInfo)
    if isConditionFull == false then
        return false
    end
    local state = gameMgr:GetPlayerDataMgr():GetConfigManager():GetBagRecycleData():GetRecoverState(coverId)
    if state == false then
        return false
    end
    if (gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)) then
        return false
    end
    return self:SelectRecommendItem(bagItemInfo)
end

---@return boolean 是否有限时回收buff
function LuaMainPlayerBagRecycleMgr:GetTimeLimitRecycleBuff()
    return self.mHasTimeLimitRecycleBuff
end

---@return boolean 设置显示回收buff
function LuaMainPlayerBagRecycleMgr:SetTimeLimitRecycleBuff(state)
    self.mHasTimeLimitRecycleBuff = state
end
--endregion

--region 回收收益
---获取回收收益数据管理类
---@return LuaMainPlayerRecycleEarningMgr
function LuaMainPlayerBagRecycleMgr:GetRecycleEarningMgr()
    if self.mRecycleEarningMgr == nil then
        self.mRecycleEarningMgr = luaclass.LuaMainPlayerRecycleEarningMgr:New()
    end
    return self.mRecycleEarningMgr
end
--endregion

return LuaMainPlayerBagRecycleMgr