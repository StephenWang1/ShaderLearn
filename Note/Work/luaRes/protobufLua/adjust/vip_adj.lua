--[[本文件为工具自动生成,禁止手动修改]]
local vipV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable vipV2.ReqBuyVipReward
---@type vipV2.ReqBuyVipReward
vipV2_adj.metatable_ReqBuyVipReward = {
    _ClassName = "vipV2.ReqBuyVipReward",
}
vipV2_adj.metatable_ReqBuyVipReward.__index = vipV2_adj.metatable_ReqBuyVipReward
--endregion

---@param tbl vipV2.ReqBuyVipReward 待调整的table数据
function vipV2_adj.AdjustReqBuyVipReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ReqBuyVipReward)
    if tbl.vipLevel == nil then
        tbl.vipLevelSpecified = false
        tbl.vipLevel = 0
    else
        tbl.vipLevelSpecified = true
    end
end

--region metatable vipV2.ResRoleVipInfoChange
---@type vipV2.ResRoleVipInfoChange
vipV2_adj.metatable_ResRoleVipInfoChange = {
    _ClassName = "vipV2.ResRoleVipInfoChange",
}
vipV2_adj.metatable_ResRoleVipInfoChange.__index = vipV2_adj.metatable_ResRoleVipInfoChange
--endregion

---@param tbl vipV2.ResRoleVipInfoChange 待调整的table数据
function vipV2_adj.AdjustResRoleVipInfoChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResRoleVipInfoChange)
    if tbl.curExp == nil then
        tbl.curExpSpecified = false
        tbl.curExp = 0
    else
        tbl.curExpSpecified = true
    end
    if tbl.curLevel == nil then
        tbl.curLevelSpecified = false
        tbl.curLevel = 0
    else
        tbl.curLevelSpecified = true
    end
    if tbl.changeExp == nil then
        tbl.changeExpSpecified = false
        tbl.changeExp = 0
    else
        tbl.changeExpSpecified = true
    end
end

--region metatable vipV2.ResRoleVip2InfoChange
---@type vipV2.ResRoleVip2InfoChange
vipV2_adj.metatable_ResRoleVip2InfoChange = {
    _ClassName = "vipV2.ResRoleVip2InfoChange",
}
vipV2_adj.metatable_ResRoleVip2InfoChange.__index = vipV2_adj.metatable_ResRoleVip2InfoChange
--endregion

---@param tbl vipV2.ResRoleVip2InfoChange 待调整的table数据
function vipV2_adj.AdjustResRoleVip2InfoChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResRoleVip2InfoChange)
    if tbl.curExp == nil then
        tbl.curExpSpecified = false
        tbl.curExp = 0
    else
        tbl.curExpSpecified = true
    end
    if tbl.curLevel == nil then
        tbl.curLevelSpecified = false
        tbl.curLevel = 0
    else
        tbl.curLevelSpecified = true
    end
    if tbl.changeExp == nil then
        tbl.changeExpSpecified = false
        tbl.changeExp = 0
    else
        tbl.changeExpSpecified = true
    end
end

--region metatable vipV2.ResRoleVipInfo
---@type vipV2.ResRoleVipInfo
vipV2_adj.metatable_ResRoleVipInfo = {
    _ClassName = "vipV2.ResRoleVipInfo",
}
vipV2_adj.metatable_ResRoleVipInfo.__index = vipV2_adj.metatable_ResRoleVipInfo
--endregion

---@param tbl vipV2.ResRoleVipInfo 待调整的table数据
function vipV2_adj.AdjustResRoleVipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResRoleVipInfo)
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.totalRechargeDiamond == nil then
        tbl.totalRechargeDiamondSpecified = false
        tbl.totalRechargeDiamond = 0
    else
        tbl.totalRechargeDiamondSpecified = true
    end
    if tbl.monthRechargeDiamond == nil then
        tbl.monthRechargeDiamondSpecified = false
        tbl.monthRechargeDiamond = 0
    else
        tbl.monthRechargeDiamondSpecified = true
    end
    if tbl.payBackRechargeIds == nil then
        tbl.payBackRechargeIds = {}
    end
end

--region metatable vipV2.ResRoleVip2Info
---@type vipV2.ResRoleVip2Info
vipV2_adj.metatable_ResRoleVip2Info = {
    _ClassName = "vipV2.ResRoleVip2Info",
}
vipV2_adj.metatable_ResRoleVip2Info.__index = vipV2_adj.metatable_ResRoleVip2Info
--endregion

---@param tbl vipV2.ResRoleVip2Info 待调整的table数据
function vipV2_adj.AdjustResRoleVip2Info(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResRoleVip2Info)
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
end

--region metatable vipV2.ResBuyVipReward
---@type vipV2.ResBuyVipReward
vipV2_adj.metatable_ResBuyVipReward = {
    _ClassName = "vipV2.ResBuyVipReward",
}
vipV2_adj.metatable_ResBuyVipReward.__index = vipV2_adj.metatable_ResBuyVipReward
--endregion

---@param tbl vipV2.ResBuyVipReward 待调整的table数据
function vipV2_adj.AdjustResBuyVipReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResBuyVipReward)
    if tbl.level == nil then
        tbl.level = {}
    end
