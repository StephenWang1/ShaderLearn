---@class UIOtherServantPanel:UIBase 幻兽面板
local UIOtherServantPanel = {}

--region 局部变量
---@type 元灵界面类型
UIOtherServantPanel.ServantNavType = nil;
---@type table<元灵界面类型,UIServantBasicPanel>
UIOtherServantPanel.BranchPanel = {};
UIOtherServantPanel.ServantIndex = -1
UIOtherServantPanel.ServantItemHeadList = {}
---@type UIOtherServantPanel
UIOtherServantPanel.Self = nil
UIOtherServantPanel.PlayerServantInfoList = nil
---当前选中物品信息
UIOtherServantPanel.mCurrentChooseBagItemInfo = nil
---灵兽头像模板
UIOtherServantPanel.mServantHeadTemplate = nil
---灵兽装备模板Base
UIOtherServantPanel.mBaseTemplate = nil
---选择Tag协程
UIOtherServantPanel.mSelectTitleCor = nil
---是否需要刷新灵兽信息
---@type number
UIOtherServantPanel.mNeedRefreshServantInfoStep = nil
--endregion

--region 属性
--region 节点
function UIOtherServantPanel:GetServantItemHeadList_GridContainer()
    if (self.mServantList == nil) then
        self.mServantList = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou", "GameObject")
    end
    return self.mServantList
end

function UIOtherServantPanel:GetBasePanel_Root()
    if (self.mBasePanel == nil) then
        self.mBasePanel = self:GetCurComp("WidgetRoot/Equip", "GameObject")
    end
    return self.mBasePanel
end

function UIOtherServantPanel:GetLevelPanel_Root()
    if (self.mLevelPanel == nil) then
        self.mLevelPanel = self:GetCurComp("WidgetRoot/Level", "GameObject")
    end
    return self.mLevelPanel
end

function UIOtherServantPanel:GetReinPanel_Root()
    if (self.mReinPanel == nil) then
        self.mReinPanel = self:GetCurComp("WidgetRoot/Rein", "GameObject")
    end
    return self.mReinPanel
end

function UIOtherServantPanel:GetCurBranchPanel()
    return UIOtherServantPanel.BranchPanel[UIOtherServantPanel.ServantNavType]
end
--endregion

--region 页签
function UIOtherServantPanel:GetServantTagPanel()
    if (UIOtherServantPanel.mTagPanel == nil) then
        UIOtherServantPanel.mTagPanel = uimanager:GetPanel("UIServantTagPanel")
    end
    return UIOtherServantPanel.mTagPanel
end
function UIOtherServantPanel:GetTabEquip_UIToggle()
    if (self.mTabEquip == nil) then
        if self:GetServantTagPanel() then
            self.mTabEquip = self:GetServantTagPanel():GetEquip_UIToggle()
        end
    end
    return self.mTabEquip
end

function UIOtherServantPanel:GetTabLevel_UIToggle()
    if (self.mTabLevel == nil) then
        if self:GetServantTagPanel() then
            self.mTabLevel = self:GetServantTagPanel():GetLevel_UIToggle()
        end
    end
    return self.mTabLevel
end

function UIOtherServantPanel:GetTabRein_UIToggle()
    if (self.mTabRein == nil) then
        if self:GetServantTagPanel() then
            self.mTabRein = self:GetServantTagPanel():GetRein_UIToggle()
        end
    end
    return self.mTabRein
end
--endregion

--region 按钮
function UIOtherServantPanel:GetClose_Btn()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/Main/window/left_main/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

function UIOtherServantPanel:GetCloseAll_Btn()
    if (self.mAllMainCloseBtn == nil) then
        self.mAllMainCloseBtn = self:GetCurComp("WidgetRoot/Main/window/all_main/events2/btn_close", "GameObject")
    end
    return self.mAllMainCloseBtn
end

function UIOtherServantPanel:GetBtnShowAttribute()
    if (self.mShowAttributeBtn == nil) then
        self.mShowAttributeBtn = UIOtherServantPanel:GetCurComp("WidgetRoot/Main/window/left_main/arrow", "GameObject")
    end
    return self.mShowAttributeBtn
end

