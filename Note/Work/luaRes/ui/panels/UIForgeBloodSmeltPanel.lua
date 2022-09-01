---@class UIForgeBloodSmeltPanel:UIBase 血继熔炼面板
local UIForgeBloodSmeltPanel = {}

local IsNullFunc = CS.StaticUtility.IsNull

--region 局部变量定义
---存储打开界面名
---@type table<number,string>
UIForgeBloodSmeltPanel.mAllOpenPanel = nil

---当前选中装备
---@type bagV2.BagItemInfo
UIForgeBloodSmeltPanel.mChooseItemInfo = nil

---背包界面
---@type UIBagPanel
UIForgeBloodSmeltPanel.mBagPanel = nil

---血继界面
---@type UIRoleBloodSuitPanel
UIForgeBloodSmeltPanel.mBloodSuitPanel = nil

---@type LuaEnumBloodSuitSmeltType 当前界面类型
UIForgeBloodSmeltPanel.mCurrentPanelType = nil

---@type table<number,bagV2.BagItemInfo> 当前选中道具的可熔炼列表
UIForgeBloodSmeltPanel.mCurrentShowSmeltList = nil

UIForgeBloodSmeltPanel.mChooseMenuType = {
    LuaEquipBloodSuitType.Yao,
    LuaEquipBloodSuitType.Xian,
    LuaEquipBloodSuitType.Mo,
    LuaEquipBloodSuitType.Ling,
    LuaEquipBloodSuitType.Shen,
}

UIForgeBloodSmeltPanel.mChooseIndexType = {
    LuaEquipBloodSuitItemType.egg1,
    LuaEquipBloodSuitItemType.egg2,
    LuaEquipBloodSuitItemType.egg3,
    LuaEquipBloodSuitItemType.egg4,
    LuaEquipBloodSuitItemType.egg5,
    LuaEquipBloodSuitItemType.egg6,
    LuaEquipBloodSuitItemType.egg7,
    LuaEquipBloodSuitItemType.egg8,
    LuaEquipBloodSuitItemType.body1,
    LuaEquipBloodSuitItemType.body2,
    LuaEquipBloodSuitItemType.body3,
    LuaEquipBloodSuitItemType.body4,
}

---@type table<LuaEquipBloodSuitType,LuaRedPointName> 血继套装红点
UIForgeBloodSmeltPanel.defaultSuitRedPointDic = {
    [LuaEquipBloodSuitType.Yao] = LuaRedPointName.BloodSuitSmelt_Yao,
    [LuaEquipBloodSuitType.Xian] = LuaRedPointName.BloodSuitSmelt_Xian,
    [LuaEquipBloodSuitType.Mo] = LuaRedPointName.BloodSuitSmelt_Mo,
    [LuaEquipBloodSuitType.Ling] = LuaRedPointName.BloodSuitSmelt_Ling,
    [LuaEquipBloodSuitType.Shen] = LuaRedPointName.BloodSuitSmelt_Shen,
}
--endregion

--region 组件
---@return UnityEngine.GameObject 关闭界面按钮
function UIForgeBloodSmeltPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

--region 页签
---@return UnityEngine.GameObject 血继界面按钮
function UIForgeBloodSmeltPanel:GetBloodSuitBtn_Go()
    if self.mBloodSuitBtn == nil then
        self.mBloodSuitBtn = self:GetCurComp("WidgetRoot/events/btn_role", "GameObject")
    end
    return self.mBloodSuitBtn
end

---@return UISprite 血继界面按钮图片
function UIForgeBloodSmeltPanel:GetBloodSuitBtn_UISprite()
    if self.mBloodSuitBtnSP == nil then
        self.mBloodSuitBtnSP = self:GetCurComp("WidgetRoot/events/btn_role/icon", "UISprite")
    end
    return self.mBloodSuitBtnSP
end

---@return UnityEngine.GameObject 血继界面按钮选中
function UIForgeBloodSmeltPanel:GetBloodSuitBtnChoose_Go()
    if self.mBloodSuitBtnChoose == nil then
        self.mBloodSuitBtnChoose = self:GetCurComp("WidgetRoot/events/btn_role/Checkmark", "GameObject")
    end
    return self.mBloodSuitBtnChoose
end

---@return UnityEngine.GameObject 背包界面按钮
function UIForgeBloodSmeltPanel:GetBagBtn_Go()
    if self.mBagBtn == nil then
        self.mBagBtn = self:GetCurComp("WidgetRoot/events/btn_bag", "GameObject")
    end
    return self.mBagBtn
end

---@return UISprite 背包界面按钮图片
function UIForgeBloodSmeltPanel:GetBagBtn_UISprite()
    if self.mBagBtnSP == nil then
        self.mBagBtnSP = self:GetCurComp("WidgetRoot/events/btn_bag/icon", "UISprite")
    end
    return self.mBagBtnSP
end

---@return UnityEngine.GameObject 背包界面按钮选中
function UIForgeBloodSmeltPanel:GetBagBtnChoose_Go()
    if self.mBagBtnChoose == nil then
        self.mBagBtnChoose = self:GetCurComp("WidgetRoot/events/btn_bag/Checkmark", "GameObject")
    end
    return self.mBagBtnChoose
end
--endregion

---@return UnityEngine.GameObject 熔炼按钮
function UIForgeBloodSmeltPanel:GetSmeltBtn_Go()
    if self.mSmeltBtn == nil then
        self.mSmeltBtn = self:GetCurComp("WidgetRoot/events/btn_Smelt", "GameObject")
    end
    return self.mSmeltBtn
end

---@return UnityEngine.GameObject 帮助按钮
function UIForgeBloodSmeltPanel:GetHelpBtn_Go()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return self.mHelpBtn
end

---@return UILabel 获取装备名字
function UIForgeBloodSmeltPanel:GetTitle_UILabel()
    if self.mTitleLb == nil then
        self.mTitleLb = self:GetCurComp("WidgetRoot/view/Title/name", "UILabel")
    end
    return self.mTitleLb
end

---@return UnityEngine.GameObject 获取标题
function UIForgeBloodSmeltPanel:GetTitle_GO()
    if self.mTitleGo == nil then
        self.mTitleGo = self:GetCurComp("WidgetRoot/view/Title", "GameObject")
    end
    return self.mTitleGo
end

---@return UISprite 获取道具icon
function UIForgeBloodSmeltPanel:GetSmeltItemIcon_UISprite()
    if self.mIconSp == nil then
        self.mIconSp = self:GetCurComp("WidgetRoot/view/itemTemplate/icon", "UISprite")
    end
    return self.mIconSp
end

