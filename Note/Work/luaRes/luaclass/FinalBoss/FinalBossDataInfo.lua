---@class FinalBossDataInfo 终极boss数据类
local FinalBossDataInfo = {}

--region 数据
---@private
---@type MythBossDataInfo 神级装备数据类
FinalBossDataInfo.MythBossDataInfo = nil
--endregion

--region 获取
---@public
---获取神级boss数据类
---@return MythBossDataInfo
function FinalBossDataInfo:GetMythBossDataInfo()
    if self.MythBossDataInfo == nil then
        self.MythBossDataInfo = luaclass.MythBossDataInfo:New()
    end
    return self.MythBossDataInfo
end
--endregion

return FinalBossDataInfo