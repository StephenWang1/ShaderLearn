---@class LeftMainMissionData_ChallengeBossFinish:LeftMainMissionData
local LeftMainMissionData_ChallengeBossFinish = {}

setmetatable(LeftMainMissionData_ChallengeBossFinish, luaclass.LeftMainMissionData)

function LeftMainMissionData_ChallengeBossFinish:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.ChallengeBossFinish
end

---是否开启
---@return boolean
function LeftMainMissionData_ChallengeBossFinish:GetIsEnabled()
    if self.mIsEnabled == nil then
        self:UpdateIsEnabled()
    end
    return self.mIsEnabled == true
end

---更新是否开启的状态,不触发事件
---@private
function LeftMainMissionData_ChallengeBossFinish:UpdateIsEnabled()
    self.mIsEnabled = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():IsAnyMissionFinish()
end

function LeftMainMissionData_ChallengeBossFinish:Initialize()
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
function LeftMainMissionData_ChallengeBossFinish:OnRefreshUI(template)
    template.task_type.spriteName = 'BossTask'
    template.bg2.spriteName = 'BossTaskdise'
    template.lb_content.text = luaEnumColorType.White .. '找宗师提交任务'
    template.completed:SetActive(true)
    template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    template:BindClickEvent(function()
        Utility.TryTransfer(1031)
    end)
end

return LeftMainMissionData_ChallengeBossFinish