function UIOtherServantPanel:GetBtnHideAttribute()
    if (self.mHideAttributeBtn == nil) then
        self.mHideAttributeBtn = UIOtherServantPanel:GetCurComp("WidgetRoot/Main/window/all_main/arrow", "GameObject")
    end
    return self.mHideAttributeBtn
end
--endregion

--region 头像
function UIOtherServantPanel:GetHeadIcon1_UIToggle()
    if (self.mHeadIcon1 == nil) then
        self.mHeadIcon1 = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou1", "UIToggle")
    end
    return self.mHeadIcon1
end

function UIOtherServantPanel:GetHeadIcon2_UIToggle()
    if (self.mHeadIcon2 == nil) then
        self.mHeadIcon2 = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou2", "UIToggle")
    end
    return self.mHeadIcon2
end

function UIOtherServantPanel:GetHeadIcon3_UIToggle()
    if (self.mHeadIcon3 == nil) then
        self.mHeadIcon3 = self:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou3", "UIToggle")
    end
    return self.mHeadIcon3
end
--endregion

--region View
function UIOtherServantPanel:ModelBG1_GameObject()
    if (self.mModelBG1 == nil) then
        self.mModelBG1 = self:GetCurComp("WidgetRoot/Main/view/ModelBG1", "GameObject")
    end
    return self.mModelBG1
end

function UIOtherServantPanel:ModelBG2_GameObject()
    if (self.mModelBG2 == nil) then
        self.mModelBG2 = self:GetCurComp("WidgetRoot/Main/view/ModelBG2", "GameObject")
    end
    return self.mModelBG2
end

function UIOtherServantPanel:ModelBG3_GameObject()
    if (self.mModelBG3 == nil) then
        self.mModelBG3 = self:GetCurComp("WidgetRoot/Main/view/ModelBG3", "GameObject")
    end
    return self.mModelBG3
end

function UIOtherServantPanel:GetNormalBottom_GameObject()
    if (self.mNormalBottom == nil) then
        self.mNormalBottom = UIOtherServantPanel:GetCurComp("WidgetRoot/Main/window/left_main", "GameObject")
    end
    return self.mNormalBottom
end

function UIOtherServantPanel:GetAttributeBottom_GameObject()
    if (self.mAttributeBottom == nil) then
        self.mAttributeBottom = UIOtherServantPanel:GetCurComp("WidgetRoot/Main/window/all_main", "GameObject")
    end
    return self.mAttributeBottom
end
--endregion

--region 其他组件

function UIOtherServantPanel:GetServantHeadRedPointList()
    if (UIOtherServantPanel.mHeadRedPointList == nil) then
        UIOtherServantPanel.mHeadRedPointList = {};
        local firstHeadRed = UIOtherServantPanel:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou1/RedPoint", "UIRedPoint");
        if (firstHeadRed ~= nil) then
            table.insert(UIOtherServantPanel.mHeadRedPointList, firstHeadRed);
        end
        local secondHeadRed = UIOtherServantPanel:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou2/RedPoint", "UIRedPoint");
        if (secondHeadRed ~= nil) then
            table.insert(UIOtherServantPanel.mHeadRedPointList, secondHeadRed);
        end
        local thirdHeadRed = UIOtherServantPanel:GetCurComp("WidgetRoot/Main/Scroll View/huanshou/huanshou3/RedPoint", "UIRedPoint");
        if (thirdHeadRed ~= nil) then
            table.insert(UIOtherServantPanel.mHeadRedPointList, thirdHeadRed);
        end
    end
    return UIOtherServantPanel.mHeadRedPointList;
end

--endregion

--endregion

--region 初始化
function UIOtherServantPanel:Init()
    UIOtherServantPanel.Self = self;
    --networkRequest.ReqServantInfo()
    UIOtherServantPanel.BindMessage()
    UIOtherServantPanel:BindUIEvents()
    UIOtherServantPanel:InitData();
end

