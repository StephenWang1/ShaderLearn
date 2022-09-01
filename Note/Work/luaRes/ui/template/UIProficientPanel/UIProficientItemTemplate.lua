---@class UIProficientItemTemplate 专精界面的列表中每个专精信息
local UIProficientItemTemplate = {}

---@type LuaProficientItem
UIProficientItemTemplate.ProficientItem = nil

--region 组件
---专精ICON
function UIProficientItemTemplate:GetIconSprite()
    if (self.mGetIconSprite == nil) then
        self.mGetIconSprite = self:Get("skillIcon", "Top_UISprite")
    end
    return self.mGetIconSprite
end

---专精ICON
function UIProficientItemTemplate:GetIconSpriteEffect()
    if (self.mGetIconSpriteEffect == nil) then
        self.mGetIconSpriteEffect = self:Get("skillIcon/effect", "GameObject")
    end
    return self.mGetIconSpriteEffect
end

---名字label
function UIProficientItemTemplate:GetNameLabel()
    if (self.mGetNameLabel == nil) then
        self.mGetNameLabel = self:Get("skillName", "Top_UILabel")
    end
    return self.mGetNameLabel
end

---等级label
function UIProficientItemTemplate:GetLevelLabel()
    if (self.mGetLevelLabel == nil) then
        self.mGetLevelLabel = self:Get("skillLevel", "Top_UILabel")
    end
    return self.mGetLevelLabel
end

---高亮的等级label
function UIProficientItemTemplate:GetHighEffectLevelLabel()
    if (self.mGetHighEffectLevelLabel == nil) then
        self.mGetHighEffectLevelLabel = self:Get("HighlightEffect", "Top_UILabel")
    end
    return self.mGetHighEffectLevelLabel
end

---高亮的等级label
function UIProficientItemTemplate:GetHighEffectLevelLabelTween()
    if (self.mGetHighEffectLevelLabelTween == nil) then
        self.mGetHighEffectLevelLabelTween = self:Get("HighlightEffect", "Top_TweenAlpha")
    end
    return self.mGetHighEffectLevelLabelTween
end

---消耗的材料
function UIProficientItemTemplate:GetCostMaterialGridContainer()
    if (self.mGetCostMaterialGridContainer == nil) then
        self.mGetCostMaterialGridContainer = self:Get("costMaterialTable", "Top_UIGridContainer")
    end
    return self.mGetCostMaterialGridContainer
end

---消耗材料的Table,用来进行排列
function UIProficientItemTemplate:GetCostMaterialTable()
    if (self.mGetCostMaterialTable == nil) then
        self.mGetCostMaterialTable = self:Get("costMaterialTable", "Top_UITable")
    end
    return self.mGetCostMaterialTable
end

---不满足条件的时候的提示
function UIProficientItemTemplate:GetTipLabel()
    if (self.mGetTipLabel == nil) then
        self.mGetTipLabel = self:Get("Tips", "Top_UILabel")
    end
    return self.mGetTipLabel
end

---学习按钮
function UIProficientItemTemplate:GetBtnLearn()
    if (self.mGetBtnLearn == nil) then
        self.mGetBtnLearn = self:Get("Btn_Learn", "GameObject")
    end
    return self.mGetBtnLearn
end

---学习按钮特效
function UIProficientItemTemplate:GetBtnLearnEffect()
    if (self.mGetBtnLearnEffect == nil) then
        self.mGetBtnLearnEffect = self:Get("Btn_Learn/Effect", "GameObject")
    end
    return self.mGetBtnLearnEffect
end

---升级按钮
function UIProficientItemTemplate:GetBtnUpgrade()
    if (self.mGetBtnUpgrade == nil) then
        self.mGetBtnUpgrade = self:Get("Btn_Upgrade", "GameObject")
    end
    return self.mGetBtnUpgrade
end

---升级按钮特效
function UIProficientItemTemplate:GetBtnUpgradeEffect()
    if (self.mGetBtnUpgradeEffect == nil) then
        self.mGetBtnUpgradeEffect = self:Get("Btn_Upgrade/Effect", "GameObject")
    end
    return self.mGetBtnUpgradeEffect
end

---Bg
function UIProficientItemTemplate:GetBg()
    if (self.mGetBg == nil) then
        self.mGetBg = self:Get("background/frame", "Top_UISprite")
    end
    return self.mGetBg
