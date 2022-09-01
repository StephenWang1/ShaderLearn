--[[本文件为工具自动生成,禁止手动修改]]
local treasureHuntV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable treasureHuntV2.TreasureHuntInfo
---@type treasureHuntV2.TreasureHuntInfo
treasureHuntV2_adj.metatable_TreasureHuntInfo = {
    _ClassName = "treasureHuntV2.TreasureHuntInfo",
}
treasureHuntV2_adj.metatable_TreasureHuntInfo.__index = treasureHuntV2_adj.metatable_TreasureHuntInfo
--endregion

---@param tbl treasureHuntV2.TreasureHuntInfo 待调整的table数据
function treasureHuntV2_adj.AdjustTreasureHuntInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TreasureHuntInfo)
    if tbl.itemInfo == nil then
        tbl.itemInfo = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemInfo do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemInfo[i])
            end
        end
    end
    if tbl.maxGrid == nil then
        tbl.maxGridSpecified = false
        tbl.maxGrid = 0
    else
        tbl.maxGridSpecified = true
    end
end

--region metatable treasureHuntV2.StorageUpdateInfo
---@type treasureHuntV2.StorageUpdateInfo
treasureHuntV2_adj.metatable_StorageUpdateInfo = {
    _ClassName = "treasureHuntV2.StorageUpdateInfo",
}
treasureHuntV2_adj.metatable_StorageUpdateInfo.__index = treasureHuntV2_adj.metatable_StorageUpdateInfo
--endregion

---@param tbl treasureHuntV2.StorageUpdateInfo 待调整的table数据
function treasureHuntV2_adj.AdjustStorageUpdateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_StorageUpdateInfo)
    if tbl.item == nil then
        tbl.itemSpecified = false
        tbl.item = nil
    else
        if tbl.itemSpecified == nil then 
            tbl.itemSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.item)
            end
        end
    end
    if tbl.operate == nil then
        tbl.operateSpecified = false
        tbl.operate = 0
    else
        tbl.operateSpecified = true
    end
end

--region metatable treasureHuntV2.PrivateCardOverRequest
---@type treasureHuntV2.PrivateCardOverRequest
treasureHuntV2_adj.metatable_PrivateCardOverRequest = {
    _ClassName = "treasureHuntV2.PrivateCardOverRequest",
}
treasureHuntV2_adj.metatable_PrivateCardOverRequest.__index = treasureHuntV2_adj.metatable_PrivateCardOverRequest
--endregion

---@param tbl treasureHuntV2.PrivateCardOverRequest 待调整的table数据
function treasureHuntV2_adj.AdjustPrivateCardOverRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_PrivateCardOverRequest)
    if tbl.privateOver == nil then
        tbl.privateOverSpecified = false
        tbl.privateOver = false
    else
        tbl.privateOverSpecified = true
    end
end

--region metatable treasureHuntV2.TreasureRequest
---@type treasureHuntV2.TreasureRequest
treasureHuntV2_adj.metatable_TreasureRequest = {
    _ClassName = "treasureHuntV2.TreasureRequest",
}
treasureHuntV2_adj.metatable_TreasureRequest.__index = treasureHuntV2_adj.metatable_TreasureRequest
--endregion

---@param tbl treasureHuntV2.TreasureRequest 待调整的table数据
function treasureHuntV2_adj.AdjustTreasureRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TreasureRequest)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.treasurePrivate == nil then
        tbl.treasurePrivateSpecified = false
        tbl.treasurePrivate = false
    else
        tbl.treasurePrivateSpecified = true
    end
    if tbl.cardPage == nil then
        tbl.cardPageSpecified = false
        tbl.cardPage = 0
    else
        tbl.cardPageSpecified = true
    end
    if tbl.buttonMax == nil then
        tbl.buttonMaxSpecified = false
        tbl.buttonMax = false
    else
        tbl.buttonMaxSpecified = true
    end
end

--region metatable treasureHuntV2.TurnCardRequset
---@type treasureHuntV2.TurnCardRequset
treasureHuntV2_adj.metatable_TurnCardRequset = {
    _ClassName = "treasureHuntV2.TurnCardRequset",
}
treasureHuntV2_adj.metatable_TurnCardRequset.__index = treasureHuntV2_adj.metatable_TurnCardRequset
--endregion

