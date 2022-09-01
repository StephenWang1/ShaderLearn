--[[本文件为工具自动生成,禁止手动修改]]
local friendV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable friendV2.FriendInfo
---@type friendV2.FriendInfo
friendV2_adj.metatable_FriendInfo = {
    _ClassName = "friendV2.FriendInfo",
}
friendV2_adj.metatable_FriendInfo.__index = friendV2_adj.metatable_FriendInfo
--endregion

---@param tbl friendV2.FriendInfo 待调整的table数据
function friendV2_adj.AdjustFriendInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_FriendInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.relation == nil then
        tbl.relationSpecified = false
        tbl.relation = 0
    else
        tbl.relationSpecified = true
    end
    if tbl.friendLove == nil then
        tbl.friendLoveSpecified = false
        tbl.friendLove = 0
    else
        tbl.friendLoveSpecified = true
    end
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
    if tbl.isOnline == nil then
        tbl.isOnlineSpecified = false
        tbl.isOnline = false
    else
        tbl.isOnlineSpecified = true
    end
    if tbl.isReceive == nil then
        tbl.isReceiveSpecified = false
        tbl.isReceive = false
    else
        tbl.isReceiveSpecified = true
    end
    if tbl.unreadNum == nil then
        tbl.unreadNumSpecified = false
        tbl.unreadNum = 0
    else
        tbl.unreadNumSpecified = true
    end
    if tbl.latelyChat == nil then
        tbl.latelyChatSpecified = false
        tbl.latelyChat = nil
    else
        if tbl.latelyChatSpecified == nil then 
            tbl.latelyChatSpecified = true
            if adjustTable.chat_adj ~= nil and adjustTable.chat_adj.AdjustResChat ~= nil then
                adjustTable.chat_adj.AdjustResChat(tbl.latelyChat)
            end
        end
    end
    if tbl.roleLettering == nil then
        tbl.roleLetteringSpecified = false
        tbl.roleLettering = ""
    else
        tbl.roleLetteringSpecified = true
    end
    if tbl.remark == nil then
        tbl.remarkSpecified = false
        tbl.remark = ""
    else
        tbl.remarkSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
end

--region metatable friendV2.ResFriendInfo
---@type friendV2.ResFriendInfo
friendV2_adj.metatable_ResFriendInfo = {
    _ClassName = "friendV2.ResFriendInfo",
}
friendV2_adj.metatable_ResFriendInfo.__index = friendV2_adj.metatable_ResFriendInfo
--endregion

---@param tbl friendV2.ResFriendInfo 待调整的table数据
function friendV2_adj.AdjustResFriendInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResFriendInfo)
    if tbl.friends == nil then
        tbl.friends = {}
    else
        if friendV2_adj.AdjustFriendInfo ~= nil then
            for i = 1, #tbl.friends do
                friendV2_adj.AdjustFriendInfo(tbl.friends[i])
            end
        end
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.unreadTotalNum == nil then
        tbl.unreadTotalNumSpecified = false
        tbl.unreadTotalNum = 0
    else
        tbl.unreadTotalNumSpecified = true
    end
    if tbl.mayKnowList == nil then
        tbl.mayKnowList = {}
    else
        if friendV2_adj.AdjustMayKnowFriend ~= nil then
            for i = 1, #tbl.mayKnowList do
                friendV2_adj.AdjustMayKnowFriend(tbl.mayKnowList[i])
            end
        end
    end
end

--region metatable friendV2.ResMayKnowFriend
---@type friendV2.ResMayKnowFriend
friendV2_adj.metatable_ResMayKnowFriend = {
    _ClassName = "friendV2.ResMayKnowFriend",
}
friendV2_adj.metatable_ResMayKnowFriend.__index = friendV2_adj.metatable_ResMayKnowFriend
--endregion

---@param tbl friendV2.ResMayKnowFriend 待调整的table数据
function friendV2_adj.AdjustResMayKnowFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResMayKnowFriend)
    if tbl.list == nil then
        tbl.list = {}
    else
        if friendV2_adj.AdjustMayKnowFriend ~= nil then
            for i = 1, #tbl.list do
                friendV2_adj.AdjustMayKnowFriend(tbl.list[i])
            end
        end
    end
end

--region metatable friendV2.MayKnowFriend
---@type friendV2.MayKnowFriend
friendV2_adj.metatable_MayKnowFriend = {
    _ClassName = "friendV2.MayKnowFriend",
}
friendV2_adj.metatable_MayKnowFriend.__index = friendV2_adj.metatable_MayKnowFriend
--endregion

---@param tbl friendV2.MayKnowFriend 待调整的table数据
function friendV2_adj.AdjustMayKnowFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_MayKnowFriend)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if friendV2_adj.AdjustFriendInfo ~= nil then
                friendV2_adj.AdjustFriendInfo(tbl.info)
            end
        end
    end
end

--region metatable friendV2.ReqOpenFriendPanel
---@type friendV2.ReqOpenFriendPanel
friendV2_adj.metatable_ReqOpenFriendPanel = {
    _ClassName = "friendV2.ReqOpenFriendPanel",
}
friendV2_adj.metatable_ReqOpenFriendPanel.__index = friendV2_adj.metatable_ReqOpenFriendPanel
--endregion

---@param tbl friendV2.ReqOpenFriendPanel 待调整的table数据
function friendV2_adj.AdjustReqOpenFriendPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqOpenFriendPanel)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable friendV2.ReqSearchFriend
---@type friendV2.ReqSearchFriend
friendV2_adj.metatable_ReqSearchFriend = {
    _ClassName = "friendV2.ReqSearchFriend",
}
friendV2_adj.metatable_ReqSearchFriend.__index = friendV2_adj.metatable_ReqSearchFriend
--endregion

---@param tbl friendV2.ReqSearchFriend 待调整的table数据
function friendV2_adj.AdjustReqSearchFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqSearchFriend)
    if tbl.idOrName == nil then
        tbl.idOrNameSpecified = false
        tbl.idOrName = ""
    else
        tbl.idOrNameSpecified = true
    end
end

