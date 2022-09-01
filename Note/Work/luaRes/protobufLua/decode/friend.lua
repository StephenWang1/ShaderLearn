--[[本文件为工具自动生成,禁止手动修改]]
local friendV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData friendV2.FriendInfo lua中的数据结构
---@return friendV2.FriendInfo C#中的数据结构
function friendV2.FriendInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.FriendInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.relation ~= nil and decodedData.relationSpecified ~= false then
        data.relation = decodedData.relation
    end
    if decodedData.friendLove ~= nil and decodedData.friendLoveSpecified ~= false then
        data.friendLove = decodedData.friendLove
    end
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    if decodedData.isOnline ~= nil and decodedData.isOnlineSpecified ~= false then
        data.isOnline = decodedData.isOnline
    end
    if decodedData.isReceive ~= nil and decodedData.isReceiveSpecified ~= false then
        data.isReceive = decodedData.isReceive
    end
    if decodedData.unreadNum ~= nil and decodedData.unreadNumSpecified ~= false then
        data.unreadNum = decodedData.unreadNum
    end
    if decodedData.latelyChat ~= nil and decodedData.latelyChatSpecified ~= false then
        data.latelyChat = decodeTable.chat.ResChat(decodedData.latelyChat)
    end
    if decodedData.roleLettering ~= nil and decodedData.roleLetteringSpecified ~= false then
        data.roleLettering = decodedData.roleLettering
    end
    if decodedData.remark ~= nil and decodedData.remarkSpecified ~= false then
        data.remark = decodedData.remark
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    return data
end

---@param decodedData friendV2.ResFriendInfo lua中的数据结构
---@return friendV2.ResFriendInfo C#中的数据结构
function friendV2.ResFriendInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResFriendInfo()
    if decodedData.friends ~= nil and decodedData.friendsSpecified ~= false then
        for i = 1, #decodedData.friends do
            data.friends:Add(friendV2.FriendInfo(decodedData.friends[i]))
        end
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.unreadTotalNum ~= nil and decodedData.unreadTotalNumSpecified ~= false then
        data.unreadTotalNum = decodedData.unreadTotalNum
    end
    if decodedData.mayKnowList ~= nil and decodedData.mayKnowListSpecified ~= false then
        for i = 1, #decodedData.mayKnowList do
            data.mayKnowList:Add(friendV2.MayKnowFriend(decodedData.mayKnowList[i]))
        end
    end
    return data
end

---@param decodedData friendV2.ResMayKnowFriend lua中的数据结构
---@return friendV2.ResMayKnowFriend C#中的数据结构
function friendV2.ResMayKnowFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResMayKnowFriend()
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        for i = 1, #decodedData.list do
            data.list:Add(friendV2.MayKnowFriend(decodedData.list[i]))
        end
    end
    return data
end

---@param decodedData friendV2.MayKnowFriend lua中的数据结构
---@return friendV2.MayKnowFriend C#中的数据结构
function friendV2.MayKnowFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.MayKnowFriend()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = friendV2.FriendInfo(decodedData.info)
    end
    return data
end

---@param decodedData friendV2.ReqOpenFriendPanel lua中的数据结构
---@return friendV2.ReqOpenFriendPanel C#中的数据结构
function friendV2.ReqOpenFriendPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqOpenFriendPanel()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData friendV2.ReqSearchFriend lua中的数据结构
---@return friendV2.ReqSearchFriend C#中的数据结构
function friendV2.ReqSearchFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqSearchFriend()
    if decodedData.idOrName ~= nil and decodedData.idOrNameSpecified ~= false then
        data.idOrName = decodedData.idOrName
    end
    return data
end

---@param decodedData friendV2.ReqAddFriend lua中的数据结构
---@return friendV2.ReqAddFriend C#中的数据结构
function friendV2.ReqAddFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqAddFriend()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.uid ~= nil and decodedData.uidSpecified ~= false then
        data.uid = decodedData.uid
    end
    return data
end

