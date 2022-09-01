---玩家的装备数据管理类,用来管理Lua内的装备数据(PS:同步C#数据) gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
---@class LuaMainPlayerEquipMgr:luaobject
local LuaMainPlayerEquipMgr = {}

---@type table<LuaEquipmentListType, LuaPlayerEquipmentListData>
LuaMainPlayerEquipMgr.EquipmentListDic = {}

---@type table<LuaEnumMagicEquipSuitType, LuaMagicEquipmentListData>
LuaMainPlayerEquipMgr.MagicEquipmentListDic = nil

---@type table<LuaEnumGemEquipType,LuaGemEquipmentListData>
LuaMainPlayerEquipMgr.GemEquipmentListDic = nil

---@type table<number:道具的唯一ID,bagV2.BagItemInfo>
LuaMainPlayerEquipMgr.ItemListDic = nil

---@type table<number, boolean> 装备格子的当前解锁/未解锁状态,一般用于需要解锁的格子,不用于正常格子
LuaMainPlayerEquipMgr.UnlockedEquipIndexs = nil

function LuaMainPlayerEquipMgr:Init()
    self.UnlockedEquipIndexs = {}
    self:InitRedData();
end

--region 接受到服务器的消息后的处理

---服务器告知所有装备数据(目前只有列表1(普通装备的数据))
---@param tblData equipV2.ResAllEquip lua table类型消息数据
function LuaMainPlayerEquipMgr:OnAllEquipMessageReceived(tblData)
    if (tblData == nil or tblData.equipList == nil) then
        return ;
    end
    self.ItemListDicCache = nil
    self.EquipmentListDic = {}
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():CleanBloodSuitDic()
    ---循环人物身上的所有装备
    self.UnlockedEquipIndexs = {}
    for k, equip in pairs(tblData.equipList) do
        ---@type equipV2.EquipsChange
        local equipsChange = equip
        self.UnlockedEquipIndexs[equipsChange.equipIndex] = true
        if (equipsChange.changeEquip ~= nil) then
            equipsChange.changeEquip.index = equipsChange.equipIndex;
        end
        self:SetEquipItem(equipsChange.changeEquip, equipsChange.equipIndex)
    end
end

---装备信息更新
---@param tblData equipV2.ResEquipChange lua table类型消息数据
function LuaMainPlayerEquipMgr:OnEquipChangeMessageReceived(tblData)
    if (tblData.equipChange ~= nil and Utility.GetLuaTableCount(tblData.equipChange) ~= 0) then
        for i, item in pairs(tblData.equipChange) do
            ---@type equipV2.EquipsChange
            local equipsChange = item
            self.UnlockedEquipIndexs[item.equipIndex] = true
            if (equipsChange.changeEquip ~= nil) then
                equipsChange.changeEquip.index = equipsChange.equipIndex;
            end
            ---@type bagV2.BagItemInfo
            local equip = equipsChange.changeEquip

            self:SetEquipItem(equip, equipsChange.equipIndex)
        end
    else
        ---貌似如果为空的话,需要清理到整个清单
        --local EquipmentList = self:GetEquipmentList(LuaEquipmentListType.Base)
        --EquipmentList:Clear();
    end
end

---返回修理装备
---@param tblData equipV2.ResRepairEquip lua table类型消息数据
function LuaMainPlayerEquipMgr:OnResRepairEquipMessage(tblData)
    if tblData and tblData.bodyEquips and Utility.GetLuaTableCount(tblData.bodyEquips) > 0 then
        for i = 1, #tblData.bodyEquips do
            local equip = tblData.bodyEquips[i]
            if equip then
                self:SetEquipItem(equip, equip.index)
            end
        end
    end
end

---返回修理灵兽肉身装备
---@param tblData equipV2.ResRepairServantEquip lua table类型消息数据
function LuaMainPlayerEquipMgr:OnResRepairServantEquipMessage(tblData)

end

---装备炼制响应
---@param tblData equipV2.ResRepairServantEquip lua table类型消息数据
function LuaMainPlayerEquipMgr:OnResEquipRefineMessage(tblData)

end

---背包变动
---@param tblData bagV2.ResBagChange lua table类型消息数据
function LuaMainPlayerEquipMgr:RespondBagChange(tblData)
    self:CallRedPointAll(tblData)
end

---刷新鉴定信息
---@param tblData equipV2.ResAppraisaResult lua table类型消息数据
function LuaMainPlayerEquipMgr:RefreshJianDingData(tblData)
    if tblData.appraisaEquip == nil then
        return
    end
    self:SetEquipItem(tblData.appraisaEquip, tblData.appraisaEquip.index)
end
--endregion

---刷新投保
---@param tblData roleV2.ResInsuredSucces lua table类型消息数据
function LuaMainPlayerEquipMgr:RefreshInsureData(tblData)
    if tblData.theEquip == nil then
        return
    end
    self:SetEquipItem(tblData.theEquip, tblData.index)
end
--endregion

---耐久变动
---@param lidInfo bagV2.LastingUpdate
function LuaMainPlayerEquipMgr:RefreshSingleEquipLasting(lidInfo)
    local lidList = lidInfo.itemId
    if self.ItemListDic then
        for i = 1, #lidList do
            local lid = lidList[i]
            ---@type bagV2.BagItemInfo
            local bagItemInfo = self.ItemListDic[lid]
            if bagItemInfo then
                local lasting = bagItemInfo.currentLasting - 1
                bagItemInfo.currentLasting = math.max(-10, lasting)
                self:SetEquipItem(bagItemInfo, bagItemInfo.index)
            end
        end
    end
end

---升星变动
---@type bagV2.ResIntensify
function LuaMainPlayerEquipMgr:OnResIntensifyChange(tblData)
    if tblData == nil or tblData.equipInfo == nil or tblData.equipId == nil then
        return
    end
    self:SetEquipItem(tblData.equipInfo, tblData.equipInfo.index)
end

--region 红点相关

---合成相关的

function LuaMainPlayerEquipMgr:InitRedData()
end

---刷新所有红点
---@param tblData bagV2.ResBagChange lua table类型消息数据
function LuaMainPlayerEquipMgr:CallRedPointAll(tblData)
    self:CallRedPointKey_ForgeGodPowerSmelt(tblData)
end

--region 神炼的合成红点
---神炼红点的状态
LuaMainPlayerEquipMgr.IsShowForgeGodPowerSmeltRedState = nil
---神炼红点的列表
LuaMainPlayerEquipMgr.IsShowForgeGodPowerSmeltRedList = nil
---触发神炼红点的装备位
LuaMainPlayerEquipMgr.IsShowForgeGodPowerSmeltRedEquipIndex = nil
---是否显示红点
function LuaMainPlayerEquipMgr:IsShowForgeGodPowerSmeltRed()
    if (self.IsShowForgeGodPowerSmeltRedState == nil) then
        self:InitShowForgeGodPowerSmeltRed()
    end

    return self.IsShowForgeGodPowerSmeltRedState
end

---第一次需要去检索背包里面的所有东西
function LuaMainPlayerEquipMgr:InitShowForgeGodPowerSmeltRed()
    self.IsShowForgeGodPowerSmeltRedEquipIndex = 0
    self.IsShowForgeGodPowerSmeltRedList = {}
    ---@type LuaMainPlayerBagMgr
    local bagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    self.IsShowForgeGodPowerSmeltRedState = false
    for i, v in pairs(bagMgr:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        local influence, equipIndexList = self:IsInfluenceForgeGodPowerSmelt(v)
        if (influence) then
            for i, equipIndex in pairs(equipIndexList) do
                if (self.IsShowForgeGodPowerSmeltRedState == false or self.IsShowForgeGodPowerSmeltRedEquipIndex > equipIndex) then
                    --首个影响的红点为默认的
                    self.IsShowForgeGodPowerSmeltRedEquipIndex = equipIndex
                    self.IsShowForgeGodPowerSmeltRedState = true
                end
                table.insert(self.IsShowForgeGodPowerSmeltRedList, equipIndex)
            end
        end
    end
    if (self.IsShowForgeGodPowerSmeltRedState == true) then
        return
    end

    self.IsShowForgeGodPowerSmeltRedEquipIndex = nil
    self.IsShowForgeGodPowerSmeltRedState = false
end

---刷新神炼的合成红点
---@param tblData bagV2.ResBagChange lua table类型消息数据
function LuaMainPlayerEquipMgr:CallRedPointKey_ForgeGodPowerSmelt(tblData)
    if (tblData == nil) then
        return
    end
    local getItems = tblData.itemList
    local isInfluence = false
    if (getItems ~= nil) then
        for i, v in pairs(getItems) do
            if (self:CallRedPointKey_ForgeGodPowerSmeltItem(v)) then
                return ;
            end
        end
    end
    if (isInfluence == false and tblData.removeItemList) then
        for i, v in pairs(tblData.removeItemList) do
            if (self:CallRedPointKey_ForgeGodPowerSmeltItem(v)) then
                return ;
            end
        end
    end
end

---@param bagItemInfo bagV2.BagItemInfo
function LuaMainPlayerEquipMgr:CallRedPointKey_ForgeGodPowerSmeltItem(bagItemInfo)
    if (bagItemInfo == nil) then
        return
    end
    local influence, equipIndex = self:IsInfluenceForgeGodPowerSmelt(bagItemInfo)

    if (influence) then
        self:InitShowForgeGodPowerSmeltRed()
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ForgeGodPowerSmelt_All));
    end
    return influence
