---特殊活动基类
---@class SpecialActivityBase:luaobject
local SpecialActivityBase = {}

---返回nil表示使用服务器的红点判定,返回boolean值表示覆盖服务器的红点判定
---@overload
---@return boolean|nil
function SpecialActivityBase:GetRedPointState()
    return nil
end

return SpecialActivityBase