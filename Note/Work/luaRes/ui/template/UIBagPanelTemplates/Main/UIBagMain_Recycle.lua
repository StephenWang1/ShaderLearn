---背包回收界面
---@class UIBagMain_Recycle:UIBagMain_Normal
local UIBagMain_Recycle = {}

setmetatable(UIBagMain_Recycle, luaComponentTemplates.UIBagMainNormal)

UIBagMain_Recycle.isNewRecycle = true

--region 局部变量
local Utility = Utility

UIBagMain_Recycle.csMainPlayerInfo = nil
---@return CSMainPlayerInfo
function UIBagMain_Recycle:GetCSMainPlayerInfo()
    if self.csMainPlayerInfo == nil then
        self.csMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.csMainPlayerInfo
end

UIBagMain_Recycle.mCSBagInfo = nil
---@return CSBagInfoV2
function UIBagMain_Recycle:GetCSBagInfo()
    if self.mCSBagInfo == nil then
        local mainPlayerInfo = self:GetCSMainPlayerInfo()
        self.mCSBagInfo = mainPlayerInfo.BagInfo
    end
    return self.mCSBagInfo
end

---回收选项元表
---@class RecycleOption
local recycleOptionMetaTable = {
    ---@private
    ---@type UIBagMain_Recycle
    BagMainRecycle = nil,
    ---@public
    ---@type luaEnumRecycleOptionType
    RecycleOptionType = nil,
    ---@public
    ---@type string
    Description = nil,
    ---@private
    ---@type table
    Parameters = nil,
    ---@public
    ---@type UIBagRecycleOptionGO
    OptionTemplate = nil,
    ---默认开启状态
    ---@public
    ---@type boolean
    DefaultState = false,
    ---临时状态
    ---@private
    ---@type boolean
    StateTemp = false,
    ---@private
    ---@type fun(recyclePart:UIBagMain_Recycle,bagItemInfo:bagV2.BagItemInfo,...:any):boolean
    CheckFunction = nil,
    ---@private
    ---@type fun(recyclePart:UIBagMain_Recycle,bagItemInfo:bagV2.BagItemInfo,RecycleOptionType:number,...:any):boolean
    IsBelongToFunction = nil,
    ---@public
    ---归属物品列表
    ---@type table
    RecycleItemTable = {},
    ---得到回收选项的变更对每个背包物品Check状态的改变,boolean表示该选项决定的物品最终Check状态
    ---@param self RecycleOption
    ---@param bagItemInfo bagV2.BagItemInfo
    ---@return boolean
    Check = function(self, bagItemInfo)
        if self.CheckFunction ~= nil and bagItemInfo ~= nil then
            return (self.CheckFunction(self.BagMainRecycle, bagItemInfo, table.unpack(self.Parameters)) == true)
        end
        return false
    end,
    ---判断背包物品是否属于该回收选项
    ---@param self RecycleOption
    ---@param bagItemInfo bagV2.BagItemInfo
    ---@return boolean
    IsBelongTo = function(self, bagItemInfo)
        if self.IsBelongToFunction ~= nil and bagItemInfo ~= nil then
            return (self.IsBelongToFunction(self.BagMainRecycle, bagItemInfo, self.RecycleOptionType, table.unpack(self.Parameters)) == true)
        end
        return false
    end,
    ---绑定选项模板
    ---@param self RecycleOption
    ---@param optionTemplate UIBagRecycleOptionGO
    BindBagOption = function(self, optionTemplate)
        self.OptionTemplate = optionTemplate
        optionTemplate:BindChangeEvent(function(isOptionOn)
            self:OnOptionStateChanged(isOptionOn)
        end)
        optionTemplate:SetOptionLabel(self.Description)
    end,
    ---选项状态变化事件
    ---@private
    ---@param self RecycleOption
    ---@param isOptionOn boolean
    OnOptionStateChanged = function(self, isOptionOn)
        if self.mAvoidCallBack == true then
            return
        end
        self.StateTemp = isOptionOn
        self.BagMainRecycle:OnRecycleOptionStateChanged(self, isOptionOn)
    end,
    ---更改状态
    ---@overload fun(self:RecycleOption,isOptionChecked:boolean)
    ---@param self RecycleOption
    ---@param isOptionChecked boolean
    ---@param isEvadeCallBack boolean 是否规避执行回调
    ChangeState = function(self, isOptionChecked, isEvadeCallBack)
        if self.mLock == true then
            return
        end
        self.mLock = true
        if isEvadeCallBack then
            self.mAvoidCallBack = true
        end
        if self.OptionTemplate then
            self.OptionTemplate:ChangeState(isOptionChecked)
        end
        self.mAvoidCallBack = false
        self.mLock = false
    end,
    ---@private
    ---@param self RecycleOption
    ---@return string
    __tostring = function(self)
        if self then
            return "RecycleOption:\nDescription:  " .. tostring(self.Description) .. "\nCheckFunction:  "
                    .. tostring(self.CheckFunction) .. "\nIsBelongToFunction:  " .. tostring(self.IsBelongToFunction) .. "\nParameters:  " .. tostring(self.Parameters ~= nil and table.unpack(self.Parameters) or nil)
        end
        return ""
    end
}
recycleOptionMetaTable.__index = recycleOptionMetaTable
--endregion

--region 字段
---回收选项
---@type table<number,RecycleOption>
UIBagMain_Recycle.mRecycleOptions = nil
---延迟刷新背包格子回收特效的时间
UIBagMain_Recycle.mDelayRefreshBagGridEffectTime = nil
---延迟刷新背包的时间(下一次刷新背包的时间节点)
UIBagMain_Recycle.mDelayRefreshBagTime = nil
---延迟播放回收特效
UIBagMain_Recycle.mDelayPlayRecycleEffectTime = nil
---延迟刷新背包货币的时间
UIBagMain_Recycle.mDelayRefreshBagCoin = nil
--endregion

--region 属性
---获取当前回收物品列表,number为lid,boolean值为true的表示需要被回收
---@return table<number,boolean>
function UIBagMain_Recycle:GetRecycleBagItems()
    if self.mRecycleBagItems == nil then
        self.mRecycleBagItems = {}
    end
    return self.mRecycleBagItems
end

---获取当前回收物品列表，number为lid,boolean值为true的表示默认回收状态
function UIBagMain_Recycle:GetRecycleBagItemsDefaultState()
    if self.mRecycleBagItemsDefaultStat == nil then
        self.mRecycleBagItemsDefaultStat = {}
    end
    return self.mRecycleBagItemsDefaultStat
end
--endregion

--region 回收相关组件
---回收视图节点
---@return UnityEngine.GameObject
function UIBagMain_Recycle:GetRecycleRoot()
    if self.mRecycleGo == nil then
        self.mRecycleGo = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle", "GameObject")
    end
    return self.mRecycleGo
end

---获取回收选项格子容器
---@return UIGridContainer
function UIBagMain_Recycle:GetRecycleOptionsGridContainer()
    if self.mRecycleOptionsGridContainer == nil then
        self.mRecycleOptionsGridContainer = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/ScrollView/RecycleOptions", "UIGridContainer")
    end
    return self.mRecycleOptionsGridContainer
end

---获取回收收益格子容器
---@return UIGridContainer
function UIBagMain_Recycle:GetRecycleEarningGridContainer()
    if self.mRecycleEarningGridContainer == nil then
        self.mRecycleEarningGridContainer = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/view/ScrollView_Earning/RecycleEarning", "UIGridContainer")
    end
    return self.mRecycleEarningGridContainer
end

---获取回收收益Table
---@return Top_UITable
function UIBagMain_Recycle:GetRecycleEarningUITable()
    if self.mRecycleEarningUITable == nil then
        self.mRecycleEarningUITable = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/view/ScrollView_Earning/RecycleEarning", "Top_UITable")
    end
    return self.mRecycleEarningUITable
end

---获取回收按钮
---@return UIEventListener
function UIBagMain_Recycle:GetRecycleButtonGO()
    if self.mRecycleButtonGO == nil then
        self.mRecycleButtonGO = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/events/Btn_Recycle", "GameObject")
    end
    return self.mRecycleButtonGO
end

---获取回收按钮特效
---@return UIEventListener
function UIBagMain_Recycle:GetRecycleButtonEffectGO()
    if self.mRecycleButtonEffectGO == nil then
        self.mRecycleButtonEffectGO = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/events/Btn_Recycle/recycleBtnEffect", "GameObject")
    end
    return self.mRecycleButtonEffectGO
end

---获取回收设置触发按钮
---@return UIEventListener
function UIBagMain_Recycle:GetRecycleConfigBtnGO()
    if self.mRecycleConfigBtnGO == nil then
        self.mRecycleConfigBtnGO = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/events/Btn_RecycleConfig", "GameObject")
    end
    return self.mRecycleConfigBtnGO
end

---获取回收设置面板
---@return UIEventListener
function UIBagMain_Recycle:GetRecycleConfigGO()
    if self.mRecycleConfigGO == nil then
        self.mRecycleConfigGO = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/RecycleConfig", "GameObject")
    end
    return self.mRecycleConfigGO
