---主角的背包数据管理类,用来管理Lua内的背包数据(PS:同步C#数据)
---@class LuaMainPlayerBagMgr:luaobject
local LuaMainPlayerBagMgr = {}

--region 主角背包数据
---获取背包数据
---@public
---@alias lid number
---@return table<lid,bagV2.BagItemInfo> 背包数据 lua的bagV2.BagItemInfo
function LuaMainPlayerBagMgr:GetAllBagItemData()
    if self.mBagData == nil then
        self.mBagData = {}
    end
    return self.mBagData
end

---获取背包数据,
---@param lid number 背包物品的唯一ID
---@return bagV2.BagItemInfo
function LuaMainPlayerBagMgr:GetBagItemData(lid)
    return self:GetAllBagItemData()[lid]
end

---获取实际的货币数量（单独的货币id数量）
---@public
---@param coinItemID number 货币ItemID
---@return number
function LuaMainPlayerBagMgr:GetCurCoinAmount(coinItemID)
    if type(coinItemID) ~= 'number' or type(self.mCoinDataList) ~= 'table' then
        return 0
    end
    return self.mCoinDataList[coinItemID] or 0
end

---获取货币数量（合批同类型货币数据）
---@public
---@param coinItemID number 货币ItemID
---@return number
function LuaMainPlayerBagMgr:GetCoinAmount(coinItemID)
    if self.mCoinDataList == nil or coinItemID == nil then
        return 0
    end
    local sameCoinList = self:GetSameCoinList()
    local isSameCoinExist = false
    ---@type table<number,CoinItemID>
    local sameCoins = nil
    for i = 1, #sameCoinList do
        for j = 1, #sameCoinList[i] do
            if sameCoinList[i][j] == coinItemID then
                sameCoins = sameCoinList[i]
                isSameCoinExist = true
                break
            end
        end
        if isSameCoinExist then
            break
        end
    end
    if isSameCoinExist and sameCoins ~= nil then
        local amount = 0
        for i = 1, #sameCoins do
            local coinIDTemp = sameCoins[i]
            local countTemp = self.mCoinDataList[coinIDTemp] or 0
            amount = amount + countTemp
        end
        return amount
    else
        return self.mCoinDataList[coinItemID] or 0
    end
end

---相同货币列表
---@private
---@return table<number,table<CoinItemID,CoinCount>>
function LuaMainPlayerBagMgr:GetSameCoinList()
    if self.mSameCoinList == nil then
        self.mSameCoinList = {}
        ---@type TABLE.CFG_GLOBAL
        local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22709)
        if tbl then
            local strs1 = string.Split(tbl.value, '&')
            for i = 1, #strs1 do
                local strs2 = string.Split(strs1[i], '#')
                local ids = {}
                for j = 1, #strs2 do
                    local idTemp = tonumber(strs2[j])
                    if idTemp then
                        table.insert(ids, idTemp)
                    end
                end
                table.insert(self.mSameCoinList, ids)
            end
        end
    end
    return self.mSameCoinList
end

---获取最大背包容量
---@return number
function LuaMainPlayerBagMgr:GetMaxGridCount()
    return self.mMaxGridCount or 0
end

---获取背包扩容次数
---@return number
function LuaMainPlayerBagMgr:GetAddGridCount()
    return self.mAddGridCount or 0
end

---获取背包中剩余空格数量
---@return number
function LuaMainPlayerBagMgr:GetEmptyGridCount()
    return self.mEmptyGridCount or 0
end

---获取物品日使用次数信息
---@return bagV2.ResDayUseItemCount
function LuaMainPlayerBagMgr:GetItemDayUseCount(itemID)
    if self.mItemDayUseCounts == nil or itemID == nil then
        return nil
    end
    return self.mItemDayUseCounts[itemID] or nil
end
--endregion

--region 主角额外装备数据(灯芯等)
---赤焰灯芯物品ID
---@return number
function LuaMainPlayerBagMgr:GetChiYanDengXinItemID()
    return self.mChiYanDengXinItemID or 0
end

---赤焰灯芯物品Item表数据
---@return TABLE.cfg_items
function LuaMainPlayerBagMgr:GetChiYanDengXinItemTbl()
    return self.mChiYanDengXinItemTbl
end

---进攻之源物品ID
---@return number
function LuaMainPlayerBagMgr:GetJinGongZhiYuanItemID()
    return self.mJinGongZhiYuanItemID or 0
end

---进攻之源物品Item表数据
---@return TABLE.cfg_items
function LuaMainPlayerBagMgr:GetJinGongZhiYuanItemTbl()
    return self.mJinGongZhiYuanItemTbl
end

---守护之源物品ID
---@return number
function LuaMainPlayerBagMgr:GetShouHuZhiYuanItemID()
    return self.mShouHuZhiYuanItemID or 0
end

---守护之源物品Item表数据
---@return TABLE.cfg_items
function LuaMainPlayerBagMgr:GetShouHuZhiYuanItemTbl()
    return self.mShouHuZhiYuanItemTbl
end

---生命精魄物品ID
---@return number
function LuaMainPlayerBagMgr:GetShengMingJingPoItemID()
    return self.mShengMingJingPoItemID or 0
end

---生命精魄物品Item表数据
---@return TABLE.cfg_items
function LuaMainPlayerBagMgr:GetShengMingJingPoItemTbl()
    return self.mShengMingJingPoItemTbl
end

