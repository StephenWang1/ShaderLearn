---装备维修
---@class UIRepairPanel:UIBase
local UIRepairPanel = {}

local Utility = Utility

local IsNullFunction = CS.StaticUtility.IsNull

--region  局部变量定义
---背包和身上装备显示格子数目
UIRepairPanel.mGridCount = 16

---选中装备修理需要花费
UIRepairPanel.mRepairCost = nil

--- 角色面板
---@type UIRolePanel
UIRepairPanel.mRolePanel = nil

---背包面板
UIRepairPanel.mBagPanel = nil

---灵兽面板
UIRepairPanel.mServantPanel = nil

---当前面板状态
UIRepairPanel.mCurrentPanel = nil

---需要维修列表
UIRepairPanel.mNeedRepairList = nil

---玩家道具数量
---@type number
UIRepairPanel.mPlayerItemNum = 0

---当前玩家设置耐久度
---@type number
UIRepairPanel.mCurrentAutoRepairRoleLasting = nil

---当前玩家设置耐久度
---@type number
UIRepairPanel.mCurrentAutoRepairBagLasting = nil

---当前玩家设置耐久度自动维修灵兽耐久度
---@type number
UIRepairPanel.mCurrentAutoRepairServantLasting = nil

---存储当前页是否被刷新
UIRepairPanel.mPageToRefresh = {}

---@type table<UnityEngine.GameObject,UIRepairGridItem>
---存储格子对应模板
UIRepairPanel.GoToTemplate = {}

---@type table<number,table>
UIRepairPanel.mLastingSettingGoToInfo = {}

---设置当前总页数
UIRepairPanel.mCurrentTotalPage = nil

---页数对应Sprite
UIRepairPanel.mPageGoToSprite = {}

---当前页
UIRepairPanel.mCurrentPage = nil

---当前选中比例
UIRepairPanel.mCurrentChooseRate = nil

---维修消费道具
UIRepairPanel.mRepairCostGoldItemId = LuaEnumCoinType.JinBi

---@type table<number,number>
---锻造货币id对应数量
UIRepairPanel.ShowCoinList = {}

---@type string
---道具不足提示
UIRepairPanel.CurrentMoneyNotEnoughDes = nil

---月卡信息类型不详
UIRepairPanel.CommerceMonthCardInfo = nil

---存储装备类型
UIRepairPanel.mEquipType = {
    luaEnumRepairType.Role,
    luaEnumRepairType.Servant,
    luaEnumRepairType.Divine,
}
--endregion

--region 组件
---关闭按钮
function UIRepairPanel:GetCloseButton_GameObject()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/event/Btn_Close", "GameObject")
    end
    return self.mCloseButton
end

---维修按钮
function UIRepairPanel:GetRepairButton_GameObject()
    if self.mRepairButton == nil then
        self.mRepairButton = self:GetCurComp("WidgetRoot/event/Btn_repair", "GameObject")
    end
    return self.mRepairButton
end

---添加按钮
function UIRepairPanel:GetAddButton_GameObject()
    if self.mAddButton == nil then
        self.mAddButton = self:GetCurComp("WidgetRoot/event/Btn_add", "GameObject")
    end
    return self.mAddButton
end

---玩家金币Lable
function UIRepairPanel:GetGoldLabel_UILabel()
    if self.mGoldLabel == nil then
        self.mGoldLabel = self:GetCurComp("WidgetRoot/view/coininfo/gold", "UILabel")
    end
    return self.mGoldLabel
end

---维修消耗道具图片
function UIRepairPanel:GetGoldIcon_UISprite()
    if self.mGoldIcon == nil then
        self.mGoldIcon = self:GetCurComp("WidgetRoot/view/coininfo/gold/img", "UISprite")
    end
    return self.mGoldIcon
end

---@return UIGridContainer 选中页数显示
function UIRepairPanel:GetShowPage_UIGridContainer()
    if self.mChoosePageGrid == nil then
        self.mChoosePageGrid = UIRepairPanel:GetCurComp("WidgetRoot/view/grid", "UIGridContainer")
    end
    return self.mChoosePageGrid
end

---@return UIToggle 背包按钮
function UIRepairPanel:GetBagButton_UIToggle()
    if self.mBagToggle == nil then
        self.mBagToggle = self:GetCurComp("WidgetRoot/event/btn_bag", "UIToggle")
    end
    return self.mBagToggle
end

---@return UIToggle 角色按钮
function UIRepairPanel:GetRoleButton_UIToggle()
    if self.mRoleToggle == nil then
        self.mRoleToggle = self:GetCurComp("WidgetRoot/event/btn_role", "UIToggle")
    end
    return self.mRoleToggle
end

---@return UIToggle 灵兽按钮
function UIRepairPanel:GetServantButton_UIToggle()
    if self.mServantToggle == nil then
        self.mServantToggle = self:GetCurComp("WidgetRoot/event/btn_servant", "UIToggle")
    end
    return self.mServantToggle
end

---设置按钮
function UIRepairPanel:GetConfigButton_GameObject()
    if self.mConfigButton == nil then
        self.mConfigButton = self:GetCurComp("WidgetRoot/event/Btn_config", "GameObject")
    end
    return self.mConfigButton
end

---设置Root
function UIRepairPanel:GetConfigRoot_GameObject()
    if UIRepairPanel.mConfigRoot == nil then
        UIRepairPanel.mConfigRoot = UIRepairPanel:GetCurComp("WidgetRoot/view/Config", "GameObject")
    end
    return UIRepairPanel.mConfigRoot
end

