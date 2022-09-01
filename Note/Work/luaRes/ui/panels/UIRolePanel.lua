---角色界面
---@class UIRolePanel:UIBase
local UIRolePanel = {}
UIRolePanel.PanelLayerType = CS.UILayerType.WindowsPlane

--region 局部变量定义
---显示角色信息
UIRolePanel.playerAvatarInfo = nil
---角色界面模型
UIRolePanel.ObservationModel = nil
---刷新装备格子模板
UIRolePanel.mEquipGridTemplate = nil
---刷新装备模板
UIRolePanel.mEquipTemplate = nil
---显示装备信息
UIRolePanel.mEquipInfo = nil
---是否为主角
UIRolePanel.mIsMainPlayer = true
---打开参数
UIRolePanel.OpendataDelta = luaEnumRolePanelType.Base
---角色界面打开来源类型
UIRolePanel.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.Other

UIRolePanel.isShowCloseBtn = true
UIRolePanel.isShowArrowBtn = true

UIRolePanel.IsCanShowMagicWeapone = true
UIRolePanel.IsCanShowSLEquip = true

---@type LuaEquipmentListType 装备列表类型
UIRolePanel.NowSelectEquipListType = LuaEquipmentListType.Base
---@type boolean 当前状态是否为正常套装列表
UIRolePanel.NowEquipListStateIsNormal = true
---@type UIRolePanel_SLSuitPanelTemplate
UIRolePanel.SLSuitPanelTemplate = nil

---@type table<LuaPlayerEquipmentListData>
UIRolePanel.AllSLEquipmentList = nil

---得到主角装备管理器
---@type LuaMainPlayerEquipMgr
function UIRolePanel:GetMainPlayerEquipMgr()
    return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
end

--endregion

--region 组件
---获取模型父节点
function UIRolePanel:GetModelRoot_GameObject()
    if self.mModelRoot == nil then
        self.mModelRoot = self:GetCurComp("WidgetRoot/left/roleModel", "GameObject")
    end
    return self.mModelRoot
end

---外观按钮
function UIRolePanel:GetAppearanceBtn_GameObject()
    if self.mAppearanceBtn_GO == nil then
        self.mAppearanceBtn_GO = self:GetCurComp("WidgetRoot/window/window/all_main/events2/btn_outlook", "GameObject")
    end
    return self.mAppearanceBtn_GO
end

---@return UIRedPoint
function UIRolePanel:GetAppearanceBtnRedPoint()
    if self.mAppearanceBtnRedPoint == nil then
        self.mAppearanceBtnRedPoint = self:GetCurComp("WidgetRoot/window/window/all_main/events2/btn_outlook/redpoint", "UIRedPoint")
    end
    return self.mAppearanceBtnRedPoint
end

---面巾按钮
---@private
---@return UnityEngine.GameObject
function UIRolePanel:GetFaceButton_GameObject()
    if self.mFaceButton_GO == nil then
        self.mFaceButton_GO = self:GetCurComp("WidgetRoot/left/view/equips/equips/face", "GameObject")
    end
    return self.mFaceButton_GO
end

---面巾tips
---@return UnityEngine.GameObject
function UIRolePanel:GetFaceTips_GameObject()
    if self.mFaceTipsGO == nil then
        self.mFaceTipsGO = self:GetCurComp("WidgetRoot/left/view/equips/equips/face/facetips", "GameObject")
    end
    return self.mFaceTipsGO
end

---盾牌(左手武器)
---@private
---@return UnityEngine.GameObject
function UIRolePanel:GetShieldButton_GameObject()
    if self.mShielButton_GO == nil then
        self.mShielButton_GO = self:GetCurComp("WidgetRoot/left/view/equips/equips/shield", "GameObject")
    end
    return self.mShielButton_GO
end

---盾牌tips
---@return UnityEngine.GameObject
function UIRolePanel:GetShieldTips_GameObject()
    if self.mShielTips_GO == nil then
        self.mShielTips_GO = self:GetCurComp("WidgetRoot/left/view/equips/equips/shield/shieldtips", "GameObject")
    end
    return self.mShielTips_GO
end

---斗笠
---@private
---@return UnityEngine.GameObject
function UIRolePanel:GetbambooHatButton_GameObject()
    if self.mbambooButton_GO == nil then
        self.mbambooButton_GO = self:GetCurComp("WidgetRoot/left/view/equips/equips/bambooHat", "GameObject")
    end
    return self.mbambooButton_GO
end

---斗笠tips
---@return UnityEngine.GameObject
function UIRolePanel:GetbambooHatTips_GameObject()
    if self.mbambooHatTipsGO == nil then
        self.mbambooHatTipsGO = self:GetCurComp("WidgetRoot/left/view/equips/equips/bambooHat/hattips", "GameObject")
    end
    return self.mbambooHatTipsGO
end

---名字左侧的排版Table
function UIRolePanel:GetNameLeftTable_Table()
    if self.mNameLeftTable_Table == nil then
        self.mNameLeftTable_Table = self:GetCurComp("WidgetRoot/left/view/nameLeftTable", "Top_UITable")
    end
    return self.mNameLeftTable_Table
end

---名字右侧的排版Table
function UIRolePanel:GetNameRightTable_Table()
    if self.mNameRightTable_Table == nil then
        self.mNameRightTable_Table = self:GetCurComp("WidgetRoot/left/view/nameRightTable", "Top_UITable")
    end
    return self.mNameRightTable_Table
end

---商会标识
---@return UnityEngine.GameObject
function UIRolePanel:GetCommerce_UISprite()
    if self.mCommerce_UISprite == nil then
        self.mCommerce_UISprite = self:GetCurComp("WidgetRoot/left/view/nameLeftTable/commerce", "UISprite")
    end
    return self.mCommerce_UISprite
end

function UIRolePanel:GetVipBtn_GameObject()
    if (self.mVipBtn == nil) then
        self.mVipBtn = self:GetCurComp("WidgetRoot/left/view/nameRightTable/vip", "GameObject")
    end
    return self.mVipBtn
end

function UIRolePanel:GetVipLevel_Sprite()
    if (self.mVipLevelSprite == nil) then
        self.mVipLevelSprite = self:GetCurComp("WidgetRoot/left/view/nameRightTable/vip", "Top_UISprite")
    end
    return self.mVipLevelSprite
end

function UIRolePanel:GetVipLevel_UILabel()
    if (self.mVipLevel == nil) then
        self.mVipLevel = self:GetCurComp("WidgetRoot/left/view/nameRightTable/vip/lv", "Top_UILabel")
    end
    return self.mVipLevel
end
function UIRolePanel:GetSVipLevel_UIFont()
    if (self.mSVipLevelFont == nil) then
        self.mSVipLevelFont = self:GetCurComp("StaticRoot/svipfont", "Top_UILabel")
    end
    return self.mSVipLevelFont
end

---@type UnityEngine.GameObject 法宝装备按钮
function UIRolePanel:GetMagicEquipBtn_GameObject()
    if (self.mMagicEquipBtn_GameObject == nil) then
        self.mMagicEquipBtn_GameObject = self:GetCurComp("WidgetRoot/left/events/btn_artifact", "GameObject")
    end
    return self.mMagicEquipBtn_GameObject
end

function UIRolePanel:GetMagicEquip_RedPoint()
    if (self.mMagicEquip_RedPoint == nil) then
        self.mMagicEquip_RedPoint = self:GetCurComp("WidgetRoot/left/events/btn_artifact/redpoint", "UIRedPoint")
    end
    return self.mMagicEquip_RedPoint
end

---得到正常的装备页签节点
function UIRolePanel:GetNormalEquipsRoot()
    if (self.mGetNormalEquipsRoot == nil) then
        self.mGetNormalEquipsRoot = self:GetCurComp("WidgetRoot/left/view/equips", "GameObject")
    end
    return self.mGetNormalEquipsRoot
end

---得到神力的页签节点面板功能节点
function UIRolePanel:GetSLPageRoot()
    if (self.mGetSLPageRoot == nil) then
        self.mGetSLPageRoot = self:GetCurComp("WidgetRoot/left/view/SLPageRoot", "GameObject")
    end
    return self.mGetSLPageRoot
end

---得到神力的装备页签节点(PS:虽然按照道理来说,人物的装备以及神力的装备在Item模板中应该是一样的但是由于套装可能布局,装备格子数量都不尽相同,所以另起一个模板)
function UIRolePanel:GetSLEquipsRoot()
    if (self.mGetSLEquipsRoot == nil) then
        self.mGetSLEquipsRoot = self:GetCurComp("WidgetRoot/left/view/slequips", "GameObject")
    end
    return self.mGetSLEquipsRoot
