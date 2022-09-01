---锻造界面
---@class UIForgePanel:UIBase
local UIForgePanel = {}

--region 局部变量
---背包筛选方法
UIForgePanel.FilterItemsInBagFunc = nil
---物品点击回调
UIForgePanel.ItemClickEvent = nil
---左边面板类型
UIForgePanel.LeftType = nil
---右边面板类型
UIForgePanel.RightType = nil
---右边面板
UIForgePanel.mRightPanel = nil
---左边面板
UIForgePanel.mLeftPanel = nil
---左边面板名字
UIForgePanel.mLeftPanelName = nil
---右边面板名字
UIForgePanel.mRightPanelName = nil

---界面打开参数缓存
UIForgePanel.mCustomData = nil
--endregion

--region 组件
---角色按钮
function UIForgePanel.GetRoleButton_GameObject()
    if UIForgePanel.mRoleButton == nil then
        UIForgePanel.mRoleButton = UIForgePanel:GetCurComp("WidgetRoot/events/UIForgePanelLeftTag/btn_role", "GameObject")
    end
    return UIForgePanel.mRoleButton
end

---角色图片
function UIForgePanel.GetRoleButtonSprite_UISprite()
    if UIForgePanel.mRoleButtonSprite == nil then
        UIForgePanel.mRoleButtonSprite = UIForgePanel:GetCurComp("WidgetRoot/events/UIForgePanelLeftTag/btn_role/icon", "UISprite")
    end
    return UIForgePanel.mRoleButtonSprite
end

---灵兽按钮
function UIForgePanel.GetYuanLingButton_GameObject()
    if UIForgePanel.mYuanLingButton == nil then
        UIForgePanel.mYuanLingButton = UIForgePanel:GetCurComp("WidgetRoot/events/UIForgePanelLeftTag/btn_yuanling", "GameObject")
    end
    return UIForgePanel.mYuanLingButton
end
---灵兽图片
function UIForgePanel.GetServantButtonSprite_UISprite()
    if UIForgePanel.mServantSprite == nil then
        UIForgePanel.mServantSprite = UIForgePanel:GetCurComp("WidgetRoot/events/UIForgePanelLeftTag/btn_yuanling/icon", "UISprite")
    end
    return UIForgePanel.mServantSprite
end
---背包按钮
function UIForgePanel.GetBagButton_GameObject()
    if UIForgePanel.mBagButton == nil then
        UIForgePanel.mBagButton = UIForgePanel:GetCurComp("WidgetRoot/events/UIForgePanelLeftTag/btn_bag", "GameObject")
    end
    return UIForgePanel.mBagButton
end
---背包图片
function UIForgePanel.GetBagButtonSprite_UISprite()
    if UIForgePanel.mBagButtonSprite == nil then
        UIForgePanel.mBagButtonSprite = UIForgePanel:GetCurComp("WidgetRoot/events/UIForgePanelLeftTag/btn_bag/icon", "UISprite")
    end
    return UIForgePanel.mBagButtonSprite
end

---关闭按钮
function UIForgePanel.GetCloseButton_GameObject()
    if UIForgePanel.mCloseBtn_GO == nil then
        UIForgePanel.mCloseBtn_GO = UIForgePanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIForgePanel.mCloseBtn_GO
end
--endregion

--region 初始化
function UIForgePanel:Init()
    UIForgePanel.BindUIEvents()
    UIForgePanel.InitPanel()
    UIForgePanel.BindMessage()
end
---界面显示
---@param customData.leftPanelType LuaEnumForgeOpenType  角色/灵兽/背包
---@param customData.rightPanelType LuaEnumStrengthenType 锻造类型 强化/元素/转移/印记
---@param customData.bagItemInfo bagV2.BagItemInfo
function UIForgePanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end
    if (customData.leftPanelType == nil) then
        customData.leftPanelType = LuaEnumStrengthenType.Role;
    end
    if (customData.rightPanelType == nil) then
        customData.rightPanelType = LuaEnumForgeOpenType.Strengthen;
    end
    UIForgePanel.mCustomData = customData;
    UIForgePanel.RightType = customData.rightPanelType;
    UIForgePanel.LeftType = customData.leftPanelType;
    UIForgePanel.RefreshLeftPanel(customData.leftPanelType, function()
        UIForgePanel.RefreshRightPanel(customData.rightPanelType);
    end);
