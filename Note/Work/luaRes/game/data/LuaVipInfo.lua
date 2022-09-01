---@class LuaVipInfo:luaobject
local LuaVipInfo = {}

function LuaVipInfo:Init()

end

--region 获取、设置VIP数据
---@return vipV2.ResRoleVipInfo
function LuaVipInfo:GetPlayerVipData()
    if (self.mPlayerVipData == nil) then
        self.mPlayerVipData = {}
    end
    return self.mPlayerVipData
end

---@param info vipV2.ResRoleVip2Info
function LuaVipInfo:SetPlayerVipData(info)
    self.mPlayerVipData = info
end

---@param info vipV2.ResRoleVipInfoChange
function LuaVipInfo:ChangePlayerVipData(info)
    self:GetPlayerVipData().level = info.curLevel
    self:GetPlayerVipData().exp = info.curExp
end
--endregion

--region 获取VIP相关数据
---@return number
function LuaVipInfo:GetPlayerVipLevel()
    if (self:GetPlayerVipData() ~= nil and self:GetPlayerVipData().level ~= nil) then
        return self:GetPlayerVipData().level
    else
        return 0
    end
end
--endregion

function LuaVipInfo:OnDestroy()

end

return LuaVipInfo