end

---得到神力的装备页签切换按钮
function UIRolePanel:GetSLEquipsPageToggle()
    if (self.mGetSLEquipsPageToggle == nil) then
        self.mGetSLEquipsPageToggle = self:GetCurComp("WidgetRoot/left/view/SLPageRoot/slToggle", "GameObject")
    end
    return self.mGetSLEquipsPageToggle
end

function UIRolePanel:GetSLEquipsPageToggleIcon()
    if (self.mGetSLEquipsPageToggleIcon == nil) then
        self.mGetSLEquipsPageToggleIcon = self:GetCurComp("WidgetRoot/left/view/SLPageRoot/slToggle", "Top_UISprite")
    end
    return self.mGetSLEquipsPageToggleIcon
end

---得到神力的装备页签切换按钮的Grid
function UIRolePanel:GetSLSuitPageBtnContainer()
    if (self.mGetSLSuitPageBtnContainer == nil) then
        self.mGetSLSuitPageBtnContainer = self:GetCurComp("WidgetRoot/left/view/SLPageRoot/slSuitContainer", "Top_UIGridContainer")
    end
    return self.mGetSLSuitPageBtnContainer
end

---得到神力的装备页签切换按钮的Grid
function UIRolePanel:GetSLSuitPageBtnContainerPanel()
    if (self.mGetSLSuitPageBtnContainerPanel == nil) then
        self.mGetSLSuitPageBtnContainerPanel = self:GetCurComp("WidgetRoot/left/view/SLPageRoot/slSuitContainer", "Top_UIPanel")
    end
    return self.mGetSLSuitPageBtnContainerPanel
end

---得到神力的装备小按钮的Grid
function UIRolePanel:GetSLSuitActivateSmallContainer()
    if (self.mGetSLSuitActivateSmallContainer == nil) then
        self.mGetSLSuitActivateSmallContainer = self:GetCurComp("WidgetRoot/left/view/SLPageRoot/slSuitActivateSmallContainer", "GameObject")
    end
    return self.mGetSLSuitActivateSmallContainer
end
---得到神力的装备小按钮的Grid的个体模板
function UIRolePanel:GetSLSuitActivateSmallContainerItemTemp()
    if (self.mslSuitActivateSmallContainerItemTemp == nil) then
        self.mslSuitActivateSmallContainerItemTemp = self:GetCurComp("WidgetRoot/left/view/SLPageRoot/slSuitActivateSmallBtnTemp", "GameObject")
    end
    return self.mslSuitActivateSmallContainerItemTemp
end

---官位位置
function UIRolePanel:GetOfficialState_Transform()
    if (self.mOfficialStateTransform == nil) then
        self.mOfficialStateTransform = self:GetCurComp("WidgetRoot/left/view/officialname", "Transform")
    end
    return self.mOfficialStateTransform
end

---官位描述
function UIRolePanel:GetOfficialState_UILabel()
    if (self.mOfficialStateUILabel == nil) then
        self.mOfficialStateUILabel = self:GetCurComp("WidgetRoot/left/view/officialname", "Top_UILabel")
    end
    return self.mOfficialStateUILabel
end

--会员等级图片显示
function UIRolePanel:GetMemberSprite()
    if (self.mMemberSprite == nil) then
        self.mMemberSprite = self:GetCurComp("WidgetRoot/left/view/nameRightTable/member", "Top_UISprite")
    end
    return self.mMemberSprite
end

---获取法阵对象
---@return UnityEngine.GameObject
function UIRolePanel:GetFaZhenEffect_GameObject()
    if self.mFaZhenEffect_GameObject == nil then
        self.mFaZhenEffect_GameObject = self:GetCurComp("WidgetRoot/left/effect", "GameObject")
    end
    return self.mFaZhenEffect_GameObject
end

---法阵特效1
---@return CSUIEffectLoad
function UIRolePanel:GetFaZhenEffect1_EffectLoad()
    if self.mFaZhenEffect1_EffectLoad == nil then
        self.mFaZhenEffect1_EffectLoad = self:GetCurComp("WidgetRoot/left/effect/FaZhenEffect", "CSUIEffectLoad")
    end
    return self.mFaZhenEffect1_EffectLoad
end

---法阵特效2
---@return CSUIEffectLoad
function UIRolePanel:GetFaZhenEffect2_EffectLoad()
    if self.mFaZhenEffect2_EffectLoad == nil then
        self.mFaZhenEffect2_EffectLoad = self:GetCurComp("WidgetRoot/left/effect/FaZhenEffect2", "CSUIEffectLoad")
    end
    return self.mFaZhenEffect2_EffectLoad
end
--endregion

--region 初始化
function UIRolePanel:Init()
    self:InitComponents()
    self:BindMessage()
    self:BindUIEvent()
    ---@type RolePanel_DataDelta
    self.dataDelta = templatemanager.GetNewTemplate(self.right.gameObject, luaComponentTemplates.RolePanel_DataDelta)
    self.dataDelta:Show()
    networkRequest.ReqElementSuitInfo()
    self:InitOtherPanel()
    ---@type boolean 面巾提示正在显示状态
    self.mFaceTipsIsShowing = self:GetFaceTips_GameObject().activeSelf
    ---@type boolean 盾牌提示正在显示状态
    self.mLeftWeaponTipsIsShowing = self:GetShieldButton_GameObject().activeSelf
    ---@type boolean 斗笠提示正在显示状态
    self.mDouLiTipsIsShowing = self:GetbambooHatButton_GameObject().activeSelf
    self:HideFaceTips()
end

---@class RolePanelParam
---@field avatarInfo CSAvaterInfo 模型信息/默认主角模型
---@field equipShowTemplate TemplateBase 装备显示模板/默认主角显示模板
---@field equipItemTemplate TemplateBase 装备格子显示模板/默认主角显示模板
---@field equipInfo TemplateBase 装备信息/其他玩家信息
---@field openSourceType LuaEnumPanelOpenSourceType 角色界面打开来源
---@field isShowCloseBtn boolean  显示关闭按钮 （默认显示）
---@field isShowArrowBtn boolean  显示扩展按钮 （默认显示）
---@field mSLSuitPanelTemplate TemplateBase 神力装备模板

