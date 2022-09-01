---@class UIRolePanel_GridTemplateShenQi:UIRolePanel_GridTemplateXianZhuang 神器单个格子
local UIRolePanel_GridTemplateShenQi = {}

setmetatable(UIRolePanel_GridTemplateShenQi, luaComponentTemplates.UIRolePanel_GridTemplateXianZhuang)

function UIRolePanel_GridTemplateShenQi:UpdateSoulEquipSign()
    local gobj = self:GetSoulEquip_GameObject();
    local soulEquipIcon = self:GetSoulEquipIcon_UISprite();

    if gobj and CS.StaticUtility.IsNull(gobj) == false then
        local soulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSingleTypeEquipByEquipIndex(LuaEnumSoulEquipType.ShenQi, self.equipIndex);
        gobj:SetActive(soulEquip ~= nil);
        if (soulEquip ~= nil) then
            ---@type TABLE.cfg_items
            local tbl = clientTableManager.cfg_itemsManager:TryGetValue(soulEquip.itemId);
            if (tbl ~= nil) then
                soulEquipIcon.spriteName = tbl:GetIcon();
                self:GetSoulEquipQuality_UISprite().spriteName = "SoulEquip_" .. tbl:GetGroup()
            end
        end
    end
end

return UIRolePanel_GridTemplateShenQi