---@return UnityEngine.GameObject 获取AddGo
function UIForgeBloodSmeltPanel:GetSmeltAddSign_GO()
    if self.mAddSignGo == nil then
        self.mAddSignGo = self:GetCurComp("WidgetRoot/view/itemTemplate/add", "GameObject")
    end
    return self.mAddSignGo
end

---@return UnityEngine.GameObject 获取等级
function UIForgeBloodSmeltPanel:GetSmeltLevel_GO()
    if self.mSmeltLevelGo == nil then
        self.mSmeltLevelGo = self:GetCurComp("WidgetRoot/view/lv_bg", "GameObject")
    end
    return self.mSmeltLevelGo
end

---@return UILabel 血继等级显示
function UIForgeBloodSmeltPanel:GetSmeltExpShow_UILabel()
    if self.mSmeltExpLb == nil then
        self.mSmeltExpLb = self:GetCurComp("WidgetRoot/view/lv_bg/roleexpvalue", "UILabel")
    end
    return self.mSmeltExpLb
end

---@return Top_FillTween 血继经验显示
function UIForgeBloodSmeltPanel:GetSmeltExpShow_FillTween()
    if self.mSmeltFillTween == nil then
        self.mSmeltFillTween = self:GetCurComp("WidgetRoot/view/lv_bg/roleexp", "Top_FillTween")
    end
    return self.mSmeltFillTween
end

---@return UILabel 血继等级显示
function UIForgeBloodSmeltPanel:GetSmeltLevelShow_UILabel()
    if self.mSmeltLevelLb == nil then
        self.mSmeltLevelLb = self:GetCurComp("WidgetRoot/view/lv_bg/lv", "UILabel")
    end
    return self.mSmeltLevelLb
end

---@return UnityEngine.GameObject 血继材料Go
function UIForgeBloodSmeltPanel:GetSmeltMaterial_GO()
    if self.mSmeltMatGo == nil then
        self.mSmeltMatGo = self:GetCurComp("WidgetRoot/view/Cost", "GameObject")
    end
    return self.mSmeltMatGo
end

---@return UILoopScrollViewPlus 血继材料
function UIForgeBloodSmeltPanel:GetSmeltMaterial_LoopScrollViewPlus()
    if self.mMatLoop == nil then
        self.mMatLoop = self:GetCurComp("WidgetRoot/view/Cost/ScrollView/Grid", "UILoopScrollViewPlus")
    end
    return self.mMatLoop
end

---@return UnityEngine.GameObject 材料不足
function UIForgeBloodSmeltPanel:GetMaterialNotEnough_Go()
    if self.mMatNotEnoughGo == nil then
        self.mMatNotEnoughGo = self:GetCurComp("WidgetRoot/view/NoMaterialsText", "GameObject")
    end
    return self.mMatNotEnoughGo
end

---@return UIGridContainer 属性
function UIForgeBloodSmeltPanel:GetAttribute_UIGridContainer()
    if self.mAttributeLoop == nil then
        self.mAttributeLoop = self:GetCurComp("WidgetRoot/view/Attribute/ScrollView/Grid", "UIGridContainer")
    end
    return self.mAttributeLoop
end

---@return UnityEngine.GameObject 属性
function UIForgeBloodSmeltPanel:GetAttributeRoot_Go()
    if self.mAttributeRoot == nil then
        self.mAttributeRoot = self:GetCurComp("WidgetRoot/view/Attribute", "GameObject")
    end
    return self.mAttributeRoot
end

---@return UnityEngine.GameObject 满级
function UIForgeBloodSmeltPanel:GetLevelMax_GO()
    if self.mLevelMaxGo == nil then
        self.mLevelMaxGo = self:GetCurComp("WidgetRoot/view/LevelMax", "GameObject")
    end
    return self.mLevelMaxGo
end

---@return UnityEngine.GameObject 没有选择道具
function UIForgeBloodSmeltPanel:GetNotChoose_GO()
    if self.mNotChooseGo == nil then
        self.mNotChooseGo = self:GetCurComp("WidgetRoot/view/ChooseItemText", "GameObject")
    end
    return self.mNotChooseGo
end

---@return UISprite 等级条
function UIForgeBloodSmeltPanel:GetLevelBar_UISprite()
    if self.mLevelBar == nil then
        self.mLevelBar = self:GetCurComp("WidgetRoot/view/lv_bg/roleexp", "UISprite")
    end
    return self.mLevelBar
end

---@return UISprite 血炼等级条
function UIForgeBloodSmeltPanel:GetSmeltLevelBar_UISprite()
    if self.mSmeltLevelBar == nil then
        self.mSmeltLevelBar = self:GetCurComp("WidgetRoot/view/lv_bg/roleexpTemp", "UISprite")
    end
    return self.mSmeltLevelBar
end

---@return UILabel 血炼增加经验
function UIForgeBloodSmeltPanel:GetSmeltAddExp_UILabel()
    if self.mSmeltAddExpLb == nil then
        self.mSmeltAddExpLb = self:GetCurComp("WidgetRoot/view/lv_bg/expaddvalue", "UILabel")
    end
    return self.mSmeltAddExpLb
end

---@return UnityEngine.GameObject 成功特效节点
function UIForgeBloodSmeltPanel:GetSuccessEffect_Go()
    if self.mEffectGo == nil then
        self.mEffectGo = self:GetCurComp("WidgetRoot/view/itemTemplate/effect", "GameObject")
    end
    return self.mEffectGo
end

--region  箭头
---@return UIScrollView
function UIForgeBloodSmeltPanel:GetAttributeScrollView()
    if self.mAttributeUIScrollView == nil then
        self.mAttributeUIScrollView = self:GetCurComp("WidgetRoot/view/Attribute/ScrollView", "UIScrollView")
    end
    return self.mAttributeUIScrollView
end

---@return TweenAlpha
function UIForgeBloodSmeltPanel:GetAttributeLeftArrow_TweenAlpha()
    if self.mAttributeLeftTweenAlpha == nil then
        self.mAttributeLeftTweenAlpha = self:GetCurComp("WidgetRoot/view/Attribute/arrowPanel/LeftArrow", "TweenAlpha")
    end
    return self.mAttributeLeftTweenAlpha
end

---@return TweenAlpha
function UIForgeBloodSmeltPanel:GetAttributeRightArrow_TweenAlpha()
    if self.mAttributeRightTweenAlpha == nil then
        self.mAttributeRightTweenAlpha = self:GetCurComp("WidgetRoot/view/Attribute/arrowPanel/RightArrow", "TweenAlpha")
    end
    return self.mAttributeRightTweenAlpha
end

---@return UIScrollView
function UIForgeBloodSmeltPanel:GetMaterialScrollView()
    if self.mMaterialUIScrollView == nil then
        self.mMaterialUIScrollView = self:GetCurComp("WidgetRoot/view/Cost/ScrollView", "UIScrollView")
    end
    return self.mMaterialUIScrollView
