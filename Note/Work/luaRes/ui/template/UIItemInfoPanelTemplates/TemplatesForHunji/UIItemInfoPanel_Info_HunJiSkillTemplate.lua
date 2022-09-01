---@class UIItemInfoPanel_Info_HunJiSkillTemplate:TemplateBase
local UIItemInfoPanel_Info_HunJiSkillTemplate = {}

--region 组件
---标题文本
---@return UILabel
function UIItemInfoPanel_Info_HunJiSkillTemplate:GetTitleLabel()
    if self.mTitle == nil then
        self.mTitle = self:Get("title", "UILabel")
    end
    return self.mTitle
end

---技能容器
---@return UIGridContainer
function UIItemInfoPanel_Info_HunJiSkillTemplate:GetSkillsGridContainer()
    if self.mSkillsGridContainer == nil then
        self.mSkillsGridContainer = self:Get("ExchangeItem", "UIGridContainer")
    end
    return self.mSkillsGridContainer
end

---@return UnityEngine.GameObject
function UIItemInfoPanel_Info_HunJiSkillTemplate:GetSkillItemCell()
    if self.mSkillItemCell == nil then
        self.mSkillItemCell = self:Get("UIItem", "GameObject")
    end
    return self.mSkillItemCell
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_HunJiSkillTemplate:RefreshWithInfo(commonData)
    if commonData == nil then
        self:GetTitleLabel().gameObject:SetActive(false)
        self:GetSkillsGridContainer().gameObject:SetActive(false)
        self:GetSkillItemCell():SetActive(false)
        return
    end
    ---@type TABLE.CFG_ITEMS
    local info = commonData.itemInfo
    if info.compoundParam == nil or info.compoundParam.list.Count == 0 then
        self:GetTitleLabel().gameObject:SetActive(false)
        self:GetSkillsGridContainer().gameObject:SetActive(false)
        self:GetSkillItemCell():SetActive(false)
        return
    end
    local skills = {}
    local skillTbl
    for i = 0, info.compoundParam.list.Count - 1 do
        ___, skillTbl = CS.Cfg_SkillTableManager.Instance:TryGetValue(info.compoundParam.list[i])
        if skillTbl then
            table.insert(skills, skillTbl)
        end
    end
    local skillCount = #skills
    if skillCount == 0 then
        self:GetTitleLabel().gameObject:SetActive(false)
        self:GetSkillsGridContainer().gameObject:SetActive(false)
        self:GetSkillItemCell():SetActive(false)
        return
    end
    self:GetSkillsGridContainer().MaxCount = skillCount
    self:GetTitleLabel().gameObject:SetActive(true)
    for i = 1, skillCount do
        skillTbl = skills[i]
        local skillConditionTbl = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillTbl.id, 1)
        if skillConditionTbl ~= nil then
            local go = self:GetSkillsGridContainer().controlList[i - 1]
            ---@type UISprite
            local iconSprite = self:GetCurComp(go, "icon", "UISprite")
            iconSprite.spriteName = skillTbl.icon
            ---@type UILabel
            local detailLabel = self:GetCurComp(go, "info", "UILabel")
            detailLabel.text = skillConditionTbl.show
        end
    end
end

return UIItemInfoPanel_Info_HunJiSkillTemplate