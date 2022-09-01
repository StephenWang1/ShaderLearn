---@class UIAncientBattlefileldPanel:UIBase 上古战场副本面板
local UIAncientBattlefileldPanel = {}

local CheckNullFunction = CS.StaticUtility.IsNull

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIAncientBattlefileldPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UIGridContainer 奖励列表
function UIAncientBattlefileldPanel:GetReward_UIGridContainer()
    if self.mRewardContainer == nil then
        self.mRewardContainer = self:GetCurComp("WidgetRoot/Awards", "UIGridContainer")
    end
    return self.mRewardContainer
end

---@return UnityEngine.GameObject 开启下拉框按钮
function UIAncientBattlefileldPanel:GetOpenDropDownBtn_Go()
    if self.mOpenDropDownBtn == nil then
        self.mOpenDropDownBtn = self:GetCurComp("WidgetRoot/eventcostTwo/btn_add", "GameObject")
    end
    return self.mOpenDropDownBtn
end

---@return UnityEngine.GameObject 关闭下拉框按钮
function UIAncientBattlefileldPanel:GetCloseDropDownBtn_Go()
    if self.mCloseDropDownBtn == nil then
        self.mCloseDropDownBtn = self:GetCurComp("WidgetRoot/eventcostTwo/Location/block", "GameObject")
    end
    return self.mCloseDropDownBtn
end

---@return UnityEngine.GameObject 下拉框GO
function UIAncientBattlefileldPanel:GetDropDown_Go()
    if self.mDropDownGo == nil then
        self.mDropDownGo = self:GetCurComp("WidgetRoot/eventcostTwo/Location", "GameObject")
    end
    return self.mDropDownGo
end

---@return UILabel 选中副本显示
function UIAncientBattlefileldPanel:GetChooseDuplicateShow_UILabel()
    if self.mCurrentChooseLb == nil then
        self.mCurrentChooseLb = self:GetCurComp("WidgetRoot/eventcostTwo/label", "UILabel")
    end
    return self.mCurrentChooseLb
end

---@return UIGridContainer 奖励列表
function UIAncientBattlefileldPanel:GetDropDown_UIGridContainer()
    if self.mDropDownContainer == nil then
        self.mDropDownContainer = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList/Grid", "UIGridContainer")
    end
    return self.mDropDownContainer
end

---@return UnityEngine.GameObject 帮助按钮
function UIAncientBattlefileldPanel:GetHelpBtn_Go()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/btn_help", "GameObject")
    end
    return self.mHelpBtn
end

---@return UnityEngine.GameObject 进入按钮
function UIAncientBattlefileldPanel:GetEnterBtn_GO()
    if self.mEnterBtnGo == nil then
        self.mEnterBtnGo = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return self.mEnterBtnGo
end

---@return UIScrollView 控制SV
function UIAncientBattlefileldPanel:GetLocation_UIScrollView()
    if self.mLocationSV == nil then
        self.mLocationSV = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList", "UIScrollView")
    end
    return self.mLocationSV
end

---@return UIPanel 控制SV
function UIAncientBattlefileldPanel:GetLocation_UIPanel()
    if self.mLocationPanel == nil then
        self.mLocationPanel = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList", "UIPanel")
    end
    return self.mLocationPanel
end

--endregion

--region 数据

---@type TABLE.CFG_DUPLICATE
---当前选择副本数据
UIAncientBattlefileldPanel.mCurrentChooseDuplicate = nil

---@type TABLE.CFG_DUPLICATE
---当前可进入副本数据
UIAncientBattlefileldPanel.mCurrentCanChooseDuplicate = nil

---@type table<number,number> 副本id对应位置
UIAncientBattlefileldPanel.mCurrentDuplicateIdToIndex = nil

---@return CSMainPlayerInfo
function UIAncientBattlefileldPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return TABLE.CFG_CONDITIONS 条件表
function UIAncientBattlefileldPanel:CacheConditionInfo(id)
    if self.mConditionIdToInfo == nil then
        self.mConditionIdToInfo = {}
    end
    local info = self.mConditionIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(id)
        self.mConditionIdToInfo[id] = info
    end
    return info
end

---@return TABLE.CFG_ITEMS 道具表
function UIAncientBattlefileldPanel:CacheItemInfo(id)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToInfo[id] = info
    end
    return info
end
--endregion

--region 初始化
function UIAncientBattlefileldPanel:Init()
    self:BindEvent()
end

function UIAncientBattlefileldPanel:Show(DupID)
    self.mCurrentCanChooseDuplicate = nil
    self:RefreshDropDown()
    self:RefreshDefaultDuplicate(DupID)
    self:OnClickDuplicate(self.mCurrentCanChooseDuplicate)
end

function UIAncientBattlefileldPanel:BindEvent()
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
            self:ShowDropDown()
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

--region 奖励
---刷新奖励
---@param duplicate TABLE.CFG_DUPLICATE 副本表
function UIAncientBattlefileldPanel:RefreshReward(duplicate)
    if CheckNullFunction(self:GetReward_UIGridContainer()) == false and duplicate then
        local data = CS.Cfg_DuplicateTableManager.Instance:GetRewardItemIds(duplicate)
        if data then
            self:GetReward_UIGridContainer().MaxCount = data.Count
            for i = 0, self:GetReward_UIGridContainer().controlList.Count - 1 do
                local go = self:GetReward_UIGridContainer().controlList[i]
                local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
                local itemInfo = self:CacheItemInfo(data[i])
                if itemInfo then
                    icon.spriteName = itemInfo.icon
                    CS.UIEventListener.Get(go).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                    end
                end
            end
        end
    end
