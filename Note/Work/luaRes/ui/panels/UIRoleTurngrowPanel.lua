---@class UIRoleTurngrowPanel:UIBase
local UIRoleTurngrowPanel = {}

--region 局部变量定义
---当前转生条件是否满足
UIRoleTurngrowPanel.isCanLevelUpReinLevel = true
---当前转生表id（非转生等级）
UIRoleTurngrowPanel.NowRoleTurnGrowLevel = -1
---当前职业
UIRoleTurngrowPanel.NowRoleCareer = 0
---当前角色等级
UIRoleTurngrowPanel.NowRoleLevel = 0
---当前修为值
UIRoleTurngrowPanel.NowEnergy = 0
---当前转生表
UIRoleTurngrowPanel.NowRoleTurnGrowValue = nil
---下一阶转生表
UIRoleTurngrowPanel.NextRoleTurnGrowValue = nil
---液体特效
UIRoleTurngrowPanel.waterEffect = nil
---液体特效路径
UIRoleTurngrowPanel.waterEffectPool = nil
---初始其他特效
UIRoleTurngrowPanel.initOtherEffect = nil
---初始其他特效路径
UIRoleTurngrowPanel.initOtherEffectPool = nil

UIRoleTurngrowPanel.equipGirdEffect = nil
UIRoleTurngrowPanel.equipGirdEffectPool = nil

---当前液体特效高度数值 0-1
UIRoleTurngrowPanel.CurWaterValue = 0
---液体特效目标高度
UIRoleTurngrowPanel.WaterTargetValue = 0
---液体特效变化协程
UIRoleTurngrowPanel.IEnumChangeWaterValue = nil
---转生成功特效
UIRoleTurngrowPanel.successEffect = nil
---转生成功特效路径
UIRoleTurngrowPanel.successEffectPool = nil
---转生循环特效
UIRoleTurngrowPanel.initialEffect = nil
---循坏特效路径
UIRoleTurngrowPanel.initialEffectPool = nil

---转生小循环特效
UIRoleTurngrowPanel.initialSmallEffect = nil
---小循坏特效路径
UIRoleTurngrowPanel.initialSmallEffectPool = nil

UIRoleTurngrowPanel.xiuWeiPos = nil
UIRoleTurngrowPanel.StonePos = nil
UIRoleTurngrowPanel.isOrgin = true

UIRoleTurngrowPanel.xiuWeiName = nil
UIRoleTurngrowPanel.StoneName = nil
UIRoleTurngrowPanel.isInitGrid = true

---@type ReplaceMateriaUpgradeConditionInformationBase
UIRoleTurngrowPanel.upConditionsInfo = {}
--endregion

--region 字体颜色
---属性文字颜色
UIRoleTurngrowPanel.AttributeWordColor = "[c9b39c]"
---当前属性数字颜色
UIRoleTurngrowPanel.NowAttributeNumbColor = "[ffffff]"
---下一阶属性数字颜色
UIRoleTurngrowPanel.NextAttributeNumbColor = "[00ff00]"
--endregion

--region 字体tween
UIRoleTurngrowPanel.tweenScaleTable = {}
--endregion

--region 组件
---视图
function UIRoleTurngrowPanel.GetView_Go()
    if UIRoleTurngrowPanel.mView_Go == nil then
        UIRoleTurngrowPanel.mView_Go = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view", "Transform")
    end
    return UIRoleTurngrowPanel.mView_Go
end

---等级需求
function UIRoleTurngrowPanel.GetNeedlevel_Label()
    if UIRoleTurngrowPanel.mNeedlevel_Label == nil then
        UIRoleTurngrowPanel.mNeedlevel_Label = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/needlevel", "UILabel")
    end
    return UIRoleTurngrowPanel.mNeedlevel_Label
end

---等级需求TweenPosition
function UIRoleTurngrowPanel.GetNeedlevel_TweenPosition()
    if UIRoleTurngrowPanel.mNeedlevel_TweenPosition == nil then
        UIRoleTurngrowPanel.mNeedlevel_TweenPosition = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/needlevel", "TweenPosition")
    end
    return UIRoleTurngrowPanel.mNeedlevel_TweenPosition
end

---属性列表
function UIRoleTurngrowPanel.GetAttributeList_UIGridContainer()
    if UIRoleTurngrowPanel.m_AttributeList_UIGridContainer == nil then
        UIRoleTurngrowPanel.m_AttributeList_UIGridContainer = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Center/Scroll View/arributelist", "UIGridContainer")
    end
    return UIRoleTurngrowPanel.m_AttributeList_UIGridContainer
end

---属性列表视图
function UIRoleTurngrowPanel.GetAttributeList_UIScrollView()
    if UIRoleTurngrowPanel.m_AttributeList_UIScrollView == nil then
        UIRoleTurngrowPanel.m_AttributeList_UIScrollView = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Center/Scroll View", "UIScrollView")
    end
    return UIRoleTurngrowPanel.m_AttributeList_UIScrollView
end

---向上箭头
function UIRoleTurngrowPanel.GetUpArrow_GameObject()
    if UIRoleTurngrowPanel.mUpArroe_GameObject == nil then
        UIRoleTurngrowPanel.mUpArroe_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Center/UpArrow", "GameObject")
    end
    return UIRoleTurngrowPanel.mUpArroe_GameObject
end

---向下箭头
function UIRoleTurngrowPanel.GetDownArrow_GameObject()
    if UIRoleTurngrowPanel.mDownArroe_GameObject == nil then
        UIRoleTurngrowPanel.mDownArroe_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Center/DownArrow", "GameObject")
    end
    return UIRoleTurngrowPanel.mDownArroe_GameObject
end

---向上箭头tween
function UIRoleTurngrowPanel.GetUpArrow_TweenAlpha()
    if UIRoleTurngrowPanel.mUpArroe_TweenAlpha == nil then
        UIRoleTurngrowPanel.mUpArroe_TweenAlpha = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Center/UpArrow", "Top_TweenAlpha")
    end
    return UIRoleTurngrowPanel.mUpArroe_TweenAlpha
end

---向下箭头tween
function UIRoleTurngrowPanel.GetDownArrow_TweenAlpha()
    if UIRoleTurngrowPanel.mDownArroe_TweenAlpha == nil then
        UIRoleTurngrowPanel.mDownArroe_TweenAlpha = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Center/DownArrow", "Top_TweenAlpha")
    end
    return UIRoleTurngrowPanel.mDownArroe_TweenAlpha
end

---转生需求材料
function UIRoleTurngrowPanel.GetBottom_GameObject()
    if UIRoleTurngrowPanel.mBottom_GameObject == nil then
        UIRoleTurngrowPanel.mBottom_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom", "GameObject")
    end
    return UIRoleTurngrowPanel.mBottom_GameObject
end

---修为按钮
function UIRoleTurngrowPanel.GetXiuWei_GameObject()
    if UIRoleTurngrowPanel.mXiuWei_GameObject == nil then
        UIRoleTurngrowPanel.mXiuWei_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/xiuwei", "GameObject")
    end
    return UIRoleTurngrowPanel.mXiuWei_GameObject
end

---修为icon按钮
function UIRoleTurngrowPanel.GetXiuWeiIcon_GameObject()
    if UIRoleTurngrowPanel.mXiuWeiIcon_GameObject == nil then
        UIRoleTurngrowPanel.mXiuWeiIcon_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/xiuwei/icon", "GameObject")
    end
    return UIRoleTurngrowPanel.mXiuWeiIcon_GameObject
end

---修为加号
function UIRoleTurngrowPanel.GetXiuWeiAdd_GameObject()
    if UIRoleTurngrowPanel.mXiuWeiAdd_GameObject == nil then
        UIRoleTurngrowPanel.mXiuWeiAdd_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/xiuwei/add", "GameObject")
    end
    return UIRoleTurngrowPanel.mXiuWeiAdd_GameObject
end

---升级效果label
function UIRoleTurngrowPanel:GetLevelUpDescribe_Label()
    if self.mLevelUpDescribe_Label == nil then
        self.mLevelUpDescribe_Label = self:GetCurComp("WidgetRoot/view/Tabel/Center/Label", "UILabel")
    end
    return self.mLevelUpDescribe_Label
end

---升级条件label
function UIRoleTurngrowPanel:GetLevelUpCondition_Label()
    if self.mLevelUpCondition_Label == nil then
        self.mLevelUpCondition_Label = self:GetCurComp("WidgetRoot/view/Tabel/Bottom/growlevel", "UILabel")
    end
    return self.mLevelUpCondition_Label
end

---消耗修为
function UIRoleTurngrowPanel.GetXiuWeiNum_Label()
    if UIRoleTurngrowPanel.mXiuWeiNum_Label == nil then
        UIRoleTurngrowPanel.mXiuWeiNum_Label = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/xiuwei/num", "UILabel")
    end
    return UIRoleTurngrowPanel.mXiuWeiNum_Label
end

---神石按钮
function UIRoleTurngrowPanel.GetGodStone_GameObject()
    if UIRoleTurngrowPanel.mGodStone_GameObject == nil then
        UIRoleTurngrowPanel.mGodStone_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/shenshi", "GameObject")
    end
    return UIRoleTurngrowPanel.mGodStone_GameObject
end

---神石icon按钮
function UIRoleTurngrowPanel.GetGodStoneIcon_GameObject()
    if UIRoleTurngrowPanel.mGodStoneIcon_GameObject == nil then
        UIRoleTurngrowPanel.mGodStoneIcon_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/shenshi/icon", "GameObject")
    end
    return UIRoleTurngrowPanel.mGodStoneIcon_GameObject
end

