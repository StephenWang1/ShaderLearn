---@class UIConfigPanel_PartBasic
local UIConfigPanel_PartBasic = {}

---下拉列表缓存 table<Top_DropDown,table>
UIConfigPanel_PartBasic.dropDownTable = nil

---@param uiConfigPanel UIConfigPanel
function UIConfigPanel_PartBasic:Init(uiConfigPanel, panelType)
    if uiConfigPanel ~= nil then
        self.uiConfigPanel = uiConfigPanel
        self.Config = uiConfigPanel.Config
        self.isRefresh = false
        self.panelType = panelType
        self.dropDownTable = {}
        self.settingTableManager = CS.Cfg_SettingTableManager.Instance
    end
end

--region 默认刷新面板
function UIConfigPanel_PartBasic:RefreshPanel()
end
--endregion

--region 数据保存和读取
--region 数据存储方法
---SetSlider
function UIConfigPanel_PartBasic:SetSlider(go, SliderName, Go_Enum, callback)
    local go_Slider = self:GetCurComp(go, SliderName, "UISlider")
    if go_Slider ~= nil and CS.StaticUtility.IsNull(go_Slider) == false and Go_Enum ~= nil then
        CS.EventDelegate.Add(go_Slider.onChange, function()
            if self:CheckIsRefresh() == true then
                local number = go_Slider.value
                if callback ~= nil then
                    callback(Go_Enum, number, go_Slider)
                end
            end
        end)
        go_Slider.onDragFinished = function()
            self.Config:SetFloat(Go_Enum, go_Slider.value)
        end
    end
end

---设置滑动节点
function UIConfigPanel_PartBasic:SetSliderPoint(go, SliderName, Go_Enum, pointList, callback)
    local go_Slider = self:GetCurComp(go, SliderName, "UISlider")
    if go_Slider ~= nil and CS.StaticUtility.IsNull(go_Slider) == false and Go_Enum ~= nil then
        go_Slider.numberOfSteps = pointList.Count
        CS.EventDelegate.Add(go_Slider.onChange, function()
            if self:CheckIsRefresh() == true then
                local number = go_Slider.value
                if callback ~= nil then
                    callback(Go_Enum, number, go_Slider)
                end
            end
        end)
        go_Slider.onDragFinished = function()
            self.Config:SetFloat(Go_Enum, go_Slider.value)
        end
    end
end

---SetToogle
function UIConfigPanel_PartBasic:SetToogle(go, ToogleName, Go_Enum, callback, groupId)
    local go_Toogle = self:GetCurComp(go, ToogleName, "UIToggle")
    if go_Toogle ~= nil and CS.StaticUtility.IsNull(go_Toogle) == false and Go_Enum ~= nil then
        go_Toogle.group = groupId
        CS.EventDelegate.Add(go_Toogle.onChange, function()
            if self:CheckIsRefresh() == true then
                self.Config:SetBool(Go_Enum, go_Toogle.value)
                if callback ~= nil then
                    callback(Go_Enum, go_Toogle.value)
                end
            end
        end)
    end
end

---SetDropDown
function UIConfigPanel_PartBasic:SetDropDown(go, PopupListName, Go_Enum, callback)
    local go_PopupListName = self:GetCurComp(go, PopupListName, "Top_UIDropDown")
    if go_PopupListName ~= nil and CS.StaticUtility.IsNull(go_PopupListName) == false and Go_Enum ~= nil then
        if self.attckmodel == go then
            ---@param DropdownData Top_UIDropDownDropdownData
            go_PopupListName.CanItemSelectChange = function(DropdownData, go)
                if DropdownData then
                    if DropdownData.Label == "队伍模式" then
                        return Utility.TryChangeMode(go, 1, 2)
                    elseif DropdownData.Label == "行会模式" then
                        return Utility.TryChangeMode(go, 2, 2)
                    end
                end
                return true
            end
        end

        ---存储设置的按钮
        go_PopupListName.OnValueChange:Add(function(inputValue)
            if self:CheckIsRefresh() == true then
                if self:GetPanelState() == false then
                    return
                end
                local value = self.dropDownTable[go_PopupListName][inputValue.Label]
                if value == nil then
                    return
                end
                self.Config:SetInt(Go_Enum, tonumber(value))
                if callback ~= nil then
                    callback(Go_Enum, tonumber(value))
                end
            end
        end)
    end
end
--endregion

--region 数据获取方法
---GetSlider
function UIConfigPanel_PartBasic:GetSlider(go, SliderName, Go_Enum, callback)
    local go_Slider = self:GetCurComp(go, SliderName, "UISlider")
    if go_Slider ~= nil and CS.StaticUtility.IsNull(go_Slider) == false and Go_Enum ~= nil then
        go_Slider.sliderValue = self.Config:GetFloat(Go_Enum)
        if callback ~= nil then
            callback(Go_Enum, go_Slider.sliderValue)
        end
    end
end

---GetToogle
function UIConfigPanel_PartBasic:GetToogle(go, ToogleName, Go_Enum, callback)
    local go_Toogle = self:GetCurComp(go, ToogleName, "UIToggle")
    if go_Toogle ~= nil and CS.StaticUtility.IsNull(go_Toogle) == false and Go_Enum ~= nil then
        go_Toogle.value = self.Config:GetBool(Go_Enum)
        if callback ~= nil then
            callback(Go_Enum, go_Toogle.value)
        end
    end
end

