--[[本文件为工具自动生成,禁止手动修改]]
local tipV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData tipV2.PromptMsg lua中的数据结构
---@return tipV2.PromptMsg C#中的数据结构
function tipV2.PromptMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.tipV2.PromptMsg()
    data.msg = decodedData.msg
    data.type = decodedData.type
    return data
end

---@param decodedData tipV2.ResUIBubbleMsg lua中的数据结构
---@return tipV2.ResUIBubbleMsg C#中的数据结构
function tipV2.ResUIBubbleMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.tipV2.ResUIBubbleMsg()
    data.id = decodedData.id
    if decodedData.msg ~= nil and decodedData.msgSpecified ~= false then
        data.msg = decodedData.msg
    end
    return data
end

return tipV2