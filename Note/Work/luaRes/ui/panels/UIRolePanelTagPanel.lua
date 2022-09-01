---角色面板页签
---@class UIRolePanelTagPanel:UIBase
local UIRolePanelTagPanel = {}

---UI界面层级为Tips
UIRolePanelTagPanel.PanelLayerType = CS.UILayerType.TipsPlane
--region 局部变量
---所有打开过的面板
UIRolePanelTagPanel.AllPanelList = {}
---是否正忙,0表示没有界面在预定打开中,不忙
UIRolePanelTagPanel.IsBusyCount = 0

---渐入按钮列表
UIRolePanelTagPanel.mButtonList = nil;
--endregion

---当前显示的页签
UIRolePanelTagPanel.mCurTagIndex = 1


--region数据
---@return CSMainPlayerInfo
function UIRolePanelTagPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end
--endregion

--region 页签显示
---所有需要显示页签
UIRolePanelTagPanel.TagShow = {
    LuaEnumLeftTagType.UIRolePanel,
    LuaEnumLeftTagType.UIRoleTurnGrowPanel,
    LuaEnumLeftTagType.UIRolePrefixPanel,
    LuaEnumLeftTagType.UIRoleBloodSuitPanel,
    LuaEnumLeftTagType.UIMilitaryRankTitlePanel,
    LuaEnumLeftTagType.UIRolePotentialPanel,
    LuaEnumLeftTagType.UIOfficialPositionPanel,
    LuaEnumLeftTagType.UICollectionPanel,
    LuaEnumLeftTagType.UIOutlookPanel, --外观页签界面
}

---添加要显示按钮
function UIRolePanelTagPanel:AddTagShow()
    local startPos = -160
    local des = -77
    local addNum = 0
    local sortTagIdList = LuaGlobalTableDeal.GetSortLeftTagIdList(self.TagShow)
    for i = 1, #sortTagIdList do
        local tagId = sortTagIdList[i]
        local go = self.TagIdToBtn[tagId]
        if self:IsTagCanShow(tagId) then
            table.insert(self.mButtonList, go)
            addNum = addNum + 1
            local originPos = go.transform.localPosition
            originPos.y = startPos + des * (addNum - 1)
            go.transform.localPosition = originPos
        else
            go:SetActive(false)
        end
    end
end

---@return boolean 页签是否可显示
function UIRolePanelTagPanel:IsTagCanShow(tagId)
    --外观页签暂时做一个特殊处理
    if tagId == 9 then
        if CS.CSScene.MainPlayerInfo ~= nil and
                ((CS.CSScene.MainPlayerInfo.Appearance.AppearanceData ~= nil and CS.CSScene.MainPlayerInfo.Appearance.AppearanceData.IsOnceHoldAnyFashion) or
                        (CS.CSScene.MainPlayerInfo.TitleInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList.Count > 0)) and
                not CS.CSScene.MainPlayerInfo.IsSpy then
            return true
        else
            return false
            --[[else
            if not CS.CSScene.MainPlayerInfo.Appearance.AppearanceData.IsOnceHoldAnyFashion  then
                return false
            else]]
        end
    end
    if uiStaticParameter.mRolePanelTagCondition == nil then
        local data = {}
        local res, conditions = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22377)
        if res then
            local strs = string.Split(conditions.value, '&')
            if strs and #strs then
                for i = 1, #strs do
                    local str = strs[i]
                    local condition = string.Split(str, '#')
                    if #condition >= 1 then
                        local tagId = tonumber(condition[1])
                        data[tagId] = condition
                    end
                end
            end
        end
        uiStaticParameter.mRolePanelTagCondition = data
    end
    local conditionIds = uiStaticParameter.mRolePanelTagCondition[tagId]
    if conditionIds and #conditionIds >= 2 then
        for j = 2, #conditionIds do
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionIds[j]) then
                return false
            end
        end
    end
    return true
end
--endregion

--region 初始化
function UIRolePanelTagPanel:Init()
    UIRolePanelTagPanel:InitRolePanelTag()
    --region 按钮渐入动画
    UIRolePanelTagPanel.mButtonList = {};
    --[[    table.insert(UIRolePanelTagPanel.mButtonList, UIRolePanelTagPanel.btn_role);
        table.insert(UIRolePanelTagPanel.mButtonList, UIRolePanelTagPanel.btn_reincarnation);
        table.insert(UIRolePanelTagPanel.mButtonList, UIRolePanelTagPanel.btn_militaryRank);]]
    self:AddTagShow()
    --table.insert(UIRolePanelTagPanel.mButtonList, UIRolePanelTagPanel.btn_innpower);

    UIRolePanelTagPanel.ResetTweenOriginParameter();
    UIRolePanelTagPanel:PlayButtonsFadeIn();
    --endregion
    self.time = 0
