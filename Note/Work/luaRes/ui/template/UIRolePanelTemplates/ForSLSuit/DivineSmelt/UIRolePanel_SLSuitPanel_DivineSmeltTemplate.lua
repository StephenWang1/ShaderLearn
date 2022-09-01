---@class UIRolePanel_SLSuitPanel_DivineSmeltTemplate:UIRolePanel_SLSuitPanelTemplate 神力装备面板模板定义(神炼继承)
local UIRolePanel_SLSuitPanel_DivineSmeltTemplate = {}

setmetatable(UIRolePanel_SLSuitPanel_DivineSmeltTemplate, luaComponentTemplates.UIRolePanel_SLSuitPanelTemplate)

---@return UIRolePanel_SLEquipGrid_DivineSmeltTemplate
function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:GetGridTemp()
    return luaComponentTemplates.UIRolePanel_SLEquipGrid_DivineSmeltTemplate
end

function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:UpdateItemData(equipBasicIndex)
    self:RunBaseFunction("UpdateItemData", equipBasicIndex)
    local equipIndex = 100000 + 1000 * self.Type + equipBasicIndex
    ---@type UIRolePanel_GridTemplateSynthesis
    local temp = self.EquipGridDic[equipBasicIndex]
    if (temp == nil) then
        return ;
    end
    temp:SetItemChoose(self:GetItemNeedChoose(equipIndex))
end

---判断道具是否需要选中
function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:GetItemNeedChoose(equipIndex)
    if self.mCurrentChooseBagItemInfo and self.mCurrentChooseBagItemInfo.index == equipIndex then
        return true
    end
    return false
end

---设置默认神力的选中
function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:SetDefaultForgetGodPowerSelect()
    if(self.EquipGridDic == nil) then
        return
    end
    for i, v in pairs(self.EquipGridDic) do
        ---@type UIRolePanel_SLEquipGridTemp
        local SLEquipGridTemp = v
        if(SLEquipGridTemp.bagItemInfo ~= nil and SLEquipGridTemp.equipIndex == gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr().IsShowForgeGodPowerSmeltRedEquipIndex) then
            self:SetCurrentChooseItem(SLEquipGridTemp.bagItemInfo);
            luaEventManager.DoCallback(LuaCEvent.RoleForgeGodPowerSmeltItemClicked, SLEquipGridTemp.bagItemInfo)
        end
    end
end

---设置当前选中
---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:SetCurrentChooseItem(bagItemInfo)
    if self.mCurrentChooseBagItemInfo then
        self:UpdateSingleEquipChooseStateByEquipIndex(self.mCurrentChooseBagItemInfo.index, false)
    end
    self.mCurrentChooseBagItemInfo = bagItemInfo

    if(bagItemInfo == nil) then
        return;
    end
    self:UpdateSingleEquipChooseStateByEquipIndex(bagItemInfo.index, true)
end

---刷新单个装备选中状态（根据装备位）
function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:UpdateSingleEquipChooseStateByEquipIndex(equipIndex, needChoose)
    local basicIndex = self:GetBasicIndexByEquipIndex(equipIndex)
    if basicIndex then
        self:UpdateSingleEquipChooseStateByBasicIndex(basicIndex, needChoose)
    end
end

---刷新单个装备选中状态（根据subtype）
---@param equipBasicIndex LuaEquipmentItemType
function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:UpdateSingleEquipChooseStateByBasicIndex(equipBasicIndex, needChoose)
    ---@type UIRolePanel_SLEquipGrid_DivineSmeltTemplate
    local temp = self.EquipGridDic[equipBasicIndex]
    if (temp == nil) then
        return
    end
    temp:SetItemChoose(needChoose)
end

---根据装备位获取对应的枚举
---@return LuaEquipmentItemType subtype
---@param  equipIndex number 装备位
function UIRolePanel_SLSuitPanel_DivineSmeltTemplate:GetBasicIndexByEquipIndex(equipIndex)
    return Utility.GetSLEquipBasicIndex(equipIndex)
end

return UIRolePanel_SLSuitPanel_DivineSmeltTemplate