---帮会界面
---@class UIGuildPanel:UIBase
local UIGuildPanel = {}

--region局部变量定义
---当前界面类型
---@type number
UIGuildPanel.mCurrentPanelType = nil

---需要显示Toggle
---@type table<number,UIToggle>
UIGuildPanel.mToggleTable = {}

---帮会Toggle名字
UIGuildPanel.mTypeName = {
    [LuaEnumGuildPanelType.GuildInfo] = "行会总览",
    [LuaEnumGuildPanelType.GuildMember] = "行会成员",
    [LuaEnumGuildPanelType.GuildWarehouse] = "行会仓库",
    [LuaEnumGuildPanelType.GuildWelfare] = "行会繁荣",
    [LuaEnumGuildPanelType.GuildActivity] = "行会活动",
    [LuaEnumGuildPanelType.GuildSmelt] = "行会熔炼",
}

---界面类型对应Toggle
---@type table<number,UIToggle>
UIGuildPanel.mTypeToToggle = {}

---类型对应界面
---@type table<number,panel>
UIGuildPanel.mTypeToPanel = {}

---开始创建名字列表
---@type table<number,string>
UIGuildPanel.mAllPanelName = {}

---格子对应type
---@type table<UnityEngine.GameObject,number>
UIGuildPanel.mGoToType = {}

--endregion

--region组件
---@return UIGridContainer 帮会ToggleContainer
function UIGuildPanel:GetToggleContainer_UIGridContainer()
    if self.mGridContainer == nil then
        self.mGridContainer = self:GetCurComp("WidgetRoot/event/Scroll View/MainBookMarkList", "UIGridContainer")
    end
    return self.mGridContainer
end

---@return UnityEngine.GameObject 关闭按钮
function UIGuildPanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end
--endregion

--region 属性
---@return CSPlayerInfo 玩家信息
function UIGuildPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2 帮会所有信息
function UIGuildPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil then
        if self:GetPlayerInfo() then
            self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mUnionInfoV2
end
--endregion

--region 初始化
function UIGuildPanel:Init()
    self.mAllPanelName = {}
    self:BindEvent()
    self:BindMessage()
    networkRequest.ReqSendAllUnionInfo()
end

function UIGuildPanel:Show(customData)
    local type = self:GetRedPointShowType()
    if customData and customData.type then
        type = customData.type
    end
    if customData and customData.isOpenAccusePanel then
        self.isOpenAccusePanel = true
    end
    ---@type UIMainChatPanel
    local uiMainChatPanel = uimanager:GetPanel("UIMainChatPanel");
    if (uiMainChatPanel ~= nil) then
        uiMainChatPanel.UIOpenIsShow();
        uiMainChatPanel.RefreshUIPanel(LuaEnumSocialPanelType.GuildPanel, true, nil)
    end
    self:RefreshPanelShow(type)
end

---获取红点导致的帮会跳转位置
function UIGuildPanel:GetRedPointShowType()

    local isShowGuildApply = CS.CSUIRedPointManager.GetInstance():IsShowUnionApplyRedPoint()
    if isShowGuildApply then
        return LuaEnumGuildPanelType.GuildMember
    end
    local isShowGuildABenefits = CS.CSUIRedPointManager.GetInstance():IsShowUnionBenefitRedPoint()
    if isShowGuildABenefits then
        return LuaEnumGuildPanelType.GuildWelfare
    end
    return LuaEnumGuildPanelType.GuildInfo
end

function UIGuildPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoDoMission, function()
        uimanager:ClosePanel('UIGuildPanel')
    end);
end

function UIGuildPanel:BindMessage()
    uimanager:ClosePanel("UICreateGuildPanel")
    self.OnGuildChanged = function()
        if self:GetUnionInfoV2().UnionID == 0 then
            self:ClosePanel()
            return
        end
        self:RefreshPanelShow()
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.UnionIDChange, self.OnGuildChanged)
end

--endregion

--region UI事件
---刷新界面显示
function UIGuildPanel:RefreshPanelShow(chooseType)
    self:GetNeedShowToggle()
    self:InitToggle()
    self:ChooseToggle(chooseType)
end

---获取需要显示Toggle
function UIGuildPanel:GetNeedShowToggle()
    self.mToggleTable = {}
    self:AddShowToggle(LuaEnumGuildPanelType.GuildInfo)
    self:AddShowToggle(LuaEnumGuildPanelType.GuildMember)
    --self:AddShowToggle(LuaEnumGuildPanelType.GuildWarehouse)
    -- self:AddShowToggle(LuaEnumGuildPanelType.GuildSmelt)
    self:AddShowToggle(LuaEnumGuildPanelType.GuildWelfare)
    self:AddShowToggle(LuaEnumGuildPanelType.GuildActivity)
end

---添加需要显示Toggle
function UIGuildPanel:AddShowToggle(type)
    table.insert(self.mToggleTable, type)
end

