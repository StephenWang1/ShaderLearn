---@class UIUnionManagerPanel:UIBase 帮会推送NPC面板
local UIUnionManagerPanel = {}

--region局部变量定义
--region 组件
---@return UnityEngine.GameObject 申请按钮特效
function UIUnionManagerPanel:GetApplyEffect_GameObject()
    if self.mApplyBtneffect == nil then
        self.mApplyBtneffect = self:GetCurComp("WidgetRoot/view/levelEnough/ApplyBtn/effect", "GameObject")
    end
    return self.mApplyBtneffect
end

---@return UILabel 等级不足提示
function UIUnionManagerPanel:GetLevelNotEnoughDes_UILabel()
    if self.mLevelNotEnoughDes == nil then
        self.mLevelNotEnoughDes = self:GetCurComp("WidgetRoot/view/LevelNotEnough", "UILabel")
    end
    return self.mLevelNotEnoughDes
end

---@return UILabel 推送帮会名字
function UIUnionManagerPanel:GetPushUnionName_UILabel()
    if self.mPushUnionLabel == nil then
        self.mPushUnionLabel = self:GetCurComp("WidgetRoot/view/levelEnough/unionName", "UILabel")
    end
    return self.mPushUnionLabel
end
--endregion

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIUnionManagerPanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject 申请按钮
function UIUnionManagerPanel:GetApplyBtn_GameObject()
    if self.mApplyBtn == nil then
        self.mApplyBtn = self:GetCurComp("WidgetRoot/view/btn_allApplication", "GameObject")
    end
    return self.mApplyBtn
end

---@return UnityEngine.GameObject 申请按钮特效
function UIUnionManagerPanel:GetApplyBtn_GameObjectEffect()
    if self.mApplyBtn_GameObjectEffect == nil then
        self.mApplyBtn_GameObjectEffect = self:GetCurComp("WidgetRoot/view/btn_allApplication/buttonEffect", "GameObject")
    end
    return self.mApplyBtn_GameObjectEffect
end

---@return UILabel 申请按钮文字
function UIUnionManagerPanel:GetApplyBtn_UILabel()
    if self.mApplyBtnLabel == nil then
        self.mApplyBtnLabel = self:GetCurComp("WidgetRoot/view/btn_allApplication/Label", "UILabel")
    end
    return self.mApplyBtnLabel
end

----@return UILoopScrollViewPlus 帮会循环组件
function UIUnionManagerPanel:GetUnionList_LoopScrollViewPlus()
    if self.mUnionListLoop == nil then
        self.mUnionListLoop = self:GetCurComp("WidgetRoot/view/ScrollView/Content", "UILoopScrollViewPlus")
    end
    return self.mUnionListLoop
end

---@return UnityEngine.GameObject 帮助按钮
function UIUnionManagerPanel:GetHelpBtn_GameObject()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/view/btn_help", "GameObject")
    end
    return self.mHelpBtn
end
--endregion

--region 属性
---@return CSMainPlayerInfo
function UIUnionManagerPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2
function UIUnionManagerPanel:GetUnionInfoV2()
    if self.mUnionInfo == nil and self:GetPlayerInfo() then
        self.mUnionInfo = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfo
end

--endregion

--region 初始化
function UIUnionManagerPanel:Init()
    self:AddCollider()
    self:BindEvent()
end

function UIUnionManagerPanel:Show(data)
    if data == nil then
        UIUnionManagerPanel.isOpenEffect = false
    else
        UIUnionManagerPanel.isOpenEffect = true
    end
    networkRequest.ReqSendAllUnionInfo()
    self:ShowPanel()
    self:RefreshApplyBtn_GameObjectEffect()
end

function UIUnionManagerPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetApplyBtn_GameObject()).onClick = function(go)
        self:OnApplyBtnClicked(go)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_NPCLeaveView, function(id, data)
        if data == LuaEnumNPCType.UnionManager then
            self:ClosePanel()
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AllUnionInfoChange, function()
        self:OnResSendAllUnionInfoMessageReceived()
    end)
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).onClick = function()
        self:OnHelpBtnClicked()
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoDoMission, function()
        uiStaticParameter.IsAutoSkillOpenPanel=true
        self:OnApplyBtnClicked(nil,false)
    end);
end
--endregion

