--[[本文件为工具自动生成,禁止手动修改]]
local appearanceV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData appearanceV2.ResGetWearFashion lua中的数据结构
---@return appearanceV2.ResGetWearFashion C#中的数据结构
function appearanceV2.ResGetWearFashion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.ResGetWearFashion()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.wearIds ~= nil and decodedData.wearIdsSpecified ~= false then
        for i = 1, #decodedData.wearIds do
            data.wearIds:Add(appearanceV2.wearPosition(decodedData.wearIds[i]))
        end
    end
    return data
end

---@param decodedData appearanceV2.ResGetHasFashion lua中的数据结构
---@return appearanceV2.ResGetHasFashion C#中的数据结构
function appearanceV2.ResGetHasFashion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.ResGetHasFashion()
    if decodedData.FashionInfo ~= nil and decodedData.FashionInfoSpecified ~= false then
        for i = 1, #decodedData.FashionInfo do
            data.FashionInfo:Add(appearanceV2.FashionType(decodedData.FashionInfo[i]))
        end
    end
    return data
end

---@param decodedData appearanceV2.wearPosition lua中的数据结构
---@return appearanceV2.wearPosition C#中的数据结构
function appearanceV2.wearPosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.wearPosition()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData appearanceV2.FashionType lua中的数据结构
---@return appearanceV2.FashionType C#中的数据结构
function appearanceV2.FashionType(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.FashionType()
    if decodedData.subType ~= nil and decodedData.subTypeSpecified ~= false then
        data.subType = decodedData.subType
    end
    if decodedData.itemList ~= nil and decodedData.itemListSpecified ~= false then
        for i = 1, #decodedData.itemList do
            data.itemList:Add(decodeTable.bag.BagItemInfo(decodedData.itemList[i]))
        end
    end
    return data
end

--[[appearanceV2.ReqEnableFashion 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData appearanceV2.ResGetHasAppellation lua中的数据结构
---@return appearanceV2.ResGetHasAppellation C#中的数据结构
function appearanceV2.ResGetHasAppellation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.ResGetHasAppellation()
    if decodedData.titleInfo ~= nil and decodedData.titleInfoSpecified ~= false then
        for i = 1, #decodedData.titleInfo do
            data.titleInfo:Add(appearanceV2.TitleInfo(decodedData.titleInfo[i]))
        end
    end
    return data
end

---@param decodedData appearanceV2.TitleInfo lua中的数据结构
---@return appearanceV2.TitleInfo C#中的数据结构
function appearanceV2.TitleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.TitleInfo()
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.titleDes ~= nil and decodedData.titleDesSpecified ~= false then
        data.titleDes = decodedData.titleDes
    end
    return data
end

---@param decodedData appearanceV2.ReqEnableTitle lua中的数据结构
---@return appearanceV2.ReqEnableTitle C#中的数据结构
function appearanceV2.ReqEnableTitle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.ReqEnableTitle()
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.close ~= nil and decodedData.closeSpecified ~= false then
        data.close = decodedData.close
    end
    return data
end

---@param decodedData appearanceV2.ReqModifyTitle lua中的数据结构
---@return appearanceV2.ReqModifyTitle C#中的数据结构
function appearanceV2.ReqModifyTitle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.ReqModifyTitle()
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.modifyTitle ~= nil and decodedData.modifyTitleSpecified ~= false then
        data.modifyTitle = decodedData.modifyTitle
    end
    return data
end

---@param decodedData appearanceV2.ResModifyTitle lua中的数据结构
---@return appearanceV2.ResModifyTitle C#中的数据结构
function appearanceV2.ResModifyTitle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.ResModifyTitle()
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.modifyTitle ~= nil and decodedData.modifyTitleSpecified ~= false then
        data.modifyTitle = decodedData.modifyTitle
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData appearanceV2.ResEnableAppellation lua中的数据结构
---@return appearanceV2.ResEnableAppellation C#中的数据结构
function appearanceV2.ResEnableAppellation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.appearanceV2.ResEnableAppellation()
    if decodedData.titleInfo ~= nil and decodedData.titleInfoSpecified ~= false then
        data.titleInfo = appearanceV2.TitleInfo(decodedData.titleInfo)
    end
    return data
end

--[[appearanceV2.ResAppearanceRedPoint 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return appearanceV2