---宝石物品ID
---@return number
function LuaMainPlayerBagMgr:GetBaoShiItemID()
    return self.mBaoShiItemID or 0
end

---宝石物品Item表数据
---@return TABLE.cfg_items
function LuaMainPlayerBagMgr:GetBaoShiItemTbl()
    return self.mBaoShiItemTbl
end
--endregion

--region 主角衍生数据
---获取最近一次背包变化的原因,默认返回0,表示初始化背包
---@return number
function LuaMainPlayerBagMgr:GetLatestBagChangeReason()
    return self.mLatestBagChangeReason
end
--endregion

--region 网络接口
---初始化背包数据
---@public
---@param resBagInfo bagV2.ResBagInfo
function LuaMainPlayerBagMgr:InitializeBagData(resBagInfo)
    if resBagInfo == nil then
        return
    end
    ---背包扩容次数
    if resBagInfo.addGridCountSpecified then
        self.mAddGridCount = resBagInfo.addGridCount
    end
    ---背包最大格子数量
    if resBagInfo.maxGridCountSpecified then
        self.mMaxGridCount = resBagInfo.maxGridCount
    end
    ---背包物品数据
    ---@type table<lid,bagV2.BagItemInfo>
    self.mBagData = {}
    self.mLatestBagChangeReason = 0
    if resBagInfo and resBagInfo.itemList then
        for i = 1, #resBagInfo.itemList do
            local bagItem = resBagInfo.itemList[i]
            self:GetAllBagItemData()[bagItem.lid] = bagItem
        end
    end
    ---货币数据
    ---@type table<CoinItemID,CoinCount>
    self.mCoinDataList = {}
    if resBagInfo and resBagInfo.coinList then
        for i = 1, #resBagInfo.coinList do
            local coinData = resBagInfo.coinList[i]
            if coinData.itemId ~= 0 then
                self.mCoinDataList[coinData.itemId] = coinData.count or 0
            end
        end
    end
    ---额外装备数据(玩家身上装备的额外装备,如赤焰灯芯,进攻之源等)
    if resBagInfo and resBagInfo.extraEquip then
        self:InitializeExtraEquips(resBagInfo.extraEquip)
    end
    ---刷新背包中空格子数量
    self:RefreshEmptyGridCount()
end

---刷新空格数量
---@private
function LuaMainPlayerBagMgr:RefreshEmptyGridCount()
    ---背包中空格数量
    self.mEmptyGridCount = self:GetMaxGridCount() - Utility.GetTableCount(self:GetAllBagItemData())
    if self.mEmptyGridCount < 0 then
        self.mEmptyGridCount = 0
    end
end

---初始化额外装备
---@private
---@param extraEquips table<number,bagV2.ExtraEquip>
function LuaMainPlayerBagMgr:InitializeExtraEquips(extraEquips)
    if extraEquips == nil then
        return
    end
    for i = 1, #extraEquips do
        local extraTemp = extraEquips[i]
        local type = extraTemp.type
        if type == 14 then
            ---赤焰灯芯
            self.mChiYanDengXinItemID = extraTemp.itemId
            self.mChiYanDengXinItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mChiYanDengXinItemID)
        elseif type == 19 then
            ---进攻之源
            self.mJinGongZhiYuanItemID = extraTemp.itemId
            self.mJinGongZhiYuanItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mJinGongZhiYuanItemID)
        elseif type == 20 then
            ---守护之源
            self.mShouHuZhiYuanItemID = extraTemp.itemId
            self.mShouHuZhiYuanItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mShouHuZhiYuanItemID)
        elseif type == 16 then
            ---生命精魄
            self.mShengMingJingPoItemID = extraTemp.itemId
            self.mShengMingJingPoItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mShengMingJingPoItemID)
        elseif type == 17 then
            ---宝石
            self.mBaoShiItemID = extraTemp.itemId
            self.mBaoShiItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mBaoShiItemID)
        end
    end
end

---响应背包变化
---@public
---@param resBagChange bagV2.ResBagChange
function LuaMainPlayerBagMgr:RespondBagChange(resBagChange)
    if resBagChange == nil then
        return
    end
    ---背包变化原因
    self.mLatestBagChangeReason = resBagChange.action
    if resBagChange.itemList then
        ---增加的物品队列
        for i = 1, #resBagChange.itemList do
            local bagItemTemp = resBagChange.itemList[i]
            self:GetAllBagItemData()[bagItemTemp.lid] = bagItemTemp
        end
    end
    if resBagChange.coinList then
        ---改变的货币队列
        if self.mCoinDataList == nil then
            self.mCoinDataList = {}
        end
        for i = 1, #resBagChange.coinList do
            local coinInfo = resBagChange.coinList[i]
            if coinInfo.itemIdSpecified and coinInfo.countSpecified then
                self.mCoinDataList[coinInfo.itemId] = coinInfo.count
            end
        end
    end
    if resBagChange.removedIdList then
        ---移除的物品id队列
        for i = 1, #resBagChange.removedIdList do
            local removedLid = resBagChange.removedIdList[i]
            self:GetAllBagItemData()[removedLid] = nil
        end
    end
    ---刷新下空格子数量
    self:RefreshEmptyGridCount()
end

---响应背包扩容
---@public
---@param resAddStorageMaxCount bagV2.ResAddStorageMaxCount
function LuaMainPlayerBagMgr:RespondAddStorageMaxCount(resAddStorageMaxCount)
    if resAddStorageMaxCount == nil then
        return
    end
    ---赋值背包中最大格子数量
    self.mMaxGridCount = resAddStorageMaxCount.maxGridCount
    ---刷新空格数量
    self:RefreshEmptyGridCount()
