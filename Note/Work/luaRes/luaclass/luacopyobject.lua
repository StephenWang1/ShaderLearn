---@class luacopyobject:luaobject
local luacopyobject = {}

---@private
---@return UIComponentController
function luacopyobject:GetUIComponentController()
    if self.mUIComponentController == nil then
        if CS.StaticUtility.IsNull(self:GetPrefabGO()) == false and CS.StaticUtility.IsNull(self:GetRootGO()) == false then
            self.mUIComponentController = luaclass.UIComponentController:New(self:GetRootGO(), self:GetPrefabGO())
        end
    end
    return self.mUIComponentController
end

---@protected
---@return UnityEngine.GameObject
function luacopyobject:GetRootGO()
    return self.go
end

---@protected
---@return UnityEngine.GameObject
function luacopyobject:GetPrefabGO()
    return nil
end

return luacopyobject