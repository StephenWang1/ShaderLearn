---转移界面
---@class UIForgeTransferPanel:UIBase
local UIForgeTransferPanel = {}

--region 局部变量
---原始装备
---@type bagV2.BagItemInfo
UIForgeTransferPanel.mOriginEquipInfo = nil

---原始装备类型
---@type LuaEnumStrengthenType
UIForgeTransferPanel.mOriginEquipType = nil

---原始装备模板
UIForgeTransferPanel.mOriginTemplate = nil

---目标装备
---@type bagV2.BagItemInfo
UIForgeTransferPanel.mAimEquipInfo = nil

---目标装备类型
---@type LuaEnumStrengthenType
UIForgeTransferPanel.mAimEquipType = nil

---目标装备模板
UIForgeTransferPanel.mAimEquipTemplate = nil

---角色界面
---@type UIRolePanel
UIForgeTransferPanel.mRolePanel = nil

---背包界面
---@type UIBagPanel
UIForgeTransferPanel.mBagPanel = nil

---元灵界面
---@type UIServantPanel
UIForgeTransferPanel.mServantPanel = nil

---打开界面table
UIForgeTransferPanel.mOpenPanel = {}
---没有选中左边时提示
UIForgeTransferPanel.mChooseLeft = "点击左侧面板，选择要转出的装备"
---没有选中右边时提示
UIForgeTransferPanel.mChooseRight = "点击左侧面板，选择想要获得星级的装备"

---@type LuaEnumStrengthenType 当前面板类型
UIForgeTransferPanel.mCurrentPanelType = nil
--endregion

--region 缓存数据
---@return CSMainPlayerInfo
function UIForgeTransferPanel:GetMainPlayerInfoV2()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2 背包数据
function UIForgeTransferPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfoV2() then
        self.mBagInfoV2 = self:GetMainPlayerInfoV2().BagInfo
    end
    return self.mBagInfoV2
end

---@return CSEquipInfoV2 角色装备数据
function UIForgeTransferPanel:GetEquipInfoV2()
    if self.mEquipInfoV2 == nil and self:GetMainPlayerInfoV2() then
        self.mEquipInfoV2 = self:GetMainPlayerInfoV2().EquipInfo
    end
    return self.mEquipInfoV2
end

---@return CSServantInfoV2
function UIForgeTransferPanel:GetServantInfoV2()
    if self.mServantInfoV2 == nil and self:GetMainPlayerInfoV2() then
        self.mServantInfoV2 = self:GetMainPlayerInfoV2().ServantInfoV2
    end
    return self.mServantInfoV2
end
--endregion

--region 组件
---转移按钮
function UIForgeTransferPanel.GetTransferButton_GameObject()
    if UIForgeTransferPanel.mStrengthenButton_GO == nil then
        UIForgeTransferPanel.mStrengthenButton_GO = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/btn_transfer", "GameObject")
    end
    return UIForgeTransferPanel.mStrengthenButton_GO
end

---原ItemGameObject
function UIForgeTransferPanel.GetOriginEquip_GameObject()
    if UIForgeTransferPanel.mOriginEquip == nil then
        UIForgeTransferPanel.mOriginEquip = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/OriginEquip", "GameObject")
    end
    return UIForgeTransferPanel.mOriginEquip
end
---目标ItemGameObject
function UIForgeTransferPanel.GetAimEquip_GameObject()
    if UIForgeTransferPanel.mAimEquip == nil then
        UIForgeTransferPanel.mAimEquip = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/AimEquip", "GameObject")
    end
    return UIForgeTransferPanel.mAimEquip
end

---@return UIForgeTransferPanel_TransferGrid 原ItemTemplate
function UIForgeTransferPanel.GetOriginEquipTemplate()
    if UIForgeTransferPanel.mOriginWrapContent == nil then
        UIForgeTransferPanel.mOriginWrapContent = templatemanager.GetNewTemplate(UIForgeTransferPanel.GetOriginEquip_GameObject(), luaComponentTemplates.UIForgeTransferPanel_TransferGrid)
    end
    return UIForgeTransferPanel.mOriginWrapContent
end

---@return UIForgeTransferPanel_TransferGrid 目标ItemTemplate
function UIForgeTransferPanel.GetAimEquipTemplate()
    if UIForgeTransferPanel.mAimWrapContent == nil then
        UIForgeTransferPanel.mAimWrapContent = templatemanager.GetNewTemplate(UIForgeTransferPanel.GetAimEquip_GameObject(), luaComponentTemplates.UIForgeTransferPanel_TransferGrid)
    end
    return UIForgeTransferPanel.mAimWrapContent
end

---转移消耗物品Icon
function UIForgeTransferPanel.GetGoldIcon_UISprite()
    if UIForgeTransferPanel.mGoldIcon == nil then
        UIForgeTransferPanel.mGoldIcon = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/gold/money", "UISprite")
    end
    return UIForgeTransferPanel.mGoldIcon
end

---转移消耗道具数量
function UIForgeTransferPanel.GetGold_UILabel()
    if UIForgeTransferPanel.mGoldLabel == nil then
        UIForgeTransferPanel.mGoldLabel = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/gold", "UILabel")
    end
    return UIForgeTransferPanel.mGoldLabel
end

---转以后星数
function UIForgeTransferPanel.GetTransferIntensify_GameObject()
    if UIForgeTransferPanel.mTransferIntensify == nil then
        UIForgeTransferPanel.mTransferIntensify = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/Transfer", "GameObject")
    end
    return UIForgeTransferPanel.mTransferIntensify
end

---当前装备转移前
function UIForgeTransferPanel.GetOriginIntensify_UILabel()
    if UIForgeTransferPanel.mOriginIntensify == nil then
        UIForgeTransferPanel.mOriginIntensify = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/Current/CurrentValue", "UILabel")
    end
    return UIForgeTransferPanel.mOriginIntensify
