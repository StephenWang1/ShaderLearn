---@class LuaSuitMgr
local LuaSuitMgr = {};

---@type table<number,table<number, TABLE.cfg_suit>> <suitType, <suitLevel, TABLE.cfg_suit>>
LuaSuitMgr.mSuitTypeToLevelDic = nil;

function LuaSuitMgr:Init()
    self.mSuitTypeToLevelDic = {};
    ---@param tbl TABLE.cfg_suit
    clientTableManager.cfg_suitManager:ForPair(function(key, tbl)
        if (self.mSuitTypeToLevelDic[tbl:GetSuitId()] == nil) then
            self.mSuitTypeToLevelDic[tbl:GetSuitId()] = {};
        end
        self.mSuitTypeToLevelDic[tbl:GetSuitId()][tbl:GetSuitLv()] = tbl;
    end);
end

---@return TABLE.cfg_suit
function LuaSuitMgr:GetSuitTbl(suitType, suitLevel)
    if (self.mSuitTypeToLevelDic[suitType] ~= nil) then
        return self.mSuitTypeToLevelDic[suitType][suitLevel];
    end
    return nil;
end

---@public 目标数据中魂装套装的数量
---@param luaSoulEquipDataClass LuaSoulEquipDataClass
function LuaSuitMgr:GetBodySoulEquipSuitTable(suitType, luaSoulEquipDataClass)
    local soulEquips = self:GetBodySoulSuitEquip(suitType, luaSoulEquipDataClass);
    local minLevel = nil;
    if (soulEquips ~= nil) then
        ---@type bagV2.BagItemInfo
        for k, v in pairs(soulEquips) do

            ---@type TABLE.cfg_items
            local tbl = clientTableManager.cfg_itemsManager:TryGetValue(v.itemId);
            if (tbl ~= nil) then
                if (minLevel == nil) then
                    minLevel = tbl:GetGroup();
                end
                if (minLevel > tbl:GetGroup()) then
                    minLevel = tbl:GetGroup();
                end
            end
        end
    end
    return self:GetSuitTbl(suitType, minLevel);
end

---@public 获得身上魂装的套装列表
---@param suitType 套装类型
---@param luaSoulEquipDataClass LuaSoulEquipDataClass
---@return tbale<bagV2.BagItemInfo>
function LuaSuitMgr:GetBodySoulSuitEquip(suitType, luaSoulEquipDataClass)
    local returnList = {};
    if (luaSoulEquipDataClass == nil) then
        luaSoulEquipDataClass = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetLuaSoulEquipData();
    end
    if (luaSoulEquipDataClass ~= nil) then
        local soulEquips = luaSoulEquipDataClass:GetAllBodySoulEquip();
        ---@param v LuaSoulEquipVo
        for k, v in pairs(soulEquips) do
            ---@type table<number,LuaSoulEquipHoleInfo>
            local allHoleSoluEquip = v:GetSoulEquip_All()
            for i, j in pairs(allHoleSoluEquip) do
                ---@type TABLE.cfg_items
                local tbl = j.cfg_items
                if (tbl ~= nil) then
                    if (tbl:GetSuitBelong() == suitType) then
                        table.insert(returnList, j.bagItemInfo);
                    end
                end
            end
        end
    end
    return returnList;
end

return LuaSuitMgr;
