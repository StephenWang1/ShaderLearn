---@class UIRolePanel_GridTemplateXianZhuang:UIRolePanel_GridTemplateBase 仙装单个格子
local UIRolePanel_GridTemplateXianZhuang = {}

setmetatable(UIRolePanel_GridTemplateXianZhuang, luaComponentTemplates.UIRolePanel_GridTemplateBase)

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateXianZhuang:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateXianZhuang:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

---重写刷新Icon显示
function UIRolePanel_GridTemplateXianZhuang:RefreshIconInfo()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        if (self.itemInfo ~= nil) then
            self:GetIcon_UISprite().spriteName = self.itemInfo.icon
            local canSoulEquipSet = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsEquipCanInlay_XianZhuang(LuaEnumSoulEquipType.XianZhuang, self.bagItemInfo)
            self:GetIcon_UISprite().color = canSoulEquipSet and CS.UnityEngine.Color.white or LuaEnumUnityColorType.HalfTransparent;
            self:GetIcon_UISprite().gameObject:SetActive(true)
        end
    end
end

function UIRolePanel_GridTemplateXianZhuang:UpdateSoulEquipSign()
    local gobj = self:GetSoulEquip_GameObject();
    local soulEquipGrid = self:GetSoulEquipIcon_Grid();

    if gobj and CS.StaticUtility.IsNull(gobj) == false then
        local LuaSoulEquipVo = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipClassToEquipIndex(LuaEnumSoulEquipType.XianZhuang, self.equipIndex);
        local active = false
        if (LuaSoulEquipVo ~= nil) then
            local allSoulEquip = LuaSoulEquipVo:GetSoulEquip_AllNonEmpty()
            soulEquipGrid.MaxCount = #allSoulEquip
            active = #allSoulEquip > 0
            for i = 0, soulEquipGrid.MaxCount - 1 do
                local go = soulEquipGrid.controlList[i]
                local icon = self:GetCurComp(go.transform, "", "UISprite")
                icon.spriteName = allSoulEquip[i + 1].cfg_items:GetIcon();
            end
            self:GetSoulEquipQuality_UISprite().spriteName = ""
        end
        gobj:SetActive(active);
    end
end

return UIRolePanel_GridTemplateXianZhuang