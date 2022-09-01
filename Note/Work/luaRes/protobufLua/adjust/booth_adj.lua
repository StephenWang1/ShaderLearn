--[[本文件为工具自动生成,禁止手动修改]]
local boothV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable boothV2.BoothMapsResponse
---@type boothV2.BoothMapsResponse
boothV2_adj.metatable_BoothMapsResponse = {
    _ClassName = "boothV2.BoothMapsResponse",
}
boothV2_adj.metatable_BoothMapsResponse.__index = boothV2_adj.metatable_BoothMapsResponse
--endregion

---@param tbl boothV2.BoothMapsResponse 待调整的table数据
function boothV2_adj.AdjustBoothMapsResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothMapsResponse)
    if tbl.MapIds == nil then
        tbl.MapIds = {}
    end
    if tbl.lastRemoveBoothTime == nil then
        tbl.lastRemoveBoothTimeSpecified = false
        tbl.lastRemoveBoothTime = 0
    else
        tbl.lastRemoveBoothTimeSpecified = true
    end
end

--region metatable boothV2.CreateBoothRequest
---@type boothV2.CreateBoothRequest
boothV2_adj.metatable_CreateBoothRequest = {
    _ClassName = "boothV2.CreateBoothRequest",
}
boothV2_adj.metatable_CreateBoothRequest.__index = boothV2_adj.metatable_CreateBoothRequest
--endregion

---@param tbl boothV2.CreateBoothRequest 待调整的table数据
function boothV2_adj.AdjustCreateBoothRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_CreateBoothRequest)
    if tbl.label == nil then
        tbl.label = {}
    end
    if tbl.boothConfigId == nil then
        tbl.boothConfigIdSpecified = false
        tbl.boothConfigId = 0
    else
        tbl.boothConfigIdSpecified = true
    end
    if tbl.boothCoordinateId == nil then
        tbl.boothCoordinateIdSpecified = false
        tbl.boothCoordinateId = 0
    else
        tbl.boothCoordinateIdSpecified = true
    end
end

--region metatable boothV2.ChangeBoothNameRequest
---@type boothV2.ChangeBoothNameRequest
boothV2_adj.metatable_ChangeBoothNameRequest = {
    _ClassName = "boothV2.ChangeBoothNameRequest",
}
boothV2_adj.metatable_ChangeBoothNameRequest.__index = boothV2_adj.metatable_ChangeBoothNameRequest
--endregion

---@param tbl boothV2.ChangeBoothNameRequest 待调整的table数据
function boothV2_adj.AdjustChangeBoothNameRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_ChangeBoothNameRequest)
    if tbl.label == nil then
        tbl.label = {}
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable boothV2.BoothIdMsg
---@type boothV2.BoothIdMsg
boothV2_adj.metatable_BoothIdMsg = {
    _ClassName = "boothV2.BoothIdMsg",
}
boothV2_adj.metatable_BoothIdMsg.__index = boothV2_adj.metatable_BoothIdMsg
--endregion

---@param tbl boothV2.BoothIdMsg 待调整的table数据
function boothV2_adj.AdjustBoothIdMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothIdMsg)
    if tbl.BoothId == nil then
        tbl.BoothIdSpecified = false
        tbl.BoothId = 0
    else
        tbl.BoothIdSpecified = true
    end
end

--region metatable boothV2.BoothItemList
---@type boothV2.BoothItemList
boothV2_adj.metatable_BoothItemList = {
    _ClassName = "boothV2.BoothItemList",
}
boothV2_adj.metatable_BoothItemList.__index = boothV2_adj.metatable_BoothItemList
--endregion

---@param tbl boothV2.BoothItemList 待调整的table数据
function boothV2_adj.AdjustBoothItemList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothItemList)
    if tbl.items == nil then
        tbl.items = {}
    else
        if adjustTable.auction_adj ~= nil and adjustTable.auction_adj.AdjustAuctionItemInfo ~= nil then
            for i = 1, #tbl.items do
                adjustTable.auction_adj.AdjustAuctionItemInfo(tbl.items[i])
            end
        end
    end