---@param tbl treasureHuntV2.TurnCardRequset 待调整的table数据
function treasureHuntV2_adj.AdjustTurnCardRequset(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TurnCardRequset)
    if tbl.page == nil then
        tbl.pageSpecified = false
        tbl.page = 0
    else
        tbl.pageSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable treasureHuntV2.TurnCardFailInfo
---@type treasureHuntV2.TurnCardFailInfo
treasureHuntV2_adj.metatable_TurnCardFailInfo = {
    _ClassName = "treasureHuntV2.TurnCardFailInfo",
}
treasureHuntV2_adj.metatable_TurnCardFailInfo.__index = treasureHuntV2_adj.metatable_TurnCardFailInfo
--endregion

---@param tbl treasureHuntV2.TurnCardFailInfo 待调整的table数据
function treasureHuntV2_adj.AdjustTurnCardFailInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TurnCardFailInfo)
    if tbl.ret == nil then
        tbl.retSpecified = false
        tbl.ret = 0
    else
        tbl.retSpecified = true
    end
end

--region metatable treasureHuntV2.TurnCardPrivateInfo
---@type treasureHuntV2.TurnCardPrivateInfo
treasureHuntV2_adj.metatable_TurnCardPrivateInfo = {
    _ClassName = "treasureHuntV2.TurnCardPrivateInfo",
}
treasureHuntV2_adj.metatable_TurnCardPrivateInfo.__index = treasureHuntV2_adj.metatable_TurnCardPrivateInfo
--endregion

---@param tbl treasureHuntV2.TurnCardPrivateInfo 待调整的table数据
function treasureHuntV2_adj.AdjustTurnCardPrivateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TurnCardPrivateInfo)
    if tbl.cardPrivate == nil then
        tbl.cardPrivateSpecified = false
        tbl.cardPrivate = false
    else
        tbl.cardPrivateSpecified = true
    end
end

--region metatable treasureHuntV2.CardInfo
---@type treasureHuntV2.CardInfo
treasureHuntV2_adj.metatable_CardInfo = {
    _ClassName = "treasureHuntV2.CardInfo",
}
treasureHuntV2_adj.metatable_CardInfo.__index = treasureHuntV2_adj.metatable_CardInfo
--endregion

---@param tbl treasureHuntV2.CardInfo 待调整的table数据
function treasureHuntV2_adj.AdjustCardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_CardInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.front == nil then
        tbl.frontSpecified = false
        tbl.front = false
    else
        tbl.frontSpecified = true
    end
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.HuntItemList == nil then
        tbl.HuntItemList = {}
    else
        if treasureHuntV2_adj.AdjustTreasureHuntItemInfo ~= nil then
            for i = 1, #tbl.HuntItemList do
                treasureHuntV2_adj.AdjustTreasureHuntItemInfo(tbl.HuntItemList[i])
            end
        end
    end
end

--region metatable treasureHuntV2.TreasureHuntItemInfo
---@type treasureHuntV2.TreasureHuntItemInfo
treasureHuntV2_adj.metatable_TreasureHuntItemInfo = {
    _ClassName = "treasureHuntV2.TreasureHuntItemInfo",
}
treasureHuntV2_adj.metatable_TreasureHuntItemInfo.__index = treasureHuntV2_adj.metatable_TreasureHuntItemInfo
--endregion

---@param tbl treasureHuntV2.TreasureHuntItemInfo 待调整的table数据
function treasureHuntV2_adj.AdjustTreasureHuntItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TreasureHuntItemInfo)
    if tbl.item == nil then
        tbl.itemSpecified = false
        tbl.item = nil
    else
        if tbl.itemSpecified == nil then 
            tbl.itemSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.item)
            end
        end
    end
    if tbl.effect == nil then
        tbl.effectSpecified = false
        tbl.effect = false
    else
        tbl.effectSpecified = true
    end
end

--region metatable treasureHuntV2.AllCardInfo
---@type treasureHuntV2.AllCardInfo
treasureHuntV2_adj.metatable_AllCardInfo = {
    _ClassName = "treasureHuntV2.AllCardInfo",
}
treasureHuntV2_adj.metatable_AllCardInfo.__index = treasureHuntV2_adj.metatable_AllCardInfo
--endregion