--region metatable friendV2.ReqAddFriend
---@type friendV2.ReqAddFriend
friendV2_adj.metatable_ReqAddFriend = {
    _ClassName = "friendV2.ReqAddFriend",
}
friendV2_adj.metatable_ReqAddFriend.__index = friendV2_adj.metatable_ReqAddFriend
--endregion

---@param tbl friendV2.ReqAddFriend 待调整的table数据
function friendV2_adj.AdjustReqAddFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqAddFriend)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
end

--region metatable friendV2.ResFriendChange
---@type friendV2.ResFriendChange
friendV2_adj.metatable_ResFriendChange = {
    _ClassName = "friendV2.ResFriendChange",
}
friendV2_adj.metatable_ResFriendChange.__index = friendV2_adj.metatable_ResFriendChange
--endregion

---@param tbl friendV2.ResFriendChange 待调整的table数据
function friendV2_adj.AdjustResFriendChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResFriendChange)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.addOrRemove == nil then
        tbl.addOrRemoveSpecified = false
        tbl.addOrRemove = 0
    else
        tbl.addOrRemoveSpecified = true
    end
    if tbl.friend == nil then
        tbl.friend = {}
    else
        if friendV2_adj.AdjustFriendInfo ~= nil then
            for i = 1, #tbl.friend do
                friendV2_adj.AdjustFriendInfo(tbl.friend[i])
            end
        end
    end
end

--region metatable friendV2.ReqDeleteFriend
---@type friendV2.ReqDeleteFriend
friendV2_adj.metatable_ReqDeleteFriend = {
    _ClassName = "friendV2.ReqDeleteFriend",
}
friendV2_adj.metatable_ReqDeleteFriend.__index = friendV2_adj.metatable_ReqDeleteFriend
--endregion

---@param tbl friendV2.ReqDeleteFriend 待调整的table数据
function friendV2_adj.AdjustReqDeleteFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqDeleteFriend)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.targetList == nil then
        tbl.targetListSpecified = false
        tbl.targetList = 0
    else
        tbl.targetListSpecified = true
    end
end

--region metatable friendV2.checkApply
---@type friendV2.checkApply
friendV2_adj.metatable_checkApply = {
    _ClassName = "friendV2.checkApply",
}
friendV2_adj.metatable_checkApply.__index = friendV2_adj.metatable_checkApply
--endregion

---@param tbl friendV2.checkApply 待调整的table数据
function friendV2_adj.AdjustcheckApply(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_checkApply)
    if tbl.listId == nil then
        tbl.listId = {}
    end
end

--region metatable friendV2.SummonFriend
---@type friendV2.SummonFriend
friendV2_adj.metatable_SummonFriend = {
    _ClassName = "friendV2.SummonFriend",
}
friendV2_adj.metatable_SummonFriend.__index = friendV2_adj.metatable_SummonFriend
--endregion

---@param tbl friendV2.SummonFriend 待调整的table数据
function friendV2_adj.AdjustSummonFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_SummonFriend)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable friendV2.SummonNotice
---@type friendV2.SummonNotice
friendV2_adj.metatable_SummonNotice = {
    _ClassName = "friendV2.SummonNotice",
}
friendV2_adj.metatable_SummonNotice.__index = friendV2_adj.metatable_SummonNotice
--endregion

---@param tbl friendV2.SummonNotice 待调整的table数据
function friendV2_adj.AdjustSummonNotice(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_SummonNotice)
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable friendV2.ConfirmSummon
---@type friendV2.ConfirmSummon
friendV2_adj.metatable_ConfirmSummon = {
    _ClassName = "friendV2.ConfirmSummon",
}
friendV2_adj.metatable_ConfirmSummon.__index = friendV2_adj.metatable_ConfirmSummon
--endregion

---@param tbl friendV2.ConfirmSummon 待调整的table数据
function friendV2_adj.AdjustConfirmSummon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ConfirmSummon)
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable friendV2.AscertainPoint
---@type friendV2.AscertainPoint
friendV2_adj.metatable_AscertainPoint = {
    _ClassName = "friendV2.AscertainPoint",
}
friendV2_adj.metatable_AscertainPoint.__index = friendV2_adj.metatable_AscertainPoint
--endregion

---@param tbl friendV2.AscertainPoint 待调整的table数据
function friendV2_adj.AdjustAscertainPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_AscertainPoint)
end

--region metatable friendV2.TeacherDisciple
---@type friendV2.TeacherDisciple
friendV2_adj.metatable_TeacherDisciple = {
    _ClassName = "friendV2.TeacherDisciple",
}
friendV2_adj.metatable_TeacherDisciple.__index = friendV2_adj.metatable_TeacherDisciple
--endregion

---@param tbl friendV2.TeacherDisciple 待调整的table数据
function friendV2_adj.AdjustTeacherDisciple(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_TeacherDisciple)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable friendV2.TeacherDiscipleNotice
---@type friendV2.TeacherDiscipleNotice
friendV2_adj.metatable_TeacherDiscipleNotice = {
    _ClassName = "friendV2.TeacherDiscipleNotice",
}
friendV2_adj.metatable_TeacherDiscipleNotice.__index = friendV2_adj.metatable_TeacherDiscipleNotice
--endregion

---@param tbl friendV2.TeacherDiscipleNotice 待调整的table数据
function friendV2_adj.AdjustTeacherDiscipleNotice(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_TeacherDiscipleNotice)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable friendV2.SearchFriend
---@type friendV2.SearchFriend
friendV2_adj.metatable_SearchFriend = {
    _ClassName = "friendV2.SearchFriend",
}
friendV2_adj.metatable_SearchFriend.__index = friendV2_adj.metatable_SearchFriend
--endregion

---@param tbl friendV2.SearchFriend 待调整的table数据
function friendV2_adj.AdjustSearchFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_SearchFriend)
    if tbl.list == nil then
        tbl.list = {}
    else
        if friendV2_adj.AdjustFriendInfo ~= nil then
            for i = 1, #tbl.list do
                friendV2_adj.AdjustFriendInfo(tbl.list[i])
            end
        end
    end
end

