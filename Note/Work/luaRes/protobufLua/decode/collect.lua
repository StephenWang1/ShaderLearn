--[[本文件为工具自动生成,禁止手动修改]]
local collect = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData collect.CabinetInfo lua中的数据结构
---@return collect.CabinetInfo C#中的数据结构
function collect.CabinetInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.collect.CabinetInfo()
    if decodedData.collectionItems ~= nil and decodedData.collectionItemsSpecified ~= false then
        for i = 1, #decodedData.collectionItems do
            data.collectionItems:Add(decodeTable.bag.BagItemInfo(decodedData.collectionItems[i]))
        end
    end
    data.level = decodedData.level
    data.exp = decodedData.exp
    if decodedData.linkEffects ~= nil and decodedData.linkEffectsSpecified ~= false then
        for i = 1, #decodedData.linkEffects do
            data.linkEffects:Add(decodedData.linkEffects[i])
        end
    end
    return data
end

---@param decodedData collect.PutCollectionItemMsg lua中的数据结构
---@return collect.PutCollectionItemMsg C#中的数据结构
function collect.PutCollectionItemMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.collect.PutCollectionItemMsg()
    data.lid = decodedData.lid
    data.page = decodedData.page
    data.x = decodedData.x
    data.y = decodedData.y
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    return data
end

---@param decodedData collect.RemoveCollectionItemMsg lua中的数据结构
---@return collect.RemoveCollectionItemMsg C#中的数据结构
function collect.RemoveCollectionItemMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.collect.RemoveCollectionItemMsg()
    data.itemId = decodedData.itemId
    if decodedData.bagIndex ~= nil and decodedData.bagIndexSpecified ~= false then
        data.bagIndex = decodedData.bagIndex
    end
    return data
end

---@param decodedData collect.SwapCollectionItemMsg lua中的数据结构
---@return collect.SwapCollectionItemMsg C#中的数据结构
function collect.SwapCollectionItemMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.collect.SwapCollectionItemMsg()
    data.itemId = decodedData.itemId
    data.page = decodedData.page
    data.x = decodedData.x
    data.y = decodedData.y
    return data
end

---@param decodedData collect.CallbackCollectionMsg lua中的数据结构
---@return collect.CallbackCollectionMsg C#中的数据结构
function collect.CallbackCollectionMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.collect.CallbackCollectionMsg()
    if decodedData.itemIds ~= nil and decodedData.itemIdsSpecified ~= false then
        for i = 1, #decodedData.itemIds do
            data.itemIds:Add(decodedData.itemIds[i])
        end
    end
    if decodedData.lids ~= nil and decodedData.lidsSpecified ~= false then
        for i = 1, #decodedData.lids do
            data.lids:Add(decodedData.lids[i])
        end
    end
    if decodedData.cabinet ~= nil and decodedData.cabinetSpecified ~= false then
        data.cabinet = collect.CabinetInfo(decodedData.cabinet)
    end
    return data
end

return collect