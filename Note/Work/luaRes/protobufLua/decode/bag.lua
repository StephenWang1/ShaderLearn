--[[本文件为工具自动生成,禁止手动修改]]
local bagV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData bagV2.BestAttInfo lua中的数据结构
---@return bagV2.BestAttInfo C#中的数据结构
function bagV2.BestAttInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.BestAttInfo()
    data.attId = decodedData.attId
    data.attType = decodedData.attType
    if decodedData.attValue ~= nil and decodedData.attValueSpecified ~= false then
        data.attValue = decodedData.attValue
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    return data
end

---@param decodedData bagV2.LingBaoInfo lua中的数据结构
---@return bagV2.LingBaoInfo C#中的数据结构
function bagV2.LingBaoInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.LingBaoInfo()
    data.level = decodedData.level
    if decodedData.nowExp ~= nil and decodedData.nowExpSpecified ~= false then
        data.nowExp = decodedData.nowExp
    end
    if decodedData.totalExp ~= nil and decodedData.totalExpSpecified ~= false then
        data.totalExp = decodedData.totalExp
    end
    if decodedData.refineLv ~= nil and decodedData.refineLvSpecified ~= false then
        data.refineLv = decodedData.refineLv
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    return data
end

---@param decodedData bagV2.JiPinInfo lua中的数据结构
---@return bagV2.JiPinInfo C#中的数据结构
function bagV2.JiPinInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.JiPinInfo()
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.attributeType ~= nil and decodedData.attributeTypeSpecified ~= false then
        for i = 1, #decodedData.attributeType do
            data.attributeType:Add(decodedData.attributeType[i])
        end
    end
    if decodedData.attributeValue ~= nil and decodedData.attributeValueSpecified ~= false then
        for i = 1, #decodedData.attributeValue do
            data.attributeValue:Add(decodedData.attributeValue[i])
        end
    end
    return data
end

---@param decodedData bagV2.FromInfo lua中的数据结构
---@return bagV2.FromInfo C#中的数据结构
function bagV2.FromInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.FromInfo()
    data.type = decodedData.type
    if decodedData.params ~= nil and decodedData.paramsSpecified ~= false then
        for i = 1, #decodedData.params do
            data.params:Add(decodedData.params[i])
        end
    end
    return data
end

---@param decodedData bagV2.BagItemInfo lua中的数据结构
---@return bagV2.BagItemInfo C#中的数据结构
function bagV2.BagItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.BagItemInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.bind ~= nil and decodedData.bindSpecified ~= false then
        data.bind = decodedData.bind
    end
    if decodedData.attribute ~= nil and decodedData.attributeSpecified ~= false then
        for i = 1, #decodedData.attribute do
            data.attribute:Add(bagV2.ItemAttribute(decodedData.attribute[i]))
        end
    end
    if decodedData.fromInfo ~= nil and decodedData.fromInfoSpecified ~= false then
        data.fromInfo = bagV2.FromInfo(decodedData.fromInfo)
    end
    if decodedData.intensify ~= nil and decodedData.intensifySpecified ~= false then
        data.intensify = decodedData.intensify
    end
    if decodedData.maxStar ~= nil and decodedData.maxStarSpecified ~= false then
        data.maxStar = decodedData.maxStar
    end
    if decodedData.zhuling ~= nil and decodedData.zhulingSpecified ~= false then
        data.zhuling = decodedData.zhuling
    end
    if decodedData.luck ~= nil and decodedData.luckSpecified ~= false then
        data.luck = decodedData.luck
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.currentLasting ~= nil and decodedData.currentLastingSpecified ~= false then
        data.currentLasting = decodedData.currentLasting
    end
    if decodedData.curse ~= nil and decodedData.curseSpecified ~= false then
        data.curse = decodedData.curse
    end
    if decodedData.rateAttribute ~= nil and decodedData.rateAttributeSpecified ~= false then
        for i = 1, #decodedData.rateAttribute do
            data.rateAttribute:Add(bagV2.ItemAttribute(decodedData.rateAttribute[i]))
        end
    end
    if decodedData.imprint ~= nil and decodedData.imprintSpecified ~= false then
        data.imprint = decodedData.imprint
    end
    if decodedData.isWastageLasting ~= nil and decodedData.isWastageLastingSpecified ~= false then
        data.isWastageLasting = decodedData.isWastageLasting
    end
    if decodedData.leftUseNum ~= nil and decodedData.leftUseNumSpecified ~= false then
        data.leftUseNum = decodedData.leftUseNum
    end
    if decodedData.bagIndex ~= nil and decodedData.bagIndexSpecified ~= false then
        data.bagIndex = decodedData.bagIndex
    end
    if decodedData.inlayInfoList ~= nil and decodedData.inlayInfoListSpecified ~= false then
        for i = 1, #decodedData.inlayInfoList do
            data.inlayInfoList:Add(bagV2.inlayInfo(decodedData.inlayInfoList[i]))
        end
    end
    if decodedData.tradeState ~= nil and decodedData.tradeStateSpecified ~= false then
        data.tradeState = decodedData.tradeState
    end
    if decodedData.canTrade ~= nil and decodedData.canTradeSpecified ~= false then
        data.canTrade = decodedData.canTrade
    end
    if decodedData.redBagMoney ~= nil and decodedData.redBagMoneySpecified ~= false then
        data.redBagMoney = decodedData.redBagMoney
    end
    if decodedData.rateAttribute1 ~= nil and decodedData.rateAttribute1Specified ~= false then
        for i = 1, #decodedData.rateAttribute1 do
            data.rateAttribute1:Add(bagV2.ItemAttribute(decodedData.rateAttribute1[i]))
        end
    end
    if decodedData.rateAttribute2 ~= nil and decodedData.rateAttribute2Specified ~= false then
        for i = 1, #decodedData.rateAttribute2 do
            data.rateAttribute2:Add(bagV2.ItemAttribute(decodedData.rateAttribute2[i]))
        end
    end
    if decodedData.bloodLevel ~= nil and decodedData.bloodLevelSpecified ~= false then
        data.bloodLevel = decodedData.bloodLevel
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.limitedType ~= nil and decodedData.limitedTypeSpecified ~= false then
        data.limitedType = decodedData.limitedType
    end
    if decodedData.limitedTime ~= nil and decodedData.limitedTimeSpecified ~= false then
        data.limitedTime = decodedData.limitedTime
    end
    if decodedData.soulEffect ~= nil and decodedData.soulEffectSpecified ~= false then
        data.soulEffect = decodedData.soulEffect
    end
    if decodedData.appraisalQuality ~= nil and decodedData.appraisalQualitySpecified ~= false then
        data.appraisalQuality = decodedData.appraisalQuality
    end
    if decodedData.appraisalAttr ~= nil and decodedData.appraisalAttrSpecified ~= false then
        data.appraisalAttr = decodedData.appraisalAttr
    end
    if decodedData.isInsured ~= nil and decodedData.isInsuredSpecified ~= false then
        data.isInsured = decodedData.isInsured
    end
    if decodedData.growthLevel ~= nil and decodedData.growthLevelSpecified ~= false then
        data.growthLevel = decodedData.growthLevel
    end
    if decodedData.killMonsterCount ~= nil and decodedData.killMonsterCountSpecified ~= false then
        data.killMonsterCount = decodedData.killMonsterCount
    end
    return data