end

function UIRolePanelTagPanel:Show(customData, callBack)
    if customData == nil then
        customData = {}
    end
    self.mOfficialPanelData = nil

    local showPanelType = customData.type == nil and LuaEnumLeftTagType.UIRolePanel or customData.type

    if showPanelType == LuaEnumLeftTagType.UIRolePanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIRolePanel, self.OnClickRoleBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIRoleTurnGrowPanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIRoleTurnGrowPanel, self.OnClickReincarnationBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIRolePrefixPanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIRolePrefixPanel, self.OnClickMilitaryRankBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIRolePowerPanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIRolePowerPanel, self.OnClickInnpowerBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIRoleBloodSuitPanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIRoleBloodSuitPanel, self.OnClickBloodSuitBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIMilitaryRankTitlePanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIMilitaryRankTitlePanel, self.OnClickSealMarkBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIRolePotentialPanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIRolePotentialPanel, self.OnClickPotentialBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIOfficialPositionPanel then
        self.mOfficialPanelData = {}
        self.mOfficialPanelData.isOpenHuFu = customData.isOpenHuFu
        self:SwitchPanel(LuaEnumLeftTagType.UIOfficialPositionPanel, self.OnClickOfficialBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UICollectionPanel then
        self:SwitchPanel(LuaEnumLeftTagType.UICollectionPanel, self.OnClickCollectionBtn, customData, callBack)
    elseif showPanelType == LuaEnumLeftTagType.UIOutlookPanel then
        self:SwitchPanel(LuaEnumLeftTagType.UIOutlookPanel, self.OnClickOutlookBtn, customdata, callBack)
    end
    --Utility.TryFadeOutMainMenusLeft("UIRolePanelTagPanel");
    self:SetCreatePanel(customData, callBack)
end

function UIRolePanelTagPanel:InitRolePanelTag()
    UIRolePanelTagPanel:InitComponents()
    UIRolePanelTagPanel:BindUIEvent()
    UIRolePanelTagPanel:BindClientEvents()
    --UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel.TagIdToBtn = {
        [LuaEnumLeftTagType.UIRolePanel] = UIRolePanelTagPanel.btn_role,
        [LuaEnumLeftTagType.UIRoleTurnGrowPanel] = UIRolePanelTagPanel.btn_reincarnation,
        [LuaEnumLeftTagType.UIRolePrefixPanel] = UIRolePanelTagPanel.btn_militaryRank,
        [LuaEnumLeftTagType.UIRoleBloodSuitPanel] = UIRolePanelTagPanel.btn_zhuangbei,
        [LuaEnumLeftTagType.UIMilitaryRankTitlePanel] = UIRolePanelTagPanel.btn_SealMark,
        [LuaEnumLeftTagType.UIRolePotentialPanel] = UIRolePanelTagPanel.btn_potential,
        [LuaEnumLeftTagType.UIOfficialPositionPanel] = UIRolePanelTagPanel.btn_officialMark,
        [LuaEnumLeftTagType.UICollectionPanel] = UIRolePanelTagPanel.btn_collectionMark,
        [LuaEnumLeftTagType.UIOutlookPanel] = UIRolePanelTagPanel.btn_outlookMark,
    }
    UIRolePanelTagPanel.BindLuaRedPoint()
end

function UIRolePanelTagPanel:BindClientEvents()
    UIRolePanelTagPanel:GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, UIRolePanelTagPanel.OnUIPanelClosedEventReceived)
    UIRolePanelTagPanel:GetClientEventHandler():AddEvent(CS.CEvent.UpdateOrientationState, UIRolePanelTagPanel.ResetTweenOriginParameter);
end

