--[[本文件为工具自动生成,禁止手动修改]]
local vipV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData vipV2.ReqBuyVipReward lua中的数据结构
---@return vipV2.ReqBuyVipReward C#中的数据结构
function vipV2.ReqBuyVipReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ReqBuyVipReward()
    if decodedData.vipLevel ~= nil and decodedData.vipLevelSpecified ~= false then
        data.vipLevel = decodedData.vipLevel
    end
    return data
end

---@param decodedData vipV2.ResRoleVipInfoChange lua中的数据结构
---@return vipV2.ResRoleVipInfoChange C#中的数据结构
function vipV2.ResRoleVipInfoChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResRoleVipInfoChange()
    if decodedData.curExp ~= nil and decodedData.curExpSpecified ~= false then
        data.curExp = decodedData.curExp
    end
    if decodedData.curLevel ~= nil and decodedData.curLevelSpecified ~= false then
        data.curLevel = decodedData.curLevel
    end
    if decodedData.changeExp ~= nil and decodedData.changeExpSpecified ~= false then
        data.changeExp = decodedData.changeExp
    end
    return data
end

---@param decodedData vipV2.ResRoleVip2InfoChange lua中的数据结构
---@return vipV2.ResRoleVip2InfoChange C#中的数据结构
function vipV2.ResRoleVip2InfoChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResRoleVip2InfoChange()
    if decodedData.curExp ~= nil and decodedData.curExpSpecified ~= false then
        data.curExp = decodedData.curExp
    end
    if decodedData.curLevel ~= nil and decodedData.curLevelSpecified ~= false then
        data.curLevel = decodedData.curLevel
    end
    if decodedData.changeExp ~= nil and decodedData.changeExpSpecified ~= false then
        data.changeExp = decodedData.changeExp
    end
    return data
end

---@param decodedData vipV2.ResRoleVipInfo lua中的数据结构
---@return vipV2.ResRoleVipInfo C#中的数据结构
function vipV2.ResRoleVipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResRoleVipInfo()
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.totalRechargeDiamond ~= nil and decodedData.totalRechargeDiamondSpecified ~= false then
        data.totalRechargeDiamond = decodedData.totalRechargeDiamond
    end
    if decodedData.monthRechargeDiamond ~= nil and decodedData.monthRechargeDiamondSpecified ~= false then
        data.monthRechargeDiamond = decodedData.monthRechargeDiamond
    end
    if decodedData.payBackRechargeIds ~= nil and decodedData.payBackRechargeIdsSpecified ~= false then
        for i = 1, #decodedData.payBackRechargeIds do
            data.payBackRechargeIds:Add(decodedData.payBackRechargeIds[i])
        end
    end
    return data
end