end

---@param decodedData bagV2.inlayInfo lua中的数据结构
---@return bagV2.inlayInfo C#中的数据结构
function bagV2.inlayInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.inlayInfo()
    if decodedData.pos ~= nil and decodedData.posSpecified ~= false then
        data.pos = decodedData.pos
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.currentLasting ~= nil and decodedData.currentLastingSpecified ~= false then
        data.currentLasting = decodedData.currentLasting
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData bagV2.ExtraEquip lua中的数据结构
---@return bagV2.ExtraEquip C#中的数据结构
function bagV2.ExtraEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ExtraEquip()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData bagV2.ItemAttribute lua中的数据结构
---@return bagV2.ItemAttribute C#中的数据结构
function bagV2.ItemAttribute(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ItemAttribute()
    data.type = decodedData.type
    data.num = decodedData.num
    return data
end

---@param decodedData bagV2.InstanceItemInfo lua中的数据结构
---@return bagV2.InstanceItemInfo C#中的数据结构
function bagV2.InstanceItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.InstanceItemInfo()
    if decodedData.globalId ~= nil and decodedData.globalIdSpecified ~= false then
        data.globalId = decodedData.globalId
    end
    if decodedData.useNum ~= nil and decodedData.useNumSpecified ~= false then
        data.useNum = decodedData.useNum
    end
    return data
end

---@param decodedData bagV2.CoinInfo lua中的数据结构
---@return bagV2.CoinInfo C#中的数据结构
function bagV2.CoinInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.CoinInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData bagV2.ResBagInfo lua中的数据结构
---@return bagV2.ResBagInfo C#中的数据结构
function bagV2.ResBagInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResBagInfo()
    if decodedData.emptyGridCount ~= nil and decodedData.emptyGridCountSpecified ~= false then
        data.emptyGridCount = decodedData.emptyGridCount
    end
    if decodedData.maxGridCount ~= nil and decodedData.maxGridCountSpecified ~= false then
        data.maxGridCount = decodedData.maxGridCount
    end
    if decodedData.addGridCount ~= nil and decodedData.addGridCountSpecified ~= false then
        data.addGridCount = decodedData.addGridCount
    end
    if decodedData.itemList ~= nil and decodedData.itemListSpecified ~= false then
        for i = 1, #decodedData.itemList do
            data.itemList:Add(bagV2.BagItemInfo(decodedData.itemList[i]))
        end
    end
    if decodedData.coinList ~= nil and decodedData.coinListSpecified ~= false then
        for i = 1, #decodedData.coinList do
            data.coinList:Add(bagV2.CoinInfo(decodedData.coinList[i]))
        end
    end
    if decodedData.recycleData ~= nil and decodedData.recycleDataSpecified ~= false then
        for i = 1, #decodedData.recycleData do
            data.recycleData:Add(decodedData.recycleData[i])
        end
    end
    if decodedData.extraEquip ~= nil and decodedData.extraEquipSpecified ~= false then
        for i = 1, #decodedData.extraEquip do
            data.extraEquip:Add(bagV2.ExtraEquip(decodedData.extraEquip[i]))
        end
    end
    return data
end

---@param decodedData bagV2.ResBagChange lua中的数据结构
---@return bagV2.ResBagChange C#中的数据结构
function bagV2.ResBagChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResBagChange()
    if decodedData.action ~= nil and decodedData.actionSpecified ~= false then
        data.action = decodedData.action
    end
    if decodedData.itemList ~= nil and decodedData.itemListSpecified ~= false then
        for i = 1, #decodedData.itemList do
            data.itemList:Add(bagV2.BagItemInfo(decodedData.itemList[i]))
        end
    end
    if decodedData.coinList ~= nil and decodedData.coinListSpecified ~= false then
        for i = 1, #decodedData.coinList do
            data.coinList:Add(bagV2.CoinInfo(decodedData.coinList[i]))
        end
    end
    if decodedData.removedIdList ~= nil and decodedData.removedIdListSpecified ~= false then
        for i = 1, #decodedData.removedIdList do
            data.removedIdList:Add(decodedData.removedIdList[i])
        end
    end
    if decodedData.removeItemList ~= nil and decodedData.removeItemListSpecified ~= false then
        for i = 1, #decodedData.removeItemList do
            data.removeItemList:Add(bagV2.BagItemInfo(decodedData.removeItemList[i]))
        end
    end
    return data
end

---@param decodedData bagV2.UseItemRequest lua中的数据结构
---@return bagV2.UseItemRequest C#中的数据结构
function bagV2.UseItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.UseItemRequest()
    data.count = decodedData.count
    data.itemId = decodedData.itemId
    if decodedData.clientParam ~= nil and decodedData.clientParamSpecified ~= false then
        data.clientParam = decodedData.clientParam
    end
    if decodedData.clientParams ~= nil and decodedData.clientParamsSpecified ~= false then
        for i = 1, #decodedData.clientParams do
            data.clientParams:Add(decodedData.clientParams[i])
        end
    end
    if decodedData.clientParamStrs ~= nil and decodedData.clientParamStrsSpecified ~= false then
        for i = 1, #decodedData.clientParamStrs do
            data.clientParamStrs:Add(decodedData.clientParamStrs[i])
        end
    end
    return data
end

---@param decodedData bagV2.ResUseItem lua中的数据结构
---@return bagV2.ResUseItem C#中的数据结构
function bagV2.ResUseItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResUseItem()
    data.itemId = decodedData.itemId
    if decodedData.cdTime ~= nil and decodedData.cdTimeSpecified ~= false then
        data.cdTime = decodedData.cdTime
    end
    return data
end

---@param decodedData bagV2.RecycleEquipmentRequest lua中的数据结构
---@return bagV2.RecycleEquipmentRequest C#中的数据结构
function bagV2.RecycleEquipmentRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.RecycleEquipmentRequest()
    if decodedData.recycleList ~= nil and decodedData.recycleListSpecified ~= false then
        for i = 1, #decodedData.recycleList do
            data.recycleList:Add(decodedData.recycleList[i])
        end
    end
    if decodedData.intensifyLv ~= nil and decodedData.intensifyLvSpecified ~= false then
        data.intensifyLv = decodedData.intensifyLv
    end
    if decodedData.recycleData ~= nil and decodedData.recycleDataSpecified ~= false then
        for i = 1, #decodedData.recycleData do
            data.recycleData:Add(decodedData.recycleData[i])
        end
    end
    return data
end

---@param decodedData bagV2.RecycleSuccess lua中的数据结构
---@return bagV2.RecycleSuccess C#中的数据结构
function bagV2.RecycleSuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.RecycleSuccess()
    if decodedData.idList ~= nil and decodedData.idListSpecified ~= false then
        for i = 1, #decodedData.idList do
            data.idList:Add(decodedData.idList[i])
        end
    end
    return data
end

---@param decodedData bagV2.ResSmelt lua中的数据结构
---@return bagV2.ResSmelt C#中的数据结构
function bagV2.ResSmelt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResSmelt()
    if decodedData.idList ~= nil and decodedData.idListSpecified ~= false then
        for i = 1, #decodedData.idList do
            data.idList:Add(decodedData.idList[i])
        end
    end
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(bagV2.ItemOutput(decodedData.rewards[i]))
        end
    end
    return data
end

---@param decodedData bagV2.ResAddGridCountChange lua中的数据结构
---@return bagV2.ResAddGridCountChange C#中的数据结构
function bagV2.ResAddGridCountChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResAddGridCountChange()
    if decodedData.addGridCount ~= nil and decodedData.addGridCountSpecified ~= false then
        data.addGridCount = decodedData.addGridCount
    end
    if decodedData.emptyGridCount ~= nil and decodedData.emptyGridCountSpecified ~= false then
        data.emptyGridCount = decodedData.emptyGridCount
    end
    if decodedData.maxGridCount ~= nil and decodedData.maxGridCountSpecified ~= false then
        data.maxGridCount = decodedData.maxGridCount
    end
    return data
end

---@param decodedData bagV2.ResUseAttackDrag lua中的数据结构
---@return bagV2.ResUseAttackDrag C#中的数据结构
function bagV2.ResUseAttackDrag(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResUseAttackDrag()
    if decodedData.rate ~= nil and decodedData.rateSpecified ~= false then
        data.rate = decodedData.rate
    end
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    if decodedData.useCount ~= nil and decodedData.useCountSpecified ~= false then
        data.useCount = decodedData.useCount
    end
    return data
end

---@param decodedData bagV2.UseInstanceItemRequest lua中的数据结构
---@return bagV2.UseInstanceItemRequest C#中的数据结构
function bagV2.UseInstanceItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.UseInstanceItemRequest()
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.globalId ~= nil and decodedData.globalIdSpecified ~= false then
        data.globalId = decodedData.globalId
    end
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    if decodedData.useTime ~= nil and decodedData.useTimeSpecified ~= false then
        data.useTime = decodedData.useTime
    end
    return data
end

---@param decodedData bagV2.ResGetAttackDragBuyCount lua中的数据结构
---@return bagV2.ResGetAttackDragBuyCount C#中的数据结构
function bagV2.ResGetAttackDragBuyCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResGetAttackDragBuyCount()
    if decodedData.useInfo ~= nil and decodedData.useInfoSpecified ~= false then
        for i = 1, #decodedData.useInfo do
            data.useInfo:Add(bagV2.InstanceItemInfo(decodedData.useInfo[i]))
        end
    end
    return data
end

---@param decodedData bagV2.VipRecycleEquipmentRequest lua中的数据结构
---@return bagV2.VipRecycleEquipmentRequest C#中的数据结构
function bagV2.VipRecycleEquipmentRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.VipRecycleEquipmentRequest()
    if decodedData.recycleList ~= nil and decodedData.recycleListSpecified ~= false then
        for i = 1, #decodedData.recycleList do
            data.recycleList:Add(decodedData.recycleList[i])
        end
    end
    return data
end

---@param decodedData bagV2.DeleteSpecialItemRequest lua中的数据结构
---@return bagV2.DeleteSpecialItemRequest C#中的数据结构
function bagV2.DeleteSpecialItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.DeleteSpecialItemRequest()
    data.uniqueId = decodedData.uniqueId
    return data
end

---@param decodedData bagV2.ResRechargeBoxInfo lua中的数据结构
---@return bagV2.ResRechargeBoxInfo C#中的数据结构
function bagV2.ResRechargeBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResRechargeBoxInfo()
    data.itemId = decodedData.itemId
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData bagV2.SellActivityItemRequest lua中的数据结构
---@return bagV2.SellActivityItemRequest C#中的数据结构
function bagV2.SellActivityItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.SellActivityItemRequest()
    data.itemId = decodedData.itemId
    data.count = decodedData.count
    return data
end

---@param decodedData bagV2.StartZhuanPanRequest lua中的数据结构
---@return bagV2.StartZhuanPanRequest C#中的数据结构
function bagV2.StartZhuanPanRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.StartZhuanPanRequest()
    data.itemId = decodedData.itemId
    return data
end

---@param decodedData bagV2.ResZhuanPanResult lua中的数据结构
---@return bagV2.ResZhuanPanResult C#中的数据结构
function bagV2.ResZhuanPanResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResZhuanPanResult()
    data.index = decodedData.index
    data.intemId = decodedData.intemId
    data.count = decodedData.count
    return data
end

---@param decodedData bagV2.ResSpecialItemActivate lua中的数据结构
---@return bagV2.ResSpecialItemActivate C#中的数据结构
function bagV2.ResSpecialItemActivate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResSpecialItemActivate()
    if decodedData.itemIdList ~= nil and decodedData.itemIdListSpecified ~= false then
        for i = 1, #decodedData.itemIdList do
            data.itemIdList:Add(decodedData.itemIdList[i])
        end
    end
    return data
end

---@param decodedData bagV2.ResStorageInfo lua中的数据结构
---@return bagV2.ResStorageInfo C#中的数据结构
function bagV2.ResStorageInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResStorageInfo()
    if decodedData.emptyGridCount ~= nil and decodedData.emptyGridCountSpecified ~= false then
        data.emptyGridCount = decodedData.emptyGridCount
    end
    if decodedData.maxGridCount ~= nil and decodedData.maxGridCountSpecified ~= false then
        data.maxGridCount = decodedData.maxGridCount
    end
    if decodedData.itemList ~= nil and decodedData.itemListSpecified ~= false then
        for i = 1, #decodedData.itemList do
            data.itemList:Add(bagV2.BagItemInfo(decodedData.itemList[i]))
        end
    end
    return data
end

---@param decodedData bagV2.ResStorageUpdate lua中的数据结构
---@return bagV2.ResStorageUpdate C#中的数据结构
function bagV2.ResStorageUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResStorageUpdate()
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = bagV2.BagItemInfo(decodedData.item)
    end
    if decodedData.operate ~= nil and decodedData.operateSpecified ~= false then
        data.operate = decodedData.operate
    end
    return data
end

---@param decodedData bagV2.StorageOutItemRequest lua中的数据结构
---@return bagV2.StorageOutItemRequest C#中的数据结构
function bagV2.StorageOutItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.StorageOutItemRequest()
    data.objId = decodedData.objId
    return data
end

---@param decodedData bagV2.StorageInItemRequest lua中的数据结构
---@return bagV2.StorageInItemRequest C#中的数据结构
function bagV2.StorageInItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.StorageInItemRequest()
    data.objId = decodedData.objId
    return data
end

---@param decodedData bagV2.ResAddStorageMaxCount lua中的数据结构
---@return bagV2.ResAddStorageMaxCount C#中的数据结构
function bagV2.ResAddStorageMaxCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResAddStorageMaxCount()
    data.emptyGridCount = decodedData.emptyGridCount
    data.maxGridCount = decodedData.maxGridCount
    return data
end

---@param decodedData bagV2.AddTradeItemRequest lua中的数据结构
---@return bagV2.AddTradeItemRequest C#中的数据结构
function bagV2.AddTradeItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.AddTradeItemRequest()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData bagV2.ResTradeItemChange lua中的数据结构
---@return bagV2.ResTradeItemChange C#中的数据结构
function bagV2.ResTradeItemChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResTradeItemChange()
    data.uid = decodedData.uid
    if decodedData.itemList ~= nil and decodedData.itemListSpecified ~= false then
        for i = 1, #decodedData.itemList do
            data.itemList:Add(bagV2.BagItemInfo(decodedData.itemList[i]))
        end
    end
    if decodedData.coinList ~= nil and decodedData.coinListSpecified ~= false then
        for i = 1, #decodedData.coinList do
            data.coinList:Add(bagV2.CoinInfo(decodedData.coinList[i]))
        end
    end
    return data
end

---@param decodedData bagV2.DiscardItemRequest lua中的数据结构
---@return bagV2.DiscardItemRequest C#中的数据结构
function bagV2.DiscardItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.DiscardItemRequest()
    data.objId = decodedData.objId
    data.count = decodedData.count
    return data
end

---@param decodedData bagV2.ResRecoveryDrug lua中的数据结构
---@return bagV2.ResRecoveryDrug C#中的数据结构
function bagV2.ResRecoveryDrug(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResRecoveryDrug()
    data.itemId = decodedData.itemId
    if decodedData.cdTime ~= nil and decodedData.cdTimeSpecified ~= false then
        data.cdTime = decodedData.cdTime
    end
    return data
end

---@param decodedData bagV2.ItemApart lua中的数据结构
---@return bagV2.ItemApart C#中的数据结构
function bagV2.ItemApart(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ItemApart()
    data.itemId = decodedData.itemId
    data.count = decodedData.count
    return data
end

---@param decodedData bagV2.ReqIntensify lua中的数据结构
---@return bagV2.ReqIntensify C#中的数据结构
function bagV2.ReqIntensify(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqIntensify()
    data.equipId = decodedData.equipId
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData bagV2.ReqIntensifyTrans lua中的数据结构
---@return bagV2.ReqIntensifyTrans C#中的数据结构
function bagV2.ReqIntensifyTrans(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqIntensifyTrans()
    data.oldEquipId = decodedData.oldEquipId
    data.newEquipId = decodedData.newEquipId
    return data
end

---@param decodedData bagV2.ResIntensify lua中的数据结构
---@return bagV2.ResIntensify C#中的数据结构
function bagV2.ResIntensify(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResIntensify()
    data.equipId = decodedData.equipId
    data.equipInfo = bagV2.BagItemInfo(decodedData.equipInfo)
    return data
end

---@param decodedData bagV2.Destruction lua中的数据结构
---@return bagV2.Destruction C#中的数据结构
function bagV2.Destruction(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.Destruction()
    data.objId = decodedData.objId
    return data
end

---@param decodedData bagV2.GemUpgrade lua中的数据结构
---@return bagV2.GemUpgrade C#中的数据结构
function bagV2.GemUpgrade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.GemUpgrade()
    data.currentId = decodedData.currentId
    return data
end

---@param decodedData bagV2.GemUpgradeRes lua中的数据结构
---@return bagV2.GemUpgradeRes C#中的数据结构
function bagV2.GemUpgradeRes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.GemUpgradeRes()
    data.newId = decodedData.newId
    data.type = decodedData.type
    return data
end

---@param decodedData bagV2.LastingUpdate lua中的数据结构
---@return bagV2.LastingUpdate C#中的数据结构
function bagV2.LastingUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.LastingUpdate()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        for i = 1, #decodedData.itemId do
            data.itemId:Add(decodedData.itemId[i])
        end
    end
    return data
end

---@param decodedData bagV2.UseAllExpBox lua中的数据结构
---@return bagV2.UseAllExpBox C#中的数据结构
function bagV2.UseAllExpBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.UseAllExpBox()
    data.data = decodedData.data
    if decodedData.useSpiritPoint ~= nil and decodedData.useSpiritPointSpecified ~= false then
        data.useSpiritPoint = decodedData.useSpiritPoint
    end
    return data
end

---@param decodedData bagV2.UseExpBox lua中的数据结构
---@return bagV2.UseExpBox C#中的数据结构
function bagV2.UseExpBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.UseExpBox()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.useSpiritPoint ~= nil and decodedData.useSpiritPointSpecified ~= false then
        data.useSpiritPoint = decodedData.useSpiritPoint
    end
    return data
end

---@param decodedData bagV2.TidyItem lua中的数据结构
---@return bagV2.TidyItem C#中的数据结构
function bagV2.TidyItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.TidyItem()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        for i = 1, #decodedData.itemId do
            data.itemId:Add(decodedData.itemId[i])
        end
    end
    return data
end

---@param decodedData bagV2.LampUpgrade lua中的数据结构
---@return bagV2.LampUpgrade C#中的数据结构
function bagV2.LampUpgrade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.LampUpgrade()
    data.currentId = decodedData.currentId
    data.lampId = decodedData.lampId
    data.type = decodedData.type
    return data
end

---@param decodedData bagV2.LampUpgradeRes lua中的数据结构
---@return bagV2.LampUpgradeRes C#中的数据结构
function bagV2.LampUpgradeRes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.LampUpgradeRes()
    data.type = decodedData.type
    data.id = decodedData.id
    return data
end

---@param decodedData bagV2.ReqUpgradeSoulJade lua中的数据结构
---@return bagV2.ReqUpgradeSoulJade C#中的数据结构
function bagV2.ReqUpgradeSoulJade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqUpgradeSoulJade()
    data.soulJadeId = decodedData.soulJadeId
    data.thisId = decodedData.thisId
    data.type = decodedData.type
    return data
end

---@param decodedData bagV2.ResUpgradeSoulJade lua中的数据结构
---@return bagV2.ResUpgradeSoulJade C#中的数据结构
function bagV2.ResUpgradeSoulJade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResUpgradeSoulJade()
    data.newId = decodedData.newId
    return data
end

---@param decodedData bagV2.RafflePreyTreasureBag lua中的数据结构
---@return bagV2.RafflePreyTreasureBag C#中的数据结构
function bagV2.RafflePreyTreasureBag(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.RafflePreyTreasureBag()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData bagV2.DrawPreyTreasureBagResponse lua中的数据结构
---@return bagV2.DrawPreyTreasureBagResponse C#中的数据结构
function bagV2.DrawPreyTreasureBagResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.DrawPreyTreasureBagResponse()
    return data
end

---@param decodedData bagV2.DrawPreyTreasureBag lua中的数据结构
---@return bagV2.DrawPreyTreasureBag C#中的数据结构
function bagV2.DrawPreyTreasureBag(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.DrawPreyTreasureBag()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData bagV2.PreyTreasureBagResponse lua中的数据结构
---@return bagV2.PreyTreasureBagResponse C#中的数据结构
function bagV2.PreyTreasureBagResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.PreyTreasureBagResponse()
    if decodedData.jackpot ~= nil and decodedData.jackpotSpecified ~= false then
        for i = 1, #decodedData.jackpot do
            data.jackpot:Add(bagV2.BagItemInfo(decodedData.jackpot[i]))
        end
    end
    if decodedData.rewardIndex ~= nil and decodedData.rewardIndexSpecified ~= false then
        data.rewardIndex = decodedData.rewardIndex
    end
    if decodedData.isRaffle ~= nil and decodedData.isRaffleSpecified ~= false then
        data.isRaffle = decodedData.isRaffle
    end
    return data
end

---@param decodedData bagV2.RafflePreyTreasureBox lua中的数据结构
---@return bagV2.RafflePreyTreasureBox C#中的数据结构
function bagV2.RafflePreyTreasureBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.RafflePreyTreasureBox()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData bagV2.DrawPreyTreasureBoxResponse lua中的数据结构
---@return bagV2.DrawPreyTreasureBoxResponse C#中的数据结构
function bagV2.DrawPreyTreasureBoxResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.DrawPreyTreasureBoxResponse()
    return data
end

---@param decodedData bagV2.DrawPreyTreasureBox lua中的数据结构
---@return bagV2.DrawPreyTreasureBox C#中的数据结构
function bagV2.DrawPreyTreasureBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.DrawPreyTreasureBox()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.dayCount ~= nil and decodedData.dayCountSpecified ~= false then
        data.dayCount = decodedData.dayCount
    end
    return data
end

---@param decodedData bagV2.PreyTreasureBoxResponse lua中的数据结构
---@return bagV2.PreyTreasureBoxResponse C#中的数据结构
function bagV2.PreyTreasureBoxResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.PreyTreasureBoxResponse()
    if decodedData.jackpot ~= nil and decodedData.jackpotSpecified ~= false then
        for i = 1, #decodedData.jackpot do
            data.jackpot:Add(bagV2.BagItemInfo(decodedData.jackpot[i]))
        end
    end
    if decodedData.rewardIndex ~= nil and decodedData.rewardIndexSpecified ~= false then
        data.rewardIndex = decodedData.rewardIndex
    end
    if decodedData.isRaffle ~= nil and decodedData.isRaffleSpecified ~= false then
        data.isRaffle = decodedData.isRaffle
    end
    return data
end

---@param decodedData bagV2.UsePreyTreasureBoxMulti lua中的数据结构
---@return bagV2.UsePreyTreasureBoxMulti C#中的数据结构
function bagV2.UsePreyTreasureBoxMulti(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.UsePreyTreasureBoxMulti()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData bagV2.ResAwardPreyTreasureBoxMulti lua中的数据结构
---@return bagV2.ResAwardPreyTreasureBoxMulti C#中的数据结构
function bagV2.ResAwardPreyTreasureBoxMulti(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResAwardPreyTreasureBoxMulti()
    if decodedData.awardItems ~= nil and decodedData.awardItemsSpecified ~= false then
        for i = 1, #decodedData.awardItems do
            data.awardItems:Add(bagV2.BagItemInfo(decodedData.awardItems[i]))
        end
    end
    if decodedData.package ~= nil and decodedData.packageSpecified ~= false then
        for i = 1, #decodedData.package do
            data.package:Add(bagV2.PreyTreasureBoxResponse(decodedData.package[i]))
        end
    end
    return data
end

---@param decodedData bagV2.AwardPreyTreasureBoxMulti lua中的数据结构
---@return bagV2.AwardPreyTreasureBoxMulti C#中的数据结构
function bagV2.AwardPreyTreasureBoxMulti(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.AwardPreyTreasureBoxMulti()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData bagV2.RemoveTimeEnd lua中的数据结构
---@return bagV2.RemoveTimeEnd C#中的数据结构
function bagV2.RemoveTimeEnd(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.RemoveTimeEnd()
    if decodedData.itemIdList ~= nil and decodedData.itemIdListSpecified ~= false then
        for i = 1, #decodedData.itemIdList do
            data.itemIdList:Add(decodedData.itemIdList[i])
        end
    end
    return data
end

---@param decodedData bagV2.ReqGetNextSoulJade lua中的数据结构
---@return bagV2.ReqGetNextSoulJade C#中的数据结构
function bagV2.ReqGetNextSoulJade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqGetNextSoulJade()
    if decodedData.thisId ~= nil and decodedData.thisIdSpecified ~= false then
        data.thisId = decodedData.thisId
    end
    return data
end

---@param decodedData bagV2.ResGetNextSoulJade lua中的数据结构
---@return bagV2.ResGetNextSoulJade C#中的数据结构
function bagV2.ResGetNextSoulJade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResGetNextSoulJade()
    if decodedData.isSuccess ~= nil and decodedData.isSuccessSpecified ~= false then
        data.isSuccess = decodedData.isSuccess
    end
    return data
end

---@param decodedData bagV2.ReqEvolve lua中的数据结构
---@return bagV2.ReqEvolve C#中的数据结构
function bagV2.ReqEvolve(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqEvolve()
    if decodedData.equipId ~= nil and decodedData.equipIdSpecified ~= false then
        data.equipId = decodedData.equipId
    end
    if decodedData.sacrifices ~= nil and decodedData.sacrificesSpecified ~= false then
        for i = 1, #decodedData.sacrifices do
            data.sacrifices:Add(decodedData.sacrifices[i])
        end
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData bagV2.ResEvolve lua中的数据结构
---@return bagV2.ResEvolve C#中的数据结构
function bagV2.ResEvolve(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResEvolve()
    data.equipId = decodedData.equipId
    data.equipInfo = bagV2.BagItemInfo(decodedData.equipInfo)
    return data
end

---@param decodedData bagV2.ResBundlitem lua中的数据结构
---@return bagV2.ResBundlitem C#中的数据结构
function bagV2.ResBundlitem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResBundlitem()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        for i = 1, #decodedData.itemId do
            data.itemId:Add(decodedData.itemId[i])
        end
    end
    return data
end

---@param decodedData bagV2.ReqBuyResBundlitem lua中的数据结构
---@return bagV2.ReqBuyResBundlitem C#中的数据结构
function bagV2.ReqBuyResBundlitem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqBuyResBundlitem()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData bagV2.ResSuccessBuyBindlitem lua中的数据结构
---@return bagV2.ResSuccessBuyBindlitem C#中的数据结构
function bagV2.ResSuccessBuyBindlitem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResSuccessBuyBindlitem()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        for i = 1, #decodedData.lid do
            data.lid:Add(decodedData.lid[i])
        end
    end
    return data
end

---@param decodedData bagV2.ReqBuyMaterialWay lua中的数据结构
---@return bagV2.ReqBuyMaterialWay C#中的数据结构
function bagV2.ReqBuyMaterialWay(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqBuyMaterialWay()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.materialId ~= nil and decodedData.materialIdSpecified ~= false then
        data.materialId = decodedData.materialId
    end
    if decodedData.materialCount ~= nil and decodedData.materialCountSpecified ~= false then
        data.materialCount = decodedData.materialCount
    end
    return data
end

---@param decodedData bagV2.ResBuyMaterialWaySuccess lua中的数据结构
---@return bagV2.ResBuyMaterialWaySuccess C#中的数据结构
function bagV2.ResBuyMaterialWaySuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResBuyMaterialWaySuccess()
    if decodedData.buyId ~= nil and decodedData.buyIdSpecified ~= false then
        data.buyId = decodedData.buyId
    end
    if decodedData.buyCount ~= nil and decodedData.buyCountSpecified ~= false then
        data.buyCount = decodedData.buyCount
    end
    return data
end

---@param decodedData bagV2.ReqDayUseItemCount lua中的数据结构
---@return bagV2.ReqDayUseItemCount C#中的数据结构
function bagV2.ReqDayUseItemCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqDayUseItemCount()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData bagV2.ResDayUseItemCount lua中的数据结构
---@return bagV2.ResDayUseItemCount C#中的数据结构
function bagV2.ResDayUseItemCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResDayUseItemCount()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.useCount ~= nil and decodedData.useCountSpecified ~= false then
        data.useCount = decodedData.useCount
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    return data
end

---@param decodedData bagV2.ReqCanUseGatherSpiritBead lua中的数据结构
---@return bagV2.ReqCanUseGatherSpiritBead C#中的数据结构
function bagV2.ReqCanUseGatherSpiritBead(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqCanUseGatherSpiritBead()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData bagV2.ResCanUseGatherSpiritBead lua中的数据结构
---@return bagV2.ResCanUseGatherSpiritBead C#中的数据结构
function bagV2.ResCanUseGatherSpiritBead(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResCanUseGatherSpiritBead()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.canUse ~= nil and decodedData.canUseSpecified ~= false then
        data.canUse = decodedData.canUse
    end
    return data
end

---@param decodedData bagV2.ItemOutput lua中的数据结构
---@return bagV2.ItemOutput C#中的数据结构
function bagV2.ItemOutput(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ItemOutput()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.number ~= nil and decodedData.numberSpecified ~= false then
        data.number = decodedData.number
    end
    return data
end

---@param decodedData bagV2.UpdateItemOutput lua中的数据结构
---@return bagV2.UpdateItemOutput C#中的数据结构
function bagV2.UpdateItemOutput(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.UpdateItemOutput()
    if decodedData.maxOpenDayOfAll ~= nil and decodedData.maxOpenDayOfAllSpecified ~= false then
        data.maxOpenDayOfAll = decodedData.maxOpenDayOfAll
    end
    if decodedData.itemOutputs ~= nil and decodedData.itemOutputsSpecified ~= false then
        for i = 1, #decodedData.itemOutputs do
            data.itemOutputs:Add(bagV2.ItemOutput(decodedData.itemOutputs[i]))
        end
    end
    return data
end

---@param decodedData bagV2.ReqUseCDKey lua中的数据结构
---@return bagV2.ReqUseCDKey C#中的数据结构
function bagV2.ReqUseCDKey(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqUseCDKey()
    data.cdKey = decodedData.cdKey
    return data
end

---@param decodedData bagV2.ReqUseSpyBrand lua中的数据结构
---@return bagV2.ReqUseSpyBrand C#中的数据结构
function bagV2.ReqUseSpyBrand(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqUseSpyBrand()
    if decodedData.itemLid ~= nil and decodedData.itemLidSpecified ~= false then
        data.itemLid = decodedData.itemLid
    end
    if decodedData.roleLid ~= nil and decodedData.roleLidSpecified ~= false then
        data.roleLid = decodedData.roleLid
    end
    return data
end

---@param decodedData bagV2.ResItemTips lua中的数据结构
---@return bagV2.ResItemTips C#中的数据结构
function bagV2.ResItemTips(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResItemTips()
    if decodedData.tip ~= nil and decodedData.tipSpecified ~= false then
        for i = 1, #decodedData.tip do
            data.tip:Add(bagV2.ItemTip(decodedData.tip[i]))
        end
    end
    return data
end

---@param decodedData bagV2.ItemTip lua中的数据结构
---@return bagV2.ItemTip C#中的数据结构
function bagV2.ItemTip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ItemTip()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.multi ~= nil and decodedData.multiSpecified ~= false then
        data.multi = decodedData.multi
    end
    return data
end

---@param decodedData bagV2.ReqBloodSmelt lua中的数据结构
---@return bagV2.ReqBloodSmelt C#中的数据结构
function bagV2.ReqBloodSmelt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqBloodSmelt()
    data.equipId = decodedData.equipId
    if decodedData.recycleList ~= nil and decodedData.recycleListSpecified ~= false then
        for i = 1, #decodedData.recycleList do
            data.recycleList:Add(decodedData.recycleList[i])
        end
    end
    return data
end

---@param decodedData bagV2.ResBloodSmelt lua中的数据结构
---@return bagV2.ResBloodSmelt C#中的数据结构
function bagV2.ResBloodSmelt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResBloodSmelt()
    data.item = bagV2.BagItemInfo(decodedData.item)
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData bagV2.ReqDivineSmelt lua中的数据结构
---@return bagV2.ReqDivineSmelt C#中的数据结构
function bagV2.ReqDivineSmelt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ReqDivineSmelt()
    data.equipId = decodedData.equipId
    if decodedData.recycleList ~= nil and decodedData.recycleListSpecified ~= false then
        for i = 1, #decodedData.recycleList do
            data.recycleList:Add(decodedData.recycleList[i])
        end
    end
    return data
end

---@param decodedData bagV2.ResDivineSmelt lua中的数据结构
---@return bagV2.ResDivineSmelt C#中的数据结构
function bagV2.ResDivineSmelt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResDivineSmelt()
    data.item = bagV2.BagItemInfo(decodedData.item)
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData bagV2.ResBagSizeByMonthCard lua中的数据结构
---@return bagV2.ResBagSizeByMonthCard C#中的数据结构
function bagV2.ResBagSizeByMonthCard(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResBagSizeByMonthCard()
    if decodedData.emptyGridCount ~= nil and decodedData.emptyGridCountSpecified ~= false then
        data.emptyGridCount = decodedData.emptyGridCount
    end
    if decodedData.maxGridCount ~= nil and decodedData.maxGridCountSpecified ~= false then
        data.maxGridCount = decodedData.maxGridCount
    end
    return data
end

---@param decodedData bagV2.UseMoneyBox lua中的数据结构
---@return bagV2.UseMoneyBox C#中的数据结构
function bagV2.UseMoneyBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.UseMoneyBox()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData bagV2.ResUpdateAutomaticCollect lua中的数据结构
---@return bagV2.ResUpdateAutomaticCollect C#中的数据结构
function bagV2.ResUpdateAutomaticCollect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bagV2.ResUpdateAutomaticCollect()
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

return bagV2