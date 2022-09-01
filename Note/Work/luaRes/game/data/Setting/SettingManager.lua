---@class SettingManager 设置管理类
local SettingManager = {}

--region 事件触发
---等级变动
function SettingManager:LevelChange()
    if Utility.IsMainPlayerMatchConditionList_AND(LuaGlobalTableDeal.GetLevelChangeSetMapBossBornToggleConditionList()).success == true then
        self:SetMonsterPointShowState(true)
    end
end
--endregion

--region 小地图
---设置小地图怪物出生点显示勾选状态
---@param state boolean
function SettingManager:SetMonsterPointShowState(state)
    if type(state) ~= 'boolean' then
        return
    end
    CS.UIMapPanelController.IsLimitMonsterPointShow = state
end
--endregion

return SettingManager