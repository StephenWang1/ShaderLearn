--[[本文件为工具自动生成,禁止手动修改]]
local activeV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData activeV2.ActiveInfo lua中的数据结构
---@return activeV2.ActiveInfo C#中的数据结构
function activeV2.ActiveInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activeV2.ActiveInfo()
    if decodedData.activeNumber ~= nil and decodedData.activeNumberSpecified ~= false then
        data.activeNumber = decodedData.activeNumber
    end
    if decodedData.activeProgress ~= nil and decodedData.activeProgressSpecified ~= false then
        for i = 1, #decodedData.activeProgress do
            data.activeProgress:Add(activeV2.ActiveItem(decodedData.activeProgress[i]))
        end
    end
    if decodedData.reward ~= nil and decodedData.rewardSpecified ~= false then
        data.reward = decodedData.reward
    end
    if decodedData.firstRandomIndex ~= nil and decodedData.firstRandomIndexSpecified ~= false then
        for i = 1, #decodedData.firstRandomIndex do
            data.firstRandomIndex:Add(decodedData.firstRandomIndex[i])
        end
    end
    return data
end

---@param decodedData activeV2.ActiveItem lua中的数据结构
---@return activeV2.ActiveItem C#中的数据结构
function activeV2.ActiveItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activeV2.ActiveItem()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.completeCount ~= nil and decodedData.completeCountSpecified ~= false then
        data.completeCount = decodedData.completeCount
    end
    if decodedData.hasCompleteItem ~= nil and decodedData.hasCompleteItemSpecified ~= false then
        data.hasCompleteItem = decodedData.hasCompleteItem
    end
    if decodedData.clientActiveNum ~= nil and decodedData.clientActiveNumSpecified ~= false then
        data.clientActiveNum = decodedData.clientActiveNum
    end
    return data
end

--[[activeV2.GetActiveRewardRequest 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[activeV2.GetActiveCompleteRequest 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return activeV2