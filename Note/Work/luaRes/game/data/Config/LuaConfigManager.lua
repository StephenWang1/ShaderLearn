---@class LuaConfigManager 玩家设置数据类
local LuaConfigManager = {}

---@return LuaConfig_BagRecycle
function LuaConfigManager:GetBagRecycleData()
    if self.mBagRecycleData == nil then
        self.mBagRecycleData = luaclass.LuaConfig_BagRecycle:New()
    end
    return self.mBagRecycleData
end

return LuaConfigManager