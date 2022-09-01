---活动详情界面
---@class 活动详情界面
local UIActiveTipPanel = {}

--region 局部变量定义
UIActiveTipPanel.mActiveData = nil
UIActiveTipPanel.PanelLayerType = CS.UILayerType.TipsPlane
--endregion

--region 组件
---关闭按钮
function UIActiveTipPanel.GetCloseButton_GameObject()
    if UIActiveTipPanel.mCloseBtn_GO == nil then
        UIActiveTipPanel.mCloseBtn_GO = UIActiveTipPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIActiveTipPanel.mCloseBtn_GO
end

---关闭按钮Box
function UIActiveTipPanel.GetBoxButton_GameObject()
    if UIActiveTipPanel.mBoxBtn_GO == nil then
        UIActiveTipPanel.mBoxBtn_GO = UIActiveTipPanel:GetCurComp("WidgetRoot/events/btn_box", "GameObject")
    end
    return UIActiveTipPanel.mBoxBtn_GO
end

---活动Icon
function UIActiveTipPanel.GetIcon_UISprite()
    if UIActiveTipPanel.mIcon_UISprite == nil then
        UIActiveTipPanel.mIcon_UISprite = UIActiveTipPanel:GetCurComp("WidgetRoot/view/icon", "UISprite")
    end
    return UIActiveTipPanel.mIcon_UISprite
end

---活动名文本
function UIActiveTipPanel.GetName_UILabel()
    if UIActiveTipPanel.mName_UILabel == nil then
        UIActiveTipPanel.mName_UILabel = UIActiveTipPanel:GetCurComp("WidgetRoot/view/name", "UILabel")
    end
    return UIActiveTipPanel.mName_UILabel
end

---活动数量文本
function UIActiveTipPanel.GetCount_UILabel()
    if UIActiveTipPanel.mCount_UILabel == nil then
        UIActiveTipPanel.mCount_UILabel = UIActiveTipPanel:GetCurComp("WidgetRoot/view/count", "UILabel")
    end
    return UIActiveTipPanel.mCount_UILabel
end

---活动时间文本
function UIActiveTipPanel.GetOpenTime_UILabel()
    if UIActiveTipPanel.mOpenTime_UILabel == nil then
        UIActiveTipPanel.mOpenTime_UILabel = UIActiveTipPanel:GetCurComp("WidgetRoot/view/openTime", "UILabel")
    end
    return UIActiveTipPanel.mOpenTime_UILabel
end

---等级要求文本
function UIActiveTipPanel.GetOpenLevel_UILabel()
    if UIActiveTipPanel.mOpenLevel_UILabel == nil then
        UIActiveTipPanel.mOpenLevel_UILabel = UIActiveTipPanel:GetCurComp("WidgetRoot/view/openlevel", "UILabel")
    end
    return UIActiveTipPanel.mOpenLevel_UILabel
end

---描述文本
function UIActiveTipPanel.GetDescription_UILabel()
    if UIActiveTipPanel.mDescription_UILabel == nil then
        UIActiveTipPanel.mDescription_UILabel = UIActiveTipPanel:GetCurComp("WidgetRoot/view/desc", "UILabel")
    end
    return UIActiveTipPanel.mDescription_UILabel
end

---活跃度奖励文本
function UIActiveTipPanel.GetActiveAward_UILabel()
    if UIActiveTipPanel.mActiveAward_UILabel == nil then
        UIActiveTipPanel.mActiveAward_UILabel = UIActiveTipPanel:GetCurComp("WidgetRoot/view/activeAward", "UILabel")
    end
    return UIActiveTipPanel.mActiveAward_UILabel
end

---奖励格子
function UIActiveTipPanel.GetRewardGrids_UIGridContainer()
    if UIActiveTipPanel.mRewardGrids_UIGridContainer == nil then
        UIActiveTipPanel.mRewardGrids_UIGridContainer = UIActiveTipPanel:GetCurComp("WidgetRoot/view/scrollView/rewardList", "UIGridContainer")
    end
    return UIActiveTipPanel.mRewardGrids_UIGridContainer
end

---参加按钮
--function UIActiveTipPanel.GetParticipateButton_GameObject()
--    if UIActiveTipPanel.mParticipateButton_GameObject == nil then
--        UIActiveTipPanel.mParticipateButton_GameObject = UIActiveTipPanel:GetCurComp("WidgetRoot/events/btn_participate", "GameObject")
--    end
--    return UIActiveTipPanel.mParticipateButton_GameObject
--end

function UIActiveTipPanel:GetUIItemShowListTemplate_GameObject()
    if (self.mUIItemShowListTemplate_GameObject == nil) then
        self.mUIItemShowListTemplate_GameObject = self:GetCurComp("WidgetRoot/view/scrollView/rewardList", "GameObject");
    end
    return self.mUIItemShowListTemplate_GameObject;
end

function UIActiveTipPanel:GetUIItemShowListTemplate()
    if (self:GetUIItemShowListTemplate_GameObject() ~= nil) then
        if (self.mUIItemShowListTemplate == nil) then
            self.mUIItemShowListTemplate = templatemanager.GetNewTemplate(self:GetUIItemShowListTemplate_GameObject(), luaComponentTemplates.UIItemShowListTemplate);
        end
    end
    return self.mUIItemShowListTemplate;
