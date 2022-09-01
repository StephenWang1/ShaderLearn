--[[本文件为工具自动生成,禁止手动修改]]
local elementV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable elementV2.ResElementSuitInfo
---@type elementV2.ResElementSuitInfo
elementV2_adj.metatable_ResElementSuitInfo = {
    _ClassName = "elementV2.ResElementSuitInfo",
}
elementV2_adj.metatable_ResElementSuitInfo.__index = elementV2_adj.metatable_ResElementSuitInfo
--endregion

---@param tbl elementV2.ResElementSuitInfo 待调整的table数据
function elementV2_adj.AdjustResElementSuitInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, elementV2_adj.metatable_ResElementSuitInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.elementInfos == nil then
        tbl.elementInfos = {}
    else
        if elementV2_adj.AdjustElementInfo ~= nil then
            for i = 1, #tbl.elementInfos do
                elementV2_adj.AdjustElementInfo(tbl.elementInfos[i])
            end
        end
    end
    if tbl.suitInfos == nil then
        tbl.suitInfos = {}
    else
        if elementV2_adj.AdjustElementSuit ~= nil then
            for i = 1, #tbl.suitInfos do
                elementV2_adj.AdjustElementSuit(tbl.suitInfos[i])
            end
        end
    end
    if tbl.isPutUp == nil then
        tbl.isPutUpSpecified = false
        tbl.isPutUp = false
    else
        tbl.isPutUpSpecified = true
    end
    if tbl.isTakeOff == nil then
        tbl.isTakeOffSpecified = false
        tbl.isTakeOff = false
    else
        tbl.isTakeOffSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable elementV2.ElementInfo
---@type elementV2.ElementInfo
elementV2_adj.metatable_ElementInfo = {
    _ClassName = "elementV2.ElementInfo",
}
elementV2_adj.metatable_ElementInfo.__index = elementV2_adj.metatable_ElementInfo
--endregion

---@param tbl elementV2.ElementInfo 待调整的table数据
function elementV2_adj.AdjustElementInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, elementV2_adj.metatable_ElementInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.bagItemInfo == nil then
        tbl.bagItemInfoSpecified = false
        tbl.bagItemInfo = nil
    else
        if tbl.bagItemInfoSpecified == nil then 
            tbl.bagItemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.bagItemInfo)
            end
        end
    end
end

--region metatable elementV2.ReqPutUpElement
---@type elementV2.ReqPutUpElement
elementV2_adj.metatable_ReqPutUpElement = {
    _ClassName = "elementV2.ReqPutUpElement",
}
elementV2_adj.metatable_ReqPutUpElement.__index = elementV2_adj.metatable_ReqPutUpElement
--endregion

---@param tbl elementV2.ReqPutUpElement 待调整的table数据
function elementV2_adj.AdjustReqPutUpElement(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, elementV2_adj.metatable_ReqPutUpElement)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.elementId == nil then
        tbl.elementIdSpecified = false
        tbl.elementId = 0
    else
        tbl.elementIdSpecified = true
    end
end

--region metatable elementV2.ReqTakeOffElement
---@type elementV2.ReqTakeOffElement
elementV2_adj.metatable_ReqTakeOffElement = {
    _ClassName = "elementV2.ReqTakeOffElement",
}
elementV2_adj.metatable_ReqTakeOffElement.__index = elementV2_adj.metatable_ReqTakeOffElement
--endregion

---@param tbl elementV2.ReqTakeOffElement 待调整的table数据
function elementV2_adj.AdjustReqTakeOffElement(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, elementV2_adj.metatable_ReqTakeOffElement)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable elementV2.ElementSuit
---@type elementV2.ElementSuit
elementV2_adj.metatable_ElementSuit = {
    _ClassName = "elementV2.ElementSuit",
}
elementV2_adj.metatable_ElementSuit.__index = elementV2_adj.metatable_ElementSuit
--endregion

---@param tbl elementV2.ElementSuit 待调整的table数据
function elementV2_adj.AdjustElementSuit(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, elementV2_adj.metatable_ElementSuit)
    if tbl.subType == nil then
        tbl.subTypeSpecified = false
        tbl.subType = 0
    else
        tbl.subTypeSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.suitId == nil then
        tbl.suitIdSpecified = false
        tbl.suitId = 0
    else
        tbl.suitIdSpecified = true
    end
    if tbl.suitValue == nil then
        tbl.suitValueSpecified = false
        tbl.suitValue = 0
    else
        tbl.suitValueSpecified = true
    end
    if tbl.point == nil then
        tbl.pointSpecified = false
        tbl.point = 0
    else
        tbl.pointSpecified = true
    end
end

return elementV2_adj