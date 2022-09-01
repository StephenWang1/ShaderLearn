---@class LuaShieldAndHatManager:luaobject 盾牌和斗笠管理类
local LuaShieldAndHatManager = {}

function LuaShieldAndHatManager:GetEquipList(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    local itemInfoList = {}
    if itemInfo ~= nil then
        table.insert(itemInfoList, itemInfo)
    end
    if type(self.ShieldAndHatEquipList) ~= 'table' or Utility.GetLuaTableCount(self.ShieldAndHatEquipList) <= 0 then
        return itemInfoList
    end
    for k, v in pairs(self.ShieldAndHatEquipList) do
        local ShieldAndHatEquipInfo = v
        if ShieldAndHatEquipInfo.itemInfo ~= nil and (itemInfo:GetType() ~= ShieldAndHatEquipInfo.itemInfo:GetType() or itemInfo:GetSubType() ~= ShieldAndHatEquipInfo.itemInfo:GetSubType()) then
            table.insert(itemInfoList, ShieldAndHatEquipInfo.itemInfo)
        end
    end
    return itemInfoList
end

---设置装备列表
---@param equipList equipV2.ResAllEquip
function LuaShieldAndHatManager:SetEquipList(equipList)
    if (self.ShieldAndHatEquipList == nil) then
        self.ShieldAndHatEquipList = {}
    end
    if (equipList == nil or #equipList == 0) then
        return
    end
    for i = 1, #equipList do
        if (equipList[i].changeEquip ~= nil) then
            local result, itemInfo = clientTableManager.cfg_itemsManager:IsShieldorHatEquip(equipList[i].changeEquip.itemId)
            if (result) then
                local ShieldAndHatTable = {}
                ---@type item
                ShieldAndHatTable.itemInfo = itemInfo
                table.insert(self.ShieldAndHatEquipList, ShieldAndHatTable)
            end
        end
    end
end

---@param EquipList equipV2.EquipsChange
function LuaShieldAndHatManager:ChangeEquipList(EquipList)
    if (self.ShieldAndHatEquipList == nil) then
        self.ShieldAndHatEquipList = {}
    end
    for i = 1, #EquipList do
        if (EquipList[i].changeEquip ~= nil) then
            self:AddEquipList(EquipList[i].changeEquip.itemId)
        else
            if (EquipList[i].equipIndex == LuaEnumEquipSubType.Equip_Shield) then
                self:RemoveEquipList(LuaEnumEquipSubType.Equip_Shield)
            elseif (EquipList[i].equipIndex == LuaEnumEquipSubType.Equip_Hat) then
                self:RemoveEquipList(LuaEnumEquipSubType.Equip_Hat)
            end
        end
    end
end

---查看他人时，把斗笠和盾牌加入
function LuaShieldAndHatManager:AddEquipList(itemId)
    if (self.ShieldAndHatEquipList == nil) then
        self.ShieldAndHatEquipList = {}
    end

    local result, itemInfo = clientTableManager.cfg_itemsManager:IsShieldorHatEquip(itemId)
    if (result) then
        local isfind = false
        for i = 1, #self.ShieldAndHatEquipList do
            if (self.ShieldAndHatEquipList[i].itemInfo:GetSubType() == itemInfo:GetSubType()) then
                self.ShieldAndHatEquipList[i].itemInfo = itemInfo
                isfind = true
            end
        end
        if (isfind == false) then
            local ShieldAndHatTable = {}
            ---@type item
            ShieldAndHatTable.itemInfo = itemInfo
            table.insert(self.ShieldAndHatEquipList, ShieldAndHatTable)
        end
    end
end

---@param type EquipsubType
function LuaShieldAndHatManager:RemoveEquipList(type)
    if (self.ShieldAndHatEquipList == nil) then
        return
    end

    for i = #self.ShieldAndHatEquipList, 1, -1 do
        if (self.ShieldAndHatEquipList[i].itemInfo:GetSubType() == type) then
            table.remove(self.ShieldAndHatEquipList, i)
        end
    end
end

return LuaShieldAndHatManager