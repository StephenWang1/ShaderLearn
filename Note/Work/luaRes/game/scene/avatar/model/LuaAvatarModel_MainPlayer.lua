---lua端场景中avatar的模型类
---@class LuaAvatarModel_MainPlayer:LuaAvatarModel
local LuaAvatarModel_MainPlayer = {}
---所有AvatarModel类继承与LuaAvatarModel
setmetatable(LuaAvatarModel_MainPlayer, luaclass.LuaAvatarModel)

return LuaAvatarModel_MainPlayer