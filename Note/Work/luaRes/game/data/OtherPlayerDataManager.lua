---@class OtherPlayerDataManager 其他玩家的数据管理
local OtherPlayerDataManager = {}

---@type roleV2.RoleToOtherInfo lua table类型消息数据
OtherPlayerDataManager.RoleToOtherInfo = nil
---@type table<LuaEnumMagicEquipSuitType, LuaMagicEquipmentListData>
OtherPlayerDataManager.OtherRoleMagicEquipmentListDic = nil
---@type table<servantV2.OtherServantInfo>
OtherPlayerDataManager.OtherRoleServantInfoList = nil

---@type table<number, SoulEquipVo>
OtherPlayerDataManager.mEquipIndexToSoulEquipDic = nil;

---@type table<number>
OtherPlayerDataManager.mActiveSoulSuitIds = nil;

---@type table<LuaEnumGemEquipSuitType,LuaGemEquipmentListData> 宝物套装列表
OtherPlayerDataManager.GemEquipmentListDic = nil

---@type LuaZhenFaManager 阵法管理类
OtherPlayerDataManager.ZhenFaManager = nil

---@type LuaRecastMgr 重铸管理类
OtherPlayerDataManager.RecastMgr = nil

---@return LuaSoulEquipMgr
function OtherPlayerDataManager:GetLuaSoulEquipData()
    if (self.mLuaSoulEquipClass == nil) then
        self.mLuaSoulEquipClass = luaclass.LuaSoulEquipMgr:New();
    end
    return self.mLuaSoulEquipClass;
end

---@param tblData roleV2.RoleToOtherInfo lua table类型消息数据
function OtherPlayerDataManager:ResOtherRoleInfoMessage(tblData)
    self.RoleToOtherInfo = tblData;
    self.mCollectionInfo = nil
    if self.RoleToOtherInfo ~= nil then
        self:RefreshAllMagicEquipList(tblData.magicWeapon)
        self:InitBaseAndSLSuit(tblData.equipList)
        self:GetLuaSoulEquipData():UpdateAllSoulEquip(tblData.soulEquip)
        self:RefreshZhenFaInfo(tblData)
        self:RefreshZhenFaEquip(tblData.equipList)
        self:RefreshRecastMgr(tblData.resRecasts)
    end
end

---得到其他玩家的所有装备信息
---@return table<bagV2.BagItemInfo>
function OtherPlayerDataManager:GetOtherPlayerEquipInfo()
    if (self.RoleToOtherInfo == nil) then
        return nil
    end
    return self.RoleToOtherInfo.equipList
end

--得到其他玩家的会员等级
function OtherPlayerDataManager:GetVipLevel()
    if (self.RoleToOtherInfo == nil) then
        return nil or 0
    end
    if self.RoleToOtherInfo.vipMember == nil then
        return nil or 0
    end
    --print("vipMember == ",self.RoleToOtherInfo.vipMember.level)
    return self.RoleToOtherInfo.vipMember.level or 0
end

function OtherPlayerDataManager:GetOtherPlayerEquipInfoByLid(lid)
    if (self.RoleToOtherInfo == nil) then
        return nil
    end

    ---@param v bagV2.BagItemInfo
    for k, v in pairs(self.RoleToOtherInfo.equipList) do
        if (v.lid == lid) then
            return v;
        end
    end
    return nil
end

---藏品数据
---@return LuaCollectionInfo
function OtherPlayerDataManager:GetCollectionInfo()
    if self.mCollectionInfo == nil and self.RoleToOtherInfo ~= nil then
        self.mCollectionInfo = luaclass.LuaCollectionInfo:New(false, self.RoleToOtherInfo.career)
        self.mCollectionInfo:RefreshCabinetInfo(self.RoleToOtherInfo.cabinetInfo)
    end
    return self.mCollectionInfo
end


--region 基础套装+神力套装

---@type table<LuaEquipmentListType, LuaPlayerEquipmentListData>
OtherPlayerDataManager.EquipmentListDic = nil

