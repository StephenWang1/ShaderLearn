---@class UISuitAttributeSoulEquipPanel:UIBase
local UISuitAttributeSoulEquipPanel = {};

---一行的高度(没有套装效果时的高度)
UISuitAttributeSoulEquipPanel.backGroudHigh_OneRow = 200
---增加的高度倍数
UISuitAttributeSoulEquipPanel.addRow = 60

function UISuitAttributeSoulEquipPanel:GetBackGround_UISprite()
    if(self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:GetCurComp("WidgetRoot/window/background","UISprite")
    end
    return self.mBackGround_UISprite;
end

function UISuitAttributeSoulEquipPanel:GetGridContainer()
    if(self.mGridContainer == nil) then
        self.mGridContainer = self:GetCurComp("WidgetRoot/view/SuitIcon/Grid","UIGridContainer");
    end
    return self.mGridContainer;
end

function UISuitAttributeSoulEquipPanel:GetSuitAttributeGridContainer()
    if(self.mSuitAttributeGridContainer == nil) then
        self.mSuitAttributeGridContainer = self:GetCurComp("WidgetRoot/ToggleArea/Grid","UIGridContainer");
    end
    return self.mSuitAttributeGridContainer;
end

function UISuitAttributeSoulEquipPanel:GetEquipIndexList()
    return gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetEquipIndexList();
end

function UISuitAttributeSoulEquipPanel:UpdateUI()
    local list = self:GetEquipIndexList();
    local gridContainer = self:GetGridContainer();
    gridContainer.MaxCount = #list;
    local index = 0;
    ---@param v number
    for k,v in pairs(list) do
        local soulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(v);
        local itemTemplate = gridContainer.controlList[index]
        local icon_UISprite = self:GetComp(itemTemplate.transform,"icon","UISprite")
        local level_UILabel = self:GetComp(itemTemplate.transform,"level","UILabel")
        icon_UISprite.spriteName = v;
        if(soulEquip ~= nil) then
            ---@type TABLE.cfg_items
            local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(soulEquip.itemId);
            if(itemTable ~= nil) then
                ---@type TABLE.cfg_suit
                local suitTable = gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetSuitTbl(itemTable:GetSuitBelong(), itemTable:GetGroup())
                if(suitTable ~= nil) then
                    level_UILabel.text = suitTable:GetName();
                end
            end
        else
            level_UILabel.text = luaEnumColorType.Red.."未镶嵌[-]";
        end
        index = index + 1;
    end

    self:UpdateSuitAttribute();
    self:GetBackGround_UISprite():SetDimensions(self:GetBackGround_UISprite().localSize.x,self.backGroudHigh_OneRow + self.addRow * self:GetSuitAttributeGridContainer().MaxCount)

end

function UISuitAttributeSoulEquipPanel:UpdateSuitAttribute()
    local gridContainer = self:GetSuitAttributeGridContainer();
    local soulEquip = nil
    local list = self:GetEquipIndexList();
    for k,v in pairs(list) do
        soulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(v);
        if(soulEquip ~= nil) then
            break;
        end
    end
    if(soulEquip ~= nil) then
        gridContainer.MaxCount = 1;
        local gobj = gridContainer.controlList[0];
        local suitName_Text = self:GetComp(gobj.transform,"FristAttr/content","UILabel")
        local suitAttr_Text = self:GetComp(gobj.transform,"FristAttr/attribute","UILabel")
        ---@type TABLE.cfg_items
        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(soulEquip.itemId);
        if(itemTable ~= nil) then
            ---@type TABLE.cfg_suit
            local suitTable = gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetBodySoulEquipSuitTable(itemTable:GetSuitBelong(), gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetLuaSoulEquipData())
            local isActive = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsSuitActive(suitTable:GetId())

            local bodySuitEquips = gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetBodySoulSuitEquip(itemTable:GetSuitBelong())
            if(suitTable ~= nil) then
                local color = (isActive and luaEnumColorType.Green or luaEnumColorType.Gray);
                suitName_Text.text = color.. suitTable:GetName().."("..#bodySuitEquips.."/"..suitTable:GetNeedNum()..")[-]";
                local value = 0;
                if(suitTable:GetAttributeParam() ~= nil and #suitTable:GetAttributeParam().list > 0) then
                    value = math.floor(suitTable:GetAttributeParam().list[1] / 100);
                end
                suitAttr_Text.text = color .. string.CSFormat(suitTable:GetDes(), value);
            end
        end
    else
        gridContainer.MaxCount = 0;
    end
end

function UISuitAttributeSoulEquipPanel:Init()
    self:AddCollider();
end

function UISuitAttributeSoulEquipPanel:Show()
    self:UpdateUI();
end

return UISuitAttributeSoulEquipPanel