---@param customData RolePanelParam
function UIRolePanel:Show(customData)
    if customData == nil then
        customData = {}
    end
    --设置数据
    self.customData = customData
    if customData ~= nil and customData.monthCard ~= nil then
        self.monthCard = self.customData.monthCard
    end
    if customData == nil or customData.openSourceType == nil then
        local uiBagPanel = uimanager:GetPanel("UIBagPanel");
        if (uiBagPanel ~= nil) then
            self.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.ByBagPanel;
        else
            self.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.Other
        end
    else
        self.mPanelOpenSourceType = customData.openSourceType
    end
    if customData then
        self.isShowCloseBtn = customData.isShowCloseBtn == nil or customData.isShowCloseBtn == true
    else
        self.isShowCloseBtn = true
    end
    if customData and customData.avatarInfo then
        self.isShowArrowBtn = false
        self.mIsMainPlayer = false
        self.playerAvatarInfo = customData.avatarInfo
    else
        self.isShowArrowBtn = (customData == nil or customData.isShowArrowBtn == nil) or customData.isShowArrowBtn == true
        self.mIsMainPlayer = true
        self.playerAvatarInfo = CS.CSScene.MainPlayerInfo
        if self.playerAvatarInfo ~= nil then
            self.monthCard = self.playerAvatarInfo.MonthCardList
        end
    end
    if self.isShowArrowBtn then
        if self.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByRoleHeadPanel
                and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetAppearanceInfo():IsRedPointShouldShow() then
            self.OpendataDelta = luaEnumRolePanelType.DataDelta
        end
    end

    if customData and customData.equipShowTemplate then
        self.mEquipTemplate = customData.equipShowTemplate
    else
        self.mEquipTemplate = luaComponentTemplates.UIRolePanel_EquipTemplate
    end
    if customData and customData.equipItemTemplate then
        self.mEquipGridTemplate = customData.equipItemTemplate
    else
        self.mEquipGridTemplate = luaComponentTemplates.UIRolePanel_GridTemplateBase
    end
    local mSLSuitTemplate = luaComponentTemplates.UIRolePanel_SLSuitPanelTemplate
    if customData and customData.mSLSuitPanelTemplate then
        mSLSuitTemplate = customData.mSLSuitPanelTemplate
    end
    if self.SLSuitPanelTemplate == nil then
        self.SLSuitPanelTemplate = templatemanager.GetNewTemplate(self:GetSLEquipsRoot(), mSLSuitTemplate)
    end
    self.SLSuitPanelTemplate:SetBagMgrData(self:GetBagMgrData())
    --绑定模板
    if CS.StaticUtility.IsNull(self.left) == false then
        ---@type UIRolePanel_EquipTemplate
        self.equipShow = templatemanager.GetNewTemplate(self.left.gameObject, self.mEquipTemplate, self)
        local data = ternary(customData == nil, UIRolePanel.playerAvatarInfo, customData)
        self.equipShow:InitGrid(self.mEquipGridTemplate, customData, self.playerAvatarInfo)
        local officialInfo = gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetOfficialInfo()
        local isActive = officialInfo.emperorTokenValid ~= 0
        self.equipShow:RefreshHuFuGrid(officialInfo.emperorTokenId, isActive, true)
    end
    self:ReCheckComponents()
    --加载模型
    self:LoadModel()
    self:InitBtnState()
    if self.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByRoleHeadPanel or self.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByBagPanel then
        self:ChangeBagPanelToRoleType()
    end
    if customData.CallBack ~= nil then
        customData.CallBack(self)
    end
    --刷新盾牌按钮状态
    self:RefreshLeftWeaponButtonState()
    --刷新斗笠按钮状态
    self:RefreshDouLiButtonState()
    --刷新面巾按钮状态
    self:RefreshFaceButtonState()
    --刷新商会标识
    self:RefreshMonthCardSprite()
    --刷新Vip信息
    --self:RefreshVipInfo()
    --刷新会员图标
    self:RefreshVipLevelIcon()
    --刷新名字右侧的UITable(VIP信息,商会信息,（以后可能会加的奇奇怪怪的东西）,在某种情况下,不会显示,这个时候会进行排序)
    self:RefreshNameRightTable()
    --刷新法宝
    self:RefreshMagicEquip()
    --刷新官位
    self:RefreshOfficialInfo()
    --刷新法阵
    self:RefreshFaZhen()

    --刷新套装相关的页签开关
    self:UpdateSuitPageToggle()
    ---刷新扩展/非扩展状态
    self:RefreshDataDeltaState()
    ---绑定背包打开事件
    if self.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByBagPanel or self.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByRoleHeadPanel then
        self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.OnMainChatPanelBagButtonClickedFunc)
    end
end

---得到背包数据, 其他玩家查看面板的时候,返回nil
function UIRolePanel:GetBagMgrData()
    return gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
end

---@return table<LuaPlayerEquipmentListData>
function UIRolePanel:GetAllSLEquipmentList()
    return self:GetMainPlayerEquipMgr():GetAllSLEquipmentList();
end

function UIRolePanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetVipBtn_GameObject()).onClick = function()
        self:OnVipBtnClick()
    end

    CS.UIEventListener.Get(self:GetMagicEquipBtn_GameObject()).onClick = function(go)
        self:MagicEquipBtnOnClick(go)
    end

    CS.UIEventListener.Get(self.btn_close).onClick = function()
        self:OnClosePanelClick()
    end
    CS.UIEventListener.Get(self.btn_close2).onClick = function()
        self:OnClosePanelClick()
    end
    --点击开启属性面板箭头事件
    CS.UIEventListener.Get(self.leftArrow).onClick = function()
        self:OnRightArrowClick(self:ResRole_ArrowBtnClicked())
        self:RemoveArrowHint(true)
    end
    --点击关闭属性面板箭头事件
    CS.UIEventListener.Get(self.rightArrow).onClick = function()
        self:OnRightArrowClick(self:ResRole_ArrowBtnClicked())
    end
    --点击商会按钮
    CS.UIEventListener.Get(self:GetCommerce_UISprite().gameObject).onClick = function()
        if self.monthCard ~= nil and self.monthCard.Count ~= nil and self.monthCard.Count > 0 then
            uimanager:CreatePanel("UICommercePanel")
        end
    end
    --点击会员图标按钮
    CS.UIEventListener.Get(self:GetMemberSprite().gameObject).onClick = function()
        uimanager:CreatePanel("UIRechargeMemberPanel")
    end
    CS.UIEventListener.Get(self:GetFaZhenEffect_GameObject()).onClick = function()
        self:FaZhenOnClick()
    end
    --角色属性变动事件
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateInfo, function()
        self:OnRoleAttributeChange()
    end)
    --更改角色装备模型
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_ResetMainPlayerPart, function()
        self:ResetMainPlayerPart()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BodyEquipRepairFinish, function()
        self:OnRepairMessageReceived()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_EquipUpdated, function()
        self:OnEquipUpdateEventReceived()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:OnResEquipChangeMessageReceived()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:OnResEquipChangeMessageReceived()
    end);
    self:GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, function()
        self:OnPanelClosed()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairGetRefreshChooseList, function(msgId, type)
        if type == luaEnumRepairType.Role and self.mIsMainPlayer then
            if self:IsFaceButtonShouldBeShown() == false then
                ---面巾不显示的话return
                return
            end
            if self.playerAvatarInfo == nil or self.playerAvatarInfo.EquipInfo == nil or self.playerAvatarInfo.EquipInfo.GetEquipByEquipIndex == nil then
                return
            end
            ---@type bagV2.BagItemInfo
            local faceEquip = self.playerAvatarInfo.EquipInfo:GetEquipByEquipIndex(LuaEnumEquiptype.Face)
            if faceEquip == nil or faceEquip.ItemTABLE == nil or faceEquip.currentLasting == nil or faceEquip.ItemTABLE.maxLasting == nil then
                return
            end
            if faceEquip.currentLasting < faceEquip.ItemTABLE.maxLasting and self.equipShow and self.equipShow.SendChooseList then
                ---耐久度不足,需要自动选中面巾
                self.equipShow.face = faceEquip
                self.equipShow:SendChooseList()
            end
        end
    end)
    --外观按钮点击事件
    CS.UIEventListener.Get(self:GetAppearanceBtn_GameObject()).onClick = function()
        if self and self.go ~= nil then
            local appearancePanel = uimanager:GetPanel("UIAppearancePanel")
            if appearancePanel then
                uimanager:ClosePanel("UIAppearancePanel")
            else
                uimanager:CreatePanel("UIAppearancePanel")
            end
        end
    end    ---外观红点
    if self:GetAppearanceBtnRedPoint() ~= nil and CS.StaticUtility.IsNull(self:GetAppearanceBtnRedPoint()) == false then
        self:GetAppearanceBtnRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.NewAppearance))
    end

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOfficialInfoV2Message, function()
        if self.equipShow then
            local officialInfo = gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetOfficialInfo()
            local isActive = officialInfo.emperorTokenValid ~= 0
            self.equipShow:RefreshHuFuGrid(officialInfo.emperorTokenId, isActive, true)
        end
    end)

    ---仙装/魂装改变刷新面板
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mInlaySingleDataChange, function(msgId, type)
        self:RefreshPanel()
    end)
end

function UIRolePanel:InitOtherPanel()
    self:ShowClickArrowHint()
    self:BindLuaRedPoint()
end

