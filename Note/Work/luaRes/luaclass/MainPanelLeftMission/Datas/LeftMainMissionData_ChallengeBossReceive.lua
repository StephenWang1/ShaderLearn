---@class returnLeftMainMissionData_ChallengeBossReceive:LeftMainMissionData
local LeftMainMissionData_ChallengeBossReceive = {}

setmetatable(LeftMainMissionData_ChallengeBossReceive, luaclass.LeftMainMissionData)

function LeftMainMissionData_ChallengeBossReceive:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.ChallengeBossReceive
end

---是否开启
---@return boolean
function LeftMainMissionData_ChallengeBossReceive:GetIsEnabled()
    if self.mIsEnabled == nil then
        self:UpdateIsEnabled()
    end
    return self.mIsEnabled == true
end

---更新是否开启的状态,不触发事件
---@private
function LeftMainMissionData_ChallengeBossReceive:UpdateIsEnabled()
    if gameMgr:GetPlayerDataMgr() == nil or gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():GetAllChallengeBossData() == nil then
        self.mIsEnabled = false
        return
    end

    local time = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():GetAllChallengeBossData().tadayCount
    local totalTime = LuaGlobalTableDeal:GetChallengeBossTimes()
    local hasTime = totalTime - time > 0
    local isConditionFull = LuaGlobalTableDeal:IsMainPlayerMatchChallengeBossCondition()
    local anyFinish = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():IsAnyMissionFinish()
    local mission = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():GetCurrentMission()
    self.mIsEnabled = mission == nil and anyFinish == false and hasTime and isConditionFull
end

function LeftMainMissionData_ChallengeBossReceive:Initialize()
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.ChallengeBossDataChange, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)

    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshArrestMissionShow, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)
end

---刷新模板的UI
---@public
---@param template UIMissionInfoTemplates
function LeftMainMissionData_ChallengeBossReceive:OnRefreshUI(template)
    template.task_type.spriteName = 'BossTask'
    template.bg2.spriteName = 'BossTaskdise'
    template.lb_content.text = luaEnumColorType.White .. '找宗师接取任务'
    template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    template:BindClickEvent(function()
        Utility.TryTransfer(1031)
    end)
end

return LeftMainMissionData_ChallengeBossReceive