--region UI事件
---刷新面板显示
function UIUnionManagerPanel:RefreshPanel()
    self.mPushInfo = nil
    if self:GetDescriptionInfo() then
        self:GetDescription_UILabel().text = string.gsub(self:GetDescriptionInfo().value, "\\n", "\n")
    end
    if self:GetPlayerInfo() and self:GetUnionInfoV2() then
        local addUnionLevel = CS.Cfg_GlobalTableManager.Instance:OpenUnionLevel()
        local isArriveLevel = self:GetPlayerInfo().Level >= addUnionLevel
        local hasUnion = self:GetUnionInfoV2().UnionID ~= 0
        self:GetApplyBtn_GameObject():SetActive(isArriveLevel)
        self:GetLevelNotEnoughDes_UILabel().gameObject:SetActive(not isArriveLevel)
        if isArriveLevel then
            self:GetApplyEffect_GameObject().gameObject:SetActive(UIUnionManagerPanel.isOpenEffect)
            self:GetApplyBtn_UILabel().text = ternary(hasUnion, "我的行会", "立即申请")
            CS.UIEventListener.Get(self:GetApplyBtn_GameObject()).onClick = function()
                self:ApplyUnion(hasUnion)
            end
        else
            self:GetLevelNotEnoughDes_UILabel().text = addUnionLevel .. "级开启行会功能"
        end
        local isPush = isArriveLevel and not hasUnion
        self:GetPushUnionName_UILabel().gameObject:SetActive(isPush)
        if isPush then
            self.mPushInfo = self:GetPushUnionInfo()
            if self.mPushInfo then
                self:GetPushUnionName_UILabel().text = self.mPushInfo.unionName
            else
                self:GetApplyBtn_GameObject():SetActive(false)
                self:GetPushUnionName_UILabel().gameObject:SetActive(false)
            end
        end
    end
end

---@return TABLE.CFG_DESCRIPTION 描述
function UIUnionManagerPanel:GetDescriptionInfo()
    if self.mDesInfo == nil then
        ___, self.mDesInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(114)
    end
    return self.mDesInfo
end

function UIUnionManagerPanel:ShowPanel()
    self:GetApplyBtn_UILabel().text = ternary(self:GetUnionInfoV2().UnionID == 0, "全部申请", "我的行会")
    local taskId = CS.Cfg_GlobalTableManager.Instance:GetUnionTaskId()
    ---@type CSMission
    local currentMission = CS.CSMissionManager.Instance:GetMainTask()
    if currentMission then
        local currentTaskID = currentMission.taskId
        if taskId == currentTaskID and self:GetUnionInfoV2().UnionID == 0 then
            Utility.ShowDisplayPopoTips(self:GetApplyBtn_GameObject(), 234)
        end
    end
end


--region 申请入会
---申请加入推荐帮会
function UIUnionManagerPanel:OnApplyBtnClicked(go,isOpenGuildPanel)
    if self:GetUnionInfoV2().UnionID ~= 0 then
        if isOpenGuildPanel==nil or isOpenGuildPanel==true  then
            uimanager:CreatePanel("UIGuildPanel")
        end
        luaEventManager.DoCallback(LuaCEvent.CloseDisplayBubble)
        self:ClosePanel()
    else
        --申请推荐
        local pushInfo = self:GetPushUnionInfo()
        if pushInfo then
            networkRequest.ReqJoinOrWithdrawUnion(pushInfo.unionId, 1)
            luaEventManager.DoCallback(LuaCEvent.CloseDisplayBubble)
            self:ClosePanel()
        end
    end
end
--endregion

---@return unionV2.UnionInfo
function UIUnionManagerPanel:GetPushUnionInfo()
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().PushList and self:GetUnionInfoV2().PushList.Count > 0 then
        return self:GetUnionInfoV2().PushList[0]
    end
end

---收到所有帮会信息
function UIUnionManagerPanel:OnResSendAllUnionInfoMessageReceived()
    if self:GetUnionInfoV2() then
        local unionInfoList = self:GetUnionInfoV2().AllUnionInfo
        if unionInfoList == nil then
            return
        end
        self:GetUnionList_LoopScrollViewPlus():Init(function(itemGo, line)
            if line < unionInfoList.Count then
                local template = self:GetGridTemplate(itemGo)
                local data = unionInfoList[line]
                if template then
                    template:RefreshItem(data, line)
                end
                return true
            else
                return false
            end
        end)
    end
end

---@return UIGuildListPanel_GirdTemplate 获取帮会格子模板
function UIUnionManagerPanel:GetGridTemplate(go)
    if self.mGridToTemplate == nil then
        self.mGridToTemplate = {}
    end
    local template = self.mGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildListPanel_GirdTemplate, self)
    end
    return template
end

---点击帮助按钮
function UIUnionManagerPanel:OnHelpBtnClicked()
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(131)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end
--endregion

---刷新任务回收按钮特效
function UIUnionManagerPanel:RefreshApplyBtn_GameObjectEffect()
    local idList = LuaGlobalTableDeal.GetBangHuiEffectTaskIList()
    local isNeedShow = false;
    for i, v in pairs(idList) do
        local isfind, tempMission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(tonumber(v))
        if isfind then
            isNeedShow = true
        end
    end
    self:GetApplyBtn_GameObjectEffect().gameObject:SetActive(isNeedShow)
end

function ondestroy()
    luaEventManager.DoCallback(LuaCEvent.CloseDisplayBubble)
end

return UIUnionManagerPanel
