---@class LuaServantEquipMgr 灵兽装备类
local LuaServantEquipMgr = {}

---@type table<number,LuaSingleServantEquipInfo>
LuaServantEquipMgr.mServantTypeToEquipData = nil
---@type table<LuaEnumEquipSubType,table<number>>
LuaServantEquipMgr.ServantRoleEquipIndexDic = nil

--region 服务器消息
---这个是所有灵兽的数据，会刷新所有装备数据
---@param allServantInfo servantV2.ResServantInfo
function LuaServantEquipMgr:OnResServantInfoReceived(allServantInfo)
    if allServantInfo and allServantInfo.serverts then
        for i = 1, #allServantInfo.serverts do
            ---@type servantV2.ServantInfo
            local servantInfo = allServantInfo.serverts[i]
            self:RefreshSingleServantEquipByEquipList(servantInfo.type, servantInfo.equips)
        end
    end
end

---刷新单个灵兽信息
---@param singleServantInfo  servantV2.ServantInfo
function LuaServantEquipMgr:OnResSingleServantInfoExMessageReceived(singleServantInfo)
    self:RefreshSingleServantEquipByEquipList(singleServantInfo.type, singleServantInfo.equips)
end

---装备掉落
---@param removeLid number 移除的装备lid
function LuaServantEquipMgr:OnResPlayerDieDropEquipByWearMessageReceived(removeLid)
    for k, v in pairs(luaEnumServantType) do
        local type = v
        local equipData = self:GetSingleServantEquipData(type)
        if equipData then
            if equipData:RemoveSingleEquipByLid(removeLid) then
                return
            end
        end
    end
end

---装备强化
---@param tblData bagV2.ResIntensify
function LuaServantEquipMgr:OnResIntensifyMessageReceived(tblData)
    if tblData == nil or tblData.equipInfo == nil or tblData.equipId == nil then
        return
    end
    self:RefreshSingleEquipByEquipIndex(tblData.equipId, tblData.equipInfo)
end

---@param tblData equipV2.ResRepairEquip
function LuaServantEquipMgr:OnResRepairEquipMessage(tblData)
    if tblData and tblData.bodyEquips and Utility.GetLuaTableCount(tblData.bodyEquips) > 0 then
        for i = 1, #tblData.bodyEquips do
            local equip = tblData.bodyEquips[i]
            if equip then

                self:RefreshSingleEquipByEquipIndex(equip.index, equip)
            end
        end
    end

    local key = LuaRedPointName.Repair_Servant
    local allKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(allKey);
end
--endregion

--region 刷新单个灵兽装备数据(知道灵兽类型的情况)
---根据装备列表刷新单个灵兽装备数据
---@param servantType luaEnumServantType 灵兽类型
---@param equipList table<number, bagV2.BagItemInfo> 装备
function LuaServantEquipMgr:RefreshSingleServantEquipByEquipList(servantType, equipList)
    if servantType == nil or equipList == nil then
        return
    end

    if self.mServantTypeToEquipData == nil then
        self.mServantTypeToEquipData = {}
    end
    local singleServantInfo = self.mServantTypeToEquipData[servantType]
    if singleServantInfo == nil then
        singleServantInfo = luaclass.LuaSingleServantEquipInfo:New()
        self.mServantTypeToEquipData[servantType] = singleServantInfo
    end
    singleServantInfo:SaveSingleEquipData(servantType, equipList)
end
--endregion

--region 刷新单个装备数据
---@param index number 装备位
---@param bagItemInfo bagV2.BagItemInfo 根据装备位刷新单个装备
function LuaServantEquipMgr:RefreshSingleEquipByEquipIndex(index, bagItemInfo)
    local type = self:GetServantTypeByEquipIndex(index)
    local equipInfo = self:GetSingleServantEquipData(type)
    if equipInfo then
        equipInfo:RefreshSingleEquipByEquipIndex(index,bagItemInfo)
    end
end
--endregion

--region 数据获取
---@return LuaSingleServantEquipInfo 单个灵兽装备数据
function LuaServantEquipMgr:GetSingleServantEquipData(servantType)
    if servantType == nil then
        return
    end
    if self.mServantTypeToEquipData == nil then
        return
    end
    return self.mServantTypeToEquipData[servantType]
end

