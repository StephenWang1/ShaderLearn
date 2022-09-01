---@class UIReforgedPanelTemplates_AttributeTemplate:TemplateBase 属性模板
local UIReforgedPanelTemplates_AttributeTemplate = {}

--region 初始化
function UIReforgedPanelTemplates_AttributeTemplate:Init()
    self:InitComponent()
end

function UIReforgedPanelTemplates_AttributeTemplate:InitComponent()
    ---@type UILabel 属性名字
    self.attributeName_UILabel = self:Get("curLevelAttribute/AttributeName","UILabel")
    ---@type UILabel 当前属性值
    self.attributeCurValue_UILabel = self:Get("curLevelAttribute/AttributeValue","UILabel")
    ---@type UILabel 下一级属性值
    self.attributeNextValue_UILabel = self:Get("nextLevelAttribute/AttributeValue","UILabel")
end
--endregion

--region 刷新
---@param attributeInfo AttributeDes
function UIReforgedPanelTemplates_AttributeTemplate:RefreshPanel(attributeInfo)
    if self:AnalysisParams(attributeInfo) == false then
        return
    end
    self:RefreshAttribute()
end

---解析数据
---@param attributeInfo AttributeDes
---@return boolean
function UIReforgedPanelTemplates_AttributeTemplate:AnalysisParams(attributeInfo)
    if attributeInfo == nil or attributeInfo.attributeType == nil then
        return false
    end
    self.attributeInfo = attributeInfo
    return true
end

function UIReforgedPanelTemplates_AttributeTemplate:RefreshAttribute()
    luaclass.UIRefresh:RefreshLabel(self.attributeName_UILabel,self.attributeInfo.attributeName)
    luaclass.UIRefresh:RefreshLabel(self.attributeCurValue_UILabel,self.attributeInfo.attributeValueDes)
    luaclass.UIRefresh:RefreshLabel(self.attributeNextValue_UILabel,luaEnumColorType.Green1 .. self.attributeInfo.attributeNextValueDes)
end
--endregion

return UIReforgedPanelTemplates_AttributeTemplate