end

function UIForgePanel.BindUIEvents()
    CS.UIEventListener.Get(UIForgePanel.GetCloseButton_GameObject()).onClick = UIForgePanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIForgePanel.GetRoleButton_GameObject()).onClick = UIForgePanel.OnRoleButtonClicked
    CS.UIEventListener.Get(UIForgePanel.GetBagButton_GameObject()).onClick = UIForgePanel.OnBagButtonClicked
    CS.UIEventListener.Get(UIForgePanel.GetYuanLingButton_GameObject()).onClick = UIForgePanel.OnYuanLingButtonClicked
end

function UIForgePanel.BindMessage()
    UIForgePanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIForgePanel.RefreshPlayerLevel)
    UIForgePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridRefresh, UIForgePanel.RolePanelEquipGridRefresh)
    UIForgePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UIForgePanel.OnBagButtonClicked)
end
--endregion

--region UI事件
---角色变化
function UIForgePanel.RefreshPlayerLevel()
    UIForgePanel.RefreshServantButtonShow()
end

---刷新角色面板装备格子
function UIForgePanel.RolePanelEquipGridRefresh()
    return ;
end

---初始化界面
function UIForgePanel.InitPanel()
    UIForgePanel.RefreshServantButtonShow()
end

---判断灵兽页签是否开启
function UIForgePanel.RefreshServantButtonShow()
    local isShowServantButton = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsOpenServantStrength()
    if CS.StaticUtility.IsNull(UIForgePanel.GetYuanLingButton_GameObject()) == false then
        UIForgePanel.GetYuanLingButton_GameObject():SetActive(isShowServantButton)
    end
end

---关闭界面
function UIForgePanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIForgePanel")
end

---强化
function UIForgePanel.OnStrengthenToggleClicked(go)
    UIForgePanel.RefreshRightPanel(LuaEnumForgeOpenType.Strengthen)
end

---元素
function UIForgePanel.OnElementBtnClicked(go)
    --UIForgePanel.RefreshRightPanel(LuaEnumForgeOpenType.Element)
end

---点击锻造
function UIForgePanel.OnForgeToggleClicked()
    if UIForgePanel.RightType == LuaEnumForgeOpenType.Strengthen then
        return
    end
    UIForgePanel.GetSecondTag_TweenPosition():PlayForward()
    UIForgePanel.RefreshRightPanel(LuaEnumForgeOpenType.Strengthen)
end

---点击角色
function UIForgePanel.OnRoleButtonClicked()
    UIForgePanel.RefreshLeftPanel(LuaEnumStrengthenType.Role)
end

---点击灵兽
function UIForgePanel.OnYuanLingButtonClicked()
    UIForgePanel.RefreshLeftPanel(LuaEnumStrengthenType.YuanLing)
end

---点击背包
function UIForgePanel.OnBagButtonClicked()
    if UIForgePanel.RightType == LuaEnumForgeOpenType.Strengthen then
        UIForgePanel.RefreshLeftPanel(LuaEnumStrengthenType.Bag)
    end
end

---创建面板
---@param panelName string 创建界面名称
---@param callBack CallBack 创界界面回调
function UIForgePanel.CreatePanel(panelName, callBack, customData)
    uimanager:CreatePanel(panelName, function(panel)
        if callBack ~= nil then
            callBack(panel)
        end
    end, customData)
end

---刷新角色面板
function UIForgePanel:RefreshRolePanel(equipIconIsOpen)
    local rolePanel = uimanager:GetPanel("UIRolePanel")
    if rolePanel ~= nil then
        UIForgePanel.RefreshRolePanelEquipGird(rolePanel, equipIconIsOpen)
    end
end

