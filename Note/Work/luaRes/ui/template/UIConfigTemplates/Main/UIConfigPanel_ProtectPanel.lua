---@class UIConfigPanel_ProtectPanel:UIConfigPanel_PartBasic
local UIConfigPanel_ProtectPanel = {}

setmetatable(UIConfigPanel_ProtectPanel, luaComponentTemplates.UIConfigPanel_PartBasic)

function UIConfigPanel_ProtectPanel:Init(uiConfigPanel, panelType)
    self:RunBaseFunction("Init", uiConfigPanel)
    self:InitComp()
    self:BindEvents()
end

function UIConfigPanel_ProtectPanel:InitComp()
    ---生命保护
    self.HelpBtn_GameObject = self:Get("protectPanel/helpBtn", "GameObject")
    self.AutoUseItemBar1 = self:Get("protectPanel/protect/AutoUseItem1", "Transform");
    self.AutoUseItemBar2 = self:Get("protectPanel/protect/AutoUseItem2", "Transform");
    self.AutoUseItemBar3 = self:Get("protectPanel/protect/AutoUseItem3", "Transform");
    self.AutoUseItemBar4 = self:Get("protectPanel/protect/AutoUseItem4", "Transform");

    self:InitProtectBar(self.AutoUseItemBar1, CS.EConfigOption.AutoUseItem1, CS.EConfigOption.AutoUseItem1Drag, 1)
    self:InitProtectBar(self.AutoUseItemBar2, CS.EConfigOption.AutoUseItem2, CS.EConfigOption.AutoUseItem2Drag, 2)
    self:InitProtectBar(self.AutoUseItemBar3, CS.EConfigOption.AutoUseItem3, CS.EConfigOption.AutoUseItem3Drag, 3)
    self:InitProtectBar(self.AutoUseItemBar4, CS.EConfigOption.AutoUseItem4, CS.EConfigOption.AutoUseItem4Drag, 4)
end

function UIConfigPanel_ProtectPanel:BindEvents()
    CS.UIEventListener.Get(self.
    HelpBtn_GameObject).onClick = function()
        Utility.ShowHelpPanel({ id = 125 })
    end
end

function UIConfigPanel_ProtectPanel:RefreshPanel()
    ---生命保护
    local itemIdList = {};
    table.insert(itemIdList, self.settingTableManager:GetSettingHpProtectedDropDownList(Utility.EnumToInt(CS.EConfigOption.AutoUseItem1)))
    table.insert(itemIdList, self.settingTableManager:GetSettingHpProtectedDropDownList(Utility.EnumToInt(CS.EConfigOption.AutoUseItem2)))
    table.insert(itemIdList, self.settingTableManager:GetSettingHpProtectedDropDownList(Utility.EnumToInt(CS.EConfigOption.AutoUseItem3)))
    table.insert(itemIdList, self.settingTableManager:GetSettingHpProtectedDropDownList(Utility.EnumToInt(CS.EConfigOption.AutoUseItem4)))

    self.uiConfigPanel.AutoItemUseTable = {}
    self.uiConfigPanel.AutoItemNameList = {}
    for k, v in pairs(itemIdList) do
        if (self.uiConfigPanel.AutoItemUseTable[k] == nil) then
            self.uiConfigPanel.AutoItemUseTable[k] = {};
        end
        if (self.uiConfigPanel.AutoItemNameList[k] == nil) then
            self.uiConfigPanel.AutoItemNameList[k] = {};
        end
        local length = v.Count - 1
        for k1 = 0, length do
            local v1 = v[k1]
            if v1 ~= nil then
                local configId = v1
                local name = self:AnalysisListName(configId)
                self.uiConfigPanel.AutoItemUseTable[k][name] = configId
                table.insert(self.uiConfigPanel.AutoItemNameList[k], name)
            end
        end
    end

    self:RefreshProtectBar(self.AutoUseItemBar1, CS.EConfigOption.AutoUseItem1, CS.EConfigOption.AutoUseItem1Drag, itemIdList[1], 1)
    self:RefreshProtectBar(self.AutoUseItemBar2, CS.EConfigOption.AutoUseItem2, CS.EConfigOption.AutoUseItem2Drag, itemIdList[2], 2)
    self:RefreshProtectBar(self.AutoUseItemBar3, CS.EConfigOption.AutoUseItem3, CS.EConfigOption.AutoUseItem3Drag, itemIdList[3], 3)
    self:RefreshProtectBar(self.AutoUseItemBar4, CS.EConfigOption.AutoUseItem4, CS.EConfigOption.AutoUseItem4Drag, itemIdList[4], 4)
    self:InitRefresh()
end