end

---这个道具是否会影响神炼的红点(不要随便去循环装备位,然后再判定)
---@param bagItemInfo bagV2.BagItemInfo
function LuaMainPlayerEquipMgr:IsInfluenceForgeGodPowerSmelt(bagItemInfo)
    if (bagItemInfo == nil) then
        return false
    end
    ---@type TABLE.cfg_items
    local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    local divineSuitTbl = Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo)
    if (itemTbl == nil or divineSuitTbl == nil) then
        return false
    end

    if (self.InfluenceForgeGodPowerSmeltDivineSuit == nil) then
        self.InfluenceForgeGodPowerSmeltDivineSuit = {}
    end

    local fabaoIndex = Utility.GetSLEquipIndex(divineSuitTbl:GetType(), LuaEquipmentItemType.POS_SL_FABAO)
    local list = {}
    local fbCache = self.InfluenceForgeGodPowerSmeltDivineSuit[fabaoIndex]
    if (fbCache) then
        ---@type table<number> 所有道具都会影响法宝
        local costDivineIdList = self.InfluenceForgeGodPowerSmeltDivineSuit[fabaoIndex].divineSuitIDList
        if (costDivineIdList ~= nil) then
            for i, v in pairs(costDivineIdList) do
                if (itemTbl:GetDivineId() == v) then
                    table.insert(list, fabaoIndex);
                    break
                end
            end
        end
    end
    ---法宝道具在上面以及直接判定过了  后续不用重复判定
    if (itemTbl:GetSubType() ~= LuaEquipmentItemType.POS_SL_FABAO) then
        local equipIndex = Utility.GetSLEquipIndex(divineSuitTbl:GetType(), itemTbl:GetSubType())
        local cache = self.InfluenceForgeGodPowerSmeltDivineSuit[equipIndex]

        if (cache == nil) then
            if (#list > 0) then
                return true, list
            end
            return false
        end

        local type = divineSuitTbl:GetType()
        ---如果不是法宝,那么需要先去判定是否满足法宝条件
        ---@type LuaEquipDataItem
        local fbItem = self:GetEquipmentList(type, divineSuitTbl:GetSubType()):GetEquipItem(fabaoIndex)
        if (fbItem == nil or fbItem.BagItemInfo == nil or Utility.GetDivineSuitTblByBagItemInfo(fbItem.BagItemInfo):GetLevel() < cache.needFBLevel) then

            if (#list > 0) then
                return true, list
            end
            return false
        end

        ---@type table<number> 可以影响这个装备位套装类型
        local costDivineIdList = cache.divineSuitIDList
        if (costDivineIdList ~= nil) then
            for i, v in pairs(costDivineIdList) do
                if (itemTbl:GetDivineId() == v) then
                    table.insert(list, equipIndex);
                    break
                end
            end
        end
        ---左手戒指或者右手戒指需要额外判定下
        if (itemTbl:GetSubType() == LuaEquipmentItemType.POS_SL_LEFT_RING or itemTbl:GetSubType() == LuaEquipmentItemType.POS_SL_LEFT_HAND) then
            equipIndex = Utility.GetSLEquipIndex(divineSuitTbl:GetType(), itemTbl:GetSubType(), true)
            ---@type table<number> 可以影响这个装备位套装类型
            local costDivineIdList = cache.divineSuitIDList
            if (costDivineIdList ~= nil) then
                for i, v in pairs(costDivineIdList) do
                    if (itemTbl:GetDivineId() == v) then
                        table.insert(list, equipIndex);
                        break
                    end
                end
            end
        end
    end

    if (#list > 0) then
        return true, list
    end

    return false
end

---@class InfluenceForgeGodPowerSmeltDivineSuitResult
---@field needFBLevel number
---@field divineSuitIDList table<number>lua的类型这里存放可以影响这个装备位套装类型>

---影响神炼红点的神力套装
---@type table<InfluenceForgeGodPowerSmeltDivineSuitResult>
LuaMainPlayerEquipMgr.InfluenceForgeGodPowerSmeltDivineSuit = nil

---设置会影响神力红点刷新的条件
---@param isAdd boolean 是否为添加条件
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function LuaMainPlayerEquipMgr:SetInfluenceForgeGodPowerSmeltReason(isAdd, index, bagItemInfo)
    if (bagItemInfo == nil) then
        return ;
    end
    ---@type TABLE.cfg_divinesuit
    local divineSuit = Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo)
    if (divineSuit == nil or divineSuit:GetLevel() >= 5) then
        --5级以上不能继续合成了
        return
    end
    if (self.InfluenceForgeGodPowerSmeltDivineSuit == nil) then
        self.InfluenceForgeGodPowerSmeltDivineSuit = {}
    end
    if (isAdd) then
        ---@type TABLE.cfg_divinelevelup
        local divinelevelup = Utility.GetDivineLevelUpTblByBagItemInfo(bagItemInfo)
        if (divinelevelup ~= nil and divinelevelup:GetCostDivineId() ~= nil) then
            --在这个装备位上,有一个装备会影响红点
            self.InfluenceForgeGodPowerSmeltDivineSuit[index] = {}
            self.InfluenceForgeGodPowerSmeltDivineSuit[index].needFBLevel = Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo):GetLevel() + 1
            self.InfluenceForgeGodPowerSmeltDivineSuit[index].divineSuitIDList = divinelevelup:GetCostDivineId().list
        end
    else
        self.InfluenceForgeGodPowerSmeltDivineSuit[index] = nil
    end

    self:InitShowForgeGodPowerSmeltRed()
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ForgeGodPowerSmelt_All));
end
--endregion

