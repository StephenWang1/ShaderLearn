---@class MagicEquipItemInfo_UIItem:UIItemInfoPanel_Info_UIItem 法宝Item信息模块
local MagicEquipItemInfo_UIItem = {}

--region 数据
MagicEquipItemInfo_UIItem.levelFormat = "品阶 %s阶"
--endregion

setmetatable(MagicEquipItemInfo_UIItem,luaComponentTemplates.UIItemInfoPanel_Info_UIItem)

---刷新持久
function MagicEquipItemInfo_UIItem:RefreshLasting()
    if self.ItemInfo == nil or CS.StaticUtility.IsNull(self:GetNaijiu_UILabel()) then
        return
    end
    ---@type TABLE.cfg_magicweapon
    local magicEquipSuitInfo = clientTableManager.cfg_itemsManager:GetMagicEquipSuitInfo(self.ItemInfo.id)
    if magicEquipSuitInfo == nil then
        return
    end
    local level = magicEquipSuitInfo:GetLevel()
    if level == nil then
        return
    end
    self:GetNaijiu_UILabel().text = string.format(self.levelFormat,level)
end

---刷新效果削减文本
function MagicEquipItemInfo_UIItem:RefreshWeakenWarning()

end

return MagicEquipItemInfo_UIItem