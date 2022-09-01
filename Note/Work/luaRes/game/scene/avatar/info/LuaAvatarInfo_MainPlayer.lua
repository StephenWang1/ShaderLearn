---@class LuaAvatarInfo_MainPlayer:LuaAvatarInfo Lua的主角信息
local LuaAvatarInfo_MainPlayer = {}
---所有AvatarInfo类继承与LuaAvatarInfo
setmetatable(LuaAvatarInfo_MainPlayer, luaclass.LuaAvatarInfo)

return LuaAvatarInfo_MainPlayer