end

--region metatable vipV2.ResFreeVipReward
---@type vipV2.ResFreeVipReward
vipV2_adj.metatable_ResFreeVipReward = {
    _ClassName = "vipV2.ResFreeVipReward",
}
vipV2_adj.metatable_ResFreeVipReward.__index = vipV2_adj.metatable_ResFreeVipReward
--endregion

---@param tbl vipV2.ResFreeVipReward 待调整的table数据
function vipV2_adj.AdjustResFreeVipReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResFreeVipReward)
    if tbl.level == nil then
        tbl.level = {}
    end
end

--region metatable vipV2.CardInfo
---@type vipV2.CardInfo
vipV2_adj.metatable_CardInfo = {
    _ClassName = "vipV2.CardInfo",
}
vipV2_adj.metatable_CardInfo.__index = vipV2_adj.metatable_CardInfo
--endregion

---@param tbl vipV2.CardInfo 待调整的table数据
function vipV2_adj.AdjustCardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_CardInfo)
    if tbl.kind == nil then
        tbl.kindSpecified = false
        tbl.kind = 0
    else
        tbl.kindSpecified = true
    end
    if tbl.cardType == nil then
        tbl.cardTypeSpecified = false
        tbl.cardType = 0
    else
        tbl.cardTypeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.isGot == nil then
        tbl.isGotSpecified = false
        tbl.isGot = false
    else
        tbl.isGotSpecified = true
    end
    if tbl.renewNum == nil then
        tbl.renewNumSpecified = false
        tbl.renewNum = 0
    else
        tbl.renewNumSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.activeType == nil then
        tbl.activeTypeSpecified = false
        tbl.activeType = 0
    else
        tbl.activeTypeSpecified = true
    end
end

--region metatable vipV2.CardId
---@type vipV2.CardId
vipV2_adj.metatable_CardId = {
    _ClassName = "vipV2.CardId",
}
vipV2_adj.metatable_CardId.__index = vipV2_adj.metatable_CardId
--endregion

---@param tbl vipV2.CardId 待调整的table数据
function vipV2_adj.AdjustCardId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_CardId)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable vipV2.CardKind
---@type vipV2.CardKind
vipV2_adj.metatable_CardKind = {
    _ClassName = "vipV2.CardKind",
}
vipV2_adj.metatable_CardKind.__index = vipV2_adj.metatable_CardKind
--endregion

---@param tbl vipV2.CardKind 待调整的table数据
function vipV2_adj.AdjustCardKind(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_CardKind)
    if tbl.kind == nil then
        tbl.kindSpecified = false
        tbl.kind = 0
    else
        tbl.kindSpecified = true
    end
end

--region metatable vipV2.CardType
---@type vipV2.CardType
vipV2_adj.metatable_CardType = {
    _ClassName = "vipV2.CardType",
}
vipV2_adj.metatable_CardType.__index = vipV2_adj.metatable_CardType
--endregion

---@param tbl vipV2.CardType 待调整的table数据
function vipV2_adj.AdjustCardType(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_CardType)
    if tbl.cardType == nil then
        tbl.cardTypeSpecified = false
        tbl.cardType = 0
    else
        tbl.cardTypeSpecified = true
    end
end

--region metatable vipV2.Card
---@type vipV2.Card
vipV2_adj.metatable_Card = {
    _ClassName = "vipV2.Card",
}
vipV2_adj.metatable_Card.__index = vipV2_adj.metatable_Card
--endregion

---@param tbl vipV2.Card 待调整的table数据
function vipV2_adj.AdjustCard(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_Card)
    if tbl.kind == nil then
        tbl.kindSpecified = false
        tbl.kind = 0
    else
        tbl.kindSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.priceType == nil then
        tbl.priceTypeSpecified = false
        tbl.priceType = 0
    else
        tbl.priceTypeSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = 0
    else
        tbl.priceSpecified = true
    end
    if tbl.orignalPrice == nil then
        tbl.orignalPriceSpecified = false
        tbl.orignalPrice = 0
    else
        tbl.orignalPriceSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable vipV2.ResCardPanel
---@type vipV2.ResCardPanel
vipV2_adj.metatable_ResCardPanel = {
    _ClassName = "vipV2.ResCardPanel",
}
vipV2_adj.metatable_ResCardPanel.__index = vipV2_adj.metatable_ResCardPanel
--endregion

---@param tbl vipV2.ResCardPanel 待调整的table数据
function vipV2_adj.AdjustResCardPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResCardPanel)
    if tbl.list == nil then
        tbl.list = {}
    else
        if vipV2_adj.AdjustCard ~= nil then
            for i = 1, #tbl.list do
                vipV2_adj.AdjustCard(tbl.list[i])
            end
        end
    end
    if tbl.kind == nil then
        tbl.kindSpecified = false
        tbl.kind = 0
    else
        tbl.kindSpecified = true
    end
end

--region metatable vipV2.ResCardInfo
---@type vipV2.ResCardInfo
vipV2_adj.metatable_ResCardInfo = {
    _ClassName = "vipV2.ResCardInfo",
}
vipV2_adj.metatable_ResCardInfo.__index = vipV2_adj.metatable_ResCardInfo
--endregion

