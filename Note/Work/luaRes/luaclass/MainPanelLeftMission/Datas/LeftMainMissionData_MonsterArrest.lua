---@class LeftMainMissionData_MonsterArrest:LeftMainMissionData
local LeftMainMissionData_MonsterArrest = {}

setmetatable(LeftMainMissionData_MonsterArrest, luaclass.LeftMainMissionData)

function LeftMainMissionData_MonsterArrest:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.MonsterTask
end

---是否开启
---@return boolean
function LeftMainMissionData_MonsterArrest:GetIsEnabled()
    if self.mIsEnabled == nil then
        self:UpdateIsEnabled()
    end
    return self.mIsEnabled == true
end

---更新是否开启的状态,不触发事件
---@private
function LeftMainMissionData_MonsterArrest:UpdateIsEnabled()
    local singleMission = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetCurrentShowMonsterArrestMission()
    self.mIsEnabled = singleMission ~= nil
end

function LeftMainMissionData_MonsterArrest:Initialize()
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.MonsterArrestDataChange, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)
end

---刷新模板的UI
---@public
---@param template UIMissionInfoTemplates
function LeftMainMissionData_MonsterArrest:OnRefreshUI(template)
    template.task_type.spriteName = 'monsterarrest'
    template.bg2.spriteName = 'monsterarrestdise'
    local mission, group = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetCurrentShowMonsterArrestMission()
    if mission == nil then
        return
    end
    local str = "怪物悬赏"
    local progress = ""
    if group then
        str = mission.tbl_tasks.name
    else
        local monsterId = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetMonsterIdByMission(mission)
        local tbl = clientTableManager.cfg_monstersManager:TryGetValue(monsterId)
        if tbl then
            str = "击杀" .. tbl:GetName()
        end
        progress = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetMissionProgress(mission, true, false)
    end
    template.lb_content.text = luaEnumColorType.White .. str
    template.lb_state.text = progress
    template.completed:SetActive(group)
    template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    template:BindClickEvent(function()
        --template.lb_content:ResetHorseLamp()
        uimanager:CreatePanel("UIMonsterArrestPanel")
    end)
end

return LeftMainMissionData_MonsterArrest