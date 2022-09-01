---@class copytemplatebase:TemplateBase
local copytemplatebase = {}

---@public
---@return UIComponentController
function copytemplatebase:GetUIComponentController()
    if self.mUIComponentController == nil then
        if CS.StaticUtility.IsNull(self:GetPrefabGO()) == false and CS.StaticUtility.IsNull(self:GetRootGO()) == false then
            self.mUIComponentController = luaclass.UIComponentController:New(self:GetRootGO(), self:GetPrefabGO())
        end
    end
    return self.mUIComponentController
end

---@protected
---@return UnityEngine.GameObject
function copytemplatebase:GetRootGO()
    return self.go
end

---@protected
---@return UnityEngine.GameObject
function copytemplatebase:GetPrefabGO()
    return nil
end

return copytemplatebase