end

---目标装备转移前
function UIForgeTransferPanel.GetOriginTransferIntensify_UILabel()
    if UIForgeTransferPanel.mOriginTransferIntensify == nil then
        UIForgeTransferPanel.mOriginTransferIntensify = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/Current/TransferValue", "UILabel")
    end
    return UIForgeTransferPanel.mOriginTransferIntensify
end

---当前装备转移后
function UIForgeTransferPanel.GetAimIntensify_UILabel()
    if UIForgeTransferPanel.mAimIntensify == nil then
        UIForgeTransferPanel.mAimIntensify = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/Transfer/CurrentValue", "UILabel")
    end
    return UIForgeTransferPanel.mAimIntensify
end

---目标装备转移后
function UIForgeTransferPanel.GetAimTransferIntensify_UILabel()
    if UIForgeTransferPanel.mAimTransferIntensify == nil then
        UIForgeTransferPanel.mAimTransferIntensify = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/Transfer/TransferValue", "UILabel")
    end
    return UIForgeTransferPanel.mAimTransferIntensify
end

---添加资源按钮
function UIForgeTransferPanel.GetAddButton_GameObject()
    if UIForgeTransferPanel.mAddButton == nil then
        UIForgeTransferPanel.mAddButton = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish/gold/Add", "GameObject")
    end
    return UIForgeTransferPanel.mAddButton
end

---套装按钮
function UIForgeTransferPanel.GetSuitButton_GameObject()
    if UIForgeTransferPanel.mSuitButton == nil then
        UIForgeTransferPanel.mSuitButton = UIForgeTransferPanel:GetCurComp("WidgetRoot/events/btn_suit", "GameObject")
    end
    return UIForgeTransferPanel.mSuitButton
end

---套装加成显示
function UIForgeTransferPanel.GetSuitShow_GameObject()
    if UIForgeTransferPanel.mSuitShow == nil then
        UIForgeTransferPanel.mSuitShow = UIForgeTransferPanel:GetCurComp("WidgetRoot/SuitHintPanel", "GameObject")
    end
    return UIForgeTransferPanel.mSuitShow
end

---当前套装等级
function UIForgeTransferPanel.GetCurrentSuitLevel_UILabel()
    if UIForgeTransferPanel.mCurrentSuitLevel == nil then
        UIForgeTransferPanel.mCurrentSuitLevel = UIForgeTransferPanel:GetCurComp("WidgetRoot/SuitHintPanel/CurrentSuitEffect", "UILabel")
    end
    return UIForgeTransferPanel.mCurrentSuitLevel
end

---当前套装效果
function UIForgeTransferPanel.GetCurrentSuitAttack_UILabel()
    if UIForgeTransferPanel.mCurrentSuitAttack == nil then
        UIForgeTransferPanel.mCurrentSuitAttack = UIForgeTransferPanel:GetCurComp("WidgetRoot/SuitHintPanel/CurrentSuitEffect/Level", "UILabel")
    end
    return UIForgeTransferPanel.mCurrentSuitAttack
end

---下一级套装等级
function UIForgeTransferPanel.GetNextSuitLevel_UILabel()
    if UIForgeTransferPanel.mNextSuitLevel == nil then
        UIForgeTransferPanel.mNextSuitLevel = UIForgeTransferPanel:GetCurComp("WidgetRoot/SuitHintPanel/AfterSuitEffect", "UILabel")
    end
    return UIForgeTransferPanel.mNextSuitLevel
end

---下一级套装效果
function UIForgeTransferPanel.GetNextSuitAttack_UILabel()
    if UIForgeTransferPanel.mNextSuitAttack == nil then
        UIForgeTransferPanel.mNextSuitAttack = UIForgeTransferPanel:GetCurComp("WidgetRoot/SuitHintPanel/AfterSuitEffect/Level", "UILabel")
    end
    return UIForgeTransferPanel.mNextSuitAttack
end

---套装关闭按钮
function UIForgeTransferPanel.GetSuitCloseButton_GameObject()
    if UIForgeTransferPanel.mSuitCloseButton == nil then
        UIForgeTransferPanel.mSuitCloseButton = UIForgeTransferPanel:GetCurComp("WidgetRoot/SuitHintPanel/close", "GameObject")
    end
    return UIForgeTransferPanel.mSuitCloseButton
end

---系统说明按钮
function UIForgeTransferPanel.GetHelpBtn_GameObject()
    if UIForgeTransferPanel.mHelpBtn_GameObject == nil then
        UIForgeTransferPanel.mHelpBtn_GameObject = UIForgeTransferPanel:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return UIForgeTransferPanel.mHelpBtn_GameObject
end

---角色按钮
function UIForgeTransferPanel:GetRoleButton_UIToggle()
    if self.mRoleButton == nil then
        self.mRoleButton = self:GetCurComp("WidgetRoot/events/btn_role", "UIToggle")
    end
    return self.mRoleButton
end

---背包按钮
function UIForgeTransferPanel:GetBagButton_UIToggle()
    if self.mBagButton == nil then
        self.mBagButton = self:GetCurComp("WidgetRoot/events/btn_bag", "UIToggle")
    end
    return self.mBagButton
end

---元灵按钮
function UIForgeTransferPanel:GetServantButton_UIToggle()
    if self.mServantButton == nil then
        self.mServantButton = self:GetCurComp("WidgetRoot/events/btn_yuanling", "UIToggle")
    end
    return self.mServantButton
end

---关闭按钮
function UIForgeTransferPanel.GetCloseButton_GameObject()
    if UIForgeTransferPanel.mCloseButton == nil then
        UIForgeTransferPanel.mCloseButton = UIForgeTransferPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIForgeTransferPanel.mCloseButton
end

