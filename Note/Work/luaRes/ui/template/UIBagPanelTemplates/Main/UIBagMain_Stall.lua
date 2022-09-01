---背包与摊位界面组合时
---@class UIBagMain_Stall:UIBagMain_Normal
local UIBagMain_Stall = {}

setmetatable(UIBagMain_Stall, luaComponentTemplates.UIBagMainNormal)

--region重写属性
---是都显示扩展按钮
function UIBagMain_Stall:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Stall:IsShowRecycleButton()
    return false
end
--endregion

return UIBagMain_Stall