end

---tips显示最低点
function UIProficientItemTemplate:GetLowPoint()
    if (self.mLowPoint == nil) then
        self.mLowPoint = self:Get("lowPoint", "GameObject")
    end
    return self.mLowPoint
end

---tips显示最高点
function UIProficientItemTemplate:GetHeightPoint()
    if (self.mHeightPoint == nil) then
        self.mHeightPoint = self:Get("hightPoint", "GameObject")
    end
    return self.mHeightPoint
end

--endregion

function UIProficientItemTemplate:Init()
    CS.UIEventListener.Get(self:GetIconSprite().gameObject).onClick = function()
        self:OnClickIconOpenDetailPanel()
    end

    CS.UIEventListener.Get(self:GetBtnLearn().gameObject).onClick = function()
        self:OnClickLearn()
    end

    CS.UIEventListener.Get(self:GetBtnUpgrade().gameObject).onClick = function()
        self:OnClickLearn()
    end
end

---更新数据
---@param data LuaProficientItem
function UIProficientItemTemplate:UpdateData(data, index)
    self.ProficientItem = data

    self:UpdateUI(index)
    self:UpdateCostMaterial()
    self:UpdateBtnState()
end

UIProficientItemTemplate.LastLevel = nil
function UIProficientItemTemplate:UpdateUI(index)
    local tbl = self.ProficientItem.tbl ~= nil and self.ProficientItem.tbl or self.ProficientItem.nextTbl

    self:GetNameLabel().text = "[dde6eb]" .. tbl:GetName()
    self:GetIconSprite().spriteName = tbl:GetIcon()
    if (self.ProficientItem.level == 0) then
        self:GetLevelLabel().text = "[878787]" .. tostring(self.ProficientItem.level) .. "级"
        self:GetHighEffectLevelLabel().text = tostring(self.ProficientItem.level) .. "级"
    elseif (self.ProficientItem.level == self.ProficientItem.maxLevel) then
        self:GetLevelLabel().text = "[878787]已满级"
        self:GetHighEffectLevelLabel().text = "已满级"
    else
        self:GetLevelLabel().text = "[878787]" .. tostring(self.ProficientItem.level) .. "级"
        self:GetHighEffectLevelLabel().text = tostring(self.ProficientItem.level) .. "级"
    end

    if (self.LastLevel ~= nil and self.LastLevel < self.ProficientItem.level) then
        self:GetHighEffectLevelLabelTween():ResetToBeginning()
        self:GetHighEffectLevelLabelTween():PlayForward()
        self:GetIconSpriteEffect().gameObject:SetActive(false)
        self:GetIconSpriteEffect().gameObject:SetActive(true)
    end

    self.LastLevel = self.ProficientItem.level

    if (index ~= nil) then
        self:GetBg().alpha = index % 2 == 1 and 0.1 or 1
    end
end

---@type table<UIProficientCostMaterialTemplate>
UIProficientItemTemplate.ProficientCostMaterialTemplateList = nil
---@type boolean
UIProficientItemTemplate.IsMeetMaterial = nil

---更新消耗材料
function UIProficientItemTemplate:UpdateCostMaterial()
    if (self.ProficientItem.nextTbl == nil) then
        self:GetCostMaterialGridContainer().MaxCount = 0
        return
    end
    if (self.ProficientCostMaterialTemplateList == nil) then
        self.ProficientCostMaterialTemplateList = {}
    end

    self:GetCostMaterialGridContainer().gameObject:SetActive(true)
    ---消耗的材料始终未nextTbl的材料
    local itemCostItem = self.ProficientItem.nextTbl:GetCost()
    self.IsMeetMaterial = true
    if (itemCostItem ~= nil and itemCostItem.list ~= nil) then
        self:GetCostMaterialGridContainer().MaxCount = #itemCostItem.list
        local index = 0

        ---@param list table<number, table<number>>
        for i, list in pairs(itemCostItem.list) do
            local obj = self:GetCostMaterialGridContainer().controlList[index]

            if (self.ProficientCostMaterialTemplateList[obj] == nil) then
                self.ProficientCostMaterialTemplateList[obj] = templatemanager.GetNewTemplate(obj, luaComponentTemplates.UIProficientCostMaterialTemplate)
            end
            ---@type UIProficientCostMaterialTemplate
            local temp = self.ProficientCostMaterialTemplateList[obj]
            temp:UpdateCostMaterialItem(list.list)
            index = index + 1

            if (temp.IsMeet == false) then
                self.IsMeetMaterial = false
            end
        end
    else
        self.IsMeetMaterial = false
        self:GetCostMaterialGridContainer().MaxCount = 0
    end

    self:GetBtnUpgradeEffect().gameObject:SetActive(self.IsMeetMaterial)
    --self:GetBtnLearnEffect().gameObject:SetActive(isCanUpgrade)
