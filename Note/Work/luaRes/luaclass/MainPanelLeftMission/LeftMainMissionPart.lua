---主界面左侧任务部分数据(额外数据)
---@class LeftMainMissionPart:luaobject
local LeftMainMissionPart = {}

---获取额外任务列表
---@return table<number,LeftMainMissionData>
function LeftMainMissionPart:GetMissions()
    return self.mMissions
end

---初始化
---@public
---@param ownerPanel UIBase 归属界面
function LeftMainMissionPart:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    ---任务栏选项注册
    ---@type table<number,LeftMainMissionData>
    self.mMissions = {}
    ---挂机
    table.insert(self.mMissions, luaclass.LeftMainMissionData_GuaJi:New(self:GetOwnerPanel()))
    ---我要经验
    table.insert(self.mMissions, luaclass.LeftMainMissionData_WoYaoJingYan:New(self:GetOwnerPanel()))
    ---我要元宝
    table.insert(self.mMissions, luaclass.LeftMainMissionData_WoYaoYuanBao:New(self:GetOwnerPanel()))
    ---挑战boss
    table.insert(self.mMissions, luaclass.LeftMainMissionData_ChallengeBoss:New(self:GetOwnerPanel()))
    table.insert(self.mMissions, luaclass.LeftMainMissionData_ChallengeBossFinish:New(self:GetOwnerPanel()))
    table.insert(self.mMissions, luaclass.LeftMainMissionData_ChallengeBossReceive:New(self:GetOwnerPanel()))
    ---怪物悬赏
    table.insert(self.mMissions, luaclass.LeftMainMissionData_MonsterArrest:New(self:GetOwnerPanel()))
    ---灵魂任务
    table.insert(self.mMissions, luaclass.LeftMainMissionData_LingHunRenWu:New(self:GetOwnerPanel()))
    ---兵鉴任务
    table.insert(self.mMissions, luaclass.LeftMainMissionData_WeaponBookMission:New(self:GetOwnerPanel()))
end

---获取归属的界面,所有的事件注册都应当通过该界面进行
---@public
---@return UIBase
function LeftMainMissionPart:GetOwnerPanel()
    return self.mOwnerPanel
end

---释放数据
---@public
function LeftMainMissionPart:Dispose()
    self.mOwnerPanel = nil
    local missionTbl = self:GetMissions()
    if missionTbl then
        for i, v in pairs(missionTbl) do
            v:Dispose()
        end
    end
end

return LeftMainMissionPart