---
--- Created by Olivier.
--- DateTime: 2021/2/26 13:30
--- 灵魂任务显示模型

---@class LeftMainMissionData_LingHunRenWu:LeftMainMissionData
local LeftMainMissionData_LingHunRenWu = {}

setmetatable(LeftMainMissionData_LingHunRenWu, luaclass.LeftMainMissionData)

function LeftMainMissionData_LingHunRenWu:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.LingHunRenWu
end

---是否开启
---@return boolean
function LeftMainMissionData_LingHunRenWu:GetIsEnabled()
    self.mIsEnabled = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetLingHunMissionData():IsFunctionOpen()
    return self.mIsEnabled
end

function LeftMainMissionData_LingHunRenWu:Initialize()
    --UILsMissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSoulTaskStateMessage, UILsMissionPanel.OnResLingShouTaskInfoMessageCallBack)
    self:GetOwnerPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSoulTaskStateMessage, function()
        self:GetIsEnabled()
        self:Refresh()
    end)
end

---刷新模板的UI
---@public
---@param template UIMissionInfoTemplates
function LeftMainMissionData_LingHunRenWu:OnRefreshUI(template)
    template.task_type.spriteName = 'monsterarrest'
    template.bg2.spriteName = 'monsterarrestdise'
    --local mission, group = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetCurrentShowMonsterArrestMission()
    --if mission == nil then
    --    return
    --end
    local str = "灵魂任务"
    --local progress = ""
    --if group then
    --    str = mission.tbl_tasks.name
    --else
    --    local monsterId = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetMonsterIdByMission(mission)
    --    local tbl = clientTableManager.cfg_monstersManager:TryGetValue(monsterId)
    --    if tbl then
    --        str = "击杀" .. tbl:GetName()
    --    end
    --    progress = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetMissionProgress(mission, true , false)
    --end
    template.lb_content.text = luaEnumColorType.White .. str
    --template.lb_state.text = "灵魂任务"
    template.completed:SetActive(false)
    template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    template:BindClickEvent(function()
        uimanager:CreatePanel("UISoulMissionPanel")
    end)
end

return LeftMainMissionData_LingHunRenWu