---@class UIActivitiesDesViewTemplate:TemplateBase
local UIActivitiesDesViewTemplate = {};

---@type table<UnityEngine.GameObject, UIActivitiesDesUnitTemplate>
UIActivitiesDesViewTemplate.mUnitDic = nil;

UIActivitiesDesViewTemplate.mUIItemDic = nil;

UIActivitiesDesViewTemplate.mTablaData = nil;

---@type TABLE.cfg_daily_activity_time
UIActivitiesDesViewTemplate.mLuaTableData = nil;

--region Components

function UIActivitiesDesViewTemplate:GetAwardsDes_GameObject()
    if(self.mAwardDes_GameObject == nil) then
        self.mAwardDes_GameObject = self:Get("text","GameObject")
    end
    return self.mAwardDes_GameObject;
end

function UIActivitiesDesViewTemplate:GetRewardRoot_GameObject()
    if(self.mRewardRoot_GameObject == nil) then
        self.mRewardRoot_GameObject = self:Get("Reward","GameObject");
    end
    return self.mRewardRoot_GameObject;
end

function UIActivitiesDesViewTemplate:GetAwardsGridContainer()
    if(self.mAwardsGridContainer == nil) then
        self.mAwardsGridContainer = self:Get("Awards","UIGridContainer");
    end
    return self.mAwardsGridContainer;
end

function UIActivitiesDesViewTemplate:GetRewardGridContainer()
    if(self.mRewardsGridContainer == nil) then
        self.mRewardsGridContainer = self:Get("Reward/ScrollView/Awards","UIGridContainer");
    end
    return self.mRewardsGridContainer;
end

function UIActivitiesDesViewTemplate:GetUnitGridContainer()
    if(self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("ScrollView/Grid","UIGridContainer");
    end
    return self.mUnitGridContainer;
end

function UIActivitiesDesViewTemplate:GetUITable()
    if(self.mUITable == nil) then
        self.mUITable = self:Get("ScrollView/Grid","UITable");
    end
    return self.mUITable;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public

---@param tableData TABLE.cfg_daily_activity_time
function UIActivitiesDesViewTemplate:UpdateView(tableData)
    self.mLuaTableData = tableData;
    self.mTablaData = tableData:CsTABLE() == nil and tableData or tableData:CsTABLE();
    self:UpdateUI();
    self:UpdateAwards();
end

function UIActivitiesDesViewTemplate:UpdateUI()
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    if(self.mTablaData ~= nil) then
        local ruleDataVo = CS.Cfg_DailyActivityTimeTableManager.Instance:GetActivitiesDes(self.mTablaData);
        local unitGridContainer = self:GetUnitGridContainer();
        if(ruleDataVo ~= nil and unitGridContainer ~= nil) then
            unitGridContainer.MaxCount = ruleDataVo.ruleDataVoDic.Count;
            if(ruleDataVo.ruleDataVoDic.Count > 0) then
                local index = 0;
                CS.Utility_Lua.luaForeachCsharp:Foreach(ruleDataVo.ruleDataVoDic, function(k, v)
                    local gobj = unitGridContainer.controlList[index];
                    if(self.mUnitDic[gobj] == nil) then
                        self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIActivitiesDesUnitTemplate);
                    end
                    self.mUnitDic[gobj]:UpdateUnit(k,v);
                    index = index + 1;

                    if(index == unitGridContainer.MaxCount - 1) then
                        self:GetUITable():Reposition();
                    end
                end)
            end
        end
    end
    self:GetUITable():Reposition();
end

function UIActivitiesDesViewTemplate:UpdateAwards()
    if(self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end

    local isCalendarGift = self.mLuaTableData:GetHaveGift() == 1;
    local gridContainer = isCalendarGift and self:GetAwardsGridContainer() or self:GetRewardGridContainer();
    if(gridContainer == nil) then
        return;
    end
    local tableData = self.mTablaData;
    local itemIds, nums = CS.Cfg_DailyActivityTimeTableManager.Instance:GetActivityAwardShow(tableData);

    if(itemIds ~= nil and itemIds.Count > 0) then
        if(self:GetAwardsDes_GameObject() ~= nil) then
            self:GetAwardsDes_GameObject():SetActive(false);
        end
        self:GetRewardRoot_GameObject():SetActive(not isCalendarGift);
        gridContainer.MaxCount = itemIds.Count;
        for i = 0, itemIds.Count - 1 do
            local itemId = itemIds[i];
            local num = 1;
            if(nums.Count == itemIds.Count) then
                num = nums[i];
            end
            local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
            if(isFindItem) then
                local gobj = gridContainer.controlList[i];
                if(self.mUIItemDic[gobj] == nil) then
                    self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                    CS.UIEventListener.Get(gobj).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = self.mUIItemDic[gobj].ItemInfo})
                    end
                end
                self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, num);
            end
        end
    else
        self:GetRewardRoot_GameObject():SetActive(false);
        if(self:GetAwardsDes_GameObject() ~= nil) then
            self:GetAwardsDes_GameObject():SetActive(false);
        end
    end
end

function UIActivitiesDesViewTemplate:SetAwardActive(isActive)
    local gridContainer = self:GetAwardsGridContainer();
    if(gridContainer == nil) then
        return;
    end
    gridContainer.gameObject:SetActive(isActive);
end

--endregion

--region Private

function UIActivitiesDesViewTemplate:InitEvents()

end

function UIActivitiesDesViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UIActivitiesDesViewTemplate:Init()

end

return UIActivitiesDesViewTemplate;