end

---响应强化/转移等
---@public
---@param resIntensify bagV2.ResIntensify
function LuaMainPlayerBagMgr:RespondIntensify(resIntensify)
    if resIntensify == nil then
        return
    end
    local lid = resIntensify.equipId
    local bagItemTemp = resIntensify.equipInfo
    self:GetAllBagItemData()[lid] = bagItemTemp
end

---鉴定刷新
---@public
---@param resIntensify bagV2.ResIntensify
function LuaMainPlayerBagMgr:RespondJianDing(resIntensify)
    if resIntensify == nil then
        return
    end
    local lid = resIntensify.appraisaEquip.lid
    local bagItemTemp = resIntensify.appraisaEquip
    self:GetAllBagItemData()[lid] = bagItemTemp
end

---响应赤焰灯芯升级
---@public
---@param lampUpgradeRes bagV2.LampUpgradeRes
function LuaMainPlayerBagMgr:RespondLampUpgrade(lampUpgradeRes)
    if lampUpgradeRes == nil then
        return
    end
    local lampType = lampUpgradeRes.type
    if lampType == 1 then
        ---赤焰灯灯芯
        self.mChiYanDengXinItemID = lampUpgradeRes.id
        self.mChiYanDengXinItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mChiYanDengXinItemID)
    elseif lampType == 2 then
        ---进攻之源
        self.mJinGongZhiYuanItemID = lampUpgradeRes.id
        self.mJinGongZhiYuanItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mJinGongZhiYuanItemID)
    elseif lampType == 3 then
        ---守护之源
        self.mShouHuZhiYuanItemID = lampUpgradeRes.id
        self.mShouHuZhiYuanItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mShouHuZhiYuanItemID)
    elseif lampType == 4 then
        ---宝石
        self.mBaoShiItemID = lampUpgradeRes.id
        self.mBaoShiItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mBaoShiItemID)
    end
end

---响应生命精魄升级
---@public
---@param resUpgradeSoulJade bagV2.ResUpgradeSoulJade
function LuaMainPlayerBagMgr:RespondUpgradeSoulJade(resUpgradeSoulJade)
    if resUpgradeSoulJade == nil then
        return
    end
    self.mShengMingJingPoItemID = resUpgradeSoulJade.newId
    self.mShengMingJingPoItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mShengMingJingPoItemID)
end

---响应装备进化
---@public
---@param resEvolve bagV2.ResEvolve
function LuaMainPlayerBagMgr:RespondEvolve(resEvolve)
    if resEvolve == nil then
        return
    end
    self:GetAllBagItemData()[resEvolve.equipId] = resEvolve.equipInfo
end

---每日使用物品数量
---@public
---@param resDayUseItemCount bagV2.ResDayUseItemCount
function LuaMainPlayerBagMgr:RespondDayUseItemCount(resDayUseItemCount)
    if resDayUseItemCount == nil then
        return
    end
    if self.mItemDayUseCounts == nil then
        ---@type table<number, bagV2.ResDayUseItemCount>
        self.mItemDayUseCounts = {}
    end
    self.mItemDayUseCounts[resDayUseItemCount.itemId] = resDayUseItemCount
end

---熔炼血继回包
---@public
---@param resBloodSmelt bagV2.ResBloodSmelt
function LuaMainPlayerBagMgr:RespondBloodSmelt(resBloodSmelt)
    if resBloodSmelt == nil then
        return
    end
    self:GetAllBagItemData()[resBloodSmelt.item.lid] = resBloodSmelt.item
end

---修改背包最大格子数目
---@param resBagSizeByMonthCard bagV2.ResBagSizeByMonthCard
function LuaMainPlayerBagMgr:RefreshMaxGridCountByMonthCard(resBagSizeByMonthCard)
    self.mMaxGridCount = resBagSizeByMonthCard.maxGridCount
    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_BagItemChanged)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.BAG_FULL);
end

---@param tblData equipV2.ResRefinResult
function LuaMainPlayerBagMgr:RespondAgainRefine(tblData)
    if tblData == nil then
        return
    end
    self:GetAllBagItemData()[tblData.soulEquips.itemInfo.lid] = tblData.soulEquips.itemInfo
end

---@param tblData roleV2.ResInsuredSucces
function LuaMainPlayerBagMgr:RespondInsure(tblData)
    if tblData == nil or tblData.theEquip == nil then
        return
    end
    self:GetAllBagItemData()[tblData.theEquip.lid] = tblData.theEquip
end

--endregion

--region 模块接口
---获取到背包中某个道具的数量
---@param itemID number 传入道具表的ID
---@param excludeItemLid number|nil 排除道具的lid(在某个道具,然后获取相同道具的数量的时候)
---@param func function
---@return number 数量
function LuaMainPlayerBagMgr:GetItemCount(itemID, excludeItemLid, func)
    local count = 0
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        if bagItemInfo.itemId == itemID and (func == nil or func(bagItemInfo)) then
            if (excludeItemLid == nil or excludeItemLid ~= bagItemInfo.lid) then
                count = count + bagItemInfo.count
            end
        end
    end
    return count
end