---神石加号
function UIRoleTurngrowPanel.GetGodStoneAdd_GameObject()
    if UIRoleTurngrowPanel.mGodStoneAdd_GameObject == nil then
        UIRoleTurngrowPanel.mGodStoneAdd_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/shenshi/add", "GameObject")
    end
    return UIRoleTurngrowPanel.mGodStoneAdd_GameObject
end

---消耗神石
function UIRoleTurngrowPanel.GetGodStoneNum_Label()
    if UIRoleTurngrowPanel.mGodStoneNum_Label == nil then
        UIRoleTurngrowPanel.mGodStoneNum_Label = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/change/shenshi/num", "UILabel")
    end
    return UIRoleTurngrowPanel.mGodStoneNum_Label
end

---转生按钮
function UIRoleTurngrowPanel.GetTurnGrowBtn_Button()
    if UIRoleTurngrowPanel.mTurnGrowBtn_Button == nil then
        UIRoleTurngrowPanel.mTurnGrowBtn_Button = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/btn_turngrow", "GameObject")
    end
    return UIRoleTurngrowPanel.mTurnGrowBtn_Button
end

function UIRoleTurngrowPanel.GetTurnGrowDescribe_UILabel()
    if UIRoleTurngrowPanel.mTurnGrowBtnDescribe_UILabel == nil then
        UIRoleTurngrowPanel.mTurnGrowBtnDescribe_UILabel = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/btn_turngrow/Label", "Top_UILabel")
    end
    return UIRoleTurngrowPanel.mTurnGrowBtnDescribe_UILabel
end

---转生按钮特效
---@return UnityEngine.GameObject
function UIRoleTurngrowPanel.GetTurnGrowBtnEffect_GameObject()
    if UIRoleTurngrowPanel.mTurnGrowBtnEffect_GameObject == nil then
        UIRoleTurngrowPanel.mTurnGrowBtnEffect_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/btn_turngrow/buttonEffect", "GameObject")
    end
    return UIRoleTurngrowPanel.mTurnGrowBtnEffect_GameObject
end

---消息tips
function UIRoleTurngrowPanel.GetTips_UILabel()
    if UIRoleTurngrowPanel.mTips_UILabel == nil then
        UIRoleTurngrowPanel.mTips_UILabel = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/man", "UILabel")
    end
    return UIRoleTurngrowPanel.mTips_UILabel
end

---关闭按钮
function UIRoleTurngrowPanel.GetCloseBtn_Button()
    if UIRoleTurngrowPanel.mCloseBtn_Button == nil then
        UIRoleTurngrowPanel.mCloseBtn_Button = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIRoleTurngrowPanel.mCloseBtn_Button
end

---左关闭按钮
function UIRoleTurngrowPanel.GetLeftCloseBtn_GameObject()
    if UIRoleTurngrowPanel.mLeftCloseBtn_GameObject == nil then
        UIRoleTurngrowPanel.mLeftCloseBtn_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/window/window/left_main/events/btn_close", "GameObject")
    end
    return UIRoleTurngrowPanel.mLeftCloseBtn_GameObject
end

---升级效果
function UIRoleTurngrowPanel.GetGrowLevel_GameObject()
    if UIRoleTurngrowPanel.mGrowLevel_GameObject == nil then
        UIRoleTurngrowPanel.mGrowLevel_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/view/Tabel/Bottom/growlevel", "GameObject")
    end
    return UIRoleTurngrowPanel.mGrowLevel_GameObject
end

---帮助按钮
function UIRoleTurngrowPanel.GetHelpBtn_GameObject()
    if UIRoleTurngrowPanel.mGetHelpBtn_GameObject == nil then
        UIRoleTurngrowPanel.mGetHelpBtn_GameObject = UIRoleTurngrowPanel:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return UIRoleTurngrowPanel.mGetHelpBtn_GameObject
end
---Top_CSEffectRenderQueue
function UIRoleTurngrowPanel.Top_CSEffectRenderQueue()
    if UIRoleTurngrowPanel.mTop_CSEffectRenderQueue == nil then
        UIRoleTurngrowPanel.mTop_CSEffectRenderQueue = UIRoleTurngrowPanel.waterEffect.transform:GetComponent('Top_CSEffectRenderQueue')
    end
    return UIRoleTurngrowPanel.mTop_CSEffectRenderQueue
end

function UIRoleTurngrowPanel:GetTurnBallGroup_GameObject()
    if (self.mTurnBallGroup == nil) then
        self.mTurnBallGroup = self:GetCurComp("WidgetRoot/view/turngrowlevel/ball", "GameObject")
    end
    return self.mTurnBallGroup
end

---@return Top_UIGridContainer
function UIRoleTurngrowPanel:GetReinItem_GridContainer()
    if (self.mReinItemGrid == nil) then
        self.mReinItemGrid = self:GetCurComp("WidgetRoot/view/Tabel/Bottom/ScorllView/change", "Top_UIGridContainer")
    end
    return self.mReinItemGrid
end

---获取中间属性的坐标
---@return UnityEngine.GameObject
function UIRoleTurngrowPanel:GetBottomWidget_Gameobject()
    if (self.mBottomWidget_Gameobject == nil) then
        self.mBottomWidget_Gameobject = self:GetCurComp("WidgetRoot/view/Tabel/Wight", "GameObject")
    end
    return self.mBottomWidget_Gameobject
end

---转生/等级跳转按钮
---@return UnityEngine.GameObject
function UIRoleTurngrowPanel:GetButton_Jump_GameObject()
    if self.mButtonJumpGameObject == nil then
        self.mButtonJumpGameObject = self:GetCurComp("WidgetRoot/events/btn_jump", "GameObject")
    end
    return self.mButtonJumpGameObject
end

---跳转红点
---@return UIRedPoint
function UIRoleTurngrowPanel:GetBtnJumpRedPoint()
    if self.mBtnJumpRedPoint == nil then
        self.mBtnJumpRedPoint = self:GetCurComp("WidgetRoot/events/btn_jump/redpoint", "UIRedPoint")
    end
    return self.mBtnJumpRedPoint
end
--endregion

function UIRoleTurngrowPanel:GetOtherItemShow_GameObject()
    if (self.mOtherItemShow_GameObject == nil) then
        self.mOtherItemShow_GameObject = self:GetCurComp("WidgetRoot/view/otherItem", "GameObject");
    end
    return self.mOtherItemShow_GameObject;
end

---@return UIItem
function UIRoleTurngrowPanel:GetOtherItemShow_UIItem()
    if (self.mOtherItemShow_UIItem == nil) then
        self.mOtherItemShow_UIItem = templatemanager.GetNewTemplate(self:GetOtherItemShow_GameObject(), luaComponentTemplates.UIItem);
    end
    return self.mOtherItemShow_UIItem;
end

function UIRoleTurngrowPanel:GetOtherItemEffect()
    if (self.mOtherItemEffect == nil) then
        self.mOtherItemEffect = self:GetCurComp("WidgetRoot/view/otherItem/bg", "CSUIEffectLoad");
    end
    return self.mOtherItemEffect;
end

--region 初始化
function UIRoleTurngrowPanel:Init()
    self:InitComponents()
    UIRoleTurngrowPanel.ReqTurnGrowMessage()
    UIRoleTurngrowPanel.ReqStoreById()
    UIRoleTurngrowPanel.BindUIEvents()
    UIRoleTurngrowPanel.BindMessage()
    UIRoleTurngrowPanel.InitParams()
    UIRoleTurngrowPanel.RefreshJumpBtnState()
end

function UIRoleTurngrowPanel:Show(customData)
    local type = LuaEnumRoleReinPanelType.ReinPanel
    if customData ~= nil and customData.index ~= nil then
        type = customData.index
    else
        ---第一次打开时,如果转生界面没有红点且等级界面可以打开且有红点,那么切换到等级界面
        if self.mIsNotFirst == nil and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange() ~= nil
                and gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():IsSystemOpened() then
            local isRoleTurngrowRedPointExist = false
            if gameMgr:GetLuaRedPointManager():GetRedPointState(LuaRedPointName.LianZhi_XiuWei) then
                isRoleTurngrowRedPointExist = true
            end
            if isRoleTurngrowRedPointExist == false and gameMgr:GetLuaRedPointManager():GetRedPointState(LuaRedPointName.LuaRoleReinRedPoint) then
                isRoleTurngrowRedPointExist = true
            end
            if isRoleTurngrowRedPointExist == false and gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():IsExpExchangeRedPointNeedShow() then
                type = LuaEnumRoleReinPanelType.ExpExchange
            end
        end
    end
    self.mIsNotFirst = true
    if type == LuaEnumRoleReinPanelType.ExpExchange then
        self.SwitchToLevelPanel()
    end

    if UIRoleTurngrowPanel.successEffect ~= nil then
        UIRoleTurngrowPanel.successEffect.gameObject:SetActive(false)
    end
end

function UIRoleTurngrowPanel:InitComponents()
    ---@type Top_UITable 总tabel
    UIRoleTurngrowPanel.totalTabel = self:GetCurComp("WidgetRoot/view/Tabel", "Top_UITable")
    ---@type Top_UITable 二级tabel
    UIRoleTurngrowPanel.bottomTabel = self:GetCurComp("WidgetRoot/view/Tabel/Bottom", "Top_UITable")
    ---@type Top_UITable 三级tabel
    UIRoleTurngrowPanel.changeTabel = self:GetCurComp("WidgetRoot/view/Tabel/Bottom/change", "Top_UITable")
end

function UIRoleTurngrowPanel.InitParams()
    UIRoleTurngrowPanel.XiuweiItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(1000012)
    UIRoleTurngrowPanel.xiuWeiPos = CS.UnityEngine.Vector3(-454, -222, 0)
    --UIRoleTurngrowPanel.StonePos = UIRoleTurngrowPanel.GetGodStone_GameObject().transform.localPosition
