local UIRolePanel_EquipTemplateSignet = {}
setmetatable(UIRolePanel_EquipTemplateSignet, luaComponentTemplates.UIRolePanel_EquipTemplate)

function UIRolePanel_EquipTemplateSignet:RefreshGrid(imprint)
    if imprint then
        local temp = self.mEquipIndexToTemplate[imprint.index]
        if temp then
            temp:RefreshGrid(imprint)
        end
    end
end

function UIRolePanel_EquipTemplateSignet:RefreshAll()
    for k, item in pairs(self.mEquipIndexToTemplate) do
        item:RefreshStart()
    end
end

---帧更新事件
function UIRolePanel_EquipTemplateSignet:Update()
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
            return;
        end
    end
end

function UIRolePanel_EquipTemplateSignet:InitGrid(template, customData, avatarInfo)
    self:RunBaseFunction("InitGrid", template, customData, avatarInfo);
    self.lamp:SetActive(false);
    self.souljade:SetActive(false);
    self.jewel:SetActive(false);
    self.medal:SetActive(false);
    self.rawanima:SetActive(false);

    self.helmet.transform.localPosition = CS.UnityEngine.Vector3(30, 113, 0);
    self.necklace.transform.localPosition = CS.UnityEngine.Vector3(30, 23, 0);
end

---重写角装备格子按下事件
function UIRolePanel_EquipTemplateSignet:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true;
        self.mPressTarget = go;
    else
        self.mIsLongPress = false;
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateSignet:OnItemClicked(go)
    if (not self.mIsLongPressShowItemInfo) then
        local template = self.mGridToTemplate[go]
        if template.IsMayInlay then
            luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template)
            self:SetItemShowChoose(go)
        else
            self:ShowTips(go.transform, 231);
        end
    end
    self.mIsLongPressShowItemInfo = false;
end

--提示信息
function UIRolePanel_EquipTemplateSignet:ShowTips(trans, id, des)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans
    if des ~= nil then
        TipsInfo[LuaEnumTipConfigType.Describe] = des
    end
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UISignetPanel"
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end

---设置某格子选中显示
function UIRolePanel_EquipTemplateSignet:SetItemShowChoose(go)
    for k, v in pairs(self.mGridToTemplate) do
        if k == go then
            local template = self.mGridToTemplate[go]
            if template ~= nil and template.bagItemInfo ~= nil then
                CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(template.bagItemInfo.ItemTABLE, CS.ItemSoundType.Touch)
            end
        end
        v:SetItemChoose(k == go)
    end
end



return UIRolePanel_EquipTemplateSignet