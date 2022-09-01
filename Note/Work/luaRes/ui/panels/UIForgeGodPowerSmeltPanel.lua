---@class UIForgeGodPowerSmeltPanel:UIBase 神炼界面
local UIForgeGodPowerSmeltPanel = {}

local IsNullFunc = CS.StaticUtility.IsNull

---@class 神炼界面选择的面板类型
EForgeGodPowerSmeltSelectPanelType = {
    ---人物
    Role = 1,
    ---背包
    Bag = 2
}

--region 字段属性
---@type UIRolePanel
UIForgeGodPowerSmeltPanel.mRolePanel = nil

---@type EForgeGodPowerSmeltSelectPanelType 当前神炼界面选择的面板类型
UIForgeGodPowerSmeltPanel.NowSelectPanelType = nil

---@type bagV2.BagItemInfo 当前选中的道具目标
UIForgeGodPowerSmeltPanel.ChooseItemInfo = nil

--endregion

--region 组件获取

--region 界面开关以及切换界面的按钮
---关闭界面按钮
function UIForgeGodPowerSmeltPanel:GetBtnClose()
    if self.mGetBtnClose == nil then
        self.mGetBtnClose = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mGetBtnClose
end

---打开背包面板按钮
function UIForgeGodPowerSmeltPanel:GetBtnOpenBagPanel()
    if self.mGetBtnOpenBagPanel == nil then
        self.mGetBtnOpenBagPanel = self:GetCurComp("WidgetRoot/events/btn_bag", "GameObject")
    end
    return self.mGetBtnOpenBagPanel
end

---打开背包面板按钮选中标记
function UIForgeGodPowerSmeltPanel:GetBtnOpenBagPanelCheckMark()
    if self.mGetBtnOpenBagPanelCheckMark == nil then
        self.mGetBtnOpenBagPanelCheckMark = self:GetCurComp("WidgetRoot/events/btn_bag/Checkmark", "GameObject")
    end
    return self.mGetBtnOpenBagPanelCheckMark
end

---打开人物面板按钮
function UIForgeGodPowerSmeltPanel:GetBtnOpenRolePanel()
    if self.mGetBtnOpenRolePanel == nil then
        self.mGetBtnOpenRolePanel = self:GetCurComp("WidgetRoot/events/btn_role", "GameObject")
    end
    return self.mGetBtnOpenRolePanel
end

---打开人物面板按钮选中标记
function UIForgeGodPowerSmeltPanel:GetBtnOpenRolePanelCheckMark()
    if self.mGetBtnOpenRolePanelCheckMark == nil then
        self.mGetBtnOpenRolePanelCheckMark = self:GetCurComp("WidgetRoot/events/btn_role/Checkmark", "GameObject")
    end
    return self.mGetBtnOpenRolePanelCheckMark
end
--endregion

---得到神炼点击按钮
function UIForgeGodPowerSmeltPanel:GetBtn_Smelt()
    if self.mGetBtn_Smelt == nil then
        self.mGetBtn_Smelt = self:GetCurComp("WidgetRoot/events/btn_Smelt", "GameObject")
    end
    return self.mGetBtn_Smelt
end

---得到标题的Label
function UIForgeGodPowerSmeltPanel:GetLabel_Title()
    if self.mGetLabel_Title == nil then
        self.mGetLabel_Title = self:GetCurComp("WidgetRoot/view/Title/name", "Top_UILabel")
    end
    return self.mGetLabel_Title
end

---得到属性加成的根节点
function UIForgeGodPowerSmeltPanel:GetAttributeRoot()
    if self.mGetAttributeRoot == nil then
        self.mGetAttributeRoot = self:GetCurComp("WidgetRoot/view/Attribute", "GameObject")
    end
    return self.mGetAttributeRoot
end

---得到等级进度的根节点
function UIForgeGodPowerSmeltPanel:GetLvProcessRoot()
    if self.mGetLvProcessRoot == nil then
        self.mGetLvProcessRoot = self:GetCurComp("WidgetRoot/view/lv_bg", "GameObject")
    end
    return self.mGetLvProcessRoot
end

---得到等级进度的文本
function UIForgeGodPowerSmeltPanel:GetLvProcessLabel()
    if self.mGetLvProcessLabel == nil then
        self.mGetLvProcessLabel = self:GetCurComp("WidgetRoot/view/lv_bg/lv", "Top_UILabel")
    end
    return self.mGetLvProcessLabel
end

---得到材料花费的根节点
function UIForgeGodPowerSmeltPanel:GetCostMaterialRoot()
    if self.mGetCostMaterialRoot == nil then
        self.mGetCostMaterialRoot = self:GetCurComp("WidgetRoot/view/Cost", "GameObject")
    end
    return self.mGetCostMaterialRoot
end

---花费列表的Grid类
function UIForgeGodPowerSmeltPanel:GetCostMaterialGridContainer()
    if self.mGetCostMaterialGridContainer == nil then
        self.mGetCostMaterialGridContainer = self:GetCurComp("WidgetRoot/view/Cost/ScrollView/Grid", "Top_UIGridContainer")
    end
    return self.mGetCostMaterialGridContainer
