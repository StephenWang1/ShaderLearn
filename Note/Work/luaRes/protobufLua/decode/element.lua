--[[本文件为工具自动生成,禁止手动修改]]
local elementV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData elementV2.ResElementSuitInfo lua中的数据结构
---@return elementV2.ResElementSuitInfo C#中的数据结构
function elementV2.ResElementSuitInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.elementV2.ResElementSuitInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.elementInfos ~= nil and decodedData.elementInfosSpecified ~= false then
        for i = 1, #decodedData.elementInfos do
            data.elementInfos:Add(elementV2.ElementInfo(decodedData.elementInfos[i]))
        end
    end
    if decodedData.suitInfos ~= nil and decodedData.suitInfosSpecified ~= false then
        for i = 1, #decodedData.suitInfos do
            data.suitInfos:Add(elementV2.ElementSuit(decodedData.suitInfos[i]))
        end
    end
    if decodedData.isPutUp ~= nil and decodedData.isPutUpSpecified ~= false then
        data.isPutUp = decodedData.isPutUp
    end
    if decodedData.isTakeOff ~= nil and decodedData.isTakeOffSpecified ~= false then
        data.isTakeOff = decodedData.isTakeOff
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData elementV2.ElementInfo lua中的数据结构
---@return elementV2.ElementInfo C#中的数据结构
function elementV2.ElementInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.elementV2.ElementInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.bagItemInfo ~= nil and decodedData.bagItemInfoSpecified ~= false then
        data.bagItemInfo = decodeTable.bag.BagItemInfo(decodedData.bagItemInfo)
    end
    return data
end

---@param decodedData elementV2.ReqPutUpElement lua中的数据结构
---@return elementV2.ReqPutUpElement C#中的数据结构
function elementV2.ReqPutUpElement(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.elementV2.ReqPutUpElement()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.elementId ~= nil and decodedData.elementIdSpecified ~= false then
        data.elementId = decodedData.elementId
    end
    return data
end

---@param decodedData elementV2.ReqTakeOffElement lua中的数据结构
---@return elementV2.ReqTakeOffElement C#中的数据结构
function elementV2.ReqTakeOffElement(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.elementV2.ReqTakeOffElement()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData elementV2.ElementSuit lua中的数据结构
---@return elementV2.ElementSuit C#中的数据结构
function elementV2.ElementSuit(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.elementV2.ElementSuit()
    if decodedData.subType ~= nil and decodedData.subTypeSpecified ~= false then
        data.subType = decodedData.subType
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.suitId ~= nil and decodedData.suitIdSpecified ~= false then
        data.suitId = decodedData.suitId
    end
    if decodedData.suitValue ~= nil and decodedData.suitValueSpecified ~= false then
        data.suitValue = decodedData.suitValue
    end
    if decodedData.point ~= nil and decodedData.pointSpecified ~= false then
        data.point = decodedData.point
    end
    return data
end

return elementV2