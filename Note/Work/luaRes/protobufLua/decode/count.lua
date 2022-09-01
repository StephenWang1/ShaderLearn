--[[本文件为工具自动生成,禁止手动修改]]
local countV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData countV2.CountInfo lua中的数据结构
---@return countV2.CountInfo C#中的数据结构
function countV2.CountInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.countV2.CountInfo()
    if decodedData.countType ~= nil and decodedData.countTypeSpecified ~= false then
        data.countType = decodedData.countType
    end
    if decodedData.countNum ~= nil and decodedData.countNumSpecified ~= false then
        data.countNum = decodedData.countNum
    end
    if decodedData.key ~= nil and decodedData.keySpecified ~= false then
        data.key = decodedData.key
    end
    return data
end

---@param decodedData countV2.ResCountData lua中的数据结构
---@return countV2.ResCountData C#中的数据结构
function countV2.ResCountData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.countV2.ResCountData()
    if decodedData.countList ~= nil and decodedData.countListSpecified ~= false then
        for i = 1, #decodedData.countList do
            data.countList:Add(countV2.CountInfo(decodedData.countList[i]))
        end
    end
    return data
end

--[[countV2.ResCountChange 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData countV2.ReqGetInstanceItemUseCount lua中的数据结构
---@return countV2.ReqGetInstanceItemUseCount C#中的数据结构
function countV2.ReqGetInstanceItemUseCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.countV2.ReqGetInstanceItemUseCount()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.globalId ~= nil and decodedData.globalIdSpecified ~= false then
        for i = 1, #decodedData.globalId do
            data.globalId:Add(decodedData.globalId[i])
        end
    end
    return data
end

--[[countV2.ResCountShareUsed 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return countV2