---@class UIServantPanel:UIBase 幻兽面板
local UIServantPanel = {}

--region 局部变量
---@type 元灵界面类型
UIServantPanel.ServantNavType = nil;
UIServantPanel.BranchPanel = {};
UIServantPanel.ServantIndex = -1
UIServantPanel.ServantItemHeadList = {}
---@type UIServantPanel
UIServantPanel.Self = nil
UIServantPanel.PlayerServantInfoList = nil
---当前选中物品信息
UIServantPanel.mCurrentChooseBagItemInfo = nil
---灵兽头像模板
UIServantPanel.mServantHeadTemplate = nil
---灵兽装备模板Base
UIServantPanel.mBaseTemplate = nil
---选择Tag协程
UIServantPanel.mSelectTitleCor = nil
---是否需要刷新灵兽信息
---@type number
UIServantPanel.mNeedRefreshServantInfoStep = nil
---需要刷新灵兽信息Type
---@type number
UIServantPanel.mNeedRefreshServantInfoType = nil
--endregion

--region 属性
--region 节点
function UIServantPanel:GetServantItemHeadList_GridContainer()
    if (self.mServantList == nil) then
        self.mServantList = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou", "GameObject")
    end
    return self.mServantList
end

function UIServantPanel:GetBasePanel_Root()
    if (self.mBasePanel == nil) then
        self.mBasePanel = self:GetCurComp("WidgetRoot/Equip", "GameObject")
    end
    return self.mBasePanel
end

function UIServantPanel:GetLevelPanel_Root()
    if (self.mLevelPanel == nil) then
        self.mLevelPanel = self:GetCurComp("WidgetRoot/Level", "GameObject")
    end
    return self.mLevelPanel
end

function UIServantPanel:GetReinPanel_Root()
    if (self.mReinPanel == nil) then
        self.mReinPanel = self:GetCurComp("WidgetRoot/Rein", "GameObject")
    end
    return self.mReinPanel
end

function UIServantPanel:GetHunJiPanel_Root()
    if self.mHunJIPanel == nil then
        self.mHunJIPanel = self:GetCurComp("WidgetRoot/HunJi", "GameObject")
    end
    return self.mHunJIPanel
end

---@return UIServantBasicPanel
function UIServantPanel:GetCurBranchPanel()
    return UIServantPanel.BranchPanel[UIServantPanel.ServantNavType]
end
--endregion

--region 页签
function UIServantPanel:GetServantTagPanel()
    if (UIServantPanel.mTagPanel == nil) then
        UIServantPanel.mTagPanel = uimanager:GetPanel("UIServantTagPanel")
    end
    return UIServantPanel.mTagPanel
end
function UIServantPanel:GetTabEquip_UIToggle()
    if (self.mTabEquip == nil) then
        if self:GetServantTagPanel() then
            self.mTabEquip = self:GetServantTagPanel():GetEquip_UIToggle()
        end
    end
    return self.mTabEquip
end

function UIServantPanel:GetTabLevel_UIToggle()
    if (self.mTabLevel == nil) then
        if self:GetServantTagPanel() then
            self.mTabLevel = self:GetServantTagPanel():GetLevel_UIToggle()
        end
    end
    return self.mTabLevel
end

function UIServantPanel:GetTabRein_UIToggle()
    if (self.mTabRein == nil) then
        if self:GetServantTagPanel() then
            self.mTabRein = self:GetServantTagPanel():GetRein_UIToggle()
        end
    end
    return self.mTabRein
end

function UIServantPanel:GetTabHunJi_UIToggle()
    if (self.mTabHunJi == nil) then
        if self:GetServantTagPanel() ~= nil then
            self.mTabHunJi = self:GetServantTagPanel():GetHunJi_UIToggle()
        end
    end
    return self.mTabHunJi
end
--endregion

function UIServantPanel:GetEquipOtherBtnParent_GameObject()
    if (self.mEquipOtherBtnParent_GameObject == nil) then
        self.mEquipOtherBtnParent_GameObject = self:GetCurComp("WidgetRoot/Equip/events", "GameObject");
    end
    return self.mEquipOtherBtnParent_GameObject;
end

--region 按钮
function UIServantPanel:GetClose_Btn()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/Main/window/left_main/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

function UIServantPanel:GetCloseAll_Btn()
    if (self.mAllMainCloseBtn == nil) then
        self.mAllMainCloseBtn = self:GetCurComp("WidgetRoot/Main/window/all_main/events2/btn_close", "GameObject")
    end
    return self.mAllMainCloseBtn
end

function UIServantPanel:GetBtnShowAttribute()
    if (self.mShowAttributeBtn == nil) then
        self.mShowAttributeBtn = UIServantPanel:GetCurComp("WidgetRoot/Main/window/left_main/arrow", "GameObject")
    end
    return self.mShowAttributeBtn
end

function UIServantPanel:GetBtnHideAttribute()
    if (self.mHideAttributeBtn == nil) then
        self.mHideAttributeBtn = UIServantPanel:GetCurComp("WidgetRoot/Main/window/all_main/arrow", "GameObject")
    end
    return self.mHideAttributeBtn
end
--endregion

--region 头像
function UIServantPanel:GetHeadIcon1_UIToggle()
    if (self.mHeadIcon1 == nil) then
        self.mHeadIcon1 = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou1", "UIToggle")
    end
    return self.mHeadIcon1
end

function UIServantPanel:GetHeadIcon2_UIToggle()
    if (self.mHeadIcon2 == nil) then
        self.mHeadIcon2 = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou2", "UIToggle")
    end
    return self.mHeadIcon2
end

function UIServantPanel:GetHeadIcon3_UIToggle()
    if (self.mHeadIcon3 == nil) then
        self.mHeadIcon3 = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou3", "UIToggle")
    end
    return self.mHeadIcon3
end
--endregion