end

--region metatable boothV2.ResBoothInfo
---@type boothV2.ResBoothInfo
boothV2_adj.metatable_ResBoothInfo = {
    _ClassName = "boothV2.ResBoothInfo",
}
boothV2_adj.metatable_ResBoothInfo.__index = boothV2_adj.metatable_ResBoothInfo
--endregion

---@param tbl boothV2.ResBoothInfo 待调整的table数据
function boothV2_adj.AdjustResBoothInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_ResBoothInfo)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if boothV2_adj.AdjustBoothInfo ~= nil then
                boothV2_adj.AdjustBoothInfo(tbl.info)
            end
        end
    end
    if tbl.hasBooth == nil then
        tbl.hasBoothSpecified = false
        tbl.hasBooth = false
    else
        tbl.hasBoothSpecified = true
    end
    if tbl.moonBoothEndTime == nil then
        tbl.moonBoothEndTimeSpecified = false
        tbl.moonBoothEndTime = 0
    else
        tbl.moonBoothEndTimeSpecified = true
    end
end

--region metatable boothV2.BoothInfo
---@type boothV2.BoothInfo
boothV2_adj.metatable_BoothInfo = {
    _ClassName = "boothV2.BoothInfo",
}
boothV2_adj.metatable_BoothInfo.__index = boothV2_adj.metatable_BoothInfo
--endregion

---@param tbl boothV2.BoothInfo 待调整的table数据
function boothV2_adj.AdjustBoothInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothInfo)
    if tbl.boothId == nil then
        tbl.boothIdSpecified = false
        tbl.boothId = 0
    else
        tbl.boothIdSpecified = true
    end
    if tbl.boothCoordinateId == nil then
        tbl.boothCoordinateIdSpecified = false
        tbl.boothCoordinateId = 0
    else
        tbl.boothCoordinateIdSpecified = true
    end
    if tbl.boothTypeId == nil then
        tbl.boothTypeIdSpecified = false
        tbl.boothTypeId = 0
    else
        tbl.boothTypeIdSpecified = true
    end
    if tbl.boothMapId == nil then
        tbl.boothMapIdSpecified = false
        tbl.boothMapId = 0
    else
        tbl.boothMapIdSpecified = true
    end
    if tbl.boothLine == nil then
        tbl.boothLineSpecified = false
        tbl.boothLine = 0
    else
        tbl.boothLineSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.isRemote == nil then
        tbl.isRemoteSpecified = false
        tbl.isRemote = false
    else
        tbl.isRemoteSpecified = true
    end
    if tbl.label == nil then
        tbl.label = {}
    end
    if tbl.overdueTime == nil then
        tbl.overdueTimeSpecified = false
        tbl.overdueTime = 0
    else
        tbl.overdueTimeSpecified = true
    end
end

--region metatable boothV2.BoothBuy
---@type boothV2.BoothBuy
boothV2_adj.metatable_BoothBuy = {
    _ClassName = "boothV2.BoothBuy",
}
boothV2_adj.metatable_BoothBuy.__index = boothV2_adj.metatable_BoothBuy
--endregion

---@param tbl boothV2.BoothBuy 待调整的table数据
function boothV2_adj.AdjustBoothBuy(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothBuy)
    if tbl.boothId == nil then
        tbl.boothIdSpecified = false
        tbl.boothId = 0
    else
        tbl.boothIdSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable boothV2.BoothCoordinateIdMsg
---@type boothV2.BoothCoordinateIdMsg
boothV2_adj.metatable_BoothCoordinateIdMsg = {
    _ClassName = "boothV2.BoothCoordinateIdMsg",
}
boothV2_adj.metatable_BoothCoordinateIdMsg.__index = boothV2_adj.metatable_BoothCoordinateIdMsg
--endregion

---@param tbl boothV2.BoothCoordinateIdMsg 待调整的table数据
function boothV2_adj.AdjustBoothCoordinateIdMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothCoordinateIdMsg)
    if tbl.boothCoordinateId == nil then
        tbl.boothCoordinateIdSpecified = false
        tbl.boothCoordinateId = 0
    else
        tbl.boothCoordinateIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable boothV2.BoothPointRequest