end

---回收togglCheckMark
---@return UnityEngine.GameObject
function UIBagMain_Recycle:GetRecycleToggleCheck_GameObject()
    if self.mRecycleToggleCheck_GO == nil then
        self.mRecycleToggleCheck_GO = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/events/RecycleToggle/check", "GameObject")
    end
    return self.mRecycleToggleCheck_GO
end

---@return UnityEngine.GameObject 自动回收按钮
function UIBagMain_Recycle:GetAutoRecycleBtn_GO()
    if self.mAutoRecycleBtn == nil then
        self.mAutoRecycleBtn = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/events/AutoRecycle", "GameObject")
    end
    return self.mAutoRecycleBtn
end

---@return UnityEngine.GameObject 自动回收按钮check
function UIBagMain_Recycle:GetAutoRecycleBtnCheck_GO()
    if self.mAutoRecycleBtnCheck == nil then
        self.mAutoRecycleBtnCheck = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/events/AutoRecycle/check", "GameObject")
    end
    return self.mAutoRecycleBtnCheck
end

---@return UnityEngine.GameObject 自动回收提醒提示
function UIBagMain_Recycle:GetRechargePrompt_GO()
    if self.mRechargePrompt == nil then
        self.mRechargePrompt = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/recycle/view/RechargePrompt", "GameObject")
    end
    return self.mRechargePrompt
end
--endregion

--region 重写属性
---回收界面展开背包
---@return boolean
function UIBagMain_Recycle:IsExpandBagPanel()
    return true
end

---使用服务器顺序
---@return boolean
function UIBagMain_Recycle:IsUseServerOrder()
    return true
end

---禁用双击交互
---@return boolean
function UIBagMain_Recycle:IsItemDoubleClickedAvailable()
    return false
end

---不显示整理按钮
---@return boolean
function UIBagMain_Recycle:IsShowTrimButton()
    return false
end

---背包信息是否过时
function UIBagMain_Recycle:IsBagInfoDirty()
    if self.mDelayRefreshBagTime ~= nil then
        return false
    end
    return self:RunBaseFunction("IsBagInfoDirty")
end

---刷新货币是否用tween，当此属性被置为true时,货币刷新时用tween
---@public
---@return boolean
function UIBagMain_Recycle:RefreshCionByTween()
    return true
end
--endregion

--region 重写初始化方法
---初始化
function UIBagMain_Recycle:OnInit()
    self:RunBaseFunction("OnInit")
    local gloBalInfo = CS.Cfg_GlobalTableManager.Instance
    self.bagGridDeltaRefreshTime = gloBalInfo:GetRecycleGridDelayRefreshTime()
    self.playRecycleEffectDeltaTime = gloBalInfo:GetPlayRecycleEffectDelayRefreshTime()
    self.coinDeltaRefreshTime = gloBalInfo:GetBagCoinDelayRefreshTime()
    ---回收按钮点击事件
    ---@type function
    self.mOnRecycleButtonClickedFunction = function()
        self:OnRecycleButtonClicked()
    end
    ---回收请求框确认事件
    ---@type function
    self.mOnRecyclePromptConfirmedFunction = function()
        self:RequestRecycle()
    end
    self.CallFuncOnResRecycleEquipmentMessage = function()
        self:RefreshRecycleEarning()
        self:SetAllDelay()
        ---回收后自动整理
        --self.mNeedCheckTrim = true
    end
    ---回收设置按钮点击事件
    ---@type function
    self.mOnRecycleSettingButtonClickedFunction = function()
        self:OpenRecycleSettingPanel()
    end
    self:InitAutoRecycleBtn()
end
--endregion

--region 重写生命周期方法
function UIBagMain_Recycle:OnEnable()
    self:RunBaseFunction("OnEnable")
    self:GetRecycleRoot():SetActive(true)
    self:GetRecycleToggleCheck_GameObject():SetActive(true)
    self:ClearAllBagItemsSelectedState()
    self:ClearRecycleItemList()
    self:InitAutoRecycleBtn()

    if self.isNewRecycle then
        self:InitializeRecycleOptions_New()
    else
        self:InitializeRecycleOptions()
    end

    self:InitRecycleBtnEffect()
    CS.UIEventListener.Get(self:GetRecycleButtonGO()).onClick = self.mOnRecycleButtonClickedFunction
    CS.UIEventListener.Get(self:GetRecycleConfigBtnGO()).onClick = self.mOnRecycleSettingButtonClickedFunction
    self:GetBagPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRecycleEquipmentMessage, self.CallFuncOnResRecycleEquipmentMessage)
    CS.UIEventListener.Get(self:GetAutoRecycleBtn_GO()).onClick = function(go)
        self:OnAutoRecycleClicked(go)
    end
end

---刷新回收面板
function UIBagMain_Recycle:RefreshRecycle()
    --self:ClearAllBagItemsSelectedState()
    --self:ClearRecycleItemList()
    if self.isNewRecycle then
        self:InitializeRecycleOptions_New()
    else
        self:InitializeRecycleOptions()
    end
end

function UIBagMain_Recycle:OnDisable()
    self:RunBaseFunction("OnDisable")
    self:GetRecycleRoot():SetActive(false)
    self:GetRecycleToggleCheck_GameObject():SetActive(false)
    CS.UIEventListener.Get(self:GetRecycleButtonGO()).onClick = nil
    CS.UIEventListener.Get(self:GetRecycleConfigBtnGO()).onClick = nil
    --if self.recycleSettingTemplate ~= nil then
    --    self.recycleSettingTemplate:ResetAllOptionChooseState()
    --end
    self:GetBagPanel():GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResRecycleEquipmentMessage, self.CallFuncOnResRecycleEquipmentMessage)
    self:GetBagPanel():ResetTriggleCoinAddTip()
end
--endregion

--region 重写筛选方法
---背包物品筛选方法
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIBagMain_Recycle:BagItemFilterFunction(bagItemInfo, itemInfo)
    --return self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo) and self:IsCanBeRecycled(bagItemInfo, itemTbl)
    return true
end
--endregion

--region 重写格子刷新方法
function UIBagMain_Recycle:RefreshGrids()
    self.bagItemChange = true
    self:RunBaseFunction("RefreshGrids")
    self:RefreshRecycle()
    self.bagItemChange = false
end

function UIBagMain_Recycle:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo) and self:IsCanBeRecycled(bagItemInfo) and not self:IsInsurance(bagItemInfo) then
        local isChoose = self:GetBagItemSelectedState(bagItemInfo)
        ---显示CheckBox
        bagGrid:SetCompActive(bagGrid.Components.Check1, true)
        ---切换CheckBox的显示状态
        bagGrid:SetCompSpriteName(bagGrid.Components.Check1, isChoose and "check" or "checkkuang")
        ---切换Choose的显示状态
        if itemTbl.type == luaEnumItemType.Collection then
            if isChoose and self:SelectRecommendedCollections(bagItemInfo) ~= true then
                bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
            end
        else
            local default = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():GetRecycleItemDefaultState(bagItemInfo.lid)
            bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, isChoose and default == false)
        end
        self:RefreshEquipDurabilityIsLess(bagGrid, bagItemInfo, itemTbl)
    else
        ---置灰显示
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end
--endregion

--region 重写交互方法
---格子长按时,显示物品信息
function UIBagMain_Recycle:OnGridLongPressed(bagGrid, bagItemInfo, itemTbl)
    self:ShowItemInfo(bagItemInfo)
end

---格子点击时,切换该物品的选中非选中状态
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Recycle:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo) and not self:IsInsurance(bagItemInfo) then

        if self:IsAvailableForSemelt(bagItemInfo) then
            ---设置背包熔炼数据
            self:SetBagItemSelectSmeltData(bagItemInfo, not self:GetBagItemSelectedState(bagItemInfo))
        else
            self:SetBagItemSelectedState(bagItemInfo, self:GetBagItemSelectedState(bagItemInfo) == false)
            self:RefreshEarningData(bagItemInfo, self:GetBagItemSelectedState(bagItemInfo))
        end

        self:RefreshRecycleEarning()

        self:RefreshOptionByBagItemInfo(bagItemInfo, self:GetBagItemSelectedState(bagItemInfo))
        self:RefreshChooseData(itemTbl.id, self:GetBagItemSelectedState(bagItemInfo))
    else
        Utility.ShowPopoTips(bagGrid.go.transform, nil, 177)
    end
    bagGrid:Refresh()
end
--endregion

--region 重写帧刷新方法
---帧刷新
---@param time number 当前时间
function UIBagMain_Recycle:OnUpdate(time)
    if self.mNeedCheckTrim then
        self.mNeedCheckTrim = false
        self:CheckIsNeedTrimAfterRecycle()
    end
    self:CheckDelayRefreshBagItem(time)
end

