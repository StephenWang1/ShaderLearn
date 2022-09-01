---@class UIRolePanel_EquipTemplateShenQi:UIRolePanel_EquipTemplateXianZhuang 神器角色模板
local UIRolePanel_EquipTemplateShenQi = {}

setmetatable(UIRolePanel_EquipTemplateShenQi, luaComponentTemplates.UIRolePanel_EquipTemplateXianZhuang)

function UIRolePanel_EquipTemplateShenQi:OnInit()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ShenQiChooseGridChange, function(msgId, bagItemInfo)
            self:SetItemShowChoose(bagItemInfo)
        end)
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateShenQi:OnItemClicked(go)
    ---@type UIRolePanel_GridTemplateBase
    local template = self.mGridToTemplate[go];
    if template:GetItemChooseState() == true then
        self:ShowItemInfo(template, false);
    else
        local tipsInfo = {};
        local bagItemInfo = template.bagItemInfo;
        if bagItemInfo ~= nil then
            local canSoulEquipSet = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsEquipCanInlay_XianZhuang(LuaEnumSoulEquipType.XianZhuang, bagItemInfo)
            if not canSoulEquipSet then
                tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 457
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo)
                Utility.ShowPopoTips(go, nil, 457)
                return
            end
        end
        luaEventManager.DoCallback(LuaCEvent.mRoleGridClicked_ShenQi, template.bagItemInfo)
    end
end

return UIRolePanel_EquipTemplateShenQi