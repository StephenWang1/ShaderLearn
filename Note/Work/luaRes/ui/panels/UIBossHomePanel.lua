---@class UIBossHomePanel:UIBase
local UIBossHomePanel = {}

local CheckNullFunction = CS.StaticUtility.IsNull
---@type table<UnityEngine.GameObject,UIActivityDuplicateRewardItemTemplate>
UIBossHomePanel.mAwardUnitDic = nil;
--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIBossHomePanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UIGridContainer 奖励列表
function UIBossHomePanel:GetReward_UIGridContainer()
    if self.mRewardContainer == nil then
        self.mRewardContainer = self:GetCurComp("WidgetRoot/Awards", "UIGridContainer")
    end
    return self.mRewardContainer
end

---@return UnityEngine.GameObject 开启下拉框按钮
function UIBossHomePanel:GetOpenDropDownBtn_Go()
    if self.mOpenDropDownBtn == nil then
        self.mOpenDropDownBtn = self:GetCurComp("WidgetRoot/eventcostTwo/btn_add", "GameObject")
    end
    return self.mOpenDropDownBtn
end

---@return UnityEngine.GameObject 关闭下拉框按钮
function UIBossHomePanel:GetCloseDropDownBtn_Go()
    if self.mCloseDropDownBtn == nil then
        self.mCloseDropDownBtn = self:GetCurComp("WidgetRoot/eventcostTwo/Location/block", "GameObject")
    end
    return self.mCloseDropDownBtn
end
---@return UILabel 选中文字
function UIBossHomePanel:GetChoose_Lb()
    if self.mChooseLb == nil then
        self.mChooseLb = self:GetCurComp("WidgetRoot/eventcostTwo/label", "UILabel")
    end
    return self.mChooseLb
end
---@return UnityEngine.GameObject 下拉框GO
function UIBossHomePanel:GetDropDown_Go()
    if self.mDropDownGo == nil then
        self.mDropDownGo = self:GetCurComp("WidgetRoot/eventcostTwo/Location", "GameObject")
    end
    return self.mDropDownGo
end

---@return UIGridContainer 奖励列表
function UIBossHomePanel:GetDropDown_UIGridContainer()
    if self.mDropDownContainer == nil then
        self.mDropDownContainer = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList/Grid", "UIGridContainer")
    end
    return self.mDropDownContainer
end
---@return UIScrollView
function UIBossHomePanel:GetDropDown_ScrollView()
    if self.mDropDownScrollView == nil then
        self.mDropDownScrollView = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList", "UIScrollView")
    end
    return self.mDropDownScrollView
end
---@return UnityEngine.GameObject 帮助按钮
function UIBossHomePanel:GetHelpBtn_Go()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/btn_help", "GameObject")
    end
    return self.mHelpBtn
end

function UIBossHomePanel:GetEnterBtn_GO()
    if self.mEnterBtnGo == nil then
        self.mEnterBtnGo = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return self.mEnterBtnGo
end
--endregion

--region 初始化
function UIBossHomePanel:Init()
    self:BindEvent()
end

function UIBossHomePanel:Show(DupID)
    self:RefreshDefaultDuplicate(DupID)
    self:UpdateUI();
end
---@public
function UIBossHomePanel:UpdateUI()
    self:UpdateAwards();
    self:UpdateChooseLb();
end
function UIBossHomePanel:UpdateChooseLb()
    if(self:GetCurrentDuplicateTable()~=nil and self:GetChoose_Lb()~=nil)then
        self:GetChoose_Lb().text ="[" .. self:GetColorStr(self:GetCurrentDuplicateTable()) .. "]" .. self:GetCurrentDuplicateTable().name .. "[-]"
                .. "[878787](" .. self:GetVIPLevelStr(self:GetCurrentDuplicateTable()) .. ")[-]"
    end
end
function UIBossHomePanel:BindEvent()
    if CheckNullFunction(self:GetCloseBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetCloseBtn_Go()) .onClick = function()
            self:ClosePanel()
        end
    end
    if CheckNullFunction(self:GetCloseDropDownBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetCloseDropDownBtn_Go()).onClick = function()
            self:GetDropDown_Go():SetActive(false)
        end
    end
    if CheckNullFunction(self:GetOpenDropDownBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetOpenDropDownBtn_Go()).onClick = function()
            self:GetDropDown_Go():SetActive(true)
            self:RefreshDropDown()
        end
    end
    if CheckNullFunction(self:GetHelpBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetHelpBtn_Go()).onClick = function(go)
            self:OnHelpBtnClicked(go)
        end
    end
    if CheckNullFunction(self:GetEnterBtn_GO()) == false then
        CS.UIEventListener.Get(self:GetEnterBtn_GO()).onClick = function(go)
            self:OnEnterBtnClicked(go)
        end
    end
end
--endregion