---检查延迟刷新背包物品(UE要求回收表现效果顺序依次为（格子特效--->格子回收刷新---->金币特效----->背包货币tween刷新）)
---@param time number 当前时间
function UIBagMain_Recycle:CheckDelayRefreshBagItem(time)
    if self.mDelayRefreshBagGridEffectTime and time > self.mDelayRefreshBagGridEffectTime then
        self.mDelayRefreshBagGridEffectTime = nil
        self:PlayRecycleGridEffect()
    end
    if self.mDelayRefreshBagTime and time > self.mDelayRefreshBagTime then
        self.mDelayRefreshBagTime = nil
        self:RefreshGrids()
    end
    if self.mDelayPlayRecycleEffectTime and time > self.mDelayPlayRecycleEffectTime then
        self.mDelayPlayRecycleEffectTime = nil
        self:PlayEarningEffect()
    end
    if self.mDelayRefreshBagCoin and time > self.mDelayRefreshBagCoin then
        self.mDelayRefreshBagCoin = nil
        self:RefreshCoins(false, true)
    end
end
--endregion

--region UI事件
---回收按钮点击事件
function UIBagMain_Recycle:OnRecycleButtonClicked()
    self:DoRecycleOperation()
    self:GetBagPanel():RecordCoinAddTipOriginAmount()
    if Utility.TrySubmitTask("UIBagPanel") then
        uimanager:ClosePanel("UIBagPanel")
    end
end
--endregion

--region 单个物品选中状态
---获取背包物品的选中状态
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:GetBagItemSelectedState(bagItemInfo)
    return self:GetRecycleBagItems()[bagItemInfo.lid] == true or self:GetSmeltBagItemsStateDic()[bagItemInfo.lid] == true
end

---获取背包物品的回收选中状态
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:GetRecycleBagItemSelectedState(bagItemInfo)
    return self:GetRecycleBagItems()[bagItemInfo.lid] == true
end

---设置背包物品的选中状态
---@param bagItemInfo bagV2.BagItemInfo
---@param isSelected boolean
function UIBagMain_Recycle:SetBagItemSelectedState(bagItemInfo, isSelected)
    self:GetRecycleBagItems()[bagItemInfo.lid] = isSelected
end

---设置背包物品的默认状态（在回收选项选项为true时刷新默认状态）
function UIBagMain_Recycle:SetBagGridState(bagItemInfo, defaultState)
    if self:GetRecycleBagItemsDefaultState()[bagItemInfo.lid] == nil then
        self:GetRecycleBagItemsDefaultState()[bagItemInfo.lid] = defaultState
    end
end

---获取背包物品的默认状态
function UIBagMain_Recycle:GetBestBagItemState(bagItemInfo, itemTbl)
    ---并非所有的默认选项都添加
    local defaultState = ternary(self:GetRecycleBagItemsDefaultState()[bagItemInfo.lid] == nil, false, self:GetRecycleBagItemsDefaultState()[bagItemInfo.lid])
    return defaultState
end

---清除所有背包物品的选中状态
function UIBagMain_Recycle:ClearAllBagItemsSelectedState()
    for i, v in pairs(self:GetRecycleBagItems()) do
        self:GetRecycleBagItems()[i] = false
    end
    self.mRecycleBagItemsDefaultStat = {}
end
--endregion

--region 回收选项
---是否可以被回收
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:IsCanBeRecycled(bagItemInfo)
    return true
end

---是否已投保险
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:IsInsurance(bagItemInfo)
    return gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)
end

---初始化回收选项
function UIBagMain_Recycle:InitializeRecycleOptions()
    self:AddAllRecycleOptions()
    self:CreateAndBindAllRecycleTemplates()
    self:InitializeAllRecycleOptionDefaultState()
end

---初始化回收按钮特效
function UIBagMain_Recycle:InitRecycleBtnEffect()
    if self:GetRecycleButtonEffectGO() ~= nil then
        self:GetRecycleButtonEffectGO():SetActive(uiStaticParameter.RecycleBubbleOnClick)
        uiStaticParameter.RecycleBubbleOnClick = false
    end
    self:RefreshRecycleTaskButtonEffect()
end

---添加所有的回收选项
function UIBagMain_Recycle:AddAllRecycleOptions()
    if self.mRecycleOptions then
        for i, v in pairs(self.mRecycleOptions) do
            self:PushRecycleOption(v)
        end
        Utility.ClearTable(self.mRecycleOptions)
    else
        self.mRecycleOptions = {}
    end
    if self:GetCSMainPlayerInfo() then
        local level = self:GetCSMainPlayerInfo().Level
        local reinLv = CS.CSScene.MainPlayerInfo.ReinLevel
        local CSGlobalTblMgr = CS.Cfg_GlobalTableManager.Instance
        local conditionManager = CS.Cfg_ConditionManager.Instance
        if conditionManager:IsMainPlayerMatchCondition(CSGlobalTblMgr:GetRecycleEquipLv()) then
            self:AddRecycleOption(luaEnumRecycleOptionType.LEVELEQUIP, "等级装备", self.SelectByUseLevelAndBetterThanEquip, self.SelectByUseLevel, true, 1, 999)
        end
        if conditionManager:IsMainPlayerMatchCondition(CSGlobalTblMgr:GetRecycleEquipReinLv()) then
            self:AddRecycleOption(luaEnumRecycleOptionType.REINLVEQUIP, "转生装备", self.SelectByReinLevelAndBetterThanEquip, self.SelectByReinLevel, true, 1, 999)
        end
        if level >= CSGlobalTblMgr:intGetGemRecycleLevel() then
            self:AddRecycleOption(luaEnumRecycleOptionType.SPECIALEQUIP, "特殊装备", self.SelectByBetterGem, self.SelectGem, true)
        end
        if gameMgr:GetPlayerDataMgr():GetCollectionInfo():IsMainPlayerCollectionOpened() then
            self:AddRecycleOption(luaEnumRecycleOptionType.COLLECTION, "藏品", self.SelectRecommendedCollections, self.SelectCollections, false)
        end
        if CS.Cfg_GlobalTableManager.Instance:DrugRecycleLevelLimit() then
            self:AddRecycleOption(luaEnumRecycleOptionType.DRUG, "药品", self.SelectLowQualityDrug, self.SelectDrug, true, 1, 999)
        end
        if level >= CSGlobalTblMgr:intGetSkillRecycleLevel() then
            ---因为本职业的技能书将在物品筛选显示的时候被筛选掉,所以此处进入判断的只有非本职业的技能书,若后续有修改则应随之改动
            self:AddRecycleOption(luaEnumRecycleOptionType.SKILLBOOK, "技能书", self.SelectBySkillBookType, self.SelectBySkillBook, true)
        end
        if level >= CSGlobalTblMgr:intGetServantRecycleLevel() then
            self:AddRecycleOption(luaEnumRecycleOptionType.SERVANT, "灵兽", self.SelectServant, self.SelectServantRelated, true)
            self:AddRecycleOption(luaEnumRecycleOptionType.SERVANTBODY, "灵兽肉身", self.SelectServantBody, self.SelectServantBodyRelated, true)
            self:AddRecycleOption(luaEnumRecycleOptionType.SERVANTEQUIP, "灵兽装备", self.SelectServantEquip, self.SelectServantEquipRelated, true)
        end
        if self:GetCSBagInfo():OpenGodStoneRecycle() then
            self:AddRecycleOption(luaEnumRecycleOptionType.REINSTONE, "转生证明", self.SelectLowLevelGodStone, self.SelectGodStone, false)
        end
        if level >= CSGlobalTblMgr:intGetElementRecycleLevel() then
            self:AddRecycleOption(luaEnumRecycleOptionType.ELEMENT, "元素", self.SelectLowQualityElement, self.SelectElement, true)
        end
        if level >= CSGlobalTblMgr:intGetSignetRecycleLevel() then
            self:AddRecycleOption(luaEnumRecycleOptionType.SIGNET, "印记", self.SelectLowQualitySignet, self.SelectSignet, true)
        end
        if level >= CSGlobalTblMgr:intGetMineraRecycleLevel() then
            self:AddRecycleOption(luaEnumRecycleOptionType.OTHERMATERIAL, "其他材料", self.SelectPartOfMaterial, self.SelectTaskMaterial, true, 1, 999)
        end
        local luaGlobalInfo = LuaGlobalTableDeal.GetGlobalTabl(22866)
        if luaGlobalInfo then
            local strs = string.Split(luaGlobalInfo.value, '#')
            local show = true
            for i = 1, #strs do
                if not Utility.IsMainPlayerMatchCondition(tonumber(strs[i])).success then
                    show = false
                end
            end
            if show then
                self:AddRecycleOption(luaEnumRecycleOptionType.XianZhuang, "仙装", self.SelectRecommendedXianZhuang, self.SelectAllXianZhuang, true)
            end
        end
    end
end