---刷新所有角色面板装备格子
function UIForgePanel.RefreshRolePanelEquipGird(panel, equipIconIsOpen)
    if panel ~= nil and panel.equipShow ~= nil then
        local equipts = panel.equipShow.mEquips
        if equipts ~= nil then
            for k, v in pairs(equipts) do
                UIForgePanel.RefreshSingleEquipGird(v, equipIconIsOpen)
            end
        end
    end
end

---刷新角色面板下单个格子
function UIForgePanel.RefreshSingleEquipGird(uiItemClass, equipIsOpen)
    if uiItemClass.add == nil then
        uiItemClass.add = CS.Utility_Lua.Get(uiItemClass.go.transform, "add", "Transform")
    end
    if uiItemClass.yinji1 == nil then
        uiItemClass.yinji1 = CS.Utility_Lua.Get(uiItemClass.go.transform, "yinji", "Transform")
    end
    if uiItemClass.elementadd == nil then
        uiItemClass.elementadd = CS.Utility_Lua.Get(uiItemClass.go.transform, "eleadd", "Transform")
    end
    if uiItemClass.equip == nil then
        uiItemClass.equip = CS.Utility_Lua.Get(uiItemClass.go.transform, "icon", "Transform")
    end
    uiItemClass.add.gameObject:SetActive(false)
    uiItemClass.yinji1.gameObject:SetActive(false)
    uiItemClass.elementadd.gameObject:SetActive(false)
    uiItemClass.equip.gameObject:SetActive(equipIsOpen)
end

---印记右侧按钮全部关闭
function UIForgePanel.CloseSignet(isShow)
    UIForgePanel.GetRoleButton_GameObject():SetActive(isShow)
    UIForgePanel.GetYuanLingButton_GameObject():SetActive(isShow)
    UIForgePanel.GetBagButton_GameObject():SetActive(isShow)
end

---设置按钮状态
function UIForgePanel.SetButtonState(state)
    CS.Utility_Lua.GetComponent(UIForgePanel.GetRoleButton_GameObject(),"UIToggle").value = state == LuaEnumStrengthenType.Role
    CS.Utility_Lua.GetComponent(UIForgePanel.GetBagButton_GameObject(),"UIToggle").value = state == LuaEnumStrengthenType.Bag
    CS.Utility_Lua.GetComponent(UIForgePanel.GetYuanLingButton_GameObject(),"UIToggle").value = state == LuaEnumStrengthenType.YuanLing
    UIForgePanel.GetRoleButtonSprite_UISprite().spriteName = ternary(state == LuaEnumStrengthenType.Role, "c2", "u2")
    UIForgePanel.GetBagButtonSprite_UISprite().spriteName = ternary(state == LuaEnumStrengthenType.Bag, "c1", "u1")
    UIForgePanel.GetServantButtonSprite_UISprite().spriteName = ternary(state == LuaEnumStrengthenType.YuanLing, "c1", "u1")
end
--endregion

--region 刷新左边面板
---刷新左边面板
function UIForgePanel.RefreshLeftPanel(strengthenType, createdCallBack)
    if strengthenType ~= UIForgePanel.LeftType then
        if UIForgePanel.mLeftPanelName ~= nil then
            uimanager:ClosePanel(UIForgePanel.mLeftPanelName);
        end
    end
    if strengthenType == nil then
        UIForgePanel.LeftType = LuaEnumStrengthenType.Role
    else
        UIForgePanel.LeftType = strengthenType
    end
    if UIForgePanel.LeftType == LuaEnumStrengthenType.Role then
        UIForgePanel.RefreshLeftRolePanel(createdCallBack)
    elseif UIForgePanel.LeftType == LuaEnumStrengthenType.YuanLing then
        UIForgePanel.RefreshLeftServantPanel(createdCallBack)
    elseif UIForgePanel.LeftType == LuaEnumStrengthenType.Bag then
        UIForgePanel.RefreshLeftBagPanel(createdCallBack)
    end
    --设置按钮显示状态
    UIForgePanel.SetButtonState(UIForgePanel.LeftType)