---设置GridContainer
function UIRepairPanel:GetConfigList_GridContainer()
    if self.mConfigContainer == nil then
        self.mConfigContainer = self:GetCurComp("WidgetRoot/view/Config/ConfigList", "UIGridContainer")
    end
    return self.mConfigContainer
end

---设置界面标题
function UIRepairPanel:GetConfigTitle_UILabel()
    if self.mConfigTitle == nil then
        self.mConfigTitle = UIRepairPanel:GetCurComp("WidgetRoot/view/Config/Title", "UILabel")
    end
    return self.mConfigTitle
end

---折扣显示内容
---@return UILabel
function UIRepairPanel:GetOnSale_UILabel()
    if self.mOnSale_GameObject == nil then
        self.mOnSale_GameObject = UIRepairPanel:GetCurComp("WidgetRoot/view/Label2/onSale", "UILabel")
    end
    return self.mOnSale_GameObject
end

---@return UIPageRecyclingContainerForGameObject 获取维修控制器
function UIRepairPanel:GetRepairCycleController()
    if self.mCycleController == nil then
        self.mCycleController = self:GetCurComp("WidgetRoot/view/Repair/Scroll View/UIGrid", "UIPageRecyclingContainerForGameObject")
    end
    return self.mCycleController
end

---@return UnityEngine.GameObject
function UIRepairPanel:GetRepairSuccess_G0()
    if self.mSuccessGo == nil then
        self.mSuccessGo = self:GetCurComp("WidgetRoot/event/top/effect", "GameObject")
    end
    return self.mSuccessGo
end

--region 花费道具
---@return UIGridContainer 维修货币列表显示
function UIRepairPanel:GetRepairCost_UIGridContainer()
    if self.mRepairCostContainer == nil then
        self.mRepairCostContainer = self:GetCurComp("WidgetRoot/view/scroll/Grid", "UIGridContainer")
    end
    return self.mRepairCostContainer
end

---@return UIScrollView
function UIRepairPanel:GetRepairCostScroll_UIScrollView()
    if self.mCostScrollView == nil then
        self.mCostScrollView = self:GetCurComp("WidgetRoot/view/scroll", "UIScrollView")
    end
    return self.mCostScrollView
end

--endregion

--region 红点
---@return UIRedPoint
function UIRepairPanel:GetRedPoint()
    if self.mRedPoint == nil then
        self.mRedPoint = self:GetCurComp("WidgetRoot/event/btn_servant/Red", "UIRedPoint")
    end
    return self.mRedPoint
end
--endregion

--endregion

--region属性
---@return CSPlayerInfo 玩家信息
function UIRepairPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSBagInfoV2 玩家背包信息
function UIRepairPanel:GetBagInfoV2()
    if self.mBagInfo == nil then
        if self:GetPlayerInfo() then
            self.mBagInfo = self:GetPlayerInfo().BagInfo
        end
    end
    return self.mBagInfo
end

---@return number 获取当前耐久度
function UIRepairPanel:GetCurrentLasting()
    if self.mCurrentPanel == luaEnumRepairType.Role then
        return self:GetRoleLastingSetting()
    elseif self.mCurrentPanel == luaEnumRepairType.Bag then
        return self:GeBagLastingSetting()
    end
end

---@return System.Array 获取角色设置耐久度
function UIRepairPanel:GetRoleLastingSetting()
    if self.mRoleLastingSetting == nil then
        self.mRoleLastingSetting = CS.Cfg_GlobalTableManager.Instance:GetAutoRepairRoleLasting()
    end
    return self.mRoleLastingSetting
end

---@return number 获取角色当前设置自动维修耐久度
function UIRepairPanel:GetAutoRepairRoleLasting()
    if self.AutoRepairRoleLasting == nil then
        if self:GetPlayerInfo() then
            self.AutoRepairRoleLasting = self:GetPlayerInfo().ConfigInfo:GetInt(CS.EConfigOption.AutoChooseRepairRole)
            if self.AutoRepairRoleLasting == nil and self:GetRoleLastingSetting() and self:GetRoleLastingSetting().Length > 0 then
                local normalInfo = self:GetRoleLastingSetting()[0]
                self.AutoRepairRoleLasting = normalInfo
                self:GetPlayerInfo().ConfigInfo:SetInt(CS.EConfigOption.AutoChooseRepairRole, normalInfo)
            end
        end
    end
    return self.AutoRepairRoleLasting
end

---@return System.Array 获取背包设置耐久度
function UIRepairPanel:GeBagLastingSetting()
    if self.mBagLastingSetting == nil then
        self.mBagLastingSetting = CS.Cfg_GlobalTableManager.Instance:GetAutoRepairBagLasting()
    end
    return self.mBagLastingSetting
end

---@return number 获取背包当前设置自动维修耐久度
function UIRepairPanel:GetAutoRepairBagLasting()
    if self.AutoRepairBagLasting == nil then
        if self:GetPlayerInfo() then
            self.AutoRepairBagLasting = self:GetPlayerInfo().ConfigInfo:GetInt(CS.EConfigOption.AutoChooseRepairBag)
            if self.AutoRepairBagLasting == nil and self:GeBagLastingSetting() and self:GeBagLastingSetting().Length > 0 then
                local normalInfo = self:GeBagLastingSetting()[0]
                self.AutoRepairBagLasting = normalInfo
                self:GetPlayerInfo().ConfigInfo:SetInt(CS.EConfigOption.AutoChooseRepairBag, normalInfo)
            end
        end
    end
    return self.AutoRepairBagLasting
end

---@return System.Array 获取灵兽可设置耐久度
function UIRepairPanel:GetServantLastingSetting()
    if self.mServantLastingSetting == nil then
        self.mServantLastingSetting = CS.Cfg_GlobalTableManager.Instance:GetAutoRepairServantEquipLasting()
    end
    return self.mServantLastingSetting