--region View
function UIServantPanel:GetNormalBottom_GameObject()
    if (self.mNormalBottom == nil) then
        self.mNormalBottom = UIServantPanel:GetCurComp("WidgetRoot/Main/window/left_main", "GameObject")
    end
    return self.mNormalBottom
end

function UIServantPanel:GetAttributeBottom_GameObject()
    if (self.mAttributeBottom == nil) then
        self.mAttributeBottom = UIServantPanel:GetCurComp("WidgetRoot/Main/window/all_main", "GameObject")
    end
    return self.mAttributeBottom
end
--endregion

--region 其他组件

function UIServantPanel:GetServantHeadRedPointList()
    if (UIServantPanel.mHeadRedPointList == nil) then
        UIServantPanel.mHeadRedPointList = {};
        local firstHeadRed = UIServantPanel:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou1/RedPoint", "UIRedPoint");
        if (firstHeadRed ~= nil) then
            table.insert(UIServantPanel.mHeadRedPointList, firstHeadRed);
        end
        local secondHeadRed = UIServantPanel:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou2/RedPoint", "UIRedPoint");
        if (secondHeadRed ~= nil) then
            table.insert(UIServantPanel.mHeadRedPointList, secondHeadRed);
        end
        local thirdHeadRed = UIServantPanel:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou3/RedPoint", "UIRedPoint");
        if (thirdHeadRed ~= nil) then
            table.insert(UIServantPanel.mHeadRedPointList, thirdHeadRed);
        end
    end
    return UIServantPanel.mHeadRedPointList;
end

---@return UIRedPoint
function UIServantPanel:GetServantPracticeRedPoint()
    if self.mServantPracticeRedPoint == nil then
        self.mServantPracticeRedPoint = self:GetCurComp("WidgetRoot/Level/events/btn_practice/RedPoint", "UIRedPoint")
    end
    return self.mServantPracticeRedPoint
end


--endregion

--endregion

--region 初始化
function UIServantPanel:Init()
    UIServantPanel.Self = self;
    --networkRequest.ReqServantInfo()
    UIServantPanel:ReqRefreshGoodHintParams()
    UIServantPanel.BindMessage()
    UIServantPanel:BindUIEvents()
    UIServantPanel:InitData();
    self:AddLuaRedPointKey()
end

---@param customData{BaseTemplate:table, openServantPanelType:LuaEnumPanelOpenSourceType,showBagItemInfo:bagV2.BagItemInfo,ServantHead:table,topOpenType:number,isCreatedWithTag:boolean}
function UIServantPanel:Show(customData)
    uimanager:ClosePanel("UIServantMainTipsPanel")
    if (customData == nil) then
        customData = {};
    end
    if customData.isCreatedWithTag then
        if uimanager:GetPanel("UIServantTagPanel") == nil then
            uimanager:ClosePanel(self, true)
            return
        end
    end

    if (customData.pos == nil) then
        customData.pos = 0;
    end
    if (customData.IsOpenPracticePanel == nil) then
        customData.IsOpenPracticePanel = false;
    end
    UIServantPanel.IsOpenPracticePanel = customData.IsOpenPracticePanel

    if (customData.IsOpenGatherSoulPanel == nil) then
        customData.IsOpenGatherSoulPanel = false;
    end
    UIServantPanel.SpecialOpen = customData.SpecialOpen
    UIServantPanel.IsOpenGatherSoulPanel = customData.IsOpenGatherSoulPanel

    --region 初始化装备模板
    --默认装备模板
    ---@type UIServantPanel_Base
    UIServantPanel.mBaseTemplate = luaComponentTemplates.UIServantPanel_Base
    --重写装备模板
    if customData.BaseTemplate then
        UIServantPanel.mBaseTemplate = customData.BaseTemplate
    end
    --初始化界面
    UIServantPanel:InitPanel();
    --endregion

    customData.pos = customData.pos < 0 and 0 or customData.pos;
    if (customData.openServantPanelType ~= nil) then
        UIServantPanel.mPanelOpenSourceType = customData.openServantPanelType
    else
        UIServantPanel.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.Other
    end
    if customData.showBagItemInfo then
        UIServantPanel.mCurrentChooseBagItemInfo = customData.showBagItemInfo
    end

    --region 初始化头像模板
    --头像默认模板
    UIServantPanel.mServantHeadTemplate = luaComponentTemplates.UIServantInfoTemplate
    --重写头像模板
    if customData.ServantHead then
        UIServantPanel.mServantHeadTemplate = customData.ServantHead
    end
    --endregion
    if UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByStrengthenPanel then
        self:GetClose_Btn():SetActive(false)
        self:GetBtnShowAttribute():SetActive(false)
    elseif (UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        if (customData.OtherServantList ~= nil) then
            UIServantPanel.OtherServantList = customData.OtherServantList
            UIServantPanel:ShowOtherServantPanel()
            UIServantPanel.TabEquipOnClick()
            UIServantPanel:UpdateOtherHeadList()
            UIServantPanel.ServantIndex = customData.pos
            return
        end
    end
    UIServantPanel.ServantIndex = customData.pos
    UIServantPanel:UpdateHeadList();

    local openType = LuaEnumServantPanelType.BasePanel
    ---没有传参数的时候读红点
    local redPointMgr = CS.CSUIRedPointManager.GetInstance()
    if (redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_EQUIP) or redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_EGG)) then
        openType = LuaEnumServantPanelType.BasePanel
        --elseif (redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_Practice_PUSH)) then
        --    openType = LuaEnumServantPanelType.LevelPanel
        -- UIServantPanel.IsOpenPracticePanel = true
        --elseif (redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_LEVEL)) then
        --    openType = LuaEnumServantPanelType.LevelPanel
        --elseif (redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_REIN) or redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_GatherSoul) or redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_GatherSoul1) or redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_GatherSoul2) or redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_GatherSoul3)) then
        --    openType = LuaEnumServantPanelType.ReinPanel
    elseif (redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_HUNJI_FIRST) or redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_HUNJI_SECOND) or redPointMgr:GetRedPointValue(CS.RedPointKey.SERVANT_HUNJI_THIRD)) then
        openType = LuaEnumServantPanelType.HunJiPanel
        --elseif gameMgr:GetLuaRedPointManager():GetRedPointState(LuaRedPointName.ServantPractice_HM) then
        --    openType = LuaEnumServantPanelType.LevelPanel
        --elseif gameMgr:GetLuaRedPointManager():GetRedPointState(LuaRedPointName.ServantPractice_LX) then
        --    openType = LuaEnumServantPanelType.LevelPanel
        --elseif gameMgr:GetLuaRedPointManager():GetRedPointState(LuaRedPointName.ServantPractice_TC) then
        --    openType = LuaEnumServantPanelType.LevelPanel
    end
    ---传参则打开传参面板
    if customData.topOpenType then
        openType = customData.topOpenType
    end
    UIServantPanel:SwitchServantPanel(openType)
