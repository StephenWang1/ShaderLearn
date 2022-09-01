---@class UIReforgedPanel:UIBase 重铸面板
local UIReforgedPanel = {}

--region 模型对象
---@return UIItem
function UIReforgedPanel:GetItemTemplate()
    if self.itemTemplate == nil then
        self.itemTemplate = templatemanager.GetNewTemplate(self.item_GameObject, luaComponentTemplates.UIItem)
    end
    return self.itemTemplate
end

---@return table<UnityEngine.GameObject,UIReforgedPanelTemplates_AttributeTemplate>
function UIReforgedPanel:GetAttributeTemplateList()
    if self.AttributeTemplateList == nil then
        self.AttributeTemplateList = {}
    end
    return self.AttributeTemplateList
end

---@return table<UnityEngine.GameObject,UIReforgedPanelTemplates_MaterialTemplate>
function UIReforgedPanel:GetMaterialTemplateList()
    if self.MaterialTemplateList == nil then
        self.MaterialTemplateList = {}
    end
    return self.MaterialTemplateList
end

---@return table<UnityEngine.GameObject,UIReforgedPanelTemplates_LevelEffect>
function UIReforgedPanel:GetLevelEffectTemplateList()
    if self.LevelEffectTemplateList == nil then
        self.LevelEffectTemplateList = {}
    end
    return self.LevelEffectTemplateList
end

---@return UIRolePanel
function UIReforgedPanel:GetUIRolePanel()
    if self.uiRolePanel == nil then
        local commonData = { equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateRecast, equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateRecast, isShowCloseBtn = false, isShowArrowBtn = false }
        uimanager:CreatePanel("UIRolePanel", function(panel)
            panel:ShowCloseButton(false)
            panel:SetSLToggle(false)
            self.uiRolePanel = panel
        end, commonData)
    end
    return self.uiRolePanel
end

---@return UIRolePanel_EquipTemplateRecast
function UIReforgedPanel:GetUIRolePanelEquipTemplate()
    if self:GetUIRolePanel() ~= nil then
        return self:GetUIRolePanel().equipShow
    end
end
--endregion

--region 初始化
function UIReforgedPanel:Init()
    self:InitComponent()
    self:BindUIEvents()
    self:BindClientEvents()
end

function UIReforgedPanel:InitComponent()
    ---@type UILabel
    self.itemName_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/Background/name", "UILabel")
    ---@type UnityEngine.GameObject
    self.item_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Background/Item", "GameObject")
    ---@type UILabel
    self.recastLevel_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/LevelAttribute/Value", "UILabel")
    ---@type UITable
    self.recastLevel_UITable = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/LevelAttribute", "UITable")
    ---@type UILabel
    self.skillDes_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/AttributeTips/Des", "UILabel")
    ---@type UIGridContainer
    self.attributeList_UIGridContainer = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/ScrollView/otherAttribute", "UIGridContainer")
    ---@type UnityEngine.GameObject
    self.upLevelMaterialList_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition", "GameObject")
    ---@type UIGridContainer
    self.upLevelMaterialList_UIGridContainer = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Grid", "UIGridContainer")
    ---@type UnityEngine.GameObject
    self.upLevelBtn = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Btn_Upgrade", "GameObject")
    ---@type UnityEngine.GameObject
    self.upLevelBtnEffect = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Btn_Upgrade/activeEffect", "GameObject")
    ---@type UISprite
    self.upLevelCoinIcon_UISprite = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/gold/img", "UISprite")
    ---@type UILabel
    self.upLevelCoin_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/gold", "UILabel")
    ---@type UnityEngine.GameObject
    self.helpBtn_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    ---@type UnityEngine.GameObject
    self.closeBtn_GameObject = self:GetCurComp("WidgetRoot/events/Btn_Close", "GameObject")
    ---@type UnityEngine.GameObject
    self.successEffect_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/upEffect", "GameObject")
    ---@type UnityEngine.GameObject
    self.levelEffect = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Level", "GameObject")
    ---@type UISprite
    self.MaxLevelHint = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/maxLevelAttribute/maxSprite", "UISprite")
