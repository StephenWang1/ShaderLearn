---@class UIRolePanel_GridTemplateJianDing:UIRolePanel_GridTemplateBase 鉴定单个格子
local UIRolePanel_GridTemplateJianDing = {}

setmetatable(UIRolePanel_GridTemplateJianDing, luaComponentTemplates.UIRolePanel_GridTemplateBase)

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateJianDing:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateJianDing:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

---重写刷新Icon显示
function UIRolePanel_GridTemplateJianDing:RefreshIconInfo()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        if (self.itemInfo ~= nil) then
            self:GetIcon_UISprite().spriteName = self.itemInfo.icon
            self:GetIcon_UISprite().color = self:GetJianDingTable(self.bagItemInfo) and CS.UnityEngine.Color.white or LuaEnumUnityColorType.HalfTransparent;
            self:GetIcon_UISprite().gameObject:SetActive(true)
        end
    end
end

function UIRolePanel_GridTemplateJianDing:GetJianDingTable(bagItemInfo)
    local Lua_jianDingTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if  Lua_jianDingTABLE:GetJianDing() == 1 then
        return true
    else
        return false
    end
end

return UIRolePanel_GridTemplateJianDing