---@param customData{BaseTemplate:table, openServantPanelType:LuaEnumPanelOpenSourceType,showBagItemInfo:bagV2.BagItemInfo,ServantHead:table,topOpenType:number}
function UIOtherServantPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end



    --region 初始化装备模板
    --默认装备模板
    ---@type UIServantPanel_Base
    UIOtherServantPanel.mBaseTemplate = luaComponentTemplates.UIServantPanel_Base
    --初始化界面
    UIOtherServantPanel:InitPanel();
    --endregion


    if (customData.openServantPanelType ~= nil) then
        UIOtherServantPanel.mPanelOpenSourceType = customData.openServantPanelType
    else
        UIOtherServantPanel.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.Other
    end
    if customData.showBagItemInfo then
        UIOtherServantPanel.mCurrentChooseBagItemInfo = customData.showBagItemInfo
    end

    --region 初始化头像模板
    --头像默认模板
    UIOtherServantPanel.mServantHeadTemplate = luaComponentTemplates.UIServantInfoTemplate
    --重写头像模板
    if customData.ServantHead then
        UIOtherServantPanel.mServantHeadTemplate = customData.ServantHead
    end
    --endregion

    if (customData.OtherServantList ~= nil) then
        if (customData.pos == nil) then
            customData.pos = customData.OtherServantList[0].type;
        else
            customData.pos = customData.pos < 1 and 1 or customData.pos;
            customData.pos = customData.pos > 3 and 3 or customData.pos;
        end
        for i = 0, customData.OtherServantList.Count - 1 do
            if (customData.OtherServantList[i].type == customData.pos) then
                if (i == customData.OtherServantList[i].type - 1) then
                    UIOtherServantPanel.ServantIndex = customData.pos - 1
                else
                    UIOtherServantPanel.ServantIndex = i
                end
            end
        end
        UIOtherServantPanel.OtherServantList = customData.OtherServantList
        UIOtherServantPanel:ShowOtherServantPanel()
        UIOtherServantPanel.TabEquipOnClick()
        UIOtherServantPanel:UpdateOtherHeadList()
        return
    end
end

function UIOtherServantPanel.BindMessage()
end

function UIOtherServantPanel:BindUIEvents()
    CS.UIEventListener.Get(UIOtherServantPanel:GetClose_Btn()).onClick = UIOtherServantPanel.OnClickClose_Btn
    --luaEventManager.BindCallback(LuaCEvent.Servant_OnClickServantTag, UIOtherServantPanel.OnServantTagClicked);
end

function UIOtherServantPanel:InitData()
    --灵兽等级限制数据
    --UIOtherServantPanel.mShowEquipReinLevel = UIOtherServantPanel.GetNoticeTableData(13)
    UIOtherServantPanel.mShowEquipReinLevel = 0
    --肉身等级限制
    UIOtherServantPanel.mShowBodyLevel = UIOtherServantPanel.GetNoticeTableData(14)
    --转生等级限制
    UIOtherServantPanel.ReinLevelGroup = UIOtherServantPanel.GetGlobalTableData(20233)
    UIOtherServantPanel.ShowReinLevel = tonumber(string.Split(UIOtherServantPanel.ReinLevelGroup, "#")[1])
    UIOtherServantPanel.ClickReinLevel = tonumber(string.Split(UIOtherServantPanel.ReinLevelGroup, "#")[2])
end

function UIOtherServantPanel:InitPanel()
    UIOtherServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel] = templatemanager.GetNewTemplate(UIOtherServantPanel:GetBasePanel_Root(), UIOtherServantPanel.mBaseTemplate, self)
end
--endregion

--region 表数据
---获取Help表数据
function UIOtherServantPanel.GetHelpTableData(id)
    local res, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if res then
        return info
    end
    return nil
end

---获取Notice表数据
function UIOtherServantPanel.GetNoticeTableData(id)
    local res2, limit2 = CS.Cfg_NoticeTableManager.Instance.dic:TryGetValue(id)
    if res2 then
        return tonumber(limit2.conceal)
    end
    return nil
end

---获取Global表数据
function UIOtherServantPanel.GetGlobalTableData(id)
    local res2, limit2 = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(id)
    if res2 then
        return limit2.value
    end
    return nil
end
--endregion