---完成选择后
function UIForgeTransferPanel.GetFinishShow_GameObject()
    if UIForgeTransferPanel.mFinishShow == nil then
        UIForgeTransferPanel.mFinishShow = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Finish", "GameObject")
    end
    return UIForgeTransferPanel.mFinishShow
end

---未完成选择
function UIForgeTransferPanel.GetUnFinishShow_GameObject()
    if UIForgeTransferPanel.mUnFinishShow == nil then
        UIForgeTransferPanel.mUnFinishShow = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Unfinish", "GameObject")
    end
    return UIForgeTransferPanel.mUnFinishShow
end

---未完成显示Label
function UIForgeTransferPanel.GetUnFinish_UILabel()
    if UIForgeTransferPanel.mUnFinishLabel == nil then
        UIForgeTransferPanel.mUnFinishLabel = UIForgeTransferPanel:GetCurComp("WidgetRoot/view/Unfinish/Label", "UILabel")
    end
    return UIForgeTransferPanel.mUnFinishLabel
end

---特效节点
function UIForgeTransferPanel.GetEffectRoot_GameObject()
    if UIForgeTransferPanel.mEffectRoot == nil then
        UIForgeTransferPanel.mEffectRoot = UIForgeTransferPanel:GetCurComp("WidgetRoot/window/FunctionBg", "GameObject")
    end
    return UIForgeTransferPanel.mEffectRoot
end
--endregion

--region 初始化
function UIForgeTransferPanel:Init()
    self:BindEvents()
    self:BingMessage()
    UIForgeTransferPanel.GetStrengthenData()
    self:InitPanel()
    self:RefreshServantButtonShow()
end

function UIForgeTransferPanel:Show(customData)
    self.mCurrentPanelType = nil
    local type = LuaEnumStrengthenType.Role
    if customData.type then
        type = customData.type
    end
    self.mCurrentAutoChooseType = type
    if customData and customData.mChooseItemInfo then
        self.mManualChooseData = customData.mChooseItemInfo
    end
    self:ManageAutoChooseEquip()

    self:SwitchToPanel(type)
    self:RefreshData()
end

function UIForgeTransferPanel:BindEvents()
    CS.UIEventListener.Get(UIForgeTransferPanel.GetTransferButton_GameObject()).onClick = UIForgeTransferPanel.OnTransferButtonClicked
    CS.UIEventListener.Get(UIForgeTransferPanel.GetOriginEquip_GameObject()).onClick = function()
        self:OnOriginEquipClicked()
    end
    CS.UIEventListener.Get(UIForgeTransferPanel.GetAimEquip_GameObject()).onClick = function()
        self:OnAimEquipClicked()
    end
    CS.UIEventListener.Get(UIForgeTransferPanel.GetAddButton_GameObject()).onClick = function(go)
        self:OnAddButtonClicked(go)
    end
    CS.UIEventListener.Get(UIForgeTransferPanel.GetGold_UILabel().gameObject).onClick = UIForgeTransferPanel.OnGoldButtonClicked
    CS.UIEventListener.Get(UIForgeTransferPanel.GetHelpBtn_GameObject()).onClick = UIForgeTransferPanel.OnHelpBtnClicked
    CS.EventDelegate.Add(self:GetRoleButton_UIToggle().onChange, function()
        if self:GetRoleButton_UIToggle().value then
            self.mCurrentPanelType = LuaEnumStrengthenType.Role
            self:SwitchToRolePanel()
        end
    end)
    CS.EventDelegate.Add(self:GetBagButton_UIToggle().onChange, function()
        if self:GetBagButton_UIToggle().value then
            self.mCurrentPanelType = LuaEnumStrengthenType.Bag
            self:SwitchToBagPanel()
        end
    end)
    CS.EventDelegate.Add(self:GetServantButton_UIToggle().onChange, function()
        if self:GetServantButton_UIToggle().value then
            self.mCurrentPanelType = LuaEnumStrengthenType.YuanLing
            self:SwitchToServantPanel()
        end
    end)
    CS.UIEventListener.Get(UIForgeTransferPanel.GetCloseButton_GameObject().gameObject).onClick = UIForgeTransferPanel.OnCloseButtonClicked
end

function UIForgeTransferPanel:BingMessage()
    UIForgeTransferPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResIntensifyMessage, function()
        self:OnResIntensifyMessageReceived()
    end)
    UIForgeTransferPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GridSingleClicked, function(id, bagItemInfo)
        self:OnBagItemClicked(id, bagItemInfo)
    end)
    UIForgeTransferPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, function(id, itemTemp)
        self:OnRoleItemClicked(id, itemTemp)
    end)
    UIForgeTransferPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Servant_GridClicked, function(msgId, info)
        self:OnServantItemClicked(msgId, info)
    end)
    UIForgeTransferPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, function()
        self:OnMainBagClicked()
    end)
    UIForgeTransferPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, UIForgeTransferPanel.RefreshPanel)
end

---初始化数据b
function UIForgeTransferPanel.GetStrengthenData()
    UIForgeTransferPanel.strengthenIDList = CS.Cfg_GlobalTableManager.Instance:GetStrengthenID()
end
--endregion

--region 服务器事件
function UIForgeTransferPanel:OnResIntensifyMessageReceived()
    if self.mOriginEquipInfo ~= nil and self.mAimEquipInfo ~= nil then
        self.ShowWinEffect()
        self:InitPanel()
    end

    self:ReplaceOriginItem()
    self:ReplaceAimItem()
    self:ManageAutoChooseEquip()
    self:RefreshData()
end
--endregion

--region 客户端消息
---点击背包格子
function UIForgeTransferPanel:OnBagItemClicked(id, bagItemInfo)
    if bagItemInfo then
        self:OnItemClicked(bagItemInfo, LuaEnumStrengthenType.Bag, bagItemInfo)
    end
