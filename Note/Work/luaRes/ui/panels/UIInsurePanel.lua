--- DateTime: 2021/05/08 15:45
--- Description 

---@class UIInsurePanel:UIBase
local UIInsurePanel = {}

--region parameters
---@type LuaInsureMgr
local InsureMgr = nil
---@type  LuaInsuranceBigTabType 当前大页签类型
UIInsurePanel.curBigTabType = LuaInsuranceBigTabType.Insurance
---@type LuaInsuranceSubTabType 当前子页签类型
UIInsurePanel.curSubTabType = LuaInsuranceSubTabType.Role
---@type UIInsureItemTemplate 当前选中的保险UIItem
UIInsurePanel.curUIInsureItem = nil
---@type LuaInsureItem[] 当前类型的保险Item数据
UIInsurePanel.LuaInsureItemList = nil
---@type UIInsureItemTemplate[] 当前类型的保险UIItem
UIInsurePanel.UIInsureItemList = nil
---@type GamaObject
UIInsurePanel.curClickBigTab = nil
--endregion

--region Init
---@private
function UIInsurePanel:Init()
    self:InitComponent()
    self:InitParameter()
    self:InitBindEvent()
end

---@private
function UIInsurePanel:InitParameter()
    self.LuaInsureItemList = {}
    self.UIInsureItemList = {}
    self.IsInitializedEquipGrid = false
end