---@param decodedData friendV2.ResFriendChange lua中的数据结构
---@return friendV2.ResFriendChange C#中的数据结构
function friendV2.ResFriendChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResFriendChange()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.addOrRemove ~= nil and decodedData.addOrRemoveSpecified ~= false then
        data.addOrRemove = decodedData.addOrRemove
    end
    if decodedData.friend ~= nil and decodedData.friendSpecified ~= false then
        for i = 1, #decodedData.friend do
            data.friend:Add(friendV2.FriendInfo(decodedData.friend[i]))
        end
    end
    return data
end

---@param decodedData friendV2.ReqDeleteFriend lua中的数据结构
---@return friendV2.ReqDeleteFriend C#中的数据结构
function friendV2.ReqDeleteFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqDeleteFriend()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.targetList ~= nil and decodedData.targetListSpecified ~= false then
        data.targetList = decodedData.targetList
    end
    return data
end

---@param decodedData friendV2.checkApply lua中的数据结构
---@return friendV2.checkApply C#中的数据结构
function friendV2.checkApply(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.checkApply()
    if decodedData.listId ~= nil and decodedData.listIdSpecified ~= false then
        for i = 1, #decodedData.listId do
            data.listId:Add(decodedData.listId[i])
        end
    end
    data.flag = decodedData.flag
    return data
end

---@param decodedData friendV2.SummonFriend lua中的数据结构
---@return friendV2.SummonFriend C#中的数据结构
function friendV2.SummonFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.SummonFriend()
    data.roleId = decodedData.roleId
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData friendV2.SummonNotice lua中的数据结构
---@return friendV2.SummonNotice C#中的数据结构
function friendV2.SummonNotice(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.SummonNotice()
    data.roleId = decodedData.roleId
    data.name = decodedData.name
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData friendV2.ConfirmSummon lua中的数据结构
---@return friendV2.ConfirmSummon C#中的数据结构
function friendV2.ConfirmSummon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ConfirmSummon()
    data.roleId = decodedData.roleId
    data.isAgreed = decodedData.isAgreed
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData friendV2.AscertainPoint lua中的数据结构
---@return friendV2.AscertainPoint C#中的数据结构
function friendV2.AscertainPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.AscertainPoint()
    data.mapName = decodedData.mapName
    data.x = decodedData.x
    data.y = decodedData.y
    data.mapId = decodedData.mapId
    data.line = decodedData.line
    return data
end

---@param decodedData friendV2.TeacherDisciple lua中的数据结构
---@return friendV2.TeacherDisciple C#中的数据结构
function friendV2.TeacherDisciple(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.TeacherDisciple()
    data.targetId = decodedData.targetId
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData friendV2.TeacherDiscipleNotice lua中的数据结构
---@return friendV2.TeacherDiscipleNotice C#中的数据结构
function friendV2.TeacherDiscipleNotice(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.TeacherDiscipleNotice()
    data.roleId = decodedData.roleId
    data.name = decodedData.name
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData friendV2.SearchFriend lua中的数据结构
---@return friendV2.SearchFriend C#中的数据结构
function friendV2.SearchFriend(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.SearchFriend()
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        for i = 1, #decodedData.list do
            data.list:Add(friendV2.FriendInfo(decodedData.list[i]))
        end
    end
    return data
end

---@param decodedData friendV2.ReqEditInfo lua中的数据结构
---@return friendV2.ReqEditInfo C#中的数据结构
function friendV2.ReqEditInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqEditInfo()
    if decodedData.brief ~= nil and decodedData.briefSpecified ~= false then
        data.brief = decodedData.brief
    end
    if decodedData.address ~= nil and decodedData.addressSpecified ~= false then
        data.address = decodedData.address
    end
    if decodedData.contactWay ~= nil and decodedData.contactWaySpecified ~= false then
        data.contactWay = decodedData.contactWay
    end
    if decodedData.openList ~= nil and decodedData.openListSpecified ~= false then
        for i = 1, #decodedData.openList do
            data.openList:Add(decodedData.openList[i])
        end
    end
    return data
end

---@param decodedData friendV2.ResPersonalInfo lua中的数据结构
---@return friendV2.ResPersonalInfo C#中的数据结构
function friendV2.ResPersonalInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResPersonalInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.relation ~= nil and decodedData.relationSpecified ~= false then
        data.relation = decodedData.relation
    end
    if decodedData.friendLove ~= nil and decodedData.friendLoveSpecified ~= false then
        data.friendLove = decodedData.friendLove
    end
    if decodedData.brief ~= nil and decodedData.briefSpecified ~= false then
        data.brief = decodedData.brief
    end
    if decodedData.address ~= nil and decodedData.addressSpecified ~= false then
        data.address = decodedData.address
    end
    if decodedData.contactWay ~= nil and decodedData.contactWaySpecified ~= false then
        data.contactWay = decodedData.contactWay
    end
    if decodedData.remark ~= nil and decodedData.remarkSpecified ~= false then
        data.remark = decodedData.remark
    end
    if decodedData.openList ~= nil and decodedData.openListSpecified ~= false then
        for i = 1, #decodedData.openList do
            data.openList:Add(decodedData.openList[i])
        end
    end
    if decodedData.roleLettering ~= nil and decodedData.roleLetteringSpecified ~= false then
        data.roleLettering = decodedData.roleLettering
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData friendV2.ReqEditRemark lua中的数据结构
---@return friendV2.ReqEditRemark C#中的数据结构
function friendV2.ReqEditRemark(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqEditRemark()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.remark ~= nil and decodedData.remarkSpecified ~= false then
        data.remark = decodedData.remark
    end
    return data
end

---@param decodedData friendV2.ReqLookFriendInfo lua中的数据结构
---@return friendV2.ReqLookFriendInfo C#中的数据结构
function friendV2.ReqLookFriendInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqLookFriendInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData friendV2.ChatTarget lua中的数据结构
---@return friendV2.ChatTarget C#中的数据结构
function friendV2.ChatTarget(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ChatTarget()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    return data
end

---@param decodedData friendV2.ResChatLog lua中的数据结构
---@return friendV2.ResChatLog C#中的数据结构
function friendV2.ResChatLog(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResChatLog()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.chatList ~= nil and decodedData.chatListSpecified ~= false then
        for i = 1, #decodedData.chatList do
            data.chatList:Add(decodeTable.chat.ResChat(decodedData.chatList[i]))
        end
    end
    return data
end

---@param decodedData friendV2.ReqChatLog lua中的数据结构
---@return friendV2.ReqChatLog C#中的数据结构
function friendV2.ReqChatLog(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqChatLog()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.chatId ~= nil and decodedData.chatIdSpecified ~= false then
        data.chatId = decodedData.chatId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData friendV2.ReqDeleteChatLog lua中的数据结构
---@return friendV2.ReqDeleteChatLog C#中的数据结构
function friendV2.ReqDeleteChatLog(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqDeleteChatLog()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.ids ~= nil and decodedData.idsSpecified ~= false then
        for i = 1, #decodedData.ids do
            data.ids:Add(decodedData.ids[i])
        end
    end
    return data
end

---@param decodedData friendV2.ResUpdateChatLog lua中的数据结构
---@return friendV2.ResUpdateChatLog C#中的数据结构
function friendV2.ResUpdateChatLog(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResUpdateChatLog()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.chatList ~= nil and decodedData.chatListSpecified ~= false then
        for i = 1, #decodedData.chatList do
            data.chatList:Add(decodeTable.chat.ResChat(decodedData.chatList[i]))
        end
    end
    return data
end

---@param decodedData friendV2.GetFriendCircleInfo lua中的数据结构
---@return friendV2.GetFriendCircleInfo C#中的数据结构
function friendV2.GetFriendCircleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.GetFriendCircleInfo()
    data.beforeTime = decodedData.beforeTime
    data.roleId = decodedData.roleId
    data.type = decodedData.type
    return data
end

---@param decodedData friendV2.FriendCircleReplyInfo lua中的数据结构
---@return friendV2.FriendCircleReplyInfo C#中的数据结构
function friendV2.FriendCircleReplyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.FriendCircleReplyInfo()
    data.id = decodedData.id
    data.roleInfo = friendV2.FriendInfo(decodedData.roleInfo)
    if decodedData.message ~= nil and decodedData.messageSpecified ~= false then
        data.message = decodedData.message
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.replyTo ~= nil and decodedData.replyToSpecified ~= false then
        data.replyTo = decodedData.replyTo
    end
    if decodedData.likedRoles ~= nil and decodedData.likedRolesSpecified ~= false then
        for i = 1, #decodedData.likedRoles do
            data.likedRoles:Add(friendV2.FriendInfo(decodedData.likedRoles[i]))
        end
    end
    return data
end

---@param decodedData friendV2.FriendCirclePostInfo lua中的数据结构
---@return friendV2.FriendCirclePostInfo C#中的数据结构
function friendV2.FriendCirclePostInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.FriendCirclePostInfo()
    if decodedData.post ~= nil and decodedData.postSpecified ~= false then
        data.post = friendV2.FriendCircleReplyInfo(decodedData.post)
    end
    if decodedData.replies ~= nil and decodedData.repliesSpecified ~= false then
        for i = 1, #decodedData.replies do
            data.replies:Add(friendV2.FriendCircleReplyInfo(decodedData.replies[i]))
        end
    end
    if decodedData.systemType ~= nil and decodedData.systemTypeSpecified ~= false then
        data.systemType = decodedData.systemType
    end
    return data
end

---@param decodedData friendV2.ResFriendCircle lua中的数据结构
---@return friendV2.ResFriendCircle C#中的数据结构
function friendV2.ResFriendCircle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResFriendCircle()
    if decodedData.posts ~= nil and decodedData.postsSpecified ~= false then
        for i = 1, #decodedData.posts do
            data.posts:Add(friendV2.FriendCirclePostInfo(decodedData.posts[i]))
        end
    end
    if decodedData.onwer ~= nil and decodedData.onwerSpecified ~= false then
        data.onwer = friendV2.FriendInfo(decodedData.onwer)
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData friendV2.ReqFriendCirclePost lua中的数据结构
---@return friendV2.ReqFriendCirclePost C#中的数据结构
function friendV2.ReqFriendCirclePost(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqFriendCirclePost()
    data.message = decodedData.message
    return data
end

---@param decodedData friendV2.ReqFriendCircleReply lua中的数据结构
---@return friendV2.ReqFriendCircleReply C#中的数据结构
function friendV2.ReqFriendCircleReply(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqFriendCircleReply()
    data.postId = decodedData.postId
    data.replyId = decodedData.replyId
    data.message = decodedData.message
    return data
end

---@param decodedData friendV2.ReqFriendCircleLike lua中的数据结构
---@return friendV2.ReqFriendCircleLike C#中的数据结构
function friendV2.ReqFriendCircleLike(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqFriendCircleLike()
    data.postId = decodedData.postId
    data.replyId = decodedData.replyId
    return data
end

---@param decodedData friendV2.OfferReward lua中的数据结构
---@return friendV2.OfferReward C#中的数据结构
function friendV2.OfferReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.OfferReward()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.prisoner ~= nil and decodedData.prisonerSpecified ~= false then
        data.prisoner = decodedData.prisoner
    end
    if decodedData.prisonerName ~= nil and decodedData.prisonerNameSpecified ~= false then
        data.prisonerName = decodedData.prisonerName
    end
    if decodedData.offerTime ~= nil and decodedData.offerTimeSpecified ~= false then
        data.offerTime = decodedData.offerTime
    end
    if decodedData.reward ~= nil and decodedData.rewardSpecified ~= false then
        data.reward = decodedData.reward
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.finisher ~= nil and decodedData.finisherSpecified ~= false then
        data.finisher = decodedData.finisher
    end
    if decodedData.finisherName ~= nil and decodedData.finisherNameSpecified ~= false then
        data.finisherName = decodedData.finisherName
    end
    if decodedData.finishTime ~= nil and decodedData.finishTimeSpecified ~= false then
        data.finishTime = decodedData.finishTime
    end
    if decodedData.prisonerCareer ~= nil and decodedData.prisonerCareerSpecified ~= false then
        data.prisonerCareer = decodedData.prisonerCareer
    end
    if decodedData.prisonerSex ~= nil and decodedData.prisonerSexSpecified ~= false then
        data.prisonerSex = decodedData.prisonerSex
    end
    if decodedData.prisonerLevel ~= nil and decodedData.prisonerLevelSpecified ~= false then
        data.prisonerLevel = decodedData.prisonerLevel
    end
    if decodedData.offerType ~= nil and decodedData.offerTypeSpecified ~= false then
        data.offerType = decodedData.offerType
    end
    return data
end

---@param decodedData friendV2.MonsterOfferReward lua中的数据结构
---@return friendV2.MonsterOfferReward C#中的数据结构
function friendV2.MonsterOfferReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.MonsterOfferReward()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    if decodedData.head ~= nil and decodedData.headSpecified ~= false then
        data.head = decodedData.head
    end
    if decodedData.monsterName ~= nil and decodedData.monsterNameSpecified ~= false then
        data.monsterName = decodedData.monsterName
    end
    if decodedData.goalCount ~= nil and decodedData.goalCountSpecified ~= false then
        data.goalCount = decodedData.goalCount
    end
    if decodedData.mapName ~= nil and decodedData.mapNameSpecified ~= false then
        data.mapName = decodedData.mapName
    end
    if decodedData.completeNum ~= nil and decodedData.completeNumSpecified ~= false then
        data.completeNum = decodedData.completeNum
    end
    if decodedData.startTime ~= nil and decodedData.startTimeSpecified ~= false then
        data.startTime = decodedData.startTime
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.offerType ~= nil and decodedData.offerTypeSpecified ~= false then
        data.offerType = decodedData.offerType
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.deliverId ~= nil and decodedData.deliverIdSpecified ~= false then
        data.deliverId = decodedData.deliverId
    end
    return data
end

---@param decodedData friendV2.MonsterOfferInfo lua中的数据结构
---@return friendV2.MonsterOfferInfo C#中的数据结构
function friendV2.MonsterOfferInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.MonsterOfferInfo()
    if decodedData.monsterOffer ~= nil and decodedData.monsterOfferSpecified ~= false then
        data.monsterOffer = friendV2.MonsterOfferReward(decodedData.monsterOffer)
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.myKillCount ~= nil and decodedData.myKillCountSpecified ~= false then
        data.myKillCount = decodedData.myKillCount
    end
    return data
end

---@param decodedData friendV2.ReqOfferList lua中的数据结构
---@return friendV2.ReqOfferList C#中的数据结构
function friendV2.ReqOfferList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqOfferList()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    return data
end

---@param decodedData friendV2.ResOfferList lua中的数据结构
---@return friendV2.ResOfferList C#中的数据结构
function friendV2.ResOfferList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResOfferList()
    if decodedData.playerOfferLists ~= nil and decodedData.playerOfferListsSpecified ~= false then
        for i = 1, #decodedData.playerOfferLists do
            data.playerOfferLists:Add(friendV2.PlayerOfferList(decodedData.playerOfferLists[i]))
        end
    end
    if decodedData.monsterOfferLists ~= nil and decodedData.monsterOfferListsSpecified ~= false then
        for i = 1, #decodedData.monsterOfferLists do
            data.monsterOfferLists:Add(friendV2.MonsterOfferList(decodedData.monsterOfferLists[i]))
        end
    end
    return data
end

---@param decodedData friendV2.PlayerOfferList lua中的数据结构
---@return friendV2.PlayerOfferList C#中的数据结构
function friendV2.PlayerOfferList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.PlayerOfferList()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        for i = 1, #decodedData.list do
            data.list:Add(friendV2.OfferReward(decodedData.list[i]))
        end
    end
    return data
end

---@param decodedData friendV2.MonsterOfferList lua中的数据结构
---@return friendV2.MonsterOfferList C#中的数据结构
function friendV2.MonsterOfferList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.MonsterOfferList()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        for i = 1, #decodedData.list do
            data.list:Add(friendV2.MonsterOfferInfo(decodedData.list[i]))
        end
    end
    if decodedData.remainNum ~= nil and decodedData.remainNumSpecified ~= false then
        data.remainNum = decodedData.remainNum
    end
    return data
end

---@param decodedData friendV2.ResUpdateOfferList lua中的数据结构
---@return friendV2.ResUpdateOfferList C#中的数据结构
function friendV2.ResUpdateOfferList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResUpdateOfferList()
    if decodedData.addMonsters ~= nil and decodedData.addMonstersSpecified ~= false then
        for i = 1, #decodedData.addMonsters do
            data.addMonsters:Add(friendV2.MonsterOfferReward(decodedData.addMonsters[i]))
        end
    end
    if decodedData.removeMonsters ~= nil and decodedData.removeMonstersSpecified ~= false then
        for i = 1, #decodedData.removeMonsters do
            data.removeMonsters:Add(decodedData.removeMonsters[i])
        end
    end
    return data
end

---@param decodedData friendV2.ResUpdateCompleteNum lua中的数据结构
---@return friendV2.ResUpdateCompleteNum C#中的数据结构
function friendV2.ResUpdateCompleteNum(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResUpdateCompleteNum()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData friendV2.ReqPublishOffer lua中的数据结构
---@return friendV2.ReqPublishOffer C#中的数据结构
function friendV2.ReqPublishOffer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqPublishOffer()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.reward ~= nil and decodedData.rewardSpecified ~= false then
        data.reward = decodedData.reward
    end
    if decodedData.targetName ~= nil and decodedData.targetNameSpecified ~= false then
        data.targetName = decodedData.targetName
    end
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    return data
end

---@param decodedData friendV2.TargetId lua中的数据结构
---@return friendV2.TargetId C#中的数据结构
function friendV2.TargetId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.TargetId()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    return data
end

---@param decodedData friendV2.ResEnemyPosition lua中的数据结构
---@return friendV2.ResEnemyPosition C#中的数据结构
function friendV2.ResEnemyPosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResEnemyPosition()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.mapName ~= nil and decodedData.mapNameSpecified ~= false then
        data.mapName = decodedData.mapName
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.targetName ~= nil and decodedData.targetNameSpecified ~= false then
        data.targetName = decodedData.targetName
    end
    return data
end

---@param decodedData friendV2.ReqWithdrawOffer lua中的数据结构
---@return friendV2.ReqWithdrawOffer C#中的数据结构
function friendV2.ReqWithdrawOffer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqWithdrawOffer()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    return data
end

---@param decodedData friendV2.ReqEarlyLeavePrison lua中的数据结构
---@return friendV2.ReqEarlyLeavePrison C#中的数据结构
function friendV2.ReqEarlyLeavePrison(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqEarlyLeavePrison()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.prisoner ~= nil and decodedData.prisonerSpecified ~= false then
        data.prisoner = decodedData.prisoner
    end
    return data
end

---@param decodedData friendV2.OfferMatterCode lua中的数据结构
---@return friendV2.OfferMatterCode C#中的数据结构
function friendV2.OfferMatterCode(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.OfferMatterCode()
    if decodedData.code ~= nil and decodedData.codeSpecified ~= false then
        data.code = decodedData.code
    end
    return data
end

---@param decodedData friendV2.OfferId lua中的数据结构
---@return friendV2.OfferId C#中的数据结构
function friendV2.OfferId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.OfferId()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData friendV2.UpdateMonsterOfferPanel lua中的数据结构
---@return friendV2.UpdateMonsterOfferPanel C#中的数据结构
function friendV2.UpdateMonsterOfferPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.UpdateMonsterOfferPanel()
    if decodedData.infos ~= nil and decodedData.infosSpecified ~= false then
        for i = 1, #decodedData.infos do
            data.infos:Add(friendV2.MonsterOfferPanel(decodedData.infos[i]))
        end
    end
    return data
end

---@param decodedData friendV2.MonsterOfferPanel lua中的数据结构
---@return friendV2.MonsterOfferPanel C#中的数据结构
function friendV2.MonsterOfferPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.MonsterOfferPanel()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.myKillCount ~= nil and decodedData.myKillCountSpecified ~= false then
        data.myKillCount = decodedData.myKillCount
    end
    return data
end

---@param decodedData friendV2.ResOfferSearch lua中的数据结构
---@return friendV2.ResOfferSearch C#中的数据结构
function friendV2.ResOfferSearch(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResOfferSearch()
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(friendV2.OfferSearchPlayer(decodedData.players[i]))
        end
    end
    return data
end

---@param decodedData friendV2.OfferSearchPlayer lua中的数据结构
---@return friendV2.OfferSearchPlayer C#中的数据结构
function friendV2.OfferSearchPlayer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.OfferSearchPlayer()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData friendV2.ResFriendLoveChange lua中的数据结构
---@return friendV2.ResFriendLoveChange C#中的数据结构
function friendV2.ResFriendLoveChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResFriendLoveChange()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.friendLove ~= nil and decodedData.friendLoveSpecified ~= false then
        data.friendLove = decodedData.friendLove
    end
    return data
end

---@param decodedData friendV2.ResFriendCircleUpdated lua中的数据结构
---@return friendV2.ResFriendCircleUpdated C#中的数据结构
function friendV2.ResFriendCircleUpdated(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResFriendCircleUpdated()
    data.updateTime = decodedData.updateTime
    if decodedData.lastReadTime ~= nil and decodedData.lastReadTimeSpecified ~= false then
        data.lastReadTime = decodedData.lastReadTime
    end
    if decodedData.updateRoleId ~= nil and decodedData.updateRoleIdSpecified ~= false then
        data.updateRoleId = decodedData.updateRoleId
    end
    if decodedData.unreadCount ~= nil and decodedData.unreadCountSpecified ~= false then
        data.unreadCount = decodedData.unreadCount
    end
    if decodedData.systemMsgDisabled ~= nil and decodedData.systemMsgDisabledSpecified ~= false then
        for i = 1, #decodedData.systemMsgDisabled do
            data.systemMsgDisabled:Add(decodedData.systemMsgDisabled[i])
        end
    end
    if decodedData.updateRoleInfo ~= nil and decodedData.updateRoleInfoSpecified ~= false then
        data.updateRoleInfo = friendV2.FriendInfo(decodedData.updateRoleInfo)
    end
    return data
end

---@param decodedData friendV2.ReqFriendCircleSysMsgConfig lua中的数据结构
---@return friendV2.ReqFriendCircleSysMsgConfig C#中的数据结构
function friendV2.ReqFriendCircleSysMsgConfig(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqFriendCircleSysMsgConfig()
    if decodedData.systemMsgDisabled ~= nil and decodedData.systemMsgDisabledSpecified ~= false then
        for i = 1, #decodedData.systemMsgDisabled do
            data.systemMsgDisabled:Add(decodedData.systemMsgDisabled[i])
        end
    end
    return data
end

---@param decodedData friendV2.UnLookApplicant lua中的数据结构
---@return friendV2.UnLookApplicant C#中的数据结构
function friendV2.UnLookApplicant(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.UnLookApplicant()
    if decodedData.applicantList ~= nil and decodedData.applicantListSpecified ~= false then
        for i = 1, #decodedData.applicantList do
            data.applicantList:Add(decodedData.applicantList[i])
        end
    end
    return data
end

---@param decodedData friendV2.UpdateLettering lua中的数据结构
---@return friendV2.UpdateLettering C#中的数据结构
function friendV2.UpdateLettering(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.UpdateLettering()
    if decodedData.updateRoleId ~= nil and decodedData.updateRoleIdSpecified ~= false then
        data.updateRoleId = decodedData.updateRoleId
    end
    if decodedData.lettering ~= nil and decodedData.letteringSpecified ~= false then
        data.lettering = decodedData.lettering
    end
    return data
end

---@param decodedData friendV2.ReqFriendCircleDelete lua中的数据结构
---@return friendV2.ReqFriendCircleDelete C#中的数据结构
function friendV2.ReqFriendCircleDelete(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ReqFriendCircleDelete()
    data.postId = decodedData.postId
    data.replyId = decodedData.replyId
    return data
end

---@param decodedData friendV2.ResFriendLogin lua中的数据结构
---@return friendV2.ResFriendLogin C#中的数据结构
function friendV2.ResFriendLogin(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResFriendLogin()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.isLogin ~= nil and decodedData.isLoginSpecified ~= false then
        data.isLogin = decodedData.isLogin
    end
    return data
end

---@param decodedData friendV2.ResAccurateSearch lua中的数据结构
---@return friendV2.ResAccurateSearch C#中的数据结构
function friendV2.ResAccurateSearch(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.friendV2.ResAccurateSearch()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(friendV2.FriendInfo(decodedData.info[i]))
        end
    end
    return data
end

return friendV2