---添加回收选项
---@param recycleOptionType luaEnumRecycleOptionType
---@param description string
---@param CheckFunction fun(recyclePart:UIBagMain_Recycle,bagItemInfo:bagV2.BagItemInfo,...:any):boolean 得到回收选项状态变更对每个背包物品Check状态的改变,nil表示不改变,boolean表示该物品最后的Check状态
---@param IsBelongToFunction fun(recyclePart:UIBagMain_Recycle,bagItemInfo:bagV2.BagItemInfo,...:any):boolean 判断背包物品是否属于该回收选项
---@param DefaultState boolean 默认开启状态
---@vararg any
---@return RecycleOption
function UIBagMain_Recycle:AddRecycleOption(recycleOptionType, description, CheckFunction, IsBelongToFunction, DefaultState, ...)
    ---@type RecycleOption
    local tbl = self:PopRecycleOption()
    tbl.BagMainRecycle = self
    tbl.RecycleOptionType = recycleOptionType
    tbl.Description = description
    tbl.DefaultState = DefaultState
    tbl.CheckFunction = CheckFunction
    tbl.IsBelongToFunction = IsBelongToFunction
    tbl.Parameters = { ... }
    table.insert(self.mRecycleOptions, tbl)
    return tbl
end

---获取一个回收选项
---@private
---@return RecycleOption
function UIBagMain_Recycle:PopRecycleOption()
    if self.mRecycleOptionPool == nil then
        self.mRecycleOptionPool = {}
    end
    local option
    if #self.mRecycleOptionPool > 0 then
        option = self.mRecycleOptionPool[1]
        table.remove(self.mRecycleOptionPool, 1)
    end
    if option == nil then
        option = {}
        setmetatable(option, recycleOptionMetaTable)
    end
    return option
end

---压入一个回收选项
---@private
---@param option RecycleOption
function UIBagMain_Recycle:PushRecycleOption(option)
    if option then
        if self.mRecycleOptionPool == nil then
            self.mRecycleOptionPool = {}
        end
        table.insert(self.mRecycleOptionPool, option)
    end
end

---创建并绑定所有回收模板
function UIBagMain_Recycle:CreateAndBindAllRecycleTemplates()
    if self.mRecycleOptions then
        local recycleOptionCount = #self.mRecycleOptions
        self:GetRecycleOptionsGridContainer().MaxCount = recycleOptionCount
        for i = 1, recycleOptionCount do
            local optionTbl = self.mRecycleOptions[i]
            local go = self:GetRecycleOptionsGridContainer().controlList[i - 1]
            local bagRecycleOptionTemplate = self:GetRecycleOptionGOTemplate(go)
            bagRecycleOptionTemplate:ResetOptionState()
            optionTbl:BindBagOption(bagRecycleOptionTemplate)
        end
    end
end

---根据选项游戏物体获取回收选项
---@param go UnityEngine.GameObject
---@return UIBagRecycleOptionGO
function UIBagMain_Recycle:GetRecycleOptionGOTemplate(go)
    if self.mRecycleOptionGOTemplates == nil then
        self.mRecycleOptionGOTemplates = {}
    end
    local optionGOTemplate = self.mRecycleOptionGOTemplates[go]
    if optionGOTemplate == nil then
        optionGOTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBagRecycleOptionGO)
    end
    self.mRecycleOptionGOTemplates[go] = optionGOTemplate
    return optionGOTemplate
end

---初始化所有回收选项的默认状态
function UIBagMain_Recycle:InitializeAllRecycleOptionDefaultState()
    local bagItemList = self:GetBagItemList()
    local optionCount = #self.mRecycleOptions
    --for i = 1, optionCount do
    --    local option = self.mRecycleOptions[i]
    --    option.StateTemp = false
    --end
    for j, v in pairs(bagItemList) do
        for i = 1, optionCount do
            local option = self.mRecycleOptions[i]
            local IsNewRecycleItem = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():IsContainRecycleDefaultItem(v.lid) == false
            if option:IsBelongTo(v) then
                if option.DefaultState then
                    ---选项默认开启
                    if option.StateTemp == false then
                        ---1.新数据根据是否是推荐物品进行勾选    2.老数据根据当前的选择状态进行勾选
                        if IsNewRecycleItem and (option:Check(v)) or (IsNewRecycleItem == false and self:GetBagItemSelectedState(v)) then
                            option.StateTemp = true
                            break
                        end
                    end
                else
                    ---选项默认不开启
                    if option.StateTemp == false then
                        ---旧数据根据当前的选择状态进行勾选
                        if (IsNewRecycleItem == false and self:GetBagItemSelectedState(v)) then
                            option.StateTemp = true
                            break
                        end
                    end
                end
            end
            --[[            if option.DefaultState and option.StateTemp == false then
                            ---1.新数据根据是否是推荐物品进行勾选    2.老数据根据当前的选择状态进行勾选
                            if IsNewRecycleItem and (option:IsBelongTo(v) and option:Check(v)) or (IsNewRecycleItem == false and self:GetBagItemSelectedState(v) and option:IsBelongTo(v)) then
                                option.StateTemp = true
                                break
                            end
                        end]]
        end
    end
    for i = 1, #self.mRecycleOptions do
        local option = self.mRecycleOptions[i]
        option:ChangeState(option.StateTemp, false)
    end
end

---初始化回收组合提醒文字
function UIBagMain_Recycle:InitializeRechargePrompt()
    local active = false
    local cfg_global = LuaGlobalTableDeal.GetGlobalTabl(23044)
    if (cfg_global ~= nil) then
        local condition = Utility.IsMainPlayerMatchCondition(tonumber(cfg_global.value))
        if (condition) then
            active = condition.success
        end
    end
    luaclass.UIRefresh:RefreshActive(self:GetRechargePrompt_GO(), active)
end

---刷新页签的状态
function UIBagMain_Recycle:RefreshOptionByBagItemInfo(bagItemInfo, isSelected)
    if bagItemInfo ~= nil then
        for k, v in pairs(self.mRecycleOptions) do
            ---只影响对应归属的页签类型
            if v.IsBelongTo(v, bagItemInfo) then
                if isSelected then
                    ---当前物品为选中
                    v.ChangeState(v, true, true)
                else
                    ---当前物品为不选中(遍历回收物品内是否有归属物品，如果有则勾选页签，否则关掉勾选页签)
                    local recycleItemList = self:GetRecycleBagItems()
                    for recycleItemLid, isRecycle in pairs(recycleItemList) do
                        local curBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(recycleItemLid)
                        if isRecycle and bagItemInfo.lid ~= recycleItemLid and v.IsBelongTo(v, curBagItemInfo) then
                            v.ChangeState(v, true, true)
                            return
                        end
                    end

                    --region 熔炼处理
                    for SmeltItemLid, isSmelt in pairs(self:GetSmeltBagItemsStateDic()) do
                        local curBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(SmeltItemLid)
                        if isSmelt and bagItemInfo.lid ~= SmeltItemLid and v.IsBelongTo(v, curBagItemInfo) then
                            v.ChangeState(v, true, true)
                            return
                        end
                    end
                    --endregion

                    v.ChangeState(v, false, true)
                end
            end
        end
    end
end
--endregion

--region 选项Check/IsBelongTo方法
---根据装备使用等级选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number
---@param maxLevel number
---@return boolean
function UIBagMain_Recycle:SelectByUseLevel(bagItemInfo, minLevel, maxLevel)
    return self:GetRecycleDataManager():SelectByUseLevel(bagItemInfo, minLevel, maxLevel)
end

---根据是否优于身上装备的物品选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectByBetterThanEquipedItem(bagItemInfo)
    return self:GetRecycleDataManager():SelectByBetterThanEquipedItem(bagItemInfo)
end

---根据使用等级和弱与身上装备选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number
---@param maxLevel number
---@return boolean
function UIBagMain_Recycle:SelectByUseLevelAndBetterThanEquip(bagItemInfo, minLevel, maxLevel)
    return self:GetRecycleDataManager():SelectByUseLevelAndBetterThanEquip(bagItemInfo, minLevel, maxLevel)
end

---根据技能书职业类型和技能是否满级进行选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectBySkillBookType(bagItemInfo)
    return self:GetRecycleDataManager():SelectBySkillBookType(bagItemInfo)
end

---根据技能书选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectBySkillBook(bagItemInfo)
    return self:GetRecycleDataManager():SelectBySkillBook(bagItemInfo)
end

---根据转生等级选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minReinLevel number
---@param maxReinLevel number
---@return boolean
function UIBagMain_Recycle:SelectByReinLevel(bagItemInfo, minReinLevel, maxReinLevel)
    return self:GetRecycleDataManager():SelectByReinLevel(bagItemInfo, minReinLevel, maxReinLevel)
end

---根据转生等级选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minReinLevel number
---@param maxReinLevel number
---@return boolean
function UIBagMain_Recycle:SelectByReinLevelAndBetterThanEquip(bagItemInfo, minReinLevel, maxReinLevel)
    return self:GetRecycleDataManager():SelectByReinLevelAndBetterThanEquip(bagItemInfo, minReinLevel, maxReinLevel)
end

---根据更好宝物选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_Recycle:SelectByBetterGem(bagItemInfo)
    return self:GetRecycleDataManager():SelectByBetterGem(bagItemInfo)
end

---根据宝物类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectGem(bagItemInfo)
    return self:GetRecycleDataManager():SelectGem(bagItemInfo)
end

