---技能可学习提示
---@class UIMainHint_SkillLearningAvailableTips:UIBasicHint
local UIMainHint_SkillLearningAvailableTips = {}

setmetatable(UIMainHint_SkillLearningAvailableTips, luaComponentTemplates.UIBasicHint)

---文字内容组件
---@return UILabel
function UIMainHint_SkillLearningAvailableTips:GetContentLabel_UILabel()
    if self.mContentLabel_UILabel == nil then
        self.mContentLabel_UILabel = self:Get("tipPanel/lb_tips", "UILabel")
    end
    return self.mContentLabel_UILabel
end

---内容点击按钮
---@return GameObject
function UIMainHint_SkillLearningAvailableTips:GetContentClickButton_GO()
    if self.mContentClickButton_GO == nil then
        self.mContentClickButton_GO = self:Get("tipPanel/lb_tips", "GameObject")
    end
    return self.mContentClickButton_GO
end

function UIMainHint_SkillLearningAvailableTips:RegisterAllComponents()
    self:RegisterSingleTweenComponent("tipPanel")
    self:RegisterSingleCollider("tipPanel/lb_tips")
    self:RegisterSingleCollider("tipPanel/btn_close")
end

function UIMainHint_SkillLearningAvailableTips:RefreshData(content)
    self:GetContentLabel_UILabel().text = content
end

function UIMainHint_SkillLearningAvailableTips:BindUIEvents()
    CS.UIEventListener.Get(self:GetContentClickButton_GO()).onClick = function()
        self:OnContentClicked()
    end
end

---提示内容点击事件
function UIMainHint_SkillLearningAvailableTips:OnContentClicked()
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo;
    local normalSkillList = bagInfo:GetSkillIdList(1);
    local skillId
    if (normalSkillList ~= nil and normalSkillList.Count > 0) then
        skillId = normalSkillList[0];
    else
        local secretSkillList = bagInfo:GetSkillIdList(0);
        if (secretSkillList ~= nil and secretSkillList.Count > 0) then
            skillId = secretSkillList[0];
        end
    end
    local isGetValue, tableValue = CS.Cfg_SkillTableManager.Instance:TryGetValue(skillId);
    if (isGetValue) then
        if (tableValue.cls == 2 or tableValue.cls == 0 or tableValue.cls == 4) then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.SkillDetails);
        elseif (tableValue.cls == 2 or tableValue.cls == 0) then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.HeartSkill);
        end
    end
    self:Close(true)
end

return UIMainHint_SkillLearningAvailableTips