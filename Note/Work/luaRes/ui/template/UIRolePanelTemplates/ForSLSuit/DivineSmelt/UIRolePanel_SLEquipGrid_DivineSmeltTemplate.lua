---@class UIRolePanel_SLEquipGrid_DivineSmeltTemplate:UIRolePanel_SLEquipGridTemp 神力装备格子模板定义（神炼继承）
local UIRolePanel_SLEquipGrid_DivineSmeltTemplate = {}

setmetatable(UIRolePanel_SLEquipGrid_DivineSmeltTemplate, luaComponentTemplates.UIRolePanel_SLEquipGridTemp)

function UIRolePanel_SLEquipGrid_DivineSmeltTemplate:RedPoint()
    if self.red == nil then
        self.red = self:Get('background/Red', 'Top_UIRedPoint')
    end
    return self.red
end

function UIRolePanel_SLEquipGrid_DivineSmeltTemplate:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        if self.bagItemInfo then
            luaEventManager.DoCallback(LuaCEvent.RoleForgeGodPowerSmeltItemClicked, self.bagItemInfo)
        end
    end
end

---绑定红点
function UIRolePanel_SLEquipGrid_DivineSmeltTemplate:BindRedPoint()

    Utility.RegisterRedPoint(self:RedPoint(), self:GetRedPointKey())
    if self:RedPoint() ~= nil then
        self:RedPoint():AddRedPointKey(self:GetRedPointKey())
    end
    local luaRedPointMgr = gameMgr:GetLuaRedPointManager()
    luaRedPointMgr:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetRedPointKey(), function()
        ---@type LuaMainPlayerEquipMgr
        local equipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
        if(equipMgr.IsShowForgeGodPowerSmeltRedList == nil) then
            return false
        end
        for i, equipIndex in pairs(equipMgr.IsShowForgeGodPowerSmeltRedList) do
            --equipIndex:装备为
            if(equipIndex == self.equipIndex) then
                return true;
            end
        end
        return false
    end)

    self:CallRedPoint();
end


function UIRolePanel_SLEquipGrid_DivineSmeltTemplate:CallRedPoint()
    local luaRedPointMgr = gameMgr:GetLuaRedPointManager()
    luaRedPointMgr:CallRedPoint(self:GetRedPointKey())
end

---移除红点
function UIRolePanel_SLEquipGrid_DivineSmeltTemplate:RemoveRedPoint()
    if self:RedPoint() ~= nil then
        self:RedPoint():RemoveRedPointKey();
    end
end

function UIRolePanel_SLEquipGrid_DivineSmeltTemplate:GetRedPointKey()
    local keyName = "UIRolePanel_SLEquipGrid_DivineSmeltTemplate"..self.equipIndex

    local redKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(keyName);
    return redKey;
end


return UIRolePanel_SLEquipGrid_DivineSmeltTemplate