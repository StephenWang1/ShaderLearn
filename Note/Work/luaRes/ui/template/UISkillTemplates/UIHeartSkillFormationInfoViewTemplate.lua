
---@class UIHeartSkillFormationInfoViewTemplate
local UIHeartSkillFormationInfoViewTemplate = {};

UIHeartSkillFormationInfoViewTemplate.mCurrentLevelFormationTable = nil;

UIHeartSkillFormationInfoViewTemplate.mNextLevelFormationTable = nil;

--region Components

function UIHeartSkillFormationInfoViewTemplate:GetMaxLevelTips_GameObject()
    if(self.mMaxLevelTips_GameObject == nil) then
        self.mMaxLevelTips_GameObject = self:Get("nextSkill/maxLevelTips","GameObject");
    end
    return self.mMaxLevelTips_GameObject;
end

function UIHeartSkillFormationInfoViewTemplate:GetFormationIcon_UISprite()
    if(self.mFormationIcon_UISprite == nil) then
        self.mFormationIcon_UISprite = self:Get("icon/skillIcon","UISprite");
    end
    return self.mFormationIcon_UISprite;
end

function UIHeartSkillFormationInfoViewTemplate:GetFormationName_Text()
    if(self.mFormationName_Text == nil) then
        self.mFormationName_Text = self:Get("icon/skillName","UILabel");
    end
    return self.mFormationName_Text;
end

function UIHeartSkillFormationInfoViewTemplate:GetCurrentLevel_Text()
    if(self.mCurrentLevel_Text == nil) then
        self.mCurrentLevel_Text = self:Get("currentSkill/skillLevel", "UILabel");
    end
    return self.mCurrentLevel_Text;
end

function UIHeartSkillFormationInfoViewTemplate:GetNextLevel_Text()
    if(self.mNextLevel_Text == nil) then
        self.mNextLevel_Text = self:Get("nextSkill/skillLevel", "UILabel");
    end
    return self.mNextLevel_Text;
end

function UIHeartSkillFormationInfoViewTemplate:GetCurrentLevelDes_Text()
    if(self.mCurrentLevelDes_Text == nil) then
        self.mCurrentLevelDes_Text = self:Get("currentSkill/skillDescription","UILabel");
    end
    return self.mCurrentLevelDes_Text;
end

function UIHeartSkillFormationInfoViewTemplate:GetNextLevelDes_Text()
    if(self.mNextLevelDes_Text == nil) then
        self.mNextLevelDes_Text = self:Get("nextSkill/skillDescription", "UILabel");
    end
    return self.mNextLevelDes_Text;
end

function UIHeartSkillFormationInfoViewTemplate:GetFormationSkillGrid_UIGridContainer()
    if(self.mFormationSkillGrid_UIGridContainer == nil) then
        self.mFormationSkillGrid_UIGridContainer = self:Get("grid","UIGridContainer");
    end
    return self.mFormationSkillGrid_UIGridContainer;
end

--endregion

--region Method

--region Public

function UIHeartSkillFormationInfoViewTemplate:UpdateView(formationId, formationLevel)
    local isFind, formationTable = CS.Cfg_SkillHeartFormationTableManager.Instance:TryGetValue(formationId);
    if(isFind) then
        self.mFormationTable = formationTable;
    end
    self.mCurrentLevelFormationTable = CS.Cfg_SkillFormationLevelTableManager.Instance:GetSkillFormationLevelTableData(formationId, formationLevel);
    self.mNextLevelFormationTable = CS.Cfg_SkillFormationLevelTableManager.Instance:GetSkillFormationLevelTableData(formationId, formationLevel + 1);
    if(self.mNextLevelFormationTable.level == self.mCurrentLevelFormationTable.level) then
        self.mNextLevelFormationTable = nil;
    end
    self:UpdateUI();
end

function UIHeartSkillFormationInfoViewTemplate:UpdateUI()
    if(self.mFormationTable ~= nil) then
        self:GetFormationIcon_UISprite().spriteName = self.mFormationTable.icon2;
        self:GetFormationName_Text().text = self.mFormationTable.name;
    end

    if(self.mCurrentLevelFormationTable ~= nil) then
        self:GetCurrentLevel_Text().text = "当前等级  "..self.mCurrentLevelFormationTable.level.."级";
        self:GetCurrentLevelDes_Text().text = CS.Cfg_SkillFormationLevelTableManager.Instance:GetFormationDescription(self.mCurrentLevelFormationTable, luaEnumColorType.Yellow)
    else
        self:GetCurrentLevel_Text().text = "";
        self:GetCurrentLevelDes_Text().text = "";
    end

    if(self.mNextLevelFormationTable ~= nil) then
        self:GetNextLevel_Text().text = "下一等级  "..self.mNextLevelFormationTable.level.."级";
        self:GetNextLevelDes_Text().text = CS.Cfg_SkillFormationLevelTableManager.Instance:GetFormationDescription(self.mNextLevelFormationTable, luaEnumColorType.Green);
        self:GetMaxLevelTips_GameObject():SetActive(false);
    else
        self:GetNextLevel_Text().text = "";
        self:GetNextLevelDes_Text().text = "";
        self:GetMaxLevelTips_GameObject():SetActive(true);
    end

    self:UpdateFormationSkills();
end

function UIHeartSkillFormationInfoViewTemplate:UpdateFormationSkills()
    if(self.mFormationTable ~= nil) then
        local formationSkills = {};
        --if(self.mFormationTable.id == 101) then
            local usedSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
            CS.Utility_Lua.luaForeachCsharp:Foreach(usedSkillDic, function(k, v)
                table.insert(formationSkills, v);
            end);
        --else
        --    table.insert(formationSkills, self.mFormationTable.secretSkill1);
        --    table.insert(formationSkills, self.mFormationTable.secretSkill2)
        --    table.insert(formationSkills, self.mFormationTable.secretSkill3)
        --    table.insert(formationSkills, self.mFormationTable.secretSkill4)
        --    table.insert(formationSkills, self.mFormationTable.secretSkill5)
        --    table.insert(formationSkills, self.mFormationTable.secretSkill6)
        --end
        local gridContainer = self:GetFormationSkillGrid_UIGridContainer();
        gridContainer.MaxCount = #formationSkills;
        if(self.mFormationSkillUnitDic == nil) then
            self.mFormationSkillUnitDic = {};
        end
        local index = 0;
        for k, v in pairs(formationSkills) do
            local gobj = gridContainer.controlList[index];
            if(self.mFormationSkillUnitDic[gobj] == nil) then
                self.mFormationSkillUnitDic[gobj] = CS.Utility_Lua.GetComponent(gobj, "UILabel");
            end
            local isFind0, skillTable = CS.Cfg_SkillTableManager.Instance:TryGetValue(v);
            local isFind1, skillBean = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic:TryGetValue(v);
            local level = 0;
            if(isFind1) then
                level = skillBean.level
            end

            if(isFind0) then
                self.mFormationSkillUnitDic[gobj].text = skillTable.name.." Lv."..level;
            end

            index = index + 1;
        end
    end
end

--endregion

--region Private


--endregion

--endregion

function UIHeartSkillFormationInfoViewTemplate:Init()

end

function UIHeartSkillFormationInfoViewTemplate:OnDestroy()

end

return UIHeartSkillFormationInfoViewTemplate;