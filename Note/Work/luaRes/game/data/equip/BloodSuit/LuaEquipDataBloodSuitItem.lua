---玩家的血继装备数据
---@class LuaEquipDataBloodSuitItem
local LuaEquipDataBloodSuitItem = {}

---道具表信息
---@return TABLE.cfg_items
function LuaEquipDataBloodSuitItem:GetItemTbl()
    if self.mItemTbl == nil then
        self.mItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.ItemID)
    end
    return self.mItemTbl
end

---血继表信息
---@return TABLE.cfg_bloodsuit
function LuaEquipDataBloodSuitItem:GetBloodsuitTbl()
    if self.mBloodsuitTbl == nil then
        self.mBloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.ItemID)
    end
    return self.mBloodsuitTbl
end

---灵兽表信息
---@return TABLE.cfg_huanshou
function LuaEquipDataBloodSuitItem:GetHuanShouTbl()
    if self.mHuanShou == nil then
        if self:GetItemTbl() ~= nil and self:GetItemTbl():GetUseParam() ~= nil and self:GetItemTbl():GetUseParam().list[0] ~= nil then
            self.mHuanShou = clientTableManager.cfg_huanshouManager:TryGetValue(self:GetItemTbl():GetUseParam().list[0])
        end
    end
    return self.mHuanShou
end

---怪物表信息
---@return TABLE.cfg_monsters
function LuaEquipDataBloodSuitItem:GetMonstersTbl()
    if self.mMonsters == nil then
        if self:GetHuanShouTbl() ~= nil then
            self.mMonsters = clientTableManager.cfg_monstersManager:TryGetValue(self:GetHuanShouTbl():GetId())
        end
    end
    return self.mMonsters
end

---初始化血继数据
---@param tblData bagV2.BagItemInfo
---@param pos LuaEquipBloodSuitItemType
function LuaEquipDataBloodSuitItem:RefreShData(tblData, pos)
    self:RevertData()
    self.pos = pos
    if tblData == nil then
        return
    end
    self.BagItemInfo = tblData
    self.ItemID = tblData.itemId
    self.index = tblData.index
end

---还原数据
function LuaEquipDataBloodSuitItem:RevertData()
    self.BagItemInfo = nil
    self.ItemID = nil
    self.index = nil
    self.mHuanShou = nil
    self.mBloodsuitTbl = nil
    self.mItemTbl = nil
    self.mMonsters = nil
end

return LuaEquipDataBloodSuitItem