---@param list table<bagV2.BagItemInfo> 所有装备的数据列表
function OtherPlayerDataManager:InitBaseAndSLSuit(list)
    self.EquipmentListDic = {}
    self.GemEquipmentListDic = {}
    local ShieldAndHatSuitList = self:GetShieldAndHatSuitListByShieldAndHatSuitType(LuaEnumShieldAndHatEquipSuitType.Normal)
    ShieldAndHatSuitList.ShieldAndHatEquipDataItemList = {}
    ---循环人物身上的所有装备
    for k, equip in pairs(list) do
        self:SetEquipItem(equip)
    end
end

---设置装备数据到指定列表清单中
---@param bagItemInfo bagV2.BagItemInfo  道具数据信息
function OtherPlayerDataManager:SetEquipItem(bagItemInfo, index)
    if (bagItemInfo == nil and index == nil) then
        return ;
    end
    if (bagItemInfo ~= nil and bagItemInfo.ItemTABLE == nil) then
        bagItemInfo.ItemTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    end
    if (index == nil and bagItemInfo ~= nil) then
        index = bagItemInfo.index
    end
    ---不在这个方法里面处理血迹相关
    if Utility.IsXJEquip(index) ~= LuaEquipBloodSuitType.None then
        return
    else
        local suitData = nil
        local subType = 1
        if (bagItemInfo.ItemTABLE ~= nil) then
            suitData = clientTableManager.cfg_divinesuitManager:TryGetValue(bagItemInfo.ItemTABLE:GetDivineId())
        end
        if (suitData ~= nil) then
            subType = suitData:GetSubType()
        end

        local type = Utility.IsSLEquip(index, true)

        local EquipmentList = self:GetEquipmentList(type, subType)
        --index = self:GetSLEquipBasicIndex(index)
        EquipmentList:SetEquipItem(index, bagItemInfo);
        self:RefreshGemEquip(index, bagItemInfo)
        self:RefreshShieldAndHatEquip(index, bagItemInfo)
    end
end

---传入装备列表列表类型,返回对的列表装备清单
---@param type LuaEquipmentListType lua枚举,装备的列表类型
---@param subType number 套装子类型
---@return LuaPlayerEquipmentListData 指定类型的装备清单
function OtherPlayerDataManager:GetEquipmentList(type, subType)
    if (self.EquipmentListDic[type] == nil) then
        self.EquipmentListDic[type] = luaclass.LuaPlayerEquipmentListData:New()
        self.EquipmentListDic[type]:InitDivineSuit(type, subType)
    elseif (self.EquipmentListDic[type]:GetAdditionDataList(subType) == nil) then
        self.EquipmentListDic[type]:RefreshDivineSuit(type, subType)
    end
    return self.EquipmentListDic[type]
end

---获取到所有神力的列表
---@return table<LuaPlayerEquipmentListData>
function OtherPlayerDataManager:GetAllSLEquipmentList()
    if (self.EquipmentListDic == nil) then
        return nil
    end
    local list = {}
    for i, v in pairs(self.EquipmentListDic) do
        if (v.EquipmentListType ~= LuaEquipmentListType.Base) then
            table.insert(list, v)
        end
    end
    return list
end

--endregion

--region 法宝
--region 刷新
---刷新所有法宝装备数据
---@param tblData equipV2.AllMagicWeaponInfo 服务器所有法宝数据
function OtherPlayerDataManager:RefreshAllMagicEquipList(tblData)
    self.OtherRoleMagicEquipmentListDic = {}
    if tblData == nil or tblData.allInfo == nil or type(tblData) ~= 'table' then
        return
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
end
--endregion

--region 获取
---通过法宝套装类型获取套装信息
---@param suitType LuaEnumMagicEquipSuitType 法宝套装类型
---@return LuaMagicEquipmentListData 法宝套装信息类
function OtherPlayerDataManager:GetMagicEquipListBySuitType(suitType)
    ---@type LuaMagicEquipmentListData 法宝套装信息类
    local suitInfoTable = self.OtherRoleMagicEquipmentListDic[suitType]
    if suitInfoTable == nil then
        suitInfoTable = luaclass.LuaMagicEquipmentListData:New()
        suitInfoTable:AnalysisSuitType(suitType)
        self.OtherRoleMagicEquipmentListDic[suitType] = suitInfoTable
    end
    return suitInfoTable