---生命保护_刷新滑动条
function UIConfigPanel_ProtectPanel:RefreshProtectBar(go, itemEnum, dragEnum, itemList, index)
    local itemUseSlider = self:GetCurComp(go, "Slider", "UISlider")
    local itemUseNumber = self:GetCurComp(go, "Slider/number", "UILabel")
    local itemUsePopList = self:GetCurComp(go, "DropDown", "Top_UIDropDown")

    --itemUsePopList.CaptionName = "无";
    itemUsePopList:SetCaptionLabel("无", "")
    local ConfigId = self.Config:GetInt(itemEnum)
    local length = itemList.Count - 1
    for k = 0, length do
        local v = itemList[k]
        if v ~= nil then
            local configId = v
            if (configId == ConfigId) then
                --itemUsePopList.CaptionName = itemTable.name;
                itemUsePopList:SetCaptionLabel(self:AnalysisListName(configId), "")
            end
        end
    end
    --itemUsePopList.items = UIConfigPanel_Pickup.uiConfigPanel.AutoItemNameList
    itemUsePopList:SetOptions(self.uiConfigPanel.AutoItemNameList[index])

    local number = self.Config:GetInt(dragEnum)
    itemUseSlider.value = number / 100
    itemUseNumber.text = tostring(number) .. "%"
end

--region 生命保护
function UIConfigPanel_ProtectPanel:InitProtectBar(go, itemEnum, dragEnum, index)
    local itemUseSlider = self:GetCurComp(go, "Slider", "UISlider")
    local itemUseNumber = self:GetCurComp(go, "Slider/number", "UILabel")
    local itemUsePopList = self:GetCurComp(go, "DropDown", "Top_UIDropDown")

    self:SetSlider(go, "Slider", dragEnum, function()
        local number = tonumber(string.format("%.0f", itemUseSlider.value * 100))
        itemUseNumber.text = tostring(number) .. "%"
    end)

    --- 自动使用道具的道具改变
    itemUsePopList.OnValueChange:Add(function(inputValue)
        if (self.uiConfigPanel.mInitProtectPanel == false) then
            return
        end
        local configId = self.uiConfigPanel.AutoItemUseTable[index][inputValue.Label]
        local value = 0
        if (configId ~= nil) then
            value = configId;
        end
        self.Config:SetInt(itemEnum, value)
        self:ItemPopList(itemEnum, configId)
    end)
end

function UIConfigPanel_ProtectPanel:SliderDrag(AutoItemType, Value)
    if AutoItemType == CS.EConfigOption.AutoUseItem1Drag then
        --CS.UnityEngine.Debug.LogError("AutoUseItem1Drag")
    elseif AutoItemType == CS.EConfigOption.AutoUseItem2Drag then
        --CS.UnityEngine.Debug.LogError("AutoUseItem2Drag")
    elseif AutoItemType == CS.EConfigOption.AutoUseItem3Drag then
        --CS.UnityEngine.Debug.LogError("AutoUseItem3Drag")
    elseif AutoItemType == CS.EConfigOption.AutoUseItem4Drag then
        --CS.UnityEngine.Debug.LogError("AutoUseItem4Drag")
    end
end

function UIConfigPanel_ProtectPanel:ItemPopList(AutoItemType, itemInfo)
    if AutoItemType == CS.EConfigOption.AutoUseItem1 then
        --CS.UnityEngine.Debug.LogError("AutoUseItem1")
    elseif AutoItemType == CS.EConfigOption.AutoUseItem2 then
        --CS.UnityEngine.Debug.LogError("AutoUseItem2")
    elseif AutoItemType == CS.EConfigOption.AutoUseItem3 then
        --CS.UnityEngine.Debug.LogError("AutoUseItem3")
    elseif AutoItemType == CS.EConfigOption.AutoUseItem4 then
        --CS.UnityEngine.Debug.LogError("AutoUseItem4")
    end
end
--endregion

--region 功能
---解析显示的选项列表的内容
function UIConfigPanel_ProtectPanel:AnalysisListName(id)
    if id == 0 then
        return "无"
    else
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(id)
        if itemInfoIsFind then
            return itemInfo.name
        end
        local isUseAllItemId = CS.Cfg_GlobalTableManager.Instance:CheckIsAllUseDrugGlobalId(id)
        if isUseAllItemId == true then
            local itemTableList = CS.Cfg_GlobalTableManager.Instance:GetAllUseItemTableList()
            if itemTableList.Count > 0 then
                return "所有" .. Utility.GetItemType(itemTableList[0].type, itemTableList[0].subType)
            end
        end
    end
    return ""
end
--endregion

return UIConfigPanel_ProtectPanel