---获取到背包中某个道具的数量(包含货币)
---@param itemID number 传入道具表的ID
---@param excludeItemLid number|nil 排除道具的lid(在某个道具,然后获取相同道具的数量的时候)
---@return number 数量
function LuaMainPlayerBagMgr:GetItemAndMoneyCount(itemID, excludeItemLid)
    local itemCount = self:GetItemCount(itemID, excludeItemLid)
    local moneyCount = self:GetCoinAmount(itemID)
    if moneyCount == nil then
        moneyCount = 0
    end
    return itemCount + moneyCount
end

---获取到背包中某个道具的数量(包含单独的货币id数量)
---@param itemID number 传入道具表的ID
---@param excludeItemLid number|nil 排除道具的lid(在某个道具,然后获取相同道具的数量的时候)
---@param func function
---@return number 数量
function LuaMainPlayerBagMgr:GetItemAndCurCoinMoneyCount(itemID, excludeItemLid, func)
    local itemCount = self:GetItemCount(itemID, excludeItemLid, func)
    local moneyCount = self:GetCurCoinAmount(itemID)
    if moneyCount == nil then
        moneyCount = 0
    end
    return itemCount + moneyCount
end

--region 获取背包中的道具

---获取到背包中某个道具的列表
---@param itemID number 传入道具表的ID
---@param excludeItemLid number 排除道具的lid(在某个道具,然后获取相同道具的数量的时候)
---@return number 数量
function LuaMainPlayerBagMgr:GetItemListByItemId(itemID, excludeItemLid)
    local count = 0
    local list = {}
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        if bagItemInfo.itemId == itemID then
            if (excludeItemLid == nil or excludeItemLid ~= bagItemInfo.lid) then
                count = count + bagItemInfo.count
                table.insert(list, bagItemInfo)
            end
        end
    end
    return count, list
end

---获取到背包中的道具列表 根据传入的类型
---@param type number 道具表中的type
---@param subType number 道具表中的subType
---@return table<bagV2.BagItemInfo>
function LuaMainPlayerBagMgr:GetItemListByType(type, subType)
    local list = {}
    local bagItemInfo = nil
    local itemTbl = nil
    local isSameType = nil
    local isSubType = nil
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        bagItemInfo = v
        ---@type TABLE.cfg_items
        itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)
        isSameType = type == nil or itemTbl:GetType() == type
        isSubType = subType == nil or itemTbl:GetSubType() == subType
        if isSameType and isSubType then
            table.insert(list, bagItemInfo)
        end
    end
    return list
end

---获取到背包中的道具 根据传入的类型
---@param type number 道具表中的type
---@param subType number 道具表中的subType
---@return bagV2.BagItemInfo
function LuaMainPlayerBagMgr:GetItemByType(type, subType)
    local list = {}
    local bagItemInfo = nil
    local itemTbl = nil
    local isSameType = nil
    local isSubType = nil
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        bagItemInfo = v
        ---@type TABLE.cfg_items
        itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)
        isSameType = type == nil or itemTbl:GetType() == type
        isSubType = subType == nil or itemTbl:GetSubType() == subType
        if isSameType and isSubType then
            return bagItemInfo
        end
    end
end

---获取ItemId获取背包物品数据
---@param itemId number
---@return bagV2.BagItemInfo
function LuaMainPlayerBagMgr:GetBagItemInfoByItemId(itemId)
    local count, bagItemInfoList = self:GetItemListByItemId(itemId)
    if type(bagItemInfoList) == 'table' and Utility.GetLuaTableCount(bagItemInfoList) > 0 then
        return bagItemInfoList[1]
    end
end

---@class SearchItemTypeItem
---@field type number 道具表中的type
---@field subType number 道具表中的subType

---获取到背包中的道具列表 根据传入的类型
---@param SearchItemTypes table<SearchItemTypeItem> 道具表中的type
---@return table<bagV2.BagItemInfo>
function LuaMainPlayerBagMgr:GetItemListByTypes(SearchItemTypes)
    local list = {}
    local bagItemInfo = nil
    local itemTbl = nil
    local isSameType = nil
    local isSubType = nil
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        bagItemInfo = v
        ---@type TABLE.cfg_items
        itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)

        if (SearchItemTypes ~= nil) then
            for j, SearchItemType in pairs(SearchItemTypes) do
                local type = SearchItemType.type
                local subType = SearchItemType.subType

                isSameType = type == nil or itemTbl:GetType() == type
                isSubType = subType == nil or itemTbl:GetSubType() == subType
                if isSameType and isSubType then
                    table.insert(list, bagItemInfo)
                    break
                end
            end
        else
            table.insert(list, bagItemInfo)
        end
    end
    return list
end

--endregion

--region 道具使用的数量上限

---同一组中  多个道具互相公用使用次数
LuaMainPlayerBagMgr.ItemToUseCountIndex = nil
LuaMainPlayerBagMgr.UseCountIndexCost = {}

---从表格中读取数据,将不同的道具塞入字典中
function LuaMainPlayerBagMgr:InitBagItemUseCountLimitInfo()
    --道具共享限次使用的分组配置数据，格式：组序号#itemID#itemID#...#itemID & 组序号#itemID#itemID#...#itemID，
    --共享次数的同组之间用#分割，多个分组之间用&连接，每一组的第一个参数为组序号（从1开始向后递增）
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22879)

    self.ItemToUseCountIndex = {}
    if isFind then
        local strArray = string.Split(info.value, '&')
        for i, v in pairs(strArray) do
            local data = string.Split(v, '#')
            local index = data[1]
            for j = 2, #data do
                local itemId = tonumber(data[j])
                self.ItemToUseCountIndex[itemId] = index;
            end
        end
    end
