--[[本文件为工具自动生成,禁止手动修改]]
local bagV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable bagV2.BestAttInfo
---@type bagV2.BestAttInfo
bagV2_adj.metatable_BestAttInfo = {
    _ClassName = "bagV2.BestAttInfo",
}
bagV2_adj.metatable_BestAttInfo.__index = bagV2_adj.metatable_BestAttInfo
--endregion

---@param tbl bagV2.BestAttInfo 待调整的table数据
function bagV2_adj.AdjustBestAttInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_BestAttInfo)
    if tbl.attValue == nil then
        tbl.attValueSpecified = false
        tbl.attValue = 0
    else
        tbl.attValueSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
end

--region metatable bagV2.LingBaoInfo
---@type bagV2.LingBaoInfo
bagV2_adj.metatable_LingBaoInfo = {
    _ClassName = "bagV2.LingBaoInfo",
}
bagV2_adj.metatable_LingBaoInfo.__index = bagV2_adj.metatable_LingBaoInfo
--endregion

---@param tbl bagV2.LingBaoInfo 待调整的table数据
function bagV2_adj.AdjustLingBaoInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_LingBaoInfo)
    if tbl.nowExp == nil then
        tbl.nowExpSpecified = false
        tbl.nowExp = 0
    else
        tbl.nowExpSpecified = true
    end
    if tbl.totalExp == nil then
        tbl.totalExpSpecified = false
        tbl.totalExp = 0
    else
        tbl.totalExpSpecified = true
    end
    if tbl.refineLv == nil then
        tbl.refineLvSpecified = false
        tbl.refineLv = 0
    else
        tbl.refineLvSpecified = true
    end
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
end

--region metatable bagV2.JiPinInfo
---@type bagV2.JiPinInfo
bagV2_adj.metatable_JiPinInfo = {
    _ClassName = "bagV2.JiPinInfo",
}
bagV2_adj.metatable_JiPinInfo.__index = bagV2_adj.metatable_JiPinInfo
--endregion

---@param tbl bagV2.JiPinInfo 待调整的table数据
function bagV2_adj.AdjustJiPinInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_JiPinInfo)
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
    if tbl.attributeType == nil then
        tbl.attributeType = {}
    end
    if tbl.attributeValue == nil then
        tbl.attributeValue = {}
    end
end

--region metatable bagV2.FromInfo
---@type bagV2.FromInfo
bagV2_adj.metatable_FromInfo = {
    _ClassName = "bagV2.FromInfo",
}
bagV2_adj.metatable_FromInfo.__index = bagV2_adj.metatable_FromInfo
--endregion

---@param tbl bagV2.FromInfo 待调整的table数据
function bagV2_adj.AdjustFromInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_FromInfo)
    if tbl.params == nil then
        tbl.params = {}
    end
end

--region metatable bagV2.BagItemInfo
---@type bagV2.BagItemInfo
bagV2_adj.metatable_BagItemInfo = {
    _ClassName = "bagV2.BagItemInfo",
}
bagV2_adj.metatable_BagItemInfo.__index = bagV2_adj.metatable_BagItemInfo
--endregion

---@param tbl bagV2.BagItemInfo 待调整的table数据
function bagV2_adj.AdjustBagItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_BagItemInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.bind == nil then
        tbl.bindSpecified = false
        tbl.bind = 0
    else
        tbl.bindSpecified = true
    end
    if tbl.attribute == nil then
        tbl.attribute = {}
    else
        if bagV2_adj.AdjustItemAttribute ~= nil then
            for i = 1, #tbl.attribute do
                bagV2_adj.AdjustItemAttribute(tbl.attribute[i])
            end
        end
    end
    if tbl.fromInfo == nil then
        tbl.fromInfoSpecified = false
        tbl.fromInfo = nil
    else
        if tbl.fromInfoSpecified == nil then 
            tbl.fromInfoSpecified = true
            if bagV2_adj.AdjustFromInfo ~= nil then
                bagV2_adj.AdjustFromInfo(tbl.fromInfo)
            end
        end
    end
    if tbl.intensify == nil then
        tbl.intensifySpecified = false
        tbl.intensify = 0
    else
        tbl.intensifySpecified = true
    end
    if tbl.maxStar == nil then
        tbl.maxStarSpecified = false
        tbl.maxStar = 0
    else
        tbl.maxStarSpecified = true
    end
    if tbl.zhuling == nil then
        tbl.zhulingSpecified = false
        tbl.zhuling = 0
    else
        tbl.zhulingSpecified = true
    end
    if tbl.luck == nil then
        tbl.luckSpecified = false
        tbl.luck = 0
    else
        tbl.luckSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.currentLasting == nil then
        tbl.currentLastingSpecified = false
        tbl.currentLasting = 0
    else
        tbl.currentLastingSpecified = true
    end
    if tbl.curse == nil then
        tbl.curseSpecified = false
        tbl.curse = 0
    else
        tbl.curseSpecified = true
    end
    if tbl.rateAttribute == nil then
        tbl.rateAttribute = {}
    else
        if bagV2_adj.AdjustItemAttribute ~= nil then
            for i = 1, #tbl.rateAttribute do
                bagV2_adj.AdjustItemAttribute(tbl.rateAttribute[i])
            end
        end
    end
    if tbl.imprint == nil then
        tbl.imprintSpecified = false
        tbl.imprint = 0
    else
        tbl.imprintSpecified = true
    end
    if tbl.isWastageLasting == nil then
        tbl.isWastageLastingSpecified = false
        tbl.isWastageLasting = 0
    else
        tbl.isWastageLastingSpecified = true
    end
    if tbl.leftUseNum == nil then
        tbl.leftUseNumSpecified = false
        tbl.leftUseNum = 0
    else
        tbl.leftUseNumSpecified = true
    end
    if tbl.bagIndex == nil then
        tbl.bagIndexSpecified = false
        tbl.bagIndex = 0
    else
        tbl.bagIndexSpecified = true
    end
    if tbl.inlayInfoList == nil then
        tbl.inlayInfoList = {}
    else
        if bagV2_adj.AdjustinlayInfo ~= nil then
            for i = 1, #tbl.inlayInfoList do
                bagV2_adj.AdjustinlayInfo(tbl.inlayInfoList[i])
            end
        end
    end
    if tbl.tradeState == nil then
        tbl.tradeStateSpecified = false
        tbl.tradeState = 0
    else
        tbl.tradeStateSpecified = true
    end
    if tbl.canTrade == nil then
        tbl.canTradeSpecified = false
        tbl.canTrade = 0
    else
        tbl.canTradeSpecified = true
    end
    if tbl.redBagMoney == nil then
        tbl.redBagMoneySpecified = false
        tbl.redBagMoney = 0
    else
        tbl.redBagMoneySpecified = true
    end
    if tbl.rateAttribute1 == nil then
        tbl.rateAttribute1 = {}
    else
        if bagV2_adj.AdjustItemAttribute ~= nil then
            for i = 1, #tbl.rateAttribute1 do
                bagV2_adj.AdjustItemAttribute(tbl.rateAttribute1[i])
            end
        end
    end
    if tbl.rateAttribute2 == nil then
        tbl.rateAttribute2 = {}
    else
        if bagV2_adj.AdjustItemAttribute ~= nil then
            for i = 1, #tbl.rateAttribute2 do
                bagV2_adj.AdjustItemAttribute(tbl.rateAttribute2[i])
            end
        end
    end
    if tbl.bloodLevel == nil then
        tbl.bloodLevelSpecified = false
        tbl.bloodLevel = 0
    else
        tbl.bloodLevelSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.limitedType == nil then
        tbl.limitedTypeSpecified = false
        tbl.limitedType = 0
    else
        tbl.limitedTypeSpecified = true
    end
    if tbl.limitedTime == nil then
        tbl.limitedTimeSpecified = false
        tbl.limitedTime = 0
    else
        tbl.limitedTimeSpecified = true
    end
    if tbl.soulEffect == nil then
        tbl.soulEffectSpecified = false
        tbl.soulEffect = 0
    else
        tbl.soulEffectSpecified = true
    end
    if tbl.appraisalQuality == nil then
        tbl.appraisalQualitySpecified = false
        tbl.appraisalQuality = 0
    else
        tbl.appraisalQualitySpecified = true
    end
    if tbl.appraisalAttr == nil then
        tbl.appraisalAttrSpecified = false
        tbl.appraisalAttr = 0
    else
        tbl.appraisalAttrSpecified = true
    end
    if tbl.isInsured == nil then
        tbl.isInsuredSpecified = false
        tbl.isInsured = 0
    else
        tbl.isInsuredSpecified = true
    end
    if tbl.growthLevel == nil then
        tbl.growthLevelSpecified = false
        tbl.growthLevel = 0
    else
        tbl.growthLevelSpecified = true
    end
    if tbl.killMonsterCount == nil then
        tbl.killMonsterCountSpecified = false
        tbl.killMonsterCount = 0
    else
        tbl.killMonsterCountSpecified = true
    end