--region Update
function update()
    if UIOtherServantPanel.mNeedRefreshServantInfoStep then
        UIOtherServantPanel:RefreshServantInfo(UIOtherServantPanel.mNeedRefreshServantInfoStep)
        UIOtherServantPanel.mNeedRefreshServantInfoStep = UIOtherServantPanel.mNeedRefreshServantInfoStep - 1
        if UIOtherServantPanel.mNeedRefreshServantInfoStep <= 0 then
            UIOtherServantPanel.mNeedRefreshServantInfoStep = nil
        end
    end
end
--endregion

--region 面板切换
function UIOtherServantPanel.OnServantTagClicked(msgId, servantPanelType)
    UIOtherServantPanel:SwitchServantPanel(servantPanelType)
end

function UIOtherServantPanel.OnClickClose_Btn()
    uimanager:ClosePanel("UIOtherServantPanel")
    uimanager:ClosePanel("UIServantTagPanel")
end

function UIOtherServantPanel.TabEquipOnClick()
    UIOtherServantPanel:SwitchServantPanel(LuaEnumServantPanelType.BasePanel)
end

function UIOtherServantPanel:SwitchServantPanel(type)
    if (type == UIOtherServantPanel.ServantNavType) then
        return
    end
    --音效
    uimanager:PlayCloseUIAudio(UIOtherServantPanel)

    if (UIOtherServantPanel:GetCurBranchPanel() ~= nil) then
        --刷新真实等级
        UIOtherServantPanel:GetSelectHeadInfo():RefreshLevel()

        UIOtherServantPanel.OnClickBtnHideAttribute(nil)
        UIOtherServantPanel:GetCurBranchPanel():Hide()
    end
    UIOtherServantPanel.ServantNavType = type
    if (UIOtherServantPanel:GetCurBranchPanel() ~= nil) then
        UIOtherServantPanel.mSelectTitleCor = StartCoroutine(UIOtherServantPanel.IEnumSelectTitle, type);
    end
end

function UIOtherServantPanel.IEnumSelectTitle(type)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.1))
    UIOtherServantPanel:GetCurBranchPanel():Show()
    if UIOtherServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByServantHint then
        UIOtherServantPanel:GetSelectHeadInfo():IconOnClick(LuaEnumPanelOpenSourceType.ByServantHint);
    else
        UIOtherServantPanel:GetSelectHeadInfo():IconOnClick(LuaEnumPanelOpenSourceType.ByServantPanel);
    end
    if (type == LuaEnumServantPanelType.BasePanel) then
        if not CS.StaticUtility.IsNull(UIOtherServantPanel:GetTabEquip_UIToggle()) then
            UIOtherServantPanel:GetTabEquip_UIToggle().value = true
        end
    end
end
--endregion

--region 展开右侧小面板
function UIOtherServantPanel.OnClickBtnShowAttribute(go)
    UIOtherServantPanel:GetNormalBottom_GameObject():SetActive(false)
    UIOtherServantPanel:GetAttributeBottom_GameObject():SetActive(true)
    UIOtherServantPanel.BranchPanel[UIOtherServantPanel.ServantNavType]:ShowFull(true);

    if luaEventManager.HasCallback(LuaCEvent.ServantArrowClicked) then
        luaEventManager.DoCallback(LuaCEvent.ServantArrowClicked, LuaEnumServantEquipType.Show)
    end
end

---隐藏属性
function UIOtherServantPanel.OnClickBtnHideAttribute(go)
    UIOtherServantPanel:GetNormalBottom_GameObject():SetActive(true)
    UIOtherServantPanel:GetAttributeBottom_GameObject():SetActive(false)
    UIOtherServantPanel.BranchPanel[UIOtherServantPanel.ServantNavType]:ShowFull(false);

    if luaEventManager.HasCallback(LuaCEvent.ServantArrowClicked) then
        luaEventManager.DoCallback(LuaCEvent.ServantArrowClicked, LuaEnumServantEquipType.Hide)
    end
end
--endregion

--region 获取灵兽数据
function UIOtherServantPanel:GetServantInfo()
    if (self.mServantInfo == nil) then
        self.mServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    end
    return self.mServantInfo
end

