--[[本文件为工具自动生成,禁止手动修改]]
local wingV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable wingV2.WingInfo
---@type wingV2.WingInfo
wingV2_adj.metatable_WingInfo = {
    _ClassName = "wingV2.WingInfo",
}
wingV2_adj.metatable_WingInfo.__index = wingV2_adj.metatable_WingInfo
--endregion

---@param tbl wingV2.WingInfo 待调整的table数据
function wingV2_adj.AdjustWingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, wingV2_adj.metatable_WingInfo)
    if tbl.wingId == nil then
        tbl.wingIdSpecified = false
        tbl.wingId = 0
    else
        tbl.wingIdSpecified = true
    end
    if tbl.blessingValue == nil then
        tbl.blessingValueSpecified = false
        tbl.blessingValue = 0
    else
        tbl.blessingValueSpecified = true
    end
end

--region metatable wingV2.ResWingInfo
---@type wingV2.ResWingInfo
wingV2_adj.metatable_ResWingInfo = {
    _ClassName = "wingV2.ResWingInfo",
}
wingV2_adj.metatable_ResWingInfo.__index = wingV2_adj.metatable_ResWingInfo
--endregion

---@param tbl wingV2.ResWingInfo 待调整的table数据
function wingV2_adj.AdjustResWingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, wingV2_adj.metatable_ResWingInfo)
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
    if tbl.wingInfo == nil then
        tbl.wingInfoSpecified = false
        tbl.wingInfo = nil
    else
        if tbl.wingInfoSpecified == nil then 
            tbl.wingInfoSpecified = true
            if wingV2_adj.AdjustWingInfo ~= nil then
                wingV2_adj.AdjustWingInfo(tbl.wingInfo)
            end
        end
    end
end

--region metatable wingV2.ReqLevelUpWing
---@type wingV2.ReqLevelUpWing
wingV2_adj.metatable_ReqLevelUpWing = {
    _ClassName = "wingV2.ReqLevelUpWing",
}
wingV2_adj.metatable_ReqLevelUpWing.__index = wingV2_adj.metatable_ReqLevelUpWing
--endregion

---@param tbl wingV2.ReqLevelUpWing 待调整的table数据
function wingV2_adj.AdjustReqLevelUpWing(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, wingV2_adj.metatable_ReqLevelUpWing)
    if tbl.autoUseMoney == nil then
        tbl.autoUseMoneySpecified = false
        tbl.autoUseMoney = 0
    else
        tbl.autoUseMoneySpecified = true
    end
end

--region metatable wingV2.ResLevelUpWing
---@type wingV2.ResLevelUpWing
wingV2_adj.metatable_ResLevelUpWing = {
    _ClassName = "wingV2.ResLevelUpWing",
}
wingV2_adj.metatable_ResLevelUpWing.__index = wingV2_adj.metatable_ResLevelUpWing
--endregion

---@param tbl wingV2.ResLevelUpWing 待调整的table数据
function wingV2_adj.AdjustResLevelUpWing(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, wingV2_adj.metatable_ResLevelUpWing)
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
    if tbl.wingInfo == nil then
        tbl.wingInfoSpecified = false
        tbl.wingInfo = nil
    else
        if tbl.wingInfoSpecified == nil then 
            tbl.wingInfoSpecified = true
            if wingV2_adj.AdjustWingInfo ~= nil then
                wingV2_adj.AdjustWingInfo(tbl.wingInfo)
            end
        end
    end
end

return wingV2_adj