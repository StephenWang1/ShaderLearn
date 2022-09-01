---@class UISynthesisMaterialUnitTemplate
local UISynthesisMaterialUnitTemplate = {};

UISynthesisMaterialUnitTemplate.mSynthesisTable = nil;

UISynthesisMaterialUnitTemplate.mItemId = 0;

---@type TABLE.cfg_items
UISynthesisMaterialUnitTemplate.mItemTable = nil;

UISynthesisMaterialUnitTemplate.mSynthesisCount = 1;

UISynthesisMaterialUnitTemplate.mNeedCount = 0;

---@type LuaMaterialData 合成材料的数据
UISynthesisMaterialUnitTemplate.SynthesisMaterialData = nil

--region Components

function UISynthesisMaterialUnitTemplate:GetAdd_GameObject()
    if (self.mAdd_GameObject == nil) then
        self.mAdd_GameObject = self:Get("add", "GameObject");
    end
    return self.mAdd_GameObject;
end

function UISynthesisMaterialUnitTemplate:GetCount_Text()
    if (self.mCount_Text == nil) then
        self.mCount_Text = self:Get("count", "UILabel");
    end
    return self.mCount_Text;
end

---@return UIItem
function UISynthesisMaterialUnitTemplate:GetUIItem()
    if (self.mUIItem == nil) then
        local gobj = self:Get("UIItem", "GameObject");
        self.mUIItem = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
    end
    return self.mUIItem;
end

function UISynthesisMaterialUnitTemplate:GetSynthesisCount()
    if (self.mSynthesisCount == nil) then
        self.mSynthesisCount = 1;
    end
    return self.mSynthesisCount;
end

function UISynthesisMaterialUnitTemplate:GetMainChooseBagItemInfo()
    if (self.mSynthesisViewTemplate ~= nil) then
        return self.mSynthesisViewTemplate:GetSynthesisMainBagItemInfo();
    end
    return nil;
end

---材料取用逻辑类型
function UISynthesisMaterialUnitTemplate:GetCurSynthesisUseMaterialType()
    if (self.mIsMainMaterial) then
        ---如果是主材料则从输入参数中拿逻辑
        if (self.mSynthesisViewTemplate ~= nil) then
            return self.mSynthesisViewTemplate:GetCurSynthesisUseMaterialType();
        end
        return LuaEnumSynthesisUseMaterialLogicType.RoleAndBag;
    else
        ---如果不是主材料就固定只取背包
        return LuaEnumSynthesisUseMaterialLogicType.OnlyBag;
    end
end

--endregion

---@param synthesisViewTemplate UISynthesisViewTemplate
function UISynthesisMaterialUnitTemplate:Init(synthesisViewTemplate)
    self.mSynthesisViewTemplate = synthesisViewTemplate;
    self:InitEvents();
end

function UISynthesisMaterialUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetUIItem().go).onClick = function()
        if (self.mItemTable ~= nil) then
            ---- 100962 合成内点击装备类型的+号时，直接弹出对应装备的tips，不显示获取途径
            --if self.mItemTable.type == luaEnumItemType.Equip then
            --    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mItemTable, showRight = false });
            --    return
            --end

            local isEnough = self:IsEnoughCost()
            if (isEnough) then
                if (self:GetMainChooseBagItemInfo() ~= nil and self:GetMainChooseBagItemInfo().itemId == self.mItemId) then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self:GetMainChooseBagItemInfo(), showRight = false });
                else
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mItemTable:CsTABLE() });
                end
            else
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.SynthesisPanel
                --Utility.ShowItemGetWay(self.mItemId, self:GetUIItem().go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero);
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mItemTable:CsTABLE() });
            end
        end
    end
end

--region Method

function UISynthesisMaterialUnitTemplate:UpdateUnit(synthesisTable, itemId, needCount, isMainMaterial)
    self.mSynthesisTable = synthesisTable;
    if (isMainMaterial == nil) then
        isMainMaterial = false;
    end
    self.mIsMainMaterial = isMainMaterial;
    self.mItemId = itemId;
    self.mNeedCount = needCount
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if (itemTbl) then
        self.mItemTable = itemTbl;
        self:GetUIItem():RefreshUIWithItemInfo(itemTbl:CsTABLE(), 1);
    end
    self:UpdateSynthesisCount(self:GetSynthesisCount());
end

function UISynthesisMaterialUnitTemplate:UpdateSynthesisCount(synthesisCount)
    self.mSynthesisCount = synthesisCount;
    self:UpdateMaterialData()
    self:UpdateUI()
end