end

function UIReforgedPanel:BindUIEvents()
    luaclass.UIRefresh:BindClickCallBack(self.closeBtn_GameObject, function()
        uimanager:ClosePanel(self)
    end)
    luaclass.UIRefresh:BindClickCallBack(self.helpBtn_GameObject, function()
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(246)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end)
    luaclass.UIRefresh:BindClickCallBack(self.upLevelBtn, function(go)
        if self.equipIndexRecastInfo ~= nil then
            local popHintTxt = self.equipIndexRecastInfo:CanUpRecastLevel()
            if CS.StaticUtility.IsNullOrEmpty(popHintTxt) == false then
                Utility.ShowPopoTips(go.transform, popHintTxt, 140)
                return
            end
        end
        networkRequest.ReqRecast(self.equipIndex)
    end)
    luaclass.UIRefresh:BindClickCallBack(self.upLevelCoinIcon_UISprite, function()
        if self.upRecastCoinCostItemInfo ~= nil then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.upRecastCoinCostItemInfo, showRight = false })
        end
    end)
end

function UIReforgedPanel:BindClientEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ReforgedRoleGridClick, function(id, gridTemplate)
        self:RefreshPanel(gridTemplate)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ReforgedPanelRefresh, function()
        self:RefreshPanel()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ReforgedResult, function()
        luaclass.UIRefresh:RefreshActive(self.successEffect_GameObject, false)
        luaclass.UIRefresh:RefreshActive(self.successEffect_GameObject, true)
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:OnBagItemChanged()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:OnBagCoinChanged()
    end)
end

function UIReforgedPanel:OnBagItemChanged()
    self:AnalysisBaseData()
    self:RefreshMaterialList()
end

function UIReforgedPanel:OnBagCoinChanged()
    self:AnalysisBaseData()
    self:RefreshCoin()
end
--endregion

--region 刷新
---@class RecastPanelOpenParams 重铸面板打开参数
---@field type LuaEnumRecastType

---@param commonData RecastPanelOpenParams
function UIReforgedPanel:Show(commonData)
    self:AnalysisPanel(commonData)
    self:ChooseDefaultGrid()
end

---@param commonData RecastPanelOpenParams
---@return boolean 解析结果
function UIReforgedPanel:AnalysisPanel(commonData)
    if commonData == nil or commonData.type == nil then
        return false
    end
    return self:RefreshPanel({ equipIndex = commonData.type })
end

---选择角色面板默认装备位
function UIReforgedPanel:ChooseDefaultGrid()
    if self:GetUIRolePanelEquipTemplate() ~= nil and uiStaticParameter.RecastChooseEquipIndex ~= nil then
        self:GetUIRolePanelEquipTemplate():SetItemShowChooseByEquipIndex(uiStaticParameter.RecastChooseEquipIndex)
    end
end

---@param gridTemplate UIRolePanel_GridTemplateBase
function UIReforgedPanel:RefreshPanel(gridTemplate)
    self:AnalysisBaseData(gridTemplate)
    if self.equipIndexRecastInfo ~= nil then
        local haveNextLevel = self.equipIndexRecastInfo:HaveNextLevel()
        luaclass.UIRefresh:RefreshActive(self.upLevelMaterialList_GameObject, haveNextLevel)
        luaclass.UIRefresh:RefreshActive(self.upLevelBtn, haveNextLevel)
        luaclass.UIRefresh:RefreshActive(self.upLevelCoin_UILabel, haveNextLevel)
        luaclass.UIRefresh:RefreshActive(self.MaxLevelHint, haveNextLevel == false)
    end
    self:RefreshChooseItemInfo()
    self:RefreshRecastInfo()
    self:RefreshAttributeList()
    self:RefreshMaterialList()
    self:RefreshCoin()
    self:RefreshLevelEffect()
    self:RefreshMaxLevel()
    self:RefreshBtnEffect()
end

