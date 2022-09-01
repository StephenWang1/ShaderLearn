---@class LuaAvatarInfo_Servant:LuaAvatarInfo Lua的灵兽信息
local LuaAvatarInfo_Servant = {}
---所有AvatarInfo类继承与LuaAvatarInfo
setmetatable(LuaAvatarInfo_Servant, luaclass.LuaAvatarInfo)

return LuaAvatarInfo_Servant