end

--region metatable bagV2.inlayInfo
---@type bagV2.inlayInfo
bagV2_adj.metatable_inlayInfo = {
    _ClassName = "bagV2.inlayInfo",
}
bagV2_adj.metatable_inlayInfo.__index = bagV2_adj.metatable_inlayInfo
--endregion

---@param tbl bagV2.inlayInfo 待调整的table数据
function bagV2_adj.AdjustinlayInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_inlayInfo)
    if tbl.pos == nil then
        tbl.posSpecified = false
        tbl.pos = 0
    else
        tbl.posSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.currentLasting == nil then
        tbl.currentLastingSpecified = false
        tbl.currentLasting = 0
    else
        tbl.currentLastingSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable bagV2.ExtraEquip
---@type bagV2.ExtraEquip
bagV2_adj.metatable_ExtraEquip = {
    _ClassName = "bagV2.ExtraEquip",
}
bagV2_adj.metatable_ExtraEquip.__index = bagV2_adj.metatable_ExtraEquip
--endregion

---@param tbl bagV2.ExtraEquip 待调整的table数据
function bagV2_adj.AdjustExtraEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ExtraEquip)
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
end

--region metatable bagV2.ItemAttribute
---@type bagV2.ItemAttribute
bagV2_adj.metatable_ItemAttribute = {
    _ClassName = "bagV2.ItemAttribute",
}
bagV2_adj.metatable_ItemAttribute.__index = bagV2_adj.metatable_ItemAttribute
--endregion

---@param tbl bagV2.ItemAttribute 待调整的table数据
function bagV2_adj.AdjustItemAttribute(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ItemAttribute)
end

--region metatable bagV2.InstanceItemInfo
---@type bagV2.InstanceItemInfo
bagV2_adj.metatable_InstanceItemInfo = {
    _ClassName = "bagV2.InstanceItemInfo",
}
bagV2_adj.metatable_InstanceItemInfo.__index = bagV2_adj.metatable_InstanceItemInfo
--endregion

---@param tbl bagV2.InstanceItemInfo 待调整的table数据
function bagV2_adj.AdjustInstanceItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_InstanceItemInfo)
    if tbl.globalId == nil then
        tbl.globalIdSpecified = false
        tbl.globalId = 0
    else
        tbl.globalIdSpecified = true
    end
    if tbl.useNum == nil then
        tbl.useNumSpecified = false
        tbl.useNum = 0
    else
        tbl.useNumSpecified = true
    end
end

--region metatable bagV2.CoinInfo
---@type bagV2.CoinInfo
bagV2_adj.metatable_CoinInfo = {
    _ClassName = "bagV2.CoinInfo",
}
bagV2_adj.metatable_CoinInfo.__index = bagV2_adj.metatable_CoinInfo
--endregion

---@param tbl bagV2.CoinInfo 待调整的table数据
function bagV2_adj.AdjustCoinInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_CoinInfo)
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

--region metatable bagV2.ResBagInfo
---@type bagV2.ResBagInfo
bagV2_adj.metatable_ResBagInfo = {
    _ClassName = "bagV2.ResBagInfo",
}
bagV2_adj.metatable_ResBagInfo.__index = bagV2_adj.metatable_ResBagInfo
--endregion

---@param tbl bagV2.ResBagInfo 待调整的table数据
function bagV2_adj.AdjustResBagInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResBagInfo)
    if tbl.emptyGridCount == nil then
        tbl.emptyGridCountSpecified = false
        tbl.emptyGridCount = 0
    else
        tbl.emptyGridCountSpecified = true
    end
    if tbl.maxGridCount == nil then
        tbl.maxGridCountSpecified = false
        tbl.maxGridCount = 0
    else
        tbl.maxGridCountSpecified = true
    end
    if tbl.addGridCount == nil then
        tbl.addGridCountSpecified = false
        tbl.addGridCount = 0
    else
        tbl.addGridCountSpecified = true
    end
    if tbl.itemList == nil then
        tbl.itemList = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemList do
                bagV2_adj.AdjustBagItemInfo(tbl.itemList[i])
            end
        end
    end
    if tbl.coinList == nil then
        tbl.coinList = {}
    else
        if bagV2_adj.AdjustCoinInfo ~= nil then
            for i = 1, #tbl.coinList do
                bagV2_adj.AdjustCoinInfo(tbl.coinList[i])
            end
        end
    end
    if tbl.recycleData == nil then
        tbl.recycleData = {}
    end
    if tbl.extraEquip == nil then
        tbl.extraEquip = {}
    else
        if bagV2_adj.AdjustExtraEquip ~= nil then
            for i = 1, #tbl.extraEquip do
                bagV2_adj.AdjustExtraEquip(tbl.extraEquip[i])
            end
        end
    end
end

--region metatable bagV2.ResBagChange
---@type bagV2.ResBagChange
bagV2_adj.metatable_ResBagChange = {
    _ClassName = "bagV2.ResBagChange",
}
bagV2_adj.metatable_ResBagChange.__index = bagV2_adj.metatable_ResBagChange
--endregion

---@param tbl bagV2.ResBagChange 待调整的table数据
function bagV2_adj.AdjustResBagChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResBagChange)
    if tbl.action == nil then
        tbl.actionSpecified = false
        tbl.action = 0
    else
        tbl.actionSpecified = true
    end
    if tbl.itemList == nil then
        tbl.itemList = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemList do
                bagV2_adj.AdjustBagItemInfo(tbl.itemList[i])
            end
        end
    end
    if tbl.coinList == nil then
        tbl.coinList = {}
    else
        if bagV2_adj.AdjustCoinInfo ~= nil then
            for i = 1, #tbl.coinList do
                bagV2_adj.AdjustCoinInfo(tbl.coinList[i])
            end
        end
    end
    if tbl.removedIdList == nil then
        tbl.removedIdList = {}
    end
    if tbl.removeItemList == nil then
        tbl.removeItemList = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.removeItemList do
                bagV2_adj.AdjustBagItemInfo(tbl.removeItemList[i])
            end
        end
    end
end

--region metatable bagV2.UseItemRequest
---@type bagV2.UseItemRequest
bagV2_adj.metatable_UseItemRequest = {
    _ClassName = "bagV2.UseItemRequest",
}
bagV2_adj.metatable_UseItemRequest.__index = bagV2_adj.metatable_UseItemRequest
--endregion

---@param tbl bagV2.UseItemRequest 待调整的table数据
function bagV2_adj.AdjustUseItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_UseItemRequest)
    if tbl.clientParam == nil then
        tbl.clientParamSpecified = false
        tbl.clientParam = 0
    else
        tbl.clientParamSpecified = true
    end
    if tbl.clientParams == nil then
        tbl.clientParams = {}
    end
    if tbl.clientParamStrs == nil then
        tbl.clientParamStrs = {}
    end
end

--region metatable bagV2.ResUseItem
---@type bagV2.ResUseItem
bagV2_adj.metatable_ResUseItem = {
    _ClassName = "bagV2.ResUseItem",
}
bagV2_adj.metatable_ResUseItem.__index = bagV2_adj.metatable_ResUseItem
--endregion

---@param tbl bagV2.ResUseItem 待调整的table数据
function bagV2_adj.AdjustResUseItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResUseItem)
    if tbl.cdTime == nil then
        tbl.cdTimeSpecified = false
        tbl.cdTime = 0
    else
        tbl.cdTimeSpecified = true
    end
end

--region metatable bagV2.RecycleEquipmentRequest
---@type bagV2.RecycleEquipmentRequest
bagV2_adj.metatable_RecycleEquipmentRequest = {
    _ClassName = "bagV2.RecycleEquipmentRequest",
}
bagV2_adj.metatable_RecycleEquipmentRequest.__index = bagV2_adj.metatable_RecycleEquipmentRequest
--endregion

