---@class PlatformMgr:luaobject 平台管理累
local PlatformMgr = {}

---@return PlatformInfo
function PlatformMgr:GetPlatformInfo()
    if self.mPlatformInfo == nil then
        self.mPlatformInfo = luaclass.PlatformInfo:New()
    end
    return self.mPlatformInfo
end

return PlatformMgr