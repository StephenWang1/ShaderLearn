---帮会申请界面
---@class UIGuildApplicationsPanel:UIBase
local UIGuildApplicationsPanel = {}

local Utility = Utility

--region 局部变量
---申请入会玩家列表
UIGuildApplicationsPanel.mApplyListContainer = nil
---帮会信息
UIGuildApplicationsPanel.mUnionInfo = nil
---玩家ID
UIGuildApplicationsPanel.mPlayerID = nil
---是否在设置状态
UIGuildApplicationsPanel.mSetting = false
---设置item信息
UIGuildApplicationsPanel.mSettingInfo = {}
---设置当前选中等级
UIGuildApplicationsPanel.mCurrentChooseLevel = nil
---当前选中显示的边框
UIGuildApplicationsPanel.mCurrentChoose = nil
---当前选中等级设置
UIGuildApplicationsPanel.mChooseLevel = nil
---拉黑信息
UIGuildApplicationsPanel.mPullBlackInfo = nil

--endregion

--region 组件
---申请入会Container
function UIGuildApplicationsPanel.GetApplyContainer_UIGridContainer()
    if UIGuildApplicationsPanel.mGuildList == nil then
        UIGuildApplicationsPanel.mGuildList = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/GuildList/container", "UIGridContainer")
    end
    return UIGuildApplicationsPanel.mGuildList
end
---一键同意入会申请
function UIGuildApplicationsPanel.GetAllAgreeButton_GameObject()
    if UIGuildApplicationsPanel.mAllAgreeButton == nil then
        UIGuildApplicationsPanel.mAllAgreeButton = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/btn_allagree", "GameObject")
    end
    return UIGuildApplicationsPanel.mAllAgreeButton
end
---一键忽略
function UIGuildApplicationsPanel.GetAllDisagreeButton_GameObject()
    if UIGuildApplicationsPanel.mAllDisagreeButton == nil then
        UIGuildApplicationsPanel.mAllDisagreeButton = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/btn_alldisagree", "GameObject")
    end
    return UIGuildApplicationsPanel.mAllDisagreeButton
end
---黑名单
function UIGuildApplicationsPanel.GetBlackListButton_GameObject()
    if UIGuildApplicationsPanel.mBlackListButton == nil then
        UIGuildApplicationsPanel.mBlackListButton = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/btn_blacklist", "GameObject")
    end
    return UIGuildApplicationsPanel.mBlackListButton
end
---@return UnityEngine.GameObject 设置自动通过按钮
function UIGuildApplicationsPanel:GetSettingButton_GameObject()
    if self.mSettingButton == nil then
        self.mSettingButton = self:GetCurComp("WidgetRoot/btn_set", "GameObject")
    end
    return self.mSettingButton
end
---设置Container
function UIGuildApplicationsPanel.GetSettingContainer_UIContainer()
    if UIGuildApplicationsPanel.mSettingContainer == nil then
        UIGuildApplicationsPanel.mSettingContainer = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings/PresiShow/Grid", "UIGridContainer")
    end
    return UIGuildApplicationsPanel.mSettingContainer
end
---显示自动通过等级
function UIGuildApplicationsPanel.GetShowSettingLabel_UILabel()
    if UIGuildApplicationsPanel.mShowSettingLabel == nil then
        UIGuildApplicationsPanel.mShowSettingLabel = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings/Text", "UILabel")
    end
    return UIGuildApplicationsPanel.mShowSettingLabel
end
---箭头显示
function UIGuildApplicationsPanel.GetSettingArrow_GameObject()
    if UIGuildApplicationsPanel.mSettingArrow == nil then
        UIGuildApplicationsPanel.mSettingArrow = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings/PresiShow/select", "GameObject")
    end
    return UIGuildApplicationsPanel.mSettingArrow
end

---@return UnityEngine.GameObject 关闭界面按钮
function UIGuildApplicationsPanel:GetCloseButton_GameObject()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/panel/btn_close", "GameObject")
    end
    return self.mCloseButton
end

---设置自动通过界面
function UIGuildApplicationsPanel.GetSettingPanel_GameObject()
    if UIGuildApplicationsPanel.mSettingPanel == nil then
        UIGuildApplicationsPanel.mSettingPanel = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings", "GameObject")
    end
    return UIGuildApplicationsPanel.mSettingPanel