---@param tbl bagV2.RecycleEquipmentRequest 待调整的table数据
function bagV2_adj.AdjustRecycleEquipmentRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_RecycleEquipmentRequest)
    if tbl.recycleList == nil then
        tbl.recycleList = {}
    end
    if tbl.intensifyLv == nil then
        tbl.intensifyLvSpecified = false
        tbl.intensifyLv = 0
    else
        tbl.intensifyLvSpecified = true
    end
    if tbl.recycleData == nil then
        tbl.recycleData = {}
    end
end

--region metatable bagV2.RecycleSuccess
---@type bagV2.RecycleSuccess
bagV2_adj.metatable_RecycleSuccess = {
    _ClassName = "bagV2.RecycleSuccess",
}
bagV2_adj.metatable_RecycleSuccess.__index = bagV2_adj.metatable_RecycleSuccess
--endregion

---@param tbl bagV2.RecycleSuccess 待调整的table数据
function bagV2_adj.AdjustRecycleSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_RecycleSuccess)
    if tbl.idList == nil then
        tbl.idList = {}
    end
end

--region metatable bagV2.ResSmelt
---@type bagV2.ResSmelt
bagV2_adj.metatable_ResSmelt = {
    _ClassName = "bagV2.ResSmelt",
}
bagV2_adj.metatable_ResSmelt.__index = bagV2_adj.metatable_ResSmelt
--endregion

---@param tbl bagV2.ResSmelt 待调整的table数据
function bagV2_adj.AdjustResSmelt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResSmelt)
    if tbl.idList == nil then
        tbl.idList = {}
    end
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if bagV2_adj.AdjustItemOutput ~= nil then
            for i = 1, #tbl.rewards do
                bagV2_adj.AdjustItemOutput(tbl.rewards[i])
            end
        end
    end
end

--region metatable bagV2.ResAddGridCountChange
---@type bagV2.ResAddGridCountChange
bagV2_adj.metatable_ResAddGridCountChange = {
    _ClassName = "bagV2.ResAddGridCountChange",
}
bagV2_adj.metatable_ResAddGridCountChange.__index = bagV2_adj.metatable_ResAddGridCountChange
--endregion

---@param tbl bagV2.ResAddGridCountChange 待调整的table数据
function bagV2_adj.AdjustResAddGridCountChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResAddGridCountChange)
    if tbl.addGridCount == nil then
        tbl.addGridCountSpecified = false
        tbl.addGridCount = 0
    else
        tbl.addGridCountSpecified = true
    end
    if tbl.emptyGridCount == nil then
        tbl.emptyGridCountSpecified = false
        tbl.emptyGridCount = 0
    else
        tbl.emptyGridCountSpecified = true
    end
    if tbl.maxGridCount == nil then
        tbl.maxGridCountSpecified = false
        tbl.maxGridCount = 0
    else
        tbl.maxGridCountSpecified = true
    end
end

--region metatable bagV2.ResUseAttackDrag
---@type bagV2.ResUseAttackDrag
bagV2_adj.metatable_ResUseAttackDrag = {
    _ClassName = "bagV2.ResUseAttackDrag",
}
bagV2_adj.metatable_ResUseAttackDrag.__index = bagV2_adj.metatable_ResUseAttackDrag
--endregion

---@param tbl bagV2.ResUseAttackDrag 待调整的table数据
function bagV2_adj.AdjustResUseAttackDrag(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResUseAttackDrag)
    if tbl.rate == nil then
        tbl.rateSpecified = false
        tbl.rate = 0
    else
        tbl.rateSpecified = true
    end
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
    if tbl.useCount == nil then
        tbl.useCountSpecified = false
        tbl.useCount = 0
    else
        tbl.useCountSpecified = true
    end
end

--region metatable bagV2.UseInstanceItemRequest
---@type bagV2.UseInstanceItemRequest
bagV2_adj.metatable_UseInstanceItemRequest = {
    _ClassName = "bagV2.UseInstanceItemRequest",
}
bagV2_adj.metatable_UseInstanceItemRequest.__index = bagV2_adj.metatable_UseInstanceItemRequest
--endregion

---@param tbl bagV2.UseInstanceItemRequest 待调整的table数据
function bagV2_adj.AdjustUseInstanceItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_UseInstanceItemRequest)
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
    if tbl.globalId == nil then
        tbl.globalIdSpecified = false
        tbl.globalId = 0
    else
        tbl.globalIdSpecified = true
    end
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
    if tbl.useTime == nil then
        tbl.useTimeSpecified = false
        tbl.useTime = 0
    else
        tbl.useTimeSpecified = true
    end
end

--region metatable bagV2.ResGetAttackDragBuyCount
---@type bagV2.ResGetAttackDragBuyCount
bagV2_adj.metatable_ResGetAttackDragBuyCount = {
    _ClassName = "bagV2.ResGetAttackDragBuyCount",
}
bagV2_adj.metatable_ResGetAttackDragBuyCount.__index = bagV2_adj.metatable_ResGetAttackDragBuyCount
--endregion

---@param tbl bagV2.ResGetAttackDragBuyCount 待调整的table数据
function bagV2_adj.AdjustResGetAttackDragBuyCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResGetAttackDragBuyCount)
    if tbl.useInfo == nil then
        tbl.useInfo = {}
    else
        if bagV2_adj.AdjustInstanceItemInfo ~= nil then
            for i = 1, #tbl.useInfo do
                bagV2_adj.AdjustInstanceItemInfo(tbl.useInfo[i])
            end
        end
    end
end

--region metatable bagV2.VipRecycleEquipmentRequest
---@type bagV2.VipRecycleEquipmentRequest
bagV2_adj.metatable_VipRecycleEquipmentRequest = {
    _ClassName = "bagV2.VipRecycleEquipmentRequest",
}
bagV2_adj.metatable_VipRecycleEquipmentRequest.__index = bagV2_adj.metatable_VipRecycleEquipmentRequest
--endregion

---@param tbl bagV2.VipRecycleEquipmentRequest 待调整的table数据
function bagV2_adj.AdjustVipRecycleEquipmentRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_VipRecycleEquipmentRequest)
    if tbl.recycleList == nil then
        tbl.recycleList = {}
    end
end

--region metatable bagV2.DeleteSpecialItemRequest
---@type bagV2.DeleteSpecialItemRequest
bagV2_adj.metatable_DeleteSpecialItemRequest = {
    _ClassName = "bagV2.DeleteSpecialItemRequest",
}
bagV2_adj.metatable_DeleteSpecialItemRequest.__index = bagV2_adj.metatable_DeleteSpecialItemRequest
--endregion

---@param tbl bagV2.DeleteSpecialItemRequest 待调整的table数据
function bagV2_adj.AdjustDeleteSpecialItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_DeleteSpecialItemRequest)
end

--region metatable bagV2.ResRechargeBoxInfo
---@type bagV2.ResRechargeBoxInfo
bagV2_adj.metatable_ResRechargeBoxInfo = {
    _ClassName = "bagV2.ResRechargeBoxInfo",
}
bagV2_adj.metatable_ResRechargeBoxInfo.__index = bagV2_adj.metatable_ResRechargeBoxInfo
--endregion

---@param tbl bagV2.ResRechargeBoxInfo 待调整的table数据
function bagV2_adj.AdjustResRechargeBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResRechargeBoxInfo)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable bagV2.SellActivityItemRequest
---@type bagV2.SellActivityItemRequest
bagV2_adj.metatable_SellActivityItemRequest = {
    _ClassName = "bagV2.SellActivityItemRequest",
}
bagV2_adj.metatable_SellActivityItemRequest.__index = bagV2_adj.metatable_SellActivityItemRequest
--endregion

---@param tbl bagV2.SellActivityItemRequest 待调整的table数据
function bagV2_adj.AdjustSellActivityItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_SellActivityItemRequest)
end

--region metatable bagV2.StartZhuanPanRequest
---@type bagV2.StartZhuanPanRequest
bagV2_adj.metatable_StartZhuanPanRequest = {
    _ClassName = "bagV2.StartZhuanPanRequest",
}
bagV2_adj.metatable_StartZhuanPanRequest.__index = bagV2_adj.metatable_StartZhuanPanRequest
--endregion