end

---通过装备位获取对应装备位的装备数据
---@param equipIndex number 装备位
---@return LuaMagicEquipDataItem 法宝装备信息类
function OtherPlayerDataManager:GetMagicEquipItemInfo(equipIndex)
    local equipType = clientTableManager.cfg_magicweaponManager:AnalysisTypeByEquipIndex(equipIndex)
    local equipListData = self:GetMagicEquipListBySuitType(equipType)
    if equipListData ~= nil then
        return equipListData:GetMagicEquipItemInfo(equipIndex)
    end
end

---获取需要显示的套装页签id表
---@return table 套装类型id表
function OtherPlayerDataManager:GetShowPageTable()
    if self.RoleToOtherInfo ~= nil and self.RoleToOtherInfo.magicWeapon ~= nil then
        return self.RoleToOtherInfo.magicWeapon.typed.typed
    end
end
--endregion

--region 查询
---是否是需要显示的套装类型
---@param suitType LuaEnumMagicEquipSuitType 套装类型
---@return boolean 是否显示
function OtherPlayerDataManager:IsShowSuitType(suitType)
    local showPageTable = self:GetShowPageTable()
    if showPageTable ~= nil and type(showPageTable) == 'table' then
        for k, v in pairs(showPageTable) do
            if v == suitType then
                return true
            end
        end
    end
    return false
end

---是否是其他人的法宝装备
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 是否是其他人身上的装备
function OtherPlayerDataManager:IsOtherPlayerMagicEquip(bagItemInfo)
    if bagItemInfo == nil or self.OtherRoleMagicEquipmentListDic == nil then
        return false
    end
    for k, v in pairs(self.OtherRoleMagicEquipmentListDic) do
        if v:IsContainItem(bagItemInfo) == true then
            return true
        end
    end
    return false
end
--endregion
--endregion

--region 宝物
--region 刷新
--region 宝物刷新
---刷新宝物装备
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function OtherPlayerDataManager:RefreshGemEquip(index, bagItemInfo)
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

---刷新盾牌斗笠装备
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function OtherPlayerDataManager:RefreshShieldAndHatEquip(index, bagItemInfo)
    if type(index) ~= 'number' or Utility:IsShieldAndHatEquipIndex(index) == false then
        return
    end
    ---当前宝物集合只有一类，所以写死Normal类型
    local ShieldAndHatSuitList = self:GetShieldAndHatSuitListByShieldAndHatSuitType(LuaEnumShieldAndHatEquipSuitType.Normal)
    if ShieldAndHatSuitList ~= nil then
        ShieldAndHatSuitList:RefreshShieldAndHatEquip(index, bagItemInfo)
    end
end
--endregion

--region 获取
---通过宝物套装类型获取宝物套装列表
---@param gemSuitType LuaEnumGemEquipSuitType
---@return LuaGemEquipmentListData
function OtherPlayerDataManager:GetGemSuitListByGemSuitType(gemSuitType)
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

---通过盾牌斗笠套装类型获取盾牌斗笠套装列表
---@param ShieldAndHatSuitType LuaEnumShieldAndHatEquipSuitType
---@return LuaShieldAndHatEquipmentListData
function OtherPlayerDataManager:GetShieldAndHatSuitListByShieldAndHatSuitType(ShieldAndHatSuitType)
    if self.ShieldAndHatEquipmentListDic == nil then
        self.ShieldAndHatEquipmentListDic = {}
    end
    local gemEquipmentListClass = self.ShieldAndHatEquipmentListDic[ShieldAndHatSuitType]
    if gemEquipmentListClass == nil then
        gemEquipmentListClass = luaclass.LuaShieldAndHatEquipmentListData:New()
        table.insert(self.ShieldAndHatEquipmentListDic, gemEquipmentListClass)
    end
    return gemEquipmentListClass
