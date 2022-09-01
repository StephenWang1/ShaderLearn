--[[本文件为工具自动生成,禁止手动修改]]
local zhenfaV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData zhenfaV2.ZhenfaInfo lua中的数据结构
---@return zhenfaV2.ZhenfaInfo C#中的数据结构
function zhenfaV2.ZhenfaInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.zhenfaV2.ZhenfaInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    return data
end

---@param decodedData zhenfaV2.ResZhenfaInfo lua中的数据结构
---@return zhenfaV2.ResZhenfaInfo C#中的数据结构
function zhenfaV2.ResZhenfaInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.zhenfaV2.ResZhenfaInfo()
    if decodedData.zhenfaInfo ~= nil and decodedData.zhenfaInfoSpecified ~= false then
        data.zhenfaInfo = zhenfaV2.ZhenfaInfo(decodedData.zhenfaInfo)
    end
    return data
end

return zhenfaV2