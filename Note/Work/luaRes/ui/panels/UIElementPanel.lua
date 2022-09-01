---@class UIElementPanel:UIBase
local UIElementPanel = {}
--region 组件
---view
function UIElementPanel:GetView_Go()
    if UIElementPanel.mGetView_Go == nil then
        UIElementPanel.mGetView_Go = UIElementPanel:GetCurComp("WidgetRoot/view", "GameObject")
    end
    return UIElementPanel.mGetView_Go
end


---镶嵌按钮
function UIElementPanel.GetUseBtn_Go()
    if UIElementPanel.mUseBtn_Go == nil then
        UIElementPanel.mUseBtn_Go = UIElementPanel:GetCurComp("WidgetRoot/events/btn_use", "GameObject")
    end
    return UIElementPanel.mUseBtn_Go
end

---套装按钮
function UIElementPanel.GetSuitBtn_Go()
    if UIElementPanel.mSuitBtn_Go == nil then
        UIElementPanel.mSuitBtn_Go = UIElementPanel:GetCurComp("WidgetRoot/events/btn_suit", "GameObject")
    end
    return UIElementPanel.mSuitBtn_Go
end

---帮助按钮
function UIElementPanel.GetHelpBtn_Go()
    if UIElementPanel.mHelpBtn_Go == nil then
        UIElementPanel.mHelpBtn_Go = UIElementPanel:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return UIElementPanel.mHelpBtn_Go
end

---关闭按钮
function UIElementPanel.GetCloseBtn_Go()
    if UIElementPanel.mCloseBtn_Go == nil then
        UIElementPanel.mCloseBtn_Go = UIElementPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIElementPanel.mCloseBtn_Go
end
--endregion
--endregion

--region 初始化
function UIElementPanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
    self:BindClientMessage()
    self:ReqElementSuitInfo()
    self:CreateRolePanel()
    self:InitTemplates()
end

function UIElementPanel:BindUIEvents()
    CS.UIEventListener.Get(UIElementPanel.GetSuitBtn_Go()).onClick = UIElementPanel.SuitBtnClick
    CS.UIEventListener.Get(UIElementPanel.GetHelpBtn_Go()).onClick = UIElementPanel.HelpBtnClick
    CS.UIEventListener.Get(UIElementPanel.GetCloseBtn_Go()).onClick = UIElementPanel.CloseBtnClick
end

function UIElementPanel:BindNetMessage()
    self.OnResBagChangeMessageReceivedFunc = function()
        self:OnResBagChangeMessageReceived()
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResElementSuitInfoMessage, UIElementPanel.OnResElementSuitInfoMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.OnResBagChangeMessageReceivedFunc)
end

function UIElementPanel:BindClientMessage()
    ---角色面板点击事件
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, UIElementPanel.Role_RefreshPanel)
end

---初始化套装按钮
function UIElementPanel:ReqElementSuitInfo()
    networkRequest.ReqElementSuitInfo()
end

---创建角色面板
function UIElementPanel:CreateRolePanel()
    local commonData = {equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplatesElement,equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplatesElement,isShowCloseBtn = false,isShowArrowBtn = false}
    uimanager:CreatePanel("UIRolePanel",function(panel)
        panel:ShowCloseButton(false)
        panel:SetSLToggle(false)
    end ,commonData)
end

---初始化模板
function UIElementPanel:InitTemplates()
    self.elementPanelTemplate = templatemanager.GetNewTemplate(self:GetView_Go(), luaComponentTemplates.UIElementPanelTemplate)
end
--endregion

--region 刷新
function UIElementPanel:Show(commonData)
    if commonData ~= nil then
        self.chooseEquipIndex = commonData.chooseEquipIndex
        self.chooseElementItemId = commonData.chooseElementItemId
    end
    uimanager:ClosePanel("UIBagPanel");
end
--endregion