end

---得到添加经验的添加文本
function UIForgeGodPowerSmeltPanel:GetAddExpValueLabel()
    if self.mGetAddExpValueLabel == nil then
        self.mGetAddExpValueLabel = self:GetCurComp("WidgetRoot/view/lv_bg/expaddvalue", "Top_UILabel")
    end
    return self.mGetAddExpValueLabel
end

---得到当前经验的进度条图片
function UIForgeGodPowerSmeltPanel:GetAddExpValueSlider()
    if self.mGetAddExpValueSlider == nil then
        self.mGetAddExpValueSlider = self:GetCurComp("WidgetRoot/view/lv_bg/roleexp", "Top_UISprite")
    end
    return self.mGetAddExpValueSlider
end

---得到当前经验的进度条图片动画
function UIForgeGodPowerSmeltPanel:GetAddExpValueSliderTween()
    if self.mGetAddExpValueSliderTween == nil then
        self.mGetAddExpValueSliderTween = self:GetCurComp("WidgetRoot/view/lv_bg/roleexp", "Top_FillTween")
    end
    return self.mGetAddExpValueSliderTween
end

---得到当前增长经验的进度条图片
function UIForgeGodPowerSmeltPanel:GetAddExpAddValueSlider()
    if self.mGetAddExpAddValueSlider == nil then
        self.mGetAddExpAddValueSlider = self:GetCurComp("WidgetRoot/view/lv_bg/roleexpTemp", "Top_UISprite")
    end
    return self.mGetAddExpAddValueSlider
end

---得到神力装备属性变动GridContainer
function UIForgeGodPowerSmeltPanel:GetAttributeUpdateGridContainer()
    if self.mGetAttributeUpdateGridContainer == nil then
        self.mGetAttributeUpdateGridContainer = self:GetCurComp("WidgetRoot/view/Attribute/ScrollView/Grid", "Top_UIGridContainer")
    end
    return self.mGetAttributeUpdateGridContainer
end

---得到没有选择目标的时候,显示的艺术字
function UIForgeGodPowerSmeltPanel:GetChooseItemText()
    if self.mGetChooseItemText == nil then
        self.mGetChooseItemText = self:GetCurComp("WidgetRoot/view/ChooseItemText", "GameObject")
    end
    return self.mGetChooseItemText
end

---得到没有材料的情况下,显示的艺术字
function UIForgeGodPowerSmeltPanel:GetNoMaterialsText()
    if self.mGetNoMaterialsText == nil then
        self.mGetNoMaterialsText = self:GetCurComp("WidgetRoot/view/NoMaterialsText", "GameObject")
    end
    return self.mGetNoMaterialsText
end

---得到没有材料的情况下,显示的艺术字
function UIForgeGodPowerSmeltPanel:GetLevelMaxText()
    if self.mGetLevelMaxText == nil then
        self.mGetLevelMaxText = self:GetCurComp("WidgetRoot/view/LevelMax", "GameObject")
    end
    return self.mGetLevelMaxText
end

---得到目标道具模板的GameObject
function UIForgeGodPowerSmeltPanel:GetTargetItemTempGameObject()
    if self.mGetTargetItemTempGameObject == nil then
        self.mGetTargetItemTempGameObject = self:GetCurComp("WidgetRoot/view/itemTemplate", "GameObject")
    end
    return self.mGetTargetItemTempGameObject
end

function UIForgeGodPowerSmeltPanel:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

function UIForgeGodPowerSmeltPanel:GetEffectRoot_GameObject()
    if (self.mGetEffectRoot_GameObject == nil) then
        self.mGetEffectRoot_GameObject = self:GetCurComp("WidgetRoot/view/itemTemplate/effect", "GameObject");
    end
    return self.mGetEffectRoot_GameObject;
end


--endregion

function UIForgeGodPowerSmeltPanel:Init()
    self:BindUIEvent()
    self:BindMsgEvent()
    self:SetTarget(nil)
end

---绑定UI的点击事件
function UIForgeGodPowerSmeltPanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetBtnClose()).onClick = function()
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetBtnOpenBagPanel()).onClick = function()
        self:ChoosePanel(EForgeGodPowerSmeltSelectPanelType.Bag)
    end

    CS.UIEventListener.Get(self:GetBtnOpenRolePanel()).onClick = function()
        self:ChoosePanel(EForgeGodPowerSmeltSelectPanelType.Role)
    end

    CS.UIEventListener.Get(self:GetBtn_Smelt()).onClick = function()
        self:OnClickBtn_Smelt();
    end

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(181);
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
        end
    end
end