function UIRolePanel:BindMessage()
    self.OnRoleAttributeChangeFunc = function(id, data)
        self:OnRoleAttributeChange(id, data)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerAttributeChangeMessage, self.OnRoleAttributeChangeFunc)
    self.OnResEquipChangeMessageReceivedFunc = function(id, data)
        self:OnResEquipChangeMessageReceived(id, data)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEquipChangeMessage, self.OnResEquipChangeMessageReceivedFunc)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResIntensifyMessage, self.OnResEquipChangeMessageReceivedFunc)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGodFurnaceUpGradeMessage, self.OnResEquipChangeMessageReceivedFunc)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpgradeSoulJadeMessage, self.OnResEquipChangeMessageReceivedFunc)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ReslampUpgradeResMessage, self.OnResEquipChangeMessageReceivedFunc)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mInlaySingleDataChange, function(msgId, type)
        CS.CSListUpdateMgr.Add(100, nil, function()
            self:RefreshPanel()
        end, false)
    end)
    self.OnBag_ArrowBtnOnClickedFunc = function(id, data)
        self:OnBag_ArrowBtnOnClicked(id, data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_ArrowBtnClicked, self.OnBag_ArrowBtnOnClickedFunc)
    self.OnRepairChooseListChangeFunc = function(id, data)
        self:OnRepairChooseListChange(id, data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairChooseListChange, self.OnRepairChooseListChangeFunc)
    self.OnSignet_SelectEquipShowFunc = function(id, data)
        self:OnSignet_SelectEquipShow(id, data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Signet_SelectEquipShow, self.OnSignet_SelectEquipShowFunc)
    self.OnSignet_SelectOneItemInfoFunc = function(id, data)
        self:OnSignet_SelectOneItemInfo(id, data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Signet_SelectOneItemInfo, self.OnSignet_SelectOneItemInfoFunc)
    self.OnSignet_SelectAllItemInfoFunc = function(id, data)
        self:OnSignet_SelectAllItemInfo(id, data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Signet_SelectAllItemInfo, self.OnSignet_SelectAllItemInfoFunc)
    self.OnDropBagItemOnRolePanelFunc = function(id, data)
        self:OnDropBagItemOnRolePanel(id, data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_DropBagItemOnRolePanel, self.OnDropBagItemOnRolePanelFunc)
    self.OnMainChatPanelBagButtonClickedFunc = function(id, data)
        self:OnMainChatPanelBagButtonClicked(id, data)
    end
    self.OnResAppellationChangeMessageReceivedFunc = function(id, data)
        self:OnResAppellationChangeMessageReceived(id, data)
    end
    if self.mIsMainPlayer then
        self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetHasAppellationMessage, self.OnResAppellationChangeMessageReceivedFunc)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.UnionNameChange, function()
        self.equipShow:RefreshUnionName()
    end)
    if (self:GetSLEquipsPageToggle() ~= nil) then
        CS.UIEventListener.Get(self:GetSLEquipsPageToggle()).onClick = function(go)
            if luaEventManager.HasCallback(LuaCEvent.ChangeRoleDivineState) then
                luaEventManager.DoCallback(LuaCEvent.ChangeRoleDivineState)
            else
                self:OnClickSLEquipsPageToggle()
            end
        end
    end
end

function UIRolePanel:InitComponents()
    self.left = self:GetCurComp("WidgetRoot/left", "Transform")
    self.btn_close = self:GetCurComp("WidgetRoot/window/window/left_main/events/btn_close", "GameObject")
    self.btn_close2 = self:GetCurComp("WidgetRoot/window/window/all_main/events2/btn_close", "GameObject")
    self.window = self:GetCurComp("WidgetRoot/window/window", "GameObject")
    self.right = self:GetCurComp("WidgetRoot/right", "GameObject")
    self.leftBackGround = self:GetCurComp("WidgetRoot/window/window/left_main", "GameObject")
    self.rightBackGround = self:GetCurComp("WidgetRoot/window/window/all_main", "GameObject")
    self.leftArrow = self:GetCurComp("WidgetRoot/window/window/left_main/arrow", "GameObject")
    self.rightArrow = self:GetCurComp("WidgetRoot/window/window/all_main/arrow", "GameObject")

    --self.leftArrow.transform.localPosition = CS.UnityEngine.Vector3.up*1000
    --self.rightArrow.transform.localPosition=CS.UnityEngine.Vector3.up*1000
    self.SLSuitPanelTemplate = templatemanager.GetNewTemplate(self:GetSLEquipsRoot(), self:GetSLSuitPanelTemplate(), self)
    self.SLSuitPanelTemplate:SetBagMgrData(self:GetBagMgrData())
end

---得到神力面板的模板
---@param customData RolePanelParam
function UIRolePanel:GetSLSuitPanelTemplate(customData)
    if (customData == nil) then
        return luaComponentTemplates.UIRolePanel_SLSuitPanelTemplate
    elseif customData.mSLSuitPanelTemplate then
        return customData.mSLSuitPanelTemplate
    else
        return luaComponentTemplates.UIRolePanel_SLSuitPanelTemplate
    end
end

function UIRolePanel:ReCheckComponents()
    if true then
        self:GetAppearanceBtn_GameObject():SetActive(false)
        return
    end
    if self:GetAppearanceBtn_GameObject() and CS.StaticUtility.IsNull(self:GetAppearanceBtn_GameObject()) == false then
        if self.mIsMainPlayer and CS.CSScene.MainPlayerInfo ~= nil and
                ((CS.CSScene.MainPlayerInfo.Appearance.AppearanceData ~= nil and CS.CSScene.MainPlayerInfo.Appearance.AppearanceData.IsOnceHoldAnyFashion) or
                        (CS.CSScene.MainPlayerInfo.TitleInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList.Count > 0)) and
                not CS.CSScene.MainPlayerInfo.IsSpy then
            self:GetAppearanceBtn_GameObject():SetActive(true)
        else
            self:GetAppearanceBtn_GameObject():SetActive(false)
        end
    end
end

function update()
    UIRolePanel:Update()
end

function UIRolePanel:Update()
    if (self.equipShow ~= nil and self.equipShow.Update ~= nil) then
        self.equipShow:Update();
    end
    if self.delayRefreshLinks ~= nil then
        if self.delayRefreshLinks > 0 then
            self.delayRefreshLinks = self.delayRefreshLinks - 1
        else
            self:RefreshLinks()
            self.delayRefreshLinks = nil
        end
    end
end

function UIRolePanel:BindLuaRedPoint()
    local magicEquip_AllKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MagicEquip_All);
    self:GetMagicEquip_RedPoint():AddRedPointKey(magicEquip_AllKey)
end

--endregion

--region 客户端消息回调
---玩家模型装备改变
function UIRolePanel:ResetMainPlayerPart(uiEventID, data)
    self:LoadModel()
end

---角色属性改变
function UIRolePanel:OnRoleAttributeChange()
    StartCoroutine(self.dataDelta.RefreshAttribute,self.dataDelta)
end

---装备改变事件
function UIRolePanel:OnEquipUpdateEventReceived()
    self:RefreshPanel()
    self:RefreshFaceButtonState()
    self:RefreshLeftWeaponButtonState()
    self:RefreshDouLiButtonState()
end

---点击背包界面箭头按钮
function UIRolePanel:OnBag_ArrowBtnOnClicked(id, data)
    if data ~= nil then
        if data:GetBagType() == LuaEnumBagType.Recycle or data:GetBagType() == LuaEnumBagType.Smelt then
            if self.OpendataDelta == luaEnumRolePanelType.DataDelta then
                self:OnRightArrowClick(nil)
            end
        end
    end
end

---主界面聊天的背包按钮点击事件
function UIRolePanel:OnMainChatPanelBagButtonClicked()
    if self.mPanelOpenSourceType ~= LuaEnumPanelOpenSourceType.Other then
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Role })
    end
end

---界面关闭事件
function UIRolePanel:OnPanelClosed(msgID, closedPanelName)
    if closedPanelName == "UIBagPanel" then
        if self.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByBagPanel then
            uimanager:ClosePanel("UIRolePanel")
        end
    end
end
--endregion

--region 网络消息回调
---装备改变消息
function UIRolePanel:OnResEquipChangeMessageReceived(id, buffer)
    self:RefreshPanel()
    self:UpdateSuitPageToggle()
    self:UpdateSLPageGrid()
end
--endregion

--region 加载模型
---试穿的模型数据
---@type {model, weapon, hair}
UIRolePanel.FittingModelData = nil

function UIRolePanel:LoadModel()
    if self.playerAvatarInfo then
        if (self.FittingModelData == nil) then
            self:LoadTargetModel(self.playerAvatarInfo.Sex, self.playerAvatarInfo.Career, self.playerAvatarInfo:GetBodyModelID(),
                    self.playerAvatarInfo:GetWeaponModelID(),
                    self.playerAvatarInfo:GetHairModelID(),
                    self.playerAvatarInfo:GetFaceModelID(),
                    self.playerAvatarInfo:GetShowDouLiModelID(),
                    self.playerAvatarInfo:GetShowLeftWeaponModelID())
        else
            self:LoadTargetModel(self.playerAvatarInfo.Sex, self.playerAvatarInfo.Career, self.FittingModelData.model,
                    self.FittingModelData.weapon,
                    self.FittingModelData.hair,
                    self.playerAvatarInfo:GetFaceModelID(),
                    self.playerAvatarInfo:GetShowDouLiModelID(),
                    self.playerAvatarInfo:GetShowLeftWeaponModelID())
        end
    end
end