---初始化组件
function UIRolePanelTagPanel:InitComponents()
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_role = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_role", "GameObject")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_skill = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_skill", "GameObject")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_innpower = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_innpower", "GameObject")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_reincarnation = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_reincarnation", "GameObject")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_militaryRank = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_militaryRank", "GameObject")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_title = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_title", "GameObject")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_zhuangbei = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_zhuangbei", "GameObject")
    ---@type UIRedPoint
    UIRolePanelTagPanel.btn_zhuangbeiRed = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_zhuangbei/redpoint", "UIRedPoint")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_SealMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_militaryRankTitle", "GameObject")
    ---@type UIRedPoint
    UIRolePanelTagPanel.btn_SealMarkRed = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_militaryRankTitle/redpoint", "UIRedPoint")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_potential = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_potential", "GameObject")
    ---@type UIRedPoint
    UIRolePanelTagPanel.btn_potentialRed = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_potential/redpoint", "UIRedPoint")
    ---@type UIRedPoint
    UIRolePanelTagPanel.btn_officialMarkRed = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_officialPosition/redpoint", "UIRedPoint")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_officialMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_officialPosition", "GameObject")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_collectionMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_collection", "GameObject")
    ---@type UIRedPoint
    UIRolePanelTagPanel.btn_collectionMarkRed = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_collection/redpoint", "UIRedPoint")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.btn_outlookMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_outlook", "GameObject")
    ---@type UIRedPoint
    --UIRolePanelTagPanel.btn_outlookMarkRed = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_outlook/redpoint","UIRedPoint")

    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.outlookCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_outlook/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.collectionCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_collection/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.officialCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_officialPosition/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.roleCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_role/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.skillCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_skill/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.innpowerCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_innpower/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.reincarnationCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_reincarnation/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.militaryRankCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_militaryRank/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.potentialCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_potential/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.titleCheckMark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_title/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.zhuangbeiCheckmark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_zhuangbei/Checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIRolePanelTagPanel.sealMarkCheckmark = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_militaryRankTitle/Checkmark", "Top_UISprite")
    ---@type UISprite
    UIRolePanelTagPanel.bgSprite = UIRolePanelTagPanel:GetCurComp("WidgetRoot/bg", "UISprite")

    ---@type UIRedPoint
    UIRolePanelTagPanel.rolePageRedPoint = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_role/redpoint", "UIRedPoint")
    --@type UIRedPoint 人物页签红点移到外观页签上
    UIRolePanelTagPanel.appearancePageRedPoint = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_outlook/redpoint", "UIRedPoint")
    ---@type UIRedPoint
    UIRolePanelTagPanel.btn_reincarnationRed = UIRolePanelTagPanel:GetCurComp("WidgetRoot/btn_reincarnation/redpoint", "UIRedPoint")

    UIRolePanelTagPanel.RolePanelTagUIPanel = CS.Utility_Lua.GetComponent(UIRolePanelTagPanel.go, "UIPanel")
end

---绑定UI事件
function UIRolePanelTagPanel:BindUIEvent()
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_role).onClick = UIRolePanelTagPanel.OnClickRoleBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_skill).onClick = UIRolePanelTagPanel.OnClickSkillBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_innpower).onClick = UIRolePanelTagPanel.OnClickInnpowerBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_reincarnation).onClick = UIRolePanelTagPanel.OnClickReincarnationBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_militaryRank).onClick = UIRolePanelTagPanel.OnClickMilitaryRankBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_title).onClick = UIRolePanelTagPanel.OnClickTitleBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_zhuangbei).onClick = UIRolePanelTagPanel.OnClickBloodSuitBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_SealMark).onClick = UIRolePanelTagPanel.OnClickSealMarkBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_officialMark).onClick = UIRolePanelTagPanel.OnClickOfficialBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_collectionMark).onClick = UIRolePanelTagPanel.OnClickCollectionBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_outlookMark).onClick = UIRolePanelTagPanel.OnClickOutlookBtn
    CS.UIEventListener.Get(UIRolePanelTagPanel.btn_potential).onClick = UIRolePanelTagPanel.OnClickPotentialBtn
end