--region metatable friendV2.ReqEditInfo
---@type friendV2.ReqEditInfo
friendV2_adj.metatable_ReqEditInfo = {
    _ClassName = "friendV2.ReqEditInfo",
}
friendV2_adj.metatable_ReqEditInfo.__index = friendV2_adj.metatable_ReqEditInfo
--endregion

---@param tbl friendV2.ReqEditInfo 待调整的table数据
function friendV2_adj.AdjustReqEditInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqEditInfo)
    if tbl.brief == nil then
        tbl.briefSpecified = false
        tbl.brief = ""
    else
        tbl.briefSpecified = true
    end
    if tbl.address == nil then
        tbl.addressSpecified = false
        tbl.address = ""
    else
        tbl.addressSpecified = true
    end
    if tbl.contactWay == nil then
        tbl.contactWaySpecified = false
        tbl.contactWay = ""
    else
        tbl.contactWaySpecified = true
    end
    if tbl.openList == nil then
        tbl.openList = {}
    end
end

--region metatable friendV2.ResPersonalInfo
---@type friendV2.ResPersonalInfo
friendV2_adj.metatable_ResPersonalInfo = {
    _ClassName = "friendV2.ResPersonalInfo",
}
friendV2_adj.metatable_ResPersonalInfo.__index = friendV2_adj.metatable_ResPersonalInfo
--endregion

---@param tbl friendV2.ResPersonalInfo 待调整的table数据
function friendV2_adj.AdjustResPersonalInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResPersonalInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.relation == nil then
        tbl.relationSpecified = false
        tbl.relation = 0
    else
        tbl.relationSpecified = true
    end
    if tbl.friendLove == nil then
        tbl.friendLoveSpecified = false
        tbl.friendLove = 0
    else
        tbl.friendLoveSpecified = true
    end
    if tbl.brief == nil then
        tbl.briefSpecified = false
        tbl.brief = ""
    else
        tbl.briefSpecified = true
    end
    if tbl.address == nil then
        tbl.addressSpecified = false
        tbl.address = ""
    else
        tbl.addressSpecified = true
    end
    if tbl.contactWay == nil then
        tbl.contactWaySpecified = false
        tbl.contactWay = ""
    else
        tbl.contactWaySpecified = true
    end
    if tbl.remark == nil then
        tbl.remarkSpecified = false
        tbl.remark = ""
    else
        tbl.remarkSpecified = true
    end
    if tbl.openList == nil then
        tbl.openList = {}
    end
    if tbl.roleLettering == nil then
        tbl.roleLetteringSpecified = false
        tbl.roleLettering = ""
    else
        tbl.roleLetteringSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable friendV2.ReqEditRemark
---@type friendV2.ReqEditRemark
friendV2_adj.metatable_ReqEditRemark = {
    _ClassName = "friendV2.ReqEditRemark",
}
friendV2_adj.metatable_ReqEditRemark.__index = friendV2_adj.metatable_ReqEditRemark
--endregion

---@param tbl friendV2.ReqEditRemark 待调整的table数据
function friendV2_adj.AdjustReqEditRemark(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqEditRemark)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.remark == nil then
        tbl.remarkSpecified = false
        tbl.remark = ""
    else
        tbl.remarkSpecified = true
    end
end

--region metatable friendV2.ReqLookFriendInfo
---@type friendV2.ReqLookFriendInfo
friendV2_adj.metatable_ReqLookFriendInfo = {
    _ClassName = "friendV2.ReqLookFriendInfo",
}
friendV2_adj.metatable_ReqLookFriendInfo.__index = friendV2_adj.metatable_ReqLookFriendInfo
--endregion

---@param tbl friendV2.ReqLookFriendInfo 待调整的table数据
function friendV2_adj.AdjustReqLookFriendInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqLookFriendInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable friendV2.ChatTarget
---@type friendV2.ChatTarget
friendV2_adj.metatable_ChatTarget = {
    _ClassName = "friendV2.ChatTarget",
}
friendV2_adj.metatable_ChatTarget.__index = friendV2_adj.metatable_ChatTarget
--endregion

---@param tbl friendV2.ChatTarget 待调整的table数据
function friendV2_adj.AdjustChatTarget(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ChatTarget)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
end

--region metatable friendV2.ResChatLog
---@type friendV2.ResChatLog
friendV2_adj.metatable_ResChatLog = {
    _ClassName = "friendV2.ResChatLog",
}
friendV2_adj.metatable_ResChatLog.__index = friendV2_adj.metatable_ResChatLog
--endregion

---@param tbl friendV2.ResChatLog 待调整的table数据
function friendV2_adj.AdjustResChatLog(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResChatLog)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.chatList == nil then
        tbl.chatList = {}
    else
        if adjustTable.chat_adj ~= nil and adjustTable.chat_adj.AdjustResChat ~= nil then
            for i = 1, #tbl.chatList do
                adjustTable.chat_adj.AdjustResChat(tbl.chatList[i])
            end
        end
    end
end

--region metatable friendV2.ReqChatLog
---@type friendV2.ReqChatLog
friendV2_adj.metatable_ReqChatLog = {
    _ClassName = "friendV2.ReqChatLog",
}
friendV2_adj.metatable_ReqChatLog.__index = friendV2_adj.metatable_ReqChatLog
--endregion

---@param tbl friendV2.ReqChatLog 待调整的table数据
function friendV2_adj.AdjustReqChatLog(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqChatLog)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.chatId == nil then
        tbl.chatIdSpecified = false
        tbl.chatId = 0
    else
        tbl.chatIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable friendV2.ReqDeleteChatLog
---@type friendV2.ReqDeleteChatLog
friendV2_adj.metatable_ReqDeleteChatLog = {
    _ClassName = "friendV2.ReqDeleteChatLog",
}
friendV2_adj.metatable_ReqDeleteChatLog.__index = friendV2_adj.metatable_ReqDeleteChatLog
--endregion

---@param tbl friendV2.ReqDeleteChatLog 待调整的table数据
function friendV2_adj.AdjustReqDeleteChatLog(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqDeleteChatLog)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.ids == nil then
        tbl.ids = {}
    end