end

---更新消耗材料
function UIProficientItemTemplate:UpdateCostMaterialCount()
    if (self.ProficientCostMaterialTemplateList == nil) then
        return
    end

    self.IsMeetMaterial = true
    ---@param ProficientCostMaterialTemplate UIProficientCostMaterialTemplate
    for i, ProficientCostMaterialTemplate in pairs(self.ProficientCostMaterialTemplateList) do
        ProficientCostMaterialTemplate:UpdateCostMaterialItemCount()
        if (ProficientCostMaterialTemplate.IsMeet == false) then
            self.IsMeetMaterial = false
        end
    end
    self:GetBtnUpgradeEffect().gameObject:SetActive(self.IsMeetMaterial)
    self:UpdateBtnState()
    --self:GetBtnLearnEffect().gameObject:SetActive(isCanUpgrade)

end

---更新按钮状态
function UIProficientItemTemplate:UpdateBtnState()
    if (self.ProficientItem == nil or self.ProficientItem.nextTbl == nil or self.ProficientItem.level >= self.ProficientItem.maxLevel) then
        --self:GetBtnLearn():SetActive(false)
        self:GetBtnUpgrade().gameObject:SetActive(false)
        self:GetTipLabel().gameObject:SetActive(false)
        return
    end
    ---@type table<number>
    local conditionList = self.ProficientItem.nextTbl:GetCondition().list
    ---@type LuaMatchConditionResult
    local errorResult = nil
    for i, conditionId in pairs(conditionList) do
        ---@type LuaMatchConditionResult
        local result = Utility.IsMainPlayerMatchCondition(conditionId)
        if (result.success == false) then
            errorResult = result
            break ;
        end
    end

    if (errorResult ~= nil) then
        --self:GetBtnLearn():SetActive(false)
        self:GetBtnUpgrade().gameObject:SetActive(false)
        self:GetTipLabel().gameObject:SetActive(true)
        if (errorResult.type == 1) then
            self:GetTipLabel().text = "等级达到" .. errorResult.param .. "级"
        elseif (errorResult.type == 2) then
            self:GetTipLabel().text = "转生达到" .. errorResult.param .. "转"
        end
        --self:GetTipLabel().text = errorResult.txt
    else
        self:GetTipLabel().gameObject:SetActive(false)
        self:GetBtnUpgrade().gameObject:SetActive(true and self.IsMeetMaterial)
        --if(self.ProficientItem.level == 0) then
        --    self:GetBtnLearn():SetActive(true)
        --    self:GetBtnUpgrade():SetActive(false)
        --else
        --    self:GetBtnLearn():SetActive(false)
        --    self:GetBtnUpgrade():SetActive(true)
        --end
    end
end

---根据当前模板内的专精信息内容,打开详情界面
function UIProficientItemTemplate:OnClickIconOpenDetailPanel()
    ---@type UIProficientDetailsPanel
    local proficientDetailsPanel = uimanager:GetPanel("UIProficientDetailsPanel")
    if proficientDetailsPanel ~= nil then
        proficientDetailsPanel:UpdateData(0, self.ProficientItem)
    else
        uimanager:CreatePanel("UIProficientDetailsPanel", function(panel)
            ---@type UIProficientDetailsPanel
            local panelTemp = panel
            panelTemp:UpdateData(0, self.ProficientItem, {
                posInfo = {
                    lowPos = self:GetLowPoint().transform.position,
                    heightPos = self:GetHeightPoint().transform.position
                }
            })
        end, nil)
    end
end

function UIProficientItemTemplate:OnClickLearn()
    networkRequest.ReqUpEquipProficient(self.ProficientItem.nextTbl:GetType())
end

return UIProficientItemTemplate