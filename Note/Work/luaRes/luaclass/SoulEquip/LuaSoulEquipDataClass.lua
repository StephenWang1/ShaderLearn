---@class LuaSoulEquipDataClass
local LuaSoulEquipDataClass = {};

---@type table<number, LuaSoulEquipVo>
LuaSoulEquipDataClass.mEquipIndexToSoulEquipDic = nil;

---@type table<number>
LuaSoulEquipDataClass.mActiveSoulSuitIds = nil;

function LuaSoulEquipDataClass:Init()
    self.mEquipIndexToSoulEquipDic = {};
    self.mActiveSoulSuitIds = {};
end

function LuaSoulEquipDataClass:GetEquipIndexList()
    if (self.mEquipIndexList == nil) then
        self.mEquipIndexList = {};
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_HEAD));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_BELT));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_SHOES));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING));
    end
    return self.mEquipIndexList;
end

---@public 更新所有魂装镶嵌数据
---@param tblData equipV2.AllSoulEquipInfo
function LuaSoulEquipDataClass:UpdateSoulEquipSetInfo(tblData)
    self.mEquipIndexToSoulEquipDic = {};
    if tblData and tblData.soulEquips then
        self.mActiveSoulSuitIds = tblData.activeSuitId;
        ---@param v equipV2.SoulEquip
        for k, v in pairs(tblData.soulEquips) do
            if (self.mEquipIndexToSoulEquipDic[v.index] == nil) then
                self.mEquipIndexToSoulEquipDic[v.index] = luaclass.LuaSoulEquipVo:New();
            end
            self.mEquipIndexToSoulEquipDic[v.index]:UpdateVo(v);
        end
    end

    ---手动初始化，解锁中间格子
    if (tblData and tblData.type == LuaEnumSoulEquipType.XianZhuang) then
        local SoulEquipIndexList = self:GetEquipIndexList()
        if type(SoulEquipIndexList) == 'table' and Utility.GetLuaTableCount(SoulEquipIndexList) > 0 then
            for k, v in pairs(SoulEquipIndexList) do
                if (self.mEquipIndexToSoulEquipDic[v] == nil or self.mEquipIndexToSoulEquipDic[v]:GetSoulEquip_SubIndex(2) == nil) then
                    if (self.mEquipIndexToSoulEquipDic[v] == nil) then
                        self.mEquipIndexToSoulEquipDic[v] = luaclass.LuaSoulEquipVo:New();
                    end
                    local soulEquipInfo = {}
                    table.insert(soulEquipInfo, { subIndex = 2 })
                    self.mEquipIndexToSoulEquipDic[v]:UpdateVo({ soulEquipInfo = soulEquipInfo });
                end
            end
        end
    end
end

-----@public 是否是魂装
-----@param tbl TABLE.cfg_items
--function LuaSoulEquipDataClass:IsSoulEquip(tbl)
--    if (tbl ~= nil and tbl:GetInsertLv() ~= nil and #tbl:GetInsertLv().list > 0) then
--        return true;
--    end
--    return false;
--end

-----@public
-----@return bagV2.BagItemInfo 获得对应装备位上镶嵌的 魂装/仙装/神器
-----@param type LuaEnumSoulEquipType
--function LuaSoulEquipDataClass:GetSingleTypeEquipByEquipIndex(type, equipIndex)
--    return self:GetSoulEquipToEquipIndex(equipIndex);
--end

---@public 是否激活套装
function LuaSoulEquipDataClass:IsSuitActive(suitId)
    if (self.mActiveSoulSuitIds ~= nil) then
        for k, v in pairs(self.mActiveSoulSuitIds) do
            if (v == suitId) then
                return true;
            end
        end
    end

    return false;
end

---@return number, number 等级, 转生等级
function LuaSoulEquipDataClass:GetSoulEquipSetLimit()
    if (self.mReinLimit == nil) then
        local isFind, globalTbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22829)
        if (isFind) then
            local strs = string.Split(globalTbl.value, "#");
            if (#strs > 1) then
                self.mLevelLimit = tonumber(strs[1]);
                self.mReinLimit = tonumber(strs[2]);
            end
        end
    end

    if (self.mLevelLimit == nil) then
        self.mLevelLimit = 0;
    end

    if (self.mReinLimit == nil) then
        self.mReinLimit = 1;
    end

    return self.mLevelLimit, self.mReinLimit;
end

---@public 是否能镶嵌魂装
---@param itemId number
function LuaSoulEquipDataClass:CanSetSoulEquip(itemId)
    local levelLimit, reinLimit = self:GetSoulEquipSetLimit();
    ---@type TABLE.cfg_items
    local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId);
    if (tbl ~= nil) then
        return tbl:GetUseLv() >= levelLimit and tbl:GetReinLv() >= reinLimit;
    end
    return false;