---绑定lua红点
---@private
function UIRolePanelTagPanel.BindLuaRedPoint()
    local magicEquip_AllKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MagicEquip_All);
    UIRolePanelTagPanel.rolePageRedPoint:AddRedPointKey(magicEquip_AllKey)

    local BloodSuit_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_All);
    UIRolePanelTagPanel.btn_zhuangbeiRed:AddRedPointKey(BloodSuit_All)

    local SealMark = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SealMark);
    UIRolePanelTagPanel.btn_SealMarkRed:AddRedPointKey(SealMark)
    UIRolePanelTagPanel.btn_SealMarkRed:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.TitleTalentMark))
    UIRolePanelTagPanel.btn_potentialRed:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Potential))

    local OfficialMark = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.OfficialState);
    UIRolePanelTagPanel.btn_officialMarkRed:AddRedPointKey(OfficialMark)

    local LianZhi_XiuWei = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_XiuWei);
    UIRolePanelTagPanel.btn_reincarnationRed:AddRedPointKey(LianZhi_XiuWei)

    local UpReinLv = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LuaRoleReinRedPoint);
    UIRolePanelTagPanel.btn_reincarnationRed:AddRedPointKey(UpReinLv)

    local ExpExchange = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ExpExchange);
    UIRolePanelTagPanel.btn_reincarnationRed:AddRedPointKey(ExpExchange)

    local LianZhi_GongXun = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_GongXun);
    UIRolePanelTagPanel.btn_officialMarkRed:AddRedPointKey(LianZhi_GongXun)

    local collectionRedPointKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection);
    UIRolePanelTagPanel.btn_collectionMarkRed:AddRedPointKey(collectionRedPointKey)
    UIRolePanelTagPanel.appearancePageRedPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.NewAppearance))

    local OutlookRedPointKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Outlook)
    --UIRolePanelTagPanel.btn_outlookMarkRed:AddRedPointKey(OutlookRedPointKey)
end

--endregion


---切换页面
---@param tag number
---@param clickFunc function
---@param clickFuncParam any
---@param callBack function
function UIRolePanelTagPanel:SwitchPanel(tag, clickFunc, clickFuncParam, callBack)
    UIRolePanelTagPanel.mCurTagIndex = tag
    self:RefreshTagCheck()
    if (clickFunc ~= nil) then
        clickFunc(clickFuncParam, callBack)
    end
end

--region UI事件
--点击角色方法
function UIRolePanelTagPanel.OnClickRoleBtn(param, callBack)
    UIRolePanelTagPanel.mCurTagIndex = 1
    if param == nil then
        param = { openSourceType = LuaEnumPanelOpenSourceType.ByRoleHeadPanel }
    else
        if type(param) == "table" and param.openSourceType == nil then
            param.openSourceType = LuaEnumPanelOpenSourceType.ByRoleHeadPanel
        end
    end
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIRolePanel", callBack, param)
    uimanager:ClosePanel("UIRefineMasterPanel")
    uimanager:ClosePanel("UIAppearancePanel")
end

--点击技能方法
function UIRolePanelTagPanel.OnClickSkillBtn(param, callBack)
    UIRolePanelTagPanel:RefreshPanel("UISkillPanel", function(panel)
        panel.ShowPanel(0)
        callBack(panel)
    end)
end

--点击内功方法
function UIRolePanelTagPanel.OnClickInnpowerBtn(param, callBack)

    local isOpen, isHide = uimanager:IsCondition(3)
    if not isOpen then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = UIRolePanelTagPanel.btn_innpower.transform
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 34
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIRolePanelTagPanel";
        uimanager:CreatePanel("UIBubbleTipsPanel", callBack, TipsInfo)

        return
    end
    UIRolePanelTagPanel.mCurTagIndex = 4
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIRolePowerPanel", nil)
end

--点击转生方法
function UIRolePanelTagPanel.OnClickReincarnationBtn(param, callBack)
    local isCondition, isHide = uimanager:IsCondition(4)
    if not isCondition then
        CS.Utility.ShowRedTips('转生未开启')
        return
    end
    UIRolePanelTagPanel.mCurTagIndex = 2
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIRoleTurngrowPanel", callBack, param)
    if gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_XiuWei == true then
        gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_XiuWei = false
        gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():CallRed(LuaRedPointName.LianZhi_XiuWei)
    end
    if gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isNeedopen_LianzhiXiuWei then
        uimanager:CreatePanel("UIRefineMasterPanel")
    end
end

--点击军衔方法
function UIRolePanelTagPanel.OnClickMilitaryRankBtn(go, callBack)
    UIRolePanelTagPanel.mCurTagIndex = 3
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIMilitaryRankPanel", nil)
    uimanager:ClosePanel("UIRefineMasterPanel")
    uimanager:ClosePanel("UIAppearancePanel")
end