end

---@return number 获取灵兽当前设置自动维修耐久度
function UIRepairPanel:GetAutoRepairServantLasting()
    if self.AutoRepairServantLasting == nil then
        if self:GetPlayerInfo() then
            self.AutoRepairServantLasting = self:GetPlayerInfo().ConfigInfo:GetInt(CS.EConfigOption.AutoChooseRepairServant)
            if self.AutoRepairServantLasting == nil and self:GetServantLastingSetting() and self:GetServantLastingSetting().Length > 0 then
                local normalInfo = self:GetServantLastingSetting()[0]
                self.AutoRepairServantLasting = normalInfo
                self:GetPlayerInfo().ConfigInfo:SetInt(CS.EConfigOption.AutoChooseRepairServant, normalInfo)
            end
        end
    end
    return self.AutoRepairServantLasting
end

---@return number 获取背包灵兽可设置耐久度
function UIRepairPanel:GetBagServantLastingSetting()
    if self.mBagServantLastingSetting == nil then
        self.mBagServantLastingSetting = CS.Cfg_GlobalTableManager.Instance:GetAutoRepairBagServantEquipLasting()
    end
    return self.mBagServantLastingSetting
end

---@return string 维修装备货币不足提示描述
function UIRepairPanel:GetRepairCostUnEnoughTipsInfo()
    if self.mRepairUnEnoughInfo == nil and self:GetCoinItemInfo() then
        local tableInfo = self:GetBubbleInfo(37)
        self.mRepairUnEnoughInfo = string.gsub(tableInfo.content, '{0}', self:GetCoinItemInfo().name)
    end
    return self.mRepairUnEnoughInfo
end

---获取二次确认tips信息
function UIRepairPanel:GetSureTipsInfo()
    if self.mRepairTips == nil then
        self.mRepairTips = self:GetPromptTipsInfo(1)
    end
    return self.mRepairTips
end

---@return TABLE.CFG_ITEMS 货币信息
function UIRepairPanel:GetCoinItemInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mRepairCostGoldItemId)
    end
    return self.mCoinInfo
end
--endregion

--region 初始化
function UIRepairPanel:Init()
    self:BindEvents()
    self:BindMessage()
    self:AddRedPoint()
    self:HideExtra()
end

function UIRepairPanel:Show()
    local bagPanel = uimanager:GetPanel("UIBagPanel")
    if bagPanel and CS.StaticUtility.IsNull(bagPanel.go) == false then
        uimanager:ClosePanel("UIBagPanel")
    end
    self:GetRoleButton_UIToggle():Set(true)
    self:RefreshPanelShow()
end

function UIRepairPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetRepairButton_GameObject()).onClick = function()
        self:OnRepairButtonClicked()
    end
    --  CS.UIEventListener.Get(self:GetAddButton_GameObject()).onClick = function()
    --     self:OnAddButtonClicked()
    -- end
    --  CS.UIEventListener.Get(self:GetGoldLabel_UILabel().gameObject).onClick = function()
    --     self:OnYuanBaoLBClicked()
    -- end
    CS.EventDelegate.Add(self:GetRoleButton_UIToggle().onChange, function()
        if self:GetRoleButton_UIToggle().value then
            self:SwitchToRolePanel()
        end
    end)
    CS.EventDelegate.Add(self:GetBagButton_UIToggle().onChange, function()
        if self:GetBagButton_UIToggle().value then
            self:SwitchToBagPanel()
        end
    end)
    CS.EventDelegate.Add(self:GetServantButton_UIToggle().onChange, function()
        if self:GetServantButton_UIToggle().value then
            self:SwitchToServantPanel()
        end
    end)
end

function UIRepairPanel:BindMessage()
    UIRepairPanel.RepairChooseListFunc = function(msgId, repairList)
        self:OnRepairChooseListChange(repairList)
    end
    UIRepairPanel.mEquipRepairFinish = function()
        self:EquipRepairFinishFunc()
    end
    UIRepairPanel.OnMainBagClicked = function()
        self:OnMainBagClickedFunc()
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairChooseListChange, UIRepairPanel.RepairChooseListFunc)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UIRepairPanel.OnMainBagClicked)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_NPCLeaveView, UIRepairPanel.NPCLeaveView)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshMoney()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRepairEquipMessage, UIRepairPanel.mEquipRepairFinish)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRepairServantEquipMessage, UIRepairPanel.mEquipRepairFinish)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RolePanelChangeToDivineEquipState, function()
        if self.mRolePanel and IsNullFunction(self.mRolePanel.go) == false then
            local state = self.mRolePanel:GetCurrentPanelState()
            if state == LuaEquipmentListType.Base then
                self:SwitchToRolePanel()
            else
                self:ChangeToDivineState()
            end
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairSLEquipGridClicked, function(msgId, bagItemInfo)
        self:OnSLEquipGridClicked(bagItemInfo)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairChooseItemChange, function(msgId, bagItemInfo)
        self:OnRepairChooseItemChange(bagItemInfo)
    end)
end

---新功能需要隐藏的按钮
function UIRepairPanel:HideExtra()
    self:GetServantButton_UIToggle().gameObject:SetActive(false)
end
--endregion

--region获取数据
---初始化数据
function UIRepairPanel:RefreshPanelShow()
    if self:GetCoinItemInfo() then
        -- self:GetGoldIcon_UISprite().spriteName = self:GetCoinItemInfo().icon
    end
    self:RefreshMoney()
    self:RefreshDiscount()