---@param tbl treasureHuntV2.AllCardInfo 待调整的table数据
function treasureHuntV2_adj.AdjustAllCardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_AllCardInfo)
    if tbl.cards == nil then
        tbl.cards = {}
    else
        if treasureHuntV2_adj.AdjustCardInfo ~= nil then
            for i = 1, #tbl.cards do
                treasureHuntV2_adj.AdjustCardInfo(tbl.cards[i])
            end
        end
    end
    if tbl.page == nil then
        tbl.pageSpecified = false
        tbl.page = 0
    else
        tbl.pageSpecified = true
    end
    if tbl.countDownBeginS == nil then
        tbl.countDownBeginSSpecified = false
        tbl.countDownBeginS = 0
    else
        tbl.countDownBeginSSpecified = true
    end
    if tbl.countDownS == nil then
        tbl.countDownSSpecified = false
        tbl.countDownS = 0
    else
        tbl.countDownSSpecified = true
    end
    if tbl.privateCard == nil then
        tbl.privateCardSpecified = false
        tbl.privateCard = false
    else
        tbl.privateCardSpecified = true
    end
end

--region metatable treasureHuntV2.TreasureItemChangeList
---@type treasureHuntV2.TreasureItemChangeList
treasureHuntV2_adj.metatable_TreasureItemChangeList = {
    _ClassName = "treasureHuntV2.TreasureItemChangeList",
}
treasureHuntV2_adj.metatable_TreasureItemChangeList.__index = treasureHuntV2_adj.metatable_TreasureItemChangeList
--endregion

---@param tbl treasureHuntV2.TreasureItemChangeList 待调整的table数据
function treasureHuntV2_adj.AdjustTreasureItemChangeList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TreasureItemChangeList)
    if tbl.changeList == nil then
        tbl.changeList = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.changeList do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.changeList[i])
            end
        end
    end
end

--region metatable treasureHuntV2.GetTreasureItemRequest
---@type treasureHuntV2.GetTreasureItemRequest
treasureHuntV2_adj.metatable_GetTreasureItemRequest = {
    _ClassName = "treasureHuntV2.GetTreasureItemRequest",
}
treasureHuntV2_adj.metatable_GetTreasureItemRequest.__index = treasureHuntV2_adj.metatable_GetTreasureItemRequest
--endregion

---@param tbl treasureHuntV2.GetTreasureItemRequest 待调整的table数据
function treasureHuntV2_adj.AdjustGetTreasureItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_GetTreasureItemRequest)
end

--region metatable treasureHuntV2.HuntHistory
---@type treasureHuntV2.HuntHistory
treasureHuntV2_adj.metatable_HuntHistory = {
    _ClassName = "treasureHuntV2.HuntHistory",
}
treasureHuntV2_adj.metatable_HuntHistory.__index = treasureHuntV2_adj.metatable_HuntHistory
--endregion

---@param tbl treasureHuntV2.HuntHistory 待调整的table数据
function treasureHuntV2_adj.AdjustHuntHistory(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_HuntHistory)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.serverHistory == nil then
        tbl.serverHistory = {}
    else
        if treasureHuntV2_adj.AdjustHuntHistoryInfo ~= nil then
            for i = 1, #tbl.serverHistory do
                treasureHuntV2_adj.AdjustHuntHistoryInfo(tbl.serverHistory[i])
            end
        end
    end
    if tbl.rolehistory == nil then
        tbl.rolehistory = {}
    else
        if treasureHuntV2_adj.AdjustHuntHistoryInfo ~= nil then
            for i = 1, #tbl.rolehistory do
                treasureHuntV2_adj.AdjustHuntHistoryInfo(tbl.rolehistory[i])
            end
        end
    end
end

--region metatable treasureHuntV2.HuntHistoryInfo
---@type treasureHuntV2.HuntHistoryInfo
treasureHuntV2_adj.metatable_HuntHistoryInfo = {
    _ClassName = "treasureHuntV2.HuntHistoryInfo",
}
treasureHuntV2_adj.metatable_HuntHistoryInfo.__index = treasureHuntV2_adj.metatable_HuntHistoryInfo
--endregion

