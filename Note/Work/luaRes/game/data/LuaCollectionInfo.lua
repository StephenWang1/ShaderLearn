---主角藏品数据
---@class LuaCollectionInfo:luaobject
local LuaCollectionInfo = {}

local doTest = false

--region 静态方法
---获取收藏品坐标(一个只读坐标)
---@alias CollectionCoord {x:number, y:number}
---@param x number 必须为整数,就算传入小数也会向下转换为整数
---@param y number 必须为整数,就算传入小数也会向下转换为整数
---@return CollectionCoord
function LuaCollectionInfo.GetCollectionCoordinate(x, y)
    if x == nil then
        x = 0
    else
        x = math.floor(x)
    end
    if y == nil then
        y = 0
    else
        y = math.floor(y)
    end
    local coordinates = LuaCollectionInfo.mCollectionCoordinates
    if coordinates == nil then
        coordinates = {}
        LuaCollectionInfo.mCollectionCoordinates = coordinates
    end
    local id = (x << 32) + y
    if coordinates[id] ~= nil then
        return coordinates[id]
    else
        local coordinateTemp = { x = x, y = y }
        coordinateTemp = LuaCollectionInfo.ConvertToReadOnly(coordinateTemp)
        coordinates[id] = coordinateTemp
        return coordinateTemp
    end
end

---转换为只读table
---@private
---@param tbl table
---@return table
function LuaCollectionInfo.ConvertToReadOnly(tbl)
    local newTable = {}
    local metaTable = {}
    metaTable.__index = tbl
    if LuaCollectionInfo.EmptyNewIndexFunc == nil then
        LuaCollectionInfo.EmptyNewIndexFunc = function()
        end
    end
    metaTable.__newindex = LuaCollectionInfo.EmptyNewIndexFunc
    metaTable.__tostring = function(tblTemp)
        return Utility.CombineStringQuickly(" (", tblTemp.x, ", ", tblTemp.y, ")")
    end
    setmetatable(newTable, metaTable)
    return newTable
end

---获取每页的收藏格子数量(常量)
---@return number
function LuaCollectionInfo.GetCollectionGridCountPerPage()
    return 64
end

---获取每列的收藏格子数量(常量)
---@return number
function LuaCollectionInfo.GetCollectionGridCountPerColumn()
    return 8
end

---获取每行的收藏格子数量(常量)
---@return number
function LuaCollectionInfo.GetCollectionGridCountPerLine()
    return 8
end

---获取藏品珍稀度的总值(常量)
---@return number
function LuaCollectionInfo.GetCollectionRarenessSummary()
    return 9
end