end
---获取下拉列表
function UIGuildApplicationsPanel.GetSettingPopupList_UIPopupList()
    if UIGuildApplicationsPanel.mSettingPopupList == nil then
        UIGuildApplicationsPanel.mSettingPopupList = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings/set", "UIPopupList")
    end
    return UIGuildApplicationsPanel.mSettingPopupList
end
---取消设置
function UIGuildApplicationsPanel.CancelSetting_GameObject()
    if UIGuildApplicationsPanel.mCancelSetting == nil then
        UIGuildApplicationsPanel.mCancelSetting = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings/LeftBtn", "GameObject")
    end
    return UIGuildApplicationsPanel.mCancelSetting
end
---同意设置
function UIGuildApplicationsPanel.ConfirmSetting_GameObject()
    if UIGuildApplicationsPanel.mConfirmSetting == nil then
        UIGuildApplicationsPanel.mConfirmSetting = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings/RightBtn", "GameObject")
    end
    return UIGuildApplicationsPanel.mConfirmSetting
end
---关闭设置按钮
function UIGuildApplicationsPanel.GetCloseSetting_GameObject()
    if UIGuildApplicationsPanel.mCloseSetting == nil then
        UIGuildApplicationsPanel.mCloseSetting = UIGuildApplicationsPanel:GetCurComp("WidgetRoot/apply_settings/Close", "GameObject")
    end
    return UIGuildApplicationsPanel.mCloseSetting
end

---@return UnityEngine.GameObject 无人申请GO
function UIGuildApplicationsPanel:GetNoApply_Go()
    if self.mNoApplyGo == nil then
        self.mNoApplyGo = self:GetCurComp("WidgetRoot/noApply", "GameObject")
    end
    return self.mNoApplyGo
end
--endregion

--region 属性
---@return CSPlayerInfo 玩家信息
function UIGuildApplicationsPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2 帮会信息
function UIGuildApplicationsPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end
--endregion

--region 初始化
function UIGuildApplicationsPanel:Init()
    self:BindEvents()
    self:BindMessage()
    self:InitPanel()
    UIGuildApplicationsPanel.InitData()
end

function UIGuildApplicationsPanel:Show()
    networkRequest.ReqGetApplyListInfo()
end

function UIGuildApplicationsPanel:BindMessage()
    UIGuildApplicationsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionApplicationInfoChange, function()
        self:OnResSendApplyListInfoMessageReceived()
    end)
end

function UIGuildApplicationsPanel:BindEvents()
    CS.UIEventListener.Get(UIGuildApplicationsPanel.GetAllAgreeButton_GameObject()).onClick = UIGuildApplicationsPanel.OnAllAgreeClicked
    CS.UIEventListener.Get(UIGuildApplicationsPanel.GetAllDisagreeButton_GameObject()).onClick = UIGuildApplicationsPanel.OnAllDisagreeClicked
    CS.UIEventListener.Get(UIGuildApplicationsPanel.GetBlackListButton_GameObject()).onClick = UIGuildApplicationsPanel.OnBlackListClicked
    CS.UIEventListener.Get(self:GetSettingButton_GameObject()).onClick = UIGuildApplicationsPanel.OnSettingClicked
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(UIGuildApplicationsPanel.CancelSetting_GameObject()).onClick = UIGuildApplicationsPanel.OnCloseSettingButtonClicked
    CS.UIEventListener.Get(UIGuildApplicationsPanel.ConfirmSetting_GameObject()).onClick = UIGuildApplicationsPanel.OnConfirmSettingButtonClicked
    CS.UIEventListener.Get(UIGuildApplicationsPanel.GetCloseSetting_GameObject()).onClick = UIGuildApplicationsPanel.OnCloseSettingButtonClicked
end
--endregion