end

--region metatable friendV2.ResUpdateChatLog
---@type friendV2.ResUpdateChatLog
friendV2_adj.metatable_ResUpdateChatLog = {
    _ClassName = "friendV2.ResUpdateChatLog",
}
friendV2_adj.metatable_ResUpdateChatLog.__index = friendV2_adj.metatable_ResUpdateChatLog
--endregion

---@param tbl friendV2.ResUpdateChatLog 待调整的table数据
function friendV2_adj.AdjustResUpdateChatLog(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResUpdateChatLog)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.chatList == nil then
        tbl.chatList = {}
    else
        if adjustTable.chat_adj ~= nil and adjustTable.chat_adj.AdjustResChat ~= nil then
            for i = 1, #tbl.chatList do
                adjustTable.chat_adj.AdjustResChat(tbl.chatList[i])
            end
        end
    end
end

--region metatable friendV2.GetFriendCircleInfo
---@type friendV2.GetFriendCircleInfo
friendV2_adj.metatable_GetFriendCircleInfo = {
    _ClassName = "friendV2.GetFriendCircleInfo",
}
friendV2_adj.metatable_GetFriendCircleInfo.__index = friendV2_adj.metatable_GetFriendCircleInfo
--endregion

---@param tbl friendV2.GetFriendCircleInfo 待调整的table数据
function friendV2_adj.AdjustGetFriendCircleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_GetFriendCircleInfo)
end

--region metatable friendV2.FriendCircleReplyInfo
---@type friendV2.FriendCircleReplyInfo
friendV2_adj.metatable_FriendCircleReplyInfo = {
    _ClassName = "friendV2.FriendCircleReplyInfo",
}
friendV2_adj.metatable_FriendCircleReplyInfo.__index = friendV2_adj.metatable_FriendCircleReplyInfo
--endregion

---@param tbl friendV2.FriendCircleReplyInfo 待调整的table数据
function friendV2_adj.AdjustFriendCircleReplyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_FriendCircleReplyInfo)
    if tbl.message == nil then
        tbl.messageSpecified = false
        tbl.message = ""
    else
        tbl.messageSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.replyTo == nil then
        tbl.replyToSpecified = false
        tbl.replyTo = 0
    else
        tbl.replyToSpecified = true
    end
    if tbl.likedRoles == nil then
        tbl.likedRoles = {}
    else
        if friendV2_adj.AdjustFriendInfo ~= nil then
            for i = 1, #tbl.likedRoles do
                friendV2_adj.AdjustFriendInfo(tbl.likedRoles[i])
            end
        end
    end
end

--region metatable friendV2.FriendCirclePostInfo
---@type friendV2.FriendCirclePostInfo
friendV2_adj.metatable_FriendCirclePostInfo = {
    _ClassName = "friendV2.FriendCirclePostInfo",
}
friendV2_adj.metatable_FriendCirclePostInfo.__index = friendV2_adj.metatable_FriendCirclePostInfo
--endregion

---@param tbl friendV2.FriendCirclePostInfo 待调整的table数据
function friendV2_adj.AdjustFriendCirclePostInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_FriendCirclePostInfo)
    if tbl.post == nil then
        tbl.postSpecified = false
        tbl.post = nil
    else
        if tbl.postSpecified == nil then 
            tbl.postSpecified = true
            if friendV2_adj.AdjustFriendCircleReplyInfo ~= nil then
                friendV2_adj.AdjustFriendCircleReplyInfo(tbl.post)
            end
        end
    end
    if tbl.replies == nil then
        tbl.replies = {}
    else
        if friendV2_adj.AdjustFriendCircleReplyInfo ~= nil then
            for i = 1, #tbl.replies do
                friendV2_adj.AdjustFriendCircleReplyInfo(tbl.replies[i])
            end
        end
    end
    if tbl.systemType == nil then
        tbl.systemTypeSpecified = false
        tbl.systemType = 0
    else
        tbl.systemTypeSpecified = true
    end
end

--region metatable friendV2.ResFriendCircle
---@type friendV2.ResFriendCircle
friendV2_adj.metatable_ResFriendCircle = {
    _ClassName = "friendV2.ResFriendCircle",
}
friendV2_adj.metatable_ResFriendCircle.__index = friendV2_adj.metatable_ResFriendCircle
--endregion

---@param tbl friendV2.ResFriendCircle 待调整的table数据
function friendV2_adj.AdjustResFriendCircle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResFriendCircle)
    if tbl.posts == nil then
        tbl.posts = {}
    else
        if friendV2_adj.AdjustFriendCirclePostInfo ~= nil then
            for i = 1, #tbl.posts do
                friendV2_adj.AdjustFriendCirclePostInfo(tbl.posts[i])
            end
        end
    end
    if tbl.onwer == nil then
        tbl.onwerSpecified = false
        tbl.onwer = nil
    else
        if tbl.onwerSpecified == nil then 
            tbl.onwerSpecified = true
            if friendV2_adj.AdjustFriendInfo ~= nil then
                friendV2_adj.AdjustFriendInfo(tbl.onwer)
            end
        end
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable friendV2.ReqFriendCirclePost
---@type friendV2.ReqFriendCirclePost
friendV2_adj.metatable_ReqFriendCirclePost = {
    _ClassName = "friendV2.ReqFriendCirclePost",
}
friendV2_adj.metatable_ReqFriendCirclePost.__index = friendV2_adj.metatable_ReqFriendCirclePost
--endregion

---@param tbl friendV2.ReqFriendCirclePost 待调整的table数据
function friendV2_adj.AdjustReqFriendCirclePost(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqFriendCirclePost)
end

--region metatable friendV2.ReqFriendCircleReply
---@type friendV2.ReqFriendCircleReply
friendV2_adj.metatable_ReqFriendCircleReply = {
    _ClassName = "friendV2.ReqFriendCircleReply",
}
friendV2_adj.metatable_ReqFriendCircleReply.__index = friendV2_adj.metatable_ReqFriendCircleReply
--endregion