---@param tbl bagV2.StartZhuanPanRequest 待调整的table数据
function bagV2_adj.AdjustStartZhuanPanRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_StartZhuanPanRequest)
end

--region metatable bagV2.ResZhuanPanResult
---@type bagV2.ResZhuanPanResult
bagV2_adj.metatable_ResZhuanPanResult = {
    _ClassName = "bagV2.ResZhuanPanResult",
}
bagV2_adj.metatable_ResZhuanPanResult.__index = bagV2_adj.metatable_ResZhuanPanResult
--endregion

---@param tbl bagV2.ResZhuanPanResult 待调整的table数据
function bagV2_adj.AdjustResZhuanPanResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResZhuanPanResult)
end

--region metatable bagV2.ResSpecialItemActivate
---@type bagV2.ResSpecialItemActivate
bagV2_adj.metatable_ResSpecialItemActivate = {
    _ClassName = "bagV2.ResSpecialItemActivate",
}
bagV2_adj.metatable_ResSpecialItemActivate.__index = bagV2_adj.metatable_ResSpecialItemActivate
--endregion

---@param tbl bagV2.ResSpecialItemActivate 待调整的table数据
function bagV2_adj.AdjustResSpecialItemActivate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResSpecialItemActivate)
    if tbl.itemIdList == nil then
        tbl.itemIdList = {}
    end
end

--region metatable bagV2.ResStorageInfo
---@type bagV2.ResStorageInfo
bagV2_adj.metatable_ResStorageInfo = {
    _ClassName = "bagV2.ResStorageInfo",
}
bagV2_adj.metatable_ResStorageInfo.__index = bagV2_adj.metatable_ResStorageInfo
--endregion

---@param tbl bagV2.ResStorageInfo 待调整的table数据
function bagV2_adj.AdjustResStorageInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResStorageInfo)
    if tbl.emptyGridCount == nil then
        tbl.emptyGridCountSpecified = false
        tbl.emptyGridCount = 0
    else
        tbl.emptyGridCountSpecified = true
    end
    if tbl.maxGridCount == nil then
        tbl.maxGridCountSpecified = false
        tbl.maxGridCount = 0
    else
        tbl.maxGridCountSpecified = true
    end
    if tbl.itemList == nil then
        tbl.itemList = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemList do
                bagV2_adj.AdjustBagItemInfo(tbl.itemList[i])
            end
        end
    end
end

--region metatable bagV2.ResStorageUpdate
---@type bagV2.ResStorageUpdate
bagV2_adj.metatable_ResStorageUpdate = {
    _ClassName = "bagV2.ResStorageUpdate",
}
bagV2_adj.metatable_ResStorageUpdate.__index = bagV2_adj.metatable_ResStorageUpdate
--endregion

---@param tbl bagV2.ResStorageUpdate 待调整的table数据
function bagV2_adj.AdjustResStorageUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResStorageUpdate)
    if tbl.item == nil then
        tbl.itemSpecified = false
        tbl.item = nil
    else
        if tbl.itemSpecified == nil then 
            tbl.itemSpecified = true
            if bagV2_adj.AdjustBagItemInfo ~= nil then
                bagV2_adj.AdjustBagItemInfo(tbl.item)
            end
        end
    end
    if tbl.operate == nil then
        tbl.operateSpecified = false
        tbl.operate = 0
    else
        tbl.operateSpecified = true
    end
end

--region metatable bagV2.StorageOutItemRequest
---@type bagV2.StorageOutItemRequest
bagV2_adj.metatable_StorageOutItemRequest = {
    _ClassName = "bagV2.StorageOutItemRequest",
}
bagV2_adj.metatable_StorageOutItemRequest.__index = bagV2_adj.metatable_StorageOutItemRequest
--endregion

---@param tbl bagV2.StorageOutItemRequest 待调整的table数据
function bagV2_adj.AdjustStorageOutItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_StorageOutItemRequest)
end

--region metatable bagV2.StorageInItemRequest
---@type bagV2.StorageInItemRequest
bagV2_adj.metatable_StorageInItemRequest = {
    _ClassName = "bagV2.StorageInItemRequest",
}
bagV2_adj.metatable_StorageInItemRequest.__index = bagV2_adj.metatable_StorageInItemRequest
--endregion

---@param tbl bagV2.StorageInItemRequest 待调整的table数据
function bagV2_adj.AdjustStorageInItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_StorageInItemRequest)
end

--region metatable bagV2.ResAddStorageMaxCount
---@type bagV2.ResAddStorageMaxCount
bagV2_adj.metatable_ResAddStorageMaxCount = {
    _ClassName = "bagV2.ResAddStorageMaxCount",
}
bagV2_adj.metatable_ResAddStorageMaxCount.__index = bagV2_adj.metatable_ResAddStorageMaxCount
--endregion

---@param tbl bagV2.ResAddStorageMaxCount 待调整的table数据
function bagV2_adj.AdjustResAddStorageMaxCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResAddStorageMaxCount)
end

--region metatable bagV2.AddTradeItemRequest
---@type bagV2.AddTradeItemRequest
bagV2_adj.metatable_AddTradeItemRequest = {
    _ClassName = "bagV2.AddTradeItemRequest",
}
bagV2_adj.metatable_AddTradeItemRequest.__index = bagV2_adj.metatable_AddTradeItemRequest
--endregion

---@param tbl bagV2.AddTradeItemRequest 待调整的table数据
function bagV2_adj.AdjustAddTradeItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_AddTradeItemRequest)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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

--region metatable bagV2.ResTradeItemChange
---@type bagV2.ResTradeItemChange
bagV2_adj.metatable_ResTradeItemChange = {
    _ClassName = "bagV2.ResTradeItemChange",
}
bagV2_adj.metatable_ResTradeItemChange.__index = bagV2_adj.metatable_ResTradeItemChange
--endregion

---@param tbl bagV2.ResTradeItemChange 待调整的table数据
function bagV2_adj.AdjustResTradeItemChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResTradeItemChange)
    if tbl.itemList == nil then
        tbl.itemList = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemList do
                bagV2_adj.AdjustBagItemInfo(tbl.itemList[i])
            end
        end
    end
    if tbl.coinList == nil then
        tbl.coinList = {}
    else
        if bagV2_adj.AdjustCoinInfo ~= nil then
            for i = 1, #tbl.coinList do
                bagV2_adj.AdjustCoinInfo(tbl.coinList[i])
            end
        end
    end
end

--region metatable bagV2.DiscardItemRequest
---@type bagV2.DiscardItemRequest
bagV2_adj.metatable_DiscardItemRequest = {
    _ClassName = "bagV2.DiscardItemRequest",
}
bagV2_adj.metatable_DiscardItemRequest.__index = bagV2_adj.metatable_DiscardItemRequest
--endregion

---@param tbl bagV2.DiscardItemRequest 待调整的table数据
function bagV2_adj.AdjustDiscardItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_DiscardItemRequest)
end

--region metatable bagV2.ResRecoveryDrug
---@type bagV2.ResRecoveryDrug
bagV2_adj.metatable_ResRecoveryDrug = {
    _ClassName = "bagV2.ResRecoveryDrug",
}
bagV2_adj.metatable_ResRecoveryDrug.__index = bagV2_adj.metatable_ResRecoveryDrug
--endregion

---@param tbl bagV2.ResRecoveryDrug 待调整的table数据
function bagV2_adj.AdjustResRecoveryDrug(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResRecoveryDrug)
    if tbl.cdTime == nil then
        tbl.cdTimeSpecified = false
        tbl.cdTime = 0
    else
        tbl.cdTimeSpecified = true
    end
end

--region metatable bagV2.ItemApart
---@type bagV2.ItemApart
bagV2_adj.metatable_ItemApart = {
    _ClassName = "bagV2.ItemApart",
}
bagV2_adj.metatable_ItemApart.__index = bagV2_adj.metatable_ItemApart
--endregion

---@param tbl bagV2.ItemApart 待调整的table数据
function bagV2_adj.AdjustItemApart(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ItemApart)
end

--region metatable bagV2.ReqIntensify
---@type bagV2.ReqIntensify
bagV2_adj.metatable_ReqIntensify = {
    _ClassName = "bagV2.ReqIntensify",
}
bagV2_adj.metatable_ReqIntensify.__index = bagV2_adj.metatable_ReqIntensify
--endregion