--endregion

---是否比身上的装备更好
---@param bagItemInfo bagV2.BagItemInfo lua的是数据结构
function LuaMainPlayerEquipMgr:IsBetterEquipThanEquipped(bagItemInfo)
    if (bagItemInfo == nil) then
        return false
    end
    ---@type TABLE.cfg_items
    local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo);
    local divineId = itemTbl:GetDivineId()
    local type = 0
    local subType = 1
    if (divineId ~= nil and divineId ~= 0) then
        --神力装备
        local SuitTbl = Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo)
        if (SuitTbl ~= nil) then
            type = SuitTbl:GetType();
            subType = SuitTbl:GetSubType()
        end
    end
    ---@type LuaPlayerEquipmentListData
    local PlayerEquipmentListData = self:GetEquipmentList(type, subType);
    local index = self:GetSLEquipIndex(type, itemTbl:GetSubType())
    ---@type LuaEquipDataItem
    local EquipDataItem = PlayerEquipmentListData:GetEquipItem(index)

    if (EquipDataItem.BagItemInfo == nil) then
        return true
    end

    ---@type LuaMainPlayerBagMgr
    local MainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    local isNeedSecEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsNeedSec(bagItemInfo.ItemTABLE.id)
    local isBetter = MainPlayerBagMgr:ItemCompare(EquipDataItem.BagItemInfo, bagItemInfo)
    --如果是神力戒子或者手镯  需要额外判定下右手
    if isNeedSecEquip == false then
        if (isBetter == false and (itemTbl:GetSubType() == LuaEquipmentItemType.POS_SL_LEFT_HAND or itemTbl:GetSubType() == LuaEquipmentItemType.POS_SL_LEFT_RING)) then
            index = self:GetSLEquipIndex(type, itemTbl:GetSubType(), true)
            ---@type LuaEquipDataItem
            EquipDataItem = PlayerEquipmentListData:GetEquipItem(index)

            if (EquipDataItem == nil or EquipDataItem.BagItemInfo == nil) then
                return true
            end

            isBetter = MainPlayerBagMgr:ItemCompare(EquipDataItem.BagItemInfo, bagItemInfo)
        end
    end
    return isBetter
end

