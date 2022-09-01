---@type 物品信息界面信息
local UIItemInfoPanel_ElementInsertPlace = {}

setmetatable(UIItemInfoPanel_ElementInsertPlace, luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute)

--region 自定义变量
---属性名字颜色
UIItemInfoPanel_ElementInsertPlace.attributeNameColor = ""
--endregion

--region 组件
---标题文本
---@return UILabel
function UIItemInfoPanel_ElementInsertPlace:GetTitleLabel_UILabel()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:Get("title", "UILabel")
    end
    return self.mTitleLabel_UILabel
end

---属性名文本
---@return UILabel
function UIItemInfoPanel_ElementInsertPlace:GetAttributeNameLabel_UILabel()
    if self.mAttributeNameLabel_UILabel == nil then
        self.mAttributeNameLabel_UILabel = self:Get("AttrName", "UILabel")
    end
    return self.mAttributeNameLabel_UILabel
end

---属性值文本
---@return UILabel
function UIItemInfoPanel_ElementInsertPlace:GetAttributeValueLabel_UILabel()
    if self.mAttributeValueLabel_UILabel == nil then
        self.mAttributeValueLabel_UILabel = self:Get("AttrValue", "UILabel")
    end
    return self.mAttributeValueLabel_UILabel
end

---属性箭头集合
---@return UIGridContainer
function UIItemInfoPanel_ElementInsertPlace:GetAttributeArrow_UIGridContainer()
    if self.mAttributeArrow_UIGridContainer == nil then
        self.mAttributeArrow_UIGridContainer = self:Get("AttrArrow", "UIGridContainer")
    end
    return self.mAttributeArrow_UIGridContainer
end

---强化属性集合
---@return UIGridContainer
function UIItemInfoPanel_ElementInsertPlace:GetAttrIntensify_UIGridContainer()
    if self.mAttrIntensify_UIGridContainer == nil then
        self.mAttrIntensify_UIGridContainer = self:Get("AttrIntensify", "UIGridContainer")
    end
    return self.mAttrIntensify_UIGridContainer
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_ElementInsertPlace:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self:ClearAttributeData()
    if itemInfo ~= nil then
        self:RefreshAttributes(bagItemInfo, itemInfo)
    end
    self:ShowAttribute(itemInfo)
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_ElementInsertPlace:RefreshAttributes(bagItemInfo, itemInfo)
    local elementTab = CS.Cfg_ElementTableManager.Instance:getElementStone(itemInfo.id)
    local equipIndexText = ""
    if elementTab ~= nil then
        local elementEquipIndexName = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEquipIndexName(elementTab)
        if elementEquipIndexName ~= nil and elementEquipIndexName.Length > 0 then
            for i = 0,elementEquipIndexName.Length - 1 do
                equipIndexText = equipIndexText ..elementEquipIndexName[i] .. " "
            end
        end
        self:AddAttribute(equipIndexText .. "\r\n", "" .. "\r\n", false)
    end
end

function UIItemInfoPanel_ElementInsertPlace:ClearAttributeData()
    self.count = 0
    self.attrNameStr = ""
    self.attrValueStr = ""
    self.showArrowSign = 0
    self.attributeTable = {}
end

function UIItemInfoPanel_ElementInsertPlace:ShowAttribute(itemInfo)
    self:GetTitleLabel_UILabel().gameObject:SetActive(true)
    self:GetTitleLabel_UILabel().text = "[73ddf7]镶嵌部位"
    self:GetBaseAttr_UIGridContainer().MaxCount = #self.attributeTable
    self:GetAttributeArrow_UIGridContainer().MaxCount = #self.attributeTable
    for i = 0,#self.attributeTable - 1 do
        local attribute = self.attributeTable[i+1]
        local attr = self:GetBaseAttr_UIGridContainer().controlList[i]
        local attrName = self:GetCurComp(attr,"AttrName","UILabel")
        local attrValue = self:GetCurComp(attr,"AttrValue/AttrValue","UILabel")
        local arrow = self:GetAttributeArrow_UIGridContainer().controlList[i]
        attrName.text = attribute.attributeName
        attrValue.text = attribute.attributeValue
        arrow:SetActive(attribute.isShowArrow)
    end
end
return UIItemInfoPanel_ElementInsertPlace