---获取藏品珍稀度,珍稀度与归属者无关,是一个纯二次数值属性
---@param bagItem bagV2.BagItemInfo
---@return number
function LuaCollectionInfo.GetRarenessOfCollection(bagItem)
    ---珍稀度分级为1~9，用属性的上限值（当上限值为0时，用下限值）来判断,分级规则为：
    ---珍稀度等级 =（实际随到的属性上限-属性上限随机范围的最小值）/((属性上限随机范围的最大值-属性上限随机范围的最小值)/9)
    ---当一件藏品有多条属性时，最终藏品珍稀度数值取各条属性珍稀度的平均值（最后结果有小数时，四舍五入取整）
    if bagItem == nil or bagItem.itemId == nil then
        return 0
    end
    local isLuaTable = type(bagItem) == "table"
    local collectionTbl = clientTableManager.cfg_collectionManager:TryGetValue(bagItem.itemId)
    if collectionTbl == nil then
        return 0
    end
    ---珍稀度计算的数量
    local summaryRarenessCount = 0
    ---珍稀度总值
    local summaryRareness = 0

    --limit表示随机值的左极限和右极限

    --region 计算攻击的珍稀度
    local atkPhy = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.PhyAttackMax, isLuaTable)
    local atkPhyLeftLimit = 0
    local atkPhyRightLimit = 0
    ---@type TABLE.IntListJingHao
    local phyAtkListTemp
    if atkPhy ~= 0 then
        phyAtkListTemp = collectionTbl:GetPhyAttMax()
    else
        atkPhy = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.PhyAttackMin, isLuaTable)
        phyAtkListTemp = collectionTbl:GetPhyAttMin()
    end
    if phyAtkListTemp ~= nil and phyAtkListTemp.list ~= nil and #phyAtkListTemp.list > 0 then
        atkPhyLeftLimit = phyAtkListTemp.list[1]
        atkPhyRightLimit = phyAtkListTemp.list[2]
    end
    if atkPhyLeftLimit == atkPhyRightLimit then
        if atkPhyLeftLimit ~= 0 then
            ---如果左极限等于右极限,且均不为0,认为珍稀度达到最大值,给一个9
            summaryRarenessCount = summaryRarenessCount + 1
            summaryRareness = summaryRareness + LuaCollectionInfo.GetCollectionRarenessSummary()
        end
    else
        summaryRarenessCount = summaryRarenessCount + 1
        summaryRareness = summaryRareness + LuaCollectionInfo.CalculateRoundOfNumber(LuaCollectionInfo.GetCollectionRarenessSummary() * (atkPhy - atkPhyLeftLimit) / (atkPhyRightLimit - atkPhyLeftLimit))
    end
    --endregion

    --region 计算魔法的珍稀度
    local atkMagic = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.MagicAttackMax, isLuaTable)
    local atkMagicLeftLimit = 0
    local atkMagicRightLimit = 0
    ---@type TABLE.IntListJingHao
    local atkMagicListTemp
    if atkMagic ~= 0 then
        atkMagicListTemp = collectionTbl:GetMagicAttMax()
    else
        atkMagic = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.MagicAttackMin, isLuaTable)
        atkMagicListTemp = collectionTbl:GetMagicAttMin()
    end
    if atkMagicListTemp ~= nil and atkMagicListTemp.list ~= nil and #atkMagicListTemp.list > 0 then
        atkMagicLeftLimit = atkMagicListTemp.list[1]
        atkMagicRightLimit = atkMagicListTemp.list[2]
    end
    if atkMagicLeftLimit == atkMagicRightLimit then
        if atkMagicLeftLimit ~= 0 then
            ---如果左极限等于右极限,且均不为0,认为珍稀度达到最大值,给一个9
            summaryRarenessCount = summaryRarenessCount + 1
            summaryRareness = summaryRareness + LuaCollectionInfo.GetCollectionRarenessSummary()
        end
    else
        summaryRarenessCount = summaryRarenessCount + 1
        summaryRareness = summaryRareness + LuaCollectionInfo.CalculateRoundOfNumber(LuaCollectionInfo.GetCollectionRarenessSummary() * (atkMagic - atkMagicLeftLimit) / (atkMagicRightLimit - atkMagicLeftLimit))
    end
    --endregion

    --region 计算道术的珍稀度
    local atkTao = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.TaoAttackMax, isLuaTable)
    local atkTaoLeftLimit = 0
    local atkTaoRightLimit = 0
    ---@type TABLE.IntListJingHao
    local atkTaoListTemp
    if atkTao ~= 0 then
        atkTaoListTemp = collectionTbl:GetTaoAttMax()
    else
        atkTao = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.TaoAttackMin, isLuaTable)
        atkTaoListTemp = collectionTbl:GetTaoAttMin()
    end
    if atkTaoListTemp ~= nil and atkTaoListTemp.list ~= nil and #atkTaoListTemp.list > 0 then
        atkTaoLeftLimit = atkTaoListTemp.list[1]
        atkTaoRightLimit = atkTaoListTemp.list[2]
    end
    if atkTaoLeftLimit == atkTaoRightLimit then
        if atkTaoLeftLimit ~= 0 then
            ---如果左极限等于右极限,且均不为0,认为珍稀度达到最大值,给一个9
            summaryRarenessCount = summaryRarenessCount + 1
            summaryRareness = summaryRareness + LuaCollectionInfo.GetCollectionRarenessSummary()
        end
    else
        summaryRarenessCount = summaryRarenessCount + 1
        summaryRareness = summaryRareness + LuaCollectionInfo.CalculateRoundOfNumber(LuaCollectionInfo.GetCollectionRarenessSummary() * (atkTao - atkTaoLeftLimit) / (atkTaoRightLimit - atkTaoLeftLimit))
    end
    --endregion

    --region 计算物防的珍稀度
    local def = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.PhyDefenceMax, isLuaTable)
    local defLeftLimit = 0
    local defRightLimit = 0
    ---@type TABLE.IntListJingHao
    local defListTemp
    if def ~= 0 then
        defListTemp = collectionTbl:GetPhyDefMax()
    else
        def = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.PhyDefenceMin, isLuaTable)
        defListTemp = collectionTbl:GetPhyDefMin()
    end
    if defListTemp ~= nil and defListTemp.list ~= nil and #defListTemp.list > 0 then
        defLeftLimit = defListTemp.list[1]
        defRightLimit = defListTemp.list[2]
    end
    if defLeftLimit == defRightLimit then
        if defLeftLimit ~= 0 then
            ---如果左极限等于右极限,且均不为0,认为珍稀度达到最大值,给一个9
            summaryRarenessCount = summaryRarenessCount + 1
            summaryRareness = summaryRareness + LuaCollectionInfo.GetCollectionRarenessSummary()
        end
    else
        summaryRarenessCount = summaryRarenessCount + 1
        summaryRareness = summaryRareness + LuaCollectionInfo.CalculateRoundOfNumber(LuaCollectionInfo.GetCollectionRarenessSummary() * (def - defLeftLimit) / (defRightLimit - defLeftLimit))
    end
    --endregion

    --region 计算魔防的珍稀度
    local magicDef = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.MagicDefenceMax, isLuaTable)
    local magicDefLeftLimit = 0
    local magicDefRightLimit = 0
    ---@type TABLE.IntListJingHao
    local magicDefListTemp
    if magicDef ~= 0 then
        magicDefListTemp = collectionTbl:GetMagicDefMax()
    else
        magicDef = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.MagicDefenceMin, isLuaTable)
        magicDefListTemp = collectionTbl:GetMagicDefMin()
    end
    if magicDefListTemp ~= nil and magicDefListTemp.list ~= nil and #magicDefListTemp.list > 0 then
        magicDefLeftLimit = magicDefListTemp.list[1]
        magicDefRightLimit = magicDefListTemp.list[2]
    end
    if magicDefLeftLimit == magicDefRightLimit then
        if magicDefLeftLimit ~= 0 then
            ---如果左极限等于右极限,且均不为0,认为珍稀度达到最大值,给一个9
            summaryRarenessCount = summaryRarenessCount + 1
            summaryRareness = summaryRareness + LuaCollectionInfo.GetCollectionRarenessSummary()
        end
    else
        summaryRarenessCount = summaryRarenessCount + 1
        summaryRareness = summaryRareness + LuaCollectionInfo.CalculateRoundOfNumber(LuaCollectionInfo.GetCollectionRarenessSummary() *
                (magicDef - magicDefLeftLimit) / (magicDefRightLimit - magicDefLeftLimit))
    end
    --endregion

    --region 计算血量珍稀度
    local hp = LuaCollectionInfo.GetCollectionItemAttribute(bagItem, LuaEnumAttributeType.MaxHp, isLuaTable)
    local hpLeftLimit = 0
    local hpRightLimit = 0
    if hp ~= 0 then
        if collectionTbl:GetHp() ~= nil and collectionTbl:GetHp().list ~= nil and #collectionTbl:GetHp().list > 0 then
            hpLeftLimit = collectionTbl:GetHp().list[1]
            hpRightLimit = collectionTbl:GetHp().list[2]
        end
    end
    if hpLeftLimit == hpRightLimit then
        if hpLeftLimit ~= 0 then
            ---如果左极限等于右极限,且均不为0,认为珍稀度达到最大值,给一个9
            summaryRarenessCount = summaryRarenessCount + 1
            summaryRareness = summaryRareness + LuaCollectionInfo.GetCollectionRarenessSummary()
        end
    else
        summaryRarenessCount = summaryRarenessCount + 1
        summaryRareness = summaryRareness + LuaCollectionInfo.CalculateRoundOfNumber(LuaCollectionInfo.GetCollectionRarenessSummary() * (hp - hpLeftLimit) / (hpRightLimit - hpLeftLimit))
    end
    --endregion

    ---计算总珍稀度
    if summaryRarenessCount > 0 then
        ---返回四舍五入的珍稀度平均值
        return LuaCollectionInfo.CalculateRoundOfNumber(summaryRareness / summaryRarenessCount)
    end
    return 0
end

---@public
---获取藏品物品的属性
---@param bagItem bagV2.BagItemInfo
---@param attributeType LuaEnumAttributeType
---@param isLuaTable boolean|nil
---@return number
function LuaCollectionInfo.GetCollectionItemAttribute(bagItem, attributeType, isLuaTable)
    if bagItem == nil or attributeType == nil then
        return 0
    end
    if bagItem.rateAttribute == nil then
        return 0
    end
    if isLuaTable == nil then
        isLuaTable = type(bagItem) == "table"
    end
    if isLuaTable then
        if bagItem.rateAttribute ~= nil then
            for i = 1, #bagItem.rateAttribute do
                local rateAttribute = bagItem.rateAttribute[i]
                if rateAttribute.type == attributeType then
                    return rateAttribute.num
                end
            end
        end
    else
        if bagItem.rateAttribute ~= nil then
            for i = 1, bagItem.rateAttribute.Count do
                local rateAttribute = bagItem.rateAttribute[i - 1]
                if rateAttribute.type == attributeType then
                    return rateAttribute.num
                end
            end
        end
    end
    return 0
end