---@param tbl vipV2.ResCardInfo 待调整的table数据
function vipV2_adj.AdjustResCardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResCardInfo)
    if tbl.cardList == nil then
        tbl.cardList = {}
    else
        if vipV2_adj.AdjustCardInfo ~= nil then
            for i = 1, #tbl.cardList do
                vipV2_adj.AdjustCardInfo(tbl.cardList[i])
            end
        end
    end
end

--region metatable vipV2.ResCardChange
---@type vipV2.ResCardChange
vipV2_adj.metatable_ResCardChange = {
    _ClassName = "vipV2.ResCardChange",
}
vipV2_adj.metatable_ResCardChange.__index = vipV2_adj.metatable_ResCardChange
--endregion

---@param tbl vipV2.ResCardChange 待调整的table数据
function vipV2_adj.AdjustResCardChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResCardChange)
    if tbl.cardInfo == nil then
        tbl.cardInfoSpecified = false
        tbl.cardInfo = nil
    else
        if tbl.cardInfoSpecified == nil then 
            tbl.cardInfoSpecified = true
            if vipV2_adj.AdjustCardInfo ~= nil then
                vipV2_adj.AdjustCardInfo(tbl.cardInfo)
            end
        end
    end
    if tbl.kind == nil then
        tbl.kindSpecified = false
        tbl.kind = 0
    else
        tbl.kindSpecified = true
    end
    if tbl.removeCardType == nil then
        tbl.removeCardTypeSpecified = false
        tbl.removeCardType = 0
    else
        tbl.removeCardTypeSpecified = true
    end
    if tbl.isActive == nil then
        tbl.isActiveSpecified = false
        tbl.isActive = 0
    else
        tbl.isActiveSpecified = true
    end
end

--region metatable vipV2.ResCardDayRewardInfo
---@type vipV2.ResCardDayRewardInfo
vipV2_adj.metatable_ResCardDayRewardInfo = {
    _ClassName = "vipV2.ResCardDayRewardInfo",
}
vipV2_adj.metatable_ResCardDayRewardInfo.__index = vipV2_adj.metatable_ResCardDayRewardInfo
--endregion

---@param tbl vipV2.ResCardDayRewardInfo 待调整的table数据
function vipV2_adj.AdjustResCardDayRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_ResCardDayRewardInfo)
    if tbl.rewardList == nil then
        tbl.rewardList = {}
    else
        if vipV2_adj.AdjustWelfare ~= nil then
            for i = 1, #tbl.rewardList do
                vipV2_adj.AdjustWelfare(tbl.rewardList[i])
            end
        end
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable vipV2.Welfare
---@type vipV2.Welfare
vipV2_adj.metatable_Welfare = {
    _ClassName = "vipV2.Welfare",
}
vipV2_adj.metatable_Welfare.__index = vipV2_adj.metatable_Welfare
--endregion

---@param tbl vipV2.Welfare 待调整的table数据
function vipV2_adj.AdjustWelfare(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_Welfare)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable vipV2.VipMemberInfo
---@type vipV2.VipMemberInfo
vipV2_adj.metatable_VipMemberInfo = {
    _ClassName = "vipV2.VipMemberInfo",
}
vipV2_adj.metatable_VipMemberInfo.__index = vipV2_adj.metatable_VipMemberInfo
--endregion

---@param tbl vipV2.VipMemberInfo 待调整的table数据
function vipV2_adj.AdjustVipMemberInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_VipMemberInfo)
    if tbl.receivedLevelReward == nil then
        tbl.receivedLevelReward = {}
    end
    if tbl.taskList == nil then
        tbl.taskList = {}
    else
        if vipV2_adj.AdjustVipMemberTask ~= nil then
            for i = 1, #tbl.taskList do
                vipV2_adj.AdjustVipMemberTask(tbl.taskList[i])
            end
        end
    end
end

--region metatable vipV2.VipMemberTask
---@type vipV2.VipMemberTask
vipV2_adj.metatable_VipMemberTask = {
    _ClassName = "vipV2.VipMemberTask",
}
vipV2_adj.metatable_VipMemberTask.__index = vipV2_adj.metatable_VipMemberTask
--endregion

---@param tbl vipV2.VipMemberTask 待调整的table数据
function vipV2_adj.AdjustVipMemberTask(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_VipMemberTask)
end

--region metatable vipV2.VipMemberReveiveLevelReward
---@type vipV2.VipMemberReveiveLevelReward
vipV2_adj.metatable_VipMemberReveiveLevelReward = {
    _ClassName = "vipV2.VipMemberReveiveLevelReward",
}
vipV2_adj.metatable_VipMemberReveiveLevelReward.__index = vipV2_adj.metatable_VipMemberReveiveLevelReward
--endregion

---@param tbl vipV2.VipMemberReveiveLevelReward 待调整的table数据
function vipV2_adj.AdjustVipMemberReveiveLevelReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, vipV2_adj.metatable_VipMemberReveiveLevelReward)
end

return vipV2_adj