---获取装备
---@param servantType LuaEnumServantSpeciesType 灵兽位
---@param equipIndexType LuaEnumServantEquipIndexType
---@return bagV2.BagItemInfo 根据装备位刷新单个装备
function LuaServantEquipMgr:GetEquip(servantType,equipIndexType)
    local singleServantEquipData = self:GetSingleServantEquipData(servantType)
    if singleServantEquipData == nil then
        return
    end
    return singleServantEquipData:GetEquipByEquipIndexType(equipIndexType)
end

---获取装备位
---@param servantType LuaEnumServantSpeciesType 灵兽位
---@param equipIndexType LuaEnumServantEquipIndexType
---@return number 装备位
function LuaServantEquipMgr:GetEquipIndex(servantType,equipIndexType)
    if type(servantType) ~= 'number' or type(equipIndexType) ~= 'number' then
        return -1
    end
    local extraAddValue = 200
    if equipIndexType == LuaEnumServantEquipIndexType.MagicEquip then
        extraAddValue = 0
    end
    return servantType * 1000 + extraAddValue +  equipIndexType
end

---@return number luaEnumServantType 根据装备位获得对应的灵兽类型
function LuaServantEquipMgr:GetServantTypeByEquipIndex(index)
    if index and index ~= 0 then
        return math.floor(index / 1000)
    end
    return 0
end

---@alias index number 装备位
---@return table<number,index>
---通过灵兽类型获得对应的所有装备位列表
---（灵兽法宝（伏魔之息）/项链/戒指（左右）/手镯（左右）/腰带/鞋子）
function LuaServantEquipMgr:GetSingleServantAllServantEquipIndex(servantType)
    if self.mServantTypeToAllEquipIndex == nil then
        self.mServantTypeToAllEquipIndex = {}
    end
    local equipData = self:GetSingleServantEquipData(servantType)
    if equipData then
        return equipData:GetAllEquipIndex()
    end
end

---获取物品可以穿戴的装备位
---@param itemId number
---@return table<number>
function LuaServantEquipMgr:GetServantEquipIndexByItemId(itemId)

end
--endregion

--region 测试接口
---测试与C#背包数据的一致性
---@public
---@return boolean 是否与C#背包一致
function LuaServantEquipMgr:TestCSServantComfirmly()
    ---@type CSMainPlayerInfo 主角数据
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return false
    end
    ---@type  CSServantInfoV2 灵兽数据
    local servantInfo = mainPlayerInfo.ServantInfoV2

    if servantInfo == nil then
        return false
    end

    local isSameBagData = true

    local csAllDic = servantInfo.ServantEquip

    local equipDicNum = 0
    local equipListNum = 0
    local equipLidDicNum = 0
    for k, v in pairs(luaEnumServantType) do
        local type = v
        local equipData = self:GetSingleServantEquipData(type)
        if equipData then
            equipDicNum = equipDicNum + Utility.GetTableCount(equipData.mEquipIndexToEquipDic)
            equipListNum = equipListNum + Utility.GetTableCount(equipData.mAllEquipList)
            equipLidDicNum = equipLidDicNum + Utility.GetTableCount(equipData.mLidToEquipDic)
        end
    end
    local CSharpNum = csAllDic.Count

    if equipDicNum ~= CSharpNum then
        print("灵兽装备Index对应的装备数目与C#不一致", "lua", equipDicNum, "C#", CSharpNum)
        isSameBagData = false
    end
    if equipListNum ~= CSharpNum then
        print("灵兽装备List数目与C#不一致", "lua", equipListNum, "C#", CSharpNum)
        isSameBagData = false
    end
    if equipLidDicNum ~= CSharpNum then
        print("灵兽装备Lid对应的装备数目与C#不一致", "lua", equipLidDicNum, "C#", CSharpNum)
        isSameBagData = false
    end
    for k, v in pairs(luaEnumServantType) do
        local type = v
        local equipData = self:GetSingleServantEquipData(type)
        if equipData then
            isSameBagData = self:CompareEquipIndex(csAllDic, equipData.mEquipIndexToEquipDic, "灵兽装备位对应装备列表")
            isSameBagData = self:CompareLidEquip(csAllDic, equipData.mLidToEquipDic, "灵兽Lid对应装备列表")
            isSameBagData = self:CompareLidEquip(csAllDic, equipData.mAllEquipList, "灵兽有序装备列表")
        end
    end
    if isSameBagData then
        print("C#与lua背包数据大体上一致")
    else
        print("C#与lua背包数据不一致")
    end
    return isSameBagData
end

