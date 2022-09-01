local BaseAttributeModule_Equip = {}
setmetatable(BaseAttributeModule_Equip,luaComponentTemplates.UIItemInfoPanel_Info_Basic)
---初始化
function BaseAttributeModule_Equip:Init()
    self.compareBagItemInfo,self.compareItemInfo = self:TryGetCompareItem()
end

---属性刷新
function BaseAttributeModule_Equip:RefreshAttributes()
    if self.bagItemInfo ~= nil then
        self:BagItemInfoShowAttribute()
    elseif self.itemInfo ~= nil then
        self:ItemInfoShowAttribute()
    end
end

---获取对比物品
function BaseAttributeModule_Equip:TryGetCompareItem()
    if self:CompareItem() and self.bagItemInfo ~= nil and not self:GetMainPlayerInfo().EquipInfo:GetEquipByEquipType(self.bagItemInfo.lid) then
        local compareBagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(self.itemInfo.subType)
        local compareItemInfoIsFind,compareItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(compareBagItemInfo.itemId)
        if compareItemInfoIsFind then
            return compareBagItemInfo,compareItemInfo
        end
    end
end

--region 显示基础属性
---背包物品显示基础属性
function BaseAttributeModule_Equip:BagItemInfoShowAttribute()
    self:AddBagItemInfoDoubleAttribute("防御",self:GetTotalAttributeValue(self.itemInfo.phyDefenceMin,LuaEnumAttributeType.PhyDefenceMin),self:GetTotalAttributeValue(self.itemInfo.phyDefenceMax,LuaEnumAttributeType.PhyDefenceMax),self:FindRateAttributeValue(LuaEnumAttributeType.PhyDefenceMax))
end

---物品显示基础属性
function BaseAttributeModule_Equip:ItemInfoShowAttribute()

end
--endregion

--region 添加属性
---单个属性值
function BaseAttributeModule_Equip:AddBagItemInfoAttribute(attributeName, attributeValue,rateAttribute, isShowArrow, needBlink,isShowIntensify,haveRateAttribute)
    local color = ternary(haveRateAttribute == true,"[39ce1b]","")
    local rateAttribute = ternary(rateAttribute > 0,"(+" .. tostring(rateAttribute) .. ")[-]","")
    local name = color .. attributeName
    local value = color .. attributeValue .. rateAttribute
    self:AddAttribute(name, value, isShowArrow, needBlink,isShowIntensify)
end

---两个属性值
function BaseAttributeModule_Equip:AddBagItemInfoDoubleAttribute(attributeName, minAttributeValue,maxAttributeValue,rateAttribute, isShowArrow, needBlink,isShowIntensify,haveRateAttribute)
    local color = ternary(haveRateAttribute == true,"[39ce1b]","")
    local rateAttribute = ternary(rateAttribute > 0,"(+" .. tostring(rateAttribute) .. ")[-]","")
    local name = color .. attributeName
    local value = color .. tostring(minAttributeValue) .. ' - ' .. tostring(maxAttributeValue) .. rateAttribute
    self:AddAttribute(name, value, isShowArrow, needBlink,isShowIntensify)
end
--endregion
return BaseAttributeModule_Equip