---@private
function UIInsurePanel:InitComponent()
    ---
    ---@type Top_UIGridContainer
    self.grid_toggles = self:GetCurComp("WidgetRoot/events/toggles", "Top_UIGridContainer")
    ---
    ---@type UnityEngine.GameObject
    self.go_Btn_GiveUP = self:GetCurComp("WidgetRoot/events/Btn_GiveUP", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---
    ---@type UILoopScrollViewPlus
    self.loop_equipmentList = self:GetCurComp("WidgetRoot/window/BaseWindow/leftAll/ScorllView/BookMark", "UILoopScrollViewPlus")
    ---
    ---@type UnityEngine.GameObject
    self.go_Btn_Role = self:GetCurComp("WidgetRoot/window/BaseWindow/leftAll/btn/Btn_mode1", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_Btn_Bag = self:GetCurComp("WidgetRoot/window/BaseWindow/leftAll/btn/Btn_mode2", "GameObject")
    ---
    ---@type UIItem
    self.uiitem_ItemTemplete = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/ItemTemplete", "GameObject"), luaComponentTemplates.UIItem)
    ---
    ---@type CostTemplate
    self.costTemplate_InsureNum = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/InsureNum", "GameObject"), luaComponentTemplates.CostTemplate)
    ---
    ---@type UILabel
    self.lb_InsureDes = self:GetCurComp("WidgetRoot/view/InsureDes", "UILabel")
    ---
    ---@type CostTemplate
    self.costTemplate_cost = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/cost", "GameObject"), luaComponentTemplates.CostTemplate)
    ---
    ---@type Top_UILabel
    self.lb_nullEquipListDes = self:GetCurComp("WidgetRoot/window/BaseWindow/leftAll/des", "Top_UILabel")
    ---
    ---@type UnityEngine.GameObject
    self.go_InsureEffect = self:GetCurComp("WidgetRoot/view/ItemTemplete/icon", "GameObject")
    ---
    ---@type UILabel
    self.lb_GiveUP = self:GetCurComp("WidgetRoot/events/Btn_GiveUP/Label", "UILabel")
    ---
    ---@type UILabel
    self.lb_InsureDesTitle = self:GetCurComp("WidgetRoot/view/InsureDesTitle", "UILabel")
    ---
    ---@type UnityEngine.GameObject
    self.go_fullMask = self:GetCurComp("WidgetRoot/panel", "GameObject")
end
--endregion

--region public methods
---@param customData tbale customData.type,customData.subType
function UIInsurePanel:Show(customData)
    InsureMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr()
    self.customData = customData
    networkRequest.ReqCanInsuredEquip()
end

function UIInsurePanel:RefreshUI()
    InsureMgr:RefreshData()
    self:AnalyticalData()
    self:InitInsuranceGrid()
    self:InitChooseToOpenTheTab()
    self:RefrshLeftUI(true)
    self:RefrshRightUI()
end

--endregion

--region private methods
---@private
function UIInsurePanel:AnalyticalData()
    local bigTab = nil
    local subTab = nil
    --外部选择页签
    if (self.customData ~= nil) then
        bigTab = self.customData.type
        subTab = self.customData.type
    end
    --红点选择页签
    if (bigTab == nil or subTab == nil) then
        bigTab, subTab = self:SelectTheTabAccordingToTheRedPoint()
    end
    --默认选择页签
    if (bigTab == nil or subTab == nil) then
        bigTab = LuaInsuranceBigTabType.Insurance
        subTab = LuaInsuranceSubTabType.Role
    end
    self.curBigTabType = bigTab
    self.curSubTabType = subTab
end

---@private
---根据红点选择默认页签
function UIInsurePanel:SelectTheTabAccordingToTheRedPoint()
    if (InsureMgr:GetInsuranceTypeEquipmentList(LuaInsuranceBigTabType.Insurance, LuaInsuranceSubTabType.Role) ~= nil) then
        return LuaInsuranceBigTabType.Insurance, LuaInsuranceSubTabType.Role
    elseif (InsureMgr:GetInsuranceTypeEquipmentList(LuaInsuranceBigTabType.Insurance, LuaInsuranceSubTabType.Bag) ~= nil) then
        return LuaInsuranceBigTabType.Insurance, LuaInsuranceSubTabType.Bag
    else
        return LuaInsuranceBigTabType.Insurance, LuaInsuranceSubTabType.Role
    end
end

---@private
function UIInsurePanel:InitInsuranceGrid()
    if (self.grid_toggles == nil) then
        return
    end
    local tabList = InsureMgr:GetInsuredTabList()
    if (tabList == nil) then
        return
    end
    self.grid_toggles.MaxCount = Utility.GetTableCount(tabList)
    local index = 0
    for i, v in ipairs(tabList) do
        self:InitInsuranceGridItem(self.grid_toggles.controlList[index], v, i)
        index = index + 1
    end
end

---@private
function UIInsurePanel:InitInsuranceGridItem(go, tabStr, index)
    if (go == nil) then
        return
    end
    local lb_Background = self:GetComp(go.transform, "Background/Label", "Top_UILabel")
    local lb_Checkmark = self:GetComp(go.transform, "Checkmark/Label", "Top_UILabel")
    --local go_redPoint = self:GetComp(go.transform, "redPoint", "GameObject")
    luaclass.UIRefresh:RefreshLabel(lb_Background, tabStr)
    luaclass.UIRefresh:RefreshLabel(lb_Checkmark, tabStr)
    luaclass.UIRefresh:BindClickCallBack(go, function(go)
        if (self.curBigTabType ~= index) then
            self.curBigTabType = index
            if (self.curClickBigTab ~= nil) then
                self:SetInsuranceToShowHidden(self.curClickBigTab, false)
            end
            self:SetInsuranceToShowHidden(go, true)
            self:RefrshLeftUI(index == 1)
            ---切换大页签刷新右侧界面
            if (index == 2) then
                self.curUIInsureItem = nil
            end
            self:RefrshRightUI()
        end
        self.curClickBigTab = go
    end)
end

---@private
function UIInsurePanel:InitChooseToOpenTheTab()
    local tabList = InsureMgr:GetInsuredTabList()
    if (tabList == nil) then
        return
    end
    local index = 0
    for i, v in ipairs(tabList) do
        if (index < self.grid_toggles.MaxCount) then
            local isCurClickBigTab = self.curBigTabType == i
            self:SetInsuranceToShowHidden(self.grid_toggles.controlList[index], isCurClickBigTab)
            if (isCurClickBigTab) then
                self.curClickBigTab = self.grid_toggles.controlList[index]
            end
        end
        index = index + 1
    end
    self:SetAllEquipmentToShowHidden()
end

---@private
function UIInsurePanel:SetAllEquipmentToShowHidden()
    self:SetEquipmentToShowHidden(self.go_Btn_Role, self.curSubTabType == LuaInsuranceSubTabType.Role)
    self:SetEquipmentToShowHidden(self.go_Btn_Bag, self.curSubTabType == LuaInsuranceSubTabType.Bag)
end

---@private
function UIInsurePanel:SetInsuranceToShowHidden(go, value)
    if (go == nil) then
        return
    end
    local Background = self:GetComp(go.transform, "Background", "GameObject")
    local Checkmark = self:GetComp(go.transform, "Checkmark", "GameObject")
    luaclass.UIRefresh:RefreshActive(Background, not value)
    luaclass.UIRefresh:RefreshActive(Checkmark, value)
end

---@private
function UIInsurePanel:SetEquipmentToShowHidden(go, value)
    if (go == nil) then
        return
    end
    local togggle = self:GetComp(go.transform, "", "Top_UIToggle")
    if (togggle) then
        togggle:SwitchSpriteState(value)
    end
end
--endregion

--region bind event
---@private
function UIInsurePanel:InitBindEvent()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ResCanInsuredEquip, function(id, tblData)
        InsureMgr.InsuredEquips = tblData.insuredList
        --self:RefreshUI()
        if (self.BagCoroutine ~= nil) then
            StopCoroutine(self.BagCoroutine)
        end
        self.BagCoroutine = StartCoroutine(self.RefreshUI, self)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ResInsuredSucces, function(id, tblData)
        self:RefrshLeftUI(true)
        self:RefrshRightUI()
    end)
    luaclass.UIRefresh:BindClickCallBack(self.go_CloseBtn, function()
        uimanager:ClosePanel(self)
    end)
    luaclass.UIRefresh:BindClickCallBack(self.go_Btn_Role, function()
        self.curSubTabType = LuaInsuranceSubTabType.Role
        self:SetAllEquipmentToShowHidden()
        self:RefrshLeftUI()
    end)
    luaclass.UIRefresh:BindClickCallBack(self.go_Btn_Bag, function()
        self.curSubTabType = LuaInsuranceSubTabType.Bag
        self:SetAllEquipmentToShowHidden()
        self:RefrshLeftUI()
    end)
    luaclass.UIRefresh:BindClickCallBack(self.go_Btn_GiveUP, function()
        if (self.curUIInsureItem ~= nil and self.curUIInsureItem.LuaInsureItem ~= nil) then
            self:ShowEffect(self.curBigTabType == LuaInsuranceBigTabType.Insurance and '700323' or '700324')
            luaclass.UIRefresh:RefreshActive(self.go_fullMask, true)
            if (self.ReqInsuredEquipCoroutines ~= nil) then
                StopCoroutine(self.ReqInsuredEquipCoroutines)
            end
            self.ReqInsuredEquipCoroutines = StartCoroutine(self.SendReqInsuredEquip, self)
        end
    end)
end

function UIInsurePanel:SendReqInsuredEquip()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1.5));
    ---@type LuaInsureItem
    if (self.curUIInsureItem ~= nil and self.curUIInsureItem.LuaInsureItem ~= nil) then
        local LuaInsureItem = self.curUIInsureItem.LuaInsureItem
        networkRequest.ReqInsuredEquip(LuaInsureItem:GetIndex(), LuaInsureItem:GetBagItemInfo().lid, self.curBigTabType == LuaInsuranceBigTabType.Insurance and 0 or 1)
        luaclass.UIRefresh:RefreshActive(self.go_fullMask, false)
    end