--点击称号方法
function UIRolePanelTagPanel.OnClickTitleBtn()
    if CS.CSScene.mMainPlayerInfo.TitleInfoV2.TitleInfoList.Count ~= 0 then
        UIRolePanelTagPanel:RefreshPanel("UITitlePanel", nil)
    else
        CS.Utility.ShowTips("暂无称号", 1, CS.ColorType.Red)
    end
end

---血继点击方法
function UIRolePanelTagPanel.OnClickBloodSuitBtn(customData, callBack)
    local type = nil
    local pos = nil
    if customData ~= nil then
        type = customData.BloodSuitType
        pos = customData.BloodSuitPos
    end
    local BloodSuitCustomData = {
        Suittype = type,
        pos = pos
    }
    UIRolePanelTagPanel.mCurTagIndex = 5
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIRoleBloodSuitPanel", nil, BloodSuitCustomData)
end

---点击封号方法
function UIRolePanelTagPanel.OnClickSealMarkBtn(go, callBack)
    UIRolePanelTagPanel.mCurTagIndex = 6
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIMilitaryRankTitlePanel", nil)
end

---点击官位方法
function UIRolePanelTagPanel.OnClickOfficialBtn(go, callBack)
    UIRolePanelTagPanel.mCurTagIndex = 7
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIOfficialPositionPanel", nil, UIRolePanelTagPanel.mOfficialPanelData)
    if gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_GongXun == true then
        gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_GongXun = false
        gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():CallRed(LuaRedPointName.LianZhi_GongXun)
    end
    if gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isNeedopen_LianzhiGongXun then
        uimanager:CreatePanel("UIRefineOfficialPanel")
    end
end

function UIRolePanelTagPanel.OnClickCollectionBtn(go, callBack)
    UIRolePanelTagPanel.mCurTagIndex = 8
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UICollectionPanel", nil)
end

--点击外观方法
function UIRolePanelTagPanel.OnClickOutlookBtn(go, callBack)
    UIRolePanelTagPanel.mCurTagIndex = 9
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIRolePanel", callBack)
    local appearancePanel = uimanager:CreatePanel("UIAppearancePanel")
end

---点击潜能方法
function UIRolePanelTagPanel.OnClickPotentialBtn(customData, callBack)
    UIRolePanelTagPanel.mCurTagIndex = 10
    UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel:RefreshPanel("UIRolePotentialPanel", nil, customData)
end
--endregion

function UIRolePanelTagPanel.SetAvoidCheckPanelName(avoidPanelName)
    UIRolePanelTagPanel.mAvoidCheckPanelName = avoidPanelName
    UIRolePanelTagPanel.mAvoidCheckPanelFrame = CS.UnityEngine.Time.frameCount
end

--region 客户端事件
---当界面关闭时,检查已经打开的界面是否都存在,如果都存在则关闭界面
function UIRolePanelTagPanel.OnUIPanelClosedEventReceived(eventID, panelClosed)
    if UIRolePanelTagPanel.IsBusyCount ~= 0 then
        return
    end
    if panelClosed == UIRolePanelTagPanel.mAvoidCheckPanelName then
        local currentFrameCount = CS.UnityEngine.Time.frameCount
        if UIRolePanelTagPanel.mAvoidCheckPanelFrame ~= nil and currentFrameCount - UIRolePanelTagPanel.mAvoidCheckPanelFrame < 10 then
            return
        end
    end
    if UIRolePanelTagPanel.AllPanelList then
        local isAnyPanelExist = false
        for i, v in pairs(UIRolePanelTagPanel.AllPanelList) do
            local panel = uimanager:GetPanel(i)
            if v == panel and v ~= nil then
                isAnyPanelExist = true
                break
            end
        end
        if isAnyPanelExist == false then
            uimanager:ClosePanel("UIRolePanelTagPanel")
        end
    end
end

function UIRolePanelTagPanel.ResetTweenOriginParameter()
    UIRolePanelTagPanel.mButtonOriginPositionList = {};
    for k, v in pairs(UIRolePanelTagPanel.mButtonList) do
        table.insert(UIRolePanelTagPanel.mButtonOriginPositionList, v.transform.localPosition);
    end
end
--endregion

--region 功能
---刷新面板
function UIRolePanelTagPanel:RefreshPanel(openPanelName, action, customData)
    if UIRolePanelTagPanel.CurrentPanelName ~= openPanelName and UIRolePanelTagPanel.IsBusyCount == 0 then
        UIRolePanelTagPanel.IsBusyCount = UIRolePanelTagPanel.IsBusyCount + 1
        if UIRolePanelTagPanel.CurrentPanelName ~= nil then
            uimanager:ClosePanel(UIRolePanelTagPanel.CurrentPanelName)
        end
        UIRolePanelTagPanel:OpenPanel(openPanelName, action, customData)
    end
