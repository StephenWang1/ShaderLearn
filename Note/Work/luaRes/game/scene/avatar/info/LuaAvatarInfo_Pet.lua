---@class LuaAvatarInfo_Pet:LuaAvatarInfo Lua的宠物信息
local LuaAvatarInfo_Pet = {}
---所有AvatarInfo类继承与LuaAvatarInfo
setmetatable(LuaAvatarInfo_Pet, luaclass.LuaAvatarInfo)

return LuaAvatarInfo_Pet