end

function UIServantPanel.BindMessage()
    networkRequest.ReqServantCultivateBegin(0)
    if (UIServantPanel.mPanelOpenSourceType ~= LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIServantPanel.OnResBagChangeMessageReceived)
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantLevelUpMessage, UIServantPanel.ResServantLevelUp)
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterResultMessage, UIServantPanel.ResRefineMasterResult)
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantReinUpMessage, UIServantPanel.ResServantReinUp)
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantHpUpdateMessage, UIServantPanel.RefreshServantHP)
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantExpUpdateMessage, UIServantPanel.OnResServantExpUpdateMessage)
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUseServantEggMessage, UIServantPanel.OnResServantExpUpdateMessage)
        UIServantPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantInfoMessage, UIServantPanel.ResUpdateHead)

        UIServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UIServantPanel.OnMainPanelBagClicked)
        UIServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ResServantInfo, UIServantPanel.ResServantInfoMessage)
        --UIServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantEquipInfoChange, UIServantPanel.ChangeEquip)
        UIServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantEquipChanged, UIServantPanel.ChangeEquip)

        UIServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_ArrowBtnClicked, UIServantPanel.OnBag_ArrowBtnOnClicked)
        UIServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.OuterSetServantPlaceTab, UIServantPanel.OnOuterSetServantPlaceTab)
        ---若被背包打开,则关闭背包时也关闭灵兽界面
        UIServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, function(msgID, panelName)
            if panelName == "UIBagPanel" and (UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByBagPanel or UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByItemInfoPanel) then
                uimanager:ClosePanel("UIServantPanel")
            end
        end)
        UIServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
            ---货币变化事件
            if UIServantPanel.ServantNavType == LuaEnumServantPanelType.ReinPanel and UIServantPanel.BranchPanel ~= nil then
                local panel = UIServantPanel.BranchPanel[LuaEnumServantPanelType.ReinPanel]
                if panel ~= nil and panel.OnResBagChangeMessageReceived ~= nil then
                    panel:OnResBagChangeMessageReceived()
                end
            end
        end)
    end
end

function UIServantPanel:BindUIEvents()
    CS.UIEventListener.Get(UIServantPanel:GetClose_Btn()).onClick = UIServantPanel.OnClickClose_Btn
    CS.UIEventListener.Get(UIServantPanel:GetCloseAll_Btn()).onClick = UIServantPanel.OnClickClose_Btn
    CS.UIEventListener.Get(UIServantPanel:GetBtnShowAttribute()).onClick = UIServantPanel.OnClickBtnShowAttribute
    CS.UIEventListener.Get(UIServantPanel:GetBtnHideAttribute()).onClick = UIServantPanel.OnClickBtnHideAttribute

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Servant_OnClickServantTag, UIServantPanel.OnServantTagClicked)
end

function UIServantPanel:InitData()
    --灵兽等级限制数据
    --UIServantPanel.mShowEquipReinLevel = UIServantPanel.GetNoticeTableData(13)
    UIServantPanel.mShowEquipReinLevel = 0
    --肉身等级限制
    UIServantPanel.mShowBodyLevel = UIServantPanel.GetNoticeTableData(14)
    --转生等级限制
    UIServantPanel.ReinLevelGroup = UIServantPanel.GetGlobalTableData(20233)
    UIServantPanel.ShowReinLevel = tonumber(string.Split(UIServantPanel.ReinLevelGroup, "#")[1])
    UIServantPanel.ClickReinLevel = tonumber(string.Split(UIServantPanel.ReinLevelGroup, "#")[2])
end

function UIServantPanel:ReqRefreshGoodHintParams()
    CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:RefreshHint(CS.CSBagItemHint.BagHintReason.ServantWithoutLevelRefresh)
end

function UIServantPanel:InitPanel()
    ---@type UIServantPanel_Base
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel] = templatemanager.GetNewTemplate(UIServantPanel:GetBasePanel_Root(), UIServantPanel.mBaseTemplate, self)
    ---@type UISelf_Level
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel] = templatemanager.GetNewTemplate(UIServantPanel:GetLevelPanel_Root(), luaComponentTemplates.UIServantPanel_Level, self)
    ---@type UISelf_Rein
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.ReinPanel] = templatemanager.GetNewTemplate(UIServantPanel:GetReinPanel_Root(), luaComponentTemplates.UIServantPanel_Rein, self)
    ---@type UIServantPanel_HunJI
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.HunJiPanel] = templatemanager.GetNewTemplate(UIServantPanel:GetHunJiPanel_Root(), luaComponentTemplates.UIServantPanel_HunJi, self)
end

function UIServantPanel:AddLuaRedPointKey()
    ---绑定红点
    --if not CS.StaticUtility.IsNull(self:GetServantPracticeRedPoint()) then
    --    self:GetServantPracticeRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_HM))
    --    self:GetServantPracticeRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_LX))
    --    self:GetServantPracticeRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ServantPractice_TC))
    --end