---根据是否是灵兽类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectServantRelated(bagItemInfo)
    return self:GetRecycleDataManager():SelectServantRelated(bagItemInfo)
end

---根据是否是灵兽肉身类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectServantBodyRelated(bagItemInfo)
    return self:GetRecycleDataManager():SelectServantBodyRelated(bagItemInfo)
end

---根据是否是灵兽装备类型选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectServantEquipRelated(bagItemInfo)
    return self:GetRecycleDataManager():SelectServantEquipRelated(bagItemInfo)
end

---根据灵兽与当前佩戴的灵兽对比选择
function UIBagMain_Recycle:SelectServant(bagItemInfo)
    return self:GetRecycleDataManager():SelectServant(bagItemInfo)
end

---根据灵兽肉身与当前佩戴的灵兽肉身对比选择
function UIBagMain_Recycle:SelectServantBody(bagItemInfo)
    return self:GetRecycleDataManager():SelectServantBody(bagItemInfo)
end

---根据灵兽装备与当前佩戴的灵兽装备对比选择
function UIBagMain_Recycle:SelectServantEquip(bagItemInfo)
    return self:GetRecycleDataManager():SelectServantEquip(bagItemInfo)
end

---仅选择神石类型
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectGodStone(bagItemInfo)
    return self:GetRecycleDataManager():SelectGodStone(bagItemInfo)
end

---选择低等级神石
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectLowLevelGodStone(bagItemInfo)
    return self:GetRecycleDataManager():SelectLowLevelGodStone(bagItemInfo)
end

---仅选择元素类型
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectElement(bagItemInfo)
    return self:GetRecycleDataManager():SelectElement(bagItemInfo)
end

---选择低等级元素
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectLowQualityElement(bagItemInfo)
    return self:GetRecycleDataManager():SelectLowQualityElement(bagItemInfo)
end

---选择印记
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectSignet(bagItemInfo)
    return self:GetRecycleDataManager():SelectSignet(bagItemInfo)
end

---选择低等级印记
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectLowQualitySignet(bagItemInfo)
    return self:GetRecycleDataManager():SelectLowQualitySignet(bagItemInfo)
end

---根据任务材料选择
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number 最小使用等级
---@param maxLevel number 最大使用等级
---@return boolean 是否选择该物品
function UIBagMain_Recycle:SelectTaskMaterial(bagItemInfo, minLevel, maxLevel)
    return self:GetRecycleDataManager():SelectTaskMaterial(bagItemInfo, minLevel, maxLevel)
end

---选择一部分材料
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param minLevel number 最小使用等级
---@param maxLevel number 最大使用等级
---@return boolean 是否选择该物品
function UIBagMain_Recycle:SelectPartOfMaterial(bagItemInfo, minLevel, maxLevel)
    return self:GetRecycleDataManager():SelectPartOfMaterial(bagItemInfo, minLevel, maxLevel)
end

---选择药品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectDrug(bagItemInfo)
    return self:GetRecycleDataManager():SelectDrug(bagItemInfo)
end

---选择配置默认选择药品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectLowQualityDrug(bagItemInfo)
    return self:GetRecycleDataManager():SelectLowQualityDrug(bagItemInfo)
end

---选择值得回收的藏品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectRecommendedCollections(bagItemInfo)
    return self:GetRecycleDataManager():SelectRecommendedCollections(bagItemInfo)
end

---选择藏品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectCollections(bagItemInfo)
    return self:GetRecycleDataManager():SelectCollections(bagItemInfo)
end

---选择推荐回收仙装
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectRecommendedXianZhuang(bagItemInfo)
    return self:GetRecycleDataManager():SelectRecommendedXianZhuang(bagItemInfo)
end

---选择仙装
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Recycle:SelectAllXianZhuang(bagItemInfo)
    return self:GetRecycleDataManager():SelectAllXianZhuang(bagItemInfo)
end
--endregion

--region 回收选项事件
---回收选项状态变化事件
---@param option RecycleOption
---@param isOptionOn boolean
function UIBagMain_Recycle:OnRecycleOptionStateChanged(option, isOptionOn)
    ---回收选项状态发生改变时,更改其对应的物品列表的Checked状态
    local bagItemList = self:GetBagItemList()
    local bagPanel = self:GetBagPanel()
    local checkFunc = ternary(isOptionOn == true, option.Check, option.IsBelongTo)
    for i, v in pairs(bagItemList) do
        ---推荐回收列表
        local isRecommendRecycleItem = self:GetCSBagInfo():IsRecommendRecycleItem(v, true)
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():AddRecycleItemDefaultState(v.lid, isRecommendRecycleItem)
        local isOldBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():IsContainRecycleDefaultItem(v.lid)
        ---判断是否达到归属条件
        if v and option.IsBelongTo(option, v) and not (self.bagItemChange and isOldBagItemInfo) then
            ---当前物品的选中状态
            local currentState = self:GetBagItemSelectedState(v)
            if isOptionOn == true then
                ---如果当前回收选项是true，则归属物品的状态为筛选条件状态
                ---默认勾选状态
                local chooseState = checkFunc(option, v)
                ---回收设置回收状态
                local settingChooseState = self:IsRecoverSettingAllowChoose(v)
                if settingChooseState == nil then
                    settingChooseState = CS.Cfg_RecoverSetTableManager.Instance:SettingRecycle(v, chooseState)
                end
                ---物品具体显示的回收状态（如果当前物品缓存的物品的回收状态，则显示对应的回收状态，否则由回收设置和基础逻辑进行判断当前的选择状态）
                local curChooseState = chooseState and settingChooseState
                if (curChooseState == true) then
                    if (self:IsCanDefaultRecycle(v) == false) then
                        curChooseState = false
                    end
                end

                if self:IsAvailableForSemelt(v) then
                    ---设置背包熔炼数据
                    self:SetBagItemSelectSmeltData(v, curChooseState)
                else
                    if curChooseState ~= currentState then
                        self:SetBagItemSelectedState(v, curChooseState)
                    end
                    ---刷新收益数据
                    self:RefreshEarningData(v, curChooseState)
                end

                ---当前选择数量管理
                if curChooseState == true then
                    self:RefreshChooseData(v.ItemTABLE.id, curChooseState)
                end
                ---设置当前物品的默认状态（即默认归属状态）
                self:SetBagGridState(v, chooseState)
                ---存储默认回收装备状态
                --gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():AddRecycleItemDefaultState(v.lid, curChooseState)
            elseif isOptionOn == false then
                ---如果过当前回收选项是false，则归属物品的状态都为false
                if currentState ~= isOptionOn then

                    if self:IsAvailableForSemelt(v) then
                        ---设置背包熔炼数据
                        self:SetBagItemSelectSmeltData(v, isOptionOn)
                    else
                        self:SetBagItemSelectedState(v, isOptionOn)
                        ---刷新收益数据
                        self:RefreshEarningData(v, isOptionOn)
                    end

                    self:RefreshChooseData(v.itemId, isOptionOn)
                end
                ---存储默认回收装备状态
                --gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():AddRecycleItemDefaultState(v.lid, currentState)
            end
            ---刷新格子
            if v then
                local grid = bagPanel:GetBagGrid(v.lid)
                ---若当前背包视野内有物品对应的格子,则刷新,若未找到对应格子,则不再考虑
                if grid then
                    grid:Refresh()
                end
            end
        end
    end
    self:RefreshRecycleEarning()
    if self.isNewRecycle then
        self:SavePlayerChooseState(option.RecycleOptionType, isOptionOn)
    end
end

---是否能默认回收
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 返回true的话不影响其他判定,如果返回false的话  不默认勾选
function UIBagMain_Recycle:IsCanDefaultRecycle(bagItemInfo)
    local bloodsuit = clientTableManager.cfg_bloodsuitManager:TryGetValue(bagItemInfo.itemId)
    if bloodsuit == nil then
        return true
    end
    local type = bloodsuit:GetQualityLevel()

    local MainPlayerBloodSuitEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
    local IsOpenEquipType = MainPlayerBloodSuitEquipMgr:IsOpenEquipType(type)
    if (IsOpenEquipType == false) then
        return true
    end
    ---@type LuaPlayerEquipBloodSuitListData
    local PlayerEquipBloodSuitListData = MainPlayerBloodSuitEquipMgr:GetSingleBloodSuitListData(type);
    if PlayerEquipBloodSuitListData == nil then
        return true
    end
    if MainPlayerBloodSuitEquipMgr:IsOpenBloodSuitSystem() == false then
        return true
    end

    local equipSuit = PlayerEquipBloodSuitListData.SingleBloodSuitDic
    if (equipSuit == nil) then
        ---等于nil的时候,说明一个都没有穿
        return false
    end
    ---如果有一样的 判定血继等级是否满级
    for i, v in pairs(equipSuit) do
        if v.ItemID == bagItemInfo.itemId then
            if (v.BagItemInfo.bloodLevel < 5) then
                return false
            else
                return true
            end
        end
    end
    ---是灵兽
    if (bloodsuit:GetType() == 1) then
        ---如果没有找到,那么判定下血继套装数量,数量不足,说明还可以穿
        local count = PlayerEquipBloodSuitListData.ServantCount
        if (count < 8) then
            return false
        end
    elseif (bloodsuit:GetType() == 2) then
        ---法宝
        return true
    end
    return true
