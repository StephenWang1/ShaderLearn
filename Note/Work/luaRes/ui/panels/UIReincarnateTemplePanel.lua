---@class UIReincarnateTemplePanel:UIBase
local UIReincarnateTemplePanel = {};

---@type table<UnityEngine.GameObject,UIActivityDuplicateRewardItemTemplate>
UIReincarnateTemplePanel.mAwardUnitDic = nil;

--region Components
---@return UnityEngine.GameObject
function UIReincarnateTemplePanel:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

---@return UnityEngine.GameObject
function UIReincarnateTemplePanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UnityEngine.GameObject
function UIReincarnateTemplePanel:GetBtnGetWay_GameObject()
    if (self.mBtnGetWay_GameObject == nil) then
        self.mBtnGetWay_GameObject = self:GetCurComp("WidgetRoot/eventcost/btn_add", "GameObject");
    end
    return self.mBtnGetWay_GameObject;
end

---@return UnityEngine.GameObject
function UIReincarnateTemplePanel:GetBtnEnter_GameObject()
    if (self.mBtnEnter_GameObject == nil) then
        self.mBtnEnter_GameObject = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject");
    end
    return self.mBtnEnter_GameObject;
end

---@return UILabel
function UIReincarnateTemplePanel:GetDetails_Text()
    if (self.mDetails_Text == nil) then
        self.mDetails_Text = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "UILabel")
    end
    return self.mDetails_Text;
end

---奖励标题
---@return UILabel
function UIReincarnateTemplePanel:GetRewardTitle_Text()
    if self.mRewardTitle_Text == nil then
        self.mRewardTitle_Text = self:GetCurComp("WidgetRoot/introduce/labelGroup/title", "UILabel")
    end
    return self.mRewardTitle_Text
end

---@return UILabel
function UIReincarnateTemplePanel:GetFirstEnterCondition_Text()
    if (self.mFirstEnterCondition_Text == nil) then
        self.mFirstEnterCondition_Text = self:GetCurComp("WidgetRoot/eventcost", "UILabel");
    end
    return self.mFirstEnterCondition_Text;
end

---@return UILabel
function UIReincarnateTemplePanel:GetSecondEnterCondition_Text()
    if (self.mSecondEnterCondition_Text == nil) then
        self.mSecondEnterCondition_Text = self:GetCurComp("WidgetRoot/eventcostTwo/label", "UILabel");
    end
    return self.mSecondEnterCondition_Text;
end

---@return UISprite
function UIReincarnateTemplePanel:GetFirstCostItemIcon_UISprite()
    if (self.mFirstCostItemIcon_UISprite == nil) then
        self.mFirstCostItemIcon_UISprite = self:GetCurComp("WidgetRoot/eventcost/Sprite", "UISprite");
    end
    return self.mFirstCostItemIcon_UISprite;
end

---@return UIGridContainer
function UIReincarnateTemplePanel:GetAwardGridContainer()
    if (self.mAwardGridContainer == nil) then
        self.mAwardGridContainer = self:GetCurComp("WidgetRoot/Awards", "UIGridContainer");
    end
    return self.mAwardGridContainer;
end

---获取当前选中的副本表数据
---@return TABLE.CFG_DUPLICATE
function UIReincarnateTemplePanel:GetCurrentDuplicateTable()
    return self.mDuplicateTable
end

---获取副本列表
---@return table<number, TABLE.CFG_DUPLICATE>
function UIReincarnateTemplePanel:GetDuplicateList()
    if self.mDuplicateList == nil then
        self.mDuplicateList = {}
        local list = CS.Cfg_DuplicateTableManager.Instance:GetDuplicateInfoListByDuplicateType(37)
        if list then
            for i = 0, list.Count - 1 do
                local tbl = list[i]
                table.insert(self.mDuplicateList, tbl)
            end
        end
    end
    return self.mDuplicateList
end

---@return TABLE.CFG_DAILY_ACTIVITY_TIME|nil
function UIReincarnateTemplePanel:GetDailyActivityTimeTable()
    if (self.mDuplicateTable ~= nil) then
        local isFind, dailyActivityTimeTable = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self.mDuplicateTable.openTime);
        if (isFind) then
            return dailyActivityTimeTable;
        end
    end
end