end

--endregion

--region 表数据
---获取Help表数据
function UIServantPanel.GetHelpTableData(id)
    local res, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if res then
        return info
    end
    return nil
end

---获取Notice表数据
function UIServantPanel.GetNoticeTableData(id)
    local res2, limit2 = CS.Cfg_NoticeTableManager.Instance.dic:TryGetValue(id)
    if res2 then
        return tonumber(limit2.conceal)
    end
    return nil
end

---获取Global表数据
function UIServantPanel.GetGlobalTableData(id)
    local res2, limit2 = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if res2 then
        return limit2.value
    end
    return nil
end
--endregion

--region Update
function update()
    if UIServantPanel.mNeedRefreshServantInfoStep then
        UIServantPanel:RefreshServantInfo(UIServantPanel.mNeedRefreshServantInfoStep)
        UIServantPanel.mNeedRefreshServantInfoStep = UIServantPanel.mNeedRefreshServantInfoStep - 1
        if UIServantPanel.mNeedRefreshServantInfoStep <= 0 then
            UIServantPanel.mNeedRefreshServantInfoStep = nil
            UIServantPanel.mNeedRefreshServantInfoType = nil
        end
    end
    local branchPanel = UIServantPanel:GetCurBranchPanel()
    if branchPanel ~= nil then
        branchPanel:OnUpdate()
    end
end
--endregion

--region 面板切换
function UIServantPanel.OnServantTagClicked(msgId, data)
    if (data.IsOpenPracticePanel ~= nil and data.IsOpenGatherSoulPanel ~= nil) then
        UIServantPanel:SwitchServantPanel(data.servantPanelType, data.IsOpenPracticePanel, data.IsOpenGatherSoulPanel)
    end
end

function UIServantPanel.OnClickClose_Btn()
    uimanager:ClosePanel("UIServantPanel")
    uimanager:ClosePanel("UIServantTagPanel")
end

function UIServantPanel.TabEquipOnClick()
    UIServantPanel:SwitchServantPanel(LuaEnumServantPanelType.BasePanel)
end

function UIServantPanel.TabLevelOnClick()
    UIServantPanel:SwitchServantPanel(LuaEnumServantPanelType.LevelPanel)
end

function UIServantPanel.TabReinOnClick()
    if (UIServantPanel.SetClickReinLevel()) then
        UIServantPanel:SwitchServantPanel(LuaEnumServantPanelType.ReinPanel)
    else
        UIServantPanel:ShowTips(UIServantPanel:GetTabRein_UIToggle().gameObject, 8)
        return
    end
end

function UIServantPanel:SwitchServantPanel(type, ispractice, isgathersoul)

    if (ispractice ~= nil) then
        UIServantPanel.IsOpenPracticePanel = ispractice
    end
    if (isgathersoul ~= nil) then
        UIServantPanel.IsOpenGatherSoulPanel = isgathersoul
    end
    if (type == UIServantPanel.ServantNavType) then
        if (type == LuaEnumServantPanelType.ReinPanel and UIServantPanel.IsOpenGatherSoulPanel) then
            UIServantPanel:GetCurBranchPanel():ReinGatherSoulBtnOnClick()
        elseif type == LuaEnumServantPanelType.LevelPanel and UIServantPanel.IsOpenPracticePanel then
            UIServantPanel:GetCurBranchPanel():OnClickPracticeBtn()
        end
        return
    end

    --音效
    uimanager:PlayCloseUIAudio(UIServantPanel)

    if (UIServantPanel:GetCurBranchPanel() ~= nil) then
        --刷新真实等级
        UIServantPanel:GetSelectHeadInfo():RefreshLevel()

        UIServantPanel.OnClickBtnHideAttribute(nil)
        UIServantPanel:GetCurBranchPanel():Hide()
    end
    UIServantPanel.ServantNavType = type
    if self:IsHeadNeedAddRedPoint() then
        local redComponentList = UIServantPanel:GetServantHeadRedPointList();
        for k, v in pairs(redComponentList) do
            v:RemoveRedPointKey();
        end
        if (UIServantPanel.ServantNavType == LuaEnumServantPanelType.ReinPanel) then
            for k, v in pairs(redComponentList) do
                v:AddRedPointKey(UIServantPanel:GetServantInfo():GetReinRedPointKeyWithIndex(k))
            end
        elseif (UIServantPanel.ServantNavType == LuaEnumServantPanelType.BasePanel) then
            for k, v in pairs(redComponentList) do
                v:AddRedPointKey(UIServantPanel:GetServantInfo():GetBaseRedPointKeyWithIndex(k))
                v:AddRedPointKey(UIServantPanel:GetServantInfo():GetServantEggRedPointKeyWithIndex(k))
            end
        elseif (UIServantPanel.ServantNavType == LuaEnumServantPanelType.LevelPanel) then
            for k, v in pairs(redComponentList) do
                v:AddRedPointKey(UIServantPanel:GetServantInfo():GetLevelRedPointKeyWithIndex(k))
                local redKey = Utility.GetServantPracticeRedPointType(k)
                v:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redKey))
            end
        elseif (UIServantPanel.ServantNavType == LuaEnumServantPanelType.HunJiPanel) then
            for k, v in pairs(redComponentList) do
                v:AddRedPointKey(UIServantPanel:GetServantInfo():GetHunJiRedPointKeyWithIndex(k))
            end
        end
    end

    ---刷新红点

    if (UIServantPanel:GetCurBranchPanel() ~= nil) then
        UIServantPanel.mSelectTitleCor = StartCoroutine(UIServantPanel.IEnumSelectTitle, type);
    end
end

---判断是否需要添加头像红点
function UIServantPanel:IsHeadNeedAddRedPoint()
    local isOtherServant = UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant
    local isStrength = UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByStrengthenPanel
    if isOtherServant or isStrength then
        return false
    end
    return true
