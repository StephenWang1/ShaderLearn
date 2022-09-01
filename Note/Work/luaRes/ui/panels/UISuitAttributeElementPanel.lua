---@class UISuitAttributeElementPanel:UIBase
local UISuitAttributeElementPanel = {}
UISuitAttributeElementPanel.PanelLayerType = CS.UILayerType.WindowsPlane
---一行的高度(没有套装效果时的高度)
UISuitAttributeElementPanel.backGroudHigh_OneRow = 200
---增加的高度倍数
UISuitAttributeElementPanel.addRow = 60

function UISuitAttributeElementPanel:Init()
    self:AddCollider()
    self:InitParams()
end

function  UISuitAttributeElementPanel:InitParams()
    self.title_Label = self:GetCurComp("WidgetRoot/view/dec","UILabel")
    self.suitIcon_UIGridContainer = self:GetCurComp("WidgetRoot/view/SuitIcon/Grid","UIGridContainer")
    self.backGround_UISprite = self:GetCurComp("WidgetRoot/window/background","UISprite")
    self.suitAttribute_UIGridContainer = self:GetCurComp("WidgetRoot/ToggleArea/Grid","UIGridContainer")
end

---@param title 标题
---@param equipIndexTable 装备位列表
---@param contentTable 文本内容列表
function UISuitAttributeElementPanel:Show(customData)
    self.title_Label.text = customData.title
    self.equipIndexTable = customData.equipIndexTable
    self.suitIcon_UIGridContainer.MaxCount = #customData.equipIndexTable
    self.suitInfoList = customData.suitInfoList

    self:RefreshEquipGrid()

    self:RefreshSuitInfo()

    self:SetBackGroud()
end

function UISuitAttributeElementPanel:RefreshEquipGrid()
    if self.equipIndexTable == nil then
        return
    end
    for i = 0,self.suitIcon_UIGridContainer.MaxCount - 1 do
        local itemTemplate = self.suitIcon_UIGridContainer.controlList[i]
        local icon_UISprite = self:GetComp(itemTemplate.transform,"icon","UISprite")
        local level_UILabel = self:GetComp(itemTemplate.transform,"level","UILabel")
        local elementIcon_UISprite = self:GetComp(itemTemplate.transform,"level/Sprite","UISprite")
        icon_UISprite.spriteName = "s" .. self.equipIndexTable [i + 1].icon
        level_UILabel.text = self.equipIndexTable [i + 1].level
        local elementTable = self.equipIndexTable [i + 1].elementTable
        if self.icon_High == nil then
            self.icon_High = icon_UISprite.localSize.y
        end
        if elementIcon_UISprite ~= nil and elementTable ~= nil then
            elementIcon_UISprite.spriteName = elementTable.icon
        else
            elementIcon_UISprite.gameObject:SetActive(false)
            level_UILabel.transform.localPosition = CS.UnityEngine.Vector3(0,level_UILabel.transform.localPosition.y,level_UILabel.transform.localPosition.z)
        end
    end
end

function UISuitAttributeElementPanel:RefreshSuitInfo()
    if self.suitInfoList == nil then
        return
    end
    local length = self.suitInfoList.Count - 1
    self.suitAttribute_UIGridContainer.MaxCount = self.suitInfoList.Count
    for k = 0,length do
        local v = self.suitAttribute_UIGridContainer.controlList[k]
        local content = self:GetComp(v.transform,"FristAttr/content","UILabel")
        local attribute = self:GetComp(v.transform,"FristAttr/attribute","UILabel")
        local suitInfo = self.suitInfoList[k]
        content.text = CS.Cfg_GlobalTableManager.Instance.ElementShowColorType  .. CS.CSScene.MainPlayerInfo.ElementInfo:GetElementSuitInfoContent(suitInfo)
        attribute.text = CS.Cfg_GlobalTableManager.Instance.ElementShowColorType  ..  CS.CSScene.MainPlayerInfo.ElementInfo:GetElementAttackContent(suitInfo)
    end
end

function UISuitAttributeElementPanel:SetBackGroud()
    if self.backGround_UISprite ~= nil then
        self.backGround_UISprite:SetDimensions(self.backGround_UISprite.localSize.x,self.backGroudHigh_OneRow + self.addRow * self.suitInfoList.Count)
    end
end

return UISuitAttributeElementPanel