---@return TABLE.CFG_DELIVER|nil
function UIReincarnateTemplePanel:GetDeliverTable()
    local dailyActivityTimeTbl = self:GetDailyActivityTimeTable();
    if (dailyActivityTimeTbl ~= nil) then
        local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(dailyActivityTimeTbl.deliverId);
        if (isFind) then
            return deliverTable;
        end
    end
end

---条件展开按钮
---@return UnityEngine.GameObject
function UIReincarnateTemplePanel:GetConditionAddButton()
    if self.mConditionAddBtn == nil then
        self.mConditionAddBtn = self:GetCurComp("WidgetRoot/eventcostTwo/btn_add", "GameObject")
    end
    return self.mConditionAddBtn
end

---@return UnityEngine.GameObject
function UIReincarnateTemplePanel:GetLocationGO()
    if self.mLocationGO == nil then
        self.mLocationGO = self:GetCurComp("WidgetRoot/eventcostTwo/Location", "GameObject")
    end
    return self.mLocationGO
end

---@return UIScrollView
function UIReincarnateTemplePanel:GetLocationListScrollView()
    if self.mLocationListScrollView == nil then
        self.mLocationListScrollView = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList", "UIScrollView")
    end
    return self.mLocationListScrollView
end

---@return Top_UIGridContainer
function UIReincarnateTemplePanel:GetLocationListGridContainer()
    if self.mLocationListGridContainer == nil then
        self.mLocationListGridContainer = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList/Grid", "UIGridContainer")
    end
    return self.mLocationListGridContainer
end
--endregion

--region Method
---@public
function UIReincarnateTemplePanel:UpdateUI()
    --self:UpdateEnterCondition();
    self:UpdateAwards();
    self:UpdateDetails();
    self:RefreshCurrentSelectedDuplicate()
end

---@public
function UIReincarnateTemplePanel:UpdateAwards()
    if (self.mAwardUnitDic == nil) then
        self.mAwardUnitDic = {};
    end
    local gridContainer = self:GetAwardGridContainer();
    if (self.mDuplicateTable ~= nil) then
        local awardList = CS.Cfg_DuplicateTableManager.Instance:GetRewardItemIds(self.mDuplicateTable);
        if (awardList ~= nil and awardList.Count > 0) then
            gridContainer.MaxCount = awardList.Count;
            for i = 0, awardList.Count - 1 do
                ---@type UnityEngine.GameObject
                local gobj = gridContainer.controlList[i];
                if (self.mAwardUnitDic[gobj] == nil) then
                    self.mAwardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
                end
                self.mAwardUnitDic[gobj]:RefreshUI(awardList[i], nil);
            end
            self:GetRewardTitle_Text().gameObject:SetActive(true)
        else
            gridContainer.MaxCount = 0;
            self:GetRewardTitle_Text().gameObject:SetActive(false)
        end
    else
        gridContainer.MaxCount = 0;
        self:GetRewardTitle_Text().gameObject:SetActive(false)
    end
end

---@public
function UIReincarnateTemplePanel:UpdateDetails()
    local isFind, desTable = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(167)
    if isFind then
        self:GetDetails_Text().text = string.gsub(desTable.value, '\\n', '\n')
    end
end

