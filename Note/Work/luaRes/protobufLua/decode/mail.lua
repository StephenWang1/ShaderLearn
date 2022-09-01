--[[本文件为工具自动生成,禁止手动修改]]
local mailV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData mailV2.MailInfo lua中的数据结构
---@return mailV2.MailInfo C#中的数据结构
function mailV2.MailInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mailV2.MailInfo()
    data.mailId = decodedData.mailId
    if decodedData.title ~= nil and decodedData.titleSpecified ~= false then
        data.title = decodedData.title
    end
    if decodedData.content ~= nil and decodedData.contentSpecified ~= false then
        data.content = decodedData.content
    end
    data.from = decodedData.from
    data.sendTime = decodedData.sendTime
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        data.items = decodedData.items
    end
    data.state = decodedData.state
    return data
end

---@param decodedData mailV2.MailList lua中的数据结构
---@return mailV2.MailList C#中的数据结构
function mailV2.MailList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mailV2.MailList()
    if decodedData.mails ~= nil and decodedData.mailsSpecified ~= false then
        for i = 1, #decodedData.mails do
            data.mails:Add(mailV2.MailInfo(decodedData.mails[i]))
        end
    end
    return data
end

---@param decodedData mailV2.MailIdMsg lua中的数据结构
---@return mailV2.MailIdMsg C#中的数据结构
function mailV2.MailIdMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mailV2.MailIdMsg()
    if decodedData.mailIds ~= nil and decodedData.mailIdsSpecified ~= false then
        for i = 1, #decodedData.mailIds do
            data.mailIds:Add(decodedData.mailIds[i])
        end
    end
    return data
end

--[[mailV2.MsgRemind 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return mailV2