---@param decodedData vipV2.ResRoleVip2Info lua中的数据结构
---@return vipV2.ResRoleVip2Info C#中的数据结构
function vipV2.ResRoleVip2Info(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResRoleVip2Info()
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    return data
end

---@param decodedData vipV2.ResBuyVipReward lua中的数据结构
---@return vipV2.ResBuyVipReward C#中的数据结构
function vipV2.ResBuyVipReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResBuyVipReward()
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        for i = 1, #decodedData.level do
            data.level:Add(decodedData.level[i])
        end
    end
    return data
end

---@param decodedData vipV2.ResFreeVipReward lua中的数据结构
---@return vipV2.ResFreeVipReward C#中的数据结构
function vipV2.ResFreeVipReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResFreeVipReward()
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        for i = 1, #decodedData.level do
            data.level:Add(decodedData.level[i])
        end
    end
    return data
end

---@param decodedData vipV2.CardInfo lua中的数据结构
---@return vipV2.CardInfo C#中的数据结构
function vipV2.CardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.CardInfo()
    if decodedData.kind ~= nil and decodedData.kindSpecified ~= false then
        data.kind = decodedData.kind
    end
    if decodedData.cardType ~= nil and decodedData.cardTypeSpecified ~= false then
        data.cardType = decodedData.cardType
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.isGot ~= nil and decodedData.isGotSpecified ~= false then
        data.isGot = decodedData.isGot
    end
    if decodedData.renewNum ~= nil and decodedData.renewNumSpecified ~= false then
        data.renewNum = decodedData.renewNum
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.activeType ~= nil and decodedData.activeTypeSpecified ~= false then
        data.activeType = decodedData.activeType
    end
    return data
end

---@param decodedData vipV2.CardId lua中的数据结构
---@return vipV2.CardId C#中的数据结构
function vipV2.CardId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.CardId()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData vipV2.CardKind lua中的数据结构
---@return vipV2.CardKind C#中的数据结构
function vipV2.CardKind(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.CardKind()
    if decodedData.kind ~= nil and decodedData.kindSpecified ~= false then
        data.kind = decodedData.kind
    end
    return data
end

---@param decodedData vipV2.CardType lua中的数据结构
---@return vipV2.CardType C#中的数据结构
function vipV2.CardType(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.CardType()
    if decodedData.cardType ~= nil and decodedData.cardTypeSpecified ~= false then
        data.cardType = decodedData.cardType
    end
    return data
end

---@param decodedData vipV2.Card lua中的数据结构
---@return vipV2.Card C#中的数据结构
function vipV2.Card(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.Card()
    if decodedData.kind ~= nil and decodedData.kindSpecified ~= false then
        data.kind = decodedData.kind
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.priceType ~= nil and decodedData.priceTypeSpecified ~= false then
        data.priceType = decodedData.priceType
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodedData.price
    end
    if decodedData.orignalPrice ~= nil and decodedData.orignalPriceSpecified ~= false then
        data.orignalPrice = decodedData.orignalPrice
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData vipV2.ResCardPanel lua中的数据结构
---@return vipV2.ResCardPanel C#中的数据结构
function vipV2.ResCardPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResCardPanel()
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        for i = 1, #decodedData.list do
            data.list:Add(vipV2.Card(decodedData.list[i]))
        end
    end
    if decodedData.kind ~= nil and decodedData.kindSpecified ~= false then
        data.kind = decodedData.kind
    end
    return data
end

---@param decodedData vipV2.ResCardInfo lua中的数据结构
---@return vipV2.ResCardInfo C#中的数据结构
function vipV2.ResCardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResCardInfo()
    if decodedData.cardList ~= nil and decodedData.cardListSpecified ~= false then
        for i = 1, #decodedData.cardList do
            data.cardList:Add(vipV2.CardInfo(decodedData.cardList[i]))
        end
    end
    return data
end

---@param decodedData vipV2.ResCardChange lua中的数据结构
---@return vipV2.ResCardChange C#中的数据结构
function vipV2.ResCardChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResCardChange()
    if decodedData.cardInfo ~= nil and decodedData.cardInfoSpecified ~= false then
        data.cardInfo = vipV2.CardInfo(decodedData.cardInfo)
    end
    if decodedData.kind ~= nil and decodedData.kindSpecified ~= false then
        data.kind = decodedData.kind
    end
    if decodedData.removeCardType ~= nil and decodedData.removeCardTypeSpecified ~= false then
        data.removeCardType = decodedData.removeCardType
    end
    if decodedData.isActive ~= nil and decodedData.isActiveSpecified ~= false then
        data.isActive = decodedData.isActive
    end
    return data
end

---@param decodedData vipV2.ResCardDayRewardInfo lua中的数据结构
---@return vipV2.ResCardDayRewardInfo C#中的数据结构
function vipV2.ResCardDayRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.ResCardDayRewardInfo()
    if decodedData.rewardList ~= nil and decodedData.rewardListSpecified ~= false then
        for i = 1, #decodedData.rewardList do
            data.rewardList:Add(vipV2.Welfare(decodedData.rewardList[i]))
        end
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData vipV2.Welfare lua中的数据结构
---@return vipV2.Welfare C#中的数据结构
function vipV2.Welfare(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.Welfare()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData vipV2.VipMemberInfo lua中的数据结构
---@return vipV2.VipMemberInfo C#中的数据结构
function vipV2.VipMemberInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.VipMemberInfo()
    data.level = decodedData.level
    data.dailyReceivedCount = decodedData.dailyReceivedCount
    if decodedData.receivedLevelReward ~= nil and decodedData.receivedLevelRewardSpecified ~= false then
        for i = 1, #decodedData.receivedLevelReward do
            data.receivedLevelReward:Add(decodedData.receivedLevelReward[i])
        end
    end
    if decodedData.taskList ~= nil and decodedData.taskListSpecified ~= false then
        for i = 1, #decodedData.taskList do
            data.taskList:Add(vipV2.VipMemberTask(decodedData.taskList[i]))
        end
    end
    return data
end

---@param decodedData vipV2.VipMemberTask lua中的数据结构
---@return vipV2.VipMemberTask C#中的数据结构
function vipV2.VipMemberTask(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.VipMemberTask()
    data.taskId = decodedData.taskId
    data.process = decodedData.process
    data.state = decodedData.state
    return data
end

---@param decodedData vipV2.VipMemberReveiveLevelReward lua中的数据结构
---@return vipV2.VipMemberReveiveLevelReward C#中的数据结构
function vipV2.VipMemberReveiveLevelReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.vipV2.VipMemberReveiveLevelReward()
    data.level = decodedData.level
    return data
end

return vipV2