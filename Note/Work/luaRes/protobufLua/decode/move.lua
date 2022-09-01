--[[本文件为工具自动生成,禁止手动修改]]
local moveV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData moveV2.ReqMove lua中的数据结构
---@return moveV2.ReqMove C#中的数据结构
function moveV2.ReqMove(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.moveV2.ReqMove()
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.action ~= nil and decodedData.actionSpecified ~= false then
        data.action = decodedData.action
    end
    return data
end

---@param decodedData moveV2.ResMove lua中的数据结构
---@return moveV2.ResMove C#中的数据结构
function moveV2.ResMove(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.moveV2.ResMove()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.action ~= nil and decodedData.actionSpecified ~= false then
        data.action = decodedData.action
    end
    return data
end

---@param decodedData moveV2.ReqPlayerMoveRequest lua中的数据结构
---@return moveV2.ReqPlayerMoveRequest C#中的数据结构
function moveV2.ReqPlayerMoveRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.moveV2.ReqPlayerMoveRequest()
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.startTime ~= nil and decodedData.startTimeSpecified ~= false then
        data.startTime = decodedData.startTime
    end
    if decodedData.action ~= nil and decodedData.actionSpecified ~= false then
        data.action = decodedData.action
    end
    if decodedData.currentX ~= nil and decodedData.currentXSpecified ~= false then
        data.currentX = decodedData.currentX
    end
    if decodedData.currentY ~= nil and decodedData.currentYSpecified ~= false then
        data.currentY = decodedData.currentY
    end
    if decodedData.changePosFirst ~= nil and decodedData.changePosFirstSpecified ~= false then
        data.changePosFirst = decodedData.changePosFirst
    end
    return data
end

---@param decodedData moveV2.ReqChangeDir lua中的数据结构
---@return moveV2.ReqChangeDir C#中的数据结构
function moveV2.ReqChangeDir(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.moveV2.ReqChangeDir()
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    return data
end

---@param decodedData moveV2.ResChangeDir lua中的数据结构
---@return moveV2.ResChangeDir C#中的数据结构
function moveV2.ResChangeDir(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.moveV2.ResChangeDir()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    return data
end

return moveV2