end

function UIServantPanel.IEnumSelectTitle(type)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.1))
    UIServantPanel:GetCurBranchPanel():Show()

    if UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByServantHint then
        UIServantPanel:GetSelectHeadInfo():IconOnClick(LuaEnumPanelOpenSourceType.ByServantHint);
    else
        UIServantPanel:GetSelectHeadInfo():IconOnClick(LuaEnumPanelOpenSourceType.ByServantPanel, type);
    end
    if (type == LuaEnumServantPanelType.BasePanel) then
        if not CS.StaticUtility.IsNull(UIServantPanel:GetTabEquip_UIToggle()) then
            UIServantPanel:GetTabEquip_UIToggle().value = true
        end
    elseif (type == LuaEnumServantPanelType.LevelPanel) then
        if not CS.StaticUtility.IsNull(UIServantPanel:GetTabLevel_UIToggle()) then
            UIServantPanel:GetTabLevel_UIToggle().value = true
        end
    elseif (type == LuaEnumServantPanelType.ReinPanel) then
        if not CS.StaticUtility.IsNull(UIServantPanel:GetTabRein_UIToggle()) then
            UIServantPanel:GetTabRein_UIToggle().value = true
        end
    elseif (type == LuaEnumServantPanelType.HunJiPanel) then
        if not CS.StaticUtility.IsNull(UIServantPanel:GetTabHunJi_UIToggle()) then
            UIServantPanel:GetTabHunJi_UIToggle().value = true
        end
    end
end
--endregion

--region 展开右侧小面板
function UIServantPanel.OnClickBtnShowAttribute(go)
    UIServantPanel:GetNormalBottom_GameObject():SetActive(false)
    UIServantPanel:GetAttributeBottom_GameObject():SetActive(true)
    UIServantPanel.BranchPanel[UIServantPanel.ServantNavType]:ShowFull(true);

    if luaEventManager.HasCallback(LuaCEvent.ServantArrowClicked) then
        luaEventManager.DoCallback(LuaCEvent.ServantArrowClicked, LuaEnumServantEquipType.Show)
    end
end

---隐藏属性
function UIServantPanel.OnClickBtnHideAttribute(go)
    UIServantPanel:GetNormalBottom_GameObject():SetActive(true)
    UIServantPanel:GetAttributeBottom_GameObject():SetActive(false)
    UIServantPanel.BranchPanel[UIServantPanel.ServantNavType]:ShowFull(false);

    if luaEventManager.HasCallback(LuaCEvent.ServantArrowClicked) then
        luaEventManager.DoCallback(LuaCEvent.ServantArrowClicked, LuaEnumServantEquipType.Hide)
    end
end
--endregion

--region 获取灵兽数据
---@return CSServantInfoV2
function UIServantPanel:GetServantInfo()
    if (self.mServantInfo == nil) then
        self.mServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    end
    return self.mServantInfo
end

---@return table<number, servantV2.ServantInfo>
function UIServantPanel:GetServantInfoList()
    return self:GetServantInfo().ServantInfoList
end

function UIServantPanel:GetSelectIndex()
    return self.ServantIndex
end

---@return servantV2.ServantInfo
function UIServantPanel:GetSelectServantInfo()
    if (self.ServantIndex ~= -1) then
        return self:GetTargetServantInfo(self.ServantIndex)
    end
    return nil
end

---@return servantV2.ServantInfo
function UIServantPanel:GetTargetServantInfo(index)
    if (self:GetServantInfoList().Count > index) then
        return self:GetServantInfoList()[index]
    end
    return nil
end

---当前选中的灵兽信息
---@return UIServantInfoTemplate
function UIServantPanel:GetSelectHeadInfo()
    return self:GetTargetHeadInfo(self.ServantIndex)
end

---获取目标index对应的灵兽信息
---@param index number
---@return UIServantInfoTemplate
function UIServantPanel:GetTargetHeadInfo(index)
    return self.ServantItemHeadList[index]
end

function UIServantPanel.OnOuterSetServantPlaceTab(id, data)
    UIServantPanel:SwitchServant(data, true)
end

function UIServantPanel:SwitchServant(index, isOuter)
    UIServantPanel.ServantIndex = index
    if (UIServantPanel.ServantNavType == LuaEnumServantPanelType.LevelPanel) then
        UIServantPanel:GetCurBranchPanel():InitLevelData(UIServantPanel:GetSelectServantInfo(), function(level)
            UIServantPanel:GetSelectHeadInfo():RefreshLevel(level) --customData.IsOpenPracticePanel           
        end)
        if UIServantPanel.IsOpenPracticePanel == true then
            UIServantPanel:GetCurBranchPanel():OnClickPracticeBtn()
        end
    elseif (UIServantPanel.ServantNavType == LuaEnumServantPanelType.ReinPanel) then
        if (UIServantPanel.IsOpenGatherSoulPanel) then
            UIServantPanel:GetCurBranchPanel():ReinGatherSoulBtnOnClick()
        end
    end

    for k, v in pairs(self.ServantItemHeadList) do
        v:HideAllBackGround();
    end
    UIServantPanel:GetCurBranchPanel():RefreshServant(UIServantPanel:GetSelectServantInfo(), UIServantPanel.mPanelOpenSourceType, UIServantPanel.mCurrentChooseBagItemInfo)
    --if (not UIServantPanel:GetSelectHeadInfo().IsUnLock) then
    self:GetHeadIcon1_UIToggle():SwitchSpriteState(index == 0)
    self:GetHeadIcon2_UIToggle():SwitchSpriteState(index == 1)
    self:GetHeadIcon3_UIToggle():SwitchSpriteState(index == 2)
    --end
    if isOuter == nil then
        luaEventManager.DoCallback(LuaCEvent.OnClickSetServantPlaceTab, index)
    end
end
--endregion