end

---点击角色格子
function UIForgeTransferPanel:OnRoleItemClicked(id, itemTemp)
    if itemTemp ~= nil and itemTemp.bagItemInfo ~= nil then
        self:OnItemClicked(itemTemp.bagItemInfo, LuaEnumStrengthenType.Role, itemTemp)
    end
end

---点击元灵格子
function UIForgeTransferPanel:OnServantItemClicked(msgId, info)
    if info then
        self:OnItemClicked(info, LuaEnumStrengthenType.YuanLing, info)
    end
end

--endregion

--region 页签管理
---跳转页签
function UIForgeTransferPanel:SwitchToPanel(type)
    if type == LuaEnumStrengthenType.Role then
        self:GetRoleButton_UIToggle():Set(true)
    elseif type == LuaEnumStrengthenType.Bag then
        self:GetBagButton_UIToggle():Set(true)
    elseif type == LuaEnumStrengthenType.YuanLing then
        self:GetServantButton_UIToggle():Set(true)
    end
end
--endregion

--region UI事件
---主屏幕背按钮点击事件
function UIForgeTransferPanel:OnMainBagClicked()
    self:GetBagButton_UIToggle():Set(true)
end

---切换到角色状态
function UIForgeTransferPanel:SwitchToRolePanel()
    UIForgeTransferPanel.HideOtherPanel(LuaEnumStrengthenType.Role)
    if UIForgeTransferPanel.mRolePanel == nil or CS.StaticUtility.IsNull(UIForgeTransferPanel.mRolePanel.go) then
        local roleData = {}
        roleData.equipShowTemplate = luaComponentTemplates.UIForgeTransferPanel_RoleEquipTemplate
        roleData.equipItemTemplate = luaComponentTemplates.UIForgeTransferPanel_RoleGridTemplateBase
        ---@param panel UIRolePanel
        uimanager:CreatePanel("UIRolePanel", function(panel)
            if UIForgeTransferPanel == nil or UIForgeTransferPanel.go == nil or CS.StaticUtility.IsNull(UIForgeTransferPanel.go) then
                return
            end
            panel:SetSLToggle(false)
            UIForgeTransferPanel.mRolePanel = panel
            panel:ShowCloseButton(false)
            table.insert(self.mOpenPanel, panel)
            self:AfterOpenRole()
        end, roleData)
    else
        uimanager:ReShowPanel(UIForgeTransferPanel.mRolePanel)
        self:AfterOpenRole()
    end
end

function UIForgeTransferPanel:AfterOpenRole()
    self.mCurrentAutoChooseType = LuaEnumStrengthenType.Role
    self:ManageAutoChooseEquip(1)
    self:ManageAllData()
end

---切换到背包状态
function UIForgeTransferPanel:SwitchToBagPanel()
    self.HideOtherPanel(LuaEnumStrengthenType.Bag)
    if self.mBagPanel == nil or CS.StaticUtility.IsNull(self.mBagPanel.go) then
        uimanager:CreatePanel("UIBagPanel", function(panel)
            self.mBagPanel = panel
            table.insert(self.mOpenPanel, panel)
            self:ManageAllData()
        end, { type = LuaEnumBagType.Transfer })
    else
        uimanager:ReShowPanel(self.mBagPanel)
        self:ManageAllData()
    end
end

---切换到灵兽状态
function UIForgeTransferPanel:SwitchToServantPanel()
    UIForgeTransferPanel.HideOtherPanel(LuaEnumStrengthenType.YuanLing)
    if UIForgeTransferPanel.mServantPanel == nil or CS.StaticUtility.IsNull(UIForgeTransferPanel.mServantPanel.go) then
        local servantData = {}
        servantData.topOpenType = LuaEnumServantPanelType.BasePanel
        servantData.openServantPanelType = LuaEnumPanelOpenSourceType.ByStrengthenPanel
        servantData.ServantHead = luaComponentTemplates.UIForgeTransferPanel_ServantHead
        ---@type UIForgeTransferPanel_ServantBase
        servantData.BaseTemplate = luaComponentTemplates.UIForgeTransferPanel_ServantBase
        uimanager:CreatePanel("UIServantPanel", function(panel)
            UIForgeTransferPanel.mServantPanel = panel
            panel:ShowOtherButton(false)
            table.insert(UIForgeTransferPanel.mOpenPanel, panel)
            self:AfterOpenServant()
        end, servantData)
    else
        uimanager:ReShowPanel(UIForgeTransferPanel.mServantPanel)
        self:AfterOpenServant()
    end
end

function UIForgeTransferPanel:AfterOpenServant()
    self.mCurrentAutoChooseType = LuaEnumStrengthenType.YuanLing
    self:ManageAutoChooseEquip(1)
    self:ManageAllData()
end

---隐藏其他界面
function UIForgeTransferPanel.HideOtherPanel(type)
    if UIForgeTransferPanel.mRolePanel and type ~= LuaEnumStrengthenType.Role then
        uimanager:HidePanel(UIForgeTransferPanel.mRolePanel)
    end
    if UIForgeTransferPanel.mServantPanel and type ~= LuaEnumStrengthenType.YuanLing then
        uimanager:HidePanel(UIForgeTransferPanel.mServantPanel)
    end
    if UIForgeTransferPanel.mBagPanel and type ~= LuaEnumStrengthenType.Bag then
        uimanager:HidePanel(UIForgeTransferPanel.mBagPanel)
    end
end

---关闭界面
function UIForgeTransferPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIForgeTransferPanel")
end

---点击金币信息
function UIForgeTransferPanel.OnGoldButtonClicked()
    if UIForgeTransferPanel.needItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UIForgeTransferPanel.needItemInfo })
    end
end

---系统说明按钮
function UIForgeTransferPanel.OnHelpBtnClicked()
    local info
    local isFind = nil
    isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(36)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---点击Add