function UIForgeGodPowerSmeltPanel:BindMsgEvent()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GridSingleClicked, function(magID, bagItemInfo)
        self:SetTarget(bagItemInfo)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RoleForgeGodPowerSmeltItemClicked, function(magID, bagItemInfo)
        self:SetTarget(bagItemInfo)
    end)

    UIForgeGodPowerSmeltPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, function()
        self:OnResBagChangeMessage();
    end)
    --为了在神炼界面打开的时候,角色界面不能切换到普通装备界面
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ChangeRoleDivineState, function(magID)
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelChangeSLPage, function(magID)
        ---切换神力页签的时候,重置目标
        self:SetTarget(nil)
    end)

    self.CallOnMainChatBagButtonClick = function()
        self:ChoosePanel(EForgeGodPowerSmeltSelectPanelType.Bag)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CallOnMainChatBagButtonClick)

    --self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDivineSmeltMessage, self.OnResDivineSmeltMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDivineSmeltMessage, function(magID, tableData)
        ---切换神力页签的时候,重置目标
        self:OnResDivineSmeltMessage(magID, tableData)
    end)
end

function UIForgeGodPowerSmeltPanel:Show(data)
    if (data ~= nil) then
        self.NowSelectPanelType = data.type
    end

    --设置模板选中的装备选中面板
    if (self.NowSelectPanelType == nil) then
        self.NowSelectPanelType = EForgeGodPowerSmeltSelectPanelType.Role
    end

    self:ChoosePanel(self.NowSelectPanelType)
end


--region 附带面板的切换
---@param type EForgeGodPowerSmeltSelectPanelType 选择打开的界面
function UIForgeGodPowerSmeltPanel:ChoosePanel(type)
    self.NowSelectPanelType = type
    self:ChooseRolePanel(type == EForgeGodPowerSmeltSelectPanelType.Role);
    self:ChooseBagPanel(type == EForgeGodPowerSmeltSelectPanelType.Bag);
    self:SetTarget(nil)
end

---选中角色界面
function UIForgeGodPowerSmeltPanel:ChooseRolePanel(open)
    self:GetBtnOpenRolePanelCheckMark():SetActive(open);
    if (open) then
        if self.mRolePanel == nil or IsNullFunc(self.mRolePanel.go) then
            local panelName = "UIRolePanel"
            ---@type RolePanelParam
            local data = {}
            data.openSourceType = LuaEnumPanelOpenSourceType.ByForgeGodPowerSmelt
            data.mSLSuitPanelTemplate = luaComponentTemplates.UIRolePanel_SLSuitPanel_DivineSmeltTemplate
            uimanager:CreatePanel(panelName, function(panel)
                self.mRolePanel = panel
                self:TryAddOpenPanel(panelName)
                self:AfterOpenRolePanel()
            end, data)
        else
            uimanager:ReShowPanel(self.mRolePanel)
        end
    else
        if (self.mRolePanel ~= nil) then
            uimanager:HidePanel(self.mRolePanel)
        end
    end
end

function UIForgeGodPowerSmeltPanel:AfterOpenRolePanel()
    if self:HasRolePanel() then
        self.mRolePanel:SetSLToggle(false)
        ---@type LuaMainPlayerEquipMgr
        local MainPlayerEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
        if (MainPlayerEquipMgr.IsShowForgeGodPowerSmeltRedState) then
            --得到红点的页签
            local redIndex = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr().IsShowForgeGodPowerSmeltRedEquipIndex;
            local redType = Utility.IsSLEquip(redIndex, true)
            self.mRolePanel:SwitchSuitPage(redType)
        else
            self.mRolePanel:SwitchSuitPage(LuaEquipmentListType.SLSuit_JIYI)
        end

        self.mRolePanel:ShowCloseButton(false)

        ---@type UIRolePanel_SLSuitPanel_DivineSmeltTemplate
        local SLSuitPanel_DivineSmeltTemplate = self.mRolePanel.SLSuitPanelTemplate
        if (SLSuitPanel_DivineSmeltTemplate ~= nil) then
            SLSuitPanel_DivineSmeltTemplate:SetDefaultForgetGodPowerSelect()
        end
    end
end

function UIForgeGodPowerSmeltPanel:HasRolePanel()
    if self.mRolePanel and CS.StaticUtility.IsNull(self.mRolePanel.go) == false then
        return true
    end
    return false
end

---刷新角色界面选中状态
function UIForgeGodPowerSmeltPanel:UpdateRolePanel()
    if self:HasRolePanel() then
        ---@type UIRolePanel_SLSuitPanel_DivineSmeltTemplate
        local template = self.mRolePanel.SLSuitPanelTemplate
        template:SetCurrentChooseItem(self.ChooseItemInfo)
    end
end

---选中背包界面
function UIForgeGodPowerSmeltPanel:ChooseBagPanel(open)
    self:GetBtnOpenBagPanelCheckMark():SetActive(open);
    if (open) then
        if self.mBagPanel == nil or IsNullFunc(self.mBagPanel.go) then
            local panelName = "UIBagPanel"
            ---@type UIBagPanelInputParam
            local data = {}
            data.openSourceType = LuaEnumPanelOpenSourceType.ByForgeGodPowerSmelt
            data.type = LuaEnumBagType.ForgeBloodSmelt
            --data.focusedBagItemInfo = self:GetBagNeedChooseItem()
            uimanager:CreatePanel(panelName, function(panel)
                self.mBagPanel = panel
                self:TryAddOpenPanel(panelName)
            end, data)
        else
            uimanager:ReShowPanel(self.mBagPanel)
        end
    else
        if (self.mBagPanel ~= nil) then
            uimanager:HidePanel(self.mBagPanel)
        end
    end