end

---背包筛选方法
function UIForgePanel.GetFilterItemsInBag(bagItemInfo)
    if UIForgePanel.mRightPanel ~= nil then
        UIForgePanel.FilterItemsInBagFunc = UIForgePanel.mRightPanel:FilterItemsInBag(bagItemInfo)
    end
    return UIForgePanel.FilterItemsInBagFunc
end

---刷新背包面板
function UIForgePanel.RefreshLeftBagPanel(createdCallBack)
    local panelName = "UIBagPanel"
    UIForgePanel.mLeftPanelName = panelName
    UIForgePanel:AddRelationPanel(panelName);
    --local callBack = function(panel)
    --    panel.GetRecycleBtnArrow_UISprite().gameObject:SetActive(false)
    --    panel.SetFilterBagItem(false, UIForgePanel.GetFilterItemsInBag, nil, function()
    --        local bagItemInfo = nil;
    --        local rightPanel = uimanager:GetPanel(UIForgePanel.mRightPanelName);
    --        if (rightPanel ~= nil) then
    --            bagItemInfo = rightPanel:GetSelectBagItemInfo();
    --        end
    --        if (bagItemInfo == nil) then
    --            bagItemInfo = UIForgePanel.mCustomData.bagItemInfo;
    --        end
    --
    --        if (bagItemInfo ~= nil) then
    --            panel.SwitchToPage(panel.GetFilterPageIndex(bagItemInfo));
    --            panel.OpenOneItemHighLight(bagItemInfo);
    --        end
    --    end)
    --    panel.GetBaseCloseBtn_GameObject():SetActive(false)
    --    panel:RemoveCollider()
    --
    --    if (createdCallBack ~= nil) then
    --        createdCallBack();
    --    end
    --end
    UIForgePanel.CreatePanel(panelName, createdCallBack)
end

---刷新元灵面板
function UIForgePanel.RefreshLeftServantPanel(createdCallBack)
    local panelName = "UIServantPanel"
    local servantData = nil;
    UIForgePanel.mLeftPanelName = panelName
    UIForgePanel:AddRelationPanel(panelName);

    if servantData == nil then
        servantData = {}
        servantData.openType = LuaEnumServantPanelType.BasePanel
        servantData.openServantPanelType = LuaEnumPanelOpenSourceType.ByStrengthenPanel
    end
    local bagItemInfo = nil;
    local rightPanel = uimanager:GetPanel(UIForgePanel.mRightPanelName);
    if (rightPanel ~= nil) then
        bagItemInfo = rightPanel:GetSelectBagItemInfo();
    end

    if (bagItemInfo ~= nil) then
        if (CS.CSServantInfoV2.IsServantJustEquip(bagItemInfo) or CS.CSServantInfoV2.IsServantBody(bagItemInfo)) then
            servantData.showBagItemInfo = bagItemInfo;
            servantData.pos = ternary(servantData.showBagItemInfo, math.floor(servantData.showBagItemInfo.index / 1000 - 1), 0)
        end
    end

    local callBack = function(panel)
        panel:GetBtnShowAttribute():SetActive(false)
        panel.HideButtons();

        if (createdCallBack ~= nil) then
            createdCallBack();
        end
    end
    UIForgePanel.CreatePanel(panelName, callBack, servantData)
end

---刷新角色面板
function UIForgePanel.RefreshLeftRolePanel(createdCallBack)
    local panelName = "UIRolePanel"
    UIForgePanel.mLeftPanelName = panelName
    UIForgePanel:AddRelationPanel(panelName);
    local callBack = function(panel)
        local bagItemInfo = nil;
        local rightPanel = uimanager:GetPanel(UIForgePanel.mRightPanelName);
        if (rightPanel ~= nil) then
            bagItemInfo = rightPanel:GetSelectBagItemInfo();
        end

        if (bagItemInfo == nil) then
            bagItemInfo = UIForgePanel.mCustomData.bagItemInfo;
        end
        panel:HideCurrentChooseItem();
        if (bagItemInfo ~= nil) then
            panel:SetItemChoose(bagItemInfo);
        end
        panel:ShowCloseButton(false);

        if (createdCallBack ~= nil) then
            createdCallBack();
        end
    end

    local customData = {}
    customData.equipShowTemplate = UIForgePanel:GetEquipTemplate(UIForgePanel.RightType);
    customData.equipItemTemplate = UIForgePanel:GetGridTemplate(UIForgePanel.RightType);
    UIForgePanel.CreatePanel(panelName, callBack, customData)