---装备位是否已解锁,仅限于需要解锁的装备位,不需要解锁的装备位不能调用该方法
---@param equipIndex number 装备位
---@return boolean
function LuaMainPlayerEquipMgr:IsEquipGridUnlocked(equipIndex)
    if equipIndex == nil then
        return false
    end
    if self.UnlockedEquipIndexs[equipIndex] == true then
        --print("Is Unlocked", equipIndex)
        return true
    else
        if math.floor(equipIndex / 100000) == 3 then
            ---如果是血继的话,考虑下表里面的解锁条件
            local bloodSuitLattice = clientTableManager.cfg_bloodsuit_latticeManager:TryGetValue(equipIndex)
            if bloodSuitLattice and bloodSuitLattice:GetCost() ~= nil
                    and bloodSuitLattice:GetCost().list ~= nil
                    and #bloodSuitLattice:GetCost().list > 0 and #bloodSuitLattice:GetCost().list[1].list >= 2 then
                ---如果解锁消耗不为空的话,则认为其未解锁
                --print("如果解锁消耗不为空的话,则认为其未解锁", equipIndex, "#bloodSuitLattice:GetCost().list", #bloodSuitLattice:GetCost().list)
                return false
            else
                ---如果解锁消耗为空的话,则认为其已解锁,向服务器发送一次解锁消息并返回true,即客户端认为该格子必定能够解锁且以已解锁的状态对待它
                if self.mRequestedUnlockIndexs == nil then
                    self.mRequestedUnlockIndexs = {}
                end
                if self.mRequestedUnlockIndexs[equipIndex] == nil then
                    self.mRequestedUnlockIndexs[equipIndex] = true
                    --print("request open blood suit grid", equipIndex)
                    networkRequest.ReqOpenBloodSuitGrid(equipIndex, 0)
                end
                --print("如果解锁消耗为空的话,则认为其已解锁")
                return true
            end
        else
            return false
        end
    end
end

---激活套装开启
function LuaMainPlayerEquipMgr:ActivateSuitType(type)
    self:GetEquipmentList(type):Activate()
end

--region 各种装备的装备位获取
---得到神力装备的装备位
---@param type number 神力的套装类型
---@param itemSubType number 道具表里面的SubType字段
---@param isRight boolean 是否为右手装备
function LuaMainPlayerEquipMgr:GetSLEquipIndex(type, itemSubType, isRight)
    return Utility.GetSLEquipIndex(type, itemSubType, isRight)
end

---是否为神力套装
---神力的的套装在100000-200000之间  一个套装列表赞占位1000个下标  10W个=100套
---@param index number 装备的下标
---@return LuaEquipmentListType 神力类型
function LuaMainPlayerEquipMgr:IsSLEquip(index)
    return utility.IsSLEquip(index)
end

---是否为血继套装（这个是静态方法）
---血继的的套装在300000-400000之间  一个套装列表赞占位100个下标  10W个=1000套
---@param index number 装备的下标
---@return LuaEquipBloodSuitType 血继类型
function LuaMainPlayerEquipMgr:IsXJEquip(index)
    return utility.IsXJEquip(index)
end

---获取到所有装备信息
---@return table<number,bagV2.BagItemInfo>
function LuaMainPlayerEquipMgr:GetAllEquipmentItemList()
    if (self.EquipmentListDic == nil) then
        return nil
    end
    local list = {}
    ---@param PlayerEquipmentListData LuaPlayerEquipmentListData
    for i, PlayerEquipmentListData in pairs(self.EquipmentListDic) do
        ---@type table<LuaEquipDataItem>
        local equipList = PlayerEquipmentListData:GetAllEquips()
        ---@param equip LuaEquipDataItem
        for j, equip in pairs(equipList) do
            if (equip ~= nil and equip.BagItemInfo ~= nil) then
                table.insert(list, equip.BagItemInfo)
            end
        end
    end
    return list
end

---获取到所有神力的列表
---@return table<LuaPlayerEquipmentListData>
function LuaMainPlayerEquipMgr:GetAllSLEquipmentList()
    if (self.EquipmentListDic == nil) then
        return nil
    end
    local list = {}

    for i, v in pairs(self.EquipmentListDic) do
        if (v.EquipmentListType ~= LuaEquipmentListType.Base) then
            if (v.IsActivate == true) then
                table.insert(list, v)
            end
        end
    end
    return list
end

---传入ItemId,返回对应的列表装备清单
---@param itemId number ItemId
---@return LuaPlayerEquipmentListData 指定类型的装备清单
function LuaMainPlayerEquipMgr:GetEquipmentListByItemId(itemId)
    ---@type  TABLE.cfg_divinesuit
    local suitTbl = Utility.GetDivineSuitTblByBagItemID(itemId)
    if (suitTbl ~= nil and suitTbl:GetType() ~= nil and suitTbl:GetType() > 0) then
        return self:GetEquipmentList(suitTbl:GetType(), suitTbl.GetSubType())
    end
end

---传入装备列表列表类型,返回对的列表装备清单
---@param type LuaEquipmentListType lua枚举,装备的列表类型
---@return LuaPlayerEquipmentListData 指定类型的装备清单
function LuaMainPlayerEquipMgr:GetEquipmentList(type, subType)
    if (self.EquipmentListDic[type] == nil) then
        self.EquipmentListDic[type] = luaclass.LuaPlayerEquipmentListData:New()
        self.EquipmentListDic[type]:InitDivineSuit(type, subType)
    elseif (self.EquipmentListDic[type]:GetAdditionDataList(subType) == nil) then
        self.EquipmentListDic[type]:RefreshDivineSuit(type, subType)
    end
    return self.EquipmentListDic[type]
end

---@param lid number
---@return bagV2.BagItemInfo
function LuaMainPlayerEquipMgr:GetEquipInfo(lid)
    if type(self.ItemListDic) ~= 'table' then
        return
    end
    for k, v in pairs(self.ItemListDic) do
        if (v.lid == lid) then
            return v;
        end
    end
    return nil;
end

---传入装备列表列表类型,返回对的列表装备清单
---@param type LuaEquipmentListType lua枚举,装备的列表类型
---@param index LuaEquipmentItemType 装备所在基础下标值
---@param full boolean 这个装备位是否为基础下标
---@return LuaEquipDataItem 指定类型的装备清单内指定道具
function LuaMainPlayerEquipMgr:GetEquipmentItem(type, index, full)
    local EquipmentList = self:GetEquipmentList(type)
    if (EquipmentList.EquipmentListType ~= LuaEquipmentListType.Base and (full == nil or full == false)) then
        index = self:GetSLEquipIndex(EquipmentList.EquipmentListType, index)
    end
    return EquipmentList:GetEquipItem(index)
end

---设置装备数据到指定列表清单中
---@type bagV2.BagItemInfo bagItemInfo 道具数据信息
function LuaMainPlayerEquipMgr:SetEquipItem(bagItemInfo, index)
    if (bagItemInfo == nil and index == nil) then
        return ;
    end
    if (bagItemInfo ~= nil and bagItemInfo.ItemTABLE == nil) then
        bagItemInfo.ItemTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    end
    if (index == nil and bagItemInfo ~= nil) then
        index = bagItemInfo.index
    end
    if Utility.IsXJEquip(index) ~= LuaEquipBloodSuitType.None then
        gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():RefreShBloodSuitDic(bagItemInfo, index)
    else
        ---@type TABLE.cfg_divinesuit
        local divineTbl = nil
        local subtype = 1
        if (bagItemInfo ~= nil and bagItemInfo.ItemTABLE ~= nil) then
            divineTbl = clientTableManager.cfg_divinesuitManager:TryGetValue(bagItemInfo.ItemTABLE:GetDivineId());
        end
        if (divineTbl ~= nil) then
            subtype = divineTbl:GetSubType()
        end

        local type = Utility.IsSLEquip(index, true)
        local EquipmentList = self:GetEquipmentList(type, subtype)

        --在设置装备数据之前,需要先获取到数据进行处理
        -----@type LuaEquipDataItem
        --local LuaEquipDataItem = EquipmentList:GetEquipItem(index)
        EquipmentList:SetEquipItem(index, bagItemInfo);

        self:ProcessEquipChange(false, index);

        self:ProcessEquipChange(true, index, bagItemInfo);
    end
end

---用来存在装备位对应的道具ID
---@type table<bagV2.BagItemInfo>
LuaMainPlayerEquipMgr.ItemListDicCache = {}

---装备的添加以及改变
---@param bagItemInfo bagV2.BagItemInfo
function LuaMainPlayerEquipMgr:ProcessEquipChange(isAdd, index, bagItemInfo)
    if (self.ItemListDic == nil) then
        self.ItemListDic = {}
    end
    if (self.ItemListDicCache == nil) then
        self.ItemListDicCache = {}
    end

    if (isAdd) then
        if (bagItemInfo ~= nil) then
            self.ItemListDic[bagItemInfo.lid] = bagItemInfo
            self.ItemListDicCache[index] = bagItemInfo
            if (bagItemInfo.itemId ~= nil) then
                gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint(nil, bagItemInfo.itemId)
            end
        end
    else
        if (self.ItemListDicCache[index] ~= nil) then
            local id = self.ItemListDicCache[index].itemId
            self.ItemListDic[self.ItemListDicCache[index].lid] = nil
            self.ItemListDicCache[index] = nil
            gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint(nil, id)
        end
    end
    self:SetInfluenceForgeGodPowerSmeltReason(isAdd, index, bagItemInfo)
    self:RefreshGemEquip(index, bagItemInfo)
    self:RefreshShieldAndHatEquip(index, bagItemInfo)

end

---得到已经开启的套装列表ID
---@return table<number>
function LuaMainPlayerEquipMgr:GetOpenedSuitList()
    local list = {}
    table.insert(list, 1)
    table.insert(list, 2)
    return list
end
--endregion

--region 法宝
--region 刷新
---刷新所有法宝装备数据
---@param tblData equipV2.AllMagicWeaponInfo 服务器所有法宝数据
function LuaMainPlayerEquipMgr:RefreshAllMagicEquipList(tblData)
    if tblData == nil or tblData.allInfo == nil or type(tblData) ~= 'table' then
        self.MagicEquipmentListDic = {}
        return
    end
    if self.MagicEquipmentListDic == nil then
        self.MagicEquipmentListDic = {}
    end
    for k, v in pairs(tblData.allInfo) do
        if v == nil or v.suitType == nil or v.magicWeapon == nil then
            return
        end
        ---@type LuaMagicEquipmentListData 法宝套装信息类
        local suitTableInfo = self:GetMagicEquipListBySuitType(v.suitType)
        if suitTableInfo == nil then
            return
        end
        suitTableInfo:RefreshEquipList(v)
    end
    luaEventManager.DoCallback(LuaCEvent.RefreshAllMagicEquip)

    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_All)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_XL)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_Power)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_Soul)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_SX)

