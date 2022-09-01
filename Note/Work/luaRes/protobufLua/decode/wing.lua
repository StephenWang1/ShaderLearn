--[[本文件为工具自动生成,禁止手动修改]]
local wingV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData wingV2.WingInfo lua中的数据结构
---@return wingV2.WingInfo C#中的数据结构
function wingV2.WingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.wingV2.WingInfo()
    if decodedData.wingId ~= nil and decodedData.wingIdSpecified ~= false then
        data.wingId = decodedData.wingId
    end
    if decodedData.blessingValue ~= nil and decodedData.blessingValueSpecified ~= false then
        data.blessingValue = decodedData.blessingValue
    end
    return data
end

--[[wingV2.ResWingInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData wingV2.ReqLevelUpWing lua中的数据结构
---@return wingV2.ReqLevelUpWing C#中的数据结构
function wingV2.ReqLevelUpWing(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.wingV2.ReqLevelUpWing()
    if decodedData.autoUseMoney ~= nil and decodedData.autoUseMoneySpecified ~= false then
        data.autoUseMoney = decodedData.autoUseMoney
    end
    return data
end

--[[wingV2.ResLevelUpWing 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return wingV2