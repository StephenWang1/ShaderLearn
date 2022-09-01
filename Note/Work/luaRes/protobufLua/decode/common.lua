--[[本文件为工具自动生成,禁止手动修改]]
local commonV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData commonV2.IntIntStruct lua中的数据结构
---@return commonV2.IntIntStruct C#中的数据结构
function commonV2.IntIntStruct(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.commonV2.IntIntStruct()
    data.key = decodedData.key
    data.value = decodedData.value
    return data
end

---@param decodedData commonV2.LongLongStruct lua中的数据结构
---@return commonV2.LongLongStruct C#中的数据结构
function commonV2.LongLongStruct(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.commonV2.LongLongStruct()
    data.key = decodedData.key
    data.value = decodedData.value
    return data
end

---@param decodedData commonV2.IntStringStruct lua中的数据结构
---@return commonV2.IntStringStruct C#中的数据结构
function commonV2.IntStringStruct(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.commonV2.IntStringStruct()
    data.key = decodedData.key
    data.value = decodedData.value
    return data
end

---@param decodedData commonV2.PlayerPropertyG2S lua中的数据结构
---@return commonV2.PlayerPropertyG2S C#中的数据结构
function commonV2.PlayerPropertyG2S(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.commonV2.PlayerPropertyG2S()
    if decodedData.emperorTokenId ~= nil and decodedData.emperorTokenIdSpecified ~= false then
        data.emperorTokenId = decodedData.emperorTokenId
    end
    if decodedData.tarotTonkenNum ~= nil and decodedData.tarotTonkenNumSpecified ~= false then
        data.tarotTonkenNum = decodedData.tarotTonkenNum
    end
    return data
end

return commonV2