end

---@public 获得激活的魂装套装ID
---@return table<number>
function LuaSoulEquipDataClass:GetActiveSoulEquipSuitIds()
    return self.mActiveSoulSuitIds;
end

-----@public 获得装备子类型对应的可镶嵌的魂装集合
-----@param equipSubType number
-----@param career number
-----@return table<number, TABLE.cfg_items>
--function LuaSoulEquipDataClass:GetEquipSubTypeToSoulEquipSet(equipSubType, career)
--    return gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetEquipSubTypeToSoulEquipSet(equipSubType, career);
--end

---@public 获得身上镶嵌的所有魂装
---@return table<number,LuaSoulEquipVo>
function LuaSoulEquipDataClass:GetAllBodySoulEquip()
    return self.mEquipIndexToSoulEquipDic;
end

---@public 获得对应装备为上镶嵌的魂装
---@return LuaSoulEquipVo
function LuaSoulEquipDataClass:GetSoulEquipClassToEquipIndex(equipIndex)
    if (self.mEquipIndexToSoulEquipDic ~= nil) then
        if (self.mEquipIndexToSoulEquipDic[equipIndex] ~= nil) then
            return self.mEquipIndexToSoulEquipDic[equipIndex]
        end
    end
    return nil;
end

---@public 获得对应装备为上镶嵌的魂装
---@return bagV2.BagItemInfo
function LuaSoulEquipDataClass:GetSoulEquipToEquipIndex(equipIndex, SelectInlayHolePosition)
    if (self.mEquipIndexToSoulEquipDic ~= nil) then
        if (self.mEquipIndexToSoulEquipDic[equipIndex] ~= nil) then
            ---@type LuaSoulEquipHoleInfo
            local SoulEquip = nil
            if (SelectInlayHolePosition ~= nil) then
                SoulEquip = self.mEquipIndexToSoulEquipDic[equipIndex]:GetSoulEquip_SubIndex(SelectInlayHolePosition);
            else
                SoulEquip = self.mEquipIndexToSoulEquipDic[equipIndex]:GetSoulEquip_TheBest();
            end
            if (SoulEquip ~= nil) then
                return SoulEquip.bagItemInfo
            end
        end
    end
    return nil;
end

---@public 获得对应装备为上全部镶嵌的魂装
---@return table<number,LuaSoulEquipHoleInfo>
function LuaSoulEquipDataClass:GetSoulEquipToEquipIndex_All(equipIndex)
    if (self.mEquipIndexToSoulEquipDic ~= nil) then
        if (self.mEquipIndexToSoulEquipDic[equipIndex] ~= nil) then
            return self.mEquipIndexToSoulEquipDic[equipIndex]:GetSoulEquip_All();
        end
    end
    return nil;
end

---@public 获得对应装备位魂装的激活状态
---@return boolean
function LuaSoulEquipDataClass:GetSoulEquipActiveState(equipIndex)
    if (self.mEquipIndexToSoulEquipDic ~= nil) then
        if (self.mEquipIndexToSoulEquipDic[equipIndex] ~= nil) then
            return self.mEquipIndexToSoulEquipDic[equipIndex]:GetActiveState();
        end
    end
    return nil;
end

---@public 获得身上镶嵌的魂装
---@return table<number,bagV2.BagItemInfo>
function LuaSoulEquipDataClass:GetSetSoulEquipList(itemId)
    local returnList = {};
    if (self.mEquipIndexToSoulEquipDic ~= nil) then
        for k, v in pairs(self.mEquipIndexToSoulEquipDic) do
            ---@type table<number,LuaSoulEquipHoleInfo>
            local allHoleSoulEquip = v:GetSoulEquip_All()
            for i, j in pairs(allHoleSoulEquip) do
                ---@type TABLE.cfg_items
                local tbl = j.cfg_items
                if (tbl ~= nil) then
                    if (tbl:GetId() == itemId) then
                        table.insert(returnList, j.bagItemInfo);
                    end
                end
            end
        end
    end
    return returnList;
end

---@public 获得镶嵌的魂装对应的装备位
---@return number
function LuaSoulEquipDataClass:GetEquipIndexBySetSoulEquip(lid)
    ---@type LuaSoulEquipVo
    for k, v in pairs(self.mEquipIndexToSoulEquipDic) do
        ---@type table<number,LuaSoulEquipHoleInfo>
        local allHoleSoulEquip = v:GetSoulEquip_All()
        for i, j in pairs(allHoleSoulEquip) do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = j.bagItemInfo
            if (bagItemInfo ~= nil) then
                if (bagItemInfo.lid == lid) then
                    return k;
                end
            end
        end
    end
    return -1;
end

return LuaSoulEquipDataClass;