end

---回收设置刷新，刷新已勾选的物品
---@param optionTypeTable table<number, luaEnumRecycleOptionType>
function UIBagMain_Recycle:onRecycleSettingOptionStateChanged(optionTypeTable)
    if self.mRecycleOptions ~= nil and optionTypeTable ~= nil then
        local optionTable = {}
        for k, v in pairs(optionTypeTable) do
            local isExistInRecycleOptions = false
            local temp = nil
            for i = 1, #self.mRecycleOptions do
                if self.mRecycleOptions[i].RecycleOptionType == v then
                    isExistInRecycleOptions = true
                    temp = self.mRecycleOptions[i]
                    break
                end
            end
            if isExistInRecycleOptions and temp ~= nil then
                table.insert(optionTable, temp)
            end
        end
        local bagItemList = self:GetBagItemList()
        local bagPanel = self:GetBagPanel()
        for i, v in pairs(bagItemList) do
            local currentState = self:GetBagItemSelectedState(v)
            if self:IsBelongByOptionTable(v, optionTable) then
                ---如果当前回收选项是true，则归属物品的状态为筛选条件状态
                local chooseState = self:IsCheckByOptionTable(v, optionTable) == true and self:IsHaveChooseOption(optionTable)
                local settingRecycle = self:IsRecoverSettingAllowChoose(v)
                if settingRecycle == nil then
                    settingRecycle = CS.Cfg_RecoverSetTableManager.Instance:SettingRecycle(v, chooseState)
                end

                if self:IsAvailableForSemelt(v) then
                    ---设置背包熔炼数据
                    self:SetBagItemSelectSmeltData(v, settingRecycle)
                else
                    if settingRecycle ~= currentState then
                        self:SetBagItemSelectedState(v, settingRecycle)
                    end
                    ---刷新收益数据
                    self:RefreshEarningData(v, settingRecycle)
                end
                ---设置当前物品的默认状态（即默认归属状态）
                self:SetBagGridState(v, settingRecycle)
            end
            ---刷新格子
            if v then
                local grid = bagPanel:GetBagGrid(v.lid)
                ---若当前背包视野内有物品对应的格子,则刷新,若未找到对应格子,则不再考虑
                if grid then
                    grid:Refresh()
                end
            end
        end
    end
    self:RefreshRecycleEarning()
end

---策划要求个别物品的默认状态特殊处理
function UIBagMain_Recycle:GetSpecialItemDefaultState(bagItemInfo)
    if bagItemInfo ~= nil and bagItemInfo.ItemTABLE ~= nil then
        local servantInfo = self:GetCSMainPlayerInfo().ServantInfoV2
        local itemInfo = bagItemInfo.ItemTABLE
        ---灵兽蛋
        if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
                and itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 8 then
            if servantInfo:IsCommonServant(itemInfo) and (servantInfo:HaveUnLockServantIndex() == true or servantInfo:HaveEmptyServantIndex() == true) then
                return false
            end
        end
        ---灵兽肉身
        if self:GetCSBagInfo():IsAvailableForRecycle(bagItemInfo, true) and self:IsCanBeRecycled(bagItemInfo)
                and CS.CSServantInfoV2.IsServantBody(bagItemInfo.ItemTABLE) then
            if CS.CSServantInfoV2.IsServantCommonBody(itemInfo.subType) and servantInfo:HaveUnLockServantIndex() == true then
                return false
            end
        end
    end
    return true
end
--endregion

--region 回收设置拓展
---回收设置是否允许选中
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean|nil
function UIBagMain_Recycle:IsRecoverSettingAllowChoose(bagItemInfo)
    if bagItemInfo == nil or bagItemInfo.ItemTABLE == nil or bagItemInfo.ItemTABLE.type ~= luaEnumItemType.Collection then
        return
    end
    local subType = bagItemInfo.ItemTABLE.subType
    local settingOptionType
    if subType == LuaEnumCollectionType.QingTongQi then
        settingOptionType = luaEnumRecycleSettingOptionType.QingTongQi
    elseif subType == LuaEnumCollectionType.TaoQi then
        settingOptionType = luaEnumRecycleSettingOptionType.TaoQi
    elseif subType == LuaEnumCollectionType.CiQi then
        settingOptionType = luaEnumRecycleSettingOptionType.CiQi
    elseif subType == LuaEnumCollectionType.YuQi then
        settingOptionType = luaEnumRecycleSettingOptionType.YuQi
    elseif subType == LuaEnumCollectionType.JinYinQi then
        settingOptionType = luaEnumRecycleSettingOptionType.JinYinQi
    elseif subType == LuaEnumCollectionType.FaQi then
        settingOptionType = luaEnumRecycleSettingOptionType.FaQi
    end
    if settingOptionType == nil then
        return
    end
    local options = CS.Cfg_RecoverSetTableManager.Instance:GetIsChooseRecycleSettingOptionListByOptionId(settingOptionType)
    if options == nil or options.Count == 0 then
        return false
    end
    for i = 1, options.Count do
        ---@type RecycleSettingOption
        local settingOption = options[i - 1]
        if settingOption and settingOption.ExtraParams ~= nil
                and settingOption.ExtraParams.Count > 0
                and settingOption.ExtraParams[0] == subType
                and settingOption.ChooseState then
            local isCollectionSelected = false
            for j = 1, #self.mRecycleOptions do
                local optionRecoverId = self.mRecycleOptions[j].RecycleOptionType
                if optionRecoverId == luaEnumRecycleOptionType.QingTongQi or optionRecoverId == luaEnumRecycleOptionType.TaoQi or optionRecoverId == luaEnumRecycleOptionType.CiQi or
                        optionRecoverId == luaEnumRecycleOptionType.YuQi or optionRecoverId == luaEnumRecycleOptionType.JinYinQi or optionRecoverId == luaEnumRecycleOptionType.FaQi then
                    isCollectionSelected = self.mRecycleOptions[j].StateTemp
                    break
                end
            end
            return isCollectionSelected and self:SelectRecommendedCollections(bagItemInfo)
        end
    end
    return false
end
--endregion

--region 延迟刷新
---设置延迟刷新背包格子特效
---@private
function UIBagMain_Recycle:SetDelayRefreshBagItemEffect()
    self.mDelayRefreshBagGridEffectTime = self:GetBagPanel():GetTime() + 0.01
end

---设置延迟刷新背包物品
---@private
function UIBagMain_Recycle:SetDelayRefreshBagItem()
    self.mDelayRefreshBagTime = self:GetBagPanel():GetTime() + self.bagGridDeltaRefreshTime
end

---设置延迟播放回收特效
---@private
function UIBagMain_Recycle:SetDelayPlayRecycleEffectItem()
    self.mDelayPlayRecycleEffectTime = self:GetBagPanel():GetTime() + self.playRecycleEffectDeltaTime
end

---设置延迟背包货币刷新
---@private
function UIBagMain_Recycle:SetDelayRefreshCoin()
    self.mDelayRefreshBagCoin = self:GetBagPanel():GetTime() + self.coinDeltaRefreshTime
end
--endregion

--region 回收操作
---执行回收操作
function UIBagMain_Recycle:DoRecycleOperation()
    if self:IsRecycleAvailable() then
        if self:IsBetterBagItemExistInRecycleList() then
            local wordTbl, tblExist
            tblExist, wordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(13)
            if tblExist and wordTbl then
                Utility.ShowSecondConfirmPanel({ PromptWordId = 13, ComfireAucion = self.mOnRecyclePromptConfirmedFunction })
            else
                self:RequestRecycle()
            end
        else
            self:RequestRecycle()
        end
        self:GetRecycleButtonEffectGO():SetActive(false)
    end
end

---是否回收功能可用
---@private
---@return boolean
function UIBagMain_Recycle:IsRecycleAvailable()
    local isRecycleAvailable = false
    for i, v in pairs(self:GetRecycleBagItems()) do
        if v == true then
            isRecycleAvailable = true
            break
        end
    end
    for i, v in pairs(self:GetSmeltBagItemsStateDic()) do
        if v == true then
            isRecycleAvailable = true
            break
        end
    end
    return isRecycleAvailable
end

---更好的物品是否存在于回收列表中
---@private
---@return boolean
function UIBagMain_Recycle:IsBetterBagItemExistInRecycleList()
    local isBetterBagItemExist = false
    local bagItemList = self:GetBagItemList()
    for k, v in pairs(bagItemList) do
        if self:GetBestBagItemState(v) == false and self:GetBagItemSelectedState(v) == true then
            return true
        end
    end
    return isBetterBagItemExist
end

---请求回收
---@private
function UIBagMain_Recycle:RequestRecycle()
    local bagInfo = self:GetCSMainPlayerInfo().BagInfo
    self.recycleList = bagInfo:GetRecycleItemList()
    self.recycleItemDic = self:GetCSMainPlayerInfo().BagInfo:GetRecycleEarningDic()
    self:SetDelayRefreshBagItem()
    networkRequest.ReqRecycleEquipment(self.recycleList, 0, bagInfo.RecycleSettingData)
    self:OnSmeltBtnClickCallBack()