function UIForgeTransferPanel:OnAddButtonClicked(go)
    if (UIForgeTransferPanel.needItemInfo ~= nil) then
        local coinID = UIForgeTransferPanel.needItemInfo.id;
        Utility.ShowItemGetWay(coinID, go, LuaEnumWayGetPanelArrowDirType.Down);
    end
end

---转移按钮
function UIForgeTransferPanel.OnTransferButtonClicked()
    if (not UIForgeTransferPanel.GetAddButton_GameObject().activeSelf) then
        if UIForgeTransferPanel.mOriginEquipInfo ~= nil and UIForgeTransferPanel.mAimEquipInfo ~= nil then
            if UIForgeTransferPanel.mOriginEquipInfo.intensify > UIForgeTransferPanel.mAimEquipInfo.intensify then
                local originID = UIForgeTransferPanel.GetTransferID(UIForgeTransferPanel.mOriginEquipType, UIForgeTransferPanel.mOriginEquipInfo)
                local aimID = UIForgeTransferPanel.GetTransferID(UIForgeTransferPanel.mAimEquipType, UIForgeTransferPanel.mAimEquipInfo)
                networkRequest.ReqIntensifyTransfer(originID, aimID)
            else
                CS.Utility.ShowTips("只能将高星装备转换给低星装备")
            end
        end
    else
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = UIForgeTransferPanel.GetTransferButton_GameObject().transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 246;
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIForgeTransferPanel";
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end
end

---获取物品转移ID
function UIForgeTransferPanel.GetTransferID(type, bagItemInfo)
    local id = 0
    if type == LuaEnumStrengthenType.Bag then
        id = bagItemInfo.lid
    elseif type == LuaEnumStrengthenType.Role then
        id = bagItemInfo.index * (-1)
    elseif type == LuaEnumStrengthenType.YuanLing then
        id = bagItemInfo.index * (-1)
    end
    return id
end

---点击物品
function UIForgeTransferPanel:OnItemClicked(BagItemInfo, ItemType)
    if BagItemInfo == nil or BagItemInfo == UIForgeTransferPanel.mOriginEquipInfo or BagItemInfo == UIForgeTransferPanel.mAimEquipInfo then
        return
    end

    if UIForgeTransferPanel.mOriginEquipInfo == nil then
        --左边是空的
        if BagItemInfo.intensify == 0 then
            CS.Utility.ShowTips("无星级装备不能转移")
        else
            UIForgeTransferPanel:ReplaceOriginItem(BagItemInfo, ItemType)
            --直接放到左边
            UIForgeTransferPanel.GetOriginEquipTemplate():RefreshItem(UIForgeTransferPanel.mOriginEquipInfo, LuaEnumForgeTransferType.Normal)
        end
    else
        --左边是非空的

        --比较星级
        if BagItemInfo.intensify >= UIForgeTransferPanel.mOriginEquipInfo.intensify then
            CS.Utility.ShowTips("只能将高星装备转换给低星装备")
            return
        end

        if UIForgeTransferPanel.mAimEquipInfo == nil then
            --右边是空的
            UIForgeTransferPanel:ReplaceAimItem(BagItemInfo, ItemType)
            UIForgeTransferPanel.GetAimEquipTemplate():RefreshItem(UIForgeTransferPanel.mAimEquipInfo, LuaEnumForgeTransferType.Normal)

        else
            --右边是非空的
            if BagItemInfo.intensify < UIForgeTransferPanel.mOriginEquipInfo.intensify then
                --比左边低（换右边）
                UIForgeTransferPanel:ReplaceAimItem(BagItemInfo, ItemType)
                UIForgeTransferPanel.GetAimEquipTemplate():RefreshItem(UIForgeTransferPanel.mAimEquipInfo, LuaEnumForgeTransferType.Normal)
            else
                --比左边高（换左边）
                UIForgeTransferPanel:ReplaceOriginItem(BagItemInfo, ItemType)
                UIForgeTransferPanel.GetOriginEquipTemplate():RefreshItem(UIForgeTransferPanel.mOriginEquipInfo, LuaEnumForgeTransferType.Normal)
            end
        end
    end
    if UIForgeTransferPanel.mOriginEquipInfo ~= nil and UIForgeTransferPanel.mAimEquipInfo ~= nil then
        UIForgeTransferPanel.RefreshPanel()
        UIForgeTransferPanel.GetTransferIntensify_GameObject():SetActive(true)
        UIForgeTransferPanel.GetOriginIntensify_UILabel().text = "[dde6eb]" .. UIForgeTransferPanel.mOriginEquipInfo.intensify
        UIForgeTransferPanel.GetOriginTransferIntensify_UILabel().text = "[dde6eb]" .. UIForgeTransferPanel.mAimEquipInfo.intensify
        UIForgeTransferPanel.GetAimIntensify_UILabel().text = "[e85038]" .. 0
        UIForgeTransferPanel.GetAimTransferIntensify_UILabel().text = "[00ff00]" .. UIForgeTransferPanel.mOriginEquipInfo.intensify
    end
    UIForgeTransferPanel:RefreshData()
end

---装备替换
---@param bagItemInfo
---替换原始装备
function UIForgeTransferPanel:ReplaceOriginItem(bagItemInfo, ItemType)
    self.mOriginEquipInfo = bagItemInfo
    self.mOriginEquipType = ItemType
    self:ManageAllData()
end

---替换目标装备
function UIForgeTransferPanel:ReplaceAimItem(bagItemInfo, ItemType)
    self.mAimEquipInfo = bagItemInfo
    self.mAimEquipType = ItemType
    self:ManageAllData()
end