---@param tbl friendV2.ReqFriendCircleReply 待调整的table数据
function friendV2_adj.AdjustReqFriendCircleReply(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqFriendCircleReply)
end

--region metatable friendV2.ReqFriendCircleLike
---@type friendV2.ReqFriendCircleLike
friendV2_adj.metatable_ReqFriendCircleLike = {
    _ClassName = "friendV2.ReqFriendCircleLike",
}
friendV2_adj.metatable_ReqFriendCircleLike.__index = friendV2_adj.metatable_ReqFriendCircleLike
--endregion

---@param tbl friendV2.ReqFriendCircleLike 待调整的table数据
function friendV2_adj.AdjustReqFriendCircleLike(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqFriendCircleLike)
end

--region metatable friendV2.OfferReward
---@type friendV2.OfferReward
friendV2_adj.metatable_OfferReward = {
    _ClassName = "friendV2.OfferReward",
}
friendV2_adj.metatable_OfferReward.__index = friendV2_adj.metatable_OfferReward
--endregion

---@param tbl friendV2.OfferReward 待调整的table数据
function friendV2_adj.AdjustOfferReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_OfferReward)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.prisoner == nil then
        tbl.prisonerSpecified = false
        tbl.prisoner = 0
    else
        tbl.prisonerSpecified = true
    end
    if tbl.prisonerName == nil then
        tbl.prisonerNameSpecified = false
        tbl.prisonerName = ""
    else
        tbl.prisonerNameSpecified = true
    end
    if tbl.offerTime == nil then
        tbl.offerTimeSpecified = false
        tbl.offerTime = 0
    else
        tbl.offerTimeSpecified = true
    end
    if tbl.reward == nil then
        tbl.rewardSpecified = false
        tbl.reward = 0
    else
        tbl.rewardSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.finisher == nil then
        tbl.finisherSpecified = false
        tbl.finisher = 0
    else
        tbl.finisherSpecified = true
    end
    if tbl.finisherName == nil then
        tbl.finisherNameSpecified = false
        tbl.finisherName = ""
    else
        tbl.finisherNameSpecified = true
    end
    if tbl.finishTime == nil then
        tbl.finishTimeSpecified = false
        tbl.finishTime = 0
    else
        tbl.finishTimeSpecified = true
    end
    if tbl.prisonerCareer == nil then
        tbl.prisonerCareerSpecified = false
        tbl.prisonerCareer = 0
    else
        tbl.prisonerCareerSpecified = true
    end
    if tbl.prisonerSex == nil then
        tbl.prisonerSexSpecified = false
        tbl.prisonerSex = 0
    else
        tbl.prisonerSexSpecified = true
    end
    if tbl.prisonerLevel == nil then
        tbl.prisonerLevelSpecified = false
        tbl.prisonerLevel = 0
    else
        tbl.prisonerLevelSpecified = true
    end
    if tbl.offerType == nil then
        tbl.offerTypeSpecified = false
        tbl.offerType = 0
    else
        tbl.offerTypeSpecified = true
    end
end

--region metatable friendV2.MonsterOfferReward
---@type friendV2.MonsterOfferReward
friendV2_adj.metatable_MonsterOfferReward = {
    _ClassName = "friendV2.MonsterOfferReward",
}
friendV2_adj.metatable_MonsterOfferReward.__index = friendV2_adj.metatable_MonsterOfferReward
--endregion

---@param tbl friendV2.MonsterOfferReward 待调整的table数据
function friendV2_adj.AdjustMonsterOfferReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_MonsterOfferReward)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
    if tbl.head == nil then
        tbl.headSpecified = false
        tbl.head = 0
    else
        tbl.headSpecified = true
    end
    if tbl.monsterName == nil then
        tbl.monsterNameSpecified = false
        tbl.monsterName = ""
    else
        tbl.monsterNameSpecified = true
    end
    if tbl.goalCount == nil then
        tbl.goalCountSpecified = false
        tbl.goalCount = 0
    else
        tbl.goalCountSpecified = true
    end
    if tbl.mapName == nil then
        tbl.mapNameSpecified = false
        tbl.mapName = ""
    else
        tbl.mapNameSpecified = true
    end
    if tbl.completeNum == nil then
        tbl.completeNumSpecified = false
        tbl.completeNum = 0
    else
        tbl.completeNumSpecified = true
    end
    if tbl.startTime == nil then
        tbl.startTimeSpecified = false
        tbl.startTime = 0
    else
        tbl.startTimeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.offerType == nil then
        tbl.offerTypeSpecified = false
        tbl.offerType = 0
    else
        tbl.offerTypeSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.deliverId == nil then
        tbl.deliverIdSpecified = false
        tbl.deliverId = 0
    else
        tbl.deliverIdSpecified = true
    end
end

--region metatable friendV2.MonsterOfferInfo
---@type friendV2.MonsterOfferInfo
friendV2_adj.metatable_MonsterOfferInfo = {
    _ClassName = "friendV2.MonsterOfferInfo",
}
friendV2_adj.metatable_MonsterOfferInfo.__index = friendV2_adj.metatable_MonsterOfferInfo
--endregion

---@param tbl friendV2.MonsterOfferInfo 待调整的table数据
function friendV2_adj.AdjustMonsterOfferInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_MonsterOfferInfo)
    if tbl.monsterOffer == nil then
        tbl.monsterOfferSpecified = false
        tbl.monsterOffer = nil
    else
        if tbl.monsterOfferSpecified == nil then 
            tbl.monsterOfferSpecified = true
            if friendV2_adj.AdjustMonsterOfferReward ~= nil then
                friendV2_adj.AdjustMonsterOfferReward(tbl.monsterOffer)
            end
        end
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.myKillCount == nil then
        tbl.myKillCountSpecified = false
        tbl.myKillCount = 0
    else
        tbl.myKillCountSpecified = true
    end
end

--region metatable friendV2.ReqOfferList
---@type friendV2.ReqOfferList
friendV2_adj.metatable_ReqOfferList = {
    _ClassName = "friendV2.ReqOfferList",
}
friendV2_adj.metatable_ReqOfferList.__index = friendV2_adj.metatable_ReqOfferList
--endregion