end

---@param tblData countV2.ResCountShareUsed
function LuaMainPlayerBagMgr:ResCountShareUsed(tblData)
    if (self.ItemToUseCountIndex == nil) then
        self:InitBagItemUseCountLimitInfo();
    end
    self.UseCountIndexCost = {}
    if (tblData.useCount == nil) then
        return
    end
    for i, info in pairs(tblData.useCount) do
        local index = tonumber(info >> 32);
        local count = info & 0xFFFFFFFF
        self.UseCountIndexCost[index] = count;
    end
end

---得到道具使用的上限值
---@param item bagV2.BagItemInfo
---@return number,number 当前使用,最大上限
function LuaMainPlayerBagMgr:GetItemUseCountLimit(item)
    if (item == nil) then
        return nil, nil
    end
    if (self.ItemToUseCountIndex == nil) then
        self:InitBagItemUseCountLimitInfo();
    end
    local index = self.ItemToUseCountIndex[item.itemId];
    if (index == nil) then
        return nil, nil
    end
    local useMaxCount = Utility.GetItemTblByBagItemInfo(item):GetUseLimit();
    local useCount = self.UseCountIndexCost[tonumber(index)];
    if (useCount == nil) then
        useCount = 0;
    end
    return useCount, useMaxCount;
end
--endregion

---得到一件指定装备位能传的装备
---@param equipIndex number 装备下标
---@param param any 额外参数,根据不同类型的道具,可能会有不同的用法
---@return bagV2.BagItemInfo lua的背包单位数据
function LuaMainPlayerBagMgr:GetCanEquipItem(equipIndex, param)
    local subType = Utility.GetItemSubTypeByEquipIndex(equipIndex)
    if (Utility.IsSLEquip(equipIndex)) then
        return self:GetBestSLCanEquipItem(subType, true, param)
    end
    return self:GetBestEquip(subType, true)
end

---获取到指定subType的道具中最好的一件装备
---@param subType number 道具的subType
---@param canEquip boolean 是否需要判定是否能使用
---@return bagV2.BagItemInfo lua的背包单位数据
function LuaMainPlayerBagMgr:GetBestEquip(subType, canEquip)
    local bestItem = nil
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        if (itemInfo ~= nil and itemInfo:GetType() == luaEnumItemType.Equip and Utility.GetItemTblByBagItemInfo(bagItemInfo):GetSubType() == subType) then
            if (bestItem == nil or self:ItemCompare(bestItem, bagItemInfo)) then
                if (canEquip == true) then
                    ---需要判定是否能使用
                    if (self:IsCanUseItem(bagItemInfo) == LuaItemCanUseResult.CanUse) then
                        bestItem = bagItemInfo
                    end
                else
                    bestItem = bagItemInfo
                end
            end
        end
    end
    return bestItem
end

---得到指定套装最好的神力装备
---@param subType number 道具类型
---@param canEquip boolean 是否需要判定能否穿戴
---@param type number 指定神力套装类型
---@return bagV2.BagItemInfo lua的背包单位数据
function LuaMainPlayerBagMgr:GetBestSLCanEquipItem(subType, canEquip, type)
    local bestItem = nil
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        if (Utility.GetItemTblByBagItemInfo(bagItemInfo):GetSubType() == subType and Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo) ~= nil and Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo):GetType() == type) then
            if (bestItem == nil or self:ItemCompare(bestItem, bagItemInfo)) then
                if (canEquip == true) then
                    ---需要判定是否能使用
                    if (self:IsCanUseItem(bagItemInfo) == LuaItemCanUseResult.CanUse) then
                        bestItem = bagItemInfo
                    end
                else
                    bestItem = bagItemInfo
                end
            end
        end
    end
    return bestItem
end

---是否存在神力装备
function LuaMainPlayerBagMgr:IsExitSLEquip(equipIndex, type)
    local subType = Utility.GetItemSubTypeByEquipIndex(equipIndex)
    for i, v in pairs(self:GetAllBagItemData()) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        if (Utility.GetItemTblByBagItemInfo(bagItemInfo):GetSubType() == subType and Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo) ~= nil and Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo):GetType() == type) then
            return true
        end
    end
    return false
end

