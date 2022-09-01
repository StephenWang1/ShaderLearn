---@class UIRolePanel_EquipTemplate_AgainSoulEquip:UIRolePanel_EquipTemplateSoulEquipSet 洗炼装备模板
local UIRolePanel_EquipTemplate_AgainSoulEquip = {}

setmetatable(UIRolePanel_EquipTemplate_AgainSoulEquip, luaComponentTemplates.UIRolePanel_EquipTemplateSoulEquipSet)

function UIRolePanel_EquipTemplate_AgainSoulEquip:OnInit()
    self.OnChooseItemChange = function(msgId, bagItemInfo)
        self:OnChooseBagItemChangeFunc(msgId, bagItemInfo)
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AgainSoulChangeChooseItem, self.OnChooseItemChange)
    end
end

function UIRolePanel_EquipTemplate_AgainSoulEquip:OnEnable()
end

function UIRolePanel_EquipTemplate_AgainSoulEquip:OnDisable()
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplate_AgainSoulEquip:OnItemClicked(go)
    ---@type UIRolePanel_GridTemplateSoulEquipSet
    local template = self.mGridToTemplate[go];
    if template and template.bagItemInfo then
        local soulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(template.equipIndex)
        if soulEquip then
            local active = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipActiveState(template.equipIndex)
            if active then
                luaEventManager.DoCallback(LuaCEvent.RolePanelClickedSoulEquip, soulEquip)
            else
                Utility.ShowPopoTips(go, nil, 460)
            end
        else
            Utility.ShowPopoTips(go, nil, 461)
        end
    end
end

---存储魂装装备位
function UIRolePanel_EquipTemplate_AgainSoulEquip:SaveSoulEquipToMainEquip(soulEquipLid, mainEquipIndex)
    if self.mSoulEquipLidToEquipIndex == nil then
        self.mSoulEquipLidToEquipIndex = {}
    end
    self.mSoulEquipLidToEquipIndex[soulEquipLid] = mainEquipIndex
end

---获取装备位
function UIRolePanel_EquipTemplate_AgainSoulEquip:GetSoulEquipIndex(soulEquipLid)
    if self.mSoulEquipLidToEquipIndex == nil then
        self.mSoulEquipLidToEquipIndex = {}
    end
    return self.mSoulEquipLidToEquipIndex[soulEquipLid]
end

---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_EquipTemplate_AgainSoulEquip:OnChooseBagItemChangeFunc(msgId, bagItemInfo)
    if bagItemInfo == nil then
        return
    end

    local equipIndex = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetEquipIndexBySetSoulEquip(bagItemInfo.lid)

    if self.CurrentChooseItemId ~= equipIndex then
        if self.mCurrentChooseGrid then
            self:SetItemShowChoose(false, self.mCurrentChooseGrid)
        end
        local go = self.mEquipIndexToGrid[equipIndex]
        if go then
            self:SetItemShowChoose(true, go)
        end
        self.CurrentChooseItemId = equipIndex
        self.mCurrentChooseGrid = go
    end
end

---设置某格子选中显示
function UIRolePanel_EquipTemplate_AgainSoulEquip:SetItemShowChoose(isShow, go)
    ---@type UIRolePanel_GridTemplateStrength
    local template = self.mGridToTemplate[go]
    if template then
        if template ~= nil and template.bagItemInfo ~= nil then
            CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(template.bagItemInfo.ItemTABLE, CS.ItemSoundType.Touch)
        end
        template:SetItemChoose(isShow)
        if isShow then
            luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template)
        end
    end
end

return UIRolePanel_EquipTemplate_AgainSoulEquip