local UIItemInfoPanel_Info_LeftTopOperateButtons = {}

setmetatable(UIItemInfoPanel_Info_LeftTopOperateButtons, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
---按钮克隆组件
function UIItemInfoPanel_Info_LeftTopOperateButtons:GetBtns_GridContainer()
    if self.mBtns_GridContainer == nil or CS.StaticUtility.IsNull(self.mBtns_GridContainer) == true then
        self.mBtns_GridContainer = self:Get("ScrollView/btns","UIGridContainer")
    end
    return self.mBtns_GridContainer
end
--endregion

---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_LeftTopOperateButtons:RefreshWithInfo(commonData)
    if self:AnalysisParams(commonData) == false then
        self.go:SetActive(false)
        return
    end
    self:RefreshPanel()
end

---解析参数
function UIItemInfoPanel_Info_LeftTopOperateButtons:AnalysisParams(commonData)
    local tabNum = Utility.GetTableCount(commonData.TabBagItemInfoTable)
    if commonData == nil or commonData.TabBagItemInfoTable == nil or commonData.TabItemInfoTable == nil or tabNum <= 1 then
        return false
    end
    self.bagItemInfo = commonData.bagItemInfo
    self.itemInfo = commonData.itemInfo
    self.TabBagItemInfoTable = commonData.TabBagItemInfoTable
    self.TabItemInfoTable = commonData.TabItemInfoTable
    self.TabDefaultChoose = ternary(self.isRefresh ~= true,commonData.TabDefaultChoose,0)
    self.count = Utility.GetTableCount(self.TabBagItemInfoTable)
    self.tabType = uiStaticParameter.UIItemInfoManager:GetItemType(self.itemInfo)
    self:AnalysisTabIndexTable()
    self.btnTemplateTable = {}
    self.isRefresh = true
    return true
end

---解析页签名字表
function UIItemInfoPanel_Info_LeftTopOperateButtons:AnalysisTabIndexTable()
    self.TabIndexTable = {}
    self.TabNameTable = {}
    if self.TabBagItemInfoTable ~= nil then
        ---key = 0时for循环会把0放到最后一位
        if Utility.IsContainsKey(self.TabBagItemInfoTable,0) then
            table.insert(self.TabIndexTable,0)
        end
        for k,v in pairs(self.TabBagItemInfoTable) do
            if k ~= 0 then
                table.insert(self.TabIndexTable,k)
            end
            self.TabNameTable[k] = Utility.ListChangeTable(CS.Cfg_GlobalTableManager.Instance:GetTabNameList(k))
        end
    end
end

---刷新面板
function UIItemInfoPanel_Info_LeftTopOperateButtons:RefreshPanel()
    self:GetBtns_GridContainer().MaxCount = self.count
    for k = 0,self.count - 1 do
        local btn_Go = self:GetBtns_GridContainer().controlList[k]
        local index = self.TabIndexTable[k + 1]
        local name = self.TabNameTable[index]
        local bagItemInfoTable = self.TabBagItemInfoTable[index]
        local itemInfoTable = self.TabItemInfoTable[index]
        local btnIndex = index
        local TabDefaultChoose = self.TabDefaultChoose
        local template = templatemanager.GetNewTemplate(btn_Go,luaComponentTemplates.UIItemInfoPanel_Info_LeftTopButtonTemplate)
        template:RefreshPanel({index = index,name = name,bagItemInfoTable = bagItemInfoTable,itemInfoTable = itemInfoTable,type = self.tabType,btnIndex = btnIndex,TabDefaultChoose = TabDefaultChoose})
        table.insert(self.btnTemplateTable,template)
    end
end
return UIItemInfoPanel_Info_LeftTopOperateButtons