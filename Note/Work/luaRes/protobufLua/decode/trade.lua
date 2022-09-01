--[[本文件为工具自动生成,禁止手动修改]]
local tradeV2 = {}

local decodeTable = protobufMgr.DecodeTable

--[[tradeV2.ReqTrade 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData tradeV2.ResTrade lua中的数据结构
---@return tradeV2.ResTrade C#中的数据结构
function tradeV2.ResTrade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.tradeV2.ResTrade()
    if decodedData.uid ~= nil and decodedData.uidSpecified ~= false then
        data.uid = decodedData.uid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

--[[tradeV2.ReqAgreeTrade 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[tradeV2.ReqSetTradeProgress 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData tradeV2.ResTradeStateChange lua中的数据结构
---@return tradeV2.ResTradeStateChange C#中的数据结构
function tradeV2.ResTradeStateChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.tradeV2.ResTradeStateChange()
    if decodedData.uid ~= nil and decodedData.uidSpecified ~= false then
        data.uid = decodedData.uid
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData tradeV2.TradePartyInfo lua中的数据结构
---@return tradeV2.TradePartyInfo C#中的数据结构
function tradeV2.TradePartyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.tradeV2.TradePartyInfo()
    data.roleId = decodedData.roleId
    data.name = decodedData.name
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(decodeTable.bag.BagItemInfo(decodedData.items[i]))
        end
    end
    data.locked = decodedData.locked
    data.submit = decodedData.submit
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    return data
end

---@param decodedData tradeV2.TradeInfo lua中的数据结构
---@return tradeV2.TradeInfo C#中的数据结构
function tradeV2.TradeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.tradeV2.TradeInfo()
    if decodedData.parties ~= nil and decodedData.partiesSpecified ~= false then
        for i = 1, #decodedData.parties do
            data.parties:Add(tradeV2.TradePartyInfo(decodedData.parties[i]))
        end
    end
    return data
end

--[[tradeV2.AddItemToTradeRequest 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[tradeV2.RemoveItemFromTradeRequest 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData tradeV2.SetTradeMoneyRequest lua中的数据结构
---@return tradeV2.SetTradeMoneyRequest C#中的数据结构
function tradeV2.SetTradeMoneyRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.tradeV2.SetTradeMoneyRequest()
    data.gold = decodedData.gold
    data.yuanbao = decodedData.yuanbao
    return data
end

return tradeV2