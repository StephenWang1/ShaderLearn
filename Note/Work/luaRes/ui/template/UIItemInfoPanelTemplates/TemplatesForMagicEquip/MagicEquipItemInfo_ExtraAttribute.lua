---@class MagicEquipItemInfo_ExtraAttribute:UIItemInfoPanel_Info_ExtraAttribute 法宝额外属性模块
local MagicEquipItemInfo_ExtraAttribute = {}

setmetatable(MagicEquipItemInfo_ExtraAttribute, luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute)

---刷新属性
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function MagicEquipItemInfo_ExtraAttribute:RefreshAttributes(bagItemInfo, itemInfo)
    self.bagItemInfo = bagItemInfo
    self.itemInfo = itemInfo
    if self.career ~= nil and type(self.career) ~= 'number' then
        self.career = Utility.EnumToInt(self.career)
    end
    --region 套装额外属性
    if itemInfo ~= nil then
        local titleName = "[73ddf7]套装效果"
        local iconName = ""
        local attrValue = ""
        local suitDes = self:GetShowDes()
        if CS.StaticUtility.IsNullOrEmpty(suitDes) == false then
            self:AddAttribute(titleName, iconName, suitDes)
        end
    end
    --endregion
end

---获取显示的tips描述内容
function MagicEquipItemInfo_ExtraAttribute:GetShowDes()
    local suitType = clientTableManager.cfg_itemsManager:GetMagicEquipSuitType(self.itemInfo.id)
    if self.bagItemInfo ~= nil then
        local suitListData = nil
        if gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():MagicEquipIsEquipped(self.bagItemInfo) then
            ---如果是主角身上的装备
            suitListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipListBySuitType(suitType)
        elseif gameMgr:GetOtherPlayerDataMgr():IsOtherPlayerMagicEquip(self.bagItemInfo) then
            ---如果是其他玩家身上的装备
            suitListData = gameMgr:GetOtherPlayerDataMgr():GetMagicEquipListBySuitType(suitType)
        end
        if suitListData ~= nil then
            return suitListData:GetItemInfoExtraAttributeDes(self.career)
        end
    end
    ---其他装备
    local suitInfoTable = clientTableManager.cfg_itemsManager:GetMagicEquipSuitInfo(self.itemInfo.id)
    if suitInfoTable ~= nil then
        local str = clientTableManager.cfg_magicweaponManager:GetCurSkillDes(suitInfoTable:GetId())
        str = Utility.LuaTryStringFormat(str, 1)
        local attributeDes = clientTableManager.cfg_magicweaponManager:GetAttributeDes(suitInfoTable:GetId(),self.career)
        if CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
            str = str .. '\n' .. attributeDes
        end
        return luaEnumColorType.Gray .. str
    end
end

return MagicEquipItemInfo_ExtraAttribute