---四舍五入
---@param num number
---@return number
function LuaCollectionInfo.CalculateRoundOfNumber(num)
    if num < 0 then
        return math.floor(num - 0.5)
    end
    return math.floor(num + 0.5)
end
--endregion

--region 藏品数据
---藏品柜等级,服务器数据不存在时返回0
---@return number
function LuaCollectionInfo:GetCabinetLevel()
    return self.mCabinetLevel or 0
end

---藏品柜经验值,服务器数据不存在时返回0
---@return number
function LuaCollectionInfo:GetCabinetExp()
    return self.mCabinetExp or 0
end

---藏品柜生效的连锁效果ID,指向cfg_linkeffect表,服务器数据不存在时返回nil
---@return table<number, number>|nil
function LuaCollectionInfo:GetLinkEffectIDList()
    return self.mLinkEffectIDList
end

---获取藏品列表,唯一ID => 藏品物品 的映射
---@return table<number, LuaCollectionItem>
function LuaCollectionInfo:GetCollectionDic()
    if self.mCollectionDic == nil then
        self.mCollectionDic = {}
    end
    return self.mCollectionDic
end

---获取藏品页,页索引 => 藏品页中藏品物品列表,页索引从1开始
---@return table<number, table<number, LuaCollectionItem>>
function LuaCollectionInfo:GetCollectionPageList()
    if self.mPageCollectionItems == nil then
        ---@type table<number, table<number, LuaCollectionItem>>
        self.mPageCollectionItems = {}
    end
    return self.mPageCollectionItems
end

---获取已解锁的格子数量(根据cfg_collectionbox表和当前的服务器等级数据计算得到),默认返回一页
---@return number
function LuaCollectionInfo:GetUnlockedGridCount()
    return self.mUnlockedGridCount or 0
end

---获取空格子数量(已解锁格子数量减去各个藏品所占用的格子总数量)
---@return number
function LuaCollectionInfo:GetEmptyGridCount()
    return self.mEmptyGridCount or 0
end

---获取总格子数量(根据cfg_collectionbox表和当前的服务器等级数据得到的已解锁格子数量,使用得到的页数乘以每页的格子数量得到总格子数量),服务器数据为nil是返回0
---@return number
function LuaCollectionInfo:GetSummaryGridCount()
    return self.mSummaryGridCount or 0
end

---获取归属者的职业
---@return LuaEnumCareer
function LuaCollectionInfo:GetCareer()
    return self.mOwnerCareer
end

---获取历史藏品ID集合
---@return table<number, boolean>
function LuaCollectionInfo:GetHistoryCollectionItems()
    if self.mHistoryCollectionItems == nil then
        self.mHistoryCollectionItems = {}
    end
    return self.mHistoryCollectionItems
end
--endregion

--region 初始化
---@param isOwnedByMainPlayer boolean|nil 是否是主角的藏品
---@param career LuaEnumCareer 归属者的职业
function LuaCollectionInfo:Init(isOwnedByMainPlayer, career)
    self.mIsOwnedByMainPlayer = isOwnedByMainPlayer
    self.mOwnerCareer = career
end
--endregion

--region 藏品列表
---刷新藏品列表
---@private
---@param collectionItems table<number, bagV2.BagItemInfo>
function LuaCollectionInfo:RefreshCollectionList(collectionItems)
    ---刷新藏品列表
    --清空列表
    local collectionDic = self:GetCollectionDic()
    for i, v in pairs(collectionDic) do
        collectionDic[i] = nil
    end
    --将消息中藏品重新填入列表
    ---被藏品占据的格子数量
    ---@type number
    self.occupiedGridCount = 0
    if collectionItems then
        for i = 1, #collectionItems do
            local collectionItem = collectionItems[i]
            if collectionItem and collectionDic[collectionItem.lid] == nil then
                local collectionItemTemp = luaclass.LuaCollectionItem:New(collectionItem)
                collectionDic[collectionItem.lid] = collectionItemTemp
                if self.mIsOwnedByMainPlayer and collectionItem.itemId ~= nil then
                    self:GetHistoryCollectionItems()[collectionItem.itemId] = true
                end
                local borderX, borderY = collectionItemTemp:GetBorderSize()
                self.occupiedGridCount = self.occupiedGridCount + borderX * borderY
            end
        end
    end
    --清空所有页列表中的物品
    for pageIndex, pageList in pairs(self:GetCollectionPageList()) do
        for i = #pageList, 1, -1 do
            pageList[i] = nil
        end
    end
    --将物品加入到页队列中
    for lid, collectionItem in pairs(collectionDic) do
        local pageIndex = collectionItem:GetPageIndex()
        if pageIndex ~= -1 then
            local pageItemList = self:GetCollectionPageList()[pageIndex]
            if pageItemList == nil then
                pageItemList = {}
                self:GetCollectionPageList()[pageIndex] = pageItemList
            end
            table.insert(pageItemList, collectionItem)
        end
    end
    self:RefreshGridInfo()
    if self.mIsOwnedByMainPlayer then
        ---发送客户端消息
        luaEventManager.DoCallback(LuaCEvent.CollectionInfoUpdate)
    end
end

---增加藏品物品
---@private
---@param bagItem bagV2.BagItemInfo
function LuaCollectionInfo:AddCollectionItem(bagItem)
    if bagItem == nil or bagItem.lid == nil then
        return
    end
    local lid = bagItem.lid
    self:RemoveCollectionItem(lid)
    local collectionItem = luaclass.LuaCollectionItem:New(bagItem)
    self:GetCollectionDic()[lid] = collectionItem
    if self.mIsOwnedByMainPlayer and bagItem.itemId ~= nil then
        self:GetHistoryCollectionItems()[bagItem.itemId] = true
    end
    local pageIndex = collectionItem:GetPageIndex()
    local page = self:GetCollectionPageList()[pageIndex]
    if page == nil then
        page = {}
        self:GetCollectionPageList()[pageIndex] = page
    end
    table.insert(page, collectionItem)
    ---刷新占用的格子数量
    local borderSizeX, borderSizeY = collectionItem:GetBorderSize()
    if self.occupiedGridCount ~= nil then
        self.occupiedGridCount = self.occupiedGridCount + borderSizeX * borderSizeY
    else
        self.occupiedGridCount = borderSizeX * borderSizeY
    end
    self:RefreshGridInfo()
    if self.mIsOwnedByMainPlayer then
        ---发送客户端消息
        luaEventManager.DoCallback(LuaCEvent.CollectionInfoUpdate)
    end
end

