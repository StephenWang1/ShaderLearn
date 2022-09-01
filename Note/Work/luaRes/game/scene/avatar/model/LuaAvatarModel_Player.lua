---lua端场景中avatar的模型类
---@class LuaAvatarModel_Player:LuaAvatarModel
local LuaAvatarModel_Player = {}
---所有AvatarModel类继承与LuaAvatarModel
setmetatable(LuaAvatarModel_Player, luaclass.LuaAvatarModel)

return LuaAvatarModel_Player