end
--endregion

--region刷新右边面板
function UIForgePanel.RefreshRightPanel(forgeOpenType, createdCallBack)
    if forgeOpenType == nil then
        UIForgePanel.RightType = LuaEnumForgeOpenType.Strengthen
    else
        UIForgePanel.RightType = forgeOpenType
    end

    local panelName
    local callBack
    if UIForgePanel.RightType == LuaEnumForgeOpenType.Strengthen then
        panelName = "UIForgeStrengthenPanel"
        --UIForgePanel:RefreshRolePanel(true)
        UIForgePanel.CloseSignet(true)
        UIForgePanel.RefreshServantButtonShow()
    --elseif UIForgePanel.RightType == LuaEnumForgeOpenType.Element then
    --    panelName = "UIElementPanel"
    --    UIForgePanel.CloseSignet(false)
    elseif UIForgePanel.RightType == LuaEnumForgeOpenType.Signet then
        panelName = "UISignetPanel"
        UIForgePanel.CloseSignet(false)
        UIForgePanel:RefreshRolePanel(false)
    end

    if UIForgePanel.mRightPanelName ~= nil and UIForgePanel.mRightPanelName ~= panelName then
        uimanager:ClosePanel(UIForgePanel.mRightPanelName)
    end

    callBack = function(panel)
        UIForgePanel.mRightPanel = panel

        if (createdCallBack ~= nil) then
            createdCallBack();
        end
    end
    UIForgePanel.mRightPanelName = panelName
    UIForgePanel:AddRelationPanel(panelName);
    UIForgePanel.CreatePanel(panelName, callBack, UIForgePanel.mCustomData);
end
--endregion

--region Private

---获取模板根据右侧面板类型
function UIForgePanel:GetEquipTemplate(rightType)
    if (rightType == LuaEnumForgeOpenType.Strengthen) then
        return luaComponentTemplates.UIRolePanel_EquipTemplateStrengthen
    --elseif (rightType == LuaEnumForgeOpenType.Element) then
    --    return luaComponentTemplates.UIRolePanel_EquipTemplatesElement
    elseif (rightType == LuaEnumForgeOpenType.Signet) then
        return luaComponentTemplates.UIRolePanel_EquipTemplateSignet
    end
    return luaComponentTemplates.UIRolePanel_EquipTemplateStrengthen
end

---获取模板根据右侧面板类型
function UIForgePanel:GetGridTemplate(rightType)
    if (rightType == LuaEnumForgeOpenType.Strengthen) then
        return luaComponentTemplates.UIRolePanel_GridTemplateStrength
    --elseif (rightType == LuaEnumForgeOpenType.Element) then
    --    return luaComponentTemplates.UIRolePanel_GridTemplatesElement
    elseif (rightType == LuaEnumForgeOpenType.Signet) then
        return luaComponentTemplates.UIRolePanel_GridTemplateSignet
    end
    return luaComponentTemplates.UIRolePanel_GridTemplateStrength
end

--endregion

--region OnDestroy
function ondestroy()
    uimanager:ClosePanel(UIForgePanel.mLeftPanelName)
    uimanager:ClosePanel(UIForgePanel.mRightPanelName)

    for k, v in pairs(UIForgePanel._RelationPanels) do
        uimanager:ClosePanel(v)
    end

    UIForgePanel:GetClientEventHandler():RemoveEvent(CS.CEvent.Role_UpdateLevel, UIForgePanel.RefreshPlayerLevel)
end
--endregion

return UIForgePanel