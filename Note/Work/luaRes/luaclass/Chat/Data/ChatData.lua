local ChatData = {}

--region 查询
---是否显示聊天内容
---@param CS类型服务器聊天消息 chatV2.ResChat
function ChatData:ShowChatData(csData)
    if csData ~= nil then
        if csData == nil or CS.CSScene.MainPlayerInfo == nil then
            return false
        end
        local isMainPlayerSendChat = csData.senderId == CS.CSScene.MainPlayerInfo.ID
        if isMainPlayerSendChat == false and csData.onlySelfView == 1 then
            return false
        end
    end
    return true
end
--endregion


--region 筛选
---过滤筛选行会聊天需要显示的内容
---@param csData unionV2.ResUnionChatAnnounce
function ChatData:FilterUnionChatShowChatData(csData)
    if csData ~= nil then
        if csData.announces ~= nil then
            local length = csData.announces.Count - 1
            for k = length,0,-1 do
                local resChat = csData.announces[k]
                if resChat ~= nil and resChat.chat ~= nil and self:ShowChatData(resChat.chat) == false then
                    csData.announces:RemoveAt(k)
                end
            end
        end
    end
end
--endregion
return ChatData