end

---刷新单个法宝装备数据
---@param tblData equipV2.MagicWeapon 服务器单个法宝装备变动
function LuaMainPlayerEquipMgr:RefreshSingleMagicEquip(tblData)
    if tblData ~= nil and tblData.index ~= nil then
        local lastId = nil

        ---@type LuaEnumMagicEquipSuitType 法宝套装类型
        local suitType = clientTableManager.cfg_magicweaponManager:AnalysisTypeByEquipIndex(tblData.index)
        if suitType == nil or type(suitType) ~= 'number' or suitType <= 0 then
            return
        end
        ---@type LuaMagicEquipmentListData 法宝套装信息类
        local LuaMagicEquipmentListData = self:GetMagicEquipListBySuitType(suitType)
        if LuaMagicEquipmentListData ~= nil then
            local item = LuaMagicEquipmentListData:GetMagicEquipItemInfo(tblData.index)

            if (item ~= nil and item.BagItemInfo ~= nil) then
                lastId = item.BagItemInfo.itemId
            end
            LuaMagicEquipmentListData:RefreshSingleEquip(tblData)

        end
        gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MagicEquip_All)
        local redKey = uiStaticParameter.magicEquipRedPointDic[suitType]
        if redKey then
            gameMgr:GetLuaRedPointManager():CallRedPointKey(redKey)
        end

        if (lastId ~= nil) then
            gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint(nil, lastId)
        end
        if (tblData.itemInfo ~= nil) then
            gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint(nil, tblData.itemInfo.itemId)
        end
    end
end
--endregion

--region 查询

---查询法宝是否被装备
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerEquipMgr:MagicEquipIsEquipped(bagItemInfo)
    if bagItemInfo == nil or self.MagicEquipmentListDic == nil then
        return false
    end
    for k, v in pairs(self.MagicEquipmentListDic) do
        if v:IsContainItem(bagItemInfo) == true then
            return true
        end
    end
    return false
end

---查询是否有可以装备的法宝装备
---@return boolean
function LuaMainPlayerEquipMgr:HaveCanEquippedMagicEquip()
    if self.MagicEquipmentListDic == nil or type(self.MagicEquipmentListDic) ~= 'table' then
        return false
    end
    for k, v in pairs(self.MagicEquipmentListDic) do
        if v ~= nil and v:HaveCanEquip() == true then
            return true
        end
    end
    return false
end

---查询法宝是否比身上对用装备位的装备好
---@param bagItemInfo bagV2.BagItemInfo 法宝
---@return boolean
function LuaMainPlayerEquipMgr:CheckMagicEquipBetterThanBody(bagItemInfo)
    if bagItemInfo == nil or bagItemInfo.itemId == nil or clientTableManager.cfg_itemsManager:IsMagicEquip(bagItemInfo.itemId) == false then
        return false
    end
    if type(bagItemInfo) == 'table' and bagItemInfo.ItemTABLE == nil then
        bagItemInfo.ItemTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    end
    ---@type number 可装备的装备位
    local inputItemEquipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(bagItemInfo.itemId)
    if inputItemEquipIndex == nil then
        return false
    end
    ---@type LuaMagicEquipDataItem 身上的装备信息表
    local bodyMagicItemData = self:GetMagicEquipItemInfo(inputItemEquipIndex)
    if bodyMagicItemData == nil or bodyMagicItemData.BagItemInfo == nil then
        return true
    end
    ---装备对比
    if clientTableManager.cfg_itemsManager:CompareMagicEquip(bagItemInfo.ItemTABLE, bodyMagicItemData.ItemInfo) == 1 then
        return true
    end
    return false
end

---主角是否有可以显示的法宝页签
---@return boolean 是否有可显示的法宝页签数据
function LuaMainPlayerEquipMgr:CheckMainPlayerHaveCanShowMagicEquipPage()
    local mainPlayerShowConfigPage = LuaGlobalTableDeal:GetMainPlayerCanShowPage()
    return mainPlayerShowConfigPage ~= nil and type(mainPlayerShowConfigPage) == 'table' and Utility.GetTableCount(mainPlayerShowConfigPage) > 0
end
--endregion

