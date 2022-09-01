---@class UIRolePanel_EquipTemplateStrengthen:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplateStrengthen = {}

setmetatable(UIRolePanel_EquipTemplateStrengthen, luaComponentTemplates.UIRolePanel_EquipTemplate)

---当前选中装备格子
UIRolePanel_EquipTemplateStrengthen.mCurrentChooseGrid = nil

---当前选中装备位
UIRolePanel_EquipTemplateStrengthen.CurrentChooseEquipIndex = nil

---帧更新事件
function UIRolePanel_EquipTemplateStrengthen:Update()
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
function UIRolePanel_EquipTemplateStrengthen:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true;
        self.mPressTarget = go;
    else
        self.mIsLongPress = false;
    end
end

function UIRolePanel_EquipTemplateStrengthen:OnInit()
    self.OnChooseItemChange = function(msgId, bagItemInfo)
        self:OnChooseBagItemChangeFunc(msgId, bagItemInfo)
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.StrengthenBagItemChange, self.OnChooseItemChange)
    end
end

function UIRolePanel_EquipTemplateStrengthen:InitGrid(template, customData, avatarInfo)
    self:RunBaseFunction("InitGrid", template, customData, avatarInfo);
    self.lamp:SetActive(false);
    self.souljade:SetActive(false);
    self.jewel:SetActive(false);
    self.medal:SetActive(false);
    self.rawanima:SetActive(false);
    self.hufu:SetActive(false)
    self.seal:SetActive(false)
    self.maPai:SetActive(false);
    self.anqi:SetActive(false);

    self.helmet.transform.localPosition = CS.UnityEngine.Vector3(30, 113, 0);
    self.necklace.transform.localPosition = CS.UnityEngine.Vector3(30, 23, 0);
end

function UIRolePanel_EquipTemplateStrengthen:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.StrengthenBagItemChange, self.OnChooseItemChange)
    end
end

---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_EquipTemplateStrengthen:OnChooseBagItemChangeFunc(msgId, bagItemInfo)
    local equipIndex = bagItemInfo.index
    if equipIndex ~= self.CurrentChooseEquipIndex then
        --self:HideCurrentChooseItem()
        if self.mCurrentChooseGrid then
            self:SetItemShowChoose(false, self.mCurrentChooseGrid)
        end
        local go = self.mEquipIndexToGrid[equipIndex]
        if go then
            self:SetItemShowChoose(true, go)
        end
        self.CurrentChooseItemId = bagItemInfo.index
        self.mCurrentChooseGrid = go
    end
end

---取消拖拽事件
--function UIRolePanel_EquipTemplateStrengthen:BindEvents(tbl, grid, equipIndex)
--
--end

---重写点击装备
function UIRolePanel_EquipTemplateStrengthen:OnItemClicked(go)
    if (not self.mIsLongPressShowItemInfo) then
        if self.mCurrentChooseGrid == go then
            local template = self.mGridToTemplate[go]
            self:ShowItemInfo(template, false);
        else
            local template = self.mGridToTemplate[go]
            if template and template.bagItemInfo then
                local canStrength = self:GetBagInfoV2():CanItemStrength(template.bagItemInfo)
                if canStrength then
                    luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template)
                    self.mCurrentChooseGrid = go;
                else
                    CS.Utility.ShowTips("此部位无法升星", 1)
                end
            end
        end
    end
    self.mIsLongPressShowItemInfo = false;
end

---设置某格子选中显示
function UIRolePanel_EquipTemplateStrengthen:SetItemShowChoose(isShow, go)
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

function UIRolePanel_EquipTemplateStrengthen:DestroyFunction()
    if self.mGridToTemplate then
        for k, v in pairs(self.mGridToTemplate) do
            ---@type UIRolePanel_GridTemplateStrength
            local temp = v
            temp:ClearRedPointFunc()
        end
    end
end

return UIRolePanel_EquipTemplateStrengthen