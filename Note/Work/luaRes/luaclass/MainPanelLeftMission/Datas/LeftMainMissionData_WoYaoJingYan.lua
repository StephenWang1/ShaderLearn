---我要经验
---@class LeftMainMissionData_JingYan:LeftMainMissionData
local LeftMainMissionData_WoYaoJingYan = {}

setmetatable(LeftMainMissionData_WoYaoJingYan, luaclass.LeftMainMissionData)

function LeftMainMissionData_WoYaoJingYan:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.WoYaoJingYan
end

---是否开启
---@return boolean
function LeftMainMissionData_WoYaoJingYan:GetIsEnabled()
    if self.mIsEnabled == nil then
        self:UpdateIsEnabled()
    end
    return self.mIsEnabled == true
end

---更新是否开启的状态,不触发事件
---@private
function LeftMainMissionData_WoYaoJingYan:UpdateIsEnabled()
    self.mIsEnabled = true
    local conditionTblMgr = CS.Cfg_ConditionManager.Instance
    for i = 1, #self.mShowConditions do
        if conditionTblMgr:IsMainPlayerMatchCondition(self.mShowConditions[i]) == false then
            self.mIsEnabled = false
            break
        end
    end
end

function LeftMainMissionData_WoYaoJingYan:Initialize()
    self.mShowConditions = {}
    self.mShowWayGetArray = {}
    ---解析数据
    ---@type TABLE.CFG_GLOBAL
    local globalTblExist, globalTbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22797)
    if globalTbl then
        local strs1 = string.Split(globalTbl.value, '$')
        if #strs1 >= 2 then
            local conditionStr = string.Split(strs1[1], '#')
            for i = 1, #conditionStr do
                local id = tonumber(conditionStr[i])
                if id then
                    table.insert(self.mShowConditions, id)
                end
            end
            local wayGetArrayStr = string.Split(strs1[2], '#')
            for i = 1, #wayGetArrayStr do
                local id = tonumber(wayGetArrayStr[i])
                if id then
                    table.insert(self.mShowWayGetArray, id)
                end
            end
        end
    end
    ---绑定事件,等级等更新时刷新MissionPanel
    self:GetOwnerPanel():GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)
    self:GetOwnerPanel():GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateReincarnation, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)
end

---刷新模板的UI
---@public
---@param template UIMissionInfoTemplates
function LeftMainMissionData_WoYaoJingYan:OnRefreshUI(template)
    template.task_type.spriteName = 'richang'
    template.bg2.spriteName = 'richangdise'
    template.lb_content.text = luaEnumColorType.White .. '我要经验'
    template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    template:BindClickEvent(function()
        --print("我要经验")
        Utility.ShowGetWayByWayGetArray(self.mShowWayGetArray, template.go, LuaEnumWayGetPanelArrowDirType.Left,
                { x = 150, y = 0 }, nil, nil, nil);
    end)
end

---释放,界面关闭时调用,如果没有需要执行的操作则不需要重写
---@public
function LeftMainMissionData_WoYaoJingYan:Dispose()

end

return LeftMainMissionData_WoYaoJingYan