end

---@return TweenAlpha
function UIForgeBloodSmeltPanel:GetMaterialLeftArrow_TweenAlpha()
    if self.mMaterialLeftTweenAlpha == nil then
        self.mMaterialLeftTweenAlpha = self:GetCurComp("WidgetRoot/view/Cost/arrowPanel/LeftArrow", "TweenAlpha")
    end
    return self.mMaterialLeftTweenAlpha
end

---@return TweenAlpha
function UIForgeBloodSmeltPanel:GetMaterialRightArrow_TweenAlpha()
    if self.mMaterialRightTweenAlpha == nil then
        self.mMaterialRightTweenAlpha = self:GetCurComp("WidgetRoot/view/Cost/arrowPanel/RightArrow", "TweenAlpha")
    end
    return self.mMaterialRightTweenAlpha
end

--endregion

--endregion

--region 初始化
function UIForgeBloodSmeltPanel:Init()
    self:BindEvents()
    self:BindMessage()
end

---@class BloodSuitSmeltPanelData
---@field type LuaEnumBloodSuitSmeltType 打开界面类型
---@field chooseBagItemInfo bagV2.BagItemInfo 需要选中的道具

---@param BloodSuitPanelData BloodSuitSmeltPanelData
function UIForgeBloodSmeltPanel:Show(BloodSuitPanelData)
    self.mChooseItemInfo = nil
    local customData = BloodSuitPanelData

    local normalChooseBloodToggleType = LuaEnumBloodSuitSmeltType.BloodSuit
    if customData.type then
        normalChooseBloodToggleType = customData.type
    end

    if customData.chooseBagItemInfo then
        self.mChooseItemInfo = customData.chooseBagItemInfo
    end
    self:ChoosePanel(normalChooseBloodToggleType)

    self:BloodSuitSmeltChooseItem(self.mChooseItemInfo)

end

function UIForgeBloodSmeltPanel:BindEvents()
    self:GetAttributeScrollView().onDragFinished = function()
        self:RefreshAttributeArrow()
    end

    self:GetMaterialScrollView().onDragFinished = function()
        self:RefreshMaterialArrow()
    end

    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetHelpBtn_Go()).onClick = function()
        local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(180)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
        end
    end

    CS.UIEventListener.Get(self:GetSmeltBtn_Go()).onClick = function(go)
        self:OnSmeltClicked(go)
    end

    CS.UIEventListener.Get(self:GetBagBtn_Go()).onClick = function(go)
        self:ChoosePanel(LuaEnumBloodSuitSmeltType.Bag)
    end

    CS.UIEventListener.Get(self:GetBloodSuitBtn_Go()).onClick = function(go)
        self:ChoosePanel(LuaEnumBloodSuitSmeltType.BloodSuit)
    end
end

function UIForgeBloodSmeltPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GridSingleClicked, function(magID, bagItemInfo)
        self:OnSingleBagItemClicked(bagItemInfo)
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBloodSmeltMessage, function()
        self:GetSuccessEffect_Go():SetActive(false)
        self:GetSuccessEffect_Go():SetActive(true)
        self:TryPlayExpTween()
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, function()
        self:ChoosePanel(LuaEnumBloodSuitSmeltType.Bag)
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:TryPlayExpTween()
        self:RefreshSmeltMaterial(false)
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BloodSuitPanelItemClicked, function(magID, bagItemInfo)
        self:OnSingleBloodSuitItemClicked(bagItemInfo)
    end)
end

---@return bagV2.BagItemInfo 获取血继第一个装备
function UIForgeBloodSmeltPanel:GetBloodSuitFirstEquip(index)

end
--endregion

--region 当前选中道具数据
---@return number 当前选中道具血继等级
function UIForgeBloodSmeltPanel:GetCurrentBloodSuitLevel()
    if self.mChooseItemInfo then
        return self.mChooseItemInfo.bloodLevel
    end
    return 0
end

---@return boolean 获取当前血继等级是否满级 true满级/false未满级
function UIForgeBloodSmeltPanel:GetCurrentBloodSuitLevelFull()
    local level = self:GetCurrentBloodSuitLevel()
    local data = self:CacheBloodSuitLevelInfo(level + 1)
    return data == nil
end
--endregion

--region  界面管理
---@param type LuaEnumBloodSuitSmeltType
function UIForgeBloodSmeltPanel:ChoosePanel(type)
    self.mCurrentPanelType = type
    if type == LuaEnumBloodSuitSmeltType.BloodSuit then
        self:OnBloodSuitClicked(self:GetBloodSuitBtn_Go())
    elseif type == LuaEnumBloodSuitSmeltType.Bag then
        self:OnBagClicked(self:GetBagBtn_Go())
    end
end

---设置页签选中
---@param type LuaEnumBloodSuitSmeltType 选中类型
function UIForgeBloodSmeltPanel:SetToggleState(type)
    local isBag = type == LuaEnumBloodSuitSmeltType.Bag
    local isBloodSuit = type == LuaEnumBloodSuitSmeltType.BloodSuit
    self:GetBloodSuitBtn_UISprite().spriteName = isBloodSuit and "c2" or "u2"
    self:GetBagBtn_UISprite().spriteName = isBag and "c1" or "u1"
    self:GetBagBtnChoose_Go():SetActive(isBag)
    self:GetBloodSuitBtnChoose_Go():SetActive(isBloodSuit)
end

---设置界面显示状态
function UIForgeBloodSmeltPanel:SetPanelChooseState(type)
    if self.mBagPanel and type ~= LuaEnumBloodSuitSmeltType.Bag then
        uimanager:HidePanel(self.mBagPanel)
    end

    if self.mBloodSuitPanel and type ~= LuaEnumBloodSuitSmeltType.BloodSuit then
        uimanager:HidePanel(self.mBloodSuitPanel)
    end
end

---添加打开界面
function UIForgeBloodSmeltPanel:TryAddOpenPanel(panelName)
    if self.mAllOpenPanel == nil then
        self.mAllOpenPanel = {}
    end
    table.insert(self.mAllOpenPanel, panelName)
end
--endregion

--region 血继界面
function UIForgeBloodSmeltPanel:OnBloodSuitClicked(go)
    local type = LuaEnumBloodSuitSmeltType.BloodSuit
    self:SetToggleState(type)
    self:SetPanelChooseState(type)
    self:ChooseBloodSuitPanel()
end

