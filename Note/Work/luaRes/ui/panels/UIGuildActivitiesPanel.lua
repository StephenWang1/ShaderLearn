---@class UIGuildActivitiesPanel:UIBase 行会活动
local UIGuildActivitiesPanel = {}

---@return CSMainPlayerInfo 玩家信息
function UIGuildActivitiesPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2
function UIGuildActivitiesPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

--region 初始化
function UIGuildActivitiesPanel:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvents()
    self:BindMessage()
    networkRequest.ReqMagicCircleInfo()
    networkRequest.ReqSpoilsHouse()
end

function UIGuildActivitiesPanel:InitComponent()
    self.activities_UIGridContainer = self:GetCurComp("WidgetRoot/view/Scroll View/Activities", "UIGridContainer")
end

function UIGuildActivitiesPanel:InitParams()
    self.PanelTable = {}
end

function UIGuildActivitiesPanel:BindEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefreshMagicCircleActivity, function()
        self:RefreshPanel(luaEnumActivityTypeByActivityTimeTable.MagicCircle)
    end)
end
function UIGuildActivitiesPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionSpoilsChange, function()
        self:RefreshSpoilsShow()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AllUnionInfoChange, function()
        if CS.StaticUtility.IsNull(self.go) or self.go.activeSelf == false then
            return
        end
        self:RefreshAllPanel()
    end)
end
--endregion

--region 刷新
function UIGuildActivitiesPanel:Show()
    networkRequest.ReqSendAllUnionInfo()
    --self:RefreshAllPanel()
end

---刷新所有的面板
function UIGuildActivitiesPanel:RefreshAllPanel()
    local activityList = self:GetShowActivityList()
    if self.activities_UIGridContainer ~= nil then
        self.activities_UIGridContainer.MaxCount = #activityList
        if activityList ~= nil then
            local length = #activityList - 1
            for k = 0, length do
                local go = self.activities_UIGridContainer.controlList[k]
                local activityInfo = activityList[k + 1]
                local template = self:GetActivityTemplate(activityInfo.ActivityId)
                if activityInfo ~= nil and template ~= nil and CS.StaticUtility.IsNull(go) == false then
                    ---@type GuildActivity_Base
                    local activityTemplate = templatemanager.GetNewTemplate(go, template)
                    activityTemplate:RefreshPanel({ activityId = activityInfo.ActivityId, activityInfo = activityInfo })
                end
            end
        end
    end
end

---刷新对应模板面板
---@param activityId luaEnumActivityTypeByActivityTimeTable
function UIGuildActivitiesPanel:RefreshPanel(activityId)
    if self.PanelTable ~= nil then
        local panelTemplate = self.PanelTable[activityId]
        if panelTemplate ~= nil then
            panelTemplate:RefreshPanelNoParams()
        end
    end
end

--endregion

--region 获取
---获取显示的行会活动列表
---@return ActivityList Table
function UIGuildActivitiesPanel:GetShowActivityList()
    local activityTable = {}
    local activityList = CS.Cfg_Union_ActivityTableManager.Instance:GetUnionActivityInfoList()
    if activityList ~= nil then
        local length = activityList.Count - 1
        for k = 0, length do
            local activityInfo = activityList[k]
            if activityInfo ~= nil
                    and activityInfo.UnionActivityTable
                    and not self:IsForbiddenActive(activityInfo.ActivityId)
                    and not self:IsHHSLActive(activityInfo.ActivityId)
                    and not self:IsHangHuiMiJingActivity(activityInfo.ActivityId)
                    and self:GetActivityTemplate(activityInfo.ActivityId) ~= nil then
                table.insert(activityTable, activityInfo)
            end
        end
    end

    ---行会地宫活动
    ---行会地宫活动的ID
    ---@type number
    local guildDungeonActiveID = Utility.GetNowGuildDungeonAtciveID()
    local activityInfo = {}
    if guildDungeonActiveID then
        activityInfo.ActivityId = guildDungeonActiveID
        activityInfo.isOpen = true
        activityInfo.UnionActivityTable = self:CacheUnionActivityData(activityInfo.ActivityId)
    else
        activityInfo.ActivityId = 419
        activityInfo.isOpen = false
        activityInfo.UnionActivityTable = self:CacheUnionActivityData(activityInfo.ActivityId)
    end
    table.insert(activityTable, activityInfo)

    -----行会秘境活动
    ----if Utility.GetIsHangHuiMiJingShowInGuild() then
    --local activityInfoTemp = {}
    -----如果行会秘境活动能够显示的话
    --local currentActivityID = Utility.GetCurrentEnabledHangHuiMiJingID()
    --if currentActivityID ~= nil and currentActivityID ~= 0 then
    --    activityInfoTemp.ActivityId = currentActivityID
    --    activityInfoTemp.isOpen = true
    --    activityInfoTemp.UnionActivityTable = self:CacheUnionActivityData(activityInfoTemp.ActivityId)
    --else
    --    activityInfoTemp.ActivityId = 429
    --    activityInfoTemp.isOpen = false
    --    activityInfoTemp.UnionActivityTable = self:CacheUnionActivityData(activityInfoTemp.ActivityId)
    --end
    --table.insert(activityTable, activityInfoTemp)
    ----end

    --region 行会首领玩法
    --if Utility.GetIsHangHuiShouLingShowInGuild() then
    ---如果行会秘境活动能够显示的话
    local currentActivityID = Utility.GetNowShouLingAtciveID()
    local activityInfoTemp = {}
    if currentActivityID ~= nil and currentActivityID ~= 0 then
        activityInfoTemp.ActivityId = currentActivityID
        activityInfoTemp.isOpen = true
        activityInfoTemp.UnionActivityTable = self:CacheUnionActivityData(activityInfoTemp.ActivityId)
    else
        activityInfoTemp.ActivityId = 433
        activityInfoTemp.isOpen = false
        activityInfoTemp.UnionActivityTable = self:CacheUnionActivityData(activityInfoTemp.ActivityId)
    end
    table.insert(activityTable, activityInfoTemp)
    --end
    --endregion

    local activityNum = #activityTable
    if activityNum < 3 then
        for i = 1, 3 - activityNum do
            self:AddNullActivity(activityTable)
        end
    end

    table.sort(activityTable, function(left, right)
        local res, leftInfo = CS.Cfg_Union_ActivityTableManager.Instance.dic:TryGetValue(left.ActivityId)
        local res2, rightInfo = CS.Cfg_Union_ActivityTableManager.Instance.dic:TryGetValue(right.ActivityId)
        if res and res2 then
            if leftInfo.order ~= rightInfo.order then
                ---order不相等时以order的升序排列
                return leftInfo.order < rightInfo.order
            else
                ---order相等时以id降序排列(为了让0往后排)
                return left.ActivityId > right.ActivityId
            end
        else
            return false
        end
    end)
    return activityTable