--region 刷新面板
function UIServantPanel:ShowOtherServantPanel()
    self:GetBtnShowAttribute():SetActive(false)
end

function UIServantPanel.SetClickReinLevel()
    if UIServantPanel.ClickReinLevel then
        for i = 0, UIServantPanel:GetServantInfo().ServantInfoList.Count - 1 do
            if UIServantPanel:GetServantInfo().ServantInfoList[i].level >= UIServantPanel.ClickReinLevel then
                return true
            end
        end
    end
    return false
end

---换装备
function UIServantPanel.ChangeEquip()
    ---装备改变时候，刷新装备显示
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:UpdateServantEquip()
    ---刷新法宝显示
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:ShowMagicWeapon()
end

---解锁灵兽栏
function UIServantPanel.ResUpdateHead()
    UIServantPanel:UpdateHeadList()
end

function UIServantPanel:UpdateHeadList()
    if (UIServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        return
    end
    --local count = 2
    --if (UIServantPanel.SpecialOpen ~= nil and UIServantPanel.SpecialOpen == true) then
    --    count = 0
    --end
    for i = 0, 2 do
        if (UIServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(i).gameObject ~= nil) then
            if (UIServantPanel.ServantItemHeadList[i] == nil) then
                local go = UIServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(i).gameObject
                UIServantPanel.ServantItemHeadList[i] = templatemanager.GetNewTemplate(go, UIServantPanel.mServantHeadTemplate, self, i, UIServantPanel.mPanelOpenSourceType)
            else
                if (CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count > i) then
                    UIServantPanel.ServantItemHeadList[i].info = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i]
                end
            end
            --判定该灵兽位置是否处于锁定状态
            if (i < self:GetServantInfoList().Count) then
                UIServantPanel.ServantItemHeadList[i].IsUnLock = false
            else
                UIServantPanel.ServantItemHeadList[i].IsUnLock = true
            end
            UIServantPanel.ServantItemHeadList[i]:InitParameters()
            UIServantPanel.ServantItemHeadList[i]:RefreshIcon()
            if UIServantPanel:GetSelectServantInfo() ~= nil then
                if i + 1 == UIServantPanel:GetSelectServantInfo().type then
                    if UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel].levelUpFinish == nil or UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel].levelUpFinish then
                        UIServantPanel.ServantItemHeadList[i]:RefreshLevel()
                    end
                else
                    UIServantPanel.ServantItemHeadList[i]:RefreshLevel()
                end
            else
                UIServantPanel.ServantItemHeadList[i]:RefreshLevel()
            end
        end
    end
    local count = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count
    if (count == 3) then
        UIServantPanel.ServantItemHeadList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-262, 235, 0)
        UIServantPanel.ServantItemHeadList[0]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(76, -256, 700)
        UIServantPanel.ServantItemHeadList[0].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(76, -256, 700)
        UIServantPanel.ServantItemHeadList[0]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(76, -256, 0)
        UIServantPanel.ServantItemHeadList[1].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[1].go.transform.localPosition = CS.UnityEngine.Vector3(-183, 235, 0)
        UIServantPanel.ServantItemHeadList[1]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 700)
        UIServantPanel.ServantItemHeadList[1].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 700)
        UIServantPanel.ServantItemHeadList[1]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 0)
        UIServantPanel.ServantItemHeadList[2].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[2].go.transform.localPosition = CS.UnityEngine.Vector3(-107, 235, 0)
        UIServantPanel.ServantItemHeadList[2]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-78, -256, 700)
        UIServantPanel.ServantItemHeadList[2].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(-78, -256, 700)
        UIServantPanel.ServantItemHeadList[2]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-78, -256, 0)
    elseif (count == 2) then
        UIServantPanel.ServantItemHeadList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-262, 235, 0)
        UIServantPanel.ServantItemHeadList[0]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(76, -256, 700)
        UIServantPanel.ServantItemHeadList[0].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(76, -256, 700)
        UIServantPanel.ServantItemHeadList[0]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(76, -256, 0)
        UIServantPanel.ServantItemHeadList[1].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[1].go.transform.localPosition = CS.UnityEngine.Vector3(-183, 235, 0)
        UIServantPanel.ServantItemHeadList[1]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 700)
        UIServantPanel.ServantItemHeadList[1].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 700)
        UIServantPanel.ServantItemHeadList[1]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 0)
        UIServantPanel.ServantItemHeadList[2].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[2].go.transform.localPosition = CS.UnityEngine.Vector3(-107, 235, 0)
        UIServantPanel.ServantItemHeadList[2]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-78, -256, 700)
        UIServantPanel.ServantItemHeadList[2].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(-78, -256, 700)
        UIServantPanel.ServantItemHeadList[2]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-78, -256, 0)
    elseif (count == 1) then
        UIServantPanel.ServantItemHeadList[0].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-222.5, 235, 0)
        UIServantPanel.ServantItemHeadList[0].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(40, -256, 700)
        UIServantPanel.ServantItemHeadList[0]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(40, -256, 700)
        UIServantPanel.ServantItemHeadList[0]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(40, -256, 0)
        UIServantPanel.ServantItemHeadList[1].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[1].go.transform.localPosition = CS.UnityEngine.Vector3(-143.5, 235, 0)
        UIServantPanel.ServantItemHeadList[1].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(-40, -256, 700)
        UIServantPanel.ServantItemHeadList[1]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-40, -256, 700)
        UIServantPanel.ServantItemHeadList[1]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-40, -256, 0)
        UIServantPanel.ServantItemHeadList[2].go:SetActive(false)
    elseif (count == 0) then
        UIServantPanel.ServantItemHeadList[0].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-183, 235, 0)
        UIServantPanel.ServantItemHeadList[0].ModelBG.transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 700)
        UIServantPanel.ServantItemHeadList[0]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 700)
        UIServantPanel.ServantItemHeadList[0]:GetLock_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-3, -256, 0)
        UIServantPanel.ServantItemHeadList[1].go:SetActive(false)
        UIServantPanel.ServantItemHeadList[2].go:SetActive(false)
    end