---@param CSData table<number,bagV2.BagItemInfo> System.Collections.Generic.Dictionary2System.Int32bagV2.BagItemInfo
function LuaServantEquipMgr:CompareEquipIndex(CSData, LuaData, name)
    local isSameBagData = true
    for i, v in pairs(LuaData) do
        local index = i
        local luaBagItemInfo = v
        local res, csBagItem = CSData:TryGetValue(index)
        if res == false or res == nil then
            print(name .. "c#中不存在index的装备", index)
            return false
        else
            isSameBagData = self:CompareLuaAndCSharpData(csBagItem, luaBagItemInfo, name .. " Index为【" .. index .. "】的装备")
        end
    end
    return isSameBagData
end

---@param CSData table<number,bagV2.BagItemInfo> System.Collections.Generic.Dictionary2System.Int32bagV2.BagItemInfo
function LuaServantEquipMgr:CompareLidEquip(CSData, LuaData, name)
    local isSameBagData = true
    for i, v in pairs(LuaData) do
        local lid = i
        local luaBagItemInfo = v
        local res, csBagItem = CSData:TryGetValue(luaBagItemInfo.index)
        if res == false or res == nil and csBagItem.lid ~= lid then
            print(name .. "c#中装备位" .. luaBagItemInfo.index .. "的lid是", csBagItem.lid, "lua中是", lid)
            return false
        else
            isSameBagData = self:CompareLuaAndCSharpData(csBagItem, luaBagItemInfo, name .. " Lid为【" .. lid .. "】的装备")
        end
    end
    return isSameBagData
end

---比较C#和lua道具详细属性
function LuaServantEquipMgr:CompareLuaAndCSharpData(CSInfo, LuaInfo, name)
    local csBagItem = CSInfo
    local v = LuaInfo
    local isSameBagData = true
    if csBagItem.itemId ~= v.itemId then
        print(name, "itemId 不一致", "lua", v.itemId, "C#", csBagItem.itemId)
        isSameBagData = false
    end
    if csBagItem.count ~= v.count then
        print(name, "count 不一致", "lua", v.count, "C#", csBagItem.count)
        isSameBagData = false
    end
    if csBagItem.index ~= v.index then
        print(name, "index 不一致", "lua", v.index, "C#", csBagItem.index)
        isSameBagData = false
    end
    if csBagItem.bind ~= v.bind then
        print(name, "bind 不一致", "lua", v.bind, "C#", csBagItem.bind)
        isSameBagData = false
    end
    if csBagItem.bloodLevel ~= v.bloodLevel then
        print(name, "bloodLevel 不一致", "lua", v.bloodLevel, "C#", csBagItem.bloodLevel)
        isSameBagData = false
    end
    if csBagItem.bagIndex ~= v.bagIndex then
        print(name, "bagIndex 不一致", "lua", v.bagIndex, "C#", csBagItem.bagIndex)
        isSameBagData = false
    end
    if csBagItem.intensify ~= v.intensify then
        print(name, "intensify 不一致", "lua", v.intensify, "C#", csBagItem.intensify)
        isSameBagData = false
    end
    if csBagItem.currentLasting ~= v.currentLasting then
        print(name, "currentLasting 不一致", "lua", v.currentLasting, "C#", csBagItem.currentLasting)
        isSameBagData = false
    end
    if csBagItem.leftUseNum ~= v.leftUseNum then
        print(name, "leftUseNum 不一致", "lua", v.leftUseNum, "C#", csBagItem.leftUseNum)
        isSameBagData = false
    end
    return isSameBagData
end
--endregion

