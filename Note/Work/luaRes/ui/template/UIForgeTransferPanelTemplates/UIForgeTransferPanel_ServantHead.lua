---转移重写灵兽头像界面
---@class UIForgeTransferPanel_ServantHead:UIServantInfoTemplate
local UIForgeTransferPanel_ServantHead = {}
setmetatable(UIForgeTransferPanel_ServantHead, luaComponentTemplates.UIServantInfoTemplate)

---取消灵兽Tips显示
function UIForgeTransferPanel_ServantHead:TryShowServantTip()
end

return UIForgeTransferPanel_ServantHead