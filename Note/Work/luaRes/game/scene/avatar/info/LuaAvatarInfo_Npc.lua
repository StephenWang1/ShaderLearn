---@class LuaAvatarInfo_Npc:LuaAvatarInfo Lua的NPC信息
local LuaAvatarInfo_Npc = {}
---所有AvatarInfo类继承与LuaAvatarInfo
setmetatable(LuaAvatarInfo_Npc, luaclass.LuaAvatarInfo)

return LuaAvatarInfo_Npc