function UIRolePanel:LoadTargetModel(sex, career, model, weapon, hair, face, douLi, leftweapon)
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    local ModelEffectMountItemList = {}
    --if CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEffectId() ~= 0 then
    --    table.insert(ModelEffectMountItemList, CS.ModelEffectMountItem(CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEffectId(), 1, Utility.EnumToInt(CS.ModelStructure.Weapon), CS.ResourceType.UIEffect))
    --end
    local isModelChanged = false
    if not CS.StaticUtility.IsNull(self:GetModelRoot_GameObject()) then
        isModelChanged = self.ObservationModel:CreateRoleModel(sex, career, model,
                weapon, hair, face, ModelEffectMountItemList, self:GetModelRoot_GameObject().transform, douLi, leftweapon)
    end
    if isModelChanged then
        local localPosition_x = -159
        if Utility.EnumToInt(self.playerAvatarInfo.Sex) == LuaEnumSex.WoMan then
            localPosition_x = -154
        end
        self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(localPosition_x, -134, 400))
        self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
        self.ObservationModel:SetScaleSize(CS.UnityEngine.Vector3(180, 180, 180))
        self.ObservationModel:SetDragRoot(self:GetModelRoot_GameObject())
    end
end
--endregion

--region 对外方法
function UIRolePanel:RefreshPanel()
    if self.equipShow then
        self.equipShow:RefreshGrid()
        --UIRolePanel.equipShow:RefreshSlots()
    end
end

function UIRolePanel:InitBtnState()
    self.leftArrow:SetActive(self.isShowArrowBtn)
    self.rightArrow:SetActive(self.isShowArrowBtn)
    self.btn_close:SetActive(self.isShowCloseBtn)
    self.btn_close2:SetActive(self.isShowCloseBtn)
end

---点击某格子(bagItemInfo)
function UIRolePanel:SetItemChoose(bagItemInfo)
    if bagItemInfo and bagItemInfo.index then
        self:SelectItemByEquipIndex(bagItemInfo.index)
    end
end

---根据装备位选中物品(equipIndex)
function UIRolePanel:SelectItemByEquipIndex(equipIndex)
    if (self.equipShow ~= nil) then
        self.equipShow:SetItemChoose(equipIndex)
    end
end

---隐藏当前选中物品
function UIRolePanel:HideCurrentChooseItem()
    if (self.equipShow ~= nil) then
        self.equipShow:HideCurrentChooseItem()
    end
end

---设置关闭按钮显示
function UIRolePanel:ShowCloseButton(isShow)
    --self.leftArrow:SetActive(isShow)
    self.btn_close:SetActive(isShow)
    self.IsCanShowMagicWeapone = isShow
    self:UpdateSuitPageToggle()
    self:RefreshMagicEquip()
end
--endregion

function UIRolePanel:RefreshDataDeltaState()
    if self.OpendataDelta == luaEnumRolePanelType.Base then
        self.leftBackGround:SetActive(true)
        self.rightBackGround:SetActive(false)
        self.right:SetActive(false)
    elseif self.OpendataDelta == luaEnumRolePanelType.DataDelta then
        self.leftBackGround:SetActive(false)
        self.rightBackGround:SetActive(true)
        self.right:SetActive(true)
    end
end

--region UI事件
---打开VIP面板
function UIRolePanel:OnVipBtnClick()
    uimanager:CreatePanel("UIVipInfoPanel")
end

---关闭界面
function UIRolePanel:OnClosePanelClick()
    uimanager:ClosePanel(self)
end

---箭头点击函数
function UIRolePanel:OnRightArrowClick(action)
    if self.OpendataDelta == luaEnumRolePanelType.Base then
        self.OpendataDelta = luaEnumRolePanelType.DataDelta
    else
        self.OpendataDelta = luaEnumRolePanelType.Base
    end
    self:RefreshDataDeltaState()
    if action ~= nil then
        action()
    end
    self:RefreshLinksImmediately()
end

---发送角色按钮点击事件
function UIRolePanel:ResRole_ArrowBtnClicked()
    if luaEventManager.HasCallback(LuaCEvent.Role_ArrowBtnClicked) then
        luaEventManager.DoCallback(LuaCEvent.Role_ArrowBtnClicked, self)
    end
end
--endregion

--region 拖拽物品事件响应
---将物品拖拽到角色界面响应
---@param msgID number
---@param data {type:LuaEnumDropBagItemOnRolePanelType,position:UnityEngine.Vector3,bagItemInfo:bagV2.BagItemInfo}
function UIRolePanel:OnDropBagItemOnRolePanel(msgID, data)
    if data and CS.StaticUtility.IsNull(self.go) == false and self.go.activeInHierarchy then
        local position = data.position
        local bagItemInfo = data.bagItemInfo
        local type = data.type
        if type == nil or position == nil or bagItemInfo == nil then
            return
        end
        if type == LuaEnumDropBagItemOnRolePanelType.ByBagPanel and CS.Utility_Lua.IsPointInUIRange(position, UIRolePanel.go) then
            CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(bagItemInfo)
            gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():CheckRoleNeedPushTransferItem(bagItemInfo)
        end
    end
end
--endregion

--region 更改背包的类型
---更改背包界面为角色类型背包
function UIRolePanel:ChangeBagPanelToRoleType()
    local bagPanel = uimanager:GetPanel("UIBagPanel")
    if bagPanel then
        bagPanel:Show({ type = LuaEnumBagType.Role })
    end
end
--endregion

--region 维修
---维修信息选择信息改变刷新界面
function UIRolePanel:OnRepairChooseListChange(msgId, lid)
    if self.equipShow.RefreshGridChoose then
        self.equipShow:RefreshGridChoose(lid)
    end
end

---收到维修完成消息
function UIRolePanel:OnRepairMessageReceived()
    self.equipShow:RefreshGrid()
end
--endregion

--region 转移
---设置装备选中状态
function UIRolePanel:ChooseTransferItem(equipIndex, isChoose)
    if self.equipShow.SetItemChoose and equipIndex then
        self.equipShow:SetItemChoose(equipIndex, isChoose)
    end
end
--endregion

--region 锻造
---设置锻造装备选中状态
function UIRolePanel:ChooseStrengthenItem(equipIndex)
    if self.equipShow.FirstChooseItem and equipIndex then
        ---@type UIRolePanel_EquipTemplateStrengthen
        local template = self.equipShow
        template:FirstChooseItem(equipIndex)
    end
end
--endregion

--region 印记
---设置选择信息
function UIRolePanel:OnSignet_SelectEquipShow(id, index)
    self:SelectItemByEquipIndex(index)
    luaEventManager.DoCallback(LuaCEvent.Signet_SelectCompleteBackInfo, index);
end

---设置单个镶嵌icon
function UIRolePanel:OnSignet_SelectOneItemInfo(id, imprint)
    self.equipShow:RefreshGrid(imprint)
end

---设置所有镶嵌icon信息
function UIRolePanel:OnSignet_SelectAllItemInfo()
    self.equipShow:RefreshAll()
end
--endregion

--region 称谓
function UIRolePanel:OnResAppellationChangeMessageReceived()
    self.equipShow:RefreshMarryName()
end
--endregion

--region 提示点击属性气泡
function UIRolePanel:ShowClickArrowHint()
    if self.OpendataDelta == luaEnumRolePanelType.Base then
        self.tipsTemplate = Utility.TryCreateHintTips({ point = self.leftArrow.gameObject, id = 1 })
    end
end

---@param 是否计算数量（超过一定数量，则不提示）
function UIRolePanel:RemoveArrowHint(needCount)
    if needCount == true and self.tipsTemplate ~= nil then
        self.tipsTemplate:addClickNum()
    end
    Utility.RemoveHintTips(self.tipsTemplate)
end
--endregion

--region 面巾按钮
---刷新面巾按钮状态
function UIRolePanel:RefreshFaceButtonState()
    local isFaceBtnShouldShow = self:IsFaceButtonShouldBeShown()
    if self.mFaceBtnShowState == isFaceBtnShouldShow then
        return
    end
    self.mFaceBtnShowState = isFaceBtnShouldShow
    if self.mFaceBtnClickedMethod == nil then
        self.mFaceBtnClickedMethod = function()
            self:OnFaceButtonClicked(self:GetFaceButton_GameObject())
        end
    end
    if isFaceBtnShouldShow then
        self:GetFaceButton_GameObject():SetActive(true)
        CS.UIEventListener.Get(self:GetFaceButton_GameObject()).onClick = self.mFaceBtnClickedMethod
    else
        self:GetFaceButton_GameObject():SetActive(false)
        CS.UIEventListener.Get(self:GetFaceButton_GameObject()).onClick = nil
    end
end

