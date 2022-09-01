--[[本文件为工具自动生成,禁止手动修改]]
local servantcultivateV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable servantcultivateV2.reqCultivateInfo
---@type servantcultivateV2.reqCultivateInfo
servantcultivateV2_adj.metatable_reqCultivateInfo = {
    _ClassName = "servantcultivateV2.reqCultivateInfo",
}
servantcultivateV2_adj.metatable_reqCultivateInfo.__index = servantcultivateV2_adj.metatable_reqCultivateInfo
--endregion

---@param tbl servantcultivateV2.reqCultivateInfo 待调整的table数据
function servantcultivateV2_adj.AdjustreqCultivateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantcultivateV2_adj.metatable_reqCultivateInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.hscultivationConfigId == nil then
        tbl.hscultivationConfigIdSpecified = false
        tbl.hscultivationConfigId = 0
    else
        tbl.hscultivationConfigIdSpecified = true
    end
end

--region metatable servantcultivateV2.reqFlyInfo
---@type servantcultivateV2.reqFlyInfo
servantcultivateV2_adj.metatable_reqFlyInfo = {
    _ClassName = "servantcultivateV2.reqFlyInfo",
}
servantcultivateV2_adj.metatable_reqFlyInfo.__index = servantcultivateV2_adj.metatable_reqFlyInfo
--endregion

---@param tbl servantcultivateV2.reqFlyInfo 待调整的table数据
function servantcultivateV2_adj.AdjustreqFlyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantcultivateV2_adj.metatable_reqFlyInfo)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.toX == nil then
        tbl.toXSpecified = false
        tbl.toX = 0
    else
        tbl.toXSpecified = true
    end
    if tbl.toY == nil then
        tbl.toYSpecified = false
        tbl.toY = 0
    else
        tbl.toYSpecified = true
    end
end

--region metatable servantcultivateV2.resCultivateInfo
---@type servantcultivateV2.resCultivateInfo
servantcultivateV2_adj.metatable_resCultivateInfo = {
    _ClassName = "servantcultivateV2.resCultivateInfo",
}
servantcultivateV2_adj.metatable_resCultivateInfo.__index = servantcultivateV2_adj.metatable_resCultivateInfo
--endregion

---@param tbl servantcultivateV2.resCultivateInfo 待调整的table数据
function servantcultivateV2_adj.AdjustresCultivateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantcultivateV2_adj.metatable_resCultivateInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.timeBeinS == nil then
        tbl.timeBeinSSpecified = false
        tbl.timeBeinS = 0
    else
        tbl.timeBeinSSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.status == nil then
        tbl.statusSpecified = false
        tbl.status = 0
    else
        tbl.statusSpecified = true
    end
    if tbl.reasons == nil then
        tbl.reasonsSpecified = false
        tbl.reasons = 0
    else
        tbl.reasonsSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.mapLine == nil then
        tbl.mapLineSpecified = false
        tbl.mapLine = 0
    else
        tbl.mapLineSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.dieTimeMap == nil then
        tbl.dieTimeMap = {}
    else
        if servantcultivateV2_adj.AdjustdieTimeInfo ~= nil then
            for i = 1, #tbl.dieTimeMap do
                servantcultivateV2_adj.AdjustdieTimeInfo(tbl.dieTimeMap[i])
            end
        end
    end
    if tbl.clearCD == nil then
        tbl.clearCDSpecified = false
        tbl.clearCD = 0
    else
        tbl.clearCDSpecified = true
    end
end

--region metatable servantcultivateV2.dieTimeInfo
---@type servantcultivateV2.dieTimeInfo
servantcultivateV2_adj.metatable_dieTimeInfo = {
    _ClassName = "servantcultivateV2.dieTimeInfo",
}
servantcultivateV2_adj.metatable_dieTimeInfo.__index = servantcultivateV2_adj.metatable_dieTimeInfo
--endregion

---@param tbl servantcultivateV2.dieTimeInfo 待调整的table数据
function servantcultivateV2_adj.AdjustdieTimeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantcultivateV2_adj.metatable_dieTimeInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.dieTimeS == nil then
        tbl.dieTimeSSpecified = false
        tbl.dieTimeS = 0
    else
        tbl.dieTimeSSpecified = true
    end
end

--region metatable servantcultivateV2.cultivateRedInfo
---@type servantcultivateV2.cultivateRedInfo
servantcultivateV2_adj.metatable_cultivateRedInfo = {
    _ClassName = "servantcultivateV2.cultivateRedInfo",
}
servantcultivateV2_adj.metatable_cultivateRedInfo.__index = servantcultivateV2_adj.metatable_cultivateRedInfo
--endregion

---@param tbl servantcultivateV2.cultivateRedInfo 待调整的table数据
function servantcultivateV2_adj.AdjustcultivateRedInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantcultivateV2_adj.metatable_cultivateRedInfo)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.mapLine == nil then
        tbl.mapLineSpecified = false
        tbl.mapLine = 0
    else
        tbl.mapLineSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.reasons == nil then
        tbl.reasonsSpecified = false
        tbl.reasons = 0
    else
        tbl.reasonsSpecified = true
    end
    if tbl.killName == nil then
        tbl.killNameSpecified = false
        tbl.killName = ""
    else
        tbl.killNameSpecified = true
    end
end

--region metatable servantcultivateV2.reqOpenDlg
---@type servantcultivateV2.reqOpenDlg
servantcultivateV2_adj.metatable_reqOpenDlg = {
    _ClassName = "servantcultivateV2.reqOpenDlg",
}
servantcultivateV2_adj.metatable_reqOpenDlg.__index = servantcultivateV2_adj.metatable_reqOpenDlg
--endregion

---@param tbl servantcultivateV2.reqOpenDlg 待调整的table数据
function servantcultivateV2_adj.AdjustreqOpenDlg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantcultivateV2_adj.metatable_reqOpenDlg)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

return servantcultivateV2_adj