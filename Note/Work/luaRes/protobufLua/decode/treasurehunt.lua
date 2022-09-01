--[[本文件为工具自动生成,禁止手动修改]]
local treasureHuntV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData treasureHuntV2.TreasureHuntInfo lua中的数据结构
---@return treasureHuntV2.TreasureHuntInfo C#中的数据结构
function treasureHuntV2.TreasureHuntInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TreasureHuntInfo()
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        for i = 1, #decodedData.itemInfo do
            data.itemInfo:Add(decodeTable.bag.BagItemInfo(decodedData.itemInfo[i]))
        end
    end
    if decodedData.maxGrid ~= nil and decodedData.maxGridSpecified ~= false then
        data.maxGrid = decodedData.maxGrid
    end
    return data
end

---@param decodedData treasureHuntV2.StorageUpdateInfo lua中的数据结构
---@return treasureHuntV2.StorageUpdateInfo C#中的数据结构
function treasureHuntV2.StorageUpdateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.StorageUpdateInfo()
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    if decodedData.operate ~= nil and decodedData.operateSpecified ~= false then
        data.operate = decodedData.operate
    end
    return data
end

---@param decodedData treasureHuntV2.PrivateCardOverRequest lua中的数据结构
---@return treasureHuntV2.PrivateCardOverRequest C#中的数据结构
function treasureHuntV2.PrivateCardOverRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.PrivateCardOverRequest()
    if decodedData.privateOver ~= nil and decodedData.privateOverSpecified ~= false then
        data.privateOver = decodedData.privateOver
    end
    return data
end

---@param decodedData treasureHuntV2.TreasureRequest lua中的数据结构
---@return treasureHuntV2.TreasureRequest C#中的数据结构
function treasureHuntV2.TreasureRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TreasureRequest()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.treasurePrivate ~= nil and decodedData.treasurePrivateSpecified ~= false then
        data.treasurePrivate = decodedData.treasurePrivate
    end
    if decodedData.cardPage ~= nil and decodedData.cardPageSpecified ~= false then
        data.cardPage = decodedData.cardPage
    end
    if decodedData.buttonMax ~= nil and decodedData.buttonMaxSpecified ~= false then
        data.buttonMax = decodedData.buttonMax
    end
    return data
end

