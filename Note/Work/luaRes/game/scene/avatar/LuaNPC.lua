---NPC类
---@class LuaNPC:LuaAvatar
local LuaNPC = {}

setmetatable(LuaNPC, luaclass.LuaAvatar)

---获取C#NpcInfo
---@return CSNpcInfo
function LuaNPC:GetCSNpcInfo()
    if self.mCSNpcInfo == nil and self:GetCSAvatar() ~= nil then
        self.mCSNpcInfo = self:GetCSAvatar().Info
    end
    return self.mCSNpcInfo
end

---获取npc表
---@return TABLE.CFG_NPC
function LuaNPC:GetNpcTable()
    if self.mNpcTbl == nil and self:GetCSNpcInfo() ~= nil then
        self.mNpcTbl = self:GetCSNpcInfo().NpcTbl
    end
    return self.mNpcTbl
end

return LuaNPC