--region 获取
---通过法宝套装类型获取套装信息
---@param suitType LuaEnumMagicEquipSuitType 法宝套装类型
---@return LuaMagicEquipmentListData 法宝套装信息类
function LuaMainPlayerEquipMgr:GetMagicEquipListBySuitType(suitType)
    if self.MagicEquipmentListDic == nil then
        self.MagicEquipmentListDic = {}
    end
    ---@type LuaMagicEquipmentListData 法宝套装信息类
    local suitInfoTable = self.MagicEquipmentListDic[suitType]
    if suitInfoTable == nil then
        suitInfoTable = luaclass.LuaMagicEquipmentListData:New()
        suitInfoTable:AnalysisSuitType(suitType)
        self.MagicEquipmentListDic[suitType] = suitInfoTable
    end
    return suitInfoTable
end

---通过装备位获取对应装备位的装备数据
---@param equipIndex number 装备位
---@return LuaMagicEquipDataItem 法宝装备信息类
function LuaMainPlayerEquipMgr:GetMagicEquipItemInfo(equipIndex)
    local equipType = clientTableManager.cfg_magicweaponManager:AnalysisTypeByEquipIndex(equipIndex)
    if equipType ~= nil then
        local equipListData = self:GetMagicEquipListBySuitType(equipType)
        if equipListData ~= nil then
            return equipListData:GetMagicEquipItemInfo(equipIndex)
        end
    end
end

---得到身上所有穿戴的法宝道具
---@return table<bagV2.BagItemInfo>
function LuaMainPlayerEquipMgr:GetAllMagicEquipItems()
    if (self.MagicEquipmentListDic == nil) then
        return {}
    end
    local list = {}
    for i, v in pairs(self.MagicEquipmentListDic) do
        ---@type LuaEnumMagicEquipSuitType
        local type = i
        ---@type LuaMagicEquipmentListData
        local data = v

        local equips = data:GetAllEquips()
        if (equips ~= nil) then
            for equipIndex, item in pairs(equips) do
                table.insert(list, item)
            end
        end
    end
    return list;
end

--endregion
--endregion

--region 宝物
--region 刷新
--region 宝物刷新
---刷新宝物装备
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function LuaMainPlayerEquipMgr:RefreshGemEquip(index, bagItemInfo)
    if type(index) ~= 'number' or Utility:IsGemEquipIndex(index) == false then
        return
    end
    ---当前宝物集合只有一类，所以写死Normal类型
    local gemSuitList = self:GetGemSuitListByGemSuitType(LuaEnumGemEquipSuitType.Normal)
    if gemSuitList ~= nil then
        gemSuitList:RefreshGemEquip(index, bagItemInfo)
    end
end
--endregion

--region 宝物镶嵌物刷新
---刷新所有的宝物镶嵌物
---@param gemList table<bagV2.ExtraEquip> 宝物列表
function LuaMainPlayerEquipMgr:RefreshAllGem(gemList)
    if type(gemList) ~= 'table' then
        return
    end
    for k, v in pairs(gemList) do
        self:RefreshSingleGemByExtraEquip(v)
    end
end

---刷新单个宝物镶嵌物
---@param extraEquip bagV2.ExtraEquip 宝物数据
function LuaMainPlayerEquipMgr:RefreshSingleGemByExtraEquip(extraEquip)
    if extraEquip == nil or extraEquip.itemId == nil then
        return
    end
    if self.GemEquipmentListDic == nil then
        self.GemEquipmentListDic = {}
    end
    ---当前宝物集合只有一类，所以写死Normal类型
    local gemSuitList = self:GetGemSuitListByGemSuitType(LuaEnumGemEquipSuitType.Normal)
    if type(gemSuitList) ~= 'table' then
        return
    end
    gemSuitList:RefreshSingleGemByExtraEquip(extraEquip)
end

---刷新单个宝物镶嵌物
---@param lampUpgradeRes bagV2.LampUpgradeRes
function LuaMainPlayerEquipMgr:RefreshSingleGemByLampUpgradeRes(lampUpgradeRes)
    if lampUpgradeRes == nil or lampUpgradeRes.id == nil then
        return
    end
    if self.GemEquipmentListDic == nil then
        self.GemEquipmentListDic = {}
    end
    ---当前宝物集合只有一类，所以写死Normal类型
    local gemSuitList = self:GetGemSuitListByGemSuitType(LuaEnumGemEquipSuitType.Normal)
    if type(gemSuitList) ~= 'table' then
        return
    end
    gemSuitList:RefreshSingleGemByLampUpgradeRes(lampUpgradeRes)
end

---刷新单个宝物镶嵌物
---@param resUpgradeSoulJade bagV2.ResUpgradeSoulJade
function LuaMainPlayerEquipMgr:RefreshSingleGemByResUpgradeSoulJade(resUpgradeSoulJade)
    if resUpgradeSoulJade == nil or resUpgradeSoulJade.newId == nil then
        return
    end
    if self.GemEquipmentListDic == nil then
        self.GemEquipmentListDic = {}
    end
    ---当前宝物集合只有一类，所以写死Normal类型
    local gemSuitList = self:GetGemSuitListByGemSuitType(LuaEnumGemEquipSuitType.Normal)
    if type(gemSuitList) ~= 'table' then
        return
    end
    gemSuitList:RefreshSingleGemByResUpgradeSoulJade(resUpgradeSoulJade)
end
--endregion
--endregion

--region 查询
--endregion

--region 获取
---通过宝物套装类型获取宝物套装列表
---@param gemSuitType LuaEnumGemEquipSuitType
---@return LuaGemEquipmentListData
function LuaMainPlayerEquipMgr:GetGemSuitListByGemSuitType(gemSuitType)
    if self.GemEquipmentListDic == nil then
        self.GemEquipmentListDic = {}
    end
    local gemEquipmentListClass = self.GemEquipmentListDic[gemSuitType]
    if gemEquipmentListClass == nil then
        gemEquipmentListClass = luaclass.LuaGemEquipmentListData:New()
        table.insert(self.GemEquipmentListDic, gemEquipmentListClass)
    end
    return gemEquipmentListClass
end

---通过斗笠盾牌套装类型获取斗笠盾牌套装列表
---@param gemSuitType LuaEnumShieldAndHatEquipSuitType
---@return LuaShieldAndHatEquipmentListData
function LuaMainPlayerEquipMgr:GetShieldAndHatSuitListByShieldAndHatSuitType(gemSuitType)
    if self.ShieldAndHatEquipmentListDic == nil then
        self.ShieldAndHatEquipmentListDic = {}
    end
    local gemEquipmentListClass = self.ShieldAndHatEquipmentListDic[gemSuitType]
    if gemEquipmentListClass == nil then
        gemEquipmentListClass = luaclass.LuaShieldAndHatEquipmentListData:New()
        table.insert(self.ShieldAndHatEquipmentListDic, gemEquipmentListClass)
    end
    return gemEquipmentListClass
