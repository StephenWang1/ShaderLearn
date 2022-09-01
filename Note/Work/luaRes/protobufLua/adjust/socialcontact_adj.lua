--[[本文件为工具自动生成,禁止手动修改]]
local socialcontactV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable socialcontactV2.ReqSendFlowers
---@type socialcontactV2.ReqSendFlowers
socialcontactV2_adj.metatable_ReqSendFlowers = {
    _ClassName = "socialcontactV2.ReqSendFlowers",
}
socialcontactV2_adj.metatable_ReqSendFlowers.__index = socialcontactV2_adj.metatable_ReqSendFlowers
--endregion

---@param tbl socialcontactV2.ReqSendFlowers 待调整的table数据
function socialcontactV2_adj.AdjustReqSendFlowers(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ReqSendFlowers)
    if tbl.targetRid == nil then
        tbl.targetRidSpecified = false
        tbl.targetRid = 0
    else
        tbl.targetRidSpecified = true
    end
    if tbl.flowerCount == nil then
        tbl.flowerCountSpecified = false
        tbl.flowerCount = 0
    else
        tbl.flowerCountSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable socialcontactV2.ReqGetTheFlowerCount
---@type socialcontactV2.ReqGetTheFlowerCount
socialcontactV2_adj.metatable_ReqGetTheFlowerCount = {
    _ClassName = "socialcontactV2.ReqGetTheFlowerCount",
}
socialcontactV2_adj.metatable_ReqGetTheFlowerCount.__index = socialcontactV2_adj.metatable_ReqGetTheFlowerCount
--endregion

---@param tbl socialcontactV2.ReqGetTheFlowerCount 待调整的table数据
function socialcontactV2_adj.AdjustReqGetTheFlowerCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ReqGetTheFlowerCount)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable socialcontactV2.ResGetTheFlowerCount
---@type socialcontactV2.ResGetTheFlowerCount
socialcontactV2_adj.metatable_ResGetTheFlowerCount = {
    _ClassName = "socialcontactV2.ResGetTheFlowerCount",
}
socialcontactV2_adj.metatable_ResGetTheFlowerCount.__index = socialcontactV2_adj.metatable_ResGetTheFlowerCount
--endregion

---@param tbl socialcontactV2.ResGetTheFlowerCount 待调整的table数据
function socialcontactV2_adj.AdjustResGetTheFlowerCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ResGetTheFlowerCount)
    if tbl.flowerCount == nil then
        tbl.flowerCountSpecified = false
        tbl.flowerCount = 0
    else
        tbl.flowerCountSpecified = true
    end
end

--region metatable socialcontactV2.ResTeXiao
---@type socialcontactV2.ResTeXiao
socialcontactV2_adj.metatable_ResTeXiao = {
    _ClassName = "socialcontactV2.ResTeXiao",
}
socialcontactV2_adj.metatable_ResTeXiao.__index = socialcontactV2_adj.metatable_ResTeXiao
--endregion

---@param tbl socialcontactV2.ResTeXiao 待调整的table数据
function socialcontactV2_adj.AdjustResTeXiao(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ResTeXiao)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable socialcontactV2.ResDefaultFlowerId
---@type socialcontactV2.ResDefaultFlowerId
socialcontactV2_adj.metatable_ResDefaultFlowerId = {
    _ClassName = "socialcontactV2.ResDefaultFlowerId",
}
socialcontactV2_adj.metatable_ResDefaultFlowerId.__index = socialcontactV2_adj.metatable_ResDefaultFlowerId
--endregion

---@param tbl socialcontactV2.ResDefaultFlowerId 待调整的table数据
function socialcontactV2_adj.AdjustResDefaultFlowerId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ResDefaultFlowerId)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable socialcontactV2.FatePeople
---@type socialcontactV2.FatePeople
socialcontactV2_adj.metatable_FatePeople = {
    _ClassName = "socialcontactV2.FatePeople",
}
socialcontactV2_adj.metatable_FatePeople.__index = socialcontactV2_adj.metatable_FatePeople
--endregion

---@param tbl socialcontactV2.FatePeople 待调整的table数据
function socialcontactV2_adj.AdjustFatePeople(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_FatePeople)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable socialcontactV2.ReqRebateFlower
---@type socialcontactV2.ReqRebateFlower
socialcontactV2_adj.metatable_ReqRebateFlower = {
    _ClassName = "socialcontactV2.ReqRebateFlower",
}
socialcontactV2_adj.metatable_ReqRebateFlower.__index = socialcontactV2_adj.metatable_ReqRebateFlower
--endregion

---@param tbl socialcontactV2.ReqRebateFlower 待调整的table数据
function socialcontactV2_adj.AdjustReqRebateFlower(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ReqRebateFlower)
    if tbl.targetRid == nil then
        tbl.targetRidSpecified = false
        tbl.targetRid = 0
    else
        tbl.targetRidSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable socialcontactV2.ReqReplyToThank
---@type socialcontactV2.ReqReplyToThank
socialcontactV2_adj.metatable_ReqReplyToThank = {
    _ClassName = "socialcontactV2.ReqReplyToThank",
}
socialcontactV2_adj.metatable_ReqReplyToThank.__index = socialcontactV2_adj.metatable_ReqReplyToThank
--endregion

---@param tbl socialcontactV2.ReqReplyToThank 待调整的table数据
function socialcontactV2_adj.AdjustReqReplyToThank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ReqReplyToThank)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.targetRid == nil then
        tbl.targetRidSpecified = false
        tbl.targetRid = 0
    else
        tbl.targetRidSpecified = true
    end
end

--region metatable socialcontactV2.ReqSendFlowerAddFriend
---@type socialcontactV2.ReqSendFlowerAddFriend
socialcontactV2_adj.metatable_ReqSendFlowerAddFriend = {
    _ClassName = "socialcontactV2.ReqSendFlowerAddFriend",
}
socialcontactV2_adj.metatable_ReqSendFlowerAddFriend.__index = socialcontactV2_adj.metatable_ReqSendFlowerAddFriend
--endregion

---@param tbl socialcontactV2.ReqSendFlowerAddFriend 待调整的table数据
function socialcontactV2_adj.AdjustReqSendFlowerAddFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ReqSendFlowerAddFriend)
    if tbl.targetRid == nil then
        tbl.targetRidSpecified = false
        tbl.targetRid = 0
    else
        tbl.targetRidSpecified = true
    end
end

--region metatable socialcontactV2.ReqAgreeSendFlowerAddFriend
---@type socialcontactV2.ReqAgreeSendFlowerAddFriend
socialcontactV2_adj.metatable_ReqAgreeSendFlowerAddFriend = {
    _ClassName = "socialcontactV2.ReqAgreeSendFlowerAddFriend",
}
socialcontactV2_adj.metatable_ReqAgreeSendFlowerAddFriend.__index = socialcontactV2_adj.metatable_ReqAgreeSendFlowerAddFriend
--endregion

---@param tbl socialcontactV2.ReqAgreeSendFlowerAddFriend 待调整的table数据
function socialcontactV2_adj.AdjustReqAgreeSendFlowerAddFriend(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, socialcontactV2_adj.metatable_ReqAgreeSendFlowerAddFriend)
    if tbl.targetRid == nil then
        tbl.targetRidSpecified = false
        tbl.targetRid = 0
    else
        tbl.targetRidSpecified = true
    end
end

return socialcontactV2_adj