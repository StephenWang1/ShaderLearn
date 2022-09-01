---@class UIRoleArtifactPanel:UIBase 法宝界面
local UIRoleArtifactPanel = {}

--region 数据
---@type table<number,UIRoleArtifactPanel_SinglePage> 页数据（套装类型==》页签模板）
UIRoleArtifactPanel.PageAndItemsTemplates = nil
---@type table<number,UIRoleArtifactPanel_SingleItem> 物品数据（装备位==》装备模板）
UIRoleArtifactPanel.ItemsTemplates = nil
---@type table<number,table> 当前显示的面板显示基础参数(策划配置参数)(套装类型==》策划表数据)
UIRoleArtifactPanel.PanelBaseParams = nil
---@type LuaEnumMagicEquipSuitType 当前选择的法宝类型
UIRoleArtifactPanel.ChooseType = nil
--endregion

--region 组件
---页签节点
---@return UIGridContainer
function UIRoleArtifactPanel:GetPage_GridContainer()
    if CS.StaticUtility.IsNull(self.Page_GridContainer) then
        self.Page_GridContainer = self:GetCurComp("WidgetRoot/view/ScrollView/BookMarks","UIGridContainer")
    end
    return self.Page_GridContainer
end

---物品列表节点
---@return UIGridContainer
function UIRoleArtifactPanel:GetItems_GridContainer()
    if CS.StaticUtility.IsNull(self.Items_GridContainer) then
        self.Items_GridContainer = self:GetCurComp("WidgetRoot/view/Scroll View/Grild","UIGridContainer")
    end
    return self.Items_GridContainer
end

---关闭按钮
---@return GameObject
function UIRoleArtifactPanel:GetCloseBtn_GameObject()
    if CS.StaticUtility.IsNull(self.CloseBtn_GameObject) then
        self.CloseBtn_GameObject = self:GetCurComp("WidgetRoot/events/btn_close","GameObject")
    end
    return self.CloseBtn_GameObject
end
--endregion

--region 初始化
function UIRoleArtifactPanel:Init()
    self:BindClientEvents()
end

---绑定客户端事件
function UIRoleArtifactPanel:BindClientEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        uimanager:ClosePanel(self)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshAllMagicEquip, function()
        self:Show({ChooseType = self.ChooseType})
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshMagicEquip, function(id,commonData)
        if commonData ~= nil and commonData.equipIndex ~= nil then
            self:RefreshItem(commonData.equipIndex)
        end
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MagicEquipPageClicked, function(id,commonData)
        if commonData == nil or commonData.pageConfigInfo == nil then
            return
        end
        ---@param LuaEnumMagicEquipSuitType
        local suitType = commonData.pageConfigInfo.type
        if suitType ~= nil then
            self.ChooseType = suitType
            self:RefreshItems(suitType)
        end
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BagMagicEquipItemChange, function(id,commonData)
        if commonData ~= nil and commonData.equipIndex ~= nil then
            self:RefreshItem(commonData.equipIndex)
        end
    end)
end
--endregion

--region 刷新
function UIRoleArtifactPanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshPanel()
end

---解析数据
---@param commonData table 通用参数
---@param commonData.ChooseType LuaEnumMagicEquipSuitType 指定跳转的套装类型
---@param commonData.ChooseItem number 指定选择装备
function UIRoleArtifactPanel:AnalysisParams(commonData)
    if self.PanelBaseParams == nil then
        self.PanelBaseParams = {}
    end
    self.PanelBaseParams = self:GetPageParams()
    if self.PanelBaseParams == nil or type(self.PanelBaseParams) ~= 'table' or Utility.GetTableCount(self.PanelBaseParams) <= 0 then
        return false
    end

    ---页签默认选择
    self.ChooseType = Utility.GetTableFirstValue(self.PanelBaseParams).type
    if commonData ~= nil and commonData.ChooseType ~= nil and self:PageIsContainsType(commonData.ChooseType) then
        self.ChooseType = commonData.ChooseType
    end
    return true
end

---面板刷新
function UIRoleArtifactPanel:RefreshPanel()
    self:RefreshAllPage()
    self:RefreshItems(self.ChooseType)
end

---刷新所有的页签
function UIRoleArtifactPanel:RefreshAllPage()
    if self.PanelBaseParams == nil or type(self.PanelBaseParams) ~= 'table' or Utility.GetTableCount(self.PanelBaseParams) <= 0 then
        uimanager:ClsoePanel(self)
        return
    end
    if self.PageAndItemsTemplates == nil then
        self.PageAndItemsTemplates = {}
    end
    if CS.StaticUtility.IsNull(self:GetPage_GridContainer()) == false then
        local pageCount = Utility.GetTableCount(self.PanelBaseParams)
        self:GetPage_GridContainer().MaxCount = pageCount
        local index = 0
        for k,v in pairs(self.PanelBaseParams) do
            ---@type UnityEngine.GameObject
            local obj = self:GetPage_GridContainer().controlList[index]
            local pageConfigInfo = v
            ---@type UIRoleArtifactPanel_SinglePage
            local template = templatemanager.GetNewTemplate(obj,self:GetPageTemplate())
            if template ~= nil then
                template:RefreshPanel({pageConfigInfo = pageConfigInfo,chooseState = pageConfigInfo.type == self.ChooseType})
                self.PageAndItemsTemplates[pageConfigInfo.type] = template
            end
            index = index + 1
        end
    end