--region UI事件处理
---套装按钮点击事件
function UIElementPanel.SuitBtnClick()
    local suitEquipIndexTable = {}
    if UIElementPanel.elementSuitEquipIndexList == nil then
        return
    end
    for i = 0,UIElementPanel.elementSuitEquipIndexList.Length - 1 do
        local equipIndex = UIElementPanel.elementSuitEquipIndexList[i]
        local mLevel = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementLvByEquipIndex(tonumber(equipIndex)) .. "级"
        local elementTable = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementTableInfo(equipIndex)
        local equipIndexMsg = {
            icon = equipIndex,
            level = mLevel,
            elementTable = elementTable
        }
        table.insert(suitEquipIndexTable,equipIndexMsg)
    end
    local customdata = {
        title = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementSuitTitle(),
        equipIndexTable = suitEquipIndexTable,
        suitInfoList = CS.CSScene.MainPlayerInfo.ElementInfo.MElementSuitInfo:GetElementSuitTableList(),
    }
    uimanager:CreatePanel("UISuitAttributeElementPanel",nil,customdata)
end

---帮助按钮点击事件
function UIElementPanel.HelpBtnClick()
    local info
    local isFind = nil
    isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(34)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---关闭按钮点击事件
function UIElementPanel:CloseBtnClick()
    uimanager:ClosePanel("UIElementPanel")
end
--endregion

--region 服务器事件处理
---接收元素套装信息
function UIElementPanel.OnResElementSuitInfoMessageReceived(id, info, csTabele)
    --CS.UnityEngine.Debug.LogError("接收元素套装信息")
    if info.isPutUp ~= nil and info.isPutUp == true and UIElementPanel.elementPanelTemplate ~= nil then
        UIElementPanel.elementPanelTemplate:PlaySuccessfulEffect()
    end
    if UIElementPanel.elementPanelTemplate ~= nil then
        UIElementPanel.elementPanelTemplate:RefreshElementPanelNoCustomData()
    end
    UIElementPanel.elementSuitEquipIndexList = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementSuitEquipIndex()
    UIElementPanel:RefreshRolepanel()
end

---接收背包变化信息
function UIElementPanel:OnResBagChangeMessageReceived()
    if self.elementPanelTemplate ~= nil then
        self.elementPanelTemplate:RefreshElementList()
    end
end
--endregion

--region 功能
--region 角色面板功能
function UIElementPanel.Role_RefreshPanel(msg, ItemClass)
    UIElementPanel:RefreshPanel(LuaEnumStrengthenType.Role, ItemClass.bagItemInfo, ItemClass)
end
---刷新面板
function UIElementPanel:RefreshPanel(StrengthenType, bagItemInfo, ItemClass)
    if ItemClass ~= nil and self.elementPanelTemplate ~= nil then
        local commonData = {equipItemClass = ItemClass,chooseElementItemId = self.chooseElementItemId}
        self.elementPanelTemplate:RefreshElementPanel(commonData)
        self.chooseElementItemId = 0
    end
end
--endregion

--region 其他功能
---刷新角色面板
function UIElementPanel:RefreshRolepanel()
    if self.muiRolePanel == nil then
        self.muiRolePanel = uimanager:GetPanel("UIRolePanel")
    end
    if self.muiRolePanel and CS.StaticUtility.IsNull(self.muiRolePanel.go) == false then
        local customData = {}
        ---@type UIRolePanel_EquipTemplatesElement
        customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplatesElement
        customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplatesElement
        customData.isShowCloseBtn = false
        customData.isShowArrowBtn = false
        customData.chooseEquipIndex = self.chooseEquipIndex
        self.muiRolePanel:Show(customData)
        if self.elementPanelTemplate.autoChoose == true then
            self.elementPanelTemplate.autoChoose = false
            local equipIndex = self.chooseEquipIndex
            if equipIndex == nil then
                equipIndex = CS.CSScene.MainPlayerInfo.ElementInfo:GetEquipIndexByDefaultChooseRule()
            end
            if equipIndex ~= 0 then
                --coroutine.yield(nil)
                if self.elementPanelTemplate ~= nil then
                    self.muiRolePanel:SelectItemByEquipIndex(equipIndex)
                end
            end
        end
    end
end
--endregion

--region Override
function UIElementPanel:GetSelectBagItemInfo()
    return UIElementPanel.mOriginEquipInfo;
end
--endregion

function ondestroy()
    uimanager:ClosePanel("UIRolePanel")
end
return UIElementPanel