---移除藏品物品
---@private
---@param bagItemLid number
function LuaCollectionInfo:RemoveCollectionItem(bagItemLid)
    if self:GetCollectionDic()[bagItemLid] ~= nil then
        ---从字典和页列表中移除
        local collectionItem = self:GetCollectionDic()[bagItemLid]
        local pageIndexTemp = collectionItem:GetPageIndex()
        local pageItemListTemp = self:GetCollectionPageList()[pageIndexTemp]
        if pageItemListTemp then
            for i = 1, #pageItemListTemp do
                if pageItemListTemp[i]:GetCollectionLid() == bagItemLid then
                    table.remove(pageItemListTemp, i)
                    break
                end
            end
        end
        self:GetCollectionDic()[bagItemLid] = nil
        if self.occupiedGridCount ~= nil then
            local borderSizeX, borderSizeY = collectionItem:GetBorderSize()
            self.occupiedGridCount = self.occupiedGridCount - borderSizeX * borderSizeY
        else
            self.occupiedGridCount = 0
        end
        self:RefreshGridInfo()
        if self.mIsOwnedByMainPlayer then
            ---发送客户端消息
            luaEventManager.DoCallback(LuaCEvent.CollectionInfoUpdate)
        end
    end
end

---刷新格子信息
---@private
function LuaCollectionInfo:RefreshGridInfo()
    ---刷新已解锁格子数量
    local collectionBoxTbl
    if self.mCabinetLevel ~= nil then
        collectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(self.mCabinetLevel)
    end
    if collectionBoxTbl then
        self.mUnlockedGridCount = collectionBoxTbl:GetOpenBox()
    else
        self.mUnlockedGridCount = 0
    end
    ---刷新空格子数量
    if self.occupiedGridCount ~= nil then
        self.mEmptyGridCount = self.mUnlockedGridCount - self.occupiedGridCount
        if self.mEmptyGridCount < 0 then
            self.mEmptyGridCount = 0
        end
    else
        self.mEmptyGridCount = self.mUnlockedGridCount
    end
    ---刷新藏品格子总数量,总数量 = 页数 * 单页格子数量
    self.mSummaryGridCount = math.ceil(self.mUnlockedGridCount / LuaCollectionInfo.GetCollectionGridCountPerPage())
            * LuaCollectionInfo.GetCollectionGridCountPerPage()
end
--endregion

--region 网络事件
---刷新藏品柜数据
---@param tblData collect.CabinetInfo
function LuaCollectionInfo:RefreshCabinetInfo(tblData)
    if tblData == nil then
        return
    end
    if self.mIsOwnedByMainPlayer then
        local isFirstTime = false
        if self.mIsInitialized == nil then
            self.mIsInitialized = true
            isFirstTime = true
        end
        ---不是第一次的情况下才处理连锁属性的增减
        if isFirstTime == false then
            ---检查少了哪些连锁属性,如果多了,发消息
            if self.mLinkEffectIDList ~= nil then
                for i = 1, #self.mLinkEffectIDList do
                    local idTemp = self.mLinkEffectIDList[i]
                    if tblData.linkEffects ~= nil then
                        local isRemoved = true
                        for j = 1, #tblData.linkEffects do
                            if tblData.linkEffects[j] == idTemp then
                                isRemoved = false
                                break
                            end
                        end
                        if isRemoved then
                            luaEventManager.DoCallback(LuaCEvent.LinkEffectRemoved, idTemp)
                        end
                    else
                        luaEventManager.DoCallback(LuaCEvent.LinkEffectRemoved, idTemp)
                    end
                end
            end
            ---检查多了哪些连锁属性,如果多了,发消息
            if tblData.linkEffects ~= nil then
                for i = 1, #tblData.linkEffects do
                    local idTemp = tblData.linkEffects[i]
                    if self.mLinkEffectIDList ~= nil then
                        local isAdded = true
                        for j = 1, #self.mLinkEffectIDList do
                            if self.mLinkEffectIDList[j] == idTemp then
                                isAdded = false
                                break
                            end
                        end
                        if isAdded then
                            luaEventManager.DoCallback(LuaCEvent.LinkEffectAdded, idTemp)
                        end
                    else
                        luaEventManager.DoCallback(LuaCEvent.LinkEffectAdded, idTemp)
                    end
                end
            end
        end
    end
    self.mCabinetLevel = tblData.level
    self.mCabinetExp = tblData.exp
    self.mLinkEffectIDList = tblData.linkEffects
    ---刷新藏品格子列表
    self:RefreshCollectionList(tblData.collectionItems)
    if self.mIsOwnedByMainPlayer then
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection))
    end
end

---藏品上架响应
---@param tblData collect.PutCollectionItemMsg
function LuaCollectionInfo:ResPutCollectionItem(tblData)
    if tblData == nil then
        return
    end
    self:AddCollectionItem(tblData.item)
    if self.mIsOwnedByMainPlayer then
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection))
    end
end

---藏品下架响应
---@param tblData collect.RemoveCollectionItemMsg
function LuaCollectionInfo:ResRemoveCollectionItem(tblData)
    if tblData == nil then
        return
    end
    self:RemoveCollectionItem(tblData.itemId)
    if self.mIsOwnedByMainPlayer then
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection))
    end
end

---藏品交换位置响应
---@param tblData collect.CabinetInfo
function LuaCollectionInfo:ResSwapCollectionItem(tblData)
    self:RefreshCabinetInfo(tblData)
    if self.mIsOwnedByMainPlayer then
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection))
    end
end

---藏品回收响应
---@param tblData collect.CallbackCollectionMsg
function LuaCollectionInfo:ResCallbackCollection(tblData)
    if tblData == nil then
        return
    end
    self:RefreshCabinetInfo(tblData.cabinet)
    if self.mIsOwnedByMainPlayer then
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection))
    end
end
--endregion

--region 红点
---红点是否需要显示
---@public
function LuaCollectionInfo:IsRedPointShouldExist()
    if self.mIsOwnedByMainPlayer ~= true then
        return false
    end

    local isOpen = self:IsMainPlayerCollectionOpened()
    if isOpen == false then
        return false
    end

    ---如果背包中有藏品阁中未上架但是可以上架的物品,则显示红点
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr() ~= nil then
        local bagItems = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetAllBagItemData()
        local collectionTblMgr = clientTableManager.cfg_collectionManager
        for i, v in pairs(bagItems) do
            local itemTbl = Utility.GetItemTblByBagItemInfo(v)
            if itemTbl and itemTbl:GetType() == luaEnumItemType.Collection then
                if clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemTbl:GetId()) == LuaEnumUseItemParam.CanUse then
                    if self:GetCollectionItemByCollectionID(itemTbl:GetId()) == nil then
                        local collectionTbl = collectionTblMgr:TryGetValue(itemTbl:GetId())
                        if collectionTbl ~= nil and self:FetchSuitablePositionForCollection(collectionTbl) ~= nil then
                            return true
                        end
                    end
                end
            end
        end
    end
    ---如果当前藏品阁经验足以升级,则显示红点
    if self:IsCanLevelUp() then
        return true
    end
    return false
end
--endregion