end

---获取prompt表格数据
function UIRepairPanel:GetPromptTipsInfo(id)
    local res, showInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(id)
    if res then
        return showInfo
    end
    return nil
end

---获取PromptFrame表数据
function UIRepairPanel:GetBubbleInfo(id)
    local res1, bubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
    if res1 then
        return bubbleInfo
    end
end
--endregion

--region 服务器事件
---NPC离开视野
function UIRepairPanel.NPCLeaveView(id, data)
    if data == LuaEnumNPCType.Repair then
        uimanager:ClosePanel('UIRepairPanel')
    end
end

---装备维修完成
function UIRepairPanel:EquipRepairFinishFunc()
    self:GetNewData(self.mCurrentPanel)
    self:GetRepairSuccess_G0():SetActive(false)
    self:GetRepairSuccess_G0():SetActive(true)
    self:RefreshAllSLEquip()
end
--endregion

--region客户端事件
---收到背包维修选中列表改变消息刷新维修显示
---@param repairList table 需要维修列表
function UIRepairPanel:OnRepairChooseListChange(repairList)
    if repairList then
        self.mNeedRepairList = repairList
        self:InitializePageRecycling()
        self:ShowCoinInfo()
    end
end

---主界面背包点击
function UIRepairPanel:OnMainBagClickedFunc()
    self:GetBagButton_UIToggle():Set(true)
end
--endregion

--region灵兽
---打开灵兽界面
function UIRepairPanel:SwitchToServantPanel()
    if self.mCurrentPanel == luaEnumRepairType.Servant then
        return
    end
    uimanager:HidePanel(self.mBagPanel)
    uimanager:HidePanel(self.mRolePanel)

    self.mCurrentPanel = luaEnumRepairType.Servant
    if self.mServantPanel and not CS.StaticUtility.IsNull(self.mServantPanel.go) then
        uimanager:ReShowPanel(self.mServantPanel)
        self:GetNewData(luaEnumRepairType.Servant)
    else
        local customData = {}
        customData.BaseTemplate = luaComponentTemplates.UIServantPanel_Base_Repair
        customData.ServantHead = luaComponentTemplates.UIServantHeadTemplate_Repair
        customData.topOpenType = LuaEnumServantPanelType.BasePanel
        uimanager:CreatePanel("UIServantPanel", function(panel)
            ---@type UIServantPanel
            self.mServantPanel = panel
            panel:ShowOtherButton(false)
            self:GetNewData(luaEnumRepairType.Servant)
        end, customData)
    end
end
--endregion

--region 背包
---打开背包界面
function UIRepairPanel:SwitchToBagPanel()
    if self.mCurrentPanel == luaEnumRepairType.Bag then
        return
    end
    uimanager:HidePanel(self.mRolePanel)
    uimanager:HidePanel(self.mServantPanel)
    self.mCurrentPanel = luaEnumRepairType.Bag
    if self.mBagPanel and not CS.StaticUtility.IsNull(self.mBagPanel.go) then
        uimanager:ReShowPanel(self.mBagPanel)
        self:GetNewData(luaEnumRepairType.Bag)
    else
        uimanager:CreatePanel("UIBagPanel", function(panel)
            self.mBagPanel = panel
            self:GetNewData(luaEnumRepairType.Bag)
        end, { type = LuaEnumBagType.Repair })
    end
end
--endregion

--region 角色
---打开角色界面
function UIRepairPanel:SwitchToRolePanel()
    if self.mCurrentPanel == luaEnumRepairType.Role then
        return
    end
    uimanager:HidePanel(self.mBagPanel)
    uimanager:HidePanel(self.mServantPanel)

    self.mCurrentPanel = luaEnumRepairType.Role
    ---@type RolePanelParam
    local customData = {}
    customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateRepair
    customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateRepair
    customData.mSLSuitPanelTemplate = luaComponentTemplates.UIRolePanel_SLSuitPanel_RepairTemplate
    if self.mRolePanel and CS.StaticUtility.IsNull(self.mRolePanel.go) == false then
        uimanager:ReShowPanel(UIRepairPanel.mRolePanel)
        self:GetNewData(luaEnumRepairType.Role)
    else
        uimanager:CreatePanel("UIRolePanel", function(panel)
            if panel ~= nil then
                self.mRolePanel = panel
                ---@type UIRolePanel
                local rolePanel = panel
                rolePanel:ShowCloseButton(false)
                self:GetNewData(luaEnumRepairType.Role)
            end
        end, customData)
    end
end

---@return boolean 判断当前角色界面是否正常存在
function UIRepairPanel:HasRolePanel()
    if self.mRolePanel and IsNullFunction(self.mRolePanel.go) == false then
        return true
    end
    return false
end
--endregion

--region 神力界面
---得到主角装备管理器
---@return LuaMainPlayerEquipMgr
function UIRepairPanel:GetMainPlayerEquipMgr()
    return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
end

---点击维修格子
---@param bagItemInfo bagV2.BagItemInfo
function UIRepairPanel:OnSLRepairGridClicked(bagItemInfo)
    local state = self:GetCurrentChooseDivineEquipState(bagItemInfo.index)
    self:ChangeCurrentChooseDivineEquipState(bagItemInfo.index, not state)
    self:RefreshRepairPanelShow()
end

---点击神力装备
---@param bagItemInfo bagV2.BagItemInfo
function UIRepairPanel:OnSLEquipGridClicked(bagItemInfo)
    local state = self:GetCurrentChooseDivineEquipState(bagItemInfo.index)
    self:ChangeCurrentChooseDivineEquipState(bagItemInfo.index, not state)
    self:RefreshRepairPanelShow()
