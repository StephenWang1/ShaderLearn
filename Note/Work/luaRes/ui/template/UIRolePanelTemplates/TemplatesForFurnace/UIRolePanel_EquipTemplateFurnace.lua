local UIRolePanel_EquipTemplateFurnace = {}

setmetatable(UIRolePanel_EquipTemplateFurnace, luaComponentTemplates.UIRolePanel_EquipTemplate)

UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem = nil

---帧更新事件
function UIRolePanel_EquipTemplateFurnace:Update()
    if (self.mIsLongPress) then
        self.mTimer = self.mTimer + CS.UnityEngine.Time.deltaTime;
        if (self.mTimer >= 0.2) then
            self.mIsLongPress = false;
            if (self.mPressTarget ~= nil) then
                local template = self.mGridToTemplate[self.mPressTarget]
                self:ShowItemInfo(template, false);
                self.mPressTarget = nil;
            end
            return ;
        end
    end
end

---重写角装备格子按下事件
function UIRolePanel_EquipTemplateFurnace:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true;
        self.mPressTarget = go;
    else
        self.mIsLongPress = false;
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateFurnace:OnItemClicked(go)
    if (UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem == go) then
        local template = self.mGridToTemplate[go]
        self:ShowItemInfo(template, false);
    end
end

---重写选中角色格子事件
function UIRolePanel_EquipTemplateFurnace:SetItemChoose(equipIndex)
    if self.mEquipIndexToTemplate and equipIndex and self.mEquipIndexToTemplate[equipIndex] then
        local go = self.mEquipIndexToGrid[equipIndex]
        if UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem == go then
            return
        end
        self:HideCurrentChooseItem()
        self:SetItemShowChoose(true, go)
        UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem = go

        for k, v in pairs(self.mEquipIndexToTemplate) do
            v:UpdateIconColor();
        end
    end
end

---隐藏当前选中物品
function UIRolePanel_EquipTemplateFurnace:HideCurrentChooseItem()
    if UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem ~= nil then
        self:SetItemShowChoose(false, UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem)
        UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem = nil
    end
end

---设置某格子选中显示
function UIRolePanel_EquipTemplateFurnace:SetItemShowChoose(isShow, go)
    local template = self.mGridToTemplate[go]
    if template and template.ChooseItem then
        template:ChooseItem(isShow)
    end
end

--function UIRolePanel_EquipTemplateFurnace:OnDestroy()
--    UIRolePanel_EquipTemplateFurnace.mCurrentChooseItem = nil
--end

return UIRolePanel_EquipTemplateFurnace