---选中血继界面
function UIForgeBloodSmeltPanel:ChooseBloodSuitPanel()
    if self.mBloodSuitPanel == nil or IsNullFunc(self.mBloodSuitPanel.go) then
        local panelName = "UIRoleBloodSuitPanel"
        ---@type RoleBloodPanelData
        local data = {}
        data.ItemTemplateBody = luaComponentTemplates.UIRoleBloodSuit_SmeltBodyItemTemplate
        data.ItemTemplateEgg = luaComponentTemplates.UIRoleBloodSuit_SmeltItemTemplate
        data.IsOpenBag = false
        data.isRecordSelectIndex = true
        data.SuitRedDic = self.defaultSuitRedPointDic
        data.pos = LuaEquipBloodSuitItemType.None
        uimanager:CreatePanel(panelName, function(panel)
            self.mBloodSuitPanel = panel
            self:TryAddOpenPanel(panelName)
            self:AfterCreateBloodSuitPanel()
        end, data)
    else
        uimanager:ReShowPanel(self.mBloodSuitPanel)
        self:AfterCreateBloodSuitPanel()
    end
end

---创建血继完成回调
function UIForgeBloodSmeltPanel:AfterCreateBloodSuitPanel()
    if self.mChooseItemInfo == nil then
        self.mChooseItemInfo = self:GetAutoChooseBloodSuitItemInfo()
        if self.mChooseItemInfo then
            self:OnSingleBloodSuitItemClicked(self.mChooseItemInfo)
            local index = self.mChooseItemInfo.index
            if index > 0 and self.mBloodSuitPanel then
                local type, pos = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():GetEquipTypeAndPos(index)
                self.mBloodSuitPanel:RefreshUI(type, pos)
            end
        end
    end
end

---@return bagV2.BagItemInfo 获取自动选中血继道具
function UIForgeBloodSmeltPanel:GetAutoChooseBloodSuitItemInfo()
    for i = 1, #self.mChooseMenuType do
        local type = self.mChooseMenuType[i]
        for i = 1, #self.mChooseIndexType do
            local pos = self.mChooseIndexType[i]
            ---@type LuaEquipDataBloodSuitItem
            local singleEquipData = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():GetBloodSuitItem(type, pos)
            if singleEquipData then
                local bagItemInfo = singleEquipData.BagItemInfo
                if bagItemInfo then
                    return bagItemInfo
                end
            end
        end
    end
end

---血继格子点击事件
function UIForgeBloodSmeltPanel:OnSingleBloodSuitItemClicked(bagItemInfo)
    self:BloodSuitSmeltChooseItem(bagItemInfo)
end
--endregion

--region 背包界面
---点击背包
function UIForgeBloodSmeltPanel:OnBagClicked(go)
    local type = LuaEnumBloodSuitSmeltType.Bag
    self:SetToggleState(type)
    self:SetPanelChooseState(type)
    self:ChooseBagPanel()
end

---选中背包界面
function UIForgeBloodSmeltPanel:ChooseBagPanel()
    if self.mBagPanel == nil or IsNullFunc(self.mBagPanel.go) then
        local panelName = "UIBagPanel"
        local data = {}
        data.type = LuaEnumBagType.BloodSuitSmelt
        data.focusedBagItemInfo = self:GetBagNeedChooseItem()
        uimanager:CreatePanel(panelName, function(panel)
            self.mBagPanel = panel
            self:TryAddOpenPanel(panelName)
            self:AfterCreateBagPanel()
        end, data)
    else
        uimanager:ReShowPanel(self.mBagPanel)
        self:AfterCreateBagPanel()
    end
end

---@return bagV2.BagItemInfo 获取需要选中的背包道具
function UIForgeBloodSmeltPanel:GetBagNeedChooseItem()
    if self.mChooseItemInfo and self.mChooseItemInfo.index == 0 then
        return self.mChooseItemInfo
    end
end

---创建背包完成回调
function UIForgeBloodSmeltPanel:AfterCreateBagPanel()
    if self.mChooseItemInfo == nil then
        self.mChooseItemInfo = self:GetAutoChooseBagItemInfo()
        self:OnSingleBloodSuitItemClicked(self.mChooseItemInfo)
    end
end

---@return bagV2.BagItemInfo 获取自动选中背包道具
function UIForgeBloodSmeltPanel:GetAutoChooseBagItemInfo()
    local bagItemList = {}
    local originBagItemList = self:GetBagInfoV2():GetBagItemList()
    for i = 0, originBagItemList.Count - 1 do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = originBagItemList[i]
        table.insert(bagItemList, bagItemInfo)
    end
    table.sort(bagItemList, function(left, right)
        return self:BagItemListSortFunction(left, right)
    end)
    for j = 1, #bagItemList do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = bagItemList[j]
        if self:GetBagItemInfoCanSmelt(bagItemInfo.itemId) then
            return bagItemInfo
        end
    end
end

---对背包道具排序
function UIForgeBloodSmeltPanel:BagItemListSortFunction(leftItem, rightItem)
    if self:GetBagItemInfoCanSmelt(leftItem.itemId) and not self:GetBagItemInfoCanSmelt(rightItem.itemId) then
        return true
    end
    return false
end

---@return boolean 道具是否可血炼
---@param itemId number 道具id
function UIForgeBloodSmeltPanel:GetBagItemInfoCanSmelt(itemId)
    if itemId == nil then
        return false
    end

    if self.mItemIdToCanSmelt == nil then
        self.mItemIdToCanSmelt = {}
    end
    local canSmelt = self.mItemIdToCanSmelt[itemId]
    if canSmelt == nil then
        local data = self:CacheBloodSuitInfo(itemId)
        canSmelt = data ~= nil
        self.mItemIdToCanSmelt[itemId] = canSmelt
    end
    return canSmelt
end

---背包格子点击事件
function UIForgeBloodSmeltPanel:OnSingleBagItemClicked(bagItemInfo)
    self:BloodSuitSmeltChooseItem(bagItemInfo)
end
--endregion

--region 血炼界面
---血继熔炼界面选中道具
---@param bagItemInfo bagV2.BagItemInfo 选中道具
function UIForgeBloodSmeltPanel:BloodSuitSmeltChooseItem(bagItemInfo)
    self.mChooseItemInfo = bagItemInfo
    luaEventManager.DoCallback(LuaCEvent.BloodSuitSmeltChooseItemChange, bagItemInfo)
    self:SetCurrentPlayingTween(false)
    self:RefreshBloodSuitSmeltPanel()
    self:RefreshSmeltLevel(bagItemInfo, true)
    self:RefreshSmeltMaterial(true)
    if bagItemInfo and bagItemInfo.index == 0 and self.mBloodSuitPanel and IsNullFunc(self.mBloodSuitPanel.go) == false then
        self.mBloodSuitPanel:RefreshSelectIndex(LuaEquipBloodSuitItemType.None)
    end
end

