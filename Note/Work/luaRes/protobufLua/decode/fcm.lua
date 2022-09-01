--[[本文件为工具自动生成,禁止手动修改]]
local fcmV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData fcmV2.ResAuthorityState lua中的数据结构
---@return fcmV2.ResAuthorityState C#中的数据结构
function fcmV2.ResAuthorityState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fcmV2.ResAuthorityState()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

--[[fcmV2.ReqAuthority 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData fcmV2.ResFcmState lua中的数据结构
---@return fcmV2.ResFcmState C#中的数据结构
function fcmV2.ResFcmState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fcmV2.ResFcmState()
    if decodedData.fcmState ~= nil and decodedData.fcmStateSpecified ~= false then
        data.fcmState = decodedData.fcmState
    end
    if decodedData.onlineSeconds ~= nil and decodedData.onlineSecondsSpecified ~= false then
        data.onlineSeconds = decodedData.onlineSeconds
    end
    return data
end

return fcmV2