---@param tbl bagV2.ReqIntensify 待调整的table数据
function bagV2_adj.AdjustReqIntensify(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqIntensify)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable bagV2.ReqIntensifyTrans
---@type bagV2.ReqIntensifyTrans
bagV2_adj.metatable_ReqIntensifyTrans = {
    _ClassName = "bagV2.ReqIntensifyTrans",
}
bagV2_adj.metatable_ReqIntensifyTrans.__index = bagV2_adj.metatable_ReqIntensifyTrans
--endregion

---@param tbl bagV2.ReqIntensifyTrans 待调整的table数据
function bagV2_adj.AdjustReqIntensifyTrans(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqIntensifyTrans)
end

--region metatable bagV2.ResIntensify
---@type bagV2.ResIntensify
bagV2_adj.metatable_ResIntensify = {
    _ClassName = "bagV2.ResIntensify",
}
bagV2_adj.metatable_ResIntensify.__index = bagV2_adj.metatable_ResIntensify
--endregion

---@param tbl bagV2.ResIntensify 待调整的table数据
function bagV2_adj.AdjustResIntensify(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResIntensify)
end

--region metatable bagV2.Destruction
---@type bagV2.Destruction
bagV2_adj.metatable_Destruction = {
    _ClassName = "bagV2.Destruction",
}
bagV2_adj.metatable_Destruction.__index = bagV2_adj.metatable_Destruction
--endregion

---@param tbl bagV2.Destruction 待调整的table数据
function bagV2_adj.AdjustDestruction(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_Destruction)
end

--region metatable bagV2.GemUpgrade
---@type bagV2.GemUpgrade
bagV2_adj.metatable_GemUpgrade = {
    _ClassName = "bagV2.GemUpgrade",
}
bagV2_adj.metatable_GemUpgrade.__index = bagV2_adj.metatable_GemUpgrade
--endregion

---@param tbl bagV2.GemUpgrade 待调整的table数据
function bagV2_adj.AdjustGemUpgrade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_GemUpgrade)
end

--region metatable bagV2.GemUpgradeRes
---@type bagV2.GemUpgradeRes
bagV2_adj.metatable_GemUpgradeRes = {
    _ClassName = "bagV2.GemUpgradeRes",
}
bagV2_adj.metatable_GemUpgradeRes.__index = bagV2_adj.metatable_GemUpgradeRes
--endregion

---@param tbl bagV2.GemUpgradeRes 待调整的table数据
function bagV2_adj.AdjustGemUpgradeRes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_GemUpgradeRes)
end

--region metatable bagV2.LastingUpdate
---@type bagV2.LastingUpdate
bagV2_adj.metatable_LastingUpdate = {
    _ClassName = "bagV2.LastingUpdate",
}
bagV2_adj.metatable_LastingUpdate.__index = bagV2_adj.metatable_LastingUpdate
--endregion

---@param tbl bagV2.LastingUpdate 待调整的table数据
function bagV2_adj.AdjustLastingUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_LastingUpdate)
    if tbl.itemId == nil then
        tbl.itemId = {}
    end
end

--region metatable bagV2.UseAllExpBox
---@type bagV2.UseAllExpBox
bagV2_adj.metatable_UseAllExpBox = {
    _ClassName = "bagV2.UseAllExpBox",
}
bagV2_adj.metatable_UseAllExpBox.__index = bagV2_adj.metatable_UseAllExpBox
--endregion

---@param tbl bagV2.UseAllExpBox 待调整的table数据
function bagV2_adj.AdjustUseAllExpBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_UseAllExpBox)
    if tbl.useSpiritPoint == nil then
        tbl.useSpiritPointSpecified = false
        tbl.useSpiritPoint = 0
    else
        tbl.useSpiritPointSpecified = true
    end
end

--region metatable bagV2.UseExpBox
---@type bagV2.UseExpBox
bagV2_adj.metatable_UseExpBox = {
    _ClassName = "bagV2.UseExpBox",
}
bagV2_adj.metatable_UseExpBox.__index = bagV2_adj.metatable_UseExpBox
--endregion

---@param tbl bagV2.UseExpBox 待调整的table数据
function bagV2_adj.AdjustUseExpBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_UseExpBox)
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
    if tbl.useSpiritPoint == nil then
        tbl.useSpiritPointSpecified = false
        tbl.useSpiritPoint = 0
    else
        tbl.useSpiritPointSpecified = true
    end
end

--region metatable bagV2.TidyItem
---@type bagV2.TidyItem
bagV2_adj.metatable_TidyItem = {
    _ClassName = "bagV2.TidyItem",
}
bagV2_adj.metatable_TidyItem.__index = bagV2_adj.metatable_TidyItem
--endregion

---@param tbl bagV2.TidyItem 待调整的table数据
function bagV2_adj.AdjustTidyItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_TidyItem)
    if tbl.itemId == nil then
        tbl.itemId = {}
    end
end

--region metatable bagV2.LampUpgrade
---@type bagV2.LampUpgrade
bagV2_adj.metatable_LampUpgrade = {
    _ClassName = "bagV2.LampUpgrade",
}
bagV2_adj.metatable_LampUpgrade.__index = bagV2_adj.metatable_LampUpgrade
--endregion

---@param tbl bagV2.LampUpgrade 待调整的table数据
function bagV2_adj.AdjustLampUpgrade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_LampUpgrade)
end

--region metatable bagV2.LampUpgradeRes
---@type bagV2.LampUpgradeRes
bagV2_adj.metatable_LampUpgradeRes = {
    _ClassName = "bagV2.LampUpgradeRes",
}
bagV2_adj.metatable_LampUpgradeRes.__index = bagV2_adj.metatable_LampUpgradeRes
--endregion

---@param tbl bagV2.LampUpgradeRes 待调整的table数据
function bagV2_adj.AdjustLampUpgradeRes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_LampUpgradeRes)
end

--region metatable bagV2.ReqUpgradeSoulJade
---@type bagV2.ReqUpgradeSoulJade
bagV2_adj.metatable_ReqUpgradeSoulJade = {
    _ClassName = "bagV2.ReqUpgradeSoulJade",
}
bagV2_adj.metatable_ReqUpgradeSoulJade.__index = bagV2_adj.metatable_ReqUpgradeSoulJade
--endregion

---@param tbl bagV2.ReqUpgradeSoulJade 待调整的table数据
function bagV2_adj.AdjustReqUpgradeSoulJade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqUpgradeSoulJade)
end

--region metatable bagV2.ResUpgradeSoulJade
---@type bagV2.ResUpgradeSoulJade
bagV2_adj.metatable_ResUpgradeSoulJade = {
    _ClassName = "bagV2.ResUpgradeSoulJade",
}
bagV2_adj.metatable_ResUpgradeSoulJade.__index = bagV2_adj.metatable_ResUpgradeSoulJade
--endregion

---@param tbl bagV2.ResUpgradeSoulJade 待调整的table数据
function bagV2_adj.AdjustResUpgradeSoulJade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResUpgradeSoulJade)
end

--region metatable bagV2.RafflePreyTreasureBag
---@type bagV2.RafflePreyTreasureBag
bagV2_adj.metatable_RafflePreyTreasureBag = {
    _ClassName = "bagV2.RafflePreyTreasureBag",
}
bagV2_adj.metatable_RafflePreyTreasureBag.__index = bagV2_adj.metatable_RafflePreyTreasureBag
--endregion

---@param tbl bagV2.RafflePreyTreasureBag 待调整的table数据
function bagV2_adj.AdjustRafflePreyTreasureBag(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_RafflePreyTreasureBag)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable bagV2.DrawPreyTreasureBagResponse
---@type bagV2.DrawPreyTreasureBagResponse
bagV2_adj.metatable_DrawPreyTreasureBagResponse = {
    _ClassName = "bagV2.DrawPreyTreasureBagResponse",
}
bagV2_adj.metatable_DrawPreyTreasureBagResponse.__index = bagV2_adj.metatable_DrawPreyTreasureBagResponse
--endregion

---@param tbl bagV2.DrawPreyTreasureBagResponse 待调整的table数据
function bagV2_adj.AdjustDrawPreyTreasureBagResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_DrawPreyTreasureBagResponse)
end

