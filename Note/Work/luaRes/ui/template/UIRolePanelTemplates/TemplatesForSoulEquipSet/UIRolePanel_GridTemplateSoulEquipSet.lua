---@class UIRolePanel_GridTemplateSoulEquipSet:UIRolePanel_GridTemplateBase
local UIRolePanel_GridTemplateSoulEquipSet = {};
setmetatable(UIRolePanel_GridTemplateSoulEquipSet, luaComponentTemplates.UIRolePanel_GridTemplateBase)

UIRolePanel_GridTemplateSoulEquipSet.mIsChoose = false;

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateSoulEquipSet:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

function UIRolePanel_GridTemplateSoulEquipSet:ShowEquip(bagItemInfo, equipIndex)
    self:RunBaseFunction("ShowEquip", bagItemInfo, equipIndex);
    self:UpdateSoulEquipSign();
end

---重写耐久度显示
function UIRolePanel_GridTemplateSoulEquipSet:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

---重写刷新Icon显示
function UIRolePanel_GridTemplateSoulEquipSet:RefreshIconInfo()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        if(self.itemInfo ~= nil) then
            self:GetIcon_UISprite().spriteName = self.itemInfo.icon
            local canSoulEquipSet = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CanSetSoulEquip(self.itemInfo.id);
            self:GetIcon_UISprite().color = canSoulEquipSet and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
            self:GetIcon_UISprite().gameObject:SetActive(true)
        end
    end
end

---重写隐藏其他界面调用Icon
function UIRolePanel_GridTemplateSoulEquipSet:SetOtherIcon()
    --元素
    if self:GetElementAdd_UISprite().gameObject and CS.StaticUtility.IsNull(self:GetElementAdd_UISprite().gameObject) == false then
        self:GetElementAdd_UISprite().gameObject:SetActive(false)
    end
    --特效
    if self:GetEffect_GameObject() and CS.StaticUtility.IsNull(self:GetEffect_GameObject()) then
        self:GetEffect_GameObject():SetActive(false)
    end
    --印记
    if self:GetYinJi_GameObject() and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self:GetYinJi_GameObject():SetActive(false)
    end
    if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite().gameObject) == false then
        self:GetOverlayIcon2_UISprite().spriteName = ""
    end
    --维修
    if self:GetCheck_GameObject() and CS.StaticUtility.IsNull(self:GetCheck_GameObject()) == false then
        self:GetCheck_GameObject():SetActive(false)
    end
end

---重写选中特效
function UIRolePanel_GridTemplateSoulEquipSet:ChooseItem(isShow)
    self.mIsChoose = isShow;
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(isShow)
    end
end

function UIRolePanel_GridTemplateSoulEquipSet:UpdateSoulEquipSign()
    local gobj = self:GetSoulEquip_GameObject();
    local soulEquipIcon = self:GetSoulEquipIcon_UISprite();

    if gobj and CS.StaticUtility.IsNull(gobj) == false then
        local soulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(self.equipIndex);
        gobj:SetActive(soulEquip ~= nil);
        if(soulEquip ~= nil) then
            ---@type TABLE.cfg_items
            local tbl = clientTableManager.cfg_itemsManager:TryGetValue(soulEquip.itemId);
            if(tbl ~= nil) then
                soulEquipIcon.spriteName = tbl:GetIcon();
                self:GetSoulEquipQuality_UISprite().spriteName = "SoulEquip_"..tbl:GetGroup()
            end
        end
    end
end



return UIRolePanel_GridTemplateSoulEquipSet