---重置显示
function UIForgeTransferPanel:RefreshData()
    local originLid = nil
    if UIForgeTransferPanel.mOriginEquipInfo then
        originLid = UIForgeTransferPanel.mOriginEquipInfo.lid
    end
    luaEventManager.DoCallback(LuaCEvent.OriginTransferBagItemChange, originLid)
    local aimLid = nil
    if UIForgeTransferPanel.mAimEquipInfo then
        aimLid = UIForgeTransferPanel.mAimEquipInfo.lid
    end
    luaEventManager.DoCallback(LuaCEvent.AimTransferBagItemChange, aimLid)
    UIForgeTransferPanel.ShowFinish(UIForgeTransferPanel.mOriginEquipInfo ~= nil and UIForgeTransferPanel.mAimEquipInfo ~= nil)
    local showInfo = UIForgeTransferPanel.mChooseLeft
    if UIForgeTransferPanel.mOriginEquipInfo == nil then
        ---左边为空
        UIForgeTransferPanel.GetOriginEquipTemplate():RefreshItem(nil, LuaEnumForgeTransferType.Add)
        if UIForgeTransferPanel.mAimEquipInfo == nil then
            ---右边为空
            UIForgeTransferPanel.GetAimEquipTemplate():RefreshItem(nil, LuaEnumForgeTransferType.Lock)
        end
    else
        ---左边不为空
        if UIForgeTransferPanel.mAimEquipInfo == nil then
            ---右边为空
            UIForgeTransferPanel.GetAimEquipTemplate():RefreshItem(nil, LuaEnumForgeTransferType.Add)
            showInfo = UIForgeTransferPanel.mChooseRight
        end
    end
    UIForgeTransferPanel.GetUnFinish_UILabel().text = showInfo
end

---刷新是否选中结束显示
function UIForgeTransferPanel.ShowFinish(isFinish)
    UIForgeTransferPanel.GetFinishShow_GameObject():SetActive(isFinish)
    UIForgeTransferPanel.GetUnFinishShow_GameObject():SetActive(not isFinish)
end

---点击原始装备
function UIForgeTransferPanel:OnOriginEquipClicked()
    if UIForgeTransferPanel.mOriginEquipInfo == nil then
        return
    end

    self:ReplaceOriginItem()
    UIForgeTransferPanel.mOriginEquipInfo = nil
    UIForgeTransferPanel.mOriginEquipType = nil
    UIForgeTransferPanel.mOriginTemplate = nil

    UIForgeTransferPanel:RefreshData()

end

---点击目标装备
function UIForgeTransferPanel:OnAimEquipClicked()
    if UIForgeTransferPanel.mAimEquipInfo == nil then
        return
    end
    self:ReplaceAimItem()
    UIForgeTransferPanel.mAimEquipInfo = nil
    UIForgeTransferPanel.mAimEquipType = nil
    UIForgeTransferPanel.mAimEquipTemplate = nil
    UIForgeTransferPanel:RefreshData()
end

---初始化界面显示
function UIForgeTransferPanel:InitPanel()
    local res1, intensifyInfo = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(0)
    if res1 then
        local costInfo = intensifyInfo.transferResource.list
        if costInfo ~= nil then
            local res2, spriteInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(costInfo[0])
            UIForgeTransferPanel.needItemInfo = spriteInfo
            if res2 then
                UIForgeTransferPanel.GetGoldIcon_UISprite().spriteName = spriteInfo.icon
            end
        end
    end
end

---刷新界面显示
function UIForgeTransferPanel.RefreshPanel()
    if UIForgeTransferPanel.mOriginEquipInfo == nil then
        return
    end
    local bagItemInfo = UIForgeTransferPanel.mOriginEquipInfo
    local res, intensifyInfo = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(bagItemInfo.intensify)
    if res then
        local costInfo = intensifyInfo.transferResource.list
        local costResourceNum = costInfo[1]
        if costInfo ~= nil then
            local res2, spriteInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(costInfo[0])
            UIForgeTransferPanel.needItemInfo = spriteInfo
            if res2 then
                UIForgeTransferPanel.GetGoldIcon_UISprite().spriteName = spriteInfo.icon
            end
        end
        ---判断资源数够不够
        local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
        local value = bagInfo:GetCoinAmount(costInfo[0])
        if costResourceNum then
            local color
            if value >= costResourceNum then
                color = "[00ff00]"
                UIForgeTransferPanel.GetAddButton_GameObject():SetActive(false)
            else
                color = "[e85038]"
                UIForgeTransferPanel.GetAddButton_GameObject():SetActive(true)
            end
            ---显示资源
            UIForgeTransferPanel.GetGold_UILabel().text = color .. value .. "[dde6eb]/" .. costResourceNum
        end
    end
end

---判断灵兽页签是否开启
function UIForgeTransferPanel:RefreshServantButtonShow()
    local isShowServantButton = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsOpenServantStrength()
    if CS.StaticUtility.IsNull(self:GetServantButton_UIToggle().gameObject) == false then
        self:GetServantButton_UIToggle().gameObject:SetActive(isShowServantButton)
    end
end
--endregion

--region 设置选中道具
---管理自动选中
---sign 标记是否更改原始选中
function UIForgeTransferPanel:ManageAutoChooseEquip(sign)
    if self.mCurrentAutoChooseType == nil then
        return
    end
    if self.mCurrentAutoChooseType == LuaEnumStrengthenType.Role then
        if self.mRolePanel == nil or CS.StaticUtility.IsNull(self.mRolePanel.go) then
            return
        end
    elseif self.mCurrentAutoChooseType == LuaEnumStrengthenType.YuanLing then
        if self.mServantPanel == nil or CS.StaticUtility.IsNull(self.mServantPanel.go) then
            return
        end
    end
    if self.mManualChooseData then

        local bagEquip = self.mManualChooseData.mBagEquip
        local bodyEquip = self.mManualChooseData.mBodyEquip
        local isServant = self.mCurrentAutoChooseType == LuaEnumStrengthenType.YuanLing
        local servantIndex = self.mManualChooseData.mServantEquipIndex
        self:ManualChooseTransferEquip(bagEquip, bodyEquip, isServant, servantIndex)
        self.mManualChooseData = nil
        return
    end
    if self.mCurrentAutoChooseType == LuaEnumStrengthenType.Role then
        self:AutoChooseTransferEquip(sign)
    elseif self.mCurrentAutoChooseType == LuaEnumStrengthenType.YuanLing then
        self:AutoChooseTransferServantEquip(sign)
    end