--region 外部调用IsCanUseItem(bagV2.BagItemInfo) 判定主角是否能使用道具
---主角是否能使用这个道具
---@param bagItemInfo bagV2.BagItemInfo lua的背包单位数据
---@param level number 判定者的使用等级 如果为nil,那么使用主角的
---@param reinLv number 判定者的转生等级 如果为nil,那么使用主角的
---@param sex number 判定者的性别 如果为nil,那么使用主角的
---@param bagItemInfo bagV2.BagItemInfo lua的背包单位数据
---@return LuaItemCanUseResult 道具的使用结果
function LuaMainPlayerBagMgr:IsCanUseItem(bagItemInfo, level, reinLv, sex)
    if (bagItemInfo == nil) then
        return LuaItemCanUseResult.None
    end
    if (level == nil) then
        level = CS.CSSceneExt.MainPlayerInfo.Level
    end

    if (reinLv == nil) then
        reinLv = CS.CSSceneExt.MainPlayerInfo.ReinLevel
    end

    if (sex == nil) then
        sex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    end
    ---@type TABLE.cfg_items
    local lua_ItemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)

    if (lua_ItemTbl:GetSex() ~= 0 and sex ~= lua_ItemTbl:GetSex()) then
        return LuaItemCanUseResult.Sex
    end

    local state = LuaItemCanUseResult.CanUse
    local useCondition = lua_ItemTbl:GetUseCondition()
    if (useCondition == nil or useCondition == 0) then
        --0或不配置 转生等级和等级都需满足（先看转生再看等级）
        if (lua_ItemTbl:GetReinLv() > reinLv) then
            state = LuaItemCanUseResult.UseReinLvNotEnough
        elseif (lua_ItemTbl:GetUseLv() > level) then
            state = LuaItemCanUseResult.UseLvNotEnough
        end
    elseif (useCondition == 1) then
        --1 转生或等级任意满足即可
        if (lua_ItemTbl:GetReinLv() <= reinLv or lua_ItemTbl:GetUseLv() <= level) then
            state = LuaItemCanUseResult.UseReinLvNotEnough
        end
    end
    --神力装备需要额外判定
    if (state == LuaItemCanUseResult.CanUse and lua_ItemTbl:GetDivineId() ~= nil and lua_ItemTbl:GetDivineId() ~= 0) then
        state = self:IsCanUseSLEquip(bagItemInfo)
    end
    --马牌暗器额外判定
    if state == LuaItemCanUseResult.CanUse and (lua_ItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_AnQi or lua_ItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_maPai) then
        state = self:IsCanUseMaPai_AnQi(lua_ItemTbl)
    end
    --法阵配件额外判定
    if state == LuaItemCanUseResult.CanUse and (lua_ItemTbl:GetSubType() >= LuaEnumEquipSubType.Equip_zhenfa_1 and lua_ItemTbl:GetSubType() <= LuaEnumEquipSubType.Equip_zhenfa_4) then
        state = self:IsCanUseZhenFaEquip(bagItemInfo)
    end
    return state
end

---主角是否能使用神力道具
---@param bagItemInfo bagV2.BagItemInfo lua的背包单位数据
---@return LuaItemCanUseResult 道具的使用结果
function LuaMainPlayerBagMgr:IsCanUseSLEquip(bagItemInfo)
    ---@type TABLE.cfg_divinesuit
    local divineSuitTbl = Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo)
    if (divineSuitTbl == nil) then
        return LuaItemCanUseResult.None
    end
    if (divineSuitTbl:GetLevel() == 1 or Utility.GetItemTblByBagItemInfo(bagItemInfo):GetSubType() == LuaEquipmentItemType.POS_SL_FABAO) then
        return LuaItemCanUseResult.CanUse
    end
    local type = divineSuitTbl:GetType()
    ---@type LuaPlayerEquipmentListData
    local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(type, divineSuitTbl:GetSubType())
    ---穿戴套装需要先穿戴同等级或者高等级的法宝
    local index = Utility.GetSLEquipIndex(type, LuaEquipmentItemType.POS_SL_FABAO)
    ---@type LuaEquipDataItem
    local EquipDataItem = LuaPlayerEquipmentListData:GetEquipItem(index)
    if (EquipDataItem == nil or EquipDataItem.BagItemInfo == nil) then
        return LuaItemCanUseResult.NoEquipPrepositionSLFaBao
    end
    local faBaoDivineSuitTbl = Utility.GetDivineSuitTblByBagItemInfo(EquipDataItem.BagItemInfo)
    if (faBaoDivineSuitTbl == nil) then
        return LuaItemCanUseResult.NoEquipPrepositionSLFaBao
    end
    if (faBaoDivineSuitTbl:GetLevel() >= divineSuitTbl:GetLevel()) then
        return LuaItemCanUseResult.CanUse
    else
        return LuaItemCanUseResult.EquipSLFaBaoLevelNotEnough
    end
end

---主角是否能使用马牌暗器
---@type TABLE.cfg_items
function LuaMainPlayerBagMgr:IsCanUseMaPai_AnQi(luaItemTable)
    if luaItemTable == nil then
        return LuaItemCanUseResult.None
    end
    if luaItemTable ~= nil and luaItemTable:GetConditions() ~= nil then
        local list = luaItemTable:GetConditions().list
        if list ~= nil and #list >= 1 then
            ---@type LuaMatchConditionResult
            local data = Utility.IsMainPlayerMatchCondition(list[1])
            if data ~= nil and data.success == true then
                return LuaItemCanUseResult.CanUse
            end
        end
    end
    return LuaItemCanUseResult.None
end

---主角是否能使用法阵配件
---@param bagItemInfo bagV2.BagItemInfo lua的背包单位数据
function LuaMainPlayerBagMgr:IsCanUseZhenFaEquip(bagItemInfo)
    if bagItemInfo == nil then
        return LuaItemCanUseResult.None
    end
    local conditionResult = Utility.FaZhenUseParamCondition(bagItemInfo.itemId)
    if conditionResult.success then
        return LuaItemCanUseResult.CanUse
    end
    return LuaItemCanUseResult.None
end
--endregion