end
--endregion
--endregion


--region 其他玩家灵兽
--region 刷新
---@param tblData servantV2.ResOtherServantInfo lua table类型消息数据
function OtherPlayerDataManager:RefreshOtherPlayerServantList(tblData)
    if tblData == nil then
        return
    end
    self.OtherRoleServantInfoList = tblData.infos
end

--region 获取
---@param servantSeatType luaEnumServantSeatType
---@return servantV2.OtherServantInfo
function OtherPlayerDataManager:GetOtherServantInfoByServantSeatType(servantSeatType)
    if servantSeatType == nil or self.OtherRoleServantInfoList == nil then
        return
    end
    for k, v in pairs(self.OtherRoleServantInfoList) do
        ---@type servantV2.OtherServantInfo
        local otherServantInfo = v
        if otherServantInfo ~= nil and otherServantInfo.type == servantSeatType then
            return otherServantInfo
        end
    end
end
--endregion
--endregion


--endregion

--region 法阵装备
---获取阵法管理类
---@return LuaZhenFaManager
function OtherPlayerDataManager:GetZhenFaManager()
    if self.ZhenFaManager == nil then
        self.ZhenFaManager = luaclass.LuaZhenFaManager:New()
    end
    return self.ZhenFaManager
end

---刷新阵法信息
---@param zhenFaInfo zhenfaV2.ResZhenfaInfo
function OtherPlayerDataManager:RefreshZhenFaInfo(zhenFaInfo)
    self:GetZhenFaManager():OnResZhenfaInfoMessage(zhenFaInfo)
end

---刷新阵法装备
---@param bagItemInfoList table<bagV2.BagItemInfo>
function OtherPlayerDataManager:RefreshZhenFaEquip(bagItemInfoList)
    self:GetZhenFaManager():RefreshAllEquipByBagItemInfoList(bagItemInfoList)
end
--endregion

--region 斗笠盾牌
---获取斗笠盾牌管理类
---@return LuaShieldAndHatManager
function OtherPlayerDataManager:GetShieldAndHatManager()
    if self.OtherShieldAndHatManager == nil then
        self.OtherShieldAndHatManager = luaclass.ShieldAndHatManager:New()
    end
    return self.OtherShieldAndHatManager
end
--endregion

--region 重铸
---获取阵法管理类
---@return LuaRecastMgr
function OtherPlayerDataManager:GetRecastMgr()
    if self.RecastMgr == nil then
        self.RecastMgr = luaclass.LuaRecastMgr:New()
    end
    return self.RecastMgr
end

---刷新阵法管理类
---@param recastInfo equipV2.ResRecast lua table类型消息数据
function OtherPlayerDataManager:RefreshRecastMgr(recastInfo)
    if self.RoleToOtherInfo ~= nil then
        self:GetRecastMgr():RefreshRecastList(recastInfo, self.RoleToOtherInfo.career)
    end
end
--endregion

---传入装备列表列表类型,返回对的列表装备清单
---@param type LuaEquipmentListType lua枚举,装备的列表类型
---@param index LuaEquipmentItemType 装备所在基础下标值
---@param full boolean 这个装备位是否为基础下标
---@return LuaEquipDataItem 指定类型的装备清单内指定道具
function OtherPlayerDataManager:GetEquipmentItem(type, index, ful, subType)
    local EquipmentList = self:GetEquipmentList(type, subType)
    if (EquipmentList.EquipmentListType ~= LuaEquipmentListType.Base and (full == nil or full == false)) then
        index = self:GetSLEquipIndex(EquipmentList.EquipmentListType, index)
    end
    return EquipmentList:GetEquipItem(index)
end

--region 各种装备的装备位获取
---得到神力装备的装备位
---@param type 神力的套装类型
---@param itemSubType 道具表里面的SubType字段
---@param isRight 是否为右手装备
function OtherPlayerDataManager:GetSLEquipIndex(type, itemSubType, isRight)
    return Utility.GetSLEquipIndex(type, itemSubType, isRight)
end

return OtherPlayerDataManager