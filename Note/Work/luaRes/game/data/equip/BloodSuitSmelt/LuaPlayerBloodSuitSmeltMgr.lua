---@class LuaPlayerBloodSuitSmeltMgr 血炼管理类
local LuaPlayerBloodSuitSmeltMgr = {}

---@type table<LuaRedPointName,LuaEquipBloodSuitType>
LuaPlayerBloodSuitSmeltMgr.mRedPointToType = {
    ---血继 妖装备套装
    [LuaRedPointName.BloodSuitSmelt_Yao] = LuaEquipBloodSuitType.Yao,
    ---血继 仙装备套装
    [LuaRedPointName.BloodSuitSmelt_Xian] = LuaEquipBloodSuitType.Xian,
    ---血继 魔装备套装
    [LuaRedPointName.BloodSuitSmelt_Mo] = LuaEquipBloodSuitType.Mo,
    ---血继 灵装备套装
    [LuaRedPointName.BloodSuitSmelt_Ling] = LuaEquipBloodSuitType.Ling,
    ---血继 神装备套装
    [LuaRedPointName.BloodSuitSmelt_Shen] = LuaEquipBloodSuitType.Shen,
}

LuaPlayerBloodSuitSmeltMgr.mAllRedPointData = nil
LuaPlayerBloodSuitSmeltMgr.mTypeToCanChoose = nil
LuaPlayerBloodSuitSmeltMgr.mItemIdToCanChoose = nil

--region 红点
---刷新所有红点
function LuaPlayerBloodSuitSmeltMgr:CallAllRedPoint()
    self.mAllRedPointData = {}
    self.mTypeToCanChoose = {}
    self.mItemIdToCanChoose = {}
    local BloodSuitSmelt_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_All);
    local BloodSuitSmelt_Yao = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_Yao);
    local BloodSuitSmelt_Xian = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_Xian);
    local BloodSuitSmelt_Mo = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_Mo);
    local BloodSuitSmelt_Ling = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_Ling);
    local BloodSuitSmelt_Shen = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_Shen);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuitSmelt_Yao);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuitSmelt_Xian);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuitSmelt_Mo);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuitSmelt_Ling);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuitSmelt_Shen);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuitSmelt_All);
end

---@return boolean 获取所有页签中是否有可选中类型
function LuaPlayerBloodSuitSmeltMgr:CanAllTypeItemChoose()
    for i = 1, #uiStaticParameter.mBloodSuitType do
        local type = uiStaticParameter.mBloodSuitType[i]
        local canChoose = self:GetTypeItemCanChoose(type)
        if canChoose then
            return true
        end
    end
    return false
end

---@return boolean 获取某个类型的页签是否显示红点
---@param redPointType LuaRedPointName
function LuaPlayerBloodSuitSmeltMgr:GetTypeItemCanShowRedPoint(redPointType)
    local canChoose = self:GetAllRedPointData(redPointType)
    if canChoose == nil then
        if redPointType == LuaRedPointName.BloodSuitSmelt_All then
            canChoose = self:CanAllTypeItemChoose()
        else
            local type = self.mRedPointToType[redPointType]
            if type then
                canChoose = self:CanSingleTypeChoose(type)
            end
        end
        self:SetAllRedPointData(redPointType, canChoose)
    end
    return canChoose
end

---@return boolean 有数据是布尔值，没数据返回nil
function LuaPlayerBloodSuitSmeltMgr:GetAllRedPointData(redPointType)
    if self.mAllRedPointData == nil then
        self.mAllRedPointData = {}
    end
    return self.mAllRedPointData[redPointType]
end

---对红点数据赋值
---@param redPointType LuaRedPointName
---@param canChoose boolean
function LuaPlayerBloodSuitSmeltMgr:SetAllRedPointData(redPointType, canChoose)
    if self.mAllRedPointData == nil then
        self.mAllRedPointData = {}
    end
    self.mAllRedPointData[redPointType] = canChoose
end

---@return boolean 获取单个页签是否有可选中
function LuaPlayerBloodSuitSmeltMgr:CanSingleTypeChoose(type)
    if self.mTypeToCanChoose == nil then
        return false
    end
    local canChoose = self.mTypeToCanChoose[type]
    if canChoose == nil then
        canChoose = self:GetTypeItemCanChoose(type)
    end
    return canChoose
end

---@param type LuaEquipBloodSuitType 套装类型数据
---@return boolean 判断当前类型是否可显示红点
function LuaPlayerBloodSuitSmeltMgr:GetTypeItemCanChoose(type)
    local typeData = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():GetSingleBloodSuitDic(type)
    if typeData then
        for pos, equip in pairs(typeData) do
            ---@type LuaEquipDataBloodSuitItem
            local data = equip
            if self:CanItemSmelt(data.BagItemInfo) then
                return true
            end
        end
    end
    return false
end

---@public
---@param bagItemInfo bagV2.BagItemInfo 该道具是可血炼
function LuaPlayerBloodSuitSmeltMgr:CanItemSmelt(bagItemInfo)
    if bagItemInfo == nil then
        return false
    end

    local level = bagItemInfo.bloodLevel
    local suitData = clientTableManager.cfg_bloodsuit_levelManager:TryGetValue(level + 1)
    if suitData == nil then
        return false
    end

    local itemId = bagItemInfo.itemId
    if itemId == nil then
        return false
    end

    if self.mItemIdToCanChoose == nil then
        self.mItemIdToCanChoose = {}
    end

    local canChoose = self.mItemIdToCanChoose[itemId]
    if canChoose == nil then
        canChoose = self:GetItemCanSmeltByBag(itemId)
        self.mItemIdToCanChoose[itemId] = canChoose
    end
    return canChoose
end

---@private
---@return boolean 根据背包数据判断是否可血炼
function LuaPlayerBloodSuitSmeltMgr:GetItemCanSmeltByBag(itemId)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return false
    end
    local smeltData = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemId)
    if smeltData == nil then
        return false
    end

    local bagEquip = mainPlayerInfo.BagInfo:GetBagItemList()
    if bagEquip == nil then
        return false
    end

    for i = 0, bagEquip.Count - 1 do
        ---@type bagV2.BagItemInfo
        local data = bagEquip[i]
        local smeltItemList = smeltData:GetSmeltItem()
        if smeltItemList then
            local listInfo = smeltItemList.list
            if listInfo then
                for i = 1, #listInfo do
                    if data.itemId == listInfo[i] then
                        return true
                    end
                end
            end
        end
    end
    return false
end
--endregion

return LuaPlayerBloodSuitSmeltMgr