---GetDropDwon
function UIConfigPanel_PartBasic:GetDropDown(go, PopupListName, Go_Enum, dropDownList, format)
    local go_PopupListName = self:GetCurComp(go, PopupListName, "Top_UIDropDown")
    if go_PopupListName ~= nil and CS.StaticUtility.IsNull(go_PopupListName) == false and dropDownList ~= nil and Go_Enum ~= nil then
        local dropDownValue = self.Config:GetInt(Go_Enum)
        local list = {}
        local dropDownParamsTable = {}
        for i = 0, dropDownList.Length - 1 do
            local name = string.format(format, dropDownList[i])
            if i == 0 or tonumber(dropDownList[i]) == dropDownValue then
                go_PopupListName:SetCaptionLabel(name, "")
            end
            dropDownParamsTable[name] = dropDownList[i]
            table.insert(list, name)
        end
        self.dropDownTable[go_PopupListName] = dropDownParamsTable
        go_PopupListName:SetOptions(list)
    end
end

---GetDropDwon
function UIConfigPanel_PartBasic:GetDropDownByTextTable(go, PopupListName, Go_Enum, dropDownList)
    local go_PopupListName = self:GetCurComp(go, PopupListName, "Top_UIDropDown")
    if go_PopupListName ~= nil and CS.StaticUtility.IsNull(go_PopupListName) == false and dropDownList ~= nil and Go_Enum ~= nil then
        local dropDownValue = self.Config:GetInt(Go_Enum)
        local list = {}
        local dropDownParamsTable = {}
        for i = 0, dropDownList.Length - 1 do
            local name = dropDownList[i]
            if i == 0 or i == dropDownValue then
                go_PopupListName:SetCaptionLabel(name, "")
            end
            dropDownParamsTable[name] = i
            table.insert(list, name)
        end
        self.dropDownTable[go_PopupListName] = dropDownParamsTable
        go_PopupListName:SetOptions(list)
    end
end

---设置自动拾取状态
function UIConfigPanel_PartBasic:SetAutoPickState(go, ToogleName, Go_Enum, callback, groupId)
    ---@type UIToggle
    local go_Toogle = self:GetCurComp(go, ToogleName, "UIToggle")
    if go_Toogle ~= nil and CS.StaticUtility.IsNull(go_Toogle) == false and Go_Enum ~= nil then
        go_Toogle.group = groupId
        CS.EventDelegate.Add(go_Toogle.onChange, function()
            if self:CheckIsRefresh() == true then
                self.Config:SetInt(Go_Enum, go_Toogle.value and 1 or 2)
                if callback ~= nil then
                    callback(Go_Enum, go_Toogle.value)
                end
            end
        end)
    end
end

---获取自动拾取状态
function UIConfigPanel_PartBasic:GetAutoPickState(go, ToogleName, Go_Enum, callback)
    local go_Toogle = self:GetCurComp(go, ToogleName, "UIToggle")
    local state = Utility.IsPlayerAutoPickOpen()
    if go_Toogle ~= nil and CS.StaticUtility.IsNull(go_Toogle) == false and Go_Enum ~= nil then
        go_Toogle.value = state == 1
        if callback ~= nil then
            callback(Go_Enum, go_Toogle.value)
        end
    end
    go_Toogle.gameObject:SetActive(state ~= 3)
end

function UIConfigPanel_PartBasic:SetSlider_UISlider(go_Slider, Go_Enum, callback)
    if go_Slider ~= nil and CS.StaticUtility.IsNull(go_Slider) == false and Go_Enum ~= nil then
        CS.EventDelegate.Add(go_Slider.onChange, function()
            if self:CheckIsRefresh() == true then
                local number = go_Slider.value
                if callback ~= nil then
                    callback(Go_Enum, number, go_Slider)
                end
            end
        end)
        go_Slider.onDragFinished = function()
            self.Config:SetFloat(Go_Enum, go_Slider.value)
        end
    end
end

function UIConfigPanel_PartBasic:GetSliderTwo(go_Slider, Go_Enum, callback)
    if go_Slider ~= nil and CS.StaticUtility.IsNull(go_Slider) == false and Go_Enum ~= nil then
        go_Slider.sliderValue = self.Config:GetFloat(Go_Enum)
        if callback ~= nil then
            callback(Go_Enum, go_Slider.sliderValue, go_Slider)
        end
    end
end
--endregion
--endregion

--region 刷新
---检测是否刷新
function UIConfigPanel_PartBasic:CheckIsRefresh()
    return self.isRefresh
end

---已经刷新结束
function UIConfigPanel_PartBasic:InitRefresh()
    self.updateItem = CS.CSListUpdateMgr.Add(200, nil, function()
        self.isRefresh = true
    end)
end
--endregion

--region 获取面板状态
function UIConfigPanel_PartBasic:GetPanelState()
    if self.panelType == LuaEnumConfigPanelOpenType.BasePanel then
        return self.uiConfigPanel.mInitBasePanel
    elseif self.panelType == LuaEnumConfigPanelOpenType.ShowPanel then
        return self.uiConfigPanel.mInitShowPanel
    elseif self.panelType == LuaEnumConfigPanelOpenType.PickupPanel then
        return self.uiConfigPanel.mInitPickupPanel
    elseif self.panelType == LuaEnumConfigPanelOpenType.ProtectPanel then
        return self.uiConfigPanel.mInitProtectPanel
    end
end
--endregion

function UIConfigPanel_PartBasic:OnDestroy()
    if self.updateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
        self.updateItem = nil
    end
end
return UIConfigPanel_PartBasic