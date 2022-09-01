local RoleMarryRingItemInfo_BaseInfo = {}
setmetatable(RoleMarryRingItemInfo_BaseInfo,luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute)
--region 引用
function RoleMarryRingItemInfo_BaseInfo:GetPlayerMarryInfo()
    if self.PlayerMarryInfo == nil then
        self.PlayerMarryInfo = CS.CSScene.MainPlayerInfo.MarryInfo:GetPlayerMarryInfo()
    end
    return self.PlayerMarryInfo
end

function RoleMarryRingItemInfo_BaseInfo:GetGlobalTableManager()
    if self.GlobalTableManager == nil then
        self.GlobalTableManager = CS.Cfg_GlobalTableManager.Instance
    end
    return self.GlobalTableManager
end
--endregion

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function RoleMarryRingItemInfo_BaseInfo:RefreshAttributes(bagItemInfo, itemInfo, compareBagItemInfo, compareItemInfo, career)
    self.PlayerMarryInfo = nil

    --region 基础属性显示
    self:RunBaseFunction("RefreshAttributes",nil, itemInfo, compareBagItemInfo, compareItemInfo, career)
    --endregion

    --region 亲密度上升
    local str = ""
    if itemInfo ~= nil and itemInfo.useParam ~= nil and itemInfo.useParam.list ~= nil and itemInfo.useParam.list.Count > 0 and itemInfo.useParam.list[0] > 0 then
        str = self:GetGlobalTableManager():GetRoleMarryRingIntimacyUpText(itemInfo.useParam.list[0])
        self:AddAttribute(str, '', false)
    end
    --endregion
    --region 当前亲密度
    if bagItemInfo ~= nil and bagItemInfo.intimacyValue ~= nil then
        str = self:GetGlobalTableManager():GetRoleMarryRingIntimacyText(bagItemInfo.intimacyValue)
        self:AddAttribute(str, '', false)
    end
    --endregion
end

function RoleMarryRingItemInfo_BaseInfo:ShowAttribute(itemInfo)
    if itemInfo.type == luaEnumItemType.Equip then
        self:GetTitleLabel_UILabel().gameObject:SetActive(true)
        self:GetTitleLabel_UILabel().text = ternary(self.count == 0, "", "[73ddf7]基础效果")
    else
        self:GetTitleLabel_UILabel().gameObject:SetActive(false)
    end
    if self.attributeTable ~= nil and #self.attributeTable <= 0 then
        self:GetTitleLabel_UILabel().gameObject:SetActive(false)
    end
    self:GetBaseAttr_UIGridContainer().MaxCount = #self.attributeTable
    self:GetAttributeArrow_UIGridContainer().MaxCount = #self.attributeTable
    for i = 0, #self.attributeTable - 1 do
        local attribute = self.attributeTable[i + 1]
        local attr = self:GetBaseAttr_UIGridContainer().controlList[i]
        local attrName = self:GetCurComp(attr, "AttrName", "UILabel")
        local attrValue = self:GetCurComp(attr, "AttrValue/AttrValue", "UILabel")
        local arrow = self:GetAttributeArrow_UIGridContainer().controlList[i]
        attrName.text = attribute.attributeName
        attrValue.text = attribute.attributeValue
        if attribute.needBlink ~= nil and attribute.needBlink == true then
            self:AddBlinkList(attrName.transform)
            self:AddBlinkList(attrValue.transform)
        end
        arrow:SetActive(attribute.isShowArrow)
    end
    if #self.attributeTable == 0 then
        self.go:SetActive(false)
    end
end
return RoleMarryRingItemInfo_BaseInfo