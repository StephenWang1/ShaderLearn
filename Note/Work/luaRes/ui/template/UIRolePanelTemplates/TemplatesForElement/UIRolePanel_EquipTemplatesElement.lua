---@class UIRolePanel_EquipTemplatesElement:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplatesElement = {}

setmetatable(UIRolePanel_EquipTemplatesElement, luaComponentTemplates.UIRolePanel_EquipTemplate)

---获取显示装备信息
---@param equipIndex XLua.Cast.Int32 装备位index
---@return string iconName
--function UIRolePanel_EquipTemplatesElement:GetEquipInfo(equipIndex)
--    return CS.CSScene.MainPlayerInfo.ElementInfo:GetRoleIconName(equipIndex)
--end

---刷新装备格子显示
function UIRolePanel_EquipTemplatesElement:RefreshGrid()
    if UIRolePanel_EquipTemplatesElement.mEquipIndexToTemplate then
        for k, v in pairs(UIRolePanel_EquipTemplatesElement.mEquipIndexToTemplate) do
            --region 添加附加的额外装备显示
            local extraEquips = self:GetExtraEquipList(k);
            if (extraEquips ~= nil) then
                v:AddExtraEquips(extraEquips);
            end
            --endregion
            local info = self:GetEquipInfo(k)
            v:ShowEquip(info, k)
        end
    end
end

function UIRolePanel_EquipTemplatesElement:HideCurrentChooseItem()
    if self.mCurrentChooseItem ~= nil then
        self:SetItemShowChoose(false, self.mCurrentChooseItem)
        self.mCurrentChooseItem = nil
    end
end

function UIRolePanel_EquipTemplatesElement:InitGrid(template, customData, avatarInfo)
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

---帧更新事件
function UIRolePanel_EquipTemplatesElement:Update()
    if (self.mIsLongPress) then
        self.mTimer = self.mTimer + CS.UnityEngine.Time.deltaTime;
        if (self.mTimer >= 0.2) then
            self.mIsLongPress = false;
            if (self.mPressTarget ~= nil) then
                local template = self.mGridToTemplate[self.mPressTarget]
                self:ShowItemInfo(template, false);
                self.mIsLongPressShowItemInfo = true;
                self.mPressTarget = nil;
            end
            return ;
        end
    end
end

---重写角装备格子按下事件
function UIRolePanel_EquipTemplatesElement:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true;
        self.mPressTarget = go;
    else
        self.mIsLongPress = false;
    end
end

---重写点击装备
function UIRolePanel_EquipTemplatesElement:OnItemClicked(go)
    if not self.mIsLongPressShowItemInfo then
        local template = self.mGridToTemplate[go]
        if template == nil or template.bagItemInfo == nil then
            return
        end
        if template.isCanInlay then
            if template.isChoose == true then
                self:ShowItemInfo(template, false)
                return
            end
            local template = self.mGridToTemplate[go]
            self.lastChooseTable = template
            if template then
                self:HideAllChoose()
                self:SetItemShowChoose(true, go)
            end
        else
            Utility.ShowPopoTips(go, nil, 190)
        end
    end
    self.mIsLongPressShowItemInfo = false
end

function UIRolePanel_EquipTemplatesElement:HideAllChoose()
    for k, v in pairs(self.mGridToTemplate) do
        v:ChooseItem(false)
    end
end

---设置某格子选中显示
function UIRolePanel_EquipTemplatesElement:SetItemShowChoose(isShow, go)
    ---@type UIRolePanel_GridTemplateStrength
    local template = self.mGridToTemplate[go]
    if template then
        if template ~= nil and template.bagItemInfo ~= nil then
            CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(template.bagItemInfo.ItemTABLE, CS.ItemSoundType.Touch)
        end
        template:ChooseItem(isShow)
        if isShow then
            luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template)
        end
    end
end

return UIRolePanel_EquipTemplatesElement