---lua端场景中avatar的模型类
---@class LuaAvatarModel_Npc:LuaAvatarModel
local LuaAvatarModel_Npc = {}
---所有AvatarModel类继承与LuaAvatarModel
setmetatable(LuaAvatarModel_Npc, luaclass.LuaAvatarModel)

return LuaAvatarModel_Npc