---@class UIRolePanel_EquipTemplatesMosaic:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplatesMosaic = {}
setmetatable(UIRolePanel_EquipTemplatesMosaic, luaComponentTemplates.UIRolePanel_EquipTemplate)

function UIRolePanel_EquipTemplatesMosaic:OnEnable()
    self.medalInlayClickCallBack = function(msgID, index)
        self:OnMedalInlayClickCallBack(msgID, index)
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MedalInlay_SelectOfRolePanel, self.medalInlayClickCallBack)
    end
end

function UIRolePanel_EquipTemplatesMosaic:OnMedalInlayClickCallBack(msgID, index)
    for i, v in pairs(self.mGridToTemplate) do
        if v.equipIndex == index then
            if v.mChoose_GameObject ~= nil and not CS.StaticUtility.IsNull(v.mChoose_GameObject) then
                v.mChoose_GameObject:SetActive(true)
            end
            return
        end
    end
end

---重写点击装备
function UIRolePanel_EquipTemplatesMosaic:OnItemClicked(go)
    local template = self.mGridToTemplate[go]
    if template then
        --不符合镶嵌弹出tips
        if not self:isMeetMosaic(template.equipIndex) then
            self:ShowBubbleTips(go)
            return
        end
        if template.bagItemInfo ~= nil then
            if luaEventManager.HasCallback(LuaCEvent.Role_EquipGridClicked) then
                luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template.bagItemInfo)
            end
        end
        if template.mChoose_GameObject ~= nil and not CS.StaticUtility.IsNull(template.mChoose_GameObject) then
            template.mChoose_GameObject:SetActive(true)
        end
    end
end

---显示气泡
function UIRolePanel_EquipTemplatesMosaic:ShowBubbleTips(go)
    if go == nil then
        return
    end
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 118
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIRolePanel_EquipTemplatesMosaic:isMeetMosaic(equipIndex)
    return equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL)
end

function UIRolePanel_EquipTemplatesMosaic:OnDisable()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.MedalInlay_SelectOfRolePanel, self.medalInlayClickCallBack)
    end
end

return UIRolePanel_EquipTemplatesMosaic