end

---刷新物品列表
---@param suitType LuaEnumMagicEquipSuitType 套装类型
function UIRoleArtifactPanel:RefreshItems(suitType)
    local pageConfigInfo = self:GetPageConfigInfo(suitType)
    if pageConfigInfo == nil or pageConfigInfo.suitCount == nil or pageConfigInfo.suitCount <= 0 then
        return
    end
    if self.ItemsTemplates == nil then
        self.ItemsTemplates = {}
    end
    if CS.StaticUtility.IsNull(self:GetItems_GridContainer()) == false then
        self:GetItems_GridContainer().MaxCount = pageConfigInfo.suitCount
        for k = 0,pageConfigInfo.suitCount - 1 do
            ---@type UnityEngine.GameObject
            local obj = self:GetItems_GridContainer().controlList[k]
            local gridIndex = k + 1
            ---@type number 装备位
            local equipIndex = clientTableManager.cfg_magicweaponManager:GetEquipIndexBySuitType(suitType,gridIndex)
            ---@type UIRoleArtifactPanel_SingleItem
            local template = nil
            if self.ItemsTemplates ~= nil and type(self.ItemsTemplates) == 'table' and self.ItemsTemplates[equipIndex] ~= nil then
                template = self.ItemsTemplates[equipIndex]
            else
                template = templatemanager.GetNewTemplate(obj,self:GetItemTemplate())
            end
            if template ~= nil then
                template:RefreshPanel({equipIndex = equipIndex, equipItemData = self:GetSuitItems(equipIndex)})
                self.ItemsTemplates[equipIndex] = template
            end
        end
    end
end

---刷新单个物品
---@param equipIndex number 装备位
function UIRoleArtifactPanel:RefreshItem(equipIndex)
    if self.ItemsTemplates == nil then
        self.ItemsTemplates = {}
    end
    local refreshMagicSuitType = clientTableManager.cfg_magicweaponManager:AnalysisTypeByEquipIndex(equipIndex)
    if type(refreshMagicSuitType) == 'number' and refreshMagicSuitType ~= self.ChooseType then
        return
    end
    ---@type UIRoleArtifactPanel_SingleItem
    local gridTemplate = self.ItemsTemplates[equipIndex]
    if gridTemplate == nil then
        return
    end
    gridTemplate:RefreshPanel({equipIndex = equipIndex,equipItemData = self:GetSuitItems(equipIndex)})
end
--endregion

--region 查询
---当前页签是否有对应的type
---@param suitType LuaEnumMagicEquipSuitType 法宝装备类型
---@return boolean 是否包含
function UIRoleArtifactPanel:PageIsContainsType(suitType)
    if self.PanelBaseParams ~= nil and type(self.PanelBaseParams) == 'table' then
        for k,v in pairs(self.PanelBaseParams) do
            if v.type == suitType then
                return true
            end
        end
    end
    return false
end
--endregion

--region 获取
---获取页数据
---@param suitType LuaEnumMagicEquipSuitType 法宝装备类型
---@return table 策划表数据
function UIRoleArtifactPanel:GetPageConfigInfo(suitType)
    if self.PanelBaseParams ~= nil and type(self.PanelBaseParams) == 'table' then
        return self.PanelBaseParams[suitType]
    end
end
--endregion

--region 重写
---获取显示的页签配置数据
---@return table 需要显示的页签配置数据
function UIRoleArtifactPanel:GetPageParams()
    return LuaGlobalTableDeal:GetMainPlayerCanShowPage()
end

---通过套装类型获取页签参数
---@param suitType LuaEnumMagicEquipSuitType 法宝装备类型
---@return table 套装类型基础数据
function UIRoleArtifactPanel:GetPageParamBySuitType(suitType)
    if self.PanelBaseParams == nil then
        return
    end
    return self.PanelBaseParams[suitType]
end

---获取套装物品列表
---@param equipIndex number 装备位
---@return LuaMagicEquipDataItem 法宝装备信息类
function UIRoleArtifactPanel:GetSuitItems(equipIndex)
    if equipIndex == nil then
        return nil
    end
    return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipItemInfo(equipIndex)
end

---获取页签模板
function UIRoleArtifactPanel:GetPageTemplate()
    return luaComponentTemplates.UIRoleArtifactPanel_SinglePage
end

---获取物品信息刷新模板
function UIRoleArtifactPanel:GetItemTemplate()
    return luaComponentTemplates.UIRoleArtifactPanel_SingleItem
end
--endregion

return UIRoleArtifactPanel