end
--endregion

--region leftPanel private methods
---@private
---刷新左侧面板
function UIInsurePanel:RefrshLeftUI(isDefaultSelect)
    self.LuaInsureItemList = InsureMgr:GetInsuranceTypeEquipmentList(self.curBigTabType, self.curSubTabType)
    self:RefreshInsureEquipGrid()
    self:ChooseDefaultEquipmentGrid(isDefaultSelect)
    if (self.LuaInsureItemList ~= nil and #self.LuaInsureItemList > 0) then
        luaclass.UIRefresh:RefreshActive(self.lb_nullEquipListDes, false)
    else
        local dex = string.format('暂无可%s的装备', self.curBigTabType == LuaInsuranceBigTabType.Insurance and '投保' or '弃保')
        luaclass.UIRefresh:RefreshLabel(self.lb_nullEquipListDes, dex)
        luaclass.UIRefresh:RefreshActive(self.lb_nullEquipListDes, true)
    end
end

---@private
---刷新左侧装备格子
function UIInsurePanel:RefreshInsureEquipGrid()
    if not self.IsInitializedEquipGrid then
        self.loop_equipmentList:Init(self.RefreshInsureEquipUnitTemplateView, nil)
        self.IsInitializedEquipGrid = true
    else
        self.loop_equipmentList:ResetPage()
    end
end

---@private
---刷新左侧装备格子Item
function UIInsurePanel.RefreshInsureEquipUnitTemplateView(go, line)
    if go == nil or UIInsurePanel.LuaInsureItemList == nil or line + 1 > #UIInsurePanel.LuaInsureItemList then
        return false
    end
    ---@type UIInsureItemTemplate
    local template = UIInsurePanel.UIInsureItemList[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIInsureItemTemplate)
        UIInsurePanel.UIInsureItemList[go] = template
    end
    template:Show(UIInsurePanel.LuaInsureItemList[line + 1])
    luaclass.UIRefresh:BindClickCallBack(go, function(go)
        if (UIInsurePanel.curUIInsureItem ~= nil) then
            UIInsurePanel.curUIInsureItem:SetSelectedEffect(false)
        end
        UIInsurePanel.curUIInsureItem = UIInsurePanel.UIInsureItemList[go]
        if (UIInsurePanel.curUIInsureItem ~= nil) then
            UIInsurePanel.curUIInsureItem:SetSelectedEffect(true)
        end
        UIInsurePanel:RefrshRightUI()
    end)
    return true
end

---@private
---刷新左侧装备选中
function UIInsurePanel:ChooseDefaultEquipmentGrid(isDefaultSelect)
    if (self.curUIInsureItem ~= nil) then
        self.curUIInsureItem:SetSelectedEffect(false)
    end
    if (not isDefaultSelect) then
        return
    end
    if (self.LuaInsureItemList ~= nil and #self.LuaInsureItemList > 0 and self.loop_equipmentList.itemsList ~= nil and self.loop_equipmentList.itemsList.Count > 0) then
        UIInsurePanel.curUIInsureItem = UIInsurePanel.UIInsureItemList[self.loop_equipmentList.itemsList[0]]
        if (UIInsurePanel.curUIInsureItem ~= nil) then
            UIInsurePanel.curUIInsureItem:SetSelectedEffect(true)
        end
    else
        UIInsurePanel.curUIInsureItem = nil
    end
end
--endregion

--region rightPanel private methods
---@private
---刷新右侧面板
function UIInsurePanel:RefrshRightUI()
    self:RefreshInsureIconAndCost()
    self:RefreshInsureDes()
end

---@private
---刷新投保花费
function UIInsurePanel:RefreshInsureIconAndCost()
    ---@type LuaInsureItem
    local LuaInsureItem = nil
    if (self.curUIInsureItem ~= nil and self.curUIInsureItem.LuaInsureItem ~= nil) then
        LuaInsureItem = self.curUIInsureItem.LuaInsureItem
    end
    if (LuaInsureItem ~= nil) then
        if self.uiitem_ItemTemplete then
            self.uiitem_ItemTemplete:RefreshUIWithItemInfo(LuaInsureItem:GetCSTblItem(), nil, nil, LuaInsureItem:GetBagItemInfo())
            self.uiitem_ItemTemplete:RefreshOtherUI({ showItemInfo = LuaInsureItem:GetCSTblItem() })
        end
        if self.costTemplate_InsureNum then
            self.costTemplate_InsureNum:SimpleRefreshPanel({ Cost = LuaInsureItem:GetProtectTheAmount() })
        end
        if self.costTemplate_cost then
            self.costTemplate_cost:RefreshPanel({ Cost = LuaInsureItem:GetwaiverProtectTheAmount() })
        end
    else
        if (self.uiitem_ItemTemplete) then
            luaclass.UIRefresh:RefreshSprite(self.uiitem_ItemTemplete:GetItemIcon_UISprite(), '')
            self.uiitem_ItemTemplete:SetShowItemInfo(nil)
        end
        if self.costTemplate_InsureNum then
            self.costTemplate_InsureNum:HidePanel()
        end
        if self.costTemplate_cost then
            self.costTemplate_cost:HidePanel()
        end
    end
end

---@private
---显示投保/弃保文字
function UIInsurePanel:RefreshInsureDes()
    local des = ''
    local GiveUPdes = ''
    local InsureDesTitleDes = ''
    if (self.curBigTabType == LuaInsuranceBigTabType.Insurance) then
        des = InsureMgr:GetInsuredTextDescription()
        GiveUPdes = '投保'
        InsureDesTitleDes = '投保说明'
    else
        des = InsureMgr:GetWaiveInsuredTextDescription()
        GiveUPdes = '弃保'
        InsureDesTitleDes = '弃保说明'
    end
    luaclass.UIRefresh:RefreshLabel(self.lb_InsureDes, des)
    luaclass.UIRefresh:RefreshLabel(self.lb_GiveUP, GiveUPdes)
    luaclass.UIRefresh:RefreshLabel(self.lb_InsureDesTitle, InsureDesTitleDes)
end

--endregion

--region 显示特效
---显示特效
function UIInsurePanel:ShowEffect(effectID)
    if (Utility.IsNilOrEmptyString(effectID)) then
        return
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectID, CS.ResourceType.UIEffect, function(res)
        if res ~= nil then
            if (UIInsurePanel.go_InsureEffect == nil) then
                return
            end
            UIInsurePanel.winEffectPool = res:GetUIPoolItem()
            if UIInsurePanel.winEffectPool == nil then
                return
            end
            UIInsurePanel.mSuccessEffect = UIInsurePanel.winEffectPool.go
            if UIInsurePanel.mSuccessEffect then
                UIInsurePanel.mSuccessEffect.transform.parent = UIInsurePanel.go_InsureEffect.transform
                UIInsurePanel.mSuccessEffect.transform.localPosition = CS.UnityEngine.Vector3(-153, -49, 0)
                UIInsurePanel.mSuccessEffect.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
                UIInsurePanel.mSuccessEffect:SetActive(true)
            end
        end
    end
    , CS.ResourceAssistType.UI)
end

--endregion

--region destroy
function ondestroy()
    UIInsurePanel:GetLuaEventHandler():ReleaseAllNetMsg()
end
--endregion

return UIInsurePanel