--region old
-----@public
--function UIReincarnateTemplePanel:UpdateEnterCondition()
--    if (CS.CSScene.MainPlayerInfo == nil) then
--        return ;
--    end
--
--    if (self.mDuplicateTable ~= nil) then
--        local conditionId = self.mDuplicateTable.condition;
--        local isFind, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(conditionId);
--        if (isFind) then
--            if (conditionTable.conditionType == Utility.EnumToInt(CS.EConditionType.NotLowerThan_ReinLevel)) then
--                if (conditionTable.conditionParam ~= nil and conditionTable.conditionParam.list.Count > 0) then
--                    local reinLevel = conditionTable.conditionParam.list[0];
--                    self:GetSecondEnterCondition_Text().text = "转生等级达到" .. reinLevel .. "级";
--                end
--            end
--        end
--    end
--
--    local deliverTable = self:GetDeliverTable();
--    self:GetFirstEnterCondition_Text().gameObject:SetActive(false);
--    if (deliverTable ~= nil) then
--        local costItem = deliverTable.item;
--        if (costItem ~= nil) then
--            local splitString_1 = string.Split(costItem, "&");
--            if (#splitString_1 > 0) then
--                local splitString_2 = string.Split(splitString_1[1], "#");
--                if (#splitString_2 > 1) then
--                    local itemId = tonumber(splitString_2[1]);
--                    local count = tonumber(splitString_2[2]);
--                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
--                    if (isFind) then
--                        self:GetFirstEnterCondition_Text().gameObject:SetActive(true);
--                        self:GetFirstCostItemIcon_UISprite().spriteName = itemTable.icon;
--                        local mNum = 0;
--                        if (itemTable.type == luaEnumItemType.Coin) then
--                            mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(itemId);
--                        else
--                            mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemId);
--                        end
--                        local isEnough = mNum >= count;
--                        local colorString = isEnough and luaEnumColorType.Green or luaEnumColorType.Red;
--                        self:GetFirstEnterCondition_Text().text = colorString .. mNum .. "[-]" .. luaEnumColorType.White .. "/" .. count .. "[-]";
--                    end
--                    CS.UIEventListener.Get(self:GetBtnGetWay_GameObject()).onClick = function()
--                        Utility.ShowItemGetWay(itemId);
--                    end
--                end
--            end
--        end
--    end
--end
--endregion

---@private
function UIReincarnateTemplePanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnEnter_GameObject()).onClick = function()
        local deliverTbl = self:GetDeliverTable();
        if (deliverTbl ~= nil) then
            if (self.mDuplicateTable ~= nil) then
                if (self:IsConditionMatch(self.mDuplicateTable)) then
                    Utility.ReqEnterDuplicate(deliverTbl.toMapId);
                    uimanager:ClosePanel('UIReincarnateTemplePanel');
                    uimanager:ClosePanel("UIMonsterHeadPanel");
                else
                    Utility.ShowPopoTips(self:GetBtnEnter_GameObject().transform, nil, 426, "UIReincarnateTemplePanel");
                end
            end
        end
    end;

    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIReincarnateTemplePanel");
    end

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(165)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end

    CS.UIEventListener.Get(self:GetConditionAddButton()).onClick = function()
        if self:GetLocationGO().activeSelf == false then
            self:ExpandLevelSelect()
        else
            self:HideLevelSelect()
        end
    end
end
--endregion

function UIReincarnateTemplePanel:Init()
    self:InitEvents();
end

function UIReincarnateTemplePanel:Show(DupID)
    self:RefreshDefaultDuplicate(DupID)
    self:UpdateUI();
end

---刷新默认副本
function UIReincarnateTemplePanel:RefreshDefaultDuplicate(DupID)
    self.mDuplicateTable = nil
    local list = self:GetDuplicateList()
    for i = 1, #list do
        local duplicateTbl = list[i]
        if (DupID == nil) then
            if self:IsSuggestConditionMatch(duplicateTbl) then
                self.mDuplicateTable = duplicateTbl
            end
        else
            if self:IsSuggestConditionMatch(duplicateTbl) and duplicateTbl.id == tonumber(DupID) then
                self.mDuplicateTable = duplicateTbl
                break
            end
        end
    end
    if self.mDuplicateTable == nil and #list > 0 then
        self.mDuplicateTable = list[1]
    end
end

