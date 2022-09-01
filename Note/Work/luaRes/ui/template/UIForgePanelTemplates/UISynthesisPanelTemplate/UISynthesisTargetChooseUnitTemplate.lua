---@class UISynthesisTargetChooseUnitTemplate:TemplateBase
local UISynthesisTargetChooseUnitTemplate = {};

---@type UISynthesisTargetChoosePanel
UISynthesisTargetChooseUnitTemplate.mOwnerPanel = nil;

--region Components

function UISynthesisTargetChooseUnitTemplate:GetUIItem_GameObject()
    if (self.mUIItem_GameObject == nil) then
        self.mUIItem_GameObject = self:Get("UIItem", "GameObject");
    end
    return self.mUIItem_GameObject;
end

function UISynthesisTargetChooseUnitTemplate:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("background", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UISynthesisTargetChooseUnitTemplate:GetUIItem()
    if (self.mUIItem == nil) then
        self.mUIItem = templatemanager.GetNewTemplate(self:GetUIItem_GameObject(), luaComponentTemplates.UIItem);
    end
    return self.mUIItem;
end

function UISynthesisTargetChooseUnitTemplate:GetItemName_Text()
    if (self.mItemName_Text == nil) then
        self.mItemName_Text = self:Get("name", "UILabel");
    end
    return self.mItemName_Text;
end

---材料取用逻辑类型
function UISynthesisTargetChooseUnitTemplate:GetCurSynthesisUseMaterialType()
    ---@type UISynthesisPanel
    local synthesisPanel = uimanager:GetPanel("UISynthesisPanel")
    if (synthesisPanel ~= nil) then
        ---如果是主材料则从输入参数中拿逻辑
        if (synthesisPanel:GetSynthesisViewTemplate() ~= nil) then
            return synthesisPanel:GetSynthesisViewTemplate():GetCurSynthesisUseMaterialType();
        end
        return LuaEnumSynthesisUseMaterialLogicType.RoleAndBag;
    end
    return LuaEnumSynthesisUseMaterialLogicType.All;
end


--endregion

--region Method

--region Public

---@param synthesisTable TABLE.cfg_synthesis
function UISynthesisTargetChooseUnitTemplate:UpdateUnit(synthesisTable)
    if (synthesisTable ~= nil) then
        self.mSynthesisTable = synthesisTable;
        if (synthesisTable:GetItemid() ~= nil and synthesisTable:GetItemid().list ~= nil and #synthesisTable:GetItemid().list > 0) then
            local mainMaterialId = synthesisTable:GetItemid().list[1];
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(mainMaterialId);
            if (isFind) then
                self:GetItemName_Text().text = itemTable.name;
                local count = synthesisTable:GetNumber().list[1]
                self:UpdateMaterialData(mainMaterialId);
                local mCount = self:GetMaterialCount(self:GetCurSynthesisUseMaterialType());
                self:GetUIItem():RefreshUIWithItemInfo(itemTable, mCount);
                self:GetUIItem():SetIsLock(mCount <= 0);
            end
        end
    end
end

function UISynthesisTargetChooseUnitTemplate:UpdateMaterialData(itemId)
    if (self.SynthesisMaterialData == nil) then
        self.SynthesisMaterialData = luaclass.LuaMaterialData:New()
    end
    self.SynthesisMaterialData:GenerateData(itemId)
end

---@param SynthesisUseMaterialType LuaEnumSynthesisUseMaterialLogicType
function UISynthesisTargetChooseUnitTemplate:GetMaterialCount(SynthesisUseMaterialType)
    local materialCount = 0
    materialCount = materialCount + self:GetMaterialCountFromSynthesisMaterialData(self.SynthesisMaterialData, SynthesisUseMaterialType)

    return materialCount
end

---@param SynthesisMaterialData LuaMaterialData
function UISynthesisTargetChooseUnitTemplate:GetMaterialCountFromSynthesisMaterialData(SynthesisMaterialData, SynthesisUseMaterialType)
    local materialCount = 0
    if (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.All) then
        materialCount = SynthesisMaterialData:GetAllMaterialCount()

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.OnlyBag) then
        materialCount = SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Bag)

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.RoleAndBag) then
        materialCount = SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Bag)
        materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.RoleEquip)
        materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Elements)
        materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Imprint)
        if (uiStaticParameter.OpenEudemonsDetection) then
            materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.RoleServant)
        end

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.HMAndBag and uiStaticParameter.OpenEudemonsDetection) then
        materialCount = SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Bag)
        materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.ServantEquip_HM)

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.LXAndBag and uiStaticParameter.OpenEudemonsDetection) then
        materialCount = SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Bag)
        materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.ServantEquip_LX)

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.TCAndBag and uiStaticParameter.OpenEudemonsDetection) then
        materialCount = SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Bag)
        materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.ServantEquip_TC)
    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.MagicWeapon) then
        materialCount = SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.Bag)
        materialCount = materialCount + SynthesisMaterialData:GetMaterialCount(LuaItemSavePos.MagicWeapon)
    end

    return materialCount
end
--endregion

--endregion

--endregion

function UISynthesisTargetChooseUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UISynthesisTargetChoosePanel");
        luaEventManager.DoCallback(LuaCEvent.Synthesis_OnSynthesisTargetChoose, self.mSynthesisTable);
    end
end

function UISynthesisTargetChooseUnitTemplate:Init(panel)
    self.mOwnerPanel = panel;
    self:InitEvents();
end

return UISynthesisTargetChooseUnitTemplate;