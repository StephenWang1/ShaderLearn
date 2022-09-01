---@class LuaDuplicateMgr
local LuaDuplicateMgr = {}

function LuaDuplicateMgr:Init()
    self.shiwang = nil
end

--region 尸王殿
---@type duplicateV2.RaiderInfo
function LuaDuplicateMgr:RefreshShiWangData(tblData)
    self.shiwang = tblData
end

---@return duplicateV2.RaiderInfo
function LuaDuplicateMgr:GetShiWangData()
    return self.shiwang
end
--endregion


return LuaDuplicateMgr