end

function UIServantPanel:UpdateOtherHeadList()
    local index = 1
    for i = 0, 2 do
        local go = UIServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(i).gameObject
        go:SetActive(false)
    end

    for i = 0, UIServantPanel.OtherServantList.Count - 1 do
        if (index ~= UIServantPanel.OtherServantList[i].type) then
            index = UIServantPanel.OtherServantList[i].type
        end
        if (UIServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(index - 1).gameObject ~= nil) then
            if (UIServantPanel.ServantItemHeadList[i] == nil) then
                local go = UIServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(index - 1).gameObject
                UIServantPanel.ServantItemHeadList[i] = templatemanager.GetNewTemplate(go, UIServantPanel.mServantHeadTemplate, self, i, UIServantPanel.mPanelOpenSourceType)
            end
        end
        UIServantPanel.ServantItemHeadList[i].IsUnLock = false
        UIServantPanel.ServantItemHeadList[i]:RefreshIcon()
        UIServantPanel.ServantItemHeadList[i]:RefreshLevel()
        index = index + 1
    end
    local count = Utility.GetLuaTableCount(UIServantPanel.ServantItemHeadList)
    if (count == 3) then
        UIServantPanel.ServantItemHeadList[0].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[1].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[2].go:SetActive(true)
        return
    elseif (count == 2) then
        UIServantPanel.ServantItemHeadList[0].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-222.5, 235, 0)
        UIServantPanel.ServantItemHeadList[0]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(40, -256, 0)
        UIServantPanel.ServantItemHeadList[1].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[1].go.transform.localPosition = CS.UnityEngine.Vector3(-143.5, 235, 0)
        UIServantPanel.ServantItemHeadList[1]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-40, -256, 0)
    elseif (count == 1) then
        UIServantPanel.ServantItemHeadList[0].go:SetActive(true)
        UIServantPanel.ServantItemHeadList[0].go.transform.localPosition = CS.UnityEngine.Vector3(-183, 235, 0)
        UIServantPanel.ServantItemHeadList[0]:GetModelBackGround_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, -256, 0)
    end
end
---Tips
function UIServantPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIServantPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIServantPanel:RefreshServantInfo(step)
    if step == 3 then
        for i = 0, self:GetServantInfoList().Count - 1 do
            self.ServantItemHeadList[i].info = self:GetServantInfoList()[i]
            self.ServantItemHeadList[i]:InitParameters()
        end
    end
    if step == 2 then
        if (UIServantPanel.mNeedRefreshServantInfoType ~= nil) then
            UIServantPanel:GetCurBranchPanel():RefreshServant(UIServantPanel:GetTargetServantInfo(UIServantPanel.mNeedRefreshServantInfoType - 1), UIServantPanel.mPanelOpenSourceType, UIServantPanel.mCurrentChooseBagItemInfo)
        else
            if (UIServantPanel.ServantIndex ~= -1) then
                UIServantPanel:GetCurBranchPanel():RefreshServant(UIServantPanel:GetTargetServantInfo(UIServantPanel.ServantIndex), UIServantPanel.mPanelOpenSourceType, UIServantPanel.mCurrentChooseBagItemInfo)
            else
                for i = 0, self:GetServantInfoList().Count - 1 do
                    UIServantPanel:GetCurBranchPanel():RefreshServant(UIServantPanel:GetTargetServantInfo(i), UIServantPanel.mPanelOpenSourceType, UIServantPanel.mCurrentChooseBagItemInfo)
                end
            end
        end

    end
    if step == 1 then
        for i = 0, self:GetServantInfoList().Count - 1 do
            self.ServantItemHeadList[i]:RefreshIcon()
            if (i + 1 == uiStaticParameter.SelectedServantType) then
                self.ServantItemHeadList[i]:SetChooseIcon()
            end
        end
        if (UIServantPanel.mNeedRefreshServantInfoType ~= nil) then
            UIServantPanel:GetTargetHeadInfo(UIServantPanel.mNeedRefreshServantInfoType - 1):RefreshIcon()
            UIServantPanel:GetTargetHeadInfo(UIServantPanel.mNeedRefreshServantInfoType - 1):SetChooseIcon()
        end
    end
end

function UIServantPanel.onResShowEffectInServantHead(id, index)
    if (index ~= nil and UIServantPanel.ServantItemHeadList[index] ~= nil) then
        local go = nil
        go = UIServantPanel.ServantItemHeadList[index]:GetBtnUseLight_GameObject()
        go:SetActive(true)
    end
end

function UIServantPanel.onResHideEffectInServantHead(id, index)
    if (index ~= nil and UIServantPanel.ServantItemHeadList[index] ~= nil) then
        local go = nil
        go = UIServantPanel.ServantItemHeadList[index]:GetBtnUseLight_GameObject()
        go:SetActive(false)
    end
end
--endregion

--region 客户端消息处理
function UIServantPanel.ResServantInfoMessage(id, type)
    if (type ~= nil) then
        UIServantPanel.ServantIndex = type - 1 > 0 and type - 1 or 0
        UIServantPanel.mNeedRefreshServantInfoType = type
    end
    UIServantPanel.mNeedRefreshServantInfoStep = 3
end

---点击主界面背包
function UIServantPanel.OnMainPanelBagClicked()
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant })
end

function UIServantPanel.OnBag_ArrowBtnOnClicked(id, data)
    if (data:GetBagType() == LuaEnumBagType.Recycle) then
        UIServantPanel.OnClickBtnHideAttribute(nil)
    end
end
--endregion

