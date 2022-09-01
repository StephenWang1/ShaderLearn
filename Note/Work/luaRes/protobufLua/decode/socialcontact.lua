--[[本文件为工具自动生成,禁止手动修改]]
local socialcontactV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData socialcontactV2.ReqSendFlowers lua中的数据结构
---@return socialcontactV2.ReqSendFlowers C#中的数据结构
function socialcontactV2.ReqSendFlowers(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ReqSendFlowers()
    if decodedData.targetRid ~= nil and decodedData.targetRidSpecified ~= false then
        data.targetRid = decodedData.targetRid
    end
    if decodedData.flowerCount ~= nil and decodedData.flowerCountSpecified ~= false then
        data.flowerCount = decodedData.flowerCount
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData socialcontactV2.ReqGetTheFlowerCount lua中的数据结构
---@return socialcontactV2.ReqGetTheFlowerCount C#中的数据结构
function socialcontactV2.ReqGetTheFlowerCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ReqGetTheFlowerCount()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData socialcontactV2.ResGetTheFlowerCount lua中的数据结构
---@return socialcontactV2.ResGetTheFlowerCount C#中的数据结构
function socialcontactV2.ResGetTheFlowerCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ResGetTheFlowerCount()
    if decodedData.flowerCount ~= nil and decodedData.flowerCountSpecified ~= false then
        data.flowerCount = decodedData.flowerCount
    end
    return data
end

--[[socialcontactV2.ResTeXiao 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData socialcontactV2.ResDefaultFlowerId lua中的数据结构
---@return socialcontactV2.ResDefaultFlowerId C#中的数据结构
function socialcontactV2.ResDefaultFlowerId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ResDefaultFlowerId()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

--[[socialcontactV2.FatePeople 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData socialcontactV2.ReqRebateFlower lua中的数据结构
---@return socialcontactV2.ReqRebateFlower C#中的数据结构
function socialcontactV2.ReqRebateFlower(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ReqRebateFlower()
    if decodedData.targetRid ~= nil and decodedData.targetRidSpecified ~= false then
        data.targetRid = decodedData.targetRid
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData socialcontactV2.ReqReplyToThank lua中的数据结构
---@return socialcontactV2.ReqReplyToThank C#中的数据结构
function socialcontactV2.ReqReplyToThank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ReqReplyToThank()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.targetRid ~= nil and decodedData.targetRidSpecified ~= false then
        data.targetRid = decodedData.targetRid
    end
    return data
end

---@param decodedData socialcontactV2.ReqSendFlowerAddFriend lua中的数据结构
---@return socialcontactV2.ReqSendFlowerAddFriend C#中的数据结构
function socialcontactV2.ReqSendFlowerAddFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ReqSendFlowerAddFriend()
    if decodedData.targetRid ~= nil and decodedData.targetRidSpecified ~= false then
        data.targetRid = decodedData.targetRid
    end
    return data
end

---@param decodedData socialcontactV2.ReqAgreeSendFlowerAddFriend lua中的数据结构
---@return socialcontactV2.ReqAgreeSendFlowerAddFriend C#中的数据结构
function socialcontactV2.ReqAgreeSendFlowerAddFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.socialcontactV2.ReqAgreeSendFlowerAddFriend()
    if decodedData.targetRid ~= nil and decodedData.targetRidSpecified ~= false then
        data.targetRid = decodedData.targetRid
    end
    return data
end

return socialcontactV2