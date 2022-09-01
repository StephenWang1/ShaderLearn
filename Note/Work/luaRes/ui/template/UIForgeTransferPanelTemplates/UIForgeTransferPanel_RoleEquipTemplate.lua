---转移重写角色总模板
---@class UIForgeTransferPanel_RoleEquipTemplate:UIRolePanel_EquipTemplate
local UIForgeTransferPanel_RoleEquipTemplate = {}

setmetatable(UIForgeTransferPanel_RoleEquipTemplate, luaComponentTemplates.UIRolePanel_EquipTemplate)

---取消拖拽事件
function UIForgeTransferPanel_RoleEquipTemplate:BindEvents(tbl, grid, equipIndex)
end

function UIForgeTransferPanel_RoleEquipTemplate:InitGrid(template, customData, avatarInfo)
    self:RunBaseFunction("InitGrid", template, customData, avatarInfo);
    self.lamp:SetActive(false);
    self.souljade:SetActive(false);
    self.jewel:SetActive(false);
    self.medal:SetActive(false);
    self.rawanima:SetActive(false);
    self.hufu:SetActive(false);
    self.seal:SetActive(false);
    self.maPai:SetActive(false);
    self.anqi:SetActive(false);

    self.helmet.transform.localPosition = CS.UnityEngine.Vector3(30, 113, 0);
    self.necklace.transform.localPosition = CS.UnityEngine.Vector3(30, 23, 0);
end

---设置选中
function UIForgeTransferPanel_RoleEquipTemplate:SetItemChoose(equipIndex, isChoose)
    if self.mEquipIndexToTemplate then
        local state = self:GetItemChooseState(equipIndex)
        if state ~= isChoose then
            local template = self.mEquipIndexToTemplate[equipIndex]
            if template then
                template:SetItemChoose(isChoose)
                self:SaveChooseState(equipIndex, isChoose)
            end
        end
    end
end

function UIForgeTransferPanel_RoleEquipTemplate:SaveChooseState(equipIndex, isChoose)
    if self.mEquipIndexToChooseState == nil then
        self.mEquipIndexToChooseState = {}
    end
    self.mEquipIndexToChooseState[equipIndex] = isChoose
end

function UIForgeTransferPanel_RoleEquipTemplate:GetItemChooseState(equipIndex)
    if self.mEquipIndexToChooseState then
        local state = self.mEquipIndexToChooseState[equipIndex]
        if state ~= nil then
            return state
        end
    end
    return false
end

---点击事件
function UIForgeTransferPanel_RoleEquipTemplate:OnItemClicked(go)
    local template = self.mGridToTemplate[go]
    if template ~= nil and template.bagItemInfo ~= nil then
        CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(template.bagItemInfo.ItemTABLE, CS.ItemSoundType.Touch)
    end
    luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template)
end

return UIForgeTransferPanel_RoleEquipTemplate