---lua端场景中avatar的模型类
---@class LuaAvatarModel_Servant:LuaAvatarModel
local LuaAvatarModel_Servant = {}
---所有AvatarModel类继承与LuaAvatarModel
setmetatable(LuaAvatarModel_Servant, luaclass.LuaAvatarModel)

return LuaAvatarModel_Servant