end

function UIRoleTurngrowPanel.BindUIEvents()
    CS.UIEventListener.Get(UIRoleTurngrowPanel.GetTurnGrowBtn_Button()).onClick = UIRoleTurngrowPanel.TurnGrowBtnClick
    CS.UIEventListener.Get(UIRoleTurngrowPanel.GetLeftCloseBtn_GameObject()).onClick = UIRoleTurngrowPanel.CloseBtnClick
    --CS.UIEventListener.Get(UIRoleTurngrowPanel.GetXiuWeiIcon_GameObject()).onClick = UIRoleTurngrowPanel.OpenXiuWeiItenInfoPanel
    --CS.UIEventListener.Get(UIRoleTurngrowPanel.GetXiuWeiAdd_GameObject()).onClick = UIRoleTurngrowPanel.OpenXiuWeiWayGet
    --CS.UIEventListener.Get(UIRoleTurngrowPanel.GetGodStoneIcon_GameObject()).onClick = UIRoleTurngrowPanel.OpenGodStoneItemInfoPanel
    --CS.UIEventListener.Get(UIRoleTurngrowPanel.GetGodStoneAdd_GameObject()).onClick = UIRoleTurngrowPanel.OpenGodStoneWayGet
    CS.UIEventListener.Get(UIRoleTurngrowPanel.GetHelpBtn_GameObject()).onClick = UIRoleTurngrowPanel.OnHelpBtnClick
    CS.UIEventListener.Get(UIRoleTurngrowPanel:GetButton_Jump_GameObject()).onClick = function()
        UIRoleTurngrowPanel.SwitchToLevelPanel()
    end
    UIRoleTurngrowPanel:GetBtnJumpRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ExpExchange))

    UIRoleTurngrowPanel:GetAttributeList_UIScrollView().onDragProgress = UIRoleTurngrowPanel.OnScrollViewMomentumMove
end

function UIRoleTurngrowPanel.BindMessage()

    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterResultMessage, UIRoleTurngrowPanel.OnResRefineMasterResultFun)
    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendRoleReinInfoMessage, UIRoleTurngrowPanel.OnResSendRoleReinInfoMessageReceived)
    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleExchangeReinResultMessage, UIRoleTurngrowPanel.OnResRoleExchangeReinResultMessageReceived)
    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTotalFightValueChangeMessage, UIRoleTurngrowPanel.OnResRoleFightValueChangeMessageReceived)
    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerAttributeChangeMessage, UIRoleTurngrowPanel.OnResRoleAttributeChangeMessageReceived)
    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleReinSuccess, UIRoleTurngrowPanel.OnResRoleReinSuccessReceived)
    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIRoleTurngrowPanel.OnResBagChangeMessageReceived)
    UIRoleTurngrowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerLevelChangeMessage, UIRoleTurngrowPanel.RefreshJumpBtnState)
    UIRoleTurngrowPanel:GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, function(msgID, panelName)
        if panelName == "UIBagPanel" and (UIRoleTurngrowPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByItemInfoPanel
                or UIRoleTurngrowPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByBagPanel) then
            uimanager:ClosePanel("UIRoleTurngrowPanel")
        end
    end)
end
--endregion

--region 转生/等级界面切换
---切换到等级界面
---@private
function UIRoleTurngrowPanel.SwitchToLevelPanel()
    UIRoleTurngrowPanel:HideSelf()
    local expExchangePanel = uimanager:GetPanel("UIRoleExpExchangePanel")
    if expExchangePanel then
        expExchangePanel:ReShowSelf()
    else
        uimanager:CreatePanel("UIRoleExpExchangePanel")
    end
end

---刷新跳转按钮状态
---@private
function UIRoleTurngrowPanel.RefreshJumpBtnState()
    if gameMgr:GetPlayerDataMgr() ~= nil
            and gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange() ~= nil
            and gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():IsSystemOpened() then
        UIRoleTurngrowPanel:GetButton_Jump_GameObject():SetActive(true)
    else
        UIRoleTurngrowPanel:GetButton_Jump_GameObject():SetActive(false)
    end
end
--endregion

--region UI事件处理

---@public 更新其他Item
function UIRoleTurngrowPanel:UpdateOtherItem()
    self:GetOtherItemShow_GameObject():SetActive(false);
    ---@type table<number, ReinPanelShowItemParams>
    local otherItemDataDic = LuaGlobalTableDeal:GetReinPanelShowItemData();
    ---@type ReinPanelShowItemParams
    local curShowItemParams;
    if (otherItemDataDic ~= nil) then
        for k, v in pairs(otherItemDataDic) do
            if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v.conditionId)) then
                curShowItemParams = v;
                break ;
            end
        end
    end

    if (curShowItemParams ~= nil) then
        --策划新需求，如果购买过该道具，则不显示Icon（换手机不考虑）
        self:GetOtherItemShow_GameObject():SetActive(true);
        local oldStr = CS.UnityEngine.PlayerPrefs.GetString("TurnGrowItem" .. tostring(CS.CSScene.MainPlayerInfo.ID))
        local strTable = string.Split(oldStr, '#')
        if (Utility.IsContainsValue(strTable, tostring(curShowItemParams.itemId))) then
            self:GetOtherItemShow_GameObject():SetActive(false);
        else
            local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(curShowItemParams.itemId)
            if (count ~= 0) then
                self:GetOtherItemShow_GameObject():SetActive(false);
                local newStr = oldStr .. "#" .. tostring(curShowItemParams.itemId)
                CS.UnityEngine.PlayerPrefs.SetString("TurnGrowItem" .. tostring(CS.CSScene.MainPlayerInfo.ID), newStr)
            end
        end
        local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(curShowItemParams.itemId);
        if (isFind) then
            self:GetOtherItemShow_UIItem():RefreshUIWithItemInfo(itemInfo, 1);
        end
        self:GetOtherItemEffect():ChangeEffect(curShowItemParams.effectId);
        CS.UIEventListener.Get(self:GetOtherItemShow_GameObject()).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, itemType = LuaEnumItemInfoPanelItemType.UpgradeMembership })
        end
    end
end

---刷新转生道具面板
function UIRoleTurngrowPanel:RefreshReinItem()
    if (UIRoleTurngrowPanel.NowRoleTurnGrowLevel ~= -1) then
        local reintab = clientTableManager.cfg_reincarnationManager:TryGetValue(UIRoleTurngrowPanel.NowRoleTurnGrowLevel)
        local reinitemlist
        if (reintab ~= nil) then
            if (reintab:GetOpenNeedItem() ~= nil and reintab:GetOpenNeedItem().list ~= nil) then
                reinitemlist = reintab:GetOpenNeedItem().list
                self.remainType = 1
            elseif (reintab:GetNeedItem() ~= nil and reintab:GetNeedItem().list ~= nil) then
                reinitemlist = reintab:GetNeedItem().list
                self.remainType = 1
            elseif (reintab:GetBoss() ~= nil and reintab:GetBoss().list ~= nil) then
                reinitemlist = reintab:GetBoss().list
                self.remainType = 2
            end
            if (reinitemlist == nil) then
                return
            end
            UIRoleTurngrowPanel.upConditionsInfo = {}
            ---@type ReplaceMateriaUpgradeConditionInformationItem[]
            UIRoleTurngrowPanel.upConditionsInfo.conditionInfo = {}
            self:GetReinItem_GridContainer().MaxCount = reinitemlist.Count
            for i = 0, self:GetReinItem_GridContainer().controlList.Count - 1 do
                local go = self:GetReinItem_GridContainer().controlList[i];
                local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite");
                local icon_go = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "GameObject");
                local add = CS.Utility_Lua.GetComponent(go.transform:Find("add"), "GameObject");
                local num = CS.Utility_Lua.GetComponent(go.transform:Find("num"), "Top_UILabel");
                local rightLabel = CS.Utility_Lua.GetComponent(go.transform:Find("rightLabel"), "Top_UILabel");
                local leftLabel = CS.Utility_Lua.GetComponent(go.transform:Find("leftLabel"), "Top_UILabel");
                local conditionId = reinitemlist[i]
                local result = Utility.IsMainPlayerMatchCondition(conditionId)
                if result and result.mReplaceMatData then
                    local itemId = result.mReplaceMatData.fullConditionItemId
                    ---@type TABLE.CFG_ITEMS
                    local ItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(itemId)
                    if ItemInfo then
                        rightLabel.text = " "
                        leftLabel.text = " "
                        icon.spriteName = ItemInfo.icon
                        icon_go:SetActive(true)
                        add:SetActive(true)
                        CS.UIEventListener.Get(add).onClick = function()
                            if ItemInfo.wayGet ~= nil then
                                Utility.ShowItemGetWay(itemId, add, LuaEnumWayGetPanelArrowDirType.Down)
                            end
                        end
                        CS.UIEventListener.Get(icon.gameObject).onClick = function()
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = ItemInfo })
                        end
                        local itemCount = result.mReplaceMatData.playerHasTotal
                        local text = CS.Utility_Lua.SetProgressLabelColor(itemCount, result.mReplaceMatData.num)
                        num.text = text
                        UIRoleTurngrowPanel.upConditionsInfo.conditionInfo[i + 1] = Utility.GetReplaceMateriaUpgradeConditionInformationItem(result, add, itemId)
                    end
                elseif result and result.monsterKill then
                    icon_go:SetActive(false)
                    add:SetActive(false)
                    rightLabel.text = CS.Utility_Lua.SetProgressLabelColor(result.monsterKill, result.param[0])
                    leftLabel.text = result.txt
                    num.text = " "
                end
            end
        end
        UIRoleTurngrowPanel.isCanLevelUpReinLevel = Utility.GetReplaceMateriaUpgradeConditionInformationCanBeUpgraded(UIRoleTurngrowPanel.upConditionsInfo.conditionInfo)
        UIRoleTurngrowPanel.bottomTabel:Reposition()
        UIRoleTurngrowPanel.totalTabel:Reposition()
    end
