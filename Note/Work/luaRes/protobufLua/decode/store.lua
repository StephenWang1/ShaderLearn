--[[本文件为工具自动生成,禁止手动修改]]
local storeV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData storeV2.StoreInfo lua中的数据结构
---@return storeV2.StoreInfo C#中的数据结构
function storeV2.StoreInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.StoreInfo()
    if decodedData.storeId ~= nil and decodedData.storeIdSpecified ~= false then
        data.storeId = decodedData.storeId
    end
    if decodedData.dayBuyNum ~= nil and decodedData.dayBuyNumSpecified ~= false then
        data.dayBuyNum = decodedData.dayBuyNum
    end
    if decodedData.lifeBuyNum ~= nil and decodedData.lifeBuyNumSpecified ~= false then
        data.lifeBuyNum = decodedData.lifeBuyNum
    end
    if decodedData.refreshBuyNum ~= nil and decodedData.refreshBuyNumSpecified ~= false then
        data.refreshBuyNum = decodedData.refreshBuyNum
    end
    if decodedData.serverDayBuyNum ~= nil and decodedData.serverDayBuyNumSpecified ~= false then
        data.serverDayBuyNum = decodedData.serverDayBuyNum
    end
    if decodedData.serverLifeBuyNum ~= nil and decodedData.serverLifeBuyNumSpecified ~= false then
        data.serverLifeBuyNum = decodedData.serverLifeBuyNum
    end
    if decodedData.serverRefreshBuyNum ~= nil and decodedData.serverRefreshBuyNumSpecified ~= false then
        data.serverRefreshBuyNum = decodedData.serverRefreshBuyNum
    end
    if decodedData.buyState ~= nil and decodedData.buyStateSpecified ~= false then
        data.buyState = decodedData.buyState
    end
    if decodedData.isDiscount ~= nil and decodedData.isDiscountSpecified ~= false then
        data.isDiscount = decodedData.isDiscount
    end
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodedData.price
    end
    if decodedData.pointPrice ~= nil and decodedData.pointPriceSpecified ~= false then
        data.pointPrice = decodedData.pointPrice
    end
    if decodedData.limitNum ~= nil and decodedData.limitNumSpecified ~= false then
        data.limitNum = decodedData.limitNum
    end
    if decodedData.bagItemInfo ~= nil and decodedData.bagItemInfoSpecified ~= false then
        data.bagItemInfo = decodeTable.bag.BagItemInfo(decodedData.bagItemInfo)
    end
    return data
end