--region 外部调用ItemCompare(bagV2.BagItemInfo, bagV2.BagItemInfo) 比较道具是否右边的更好
---比较2个道具的好坏,注意啊,这里默认left,right都是不为空的,并且他们的subType一样  不然比个鬼啊
---@param left bagV2.BagItemInfo lua的背包单位数据
---@param right bagV2.BagItemInfo lua的背包单位数据
---@return boolean true:右边比左边好,false左边和右边一样或者左边比右边好
function LuaMainPlayerBagMgr:ItemCompare(left, right)
    if (right == nil) then
        return false
    end
    if (left == nil) then
        return true
    end
    ---@type TABLE.cfg_items
    local leftItemTbl = Utility.GetItemTblByBagItemInfo(left);
    ---@type TABLE.cfg_items
    local rightItemTbl = Utility.GetItemTblByBagItemInfo(right);
    if (leftItemTbl:GetSubType() ~= rightItemTbl:GetSubType()) then
        return false
    end
    --神力装备的比较
    if (leftItemTbl:GetDivineId() ~= nil and leftItemTbl:GetDivineId() ~= 0) then
        return self:ItemCompareSLEquip(left, right)
    end
    ---马牌比较
    if leftItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_maPai then
        return self:ItemCompareMaPaiEquip(leftItemTbl, rightItemTbl)
    end
    ---暗器比较
    if leftItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_AnQi then
        return self:ItemCompareAnQiEquip(leftItemTbl, rightItemTbl)
    end
    ---法阵比较
    if leftItemTbl:GetSubType() >= LuaEnumEquipSubType.Equip_zhenfa_1 and leftItemTbl:GetSubType() <= LuaEnumEquipSubType.Equip_zhenfa_4 then
        return self:ItemCompareZhenFaEquip(leftItemTbl, rightItemTbl)
    end
    return false
end

---比较马牌的好坏
---@param leftItemTbl TABLE.cfg_items
---@param rightItemTbl TABLE.cfg_items
---@return boolean
function LuaMainPlayerBagMgr:ItemCompareMaPaiEquip(leftItemTbl, rightItemTbl)
    ---@type TABLE.cfg_horse_card
    local left = clientTableManager.cfg_horse_cardManager:TryGetValue(leftItemTbl:GetId())
    ---@type TABLE.cfg_horse_card
    local right = clientTableManager.cfg_horse_cardManager:TryGetValue(rightItemTbl:GetId())
    if left == nil then
        return false
    end
    if right == nil then
        return true
    end
    return left:GetStage() < right:GetStage()
end

---比较暗器好坏
---@param leftItemTbl TABLE.cfg_items
---@param rightItemTbl TABLE.cfg_items
---@return boolean
function LuaMainPlayerBagMgr:ItemCompareAnQiEquip(leftItemTbl, rightItemTbl)
    ---@type TABLE.cfg_horse_card
    local left = clientTableManager.cfg_hidden_weaponManager:TryGetValue(leftItemTbl:GetId())
    ---@type TABLE.cfg_horse_card
    local right = clientTableManager.cfg_hidden_weaponManager:TryGetValue(rightItemTbl:GetId())
    if left == nil then
        return false
    end
    if right == nil then
        return true
    end
    return left:GetStage() < right:GetStage()
end

---比较法阵好坏
---@param leftItemTbl TABLE.cfg_items
---@param rightItemTbl TABLE.cfg_items
---@return boolean
function LuaMainPlayerBagMgr:ItemCompareZhenFaEquip(leftItemTbl, rightItemTbl)
    return leftItemTbl:GetNbValue() < rightItemTbl:GetNbValue()
end

---比较2个神力装备的好坏
---@param left bagV2.BagItemInfo lua的背包单位数据
---@param right bagV2.BagItemInfo lua的背包单位数据
---@return boolean true:右边比左边好,false左边和右边一样或者左边比右边好
function LuaMainPlayerBagMgr:ItemCompareSLEquip(left, right)
    --目前神力的比较就只需要单纯的比较套装等级就好了,没有浮动属性
    if (Utility.GetDivineSuitTblByBagItemInfo(right):GetLevel() > Utility.GetDivineSuitTblByBagItemInfo(left):GetLevel()) then
        return true
    end
    return false
end

--endregion


--region 神炼

--endregion

--endregion