end

---打开面板
function UIRolePanelTagPanel:OpenPanel(PanelName, action, mCustomData)
    uimanager:CreatePanel(PanelName, function(panel)
        UIRolePanelTagPanel.AllPanelList[PanelName] = panel
        if action ~= nil and panel then
            action(panel)
        end
        if UIRolePanelTagPanel.IsBusyCount > 0 then
            UIRolePanelTagPanel.IsBusyCount = UIRolePanelTagPanel.IsBusyCount - 1
        end
    end, mCustomData)
    UIRolePanelTagPanel.CurrentPanelName = PanelName
end

function UIRolePanelTagPanel:RefreshTagCheck()
    UIRolePanelTagPanel.outlookCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 9 and 1 or 0

    UIRolePanelTagPanel.collectionCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 8 and 1 or 0

    UIRolePanelTagPanel.officialCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 7 and 1 or 0

    UIRolePanelTagPanel.roleCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 1 and 1 or 0

    UIRolePanelTagPanel.innpowerCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 4 and 1 or 0

    UIRolePanelTagPanel.reincarnationCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 2 and 1 or 0

    UIRolePanelTagPanel.militaryRankCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 3 and 1 or 0

    UIRolePanelTagPanel.potentialCheckMark.alpha = UIRolePanelTagPanel.mCurTagIndex == 10 and 1 or 0

    UIRolePanelTagPanel.zhuangbeiCheckmark.alpha = UIRolePanelTagPanel.mCurTagIndex == 5 and 1 or 0

    UIRolePanelTagPanel.sealMarkCheckmark.alpha = UIRolePanelTagPanel.mCurTagIndex == 6 and 1 or 0

end

--region 按钮渐入动画
function UIRolePanelTagPanel:PlayButtonsFadeIn()
    if (UIRolePanelTagPanel.mButtonsFadeInCoroutine ~= nil) then
        UIRolePanelTagPanel.mButtonsFadeInCoroutine = StopCoroutine(UIRolePanelTagPanel.mButtonsFadeInCoroutine);
        UIRolePanelTagPanel.mButtonsFadeInCoroutine = nil;
    end
    UIRolePanelTagPanel.mButtonsFadeInCoroutine = StartCoroutine(UIRolePanelTagPanel.IEnumButtonsFadeIn, UIRolePanelTagPanel);
end

function UIRolePanelTagPanel:IEnumButtonsFadeIn()
    if (UIRolePanelTagPanel.mButtonList == nil or UIRolePanelTagPanel.mButtonOriginPositionList == nil) then
        return ;
    end
    self:AdjustBGSize(#UIRolePanelTagPanel.mButtonList)
    for k, v in pairs(UIRolePanelTagPanel.mButtonList) do
        v:SetActive(false);
    end

    for k, v in pairs(UIRolePanelTagPanel.mButtonList) do
        v:SetActive(true);
        if (UIRolePanelTagPanel.mTweenPositionList == nil) then
            UIRolePanelTagPanel.mTweenPositionList = {};
        end
        if (UIRolePanelTagPanel.mTweenAlphaList == nil) then
            UIRolePanelTagPanel.mTweenAlphaList = {};
        end

        if (UIRolePanelTagPanel.mTweenPositionList[k] == nil) then
            UIRolePanelTagPanel.mTweenPositionList[k] = CS.Utility_Lua.GetComponent(v, "TweenPosition");
            if (UIRolePanelTagPanel.mTweenPositionList[k] == nil) then
                UIRolePanelTagPanel.mTweenPositionList[k] = v:AddComponent(typeof(CS.TweenPosition));
                UIRolePanelTagPanel.mTweenPositionList[k].duration = 0.2;
            end
        end

        if (UIRolePanelTagPanel.mTweenAlphaList[k] == nil) then
            UIRolePanelTagPanel.mTweenAlphaList[k] = CS.Utility_Lua.GetComponent(v, "TweenAlpha");
            if (UIRolePanelTagPanel.mTweenAlphaList[k] == nil) then
                UIRolePanelTagPanel.mTweenAlphaList[k] = v:AddComponent(typeof(CS.TweenAlpha));
                UIRolePanelTagPanel.mTweenAlphaList[k].duration = 0.2;
            end
        end

        local originPosition = UIRolePanelTagPanel.mButtonOriginPositionList[k] == nil and CS.UnityEngine.Vector3.zero or UIRolePanelTagPanel.mButtonOriginPositionList[k];
        UIRolePanelTagPanel.mTweenPositionList[k].from = CS.UnityEngine.Vector3(originPosition.x - 50, originPosition.y, originPosition.z);
        UIRolePanelTagPanel.mTweenPositionList[k].to = originPosition;
        UIRolePanelTagPanel.mTweenPositionList[k]:PlayTween();

        UIRolePanelTagPanel.mTweenAlphaList[k].from = 0;
        UIRolePanelTagPanel.mTweenAlphaList[k].to = 1;
        UIRolePanelTagPanel.mTweenAlphaList[k]:PlayTween();
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.05));
    end