--region 服务器事件
---收到帮会申请列表消息
function UIGuildApplicationsPanel:OnResSendApplyListInfoMessageReceived()
    UIGuildApplicationsPanel.OnCloseSettingButtonClicked()
    UIGuildApplicationsPanel.mUnionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2
    UIGuildApplicationsPanel.mPlayerID = CS.CSScene.MainPlayerInfo.ID
    --设置申请列表
    local applyListContainer = UIGuildApplicationsPanel.GetApplyContainer_UIGridContainer()
    if UIGuildApplicationsPanel.mUnionInfo.ApplyInfo then
        local applyList = UIGuildApplicationsPanel.mUnionInfo.ApplyInfo.applyInfo
        UIGuildApplicationsPanel.mApplyListContainer = {}
        applyListContainer.MaxCount = applyList.Count
        self:GetNoApply_Go():SetActive(applyList.Count <= 0)
        for i = 0, applyList.Count - 1 do
            local itemContainer = applyListContainer.controlList[i]
            local toggle = CS.Utility_Lua.GetComponent(itemContainer, "UIToggle")
            local info = applyList[i]
            --名字
            CS.Utility_Lua.GetComponent(itemContainer.transform:Find("lb_name"), "UILabel").text = "[c9b39c]" .. info.memberName
            --头像
            local icon = CS.Utility_Lua.GetComponent(itemContainer.transform:Find("head/headIcon"), "UISprite")
            if icon then
                icon .spriteName = Utility.GetPlayerHeadIconSpriteName(info.sex, info.career)
            end
            --等级
            local levelLabel = CS.Utility_Lua.GetComponent(itemContainer.transform:Find("head/level"), "UILabel")
            if levelLabel and info.memberLevel then
                levelLabel.text = info.memberLevel
            end
            --按钮
            local black = itemContainer.transform:Find("blackRoot").gameObject
            local agree = itemContainer.transform:Find("agreeRoot").gameObject
            local agreeButton = agree.transform:Find("btn_agree").gameObject
            local opposeButton = agree.transform:Find("btn_oppose").gameObject
            local refuseButton = black.transform:Find("btn_pullblack").gameObject
            --local bg = CS.Utility_Lua.GetComponent(itemContainer.transform:Find("bg"), "UISprite")
            --bg.color = ternary(i % 2 == 0, LuaEnumUnityColorType.Transparent, LuaEnumUnityColorType.Normal)
            black:SetActive(info.hasRefuse)
            agree:SetActive(not info.hasRefuse)
            CS.UIEventListener.Get(agreeButton).onClick = function(go)
                self:OnAgreeClicked(go, info.roleId)
            end
            CS.UIEventListener.Get(opposeButton, info.roleId).onClick = UIGuildApplicationsPanel.OnOpposeClicked
            CS.UIEventListener.Get(refuseButton, { info.roleId, info.memberName }).onClick = UIGuildApplicationsPanel.OnPullBlackClicked
        end
        UIGuildApplicationsPanel.mChooseLevel = UIGuildApplicationsPanel.mUnionInfo.ApplyInfo.automaticPassing
        UIGuildApplicationsPanel.SetGrid(UIGuildApplicationsPanel.mChooseLevel)
    else
        applyListContainer.MaxCount = 0
        self:GetNoApply_Go():SetActive(true)
    end
    --设置按钮显示
    self:GetSettingButton_GameObject():SetActive(self:GetUnionInfoV2():CanChangeJoinUnionLevel())
end
--endregion

--region UI事件
---关闭选中页签
function UIGuildApplicationsPanel.OnCloseChooseButtonClicked()
    if UIGuildApplicationsPanel.mCurrentChoose ~= nil then
        UIGuildApplicationsPanel.mCurrentChoose:Set(false)
    end
end
---点击设置按钮
function UIGuildApplicationsPanel.OnSettingClicked(go)
    if not CS.StaticUtility.IsNull(UIGuildApplicationsPanel.GetSettingPanel_GameObject()) then
        UIGuildApplicationsPanel.GetSettingPopupList_UIPopupList().value = ternary(UIGuildApplicationsPanel.mChooseLevel == 0, "关闭", UIGuildApplicationsPanel.mChooseLevel)
        UIGuildApplicationsPanel.GetSettingPanel_GameObject():SetActive(true)
    end
end
---点击设置
function UIGuildApplicationsPanel.OnSettingGridClicked()
    local container = UIGuildApplicationsPanel.GetSettingContainer_UIContainer()
    UIGuildApplicationsPanel.mSetting = not UIGuildApplicationsPanel.mSetting
    container.gameObject:SetActive(UIGuildApplicationsPanel.mSetting)
    local rotate
    if UIGuildApplicationsPanel.mSetting then
        rotate = 180
    else
        rotate = 0
    end
    UIGuildApplicationsPanel.GetSettingArrow_GameObject().transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, rotate)