---@type boothV2.BoothPointRequest
boothV2_adj.metatable_BoothPointRequest = {
    _ClassName = "boothV2.BoothPointRequest",
}
boothV2_adj.metatable_BoothPointRequest.__index = boothV2_adj.metatable_BoothPointRequest
--endregion

---@param tbl boothV2.BoothPointRequest 待调整的table数据
function boothV2_adj.AdjustBoothPointRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothPointRequest)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable boothV2.UpdateBoothPointResponse
---@type boothV2.UpdateBoothPointResponse
boothV2_adj.metatable_UpdateBoothPointResponse = {
    _ClassName = "boothV2.UpdateBoothPointResponse",
}
boothV2_adj.metatable_UpdateBoothPointResponse.__index = boothV2_adj.metatable_UpdateBoothPointResponse
--endregion

---@param tbl boothV2.UpdateBoothPointResponse 待调整的table数据
function boothV2_adj.AdjustUpdateBoothPointResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_UpdateBoothPointResponse)
    if tbl.boothId == nil then
        tbl.boothIdSpecified = false
        tbl.boothId = 0
    else
        tbl.boothIdSpecified = true
    end
    if tbl.success == nil then
        tbl.successSpecified = false
        tbl.success = 0
    else
        tbl.successSpecified = true
    end
end

--region metatable boothV2.GetShelfBoothInfo
---@type boothV2.GetShelfBoothInfo
boothV2_adj.metatable_GetShelfBoothInfo = {
    _ClassName = "boothV2.GetShelfBoothInfo",
}
boothV2_adj.metatable_GetShelfBoothInfo.__index = boothV2_adj.metatable_GetShelfBoothInfo
--endregion

---@param tbl boothV2.GetShelfBoothInfo 待调整的table数据
function boothV2_adj.AdjustGetShelfBoothInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_GetShelfBoothInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable boothV2.CancelBooth
---@type boothV2.CancelBooth
boothV2_adj.metatable_CancelBooth = {
    _ClassName = "boothV2.CancelBooth",
}
boothV2_adj.metatable_CancelBooth.__index = boothV2_adj.metatable_CancelBooth
--endregion

---@param tbl boothV2.CancelBooth 待调整的table数据
function boothV2_adj.AdjustCancelBooth(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_CancelBooth)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable boothV2.BoothMaps
---@type boothV2.BoothMaps
boothV2_adj.metatable_BoothMaps = {
    _ClassName = "boothV2.BoothMaps",
}
boothV2_adj.metatable_BoothMaps.__index = boothV2_adj.metatable_BoothMaps
--endregion

---@param tbl boothV2.BoothMaps 待调整的table数据
function boothV2_adj.AdjustBoothMaps(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_BoothMaps)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable boothV2.ReqUniteServerItemRadio
---@type boothV2.ReqUniteServerItemRadio
boothV2_adj.metatable_ReqUniteServerItemRadio = {
    _ClassName = "boothV2.ReqUniteServerItemRadio",
}
boothV2_adj.metatable_ReqUniteServerItemRadio.__index = boothV2_adj.metatable_ReqUniteServerItemRadio
--endregion

---@param tbl boothV2.ReqUniteServerItemRadio 待调整的table数据
function boothV2_adj.AdjustReqUniteServerItemRadio(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, boothV2_adj.metatable_ReqUniteServerItemRadio)
    if tbl.boothCoordinateId == nil then
        tbl.boothCoordinateIdSpecified = false
        tbl.boothCoordinateId = 0
    else
        tbl.boothCoordinateIdSpecified = true
    end
    if tbl.boothId == nil then
        tbl.boothIdSpecified = false
        tbl.boothId = 0
    else
        tbl.boothIdSpecified = true
    end
    if tbl.itemInfo == nil then
        tbl.itemInfoSpecified = false
        tbl.itemInfo = nil
    else
        if tbl.itemInfoSpecified == nil then 
            tbl.itemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemInfo)
            end
        end
    end
end

return boothV2_adj