--region 查询
---暴力遍历以获取一个合适的位置来放置藏品,返回pageIndex, x, y，如果返回的是nil则表示未找到合适的位置
---@param collectionTable TABLE.cfg_collection
---@param ignoreLid1 number|nil 需要忽略的唯一ID
---@param ignoreLid2 number|nil 需要忽略的唯一ID
---@return number|nil,number|nil,number|nil
function LuaCollectionInfo:FetchSuitablePositionForCollection(collectionTable, ignoreLid1, ignoreLid2)
    local pages = math.ceil(self:GetUnlockedGridCount() / LuaCollectionInfo.GetCollectionGridCountPerPage())
    for i = 1, pages do
        local pageIndexTemp = i
        ---先行后列
        for yTemp = 0, LuaCollectionInfo.GetCollectionGridCountPerColumn() - 1 do
            for xTemp = 0, LuaCollectionInfo.GetCollectionGridCountPerLine() - 1 do
                if self:IsCollectionItemCanBePutOnPosition(collectionTable, pageIndexTemp, xTemp, yTemp, ignoreLid1, ignoreLid2) then
                    return pageIndexTemp, xTemp, yTemp
                end
            end
        end
    end
end

---根据藏品ID获取对应的藏品物品
---@param collectionID number
---@return LuaCollectionItem
function LuaCollectionInfo:GetCollectionItemByCollectionID(collectionID)
    if collectionID == nil then
        return nil
    end
    for i, v in pairs(self:GetCollectionDic()) do
        if v:GetCollectionTable() ~= nil and v:GetCollectionTable():GetItemId() == collectionID then
            return v
        end
    end
end
--endregion

