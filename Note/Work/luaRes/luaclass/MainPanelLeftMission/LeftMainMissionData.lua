---主界面左侧(伪)任务数据,用于额外填充左侧任务栏中的数据
---@class LeftMainMissionData:luaobject
local LeftMainMissionData = {}

---获取排序时的index,越大越靠上,返回None时表示不显示该数据了
---@return LuaEnumLeftMainMissionSortIndex
function LeftMainMissionData:GetSortIndex()
    return LuaEnumLeftMainMissionSortIndex.None
end

---返回归属的界面,一般用于绑定事件
---@return UIMissionPanel
function LeftMainMissionData:GetOwnerPanel()
    return self.mOwnerPanel
end

---初始化
---@private
---@param ownerPanel UIBase 所归属的界面
function LeftMainMissionData:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    self:Initialize()
end

---初始化数据
---@protected
function LeftMainMissionData:Initialize()
    ---to do by subclass
end

---触发一次MissionPanel的整体刷新
---@public
function LeftMainMissionData:Refresh()
    if self:GetOwnerPanel() ~= nil and self:GetOwnerPanel().missionTemplate ~= nil then
        self:GetOwnerPanel().missionTemplate:ShowMissions()
    end
end

---刷新模板的UI
---@public
---@param template UIMissionInfoTemplates
function LeftMainMissionData:OnRefreshUI(template)
    ---to do by subclass
end

---释放,界面关闭时调用,如果没有需要执行的操作则不需要重写
---@public
function LeftMainMissionData:Dispose()
    ---to do by subclass
end

return LeftMainMissionData