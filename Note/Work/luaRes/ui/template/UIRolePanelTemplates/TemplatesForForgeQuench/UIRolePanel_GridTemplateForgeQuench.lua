---@class UIRolePanel_GridTemplateForgeQuench:UIRolePanel_GridTemplateBase
local UIRolePanel_GridTemplateForgeQuench = {};
setmetatable(UIRolePanel_GridTemplateForgeQuench, luaComponentTemplates.UIRolePanel_GridTemplateBase)

function UIRolePanel_GridTemplateForgeQuench:OnEnable()
    self:RunBaseFunction("OnEnable");
    if (self:RedPoint() ~= nil) then
        self:RedPoint():RemoveRedPointKey();
        local key = self:GetRedPointKey(self.equipIndex);
        self:RedPoint():AddRedPointKey(key);
    end
end

function UIRolePanel_GridTemplateForgeQuench:OnDisable()
    self:RunBaseFunction("OnDisable");
    if (self:RedPoint() ~= nil) then
        self:RedPoint():RemoveRedPointKey();
    end
end

---重写刷新Icon显示
function UIRolePanel_GridTemplateForgeQuench:RefreshIconInfo()
    if not CS.StaticUtility.IsNull(self:GetIcon_UISprite()) then
        if (self.bagItemInfo ~= nil) then
            if (self.itemInfo ~= nil) then
                self:GetIcon_UISprite().spriteName = self.itemInfo.icon
            end
            local isWhite = self:IsAvailableForForgeQuench(self.bagItemInfo) and self:IsShow(self.bagItemInfo)
            self:GetIcon_UISprite().color = isWhite and CS.UnityEngine.Color(1, 1, 1, 1) or CS.UnityEngine.Color(0, 0, 0, 128 / 255);
        end
        self:GetIcon_UISprite().gameObject:SetActive(true)
    end
end

---重写加号显示
function UIRolePanel_GridTemplateForgeQuench:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateForgeQuench:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end

---隐藏其他界面调用Icon
function UIRolePanel_GridTemplateForgeQuench:SetOtherIcon()
    --元素
    if self:GetElementAdd_UISprite() ~= nil and CS.StaticUtility.IsNull(self:GetElementAdd_UISprite()) == false then
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
    if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite()) == false then
        self:GetOverlayIcon2_UISprite().spriteName = ""
    end
    --维修
    if self:GetCheck_GameObject() and CS.StaticUtility.IsNull(self:GetCheck_GameObject()) == false then
        self:GetCheck_GameObject():SetActive(false)
    end
end

---获取淬炼红点
function UIRolePanel_GridTemplateForgeQuench:GetRedPointKey(index)
    return gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetRedPointKey(index, 4);
end

---是否位淬炼材料
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIRolePanel_GridTemplateForgeQuench:IsAvailableForForgeQuench(bagItemInfo)
    return gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():IsAvailableForForgeQuench(bagItemInfo)
end

---是否满足显示
---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_GridTemplateForgeQuench:IsShow(bagItemInfo)
    if bagItemInfo and bagItemInfo.itemId then
        local forgeQuenchId = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetCuiLianIdByMaterialId(bagItemInfo.itemId)
        ---@type LuaForgeQuenchItemData
        local data = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetAllForgeQuenchItemByIdDic()[forgeQuenchId]
        if data then
            return data:IsShow()
        end
    end
    return false
end

return UIRolePanel_GridTemplateForgeQuench