end

---请求转生信息
function UIRoleTurngrowPanel.ReqTurnGrowMessage()
    networkRequest.ReqGetRoleReinInfo()
end
---点击转生按钮
function UIRoleTurngrowPanel.TurnGrowBtnClick(go)
    local type = UIRoleTurngrowPanel:GetRemainType()
    if type == 2 then
        local clickCheck = UIRoleTurngrowPanel:IsKillMonster()
        if clickCheck == true then
            if UIRoleTurngrowPanel:CheckLevelReq(go) then
                networkRequest.ReqUpLevelRoleRein()
            end
        elseif clickCheck == false then
            local reintab = clientTableManager.cfg_reincarnationManager:TryGetValue(UIRoleTurngrowPanel.NowRoleTurnGrowLevel)
            local jumpId = reintab:GetParameter().list
            local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(tonumber(jumpId[1]))
            local bossTemp = {}
            bossTemp.type = bossInfo:GetType()
            bossTemp.subType = bossInfo:GetSubType()
            uimanager:ClosePanel(self)
            uimanager:CreatePanel("UIBossPanel", nil, bossTemp)
        end
        return
    end

    if UIRoleTurngrowPanel:CheckIsCanLevelUpReinLevel(go) then
        networkRequest.ReqUpLevelRoleRein()
    end
end
---请求商店商品列表
function UIRoleTurngrowPanel.ReqStoreById()
    --CS.UnityEngine.Debug.LogError("请求商店商品列表")
    networkRequest.ReqOpenStoreById(LuaEnumStoreType.TurnGrowShop)
end
---关闭按钮
function UIRoleTurngrowPanel.CloseBtnClick()
    --CS.UnityEngine.Debug.LogError("点击关闭转生面板")
    uimanager:ClosePanel("UIRoleTurngrowPanel")
end

---修为按钮点击
function UIRoleTurngrowPanel.XiuWeiBtnClick()
    if UIRoleTurngrowPanel.NowEnergy < UIRoleTurngrowPanel.NowRoleTurnGrowValue.needEnergy then
        UIRoleTurngrowPanel.OpenXiuWeiWayGet()
    else
        UIRoleTurngrowPanel.OpenXiuWeiItenInfoPanel()
    end
end

---打开修为获取途径
function UIRoleTurngrowPanel.OpenXiuWeiWayGet()
    if UIRoleTurngrowPanel.XiuweiItemInfo.wayGet ~= nil then
        Utility.ShowItemGetWay(1000012, UIRoleTurngrowPanel.GetXiuWeiAdd_GameObject(), LuaEnumWayGetPanelArrowDirType.Down);
    end
end

---打开修为iteminfopanel
function UIRoleTurngrowPanel.OpenXiuWeiItenInfoPanel()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UIRoleTurngrowPanel.XiuweiItemInfo })
end

---神石按钮点击
function UIRoleTurngrowPanel.GodStoneBtnClick()
    local itemId = UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem.list[0]
    local itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(itemId)
    if UIRoleTurngrowPanel.NowGlodStone < UIRoleTurngrowPanel.needGoldStone then
        if itemInfo.wayGet ~= nil then
            Utility.ShowItemGetWay(itemId, UIRoleTurngrowPanel.GetXiuWeiAdd_GameObject(), LuaEnumWayGetPanelArrowDirType.Down)
        end
    else
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
    end
end

---获取神石获取途径
function UIRoleTurngrowPanel.OpenGodStoneWayGet()
    local itemId = UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem.list[0]
    local itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(itemId)
    if itemInfo.wayGet ~= nil then
        Utility.ShowItemGetWay(itemId, UIRoleTurngrowPanel.GetGodStoneAdd_GameObject(), LuaEnumWayGetPanelArrowDirType.Down)
    end
end

---打开神石装备提示面板
function UIRoleTurngrowPanel.OpenGodStoneItemInfoPanel()
    if UIRoleTurngrowPanel.NowRoleTurnGrowValue == nil then
        return
    end
    local itemId = UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem.list[0]
    local itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(itemId)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
end

---点击帮助按钮
function UIRoleTurngrowPanel.OnHelpBtnClick()
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(47)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

---拖动
function UIRoleTurngrowPanel.OnScrollViewMomentumMove()
    local gridContainer = UIRoleTurngrowPanel.GetAttributeList_UIGridContainer()
    local height = gridContainer.MaxCount * gridContainer.CellHeight;
    if UIRoleTurngrowPanel:GetAttributeList_UIScrollView().panel == nil then
        return
    end
    local offsetY = UIRoleTurngrowPanel:GetAttributeList_UIScrollView().panel.clipOffset.y;
    if (offsetY < 0) then
        if (math.abs(offsetY) > gridContainer.CellHeight / 2) then
            if not UIRoleTurngrowPanel.GetUpArrow_GameObject().activeSelf then
                UIRoleTurngrowPanel.GetUpArrow_GameObject():SetActive(true);
                if UIRoleTurngrowPanel.GetDownArrow_GameObject().activeSelf then
                    UIRoleTurngrowPanel.GetDownArrow_TweenAlpha():PlayTween()
                end
                UIRoleTurngrowPanel.GetUpArrow_TweenAlpha():PlayTween()
            end
        else
            if UIRoleTurngrowPanel.GetUpArrow_GameObject().activeSelf then
                UIRoleTurngrowPanel.GetUpArrow_GameObject():SetActive(false);
            end
        end
    else
        if UIRoleTurngrowPanel.GetUpArrow_GameObject().activeSelf then
            UIRoleTurngrowPanel.GetUpArrow_GameObject():SetActive(false);
        end
    end

    local interval = (height - UIRoleTurngrowPanel:GetAttributeList_UIScrollView().panel.height) - math.abs(offsetY);
    if (interval > gridContainer.CellHeight / 2) then
        if not UIRoleTurngrowPanel.GetDownArrow_GameObject().activeSelf then
            if UIRoleTurngrowPanel.GetUpArrow_GameObject().activeSelf then
                UIRoleTurngrowPanel.GetUpArrow_TweenAlpha():PlayTween()
            end
            UIRoleTurngrowPanel.GetDownArrow_TweenAlpha():PlayTween()
            UIRoleTurngrowPanel.GetDownArrow_GameObject():SetActive(true);
        end
    else
        if UIRoleTurngrowPanel.GetDownArrow_GameObject().activeSelf then
            UIRoleTurngrowPanel.GetDownArrow_GameObject():SetActive(false);
        end
    end
end

---刷新八门
function UIRoleTurngrowPanel:RefreshTurnBallGroup(cfgid)
    local childCount = self:GetTurnBallGroup_GameObject().transform.childCount;
    local reintab = clientTableManager.cfg_reincarnationManager:TryGetValue(cfgid)

    for i = 0, childCount - 1 do
        self:GetTurnBallGroup_GameObject().transform:GetChild(i).gameObject:SetActive(i < reintab:GetEightDoor())
    end
end

---@type  number 八门类型
---获取八门名字
function UIRoleTurngrowPanel:GetEightDoorName(index)
    if (index == 1) then
        return "休门"
    elseif (index == 2) then
        return "生门"
    elseif (index == 3) then
        return "伤门"
    elseif (index == 4) then
        return "杜门"
    elseif (index == 5) then
        return "景门"
    elseif (index == 6) then
        return "死门"
    elseif (index == 7) then
        return "惊门"
    elseif (index == 8) then
        return "开门"
    else
        return ""
    end
end
--endregion

--region 服务器事件处理
function UIRoleTurngrowPanel.OnResRefineMasterResultFun(id, data, csdata)
    if (UIRoleTurngrowPanel.NowRoleTurnGrowValue ~= nil) then
        local text = CS.Utility_Lua.SetProgressLabelColor(CS.CSScene.MainPlayerInfo.ReinExp, UIRoleTurngrowPanel.NowRoleTurnGrowValue.needEnergy)
        UIRoleTurngrowPanel.GetXiuWeiNum_Label().text = text
    end
end
---接收转生信息
function UIRoleTurngrowPanel.OnResSendRoleReinInfoMessageReceived(id, info, csTabele)
    --CS.UnityEngine.Debug.LogError("接收转生信息")
    UIRoleTurngrowPanel.NowRoleTurnGrowLevel = info.cfgId
    UIRoleTurngrowPanel.NowEnergy = info.reinNum
    UIRoleTurngrowPanel.NowRoleLevel = CS.CSScene.MainPlayerInfo.Level
    --获取当前转生等级对应的表
    UIRoleTurngrowPanel.NowRoleTurnGrowValue = CS.Cfg_ReincarnationManager.Instance:getReincarnationData(UIRoleTurngrowPanel.NowRoleTurnGrowLevel)
    UIRoleTurngrowPanel.NowRoleTurnGrowValueTable = clientTableManager.cfg_reincarnationManager:TryGetValue(UIRoleTurngrowPanel.NowRoleTurnGrowLevel)
    UIRoleTurngrowPanel:InitNowTrunGrowLevel()

    --UIRoleTurngrowPanel:CalculationWaterValue()
    --UIRoleTurngrowPanel:SetWaterValue(UIRoleTurngrowPanel.WaterTargetValue)

    UIRoleTurngrowPanel:RefreshTurnBallGroup(info.cfgId)
    UIRoleTurngrowPanel:RefreshReinItem()
    UIRoleTurngrowPanel:UpdateOtherItem()
    --C#
    CS.CSScene.MainPlayerInfo.BagInfo:CheckServantEggInbagToUse();
