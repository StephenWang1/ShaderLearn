---@type 基础信息模块基类
---@class BaseAttributeModule_Base
local BaseAttributeModule_Base = {}
setmetatable(BaseAttributeModule_Base, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 自定义变量
---浮动颜色
BaseAttributeModule_Base.rateColor = "[39ce1b]"
---属性名字颜色
BaseAttributeModule_Base.attributeNameColor = ""
---属性表
BaseAttributeModule_Base.attributeTable = {}
--endregion

--region 引用
function BaseAttributeModule_Base:GetMainPlayerInfo()
    if self.mainPlayerInfo == nil then
        self.mainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mainPlayerInfo
end
--endregion

--region 组件
---标题文本
---@return UILabel
function BaseAttributeModule_Base:GetTitleLabel_UILabel()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:Get("title", "UILabel")
    end
    return self.mTitleLabel_UILabel
end

---属性名文本
---@return UILabel
function BaseAttributeModule_Base:GetAttributeNameLabel_UILabel()
    if self.mAttributeNameLabel_UILabel == nil then
        self.mAttributeNameLabel_UILabel = self:Get("AttrName", "UILabel")
    end
    return self.mAttributeNameLabel_UILabel
end

---属性值文本
---@return UILabel
function BaseAttributeModule_Base:GetAttributeValueLabel_UILabel()
    if self.mAttributeValueLabel_UILabel == nil then
        self.mAttributeValueLabel_UILabel = self:Get("AttrValue", "UILabel")
    end
    return self.mAttributeValueLabel_UILabel
end

---属性箭头集合
---@return UIGridContainer
function BaseAttributeModule_Base:GetAttributeArrow_UIGridContainer()
    if self.mAttributeArrow_UIGridContainer == nil then
        self.mAttributeArrow_UIGridContainer = self:Get("AttrArrow", "UIGridContainer")
    end
    return self.mAttributeArrow_UIGridContainer
end

---强化属性集合
---@return UIGridContainer
function BaseAttributeModule_Base:GetAttrIntensify_UIGridContainer()
    if self.mAttrIntensify_UIGridContainer == nil then
        self.mAttrIntensify_UIGridContainer = self:Get("AttrIntensify", "UIGridContainer")
    end
    return self.mAttrIntensify_UIGridContainer
end

---基础属性集合
---@return UIGridContainer
function BaseAttributeModule_Base:GetBaseAttr_UIGridContainer()
    if self.mBaseAttr_UIGridContainer == nil then
        self.mBaseAttr_UIGridContainer = self:Get("Attr", "UIGridContainer")
    end
    return self.mBaseAttr_UIGridContainer
end
--endregion

--region 刷新
---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function BaseAttributeModule_Base:RefreshWithInfo(commonData)
    self:ClearAttributeData()
    self:AnalysisData(commonData)
    self:RefreshAttributes()
    self:ShowIntensify()
    self:ShowAttribute()
    self:Init()
end

---清理数据
function BaseAttributeModule_Base:ClearAttributeData()
    self.count = 0
    self.attrNameStr = ""
    self.attrValueStr = ""
    self.attributeTable = {}
    self.bagItemInfo = nil
    self.itemInfo = nil
    self.compareBagItemInfo = nil
    self.compareItemInfo = nil
    self.needCompare = false
    self.titleName = ""
    self.IntensifyIndex = nil
    ---装备者类型（主要用于强化根据玩家职业进行显示，在BaseAttributeModule_Equip里表示职业）
    self.equipmentType = nil
end

---解析数据
---@param commonData UIItemTipInfoCommonData
function BaseAttributeModule_Base:AnalysisData(commonData)
    self.bagItemInfo = commonData.bagItemInfo
    self.itemInfo = commonData.itemInfo
    self.needCompare = ternary(commonData.needCompare == nil,false,commonData.needCompare)
    self.titleName = ternary(commonData.titleName == nil,false,commonData.titleName)
    self.equipmentType = commonData.equipmentType
end

---显示属性
function BaseAttributeModule_Base:ShowAttribute()
    self:GetTitleLabel_UILabel().text = self.titleName
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

---显示强化属性
function BaseAttributeModule_Base:ShowIntensify()
    local starMaxCount = ternary(self.IntensifyIndex ~= nil and self.IntensifyIndex <= 5,self.IntensifyIndex - 1,0)
    self:GetAttrIntensify_UIGridContainer().MaxCount = starMaxCount
    for i = 0, self:GetAttrIntensify_UIGridContainer().controlList.Count - 1 do
        self:GetAttrIntensify_UIGridContainer().controlList[i].gameObject:SetActive(false)
    end
    self:GetAttrIntensify_UIGridContainer().controlList[starMaxCount - 1].gameObject:SetActive(true)
end
--endregion

--region 添加属性
---添加属性
function BaseAttributeModule_Base:AddAttribute(attributeName, attributeValue, isShowArrow, needBlink,isShowIntensify)
    self.count = self.count + 1
    local singleAttribute = {}
    singleAttribute.attributeName = attributeName
    singleAttribute.attributeValue = attributeValue
    singleAttribute.isShowArrow = isShowArrow
    singleAttribute.needBlink = needBlink
    if isShowIntensify then
        self.IntensifyIndex = self.count
    end
    table.insert(self.attributeTable, singleAttribute)
end
--endregion

--region 重写方法
---初始化
function BaseAttributeModule_Base:Init()

end
---属性刷新
function BaseAttributeModule_Base:RefreshAttributes()

end
--endregion

--region 查询
function BaseAttributeModule_Base:CompareItem()
    return self.needCompare
end

---判断是否是背包物品类型
function BaseAttributeModule_Base:CheckIsBagItemInfo(item)
    return type(item) == 'CS.bagV2.BagItemInfo'
end

---根据属性类型找到属性浮动表的值
function BaseAttributeModule_Base:FindRateAttributeValue(type)
    if self.bagItemInfo and self.bagItemInfo.rateAttribute then
        local length = self.bagItemInfo.rateAttribute.Count - 1
        for k = 0, length do
            local v = self.bagItemInfo.rateAttribute[k]
            if v ~= nil and v.type == type then
                return v.num
            end
        end
    end
    return 0
end

---获取总属性值
function BaseAttributeModule_Base:GetTotalAttributeValue(baseAttribute,type)
    local rateAttribute = self:FindRateAttributeValue(self.bagItemInfo,type)
    return baseAttribute + rateAttribute
end
--endregion
return BaseAttributeModule_Base