end

---打开回收设置界面
---@private
function UIBagMain_Recycle:OpenRecycleSettingPanel()
    if self:GetRecycleConfigGO() ~= nil and self.recycleSettingTemplate == nil then
        self.recycleSettingTemplate = templatemanager.GetNewTemplate(self:GetRecycleConfigGO(), luaComponentTemplates.UIBagRecycle_Setting)
    end
    if self.recycleSettingTemplate ~= nil then
        self.recycleSettingTemplate:RefreshPanel(self)
        self.recycleSettingTemplate:OpenPanel()
    end
end

---检查回收后是否需要整理
function UIBagMain_Recycle:CheckIsNeedTrimAfterRecycle()
    ---第二页第三页有东西时,整理一遍
    if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.BagInfo then
        local bagItems = CS.CSScene.MainPlayerInfo.BagInfo.BagItems
        if bagItems then
            local minSecondPageIndex = self:GetGridCountPerPage()
            local needTrim = false
            for i, v in pairs(bagItems) do
                if v.bagIndex >= minSecondPageIndex then
                    needTrim = true
                    break
                end
            end
            if needTrim then
                self:DoTrim()
            end
        end
    end
end
--endregion

--region 回收收益
---刷新回收收益
function UIBagMain_Recycle:RefreshRecycleEarning()
    local recycleEarning = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():GetRecycleEarningMgr():GetBagRecycleEarningList()
    local tableCount = Utility.GetLuaTableCount(recycleEarning)
    local recycleEarningCount = tableCount
    local index = tableCount
    if type(recycleEarning) ~= 'table' or tableCount <= 0 then
        self:GetRecycleEarningGridContainer().MaxCount = 0
    else
        self:GetRecycleEarningGridContainer().MaxCount = tableCount
        local index = 0
        for k, v in pairs(recycleEarning) do
            ---@type UnityEngine.GameObject
            local gameObject = self:GetRecycleEarningGridContainer().controlList[index]
            ---@type RecycleEarning
            local recycleEarning = v
            local earningTemplate = self:GetRecycleEarningTemplate(gameObject)
            local des = ""
            if type(recycleEarning.recycleAdditionList) == 'table' and Utility.GetLuaTableCount(recycleEarning.recycleAdditionList) > 0 then
                for k, v in pairs(recycleEarning.recycleAdditionList) do
                    ---@type RecycleAddition
                    local recycleEarningAddition = v
                    if CS.StaticUtility.IsNullOrEmpty(recycleEarningAddition.des) == false then
                        if k == #recycleEarning.recycleAdditionList then
                            des = des .. recycleEarningAddition.des
                        else
                            des = des .. recycleEarningAddition.des .. "\n"
                        end
                    end
                end
            end
            earningTemplate:Refresh(recycleEarning.itemId, Utility.RemoveEndZero(recycleEarning.curTotalNumber), des)
            index = index + 1
        end
    end

    --region 熔炼积分收益处理
    for k, v in pairs(self:GetSmeltEarningItemDic()) do
        if v ~= 0 then
            recycleEarningCount = recycleEarningCount + 1
            self:GetRecycleEarningGridContainer().MaxCount = recycleEarningCount
            local earningGameObject4 = self:GetRecycleEarningGridContainer().controlList[index]
            local smeltScoreTemplate = self:GetRecycleEarningTemplate(earningGameObject4)
            smeltScoreTemplate:Refresh(k, tostring(v), '')
        end
        index = index + 1
    end
    --endregion

    luaclass.UIRefresh:RefreshUITable(self:GetRecycleEarningUITable())
end

---@return UIBagRecycleEarning
function UIBagMain_Recycle:GetRecycleEarningTemplate(go)
    if go == nil then
        return nil
    end
    if self.mRecyclingEarningTemplates == nil then
        self.mRecyclingEarningTemplates = {}
    end
    if self.mRecyclingEarningTemplates[go] == nil then
        self.mRecyclingEarningTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBagRecycleEarning)
    end
    return self.mRecyclingEarningTemplates[go]
end

function UIBagMain_Recycle:RefreshEarningData(bagItemInfo, state)
    if state then
        self:GetCSBagInfo():AddRecycleItem(bagItemInfo)
    else
        self:GetCSBagInfo():RemoveRecycleItem(bagItemInfo)
    end
end

function UIBagMain_Recycle:GetEarningItemLidList()
    return self:GetCSBagInfo():GetRecycleItemList()
end

function UIBagMain_Recycle:ClearRecycleItemList()
    self.mRecycleBagItemsDefaultStat = {}
    self:GetCSBagInfo():ClearRecycleItemList()
    self:GetCSBagInfo():ClearRecycleRemainNumDic()
    ---清理熔炼数据
    self:ClearSmeltData()
end
--endregion

--region 回收特效相关
function UIBagMain_Recycle:SetAllDelay()
    self:SetDelayRefreshBagItem()
    self:SetDelayRefreshBagItemEffect()
    self:SetDelayPlayRecycleEffectItem()
    self:SetDelayRefreshCoin()
end

---播放回收特效
function UIBagMain_Recycle:PlayEarningEffect()
    uimanager:CreatePanel("UIExpBallEffectPanel", nil, self.recycleItemDic)
end

---播放回收格子特效
function UIBagMain_Recycle:PlayRecycleGridEffect(grid, show)
    ---显示回收特效
    local bagItemList = self:GetBagItemList()
    for k, v in pairs(bagItemList) do
        local bagGrid = self:GetBagGridByBagItemlid(v.lid)
        if bagGrid and self.recycleList ~= nil and self.recycleList:Contains(v.lid) then
            ---显示回收特效
            bagGrid:SetCompActive(bagGrid.Components.RecycleEffect, true)
        end
    end
end
--endregion

--region 货币刷新
---刷新货币数量
---@overload fun()
---@public
---@param isFirstTime boolean 是否是第一次刷新,若第一次刷新,则刷新icon和active状态
function UIBagMain_Recycle:RefreshCoins(isFirstTime, deltaRefresh)
    if isFirstTime then
        ---重置左货币和右货币数量
        self.mLeftCoinCountCache = -1
        self.mRightCoinCountCache = -1
        ---刷新货币显示状态
        self:RefreshCoinsExistState()
        ---刷新货币ICON
        self:RefreshCoinsIcons()
        ---刷新货币数量
        self:RefreshCoinLabel()
    end
    if deltaRefresh then
        self:RefreshCoinLabelByTween()
        self:GetBagPanel():TriggleCoinAddTip()
    end
end
--endregion

--region 勾选数量数据刷新
function UIBagMain_Recycle:RefreshChooseData(itemId, isChoose)
    if isChoose then
        if self:GetCSBagInfo():HaveRemainRecycleNum(itemId) == true then
            self:GetCSBagInfo():AddRecycleRemainNum(itemId, 1)
        end
    else
        self:GetCSBagInfo():RemoveRecycleRemainNum(itemId, 1)

    end
end
--endregion

--region 勾选状态数据管理
function UIBagMain_Recycle:RefreshChooseStage(lid, stage)
    self:GetCSBagInfo():AddRecycleItemState(lid, stage)
end
--endregion

--region 查询
---是否有允许的选项页签归属条件达到
function UIBagMain_Recycle:IsBelongByOptionTable(bagItemInfo, optionTable)
    if bagItemInfo ~= nil and optionTable ~= nil then
        for k, v in pairs(optionTable) do
            local option = v
            if option.IsBelongTo(option, bagItemInfo) then
                return true
            end
        end
    end
    return false
end

---是否有允许的选项页签勾选条件达到
function UIBagMain_Recycle:IsCheckByOptionTable(bagItemInfo, optionTable)
    if bagItemInfo ~= nil and optionTable ~= nil then
        for k, v in pairs(optionTable) do
            local option = v
            if option.Check(option, bagItemInfo) then
                return true
            end
        end
    end
    return false
end

---是否有勾选的选项
function UIBagMain_Recycle:IsHaveChooseOption(optionTable)
    if optionTable ~= nil then
        for k, v in pairs(optionTable) do
            if v.StateTemp == true then
                return true
            end
        end
    end
    return false
end
--endregion

--region 熔炼处理

--region 属性
---当前可熔炼的物品列表,number为lid,boolean值为true的表示需要被熔炼
---@return table<number,boolean>
function UIBagMain_Recycle:GetSmeltBagItemsStateDic()
    if self.mSmeltBagItemsStateDic == nil then
        self.mSmeltBagItemsStateDic = {}
    end
    return self.mSmeltBagItemsStateDic
end

---记录当前选中熔炼物品的可获得稀有物品列表，number为itemid,Value值为当前对应的熔炼道具个数
---@return table<number,number>
function UIBagMain_Recycle:GetSmeltEarningItemDic()
    if self.mSmeltEarningItemDic == nil then
        self.mSmeltEarningItemDic = {}
    end
    return self.mSmeltEarningItemDic