end

---自动选择转移装备
function UIForgeTransferPanel:AutoChooseTransferEquip(needRefreshOrigin)
    local bagMaxStarItem = self:ChooseBagMaxStarEquip()
    local bodyMinStarItem = self:ChooseBodyMinStarEquip()
    if self.mOriginEquipInfo and self.mOriginEquipInfo.intensify < bodyMinStarItem.intensify then
        needRefreshOrigin = nil
    end
    if needRefreshOrigin == nil then
        self:OnOriginEquipClicked()
        self:OnAimEquipClicked()
    end
    if bagMaxStarItem and bodyMinStarItem then
        if bagMaxStarItem.intensify > bodyMinStarItem.intensify then
            if self.mOriginEquipInfo == nil or needRefreshOrigin == nil then
                self:ChooseBagEquip(bagMaxStarItem)
            end
            self:ChooseBodyEquip(bodyMinStarItem)
        end
    end
end

---自动选择灵兽装备
function UIForgeTransferPanel:AutoChooseTransferServantEquip(needRefreshOrigin)
    local bagMaxStarItem = self:ChooseBagMaxStarEquip()
    local bodyMinStarItem = self:ChooseServantMinStarEquip()
    if bagMaxStarItem == nil or bodyMinStarItem == nil then
        return
    end

    if self.mOriginEquipInfo and self.mOriginEquipInfo.intensify < bodyMinStarItem.intensify then
        needRefreshOrigin = nil
    end
    if needRefreshOrigin == nil then
        self:OnOriginEquipClicked()
        self:OnAimEquipClicked()
    end

    if bagMaxStarItem and bodyMinStarItem then
        if bagMaxStarItem.intensify > bodyMinStarItem.intensify then
            if self.mOriginEquipInfo == nil or needRefreshOrigin == nil then
                self:ChooseBagEquip(bagMaxStarItem)
            end
            if self.mOriginEquipInfo and self.mOriginEquipInfo.intensify > bodyMinStarItem.intensify then
                self:ChooseServantEquip(bodyMinStarItem)
            end
        end
    end
end

---选中角色装备
---@param pos number 位置 1原始装备/2目标装备
function UIForgeTransferPanel:ChooseBodyEquip(bagItemInfo)
    self:OnItemClicked(bagItemInfo, LuaEnumStrengthenType.Role)
end

---选中背包装备
---@param pos number 位置 1原始装备/2目标装备
function UIForgeTransferPanel:ChooseBagEquip(bagItemInfo)
    self:OnItemClicked(bagItemInfo, LuaEnumStrengthenType.Bag)
end

---选中灵兽装备
---@param pos number 位置 1原始装备/2目标装备
function UIForgeTransferPanel:ChooseServantEquip(bagItemInfo)
    self:OnItemClicked(bagItemInfo, LuaEnumStrengthenType.YuanLing)
end

---@return bagV2.BagItemInfo
function UIForgeTransferPanel:ChooseBagMaxStarEquip()
    if self:GetBagInfoV2() then
        ---@type bagV2.BagItemInfo
        local maxStarEquip
        local bagList = self:GetBagInfoV2():GetBagItemList()
        if bagList and bagList.Count > 0 then
            maxStarEquip = bagList[0]
            for i = 0, bagList.Count - 1 do
                ---@type bagV2.BagItemInfo
                local bagItemInfo = bagList[i]
                local canStrength = self:GetBagInfoV2():CanItemStrength(bagItemInfo)
                if canStrength then
                    if maxStarEquip == nil or (bagItemInfo.intensify > maxStarEquip.intensify) then
                        maxStarEquip = bagItemInfo
                    end
                end
            end
        end
        return maxStarEquip
    end
end

---@return bagV2.BagItemInfo
function UIForgeTransferPanel:ChooseBodyMinStarEquip()
    if self:GetEquipInfoV2() then
        local minStarEquip
        local equipList = self:GetEquipInfoV2().Equips
        for k, v in pairs(equipList) do
            local canStrength = self:GetBagInfoV2():CanItemStrength(v)
            if canStrength and v.index < 1000 then
                if minStarEquip == nil or (v.intensify < minStarEquip.intensify) then
                    minStarEquip = v
                end
            end
        end
        return minStarEquip
    end
end

---@return bagV2.BagItemInfo
function UIForgeTransferPanel:ChooseServantMinStarEquip()
    if self:GetServantInfoV2() then
        local minStarEquip
        local equipList = self:GetServantInfoV2().ServantEquip
        for k, v in pairs(equipList) do
            local canStrength = self:GetBagInfoV2():CanItemStrength(v)
            if canStrength then
                if minStarEquip == nil or (v.intensify < minStarEquip.intensify) then
                    minStarEquip = v
                end
            end
        end
        return minStarEquip
    end
end

---管理所有界面选中
function UIForgeTransferPanel:ManageAllData()
    if self.mCurrentPanelType == LuaEnumStrengthenType.Role then
        self:ManageRolePanelChoose()
    elseif self.mCurrentPanelType == LuaEnumStrengthenType.Bag then
        self:ManageBagPanelChoose()
    elseif self.mCurrentPanelType == LuaEnumStrengthenType.YuanLing then
        self:ManageServantPanelChoose()
    end
    self:RefreshData()