end
---设置显示的按钮
function UIGuildApplicationsPanel.SetGrid(currentValue)
    local info = CS.Cfg_GlobalTableManagerBase.Instance:GetUnionLimit(20034)
    local list = {}
    for i = 0, info.Count - 1 do
        local showInfo = ternary(info[i] == 0, "关闭", tostring(info[i]))
        table.insert(list, showInfo)
    end
    UIGuildApplicationsPanel.GetSettingPopupList_UIPopupList().items = list
    UIGuildApplicationsPanel.GetSettingPopupList_UIPopupList().value = ternary(currentValue == 0, "关闭", currentValue)
end
---设置自动通过
function UIGuildApplicationsPanel.OnAutoAgreeApplyClicked(go)
    if UIGuildApplicationsPanel.mCurrentChoose ~= nil then
        UIGuildApplicationsPanel.mCurrentChoose:SetActive(false)
    end
    local chooseInfo = UIGuildApplicationsPanel.mSettingInfo[go]
    UIGuildApplicationsPanel.mCurrentChooseLevel = chooseInfo
    local choose = go.transform:Find("Select").gameObject
    choose:SetActive(true)
    UIGuildApplicationsPanel.mCurrentChoose = choose

end

---同意申请
function UIGuildApplicationsPanel:OnAgreeClicked(go, roleID)
    local callBack = function()
        networkRequest.ReqCheckApplyList(UIGuildApplicationsPanel.mPlayerID, roleID, 2)
    end
    if UIGuildApplicationsPanel:CanDealApplyInfo(go, callBack) then
        networkRequest.ReqCheckApplyList(UIGuildApplicationsPanel.mPlayerID, roleID, 2)
    end
end

---@return TABLE.CFG_PROMPTWORD  拥挤描述
function UIGuildApplicationsPanel:GetCrownTypeDesInfo()
    if self.mCrownDes == nil then
        ___, self.mCrownDes = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(45)
    end
    return self.mCrownDes
end

---忽略申请
function UIGuildApplicationsPanel.OnOpposeClicked(go)
    local roleID = CS.UIEventListener.Get(go).parameter
    networkRequest.ReqCheckApplyList(UIGuildApplicationsPanel.mPlayerID, roleID, 1)
end

---拉黑申请
function UIGuildApplicationsPanel.OnPullBlackClicked(go)
    if UIGuildApplicationsPanel.mPullBlackInfo then
        local info = CS.UIEventListener.Get(go).parameter
        local PromptInfo = {
            Title = UIGuildApplicationsPanel.mPullBlackInfo.title,
            LeftDescription = UIGuildApplicationsPanel.mPullBlackInfo.leftButton,
            RightDescription = UIGuildApplicationsPanel.mPullBlackInfo.rightButton,
            ID = UIGuildApplicationsPanel.mPullBlackInfo.id,
            Content = string.format(string.gsub(UIGuildApplicationsPanel.mPullBlackInfo.des, "\\n", '\n'), info[2]),
            CallBack = function()
                networkRequest.ReqCheckApplyList(UIGuildApplicationsPanel.mPlayerID, info[1], 3)
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, PromptInfo)
    end
end

---一键同意申请
function UIGuildApplicationsPanel.OnAllAgreeClicked(go)
    if UIGuildApplicationsPanel:CanDealApplyList(go) then
        local callBack = function()
            local unionID = UIGuildApplicationsPanel.mUnionInfo.UnionID
            networkRequest.ReqAgreeAllRoleJoinUnion(unionID)
        end
        if Utility.IsSabacActivityNotOpen(go) and UIGuildApplicationsPanel:CanDealApplyInfo(go, callBack) then
            callBack()
        end
    end
end