end

---设置熔炼收益
---@param num number
function UIBagMain_Recycle:SetSmeltEarningItemInfo(itemID, num)
    if self:GetSmeltEarningItemDic()[itemID] == nil then
        self:GetSmeltEarningItemDic()[itemID] = num < 0 and 0 or num
    else
        local curNum = self:GetSmeltEarningItemDic()[itemID]
        curNum = curNum + num < 0 and 0 or curNum + num
        self:GetSmeltEarningItemDic()[itemID] = curNum
    end
end

---设置背包物品的熔炼信息
---@param bagItemInfo bagV2.BagItemInfo
---@param isSelected boolean
function UIBagMain_Recycle:SetBagItemSelectSmeltData(bagItemInfo, isSelected)
    if not self:IsAvailableForSemelt(bagItemInfo) then
        return
    end
    self:GetSmeltBagItemsStateDic()[bagItemInfo.lid] = isSelected

    ---设置熔炼收益
    if bagItemInfo.ItemTABLE.smelt ~= nil and bagItemInfo.ItemTABLE.smelt.list ~= nil then
        for i = 0, bagItemInfo.ItemTABLE.smelt.list.Count - 1 do
            local smeltInfoList = bagItemInfo.ItemTABLE.smelt.list[i]
            if smeltInfoList.list ~= nil and smeltInfoList.list.Count > 1 then
                ---获取格子所有数量的收益
                local allNum = smeltInfoList.list[1] * bagItemInfo.count
                self:SetSmeltEarningItemInfo(smeltInfoList.list[0], isSelected and allNum or allNum * -1)
            end
        end
    end
end

--endregion

---点击熔炼按钮
function UIBagMain_Recycle:OnSmeltBtnClickCallBack()
    local smeltList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    for k, v in pairs(self:GetSmeltBagItemsStateDic()) do
        if v then
            smeltList:Add(k)
        end
    end
    if smeltList.Count > 0 then
        networkRequest.ReqSmelt(smeltList)
    end
    self:ClearSmeltData()
end

---清理熔炼数据
function UIBagMain_Recycle:ClearSmeltData()
    self.mSmeltEarningItemDic = {}
    self.mSmeltBagItemsStateDic = {}
end

---判断是否符合熔炼UIForgeStrengthenPanel
---@private
function UIBagMain_Recycle:IsAvailableForSemelt(bagItemInfo)
    --[[    return bagItemInfo.ItemTABLE ~= nil and
                bagItemInfo.ItemTABLE.smelt ~= nil and
                bagItemInfo.ItemTABLE.smelt.list ~= nil and
                bagItemInfo.ItemTABLE.smelt.list.Count > 0]]
    return false
end

--endregion

--region 新版回收
---@return LuaConfig_BagRecycle 回收设置数据
function UIBagMain_Recycle:GetRecycleSettingManager()
    return gameMgr:GetPlayerDataMgr():GetConfigManager():GetBagRecycleData()
end

---@return LuaMainPlayerBagRecycleMgr 背包回收管理类
function UIBagMain_Recycle:GetRecycleDataManager()
    return gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr()
end

function UIBagMain_Recycle:InitializeRecycleOptions_New()
    self:AddAllRecycleOptions_New()
    self:CreateAndBindAllRecycleTemplates()
    self:InitializeAllRecycleOptionDefaultState_New()
    self:InitializeRechargePrompt()
end

function UIBagMain_Recycle:AddAllRecycleOptions_New()
    if self.mRecycleOptions then
        for i, v in pairs(self.mRecycleOptions) do
            self:PushRecycleOption(v)
        end
        Utility.ClearTable(self.mRecycleOptions)
    else
        self.mRecycleOptions = {}
    end
    ---改成读表
    local allToggle = clientTableManager.cfg_recoverManager:GetAllMenu()
    if allToggle == nil then
        return
    end

    ---@param l  TABLE.cfg_recover
    ---@param r  TABLE.cfg_recover
    table.sort(allToggle, function(l, r)
        if l == nil or r == nil or l:GetOrder() == nil or r:GetOrder() == nil then
            return false
        end
        return l:GetOrder() < r:GetOrder()
    end)

    for i = 1, #allToggle do
        local recover = allToggle[i]
        if self:IsMainPlayerMatchAllCondition(recover) then
            --取消了根据左边装备选择右边toggle这一步,直接选中右边的toggle然后选中左边道具
            self:AddRecycleOption(recover:GetId(), recover:GetDes(), function(tbl, bagItemInfo)
                return self:SelectRecommendItem(bagItemInfo)
            end, function(tbl, bagItemInfo, coverId)
                return self:IsBelongToToggle(bagItemInfo, coverId)
            end, false)
        end
    end
end

---@param recover TABLE.cfg_recover
function UIBagMain_Recycle:IsMainPlayerMatchAllCondition(recover)
    return self:GetRecycleDataManager():IsMainPlayerMatchAllRecoverCondition(recover)
end

---根据选中的页签判断道具是否需要选中
---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_Recycle:IsBelongToToggle(bagItemInfo, optionCoverId)
    return self:GetRecycleDataManager():IsBelongToToggle(bagItemInfo, optionCoverId)
end

---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 判断单个道具是否需要选中
function UIBagMain_Recycle:SelectRecommendItem(bagItemInfo)
    return self:GetRecycleDataManager():SelectRecommendItem(bagItemInfo)
end

---初始化所有回收选项的默认状态
function UIBagMain_Recycle:InitializeAllRecycleOptionDefaultState_New()
    if self.mRecycleOptions == nil then
        return
    end
    for i = 1, #self.mRecycleOptions do
        ---@type RecycleOption
        local option = self.mRecycleOptions[i]
        local type = option.RecycleOptionType
        local state = self:GetRecycleSettingManager():GetRecoverState(type)
        option:ChangeState(state)
    end
end

---存储设置玩家选项
function UIBagMain_Recycle:SavePlayerChooseState(recoverId, state)
    gameMgr:GetPlayerDataMgr():GetConfigManager():GetBagRecycleData():PlayerSettingRecoverState(recoverId, state)
end

---@return TABLE.cfg_items 缓存表数据
function UIBagMain_Recycle:CacheItemInfo(id)
    if id == nil then
        return
    end
    if self.mItemIdToItemInfo == nil then
        self.mItemIdToItemInfo = {}
    end
    local data = self.mItemIdToItemInfo[id]
    if data == nil then
        data = clientTableManager.cfg_itemsManager:TryGetValue(id)
        self.mItemIdToItemInfo[id] = data
    end
    return data
end

---@return TABLE.cfg_recover 缓存Recover表数据
function UIBagMain_Recycle:CacheRecoverInfo(id)
    if id == nil then
        return
    end
    if self.mCoverIdToCoverInfo == nil then
        self.mCoverIdToCoverInfo = {}
    end
    local data = self.mCoverIdToCoverInfo[id]
    if data == nil then
        data = clientTableManager.cfg_recoverManager:TryGetValue(id)
        self.mCoverIdToCoverInfo[id] = data
    end
    return data
end

---自动回收
function UIBagMain_Recycle:OnAutoRecycleClicked(go)
    local memberCondition = LuaGlobalTableDeal:GetAutoRecyclePlayerCondition()
    if memberCondition == nil then
        return
    end

    local buff = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():GetTimeLimitRecycleBuff()
    if buff ~= true then
        local fullState = Utility.IsMainPlayerMatchCondition(memberCondition)
        if fullState == nil or fullState.success == false then
            local info = clientTableManager.cfg_promptframeManager:TryGetValue(482)
            if info then
                local member = clientTableManager.cfg_memberManager:TryGetValue(fullState.param)
                if member then
                    local str = string.format(info:GetContent(), member:GetName())
                    Utility.ShowPopoTips(go, str, 482)
                end
            end
            return
        end
    end

    local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
    local state = configInfo:GetInt(CS.EConfigOption.AutoRecycle) == 1
    local change = state and 0 or 1
    configInfo:SetInt(CS.EConfigOption.AutoRecycle, change)
    self:SetAutoRecycleState(change == 1)
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():AutoRecycle()
end

function UIBagMain_Recycle:InitAutoRecycleBtn()
    local choose = gameMgr:GetPlayerDataMgr():GetConfigManager():GetBagRecycleData():IsPlayerOpenAutoRecycle()
    self:SetAutoRecycleState(choose)
end

function UIBagMain_Recycle:SetAutoRecycleState(state)
    self:GetAutoRecycleBtnCheck_GO():SetActive(state)
end
--endregion

---刷新任务回收按钮特效
function UIBagMain_Recycle:RefreshRecycleTaskButtonEffect()
    local idList = LuaGlobalTableDeal.GetHuiShouEffectTaskIList()
    local isNeedShow = false;
    for i, v in pairs(idList) do
        local isfind, tempMission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(tonumber(v))
        if isfind then
            isNeedShow = true
        end
    end
    self:GetRecycleButtonEffectGO().gameObject:SetActive(isNeedShow)
end

return UIBagMain_Recycle