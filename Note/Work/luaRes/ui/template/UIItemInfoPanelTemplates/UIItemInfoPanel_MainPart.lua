---@class UIItemInfoPanel_MainPart:UIItemInfoPanel_PartBasic
local UIItemInfoPanel_MainPart = {}

setmetatable(UIItemInfoPanel_MainPart, luaComponentTemplates.UIItemInfoPanel_PartBasic)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart:RefreshUpperArea()
    self:GetUIItemTemplate():RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart:RefreshCenterArea()
    --显示基础属性
    if self.commonData ~= nil and self.commonData.itemInfo ~= nil and self.commonData.itemInfo.type == luaEnumItemType.Element then
        local elementAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_ElementBaseAttribute, self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.BaseAttribute)
        elementAttribute:RefreshWithInfo(self.commonData)
    elseif self.commonData ~= nil and self.commonData.itemInfo ~= nil and self.commonData.itemInfo.type == luaEnumItemType.Signet then
        local signet = self:CreateTemplateUnderArea(self:GetSignettemplate_GO(), luaComponentTemplates.UIItemInfoPanel_Info_Signet, self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.BaseAttribute)
        signet:RefreshWithInfo(self.commonData)
    else
        local baseAttribute = self:GetBaseAttributeTemplate();
        baseAttribute:RefreshWithInfo(self.commonData, LuaEnumItemInfoModuleType.BaseAttribute)
    end

    ---是否是魂装
    local isSoulEquip = false;
    if(self.commonData.itemInfo ~= nil) then
        local luaTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.commonData.itemInfo.id);
        if(luaTbl ~= nil) then
            isSoulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsSoulEquip(luaTbl);
        end
    end

    local hasData = self.commonData ~= nil
    local hasBagItemInfo = self.commonData.bagItemInfo
    local hasItemInfo = self.commonData.itemInfo
    local other = (self.commonData.itemInfoSource == nil or self.commonData.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT)
    local isSLEquip = hasItemInfo and clientTableManager.cfg_itemsManager:IsDivineSuitEquip(self.commonData.itemInfo.id)
    ---神力装备要显示额外属性   魂装也要显示额外属性
    local needExtra = (hasItemInfo and other) or isSLEquip or isSoulEquip
    --额外属性
    if hasData and needExtra then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute, self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end


end

--region 刷新底部区域
function UIItemInfoPanel_MainPart:RefreshLowerArea()
    self:AddLowerFixedArea();

    --倒计时显示
    if self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.type == 8 and self.commonData.itemInfo.subType == 34 and self.commonData.bagItemInfo then
        if self.commonData.itemInfo.limitedType ~= nil and self.commonData.bagItemInfo.time ~= nil and self.commonData.itemInfo.limitedType ~= 0 then
            local time = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_TimeCount, self:GetLowerContentTable_UITable(), LuaEnumItemInfoModuleType.ItemDescription)
            time:RefreshWithInfo(self.commonData)
        end
    end

    --道具描述
    if CS.Cfg_GlobalTableManager.Instance:ShowItemDescription(self.commonData.itemInfo) then
        if self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(), LuaEnumItemInfoModuleType.ItemDescription)
            tips2:RefreshWithInfo(self.commonData)
        end
    end
    self:ShowButtonAreaDescription()
    --显示操作按钮
    --if bagItemInfo then
    --    self.buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_Buttons_GO(), luaComponentTemplates.UIItemInfoPanel_Info_OperateButtons, self:GetLowerContentTable_UITable())
    --    self.buttons:RefreshWithInfo(bagItemInfo, itemInfo)
    --end
    --物品列表
    if self.commonData ~= nil and self.commonData.itemInfo ~= nil and self.commonData.getItemList ~= nil and self.commonData.getItemList.Count > 0 then
        local getItemListTemplate = self:CreateTemplateUnderArea(self:GetItemListTemplate_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ItemList,
                self:GetLowerContentTable_UITable(), LuaEnumItemInfoModuleType.ItemList)
        getItemListTemplate:RefreshWithInfo(self.commonData)
    end
    --获取途径信息
    if self.commonData ~= nil and self.commonData.itemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine,
                self:GetLowerContentTable_UITable(), LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---显示道具底部描述(禅道单82977修改底部描述)
function UIItemInfoPanel_MainPart:ShowButtonAreaDescription()
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_DoubleLine
        local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine,
                self:GetLowerContentTable_UITable(), LuaEnumItemInfoModuleType.ItemDescription2)
        bottomDes:RefreshWithInfo(self.commonData)
    end
end

---底部可能会增加各种各样的
function UIItemInfoPanel_MainPart:AddLowerFixedArea()
    self:AddSkillDescArea()
end

function UIItemInfoPanel_MainPart:AddSkillDescArea()
    ---@type UIItemInfoPanel_Info_FixLowerSkill
    local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_SkillDesc_GO(), luaComponentTemplates.UIItemInfoPanel_Info_FixLowerSkill,
            self:GetLowerContentTable_UITable(), LuaEnumItemInfoModuleType.ItemFixLowerSkill)
    bottomDes:RefreshWithInfo(self.commonData)
end
--endregion

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_RightUpOperateButtons
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons), self:GetUpRightTable_UITable(), LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart:RefreshRightDownArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightDownButtons_Go(), luaComponentTemplates.UIItemInfoPanel_Info_RightDownOperateButtons, self:GetDownRightTable_UITable(), LuaEnumItemInfoModuleType.RightDownOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return UIItemInfoPanel_MainPart