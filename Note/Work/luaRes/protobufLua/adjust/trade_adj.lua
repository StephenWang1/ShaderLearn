--[[本文件为工具自动生成,禁止手动修改]]
local tradeV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable tradeV2.ReqTrade
---@type tradeV2.ReqTrade
tradeV2_adj.metatable_ReqTrade = {
    _ClassName = "tradeV2.ReqTrade",
}
tradeV2_adj.metatable_ReqTrade.__index = tradeV2_adj.metatable_ReqTrade
--endregion

---@param tbl tradeV2.ReqTrade 待调整的table数据
function tradeV2_adj.AdjustReqTrade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_ReqTrade)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
end

--region metatable tradeV2.ResTrade
---@type tradeV2.ResTrade
tradeV2_adj.metatable_ResTrade = {
    _ClassName = "tradeV2.ResTrade",
}
tradeV2_adj.metatable_ResTrade.__index = tradeV2_adj.metatable_ResTrade
--endregion

---@param tbl tradeV2.ResTrade 待调整的table数据
function tradeV2_adj.AdjustResTrade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_ResTrade)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable tradeV2.ReqAgreeTrade
---@type tradeV2.ReqAgreeTrade
tradeV2_adj.metatable_ReqAgreeTrade = {
    _ClassName = "tradeV2.ReqAgreeTrade",
}
tradeV2_adj.metatable_ReqAgreeTrade.__index = tradeV2_adj.metatable_ReqAgreeTrade
--endregion

---@param tbl tradeV2.ReqAgreeTrade 待调整的table数据
function tradeV2_adj.AdjustReqAgreeTrade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_ReqAgreeTrade)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
    if tbl.agree == nil then
        tbl.agreeSpecified = false
        tbl.agree = 0
    else
        tbl.agreeSpecified = true
    end
end

--region metatable tradeV2.ReqSetTradeProgress
---@type tradeV2.ReqSetTradeProgress
tradeV2_adj.metatable_ReqSetTradeProgress = {
    _ClassName = "tradeV2.ReqSetTradeProgress",
}
tradeV2_adj.metatable_ReqSetTradeProgress.__index = tradeV2_adj.metatable_ReqSetTradeProgress
--endregion

---@param tbl tradeV2.ReqSetTradeProgress 待调整的table数据
function tradeV2_adj.AdjustReqSetTradeProgress(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_ReqSetTradeProgress)
    if tbl.operation == nil then
        tbl.operationSpecified = false
        tbl.operation = 0
    else
        tbl.operationSpecified = true
    end
end

--region metatable tradeV2.ResTradeStateChange
---@type tradeV2.ResTradeStateChange
tradeV2_adj.metatable_ResTradeStateChange = {
    _ClassName = "tradeV2.ResTradeStateChange",
}
tradeV2_adj.metatable_ResTradeStateChange.__index = tradeV2_adj.metatable_ResTradeStateChange
--endregion

---@param tbl tradeV2.ResTradeStateChange 待调整的table数据
function tradeV2_adj.AdjustResTradeStateChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_ResTradeStateChange)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable tradeV2.TradePartyInfo
---@type tradeV2.TradePartyInfo
tradeV2_adj.metatable_TradePartyInfo = {
    _ClassName = "tradeV2.TradePartyInfo",
}
tradeV2_adj.metatable_TradePartyInfo.__index = tradeV2_adj.metatable_TradePartyInfo
--endregion

---@param tbl tradeV2.TradePartyInfo 待调整的table数据
function tradeV2_adj.AdjustTradePartyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_TradePartyInfo)
    if tbl.items == nil then
        tbl.items = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.items do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.items[i])
            end
        end
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
end

--region metatable tradeV2.TradeInfo
---@type tradeV2.TradeInfo
tradeV2_adj.metatable_TradeInfo = {
    _ClassName = "tradeV2.TradeInfo",
}
tradeV2_adj.metatable_TradeInfo.__index = tradeV2_adj.metatable_TradeInfo
--endregion

---@param tbl tradeV2.TradeInfo 待调整的table数据
function tradeV2_adj.AdjustTradeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_TradeInfo)
    if tbl.parties == nil then
        tbl.parties = {}
    else
        if tradeV2_adj.AdjustTradePartyInfo ~= nil then
            for i = 1, #tbl.parties do
                tradeV2_adj.AdjustTradePartyInfo(tbl.parties[i])
            end
        end
    end
end

--region metatable tradeV2.AddItemToTradeRequest
---@type tradeV2.AddItemToTradeRequest
tradeV2_adj.metatable_AddItemToTradeRequest = {
    _ClassName = "tradeV2.AddItemToTradeRequest",
}
tradeV2_adj.metatable_AddItemToTradeRequest.__index = tradeV2_adj.metatable_AddItemToTradeRequest
--endregion

---@param tbl tradeV2.AddItemToTradeRequest 待调整的table数据
function tradeV2_adj.AdjustAddItemToTradeRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_AddItemToTradeRequest)
end

--region metatable tradeV2.RemoveItemFromTradeRequest
---@type tradeV2.RemoveItemFromTradeRequest
tradeV2_adj.metatable_RemoveItemFromTradeRequest = {
    _ClassName = "tradeV2.RemoveItemFromTradeRequest",
}
tradeV2_adj.metatable_RemoveItemFromTradeRequest.__index = tradeV2_adj.metatable_RemoveItemFromTradeRequest
--endregion

---@param tbl tradeV2.RemoveItemFromTradeRequest 待调整的table数据
function tradeV2_adj.AdjustRemoveItemFromTradeRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_RemoveItemFromTradeRequest)
end

--region metatable tradeV2.SetTradeMoneyRequest
---@type tradeV2.SetTradeMoneyRequest
tradeV2_adj.metatable_SetTradeMoneyRequest = {
    _ClassName = "tradeV2.SetTradeMoneyRequest",
}
tradeV2_adj.metatable_SetTradeMoneyRequest.__index = tradeV2_adj.metatable_SetTradeMoneyRequest
--endregion

---@param tbl tradeV2.SetTradeMoneyRequest 待调整的table数据
function tradeV2_adj.AdjustSetTradeMoneyRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tradeV2_adj.metatable_SetTradeMoneyRequest)
end

return tradeV2_adj