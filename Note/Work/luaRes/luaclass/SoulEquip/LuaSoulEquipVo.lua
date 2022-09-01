---@class LuaSoulEquipVo
local LuaSoulEquipVo = {};

---@class LuaSoulEquipHoleInfo
---@field bagItemInfo bagV2.BagItemInfo
---@field cfg_items TABLE.cfg_items
---@field subIndex number 孔位，从左到右1-3
---@field active boolean 套装效果是否激活

--region 数据
LuaSoulEquipVo.mActiveState = nil;
---@type table<number,LuaSoulEquipHoleInfo>
LuaSoulEquipVo.mSoulEquipHoles = nil;
---@type table<number,TABLE.cfg_items>
--LuaSoulEquipVo.mItemInfo = nil
---@type LuaEnumSoulEquipType
--LuaSoulEquipVo.mSuitType = nil
---@type number 装备位置
LuaSoulEquipVo.index = nil
---@type TABLE.cfg_suit
--LuaSoulEquipVo.mSuitTbl = nil
---@type TABLE.cfg_inlay_effect
LuaSoulEquipVo.mInlayEffectTbl = nil
--endregion

---@param customData equipV2.SoulEquip
function LuaSoulEquipVo:UpdateVo(customData)
    self.index = customData.index;
    self:UpdateSoulEquipInfo(customData.soulEquipInfo)
end

function LuaSoulEquipVo:UpdateSoulEquipInfo(soulEquipInfo)
    if (soulEquipInfo == nil) then
        return
    end
    self.mSoulEquipHoles = {}
    for i, v in pairs(soulEquipInfo) do
        ---@type equipV2.SoulEquipInfo
        local equipInfo = v
        ---@type LuaSoulEquipHoleInfo
        local luaSoulEquipHoleInfo = {}
        luaSoulEquipHoleInfo.active = v.active
        luaSoulEquipHoleInfo.subIndex = v.subIndex
        luaSoulEquipHoleInfo.bagItemInfo = v.itemInfo
        if (v.itemInfo ~= nil) then
            luaSoulEquipHoleInfo.cfg_items = clientTableManager.cfg_itemsManager:TryGetValue(v.itemInfo.itemId)
        end
        self.mSoulEquipHoles[v.subIndex] = luaSoulEquipHoleInfo
    end
end

function LuaSoulEquipVo:GetActiveState()
    --return self.mActiveState;
    if (self.mSoulEquipHoles == nil) then
        return false
    end
    for i, v in pairs(self.mSoulEquipHoles) do
        if (v.active == true) then
            return true
        end
    end
    return false
end

--region 获取孔位信息

---获取第一个不为空的孔位信息
---@return LuaSoulEquipHoleInfo
function LuaSoulEquipVo:GetSoulEquip()
    --print('GetSoulEquip')
    if (self.mSoulEquipHoles == nil) then
        return nil
    end
    for i, v in pairs(self.mSoulEquipHoles) do
        if (v.bagItemInfo ~= nil) then
            return v
        end
    end
    return nil
end

---获取指定孔位的信息
---@return LuaSoulEquipHoleInfo
function LuaSoulEquipVo:GetSoulEquip_SubIndex(subIndex)
    if (self.mSoulEquipHoles == nil) then
        return nil
    end
    return self.mSoulEquipHoles[subIndex];
end

---获取最好的孔位信息
---@return LuaSoulEquipHoleInfo
function LuaSoulEquipVo:GetSoulEquip_TheBest()
    if (self.mSoulEquipHoles == nil) then
        return nil
    end
    ---@type LuaSoulEquipHoleInfo
    local luaSoulEquipHoleInfo = self:GetSoulEquip()
    for i, v in pairs(self.mSoulEquipHoles) do
        if (luaSoulEquipHoleInfo ~= nil and luaSoulEquipHoleInfo.cfg_items ~= nil and v.cfg_items ~= nil and luaSoulEquipHoleInfo.cfg_items:GetGroup() < v.cfg_items:GetGroup()) then
            luaSoulEquipHoleInfo = v
        end
    end
    return luaSoulEquipHoleInfo
end

---获取全部的孔位信息
---@return table<number,LuaSoulEquipHoleInfo>
function LuaSoulEquipVo:GetSoulEquip_All()
    return self.mSoulEquipHoles;
end

---获取全部的孔位信息
---@return table<number,LuaSoulEquipHoleInfo>
function LuaSoulEquipVo:GetSoulEquip_AllNonEmpty()
    if (self.mSoulEquipHoles == nil) then
        return nil
    end
    local allSoulEquip = {}
    for i, v in pairs(self.mSoulEquipHoles) do
        if (v ~= nil and v.bagItemInfo ~= nil) then
            table.insert(allSoulEquip, v)
        end
    end
    return allSoulEquip