---@param tbl treasureHuntV2.HuntHistoryInfo 待调整的table数据
function treasureHuntV2_adj.AdjustHuntHistoryInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_HuntHistoryInfo)
    if tbl.history == nil then
        tbl.historySpecified = false
        tbl.history = ""
    else
        tbl.historySpecified = true
    end
    if tbl.itemInfo == nil then
        tbl.itemInfoSpecified = false
        tbl.itemInfo = nil
    else
        if tbl.itemInfoSpecified == nil then 
            tbl.itemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemInfo)
            end
        end
    end
end

--region metatable treasureHuntV2.ExchangePointRequest
---@type treasureHuntV2.ExchangePointRequest
treasureHuntV2_adj.metatable_ExchangePointRequest = {
    _ClassName = "treasureHuntV2.ExchangePointRequest",
}
treasureHuntV2_adj.metatable_ExchangePointRequest.__index = treasureHuntV2_adj.metatable_ExchangePointRequest
--endregion

---@param tbl treasureHuntV2.ExchangePointRequest 待调整的table数据
function treasureHuntV2_adj.AdjustExchangePointRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ExchangePointRequest)
end

--region metatable treasureHuntV2.ExpUseRequest
---@type treasureHuntV2.ExpUseRequest
treasureHuntV2_adj.metatable_ExpUseRequest = {
    _ClassName = "treasureHuntV2.ExpUseRequest",
}
treasureHuntV2_adj.metatable_ExpUseRequest.__index = treasureHuntV2_adj.metatable_ExpUseRequest
--endregion

---@param tbl treasureHuntV2.ExpUseRequest 待调整的table数据
function treasureHuntV2_adj.AdjustExpUseRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ExpUseRequest)
    if tbl.idList == nil then
        tbl.idList = {}
    end
end

--region metatable treasureHuntV2.TreasureIdResponse
---@type treasureHuntV2.TreasureIdResponse
treasureHuntV2_adj.metatable_TreasureIdResponse = {
    _ClassName = "treasureHuntV2.TreasureIdResponse",
}
treasureHuntV2_adj.metatable_TreasureIdResponse.__index = treasureHuntV2_adj.metatable_TreasureIdResponse
--endregion

---@param tbl treasureHuntV2.TreasureIdResponse 待调整的table数据
function treasureHuntV2_adj.AdjustTreasureIdResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_TreasureIdResponse)
end

--region metatable treasureHuntV2.HuntCallbackRequest
---@type treasureHuntV2.HuntCallbackRequest
treasureHuntV2_adj.metatable_HuntCallbackRequest = {
    _ClassName = "treasureHuntV2.HuntCallbackRequest",
}
treasureHuntV2_adj.metatable_HuntCallbackRequest.__index = treasureHuntV2_adj.metatable_HuntCallbackRequest
--endregion

---@param tbl treasureHuntV2.HuntCallbackRequest 待调整的table数据
function treasureHuntV2_adj.AdjustHuntCallbackRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_HuntCallbackRequest)
    if tbl.idList == nil then
        tbl.idList = {}
    end
end

--region metatable treasureHuntV2.HuntCallbackResponse
---@type treasureHuntV2.HuntCallbackResponse
treasureHuntV2_adj.metatable_HuntCallbackResponse = {
    _ClassName = "treasureHuntV2.HuntCallbackResponse",
}
treasureHuntV2_adj.metatable_HuntCallbackResponse.__index = treasureHuntV2_adj.metatable_HuntCallbackResponse
--endregion

---@param tbl treasureHuntV2.HuntCallbackResponse 待调整的table数据
function treasureHuntV2_adj.AdjustHuntCallbackResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_HuntCallbackResponse)
    if tbl.indexs == nil then
        tbl.indexs = {}
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
end

--region metatable treasureHuntV2.NewRingDisplay
---@type treasureHuntV2.NewRingDisplay
treasureHuntV2_adj.metatable_NewRingDisplay = {
    _ClassName = "treasureHuntV2.NewRingDisplay",
}
treasureHuntV2_adj.metatable_NewRingDisplay.__index = treasureHuntV2_adj.metatable_NewRingDisplay
--endregion