--region 通用查询
---是否是灵兽肉身
---@param itemId number
---@return boolean
function LuaServantEquipMgr:IsServantBody(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil then
        return CS.CSServantInfoV2.IsServantBody(itemTbl:GetSubType())
    end
    return false
end

---是否是灵兽生肖装备
---@param itemId number
---@return boolean
function LuaServantEquipMgr:IsServantJustEquip(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil then
        return CS.CSServantInfoV2.IsServantJustEquip(itemTbl:GetSubType())
    end
    return false
end

---是否是灵兽通用肉身装备
---@param itemId number
---@return boolean
function LuaServantEquipMgr:IsServantCommonBody(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil then
        return CS.CSServantInfoV2.IsServantCommonBody(itemTbl:GetSubType())
    end
    return false
end

---是否是灵兽法宝装备
---@param itemId number
---@return boolean
function LuaServantEquipMgr:IsServantMagicEquip(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil then
        return CS.CSServantInfoV2.IsServantMagicWeapon(itemTbl:GetSubType())
    end
    return false
end

---是否是灵兽人物装备
---@param itemId number
---@return boolean
function LuaServantEquipMgr:IsServantRoleEquip(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil then
        return CS.CSServantInfoV2.IsServantRoleEquip(itemTbl:GetSubType())
    end
    return false
end

---是否是灵兽使用的相关装备
---@param itemId number
---@return boolean
function LuaServantEquipMgr:IsServantEquip(itemId)
    return self:IsServantBody(itemId) or self:IsServantJustEquip(itemId) or self:IsServantCommonBody(itemId) or self:IsServantMagicEquip(itemId) or self:IsServantRoleEquip(itemId)
end

---是否是指定灵兽可以使用的装备
---@param servantSeatType luaEnumServantSeatType
---@param itemId number
---@return boolean
function LuaServantEquipMgr:ServantCanUseEquip(servantSeatType,itemId)
    local servantInfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantInfoByType(servantSeatType)
    if servantInfo == nil then
        return false
    end
    if self:IsServantEquip(itemId) == false then
        return false
    end
    return clientTableManager.cfg_itemsManager:ServantEquipCanEquiped(itemId,servantInfo)
end
--endregion

--region 灵兽人物装备
---获取灵兽校色装备位字典
---@return table<LuaEnumEquipSubType,table<number>>
function LuaServantEquipMgr:GetServantRoleEquipIndexDic()
    if self.ServantRoleEquipIndexDic == nil then
        local CSServantRoleEquipIndexDic = CS.CSServantInfoV2.ServantRoleEquipIndexDic
        if CSServantRoleEquipIndexDic ~= nil then
            self.ServantRoleEquipIndexDic = {}
            CS.Utility_Lua.luaForeachCsharp:Foreach(CSServantRoleEquipIndexDic, function(k, v)
                local equipIndexTable = Utility.CSListChangeTable(v)
                if equipIndexTable ~= nil then
                    self.ServantRoleEquipIndexDic[k] = equipIndexTable
                end
            end)
        end
    end
    return self.ServantRoleEquipIndexDic
end

---是否是灵兽角色装备位
---@param equipIndex number
---@return boolean
function LuaServantEquipMgr:IsServantRoleEquipIndex(equipIndex)
    if equipIndex == nil then
        return false
    end
    local servantRoleEquipIndexDic = self:GetServantRoleEquipIndexDic()
    if servantRoleEquipIndexDic == nil then
        return false
    end
    for k,v in pairs(servantRoleEquipIndexDic) do
        if v ~= nil then
            for a,b in pairs(v) do
                if equipIndex == b then
                    return true
                end
            end
        end
    end
    return false
end

---灵兽位是否可以使用人物装备
---@param servantSeatType luaEnumServantSeatType
---@param isOtherPlayer boolean
---@return boolean
function LuaServantEquipMgr:ServantIndexCanUseRoleEquip(servantSeatType,isOtherPlayer)
    return Utility.IsServantMatchConditionList_AND(LuaGlobalTableDeal.GetServantOpenRoleEquipConditionIdList(servantSeatType),isOtherPlayer).success
end

---获取同subType所有灵兽身上的最弱的装备
---@param subType LuaEnumEquipSubType
---@return bagV2.BagItemInfo
function LuaServantEquipMgr:GetServantLowEquipBySubType(subType)
    if type(self.mServantTypeToEquipData) ~= 'table' or subType == nil then
        return
    end
    local lowEquip = nil
    for k,v in pairs(self.mServantTypeToEquipData) do
        ---@type LuaSingleServantEquipInfo
        local singleServantEquipInfo = v
        local singleServantLowEquip = singleServantEquipInfo:GetServantLowEquipBySubType(subType)
        if singleServantLowEquip ~= nil and (lowEquip == nil or Utility.CompareServantEquip(lowEquip,singleServantLowEquip) == 1) then
            lowEquip = singleServantLowEquip
        end
    end
    return lowEquip
end

---通过装备位获取装备
---@param equipIndex
---@return bagV2.BagItemInfo/nil 装备
function LuaServantEquipMgr:GetEquipByEquipIndex(equipIndex)
    local servantType = self:GetServantTypeByEquipIndex(equipIndex)
    local servantEquipInfo = self:GetSingleServantEquipData(servantType)
    if servantEquipInfo == nil then
        return
    end
    return servantEquipInfo:GetSingleEquipByEquipIndex(equipIndex)
end
--endregion

return LuaServantEquipMgr