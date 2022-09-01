---沙城土著面板
---@class UIShabakIndigenousPanel:UIBase
local UIShabakIndigenousPanel = {}

--region 组件
---关闭按钮
function UIShabakIndigenousPanel:GetCloseButton_GameObject()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    end
    return self.mCloseButton
end

---进入活动按钮
function UIShabakIndigenousPanel:EnterActivityButton_GameObject()
    if self.mEnterButton == nil then
        self.mEnterButton = self:GetCurComp("WidgetRoot/event/EnterBtn", "GameObject")
    end
    return self.mEnterButton
end

---@return UILabel 介绍label
function UIShabakIndigenousPanel:GetIntroductionLabel_UILabel()
    if self.introduceLabel == nil then
        self.introduceLabel = self:GetCurComp("WidgetRoot/introduce/des", "UILabel")
    end
    return self.introduceLabel
end

---@return UILabel 说明label
function UIShabakIndigenousPanel:GetDescription_UILabel()
    if self.mDesLabel == nil then
        self.mDesLabel = self:GetCurComp("WidgetRoot/introduce/details", "UILabel")
    end
    return self.mDesLabel
end

--endregion

--region属性
---活动信息
function UIShabakIndigenousPanel:GetDuplicateInfo()
    if self.mDuplicateInfo == nil then
        self.mDuplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    end
    return self.mDuplicateInfo
end

function UIShabakIndigenousPanel:GetUnionInfo()
    if self.mUnionInfo == nil then
        self.mUnionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2
    end
    return self.mUnionInfo
end

function UIShabakIndigenousPanel:GetLeagueInfo()
    if self.mLeagueInfo == nil then
        self.mLeagueInfo = CS.CSScene.MainPlayerInfo.LeagueInfo
    end
    return self.mLeagueInfo
end

--endregion

--region 初始化
function UIShabakIndigenousPanel:Init()
    self:BindEvents()
end

function UIShabakIndigenousPanel:Show(deliverId)
    self:ShowDescription()
    self.mDeliverId = deliverId
end

function UIShabakIndigenousPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:OnCloseButtonClicked()
    end
    CS.UIEventListener.Get(self:EnterActivityButton_GameObject()).onClick = function(go)
        self:OnEnterActivityClicked(go)
    end
end
--endregion

--region UI事件
---关闭界面
function UIShabakIndigenousPanel:OnCloseButtonClicked()
    self:ClosePanel()
end

---显示活动描述
function UIShabakIndigenousPanel:ShowDescription()
    ---@type System.Array
    local strs = CS.Cfg_DescriptionTableManager.Instance:GetShabakDes()
    if strs and strs.Length >= 2 then
        self:GetIntroductionLabel_UILabel().text = strs[0]
        self:GetDescription_UILabel().text = string.gsub(strs[1], '\\n', '\n')
    end
end

---进入活动
function UIShabakIndigenousPanel:OnEnterActivityClicked(go)
    local isOpenActive = self:GetDuplicateInfo():IsOpenShaBaK()
    if isOpenActive then
        local isStatueDestroy = self:GetDuplicateInfo().IsStatuDestroy
        if isStatueDestroy then
            local OccupyUnionId = self:GetDuplicateInfo().OccupyShabakUnionId
            local OccupyLeagueType = self:GetDuplicateInfo().OccupyShabakLeagueType
            if OccupyLeagueType ~= 0 then
                local playerLeagueType = self:GetLeagueInfo().LeagueType
                if playerLeagueType == OccupyLeagueType then
                    CS.Utility.ShowTips("守方成员不可传送")
                else
                    networkRequest.ReqDeliverByConfig(self.mDeliverId)
                    uimanager:ClosePanel("UIShabakIndigenousPanel");
                end
            elseif OccupyUnionId and OccupyUnionId ~= 0 then
                local playerUnionId = self:GetUnionInfo().UnionID
                if playerUnionId == OccupyUnionId then
                    CS.Utility.ShowTips("守方成员不可传送")
                else
                    networkRequest.ReqDeliverByConfig(self.mDeliverId)
                    uimanager:ClosePanel("UIShabakIndigenousPanel");
                end
            else
                CS.Utility.ShowTips("占领皇宫后非守方才可使用")
            end
        else
            CS.Utility.ShowTips("请先摧毁雕像")
        end
    else
        CS.Utility.ShowTips("不在活动时间内")
    end
end
--endregion

return UIShabakIndigenousPanel