---@param tbl treasureHuntV2.NewRingDisplay 待调整的table数据
function treasureHuntV2_adj.AdjustNewRingDisplay(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_NewRingDisplay)
    if tbl.todatDisplay == nil then
        tbl.todatDisplaySpecified = false
        tbl.todatDisplay = false
    else
        tbl.todatDisplaySpecified = true
    end
end

--region metatable treasureHuntV2.LimitTimeTreasureHuntPool
---@type treasureHuntV2.LimitTimeTreasureHuntPool
treasureHuntV2_adj.metatable_LimitTimeTreasureHuntPool = {
    _ClassName = "treasureHuntV2.LimitTimeTreasureHuntPool",
}
treasureHuntV2_adj.metatable_LimitTimeTreasureHuntPool.__index = treasureHuntV2_adj.metatable_LimitTimeTreasureHuntPool
--endregion

---@param tbl treasureHuntV2.LimitTimeTreasureHuntPool 待调整的table数据
function treasureHuntV2_adj.AdjustLimitTimeTreasureHuntPool(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_LimitTimeTreasureHuntPool)
    if tbl.itemInfo == nil then
        tbl.itemInfo = {}
    end
end

--region metatable treasureHuntV2.ReinNumRequest
---@type treasureHuntV2.ReinNumRequest
treasureHuntV2_adj.metatable_ReinNumRequest = {
    _ClassName = "treasureHuntV2.ReinNumRequest",
}
treasureHuntV2_adj.metatable_ReinNumRequest.__index = treasureHuntV2_adj.metatable_ReinNumRequest
--endregion

---@param tbl treasureHuntV2.ReinNumRequest 待调整的table数据
function treasureHuntV2_adj.AdjustReinNumRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ReinNumRequest)
    if tbl.rein == nil then
        tbl.rein = {}
    end
end

--region metatable treasureHuntV2.ReinNumInfo
---@type treasureHuntV2.ReinNumInfo
treasureHuntV2_adj.metatable_ReinNumInfo = {
    _ClassName = "treasureHuntV2.ReinNumInfo",
}
treasureHuntV2_adj.metatable_ReinNumInfo.__index = treasureHuntV2_adj.metatable_ReinNumInfo
--endregion

---@param tbl treasureHuntV2.ReinNumInfo 待调整的table数据
function treasureHuntV2_adj.AdjustReinNumInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ReinNumInfo)
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable treasureHuntV2.ReinNumResponse
---@type treasureHuntV2.ReinNumResponse
treasureHuntV2_adj.metatable_ReinNumResponse = {
    _ClassName = "treasureHuntV2.ReinNumResponse",
}
treasureHuntV2_adj.metatable_ReinNumResponse.__index = treasureHuntV2_adj.metatable_ReinNumResponse
--endregion

---@param tbl treasureHuntV2.ReinNumResponse 待调整的table数据
function treasureHuntV2_adj.AdjustReinNumResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ReinNumResponse)
    if tbl.reinNumInfo == nil then
        tbl.reinNumInfo = {}
    else
        if treasureHuntV2_adj.AdjustReinNumInfo ~= nil then
            for i = 1, #tbl.reinNumInfo do
                treasureHuntV2_adj.AdjustReinNumInfo(tbl.reinNumInfo[i])
            end
        end
    end
end

--region metatable treasureHuntV2.ReqDigTreasure
---@type treasureHuntV2.ReqDigTreasure
treasureHuntV2_adj.metatable_ReqDigTreasure = {
    _ClassName = "treasureHuntV2.ReqDigTreasure",
}
treasureHuntV2_adj.metatable_ReqDigTreasure.__index = treasureHuntV2_adj.metatable_ReqDigTreasure
--endregion

---@param tbl treasureHuntV2.ReqDigTreasure 待调整的table数据
function treasureHuntV2_adj.AdjustReqDigTreasure(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ReqDigTreasure)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable treasureHuntV2.ReqOneKeyCallBack
---@type treasureHuntV2.ReqOneKeyCallBack
treasureHuntV2_adj.metatable_ReqOneKeyCallBack = {
    _ClassName = "treasureHuntV2.ReqOneKeyCallBack",
}
treasureHuntV2_adj.metatable_ReqOneKeyCallBack.__index = treasureHuntV2_adj.metatable_ReqOneKeyCallBack
--endregion

