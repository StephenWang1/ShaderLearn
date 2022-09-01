--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--mail.xml

--region ID:36002 ResMailListMessage 邮件列表响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mailV2.MailList lua table类型消息数据
---@param csData mailV2.MailList C# class类型消息数据
netMsgPreprocessing[36002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local length = csData.mails.Count - 1
    for k = 0, length do
        local v = csData.mails[k]
        if (v.state == 1 and CS.System.String.IsNullOrEmpty(v.items)) then
            v.state = 2
        end
    end
    CS.CSMailInfo.Instance:Lua_UpdateMailData(csData)

    CS.CSMailInfo.Instance:SortMailByState(function(a, b)
        if (a.state == b.state) then
            if (a.state == 1) then
                if (CS.System.String.IsNullOrEmpty(a.items)) then
                    return 1
                else
                    if (a.sendTime > b.sendTime) then
                        return -1
                    elseif (a.sendTime == b.sendTime) then
                        return 0
                    else
                        return 1
                    end
                end
            else
                if (a.sendTime > b.sendTime) then
                    return -1
                elseif (a.sendTime == b.sendTime) then
                    return 0
                else
                    return 1
                end
            end
        else
            if (a.state > b.state) then
                return 1
            else
                return -1
            end
        end
    end)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
end
--endregion

--region ID:36003 ResNewMailMessage 新邮件响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mailV2.MsgRemind lua table类型消息数据
---@param csData mailV2.MsgRemind C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[36003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and tblData.type == 1 then
        CS.CSMailInfo.Instance:SetDirty()
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
        uiStaticParameter.mNewInfos = LuaEnumMainChatType.Mail
    elseif (tblData.type == 2) then
        if (CS.CSScene.MainPlayerInfo.ChatInfoV2.NewFriendApplyList:Contains(1) == false) then
            CS.CSScene.MainPlayerInfo.ChatInfoV2.NewFriendApplyList:Add(1)
        end
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.FriendApply)
        uiStaticParameter.mNewInfos = LuaEnumMainChatType.Friend
    end
end
--endregion

--region ID:36006 ResGetMailItemMessage 提取物品响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mailV2.MailIdMsg lua table类型消息数据
---@param csData mailV2.MailIdMsg C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[36006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
end
--endregion

--region ID:36008 ResDeleteMailMessage 删除邮件响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mailV2.MailIdMsg lua table类型消息数据
---@param csData mailV2.MailIdMsg C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[36008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeRead)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.MAIL_MailsToBeReadOrReceive)
end
--endregion
