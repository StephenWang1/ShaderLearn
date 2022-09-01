--[[本文件为工具自动生成,禁止手动修改]]
local boothV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData boothV2.BoothMapsResponse lua中的数据结构
---@return boothV2.BoothMapsResponse C#中的数据结构
function boothV2.BoothMapsResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothMapsResponse()
    if decodedData.MapIds ~= nil and decodedData.MapIdsSpecified ~= false then
        for i = 1, #decodedData.MapIds do
            data.MapIds:Add(decodedData.MapIds[i])
        end
    end
    if decodedData.lastRemoveBoothTime ~= nil and decodedData.lastRemoveBoothTimeSpecified ~= false then
        data.lastRemoveBoothTime = decodedData.lastRemoveBoothTime
    end
    return data
end

---@param decodedData boothV2.CreateBoothRequest lua中的数据结构
---@return boothV2.CreateBoothRequest C#中的数据结构
function boothV2.CreateBoothRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.CreateBoothRequest()
    if decodedData.label ~= nil and decodedData.labelSpecified ~= false then
        for i = 1, #decodedData.label do
            data.label:Add(decodedData.label[i])
        end
    end
    if decodedData.boothConfigId ~= nil and decodedData.boothConfigIdSpecified ~= false then
        data.boothConfigId = decodedData.boothConfigId
    end
    if decodedData.boothCoordinateId ~= nil and decodedData.boothCoordinateIdSpecified ~= false then
        data.boothCoordinateId = decodedData.boothCoordinateId
    end
    return data
end

---@param decodedData boothV2.ChangeBoothNameRequest lua中的数据结构
---@return boothV2.ChangeBoothNameRequest C#中的数据结构
function boothV2.ChangeBoothNameRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.ChangeBoothNameRequest()
    if decodedData.label ~= nil and decodedData.labelSpecified ~= false then
        for i = 1, #decodedData.label do
            data.label:Add(decodedData.label[i])
        end
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData boothV2.BoothIdMsg lua中的数据结构
---@return boothV2.BoothIdMsg C#中的数据结构
function boothV2.BoothIdMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothIdMsg()
    if decodedData.BoothId ~= nil and decodedData.BoothIdSpecified ~= false then
        data.BoothId = decodedData.BoothId
    end
    return data
end

---@param decodedData boothV2.BoothItemList lua中的数据结构
---@return boothV2.BoothItemList C#中的数据结构
function boothV2.BoothItemList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothItemList()
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(decodeTable.auction.AuctionItemInfo(decodedData.items[i]))
        end
    end
    return data
end

---@param decodedData boothV2.ResBoothInfo lua中的数据结构
---@return boothV2.ResBoothInfo C#中的数据结构
function boothV2.ResBoothInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.ResBoothInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = boothV2.BoothInfo(decodedData.info)
    end
    if decodedData.hasBooth ~= nil and decodedData.hasBoothSpecified ~= false then
        data.hasBooth = decodedData.hasBooth
    end
    if decodedData.moonBoothEndTime ~= nil and decodedData.moonBoothEndTimeSpecified ~= false then
        data.moonBoothEndTime = decodedData.moonBoothEndTime
    end
    return data
end

---@param decodedData boothV2.BoothInfo lua中的数据结构
---@return boothV2.BoothInfo C#中的数据结构
function boothV2.BoothInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothInfo()
    if decodedData.boothId ~= nil and decodedData.boothIdSpecified ~= false then
        data.boothId = decodedData.boothId
    end
    if decodedData.boothCoordinateId ~= nil and decodedData.boothCoordinateIdSpecified ~= false then
        data.boothCoordinateId = decodedData.boothCoordinateId
    end
    if decodedData.boothTypeId ~= nil and decodedData.boothTypeIdSpecified ~= false then
        data.boothTypeId = decodedData.boothTypeId
    end
    if decodedData.boothMapId ~= nil and decodedData.boothMapIdSpecified ~= false then
        data.boothMapId = decodedData.boothMapId
    end
    if decodedData.boothLine ~= nil and decodedData.boothLineSpecified ~= false then
        data.boothLine = decodedData.boothLine
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.isRemote ~= nil and decodedData.isRemoteSpecified ~= false then
        data.isRemote = decodedData.isRemote
    end
    if decodedData.label ~= nil and decodedData.labelSpecified ~= false then
        for i = 1, #decodedData.label do
            data.label:Add(decodedData.label[i])
        end
    end
    if decodedData.overdueTime ~= nil and decodedData.overdueTimeSpecified ~= false then
        data.overdueTime = decodedData.overdueTime
    end
    return data
end

---@param decodedData boothV2.BoothBuy lua中的数据结构
---@return boothV2.BoothBuy C#中的数据结构
function boothV2.BoothBuy(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothBuy()
    if decodedData.boothId ~= nil and decodedData.boothIdSpecified ~= false then
        data.boothId = decodedData.boothId
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData boothV2.BoothCoordinateIdMsg lua中的数据结构
---@return boothV2.BoothCoordinateIdMsg C#中的数据结构
function boothV2.BoothCoordinateIdMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothCoordinateIdMsg()
    if decodedData.boothCoordinateId ~= nil and decodedData.boothCoordinateIdSpecified ~= false then
        data.boothCoordinateId = decodedData.boothCoordinateId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData boothV2.BoothPointRequest lua中的数据结构
---@return boothV2.BoothPointRequest C#中的数据结构
function boothV2.BoothPointRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothPointRequest()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData boothV2.UpdateBoothPointResponse lua中的数据结构
---@return boothV2.UpdateBoothPointResponse C#中的数据结构
function boothV2.UpdateBoothPointResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.UpdateBoothPointResponse()
    if decodedData.boothId ~= nil and decodedData.boothIdSpecified ~= false then
        data.boothId = decodedData.boothId
    end
    if decodedData.success ~= nil and decodedData.successSpecified ~= false then
        data.success = decodedData.success
    end
    return data
end

---@param decodedData boothV2.GetShelfBoothInfo lua中的数据结构
---@return boothV2.GetShelfBoothInfo C#中的数据结构
function boothV2.GetShelfBoothInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.GetShelfBoothInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData boothV2.CancelBooth lua中的数据结构
---@return boothV2.CancelBooth C#中的数据结构
function boothV2.CancelBooth(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.CancelBooth()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData boothV2.BoothMaps lua中的数据结构
---@return boothV2.BoothMaps C#中的数据结构
function boothV2.BoothMaps(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.BoothMaps()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData boothV2.ReqUniteServerItemRadio lua中的数据结构
---@return boothV2.ReqUniteServerItemRadio C#中的数据结构
function boothV2.ReqUniteServerItemRadio(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.boothV2.ReqUniteServerItemRadio()
    if decodedData.boothCoordinateId ~= nil and decodedData.boothCoordinateIdSpecified ~= false then
        data.boothCoordinateId = decodedData.boothCoordinateId
    end
    if decodedData.boothId ~= nil and decodedData.boothIdSpecified ~= false then
        data.boothId = decodedData.boothId
    end
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        data.itemInfo = decodeTable.bag.BagItemInfo(decodedData.itemInfo)
    end
    return data
end

return boothV2