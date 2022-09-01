---@class LuaAvatarInfo_Player:LuaAvatarInfo Lua的玩家信息
local LuaAvatarInfo_Player = {}
---所有AvatarInfo类继承与LuaAvatarInfo
setmetatable(LuaAvatarInfo_Player, luaclass.LuaAvatarInfo)

return LuaAvatarInfo_Player