---面巾按钮是否应该显示
---@return boolean
function UIRolePanel:IsFaceButtonShouldBeShown()
    if self.playerAvatarInfo == nil then
        return false
    end
    if self.playerAvatarInfo:GetFaceModelID() == 0 then
        return false
    end
    return true
end

---面巾按钮被点击事件
function UIRolePanel:OnFaceButtonClicked(go)
    self:HideFaceTips()
    if self.playerAvatarInfo ~= nil then
        ---@type bagV2.BagItemInfo
        local equipBagItemInfo = self.playerAvatarInfo.EquipInfo:GetEquipByEquipIndex(LuaEnumEquiptype.Face)
        if equipBagItemInfo ~= nil then
            if self.equipShow:OnFaceEquipClicked(equipBagItemInfo, go) == false then
                uiStaticParameter.UIItemInfoManager:CreatePanel(
                        {
                            bagItemInfo = equipBagItemInfo,
                            showRight = true
                        }
                )
            end
        end
    end
end

---显示面巾提示
---@public
function UIRolePanel:ShowFaceTips()
    if self.mFaceTipsIsShowing == false then
        self.mFaceTipsIsShowing = true
        self:GetFaceTips_GameObject():SetActive(true)
    end
end

---隐藏面巾提示
---@public
function UIRolePanel:HideFaceTips()
    if self.mFaceTipsIsShowing then
        self.mFaceTipsIsShowing = false
        self:GetFaceTips_GameObject():SetActive(false)
    end
end
--endregion

--region 盾牌按钮
---刷新盾牌按钮状态
function UIRolePanel:RefreshLeftWeaponButtonState()
    self:GetShieldButton_GameObject():SetActive(true)
    CS.UIEventListener.Get(self:GetShieldButton_GameObject()).onClick = function()
        self:OnLeftWeaponButtonClicked(self:GetShieldButton_GameObject())
    end
    --local isLeftWeaponBtnShouldShow = self:IsLeftWeaponButtonShouldBeShown()
    --if self.mLeftWeaponBtnShowState == isLeftWeaponBtnShouldShow then
    --    return
    --end
    --self.mLeftWeaponBtnShowState = isLeftWeaponBtnShouldShow
    --if isLeftWeaponBtnShouldShow then
    --    self:GetShieldButton_GameObject():SetActive(true)
    --  CS.UIEventListener.Get(self:GetShieldButton_GameObject()).onClick = function()
    --        self:OnLeftWeaponButtonClicked(self:GetShieldButton_GameObject())
    --    end
    --else
    --    self:GetShieldButton_GameObject():SetActive(false)
    --    CS.UIEventListener.Get(self:GetShieldButton_GameObject()).onClick = nil
    --end
end

---盾牌是否显示
---@return boolean
function UIRolePanel:IsLeftWeaponButtonShouldBeShown()
    if self.playerAvatarInfo == nil then
        return false
    end
    if self.playerAvatarInfo:GetLeftWeaponModelID() == 0 then
        return false
    end
    return true
end

---盾牌按钮被点击事件
function UIRolePanel:OnLeftWeaponButtonClicked(go)
    self:HideLeftWeaponTips()
    if self.playerAvatarInfo ~= nil then
        ---@type bagV2.BagItemInfo
        local equipBagItemInfo = self.playerAvatarInfo.EquipInfo:GetEquipByEquipIndex(LuaEnumEquiptype.LeftWeapon)
        if equipBagItemInfo ~= nil then
            uiStaticParameter.UIItemInfoManager:CreatePanel(
                    {
                        bagItemInfo = equipBagItemInfo,
                        showRight = true
                    }
            )
        end
    end
end

---显示盾牌提示
---@public
function UIRolePanel:ShowLeftWeaponTips()
    self:GetShieldTips_GameObject():SetActive(true)
end

---隐藏盾牌提示
---@public
function UIRolePanel:HideLeftWeaponTips()
    self:GetShieldTips_GameObject():SetActive(false)
end
--endregion

--region 斗笠显示状态
---刷新斗笠按钮状态
function UIRolePanel:RefreshDouLiButtonState()
    self:GetbambooHatButton_GameObject():SetActive(true)
    CS.UIEventListener.Get(self:GetbambooHatButton_GameObject()).onClick = function()
        self:OnDouLiButtonClicked(self:GetbambooHatButton_GameObject())
    end

    --local isDouLiBtnShouldShow = self:IsDouLiButtonShouldBeShown()
    --if self.mDouLiBtnShowState == isDouLiBtnShouldShow then
    --    return
    --end
    --self.mDouLiBtnShowState = isDouLiBtnShouldShow
    --if isDouLiBtnShouldShow then
    --    self:GetbambooHatButton_GameObject():SetActive(true)
    --    CS.UIEventListener.Get(self:GetbambooHatButton_GameObject()).onClick =function()
    --        self:OnDouLiButtonClicked(self:GetbambooHatButton_GameObject())
    --    end
    --else
    --    self:GetbambooHatButton_GameObject():SetActive(false)
    --    CS.UIEventListener.Get(self:GetbambooHatButton_GameObject()).onClick = nil
    --end
end

---斗笠是否显示
---@return boolean
function UIRolePanel:IsDouLiButtonShouldBeShown()
    if self.playerAvatarInfo == nil then
        return false
    end
    if self.playerAvatarInfo:GetDouLiModelID() == 0 then
        return false
    end
    return true
end

---斗笠按钮被点击事件
function UIRolePanel:OnDouLiButtonClicked(go)
    self:HideDouLiTips()
    if self.playerAvatarInfo ~= nil then
        ---@type bagV2.BagItemInfo
        local equipBagItemInfo = self.playerAvatarInfo.EquipInfo:GetEquipByEquipIndex(LuaEnumEquiptype.DouLi)
        if equipBagItemInfo ~= nil then
            uiStaticParameter.UIItemInfoManager:CreatePanel(
                    {
                        bagItemInfo = equipBagItemInfo,
                        showRight = true
                    }
            )
        end
    end
end

---显示斗笠提示
---@public
function UIRolePanel:ShowDouLiTips()
    self:GetbambooHatTips_GameObject():SetActive(true)
end

---隐藏斗笠提示
---@public
function UIRolePanel:HideDouLiTips()
    self:GetbambooHatTips_GameObject():SetActive(false)
end
--endregion

--region 商会标识
---刷新商会标识
function UIRolePanel:RefreshMonthCardSprite()
    if true then
        ---关闭商会标识,私服没有这个功能
        if CS.StaticUtility.IsNull(self:GetCommerce_UISprite()) == false then
            self:GetCommerce_UISprite().gameObject:SetActive(false)
        end
        return
    end
    if self.customData ~= nil then
        if self.monthCard == nil then
            self:GetCommerce_UISprite().gameObject:SetActive(false)
            return
        end
        local monthCardTable = self.monthCard
        if type(monthCardTable) ~= "table" and monthCardTable.Count ~= nil then
            monthCardTable = Utility.ListChangeTable(monthCardTable)
        end
        if CS.StaticUtility.IsNull(self:GetCommerce_UISprite()) == false then
            local haveMonthCard = monthCardTable ~= nil and #monthCardTable > 0
            self:GetCommerce_UISprite().gameObject:SetActive(haveMonthCard)
            if haveMonthCard == true then
                self:GetCommerce_UISprite().spriteName = CS.Cfg_GlobalTableManager.Instance:GetCommerceRolePanelSpriteNameByMonthCardId(monthCardTable[1] - 1)
                --self:GetCommerce_UISprite().spriteName = "Commerce_bq"
            end
        end
    end
end
--endregion

--region Vip信息
---刷新Vip信息
function UIRolePanel:RefreshVipInfo()
    local viplevel = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level()
    if (viplevel >= 13) then
        self:GetVipLevel_UILabel().text = "[d8f6e7]" .. viplevel - 12
        self:GetVipLevel_UILabel().font = self:GetSVipLevel_UIFont().font
    else
        self:GetVipLevel_UILabel().text = viplevel
    end

    self:RefreshVipIcon()
    self:GetVipLevel_UILabel().color = viplevel == 0 and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
    self:GetVipLevel_Sprite().color = viplevel == 0 and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
end

---刷新VIPIcon信息
function UIRolePanel:RefreshVipIcon()
    self:GetVipLevel_Sprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId()[1]
    self:GetVipLevel_Sprite():MakePixelPerfect()
end
--endregion

