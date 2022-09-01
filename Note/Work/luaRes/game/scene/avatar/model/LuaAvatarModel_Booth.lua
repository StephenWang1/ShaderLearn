---lua端场景中avatar的模型类
---@class LuaAvatarModel_Booth:LuaAvatarModel
local LuaAvatarModel_Booth = {}
---所有AvatarModel类继承与LuaAvatarModel
setmetatable(LuaAvatarModel_Booth, luaclass.LuaAvatarModel)

return LuaAvatarModel_Booth