end
--endregion

--region 初始化
function UIActiveTipPanel:Init()
    UIActiveTipPanel:BindUIEvents()
end

---活跃度数据
---@param activeData TABLE.ACTIVE
---@param participateButtonCallback function 参加按钮回调函数
function UIActiveTipPanel:Show(activeData, participateButtonCallback)
    UIActiveTipPanel:RunBaseFunction("Show")
    UIActiveTipPanel.mActiveData = activeData
    UIActiveTipPanel.mParticipateCallback = participateButtonCallback
    UIActiveTipPanel.RefreshUI()

    if(activeData ~= nil and activeData.awards ~= nil) then
        local customData = {};
        local count = 0;
        for k,v in pairs(activeData.awards.list) do
            customData[v.list[0]] = v.list[1];
            count = count + 1;
        end
        self:GetUIItemShowListTemplate():ShowUIItemWithItemIds(customData, count);
    end

end

function UIActiveTipPanel:BindUIEvents()
    CS.UIEventListener.Get(UIActiveTipPanel.GetCloseButton_GameObject()).onClick = UIActiveTipPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIActiveTipPanel.GetBoxButton_GameObject()).onClick = UIActiveTipPanel.OnCloseButtonClicked
    --CS.UIEventListener.Get(UIActiveTipPanel.GetParticipateButton_GameObject()).onClick = UIActiveTipPanel.OnParticipateButtonClicked
end
--endregion

--region UI事件
function UIActiveTipPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIActiveTipPanel")
end

function UIActiveTipPanel.OnParticipateButtonClicked()
    if UIActiveTipPanel.mParticipateCallback then
        UIActiveTipPanel.mParticipateCallback()
    end
    uimanager:ClosePanel("UIActiveTipPanel")
end
--endregion

--region 刷新界面
---刷新UI
function UIActiveTipPanel.RefreshUI()
    UIActiveTipPanel.GetIcon_UISprite().spriteName = UIActiveTipPanel.mActiveData.icon
    UIActiveTipPanel.GetName_UILabel().text = UIActiveTipPanel.mActiveData.name
    local minTime = CS.Cfg_ActiveTableManager.Instance:GetMinHour(UIActiveTipPanel.mActiveData.id);
    local maxTime = CS.Cfg_ActiveTableManager.Instance:GetMaxHour(UIActiveTipPanel.mActiveData.id);
    local tab = os.date("*t",os.time());
    local isMatch = tab.hour >= minTime and tab.hour <maxTime;
    local activeInfo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(UIActiveTipPanel.mActiveData.id);
    local mCount = 0;
    if(activeInfo ~= nil) then
        mCount = activeInfo.completeCount;
    end
    UIActiveTipPanel.GetCount_UILabel().text = "[00ff00]" .. tostring( mCount.. "/" .. tostring(UIActiveTipPanel.mActiveData.count));
    UIActiveTipPanel.GetOpenLevel_UILabel().text = (isMatch and luaEnumColorType.Green or luaEnumColorType.Red).."活动时间：" .. tostring(CS.Cfg_ActiveTableManager.Instance:GetOpenHourString(UIActiveTipPanel.mActiveData.id)).."[-]";
    UIActiveTipPanel.GetOpenTime_UILabel().text = "[e8a657]等级要求：[00ff00]" .. tostring(UIActiveTipPanel.mActiveData.level) .. "级"
    UIActiveTipPanel.GetDescription_UILabel().text = UIActiveTipPanel.mActiveData.desc
    UIActiveTipPanel.GetActiveAward_UILabel().text = "[e8a657]奖励活跃度：[00ff00]" .. tostring(UIActiveTipPanel.mActiveData.bonus)
    if UIActiveTipPanel.mActiveData.awards then
        UIActiveTipPanel.GetRewardGrids_UIGridContainer().MaxCount = UIActiveTipPanel.mActiveData.awards.list.Count
        for i = 0, UIActiveTipPanel.GetRewardGrids_UIGridContainer().controlList.Count - 1 do
            local awardTemp = UIActiveTipPanel.mActiveData.awards.list[i]
            if awardTemp.list.Count >= 1 then
                local res, itemData = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(awardTemp.list[0])
                if res then
                    local template = templatemanager.GetNewTemplate(UIActiveTipPanel.GetRewardGrids_UIGridContainer().controlList[i], luaComponentTemplates.UIItem)
                    local count = 1
                    if awardTemp.list.Count >= 2 then
                        count = awardTemp.list[1]
                    end
                    template:RefreshUIWithItemInfo(itemData, count)
                end
            end
        end
    end
    --if UIActiveTipPanel.mParticipateCallback then
    --    UIActiveTipPanel.GetParticipateButton_GameObject():SetActive(true)
    --else
    --    UIActiveTipPanel.GetParticipateButton_GameObject():SetActive(false)
    --end
end
--endregion

return UIActiveTipPanel