---刷新血继熔炼面板
---@param bagItemInfo bagV2.BagItemInfo 选中道具
function UIForgeBloodSmeltPanel:RefreshBloodSuitSmeltPanel()
    local bagItemInfo = self.mChooseItemInfo
    self:RefreshChooseItemShow(bagItemInfo)
    if bagItemInfo == nil then
        return
    end

    local data = self:CacheItemInfo(bagItemInfo.itemId)
    if data == nil then
        return
    end

    self:GetTitle_UILabel().text = data:GetName() .. luaEnumColorType.Red .. "(血继等级 Lv." .. self:GetCurrentBloodSuitLevel() .. ")"
    self:RefreshSmeltAttribute()
end

---刷新选中道具
---@param bagItemInfo bagV2.BagItemInfo 选中道具
function UIForgeBloodSmeltPanel:RefreshChooseItemShow(bagItemInfo)
    if bagItemInfo == nil then
        self:SetBloodSuitSmeltItemShow(false)
        return
    end

    local data = self:CacheItemInfo(bagItemInfo.itemId)
    if data == nil then
        self:SetBloodSuitSmeltItemShow(false)
        return
    end
    self:GetSmeltItemIcon_UISprite().spriteName = data:GetIcon()
    self:SetBloodSuitSmeltItemShow(true)
end

---设置一些根据条件显示的
function UIForgeBloodSmeltPanel:SetSpecialInfoShow(levelMax)
    self:GetSmeltLevel_GO():SetActive(not levelMax)
    self:GetSmeltMaterial_GO():SetActive(not levelMax)
    self:GetLevelMax_GO():SetActive(levelMax)
    self:GetSmeltBtn_Go():SetActive(not levelMax)
end

---设置界面显示状态
function UIForgeBloodSmeltPanel:SetBloodSuitSmeltItemShow(isShow)
    self:GetSmeltAddSign_GO():SetActive(not isShow)
    self:GetSmeltItemIcon_UISprite().gameObject:SetActive(isShow)
    self:GetSmeltLevel_GO():SetActive(isShow)
    self:GetTitle_GO():SetActive(isShow)
    self:GetAttributeRoot_Go():SetActive(isShow)
    self:GetNotChoose_GO():SetActive(not isShow)
    self:GetSmeltMaterial_GO():SetActive(isShow)
    self:GetSmeltBtn_Go():SetActive(isShow)
end
--endregion

