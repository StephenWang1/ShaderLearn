--[[本文件为工具自动生成,禁止手动修改]]
local junxianV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData junxianV2.ReqJunXianLevel lua中的数据结构
---@return junxianV2.ReqJunXianLevel C#中的数据结构
function junxianV2.ReqJunXianLevel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.junxianV2.ReqJunXianLevel()
    return data
end

--[[junxianV2.ResJunXianLevel 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData junxianV2.ReqJunXianUp lua中的数据结构
---@return junxianV2.ReqJunXianUp C#中的数据结构
function junxianV2.ReqJunXianUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.junxianV2.ReqJunXianUp()
    if decodedData.thisJunXianId ~= nil and decodedData.thisJunXianIdSpecified ~= false then
        data.thisJunXianId = decodedData.thisJunXianId
    end
    if decodedData.nextJunXianId ~= nil and decodedData.nextJunXianIdSpecified ~= false then
        data.nextJunXianId = decodedData.nextJunXianId
    end
    if decodedData.thisNbValue ~= nil and decodedData.thisNbValueSpecified ~= false then
        data.thisNbValue = decodedData.thisNbValue
    end
    return data
end

---@param decodedData junxianV2.ResJunXianUp lua中的数据结构
---@return junxianV2.ResJunXianUp C#中的数据结构
function junxianV2.ResJunXianUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.junxianV2.ResJunXianUp()
    if decodedData.thisJunXianId ~= nil and decodedData.thisJunXianIdSpecified ~= false then
        data.thisJunXianId = decodedData.thisJunXianId
    end
    if decodedData.nextJunXianId ~= nil and decodedData.nextJunXianIdSpecified ~= false then
        data.nextJunXianId = decodedData.nextJunXianId
    end
    if decodedData.maxNbValue ~= nil and decodedData.maxNbValueSpecified ~= false then
        data.maxNbValue = decodedData.maxNbValue
    end
    return data
end

---@param decodedData junxianV2.ResRoundJunXianUp lua中的数据结构
---@return junxianV2.ResRoundJunXianUp C#中的数据结构
function junxianV2.ResRoundJunXianUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.junxianV2.ResRoundJunXianUp()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.thisJunXianId ~= nil and decodedData.thisJunXianIdSpecified ~= false then
        data.thisJunXianId = decodedData.thisJunXianId
    end
    return data
end

return junxianV2