--region 服务器消息处理
---@param LuaTable bagV2.ResBagChange
function UIServantPanel.OnResBagChangeMessageReceived(id, LuaTable, csTabele)
    if LuaTable.itemList == nil or #LuaTable.itemList == 0 or UIServantPanel.ServantNavType ~= LuaEnumServantPanelType.ReinPanel
            or UIServantPanel:GetSelectServantInfo() == nil then
        return
    end
    local res, servantReinInfo = CS.Cfg_HsReinTableManager.Instance.dic:TryGetValue(UIServantPanel:GetSelectServantInfo().reinId + 1)
    if (res) then
        local itemid = servantReinInfo.needStone ~= nil and servantReinInfo.needStone.list[0] or 0
        local itemCount = servantReinInfo.needStone ~= nil and servantReinInfo.needStone.list[1] or 0
        if LuaTable.itemList[1].itemId == itemid then
            UIServantPanel.GetCurBranchPanel():GetReinNeedItem_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid), itemCount)
        end
    end
end

function UIServantPanel.ResRefineMasterResult()
    ---@type UISelf_Level
    local panel = UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel]
    if (panel ~= nil) then
        panel:RefreshPool()
        networkRequest.ReqRefineMasterPanel(2)
        --降级时有经验变化刷新收益所以再次请求
    end
end

function UIServantPanel.ResServantLevelUp(id, data)
    ---@type UISelf_Level
    local panel = UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel]
    if (panel.ServantInfo ~= nil and data.type == panel.ServantInfo.type) then
        UIServantPanel:GetTargetServantInfo(data.type - 1).exp = data.exp
        UIServantPanel.ServantItemHeadList[data.type - 1].info = UIServantPanel:GetTargetServantInfo(data.type - 1)
        UIServantPanel.ServantItemHeadList[data.type - 1].level_UILabel.text = data.level
        panel:RefreshPanelLevelUp(data)
    else
        UIServantPanel:GetTargetServantInfo(data.type - 1).exp = data.exp
        UIServantPanel.ServantItemHeadList[data.type - 1].info = UIServantPanel:GetTargetServantInfo(data.type - 1)
        UIServantPanel.ServantItemHeadList[data.type - 1].level_UILabel.text = data.level
    end
    ---等级改变时候，刷新肉身格子显示
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:ShowBodyEquip()
    ---刷新法宝显示
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:ShowMagicWeapon()
end

function UIServantPanel.ResServantReinUp(id, data)
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.ReinPanel]:RefreshPanelReinUp()
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:SetEquipShow()
end


--region 灵兽血量
function UIServantPanel.RefreshServantHP(id, data)
    for k, v in pairs(UIServantPanel.ServantItemHeadList) do
        if (v.info ~= nil and v.itemId ~= 0 and v.info.type == data.type) then
            v:RefreshServantHP(id, data)
        end
    end
end
--endregion

function UIServantPanel.OnResServantExpUpdateMessage(id, data)
    local panel = UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel]
    if UIServantPanel.ServantNavType == LuaEnumServantPanelType.LevelPanel and panel.ServantInfo ~= nil and data.type == panel.ServantInfo.type or data.type == 0 then
        panel:SetLevelProgress(data)
        panel:RefreshPool()
    end
    --if UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel]:GetLevelExp_UILabel().gameObject.activeSelf then
    --    --UIServantPanel.BranchPanel[LuaEnumServantPanelType.LevelPanel]:GetLevelExp_UILabel().gameObject:SetActive(false)
    --end
end

function UIServantPanel.HideButtons()
    UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:HideButtons();
end
--endregion

--region 转移
function UIServantPanel:SetTransferItemChoose(lid, isChoose)
    self.BranchPanel[LuaEnumServantPanelType.BasePanel]:SetItemChoose(lid, isChoose)
end
--endregion

--region 锻造
function UIServantPanel.SetStrengthItemChoose(lid)
    ---@type UIForgeStrengthPanel_ServantBase
    local template = UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]
    if template then
        template:ChooseBagItemInfo(lid)
    end
end

function UIServantPanel.CloseCurrentChoose()
    ---@type UIForgeStrengthPanel_ServantBase
    local template = UIServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]
    if template and template.CloseChooseEffect then
        template:CloseChooseEffect()
    end
end
--endregion

--region 对外方法
---关闭按钮
function UIServantPanel:ShowOtherButton(isShow)
    UIServantPanel:GetClose_Btn():SetActive(isShow)
    UIServantPanel:GetBtnShowAttribute():SetActive(isShow)
    UIServantPanel:GetEquipOtherBtnParent_GameObject():SetActive(isShow);
end
--endregion

--region onDestroy
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantExpUpdateMessage, UIServantPanel.OnResServantExpUpdateMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUseServantEggMessage, UIServantPanel.OnResServantExpUpdateMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantHpUpdateMessage, UIServantPanel.RefreshServantHP)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantLevelUpMessage, UIServantPanel.ResServantLevelUp)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantReinUpMessage, UIServantPanel.ResServantReinUp)
    --luaEventManager.RemoveCallback(LuaCEvent.Servant_OnClickServantTag, UIServantPanel.OnServantTagClicked);
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, UIServantPanel.OnMainPanelBagClicked)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIServantPanel.OnResBagChangeMessageReceived)
    --luaEventManager.RemoveCallback(LuaCEvent.Bag_ArrowBtnClicked, UIServantPanel.OnBag_ArrowBtnOnClicked)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResServantInfoMessage, UIServantPanel.ResUpdateHead)
    --luaEventManager.RemoveCallback(LuaCEvent.OuterSetServantPlaceTab, UIServantPanel.OnOuterSetServantPlaceTab)
    uiStaticParameter.SelectedServantType = 0
    uimanager:ClosePanel("UIServantTagPanel")
    if (UIServantPanel.mSelectTitleCor ~= nil) then
        StopCoroutine(UIServantPanel.mSelectTitleCor)
        UIServantPanel.mSelectTitleCor = nil
    end
    uimanager:ClosePanel("UIServantGatherSoulPanel")
    uimanager:ClosePanel("UIRefineServantPanel")
end
--endregion

return UIServantPanel