---解析基础数据
---@param gridTemplate UIRolePanel_GridTemplateBase
---@return boolean 解析状态
function UIReforgedPanel:AnalysisBaseData(gridTemplate)
    if gridTemplate ~= nil then
        self.equipIndex = gridTemplate.equipIndex
    end
    self:ResetData()
    if type(self.equipIndex) == 'number' then
        self.bagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(self.equipIndex)
        if self.bagItemInfo ~= nil then
            local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.bagItemInfo.itemId)
            ---@type TABLE.CFG_ITEMS
            self.itemInfo = itemInfo
        end
        self.equipIndexRecastInfo = gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(self.equipIndex)
        if self.equipIndexRecastInfo ~= nil and self.equipIndexRecastInfo.UpRecastCoinCost ~= nil and Utility.GetLuaTableCount(self.equipIndexRecastInfo.UpRecastCoinCost) > 0 then
            local upRecastCoinCostItemInfoIsFind, upRecastCoinCostItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.equipIndexRecastInfo.UpRecastCoinCost[1].itemId)
            if upRecastCoinCostItemInfoIsFind then
                self.upRecastCoinCostItemInfo = upRecastCoinCostItemInfo
            end
        end
    end
end

function UIReforgedPanel:ResetData()
    self.bagItemInfo = nil
    self.itemInfo = nil
    self.equipIndexRecastInfo = nil
end

---刷新选择的道具信息
function UIReforgedPanel:RefreshChooseItemInfo()
    local itemName = ""
    if self.itemInfo ~= nil then
        itemName = self.itemInfo.name
    elseif self.equipIndexRecastInfo ~= nil and self.equipIndexRecastInfo.recastTbl ~= nil then
        itemName = self.equipIndexRecastInfo.recastTbl:GetName()
    end
    luaclass.UIRefresh:RefreshLabel(self.itemName_UILabel, itemName)
    if self:GetItemTemplate() ~= nil then
        if self.itemInfo ~= nil then
            self:GetItemTemplate():RefreshUIWithItemInfo(self.itemInfo)
            luaclass.UIRefresh:BindClickCallBack(self:GetItemTemplate().go, function()
                if self.bagItemInfo ~= nil then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, showRight = false })
                end
            end)
        else
            self:GetItemTemplate():ResetUI()
        end
    end
end

---刷新重铸信息
function UIReforgedPanel:RefreshRecastInfo()
    if self.equipIndexRecastInfo == nil then
        return
    end
    if self.equipIndexRecastInfo.recastLevel ~= nil then
        luaclass.UIRefresh:RefreshLabel(self.recastLevel_UILabel, tostring(self.equipIndexRecastInfo.recastLevel))
        luaclass.UIRefresh:RefreshUITable(self.recastLevel_UITable)
    end
    if self.equipIndexRecastInfo.recastTbl ~= nil and self.equipIndexRecastInfo.recastTbl:GetDesc() ~= nil then
        local skillDes = string.gsub(self.equipIndexRecastInfo.recastTbl:GetDesc(), '\\n', '\n')
        luaclass.UIRefresh:RefreshLabel(self.skillDes_UILabel, skillDes)
    end
end

---刷新属性提升列表
function UIReforgedPanel:RefreshAttributeList()
    if self.equipIndexRecastInfo == nil then
        return
    end
    if type(self.equipIndexRecastInfo.AttributeList) == 'table' and Utility.GetLuaTableCount(self.equipIndexRecastInfo.AttributeList) > 0 then
        luaclass.UIRefresh:RefreshGridContainer(self.attributeList_UIGridContainer, self.equipIndexRecastInfo.AttributeList, function(go, attributeInfo)
            if go == nil or attributeInfo == nil then
                return
            end
            local attributeTemplate = self:GetAttributeTemplateList()[go]
            if attributeTemplate == nil then
                attributeTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIReforgedPanelTemplates_AttributeTemplate)
                self:GetAttributeTemplateList()[go] = attributeTemplate
            end
            attributeTemplate:RefreshPanel(attributeInfo)
        end, true)
    end
end