end

---接收兑换修为信息
function UIRoleTurngrowPanel.OnResRoleExchangeReinResultMessageReceived(id, info, csTabele)
    UIRoleTurngrowPanel.NowEnergy = info.reinNum
    UIRoleTurngrowPanel.NowRoleLevel = info.roleLevel
    CS.CSScene.MainPlayerInfo.Level = UIRoleTurngrowPanel.NowRoleLevel
    UIRoleTurngrowPanel:InitNowTrunGrowLevel()
    --UIRoleTurngrowPanel:CalculationWaterValue()
end

---接收总战斗力
function UIRoleTurngrowPanel.OnResRoleFightValueChangeMessageReceived(id, info, csTabele)
    --CS.UnityEngine.Debug.LogError("接收总战斗力")
    CS.CSScene.MainPlayerInfo.FightPower = info.totalFightValue
end

---接收属性变化
function UIRoleTurngrowPanel.OnResRoleAttributeChangeMessageReceived(id, LuaTable, csTabele)
    --CS.UnityEngine.Debug.LogError("接收属性变化")
    CS.CSScene.MainPlayerInfo:UpdatePlayerAttribute(csTabele.attr)
    UIRoleTurngrowPanel.CheckOpenEffect()
end

---转生成功
function UIRoleTurngrowPanel.OnResRoleReinSuccessReceived(id, LuaTable, csTabele)
    UIRoleTurngrowPanel.TurnGrowFontTweenScale()
    ---刷新红点
    gameMgr:GetPlayerDataMgr():GetReinDataManager():CallUpReinLvRedPoint()
    UIRoleTurngrowPanel.ShowSuccessEffect()
end

---背包发生变化
---@param LuaTable bagV2.ResBagChange
function UIRoleTurngrowPanel.OnResBagChangeMessageReceived(id, LuaTable, csTabele)
    ---刷新红点
    gameMgr:GetPlayerDataMgr():GetReinDataManager():CallUpReinLvRedPoint()

    UIRoleTurngrowPanel:RefreshReinItem()
    --检查开启按钮特效
    UIRoleTurngrowPanel.CheckOpenEffect()
    --if LuaTable.itemList == nil or UIRoleTurngrowPanel.NowRoleTurnGrowValue == nil
    --        or #LuaTable.itemList == 0 or UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem == nil then
    --    return
    --end
    --if UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem ~= nil and LuaTable.itemList[1].itemId == UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem.list[0] then
    --    UIRoleTurngrowPanel.NowGlodStone = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem.list[0])
    --UIRoleTurngrowPanel:SetGodStone()
    --UIRoleTurngrowPanel.CheckOpenEffect()
    --UIRoleTurngrowPanel:CalculationWaterValue()
    --end
end
--endregion

--region 功能
--region 转生面板参数
---检测当前是否要更改转生面板
function UIRoleTurngrowPanel:InitNowTrunGrowLevel()
    ---修改转生面板
    UIRoleTurngrowPanel:TurnGrowChangePanel()
    ---修改经验兑换面板
    UIRoleTurngrowPanel:ExchangeEnergyChangePanel()
end

---点击转生改变面板
function UIRoleTurngrowPanel:TurnGrowChangePanel()
    --获取角色信息
    UIRoleTurngrowPanel:GetRoleMessage()
    --获取表中的数据
    UIRoleTurngrowPanel:GetReinTableMessage()

    UIRoleTurngrowPanel:SetTurnGrowValue()
    if UIRoleTurngrowPanel.isInitGrid then
        UIRoleTurngrowPanel.isInitGrid = false
        UIRoleTurngrowPanel.OnScrollViewMomentumMove()
    end
end

---点击兑换修为改变面板
function UIRoleTurngrowPanel:ExchangeEnergyChangePanel()
    --获取角色信息
    UIRoleTurngrowPanel:GetRoleMessage()
    --修改经验兑换修为面板
    UIRoleTurngrowPanel:SetExchangeEnergyValue()
end

---获取角色数据
function UIRoleTurngrowPanel:GetRoleMessage()
    --获取当前职业
    UIRoleTurngrowPanel.NowRoleCareer = CS.CSScene.MainPlayerInfo.Career
end

---获取表中的数据
function UIRoleTurngrowPanel:GetReinTableMessage()
    --if (UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem ~= nil) then
    --    UIRoleTurngrowPanel.needGoldStone = UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem.list[1]
    --else
    --    UIRoleTurngrowPanel.needGoldStone = nil
    --end
    --获取下一阶转生等级对应的表
    if UIRoleTurngrowPanel.NowRoleTurnGrowLevel < CS.Cfg_ReincarnationManager.Instance.dic.Count then
        UIRoleTurngrowPanel.NextRoleTurnGrowValue = CS.Cfg_ReincarnationManager.Instance:getReincarnationData(UIRoleTurngrowPanel.NowRoleTurnGrowLevel + 1)
    else
        UIRoleTurngrowPanel.NextRoleTurnGrowValue = nil
    end
end

---获取处理过的属性列表
---@return table<number,trungrowAttribute>
function UIRoleTurngrowPanel.GetAttributeList()
    local attributeNum = 4
    local tbl = {}
    for i = 1, attributeNum do
        local tblTemp = UIRoleTurngrowPanel.GetAttributeShowData(i)
        if tblTemp then
            table.insert(tbl, tblTemp)
        end
    end
    if #tbl >= 2 then
        table.sort(tbl, UIRoleTurngrowPanel.SortAttributeTbl)
    end
    return tbl
end

---属性列表排序
function UIRoleTurngrowPanel.SortAttributeTbl(l, r)

    if l == nil or r == nil then
        return false
    end
    local a = UIRoleTurngrowPanel.IsAttributeUp(l) and 1 or 0
    local b = UIRoleTurngrowPanel.IsAttributeUp(r) and 1 or 0
    return a > b
end

---属性是否有提升
---@param data trungrowAttribute
---@return boolean
function UIRoleTurngrowPanel.IsAttributeUp(data)
    ---数据错误
    if data == nil then
        return false
    end

    if data.nextMaxValue == nil or data.nextMaxValue == -1 then
        ---已满
        if data.curMaxValue ~= nil then
            return false
        end
    end

    if data.curMaxValue ~= nil then
        ---比较大小
        if data.nextMaxValue > data.curMaxValue then
            return true
        end
    end

    if data.nextMinValue == nil or data.nextMinValue == -1 then
        ---已满
        if data.curMinValue ~= nil then
            return false
        end
    end

    ---数据错误
    if data.curMinValue == nil then
        return false
    else
        ---比较大小
        return data.nextMinValue > data.curMinValue
    end
end

---获得显示的属性信息
---@return table<number,trungrowAttribute>
function UIRoleTurngrowPanel.GetAttributeShowData(type)

    local mStr = ''
    local mCurMinValue = 0
    local mCurMaxValue = 0
    local mNextMinValue = 0
    local mNextMaxValue = 0
    local NowRoleTurnGrowValue, NextRoleTrunGrowValue = UIRoleTurngrowPanel.NowRoleTurnGrowValue, UIRoleTurngrowPanel.NextRoleTurnGrowValue
    if NowRoleTurnGrowValue == nil then
        return nil
    end
    local isMax = NextRoleTrunGrowValue == nil or UIRoleTurngrowPanel.NowRoleTurnGrowLevel >= CS.Cfg_ReincarnationManager.Instance.dic.Count - 1
    --print(type, NowRoleTurnGrowValue.id, NowRoleTurnGrowValue.att, NowRoleTurnGrowValue.attMax, NextRoleTrunGrowValue.att, NextRoleTrunGrowValue.attMax)
    if type == 1 then
        mStr = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
        mCurMinValue = NowRoleTurnGrowValue.att
        mCurMaxValue = NowRoleTurnGrowValue.attMax
        mNextMinValue = isMax and -1 or NextRoleTrunGrowValue.att
        mNextMaxValue = isMax and -1 or NextRoleTrunGrowValue.attMax
    elseif type == 2 then
        mStr = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax)
        if (NowRoleTurnGrowValue.def ~= nil and NowRoleTurnGrowValue.defMax ~= nil) then
            mCurMinValue = UIRoleTurngrowPanel:GetRoleTurnGrow(NowRoleTurnGrowValue.def)
            mCurMaxValue = UIRoleTurngrowPanel:GetRoleTurnGrow(NowRoleTurnGrowValue.defMax)
            mNextMinValue = isMax and -1 or UIRoleTurngrowPanel:GetRoleTurnGrow(NextRoleTrunGrowValue.def)
            mNextMaxValue = isMax and -1 or UIRoleTurngrowPanel:GetRoleTurnGrow(NextRoleTrunGrowValue.defMax)
        end
    elseif type == 3 then
        mStr = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax)
        if (NowRoleTurnGrowValue.defMagic ~= nil and NowRoleTurnGrowValue.defMagicMax ~= nil) then
            mCurMinValue = UIRoleTurngrowPanel:GetRoleTurnGrow(NowRoleTurnGrowValue.defMagic)
            mCurMaxValue = UIRoleTurngrowPanel:GetRoleTurnGrow(NowRoleTurnGrowValue.defMagicMax)
            mNextMinValue = isMax and -1 or UIRoleTurngrowPanel:GetRoleTurnGrow(NextRoleTrunGrowValue.defMagic)
            mNextMaxValue = isMax and -1 or UIRoleTurngrowPanel:GetRoleTurnGrow(NextRoleTrunGrowValue.defMagicMax)
        end

    elseif type == 4 then
        mStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp)
        mCurMinValue = UIRoleTurngrowPanel:GetRoleTurnGrow(NowRoleTurnGrowValue.hp)
        mCurMaxValue = nil
        mNextMinValue = isMax and -1 or UIRoleTurngrowPanel:GetRoleTurnGrow(NextRoleTrunGrowValue.hp)
        mNextMaxValue = nil
    end
    if mCurMinValue == 0 and mCurMaxValue == 0 and mNextMinValue == 0 and mNextMaxValue == 0 then
        return
    end
    ---@class trungrowAttribute
    local trungrowAttribute = {
        str = mStr,
        curMinValue = mCurMinValue,
        curMaxValue = mCurMaxValue,
        nextMinValue = mNextMinValue,
        nextMaxValue = mNextMaxValue
    }
    return trungrowAttribute