--region metatable bagV2.DrawPreyTreasureBag
---@type bagV2.DrawPreyTreasureBag
bagV2_adj.metatable_DrawPreyTreasureBag = {
    _ClassName = "bagV2.DrawPreyTreasureBag",
}
bagV2_adj.metatable_DrawPreyTreasureBag.__index = bagV2_adj.metatable_DrawPreyTreasureBag
--endregion

---@param tbl bagV2.DrawPreyTreasureBag 待调整的table数据
function bagV2_adj.AdjustDrawPreyTreasureBag(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_DrawPreyTreasureBag)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable bagV2.PreyTreasureBagResponse
---@type bagV2.PreyTreasureBagResponse
bagV2_adj.metatable_PreyTreasureBagResponse = {
    _ClassName = "bagV2.PreyTreasureBagResponse",
}
bagV2_adj.metatable_PreyTreasureBagResponse.__index = bagV2_adj.metatable_PreyTreasureBagResponse
--endregion

---@param tbl bagV2.PreyTreasureBagResponse 待调整的table数据
function bagV2_adj.AdjustPreyTreasureBagResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_PreyTreasureBagResponse)
    if tbl.jackpot == nil then
        tbl.jackpot = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.jackpot do
                bagV2_adj.AdjustBagItemInfo(tbl.jackpot[i])
            end
        end
    end
    if tbl.rewardIndex == nil then
        tbl.rewardIndexSpecified = false
        tbl.rewardIndex = 0
    else
        tbl.rewardIndexSpecified = true
    end
    if tbl.isRaffle == nil then
        tbl.isRaffleSpecified = false
        tbl.isRaffle = false
    else
        tbl.isRaffleSpecified = true
    end
end

--region metatable bagV2.RafflePreyTreasureBox
---@type bagV2.RafflePreyTreasureBox
bagV2_adj.metatable_RafflePreyTreasureBox = {
    _ClassName = "bagV2.RafflePreyTreasureBox",
}
bagV2_adj.metatable_RafflePreyTreasureBox.__index = bagV2_adj.metatable_RafflePreyTreasureBox
--endregion

---@param tbl bagV2.RafflePreyTreasureBox 待调整的table数据
function bagV2_adj.AdjustRafflePreyTreasureBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_RafflePreyTreasureBox)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable bagV2.DrawPreyTreasureBoxResponse
---@type bagV2.DrawPreyTreasureBoxResponse
bagV2_adj.metatable_DrawPreyTreasureBoxResponse = {
    _ClassName = "bagV2.DrawPreyTreasureBoxResponse",
}
bagV2_adj.metatable_DrawPreyTreasureBoxResponse.__index = bagV2_adj.metatable_DrawPreyTreasureBoxResponse
--endregion

---@param tbl bagV2.DrawPreyTreasureBoxResponse 待调整的table数据
function bagV2_adj.AdjustDrawPreyTreasureBoxResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_DrawPreyTreasureBoxResponse)
end

--region metatable bagV2.DrawPreyTreasureBox
---@type bagV2.DrawPreyTreasureBox
bagV2_adj.metatable_DrawPreyTreasureBox = {
    _ClassName = "bagV2.DrawPreyTreasureBox",
}
bagV2_adj.metatable_DrawPreyTreasureBox.__index = bagV2_adj.metatable_DrawPreyTreasureBox
--endregion

---@param tbl bagV2.DrawPreyTreasureBox 待调整的table数据
function bagV2_adj.AdjustDrawPreyTreasureBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_DrawPreyTreasureBox)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.dayCount == nil then
        tbl.dayCountSpecified = false
        tbl.dayCount = 0
    else
        tbl.dayCountSpecified = true
    end
end

--region metatable bagV2.PreyTreasureBoxResponse
---@type bagV2.PreyTreasureBoxResponse
bagV2_adj.metatable_PreyTreasureBoxResponse = {
    _ClassName = "bagV2.PreyTreasureBoxResponse",
}
bagV2_adj.metatable_PreyTreasureBoxResponse.__index = bagV2_adj.metatable_PreyTreasureBoxResponse
--endregion

---@param tbl bagV2.PreyTreasureBoxResponse 待调整的table数据
function bagV2_adj.AdjustPreyTreasureBoxResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_PreyTreasureBoxResponse)
    if tbl.jackpot == nil then
        tbl.jackpot = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.jackpot do
                bagV2_adj.AdjustBagItemInfo(tbl.jackpot[i])
            end
        end
    end
    if tbl.rewardIndex == nil then
        tbl.rewardIndexSpecified = false
        tbl.rewardIndex = 0
    else
        tbl.rewardIndexSpecified = true
    end
    if tbl.isRaffle == nil then
        tbl.isRaffleSpecified = false
        tbl.isRaffle = false
    else
        tbl.isRaffleSpecified = true
    end
end

--region metatable bagV2.UsePreyTreasureBoxMulti
---@type bagV2.UsePreyTreasureBoxMulti
bagV2_adj.metatable_UsePreyTreasureBoxMulti = {
    _ClassName = "bagV2.UsePreyTreasureBoxMulti",
}
bagV2_adj.metatable_UsePreyTreasureBoxMulti.__index = bagV2_adj.metatable_UsePreyTreasureBoxMulti
--endregion

---@param tbl bagV2.UsePreyTreasureBoxMulti 待调整的table数据
function bagV2_adj.AdjustUsePreyTreasureBoxMulti(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_UsePreyTreasureBoxMulti)
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

--region metatable bagV2.ResAwardPreyTreasureBoxMulti
---@type bagV2.ResAwardPreyTreasureBoxMulti
bagV2_adj.metatable_ResAwardPreyTreasureBoxMulti = {
    _ClassName = "bagV2.ResAwardPreyTreasureBoxMulti",
}
bagV2_adj.metatable_ResAwardPreyTreasureBoxMulti.__index = bagV2_adj.metatable_ResAwardPreyTreasureBoxMulti
--endregion

---@param tbl bagV2.ResAwardPreyTreasureBoxMulti 待调整的table数据
function bagV2_adj.AdjustResAwardPreyTreasureBoxMulti(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResAwardPreyTreasureBoxMulti)
    if tbl.awardItems == nil then
        tbl.awardItems = {}
    else
        if bagV2_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.awardItems do
                bagV2_adj.AdjustBagItemInfo(tbl.awardItems[i])
            end
        end
    end
    if tbl.package == nil then
        tbl.package = {}
    else
        if bagV2_adj.AdjustPreyTreasureBoxResponse ~= nil then
            for i = 1, #tbl.package do
                bagV2_adj.AdjustPreyTreasureBoxResponse(tbl.package[i])
            end
        end
    end
end

--region metatable bagV2.AwardPreyTreasureBoxMulti
---@type bagV2.AwardPreyTreasureBoxMulti
bagV2_adj.metatable_AwardPreyTreasureBoxMulti = {
    _ClassName = "bagV2.AwardPreyTreasureBoxMulti",
}
bagV2_adj.metatable_AwardPreyTreasureBoxMulti.__index = bagV2_adj.metatable_AwardPreyTreasureBoxMulti
--endregion

---@param tbl bagV2.AwardPreyTreasureBoxMulti 待调整的table数据
function bagV2_adj.AdjustAwardPreyTreasureBoxMulti(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_AwardPreyTreasureBoxMulti)
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

--region metatable bagV2.RemoveTimeEnd
---@type bagV2.RemoveTimeEnd
bagV2_adj.metatable_RemoveTimeEnd = {
    _ClassName = "bagV2.RemoveTimeEnd",
}
bagV2_adj.metatable_RemoveTimeEnd.__index = bagV2_adj.metatable_RemoveTimeEnd
--endregion

---@param tbl bagV2.RemoveTimeEnd 待调整的table数据
function bagV2_adj.AdjustRemoveTimeEnd(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_RemoveTimeEnd)
    if tbl.itemIdList == nil then
        tbl.itemIdList = {}
    end
end

--region metatable bagV2.ReqGetNextSoulJade
---@type bagV2.ReqGetNextSoulJade
bagV2_adj.metatable_ReqGetNextSoulJade = {
    _ClassName = "bagV2.ReqGetNextSoulJade",
}
bagV2_adj.metatable_ReqGetNextSoulJade.__index = bagV2_adj.metatable_ReqGetNextSoulJade
--endregion