--region 藏品操作
---尝试请求商家藏品物品
---@public
---@param bagItemInfo bagV2.BagItemInfo
---@param pageIndex number|nil 页索引,从1开始,传入nil的话将暴力遍历可放的位置
---@param x number|nil 页中格子的横坐标,从1开始,传入nil的话将暴力遍历可放的位置
---@param y number|nil 页中格子的纵坐标,从1开始,传入nil的话将暴力遍历可放的位置
---@param sendNetMsg boolean|nil 是否发送网络消息
---@return boolean, string
function LuaCollectionInfo:TryReqPutOnCollectionItem(bagItemInfo, pageIndex, x, y, sendNetMsg)
    if doTest then
        print("---------------------- TryReqPutOnCollectionItem -----------------------")
    end
    ---如果不是主角的藏品数据,则没有权限处理
    if self.mIsOwnedByMainPlayer ~= true then
        if doTest then
            print("TryReqPutOnCollectionItem 0")
        end
        return false
    end
    local isOpened, failReason = self:IsMainPlayerCollectionOpened()
    if isOpened == false then
        return isOpened, failReason
    end
    ---参数,表格数据检查,规避非藏品物品
    if bagItemInfo == nil then
        if doTest then
            print("TryReqPutOnCollectionItem 1")
        end
        return false
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if itemTbl == nil or itemTbl:GetType() ~= luaEnumItemType.Collection then
        if doTest then
            print("TryReqPutOnCollectionItem 2")
        end
        return false
    end
    local isCanUseItem = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(bagItemInfo.itemId)
    if isCanUseItem ~= LuaEnumUseItemParam.CanUse then
        if isCanUseItem == LuaEnumUseItemParam.UseLvNotEnough then
            return false, "人物等级不足"
        elseif isCanUseItem == LuaEnumUseItemParam.UseReinLvNotEnough then
            return false, "人物转生等级不足"
        end
        return false
    end
    ---藏品表
    local collectionTable = clientTableManager.cfg_collectionManager:TryGetValue(bagItemInfo.itemId)
    ---检查该物品是否已上架
    local collectionItemInCabinet = self:GetCollectionDic()[bagItemInfo.lid]
    local isBagItemInCabinet = collectionItemInCabinet ~= nil
    ---藏品阁中已上架的另一个同种物品
    ---@type LuaCollectionItem
    local sameItem
    if isBagItemInCabinet == false then
        sameItem = self:GetCollectionItemByCollectionID(collectionTable:GetItemId())
    end
    ---如果输入一个目标坐标,则暴力寻找一个坐标
    if pageIndex == nil or x == nil or y == nil then
        if isBagItemInCabinet then
            ---如果一个物品本来就在藏品阁中且未输入一个坐标,则不处理,因为是无用操作
            if doTest then
                print("TryReqPutOnCollectionItem 3")
            end
            return false
        end
        if sameItem ~= nil then
            ---如果该物品不在藏宝阁中且已有一个相同的物品在藏宝阁中,则请求上架替换掉它
            if sendNetMsg then
                if doTest then
                    print("TryReqPutOnCollectionItem 4")
                end
                return networkRequest.ReqPutCollectionItem(bagItemInfo.lid, sameItem:GetPageIndex(),
                        sameItem:GetOriginCoordinate().x, sameItem:GetOriginCoordinate().y)
            else
                if doTest then
                    print("TryReqPutOnCollectionItem 5")
                end
                return true
            end
        end
        ---从藏品阁中找到一个合适的位置
        pageIndex, x, y = self:FetchSuitablePositionForCollection(collectionTable)
        if pageIndex == nil or x == nil or y == nil then
            ---如果没有找到合适的位置,则弹出提示且不执行操作
            if self:GetEmptyGridCount() < collectionTable:GetXSize() * collectionTable:GetYSize() then
                ---如果空格子不够,则弹出提示
                if doTest then
                    print("TryReqPutOnCollectionItem 6")
                end
                return false, "藏品阁空间不足"
            else
                if doTest then
                    print("TryReqPutOnCollectionItem 7")
                end
                return false, "合理排序藏品位置，才可摆放该藏品"
            end
        end
    else
        ---如果藏品在藏宝阁中且输入的坐标与当前坐标一致,则不返回true但是不进行任何操作
        if isBagItemInCabinet and collectionItemInCabinet:GetPageIndex() == pageIndex and collectionItemInCabinet:GetOriginCoordinate().x == x
                and collectionItemInCabinet:GetOriginCoordinate().y == y then
            if doTest then
                print("TryReqPutOnCollectionItem 8")
            end
            return true
        end
        ---如果藏品不在藏品阁中,而藏品阁中已经有一个同itemID的物品,且指定了坐标,若坐标不同,不能执行操作,若坐标相同,则执行替换操作
        if sameItem ~= nil then
            if (sameItem:GetOriginCoordinate().x ~= x or sameItem:GetOriginCoordinate().y ~= y or sameItem:GetPageIndex() ~= pageIndex) then
                ---如果坐标不同,则替换掉它
                if doTest then
                    print("TryReqPutOnCollectionItem 9")
                end
                return false, "已上架相同藏品"
            else
                ---如果坐标相同,则替换掉它
                if sendNetMsg then
                    if doTest then
                        print("TryReqPutOnCollectionItem 10")
                    end
                    return networkRequest.ReqPutCollectionItem(bagItemInfo.lid, sameItem:GetPageIndex(),
                            sameItem:GetOriginCoordinate().x, sameItem:GetOriginCoordinate().y)
                    --return networkRequest.ReqSwapCollectionItem(bagItemInfo.lid, sameItem:GetPageIndex(),
                    --        sameItem:GetOriginCoordinate().x, sameItem:GetOriginCoordinate().y)
                else
                    if doTest then
                        print("TryReqPutOnCollectionItem 11")
                    end
                    return true
                end
            end
        end
    end
    ---逻辑执行到这里,藏品阁中已有一个同itemID、不同lid的藏品的情况已经处理过了,替换同itemID的藏品的相关情况已经处理,此处处理上架逻辑
    if self:IsCollectionItemCanBePutOnPosition(collectionTable, pageIndex, x, y, bagItemInfo.lid) then
        ---如果该藏品可以被放置在该坐标上,根据目标bagItemInfo的实际状态,决定处理方案
        if isBagItemInCabinet then
            ---如果目标在藏品阁中,尝试交换位置
            if sendNetMsg then
                if doTest then
                    print("TryReqPutOnCollectionItem 12")
                end
                return networkRequest.ReqSwapCollectionItem(bagItemInfo.lid, pageIndex, x, y)
            else
                if doTest then
                    print("TryReqPutOnCollectionItem 13")
                end
                return true
            end
        else
            ---如果目标不在藏品阁中,则请求上架该物品
            if sendNetMsg then
                if doTest then
                    print("TryReqPutOnCollectionItem 14")
                end
                return networkRequest.ReqPutCollectionItem(bagItemInfo.lid, pageIndex, x, y)
            else
                if doTest then
                    print("TryReqPutOnCollectionItem 15")
                end
                return true
            end
        end
    else
        ---如果藏品不能放在该坐标上,查询如果移动过去之后所占据的格子中,是否会有格子被其他藏品占据,如果仅仅被一个藏品占据,则尝试交换位置,
        ---如果有两个及两个以上的藏品占据了该格子,则不能交换位置
        local newOriginCoord = luaclass.LuaCollectionInfo.GetCollectionCoordinate(x, y)
        if self.mCoordListTemp == nil then
            ---@type table<number, CollectionCoord>
            self.mCoordListTemp = {}
        end
        ---计算新占据的格子列表
        luaclass.LuaCollectionItem.CalculateCoordListBySize(newOriginCoord, collectionTable:GetXSize(), collectionTable:GetYSize(), self.mCoordListTemp)
        ---目标页
        local pageItemListTemp = self:GetCollectionPageList()[pageIndex]
        ---可能会替换的藏品物品
        ---@type LuaCollectionItem
        local anotherCollectionItem
        ---获取新占据的格子当前被哪些藏品占据,如果干涉的藏品超过了2个,则不能执行替换操作
        if pageItemListTemp ~= nil then
            ---遍历新占据的格子
            for i = 1, #self.mCoordListTemp do
                ---遍历藏品列表
                for j = 1, #pageItemListTemp do
                    local collectionItemTemp = pageItemListTemp[j]
                    ---忽略待处理的藏品
                    if collectionItemTemp ~= nil and collectionItemTemp:GetCollectionLid() ~= bagItemInfo.lid then
                        local coords = collectionItemTemp:GetCoords()
                        ---遍历坐标列表
                        for k = 1, #coords do
                            if self.mCoordListTemp[i] == coords[k] then
                                ---如果该藏品与待处理的藏品有坐标干涉
                                if anotherCollectionItem ~= nil and anotherCollectionItem ~= collectionItemTemp then
                                    ---如果干涉的藏品超过两个,则认为不能替换
                                    if doTest then
                                        print("TryReqPutOnCollectionItem 16")
                                    end
                                    return false, "该藏品不能放在这个位置"
                                else
                                    anotherCollectionItem = collectionItemTemp
                                end
                            end
                        end
                    end
                end
            end
        end
        if anotherCollectionItem == nil then
            ---被替换的藏品为空,说明新的格子没有占据任何现有藏品位置,因为之前校验错误,故此处应判定为不能进行此操作
            if doTest then
                print("TryReqPutOnCollectionItem 17")
            end
            return false, "该藏品不能放在这个位置"
        else
            ---新占据的格子与现有的某个藏品发生了干涉
            if isBagItemInCabinet then
                ---如果该物品已在藏品阁中,检查是否可以将被干涉的藏品挪到该物品所在的位置
                ---藏品阁中待操作物品的信息
                ---@type LuaCollectionItem
                local operatedCollectionItem = collectionItemInCabinet
                if self:IsCollectionItemCanBePutOnPosition(collectionTable, pageIndex, x, y, bagItemInfo.lid, anotherCollectionItem:GetCollectionLid())
                        and self:IsCollectionItemCanBePutOnPosition(anotherCollectionItem:GetCollectionTable(),
                        operatedCollectionItem:GetPageIndex(),
                        operatedCollectionItem:GetOriginCoordinate().x,
                        operatedCollectionItem:GetOriginCoordinate().y,
                        operatedCollectionItem:GetCollectionLid(),
                        anotherCollectionItem:GetCollectionLid()) then
                    ---如果被干涉的物品可以顺利挪到当前操作的物品所在的位置,检查两者交换位置后是否有重叠部分,如果有,则还是认为不可以交换位置
                    ---如果将待操作的物品挪到被干涉的物品所在位置后的新的坐标列表
                    local previousSimulateCoords = operatedCollectionItem:GetSimulateCoords(x, y)
                    ---如果将被干涉的物品挪到待操作的物品所在位置后的新的坐标列表
                    local newOccupiedSimulateCoords = anotherCollectionItem:GetSimulateCoords(operatedCollectionItem:GetOriginCoordinate().x,
                            operatedCollectionItem:GetOriginCoordinate().y)
                    ---交换位置后是否有重叠格子
                    local isOverLapping = false
                    ---坐标ID缓冲
                    self:ClearCache()
                    for i = 1, #previousSimulateCoords do
                        self:AddToCache(previousSimulateCoords[i].x, previousSimulateCoords[i].y)
                    end
                    for i = 1, #newOccupiedSimulateCoords do
                        if self:IsInCache(newOccupiedSimulateCoords[i].x, newOccupiedSimulateCoords[i].y) then
                            isOverLapping = true
                        end
                    end
                    if isOverLapping then
                        return false, "该藏品不能放在这个位置"
                    else
                        if sendNetMsg then
                            if doTest then
                                print("TryReqPutOnCollectionItem 18")
                            end
                            return networkRequest.ReqSwapCollectionItem(bagItemInfo.lid, pageIndex, x, y)
                        else
                            if doTest then
                                print("TryReqPutOnCollectionItem 19")
                            end
                            return true
                        end
                    end
                else
                    ---如果被干涉的物品不能顺利挪到当前操作的物品所在的位置,则认为其不能执行交换位置操作
                    if doTest then
                        print("TryReqPutOnCollectionItem 20")
                    end
                    return false, "该藏品不能放在这个位置"
                end
            else
                ---如果该物品不在藏品阁中,则认为其不能进行替换操作
                if doTest then
                    print("TryReqPutOnCollectionItem 21")
                end
                return false, "该藏品不能放在这个位置"
            end
        end
    end
    if doTest then
        print("TryReqPutOnCollectionItem 22")
    end
    return false
