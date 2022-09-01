---第一个任务未完成背包
---@class UIBagMain_UnFinishFirstMission:UIBagMain_Normal
local UIBagMain_UnFinishFirstMission = {}

setmetatable(UIBagMain_UnFinishFirstMission, luaComponentTemplates.UIBagMainNormal)

--region重写属性
---是否显示扩展按钮
function UIBagMain_UnFinishFirstMission:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_UnFinishFirstMission:IsShowRecycleButton()
    return false
end
--endregion

return UIBagMain_UnFinishFirstMission