end

---切换到神力装备状态
function UIRepairPanel:ChangeToDivineState()
    self.mCurrentPanel = luaEnumRepairType.Divine
    self:RefreshAllSLEquip()
end

---刷新整个神力界面
function UIRepairPanel:RefreshAllSLEquip()
    if self.mCurrentPanel == luaEnumRepairType.Divine then
        self:RefreshCurrentChooseDivineEquipState()
        self:RefreshRepairPanelShow()
        if self:HasRolePanel() and self.mRolePanel.SLSuitPanelTemplate then
            self.mRolePanel.SLSuitPanelTemplate:UpdateDate()
        end
    end
end

---刷新维修界面显示
function UIRepairPanel:RefreshRepairPanelShow()
    self.mNeedRepairList = self:GetNeedRepairSLEquipList()
    self:InitializePageRecycling()
    self:ShowCoinInfo()
end

---刷新当前神力装备状态
function UIRepairPanel:RefreshCurrentChooseDivineEquipState()
    ---@type table<number,boolean> 装备位对应是否需要选中
    self.mCurrentDivineState = {}
    ---@trype table<LuaEquipmentItemType,boolean>
    local mBasicIndexToChooseState = {}
    if self.mRolePanel and IsNullFunction(self.mRolePanel.go) == false then
        local currentState = self.mRolePanel:GetCurrentPanelState()
        local currentEquipList = self:GetMainPlayerEquipMgr():GetEquipmentList(currentState)
        if currentEquipList == nil then
            return
        end
        local equipDic = currentEquipList.EquipmentDic
        if equipDic == nil then
            return
        end
        for k, v in pairs(equipDic) do
            ---@type LuaEquipDataItem
            local equip = v
            if equip and equip.BagItemInfo then
                local needRepair = Utility:IsItemNeedRepair(equip.BagItemInfo)
                local equipIndex = equip.BagItemInfo.index
                self.mCurrentDivineState[equipIndex] = needRepair
                local basicIndex = Utility.GetSLEquipBasicIndex(equipIndex)
                mBasicIndexToChooseState[basicIndex] = needRepair
            end
        end
    end
    self:RefreshAllRoleEquipGridChooseState(mBasicIndexToChooseState)
end

---获取当前神力装备选中状态
---@return boolean
function UIRepairPanel:GetCurrentChooseDivineEquipState(equipIndex)
    if self.mCurrentDivineState == nil then
        self.mCurrentDivineState = {}
    end
    local state = self.mCurrentDivineState[equipIndex]
    if state == nil then
        state = false
    end
    return state
end

---改变当前神力装备选中状态
---@param equipIndex number 装备位
---@param chooseState boolean 选中状态
function UIRepairPanel:ChangeCurrentChooseDivineEquipState(equipIndex, chooseState)
    if self.mCurrentDivineState == nil then
        self.mCurrentDivineState = {}
    end
    self.mCurrentDivineState[equipIndex] = chooseState
    self:RefreshSingleRoleEquipGridChooseState(equipIndex, chooseState)
end

---获取当前选中装备列表
---@return table<number,number> 需要维修神力装备位列表
function UIRepairPanel:GetNeedRepairSLEquipList()
    local chooseList = {}
    if self.mRolePanel and IsNullFunction(self.mRolePanel.go) == false then
        local currentState = self.mRolePanel:GetCurrentPanelState()
        if self.mCurrentDivineState then
            for k, v in pairs(self.mCurrentDivineState) do
                if v then
                    local equipDataItem = self:GetMainPlayerEquipMgr():GetEquipmentItem(currentState, k, true)
                    if equipDataItem and equipDataItem.BagItemInfo then
                        table.insert(chooseList, equipDataItem.BagItemInfo)
                    end
                end
            end
        end
    end
    return chooseList
end

---刷新所有角色界面装备格子选中状态(神力)
function UIRepairPanel:RefreshAllRoleEquipGridChooseState(mBasicIndexToChooseState)
    if self:HasRolePanel() == false or self.mRolePanel.NowSelectEquipListType == LuaEquipmentListType.Base then
        return
    end
    ---@type UIRolePanel_SLSuitPanel_RepairTemplate
    local template = self.mRolePanel.SLSuitPanelTemplate
    template:UpdateAllEquipChooseState(mBasicIndexToChooseState)
end

---刷新单个角色界面装备格子选中状态(神力)
function UIRepairPanel:RefreshSingleRoleEquipGridChooseState(equipIndex, needChoose)
    if self:HasRolePanel() == false or self.mRolePanel.NowSelectEquipListType == LuaEquipmentListType.Base then
        return
    end
    ---@type UIRolePanel_SLSuitPanel_RepairTemplate
    local template = self.mRolePanel.SLSuitPanelTemplate
    template:UpdateSingleEquipChooseStateByEquipIndex(equipIndex, needChoose)
end
--endregion

--region 修理
---修理
function UIRepairPanel:OnRepairButtonClicked()
    if self.mRepairCost == 0 then
        Utility.ShowPopoTips(self:GetRepairButton_GameObject(), nil, 36)--请选择装备
        return
    end

    local str = self.CurrentMoneyNotEnoughDes
    if str then
        Utility.ShowPopoTips(self:GetRepairButton_GameObject(), str, 37)--{0}不足
        return
    end
    self:RepairEquip()

    --维修二次确认弹窗去除
    --[[    if self:GetSureTipsInfo() and self:GetCoinItemInfo() then
            local CancelInfo = {
                Title = self:GetSureTipsInfo().title,
                Content = self:GetSureTipsInfo().des,
                CallBack = function()
                    self:RepairEquip()
                end,
                LeftDescription = self:GetSureTipsInfo().leftButton,
                RightDescription = self:GetSureTipsInfo().rightButton,
            }
            uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
        end]]