--region 下拉框
function UIBossHomePanel:RefreshDropDown()
    if CheckNullFunction(self:GetDropDown_UIGridContainer()) == false then
        local list = self:GetDuplicateList()
        self:GetDropDown_UIGridContainer().MaxCount = #list
        local currentIndex = 1
        for i = 1, #list do
            local duplicateTbl = list[i]
            ---@type UnityEngine.GameObject
            local go = self:GetDropDown_UIGridContainer().controlList[i - 1]
            ---@type UILabel
            local label = self:GetComp(go.transform, "lb_location", "UILabel")
            label.text = "[" .. self:GetColorStr(duplicateTbl) .. "]" .. duplicateTbl.name .. "[-]"
                    .. "[878787](" .. self:GetVIPLevelStr(duplicateTbl) .. ")[-]"
            CS.UIEventListener.Get(go).onClick = function()
                self.mDuplicateTable = duplicateTbl
                self:UpdateUI()
            end
            if(self:GetCurrentDuplicateTable()~=nil)then
                if duplicateTbl.id == self:GetCurrentDuplicateTable().id then
                    currentIndex = i
                end
            end
        end
        local percentage
        if #list > 1 then
            percentage = (currentIndex - 1) / (#list - 1)
        else
            percentage = 1
        end
        self:GetDropDown_ScrollView():ScrollImmidate(percentage)
    end
end
--endregion

--region 帮助
function UIBossHomePanel:OnHelpBtnClicked(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(170)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end

end
--endregion

--region 进入
function UIBossHomePanel:OnEnterBtnClicked(go)
    local deliverTbl = self:GetDeliverTable();
    if (deliverTbl ~= nil) then
        if (self.mDuplicateTable ~= nil) then
            if (self:IsConditionMatch(self.mDuplicateTable)) then
                Utility.ReqEnterDuplicate(deliverTbl.toMapId);
                uimanager:ClosePanel('UIBossHomePanel');
                --uimanager:ClosePanel("UIMonsterHeadPanel");
            else
                --Utility.ShowPopoTips(self:GetBtnEnter_GameObject().transform, nil, 49, "UIBossHomePanel");
                --跳转VIP界面
                uimanager:CreatePanel("UIVipInfoPanel")
            end
        end
    end
end

--endregion
---获取当前选中的副本表数据
---@return TABLE.CFG_DUPLICATE
function UIBossHomePanel:GetCurrentDuplicateTable()
    return self.mDuplicateTable
end
---获取副本列表
---@return table<number, TABLE.CFG_DUPLICATE>
function UIBossHomePanel:GetDuplicateList()
    if self.mDuplicateList == nil then
        self.mDuplicateList = {}
        local list = CS.Cfg_DuplicateTableManager.Instance:GetDuplicateInfoListByDuplicateType(39)
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
function UIBossHomePanel:GetDailyActivityTimeTable()
    if (self.mDuplicateTable ~= nil) then
        local isFind, dailyActivityTimeTable = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self.mDuplicateTable.openTime);
        if (isFind) then
            return dailyActivityTimeTable;
        end
    end
end

---@return TABLE.CFG_DELIVER|nil
function UIBossHomePanel:GetDeliverTable()
    local dailyActivityTimeTbl = self:GetDailyActivityTimeTable();
    if (dailyActivityTimeTbl ~= nil) then
        local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(dailyActivityTimeTbl.deliverId);
        if (isFind) then
            return deliverTable;
        end
    end
end
---@public
function UIBossHomePanel:UpdateAwards()
    if CheckNullFunction(self:GetReward_UIGridContainer()) == false then
        if (self.mAwardUnitDic == nil) then
            self.mAwardUnitDic = {};
        end
        local gridContainer = self:GetReward_UIGridContainer();
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
            else
                gridContainer.MaxCount = 0;
            end
        else
            gridContainer.MaxCount = 0;
        end
    end
    if CheckNullFunction(self:GetDropDown_Go()) == false then
        self:GetDropDown_Go():SetActive(false)
    end
end
---刷新默认副本
function UIBossHomePanel:RefreshDefaultDuplicate(DupID)
    self.mDuplicateTable = nil
    local list = self:GetDuplicateList()
    for i = 1, #list do
        local duplicateTbl = list[i]
        if(DupID==nil)then
            if self:IsConditionMatch(duplicateTbl) then
                self.mDuplicateTable = duplicateTbl
            end
        else
            if self:IsConditionMatch(duplicateTbl) and duplicateTbl.id==tonumber(DupID) then
                self.mDuplicateTable = duplicateTbl
                break
            end
        end
    end
    if self.mDuplicateTable == nil and #list > 0 then
        self.mDuplicateTable = list[1]
    end
end
---条件是否满足
---@param duplicateTable TABLE.CFG_DUPLICATE
---@return boolean
function UIBossHomePanel:IsConditionMatch(duplicateTable)
    if duplicateTable == nil then
        return false
    end
    if duplicateTable.condition then
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(duplicateTable.condition)
    end
    return false
end
---获取颜色字符串
---@param duplicateTable TABLE.CFG_DUPLICATE
function UIBossHomePanel:GetColorStr(duplicateTable)
    if duplicateTable then
        if self:IsConditionMatch(duplicateTable) then
            return "00ff00"
        else
            return "878787"
        end
    end
    return ""
end
---获取副本的VIP等级字符串
---@param duplicateTable TABLE.CFG_DUPLICATE
---@return string
function UIBossHomePanel:GetVIPLevelStr(duplicateTable)
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
        if conditionType == 43then
            ---与VIP等级比较
            return "VIP" .. tostring(level)
        end
    end
    return ""
end
return UIBossHomePanel