---刷新材料列表
function UIReforgedPanel:RefreshMaterialList()
    if self.equipIndexRecastInfo == nil then
        return
    end
    if type(self.equipIndexRecastInfo.UpRecastItemCost) == 'table' then
        luaclass.UIRefresh:RefreshGridContainer(self.upLevelMaterialList_UIGridContainer, self.equipIndexRecastInfo.UpRecastItemCost, function(go, materialInfo)
            local materialTemplate = self:GetMaterialTemplateList()[go]
            if materialTemplate == nil then
                materialTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIReforgedPanelTemplates_MaterialTemplate)
                self:GetMaterialTemplateList()[go] = materialTemplate
            end
            materialTemplate:RefreshPanel(materialInfo)
        end)
    end
end

---刷新货币
function UIReforgedPanel:RefreshCoin()
    if self.equipIndexRecastInfo == nil then
        return
    end
    if type(self.equipIndexRecastInfo.UpRecastCoinCost) == 'table' then
        ---@type CostItemInfo
        local upRecastCoinCostInfo = self.equipIndexRecastInfo.UpRecastCoinCost[1]
        if upRecastCoinCostInfo ~= nil then
            local coinItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(upRecastCoinCostInfo.itemId)
            local needMaterialNumber = upRecastCoinCostInfo.costNumber
            local bagMaterialNumber = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(coinItemInfo:GetId())
            luaclass.UIRefresh:RefreshSprite(self.upLevelCoinIcon_UISprite, coinItemInfo:GetId())
            luaclass.UIRefresh:RefreshLabel(self.upLevelCoin_UILabel, CS.Utility_Lua.SetProgressLabelColor(bagMaterialNumber, needMaterialNumber))
        end
    end
    luaclass.UIRefresh:RefreshActive(self.upLevelCoin_UILabel, type(self.equipIndexRecastInfo.UpRecastCoinCost) == 'table' and Utility.GetLuaTableCount(self.equipIndexRecastInfo.UpRecastCoinCost) > 0)
end

---刷新等级特效
function UIReforgedPanel:RefreshLevelEffect()
    local recastLevelEffectInfoList = self.equipIndexRecastInfo:GetRecastLevelEffectInfoList()
    if CS.StaticUtility.IsNull(self.levelEffect) == false and type(recastLevelEffectInfoList) == 'table' then
        local prefabLevelEffectCount = self.levelEffect.transform.childCount
        for k = 0, prefabLevelEffectCount - 1 do
            local levelPrefab = self.levelEffect.transform:GetChild(k)
            if CS.StaticUtility.IsNull(levelPrefab) == false then
                local levelEffectTemplate = self:GetLevelEffectTemplateList()[levelPrefab]
                if levelEffectTemplate == nil then
                    levelEffectTemplate = templatemanager.GetNewTemplate(levelPrefab, luaComponentTemplates.UIReforgedPanelTemplates_LevelEffect)
                    self:GetLevelEffectTemplateList()[levelPrefab] = levelEffectTemplate
                end
                local effectInfo = recastLevelEffectInfoList[k + 1]
                levelEffectTemplate:RefreshPanel(effectInfo)
            end
        end
    end
end

---刷新按钮特效
function UIReforgedPanel:RefreshBtnEffect()
    luaclass.UIRefresh:RefreshActive(self.upLevelBtnEffect, self.equipIndexRecastInfo ~= nil and CS.StaticUtility.IsNullOrEmpty(self.equipIndexRecastInfo:CanUpRecastLevel()))
end

function UIReforgedPanel:RefreshMaxLevel()
    if self.equipIndexRecastInfo == nil then
        return
    end
    if self.equipIndexRecastInfo.recastTbl ~= nil and self.equipIndexRecastInfo.recastTbl:GetUiEffect() ~= nil then
        luaclass.UIRefresh:RefreshSprite(self.MaxLevelHint, self.equipIndexRecastInfo.recastTbl:GetUiEffect(), nil, true)
    end
end
--endregion

function ondestroy()
    uiStaticParameter.RecastChooseEquipIndex = nil
    uimanager:ClosePanel("UIRolePanel")
end
return UIReforgedPanel