end

---确认修理
function UIRepairPanel:RepairEquip()
    local mRepairList = self:ChangeTableToList()
    if self.mCurrentPanel == luaEnumRepairType.Servant then
        networkRequest.ReqRepairServantEquip(mRepairList)
    else
        networkRequest.ReqRepairEquip(mRepairList)
    end
end

---将table转为List
function UIRepairPanel:ChangeTableToList()
    local list = CS.System.Collections.Generic["List`1[System.Int64]"]()
    if self.mNeedRepairList ~= nil then
        for k, v in pairs(self.mNeedRepairList) do
            if self:IsEquipIndexType() then
                list:Add(v.index * -1)
            elseif UIRepairPanel.mCurrentPanel == luaEnumRepairType.Bag then
                list:Add(v.lid)
            end
        end
    end
    return list
end

---@return boolean 是否是装备类型
function UIRepairPanel:IsEquipIndexType()
    for i = 1, #self.mEquipType do
        if self.mCurrentPanel == self.mEquipType[i] then
            return true
        end
    end
    return false
end

--endregion

--region 维修界面
---初始化维修
function UIRepairPanel:InitializePageRecycling()
    self.mPageToRefresh = {}
    local page = math.ceil(#self.mNeedRepairList / self.mGridCount)
    if page ~= self.mCurrentTotalPage then
        self.mCurrentTotalPage = page
        self:RefreshPage()
    end
    local showPage = math.max(page, 1)
    self:GetRepairCycleController():Initialize(showPage, function(obj, page)
        self:OnPageEnterViewRange(obj, page)
    end, nil, function(page)
        self:OnCenterPageIndexChanged(page)
    end, 0)
end

---中心页刷新
function UIRepairPanel:OnPageEnterViewRange(obj, page)
    local currentPage = page + 1
    if self.mPageToRefresh[currentPage] == nil or not self.mPageToRefresh[currentPage] then
        self.mPageToRefresh[currentPage] = true
        self.mPageToRefresh[currentPage - 2] = false
        self.mPageToRefresh[currentPage + 2] = false
        local container = CS.Utility_Lua.GetComponent(obj.transform, "UIGridContainer")
        local pageData = self:SelectBagItemList(currentPage)
        if pageData then
            container.MaxCount = self.mGridCount
            for i = 0, container.controlList.Count - 1 do
                local go = container.controlList[i]
                local template = self:GetGridTemplate(go)
                if template then
                    template:RefreshUI(pageData[i + 1], 0)
                end
            end
        end
    end
end

---@return UIRepairGridItem
function UIRepairPanel:GetGridTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIRepairGridItem, self)
        self.mGoToTemplate[go] = template
    end
    return template
end

-----背包内物品中依次取出pageIndex页范围内的物品Table
-----@param items table
-----@param pageIndex XLua.Cast.Int32
function UIRepairPanel:SelectBagItemList(pageIndex)
    local list = {}
    --本页最小格子索引
    local minIndex = (pageIndex - 1) * UIRepairPanel.mGridCount + 1
    --本页最大格子索引
    local maxIndex = pageIndex * UIRepairPanel.mGridCount
    --背包内物品临时索引
    local bagItemIndex = 0
    for k, v in pairs(self.mNeedRepairList) do
        bagItemIndex = bagItemIndex + 1
        --找当前页对应的list
        if bagItemIndex >= minIndex and bagItemIndex <= maxIndex then
            table.insert(list, v)
        end
    end
    return list
end

---存储三页数据 超出三页则清楚
function UIRepairPanel:OnCenterPageIndexChanged(page)
    local currentPage = page + 1
    self:SetPageChoose(self.mCurrentPage, false)
    self.mCurrentPage = currentPage
    self:SetPageChoose(self.mCurrentPage, true)
end

---刷新页数显示
function UIRepairPanel:RefreshPage()
    self:GetShowPage_UIGridContainer().gameObject:SetActive(self.mCurrentTotalPage > 1)
    if self.mCurrentTotalPage > 1 then
        self:GetShowPage_UIGridContainer().MaxCount = self.mCurrentTotalPage
        self.mCurrentPage = 1
        for i = 0, self.mCurrentTotalPage do
            self:SetPageChoose(i + 1, i + 1 == self.mCurrentPage)
        end
    end
end

---设置页数选中
function UIRepairPanel:SetPageChoose(page, choose)
    if page then
        if page - 1 >= 0 and page - 1 < self:GetShowPage_UIGridContainer().controlList.Count then
            local go = self:GetShowPage_UIGridContainer().controlList[page - 1]
            local sp
            if self.mPageGoToSprite[go] then
                sp = self.mPageGoToSprite[go]
            else
                sp = CS.Utility_Lua.GetComponent(go.transform, "UISprite")
                self.mPageGoToSprite[go] = sp
            end
            if sp then
                sp.spriteName = ternary(choose, "scrlight", "scrbg")
            end
        end
    end
end

---维修选中格子改变
function UIRepairPanel:OnRepairChooseItemChange(bagItemInfo)
    if self.mCurrentPanel == luaEnumRepairType.Divine then
        self:OnSLRepairGridClicked(bagItemInfo)
    end
end
--endregion

--region 维修道具信息
---刷新货币信息
function UIRepairPanel:RefreshMoney()
    self.mPlayerItemNum = self:GetBagInfoV2():GetCoinAmount(self.mRepairCostGoldItemId)
    self:ShowCoinInfo()
