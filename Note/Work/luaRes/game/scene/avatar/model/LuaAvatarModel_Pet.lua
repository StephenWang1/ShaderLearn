---lua端场景中avatar的模型类
---@class LuaAvatarModel_Pet:LuaAvatarModel
local LuaAvatarModel_Pet = {}
---所有AvatarModel类继承与LuaAvatarModel
setmetatable(LuaAvatarModel_Pet, luaclass.LuaAvatarModel)

return LuaAvatarModel_Pet