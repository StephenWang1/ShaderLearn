--[[本文件为工具自动生成,禁止手动修改]]
local collect_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable collect.CabinetInfo
---@type collect.CabinetInfo
collect_adj.metatable_CabinetInfo = {
    _ClassName = "collect.CabinetInfo",
}
collect_adj.metatable_CabinetInfo.__index = collect_adj.metatable_CabinetInfo
--endregion

---@param tbl collect.CabinetInfo 待调整的table数据
function collect_adj.AdjustCabinetInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, collect_adj.metatable_CabinetInfo)
    if tbl.collectionItems == nil then
        tbl.collectionItems = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.collectionItems do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.collectionItems[i])
            end
        end
    end
    if tbl.linkEffects == nil then
        tbl.linkEffects = {}
    end
end

--region metatable collect.PutCollectionItemMsg
---@type collect.PutCollectionItemMsg
collect_adj.metatable_PutCollectionItemMsg = {
    _ClassName = "collect.PutCollectionItemMsg",
}
collect_adj.metatable_PutCollectionItemMsg.__index = collect_adj.metatable_PutCollectionItemMsg
--endregion

---@param tbl collect.PutCollectionItemMsg 待调整的table数据
function collect_adj.AdjustPutCollectionItemMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, collect_adj.metatable_PutCollectionItemMsg)
    if tbl.item == nil then
        tbl.itemSpecified = false
        tbl.item = nil
    else
        if tbl.itemSpecified == nil then 
            tbl.itemSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.item)
            end
        end
    end
end

--region metatable collect.RemoveCollectionItemMsg
---@type collect.RemoveCollectionItemMsg
collect_adj.metatable_RemoveCollectionItemMsg = {
    _ClassName = "collect.RemoveCollectionItemMsg",
}
collect_adj.metatable_RemoveCollectionItemMsg.__index = collect_adj.metatable_RemoveCollectionItemMsg
--endregion

---@param tbl collect.RemoveCollectionItemMsg 待调整的table数据
function collect_adj.AdjustRemoveCollectionItemMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, collect_adj.metatable_RemoveCollectionItemMsg)
    if tbl.bagIndex == nil then
        tbl.bagIndexSpecified = false
        tbl.bagIndex = 0
    else
        tbl.bagIndexSpecified = true
    end
end

--region metatable collect.SwapCollectionItemMsg
---@type collect.SwapCollectionItemMsg
collect_adj.metatable_SwapCollectionItemMsg = {
    _ClassName = "collect.SwapCollectionItemMsg",
}
collect_adj.metatable_SwapCollectionItemMsg.__index = collect_adj.metatable_SwapCollectionItemMsg
--endregion

---@param tbl collect.SwapCollectionItemMsg 待调整的table数据
function collect_adj.AdjustSwapCollectionItemMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, collect_adj.metatable_SwapCollectionItemMsg)
end

--region metatable collect.CallbackCollectionMsg
---@type collect.CallbackCollectionMsg
collect_adj.metatable_CallbackCollectionMsg = {
    _ClassName = "collect.CallbackCollectionMsg",
}
collect_adj.metatable_CallbackCollectionMsg.__index = collect_adj.metatable_CallbackCollectionMsg
--endregion

---@param tbl collect.CallbackCollectionMsg 待调整的table数据
function collect_adj.AdjustCallbackCollectionMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, collect_adj.metatable_CallbackCollectionMsg)
    if tbl.itemIds == nil then
        tbl.itemIds = {}
    end
    if tbl.lids == nil then
        tbl.lids = {}
    end
    if tbl.cabinet == nil then
        tbl.cabinetSpecified = false
        tbl.cabinet = nil
    else
        if tbl.cabinetSpecified == nil then 
            tbl.cabinetSpecified = true
            if collect_adj.AdjustCabinetInfo ~= nil then
                collect_adj.AdjustCabinetInfo(tbl.cabinet)
            end
        end
    end
end

return collect_adj