--region 测试接口
---测试与C#背包数据的一致性
---@public
---@return boolean 是否与C#背包一致
function LuaMainPlayerBagMgr:TestCSBagComfirmly()
    if CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    local isSameBagData = true
    ---@type CSBagInfoV2
    local csBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    if Utility.GetTableCount(self:GetAllBagItemData()) ~= csBagInfo.BagItems.Count then
        print("BagItems.Count 不一致", "lua", Utility.GetTableCount(self:GetAllBagItemData()), "C#", csBagInfo.BagItems.Count)
        isSameBagData = false
    end
    if self:GetMaxGridCount() ~= csBagInfo.MaxGridCount then
        print("BagItems.MaxGridCount 不一致", "lua", self:GetMaxGridCount(), "C#", csBagInfo.MaxGridCount)
        isSameBagData = false
    end
    if self:GetEmptyGridCount() ~= csBagInfo.EmptyGridCount then
        print("BagItems.EmptyGridCount 不一致", "lua", self:GetEmptyGridCount(), "C#", csBagInfo.EmptyGridCount)
        isSameBagData = false
    end
    if self:GetAddGridCount() ~= csBagInfo.AddGridCount then
        print("BagItems.AddGridCount 不一致", "lua", self:GetAddGridCount(), "C#", csBagInfo.AddGridCount)
        isSameBagData = false
    end
    if self:GetBaoShiItemID() ~= csBagInfo.SpecialEquipID_BaoShi then
        print("BagItems.SpecialEquipID_BaoShi 不一致", "lua", self:GetBaoShiItemID(), "C#", csBagInfo.SpecialEquipID_BaoShi)
        isSameBagData = false
    end
    if self:GetChiYanDengXinItemID() ~= csBagInfo.SpecialEquipID_DengXin then
        print("BagItems.SpecialEquipID_DengXin 不一致", "lua", self:GetChiYanDengXinItemID(), "C#", csBagInfo.SpecialEquipID_DengXin)
        isSameBagData = false
    end
    if self:GetJinGongZhiYuanItemID() ~= csBagInfo.SpecialEquipID_JingGongZhiYuan then
        print("BagItems.SpecialEquipID_JingGongZhiYuan 不一致", "lua", self:GetJinGongZhiYuanItemID(), "C#", csBagInfo.SpecialEquipID_JingGongZhiYuan)
        isSameBagData = false
    end
    if self:GetShengMingJingPoItemID() ~= csBagInfo.SpecialEquipID_ShengMingJingPo then
        print("BagItems.SpecialEquipID_ShengMingJingPo 不一致", "lua", self:GetShengMingJingPoItemID(), "C#", csBagInfo.SpecialEquipID_ShengMingJingPo)
        isSameBagData = false
    end
    if self:GetShouHuZhiYuanItemID() ~= csBagInfo.SpecialEquipID_ShouHuZhiYuan then
        print("BagItems.SpecialEquipID_ShouHuZhiYuan 不一致", "lua", self:GetShouHuZhiYuanItemID(), "C#", csBagInfo.SpecialEquipID_ShouHuZhiYuan)
        isSameBagData = false
    end
    for i, v in pairs(self:GetAllBagItemData()) do
        local csBagItem = csBagInfo:GetBagItemBylId(i)
        if csBagItem == nil then
            print("c# bagitem not found", i)
            isSameBagData = false
        else
            if csBagItem.itemId ~= v.itemId then
                print("itemId 不一致", i, "lua", v.itemId, "C#", csBagItem.itemId)
                isSameBagData = false
            end
            if csBagItem.count ~= v.count then
                print("count 不一致", i, "lua", v.count, "C#", csBagItem.count)
                isSameBagData = false
            end
            if csBagItem.index ~= v.index then
                print("index 不一致", i, "lua", v.index, "C#", csBagItem.index)
                isSameBagData = false
            end
            if csBagItem.bind ~= v.bind then
                print("bind 不一致", i, "lua", v.bind, "C#", csBagItem.bind)
                isSameBagData = false
            end
            if csBagItem.bloodLevel ~= v.bloodLevel then
                print("bloodLevel 不一致", i, "lua", v.bloodLevel, "C#", csBagItem.bloodLevel)
                isSameBagData = false
            end
            if csBagItem.bagIndex ~= v.bagIndex then
                print("bagIndex 不一致", i, "lua", v.bagIndex, "C#", csBagItem.bagIndex)
                isSameBagData = false
            end
            if csBagItem.intensify ~= v.intensify then
                print("intensify 不一致", i, "lua", v.intensify, "C#", csBagItem.intensify)
                isSameBagData = false
            end
            if csBagItem.currentLasting ~= v.currentLasting then
                print("currentLasting 不一致", i, "lua", v.currentLasting, "C#", csBagItem.currentLasting)
                isSameBagData = false
            end
            if csBagItem.leftUseNum ~= v.leftUseNum then
                print("leftUseNum 不一致", i, "lua", v.leftUseNum, "C#", csBagItem.leftUseNum)
                isSameBagData = false
            end
        end
    end
    if isSameBagData then
        print("C#与lua背包数据大体上一致")
    else
        print("C#与lua背包数据不一致")
    end
    return isSameBagData
end
--endregion

--region 主角的背包回收数据
---背包回收数据
---@return LuaMainPlayerBagRecycleMgr
function LuaMainPlayerBagMgr:GetMainPlayerBagRecycleMgr()
    if self.mMainPlayerBagRecycleMgr == nil then
        self.mMainPlayerBagRecycleMgr = luaclass.LuaMainPlayerBagRecycleMgr:New()
    end
    return self.mMainPlayerBagRecycleMgr
end
--endregion

--region 查询
---@param itemId number 道具id
---@param num number 指定数量
---@return boolean 背包中物品是否大于等于指定数量
function LuaMainPlayerBagMgr:CheckBagHaveEnoughItem(itemId, num)
    local bagItemCount = self:GetItemAndMoneyCount(itemId)
    return bagItemCount ~= nil and bagItemCount >= num
end

---请求刷新物品每日使用次数
---@public
function LuaMainPlayerBagMgr:RequestRefreshItemUseCount()
    if self.mItemDayUseCounts == nil then
        return
    end
    for i, v in pairs(self.mItemDayUseCounts) do
        networkRequest.ReqDayUseItemCount(v.itemId)
    end
end

---通过itemid获取背包中所有的物品列表
---@return table<number,bagV2.BagItemInfo>
function LuaMainPlayerBagMgr:GetBagItemInfoListByItemId(itemId)
    local bagItemInfoList = {}
    for i, v in pairs(self:GetAllBagItemData()) do
        if v ~= nil and v.itemId == itemId then
            table.insert(bagItemInfoList, v)
        end
    end
    return bagItemInfoList
end
--endregion

function LuaMainPlayerBagMgr:OnUpdate()
    if self:GetMainPlayerBagRecycleMgr() then
        self:GetMainPlayerBagRecycleMgr():UpdateRecycle()
    end
end

return LuaMainPlayerBagMgr