end

---请求下架藏品物品
---@public
function LuaCollectionInfo:ReqPutOffCollectionItem(bagItemLid)
    if self.mIsOwnedByMainPlayer ~= true then
        return
    end
    if bagItemLid == nil then
        return
    end
    local collectionItem = self:GetCollectionDic()[bagItemLid]
    if collectionItem ~= nil then
        networkRequest.ReqRemoveCollectionItem(bagItemLid, collectionItem:GetServerIndex())
    end
end

---请求升级藏品阁
---@public
function LuaCollectionInfo:ReqLevelUpCabinet()
    if self.mIsOwnedByMainPlayer ~= true then
        return
    end
    local level = self:GetCabinetLevel()
    local currentLevelCollectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(level)
    local nextLevelCollectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(level + 1)
    if nextLevelCollectionBoxTbl == nil then
        ---已满级
        return
    end
    if self:GetCabinetExp() >= nextLevelCollectionBoxTbl:GetRequired() then
        networkRequest.ReqUpgradeCabinet()
    end
end

---返回是否可以升级及是否因为已满级而不可升级
---@public
---@return boolean, boolean 是否可以升级;  是否已满级
function LuaCollectionInfo:IsCanLevelUp()
    local level = self:GetCabinetLevel()
    local currentLevelCollectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(level)
    local nextLevelCollectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(level + 1)
    if nextLevelCollectionBoxTbl == nil then
        ---已满级
        return false, true
    end
    if self:GetCabinetExp() >= nextLevelCollectionBoxTbl:GetRequired() then
        return true, false
    end
    return false, false
end
--endregion

--region 藏品开启条件
---主角藏品是否开启/不开启原因
---@return boolean,string,string,string 开启状态，未开启的气泡文本描述，未开启的图片名,未开启的图片后缀名
function LuaCollectionInfo:IsMainPlayerCollectionOpened()
    if self.mCollectionOpenConditionTbls == nil then
        self.mCollectionOpenConditionTbls = {}
        ---@type TABLE.CFG_GLOBAL
        local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22377)
        if tbl then
            local strs = string.Split(tbl.value, '&')
            for i = 1, #strs do
                local strs1 = string.Split(strs[i], '#')
                if #strs1 > 1 then
                    local tagID = tonumber(strs1[1])
                    if tagID == LuaEnumLeftTagType.UICollectionPanel then
                        for j = 2, #strs1 do
                            local conditionID = tonumber(strs1[j])
                            table.insert(self.mCollectionOpenConditionTbls, conditionID)
                        end
                        break
                    end
                end
            end
        end
    end
    local isOpen,popoStr,spriteName,spriteNameDes = LuaGlobalTableDeal:MainPlayerIsOpenCollection()
    if isOpen == false then
        return isOpen,popoStr,spriteName,spriteNameDes
    end
    local conditionMgr = CS.Cfg_ConditionManager.Instance
    for i = 1, #self.mCollectionOpenConditionTbls do
        local conditionID = self.mCollectionOpenConditionTbls[i]
        if conditionMgr:IsMainPlayerMatchCondition(conditionID) == false then
            ---@type TABLE.CFG_CONDITIONS
            local conditionTblExist, conditionTbl = conditionMgr:TryGetValue(conditionID)
            local str
            if conditionTbl ~= nil then
                str = "系统未开放"
            end
            return false, str
        end
    end
    return true
end
--endregion

--region 藏品对比
---左侧的是否比右侧的好(仅仅限于同itemID的物品)
---@param leftCollectionBagItem bagV2.BagItemInfo
---@param rightCollectionBagItem bagV2.BagItemInfo
---@return boolean
function LuaCollectionInfo:IsLeftBetterThanRight(leftCollectionBagItem, rightCollectionBagItem)
    if leftCollectionBagItem == nil then
        return false
    end
    if rightCollectionBagItem == nil then
        return true
    end
    ---先对比攻击值,再对比珍稀度,最后对比其他属性
    local leftIsLuaTbl = type(leftCollectionBagItem) == "table"
    local rightIsLuaTbl = type(rightCollectionBagItem) == "table"

    --region 对比攻击
    local leftAtkMax = 0
    local rightAtkMax = 0
    local leftAtkMin = 0
    local rightAtkMin = 0
    if self:GetCareer() == LuaEnumCareer.Warrior then
        leftAtkMin = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.PhyAttackMin, leftIsLuaTbl)
        leftAtkMax = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.PhyAttackMax, leftIsLuaTbl)
        rightAtkMin = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.PhyAttackMin, rightIsLuaTbl)
        rightAtkMax = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.PhyAttackMax, rightIsLuaTbl)
    elseif self:GetCareer() == LuaEnumCareer.Master then
        leftAtkMin = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.MagicAttackMin, leftIsLuaTbl)
        leftAtkMax = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.MagicAttackMax, leftIsLuaTbl)
        rightAtkMin = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.MagicAttackMin, rightIsLuaTbl)
        rightAtkMax = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.MagicAttackMax, rightIsLuaTbl)
    elseif self:GetCareer() == LuaEnumCareer.Taoist then
        leftAtkMin = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.TaoAttackMin, leftIsLuaTbl)
        leftAtkMax = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.TaoAttackMax, leftIsLuaTbl)
        rightAtkMin = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.TaoAttackMin, rightIsLuaTbl)
        rightAtkMax = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.TaoAttackMax, rightIsLuaTbl)
    end

    if leftAtkMin + leftAtkMax ~= rightAtkMin + rightAtkMax then
        return (leftAtkMin + leftAtkMax) > (rightAtkMin + rightAtkMax)
    end
    --endregion

    local leftRareness = LuaCollectionInfo.GetRarenessOfCollection(leftCollectionBagItem)
    local rightRareness = LuaCollectionInfo.GetRarenessOfCollection(rightCollectionBagItem)
    if leftRareness ~= rightRareness then
        ---如果藏品珍稀度不同,以珍稀度为准
        return leftRareness > rightRareness
    else
        ---如果藏品珍稀度相同,按照物防-魔防-生命的顺序进行对比,先对比属性值上限再对比属性值下限

        --region 对比物防
        local leftPhyDefMax = 0
        local rightPhyDefMax = 0
        local leftPhyDefMin = 0
        local rightPhyDefMin = 0
        leftPhyDefMax = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.PhyDefenceMax, leftIsLuaTbl)
        rightPhyDefMax = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.PhyDefenceMax, rightIsLuaTbl)
        leftPhyDefMin = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.PhyDefenceMin, leftIsLuaTbl)
        rightPhyDefMin = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.PhyDefenceMin, rightIsLuaTbl)

        if leftPhyDefMin + leftPhyDefMax ~= rightPhyDefMin + rightPhyDefMax then
            return (leftPhyDefMin + leftPhyDefMax) > (rightPhyDefMin + rightPhyDefMax)
        end
        --endregion

        --region 对比魔防
        local leftMagicDefMax = 0
        local rightMagicDefMax = 0
        local leftMagicDefMin = 0
        local rightMagicDefMin = 0
        leftMagicDefMax = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.MagicDefenceMax, leftIsLuaTbl)
        rightMagicDefMax = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.MagicDefenceMax, rightIsLuaTbl)
        leftMagicDefMin = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.MagicDefenceMin, leftIsLuaTbl)
        rightMagicDefMin = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.MagicDefenceMin, rightIsLuaTbl)

        if leftMagicDefMin + leftMagicDefMax ~= rightMagicDefMin + rightMagicDefMax then
            return (leftMagicDefMin + leftMagicDefMax) > (rightMagicDefMin + rightMagicDefMax)
        end
        --endregion

        --region 对比HP
        local leftHPMax = 0
        local rightHPMax = 0
        leftHPMax = LuaCollectionInfo.GetCollectionItemAttribute(leftCollectionBagItem, LuaEnumAttributeType.MaxHp, leftIsLuaTbl)
        rightHPMax = LuaCollectionInfo.GetCollectionItemAttribute(rightCollectionBagItem, LuaEnumAttributeType.MaxHp, rightIsLuaTbl)
        return leftHPMax > rightHPMax
        --endregion
    end