---@param tbl bagV2.ReqGetNextSoulJade 待调整的table数据
function bagV2_adj.AdjustReqGetNextSoulJade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqGetNextSoulJade)
    if tbl.thisId == nil then
        tbl.thisIdSpecified = false
        tbl.thisId = 0
    else
        tbl.thisIdSpecified = true
    end
end

--region metatable bagV2.ResGetNextSoulJade
---@type bagV2.ResGetNextSoulJade
bagV2_adj.metatable_ResGetNextSoulJade = {
    _ClassName = "bagV2.ResGetNextSoulJade",
}
bagV2_adj.metatable_ResGetNextSoulJade.__index = bagV2_adj.metatable_ResGetNextSoulJade
--endregion

---@param tbl bagV2.ResGetNextSoulJade 待调整的table数据
function bagV2_adj.AdjustResGetNextSoulJade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResGetNextSoulJade)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
end

--region metatable bagV2.ReqEvolve
---@type bagV2.ReqEvolve
bagV2_adj.metatable_ReqEvolve = {
    _ClassName = "bagV2.ReqEvolve",
}
bagV2_adj.metatable_ReqEvolve.__index = bagV2_adj.metatable_ReqEvolve
--endregion

---@param tbl bagV2.ReqEvolve 待调整的table数据
function bagV2_adj.AdjustReqEvolve(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqEvolve)
    if tbl.equipId == nil then
        tbl.equipIdSpecified = false
        tbl.equipId = 0
    else
        tbl.equipIdSpecified = true
    end
    if tbl.sacrifices == nil then
        tbl.sacrifices = {}
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable bagV2.ResEvolve
---@type bagV2.ResEvolve
bagV2_adj.metatable_ResEvolve = {
    _ClassName = "bagV2.ResEvolve",
}
bagV2_adj.metatable_ResEvolve.__index = bagV2_adj.metatable_ResEvolve
--endregion

---@param tbl bagV2.ResEvolve 待调整的table数据
function bagV2_adj.AdjustResEvolve(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResEvolve)
end

--region metatable bagV2.ResBundlitem
---@type bagV2.ResBundlitem
bagV2_adj.metatable_ResBundlitem = {
    _ClassName = "bagV2.ResBundlitem",
}
bagV2_adj.metatable_ResBundlitem.__index = bagV2_adj.metatable_ResBundlitem
--endregion

---@param tbl bagV2.ResBundlitem 待调整的table数据
function bagV2_adj.AdjustResBundlitem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResBundlitem)
    if tbl.itemId == nil then
        tbl.itemId = {}
    end
end

--region metatable bagV2.ReqBuyResBundlitem
---@type bagV2.ReqBuyResBundlitem
bagV2_adj.metatable_ReqBuyResBundlitem = {
    _ClassName = "bagV2.ReqBuyResBundlitem",
}
bagV2_adj.metatable_ReqBuyResBundlitem.__index = bagV2_adj.metatable_ReqBuyResBundlitem
--endregion

---@param tbl bagV2.ReqBuyResBundlitem 待调整的table数据
function bagV2_adj.AdjustReqBuyResBundlitem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqBuyResBundlitem)
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

--region metatable bagV2.ResSuccessBuyBindlitem
---@type bagV2.ResSuccessBuyBindlitem
bagV2_adj.metatable_ResSuccessBuyBindlitem = {
    _ClassName = "bagV2.ResSuccessBuyBindlitem",
}
bagV2_adj.metatable_ResSuccessBuyBindlitem.__index = bagV2_adj.metatable_ResSuccessBuyBindlitem
--endregion

---@param tbl bagV2.ResSuccessBuyBindlitem 待调整的table数据
function bagV2_adj.AdjustResSuccessBuyBindlitem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResSuccessBuyBindlitem)
    if tbl.lid == nil then
        tbl.lid = {}
    end
end

--region metatable bagV2.ReqBuyMaterialWay
---@type bagV2.ReqBuyMaterialWay
bagV2_adj.metatable_ReqBuyMaterialWay = {
    _ClassName = "bagV2.ReqBuyMaterialWay",
}
bagV2_adj.metatable_ReqBuyMaterialWay.__index = bagV2_adj.metatable_ReqBuyMaterialWay
--endregion

---@param tbl bagV2.ReqBuyMaterialWay 待调整的table数据
function bagV2_adj.AdjustReqBuyMaterialWay(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqBuyMaterialWay)
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
    if tbl.materialId == nil then
        tbl.materialIdSpecified = false
        tbl.materialId = 0
    else
        tbl.materialIdSpecified = true
    end
    if tbl.materialCount == nil then
        tbl.materialCountSpecified = false
        tbl.materialCount = 0
    else
        tbl.materialCountSpecified = true
    end
end

--region metatable bagV2.ResBuyMaterialWaySuccess
---@type bagV2.ResBuyMaterialWaySuccess
bagV2_adj.metatable_ResBuyMaterialWaySuccess = {
    _ClassName = "bagV2.ResBuyMaterialWaySuccess",
}
bagV2_adj.metatable_ResBuyMaterialWaySuccess.__index = bagV2_adj.metatable_ResBuyMaterialWaySuccess
--endregion

---@param tbl bagV2.ResBuyMaterialWaySuccess 待调整的table数据
function bagV2_adj.AdjustResBuyMaterialWaySuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResBuyMaterialWaySuccess)
    if tbl.buyId == nil then
        tbl.buyIdSpecified = false
        tbl.buyId = 0
    else
        tbl.buyIdSpecified = true
    end
    if tbl.buyCount == nil then
        tbl.buyCountSpecified = false
        tbl.buyCount = 0
    else
        tbl.buyCountSpecified = true
    end
end

--region metatable bagV2.ReqDayUseItemCount
---@type bagV2.ReqDayUseItemCount
bagV2_adj.metatable_ReqDayUseItemCount = {
    _ClassName = "bagV2.ReqDayUseItemCount",
}
bagV2_adj.metatable_ReqDayUseItemCount.__index = bagV2_adj.metatable_ReqDayUseItemCount
--endregion

---@param tbl bagV2.ReqDayUseItemCount 待调整的table数据
function bagV2_adj.AdjustReqDayUseItemCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqDayUseItemCount)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable bagV2.ResDayUseItemCount
---@type bagV2.ResDayUseItemCount
bagV2_adj.metatable_ResDayUseItemCount = {
    _ClassName = "bagV2.ResDayUseItemCount",
}
bagV2_adj.metatable_ResDayUseItemCount.__index = bagV2_adj.metatable_ResDayUseItemCount
--endregion

---@param tbl bagV2.ResDayUseItemCount 待调整的table数据
function bagV2_adj.AdjustResDayUseItemCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResDayUseItemCount)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.useCount == nil then
        tbl.useCountSpecified = false
        tbl.useCount = 0
    else
        tbl.useCountSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
end

--region metatable bagV2.ReqCanUseGatherSpiritBead
---@type bagV2.ReqCanUseGatherSpiritBead
bagV2_adj.metatable_ReqCanUseGatherSpiritBead = {
    _ClassName = "bagV2.ReqCanUseGatherSpiritBead",
}
bagV2_adj.metatable_ReqCanUseGatherSpiritBead.__index = bagV2_adj.metatable_ReqCanUseGatherSpiritBead
--endregion

---@param tbl bagV2.ReqCanUseGatherSpiritBead 待调整的table数据
function bagV2_adj.AdjustReqCanUseGatherSpiritBead(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqCanUseGatherSpiritBead)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable bagV2.ResCanUseGatherSpiritBead
---@type bagV2.ResCanUseGatherSpiritBead
bagV2_adj.metatable_ResCanUseGatherSpiritBead = {
    _ClassName = "bagV2.ResCanUseGatherSpiritBead",
}
bagV2_adj.metatable_ResCanUseGatherSpiritBead.__index = bagV2_adj.metatable_ResCanUseGatherSpiritBead
--endregion

---@param tbl bagV2.ResCanUseGatherSpiritBead 待调整的table数据
function bagV2_adj.AdjustResCanUseGatherSpiritBead(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResCanUseGatherSpiritBead)
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
    if tbl.canUse == nil then
        tbl.canUseSpecified = false
        tbl.canUse = false
    else
        tbl.canUseSpecified = true
    end
end

--region metatable bagV2.ItemOutput
---@type bagV2.ItemOutput
bagV2_adj.metatable_ItemOutput = {
    _ClassName = "bagV2.ItemOutput",
}
bagV2_adj.metatable_ItemOutput.__index = bagV2_adj.metatable_ItemOutput
--endregion