---初始化Toggle
function UIGuildPanel:InitToggle()
    self.mTypeToToggle = {}
    self.mGoToType = {}
    self:GetToggleContainer_UIGridContainer().MaxCount = #self.mToggleTable
    for i = 1, #self.mToggleTable do
        local type = self.mToggleTable[i]
        local go = self:GetToggleContainer_UIGridContainer().controlList[i - 1]
        self.mGoToType[go] = type
        local toggle = self:GetToggle(go)
        self.mTypeToToggle[type] = toggle

        local bgLabel = CS.Utility_Lua.GetComponent(go.transform:Find("background/Label"), "UILabel")
        local ckLabel = CS.Utility_Lua.GetComponent(go.transform:Find("checkmark/Label"), "UILabel")
        local name = self.mTypeName[type]
        if not CS.StaticUtility.IsNull(bgLabel) and not CS.StaticUtility.IsNull(ckLabel) then
            bgLabel.text = name
            ckLabel.text = name
        end

        ---@type UIRedPoint
        local redPoint = CS.Utility_Lua.GetComponent(go.transform:Find("redPoint"), "UIRedPoint")
        if not CS.StaticUtility.IsNull(redPoint) then
            self:AddRedPointKey(type, redPoint)
        end
    end
end

---@param type number 类型
---@param redPoint UIRedPoint 红点
function UIGuildPanel:AddRedPointKey(type, redPoint)
    if type == LuaEnumGuildPanelType.GuildMember then
        redPoint:AddRedPointKey(CS.RedPointKey.UNION_APPLY)
        redPoint:AddRedPointKey(CS.RedPointKey.UNION_REVENGE)
    elseif type == LuaEnumGuildPanelType.GuildWelfare then
        redPoint:AddRedPointKey(CS.RedPointKey.UNION_BENEFIT)
    end
end

---获取Obj对应Toggle
---@param go UnityEngine.GameObject
---@return UIToggle
function UIGuildPanel:GetToggle(go)
    if self.mGoToToggle == nil then
        ---@type table<UnityEngine.GameObject,UIToggle>
        self.mGoToToggle = {}
    end
    local toggle = self.mGoToToggle[go]
    if toggle == nil then
        toggle = CS.Utility_Lua.GetComponent(go, "UIToggle")
        self.mGoToToggle[go] = toggle
        if toggle then
            CS.EventDelegate.Add(toggle.onChange, function()
                if toggle.value then
                    local type = self.mGoToType[go]
                    if type then
                        self:SwitchToPanel(type)
                    end
                end
                Utility.HideBackGround(toggle, "background", toggle.value)
            end)
        end
    end
    if toggle and toggle.value then
        toggle:Set(false)
    end
    return toggle
end

---初始化选中Toggle
function UIGuildPanel:ChooseToggle(chooseType)
    local type = LuaEnumGuildPanelType.GuildInfo
    if chooseType then
        type = chooseType
    end
    local toggle = self.mTypeToToggle[type]
    if toggle then
        toggle:Set(true)
    end
end

---切换界面
function UIGuildPanel:SwitchToPanel(type)
    if type == self.mCurrentPanelType then
        return
    end
    --[[    if self.mCurrentPanelType then
            local panel = self.mTypeToPanel[self.mCurrentPanelType]
            if panel then
                uimanager:HidePanel(panel)
            end
        end]]
    self.mCurrentPanelType = type
    local panel = self.mTypeToPanel[type]
    if panel then
        uimanager:ReShowPanel(panel)
        panel:Show()
        self:HideOtherPanel()
    else
        self:CreatePanel(type)
    end
end

function UIGuildPanel:HideOtherPanel()
    if self.mTypeToPanel and self.mCurrentPanelType then
        for k, v in pairs(self.mTypeToPanel) do
            if k ~= self.mCurrentPanelType then
                if v.go and v.go.activeSelf then
                    uimanager:HidePanel(v)
                end
            end
        end
    end
end

---创建界面
function UIGuildPanel:CreatePanel(type)
    local panelName
    if type == LuaEnumGuildPanelType.GuildInfo then
        panelName = "UIGuildInfoPanel"
    elseif type == LuaEnumGuildPanelType.GuildMember then
        panelName = "UIGuildMemberListPanel"
    elseif type == LuaEnumGuildPanelType.GuildWarehouse then
        panelName = "UIGuildBagPanel"
    elseif type == LuaEnumGuildPanelType.GuildSmelt then
        panelName = "UIGuildSmeltPanel"
    elseif type == LuaEnumGuildPanelType.GuildWelfare then
        panelName = "UIGuildBenefitsPanel"
    elseif type == LuaEnumGuildPanelType.GuildActivity then
        panelName = "UIGuildActivitiesPanel"
    end
    if panelName then
        local customData = {}
        if type == LuaEnumGuildPanelType.GuildInfo then
            customData.isOpenAccusePanel = self.isOpenAccusePanel
        end

        table.insert(self.mAllPanelName, panelName)
        uimanager:CreatePanel(panelName, function(panel)
            self.mTypeToPanel[type] = panel
            self:HideOtherPanel()
        end, customData)
    end
end
--endregion

function UIGuildPanel.GetProsperity(currentUnionRank)
    if currentUnionRank == 1 then

    else

    end
end

--region OnDestroy
function ondestroy()
    luaEventManager.DoCallback(LuaCEvent.CloseMainChatPanel)
    for i = 1, #UIGuildPanel.mAllPanelName do
        uimanager:ClosePanel(UIGuildPanel.mAllPanelName[i])
    end
    uimanager:ClosePanel("UIGuildApplicationsPanel")
end
--endregion

return UIGuildPanel