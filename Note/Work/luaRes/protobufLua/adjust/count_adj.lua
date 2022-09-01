--[[本文件为工具自动生成,禁止手动修改]]
local countV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable countV2.CountInfo
---@type countV2.CountInfo
countV2_adj.metatable_CountInfo = {
    _ClassName = "countV2.CountInfo",
}
countV2_adj.metatable_CountInfo.__index = countV2_adj.metatable_CountInfo
--endregion

---@param tbl countV2.CountInfo 待调整的table数据
function countV2_adj.AdjustCountInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, countV2_adj.metatable_CountInfo)
    if tbl.countType == nil then
        tbl.countTypeSpecified = false
        tbl.countType = 0
    else
        tbl.countTypeSpecified = true
    end
    if tbl.countNum == nil then
        tbl.countNumSpecified = false
        tbl.countNum = 0
    else
        tbl.countNumSpecified = true
    end
    if tbl.key == nil then
        tbl.keySpecified = false
        tbl.key = 0
    else
        tbl.keySpecified = true
    end
end

--region metatable countV2.ResCountData
---@type countV2.ResCountData
countV2_adj.metatable_ResCountData = {
    _ClassName = "countV2.ResCountData",
}
countV2_adj.metatable_ResCountData.__index = countV2_adj.metatable_ResCountData
--endregion

---@param tbl countV2.ResCountData 待调整的table数据
function countV2_adj.AdjustResCountData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, countV2_adj.metatable_ResCountData)
    if tbl.countList == nil then
        tbl.countList = {}
    else
        if countV2_adj.AdjustCountInfo ~= nil then
            for i = 1, #tbl.countList do
                countV2_adj.AdjustCountInfo(tbl.countList[i])
            end
        end
    end
end

--region metatable countV2.ResCountChange
---@type countV2.ResCountChange
countV2_adj.metatable_ResCountChange = {
    _ClassName = "countV2.ResCountChange",
}
countV2_adj.metatable_ResCountChange.__index = countV2_adj.metatable_ResCountChange
--endregion

---@param tbl countV2.ResCountChange 待调整的table数据
function countV2_adj.AdjustResCountChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, countV2_adj.metatable_ResCountChange)
    if tbl.countType == nil then
        tbl.countTypeSpecified = false
        tbl.countType = 0
    else
        tbl.countTypeSpecified = true
    end
    if tbl.countNum == nil then
        tbl.countNumSpecified = false
        tbl.countNum = 0
    else
        tbl.countNumSpecified = true
    end
    if tbl.key == nil then
        tbl.keySpecified = false
        tbl.key = 0
    else
        tbl.keySpecified = true
    end
end

--region metatable countV2.ReqGetInstanceItemUseCount
---@type countV2.ReqGetInstanceItemUseCount
countV2_adj.metatable_ReqGetInstanceItemUseCount = {
    _ClassName = "countV2.ReqGetInstanceItemUseCount",
}
countV2_adj.metatable_ReqGetInstanceItemUseCount.__index = countV2_adj.metatable_ReqGetInstanceItemUseCount
--endregion

---@param tbl countV2.ReqGetInstanceItemUseCount 待调整的table数据
function countV2_adj.AdjustReqGetInstanceItemUseCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, countV2_adj.metatable_ReqGetInstanceItemUseCount)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.globalId == nil then
        tbl.globalId = {}
    end
end

--region metatable countV2.ResCountShareUsed
---@type countV2.ResCountShareUsed
countV2_adj.metatable_ResCountShareUsed = {
    _ClassName = "countV2.ResCountShareUsed",
}
countV2_adj.metatable_ResCountShareUsed.__index = countV2_adj.metatable_ResCountShareUsed
--endregion

---@param tbl countV2.ResCountShareUsed 待调整的table数据
function countV2_adj.AdjustResCountShareUsed(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, countV2_adj.metatable_ResCountShareUsed)
    if tbl.useCount == nil then
        tbl.useCount = {}
    end
end

return countV2_adj