end
--endregion

--endregion

--region 斗笠盾牌
---刷新斗笠盾牌装备
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function LuaMainPlayerEquipMgr:RefreshShieldAndHatEquip(index, bagItemInfo)
    if type(index) ~= 'number' or Utility:IsShieldAndHatEquipIndex(index) == false then
        return
    end
    ---当前斗笠盾牌集合只有一类，所以写死Normal类型
    local ShieldAndHatSuitList = self:GetShieldAndHatSuitListByShieldAndHatSuitType(LuaEnumShieldAndHatEquipSuitType.Normal)
    if ShieldAndHatSuitList ~= nil then
        ShieldAndHatSuitList:RefreshShieldAndHatEquip(index, bagItemInfo)
    end
end
--endregion

--region 通用
---是否是人物装备
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function LuaMainPlayerEquipMgr:IsPlayerEquip(itemTbl)
    if itemTbl == nil then
        return false
    end
    return itemTbl.type == luaEnumItemType.Equip and Utility.IsContainsValue(LuaEnumEquipSubType, itemTbl.subType)
end

---人物在此装备位是否穿戴了此itemId的装备
---@param index 装备位
---@return boolean
function LuaMainPlayerEquipMgr:IsWearingEquip(index, itemId)
    local equipBagItemInfo = self:GetEquipInfoByEquipIndex(index)
    return equipBagItemInfo ~= nil and equipBagItemInfo.itemId == itemId
end

---人物是否穿戴了此itemId的装备
---@param func function
---@return boolean
---@return bagV2.BagItemInfo
function LuaMainPlayerEquipMgr:IsWearingEquipByItemId(itemId, func)
    if (self.EquipmentListDic ~= nil) then
        ---@param v_1 LuaPlayerEquipmentListData
        for k_1, v_1 in pairs(self.EquipmentListDic) do
            local equips = v_1:GetAllEquips()
            if (equips ~= nil) then
                ---@param v_2 LuaEquipDataItem
                for k_2, v_2 in pairs(equips) do
                    if (v_2.BagItemInfo ~= nil and v_2.BagItemInfo.itemId == itemId and (func == nil or func(v_2.BagItemInfo))) then
                        return true, v_2.BagItemInfo
                    end
                end
            end
        end
    end
    return false
end

---人物穿戴了几件此itemId的装备
---@return boolean
function LuaMainPlayerEquipMgr:GetWearingEquipCountByItemId(itemId, func)
    local count = 0
    if (self.EquipmentListDic ~= nil) then
        ---@param v_1 LuaPlayerEquipmentListData
        for k_1, v_1 in pairs(self.EquipmentListDic) do
            local equips = v_1:GetAllEquips()
            if (equips ~= nil) then
                ---@param v_2 LuaEquipDataItem
                for k_2, v_2 in pairs(equips) do
                    if (v_2.BagItemInfo ~= nil and v_2.BagItemInfo.itemId == itemId and (func == nil or func(v_2.BagItemInfo))) then
                        count = count + 1
                    end
                end
            end
        end
    end
    return count
end

--region 神力装备固定套装数据
function LuaMainPlayerEquipMgr:GetStaticDivineSuitData(type, id, subType)
    if self.mStaticDivineSuit == nil then
        self.mStaticDivineSuit = {}
    end
    id = id == nil and type * 1000 + 1 or id
    local typeDivineSuit = self.mStaticDivineSuit[id]
    if typeDivineSuit == nil then
        typeDivineSuit = {}
        local AllSuitAdditionTbl = clientTableManager.cfg_divinesuitattributeManager.GetDivineSuitAdditionByID(id, 999)
        for activeCount, ActiveAttributeID in pairs(AllSuitAdditionTbl) do
            ---@type LuaEquipSuitAdditionItem
            local SuitAdditionItem = luaclass.LuaEquipSuitAdditionItem:New()
            SuitAdditionItem:InitData(type, 1, activeCount, ActiveAttributeID, subType)
            table.insert(typeDivineSuit, SuitAdditionItem)
        end
        table.sort(typeDivineSuit, function(a, b)
            return a.ActivateLimitCount < b.ActivateLimitCount
        end)
        self.mStaticDivineSuit[id] = typeDivineSuit
    end
    return typeDivineSuit
end
--endregion


---获取背包可装备物品
---@return bagV2.BagItemInfo
function LuaMainPlayerEquipMgr:GetBagCanEquipInfo(equipIndex)
    if CS.CSScene.MainPlayerInfo == nil then
        return nil
    end
    local subType = self:GetSubTypeByEquipIndex(equipIndex);
    if subType == nil then
        ---如果lua 这边没处理的话默认调用c#里面的方法
        return CS.CSScene.MainPlayerInfo.EquipInfo:GetBagCanEquipInfo(equipIndex)
    end
    local info = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBestEquip(equipIndex, true)
    return info;
end

---根据装备位index 获取装备SubType
function LuaMainPlayerEquipMgr:GetSubTypeByEquipIndex(equipIndex)
    if equipIndex == LuaEquipmentItemType.POS_MaPai then
        return LuaEnumEquipSubType.Equip_maPai
    elseif equipIndex == LuaEquipmentItemType.POS_AnQi then
        return LuaEnumEquipSubType.Equip_AnQi
    elseif equipIndex == LuaEquipmentItemType.MainSignet then
        return LuaEnumEquipSubType.MainSignet
    elseif equipIndex == LuaEquipmentItemType.SubSignet then
        return LuaEnumEquipSubType.SubSignet
    elseif equipIndex == LuaEquipmentItemType.POS_ZHENFA_EQUIP_1 then
        return LuaEnumEquipSubType.Equip_zhenfa_1
    elseif equipIndex == LuaEquipmentItemType.POS_ZHENFA_EQUIP_2 then
        return LuaEnumEquipSubType.Equip_zhenfa_2
    elseif equipIndex == LuaEquipmentItemType.POS_ZHENFA_EQUIP_3 then
        return LuaEnumEquipSubType.Equip_zhenfa_3
    elseif equipIndex == LuaEquipmentItemType.POS_ZHENFA_EQUIP_4 then
        return LuaEnumEquipSubType.Equip_zhenfa_4
    end
    return nil
end