end

---添加空活动（敬请期待）
function UIGuildActivitiesPanel:AddNullActivity(activityTable)
    local activityInfo = {}
    activityInfo.ActivityId = luaEnumActivityTypeByActivityTimeTable.NONE
    activityInfo.UnionActivityTable = self:CacheUnionActivityData(luaEnumActivityTypeByActivityTimeTable.NONE)
    table.insert(activityTable, activityInfo)
end

---@return TABLE.CFG_UNION_ACTIVITY
function UIGuildActivitiesPanel:CacheUnionActivityData(id)
    if self.mIdToActivityData == nil then
        self.mIdToActivityData = {}
    end
    local data = self.mIdToActivityData[id]
    if data == nil then
        ___, data = CS.Cfg_Union_ActivityTableManager.Instance.dic:TryGetValue(id)
        self.mIdToActivityData[id] = data
    end
    return data
end

---通过活动id获取活动模板
---@return GuildActivity_Base
function UIGuildActivitiesPanel:GetActivityTemplate(activityId)
    if activityId == luaEnumActivityTypeByActivityTimeTable.MagicCircle then
        return luaComponentTemplates.GuildActivity_MagicCircle
    elseif activityId == luaEnumActivityTypeByActivityTimeTable.NONE then
        return luaComponentTemplates.GuildActivity_UnOpen
    elseif self:IsHHSLActive(activityId) then
        ---@type GuildActivity_GuildForHangHuiShouLin
        return luaComponentTemplates.GuildActivity_HangHuiShouLing
    elseif self:IsForbiddenActive(activityId) then
        ---@type GuildActivity_GuildForbiddenArea
        return luaComponentTemplates.GuildActivity_GuildForbiddenArea
        --elseif self:IsHangHuiMiJingActivity(activityId) then
        --    return luaComponentTemplates.GuildActivity_HangHuiMiJing
    end
    return nil
end

---是否是行会禁地
---@param activityId
---@return boolean
function UIGuildActivitiesPanel:IsForbiddenActive(activityId)
    if activityId == 419 or activityId == 420 or activityId == 421 or activityId == 422 then
        return true
    end
    return false
end

---是否是行会秘境
---@param activityId
---@return boolean
function UIGuildActivitiesPanel:IsHangHuiMiJingActivity(activityId)
    if activityId == 429 or activityId == 430 or activityId == 431 or activityId == 432 then
        return true
    end
    return false
end

---是否是行会首领
---@param activityId
---@return boolean
function UIGuildActivitiesPanel:IsHHSLActive(activityId)
    if activityId == 433 or activityId == 434 then
        return true
    end
    return false
end
--endregion

--region 行会战利品
--region 组件
---@return UnityEngine.GameObject
function UIGuildActivitiesPanel:GetGuildLootRoot_GO()
    if self.mLootGo == nil then
        self.mLootGo = self:GetCurComp("WidgetRoot/Loot", "GameObject")
    end
    return self.mLootGo
end
--endregion

---@return UIGuildBenefitsPanel_SpoilsTemplate 行会战利品模板
function UIGuildActivitiesPanel:GetSpoilsTemplate()
    if self.mLootTemplate == nil then
        self.mLootTemplate = templatemanager.GetNewTemplate(self:GetGuildLootRoot_GO(), luaComponentTemplates.UIGuildBenefitsPanel_SpoilsTemplate, self)
    end
    return self.mLootTemplate
end

---刷新列表显示
function UIGuildActivitiesPanel:RefreshSpoilsShow()
    if self:GetSpoilsTemplate() then
        self:GetSpoilsTemplate():RefreshInfo(self:GetUnionInfoV2().SpoilsDic)
    end
end
--endregion

return UIGuildActivitiesPanel