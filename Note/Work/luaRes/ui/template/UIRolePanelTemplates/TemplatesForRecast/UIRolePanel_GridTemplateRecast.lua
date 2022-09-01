---@class UIRolePanel_GridTemplateRecast:UIRolePanel_GridTemplateBase 重铸单个格子
local UIRolePanel_GridTemplateRecast = {}

setmetatable(UIRolePanel_GridTemplateRecast, luaComponentTemplates.UIRolePanel_GridTemplateBase)

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateRecast:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateRecast:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

---重写刷新Icon显示
function UIRolePanel_GridTemplateRecast:RefreshIconInfo()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        if (self.itemInfo ~= nil) then
            self:GetIcon_UISprite().spriteName = self.itemInfo.icon
            local isReacstItem = gameMgr:GetPlayerDataMgr():GetRecastMgr():IsRecastItem(self.itemInfo.id)
            self:GetIcon_UISprite().color = isReacstItem and CS.UnityEngine.Color.white or LuaEnumUnityColorType.HalfTransparent;
            self:GetIcon_UISprite().gameObject:SetActive(true)
        end
    end
end

return UIRolePanel_GridTemplateRecast