---@param decodedData storeV2.ReqOpenStoreById lua中的数据结构
---@return storeV2.ReqOpenStoreById C#中的数据结构
function storeV2.ReqOpenStoreById(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ReqOpenStoreById()
    if decodedData.storeClassId ~= nil and decodedData.storeClassIdSpecified ~= false then
        data.storeClassId = decodedData.storeClassId
    end
    return data
end

---@param decodedData storeV2.ResOpenStoreById lua中的数据结构
---@return storeV2.ResOpenStoreById C#中的数据结构
function storeV2.ResOpenStoreById(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ResOpenStoreById()
    if decodedData.storeClassId ~= nil and decodedData.storeClassIdSpecified ~= false then
        data.storeClassId = decodedData.storeClassId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.nextFreshTime ~= nil and decodedData.nextFreshTimeSpecified ~= false then
        data.nextFreshTime = decodedData.nextFreshTime
    end
    if decodedData.storeInfo ~= nil and decodedData.storeInfoSpecified ~= false then
        for i = 1, #decodedData.storeInfo do
            data.storeInfo:Add(storeV2.StoreInfo(decodedData.storeInfo[i]))
        end
    end
    if decodedData.cost ~= nil and decodedData.costSpecified ~= false then
        data.cost = storeV2.Cost(decodedData.cost)
    end
    return data
end

---@param decodedData storeV2.Cost lua中的数据结构
---@return storeV2.Cost C#中的数据结构
function storeV2.Cost(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.Cost()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData storeV2.ResSendStoreInfoChange lua中的数据结构
---@return storeV2.ResSendStoreInfoChange C#中的数据结构
function storeV2.ResSendStoreInfoChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ResSendStoreInfoChange()
    if decodedData.storeInfo ~= nil and decodedData.storeInfoSpecified ~= false then
        data.storeInfo = storeV2.StoreInfo(decodedData.storeInfo)
    end
    return data
end

---@param decodedData storeV2.ReqBuyItem lua中的数据结构
---@return storeV2.ReqBuyItem C#中的数据结构
function storeV2.ReqBuyItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ReqBuyItem()
    if decodedData.storeId ~= nil and decodedData.storeIdSpecified ~= false then
        data.storeId = decodedData.storeId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.isUse ~= nil and decodedData.isUseSpecified ~= false then
        data.isUse = decodedData.isUse
    end
    if decodedData.replaceMoney ~= nil and decodedData.replaceMoneySpecified ~= false then
        data.replaceMoney = decodedData.replaceMoney
    end
    return data
end

--[[storeV2.ResBuyItem 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData storeV2.ReqMaxBuyCount lua中的数据结构
---@return storeV2.ReqMaxBuyCount C#中的数据结构
function storeV2.ReqMaxBuyCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ReqMaxBuyCount()
    if decodedData.storeId ~= nil and decodedData.storeIdSpecified ~= false then
        data.storeId = decodedData.storeId
    end
    return data
end

---@param decodedData storeV2.ResMaxBuyCount lua中的数据结构
---@return storeV2.ResMaxBuyCount C#中的数据结构
function storeV2.ResMaxBuyCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ResMaxBuyCount()
    if decodedData.storeId ~= nil and decodedData.storeIdSpecified ~= false then
        data.storeId = decodedData.storeId
    end
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    if decodedData.dayCount ~= nil and decodedData.dayCountSpecified ~= false then
        data.dayCount = decodedData.dayCount
    end
    return data
end

---@param decodedData storeV2.ReqManualFresh lua中的数据结构
---@return storeV2.ReqManualFresh C#中的数据结构
function storeV2.ReqManualFresh(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ReqManualFresh()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.storeClassId ~= nil and decodedData.storeClassIdSpecified ~= false then
        data.storeClassId = decodedData.storeClassId
    end
    return data
end

---@param decodedData storeV2.ReqStoreInfo lua中的数据结构
---@return storeV2.ReqStoreInfo C#中的数据结构
function storeV2.ReqStoreInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ReqStoreInfo()
    if decodedData.storeId ~= nil and decodedData.storeIdSpecified ~= false then
        data.storeId = decodedData.storeId
    end
    return data
end

---@param decodedData storeV2.ResStoreInfo lua中的数据结构
---@return storeV2.ResStoreInfo C#中的数据结构
function storeV2.ResStoreInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ResStoreInfo()
    if decodedData.storeClassId ~= nil and decodedData.storeClassIdSpecified ~= false then
        data.storeClassId = decodedData.storeClassId
    end
    if decodedData.storeInfo ~= nil and decodedData.storeInfoSpecified ~= false then
        data.storeInfo = storeV2.StoreInfo(decodedData.storeInfo)
    end
    return data
end

--[[storeV2.ReqSynthesis 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData storeV2.ResSynthesis lua中的数据结构
---@return storeV2.ResSynthesis C#中的数据结构
function storeV2.ResSynthesis(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ResSynthesis()
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    --C#的storeV2.ResSynthesis类中没有找到combineCount字段,不填充数据
    return data
end

---@param decodedData storeV2.ResycleItem lua中的数据结构
---@return storeV2.ResycleItem C#中的数据结构
function storeV2.ResycleItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ResycleItem()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.configId ~= nil and decodedData.configIdSpecified ~= false then
        data.configId = decodedData.configId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    return data
end

--[[storeV2.ResMostResyclePanel 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData storeV2.ReqMostResycle lua中的数据结构
---@return storeV2.ReqMostResycle C#中的数据结构
function storeV2.ReqMostResycle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ReqMostResycle()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        for i = 1, #decodedData.id do
            data.id:Add(decodedData.id[i])
        end
    end
    return data
end

---@param decodedData storeV2.ReqMostRedeem lua中的数据结构
---@return storeV2.ReqMostRedeem C#中的数据结构
function storeV2.ReqMostRedeem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.storeV2.ReqMostRedeem()
    data.id = decodedData.id
    return data
end

--[[storeV2.CombineRecord 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[storeV2.CombineCount 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[storeV2.ReqCuiLian 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[storeV2.ResCuiLian 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return storeV2