end

---设置转生属性
function UIRoleTurngrowPanel:SetTurnGrowValue()
    --转生等级和当前属性设置
    UIRoleTurngrowPanel:LabelSetValue(UIRoleTurngrowPanel.GetView_Go(), "turngrowlevel", CS.CSScene.MainPlayerInfo.ReinLevel)

    local attributeShowInfoList = UIRoleTurngrowPanel.GetAttributeList()
    UIRoleTurngrowPanel.GetAttributeList_UIGridContainer().MaxCount = #attributeShowInfoList

    for i = 1, #attributeShowInfoList do

        local go = UIRoleTurngrowPanel.GetAttributeList_UIGridContainer().controlList[i - 1]
        ---@type trungrowAttribute
        local attributeInfo = attributeShowInfoList[i]

        UIRoleTurngrowPanel:SetAttribute(go, attributeInfo.str,
                attributeInfo.curMinValue, attributeInfo.curMaxValue,
                attributeInfo.nextMinValue, attributeInfo.nextMaxValue)
    end

    UIRoleTurngrowPanel.tweenScaleTable = {}
    for i = 0, UIRoleTurngrowPanel.GetAttributeList_UIGridContainer().controlList.Count - 1 do
        local font_TweenScale = UIRoleTurngrowPanel:GetComp(UIRoleTurngrowPanel.GetAttributeList_UIGridContainer().controlList[i].transform, "nextattribute/attack", "CSFontBlink")
        table.insert(UIRoleTurngrowPanel.tweenScaleTable, font_TweenScale)
    end
end

function UIRoleTurngrowPanel:SetExchangeEnergyValue()
    --设置文本描述
    self:SetLevelUpDescribe()
    --消耗修为设置
    --UIRoleTurngrowPanel:SetEnergy()
    --消耗神石设置
    --UIRoleTurngrowPanel:SetGodStone()
    --检查开启按钮特效
    UIRoleTurngrowPanel.CheckOpenEffect()
    --刷新按钮和提示信息
    UIRoleTurngrowPanel:RefreshRoleCanTurnGrow()
end

---对应不同的角色类型设置参数
---@param NowRoleTurnGrowValue 传入的转生属性表
function UIRoleTurngrowPanel:GetRoleTurnGrow(param)
    local careerIndex = Utility.EnumToInt(UIRoleTurngrowPanel.NowRoleCareer)
    careerIndex = careerIndex - 1 < 0 and 0 or careerIndex - 1
    if param.list.Count == 0 or param.list[careerIndex].list.Count < 2 then
        return 0
    end
    return param.list[careerIndex].list[1]
end

---判断是否开启按钮特效
function UIRoleTurngrowPanel.CheckOpenEffect()
    gameMgr:GetPlayerDataMgr():GetReinDataManager():RefreshReinRedPoint()
    local canUp = gameMgr:GetPlayerDataMgr():GetReinDataManager():IsShowReinRedPoint()
    luaclass.UIRefresh:RefreshActive(UIRoleTurngrowPanel.GetTurnGrowBtnEffect_GameObject(), canUp)
end

function UIRoleTurngrowPanel:SetLevelUpDescribe()
    if (self.NextRoleTurnGrowValue ~= nil) then
        if (self.NextRoleTurnGrowValue.reincarnation == 0) then
            ---处于小阶段
            self:GetTurnGrowDescribe_UILabel().text = "突破"
            self:GetLevelUpDescribe_Label().text = "突破" .. self:GetEightDoorName(self.NowRoleTurnGrowValueTable:GetEightDoor() + 1) .. "效果"
            self:GetLevelUpCondition_Label().text = "突破" .. self:GetEightDoorName(self.NowRoleTurnGrowValueTable:GetEightDoor() + 1) .. "条件"
        else
            local isKill = UIRoleTurngrowPanel:IsKillMonster()
            if isKill == true then
                self:GetTurnGrowDescribe_UILabel().text = "转生"
            elseif isKill == false then
                self:GetTurnGrowDescribe_UILabel().text = "前往击杀"
            elseif isKill == nil then

            end
            self:GetLevelUpDescribe_Label().text = "升级" .. CS.Utility_Lua.ArabicNumeralsToWordNumbers(CS.CSScene.MainPlayerInfo.ReinLevel + 1) .. "转属性"
            self:GetLevelUpCondition_Label().text = "升级" .. CS.Utility_Lua.ArabicNumeralsToWordNumbers(CS.CSScene.MainPlayerInfo.ReinLevel + 1) .. "转条件"
        end
    else
        self:GetLevelUpDescribe_Label().text = "升级属性"
        self:GetLevelUpCondition_Label().text = "升级条件"
    end
end

---设置参数
---@param go 参数设置对象父
---@param LabelName 参数设置对象名字
---@param value 参数
function UIRoleTurngrowPanel:LabelSetValue(go, LabelName, value)
    if go == nil then
        return
    end
    local go_Label = UIRoleTurngrowPanel:GetComp(go, LabelName, "UILabel")
    if go_Label ~= nil then
        local reinLevel = value
        local showInfo = CS.Utility_Lua.ArabicNumeralsToWordNumbers(reinLevel)
        go_Label.text = value == 0 and luaEnumColorType.Gray .. showInfo .. "转" .. '[-]' or showInfo .. "转"
        --go_Label.text = showInfo .. "转"
    end
    UIRoleTurngrowPanel.CheckIsShowFireEffect(value)
end
--endregion

--region 转生面板商店
---设置物品信息
function UIRoleTurngrowPanel:SetItemMsg(Item, ItemInfo, itemCount)
    CS.UIEventListener.Get(Item).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = ItemInfo })
    end

    local item_icon = UIRoleTurngrowPanel:GetComp(Item.transform, "micon", "UISprite")
    local item_count = UIRoleTurngrowPanel:GetComp(Item.transform, "count", "UILabel")
    local item_name = UIRoleTurngrowPanel:GetComp(Item.transform, "name", "UILabel")

    item_icon.spriteName = ItemInfo.icon
    item_name.text = ItemInfo.name
    if itemCount > 1 then
        item_count.text = itemCount
    end
end

---刷新角色转生及提示信息
function UIRoleTurngrowPanel:RefreshRoleCanTurnGrow()
    if CS.CSScene.MainPlayerInfo.Level < UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel then
        --等级不足
        UIRoleTurngrowPanel.GetTurnGrowBtn_Button():SetActive(false)
        UIRoleTurngrowPanel.GetNeedlevel_Label().text = UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel
        UIRoleTurngrowPanel.GetNeedlevel_Label().gameObject:SetActive(true)
        UIRoleTurngrowPanel.GetNeedlevel_TweenPosition():PlayForward()
        UIRoleTurngrowPanel.GetBottom_GameObject():SetActive(false)
        UIRoleTurngrowPanel:GetBottomWidget_Gameobject():SetActive(true)
    elseif CS.CSScene.MainPlayerInfo.ReinLevel == 15 then
        UIRoleTurngrowPanel:RefreshMaxRoleLevel()
        UIRoleTurngrowPanel.GetNeedlevel_Label().gameObject:SetActive(false)
        UIRoleTurngrowPanel.GetNeedlevel_TweenPosition():PlayReverse()
        UIRoleTurngrowPanel.GetBottom_GameObject():SetActive(false)
        UIRoleTurngrowPanel:GetBottomWidget_Gameobject():SetActive(false)
    else
        UIRoleTurngrowPanel.GetTurnGrowBtn_Button():SetActive(true)
        UIRoleTurngrowPanel.GetTips_UILabel().gameObject:SetActive(false)
        UIRoleTurngrowPanel.GetNeedlevel_Label().gameObject:SetActive(false)
        UIRoleTurngrowPanel.GetNeedlevel_TweenPosition():PlayReverse()
        UIRoleTurngrowPanel.GetBottom_GameObject():SetActive(true)
        UIRoleTurngrowPanel:GetBottomWidget_Gameobject():SetActive(false)
    end
end

---角色转生等级已满
function UIRoleTurngrowPanel:RefreshMaxRoleLevel()
    UIRoleTurngrowPanel.GetTips_UILabel().gameObject:SetActive(true)
    --UIRoleTurngrowPanel.GetTips_UILabel().text = "转生等级已满"
    UIRoleTurngrowPanel.GetTurnGrowBtn_Button():SetActive(false)
    if UIRoleTurngrowPanel.GetXiuWei_GameObject() ~= nil then
        UIRoleTurngrowPanel.GetXiuWei_GameObject():SetActive(false)
    end
    if UIRoleTurngrowPanel.GetGodStone_GameObject() ~= nil then
        UIRoleTurngrowPanel.GetGodStone_GameObject():SetActive(false)
    end
    -- UIRoleTurngrowPanel.GetTips_UILabel().transform.localPosition = UIRoleTurngrowPanel.GetTips_UILabel().transform.localPosition + CS.UnityEngine.Vector3.up * 80
    if UIRoleTurngrowPanel.GetGrowLevel_GameObject() ~= nil then
        UIRoleTurngrowPanel.GetGrowLevel_GameObject():SetActive(false)
    end
