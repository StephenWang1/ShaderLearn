---@class UIOtherRoleArtifactPanel_SinglePage:UIRoleArtifactPanel_SinglePage 其他玩加法宝单个页签
local UIOtherRoleArtifactPanel_SinglePage = {}

setmetatable(UIOtherRoleArtifactPanel_SinglePage,luaComponentTemplates.UIRoleArtifactPanel_SinglePage)

function UIOtherRoleArtifactPanel_SinglePage:InitParams()
    self:GetBtn_UIToggle().group = 11
end

---页签按钮点击
function UIOtherRoleArtifactPanel_SinglePage:PageOnClick()
    luaEventManager.DoCallback(LuaCEvent.OtherPlayerMagicEquipPageOnClick, { pageConfigInfo = self.pageConfigInfo })
end

---绑定lua红点
---@private
function UIOtherRoleArtifactPanel_SinglePage:BindLuaRedPoint()
end

return UIOtherRoleArtifactPanel_SinglePage