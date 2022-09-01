---@class UIRolePanel_EquipTemplateSoulEquipSet:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplateSoulEquipSet = {}

setmetatable(UIRolePanel_EquipTemplateSoulEquipSet, luaComponentTemplates.UIRolePanel_EquipTemplate)

---@type UIRolePanel_GridTemplateSoulEquipSet
UIRolePanel_EquipTemplateSoulEquipSet.mSelectTemplate = nil;

---@return bagV2.BagItemInfo
function UIRolePanel_EquipTemplateSoulEquipSet:GetSelectBagItemInfo()
    ---@type UISoulEquipmentSetPanel
    local soulEquipSetPanel = uimanager:GetPanel("UISoulEquipmentSetPanel");
    if(soulEquipSetPanel ~= nil) then
        return soulEquipSetPanel:GetSelectEquip();
    end
    return nil;
end

function UIRolePanel_EquipTemplateSoulEquipSet:InitGrid(template, customData, avatarInfo)
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
function UIRolePanel_EquipTemplateSoulEquipSet:Update()
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
function UIRolePanel_EquipTemplateSoulEquipSet:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true;
        self.mPressTarget = go;
    else
        self.mIsLongPress = false;
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateSoulEquipSet:OnItemClicked(go)
    ---@type UIRolePanel_GridTemplateBase
    local template = self.mGridToTemplate[go];
    if (template.mIsChoose) then
        self:ShowItemInfo(template, false);
    else
        local tipsInfo = {};
        local hasError = false;
        local bagItemInfo = template.bagItemInfo;
        if bagItemInfo ~= nil then
            local canSoulEquipSet = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CanSetSoulEquip(template.itemInfo.id);
            local hasSoulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(bagItemInfo.index) ~= nil;
            if(not canSoulEquipSet and not hasSoulEquip) then
                hasError = true;
                tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 457
            end
        end

        if (not hasError) then
            self:RunBaseFunction("OnItemClicked", go);
        else
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
        end
    end
end

---重写选中角色格子事件
function UIRolePanel_EquipTemplateSoulEquipSet:SetItemChoose(equipIndex)
    self:UpdateGrid();
end

---隐藏当前选中物品
function UIRolePanel_EquipTemplateSoulEquipSet:HideCurrentChooseItem()
    self:UpdateGrid();
end

---设置某格子选中显示
function UIRolePanel_EquipTemplateSoulEquipSet:SetItemShowChoose(isShow, go)
    local template = self.mGridToTemplate[go]
    if template and template.ChooseItem then
        template:ChooseItem(isShow)
    end
end

function UIRolePanel_EquipTemplateSoulEquipSet:UpdateGrid()
    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
    self.mCoroutineUpdateGrid = StartCoroutine(self.CDelayUpdateGrid, self);
    --self:CDelayUpdateGrid();
end

function UIRolePanel_EquipTemplateSoulEquipSet:CDelayUpdateGrid()
    coroutine.yield(0);
    self:RefreshGrid();
    for k, v in pairs(self.mGridToTemplate) do
        self:SetItemShowChoose(false, v.go);
        if (v.bagItemInfo ~= nil) then
            local selectBagItemInfo = self:GetSelectBagItemInfo();
            if(self:GetSelectBagItemInfo() ~= nil) then
                if(v.bagItemInfo.lid == selectBagItemInfo.lid) then
                    self:SetItemShowChoose(true, v.go);
                end
            end
        end
        v:UpdateSoulEquipSign();
    end
end

function UIRolePanel_EquipTemplateSoulEquipSet:OnEnable()
    self:RunBaseFunction("OnEnable");
    if(self.mOwnerPanel ~= nil) then
        self.CallOnSelectSoulEquip = function()
            self:UpdateGrid();
        end
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.SoulEquip_OnSelectSoulEquip, self.CallOnSelectSoulEquip);

        self.CallResAllSoulEquipInfoMessage = function()
            self:UpdateGrid();
        end
        self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAllSoulEquipInfoMessage, self.CallResAllSoulEquipInfoMessage);
    end
end

function UIRolePanel_EquipTemplateSoulEquipSet:OnDisable()
    self:RunBaseFunction("OnDisable");

    if(self.mOwnerPanel ~= nil) then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.SoulEquip_OnSelectSoulEquip, self.CallOnSelectSoulEquip);
        self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResAllSoulEquipInfoMessage, self.CallResAllSoulEquipInfoMessage);
    end

    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
end

function UIRolePanel_EquipTemplateSoulEquipSet:OnDestroy()
    self:RunBaseFunction("OnDestroy");

    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
end

return UIRolePanel_EquipTemplateSoulEquipSet