---@param decodedData treasureHuntV2.TurnCardRequset lua中的数据结构
---@return treasureHuntV2.TurnCardRequset C#中的数据结构
function treasureHuntV2.TurnCardRequset(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TurnCardRequset()
    if decodedData.page ~= nil and decodedData.pageSpecified ~= false then
        data.page = decodedData.page
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData treasureHuntV2.TurnCardFailInfo lua中的数据结构
---@return treasureHuntV2.TurnCardFailInfo C#中的数据结构
function treasureHuntV2.TurnCardFailInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TurnCardFailInfo()
    if decodedData.ret ~= nil and decodedData.retSpecified ~= false then
        data.ret = decodedData.ret
    end
    return data
end

---@param decodedData treasureHuntV2.TurnCardPrivateInfo lua中的数据结构
---@return treasureHuntV2.TurnCardPrivateInfo C#中的数据结构
function treasureHuntV2.TurnCardPrivateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TurnCardPrivateInfo()
    if decodedData.cardPrivate ~= nil and decodedData.cardPrivateSpecified ~= false then
        data.cardPrivate = decodedData.cardPrivate
    end
    return data
end

---@param decodedData treasureHuntV2.CardInfo lua中的数据结构
---@return treasureHuntV2.CardInfo C#中的数据结构
function treasureHuntV2.CardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.CardInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.front ~= nil and decodedData.frontSpecified ~= false then
        data.front = decodedData.front
    end
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.HuntItemList ~= nil and decodedData.HuntItemListSpecified ~= false then
        for i = 1, #decodedData.HuntItemList do
            data.HuntItemList:Add(treasureHuntV2.TreasureHuntItemInfo(decodedData.HuntItemList[i]))
        end
    end
    return data
end

---@param decodedData treasureHuntV2.TreasureHuntItemInfo lua中的数据结构
---@return treasureHuntV2.TreasureHuntItemInfo C#中的数据结构
function treasureHuntV2.TreasureHuntItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TreasureHuntItemInfo()
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    if decodedData.effect ~= nil and decodedData.effectSpecified ~= false then
        data.effect = decodedData.effect
    end
    return data
end

---@param decodedData treasureHuntV2.AllCardInfo lua中的数据结构
---@return treasureHuntV2.AllCardInfo C#中的数据结构
function treasureHuntV2.AllCardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.AllCardInfo()
    if decodedData.cards ~= nil and decodedData.cardsSpecified ~= false then
        for i = 1, #decodedData.cards do
            data.cards:Add(treasureHuntV2.CardInfo(decodedData.cards[i]))
        end
    end
    if decodedData.page ~= nil and decodedData.pageSpecified ~= false then
        data.page = decodedData.page
    end
    if decodedData.countDownBeginS ~= nil and decodedData.countDownBeginSSpecified ~= false then
        data.countDownBeginS = decodedData.countDownBeginS
    end
    if decodedData.countDownS ~= nil and decodedData.countDownSSpecified ~= false then
        data.countDownS = decodedData.countDownS
    end
    if decodedData.privateCard ~= nil and decodedData.privateCardSpecified ~= false then
        data.privateCard = decodedData.privateCard
    end
    return data
end

---@param decodedData treasureHuntV2.TreasureItemChangeList lua中的数据结构
---@return treasureHuntV2.TreasureItemChangeList C#中的数据结构
function treasureHuntV2.TreasureItemChangeList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TreasureItemChangeList()
    if decodedData.changeList ~= nil and decodedData.changeListSpecified ~= false then
        for i = 1, #decodedData.changeList do
            data.changeList:Add(decodeTable.bag.BagItemInfo(decodedData.changeList[i]))
        end
    end
    return data
end

---@param decodedData treasureHuntV2.GetTreasureItemRequest lua中的数据结构
---@return treasureHuntV2.GetTreasureItemRequest C#中的数据结构
function treasureHuntV2.GetTreasureItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.GetTreasureItemRequest()
    data.itemId = decodedData.itemId
    return data
end

---@param decodedData treasureHuntV2.HuntHistory lua中的数据结构
---@return treasureHuntV2.HuntHistory C#中的数据结构
function treasureHuntV2.HuntHistory(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.HuntHistory()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.serverHistory ~= nil and decodedData.serverHistorySpecified ~= false then
        for i = 1, #decodedData.serverHistory do
            data.serverHistory:Add(treasureHuntV2.HuntHistoryInfo(decodedData.serverHistory[i]))
        end
    end
    if decodedData.rolehistory ~= nil and decodedData.rolehistorySpecified ~= false then
        for i = 1, #decodedData.rolehistory do
            data.rolehistory:Add(treasureHuntV2.HuntHistoryInfo(decodedData.rolehistory[i]))
        end
    end
    return data
end

---@param decodedData treasureHuntV2.HuntHistoryInfo lua中的数据结构
---@return treasureHuntV2.HuntHistoryInfo C#中的数据结构
function treasureHuntV2.HuntHistoryInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.HuntHistoryInfo()
    if decodedData.history ~= nil and decodedData.historySpecified ~= false then
        data.history = decodedData.history
    end
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        data.itemInfo = decodeTable.bag.BagItemInfo(decodedData.itemInfo)
    end
    return data
end

---@param decodedData treasureHuntV2.ExchangePointRequest lua中的数据结构
---@return treasureHuntV2.ExchangePointRequest C#中的数据结构
function treasureHuntV2.ExchangePointRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.ExchangePointRequest()
    data.id = decodedData.id
    return data
end

---@param decodedData treasureHuntV2.ExpUseRequest lua中的数据结构
---@return treasureHuntV2.ExpUseRequest C#中的数据结构
function treasureHuntV2.ExpUseRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.ExpUseRequest()
    if decodedData.idList ~= nil and decodedData.idListSpecified ~= false then
        for i = 1, #decodedData.idList do
            data.idList:Add(decodedData.idList[i])
        end
    end
    return data
end

---@param decodedData treasureHuntV2.TreasureIdResponse lua中的数据结构
---@return treasureHuntV2.TreasureIdResponse C#中的数据结构
function treasureHuntV2.TreasureIdResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.TreasureIdResponse()
    data.id = decodedData.id
    return data
end

---@param decodedData treasureHuntV2.HuntCallbackRequest lua中的数据结构
---@return treasureHuntV2.HuntCallbackRequest C#中的数据结构
function treasureHuntV2.HuntCallbackRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.HuntCallbackRequest()
    if decodedData.idList ~= nil and decodedData.idListSpecified ~= false then
        for i = 1, #decodedData.idList do
            data.idList:Add(decodedData.idList[i])
        end
    end
    return data
end

---@param decodedData treasureHuntV2.HuntCallbackResponse lua中的数据结构
---@return treasureHuntV2.HuntCallbackResponse C#中的数据结构
function treasureHuntV2.HuntCallbackResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.HuntCallbackResponse()
    if decodedData.indexs ~= nil and decodedData.indexsSpecified ~= false then
        for i = 1, #decodedData.indexs do
            data.indexs:Add(decodedData.indexs[i])
        end
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    return data
end

---@param decodedData treasureHuntV2.NewRingDisplay lua中的数据结构
---@return treasureHuntV2.NewRingDisplay C#中的数据结构
function treasureHuntV2.NewRingDisplay(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.NewRingDisplay()
    if decodedData.todatDisplay ~= nil and decodedData.todatDisplaySpecified ~= false then
        data.todatDisplay = decodedData.todatDisplay
    end
    return data
end

---@param decodedData treasureHuntV2.LimitTimeTreasureHuntPool lua中的数据结构
---@return treasureHuntV2.LimitTimeTreasureHuntPool C#中的数据结构
function treasureHuntV2.LimitTimeTreasureHuntPool(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.LimitTimeTreasureHuntPool()
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        for i = 1, #decodedData.itemInfo do
            data.itemInfo:Add(decodedData.itemInfo[i])
        end
    end
    return data
end

---@param decodedData treasureHuntV2.ReinNumRequest lua中的数据结构
---@return treasureHuntV2.ReinNumRequest C#中的数据结构
function treasureHuntV2.ReinNumRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.ReinNumRequest()
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        for i = 1, #decodedData.rein do
            data.rein:Add(decodedData.rein[i])
        end
    end
    return data
end

---@param decodedData treasureHuntV2.ReinNumInfo lua中的数据结构
---@return treasureHuntV2.ReinNumInfo C#中的数据结构
function treasureHuntV2.ReinNumInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.ReinNumInfo()
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData treasureHuntV2.ReinNumResponse lua中的数据结构
---@return treasureHuntV2.ReinNumResponse C#中的数据结构
function treasureHuntV2.ReinNumResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.ReinNumResponse()
    if decodedData.reinNumInfo ~= nil and decodedData.reinNumInfoSpecified ~= false then
        for i = 1, #decodedData.reinNumInfo do
            data.reinNumInfo:Add(treasureHuntV2.ReinNumInfo(decodedData.reinNumInfo[i]))
        end
    end
    return data
end

--[[treasureHuntV2.ReqDigTreasure 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData treasureHuntV2.ReqOneKeyCallBack lua中的数据结构
---@return treasureHuntV2.ReqOneKeyCallBack C#中的数据结构
function treasureHuntV2.ReqOneKeyCallBack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.ReqOneKeyCallBack()
    if decodedData.itemIds ~= nil and decodedData.itemIdsSpecified ~= false then
        for i = 1, #decodedData.itemIds do
            data.itemIds:Add(decodedData.itemIds[i])
        end
    end
    return data
end

---@param decodedData treasureHuntV2.ReqOneKeyOperation lua中的数据结构
---@return treasureHuntV2.ReqOneKeyOperation C#中的数据结构
function treasureHuntV2.ReqOneKeyOperation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.ReqOneKeyOperation()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData treasureHuntV2.DigTreasureWareHouse lua中的数据结构
---@return treasureHuntV2.DigTreasureWareHouse C#中的数据结构
function treasureHuntV2.DigTreasureWareHouse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.DigTreasureWareHouse()
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        for i = 1, #decodedData.itemInfo do
            data.itemInfo:Add(decodeTable.bag.BagItemInfo(decodedData.itemInfo[i]))
        end
    end
    return data
end

---@param decodedData treasureHuntV2.RoleDigTreasureCount lua中的数据结构
---@return treasureHuntV2.RoleDigTreasureCount C#中的数据结构
function treasureHuntV2.RoleDigTreasureCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.RoleDigTreasureCount()
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData treasureHuntV2.DigTreasureState lua中的数据结构
---@return treasureHuntV2.DigTreasureState C#中的数据结构
function treasureHuntV2.DigTreasureState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.DigTreasureState()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData treasureHuntV2.DigTreasureItems lua中的数据结构
---@return treasureHuntV2.DigTreasureItems C#中的数据结构
function treasureHuntV2.DigTreasureItems(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.treasureHuntV2.DigTreasureItems()
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        for i = 1, #decodedData.item do
            data.item:Add(decodeTable.bag.BagItemInfo(decodedData.item[i]))
        end
    end
    return data
end

--[[treasureHuntV2.GoldDigActiveState 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return treasureHuntV2