function UIOtherServantPanel:GetServantInfoList()
    if (UIOtherServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        return UIOtherServantPanel.OtherServantList
    else
        return self:GetServantInfo().ServantInfoList
    end
end

function UIOtherServantPanel:GetSelectIndex()
    return self.ServantIndex
end

function UIOtherServantPanel:GetSelectServantInfo()
    if (self.ServantIndex ~= -1) then
        return self:GetTargetServantInfo(self.ServantIndex)
    end
    return nil
end

function UIOtherServantPanel:GetTargetServantInfo(index)
    if (self:GetServantInfoList().Count > index) then
        return self:GetServantInfoList()[index]
    end
    return nil
end

---当前选中的灵兽信息
---@return UIServantInfoTemplate
function UIOtherServantPanel:GetSelectHeadInfo()
    return self:GetTargetHeadInfo(self.ServantIndex)
end

---获取目标index对应的灵兽信息
---@param index number
---@return UIServantInfoTemplate
function UIOtherServantPanel:GetTargetHeadInfo(index)
    if (self.ServantItemHeadList[index] ~= nil) then
        return self.ServantItemHeadList[index]
    else
        return nil
    end
end

---切换灵兽
function UIOtherServantPanel:SwitchServantByIndex(servantIndex)
    self:SetModelBG(servantIndex)
    self:SwitchServant(servantIndex)
end

function UIOtherServantPanel:SetModelBG(servantIndex)
    for k, v in pairs(self.ServantItemHeadList) do
        if (v.info ~= nil and v.info.type == servantIndex) then
            servantIndex = v.info.type
        end
    end
    if (servantIndex == 1) then
        self:ModelBG1_GameObject():SetActive(true)
        self:ModelBG2_GameObject():SetActive(false)
        self:ModelBG3_GameObject():SetActive(false)
    elseif (servantIndex == 2) then
        self:ModelBG1_GameObject():SetActive(false)
        self:ModelBG2_GameObject():SetActive(true)
        self:ModelBG3_GameObject():SetActive(false)
    elseif (servantIndex == 3) then
        self:ModelBG1_GameObject():SetActive(false)
        self:ModelBG2_GameObject():SetActive(false)
        self:ModelBG3_GameObject():SetActive(true)
    end
end

function UIOtherServantPanel:SwitchServant(type)
    for k, v in pairs(self.ServantItemHeadList) do
        if (v.info ~= nil and v.info.type == type) then
            UIOtherServantPanel.ServantIndex = v.index
        end
    end

    for k, v in pairs(self.ServantItemHeadList) do
        v:HideAllBackGround();
    end

    UIOtherServantPanel:GetCurBranchPanel():RefreshServant(UIOtherServantPanel:GetSelectServantInfo(), UIOtherServantPanel.mPanelOpenSourceType, UIOtherServantPanel.mCurrentChooseBagItemInfo)
    --if (not UIOtherServantPanel:GetSelectHeadInfo().IsUnLock) then
    self:GetHeadIcon1_UIToggle():SwitchSpriteState(false)
    self:GetHeadIcon2_UIToggle():SwitchSpriteState(false)
    self:GetHeadIcon3_UIToggle():SwitchSpriteState(false)
    CS.Utility_Lua.GetComponent(self.ServantItemHeadList[UIOtherServantPanel.ServantIndex].go, "Top_UIToggle"):SwitchSpriteState(true)
    --end
end
--endregion

--region 刷新面板
function UIOtherServantPanel:ShowOtherServantPanel()
    self:GetBtnShowAttribute():SetActive(false)
end

function UIOtherServantPanel.SetClickReinLevel()
    if UIOtherServantPanel.ClickReinLevel then
        for i = 0, UIOtherServantPanel:GetServantInfo().ServantInfoList.Count - 1 do
            if UIOtherServantPanel:GetServantInfo().ServantInfoList[i].level >= UIOtherServantPanel.ClickReinLevel then
                return true
            end
        end
    end
    return false
end

function UIOtherServantPanel:UpdateOtherHeadList()
    local index = 1
    for i = 0, 2 do
        local go = UIOtherServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(i).gameObject
        go:SetActive(false)
    end

    for i = 0, UIOtherServantPanel.OtherServantList.Count - 1 do
        if (index ~= UIOtherServantPanel.OtherServantList[i].type) then
            index = UIOtherServantPanel.OtherServantList[i].type
        end
        if (UIOtherServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(index - 1).gameObject ~= nil) then
            if (UIOtherServantPanel.ServantItemHeadList[i] == nil) then
                local go = UIOtherServantPanel:GetServantItemHeadList_GridContainer().transform:GetChild(index - 1).gameObject
                UIOtherServantPanel.ServantItemHeadList[i] = templatemanager.GetNewTemplate(go, UIOtherServantPanel.mServantHeadTemplate, self, i, UIOtherServantPanel.mPanelOpenSourceType)
            end
        end
        UIOtherServantPanel.ServantItemHeadList[i].IsUnLock = false
        UIOtherServantPanel.ServantItemHeadList[i]:RefreshIcon()
        UIOtherServantPanel.ServantItemHeadList[i]:RefreshLevel()
        index = index + 1
    end
end
---Tips
function UIOtherServantPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIOtherServantPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIOtherServantPanel:RefreshServantInfo(step)
    if step == 3 then
        UIOtherServantPanel:GetSelectHeadInfo().info = UIOtherServantPanel:GetSelectServantInfo()
    end
    if step == 2 then
        UIOtherServantPanel:GetCurBranchPanel():RefreshServant(UIOtherServantPanel:GetSelectServantInfo(), UIOtherServantPanel.mPanelOpenSourceType, UIOtherServantPanel.mCurrentChooseBagItemInfo)
    end
    if step == 1 then
        UIOtherServantPanel:GetSelectHeadInfo():RefreshIcon()
    end
end

function UIOtherServantPanel.onResShowEffectInServantHead(id, index)
    if (index ~= nil and UIOtherServantPanel.ServantItemHeadList[index] ~= nil) then
        local go = nil
        go = UIOtherServantPanel.ServantItemHeadList[index]:GetBtnUseLight_GameObject()
        go:SetActive(true)
    end
end

function UIOtherServantPanel.onResHideEffectInServantHead(id, index)
    if (index ~= nil and UIOtherServantPanel.ServantItemHeadList[index] ~= nil) then
        local go = nil
        go = UIOtherServantPanel.ServantItemHeadList[index]:GetBtnUseLight_GameObject()
        go:SetActive(false)
    end
end
--endregion

--region 客户端消息处理
function UIOtherServantPanel.ResServantInfoMessage()
    UIOtherServantPanel.mNeedRefreshServantInfoStep = 3
end
--endregion

--region 服务器消息处理
function UIOtherServantPanel.HideButtons()
    UIOtherServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:HideButtons();
end
--endregion

--region 转移
function UIOtherServantPanel.SetTransferItemChoose(lid, isChoose)
    UIOtherServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]:SetItemChoose(lid, isChoose)