--region 显示会员等级图标
function UIRolePanel:RefreshVipLevelIcon()
    local memberInfo = gameMgr:GetPlayerDataMgr():GetLuaMemberInfo()--:GetPlayerMemberLevel()
    if memberInfo:GetPlayerMemberLevel() > 0 then
        self:GetMemberSprite().gameObject:SetActive(true)
        local memberData = clientTableManager.cfg_memberManager:TryGetValue(memberInfo:GetPlayerMemberLevel())
        --print("mmeberSPrite == ", memberData:GetSpirit())
        self:GetMemberSprite().spriteName = memberData:GetSpirit()
        self:GetMemberSprite():MakePixelPerfect()
    else
        self:GetMemberSprite().gameObject:SetActive(false)
    end
end
--endregion

--region 名字右侧的排版
---刷新名字右侧的排版
function UIRolePanel:RefreshNameRightTable()
    if (self:GetNameRightTable_Table() ~= nil) then
        self:GetNameRightTable_Table().IsDealy = true;
        self:GetNameRightTable_Table():Reposition();
    end

    if (self:GetNameLeftTable_Table() ~= nil) then
        self:GetNameLeftTable_Table().IsDealy = true;
        self:GetNameLeftTable_Table():Reposition();
    end

    self.delayRefreshLinks = 0
end
--endregion

---刷新官位信息
function UIRolePanel:RefreshOfficialInfo()
    if (CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0) then
        self:GetOfficialState_Transform().localPosition = CS.UnityEngine.Vector3(-156, 263, 0)
    else
        self:GetOfficialState_Transform().localPosition = CS.UnityEngine.Vector3(-156, 238, 0)
    end
    if (gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo() ~= nil and
            gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetCurOfficialTable() ~= nil) then
        self:GetOfficialState_UILabel().gameObject:SetActive(true)
        self:GetOfficialState_UILabel().text = tostring(CS.Utility_Lua.GetItemColorByQualityValue(gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetCurOfficialTable():GetQuality()))
                .. gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetCurOfficialTable():GetName() ..
                gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetCurOfficialTable():GetLastname()
    else
        self:GetOfficialState_UILabel().gameObject:SetActive(false)
    end
end
--region 法宝
---刷新法宝装备按钮显示状态
function UIRolePanel:RefreshMagicEquip()
    --刷新法宝按钮状态
    if CS.StaticUtility.IsNull(self:GetMagicEquipBtn_GameObject()) == false then
        self:GetMagicEquipBtn_GameObject():SetActive(self.IsCanShowMagicWeapone and LuaGlobalTableDeal:IsOpenPlayerMagicEquipBtn(CS.CSScene.MainPlayerInfo.Level, true) and self.NowEquipListStateIsNormal)
    end
end

---法宝按钮点击
function UIRolePanel:MagicEquipBtnOnClick(go, commonData)
    uimanager:CreatePanel("UIRoleArtifactPanel", nil, commonData)
end
--endregion

--region 神力相关

function UIRolePanel:OnClickSLEquipsPageToggle()
    if (self.NowEquipListStateIsNormal == true) then
        self:SwitchSuitPage(LuaEquipmentListType.SLSuit_JIYI)
    else
        self:SwitchSuitPage(LuaEquipmentListType.Base)
        uimanager:ClosePanel("UISLequipLevelPanel")
    end
end