--region 熔炼属性
---刷新当前选中道具熔炼属性
function UIForgeBloodSmeltPanel:RefreshSmeltAttribute()
    local attributeList = self:GetShowAttribute()
    self:GetAttribute_UIGridContainer().MaxCount = #attributeList
    for i = 0, self:GetAttribute_UIGridContainer().controlList.Count - 1 do
        local go = self:GetAttribute_UIGridContainer().controlList[i]
        self:RefreshSingleAttribute(go, attributeList[i + 1])
    end
    self:RefreshAttributeArrow()
    self:RefreShAttributePosition(#attributeList)
end

---设置属性栏位置
function UIForgeBloodSmeltPanel:RefreShAttributePosition(number)
    self:GetAttributeScrollView():ResetPosition()
    if self:GetAttributeRoot_Go() == nil then
        return
    end
    if number <= 1 then
        self:GetAttributeRoot_Go().gameObject.transform.localPosition = CS.UnityEngine.Vector3(0, -40, 0)
    else
        self:GetAttributeRoot_Go().gameObject.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    end
end

---@param go UnityEngine.GameObject
---@param attributeData BloodSuitSmeltAttributeData
function UIForgeBloodSmeltPanel:RefreshSingleAttribute(go, attributeData)
    if attributeData == nil or IsNullFunc(go) then
        return
    end
    local name = CS.Utility_Lua.Get(go.transform, "cur/value", "UILabel")
    local currAtr = CS.Utility_Lua.Get(go.transform, "curarribute/value", "UILabel")
    local nextAtr = CS.Utility_Lua.Get(go.transform, "nextarribute/value", "UILabel")
    if IsNullFunc(name) == false then
        name.text = attributeData.attribute
    end
    if IsNullFunc(currAtr) == false then
        currAtr.text = attributeData.currAttr
    end
    if IsNullFunc(nextAtr) == false then
        nextAtr.text = attributeData.nextAttr
    end
end

---@class BloodSuitSmeltAttributeData
---@field attribute string 名字
---@field currAttr string 当前属性
---@field nextAttr string 下一级属性

---@return table<number,BloodSuitSmeltAttributeData> 获取属性数据
function UIForgeBloodSmeltPanel:GetShowAttribute()
    local data = {}
    if self.mChooseItemInfo and uiStaticParameter.mBloodSuitUseData then
        for i = 1, #uiStaticParameter.mBloodSuitUseData do
            local type = uiStaticParameter.mBloodSuitUseData[i]
            self:TryAddAttribute(data, type)
        end
    end
    return data
end

---添加属性显示
function UIForgeBloodSmeltPanel:TryAddAttribute(data, attributeType)
    local level = self:GetCurrentBloodSuitLevel()
    local itemId = self.mChooseItemInfo.itemId
    local attributeName, min, max = Utility.GetBloodSuitEquipAttribute(itemId, level, attributeType)
    local nextAttributeName, nextMin, nextMax = Utility.GetBloodSuitEquipAttribute(itemId, level + 1, attributeType)

    local needAddAttribute = true

    ---@type BloodSuitSmeltAttributeData
    local info = {}
    info.attribute = attributeName

    local leftShow = ""
    local hasLeft = min ~= nil
    local hasRight = max ~= nil
    if hasLeft and hasRight then
        leftShow = min .. "-" .. max
    elseif hasLeft and not hasRight then
        leftShow = min
    elseif not hasLeft and hasRight then
        leftShow = max
    else
        leftShow = "已满级"
    end

    local rightShow = ""
    local hasNextMin = nextMin ~= nil
    local hasNextMax = nextMax ~= nil

    if hasNextMin and hasNextMax then
        if nextMin == 0 and nextMax == 0 then
            needAddAttribute = false
        end
        rightShow = nextMin .. "-" .. nextMax
    elseif hasNextMin and not hasNextMax then
        if nextMin == 0 then
            needAddAttribute = false
        end
        rightShow = nextMin
    elseif not hasNextMin and hasNextMax then
        if nextMax == 0 then
            needAddAttribute = false
        end
        rightShow = nextMax
    else
        rightShow = "已满级"
    end

    if self:GetCurrentBloodSuitLevelFull() then
        rightShow = "已满级"
    end

    info.currAttr = leftShow
    info.nextAttr = luaEnumColorType.Green .. rightShow
    if needAddAttribute then
        table.insert(data, info)
    end
end
--endregion

--region 熔炼等级
---刷新当前血炼经验等级
function UIForgeBloodSmeltPanel:RefreshSmeltLevel(bagItemInfo, needRefeshLevelRate)
    if bagItemInfo == nil then
        return
    end
    local level = self:GetCurrentBloodSuitLevel()
    self:GetSmeltLevelShow_UILabel().text = luaEnumColorType.Gray .. "血继等级 " .. level
    local rate = 0
    local expData = self:CacheBloodSuitLevelInfo(level + 1)
    if expData then
        local cur = bagItemInfo.exp
        local cost = expData:GetCost()
        self:GetSmeltExpShow_UILabel().text = cur .. "/" .. luaEnumColorType.Gray .. cost
        if cur and cost and cost ~= 0 and self:GetCurrentTweenState() == false then
            rate = cur / cost
            if needRefeshLevelRate then
                self:GetLevelBar_UISprite().fillAmount = rate
            end
        end
    end
    self:SetSpecialInfoShow(self:GetCurrentBloodSuitLevelFull())
end

---刷新选中道具后血炼经验等级
function UIForgeBloodSmeltPanel:RefreshChooseLevel(needClearData)
    if self.mChooseItemInfo == nil then
        return
    end
    local chooseEXP = self:GetCurrentChooseMaterialExp()
    local currentExp = self.mChooseItemInfo.exp
    local totalExp = chooseEXP + currentExp

    local level = self:GetCurrentBloodSuitLevel()
    local arriveLevel, rate = self:GetCurrentChooseExpCanArriveLevel(totalExp, level)
    local addLevel = arriveLevel - level
    local addLevelShow = ""
    if addLevel > 0 then
        addLevelShow = luaEnumColorType.Green .. "+" .. addLevel
    end
    self:GetSmeltLevelShow_UILabel().text = luaEnumColorType.Gray .. "血继等级 " .. level .. addLevelShow
    if chooseEXP > 0 then
        self:GetSmeltAddExp_UILabel().text = "+" .. chooseEXP
    else
        self:GetSmeltAddExp_UILabel().text = ""
    end
    if not needClearData then
        self.mCurrentExpRate = rate
    end
    if self:GetCurrentTweenState() == false then
        self:GetSmeltLevelBar_UISprite().fillAmount = rate
    end
end

---@return number 获取当前选中道具熔炼经验
function UIForgeBloodSmeltPanel:GetCurrentChooseMaterialExp()
    local exp = 0
    if self.mCurrentShowSmeltList then
        for i = 1, #self.mCurrentShowSmeltList do
            local bagItemInfo = self.mCurrentShowSmeltList[i]
            if bagItemInfo and self:GetSmeltItemChooseState(bagItemInfo.lid) then
                local levelAddExp = 0
                local level = bagItemInfo.bloodLevel
                local levelExpData = self:CacheBloodSuitLevelInfo(level)
                if levelExpData then
                    levelAddExp = levelExpData:GetSmeltExp()
                end

                local suitAddExp = 0
                local suitData = self:CacheBloodSuitInfo(bagItemInfo.itemId)
                if suitData then
                    suitAddExp = suitData:GetSmeltExp()
                end

                local curExp = bagItemInfo.exp
                exp = exp + levelAddExp + suitAddExp + curExp
            end
        end
    end
    return exp
end

---添加自动选中道具
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeBloodSmeltPanel:TryAddChooseBagItemInfo(bagItemInfo)
    if self.mChooseItemInfo == nil then
        return
    end
    local state = self:GetSmeltItemChooseState(bagItemInfo.lid)
    if state ~= nil then
        return
    end
    if bagItemInfo.bloodLevel == 0 then
        local currentChooseExp = self:GetCurrentChooseMaterialExp()
        local totalExp = currentChooseExp + self.mChooseItemInfo.exp
        local currentLevel = self:GetCurrentBloodSuitLevel()
        local arriveLevel, rate = self:GetCurrentChooseExpCanArriveLevel(totalExp, currentLevel)
        local nextLevelData = self:CacheBloodSuitLevelInfo(arriveLevel + 1)
        if nextLevelData then
            self:SetSmeltItemChooseState(bagItemInfo.lid, true)
            return
        end
    end
    self:SetSmeltItemChooseState(bagItemInfo.lid, false)
end

---@return number,number 获取当前经验可以到达的等级,达到该等级后剩余的经验/升级后剩余经验的比例
function UIForgeBloodSmeltPanel:GetCurrentChooseExpCanArriveLevel(exp, currentLevel)
    local startLevel = currentLevel
    local hasExp = exp
    local hasData = true
    local progress = 0
    local timeCount = 0
    while hasData do
        local expData = self:CacheBloodSuitLevelInfo(startLevel + 1)
        if expData then
            local curExp = expData:GetCost()
            if hasExp > curExp then
                startLevel = startLevel + 1
                hasExp = hasExp - curExp
            elseif hasExp == curExp then
                startLevel = startLevel + 1
                progress = 1
                break
            else
                progress = hasExp / curExp
                break
            end
        else
            progress = 1
            hasData = false
        end
        timeCount = timeCount + 1
        if timeCount >= 500 then
            break
        end
    end
    return startLevel, progress
end

---刷新血继经验动画显示
---@param lastBagItemInfo bagV2.BagItemInfo 上一次道具
---@param nextBagItemInfo bagV2.BagItemInfo 当前道具
function UIForgeBloodSmeltPanel:RefreshBloodSuitSmeltLevelTween(lastBagItemInfo, nextBagItemInfo)
    local lastRate = self:GetBagItemInfoExpRate(lastBagItemInfo)
    local nextRate = self:GetBagItemInfoExpRate(nextBagItemInfo)
    local levelDis = nextBagItemInfo.bloodLevel - lastBagItemInfo.bloodLevel

    if lastRate and nextRate and levelDis and nextBagItemInfo then
        self:PlayExpTween(lastRate, nextRate, levelDis, 0, nextBagItemInfo)
    end
end

---开始播放动画
function UIForgeBloodSmeltPanel:TryPlayExpTween()
    ---@type bagV2.BagItemInfo
    local lastBagItemInfo = self.mChooseItemInfo
    if lastBagItemInfo == nil then
        return
    end
    ---@type bagV2.BagItemInfo
    local currentBagItemInfo
    if lastBagItemInfo.index ~= 0 then
        ___, currentBagItemInfo = self:GetEquipInfoV2().Equips:TryGetValue(lastBagItemInfo.index)
    else
        ___, currentBagItemInfo = self:GetBagInfoV2().BagItems:TryGetValue(self.mChooseItemInfo.lid)
    end

    ---表示获取到了不同的道具，因为服务器修改道具的时间各种不同
    local notSameItem = currentBagItemInfo.bloodLevel ~= lastBagItemInfo.bloodLevel or currentBagItemInfo.exp ~= lastBagItemInfo.exp
    if notSameItem then
        self.mChooseItemInfo = currentBagItemInfo

        if currentBagItemInfo ~= nil and lastBagItemInfo and notSameItem then
            self:RefreshBloodSuitSmeltLevelTween(lastBagItemInfo, currentBagItemInfo)
            self:RefreshBloodSuitSmeltPanel()
            self:RefreshSmeltLevel(currentBagItemInfo, false)
        end
    end
end

---播放经验条动画
function UIForgeBloodSmeltPanel:PlayExpTween(lastRate, nextRate, levelDis, time, nextBagItemInfo)
    local from = time == 0 and lastRate or 0
    local to = time == levelDis and nextRate or 1
    CS.CSValueTween.Begin(self:GetLevelBar_UISprite().gameObject, 1, from, to, function(item, value)
        if nextBagItemInfo == nil then
            return
        end

        if nextBagItemInfo.lid == self.mChooseItemInfo.lid then
            self:SetCurrentPlayingTween(true)
            self:GetLevelBar_UISprite().fillAmount = value
            self:GetSmeltLevelBar_UISprite().fillAmount = nextRate
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
function UIForgeBloodSmeltPanel:SetCurrentPlayingTween(state)
    self.mTweenPlaying = state
end

---@return boolean 获得当前动画播放状态
function UIForgeBloodSmeltPanel:GetCurrentTweenState()
    if self.mTweenPlaying ~= nil then
        return self.mTweenPlaying
    end
    return false
end

---@return number 获取道具经验比例
---@param bagItemInfo bagV2.BagItemInfo 道具
function UIForgeBloodSmeltPanel:GetBagItemInfoExpRate(bagItemInfo)
    local expData = self:CacheBloodSuitLevelInfo(bagItemInfo.bloodLevel + 1)
    if expData then
        local cur = bagItemInfo.exp
        local cost = expData:GetCost()
        self:GetSmeltExpShow_UILabel().text = cur .. "/" .. luaEnumColorType.Gray .. cost
        if cur and cost and cost ~= 0 then
            return cur / cost
        end
    end
    return 0
end
--endregion

--region 熔炼材料
---刷新熔炼材料
---@param needClearData  number 是否需要清空选中数据
function UIForgeBloodSmeltPanel:RefreshSmeltMaterial(needClearData)
    local bagItemInfo = self.mChooseItemInfo
    if needClearData then
        self.mItemLidToChoose = nil
    end
    ---@type table<number,BloodSuitSmeltItemTemplate>
    self.mCurrentPageLidToTemplate = {}
    local showList = self:GetBagCanSmeltItem(bagItemInfo, needClearData)
    self.mCurrentShowSmeltList = showList
    self:AutoChooseMaterial()
    local hasData = #showList > 0
    self:GetSmeltMaterial_LoopScrollViewPlus().gameObject:SetActive(hasData)

    self:GetMaterialNotEnough_Go():SetActive(not hasData and not self:GetCurrentBloodSuitLevelFull() and bagItemInfo)
    self:GetSmeltMaterial_LoopScrollViewPlus():Init(function(go, line)
        if line < #showList then
            if IsNullFunc(go) then
                return false
            end
            local data = showList[line + 1]
            local template = self:GetSmeltItemTemplate(go)
            if template then
                template:RefreshItem(data)
                self.mCurrentPageLidToTemplate[data.lid] = template
                return true
            else
                return false
            end
        else
            return false
        end
    end, nil)
    self:RefreshChooseLevel(needClearData)
    self:RefreshMaterialArrow()
end

---@return BloodSuitSmeltItemTemplate
function UIForgeBloodSmeltPanel:GetSmeltItemTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.BloodSuitSmeltItemTemplate, self)
        self.mGoToTemplate[go] = template
    end
    return template
end

---@return table<number,bagV2.BagItemInfo> 获取背包可熔炼道具
---@param needClearData boolean 表示数据清楚了重新设置默认选中
function UIForgeBloodSmeltPanel:GetBagCanSmeltItem(bagItemInfo, needClearData)
    if bagItemInfo == nil then
        return {}
    end

    local canSmeltData = {}
    local smeltData = self:CacheBloodSuitInfo(bagItemInfo.itemId)
    if bagItemInfo and self:GetBagInfoV2() and smeltData then
        local bagEquip = self:GetBagInfoV2():GetBagItemList()
        for i = 0, bagEquip.Count - 1 do
            ---@type bagV2.BagItemInfo
            local data = bagEquip[i]
            local smeltItemList = smeltData:GetSmeltItem()
            if data.lid ~= self.mChooseItemInfo.lid and smeltItemList then
                local listInfo = smeltItemList.list
                if listInfo then
                    for i = 1, #listInfo do
                        if data.itemId == listInfo[i] then
                            table.insert(canSmeltData, data)
                            break
                        end
                    end
                end
            end
        end
        table.sort(canSmeltData, function(left, right)
            return self:SortSmeltMaterial(left, right)
        end)
    end
    return canSmeltData
end

---自动选择材料
function UIForgeBloodSmeltPanel:AutoChooseMaterial()
    local canSmeltData = self.mCurrentShowSmeltList
    if canSmeltData == nil then
        return
    end
    for i = 1, #canSmeltData do
        self:TryAddChooseBagItemInfo(canSmeltData[i])
    end
end

---@param left bagV2.BagItemInfo
---@param right bagV2.BagItemInfo
function UIForgeBloodSmeltPanel:SortSmeltMaterial(left, right)
    if left == nil or right == nil or left.lid == right.lid then
        return false
    end
    if left.bloodLevel == right.bloodLevel then
        if left.itemId == right.itemId then
            return false
        else
            local leftData = self:CacheBloodSuitInfo(left.itemId)
            local rightData = self:CacheBloodSuitInfo(right.itemId)
            if leftData == nil or rightData == nil then
                return false
            else
                return leftData:GetQualityLevel() < rightData:GetQualityLevel()
            end
        end
    else
        return left.bloodLevel < right.bloodLevel
    end
end

---@param bagItemInfo bagV2.BagItemInfo
function UIForgeBloodSmeltPanel:OnSmeltItemClicked(go, bagItemInfo)
    local template = self:GetSmeltItemTemplate(go)
    if template then
        local state = self:GetSmeltItemChooseState(bagItemInfo.lid)
        if state == false and self:CanAddMaterial() == false then
            Utility.ShowPopoTips(go, nil, 432)
            return
        end
        local changeState = not state
        template:SetItemChoose(changeState, true)
        self:SetSmeltItemChooseState(bagItemInfo.lid, changeState)
        self:RefreshChooseLevel(true)
    end
end

---@return boolean 是否可以继续添加熔炼材料
function UIForgeBloodSmeltPanel:CanAddMaterial()
    local chooseEXP = self:GetCurrentChooseMaterialExp()
    local currentExp = self.mChooseItemInfo.exp
    local totalExp = chooseEXP + currentExp
    local level = self:GetCurrentBloodSuitLevel()
    local arriveLevel, rate = self:GetCurrentChooseExpCanArriveLevel(totalExp, level)
    local nextLevelData = self:CacheBloodSuitLevelInfo(arriveLevel + 1)
    return nextLevelData ~= nil
end

---@return boolean 获取道具选中状态
function UIForgeBloodSmeltPanel:GetSmeltItemChooseState(lid)
    if self.mItemLidToChoose == nil then
        self.mItemLidToChoose = {}
    end
    local isChoose = self.mItemLidToChoose[lid]
    return isChoose
end

---设置道具选中状态
function UIForgeBloodSmeltPanel:SetSmeltItemChooseState(lid, isChoose)
    if self.mItemLidToChoose == nil then
        self.mItemLidToChoose = {}
    end

    self.mItemLidToChoose[lid] = isChoose
end

function UIForgeBloodSmeltPanel:GetCurrentChooseExp()
    for k, v in pairs(self.mItemLidToChoose) do
        if v then

        end
    end
end
--endregion

--region 确认熔炼
---点击熔炼
function UIForgeBloodSmeltPanel:OnSmeltClicked(go)
    local data = self:GetCurrentChooseBagItemInfo()
    if #data <= 0 then
        Utility.ShowPopoTips(go, nil, 430)
        return
    end

    self.mCurrentReqData = data
    self.mStartCount = true
    self.mCurrentTime = CS.UnityEngine.Time.time
end

---延时请求等待特效播完
function UIForgeBloodSmeltPanel:DelayReq()
    if self.mStartCount and self.mCurrentReqData and CS.UnityEngine.Time.time - self.mCurrentTime > 0.5 then
        local currentChooseItem = self.mChooseItemInfo
        if currentChooseItem then
            local equipId = currentChooseItem.index > 0 and currentChooseItem.index * -1 or currentChooseItem.lid
            networkRequest.ReqBloodSmelt(equipId, self.mCurrentReqData)
        end
        self.mStartCount = false
    end
end

---获取当前选中道具
function UIForgeBloodSmeltPanel:GetCurrentChooseBagItemInfo()
    local ChooseList = {}
    if self.mCurrentShowSmeltList then
        for i = 1, #self.mCurrentShowSmeltList do
            local bagItemInfo = self.mCurrentShowSmeltList[i]
            if bagItemInfo and self:GetSmeltItemChooseState(bagItemInfo.lid) then
                local template = self.mCurrentPageLidToTemplate[bagItemInfo.lid]
                if template then
                    template:SetSmeltEffectChoose()
                end
                table.insert(ChooseList, bagItemInfo.lid)
            end
        end
    end
    return ChooseList
end
--endregion

--region  箭头
function UIForgeBloodSmeltPanel:RefreshMaterialArrow()
    local needShow = #self.mCurrentShowSmeltList >= 5
    self:RefreshArrow(self:GetMaterialScrollView(), self:GetMaterialLeftArrow_TweenAlpha(), self:GetMaterialRightArrow_TweenAlpha(), needShow)
end

function UIForgeBloodSmeltPanel:RefreshAttributeArrow()
    local needShowArrow = self:GetAttribute_UIGridContainer().MaxCount > 2
    self:RefreshArrow(self:GetAttributeScrollView(), self:GetAttributeLeftArrow_TweenAlpha(), self:GetAttributeRightArrow_TweenAlpha(), needShowArrow)
end

---@param scrollView UIScrollView
---@param leftTween TweenAlpha
---@param rightTween TweenAlpha
function UIForgeBloodSmeltPanel:RefreshArrow(scrollView, leftTween, rightTween, needShow)
    local state = scrollView:GetScrollViewSoftState(false)
    local numState = Utility.EnumToInt(state)
    leftTween.gameObject:SetActive(numState ~= 1 and needShow)
    rightTween.gameObject:SetActive(numState ~= 3 and needShow)
    leftTween:PlayTween()
    rightTween:PlayTween()
end
--endregion

--region 数据缓存
---@return TABLE.cfg_items 道具数据
function UIForgeBloodSmeltPanel:CacheItemInfo(itemId)
    if self.mItemIDToInfo == nil then
        self.mItemIDToInfo = {}
    end
    local data = self.mItemIDToInfo[itemId]
    if data == nil then
        data = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        self.mItemIDToInfo[itemId] = data
    end
    return data
end

---@return TABLE.cfg_bloodsuit 道具数据
function UIForgeBloodSmeltPanel:CacheBloodSuitInfo(itemId)
    if itemId == nil then
        return
    end
    if self.mItemIDToBloodSuitInfo == nil then
        self.mItemIDToBloodSuitInfo = {}
    end
    local data = self.mItemIDToBloodSuitInfo[itemId]
    if data == nil then
        data = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemId)
        self.mItemIDToBloodSuitInfo[itemId] = data
    end
    return data