end
--endregion

--region 锻造
function UIOtherServantPanel.SetStrengthItemChoose(lid)
    ---@type UIForgeStrengthPanel_ServantBase
    local template = UIOtherServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]
    if template then
        template:ChooseBagItemInfo(lid)
    end
end

function UIOtherServantPanel.CloseCurrentChoose()
    ---@type UIForgeStrengthPanel_ServantBase
    local template = UIOtherServantPanel.BranchPanel[LuaEnumServantPanelType.BasePanel]
    if template and template.CloseChooseEffect then
        template:CloseChooseEffect()
    end
end
--endregion

--region 对外方法
---关闭按钮
function UIOtherServantPanel:ShowOtherButton(isShow)
    UIOtherServantPanel:GetClose_Btn():SetActive(isShow)
    UIOtherServantPanel:GetBtnShowAttribute():SetActive(isShow)
end
--endregion

--region onDestroy
function ondestroy()
    --luaEventManager.RemoveCallback(LuaCEvent.Servant_OnClickServantTag, UIOtherServantPanel.OnServantTagClicked);
    if (UIOtherServantPanel.mSelectTitleCor ~= nil) then
        StopCoroutine(UIOtherServantPanel.mSelectTitleCor)
        UIOtherServantPanel.mSelectTitleCor = nil
    end
end
--endregion

return UIOtherServantPanel