end
--endregion

--region 下拉框
function UIAncientBattlefileldPanel:ShowDropDown()
    self:GetDropDown_Go():SetActive(true)
    self:JumpToAimLine(self.mCurrentCanChooseDuplicate)
end

---刷新下拉列表
function UIAncientBattlefileldPanel:RefreshDropDown()
    self.mCurrentDuplicateIdToIndex = {}
    if CheckNullFunction(self:GetDropDown_UIGridContainer()) == false then
        local showDuplicate = CS.Cfg_DuplicateTableManager.Instance:GetDuplicateInfoListByDuplicateType(40)
        if showDuplicate then
            self:GetDropDown_UIGridContainer().MaxCount = showDuplicate.Count
            for i = 0, self:GetDropDown_UIGridContainer().controlList.Count - 1 do
                local go = self:GetDropDown_UIGridContainer().controlList[i]
                if CheckNullFunction(go) == false then
                    ---@type TABLE.CFG_DUPLICATE
                    local duplicate = showDuplicate[i]
                    local location = CS.Utility_Lua.Get(go.transform, "lb_location", "UILabel")
                    local show = self:GetShowLocation(duplicate)
                    location.text = show
                    CS.UIEventListener.Get(go).onClick = function()
                        self:OnClickDuplicate(duplicate)
                    end
                    self.mCurrentDuplicateIdToIndex[duplicate.id] = i
                end
            end
        end
    end
end
---刷新默认副本
function UIAncientBattlefileldPanel:RefreshDefaultDuplicate(DupID)
    if (DupID == nil) then
        return
    end
    local duplicate
    ___, duplicate = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(tonumber(DupID))
    if (duplicate ~= nil and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(duplicate.condition)) then
        self.mCurrentCanChooseDuplicate = duplicate
    end
end
---@param duplicate TABLE.CFG_DUPLICATE 副本表
function UIAncientBattlefileldPanel:GetShowLocation(duplicate)
    if duplicate then
        ---获取显示数据
        local conditionId = duplicate.condition
        local CanEnter = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId)
        self:SaveCanEnterDuplicate(duplicate.id, CanEnter)
        local prefixShow = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(conditionId)
        local color = CanEnter and luaEnumColorType.Green or luaEnumColorType.Gray
        ---存储可进入最高副本
        if self.mCurrentCanChooseDuplicate == nil or CanEnter then
            self.mCurrentCanChooseDuplicate = duplicate
        end
        return color .. duplicate.name .. luaEnumColorType.Gray .. "(" .. prefixShow .. ")"
    end
    return ""
end

---存储副本进入信息
function UIAncientBattlefileldPanel:SaveCanEnterDuplicate(id, CanEnter)
    if self.mDuplicateIDToCanEnter == nil then
        self.mDuplicateIDToCanEnter = {}
    end
    self.mDuplicateIDToCanEnter[id] = CanEnter
end

---@return boolean 是否能进入副本
function UIAncientBattlefileldPanel:GetDuplicateCanEnter(id)
    if self.mDuplicateIDToCanEnter then
        return self.mDuplicateIDToCanEnter[id]
    end
    return false
end

---点击副本
---@param duplicate TABLE.CFG_DUPLICATE 副本表
function UIAncientBattlefileldPanel:OnClickDuplicate(duplicate)
    local show = self:GetShowLocation(duplicate)
    self:GetChooseDuplicateShow_UILabel().text = show
    self:GetDropDown_Go():SetActive(false)
    self.mCurrentCanChooseDuplicate = duplicate
    self:RefreshReward(duplicate)
end

---@param duplicate TABLE.CFG_DUPLICATE 副本表
function UIAncientBattlefileldPanel:JumpToAimLine(duplicate)
    if self.mCurrentDuplicateIdToIndex == nil then
        return
    end
    ---目标行
    local index = self.mCurrentDuplicateIdToIndex[duplicate.id]
    if index then
        local jumpLine = index - 3
        if jumpLine < 0 then
            jumpLine = 0
        end
        self:GetLocation_UIScrollView():ResetPosition()
        local pos = self:GetLocation_UIScrollView().transform.localPosition
        local originClip = self:GetLocation_UIPanel().clipOffset
        local height = self:GetDropDown_UIGridContainer().CellHeight
        local offset = height * jumpLine
        pos.y = pos.y + offset
        originClip.y = originClip.y - offset
        self:GetLocation_UIPanel().clipOffset = originClip
        self:GetLocation_UIScrollView().transform.localPosition = pos
    end
end

--endregion

--region 帮助
function UIAncientBattlefileldPanel:OnHelpBtnClicked(go)
    local data = {}
    data.id = 171
    Utility.ShowHelpPanel(data)
end
--endregion

--region 进入
function UIAncientBattlefileldPanel:OnEnterBtnClicked(go)
    local CanEnter = self:GetDuplicateCanEnter(self.mCurrentCanChooseDuplicate.id)
    if CanEnter then
        networkRequest.ReqEnterDuplicate(self.mCurrentCanChooseDuplicate.id)
        self:ClosePanel()
    else
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Prefix)
    end
end

--endregion

return UIAncientBattlefileldPanel