end

---@return TABLE.cfg_bloodsuit_level 道具数据
function UIForgeBloodSmeltPanel:CacheBloodSuitLevelInfo(level)
    if self.mItemIDToBloodSuitLevelInfo == nil then
        self.mItemIDToBloodSuitLevelInfo = {}
    end
    local data = self.mItemIDToBloodSuitLevelInfo[level]
    if data == nil then
        data = clientTableManager.cfg_bloodsuit_levelManager:TryGetValue(level)
        self.mItemIDToBloodSuitLevelInfo[level] = data
    end
    return data
end

---@return CSMainPlayerInfo
function UIForgeBloodSmeltPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2
function UIForgeBloodSmeltPanel:GetBagInfoV2()
    if self.mBagInfoInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoInfoV2
end

---@return CSEquipInfoV2
function UIForgeBloodSmeltPanel:GetEquipInfoV2()
    if self.mEquipInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mEquipInfoV2 = self:GetMainPlayerInfo().EquipInfo
    end
    return self.mEquipInfoV2
end
--endregion

--region update
function update()
    UIForgeBloodSmeltPanel:DelayReq()
end
--endregion

--region 销毁操作
function UIForgeBloodSmeltPanel:DestroyFunc()
    if self.mAllOpenPanel then
        for i = 1, #self.mAllOpenPanel do
            uimanager:ClosePanel(self.mAllOpenPanel[i])
        end
    end
end

function ondestroy()
    UIForgeBloodSmeltPanel:DestroyFunc()
end
--endregion

return UIForgeBloodSmeltPanel