end
--endregion

--region 校验缓存
---@private
function LuaCollectionInfo:ClearCache()
    if self.mCoordDic == nil then
        ---@type table<number, boolean>
        self.mCoordDic = {}
    end
    for i, v in pairs(self.mCoordDic) do
        self.mCoordDic[i] = false
    end
end

---@private
---@param x number
---@param y number
function LuaCollectionInfo:AddToCache(x, y)
    if self.mCoordDic == nil then
        ---@type table<number, boolean>
        self.mCoordDic = {}
    end
    self.mCoordDic[x * 100 + y] = true
end

---@private
---@param x number
---@param y number
---@return boolean
function LuaCollectionInfo:IsInCache(x, y)
    if self.mCoordDic == nil then
        ---@type table<number, boolean>
        self.mCoordDic = {}
    end
    return self.mCoordDic[x * 100 + y] == true
end
--endregion

--region 校验
---藏品物品是否可以被放在某个坐标上,仅仅校验坐标
---@param collectionTable TABLE.cfg_collection collection表数据
---@param pageIndex number 页索引,从1开始
---@param x number 页中格子的横坐标,从0开始
---@param y number 页中格子的纵坐标,从0开始
---@param ignoreLid1 number|nil 需要忽略的唯一ID
---@param ignoreLid2 number|nil 需要忽略的唯一ID
---@return boolean
function LuaCollectionInfo:IsCollectionItemCanBePutOnPosition(collectionTable, pageIndex, x, y, ignoreLid1, ignoreLid2)
    if doTest then
        print("------------------------- IsCollectionItemCanBePutOnPosition ------------------------------")
        print("pageIndex", pageIndex, " (" .. tostring(x) .. ", " .. tostring(y) .. ")", "size", collectionTable:GetXSize() .. " * " .. collectionTable:GetYSize())
    end
    if collectionTable == nil or pageIndex == nil or x == nil or y == nil then
        if doTest then
            print("IsCollectionItemCanBePutOnPosition 0")
        end
        return false
    end
    self:ClearCache()
    ---遍历该物品将要占据的坐标,如果有某个坐标未解锁,则认为不能将该藏品物品放在改坐标
    for dx = 1, collectionTable:GetXSize() do
        for dy = 1, collectionTable:GetYSize() do
            local xTemp = x + dx - 1
            local yTemp = y + dy - 1
            if self:IsCoordUnlocked(pageIndex, xTemp, yTemp) == false then
                ---如果某个坐标未解锁,则返回false
                if doTest then
                    print("IsCollectionItemCanBePutOnPosition 1:", pageIndex, xTemp, yTemp)
                end
                return false
            else
                self:AddToCache(xTemp, yTemp)
            end
        end
    end
    ---遍历本页已有的藏品集合
    local pageCollectionItemList = self:GetCollectionPageList()[pageIndex]
    if pageCollectionItemList ~= nil then
        ---如果该页的藏品列表中有某一个非忽略ID的藏品占据了上述坐标,则认为无法放在这个坐标上
        for i = 1, #pageCollectionItemList do
            local itemTemp = pageCollectionItemList[i]
            if itemTemp:GetCollectionLid() ~= ignoreLid1 and itemTemp:GetCollectionLid() ~= ignoreLid2 then
                local coords = pageCollectionItemList[i]:GetCoords()
                for j = 1, #coords do
                    local coordTemp = coords[j]
                    if self:IsInCache(coordTemp.x, coordTemp.y) then
                        if doTest then
                            print("IsCollectionItemCanBePutOnPosition 2:", tostring(coordTemp))
                        end
                        return false
                    end
                end
            end
        end
    end
    if doTest then
        print("IsCollectionItemCanBePutOnPosition 3")
    end
    return true
end

---某个坐标是否已经解锁,解锁坐标时是按照2格一个单位,从上到下,从左到右解锁的
---@param pageIndex number 页索引,从1开始
---@param x number 页中格子的横坐标,从0开始
---@param y number 页中格子的纵坐标,从0开始
function LuaCollectionInfo:IsCoordUnlocked(pageIndex, x, y)
    ---坐标越界检查
    if x < 0 or x >= LuaCollectionInfo.GetCollectionGridCountPerLine() then
        return false
    end
    if y < 0 or y >= LuaCollectionInfo.GetCollectionGridCountPerColumn() then
        return false
    end
    ---最大页索引,从1开始
    local maxPageIndex = math.ceil(self:GetUnlockedGridCount() / LuaCollectionInfo.GetCollectionGridCountPerPage())
    ---页数超页检查
    if pageIndex < 1 or pageIndex > maxPageIndex then
        return false
    end
    ---坐标解锁检查
    ---如果不是最后一页,那么肯定是解锁的格子
    if pageIndex < maxPageIndex then
        return true
    end
    ---最后一页解锁的格子数量
    local gridsInThisPage = self:GetUnlockedGridCount() - (maxPageIndex - 1) * LuaCollectionInfo.GetCollectionGridCountPerPage()
    local unlockCellWidth = 2
    local indexTemp = (math.floor(x / unlockCellWidth)) * LuaCollectionInfo.GetCollectionGridCountPerColumn() * unlockCellWidth
            + unlockCellWidth * y + (x % unlockCellWidth)
    return indexTemp < gridsInThisPage
end
--endregion

--region 析构
function LuaCollectionInfo:OnDestroy()

end
--endregion

return LuaCollectionInfo