end
--endregion

--region 适配bg大小
---调整bg的尺寸
---@param buttonCount number
function UIRolePanelTagPanel:AdjustBGSize(buttonCount)
    local upIndent = 0
    local downIndent = 0
    local buttonInterval = 80
    local height = self.bgSprite.height
    height = buttonInterval * buttonCount + upIndent + downIndent
    self.bgSprite.height = height
end
--endregion

--endregion

--region otherFunction
---根据战力获取item
function UIRolePanelTagPanel.GetItemForFightPower()
    local isOpen = CS.CSSystemController.Sington:CheckSystem(Utility.EnumToInt(CS.CSSystemEnum.MilitaryRank))
    if not isOpen then
        return
    end
    local maxFightPower = CS.CSScene.MainPlayerInfo.MaxFightPower
    local militaryRankDic = CS.Cfg_PrefixTableManager.Instance.dic
    local prefixItem = nil
    if militaryRankDic.Count == 0 or militaryRankDic == nil then
        return nil
    end
    for k, v in pairs(militaryRankDic) do
        if v.nbvalue <= maxFightPower then
            prefixItem = v
            break
        end
    end
    return prefixItem

end
--endregion

--region Update
function update()
    UIRolePanelTagPanel:OnUpdate()
end

function UIRolePanelTagPanel:OnUpdate()
    if self.time == nil then
        self.time = 0
    end
    self.time = self.time + CS.UnityEngine.Time.deltaTime
    if self.CheckRefreshCachePanel and self.time > self.CheckRefreshCachePanel then
        self:CheckAndTryOpenCachePanel()
    end
end

---设置创建面板参数缓存
function UIRolePanelTagPanel:SetCreatePanel(customData, callBack)
    self.customData = customData
    self.callBack = callBack
    self.CheckRefreshCachePanel = self.time + 0.15
end

---检测并尝试开启缓存面板
function UIRolePanelTagPanel:CheckAndTryOpenCachePanel()
    self.CheckRefreshCachePanel = nil
    if UIRolePanelTagPanel.IsBusyCount > 0 and self.customData ~= nil then
        UIRolePanelTagPanel.IsBusyCount = 0
        self:Show(self.customData, self.callBack)
    end
    self.customData = nil
    self.callBack = nil
end
--endregion

--region OnDestroy
function UIRolePanelTagPanel:OnDestroy()

    ---关闭所有打开过的面板
    if (UIRolePanelTagPanel.mButtonsFadeInCoroutine ~= nil) then
        UIRolePanelTagPanel.mButtonsFadeInCoroutine = StopCoroutine(UIRolePanelTagPanel.mButtonsFadeInCoroutine);
        UIRolePanelTagPanel.mButtonsFadeInCoroutine = nil;
    end

    for k, v in pairs(UIRolePanelTagPanel.AllPanelList) do
        uimanager.SetPanelToBeDestroyed(v)
    end
    UIRolePanelTagPanel.AllPanelList = {}

    if (luaEventManager.HasCallback(LuaCEvent.MainMenus_LeftFadeIn)) then
        luaEventManager.DoCallback(LuaCEvent.MainMenus_LeftFadeIn, "UIRolePanelTagPanel")
    end
end

function start()
    Utility.TryFadeOutMainMenusLeft("UIRolePanelTagPanel");
end

function ondestroy()
    UIRolePanelTagPanel:OnDestroy()
end
--endregion

return UIRolePanelTagPanel