end

---刷新折扣
function UIRepairPanel:RefreshDiscount()
    self.CommerceMonthCardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(LuaEnumCardType.Coceral)
    self.mMainPlayerVIPLevel = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level()
    self.mVIPLevelTbl = clientTableManager.cfg_vip_levelManager:TryGetValue(self.mMainPlayerVIPLevel)
    --[[    if self.mMainPlayerVIPLevel and self.mMainPlayerVIPLevel > 0 then
            self:GetOnSale_UILabel().text = "VIP优惠中"
            self:GetOnSale_UILabel().gameObject:SetActive(true)
        else
            self:GetOnSale_UILabel().gameObject:SetActive(false)
        end]]
    self:GetOnSale_UILabel().gameObject:SetActive(false)
    --self:GetOnSale_GameObject():SetActive(self.CommerceMonthCardInfo ~= nil)
end

---显示金币信息
function UIRepairPanel:ShowCoinInfo()
    self:GetRepairCostScroll_UIScrollView():ResetPosition()
    self.CurrentMoneyNotEnoughDes = nil
    local repairCost = self:GetRepairCost()
    self:GetRepairCost_UIGridContainer().MaxCount = #repairCost
    for i = 0, self:GetRepairCost_UIGridContainer().controlList.Count - 1 do
        local go = self:GetRepairCost_UIGridContainer().controlList[i]
        local icon = CS.Utility_Lua.Get(go.transform, "gold/img", "UISprite")
        local cost = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
        local Btn_add = CS.Utility_Lua.Get(go.transform, "Btn_add", "GameObject")
        local discount = CS.Utility_Lua.Get(go.transform, "reduceprice", "GameObject")
        local discountLabel = CS.Utility_Lua.Get(go.transform, "reduceprice/value", "UILabel")
        local showInfo = repairCost[i + 1]
        local itemInfo = self:GetCostItemInfoCache(showInfo.costId)
        if itemInfo then
            icon.spriteName = itemInfo.icon
            CS.UIEventListener.Get(cost.gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
            end

            local realCostNum = showInfo.costNum
            local showDisCount = math.floor(self:GetRepairDiscount() * 100);
            local hasDiscount = showDisCount > 0
            --计算月卡折扣
            --local hasDiscount = self.CommerceMonthCardInfo ~= nil or (self.mMainPlayerVIPLevel > 0 and self.mVIPLevelTbl ~= nil)
            discount:SetActive(hasDiscount)
            if hasDiscount then
                local num = showInfo.costNum - showInfo.costNum * self:GetRepairDiscount()
                realCostNum = math.ceil(num)
            end

            local hasEnough = false
            local playerHas = self:GetBagInfoV2():GetCoinAmount(showInfo.costId)
            --if res then
            if playerHas >= realCostNum then
                hasEnough = true
            end
            --end
            local otherItem = self:GetBagInfoV2():GetItemCountByItemId(showInfo.costId)
            if otherItem then
                if otherItem >= realCostNum then
                    hasEnough = true
                end
            end
            if not hasEnough then
                self.CurrentMoneyNotEnoughDes = itemInfo.name .. "不足"
            end
            local color = ternary(hasEnough, luaEnumColorType.Green, luaEnumColorType.Red1)
            local preAdd = ternary(hasDiscount, luaEnumColorType.Gray .. "[s]" .. showInfo.costNum .. "[/s]", "")
            cost.text = preAdd .. color .. realCostNum
            if showDisCount > 0 then
                discountLabel.text = "-" .. showDisCount .. "%"
            end
        end

        CS.UIEventListener.Get(Btn_add).onClick = function()
            Utility.ShowItemGetWay(showInfo.costId, Btn_add, LuaEnumWayGetPanelArrowDirType.Down);
        end
    end
    local posY = ternary(#repairCost == 1, -181, -163)
    self:GetRepairCostScroll_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(-23, posY, 0)
end

---元宝信息点击事件
function UIRepairPanel:OnYuanBaoLBClicked()
    if self:GetCoinItemInfo() then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self:GetCoinItemInfo() })
    end
end

---获取选择装备需要消耗金币
function UIRepairPanel:GetRepairCost()
    self.ShowCoinList = {}
    if self.mNeedRepairList then
        for k, v in pairs(self.mNeedRepairList) do
            local itemID = v.itemId
            if itemID ~= nil then
                local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemID)
                if res then
                    local maxLasting = itemInfo.maxLasting
                    local curLasting = v.currentLasting
                    local repairNun = maxLasting - curLasting
                    if itemInfo.type == luaEnumItemType.Equip and itemInfo.subType == LuaEnumEquiptype.Light then
                        --赤焰灯
                        local DengXinId = self:GetBagInfoV2().SpecialEquipID_DengXin
                        self:AddRepairInfo(itemInfo, repairNun, self:IsFurnaceFullLevel(DengXinId))
                    elseif itemInfo.type == luaEnumItemType.Equip and itemInfo.subType == LuaEnumEquiptype.SoulJade then
                        --魂玉
                        local ShengMingJingPoId = self:GetBagInfoV2().SpecialEquipID_ShengMingJingPo
                        self:AddRepairInfo(itemInfo, repairNun, self:IsFurnaceFullLevel(ShengMingJingPoId))
                    elseif itemInfo.type == luaEnumItemType.Equip and itemInfo.subType == LuaEnumEquiptype.TheSecretTreasureOfYuanling then
                        --灵兽秘宝
                        local JingGongZhiYuanId = self:GetBagInfoV2().SpecialEquipID_JingGongZhiYuan
                        local ShouHuZhiYuanId = self:GetBagInfoV2().SpecialEquipID_ShouHuZhiYuan
                        self:AddRepairInfo(itemInfo, repairNun, self:IsFurnaceFullLevel(JingGongZhiYuanId) and self:IsFurnaceFullLevel(ShouHuZhiYuanId))
                    elseif itemInfo.type == luaEnumItemType.Equip and itemInfo.subType == LuaEnumEquiptype.Baoshishoutao then
                        --宝石
                        local BaoShiId = self:GetBagInfoV2().SpecialEquipID_BaoShi
                        self:AddRepairInfo(itemInfo, repairNun, self:IsFurnaceFullLevel(BaoShiId))
                    else
                        self:AddRepairInfo(itemInfo, repairNun, false)
                    end
                end
            end
        end
    end
    return self:CostTableChangeToList(self.ShowCoinList)
