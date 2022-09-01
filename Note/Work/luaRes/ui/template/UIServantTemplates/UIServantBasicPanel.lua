---灵兽子界面的基类,仅提供接口,不实现功能
---@class UIServantBasicPanel:TemplateBase
local UIServantBasicPanel = {}

---显示
function UIServantBasicPanel:Show()

end

---隐藏
function UIServantBasicPanel:Hide()

end

---是否显示折叠部分
function UIServantBasicPanel:ShowFull(full)

end

---是否显示箭头
---@return boolean
function UIServantBasicPanel:IsShowArrow()

end

---刷新灵兽
---@param servantInfo servantV2.ServantInfo
---@param panelOpenType LuaEnumPanelOpenSourceType 灵兽界面打开类型(可以为空)
---@param bagItemInfo bagV2.BagItemInfo 设置默认选中格子
function UIServantBasicPanel:RefreshServant(servantInfo, panelOpenType, bagItemInfo)

end

function UIServantBasicPanel:OnUpdate()

end

return UIServantBasicPanel