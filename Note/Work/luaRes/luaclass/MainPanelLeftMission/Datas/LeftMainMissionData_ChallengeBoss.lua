---@class LeftMainMissionData_ChallengeBoss:LeftMainMissionData
local LeftMainMissionData_ChallengeBoss = {}

setmetatable(LeftMainMissionData_ChallengeBoss, luaclass.LeftMainMissionData)

function LeftMainMissionData_ChallengeBoss:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.ChallengeBoss
end

---是否开启
---@return boolean
function LeftMainMissionData_ChallengeBoss:GetIsEnabled()
    if self.mIsEnabled == nil then
        self:UpdateIsEnabled()
    end
    return self.mIsEnabled == true
end

---更新是否开启的状态,不触发事件
---@private
function LeftMainMissionData_ChallengeBoss:UpdateIsEnabled()
    local mission = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():GetCurrentMission()
    self.mIsEnabled = mission ~= nil
end

function LeftMainMissionData_ChallengeBoss:Initialize()
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
function LeftMainMissionData_ChallengeBoss:OnRefreshUI(template)
    template.task_type.spriteName = 'BossTask'
    template.bg2.spriteName = 'BossTaskdise'
    local mission = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():GetCurrentMission()
    if mission == nil then
        return
    end
    local monsterId = mission.monsterId
    local bossId = mission.bossId
    local tbl = clientTableManager.cfg_monstersManager:TryGetValue(monsterId)
    local bosstbl = clientTableManager.cfg_bossManager:TryGetValue(bossId)
    local bossTemp = {}
    if bosstbl ~= nil then
        bossTemp.type = bosstbl:GetType()
        bossTemp.subType = bosstbl:GetSubType()
    end
    local str = "宗师任务"
    if tbl then
        str = "击杀" .. tbl:GetName()
    end
    template.lb_content.text = luaEnumColorType.White .. str
    template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    template:BindClickEvent(function()
        -- Utility.TryTransfer(1022)
        --- uimanager:CreatePanel("UIBossChallengePanel")
        ---template
        --template.lb_content:ResetHorseLamp()
        uimanager:CreatePanel("UIBossPanel", nil, bossTemp)
    end)
end

return LeftMainMissionData_ChallengeBoss