---@param tbl friendV2.ReqOfferList 待调整的table数据
function friendV2_adj.AdjustReqOfferList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqOfferList)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
end

--region metatable friendV2.ResOfferList
---@type friendV2.ResOfferList
friendV2_adj.metatable_ResOfferList = {
    _ClassName = "friendV2.ResOfferList",
}
friendV2_adj.metatable_ResOfferList.__index = friendV2_adj.metatable_ResOfferList
--endregion

---@param tbl friendV2.ResOfferList 待调整的table数据
function friendV2_adj.AdjustResOfferList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResOfferList)
    if tbl.playerOfferLists == nil then
        tbl.playerOfferLists = {}
    else
        if friendV2_adj.AdjustPlayerOfferList ~= nil then
            for i = 1, #tbl.playerOfferLists do
                friendV2_adj.AdjustPlayerOfferList(tbl.playerOfferLists[i])
            end
        end
    end
    if tbl.monsterOfferLists == nil then
        tbl.monsterOfferLists = {}
    else
        if friendV2_adj.AdjustMonsterOfferList ~= nil then
            for i = 1, #tbl.monsterOfferLists do
                friendV2_adj.AdjustMonsterOfferList(tbl.monsterOfferLists[i])
            end
        end
    end
end

--region metatable friendV2.PlayerOfferList
---@type friendV2.PlayerOfferList
friendV2_adj.metatable_PlayerOfferList = {
    _ClassName = "friendV2.PlayerOfferList",
}
friendV2_adj.metatable_PlayerOfferList.__index = friendV2_adj.metatable_PlayerOfferList
--endregion

---@param tbl friendV2.PlayerOfferList 待调整的table数据
function friendV2_adj.AdjustPlayerOfferList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_PlayerOfferList)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.list == nil then
        tbl.list = {}
    else
        if friendV2_adj.AdjustOfferReward ~= nil then
            for i = 1, #tbl.list do
                friendV2_adj.AdjustOfferReward(tbl.list[i])
            end
        end
    end
end

--region metatable friendV2.MonsterOfferList
---@type friendV2.MonsterOfferList
friendV2_adj.metatable_MonsterOfferList = {
    _ClassName = "friendV2.MonsterOfferList",
}
friendV2_adj.metatable_MonsterOfferList.__index = friendV2_adj.metatable_MonsterOfferList
--endregion

---@param tbl friendV2.MonsterOfferList 待调整的table数据
function friendV2_adj.AdjustMonsterOfferList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_MonsterOfferList)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.list == nil then
        tbl.list = {}
    else
        if friendV2_adj.AdjustMonsterOfferInfo ~= nil then
            for i = 1, #tbl.list do
                friendV2_adj.AdjustMonsterOfferInfo(tbl.list[i])
            end
        end
    end
    if tbl.remainNum == nil then
        tbl.remainNumSpecified = false
        tbl.remainNum = 0
    else
        tbl.remainNumSpecified = true
    end
end

--region metatable friendV2.ResUpdateOfferList
---@type friendV2.ResUpdateOfferList
friendV2_adj.metatable_ResUpdateOfferList = {
    _ClassName = "friendV2.ResUpdateOfferList",
}
friendV2_adj.metatable_ResUpdateOfferList.__index = friendV2_adj.metatable_ResUpdateOfferList
--endregion

---@param tbl friendV2.ResUpdateOfferList 待调整的table数据
function friendV2_adj.AdjustResUpdateOfferList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResUpdateOfferList)
    if tbl.addMonsters == nil then
        tbl.addMonsters = {}
    else
        if friendV2_adj.AdjustMonsterOfferReward ~= nil then
            for i = 1, #tbl.addMonsters do
                friendV2_adj.AdjustMonsterOfferReward(tbl.addMonsters[i])
            end
        end
    end
    if tbl.removeMonsters == nil then
        tbl.removeMonsters = {}
    end
end

--region metatable friendV2.ResUpdateCompleteNum
---@type friendV2.ResUpdateCompleteNum
friendV2_adj.metatable_ResUpdateCompleteNum = {
    _ClassName = "friendV2.ResUpdateCompleteNum",
}
friendV2_adj.metatable_ResUpdateCompleteNum.__index = friendV2_adj.metatable_ResUpdateCompleteNum
--endregion

---@param tbl friendV2.ResUpdateCompleteNum 待调整的table数据
function friendV2_adj.AdjustResUpdateCompleteNum(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResUpdateCompleteNum)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable friendV2.ReqPublishOffer
---@type friendV2.ReqPublishOffer
friendV2_adj.metatable_ReqPublishOffer = {
    _ClassName = "friendV2.ReqPublishOffer",
}
friendV2_adj.metatable_ReqPublishOffer.__index = friendV2_adj.metatable_ReqPublishOffer
--endregion

---@param tbl friendV2.ReqPublishOffer 待调整的table数据
function friendV2_adj.AdjustReqPublishOffer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqPublishOffer)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.reward == nil then
        tbl.rewardSpecified = false
        tbl.reward = 0
    else
        tbl.rewardSpecified = true
    end
    if tbl.targetName == nil then
        tbl.targetNameSpecified = false
        tbl.targetName = ""
    else
        tbl.targetNameSpecified = true
    end
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
end

--region metatable friendV2.TargetId
---@type friendV2.TargetId
friendV2_adj.metatable_TargetId = {
    _ClassName = "friendV2.TargetId",
}
friendV2_adj.metatable_TargetId.__index = friendV2_adj.metatable_TargetId
--endregion

---@param tbl friendV2.TargetId 待调整的table数据
function friendV2_adj.AdjustTargetId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_TargetId)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
end

--region metatable friendV2.ResEnemyPosition
---@type friendV2.ResEnemyPosition
friendV2_adj.metatable_ResEnemyPosition = {
    _ClassName = "friendV2.ResEnemyPosition",
}
friendV2_adj.metatable_ResEnemyPosition.__index = friendV2_adj.metatable_ResEnemyPosition
--endregion