end

---添加打开界面
function UIForgeGodPowerSmeltPanel:TryAddOpenPanel(panelName)
    if self.mAllOpenPanel == nil then
        self.mAllOpenPanel = {}
    end
    table.insert(self.mAllOpenPanel, panelName)
end
--endregion

---背包变动了
function UIForgeGodPowerSmeltPanel:OnResBagChangeMessage(msgId, tblData)
    if (self.ChooseItemInfo == nil) then
        return
    end
    -----@type LuaMainPlayerBagMgr
    --local MainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    --local chooseItem = MainPlayerBagMgr:GetBagItemData(self.ChooseItemInfo.lid)
    if (self.ChooseItemInfo == nil) then
        self:SetTarget(nil)
    else
        self:UpdateCanCostItemContainer(self.ChooseItemInfo)
    end

    ---@type UIRolePanel
    local rolePanel = uimanager:GetPanel("UIRolePanel")
    if (rolePanel and rolePanel.SLSuitPanelTemplate) then
        rolePanel.SLSuitPanelTemplate:CallGridRed()
    end
end


--region 神炼目标数据的处理

---@type TABLE.cfg_divinelevelup
UIForgeGodPowerSmeltPanel.TargetDivineLevelUpTbl = nil

---下级道具
---@type TABLE.cfg_items
UIForgeGodPowerSmeltPanel.NextDivineItemTbl = nil

---下级道具的神力合成表
---@type TABLE.cfg_divinelevelup
UIForgeGodPowerSmeltPanel.NextDivineLevelUpTbl = nil

---@type ForgeGodPowerSmeltTargetItemTemp
UIForgeGodPowerSmeltPanel.TargetItemTemp = nil

---@type table<bagV2.BagItemInfo>
UIForgeGodPowerSmeltPanel.CanCostItemList = nil

---神炼的消耗面板的道具模板
---@type table<ForgeGodPowerSmeltCostItemTemp>
UIForgeGodPowerSmeltPanel.ForgetGodPowerSmeltCostItemTempDic = nil

---消耗的道具能增加的经验
UIForgeGodPowerSmeltPanel.CostItemCanAddExp = nil

---设置神炼目标
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeGodPowerSmeltPanel:SetTarget(bagItemInfo)
    if bagItemInfo == nil or self.ChooseItemInfo == nil or bagItemInfo.lid ~= self.ChooseItemInfo.lid then
        self:SetCurrentPlayingTween(false)
    end

    self.ChooseItemInfo = bagItemInfo;
    if (self.mRolePanel ~= nil) then
        ---@type UIRolePanel_SLSuitPanel_DivineSmeltTemplate
        local SLSuitPanel_DivineSmeltTemplate = self.mRolePanel.SLSuitPanelTemplate
        if (SLSuitPanel_DivineSmeltTemplate ~= nil) then
            SLSuitPanel_DivineSmeltTemplate:SetCurrentChooseItem(bagItemInfo)
        end
    end

    self:Reset(bagItemInfo == nil)
    --更新目标
    self:UpdateTargetItemTemp(bagItemInfo);

    self:UpdateAttributeUpdateGridContainer(bagItemInfo, self.NextDivineItemTbl);
    --更新获取到的能被消耗的材料面板
    self:UpdateCanCostItemContainer(bagItemInfo);

    self:UpdateLevelProcess(bagItemInfo)

    self:UpdateRolePanel()
end

---更新目标ICON的显示
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeGodPowerSmeltPanel:UpdateTargetItemTemp(bagItemInfo)
    if (self.TargetItemTemp == nil) then
        self.TargetItemTemp = templatemanager.GetNewTemplate(self:GetTargetItemTempGameObject(), luaComponentTemplates.ForgeGodPowerSmeltTargetItemTemp)
    end

    luaEventManager.DoCallback(LuaCEvent.ChangeForgeGodPowerTarget, bagItemInfo);
    if (bagItemInfo ~= nil) then
        self.TargetDivineLevelUpTbl = clientTableManager.cfg_divinelevelupManager:TryGetValue(bagItemInfo.itemId)
        if (self.TargetDivineLevelUpTbl == nil) then
            CS.UnityEngine.Debug.LogError("没有在cfg_divinelevelup表里面找到:" .. tostring(bagItemInfo.itemId));
            return
        end
        if (self.TargetDivineLevelUpTbl:GetNextId() == nil or self.TargetDivineLevelUpTbl:GetNextId() == 0) then
            ---下一级,如果没有拿到,说明已经到最高级了
            self.NextDivineItemTbl = nil
            self.NextDivineLevelUpTbl = nil
        else
            self.NextDivineItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.TargetDivineLevelUpTbl:GetNextId())
            self.NextDivineLevelUpTbl = clientTableManager.cfg_divinelevelupManager:TryGetValue(self.TargetDivineLevelUpTbl:GetNextId())
        end
    else
        self.NextDivineItemTbl = nil
        self.NextDivineLevelUpTbl = nil
    end
    self.TargetItemTemp:UpdateData(self.NextDivineItemTbl)
