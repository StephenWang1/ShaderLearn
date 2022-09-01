--[[本文件为工具自动生成,禁止手动修改]]
local mailV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable mailV2.MailInfo
---@type mailV2.MailInfo
mailV2_adj.metatable_MailInfo = {
    _ClassName = "mailV2.MailInfo",
}
mailV2_adj.metatable_MailInfo.__index = mailV2_adj.metatable_MailInfo
--endregion

---@param tbl mailV2.MailInfo 待调整的table数据
function mailV2_adj.AdjustMailInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mailV2_adj.metatable_MailInfo)
    if tbl.title == nil then
        tbl.titleSpecified = false
        tbl.title = ""
    else
        tbl.titleSpecified = true
    end
    if tbl.content == nil then
        tbl.contentSpecified = false
        tbl.content = ""
    else
        tbl.contentSpecified = true
    end
    if tbl.items == nil then
        tbl.itemsSpecified = false
        tbl.items = ""
    else
        tbl.itemsSpecified = true
    end
end

--region metatable mailV2.MailList
---@type mailV2.MailList
mailV2_adj.metatable_MailList = {
    _ClassName = "mailV2.MailList",
}
mailV2_adj.metatable_MailList.__index = mailV2_adj.metatable_MailList
--endregion

---@param tbl mailV2.MailList 待调整的table数据
function mailV2_adj.AdjustMailList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mailV2_adj.metatable_MailList)
    if tbl.mails == nil then
        tbl.mails = {}
    else
        if mailV2_adj.AdjustMailInfo ~= nil then
            for i = 1, #tbl.mails do
                mailV2_adj.AdjustMailInfo(tbl.mails[i])
            end
        end
    end
end

--region metatable mailV2.MailIdMsg
---@type mailV2.MailIdMsg
mailV2_adj.metatable_MailIdMsg = {
    _ClassName = "mailV2.MailIdMsg",
}
mailV2_adj.metatable_MailIdMsg.__index = mailV2_adj.metatable_MailIdMsg
--endregion

---@param tbl mailV2.MailIdMsg 待调整的table数据
function mailV2_adj.AdjustMailIdMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mailV2_adj.metatable_MailIdMsg)
    if tbl.mailIds == nil then
        tbl.mailIds = {}
    end
end

--region metatable mailV2.MsgRemind
---@type mailV2.MsgRemind
mailV2_adj.metatable_MsgRemind = {
    _ClassName = "mailV2.MsgRemind",
}
mailV2_adj.metatable_MsgRemind.__index = mailV2_adj.metatable_MsgRemind
--endregion

---@param tbl mailV2.MsgRemind 待调整的table数据
function mailV2_adj.AdjustMsgRemind(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mailV2_adj.metatable_MsgRemind)
end

return mailV2_adj