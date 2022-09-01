--[[本文件为工具自动生成,禁止手动修改]]
local titleV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData titleV2.TitleInfo lua中的数据结构
---@return titleV2.TitleInfo C#中的数据结构
function titleV2.TitleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.titleV2.TitleInfo()
    data.titleId = decodedData.titleId
    if decodedData.getTime ~= nil and decodedData.getTimeSpecified ~= false then
        data.getTime = decodedData.getTime
    end
    return data
end

---@param decodedData titleV2.ResRemoveTitle lua中的数据结构
---@return titleV2.ResRemoveTitle C#中的数据结构
function titleV2.ResRemoveTitle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.titleV2.ResRemoveTitle()
    data.titleId = decodedData.titleId
    return data
end

---@param decodedData titleV2.ResTitleList lua中的数据结构
---@return titleV2.ResTitleList C#中的数据结构
function titleV2.ResTitleList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.titleV2.ResTitleList()
    if decodedData.titleList ~= nil and decodedData.titleListSpecified ~= false then
        for i = 1, #decodedData.titleList do
            data.titleList:Add(titleV2.TitleInfo(decodedData.titleList[i]))
        end
    end
    return data
end

---@param decodedData titleV2.ReqPutOnTitle lua中的数据结构
---@return titleV2.ReqPutOnTitle C#中的数据结构
function titleV2.ReqPutOnTitle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.titleV2.ReqPutOnTitle()
    data.titleId = decodedData.titleId
    return data
end

--[[titleV2.ResPutOnTitle 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData titleV2.ReqPutOffTitle lua中的数据结构
---@return titleV2.ReqPutOffTitle C#中的数据结构
function titleV2.ReqPutOffTitle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.titleV2.ReqPutOffTitle()
    data.titleId = decodedData.titleId
    return data
end

---@param decodedData titleV2.ResPutOffTitle lua中的数据结构
---@return titleV2.ResPutOffTitle C#中的数据结构
function titleV2.ResPutOffTitle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.titleV2.ResPutOffTitle()
    data.title = titleV2.TitleInfo(decodedData.title)
    return data
end

return titleV2