---@return boolean 是否可以发送同意申请 拥挤状态下会长弹窗，非会长弹气泡
function UIGuildApplicationsPanel:CanDealApplyInfo(go, callBack)
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().UnionInfo.unionInfo.crown then
        local isLeader = self:GetUnionInfoV2():IsUnionManager(LuaEnumGuildPosType.ActingPresident)
        if isLeader then
            if self:GetCrownTypeDesInfo() and callBack then
                local CancelInfo = {
                    Title = self:GetCrownTypeDesInfo().title,
                    LeftDescription = self:GetCrownTypeDesInfo().leftButton,
                    RightDescription = self:GetCrownTypeDesInfo().rightButton,
                    Content = self:GetCrownTypeDesInfo().des,
                    ID = self:GetCrownTypeDesInfo().id,
                    CallBack = callBack
                }
                uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
            end
        else
            if (not CS.StaticUtility.IsNull(go)) then
                Utility.ShowPopoTips(go, nil, 188)
            end
        end
        return false
    end
    return true
end

---一键忽略申请
function UIGuildApplicationsPanel.OnAllDisagreeClicked(go)
    if Utility.IsSabacActivityNotOpen(go) and UIGuildApplicationsPanel:CanDealApplyList(go) then
        local unionID = UIGuildApplicationsPanel.mUnionInfo.UnionID
        networkRequest.ReqIgnoreAllRole(unionID)
    end
end

---@return boolean 是否可以处理申请列表 没有申请时气泡
function UIGuildApplicationsPanel:CanDealApplyList(go)
    if self:GetUnionInfoV2().ApplyInfo then
        local applyList = self:GetUnionInfoV2().ApplyInfo.applyInfo
        if applyList.Count <= 0 then
            if not CS.StaticUtility.IsNull(go) then
                Utility.ShowPopoTips(go, nil, 189)
            end
            return false
        end
        return true
    else
        if not CS.StaticUtility.IsNull(go) then
            Utility.ShowPopoTips(go, nil, 189)
        end
        return false
    end
end

---黑名单
function UIGuildApplicationsPanel.OnBlackListClicked(go)
    if Utility.IsSabacActivityNotOpen(go) then
        local unionID = UIGuildApplicationsPanel.mUnionInfo.UnionID
        uimanager:CreatePanel("UIGuildBlackListPanel", function(panel)
            networkRequest.ReqGetBlackApplyRole(nil, unionID)
        end)
    end
end
---初始化界面
function UIGuildApplicationsPanel:InitPanel()
    if UIGuildApplicationsPanel.GetSettingPanel_GameObject() then
        UIGuildApplicationsPanel.GetSettingPanel_GameObject():SetActive(false)
    end
    self.GetBlackListButton_GameObject():SetActive(self:GetUnionInfoV2():CanDeleteBlackList())
    self:GetSettingButton_GameObject():SetActive(false)
    self:OnResSendApplyListInfoMessageReceived()
end
---关闭设置界面
function UIGuildApplicationsPanel.OnCloseSettingButtonClicked()
    if UIGuildApplicationsPanel.GetSettingPanel_GameObject() then
        UIGuildApplicationsPanel.GetSettingPanel_GameObject():SetActive(false)
    end
end
---确认设置界面
function UIGuildApplicationsPanel.OnConfirmSettingButtonClicked()
    local value = UIGuildApplicationsPanel.GetSettingPopupList_UIPopupList().value
    local reqValue = ternary(value == "关闭", 0, tonumber(value))
    networkRequest.ReqAutomaticPassing(nil, reqValue)
end
---初始化数据
function UIGuildApplicationsPanel.InitData()
    UIGuildApplicationsPanel.mPullBlackInfo = UIGuildApplicationsPanel.GetPromptData(9)
end
---获取Prompt表数据
function UIGuildApplicationsPanel.GetPromptData(dataId)
    local res, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(dataId)
    if res then
        return info
    end
    return nil
end

--endregion

--region onDestroy
function ondestroy()
    UIGuildApplicationsPanel:GetUnionInfoV2():ClickApplyBtn()
    ---@type UIGuildMemberListPanel
    local memberPanel = uimanager:GetPanel("UIGuildMemberListPanel")
    if memberPanel then
        memberPanel:RefreshApplyEffect()
    end

end
--endregion

--region 刷新一次界面显示
function UIGuildApplicationsPanel:ShowPanel()
    --   UIGuildApplicationsPanel.mSetting = false
    --  UIGuildApplicationsPanel.GetSettingContainer_UIContainer().gameObject:SetActive(UIGuildApplicationsPanel.mSetting)

end
--endregion

return UIGuildApplicationsPanel