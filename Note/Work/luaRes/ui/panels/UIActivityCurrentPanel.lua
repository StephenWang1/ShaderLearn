---@class UIActivityCurrentPanel:UIActivityCurrentBase
local UIActivityCurrentPanel = {}

setmetatable(UIActivityCurrentPanel, luaPanelModules.UIActivityCurrentBase)

--region 组件
function UIActivityCurrentPanel:GetBookMark_UIGridContainer()
    if self.mBookMarkLoop == nil then
        self.mBookMarkLoop = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "UIGridContainer")
    end
    return self.mBookMarkLoop
end

function UIActivityCurrentPanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end
--endregion

--region 初始化
---@protected
---初始化
function UIActivityCurrentPanel:Init()
    self:RunBaseFunction("Init")
    self:BindMessage()
end

function UIActivityCurrentPanel:Show(customData)
    self:RunBaseFunction("Show", customData)
    local chooseActivityId
    local chooseActivityType
    --[[    if self.mOpenActivityList and #self.mOpenActivityList > 0 then
            chooseActivityId = self:GetRedPointId()
        end]]
    chooseActivityId = self:GetRedPointId()
    if customData.mChooseActivityId then
        chooseActivityId = customData.mChooseActivityId
    end

    if customData.mChooseActivityType then
        chooseActivityId = nil
        chooseActivityType = customData.mChooseActivityType
    end

    if chooseActivityId then
        self:ChooseBookMarkByActivityId(chooseActivityId)
    end
    if chooseActivityType then
        self:ChooseBookMarkByEventId(chooseActivityType)
    end
end

function UIActivityCurrentPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mAllActivityChange, function()
        self:RefreshPanel()
        local activityId = self:GetCurrentChooseActivityId()
        if activityId ~= 0 then
            self:ChooseBookMarkByActivityId(activityId)
        end
    end)
end

---@return number 当前需要选中页签
function UIActivityCurrentPanel:GetCurrentChooseActivityId()
    if self.mOpenActivityList and #self.mOpenActivityList > 0 then
        if self.mCurrentChooseActivityId then
            for i = 1, #self.mOpenActivityList do
                local chooseActivityId = self.mOpenActivityList[i]
                if self.mCurrentChooseActivityId == chooseActivityId then
                    return chooseActivityId
                end
            end
        end
    end
    return self:GetRedPointId()
end

---@return number 获得活动红点id，如果没有就返回第一个
function UIActivityCurrentPanel:GetRedPointId()
    if self.mOpenActivityList then
        for i = 1, #self.mOpenActivityList do
            local activityId = self.mOpenActivityList[i]
            local activityData = self:CacheSpecialActivityData(activityId)
            if activityData then
                local eventID = activityData:GetEventId()
                local key = "SpecialActivity_" .. eventID
                local redPointManager = gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager()
                local redPointKey = redPointManager:GetLuaRedPointKey(key)
                local open = redPointManager:GetRedPointValue(redPointKey)
                if open then
                    return activityId
                end
            end
        end
        return self.mOpenActivityList[1]
    end
    return 0
end

function UIActivityCurrentPanel:DestroyPanel()
    self:RunBaseFunction("DestroyPanel")
end

function ondestroy()
    UIActivityCurrentPanel:DestroyPanel()
end

return UIActivityCurrentPanel