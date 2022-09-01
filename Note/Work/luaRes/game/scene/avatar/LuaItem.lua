---物品类
---@class LuaItem:LuaAvatar
local LuaItem = {}

setmetatable(LuaItem, luaclass.LuaAvatar)

---获取绑定的C#中的CSItem
---@return CSItem|nil
function LuaItem:GetCSAvatar()
    return self.mCSAvatar
end

return LuaItem