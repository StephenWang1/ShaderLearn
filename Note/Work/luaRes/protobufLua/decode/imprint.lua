--[[本文件为工具自动生成,禁止手动修改]]
local imprintV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData imprintV2.ResImprintInfo lua中的数据结构
---@return imprintV2.ResImprintInfo C#中的数据结构
function imprintV2.ResImprintInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.imprintV2.ResImprintInfo()
    if decodedData.imprintInfoList ~= nil and decodedData.imprintInfoListSpecified ~= false then
        for i = 1, #decodedData.imprintInfoList do
            data.imprintInfoList:Add(imprintV2.ImprintInfo(decodedData.imprintInfoList[i]))
        end
    end
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    return data
end

---@param decodedData imprintV2.ImprintInfo lua中的数据结构
---@return imprintV2.ImprintInfo C#中的数据结构
function imprintV2.ImprintInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.imprintV2.ImprintInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.isValid ~= nil and decodedData.isValidSpecified ~= false then
        data.isValid = decodedData.isValid
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.shuXing ~= nil and decodedData.shuXingSpecified ~= false then
        data.shuXing = decodedData.shuXing
    end
    if decodedData.fuDong ~= nil and decodedData.fuDongSpecified ~= false then
        data.fuDong = decodedData.fuDong
    end
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        data.itemInfo = decodeTable.bag.BagItemInfo(decodedData.itemInfo)
    end
    return data
end

---@param decodedData imprintV2.ReqPutOnImprint lua中的数据结构
---@return imprintV2.ReqPutOnImprint C#中的数据结构
function imprintV2.ReqPutOnImprint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.imprintV2.ReqPutOnImprint()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.imprintId ~= nil and decodedData.imprintIdSpecified ~= false then
        data.imprintId = decodedData.imprintId
    end
    return data
end

---@param decodedData imprintV2.ReqTakeOffImprint lua中的数据结构
---@return imprintV2.ReqTakeOffImprint C#中的数据结构
function imprintV2.ReqTakeOffImprint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.imprintV2.ReqTakeOffImprint()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData imprintV2.ResPutOnImprint lua中的数据结构
---@return imprintV2.ResPutOnImprint C#中的数据结构
function imprintV2.ResPutOnImprint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.imprintV2.ResPutOnImprint()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData imprintV2.ResTakeOffImprint lua中的数据结构
---@return imprintV2.ResTakeOffImprint C#中的数据结构
function imprintV2.ResTakeOffImprint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.imprintV2.ResTakeOffImprint()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

return imprintV2