function UISynthesisMaterialUnitTemplate:UpdateUI()
    if (CS.CSScene.MainPlayerInfo == nil) then
        return ;
    end

    local SynthesisUseMaterialType = self:GetCurSynthesisUseMaterialType();
    local materialCount = self:GetMaterialCount(SynthesisUseMaterialType)

    if (self.mSynthesisTable ~= nil and self.mItemId ~= nil) then
        local isEnough = self:IsEnoughCost()
        local colorStr = isEnough and luaEnumColorType.Green or luaEnumColorType.Red;
        self:GetCount_Text().text = colorStr .. materialCount .. "[-]/" .. luaEnumColorType.White .. self.mNeedCount * self:GetSynthesisCount() .. "[-]";
        local sprite = self:GetUIItem():GetItemIcon_UISprite();
        if (sprite ~= nil and CS.StaticUtility.IsNull(sprite)) then
            sprite.alpha = isEnough and 1 or 0.5;
        end
        self:GetAdd_GameObject():SetActive(not isEnough);
    end
end

function UISynthesisMaterialUnitTemplate:IsEnoughCost()
    local SynthesisUseMaterialType = self:GetCurSynthesisUseMaterialType();

    local materialCount = self:GetMaterialCount(SynthesisUseMaterialType)

    local isEnough = materialCount >= self.mNeedCount * self:GetSynthesisCount();
    return isEnough
end

function UISynthesisMaterialUnitTemplate:UpdateMaterialData()
    if (self.SynthesisMaterialData == nil) then
        self.SynthesisMaterialData = luaclass.LuaMaterialData:New()
    end
    self.SynthesisMaterialData:GenerateData(self.mItemId)
end

function UISynthesisMaterialUnitTemplate:GerMagicData(itemID)
    ---@type LuaMainPlayerEquipMgr
    local MainPlayerEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
    ---@type table<bagV2.BagItemInfo>
    local list = MainPlayerEquipMgr:GetAllMagicEquipItems()
    for i, v in pairs(list) do
        ---@type bagV2.BagItemInfo
        local item = v;
        if (item.itemId == itemID) then
            return item
        end
    end
    return nil
end

--return 得到材料数量
---@param SynthesisUseMaterialType LuaEnumSynthesisUseMaterialLogicType
function UISynthesisMaterialUnitTemplate:GetMaterialCount(SynthesisUseMaterialType)
    local materialCount = 0
    materialCount = materialCount + self:GetMaterialCountFromSynthesisMaterialData(self.SynthesisMaterialData, SynthesisUseMaterialType)

    return materialCount
end

---@param SynthesisMaterialData LuaMaterialData
function UISynthesisMaterialUnitTemplate:GetMaterialCountFromSynthesisMaterialData(SynthesisMaterialData, SynthesisUseMaterialType)
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


UISynthesisMaterialUnitTemplate.CostItemListCache = nil

UISynthesisMaterialUnitTemplate.CostCoinsListCache = nil;

---@param excludeId 排除这个lib的道具
function UISynthesisMaterialUnitTemplate:GetCostItems(excludeId)
    if (excludeId == nil) then
        excludeId = 0
    end
    self.CostItemListCache = {}
    self.CostCoinsListCache = {};
    local SynthesisUseMaterialType = self:GetCurSynthesisUseMaterialType();

    if (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.All) then
        self.SynthesisMaterialData:GetAllCostItemLidList(self.CostItemListCache, self.CostCoinsListCache, excludeId)

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.OnlyBag) then
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.Bag, excludeId)
        self.SynthesisMaterialData:InsertCostCoinsIdList(self.CostCoinsListCache, LuaItemSavePos.Bag);
    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.RoleAndBag) then
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.Bag, excludeId)
        self.SynthesisMaterialData:InsertCostCoinsIdList(self.CostCoinsListCache, LuaItemSavePos.Bag);
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.RoleEquip, excludeId)
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.MagicWeapon, excludeId)
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.Elements, excludeId)
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.Imprint, excludeId)
        if (uiStaticParameter.OpenEudemonsDetection) then
            self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.RoleServant, excludeId)
        end

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.HMAndBag and uiStaticParameter.OpenEudemonsDetection) then
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.Bag, excludeId)
        self.SynthesisMaterialData:InsertCostCoinsIdList(self.CostCoinsListCache, LuaItemSavePos.Bag);
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.ServantEquip_HM, excludeId)

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.LXAndBag and uiStaticParameter.OpenEudemonsDetection) then
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.Bag, excludeId)
        self.SynthesisMaterialData:InsertCostCoinsIdList(self.CostCoinsListCache, LuaItemSavePos.Bag);
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.ServantEquip_LX, excludeId)

    elseif (SynthesisUseMaterialType == LuaEnumSynthesisUseMaterialLogicType.TCAndBag and uiStaticParameter.OpenEudemonsDetection) then
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.Bag, excludeId)
        self.SynthesisMaterialData:InsertCostCoinsIdList(self.CostCoinsListCache, LuaItemSavePos.Bag);
        self.SynthesisMaterialData:InsertCostItemLidList(self.CostItemListCache, LuaItemSavePos.ServantEquip_TC, excludeId)
    end
    return self.CostItemListCache, self.CostCoinsListCache
end

--endregion


return UISynthesisMaterialUnitTemplate;