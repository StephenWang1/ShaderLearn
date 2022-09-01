---Lua官阶信息
---@class LuaOfficialInfo:luaobject
local LuaOfficialInfo = {}

function LuaOfficialInfo:Init()

end

---获取当前官阶信息
---@return officialV2.ResOfficialInfoV2
function LuaOfficialInfo:GetOfficialInfo()
    if (self.mOfficialInfo == nil) then
        self.mOfficialInfo = {}
    end
    return self.mOfficialInfo
end

---设置、更新当前官阶信息
function LuaOfficialInfo:SetOfficialInfo(data)
    self.mOfficialInfo = data
end

---获取当前官阶的表数据
function LuaOfficialInfo:GetCurOfficialTable()
    if (self:GetOfficialInfo() ~= nil and self:GetOfficialInfo().officialPosistionId ~= nil and self:GetOfficialInfo().officialPosistionId ~= 0) then
        local info = clientTableManager.cfg_official_positionManager:TryGetValue(self:GetOfficialInfo().officialPosistionId)
        return info
    end
    return nil
end

---获取下一官阶的表数据
---如果为nil表示当前满级
function LuaOfficialInfo:GetNextOfficialTable()
    if (self:GetOfficialInfo() ~= nil and self:GetOfficialInfo().officialPosistionId ~= nil) then
        local info = clientTableManager.cfg_official_positionManager:TryGetValue(self:GetOfficialInfo().officialPosistionId + 1)
        return info
    end
    return nil
end

---一级官阶表数据
function LuaOfficialInfo:GetFirstLevelOfficalTable()
    self.firstinfo = clientTableManager.cfg_official_positionManager:TryGetValue(1)
    return self.firstinfo
end

---获取当前升级官阶所需条件
function LuaOfficialInfo:getCurLevelUpConditionsId()
    if (self:GetNextOfficialTable() ~= nil) then
        if (#self:GetNextOfficialTable():GetCost().list >= 1) then
            return self:GetNextOfficialTable():GetConditions().list
        end
    else
        return nil
    end
end

---获取当前升级官阶所需物品Id
function LuaOfficialInfo:getCurLevelUpCostItemId()
    if (self:GetNextOfficialTable() ~= nil) then
        if (#self:GetNextOfficialTable():GetCost().list >= 1) then
            return self:GetNextOfficialTable():GetCost().list[1]
        end
    else
        return nil
    end
end

---获取当前升级官阶所需物品Id
function LuaOfficialInfo:getCurLevelUpCostItemId()
    if (self:GetNextOfficialTable() ~= nil) then
        if (#self:GetNextOfficialTable():GetCost().list >= 1) then
            return self:GetNextOfficialTable():GetCost().list[1]
        end
    else
        return nil
    end
end

---获取当前升级官阶所需物品数量
function LuaOfficialInfo:getCurLevelUpCostItemCount()
    if (self:GetNextOfficialTable() ~= nil) then
        if (#self:GetNextOfficialTable():GetCost().list >= 2) then
            return self:GetNextOfficialTable():GetCost().list[2]
        end
    else
        return nil
    end
end

return LuaOfficialInfo