---@param tbl friendV2.ResEnemyPosition 待调整的table数据
function friendV2_adj.AdjustResEnemyPosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResEnemyPosition)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
    if tbl.mapName == nil then
        tbl.mapNameSpecified = false
        tbl.mapName = ""
    else
        tbl.mapNameSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.targetName == nil then
        tbl.targetNameSpecified = false
        tbl.targetName = ""
    else
        tbl.targetNameSpecified = true
    end
end

--region metatable friendV2.ReqWithdrawOffer
---@type friendV2.ReqWithdrawOffer
friendV2_adj.metatable_ReqWithdrawOffer = {
    _ClassName = "friendV2.ReqWithdrawOffer",
}
friendV2_adj.metatable_ReqWithdrawOffer.__index = friendV2_adj.metatable_ReqWithdrawOffer
--endregion

---@param tbl friendV2.ReqWithdrawOffer 待调整的table数据
function friendV2_adj.AdjustReqWithdrawOffer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqWithdrawOffer)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
end

--region metatable friendV2.ReqEarlyLeavePrison
---@type friendV2.ReqEarlyLeavePrison
friendV2_adj.metatable_ReqEarlyLeavePrison = {
    _ClassName = "friendV2.ReqEarlyLeavePrison",
}
friendV2_adj.metatable_ReqEarlyLeavePrison.__index = friendV2_adj.metatable_ReqEarlyLeavePrison
--endregion

---@param tbl friendV2.ReqEarlyLeavePrison 待调整的table数据
function friendV2_adj.AdjustReqEarlyLeavePrison(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqEarlyLeavePrison)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.prisoner == nil then
        tbl.prisonerSpecified = false
        tbl.prisoner = 0
    else
        tbl.prisonerSpecified = true
    end
end

--region metatable friendV2.OfferMatterCode
---@type friendV2.OfferMatterCode
friendV2_adj.metatable_OfferMatterCode = {
    _ClassName = "friendV2.OfferMatterCode",
}
friendV2_adj.metatable_OfferMatterCode.__index = friendV2_adj.metatable_OfferMatterCode
--endregion

---@param tbl friendV2.OfferMatterCode 待调整的table数据
function friendV2_adj.AdjustOfferMatterCode(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_OfferMatterCode)
    if tbl.code == nil then
        tbl.codeSpecified = false
        tbl.code = 0
    else
        tbl.codeSpecified = true
    end
end

--region metatable friendV2.OfferId
---@type friendV2.OfferId
friendV2_adj.metatable_OfferId = {
    _ClassName = "friendV2.OfferId",
}
friendV2_adj.metatable_OfferId.__index = friendV2_adj.metatable_OfferId
--endregion

---@param tbl friendV2.OfferId 待调整的table数据
function friendV2_adj.AdjustOfferId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_OfferId)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable friendV2.UpdateMonsterOfferPanel
---@type friendV2.UpdateMonsterOfferPanel
friendV2_adj.metatable_UpdateMonsterOfferPanel = {
    _ClassName = "friendV2.UpdateMonsterOfferPanel",
}
friendV2_adj.metatable_UpdateMonsterOfferPanel.__index = friendV2_adj.metatable_UpdateMonsterOfferPanel
--endregion

---@param tbl friendV2.UpdateMonsterOfferPanel 待调整的table数据
function friendV2_adj.AdjustUpdateMonsterOfferPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_UpdateMonsterOfferPanel)
    if tbl.infos == nil then
        tbl.infos = {}
    else
        if friendV2_adj.AdjustMonsterOfferPanel ~= nil then
            for i = 1, #tbl.infos do
                friendV2_adj.AdjustMonsterOfferPanel(tbl.infos[i])
            end
        end
    end
end

--region metatable friendV2.MonsterOfferPanel
---@type friendV2.MonsterOfferPanel
friendV2_adj.metatable_MonsterOfferPanel = {
    _ClassName = "friendV2.MonsterOfferPanel",
}
friendV2_adj.metatable_MonsterOfferPanel.__index = friendV2_adj.metatable_MonsterOfferPanel
--endregion

---@param tbl friendV2.MonsterOfferPanel 待调整的table数据
function friendV2_adj.AdjustMonsterOfferPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_MonsterOfferPanel)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.myKillCount == nil then
        tbl.myKillCountSpecified = false
        tbl.myKillCount = 0
    else
        tbl.myKillCountSpecified = true
    end
end

--region metatable friendV2.ResOfferSearch
---@type friendV2.ResOfferSearch
friendV2_adj.metatable_ResOfferSearch = {
    _ClassName = "friendV2.ResOfferSearch",
}
friendV2_adj.metatable_ResOfferSearch.__index = friendV2_adj.metatable_ResOfferSearch
--endregion

---@param tbl friendV2.ResOfferSearch 待调整的table数据
function friendV2_adj.AdjustResOfferSearch(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResOfferSearch)
    if tbl.players == nil then
        tbl.players = {}
    else
        if friendV2_adj.AdjustOfferSearchPlayer ~= nil then
            for i = 1, #tbl.players do
                friendV2_adj.AdjustOfferSearchPlayer(tbl.players[i])
            end
        end
    end
end

--region metatable friendV2.OfferSearchPlayer
---@type friendV2.OfferSearchPlayer
friendV2_adj.metatable_OfferSearchPlayer = {
    _ClassName = "friendV2.OfferSearchPlayer",
}
friendV2_adj.metatable_OfferSearchPlayer.__index = friendV2_adj.metatable_OfferSearchPlayer
--endregion

---@param tbl friendV2.OfferSearchPlayer 待调整的table数据
function friendV2_adj.AdjustOfferSearchPlayer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_OfferSearchPlayer)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable friendV2.ResFriendLoveChange
---@type friendV2.ResFriendLoveChange
friendV2_adj.metatable_ResFriendLoveChange = {
    _ClassName = "friendV2.ResFriendLoveChange",
}
friendV2_adj.metatable_ResFriendLoveChange.__index = friendV2_adj.metatable_ResFriendLoveChange
--endregion