end

---@return boolean 判断宝物当前等级是否已满
function UIRepairPanel:IsFurnaceFullLevel(id)
    if id then
        if id == 0 then
            return false
        end
        local furanceInfo = CS.Cfg_GodFurnaceTableManager.Instance:GetNextLevelItem(id)
        if furanceInfo then
            return false
        end
    end
    return true
end

---添加维修货币
---@param itemInfo TABLE.CFG_ITEMS 维修道具信息
---@param repairNum number 耐久度维修满的点数
---@param isSpecial boolean 是否是宝物满等级道具
function UIRepairPanel:AddRepairInfo(itemInfo, repairNum, isSpecial)
    local repairCostList
    if isSpecial then
        repairCostList = itemInfo.repairCost2
    else
        repairCostList = itemInfo.repairCost
    end
    if repairCostList then
        for i = 0, repairCostList.list.Count - 1 do
            local costInfoList = repairCostList.list[i]
            if costInfoList.list.Count >= 2 then
                local costId = costInfoList.list[0]
                local costNum = costInfoList.list[1]
                self:AddRepairCost(costId, costNum * repairNum)
            end
        end
    end
end

---添加花费道具
function UIRepairPanel:AddRepairCost(costId, costNum)
    local cost = self.ShowCoinList[costId]
    if cost then
        self.ShowCoinList[costId] = cost + costNum
    else
        self.ShowCoinList[costId] = costNum
    end
end

---将table转为有序排列
function UIRepairPanel:CostTableChangeToList(changTable)
    local list = {}
    if changTable then
        for k, v in pairs(changTable) do
            local info = {}
            info.costId = k
            info.costNum = v
            table.insert(list, info)
        end
    end
    table.sort(list, self.SortCostList)
    return list
end

function UIRepairPanel.SortCostList(l, r)
    if l.costId ~= r.costId then
        if l.costId == LuaEnumCoinType.JinBi then
            return true
        elseif r.costId == LuaEnumCoinType.JinBi then
            return false
        else
            return l.costId < r.costId
        end
    end
    return false
end

---@return TABLE.CFG_ITEMS 获取花费道具item信息缓存
function UIRepairPanel:GetCostItemInfoCache(id)
    if self.mCostItemIdToItemInfo == nil then
        self.mCostItemIdToItemInfo = {}
    end
    local itemInfo = self.mCostItemIdToItemInfo[id]
    if itemInfo == nil then
        ___, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    end
    return itemInfo
end

function UIRepairPanel:GetAfterDisCountCost()
    return math.floor(self:GetRepairCost() - self:GetRepairCost() * self:GetRepairDiscount())
end

---获取维修折扣 (百分比)
function UIRepairPanel:GetRepairDiscount()
    return 0
    --[[    local monthCardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(1);
        local monthCardDisCount = 0;
        if (monthCardInfo ~= nil) then
            local isFindMonthCard, monthCardTable = CS.Cfg_MonthCardTableManager.Instance:TryGetValue(monthCardInfo.id);
            if (isFindMonthCard) then
                monthCardDisCount = monthCardTable.repairDiscount / 1000;
            end
        end
        if self.mMainPlayerVIPLevel > 0 and self.mVIPLevelTbl ~= nil then
            monthCardDisCount = monthCardDisCount + self.mVIPLevelTbl:GetRepairCost() / 10000
        end
        return monthCardDisCount;]]
end

---获取货币
function UIRepairPanel:OnAddButtonClicked()
    Utility.ShowItemGetWay(self.mRepairCostGoldItemId, self:GetAddButton_GameObject(), LuaEnumWayGetPanelArrowDirType.Down);
end
--endregion

--region 设置自动选中

---获取对应界面数据
function UIRepairPanel:GetNewData(type)
    luaEventManager.DoCallback(LuaCEvent.RepairGetRefreshChooseList, type)
end
--endregion

--region 红点
function UIRepairPanel:AddRedPoint()
    local key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Repair_Servant)
    self:GetRedPoint():AddRedPointKey(key)
end
--endregion

--region onDestroy
function ondestroy()
    --luaEventManager.RemoveCallback(LuaCEvent.RepairChooseListChange, UIRepairPanel.RepairChooseListFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, UIRepairPanel.OnMainBagClicked)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRepairEquipMessage, UIRepairPanel.mEquipRepairFinish)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRepairServantEquipMessage, UIRepairPanel.mEquipRepairFinish)
    if UIRepairPanel.mRolePanel then
        uimanager:ClosePanel(UIRepairPanel.mRolePanel)
    end
    if UIRepairPanel.mBagPanel then
        uimanager:ClosePanel(UIRepairPanel.mBagPanel)
    end
    if UIRepairPanel.mServantPanel then
        uimanager:ClosePanel(UIRepairPanel.mServantPanel)
    end
end
--endregion

return UIRepairPanel