---@param tbl bagV2.ItemOutput 待调整的table数据
function bagV2_adj.AdjustItemOutput(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ItemOutput)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.number == nil then
        tbl.numberSpecified = false
        tbl.number = 0
    else
        tbl.numberSpecified = true
    end
end

--region metatable bagV2.UpdateItemOutput
---@type bagV2.UpdateItemOutput
bagV2_adj.metatable_UpdateItemOutput = {
    _ClassName = "bagV2.UpdateItemOutput",
}
bagV2_adj.metatable_UpdateItemOutput.__index = bagV2_adj.metatable_UpdateItemOutput
--endregion

---@param tbl bagV2.UpdateItemOutput 待调整的table数据
function bagV2_adj.AdjustUpdateItemOutput(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_UpdateItemOutput)
    if tbl.maxOpenDayOfAll == nil then
        tbl.maxOpenDayOfAllSpecified = false
        tbl.maxOpenDayOfAll = 0
    else
        tbl.maxOpenDayOfAllSpecified = true
    end
    if tbl.itemOutputs == nil then
        tbl.itemOutputs = {}
    else
        if bagV2_adj.AdjustItemOutput ~= nil then
            for i = 1, #tbl.itemOutputs do
                bagV2_adj.AdjustItemOutput(tbl.itemOutputs[i])
            end
        end
    end
end

--region metatable bagV2.ReqUseCDKey
---@type bagV2.ReqUseCDKey
bagV2_adj.metatable_ReqUseCDKey = {
    _ClassName = "bagV2.ReqUseCDKey",
}
bagV2_adj.metatable_ReqUseCDKey.__index = bagV2_adj.metatable_ReqUseCDKey
--endregion

---@param tbl bagV2.ReqUseCDKey 待调整的table数据
function bagV2_adj.AdjustReqUseCDKey(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqUseCDKey)
end

--region metatable bagV2.ReqUseSpyBrand
---@type bagV2.ReqUseSpyBrand
bagV2_adj.metatable_ReqUseSpyBrand = {
    _ClassName = "bagV2.ReqUseSpyBrand",
}
bagV2_adj.metatable_ReqUseSpyBrand.__index = bagV2_adj.metatable_ReqUseSpyBrand
--endregion

---@param tbl bagV2.ReqUseSpyBrand 待调整的table数据
function bagV2_adj.AdjustReqUseSpyBrand(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqUseSpyBrand)
    if tbl.itemLid == nil then
        tbl.itemLidSpecified = false
        tbl.itemLid = 0
    else
        tbl.itemLidSpecified = true
    end
    if tbl.roleLid == nil then
        tbl.roleLidSpecified = false
        tbl.roleLid = 0
    else
        tbl.roleLidSpecified = true
    end
end

--region metatable bagV2.ResItemTips
---@type bagV2.ResItemTips
bagV2_adj.metatable_ResItemTips = {
    _ClassName = "bagV2.ResItemTips",
}
bagV2_adj.metatable_ResItemTips.__index = bagV2_adj.metatable_ResItemTips
--endregion

---@param tbl bagV2.ResItemTips 待调整的table数据
function bagV2_adj.AdjustResItemTips(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResItemTips)
    if tbl.tip == nil then
        tbl.tip = {}
    else
        if bagV2_adj.AdjustItemTip ~= nil then
            for i = 1, #tbl.tip do
                bagV2_adj.AdjustItemTip(tbl.tip[i])
            end
        end
    end
end

--region metatable bagV2.ItemTip
---@type bagV2.ItemTip
bagV2_adj.metatable_ItemTip = {
    _ClassName = "bagV2.ItemTip",
}
bagV2_adj.metatable_ItemTip.__index = bagV2_adj.metatable_ItemTip
--endregion

---@param tbl bagV2.ItemTip 待调整的table数据
function bagV2_adj.AdjustItemTip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ItemTip)
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
    if tbl.multi == nil then
        tbl.multiSpecified = false
        tbl.multi = 0
    else
        tbl.multiSpecified = true
    end
end

--region metatable bagV2.ReqBloodSmelt
---@type bagV2.ReqBloodSmelt
bagV2_adj.metatable_ReqBloodSmelt = {
    _ClassName = "bagV2.ReqBloodSmelt",
}
bagV2_adj.metatable_ReqBloodSmelt.__index = bagV2_adj.metatable_ReqBloodSmelt
--endregion

---@param tbl bagV2.ReqBloodSmelt 待调整的table数据
function bagV2_adj.AdjustReqBloodSmelt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqBloodSmelt)
    if tbl.recycleList == nil then
        tbl.recycleList = {}
    end
end

--region metatable bagV2.ResBloodSmelt
---@type bagV2.ResBloodSmelt
bagV2_adj.metatable_ResBloodSmelt = {
    _ClassName = "bagV2.ResBloodSmelt",
}
bagV2_adj.metatable_ResBloodSmelt.__index = bagV2_adj.metatable_ResBloodSmelt
--endregion

---@param tbl bagV2.ResBloodSmelt 待调整的table数据
function bagV2_adj.AdjustResBloodSmelt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResBloodSmelt)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable bagV2.ReqDivineSmelt
---@type bagV2.ReqDivineSmelt
bagV2_adj.metatable_ReqDivineSmelt = {
    _ClassName = "bagV2.ReqDivineSmelt",
}
bagV2_adj.metatable_ReqDivineSmelt.__index = bagV2_adj.metatable_ReqDivineSmelt
--endregion

---@param tbl bagV2.ReqDivineSmelt 待调整的table数据
function bagV2_adj.AdjustReqDivineSmelt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ReqDivineSmelt)
    if tbl.recycleList == nil then
        tbl.recycleList = {}
    end
end

--region metatable bagV2.ResDivineSmelt
---@type bagV2.ResDivineSmelt
bagV2_adj.metatable_ResDivineSmelt = {
    _ClassName = "bagV2.ResDivineSmelt",
}
bagV2_adj.metatable_ResDivineSmelt.__index = bagV2_adj.metatable_ResDivineSmelt
--endregion

---@param tbl bagV2.ResDivineSmelt 待调整的table数据
function bagV2_adj.AdjustResDivineSmelt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResDivineSmelt)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable bagV2.ResBagSizeByMonthCard
---@type bagV2.ResBagSizeByMonthCard
bagV2_adj.metatable_ResBagSizeByMonthCard = {
    _ClassName = "bagV2.ResBagSizeByMonthCard",
}
bagV2_adj.metatable_ResBagSizeByMonthCard.__index = bagV2_adj.metatable_ResBagSizeByMonthCard
--endregion

---@param tbl bagV2.ResBagSizeByMonthCard 待调整的table数据
function bagV2_adj.AdjustResBagSizeByMonthCard(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResBagSizeByMonthCard)
    if tbl.emptyGridCount == nil then
        tbl.emptyGridCountSpecified = false
        tbl.emptyGridCount = 0
    else
        tbl.emptyGridCountSpecified = true
    end
    if tbl.maxGridCount == nil then
        tbl.maxGridCountSpecified = false
        tbl.maxGridCount = 0
    else
        tbl.maxGridCountSpecified = true
    end
end

--region metatable bagV2.UseMoneyBox
---@type bagV2.UseMoneyBox
bagV2_adj.metatable_UseMoneyBox = {
    _ClassName = "bagV2.UseMoneyBox",
}
bagV2_adj.metatable_UseMoneyBox.__index = bagV2_adj.metatable_UseMoneyBox
--endregion

---@param tbl bagV2.UseMoneyBox 待调整的table数据
function bagV2_adj.AdjustUseMoneyBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_UseMoneyBox)
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

--region metatable bagV2.ResUpdateAutomaticCollect
---@type bagV2.ResUpdateAutomaticCollect
bagV2_adj.metatable_ResUpdateAutomaticCollect = {
    _ClassName = "bagV2.ResUpdateAutomaticCollect",
}
bagV2_adj.metatable_ResUpdateAutomaticCollect.__index = bagV2_adj.metatable_ResUpdateAutomaticCollect
--endregion

---@param tbl bagV2.ResUpdateAutomaticCollect 待调整的table数据
function bagV2_adj.AdjustResUpdateAutomaticCollect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bagV2_adj.metatable_ResUpdateAutomaticCollect)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

return bagV2_adj