---@param tbl friendV2.ResFriendLoveChange 待调整的table数据
function friendV2_adj.AdjustResFriendLoveChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResFriendLoveChange)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.friendLove == nil then
        tbl.friendLoveSpecified = false
        tbl.friendLove = 0
    else
        tbl.friendLoveSpecified = true
    end
end

--region metatable friendV2.ResFriendCircleUpdated
---@type friendV2.ResFriendCircleUpdated
friendV2_adj.metatable_ResFriendCircleUpdated = {
    _ClassName = "friendV2.ResFriendCircleUpdated",
}
friendV2_adj.metatable_ResFriendCircleUpdated.__index = friendV2_adj.metatable_ResFriendCircleUpdated
--endregion

---@param tbl friendV2.ResFriendCircleUpdated 待调整的table数据
function friendV2_adj.AdjustResFriendCircleUpdated(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResFriendCircleUpdated)
    if tbl.lastReadTime == nil then
        tbl.lastReadTimeSpecified = false
        tbl.lastReadTime = 0
    else
        tbl.lastReadTimeSpecified = true
    end
    if tbl.updateRoleId == nil then
        tbl.updateRoleIdSpecified = false
        tbl.updateRoleId = 0
    else
        tbl.updateRoleIdSpecified = true
    end
    if tbl.unreadCount == nil then
        tbl.unreadCountSpecified = false
        tbl.unreadCount = 0
    else
        tbl.unreadCountSpecified = true
    end
    if tbl.systemMsgDisabled == nil then
        tbl.systemMsgDisabled = {}
    end
    if tbl.updateRoleInfo == nil then
        tbl.updateRoleInfoSpecified = false
        tbl.updateRoleInfo = nil
    else
        if tbl.updateRoleInfoSpecified == nil then 
            tbl.updateRoleInfoSpecified = true
            if friendV2_adj.AdjustFriendInfo ~= nil then
                friendV2_adj.AdjustFriendInfo(tbl.updateRoleInfo)
            end
        end
    end
end

--region metatable friendV2.ReqFriendCircleSysMsgConfig
---@type friendV2.ReqFriendCircleSysMsgConfig
friendV2_adj.metatable_ReqFriendCircleSysMsgConfig = {
    _ClassName = "friendV2.ReqFriendCircleSysMsgConfig",
}
friendV2_adj.metatable_ReqFriendCircleSysMsgConfig.__index = friendV2_adj.metatable_ReqFriendCircleSysMsgConfig
--endregion

---@param tbl friendV2.ReqFriendCircleSysMsgConfig 待调整的table数据
function friendV2_adj.AdjustReqFriendCircleSysMsgConfig(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqFriendCircleSysMsgConfig)
    if tbl.systemMsgDisabled == nil then
        tbl.systemMsgDisabled = {}
    end
end

--region metatable friendV2.UnLookApplicant
---@type friendV2.UnLookApplicant
friendV2_adj.metatable_UnLookApplicant = {
    _ClassName = "friendV2.UnLookApplicant",
}
friendV2_adj.metatable_UnLookApplicant.__index = friendV2_adj.metatable_UnLookApplicant
--endregion

---@param tbl friendV2.UnLookApplicant 待调整的table数据
function friendV2_adj.AdjustUnLookApplicant(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_UnLookApplicant)
    if tbl.applicantList == nil then
        tbl.applicantList = {}
    end
end

--region metatable friendV2.UpdateLettering
---@type friendV2.UpdateLettering
friendV2_adj.metatable_UpdateLettering = {
    _ClassName = "friendV2.UpdateLettering",
}
friendV2_adj.metatable_UpdateLettering.__index = friendV2_adj.metatable_UpdateLettering
--endregion

---@param tbl friendV2.UpdateLettering 待调整的table数据
function friendV2_adj.AdjustUpdateLettering(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_UpdateLettering)
    if tbl.updateRoleId == nil then
        tbl.updateRoleIdSpecified = false
        tbl.updateRoleId = 0
    else
        tbl.updateRoleIdSpecified = true
    end
    if tbl.lettering == nil then
        tbl.letteringSpecified = false
        tbl.lettering = ""
    else
        tbl.letteringSpecified = true
    end
end

--region metatable friendV2.ReqFriendCircleDelete
---@type friendV2.ReqFriendCircleDelete
friendV2_adj.metatable_ReqFriendCircleDelete = {
    _ClassName = "friendV2.ReqFriendCircleDelete",
}
friendV2_adj.metatable_ReqFriendCircleDelete.__index = friendV2_adj.metatable_ReqFriendCircleDelete
--endregion

---@param tbl friendV2.ReqFriendCircleDelete 待调整的table数据
function friendV2_adj.AdjustReqFriendCircleDelete(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ReqFriendCircleDelete)
end

--region metatable friendV2.ResFriendLogin
---@type friendV2.ResFriendLogin
friendV2_adj.metatable_ResFriendLogin = {
    _ClassName = "friendV2.ResFriendLogin",
}
friendV2_adj.metatable_ResFriendLogin.__index = friendV2_adj.metatable_ResFriendLogin
--endregion

---@param tbl friendV2.ResFriendLogin 待调整的table数据
function friendV2_adj.AdjustResFriendLogin(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResFriendLogin)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.isLogin == nil then
        tbl.isLoginSpecified = false
        tbl.isLogin = 0
    else
        tbl.isLoginSpecified = true
    end
end

--region metatable friendV2.ResAccurateSearch
---@type friendV2.ResAccurateSearch
friendV2_adj.metatable_ResAccurateSearch = {
    _ClassName = "friendV2.ResAccurateSearch",
}
friendV2_adj.metatable_ResAccurateSearch.__index = friendV2_adj.metatable_ResAccurateSearch
--endregion

---@param tbl friendV2.ResAccurateSearch 待调整的table数据
function friendV2_adj.AdjustResAccurateSearch(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, friendV2_adj.metatable_ResAccurateSearch)
    if tbl.info == nil then
        tbl.info = {}
    else
        if friendV2_adj.AdjustFriendInfo ~= nil then
            for i = 1, #tbl.info do
                friendV2_adj.AdjustFriendInfo(tbl.info[i])
            end
        end
    end
end

return friendV2_adj