---展开层数选择
function UIReincarnateTemplePanel:ExpandLevelSelect()
    self:GetLocationGO():SetActive(true)
    local list = self:GetDuplicateList()
    self:GetLocationListGridContainer().MaxCount = #list
    local currentIndex = 1
    for i = 1, #list do
        local duplicateTbl = list[i]
        ---@type UnityEngine.GameObject
        local go = self:GetLocationListGridContainer().controlList[i - 1]
        ---@type UILabel
        local label = self:GetComp(go.transform, "lb_location", "UILabel")
        label.text = "[" .. self:GetColorStr(duplicateTbl) .. "]" .. duplicateTbl.name .. "[-]"
                .. "[878787](" .. self:GetLevelStr(duplicateTbl) .. ")[-]"
        CS.UIEventListener.Get(go).onClick = function()
            self.mDuplicateTable = duplicateTbl
            self:UpdateUI()
            self:HideLevelSelect()
        end
        if duplicateTbl.id == self:GetCurrentDuplicateTable().id then
            currentIndex = i
        end
    end
    local percentage
    if #list > 1 then
        percentage = (currentIndex - 1) / (#list - 1)
    else
        percentage = 1
    end
    self:GetLocationListScrollView():ScrollImmidate(percentage)
end

---隐藏层数选择
function UIReincarnateTemplePanel:HideLevelSelect()
    self:GetLocationGO():SetActive(false)
end

---条件是否满足
---@param duplicateTable TABLE.CFG_DUPLICATE
---@return boolean
function UIReincarnateTemplePanel:IsConditionMatch(duplicateTable)
    if duplicateTable == nil then
        return false
    end
    if duplicateTable.condition then
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(duplicateTable.condition)
    end
    return false
end

---建议条件是否满足
---@param duplicateTable TABLE.CFG_DUPLICATE
---@return boolean
function UIReincarnateTemplePanel:IsSuggestConditionMatch(duplicateTable)
    if duplicateTable == nil then
        return false
    end
    if duplicateTable.specialCondition ~= nil and duplicateTable.specialCondition.list ~= nil then
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(duplicateTable.specialCondition.list)
    end
    return false
end

---刷新当前选中的副本
function UIReincarnateTemplePanel:RefreshCurrentSelectedDuplicate()
    if self:GetCurrentDuplicateTable() then
        self:GetSecondEnterCondition_Text().text = "[" .. self:GetColorStr(self:GetCurrentDuplicateTable()) .. "]" .. self:GetCurrentDuplicateTable().name .. "[-]"
                .. "[878787](" .. self:GetLevelStr(self:GetCurrentDuplicateTable()) .. ")[-]"
    else
        self:GetSecondEnterCondition_Text().text = ""
    end
    self:GetFirstEnterCondition_Text().gameObject:SetActive(false);
end

---获取颜色字符串
---@param duplicateTable TABLE.CFG_DUPLICATE
function UIReincarnateTemplePanel:GetColorStr(duplicateTable)
    if duplicateTable then
        if self:IsConditionMatch(duplicateTable) then
            return "00ff00"
        else
            return "878787"
        end
    end
    return ""
end

---获取副本的等级字符串
---@param duplicateTable TABLE.CFG_DUPLICATE
---@return string
function UIReincarnateTemplePanel:GetLevelStr(duplicateTable)
    if duplicateTable == nil then
        return ""
    end
    ---@type TABLE.CFG_CONDITIONS
    local conditionTbl
    ___, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(duplicateTable.condition)
    if conditionTbl == nil then
        return ""
    end
    if conditionTbl.conditionParam.list.Count > 0 then
        local level = conditionTbl.conditionParam.list[0]
        local conditionType = conditionTbl.conditionType
        if conditionType == 1 or conditionType == 2 then
            ---与等级比较
            return "" .. tostring(level) .. "级"
        elseif conditionType == 3 or conditionType == 4 then
            ---与转生等级比较
            return "转生" .. tostring(level) .. "级"
        end
        --if level == 0 then
        --    return "零"
        --elseif level == 1 then
        --    return "一"
        --elseif level == 2 then
        --    return "二"
        --elseif level == 3 then
        --    return "三"
        --elseif level == 4 then
        --    return "四"
        --elseif level == 5 then
        --    return "五"
        --elseif level == 6 then
        --    return "六"
        --elseif level == 7 then
        --    return "七"
        --elseif level == 8 then
        --    return "八"
        --elseif level == 9 then
        --    return "九"
        --elseif level == 10 then
        --    return "十"
        --elseif level == 11 then
        --    return "十一"
        --elseif level == 12 then
        --    return "十二"
        --elseif level == 13 then
        --    return "十三"
        --elseif level == 14 then
        --    return "十四"
        --elseif level == 15 then
        --    return "十五"
        --elseif level == 16 then
        --    return "十六"
        --elseif level == 17 then
        --    return "十七"
        --elseif level == 18 then
        --    return "十八"
        --elseif level == 19 then
        --    return "十九"
        --elseif level == 20 then
        --    return "二十"
        --elseif level == 21 then
        --    return "二十一"
        --elseif level == 22 then
        --    return "二十二"
        --elseif level == 23 then
        --    return "二十三"
        --elseif level == 24 then
        --    return "二十四"
        --elseif level == 25 then
        --    return "二十五"
        --elseif level == 26 then
        --    return "二十六"
        --elseif level == 27 then
        --    return "二十七"
        --elseif level == 28 then
        --    return "二十八"
        --elseif level == 29 then
        --    return "二十九"
        --elseif level == 30 then
        --    return "三十"
        --end
    end
    return ""
end

return UIReincarnateTemplePanel;