---@public 根据装备位去装备数据
---@return bagV2.BagItemInfo
function LuaMainPlayerEquipMgr:GetEquipInfoByEquipIndex(equipIndex)
    --if (self.ItemListDicCache ~= nil) then
    --    return self.ItemListDicCache[equipIndex];
    --end
    --return nil;

    if (self.EquipmentListDic ~= nil) then
        ---@param v_1 LuaPlayerEquipmentListData
        for k_1, v_1 in pairs(self.EquipmentListDic) do
            local equips = v_1:GetAllEquips()
            if (equips ~= nil) then
                ---@param v_2 LuaEquipDataItem
                for k_2, v_2 in pairs(equips) do
                    if (v_2.BagItemInfo ~= nil and v_2.BagItemInfo.index == equipIndex) then
                        return v_2.BagItemInfo;
                    end
                end
            end
        end
    end
    return nil;
end

--region 数据清理
function LuaMainPlayerEquipMgr:ResetParams()
    self.EquipmentListDic = {}
    self.MagicEquipmentListDic = {}
    self.ItemListDicCache = nil
end
--endregion

---检查是否需要隐藏戒指或手镯的第二个装备位
function LuaMainPlayerEquipMgr:CheckIsNeedSec(itemId)
    if itemId == nil then
        return false
    end
    local ItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if ItemTable:GetDivineId() == nil then
        return false
    end
    local divineId = ItemTable:GetDivineId()
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(23103)
    if Lua_GlobalTABLE.value == nil then
        return false
    end
    local num = string.Split(Lua_GlobalTABLE.value, "#")
    if num == nil then
        return false
    end
    for i = 1, #num do
        if tonumber(num[i]) == divineId then
            return true
        end
    end
end

---检查是否为兵鉴神器
function LuaMainPlayerEquipMgr:CheckIsSLBingJian(itemId)
    if itemId == nil then
        return false
    end
    local ItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if ItemTable:GetDivineId() == nil then
        return false
    end
    local divineId = ItemTable:GetDivineId()
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(23114)
    if Lua_GlobalTABLE.value == nil then
        return false
    end
    local num = string.Split(Lua_GlobalTABLE.value, "#")
    if num == nil then
        return false
    end
    for i = 1, #num do
        if tonumber(num[i]) == divineId then
            return true
        end
    end
end

---设置和检查兵鉴界面是否打开
function LuaMainPlayerEquipMgr:IsSLequipLevelOpen(isOpen)
    if isOpen == nil then
        return self.isOpen
    end
    self.isOpen = isOpen

end

---获取兵鉴当前和下一级的属性
function LuaMainPlayerEquipMgr:GetCurAndNextAttr(curData, nextData, itemId)
    local data = {}
    local enum = {16, 18, 20, 22, 24, 26}
    local extraMonEffectTableManager = clientTableManager.cfg_extra_mon_effectManager
    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career);
    for k, v in pairs(enum) do
        local temp = {}
        local extraAttributeType = v
        local addStr = extraMonEffectTableManager:GetExtraAttributeValueStrWithItemsTableAttr(curData.extra, extraAttributeType, career, itemId)
        local name = extraMonEffectTableManager:GetExtraAttributeName(curData.extra, extraAttributeType)
        local nextStr
        if nextData ~= nil then
            nextStr = extraMonEffectTableManager:GetExtraAttributeValueStrWithItemsTableAttr(nextData.extra, extraAttributeType, career, itemId)
        end
        temp.name = name
        temp.addStr = addStr
        temp.nextStr = nextStr
        if temp.name ~= "" and temp.addStr ~= "" then
            table.insert(data, temp)
        end
    end
    return data
end

---获取兵鉴当前和下一级的table
function LuaMainPlayerEquipMgr:GetCurAndNextTable(equipLevel, levelData)
    local isMaxLevel = false
    ---判断是否大于该装备的最高等级
    if equipLevel >= (#levelData - 1) then
        isMaxLevel = true
    end
    local curData = {}
    local nextData = {}
    for i = 1, #levelData do
        if levelData[i].level == equipLevel then
            curData = levelData[i]
            if isMaxLevel == false then
                nextData = levelData[i + 1]
            end
        end
    end
    return curData, nextData, isMaxLevel
end

---根据class表获取level表内容
function LuaMainPlayerEquipMgr:GetLevelTableByClassTable(itemId)
    local classData = clientTableManager.cfg_growth_weapon_classManager:TryGetValue(itemId)
    local levelKey = classData:GetWeaponLevel()
    local temp = {}
    for k, v in pairs(levelKey.list) do
        local data = clientTableManager.cfg_growth_weapon_levelManager:TryGetValue(v)
        table.insert(temp, data)
    end
    return temp
end

---根据itemid获取套装描述
function LuaMainPlayerEquipMgr:GetSuitDesBybagItemInfo(bagItemInfo, itemInfo)
    if bagItemInfo == nil and itemInfo == nil then
        return ""
    end
    local itemId = bagItemInfo and bagItemInfo.itemId or itemInfo.id
    local growth = bagItemInfo and bagItemInfo.growthLevel or 0
    local temp = self:GetLevelTableByClassTable(itemId)
    local equipLevel = growth
    if equipLevel == nil then
        equipLevel = 0
    end
    local levelData, nextLevelData, isMax = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetCurAndNextTable(equipLevel, temp)
    local suit = levelData.divineSuit
    if levelData.divineSuit == nil or levelData.divineSuit == "" or levelData.divineSuit == 0 then
        if nextLevelData == nil then
            return ""
        end
        suit = nextLevelData.divineSuit
    end
    local suitData = clientTableManager.cfg_divinesuitManager:TryGetValue(suit)
    if suitData == nil then
        return ""
    end
    local suitDes = suitData:GetAttribute()
    local suitInfo = clientTableManager.cfg_divinesuitattributeManager:TryGetValue(suitDes.list[1].list[2])
    return suitInfo.des
end

---根据顺序获取物品
function LuaMainPlayerEquipMgr:GetSLBingJianByGlobalOrder()
    local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Sl_BingJian)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(23128)
    if Lua_GlobalTABLE == nil then
        return nil
    end
    local index = string.Split(Lua_GlobalTABLE.value, "#")
    if LuaPlayerEquipmentListData then
        local equipDic = LuaPlayerEquipmentListData.EquipmentDic
        for i = 1, #index do
            for k, v in pairs(equipDic) do
                ---@type LuaEquipDataItem
                local equipInfo = v
                if equipInfo.BagItemInfo then
                    if equipInfo.BagItemInfo.index == 106000 + tonumber(index[i]) then
                        return equipInfo.BagItemInfo
                    end
                end
            end
        end
    end
    return nil
end


return LuaMainPlayerEquipMgr