end

---播放所有属性条动画
function UIRoleTurngrowPanel.TurnGrowFontTweenScale()
    for i = 1, #UIRoleTurngrowPanel.tweenScaleTable do
        UIRoleTurngrowPanel.tweenScaleTable[i]:Play()
    end
end

function UIRoleTurngrowPanel:SetAttribute(attribute, attributeName, nowAttributeMinValue, nowAttributeMaxValue, nextAttributeMinValue, nextAttributeMaxValue)
    local nowAttributeValue = UIRoleTurngrowPanel:GetComp(attribute.transform, "curattribute/attack", "UILabel")
    local nowAttributeName = UIRoleTurngrowPanel:GetComp(attribute.transform, "curattribute/attack/name", "UILabel")
    local arrow = UIRoleTurngrowPanel:GetComp(attribute.transform, "curattribute/attack/arrow", "UISprite")
    local nextAttributeValue = UIRoleTurngrowPanel:GetComp(attribute.transform, "nextattribute/attack", "UILabel")

    nowAttributeName.text = attributeName
    if nextAttributeMinValue ~= nil and nextAttributeMinValue ~= -1 then
        if nowAttributeMaxValue ~= nil then
            nowAttributeValue.text = UIRoleTurngrowPanel.NowAttributeNumbColor .. tostring(nowAttributeMinValue) .. "-" .. tostring(nowAttributeMaxValue)
            local color = UIRoleTurngrowPanel.NextAttributeNumbColor
            if (nextAttributeMinValue == nowAttributeMinValue and nextAttributeMaxValue == nowAttributeMaxValue) then
                color = UIRoleTurngrowPanel.NowAttributeNumbColor
            end
            nextAttributeValue.text = color .. tostring(nextAttributeMinValue) .. "-" .. tostring(nextAttributeMaxValue)
        else
            nowAttributeValue.text = UIRoleTurngrowPanel.NowAttributeNumbColor .. tostring(nowAttributeMinValue)
            local color = UIRoleTurngrowPanel.NextAttributeNumbColor
            if (nextAttributeMinValue == nowAttributeMinValue) then
                color = UIRoleTurngrowPanel.NowAttributeNumbColor
            end
            nextAttributeValue.text = color .. tostring(nextAttributeMinValue)
        end
    else
        nextAttributeValue.text = UIRoleTurngrowPanel.NextAttributeNumbColor .. "已满"
        if nowAttributeMaxValue ~= nil then
            nowAttributeValue.text = UIRoleTurngrowPanel.NowAttributeNumbColor .. tostring(nowAttributeMinValue) .. "-" .. tostring(nowAttributeMaxValue)
        else
            nowAttributeValue.text = UIRoleTurngrowPanel.NowAttributeNumbColor .. tostring(nowAttributeMinValue)
        end
    end

    ---设置箭头图片
    local arrowSpriteName = ternary(nextAttributeMinValue ~= nil and (nextAttributeMinValue > nowAttributeMinValue), "arrow", "arrow3")
    if (arrowSpriteName == "arrow3") then
        arrowSpriteName = ternary(nextAttributeMaxValue ~= nil and (nextAttributeMaxValue > nowAttributeMaxValue), "arrow", "arrow3")
    end
    arrow.spriteName = arrowSpriteName
end
--endregion

--region 特效

--region 设置特效进度

---计算当前总进度 0-1
function UIRoleTurngrowPanel:CalculationWaterValue()
    if UIRoleTurngrowPanel.NowEnergy == nil or UIRoleTurngrowPanel.NowRoleTurnGrowValue == nil or UIRoleTurngrowPanel.NowEnergy == nil or UIRoleTurngrowPanel.needGoldStone == nil then
        UIRoleTurngrowPanel.WaterTargetValue = 0
        return
    elseif CS.CSScene.MainPlayerInfo.ReinLevel == CS.Cfg_ReincarnationManager.Instance.dic.Count - 1 then
        UIRoleTurngrowPanel.WaterTargetValue = 1
        return
    end
    local xiuwei = (UIRoleTurngrowPanel.NowEnergy / UIRoleTurngrowPanel.NowRoleTurnGrowValue.needEnergy) * 0.5
    xiuwei = xiuwei > 0.5 and 0.5 or xiuwei
    local shenshi = (UIRoleTurngrowPanel.NowGlodStone / UIRoleTurngrowPanel.needGoldStone) * 0.5
    shenshi = shenshi > 0.5 and 0.5 or shenshi
    UIRoleTurngrowPanel.WaterTargetValue = xiuwei + shenshi
end

---设置液体特效数值
--materialsNum 0-1
function UIRoleTurngrowPanel:SetWaterValue(materialsNum)
    if UIRoleTurngrowPanel.waterEffect == nil then
        return
    end
    local v2 = CS.UnityEngine.Vector2.zero
    -- 液体shader数值为从大到小 min数值为最大 液体数值为最小 max 数值为最小  液体数值为最大
    local min = 1
    local max = 0
    --TextureOffse 参数
    local str = ''
    local curEffectQueue = UIRoleTurngrowPanel.Top_CSEffectRenderQueue()
    for i = 0, curEffectQueue.matS.Length - 1 do
        if i ~= 4 and i ~= 6 and i ~= 7 and i ~= 8 then
            min = i == 3 and 0.49 or i == 5 and 0.9 or 0.5
            max = i == 3 and -0.01 or i == 5 and 0.55 or 0
            str = i == 3 and "_MainTex" or "_MaskTex"
            v2.y = min - (materialsNum * (min - max))
            curEffectQueue.matS[i]:SetTextureOffset(str, v2)
        end
    end
    UIRoleTurngrowPanel.CurWaterValue = materialsNum
end

function UIRoleTurngrowPanel.IEnumWaterValueChange()
    local value = (UIRoleTurngrowPanel.WaterTargetValue - UIRoleTurngrowPanel.CurWaterValue) / 10
    value = tonumber(string.format("%.1f", value))
    local waterValue = 0
    if math.abs(value) <= 0.01 then
        UIRoleTurngrowPanel:SetWaterValue(UIRoleTurngrowPanel.WaterTargetValue)
    else
        while math.abs(UIRoleTurngrowPanel.CurWaterValue - UIRoleTurngrowPanel.WaterTargetValue) > 0.01 do
            waterValue = UIRoleTurngrowPanel.CurWaterValue + value
            UIRoleTurngrowPanel:SetWaterValue(waterValue)
            coroutine.yield(0.5)
        end
    end
end

---开始协程
function UIRoleTurngrowPanel.StartWaterChangeCoroutine()
    if UIRoleTurngrowPanel.IEnumChangeWaterValue ~= nil then
        StopCoroutine(UIRoleTurngrowPanel.IEnumChangeWaterValue)
        UIRoleTurngrowPanel.IEnumChangeWaterValue = nil
    end
    UIRoleTurngrowPanel.IEnumChangeWaterValue = StartCoroutine(UIRoleTurngrowPanel.IEnumWaterValueChange)
end
--endregion

---显示成功特效
function UIRoleTurngrowPanel.ShowSuccessEffect()
    local parent = UIRoleTurngrowPanel.GetView_Go().transform:Find("turngrowlevel").transform
    UIRoleTurngrowPanel.LoadeEffect(UIRoleTurngrowPanel.successEffect, '700072', parent, function(pool, obj)
        UIRoleTurngrowPanel.successEffectPool = pool
        UIRoleTurngrowPanel.successEffect = obj
    end)
end

---控制按钮特效
function UIRoleTurngrowPanel.ShowBtnEffect(isOpen)
    if isOpen then
        local parent = UIRoleTurngrowPanel:GetTurnGrowBtn_Button().transform:Find('Background')
        if parent == nil or CS.StaticUtility.IsNull(parent) or not parent.gameObject.activeSelf then
            return
        end
        UIRoleTurngrowPanel.LoadeEffect(UIRoleTurngrowPanel.equipGirdEffect, '700040', parent, function(pool, effect)
            UIRoleTurngrowPanel.equipGirdEffect = effect
            UIRoleTurngrowPanel.equipGirdEffectPool = pool
            local lowEffect = UIRoleTurngrowPanel.equipGirdEffect.transform:Find("low")
            for i = 0, lowEffect.childCount - 1 do
                local meshRenderer = lowEffect:GetChild(i):GetComponent("MeshRenderer")
                meshRenderer.materials[0].renderQueue = 3100
            end
            UIRoleTurngrowPanel.equipGirdEffect.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
        end)
    else
        if UIRoleTurngrowPanel.equipGirdEffect ~= nil then
            UIRoleTurngrowPanel.equipGirdEffect.gameObject:SetActive(false)
        end
    end
end

---加载特效
function UIRoleTurngrowPanel.LoadeEffect(obj, effectName, parent, callBack)
    if obj then
        obj:SetActive(false)
        obj:SetActive(true)
        return
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, function(res)
        if res then
            if parent == nil or CS.StaticUtility.IsNull(parent) then
                return
            end
            local objPool = res:GetUIPoolItem()
            if objPool == nil then
                return
            end
            local go = objPool.go
            go.transform.parent = parent
            go.transform.localPosition = CS.UnityEngine.Vector3.zero
            go.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
            go:SetActive(true)
            if callBack ~= nil then
                callBack(objPool, go)
            end
        end
    end
    , CS.ResourceAssistType.UI)