---更新套装相关的开关面板
function UIRolePanel:UpdateSuitPageToggle()
    --if(self.IsCanShowSLEquip == false) then
    --    self:GetSLPageRoot():SetActive(false)
    --    return
    --end
    ---@type table<LuaPlayerEquipmentListData>
    self.AllSLEquipmentList = self:GetAllSLEquipmentList()
    if #self.AllSLEquipmentList > 1 then
        for i = 1, #self.AllSLEquipmentList do
            for j = i + 1, #self.AllSLEquipmentList do
                if self.AllSLEquipmentList[i].EquipmentListType < self.AllSLEquipmentList[j].EquipmentListType then
                    self.AllSLEquipmentList[i], self.AllSLEquipmentList[j] = self.AllSLEquipmentList[j], self.AllSLEquipmentList[i]
                end
            end
        end
    end
    if (self.AllSLEquipmentList ~= nil) then
        if CS.StaticUtility.IsNull(self:GetSLPageRoot()) == false then
            self:GetSLPageRoot():SetActive(#self.AllSLEquipmentList > 0);
        end
        self:UpdateSLActivateSmallGrid()
    end
end

---隐藏神力开关
function UIRolePanel:SetSLToggle(isShow)
    self:GetSLEquipsPageToggle().gameObject:SetActive(isShow)
    self:GetSLSuitActivateSmallContainer().gameObject:SetActive(isShow)
end

---@param type LuaEquipmentListType 装备列表类型
function UIRolePanel:SwitchSuitPage(type)
    if (self.NowSelectEquipListType == type) then
        return
    end
    self.NowSelectEquipListType = type;

    self.NowEquipListStateIsNormal = type == LuaEquipmentListType.Base
    self:RefreshMagicEquip()

    local normal = type == LuaEquipmentListType.Base
    self:GetNormalEquipsRoot():SetActive(normal);
    self:GetSLEquipsRoot():SetActive(normal == false);
    self:GetSLSuitPageBtnContainer().gameObject:SetActive(normal == false);
    if (normal) then
        self.FittingModelData = nil
        self:LoadModel()
        self:GetSLEquipsPageToggleIcon().spriteName = "GodPower_turntable_bg"
    else
        self:UpdateSLPageGrid()
        self:GetSLEquipsPageToggleIcon().spriteName = "GodPower_turntable_bg2"
    end
    luaEventManager.DoCallback(LuaCEvent.RolePanelChangeToDivineEquipState)
end

---神力页签按钮的模板
UIRolePanel.SLSuitPageBtnContainerDic = nil
---更新神力页签格
function UIRolePanel:UpdateSLPageGrid()
    if (self.AllSLEquipmentList == nil or self.NowEquipListStateIsNormal == true) then
        return
    end
    local count = #self.AllSLEquipmentList;
    if (count >= 4) then
        self:GetSLSuitPageBtnContainer().pivot = CS.UIWidget.Pivot.TopLeft;
        self:GetSLSuitPageBtnContainerPanel().gameObject.transform.localPosition = CS.UnityEngine.Vector3(-180, -96);
        self:GetSLSuitPageBtnContainerPanel().clipOffset = CS.UnityEngine.Vector2(180, 0);
    else
        self:GetSLSuitPageBtnContainer().pivot = CS.UIWidget.Pivot.Center;
        self:GetSLSuitPageBtnContainerPanel().gameObject.transform.localPosition = CS.UnityEngine.Vector3(0, -96);
        self:GetSLSuitPageBtnContainerPanel().clipOffset = CS.UnityEngine.Vector2(0, 0);
    end

    self:GetSLSuitPageBtnContainer().MaxCount = count
    if (UIRolePanel.SLSuitPageBtnContainerDic == nil) then
        UIRolePanel.SLSuitPageBtnContainerDic = {}
    end
    local index = 0;
    ---@type UIRolePanel_SLPageBtnTemp
    local selectPageBtnTemp = nil
    ---@type UIRolePanel_SLPageBtnTemp
    local firstPageBtnTemp = nil
    ---循环设置页签按钮
    for i, v in pairs(self.AllSLEquipmentList) do
        local obj = self:GetSLSuitPageBtnContainer().controlList[index];
        ---@type LuaPlayerEquipmentListData
        local item = v
        ---@type UIRolePanel_SLPageBtnTemp
        local temp = self.SLSuitPageBtnContainerDic[obj];
        if (temp == nil) then
            temp = templatemanager.GetNewTemplate(obj, luaComponentTemplates.UIRolePanel_SLPageBtnTemp)
            self.SLSuitPageBtnContainerDic[obj] = temp;
        end
        temp:InitData(self, item)
        local isSelect = item.EquipmentListType == self.NowSelectEquipListType

        temp:BeSelect(isSelect)

        if (firstPageBtnTemp == nil) then
            firstPageBtnTemp = temp;
        end

        --获得到选中的页签,或者
        if (isSelect == true) then
            selectPageBtnTemp = temp
        end
        index = index + 1
    end
    if (selectPageBtnTemp == nil and firstPageBtnTemp ~= nil) then
        selectPageBtnTemp = firstPageBtnTemp;
    end

    if (selectPageBtnTemp ~= nil and selectPageBtnTemp.PlayerEquipmentListData ~= nil) then
        selectPageBtnTemp:BeSelect(true)
        self.NowSelectEquipListType = selectPageBtnTemp.PlayerEquipmentListData.EquipmentListType
        self:UpdateSLModel(selectPageBtnTemp.PlayerEquipmentListData)
        if (self.SLSuitPanelTemplate ~= nil) then
            --更新神力装备的装备面板
            self.SLSuitPanelTemplate:UpdateDate(selectPageBtnTemp.PlayerEquipmentListData, self)
        end
    end
end

---@type LuaPlayerEquipmentListData
function UIRolePanel:UpdateSLModel(data)
    self.FittingModelData = {}
    local weaponData = data:GetEquipItemByBasicIndex(LuaEquipmentItemType.POS_SL_WEAPON)
    if (weaponData ~= nil and weaponData.BagItemInfo ~= nil) then
        self.FittingModelData.weapon = Utility.GetItemTblByBagItemInfo(weaponData.BagItemInfo):GetModel().list[0]
    else
        self.FittingModelData.weapon = 0
    end

    local clothesData = data:GetEquipItemByBasicIndex(LuaEquipmentItemType.POS_SL_CLOTHES)
    if (clothesData ~= nil and clothesData.BagItemInfo ~= nil) then
        self.FittingModelData.model = Utility.GetItemTblByBagItemInfo(clothesData.BagItemInfo):GetModel().list[0]
    else
        self.FittingModelData.model = 0
    end

    local hairData = data:GetEquipItemByBasicIndex(LuaEquipmentItemType.POS_SL_HEAD)
    if (hairData ~= nil and hairData.BagItemInfo ~= nil) then
        self.FittingModelData.hair = Utility.GetItemTblByBagItemInfo(hairData.BagItemInfo):GetModel().list[0]
    else
        self.FittingModelData.hair = 0
    end
    self:LoadModel()
end

function UIRolePanel:UpdateSLActivateSmallGrid()
    if (self.AllSLEquipmentList == nil) then
        return
    end
    if (self.SLActivateSmallGridContainer == nil) then
        ---@type Lua_UICircleGridContainer
        self.SLActivateSmallGridContainer = templatemanager.GetNewTemplate(self:GetSLSuitActivateSmallContainer(), luaComponentTemplates.Lua_UICircleGridContainer)
        self.SLActivateSmallGridContainer:InitControlTemplate(self:GetSLSuitActivateSmallContainerItemTemp())
        local LayItemMaxCount = {}
        table.insert(LayItemMaxCount, 10)
        table.insert(LayItemMaxCount, 20)
        self.SLActivateSmallGridContainer:SetLayItemMaxCount(LayItemMaxCount)

        local LayerWidthList = {}
        table.insert(LayerWidthList, 50)
        table.insert(LayerWidthList, 75)
        self.SLActivateSmallGridContainer:SetLayerWidthList(LayerWidthList)
    end
    self.SLActivateSmallGridContainer:SetMaxCount(#self.AllSLEquipmentList)
    --self.SLActivateSmallGridContainer:SetMaxCount(3)
    local index = 1
    for i, obj in pairs(self.SLActivateSmallGridContainer.ControlList) do
        local icon = CS.Utility_Lua.GetComponent(obj.transform:Find("Icon"), "Top_UISprite");
        if (icon ~= nil) then
            ---@type LuaPlayerEquipmentListData
            local SLEquipmentList = self.AllSLEquipmentList[index]

            local suitActive = false
            if (SLEquipmentList ~= nil and SLEquipmentList.ActivateEquipLevelDic ~= nil) then
                for k, j in pairs(SLEquipmentList.ActivateEquipLevelDic) do
                    if (j ~= nil and j[1] ~= nil and j[1] >= 10) then
                        suitActive = true
                    end
                end
            end

            --if (SLEquipmentList == nil or SLEquipmentList.ActivateEquipLevelDic == nil or SLEquipmentList.ActivateEquipLevelDic[1] == nil or SLEquipmentList.ActivateEquipLevelDic[1] < 10) then
            if (not suitActive) then
                icon.spriteName = "GodPower_smallicon_" .. tostring(SLEquipmentList.EquipmentListType) .. "_1"
            else
                icon.spriteName = "GodPower_smallicon_" .. tostring(SLEquipmentList.EquipmentListType) .. "_2"
            end
        end
        index = index + 1
    end
end

--endregion

--region 界面状态
---@return LuaEquipmentListType 获取当前界面状态
function UIRolePanel:GetCurrentPanelState()
    return self.NowSelectEquipListType
end
--endregion

--region 法阵
---@return LuaZhenFaInfo
function UIRolePanel:GetFaZhenInfo()
    return gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaInfo()
end

---法阵点击
function UIRolePanel:FaZhenOnClick()
    local faZhenInfo = self:GetFaZhenInfo()
    if faZhenInfo == nil then
        return
    end
    local itemInfo = faZhenInfo:GetFaZhenItemInfo()
    if itemInfo == nil then
        return
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
end

---刷新法阵
function UIRolePanel:RefreshFaZhen()
    local faZhenInfo = self:GetFaZhenInfo()
    if faZhenInfo == nil then
        return
    end
    local faZhenEffectList = faZhenInfo:GetFaZhenEffectName()
    if type(faZhenEffectList) ~= 'table' then
        return
    end
    ---@type FaZhenEffectInfo
    local faZhenInfo1 = faZhenEffectList[1]
    if faZhenInfo1 ~= nil and CS.StaticUtility.IsNullOrEmpty(faZhenInfo1.faZhenEffectName) == false then
        luaclass.UIRefresh:RefreshEffect(self:GetFaZhenEffect1_EffectLoad(), faZhenInfo1.faZhenEffectName)
        self:GetFaZhenEffect1_EffectLoad().transform.localPosition = faZhenInfo1.faZhenLocalPosition
        self:GetFaZhenEffect1_EffectLoad().transform.localScale = faZhenInfo1.faZhenScale
    end
    ---@type FaZhenEffectInfo
    local faZhenInfo2 = faZhenEffectList[2]
    if faZhenInfo2 ~= nil and CS.StaticUtility.IsNullOrEmpty(faZhenInfo2.faZhenEffectName) == false then
        luaclass.UIRefresh:RefreshEffect(self:GetFaZhenEffect2_EffectLoad(), faZhenInfo2.faZhenEffectName)
        self:GetFaZhenEffect2_EffectLoad().transform.localPosition = faZhenInfo2.faZhenLocalPosition
        self:GetFaZhenEffect2_EffectLoad().transform.localScale = faZhenInfo2.faZhenScale
    end
end
--endregion

--region onDestroy
function ondestroy()
    UIRolePanel:OnDestroy()
end

function UIRolePanel:OnDestroy()
    self.dataDelta = nil
    self.right = nil
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPlayerAttributeChangeMessage, self.OnRoleAttributeChangeFunc)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResEquipChangeMessage, self.OnResEquipChangeMessageReceivedFunc)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResIntensifyMessage, self.OnResEquipChangeMessageReceivedFunc)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGodFurnaceUpGradeMessage, self.OnResEquipChangeMessageReceivedFunc)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUpgradeSoulJadeMessage, self.OnResEquipChangeMessageReceivedFunc)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ReslampUpgradeResMessage, self.OnResEquipChangeMessageReceivedFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.Bag_ArrowBtnClicked, self.OnBag_ArrowBtnOnClickedFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.RepairChooseListChange, self.OnRepairChooseListChangeFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.Signet_SelectEquipShow, self.OnSignet_SelectEquipShowFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.Signet_SelectOneItemInfo, self.OnSignet_SelectOneItemInfoFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.Signet_SelectAllItemInfo, self.OnSignet_SelectAllItemInfoFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.Role_DropBagItemOnRolePanel, self.OnDropBagItemOnRolePanelFunc)
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, self.OnMainChatPanelBagButtonClickedFunc)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGetHasAppellationMessage, self.OnResAppellationChangeMessageReceivedFunc)
    --清除模型

    local bagPanel = uimanager:GetPanel("UIBagPanel")
    if bagPanel then
        bagPanel:Show({ type = LuaEnumBagType.Normal })
    end
    if self.ObservationModel then
        self.ObservationModel:ClearModel()
    end
    if self.ReleaseClientEventHandler ~= nil then
        self:ReleaseClientEventHandler()
    end
    --uimanager:ClosePanel("UIRolePanelTagPanel");
    self:RemoveArrowHint(false)
    uimanager:ClosePanel("UIVipInfoPanel")
    uimanager:ClosePanel("UIRoleArtifactPanel")
    if self.equipShow then
        self.equipShow:DestroyFunction()
    end
    ---郭帝驿不配表 非得让我写进代码里 QQ：228063307
    uimanager:ClosePanel("UISLequipLevelPanel")
end
--endregion

return UIRolePanel