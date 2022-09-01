---@class UIRolePanel_EquipTemplateForgeQuench:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplateForgeQuench = {}
setmetatable(UIRolePanel_EquipTemplateForgeQuench, luaComponentTemplates.UIRolePanel_EquipTemplate)

function UIRolePanel_EquipTemplateForgeQuench:OnEnable()
    self:RunBaseFunction("OnEnable");
    ---@type UIRolePanel_GridTemplateForgeQuench 当前选中的模板
    self.curCheckTemplate = nil
    self.CallOnResCuiLianMessage = function(msgId, tblData)
        self:OnResCuiLianMessage(tblData)
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSynthesisMessage, self.CallOnResCuiLianMessage)
    end
end

function UIRolePanel_EquipTemplateForgeQuench:OnDisable()
    self:RunBaseFunction("OnDisable");
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResCuiLianMessage, self.CallOnResCuiLianMessage)
    end
end

function UIRolePanel_EquipTemplateForgeQuench:OnDestroy()
    self:RunBaseFunction("OnDestroy");
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResCuiLianMessage, self.CallOnResCuiLianMessage)
    end
end

function UIRolePanel_EquipTemplateForgeQuench:OnResCuiLianMessage(data)
    if data.state == 1 then
        if self.curCheckTemplate ~= nil then
            self.curCheckTemplate:ChooseItem(false)
            self.curCheckTemplate = nil
        end
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateForgeQuench:OnItemClicked(go)
    ---@type UIRolePanel_GridTemplateForgeQuench
    local template = self.mGridToTemplate[go];

    if template == nil or template.bagItemInfo == nil then
        return
    end

    if template.mIsChoose then
        self:ShowItemInfo(template, false)
    elseif template.bagItemInfo ~= nil then
        if not template:IsAvailableForForgeQuench(template.bagItemInfo) then
            Utility.ShowPopoTips(go, nil, 499, "UIRolePanel")
            return
        elseif not template:IsShow(template.bagItemInfo) then
            Utility.ShowPopoTips(go, nil, 500, "UIRolePanel")
            return
        elseif template:IsInsurance(template.bagItemInfo) then
            Utility.ShowPopoTips(go, nil, 499, "UIRolePanel")
            return
        else
            luaEventManager.DoCallback(LuaCEvent.ForgeQuenchItemCheck, {
                type = LuaEnumForgeQuenchItemCheckReason.Role,
                id = template.bagItemInfo.ItemTABLE.id,
                itemId = template.bagItemInfo.ItemTABLE.id
            })
        end
    end
    self:RefreshCheckState(template)
end

---刷新选中框状态
function UIRolePanel_EquipTemplateForgeQuench:RefreshCheckState(template)

    if self.curCheckTemplate == template then
        return
    end
    if self.curCheckTemplate ~= nil then
        self.curCheckTemplate:SetItemChoose(false)
    end
    self.curCheckTemplate = template
    self.curCheckTemplate:SetItemChoose(true)
end

return UIRolePanel_EquipTemplateForgeQuench