end

UIRoleTurngrowPanel.isShowFireEffect = false
---显示火焰特效
function UIRoleTurngrowPanel.ShowFireEffect()
    if UIRoleTurngrowPanel.isShowFireEffect then
        return
    end
    UIRoleTurngrowPanel.isShowFireEffect = true
    local parent = UIRoleTurngrowPanel.GetView_Go().transform:Find("turngrowlevel"):Find("bg")
    UIRoleTurngrowPanel.LoadeEffect(UIRoleTurngrowPanel.initialEffect, '700272', parent, function(pool, effect)
        UIRoleTurngrowPanel.initialEffect = effect
        UIRoleTurngrowPanel.initialEffectPool = pool
    end)

    local parent = UIRoleTurngrowPanel.GetView_Go().transform:Find("turngrowlevel")--:Find("di")
    UIRoleTurngrowPanel.LoadeEffect(UIRoleTurngrowPanel.initialSmallEffect, '700274', parent, function(pool, effect)
        UIRoleTurngrowPanel.initialSmallEffect = effect
        UIRoleTurngrowPanel.initialSmallEffectPool = pool
    end)
end

--endregion

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
---@param ... string    内容参数
function UIRoleTurngrowPanel.ShowTips(trans, str, id, ...)
    local TipsInfo = {}
    if ... ~= nil and ... ~= '' then
        local isFind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
        if isFind then
            str = string.format(data.content, ...)
            TipsInfo[LuaEnumTipConfigType.Describe] = str
        end
    else
        if str ~= nil or str ~= '' then
            TipsInfo[LuaEnumTipConfigType.Describe] = str
        end
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---校验是否能够转生
function UIRoleTurngrowPanel:CheckIsCanLevelUpReinLevel(go)
    --判断是否符合等级
    if UIRoleTurngrowPanel.NowRoleTurnGrowValue == nil then
        return false
    end
    if CS.CSScene.MainPlayerInfo.Level < UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel then
        UIRoleTurngrowPanel.ShowTips(go.transform, nil, 128, tostring(UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel))
        return false
    end
    if (UIRoleTurngrowPanel.isCanLevelUpReinLevel) then
        return true
    else
        if (UIRoleTurngrowPanel.upConditionsInfo ~= nil and UIRoleTurngrowPanel.upConditionsInfo.conditionInfo ~= nil and #UIRoleTurngrowPanel.upConditionsInfo.conditionInfo > 0) then
            local num = 1
            if (UIRoleTurngrowPanel.upConditionsInfo.conditionInfo[1].conditions ~= nil and (not UIRoleTurngrowPanel.upConditionsInfo.conditionInfo[1].conditions.success)) then
                num = 1
            else
                num = 2
            end
            if (num <= #UIRoleTurngrowPanel.upConditionsInfo.conditionInfo and UIRoleTurngrowPanel.upConditionsInfo.conditionInfo[num] ~= nil) then
                Utility.ShowItemGetWay(UIRoleTurngrowPanel.upConditionsInfo.conditionInfo[num].itemID, UIRoleTurngrowPanel.upConditionsInfo.conditionInfo[num].addObj, LuaEnumWayGetPanelArrowDirType.Down);
            end
        else
            UIRoleTurngrowPanel.ShowTips(go.transform, nil, 6)
        end
        return false
    end
end

---检查转生等级
function UIRoleTurngrowPanel:CheckLevelReq(go)
    if CS.CSScene.MainPlayerInfo.Level < UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel then
        UIRoleTurngrowPanel.ShowTips(go.transform, nil, 128, tostring(UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel))
        return false
    else
        return true
    end
end

---获取当前转生类型
function UIRoleTurngrowPanel:GetRemainType()
    return self.remainType
end

---检查怪物是否击杀
function UIRoleTurngrowPanel:IsKillMonster()
    if (UIRoleTurngrowPanel.NowRoleTurnGrowLevel ~= -1) then
        local reintab = clientTableManager.cfg_reincarnationManager:TryGetValue(UIRoleTurngrowPanel.NowRoleTurnGrowLevel)
        local reinitemlist
        if (reintab ~= nil) then
            if (reintab:GetBoss() ~= nil and reintab:GetBoss().list ~= nil) then
                reinitemlist = reintab:GetBoss().list
                for i = 0, reinitemlist.Count - 1 do
                    local conditionId = reinitemlist[i]
                    local result = Utility.IsMainPlayerMatchCondition(conditionId)
                    if result and result.monsterKill then
                        if result.success == false then
                            return false
                        end
                    end
                end
            end
        end
        return true
    end
end

---读取bossid的global表
function UIRoleTurngrowPanel:GetGlobalTable()
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(23019)
    return Lua_GlobalTABLE
end

---校验是否能够转生
function UIRoleTurngrowPanel.CheckIsUpTurngrowLevel(go)
    local meet = go == nil or UIRoleTurngrowPanel.NowEnergy == nil or UIRoleTurngrowPanel.NowRoleTurnGrowValue == nil or UIRoleTurngrowPanel.NowEnergy == nil
    if meet then
        return false
    end
    --判断是否符合等级
    --if CS.CSScene.MainPlayerInfo.ReinLevel == 0 then
    if CS.CSScene.MainPlayerInfo.Level < UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel then
        UIRoleTurngrowPanel.ShowTips(go.transform, nil, 128, tostring(UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel))
        return false
    end
    --end
    local xiuwei = UIRoleTurngrowPanel.NowEnergy - UIRoleTurngrowPanel.NowRoleTurnGrowValue.needEnergy
    local shenshi = 0
    if (UIRoleTurngrowPanel.needGoldStone ~= nil) then
        shenshi = UIRoleTurngrowPanel.NowGlodStone - UIRoleTurngrowPanel.needGoldStone
    end
    if xiuwei < 0 then
        if (UIRoleTurngrowPanel.NextRoleTurnGrowValue ~= nil and UIRoleTurngrowPanel.NextRoleTurnGrowValue.reincarnation == 0) then
            ---处于小阶段
            UIRoleTurngrowPanel.ShowTips(go.transform, nil, 429, UIRoleTurngrowPanel:GetEightDoorName(UIRoleTurngrowPanel.NowRoleTurnGrowValueTable:GetEightDoor() + 1))
        else
            UIRoleTurngrowPanel.ShowTips(go.transform, nil, 6)
        end
        return false
    elseif shenshi < 0 then
        local isFind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(7)
        if isFind then
            local itemId = UIRoleTurngrowPanel.NowRoleTurnGrowValue.needItem.list[0]
            local itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemId)
            if itemName ~= nil then
                local content = data.content
                content = string.gsub(content, '{}', itemName)
                UIRoleTurngrowPanel.ShowTips(go.transform, content, 7)
            end
        end
        return false
        --elseif CS.CSScene.MainPlayerInfo.Level < UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel then
        --    UIRoleTurngrowPanel.ShowTips(go.transform, nil, 128, tostring(UIRoleTurngrowPanel.NowRoleTurnGrowValue.needLevel))
        --    return false
    elseif CS.CSScene.MainPlayerInfo.ReinLevel == CS.Cfg_ReincarnationManager.Instance.dic.Count - 1 then
        return false
    end
    return true
end

---移动神石
function UIRoleTurngrowPanel.ChangeGodStonePos(isMove)
    if isMove then
        if UIRoleTurngrowPanel.isOrgin then
            UIRoleTurngrowPanel.isOrgin = false
            UIRoleTurngrowPanel.GetGodStone_GameObject().transform.localPosition = UIRoleTurngrowPanel.xiuWeiPos
        end
    else
        if not UIRoleTurngrowPanel.isOrgin then
            UIRoleTurngrowPanel.isOrgin = true
            UIRoleTurngrowPanel.GetGodStone_GameObject().transform.localPosition = UIRoleTurngrowPanel.StonePos
        end
    end
end

function UIRoleTurngrowPanel.CheckIsShowFireEffect(value)
    if value == nil or value == 0 then
        return
    end
    UIRoleTurngrowPanel.ShowFireEffect()
end

--endregion

--region Destroy
function UIRoleTurngrowPanel:OnDestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSendRoleReinInfoMessage, UIRoleTurngrowPanel.OnResSendRoleReinInfoMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRoleExchangeReinResultMessage, UIRoleTurngrowPanel.OnResRoleExchangeReinResultMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResTotalFightValueChangeMessage, UIRoleTurngrowPanel.OnResRoleFightValueChangeMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPlayerAttributeChangeMessage, UIRoleTurngrowPanel.OnResRoleAttributeChangeMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRoleReinSuccess, UIRoleTurngrowPanel.OnResRoleReinSuccessReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIRoleTurngrowPanel.OnResBagChangeMessageReceived)
    if UIRoleTurngrowPanel.IEnumChangeWaterValue ~= nil then
        StopCoroutine(UIRoleTurngrowPanel.IEnumChangeWaterValue)
        UIRoleTurngrowPanel.IEnumChangeWaterValue = nil
    end
    if CS.CSObjectPoolMgr.Instance ~= nil then
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIRoleTurngrowPanel.successEffectPool)
        -- CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIRoleTurngrowPanel.waterEffectPool)
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIRoleTurngrowPanel.equipGirdEffectPool)
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIRoleTurngrowPanel.initialEffectPool)
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UIRoleTurngrowPanel.initialSmallEffectPool)
    end
    uimanager:ClosePanel("UIRefineMasterPanel")
    uimanager:ClosePanel("UIRoleExpExchangePanel")
end

function ondestroy()
    UIRoleTurngrowPanel:OnDestroy()
end
--endregion

--region 对外方法

--endregion

return UIRoleTurngrowPanel