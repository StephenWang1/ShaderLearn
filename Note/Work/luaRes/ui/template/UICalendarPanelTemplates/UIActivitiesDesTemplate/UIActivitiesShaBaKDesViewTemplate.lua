---@class UIActivitiesShaBaKDesViewTemplate:UIActivitiesDesViewTemplate
local UIActivitiesShaBaKDesViewTemplate = {};

setmetatable(UIActivitiesShaBaKDesViewTemplate, luaComponentTemplates.UIActivitiesDesViewTemplate);

UIActivitiesShaBaKDesViewTemplate.mAwardShowUnitDic = nil;

---@type CalendarItem
UIActivitiesShaBaKDesViewTemplate.mCalendarItem = nil;

function UIActivitiesShaBaKDesViewTemplate:GetRootUITable()
    if(self.mRootUITable == nil) then
        self.mRootUITable = self:Get("ScrollView/root", "UITable");
    end
    return self.mRootUITable;
end

function UIActivitiesShaBaKDesViewTemplate:GetAwardsGridContainer()
    if(self.mAwardsGridContainer == nil) then
        self.mAwardsGridContainer = self:Get("Reward/ScrollView/Awards","UIGridContainer");
    end
    return self.mAwardsGridContainer;
end

function UIActivitiesShaBaKDesViewTemplate:GetUITable()
    if(self.mUITable == nil) then
        self.mUITable = self:Get("ScrollView/root/Grid","UITable");
    end
    return self.mUITable;
end

function UIActivitiesShaBaKDesViewTemplate:GetUnitGridContainer()
    if(self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("ScrollView/root/Grid","UIGridContainer");
    end
    return self.mUnitGridContainer;
end

function UIActivitiesShaBaKDesViewTemplate:UpdateView(tableData, calendarItem)
    self.mCalendarItem = calendarItem;
    self:RunBaseFunction("UpdateView", tableData)
end

function UIActivitiesShaBaKDesViewTemplate:UpdateAwards()
    if(self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end
    local gridContainer = self:GetAwardsGridContainer();
    if(gridContainer == nil) then
        return;
    end

    local rewards = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetShaBaKWinRewards(self.mCalendarItem);
    if(rewards ~= nil and #rewards > 0) then
        if(self:GetAwardsDes_GameObject() ~= nil) then
            self:GetAwardsDes_GameObject():SetActive(false);
        end

        gridContainer.MaxCount = #rewards;
        for k,v in pairs(rewards) do
            if(#v > 1) then
                local itemId = v[1];
                local num = v[2];
                local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                if(isFindItem) then
                    local gobj = gridContainer.controlList[k - 1];
                    if(self.mUIItemDic[gobj] == nil) then
                        self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                        CS.UIEventListener.Get(gobj).onClick = function()
                            uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemTable})
                        end
                    end
                    self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, num);
                end
            end
        end
    else
        if(self:GetAwardsDes_GameObject() ~= nil) then
            self:GetAwardsDes_GameObject():SetActive(false);
        end
    end
end

return UIActivitiesShaBaKDesViewTemplate;