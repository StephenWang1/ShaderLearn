---@class LuaAvatarInfo_Monster:LuaAvatarInfo Lua的怪物信息
local LuaAvatarInfo_Monster = {}
---所有AvatarInfo类继承与LuaAvatarInfo
setmetatable(LuaAvatarInfo_Monster, luaclass.LuaAvatarInfo)

return LuaAvatarInfo_Monster