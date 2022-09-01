---@class UIActivitiesDesUnitTemplate
local UIActivitiesDesUnitTemplate = {};

UIActivitiesDesUnitTemplate.mUnitDic = nil;

--region Components

function UIActivitiesDesUnitTemplate:GetRuleName_Text()
    if(self.mRuleName_Text == nil) then
        self.mRuleName_Text = self:Get("Label1", "UILabel");
    end
    return self.mRuleName_Text;
end

function UIActivitiesDesUnitTemplate:GetGridContainer()
    if(self.mGridContainer == nil) then
        self.mGridContainer = self:Get("Desc","UIGridContainer");
    end
    return self.mGridContainer;
end

function UIActivitiesDesUnitTemplate:GetUITable()
    if(self.mUITable == nil) then
        self.mUITable = self:Get("Desc","UITable");
    end
    return self.mUITable;
end

--endregion

--region Method

--region Public

function UIActivitiesDesUnitTemplate:UpdateUnit(ruleName, ruleDataUnitVo)
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end

    self:GetRuleName_Text().text = ruleName;
    local gridContainer = self:GetGridContainer();
    gridContainer.MaxCount = ruleDataUnitVo.ruleContentDic.Count;
    if(gridContainer.MaxCount > 0) then
        local index = 0;
        CS.Utility_Lua.luaForeachCsharp:Foreach(ruleDataUnitVo.ruleContentDic, function(k, v)
            local gobj = gridContainer.controlList[index];
            if(self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIActivitiesDesContentUnitTemplate);
            end
            self.mUnitDic[gobj]:UpdateUnit(k,v);
            index = index + 1;

            --if(index == gridContainer.MaxCount - 1) then
            --    self:GetUITable().IsDealy = false
            --    self:GetUITable():Reposition();
            --end
        end);
    end
    self:GetUITable().IsDealy = false
    self:GetUITable():Reposition();
end

--endregion

function UIActivitiesDesUnitTemplate:InitEvents()

end

function UIActivitiesDesUnitTemplate:RemoveEvents()

end

--endregion

function UIActivitiesDesUnitTemplate:Init()
    self:InitEvents();
end

function UIActivitiesDesUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIActivitiesDesUnitTemplate;