---其他玩家类
---@class LuaPlayer:LuaAvatar
local LuaPlayer = {}

setmetatable(LuaPlayer, luaclass.LuaAvatar)

--region 获取
---获取连服前缀名
function LuaPlayer:GetLianFuPlatformPrefixName()
    if self.mCSAvatar ~= nil and self.mCSAvatar.Info ~= nil then
        return self.mCSAvatar.Info.LianFuPrefixName
    end
end
--endregion

return LuaPlayer