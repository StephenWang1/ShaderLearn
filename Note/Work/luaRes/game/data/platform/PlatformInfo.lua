---@class PlatformInfo:luaobject 平台信息类
local PlatformInfo = {}

---@return number 获取平台id
function PlatformInfo:GetPlatformId()
    if self.mPlatformId == nil then
        self.mPlatformId = CS.SDKManager.PlatformData:GetPlatformData().platformID
    end
    return self.mPlatformId
end

return PlatformInfo