end

--region 神炼属性

---更新下级的属性
---@param bagItemInfo bagV2.BagItemInfo
---@param nexItemTbl TABLE.cfg_items
function UIForgeGodPowerSmeltPanel:UpdateAttributeUpdateGridContainer(bagItemInfo, nexItemTbl)
    if (bagItemInfo == nil) then
        return
    end
    if (nexItemTbl == nil) then
        self:GetLevelMaxText():SetActive(true)
        self:GetLvProcessRoot():SetActive(false)
        self:GetAttributeRoot():SetActive(false)
        self:GetBtn_Smelt():SetActive(false)
        self:GetCostMaterialRoot():SetActive(false)
        return
    end
    self:GetLevelMaxText():SetActive(false)

    self:GetLabel_Title().text = nexItemTbl:GetName()

    local sex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    local selectItemAttributeDic = Utility.GetItemAttributesByItemTable(Utility.GetItemTblByBagItemInfo(bagItemInfo), sex)
    local nextItemAttributeDic = Utility.GetItemAttributesByItemTable(self.NextDivineItemTbl, sex)

    local moreAttributeDic = nil
    if (#selectItemAttributeDic > #nextItemAttributeDic) then
        moreAttributeDic = selectItemAttributeDic
    else
        moreAttributeDic = nextItemAttributeDic
    end
    local index = 0
    self:GetAttributeUpdateGridContainer().MaxCount = Utility.GetTableCount(moreAttributeDic)
    for type, v in pairs(moreAttributeDic) do
        if (selectItemAttributeDic[type] == nextItemAttributeDic[type]) then
            self:GetAttributeUpdateGridContainer().MaxCount = self:GetAttributeUpdateGridContainer().MaxCount - 1
        else
            local go = self:GetAttributeUpdateGridContainer().controlList[index]
            self:RefreshSingleAttribute(go, type, selectItemAttributeDic[type], nextItemAttributeDic[type])
            index = index + 1
        end
    end
end

---@param go UnityEngine.GameObject
function UIForgeGodPowerSmeltPanel:RefreshSingleAttribute(go, type, leftValue, rightValue)
    if IsNullFunc(go) then
        return
    end
    if (leftValue == nil) then
        leftValue = 0
    end
    local nameLaebl = CS.Utility_Lua.Get(go.transform, "cur/value", "UILabel")
    local currAtrLaebl = CS.Utility_Lua.Get(go.transform, "curarribute/value", "UILabel")
    local nextAtrLabel = CS.Utility_Lua.Get(go.transform, "nextarribute/value", "UILabel")
    local upSprite = CS.Utility_Lua.Get(go.transform, "Up", "GameObject")
    if IsNullFunc(nameLaebl) == false then
        upSprite:SetActive(leftValue < rightValue)
    end
    if IsNullFunc(nameLaebl) == false then
        nameLaebl.text = Utility.GetItemAttribute(type)
    end
    if IsNullFunc(currAtrLaebl) == false then
        currAtrLaebl.text = leftValue
    end
    if IsNullFunc(nextAtrLabel) == false then
        nextAtrLabel.text = rightValue
    end
end
--endregion

--region 神炼消耗的材料
---更新获取到的能被消耗的材料
function UIForgeGodPowerSmeltPanel:GetCanCostItemList(bagItemInfo)
    if (bagItemInfo == nil or self.TargetDivineLevelUpTbl == nil or self.NextDivineItemTbl == nil) then
        return
    end

    local SearchItemTypeItems = self:GetCanCostType(self.TargetDivineLevelUpTbl)

    ---@type LuaMainPlayerBagMgr
    local LuaMainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()

    ---@return table<bagV2.BagItemInfo>
    local items = LuaMainPlayerBagMgr:GetItemListByTypes(SearchItemTypeItems);

    --现在只是获取到了所有这个指定类型的道具,但是要判定是否满足套装需求
    local divineSuitList = self:GetCanDivineId(self.TargetDivineLevelUpTbl)
    local CanCostItemList = {}
    for i, v in pairs(items) do
        ---@type bagV2.BagItemInfo
        local item = v;
        if (item.lid ~= bagItemInfo.lid) then
            ---@type TABLE.cfg_items
            local itemTbl = Utility.GetItemTblByBagItemInfo(item)
            if (itemTbl:GetDivineId() == nil or itemTbl:GetDivineId() == 0) then
                table.insert(CanCostItemList, v)
            else
                for divineSuitIdIndex, divineSuitId in pairs(divineSuitList) do
                    if (itemTbl:GetDivineId() == divineSuitId) then
                        table.insert(CanCostItemList, v)
                    end
                end
            end
        end
    end
    self:GetNoMaterialsText():SetActive(#CanCostItemList == 0)
    return CanCostItemList
end

---得到可以被消耗的道具类型
---@param DivineLevelUpTbl TABLE.cfg_divinelevelup
function UIForgeGodPowerSmeltPanel:GetCanCostType(DivineLevelUpTbl)
    ---@type table<SearchItemTypeItem>
    local SearchItemTypeItems = {}
    if (DivineLevelUpTbl == nil or DivineLevelUpTbl:GetCostType() == nil) then
        return SearchItemTypeItems
    end

    local configType = DivineLevelUpTbl:GetCostType().list
    for i, v in pairs(configType) do
        ---@type SearchItemTypeItem
        local typeItem = {}
        typeItem.type = v.list[1]
        typeItem.subType = v.list[2]

        table.insert(SearchItemTypeItems, typeItem)
    end
    return SearchItemTypeItems
end

---得到可以被消耗的套装
---@param DivineLevelUpTbl TABLE.cfg_divinelevelup
function UIForgeGodPowerSmeltPanel:GetCanDivineId(DivineLevelUpTbl)
    ---@type table<number>
    local divineSuitList = {}
    if (DivineLevelUpTbl == nil or DivineLevelUpTbl:GetCostDivineId() == nil) then
        return divineSuitList
    end

    local configType = DivineLevelUpTbl:GetCostDivineId().list
    for i, v in pairs(configType) do
        table.insert(divineSuitList, v)
    end
    return divineSuitList
end

---@param bagItemInfo bagV2.BagItemInfo
function UIForgeGodPowerSmeltPanel:UpdateCanCostItemContainer(bagItemInfo)
    if (bagItemInfo == nil) then
        return ;
    end
    ---@type table<bagV2.BagItemInfo>
    self.CanCostItemList = self:GetCanCostItemList(bagItemInfo)
    if (self.CanCostItemList == nil) then
        return ;
    end

    self:GetCostMaterialGridContainer().MaxCount = #self.CanCostItemList

    if (self.ForgetGodPowerSmeltCostItemTempDic == nil) then
        self.ForgetGodPowerSmeltCostItemTempDic = {}
    end
    self:ResetCostItemCanAddExp()
    --最大的经验上限
    local maxExpLimit = self.TargetDivineLevelUpTbl:GetNeedExp()
    for i = 1, self:GetCostMaterialGridContainer().MaxCount do
        local obj = self:GetCostMaterialGridContainer().controlList[i - 1]
        ---@type ForgeGodPowerSmeltCostItemTemp
        local template = self.ForgetGodPowerSmeltCostItemTempDic[obj]
        if (template == nil) then
            template = templatemanager.GetNewTemplate(obj, self:GetForgetGodPowerSmeltCostItemTemp(), self)
            self.ForgetGodPowerSmeltCostItemTempDic[obj] = template
        end

        local info = self.CanCostItemList[i]
        template:UpdateItem(info)
        --local nowExp = self.ChooseItemInfo.exp
        template:Select(false)
    end
end

function UIForgeGodPowerSmeltPanel:GetForgetGodPowerSmeltCostItemTemp()
    return luaComponentTemplates.ForgeGodPowerSmeltCostItemTemp
end

function UIForgeGodPowerSmeltPanel:ResetCostItemCanAddExp()
    self.CostItemCanAddExp = 0
end

---在消耗道具的模板中调用进来,用来在界面更新显示
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeGodPowerSmeltPanel:OnClickCostItemTempOnUpdateLevel(isAdd, bagItemInfo)
    local exp = Utility.GetItemTblByBagItemInfo(bagItemInfo):GetDivineExp()
    if (isAdd) then
        self.CostItemCanAddExp = self.CostItemCanAddExp + exp
    else
        self.CostItemCanAddExp = self.CostItemCanAddExp - exp
    end
    self:UpdateLevelProcess(bagItemInfo)
end

---更新获取到的能被消耗的材料
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeGodPowerSmeltPanel:UpdateLevelProcess(bagItemInfo)
    if (bagItemInfo == nil or self.TargetDivineLevelUpTbl == nil) then
        return ;
    end
    --最大的经验上限
    local maxExpLimit = self.TargetDivineLevelUpTbl:GetNeedExp()

    local nowExp = self.ChooseItemInfo.exp
    if (self.CostItemCanAddExp > 0) then
        self:GetAddExpValueLabel().text = "+" .. tostring(self.CostItemCanAddExp)
    else
        self:GetAddExpValueLabel().text = ""
    end

    local rate = (nowExp + self.CostItemCanAddExp) / maxExpLimit
    -- self:GetAddExpAddValueSlider().fillAmount = rate
    self.mCurrentExpRate = rate
    if self:GetCurrentTweenState() == false then
        self:GetAddExpValueSlider().fillAmount = nowExp / maxExpLimit
        self:GetAddExpAddValueSlider().fillAmount = rate
    end

    self:GetLvProcessLabel().text = "神炼进度:" .. tostring(nowExp) .. "/" .. tostring(maxExpLimit)
end

--endregion

--region 请求神炼

---点击神炼
function UIForgeGodPowerSmeltPanel:OnClickBtn_Smelt()
    if (self.ChooseItemInfo == nil) then
        return
    end
    ---非神力法宝,需要先进行判定法宝等级是否足够
    if (Utility.GetItemTblByBagItemInfo(self.ChooseItemInfo):GetSubType() ~= LuaEquipmentItemType.POS_SL_FABAO) then
        local nowLevel = Utility.GetDivineSuitTblByBagItemInfo(self.ChooseItemInfo):GetLevel()
        local NowFBLevel = self:GetNowFBLevel()
        if (NowFBLevel <= nowLevel) then
            Utility.ShowPopoTips(self:GetBtn_Smelt().transform, "请先将法宝升至" .. tostring(nowLevel + 1) .. "阶", 7, "UIForgeGodPowerSmeltPanel")
            return
        end
    end

    local costItemIdList = {}

    for i = 1, self:GetCostMaterialGridContainer().MaxCount do
        local obj = self:GetCostMaterialGridContainer().controlList[i - 1]
        ---@type ForgeGodPowerSmeltCostItemTemp
        local template = self.ForgetGodPowerSmeltCostItemTempDic[obj]
        if (template ~= nil and template.IsBeSelect and template.BagItemInfo ~= nil) then
            table.insert(costItemIdList, template.BagItemInfo.lid)
        end
    end

    if (#costItemIdList == 0) then
        Utility.ShowPopoTips(self:GetBtn_Smelt().transform, "还未选中神炼材料", 7, "UIForgeGodPowerSmeltPanel")
        return
    end
    --说明目标在背包中
    if (self.ChooseItemInfo.index == nil or self.ChooseItemInfo.index == 0) then
        networkRequest.ReqDivineSmelt(self.ChooseItemInfo.lid, costItemIdList)
    else
        networkRequest.ReqDivineSmelt(-self.ChooseItemInfo.index, costItemIdList)
    end
end

function UIForgeGodPowerSmeltPanel:GetNowFBLevel()
    if (self.ChooseItemInfo == nil) then
        return 0
    end
    ---@type TABLE.cfg_divinesuit
    local DivineSuitTbl = Utility.GetDivineSuitTblByBagItemInfo(self.ChooseItemInfo)
    local nowType = 0
    local nowSubType = 1
    if (DivineSuitTbl ~= nil) then
        nowType = DivineSuitTbl:GetType()
        nowSubType = DivineSuitTbl:GetSubType()
    end
    local fbIndex = Utility.GetSLEquipIndex(nowType, LuaEquipmentItemType.POS_SL_FABAO)
    ---@type LuaMainPlayerEquipMgr
    local MainPlayerEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
    ---@type LuaEquipDataItem
    local LuaEquipDataItem = MainPlayerEquipMgr:GetEquipmentList(nowType, nowSubType):GetEquipItem(fbIndex)
    if (LuaEquipDataItem ~= nil and LuaEquipDataItem.BagItemInfo ~= nil) then
        local fbLevel = Utility.GetDivineSuitTblByBagItemInfo(LuaEquipDataItem.BagItemInfo):GetLevel()
        return fbLevel
    end
    return 0
end

--endregion

--region 神炼结果

---@param tblData bagV2.ResDivineSmelt
function UIForgeGodPowerSmeltPanel:OnResDivineSmeltMessage(msgId, tblData)
    ---@type bagV2.BagItemInfo lua
    local bagItemInfo = tblData.item
    if (bagItemInfo == nil) then
        return ;
    end
    bagItemInfo.index = tblData.index

    self:TryPlaySmeltTween(bagItemInfo)

    self:SetTarget(bagItemInfo);
    self:ShowWinEffect()
    --self:GetAddExpValueSliderTween():
end
---显示成功特效
function UIForgeGodPowerSmeltPanel:ShowWinEffect()
    if self.mWinEffect == nil then
        if not CS.StaticUtility.IsNull(self:GetEffectRoot_GameObject()) then
            CS.CSResourceManager.Singleton:AddQueueCannotDelete("700008", CS.ResourceType.UIEffect, function(res)
                if res ~= nil then
                    if CS.StaticUtility.IsNull(self:GetEffectRoot_GameObject()) then
                        return
                    end
                    self.winEffectPool = res:GetUIPoolItem()
                    if self.winEffectPool == nil then
                        return
                    end
                    self.mWinEffect = self.winEffectPool.go
                    if self.mWinEffect then
                        self.mWinEffect.transform.parent = self:GetEffectRoot_GameObject().transform
                        self.mWinEffect.transform.localPosition = CS.UnityEngine.Vector3.zero
                        self.mWinEffect.transform.localScale = CS.UnityEngine.Vector3(125, 125, 125)
                        self.mWinEffect:SetActive(true)
                    end
                end
            end
            , CS.ResourceAssistType.UI)
        end
    else
        self.mWinEffect:SetActive(false)
        self.mWinEffect:SetActive(true)
    end
end
--endregion

--endregion

---重置面板(当没有选中目标的时候的情况)
function UIForgeGodPowerSmeltPanel:Reset(isReset)
    self:GetLabel_Title().text = ""
    self:GetLvProcessRoot():SetActive(not isReset)
    self:GetAttributeRoot():SetActive(not isReset)
    self:GetCostMaterialRoot():SetActive(not isReset)
    self:GetBtn_Smelt():SetActive(not isReset)
    self:GetChooseItemText():SetActive(isReset)
    self:GetNoMaterialsText():SetActive(false)
    self:GetLevelMaxText():SetActive(false)
    self.CostItemCanAddExp = 0
end

--region 升级动画
function UIForgeGodPowerSmeltPanel:TryPlaySmeltTween(nextBagItemInfo)
    ---@type bagV2.BagItemInfo
    local lastBagItemInfo = self.ChooseItemInfo
    if lastBagItemInfo == nil then
        return
    end
    self:RefreshSLSuitSmeltLevelTween(lastBagItemInfo, nextBagItemInfo)
end

---刷新血继经验动画显示
---@param lastBagItemInfo bagV2.BagItemInfo 上一次道具
---@param nextBagItemInfo bagV2.BagItemInfo 当前道具
function UIForgeGodPowerSmeltPanel:RefreshSLSuitSmeltLevelTween(lastBagItemInfo, nextBagItemInfo)
    self:SetCurrentPlayingTween(true)
    local lastRate = self:GetBagItemInfoExpRate(lastBagItemInfo)
    local nextRate = self:GetBagItemInfoExpRate(nextBagItemInfo)
    local lastLevel = self:GetBagItemSLLevel(lastBagItemInfo)
    local nextLevel = self:GetBagItemSLLevel(nextBagItemInfo)
    local levelDis = nextLevel - lastLevel

    if lastRate and nextRate and levelDis and nextBagItemInfo then
        self:PlayExpTween(lastRate, nextRate, levelDis, 0, nextBagItemInfo)
    end
end

---@return number 获取道具经验比例
---@param bagItemInfo bagV2.BagItemInfo 道具
function UIForgeGodPowerSmeltPanel:GetBagItemInfoExpRate(bagItemInfo)
    if (bagItemInfo == nil or self.TargetDivineLevelUpTbl == nil) then
        return 0
    end
    --最大的经验上限
    local maxExpLimit = self.TargetDivineLevelUpTbl:GetNeedExp()
    local nowExp = bagItemInfo.exp
    return nowExp / maxExpLimit
end

---播放经验条动画
function UIForgeGodPowerSmeltPanel:PlayExpTween(lastRate, nextRate, levelDis, time, nextBagItemInfo)
    local from = time == 0 and lastRate or 0
    local to = time == levelDis and nextRate or 1
    CS.CSValueTween.Begin(self:GetAddExpValueSlider().gameObject, 1, from, to, function(item, value)
        if nextBagItemInfo == nil then
            return
        end

        if nextBagItemInfo.lid == self.ChooseItemInfo.lid then
            self:GetAddExpValueSlider().fillAmount = value
            if self.mCurrentExpRate then
                self:GetAddExpAddValueSlider().fillAmount = self.mCurrentExpRate
            end
        else
            nextBagItemInfo = nil
            self:SetCurrentPlayingTween(false)
        end
    end, function()
        if time < levelDis then
            self:PlayExpTween(lastRate, nextRate, levelDis, time + 1, nextBagItemInfo)
        else
            self:SetCurrentPlayingTween(false)
        end
    end)
end

---设置当前动画播放状态
function UIForgeGodPowerSmeltPanel:SetCurrentPlayingTween(state)
    self.mTweenPlaying = state
end

---@return boolean 获得当前动画播放状态
function UIForgeGodPowerSmeltPanel:GetCurrentTweenState()
    if self.mTweenPlaying ~= nil then
        return self.mTweenPlaying
    end
    return false
end
--endregion

--region 缓存数据
---@return TABLE.cfg_items
function UIForgeGodPowerSmeltPanel:CacheItemInfo(itemId)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[itemId]
    if info == nil then
        info = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = info
    end
    return info
end

---@return TABLE.cfg_divinesuit
function UIForgeGodPowerSmeltPanel:CacheDivineInfo(divineId)
    if self.mDivineIdToInfo == nil then
        self.mDivineIdToInfo = {}
    end
    local info = self.mDivineIdToInfo[divineId]
    if info == nil then
        info = clientTableManager.cfg_divinesuitManager:TryGetValue(divineId)
        self.mDivineIdToInfo[divineId] = info
    end
    return info
end

---@return number 获得道具神力等级
---@param bagItemInfo bagV2.BagItemInfo 道具
function UIForgeGodPowerSmeltPanel:GetBagItemSLLevel(bagItemInfo)
    local itemInfo = self:CacheItemInfo(bagItemInfo.itemId)
    if itemInfo then
        local divineId = itemInfo:GetDivineId()
        local divineInfo = self:CacheDivineInfo(divineId)
        if divineInfo then
            return divineInfo:GetLevel()
        end
    end
    return 0
end
--endregion


--region 销毁操作
function UIForgeGodPowerSmeltPanel:DestroyFunc()
    if self.mAllOpenPanel then
        for i = 1, #self.mAllOpenPanel do
            uimanager:ClosePanel(self.mAllOpenPanel[i])
        end
    end
end

function ondestroy()
    UIForgeGodPowerSmeltPanel:DestroyFunc()
end
--endregion

return UIForgeGodPowerSmeltPanel