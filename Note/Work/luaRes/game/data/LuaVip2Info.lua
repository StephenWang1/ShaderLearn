---Vip类
---@class LuaVip2Info:luaobject
local LuaVip2Info = {}

function LuaVip2Info:Init()
    --Table[Key:number,Value:string]
    self.Vip2PrivilegeTable = {}
end

--region 获取、设置VIP2数据
---@return vipV2.ResRoleVip2Info
function LuaVip2Info:GetPlayerVip2Data()
    if (self.mPlayerVip2Data == nil) then
        self.mPlayerVip2Data = {}
    end
    return self.mPlayerVip2Data
end

---@param info vipV2.ResRoleVip2Info
function LuaVip2Info:SetPlayerVip2Data(info)
    self.mPlayerVip2Data = info
end

---@param info vipV2.ResRoleVip2InfoChange
function LuaVip2Info:ChangePlayerVip2Data(info)
    self:GetPlayerVip2Data().level = info.curLevel
    self:GetPlayerVip2Data().exp = info.curExp
end

function LuaVip2Info:GetVipIconId(level)
    local tableinfo = nil
    if(level == nil) then
        level = self:GetPlayerVip2Data().level
    end
    tableinfo = clientTableManager.cfg_vip_levelManager:TryGetValue(level)
    if(tableinfo~=nil)then
        self.VipIconId = string.Split(tableinfo:GetIconId(), "#")
    end
    return self.VipIconId
end

--endregion

--region 获取VIP2相关属性
---@return number
function LuaVip2Info:GetPlayerVip2Level()
    if (self:GetPlayerVip2Data() ~= nil and self:GetPlayerVip2Data().level ~= nil) then
        return self:GetPlayerVip2Data().level
    else
        return 0
    end
end

---@param level number 获取对应等级的特权描述
function LuaVip2Info:GetPrivilege(level)
    if (self.Vip2PrivilegeTable[level] == nil) then
        local tableinfo = clientTableManager.cfg_vip_levelManager:TryGetValue(level)
        if (tableinfo ~= nil) then
            self.Vip2PrivilegeTable[level] = string.Split(tableinfo:GetPrivilege(), "#")
        end
    end
    if (self.Vip2PrivilegeTable[level] ~= nil) then
        return self.Vip2PrivilegeTable[level]
    else
        return {}
    end
end
--endregion

function LuaVip2Info:OnDestroy()

end

return LuaVip2Info