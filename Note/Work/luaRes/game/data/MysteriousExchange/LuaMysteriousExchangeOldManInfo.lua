---@class LuaMysteriousExchangeOldManInfo:luaobject
local LuaMysteriousExchangeOldManInfo = {}

function LuaMysteriousExchangeOldManInfo:GetLuaMysteriousExchangeOldManInfo()
    if (self.mLuaMysteriousExchangeOldManInfo ~= nil) then
        return self.mLuaMysteriousExchangeOldManInfo
    else
        self.mLuaMysteriousExchangeOldManInfo = {}
        return self.mLuaMysteriousExchangeOldManInfo
    end
end

function LuaMysteriousExchangeOldManInfo:SetLuaMysteriousExchangeOldManInfo(info)
    self.mLuaMysteriousExchangeOldManInfo = info
end

return LuaMysteriousExchangeOldManInfo