---@param tbl treasureHuntV2.ReqOneKeyCallBack 待调整的table数据
function treasureHuntV2_adj.AdjustReqOneKeyCallBack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ReqOneKeyCallBack)
    if tbl.itemIds == nil then
        tbl.itemIds = {}
    end
end

--region metatable treasureHuntV2.ReqOneKeyOperation
---@type treasureHuntV2.ReqOneKeyOperation
treasureHuntV2_adj.metatable_ReqOneKeyOperation = {
    _ClassName = "treasureHuntV2.ReqOneKeyOperation",
}
treasureHuntV2_adj.metatable_ReqOneKeyOperation.__index = treasureHuntV2_adj.metatable_ReqOneKeyOperation
--endregion

---@param tbl treasureHuntV2.ReqOneKeyOperation 待调整的table数据
function treasureHuntV2_adj.AdjustReqOneKeyOperation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_ReqOneKeyOperation)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable treasureHuntV2.DigTreasureWareHouse
---@type treasureHuntV2.DigTreasureWareHouse
treasureHuntV2_adj.metatable_DigTreasureWareHouse = {
    _ClassName = "treasureHuntV2.DigTreasureWareHouse",
}
treasureHuntV2_adj.metatable_DigTreasureWareHouse.__index = treasureHuntV2_adj.metatable_DigTreasureWareHouse
--endregion

---@param tbl treasureHuntV2.DigTreasureWareHouse 待调整的table数据
function treasureHuntV2_adj.AdjustDigTreasureWareHouse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_DigTreasureWareHouse)
    if tbl.itemInfo == nil then
        tbl.itemInfo = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemInfo do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemInfo[i])
            end
        end
    end
end

--region metatable treasureHuntV2.RoleDigTreasureCount
---@type treasureHuntV2.RoleDigTreasureCount
treasureHuntV2_adj.metatable_RoleDigTreasureCount = {
    _ClassName = "treasureHuntV2.RoleDigTreasureCount",
}
treasureHuntV2_adj.metatable_RoleDigTreasureCount.__index = treasureHuntV2_adj.metatable_RoleDigTreasureCount
--endregion

---@param tbl treasureHuntV2.RoleDigTreasureCount 待调整的table数据
function treasureHuntV2_adj.AdjustRoleDigTreasureCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_RoleDigTreasureCount)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable treasureHuntV2.DigTreasureState
---@type treasureHuntV2.DigTreasureState
treasureHuntV2_adj.metatable_DigTreasureState = {
    _ClassName = "treasureHuntV2.DigTreasureState",
}
treasureHuntV2_adj.metatable_DigTreasureState.__index = treasureHuntV2_adj.metatable_DigTreasureState
--endregion

---@param tbl treasureHuntV2.DigTreasureState 待调整的table数据
function treasureHuntV2_adj.AdjustDigTreasureState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_DigTreasureState)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable treasureHuntV2.DigTreasureItems
---@type treasureHuntV2.DigTreasureItems
treasureHuntV2_adj.metatable_DigTreasureItems = {
    _ClassName = "treasureHuntV2.DigTreasureItems",
}
treasureHuntV2_adj.metatable_DigTreasureItems.__index = treasureHuntV2_adj.metatable_DigTreasureItems
--endregion

---@param tbl treasureHuntV2.DigTreasureItems 待调整的table数据
function treasureHuntV2_adj.AdjustDigTreasureItems(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_DigTreasureItems)
    if tbl.item == nil then
        tbl.item = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.item do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.item[i])
            end
        end
    end
end

--region metatable treasureHuntV2.GoldDigActiveState
---@type treasureHuntV2.GoldDigActiveState
treasureHuntV2_adj.metatable_GoldDigActiveState = {
    _ClassName = "treasureHuntV2.GoldDigActiveState",
}
treasureHuntV2_adj.metatable_GoldDigActiveState.__index = treasureHuntV2_adj.metatable_GoldDigActiveState
--endregion

---@param tbl treasureHuntV2.GoldDigActiveState 待调整的table数据
function treasureHuntV2_adj.AdjustGoldDigActiveState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, treasureHuntV2_adj.metatable_GoldDigActiveState)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

return treasureHuntV2_adj