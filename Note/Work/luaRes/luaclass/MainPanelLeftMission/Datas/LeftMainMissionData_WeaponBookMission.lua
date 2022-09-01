---@class LeftMainMissionData_WeaponBookMission:LeftMainMissionData 左侧任务栏兵鉴
local LeftMainMissionData_WeaponBookMission = {}

setmetatable(LeftMainMissionData_WeaponBookMission, luaclass.LeftMainMissionData)

---获取兵鉴任务管理
---@return LuaLsMissionInfo
function LeftMainMissionData_WeaponBookMission:GetWeaponBookMissionData()
    if self.weaponBookMissionData == nil then
        self.weaponBookMissionData = gameMgr:GetPlayerDataMgr():GetLsMissionData()
    end
    return self.weaponBookMissionData
end

function LeftMainMissionData_WeaponBookMission:Initialize()
    self:UpdateIsEnabled(0)
end

function LeftMainMissionData_WeaponBookMission:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.WeaponBook
end

---是否开启
---@return boolean
function LeftMainMissionData_WeaponBookMission:GetIsEnabled()
    if self.mIsEnabled == nil then
        self:UpdateIsEnabled(0)
    end
    return self.mIsEnabled == true
end

---更新是否开启的状态,不触发事件
---@param reasonCode 0:初始化 1:系统变化 2:任务变化
---@private
function LeftMainMissionData_WeaponBookMission:UpdateIsEnabled(reasonCode)
    if reasonCode == 0 then
        self.isOpenWeaponBook = Utility.CheckSystemOpenState(95)
        self.isHasMission = self:GetWeaponBookMissionData():IsShowLeftMission()
    elseif reasonCode == 1 then
        self.isOpenWeaponBook = Utility.CheckSystemOpenState(95)
    elseif reasonCode == 2 then
        self.isHasMission = self:GetWeaponBookMissionData():IsShowLeftMission()
    end

    local curState = self.isOpenWeaponBook and self.isHasMission

    if curState ~= self.mIsEnabled then
        self.mIsEnabled = curState
        self:Refresh()
        if not curState then
            self.unitTemplate = nil
        end
    end
end

function LeftMainMissionData_WeaponBookMission:Initialize()

    self.OnSystemOpenReminderMessageCallBack = function()
        self:UpdateIsEnabled(1)
    end
    self:GetOwnerPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.SystemOpenReminderMessage, self.OnSystemOpenReminderMessageCallBack)
    self.OnClickWeaponBookUnit = function(msgId, tblData)
        self:OnClickWeaponBookUnitCallBack(tblData)
    end
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.ClickWeaponBookUnit, self.OnClickWeaponBookUnit)

    self.OnRefreshMissionViewCallBack = function()
        self:UpdateIsEnabled(2)
        self:RefreshMissionView()
    end
    self:GetOwnerPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskPanelMessage, self.OnRefreshMissionViewCallBack)
    self:GetOwnerPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLingShouTaskInfoMessage, self.OnRefreshMissionViewCallBack)
end

---刷新模板的UI
---@public
---@param template UIMissionInfoTemplates
function LeftMainMissionData_WeaponBookMission:OnRefreshUI(template)
    self.unitTemplate = template
    if template then
        template.task_type.spriteName = 'cqtz'
        template.bg2.spriteName = 'monsterarrestdise'
        template:BindClickEvent(function()
            uimanager:CreatePanel("UILsMissionPanel")
        end)
        self:RefreshMissionView()
        template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    end
end

---获取当前应该显示的任务信息
---@return LsMission
function LeftMainMissionData_WeaponBookMission:GetMissionData()
    local secState = self:GetWeaponBookMissionData():GetSecStateDic()[self.sec]
    local isChange = secState == nil or secState.lockState == LuaLsMissionSecStateEnum.Geted or secState.lockState == LuaLsMissionSecStateEnum.CanGet
    if isChange or self.sec == nil then
        self.sec = self:GetWeaponBookMissionData():GetCurLeftShowMissionSec()
    end

    if self.missionId == nil then
        ---@type LsMission
        local mission = self:GetWeaponBookMissionData():GetCurShowMissionBySec(self.sec)
        self.missionId = mission == nil and 0 or mission.lsTaskId
        return mission
    end

    --当前的任务如果已经已经完成 寻找下一个
    local curMission = self:GetWeaponBookMissionData():GetMissionInfoBySecAndLsId(self.sec, self.missionId)
    if curMission == nil or curMission.rewardState == LuaLsMissionStateEnum.Geted then
        local mission = self:GetWeaponBookMissionData():GetCurShowMissionBySec(self.sec)
        self.missionId = mission == nil and 0 or mission.lsTaskId
        return mission
    end
    return curMission
end

---刷新任务视图
---@param template UIMissionInfoTemplates
function LeftMainMissionData_WeaponBookMission:RefreshMissionView()
    if self.unitTemplate == nil then
        return
    end
    ---@type LsMission
    local mission = self:GetMissionData()
    local isShowComplete = mission ~= nil and (mission.rewardState == LuaLsMissionStateEnum.CanGet or mission.rewardState == LuaLsMissionStateEnum.Geted)
    self.unitTemplate.lb_content.text = mission == nil and '' or luaEnumColorType.White .. mission.leftMission
    self.unitTemplate.lb_state.text = (mission == nil or isShowComplete) and '' or mission.curFillValue .. '/' .. mission.maxFillValue
    self.unitTemplate.completed:SetActive(isShowComplete)
end

---点击任务模板回调
---@param tblData LsMission
function LeftMainMissionData_WeaponBookMission:OnClickWeaponBookUnitCallBack(tblData)
    if tblData == nil then
        return
    end
    if self.sec ~= tblData.sec or self.missionId ~= tblData.lsTaskId then
        self.sec = tblData.sec
        self.missionId = tblData.lsTaskId
        self:RefreshMissionView()
    end
end


return LeftMainMissionData_WeaponBookMission