end

---管理角色界面选中
function UIForgeTransferPanel:ManageRolePanelChoose()
    if self.mEquipIndexToChoose then
        for k, v in pairs(self.mEquipIndexToChoose) do
            if v then
                self:ChooseRolePanelItem(k, false)
            end
        end
    end
    if self.mOriginEquipType == LuaEnumStrengthenType.Role and self.mOriginEquipInfo then
        self:ChooseRolePanelItem(self.mOriginEquipInfo.index, true)
    end
    if self.mAimEquipType == LuaEnumStrengthenType.Role and self.mAimEquipInfo then
        self:ChooseRolePanelItem(self.mAimEquipInfo.index, true)
    end
end

---设置角色界面选中
function UIForgeTransferPanel:ChooseRolePanelItem(index, isChoose)
    if self.mCurrentPanelType ~= LuaEnumStrengthenType.Role or self.mRolePanel == nil or CS.StaticUtility.IsNull(self.mRolePanel.go) then
        return
    end
    self.mRolePanel.equipShow:SetItemChoose(index, isChoose)
    if self.mEquipIndexToChoose == nil then
        self.mEquipIndexToChoose = {}
    end
    self.mEquipIndexToChoose[index] = isChoose
end

---管理背包界面选中
function UIForgeTransferPanel:ManageBagPanelChoose()
    if self.mOriginEquipType == LuaEnumStrengthenType.Bag and self.mOriginEquipInfo then
        luaEventManager.DoCallback(LuaCEvent.OriginTransferBagItemChange, self.mOriginEquipInfo.lid)
    end
    if self.mAimEquipType == LuaEnumStrengthenType.Bag and self.mAimEquipInfo then
        luaEventManager.DoCallback(LuaCEvent.AimTransferBagItemChange, self.mAimEquipInfo.lid)
    end
end

---管理灵兽界面选中
function UIForgeTransferPanel:ManageServantPanelChoose()
    if self.mServantLidToChoose then
        for k, v in pairs(self.mServantLidToChoose) do
            if v then
                self:ChooseServantPanelItem(k, false)
            end
        end
    end
    if self.mOriginEquipType == LuaEnumStrengthenType.YuanLing and self.mOriginEquipInfo then
        self:ChooseServantPanelItem(self.mOriginEquipInfo.lid, true)
    end
    if self.mAimEquipType == LuaEnumStrengthenType.YuanLing and self.mAimEquipInfo then
        self:ChooseServantPanelItem(self.mAimEquipInfo.lid, true)
    end
end

---设置灵兽界面选中
function UIForgeTransferPanel:ChooseServantPanelItem(lid, isChoose)
    if self.mCurrentPanelType ~= LuaEnumStrengthenType.YuanLing or self.mServantPanel == nil or CS.StaticUtility.IsNull(self.mServantPanel.go) then
        return
    end
    self.mServantPanel:SetTransferItemChoose(lid, isChoose)
    if self.mServantLidToChoose == nil then
        self.mServantLidToChoose = {}
    end
    self.mServantLidToChoose[lid] = isChoose
end

---手动选择转移装备
function UIForgeTransferPanel:ManualChooseTransferEquip(bagItem, bodyEquip, isServant, servantIndex)
    if bagItem and bodyEquip then
        self:ChooseBagEquip(bagItem)
        if isServant then
            local res, newBodyEquip = self:GetServantInfoV2().ServantEquip:TryGetValue(servantIndex)
            if res then
                self:ChooseServantEquip(newBodyEquip)
            end
        else
            local newEquipIndex = self:GetEquipInfoV2():GetEquipIndexByEquip(bodyEquip)
            local res, newBodyEquip = self:GetEquipInfoV2().Equips:TryGetValue(newEquipIndex)
            if res then
                self:ChooseBodyEquip(newBodyEquip)
            end
        end
    end
end
--endregion

--region 特效
---显示成功特效
function UIForgeTransferPanel.ShowWinEffect()
    if UIForgeTransferPanel.mWinEffect == nil then
        if not CS.StaticUtility.IsNull(UIForgeTransferPanel.GetEffectRoot_GameObject()) then
            CS.CSResourceManager.Singleton:AddQueueCannotDelete("700008", CS.ResourceType.UIEffect, function(res)
                if res ~= nil then
                    if CS.StaticUtility.IsNull(UIForgeTransferPanel.GetEffectRoot_GameObject()) then
                        return
                    end
                    UIForgeTransferPanel.winEffectPool = res:GetUIPoolItem()
                    if UIForgeTransferPanel.winEffectPool == nil then
                        return
                    end
                    UIForgeTransferPanel.mWinEffect = UIForgeTransferPanel.winEffectPool.go
                    if UIForgeTransferPanel.mWinEffect then
                        UIForgeTransferPanel.mWinEffect.transform.parent = UIForgeTransferPanel.GetEffectRoot_GameObject().transform
                        UIForgeTransferPanel.mWinEffect.transform.localPosition = CS.UnityEngine.Vector3.zero
                        UIForgeTransferPanel.mWinEffect.transform.localScale = CS.UnityEngine.Vector3(125, 125, 125)
                        UIForgeTransferPanel.mWinEffect:SetActive(true)
                    end
                end
            end
            , CS.ResourceAssistType.UI)
        end
    else
        UIForgeTransferPanel.mWinEffect:SetActive(false)
        UIForgeTransferPanel.mWinEffect:SetActive(true)
    end
end
--endregion

--region onDestroy
function ondestroy()
    for i = 1, #UIForgeTransferPanel.mOpenPanel do
        local panel = UIForgeTransferPanel.mOpenPanel[i]
        if panel and CS.StaticUtility.IsNull(panel.go) == false then
            uimanager:ClosePanel(panel)
        end
    end
end
--endregion

return UIForgeTransferPanel