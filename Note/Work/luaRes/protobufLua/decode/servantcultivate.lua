--[[本文件为工具自动生成,禁止手动修改]]
local servantcultivateV2 = {}

local decodeTable = protobufMgr.DecodeTable

--[[servantcultivateV2.reqCultivateInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData servantcultivateV2.reqFlyInfo lua中的数据结构
---@return servantcultivateV2.reqFlyInfo C#中的数据结构
function servantcultivateV2.reqFlyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantcultivateV2.reqFlyInfo()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.toX ~= nil and decodedData.toXSpecified ~= false then
        data.toX = decodedData.toX
    end
    if decodedData.toY ~= nil and decodedData.toYSpecified ~= false then
        data.toY = decodedData.toY
    end
    return data
end

--[[servantcultivateV2.resCultivateInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData servantcultivateV2.dieTimeInfo lua中的数据结构
---@return servantcultivateV2.dieTimeInfo C#中的数据结构
function servantcultivateV2.dieTimeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantcultivateV2.dieTimeInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.dieTimeS ~= nil and decodedData.dieTimeSSpecified ~= false then
        data.dieTimeS = decodedData.dieTimeS
    end
    return data
end

--[[servantcultivateV2.cultivateRedInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[servantcultivateV2.reqOpenDlg 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return servantcultivateV2