end
--endregion

--region 套装信息
---获取指定孔位的套装类型
---@param subIndex 孔位
---@return LuaEnumSoulEquipType
function LuaSoulEquipVo:GetSuitBelong(subIndex)
    local holeInfo = self:GetSoulEquip_SubIndex(subIndex)
    local mSuitType = 999
    if (holeInfo ~= nil) then
        local luaItemInfo = holeInfo.cfg_items
        if luaItemInfo ~= nil then
            mSuitType = luaItemInfo:GetSuitBelong()
        end
    end
    return mSuitType
end

---是否镶嵌此套装类型的装备
---@param inlayEquipType 套装类型
---@return LuaEnumSoulEquipType
function LuaSoulEquipVo:IsInlayThisSetSuitType(inlayEquipType)
    if (self.mSoulEquipHoles == nil) then
        return false
    end
    for i, v in pairs(self.mSoulEquipHoles) do
        if (v.cfg_items ~= nil and v.cfg_items:GetSuitBelong() == inlayEquipType) then
            return true
        end
    end
    return false
end

---@return number
function LuaSoulEquipVo:GetSuitLevel(subIndex)
    local holeInfo = self:GetSoulEquip_SubIndex(subIndex)
    local mSuitLevel = 1
    if (holeInfo ~= nil) then
        local luaItemInfo = holeInfo.cfg_items
        if luaItemInfo ~= nil then
            mSuitLevel = luaItemInfo:GetGroup()
        end
    end
    return mSuitLevel
end

---@return TABLE.cfg_suit
function LuaSoulEquipVo:GetSuitTbl(subIndex)
    local suitType = self:GetSuitBelong(subIndex)
    local suitLevel = self:GetSuitLevel(subIndex)
    if suitType == nil or suitLevel == nil then
        return
    end
    return gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetSuitTbl(suitType, suitLevel)
end

--endregion

--region 镶嵌信息
---@return TABLE.cfg_inlay_effect
function LuaSoulEquipVo:GetInlayEffectTbl()
    local holeInfo = self:GetSoulEquip_TheBest()
    if (holeInfo == nil) then
        return
    end
    local luaItemInfo = holeInfo.cfg_items
    if luaItemInfo == nil or type(luaItemInfo:GetExtraMonEffectInlay()) == 'number' and luaItemInfo:GetExtraMonEffectInlay() <= 0 then
        return
    end
    local mInlayEffectTbl = clientTableManager.cfg_inlay_effectManager:TryGetValue(luaItemInfo:GetExtraMonEffectInlay())
    return mInlayEffectTbl
end

-----@return string 套装名字
--function LuaSoulEquipVo:GetSuitName()
--    local suitTbl = self:GetSuitTbl()
--    if suitTbl ~= nil then
--        return suitTbl:GetName()
--    end
--    return ""
--end

---@return string 套装镶嵌名字
function LuaSoulEquipVo:GetSuitInlayName(subIndex)
    local suitTbl = self:GetSuitTbl(subIndex)
    if suitTbl ~= nil then
        return suitTbl:GetInlayName()
    end
    return ""
end

---@return number
function LuaSoulEquipVo:GetNameOrder(subIndex)
    local suitTbl = self:GetSuitTbl(subIndex)
    if suitTbl ~= nil then
        return suitTbl:GetInlayNameOrder()
    end
    return 999
end

---@return string
function LuaSoulEquipVo:GetAllSuitInlayName_NameOrder(nameOrder)
    if self.mSoulEquipHoles == nil then
        return ''
    end
    local str = ''
    for i, v in pairs(self.mSoulEquipHoles) do
        if (self:GetNameOrder(i) == nameOrder) then
            str = Utility.CombineStringQuickly(str, ' ', self:GetSuitInlayName(i))
        end
    end
    return str
end

---@return string 镶嵌特效
function LuaSoulEquipVo:GetInlayEffectName()
    local InlayEffectTbl = self:GetInlayEffectTbl()
    if InlayEffectTbl == nil then
        return ""
    end
    return InlayEffectTbl:GetEffect()
end

---@return string 镶嵌底图
function LuaSoulEquipVo:GetInlayBaseMap()
    local InlayEffectTbl = self:GetInlayEffectTbl()
    if InlayEffectTbl ~= nil and CS.StaticUtility.IsNullOrEmpty(InlayEffectTbl:GetBasePicture()) == false then
        return InlayEffectTbl:GetBasePicture()
    else
        local holeInfo = self:GetSoulEquip_TheBest()
        if holeInfo ~= nil and holeInfo.cfg_items ~= nil then
            return "SoulEquip_" .. tostring(holeInfo.cfg_items:GetGroup())
        end
    end
    return ""
end
--endregion

return LuaSoulEquipVo;