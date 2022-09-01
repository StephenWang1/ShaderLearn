--[[本文件为工具自动生成,禁止手动修改]]
local chatV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable chatV2.OtherMsgInfo
---@type chatV2.OtherMsgInfo
chatV2_adj.metatable_OtherMsgInfo = {
    _ClassName = "chatV2.OtherMsgInfo",
}
chatV2_adj.metatable_OtherMsgInfo.__index = chatV2_adj.metatable_OtherMsgInfo
--endregion

---@param tbl chatV2.OtherMsgInfo 待调整的table数据
function chatV2_adj.AdjustOtherMsgInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_OtherMsgInfo)
    if tbl.targetUid == nil then
        tbl.targetUidSpecified = false
        tbl.targetUid = 0
    else
        tbl.targetUidSpecified = true
    end
    if tbl.sendUid == nil then
        tbl.sendUidSpecified = false
        tbl.sendUid = 0
    else
        tbl.sendUidSpecified = true
    end
    if tbl.sendName == nil then
        tbl.sendNameSpecified = false
        tbl.sendName = ""
    else
        tbl.sendNameSpecified = true
    end
    if tbl.receivedUid == nil then
        tbl.receivedUidSpecified = false
        tbl.receivedUid = 0
    else
        tbl.receivedUidSpecified = true
    end
    if tbl.receivedName == nil then
        tbl.receivedNameSpecified = false
        tbl.receivedName = ""
    else
        tbl.receivedNameSpecified = true
    end
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.vipLevel == nil then
        tbl.vipLevelSpecified = false
        tbl.vipLevel = 0
    else
        tbl.vipLevelSpecified = true
    end
    if tbl.isMonthCard == nil then
        tbl.isMonthCardSpecified = false
        tbl.isMonthCard = false
    else
        tbl.isMonthCardSpecified = true
    end
end

--region metatable chatV2.AttributeInfo
---@type chatV2.AttributeInfo
chatV2_adj.metatable_AttributeInfo = {
    _ClassName = "chatV2.AttributeInfo",
}
chatV2_adj.metatable_AttributeInfo.__index = chatV2_adj.metatable_AttributeInfo
--endregion

---@param tbl chatV2.AttributeInfo 待调整的table数据
function chatV2_adj.AdjustAttributeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_AttributeInfo)
    if tbl.attributeType == nil then
        tbl.attributeType = {}
    end
    if tbl.attributeValue == nil then
        tbl.attributeValue = {}
    end
end

--region metatable chatV2.EquipItemInfo
---@type chatV2.EquipItemInfo
chatV2_adj.metatable_EquipItemInfo = {
    _ClassName = "chatV2.EquipItemInfo",
}
chatV2_adj.metatable_EquipItemInfo.__index = chatV2_adj.metatable_EquipItemInfo
--endregion

---@param tbl chatV2.EquipItemInfo 待调整的table数据
function chatV2_adj.AdjustEquipItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_EquipItemInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.bestAttInfo == nil then
        tbl.bestAttInfoSpecified = false
        tbl.bestAttInfo = nil
    else
        if tbl.bestAttInfoSpecified == nil then 
            tbl.bestAttInfoSpecified = true
            if chatV2_adj.AdjustBestAttInfo ~= nil then
                chatV2_adj.AdjustBestAttInfo(tbl.bestAttInfo)
            end
        end
    end
    if tbl.jiPinInfo == nil then
        tbl.jiPinInfoSpecified = false
        tbl.jiPinInfo = nil
    else
        if tbl.jiPinInfoSpecified == nil then 
            tbl.jiPinInfoSpecified = true
            if chatV2_adj.AdjustJiPinInfo ~= nil then
                chatV2_adj.AdjustJiPinInfo(tbl.jiPinInfo)
            end
        end
    end
    if tbl.niePanLv == nil then
        tbl.niePanLvSpecified = false
        tbl.niePanLv = 0
    else
        tbl.niePanLvSpecified = true
    end
end

--region metatable chatV2.BestAttInfo
---@type chatV2.BestAttInfo
chatV2_adj.metatable_BestAttInfo = {
    _ClassName = "chatV2.BestAttInfo",
}
chatV2_adj.metatable_BestAttInfo.__index = chatV2_adj.metatable_BestAttInfo
--endregion

---@param tbl chatV2.BestAttInfo 待调整的table数据
function chatV2_adj.AdjustBestAttInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_BestAttInfo)
    if tbl.attId == nil then
        tbl.attIdSpecified = false
        tbl.attId = 0
    else
        tbl.attIdSpecified = true
    end
    if tbl.attType == nil then
        tbl.attTypeSpecified = false
        tbl.attType = 0
    else
        tbl.attTypeSpecified = true
    end
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

--region metatable chatV2.LingBaoInfo
---@type chatV2.LingBaoInfo
chatV2_adj.metatable_LingBaoInfo = {
    _ClassName = "chatV2.LingBaoInfo",
}
chatV2_adj.metatable_LingBaoInfo.__index = chatV2_adj.metatable_LingBaoInfo
--endregion

---@param tbl chatV2.LingBaoInfo 待调整的table数据
function chatV2_adj.AdjustLingBaoInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_LingBaoInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.uniqueId == nil then
        tbl.uniqueIdSpecified = false
        tbl.uniqueId = 0
    else
        tbl.uniqueIdSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
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

--region metatable chatV2.JiPinInfo
---@type chatV2.JiPinInfo
chatV2_adj.metatable_JiPinInfo = {
    _ClassName = "chatV2.JiPinInfo",
}
chatV2_adj.metatable_JiPinInfo.__index = chatV2_adj.metatable_JiPinInfo
--endregion

---@param tbl chatV2.JiPinInfo 待调整的table数据
function chatV2_adj.AdjustJiPinInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_JiPinInfo)
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

--region metatable chatV2.ScoreInfo
---@type chatV2.ScoreInfo
chatV2_adj.metatable_ScoreInfo = {
    _ClassName = "chatV2.ScoreInfo",
}
chatV2_adj.metatable_ScoreInfo.__index = chatV2_adj.metatable_ScoreInfo
--endregion

---@param tbl chatV2.ScoreInfo 待调整的table数据
function chatV2_adj.AdjustScoreInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ScoreInfo)
    if tbl.equipScore == nil then
        tbl.equipScoreSpecified = false
        tbl.equipScore = 0
    else
        tbl.equipScoreSpecified = true
    end
    if tbl.xzScore == nil then
        tbl.xzScoreSpecified = false
        tbl.xzScore = 0
    else
        tbl.xzScoreSpecified = true
    end
    if tbl.szScore == nil then
        tbl.szScoreSpecified = false
        tbl.szScore = 0
    else
        tbl.szScoreSpecified = true
    end
    if tbl.lzScore == nil then
        tbl.lzScoreSpecified = false
        tbl.lzScore = 0
    else
        tbl.lzScoreSpecified = true
    end
end

--region metatable chatV2.RoleInfo
---@type chatV2.RoleInfo
chatV2_adj.metatable_RoleInfo = {
    _ClassName = "chatV2.RoleInfo",
}
chatV2_adj.metatable_RoleInfo.__index = chatV2_adj.metatable_RoleInfo
--endregion

---@param tbl chatV2.RoleInfo 待调整的table数据
function chatV2_adj.AdjustRoleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_RoleInfo)
    if tbl.windId == nil then
        tbl.windIdSpecified = false
        tbl.windId = 0
    else
        tbl.windIdSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.fashionTitle == nil then
        tbl.fashionTitleSpecified = false
        tbl.fashionTitle = 0
    else
        tbl.fashionTitleSpecified = true
    end
    if tbl.fashionCloth == nil then
        tbl.fashionClothSpecified = false
        tbl.fashionCloth = 0
    else
        tbl.fashionClothSpecified = true
    end
    if tbl.fashionWeapon == nil then
        tbl.fashionWeaponSpecified = false
        tbl.fashionWeapon = 0
    else
        tbl.fashionWeaponSpecified = true
    end
    if tbl.fashionWing == nil then
        tbl.fashionWingSpecified = false
        tbl.fashionWing = 0
    else
        tbl.fashionWingSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
    if tbl.playerAttribute == nil then
        tbl.playerAttributeSpecified = false
        tbl.playerAttribute = nil
    else
        if tbl.playerAttributeSpecified == nil then 
            tbl.playerAttributeSpecified = true
            if chatV2_adj.AdjustAttributeInfo ~= nil then
                chatV2_adj.AdjustAttributeInfo(tbl.playerAttribute)
            end
        end
    end
    if tbl.equipItemBeanList == nil then
        tbl.equipItemBeanList = {}
    else
        if chatV2_adj.AdjustEquipItemInfo ~= nil then
            for i = 1, #tbl.equipItemBeanList do
                chatV2_adj.AdjustEquipItemInfo(tbl.equipItemBeanList[i])
            end
        end
    end
    if tbl.strengthList == nil then
        tbl.strengthList = {}
    end
    if tbl.szList == nil then
        tbl.szList = {}
    else
        if chatV2_adj.AdjustShenZhuangInfo ~= nil then
            for i = 1, #tbl.szList do
                chatV2_adj.AdjustShenZhuangInfo(tbl.szList[i])
            end
        end
    end
    if tbl.szFightPower == nil then
        tbl.szFightPowerSpecified = false
        tbl.szFightPower = 0
    else
        tbl.szFightPowerSpecified = true
    end
    if tbl.szSuit == nil then
        tbl.szSuitSpecified = false
        tbl.szSuit = 0
    else
        tbl.szSuitSpecified = true
    end
    if tbl.szCount == nil then
        tbl.szCountSpecified = false
        tbl.szCount = 0
    else
        tbl.szCountSpecified = true
    end
    if tbl.lbList == nil then
        tbl.lbList = {}
    else
        if chatV2_adj.AdjustLingBaoInfo ~= nil then
            for i = 1, #tbl.lbList do
                chatV2_adj.AdjustLingBaoInfo(tbl.lbList[i])
            end
        end
    end
    if tbl.ringList == nil then
        tbl.ringList = {}
    else
        if chatV2_adj.AdjustRingInfo ~= nil then
            for i = 1, #tbl.ringList do
                chatV2_adj.AdjustRingInfo(tbl.ringList[i])
            end
        end
    end
    if tbl.treasureInfo == nil then
        tbl.treasureInfoSpecified = false
        tbl.treasureInfo = nil
    else
        if tbl.treasureInfoSpecified == nil then 
            tbl.treasureInfoSpecified = true
            if chatV2_adj.AdjustTreasureInfo ~= nil then
                chatV2_adj.AdjustTreasureInfo(tbl.treasureInfo)
            end
        end
    end
    if tbl.godAxInfo == nil then
        tbl.godAxInfoSpecified = false
        tbl.godAxInfo = nil
    else
        if tbl.godAxInfoSpecified == nil then 
            tbl.godAxInfoSpecified = true
            if chatV2_adj.AdjustGodAxInfo ~= nil then
                chatV2_adj.AdjustGodAxInfo(tbl.godAxInfo)
            end
        end
    end
    if tbl.legacyEquipInfo == nil then
        tbl.legacyEquipInfoSpecified = false
        tbl.legacyEquipInfo = nil
    else
        if tbl.legacyEquipInfoSpecified == nil then 
            tbl.legacyEquipInfoSpecified = true
            if chatV2_adj.AdjustLegacyEquipInfo ~= nil then
                chatV2_adj.AdjustLegacyEquipInfo(tbl.legacyEquipInfo)
            end
        end
    end
    if tbl.runesInfo == nil then
        tbl.runesInfoSpecified = false
        tbl.runesInfo = nil
    else
        if tbl.runesInfoSpecified == nil then 
            tbl.runesInfoSpecified = true
            if chatV2_adj.AdjustRunesInfo ~= nil then
                chatV2_adj.AdjustRunesInfo(tbl.runesInfo)
            end
        end
    end
    if tbl.scoreInfo == nil then
        tbl.scoreInfoSpecified = false
        tbl.scoreInfo = nil
    else
        if tbl.scoreInfoSpecified == nil then 
            tbl.scoreInfoSpecified = true
            if chatV2_adj.AdjustScoreInfo ~= nil then
                chatV2_adj.AdjustScoreInfo(tbl.scoreInfo)
            end
        end
    end
    if tbl.lianHunEquipInfo == nil then
        tbl.lianHunEquipInfoSpecified = false
        tbl.lianHunEquipInfo = nil
    else
        if tbl.lianHunEquipInfoSpecified == nil then 
            tbl.lianHunEquipInfoSpecified = true
            if chatV2_adj.AdjustLianHunEquipInfo ~= nil then
                chatV2_adj.AdjustLianHunEquipInfo(tbl.lianHunEquipInfo)
            end
        end
    end
    if tbl.dragonEquipList == nil then
        tbl.dragonEquipList = {}
    else
        if chatV2_adj.AdjustDragonEquipInfo ~= nil then
            for i = 1, #tbl.dragonEquipList do
                chatV2_adj.AdjustDragonEquipInfo(tbl.dragonEquipList[i])
            end
        end
    end
    if tbl.shouhuId == nil then
        tbl.shouhuIdSpecified = false
        tbl.shouhuId = 0
    else
        tbl.shouhuIdSpecified = true
    end
    if tbl.zhuZaiInfo == nil then
        tbl.zhuZaiInfoSpecified = false
        tbl.zhuZaiInfo = nil
    else
        if tbl.zhuZaiInfoSpecified == nil then 
            tbl.zhuZaiInfoSpecified = true
            if chatV2_adj.AdjustZhuZaiInfo ~= nil then
                chatV2_adj.AdjustZhuZaiInfo(tbl.zhuZaiInfo)
            end
        end
    end
    if tbl.godSwordLegendsLv == nil then
        tbl.godSwordLegendsLvSpecified = false
        tbl.godSwordLegendsLv = 0
    else
        tbl.godSwordLegendsLvSpecified = true
    end
    if tbl.godArmorLegendsLv == nil then
        tbl.godArmorLegendsLvSpecified = false
        tbl.godArmorLegendsLv = 0
    else
        tbl.godArmorLegendsLvSpecified = true
    end
    if tbl.leiShenInfo == nil then
        tbl.leiShenInfoSpecified = false
        tbl.leiShenInfo = nil
    else
        if tbl.leiShenInfoSpecified == nil then 
            tbl.leiShenInfoSpecified = true
            if chatV2_adj.AdjustLeiShenInfo ~= nil then
                chatV2_adj.AdjustLeiShenInfo(tbl.leiShenInfo)
            end
        end
    end
end

--region metatable chatV2.LeiShenInfo
---@type chatV2.LeiShenInfo
chatV2_adj.metatable_LeiShenInfo = {
    _ClassName = "chatV2.LeiShenInfo",
}
chatV2_adj.metatable_LeiShenInfo.__index = chatV2_adj.metatable_LeiShenInfo
--endregion

---@param tbl chatV2.LeiShenInfo 待调整的table数据
function chatV2_adj.AdjustLeiShenInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_LeiShenInfo)
    if tbl.leiShenEquipInfo == nil then
        tbl.leiShenEquipInfo = {}
    else
        if chatV2_adj.AdjustLeiShenEquipInfo ~= nil then
            for i = 1, #tbl.leiShenEquipInfo do
                chatV2_adj.AdjustLeiShenEquipInfo(tbl.leiShenEquipInfo[i])
            end
        end
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable chatV2.LeiShenEquipInfo
---@type chatV2.LeiShenEquipInfo
chatV2_adj.metatable_LeiShenEquipInfo = {
    _ClassName = "chatV2.LeiShenEquipInfo",
}
chatV2_adj.metatable_LeiShenEquipInfo.__index = chatV2_adj.metatable_LeiShenEquipInfo
--endregion

---@param tbl chatV2.LeiShenEquipInfo 待调整的table数据
function chatV2_adj.AdjustLeiShenEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_LeiShenEquipInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable chatV2.ZhuZaiInfo
---@type chatV2.ZhuZaiInfo
chatV2_adj.metatable_ZhuZaiInfo = {
    _ClassName = "chatV2.ZhuZaiInfo",
}
chatV2_adj.metatable_ZhuZaiInfo.__index = chatV2_adj.metatable_ZhuZaiInfo
--endregion

---@param tbl chatV2.ZhuZaiInfo 待调整的table数据
function chatV2_adj.AdjustZhuZaiInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ZhuZaiInfo)
    if tbl.zhuZaiEquipInfo == nil then
        tbl.zhuZaiEquipInfo = {}
    else
        if chatV2_adj.AdjustZhuZaiEquipInfo ~= nil then
            for i = 1, #tbl.zhuZaiEquipInfo do
                chatV2_adj.AdjustZhuZaiEquipInfo(tbl.zhuZaiEquipInfo[i])
            end
        end
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable chatV2.ZhuZaiEquipInfo
---@type chatV2.ZhuZaiEquipInfo
chatV2_adj.metatable_ZhuZaiEquipInfo = {
    _ClassName = "chatV2.ZhuZaiEquipInfo",
}
chatV2_adj.metatable_ZhuZaiEquipInfo.__index = chatV2_adj.metatable_ZhuZaiEquipInfo
--endregion

---@param tbl chatV2.ZhuZaiEquipInfo 待调整的table数据
function chatV2_adj.AdjustZhuZaiEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ZhuZaiEquipInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable chatV2.LianHunEquipInfo
---@type chatV2.LianHunEquipInfo
chatV2_adj.metatable_LianHunEquipInfo = {
    _ClassName = "chatV2.LianHunEquipInfo",
}
chatV2_adj.metatable_LianHunEquipInfo.__index = chatV2_adj.metatable_LianHunEquipInfo
--endregion

---@param tbl chatV2.LianHunEquipInfo 待调整的table数据
function chatV2_adj.AdjustLianHunEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_LianHunEquipInfo)
    if tbl.equips == nil then
        tbl.equips = {}
    else
        if chatV2_adj.AdjustEquipInfo ~= nil then
            for i = 1, #tbl.equips do
                chatV2_adj.AdjustEquipInfo(tbl.equips[i])
            end
        end
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable chatV2.EquipInfo
---@type chatV2.EquipInfo
chatV2_adj.metatable_EquipInfo = {
    _ClassName = "chatV2.EquipInfo",
}
chatV2_adj.metatable_EquipInfo.__index = chatV2_adj.metatable_EquipInfo
--endregion

---@param tbl chatV2.EquipInfo 待调整的table数据
function chatV2_adj.AdjustEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_EquipInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
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
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.bind == nil then
        tbl.bindSpecified = false
        tbl.bind = false
    else
        tbl.bindSpecified = true
    end
    if tbl.improveLevel == nil then
        tbl.improveLevelSpecified = false
        tbl.improveLevel = 0
    else
        tbl.improveLevelSpecified = true
    end
    if tbl.extraType == nil then
        tbl.extraType = {}
    end
    if tbl.extraValue == nil then
        tbl.extraValue = {}
    end
    if tbl.soulUp == nil then
        tbl.soulUpSpecified = false
        tbl.soulUp = 0
    else
        tbl.soulUpSpecified = true
    end
    if tbl.bestAttInfo == nil then
        tbl.bestAttInfoSpecified = false
        tbl.bestAttInfo = nil
    else
        if tbl.bestAttInfoSpecified == nil then 
            tbl.bestAttInfoSpecified = true
            if chatV2_adj.AdjustBestAttInfo ~= nil then
                chatV2_adj.AdjustBestAttInfo(tbl.bestAttInfo)
            end
        end
    end
    if tbl.JiPinInfo == nil then
        tbl.JiPinInfoSpecified = false
        tbl.JiPinInfo = nil
    else
        if tbl.JiPinInfoSpecified == nil then 
            tbl.JiPinInfoSpecified = true
            if chatV2_adj.AdjustJiPinInfo ~= nil then
                chatV2_adj.AdjustJiPinInfo(tbl.JiPinInfo)
            end
        end
    end
    if tbl.fuLingLv == nil then
        tbl.fuLingLvSpecified = false
        tbl.fuLingLv = 0
    else
        tbl.fuLingLvSpecified = true
    end
    if tbl.fuLingValue == nil then
        tbl.fuLingValueSpecified = false
        tbl.fuLingValue = 0
    else
        tbl.fuLingValueSpecified = true
    end
    if tbl.hongMengLv == nil then
        tbl.hongMengLvSpecified = false
        tbl.hongMengLv = 0
    else
        tbl.hongMengLvSpecified = true
    end
    if tbl.niePanLv == nil then
        tbl.niePanLvSpecified = false
        tbl.niePanLv = 0
    else
        tbl.niePanLvSpecified = true
    end
end

--region metatable chatV2.TreasureEquipInfo
---@type chatV2.TreasureEquipInfo
chatV2_adj.metatable_TreasureEquipInfo = {
    _ClassName = "chatV2.TreasureEquipInfo",
}
chatV2_adj.metatable_TreasureEquipInfo.__index = chatV2_adj.metatable_TreasureEquipInfo
--endregion

---@param tbl chatV2.TreasureEquipInfo 待调整的table数据
function chatV2_adj.AdjustTreasureEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_TreasureEquipInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable chatV2.RunesInfos
---@type chatV2.RunesInfos
chatV2_adj.metatable_RunesInfos = {
    _ClassName = "chatV2.RunesInfos",
}
chatV2_adj.metatable_RunesInfos.__index = chatV2_adj.metatable_RunesInfos
--endregion

---@param tbl chatV2.RunesInfos 待调整的table数据
function chatV2_adj.AdjustRunesInfos(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_RunesInfos)
    if tbl.runesList == nil then
        tbl.runesList = {}
    else
        if chatV2_adj.AdjustRunesInfo ~= nil then
            for i = 1, #tbl.runesList do
                chatV2_adj.AdjustRunesInfo(tbl.runesList[i])
            end
        end
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable chatV2.RunesInfo
---@type chatV2.RunesInfo
chatV2_adj.metatable_RunesInfo = {
    _ClassName = "chatV2.RunesInfo",
}
chatV2_adj.metatable_RunesInfo.__index = chatV2_adj.metatable_RunesInfo
--endregion

---@param tbl chatV2.RunesInfo 待调整的table数据
function chatV2_adj.AdjustRunesInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_RunesInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable chatV2.LegacyEquipInfos
---@type chatV2.LegacyEquipInfos
chatV2_adj.metatable_LegacyEquipInfos = {
    _ClassName = "chatV2.LegacyEquipInfos",
}
chatV2_adj.metatable_LegacyEquipInfos.__index = chatV2_adj.metatable_LegacyEquipInfos
--endregion

---@param tbl chatV2.LegacyEquipInfos 待调整的table数据
function chatV2_adj.AdjustLegacyEquipInfos(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_LegacyEquipInfos)
    if tbl.legacyEquipInfo == nil then
        tbl.legacyEquipInfo = {}
    else
        if chatV2_adj.AdjustLegacyEquipInfo ~= nil then
            for i = 1, #tbl.legacyEquipInfo do
                chatV2_adj.AdjustLegacyEquipInfo(tbl.legacyEquipInfo[i])
            end
        end
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
end

--region metatable chatV2.LegacyEquipInfo
---@type chatV2.LegacyEquipInfo
chatV2_adj.metatable_LegacyEquipInfo = {
    _ClassName = "chatV2.LegacyEquipInfo",
}
chatV2_adj.metatable_LegacyEquipInfo.__index = chatV2_adj.metatable_LegacyEquipInfo
--endregion

---@param tbl chatV2.LegacyEquipInfo 待调整的table数据
function chatV2_adj.AdjustLegacyEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_LegacyEquipInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable chatV2.GodAxInfo
---@type chatV2.GodAxInfo
chatV2_adj.metatable_GodAxInfo = {
    _ClassName = "chatV2.GodAxInfo",
}
chatV2_adj.metatable_GodAxInfo.__index = chatV2_adj.metatable_GodAxInfo
--endregion

---@param tbl chatV2.GodAxInfo 待调整的table数据
function chatV2_adj.AdjustGodAxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_GodAxInfo)
    if tbl.godAxId == nil then
        tbl.godAxIdSpecified = false
        tbl.godAxId = 0
    else
        tbl.godAxIdSpecified = true
    end
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
end

--region metatable chatV2.ShenZhuangInfo
---@type chatV2.ShenZhuangInfo
chatV2_adj.metatable_ShenZhuangInfo = {
    _ClassName = "chatV2.ShenZhuangInfo",
}
chatV2_adj.metatable_ShenZhuangInfo.__index = chatV2_adj.metatable_ShenZhuangInfo
--endregion

---@param tbl chatV2.ShenZhuangInfo 待调整的table数据
function chatV2_adj.AdjustShenZhuangInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ShenZhuangInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable chatV2.RingInfo
---@type chatV2.RingInfo
chatV2_adj.metatable_RingInfo = {
    _ClassName = "chatV2.RingInfo",
}
chatV2_adj.metatable_RingInfo.__index = chatV2_adj.metatable_RingInfo
--endregion

---@param tbl chatV2.RingInfo 待调整的table数据
function chatV2_adj.AdjustRingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_RingInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable chatV2.HeroInfo
---@type chatV2.HeroInfo
chatV2_adj.metatable_HeroInfo = {
    _ClassName = "chatV2.HeroInfo",
}
chatV2_adj.metatable_HeroInfo.__index = chatV2_adj.metatable_HeroInfo
--endregion

---@param tbl chatV2.HeroInfo 待调整的table数据
function chatV2_adj.AdjustHeroInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_HeroInfo)
    if tbl.windId == nil then
        tbl.windIdSpecified = false
        tbl.windId = 0
    else
        tbl.windIdSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.fashionTitle == nil then
        tbl.fashionTitleSpecified = false
        tbl.fashionTitle = 0
    else
        tbl.fashionTitleSpecified = true
    end
    if tbl.fashionCloth == nil then
        tbl.fashionClothSpecified = false
        tbl.fashionCloth = 0
    else
        tbl.fashionClothSpecified = true
    end
    if tbl.fashionWeapon == nil then
        tbl.fashionWeaponSpecified = false
        tbl.fashionWeapon = 0
    else
        tbl.fashionWeaponSpecified = true
    end
    if tbl.fashionWing == nil then
        tbl.fashionWingSpecified = false
        tbl.fashionWing = 0
    else
        tbl.fashionWingSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
    if tbl.number == nil then
        tbl.numberSpecified = false
        tbl.number = 0
    else
        tbl.numberSpecified = true
    end
    if tbl.playerAttribute == nil then
        tbl.playerAttributeSpecified = false
        tbl.playerAttribute = nil
    else
        if tbl.playerAttributeSpecified == nil then 
            tbl.playerAttributeSpecified = true
            if chatV2_adj.AdjustAttributeInfo ~= nil then
                chatV2_adj.AdjustAttributeInfo(tbl.playerAttribute)
            end
        end
    end
    if tbl.equipItemBeanList == nil then
        tbl.equipItemBeanList = {}
    else
        if chatV2_adj.AdjustEquipItemInfo ~= nil then
            for i = 1, #tbl.equipItemBeanList do
                chatV2_adj.AdjustEquipItemInfo(tbl.equipItemBeanList[i])
            end
        end
    end
    if tbl.strengthList == nil then
        tbl.strengthList = {}
    end
    if tbl.lbList == nil then
        tbl.lbList = {}
    else
        if chatV2_adj.AdjustLingBaoInfo ~= nil then
            for i = 1, #tbl.lbList do
                chatV2_adj.AdjustLingBaoInfo(tbl.lbList[i])
            end
        end
    end
    if tbl.ringList == nil then
        tbl.ringList = {}
    else
        if chatV2_adj.AdjustRingInfo ~= nil then
            for i = 1, #tbl.ringList do
                chatV2_adj.AdjustRingInfo(tbl.ringList[i])
            end
        end
    end
    if tbl.szList == nil then
        tbl.szList = {}
    else
        if chatV2_adj.AdjustShenZhuangInfo ~= nil then
            for i = 1, #tbl.szList do
                chatV2_adj.AdjustShenZhuangInfo(tbl.szList[i])
            end
        end
    end
    if tbl.szFightPower == nil then
        tbl.szFightPowerSpecified = false
        tbl.szFightPower = 0
    else
        tbl.szFightPowerSpecified = true
    end
    if tbl.szSuit == nil then
        tbl.szSuitSpecified = false
        tbl.szSuit = 0
    else
        tbl.szSuitSpecified = true
    end
    if tbl.szCount == nil then
        tbl.szCountSpecified = false
        tbl.szCount = 0
    else
        tbl.szCountSpecified = true
    end
    if tbl.treasureEquipInfo == nil then
        tbl.treasureEquipInfoSpecified = false
        tbl.treasureEquipInfo = nil
    else
        if tbl.treasureEquipInfoSpecified == nil then 
            tbl.treasureEquipInfoSpecified = true
            if chatV2_adj.AdjustTreasureEquipInfo ~= nil then
                chatV2_adj.AdjustTreasureEquipInfo(tbl.treasureEquipInfo)
            end
        end
    end
    if tbl.legacyEquipInfo == nil then
        tbl.legacyEquipInfoSpecified = false
        tbl.legacyEquipInfo = nil
    else
        if tbl.legacyEquipInfoSpecified == nil then 
            tbl.legacyEquipInfoSpecified = true
            if chatV2_adj.AdjustLegacyEquipInfo ~= nil then
                chatV2_adj.AdjustLegacyEquipInfo(tbl.legacyEquipInfo)
            end
        end
    end
    if tbl.scoreInfo == nil then
        tbl.scoreInfoSpecified = false
        tbl.scoreInfo = nil
    else
        if tbl.scoreInfoSpecified == nil then 
            tbl.scoreInfoSpecified = true
            if chatV2_adj.AdjustScoreInfo ~= nil then
                chatV2_adj.AdjustScoreInfo(tbl.scoreInfo)
            end
        end
    end
    if tbl.lianHunEquipInfo == nil then
        tbl.lianHunEquipInfoSpecified = false
        tbl.lianHunEquipInfo = nil
    else
        if tbl.lianHunEquipInfoSpecified == nil then 
            tbl.lianHunEquipInfoSpecified = true
            if chatV2_adj.AdjustLianHunEquipInfo ~= nil then
                chatV2_adj.AdjustLianHunEquipInfo(tbl.lianHunEquipInfo)
            end
        end
    end
    if tbl.dragonEquipList == nil then
        tbl.dragonEquipList = {}
    else
        if chatV2_adj.AdjustDragonEquipInfo ~= nil then
            for i = 1, #tbl.dragonEquipList do
                chatV2_adj.AdjustDragonEquipInfo(tbl.dragonEquipList[i])
            end
        end
    end
    if tbl.zhuZaiInfo == nil then
        tbl.zhuZaiInfoSpecified = false
        tbl.zhuZaiInfo = nil
    else
        if tbl.zhuZaiInfoSpecified == nil then 
            tbl.zhuZaiInfoSpecified = true
            if chatV2_adj.AdjustZhuZaiInfo ~= nil then
                chatV2_adj.AdjustZhuZaiInfo(tbl.zhuZaiInfo)
            end
        end
    end
    if tbl.godSwordLegendsLv == nil then
        tbl.godSwordLegendsLvSpecified = false
        tbl.godSwordLegendsLv = 0
    else
        tbl.godSwordLegendsLvSpecified = true
    end
    if tbl.godArmorLegendsLv == nil then
        tbl.godArmorLegendsLvSpecified = false
        tbl.godArmorLegendsLv = 0
    else
        tbl.godArmorLegendsLvSpecified = true
    end
    if tbl.leiShenInfo == nil then
        tbl.leiShenInfoSpecified = false
        tbl.leiShenInfo = nil
    else
        if tbl.leiShenInfoSpecified == nil then 
            tbl.leiShenInfoSpecified = true
            if chatV2_adj.AdjustLeiShenInfo ~= nil then
                chatV2_adj.AdjustLeiShenInfo(tbl.leiShenInfo)
            end
        end
    end
end

--region metatable chatV2.ChatItemInfo
---@type chatV2.ChatItemInfo
chatV2_adj.metatable_ChatItemInfo = {
    _ClassName = "chatV2.ChatItemInfo",
}
chatV2_adj.metatable_ChatItemInfo.__index = chatV2_adj.metatable_ChatItemInfo
--endregion

---@param tbl chatV2.ChatItemInfo 待调整的table数据
function chatV2_adj.AdjustChatItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ChatItemInfo)
    if tbl.uniqueId == nil then
        tbl.uniqueIdSpecified = false
        tbl.uniqueId = 0
    else
        tbl.uniqueIdSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.attType == nil then
        tbl.attTypeSpecified = false
        tbl.attType = 0
    else
        tbl.attTypeSpecified = true
    end
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
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.jiPinInfo == nil then
        tbl.jiPinInfoSpecified = false
        tbl.jiPinInfo = nil
    else
        if tbl.jiPinInfoSpecified == nil then 
            tbl.jiPinInfoSpecified = true
            if chatV2_adj.AdjustJiPinInfo ~= nil then
                chatV2_adj.AdjustJiPinInfo(tbl.jiPinInfo)
            end
        end
    end
end

--region metatable chatV2.TreasureInfo
---@type chatV2.TreasureInfo
chatV2_adj.metatable_TreasureInfo = {
    _ClassName = "chatV2.TreasureInfo",
}
chatV2_adj.metatable_TreasureInfo.__index = chatV2_adj.metatable_TreasureInfo
--endregion

---@param tbl chatV2.TreasureInfo 待调整的table数据
function chatV2_adj.AdjustTreasureInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_TreasureInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
    if tbl.heroId == nil then
        tbl.heroIdSpecified = false
        tbl.heroId = 0
    else
        tbl.heroIdSpecified = true
    end
end

--region metatable chatV2.HistoryInfo
---@type chatV2.HistoryInfo
chatV2_adj.metatable_HistoryInfo = {
    _ClassName = "chatV2.HistoryInfo",
}
chatV2_adj.metatable_HistoryInfo.__index = chatV2_adj.metatable_HistoryInfo
--endregion

---@param tbl chatV2.HistoryInfo 待调整的table数据
function chatV2_adj.AdjustHistoryInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_HistoryInfo)
    if tbl.content == nil then
        tbl.contentSpecified = false
        tbl.content = ""
    else
        tbl.contentSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.otherMsgInfo == nil then
        tbl.otherMsgInfoSpecified = false
        tbl.otherMsgInfo = nil
    else
        if tbl.otherMsgInfoSpecified == nil then 
            tbl.otherMsgInfoSpecified = true
            if chatV2_adj.AdjustOtherMsgInfo ~= nil then
                chatV2_adj.AdjustOtherMsgInfo(tbl.otherMsgInfo)
            end
        end
    end
    if tbl.chatItemInfos == nil then
        tbl.chatItemInfos = {}
    else
        if chatV2_adj.AdjustChatItemInfo ~= nil then
            for i = 1, #tbl.chatItemInfos do
                chatV2_adj.AdjustChatItemInfo(tbl.chatItemInfos[i])
            end
        end
    end
end

--region metatable chatV2.DragonEquipInfo
---@type chatV2.DragonEquipInfo
chatV2_adj.metatable_DragonEquipInfo = {
    _ClassName = "chatV2.DragonEquipInfo",
}
chatV2_adj.metatable_DragonEquipInfo.__index = chatV2_adj.metatable_DragonEquipInfo
--endregion

---@param tbl chatV2.DragonEquipInfo 待调整的table数据
function chatV2_adj.AdjustDragonEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_DragonEquipInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
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
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.bind == nil then
        tbl.bindSpecified = false
        tbl.bind = false
    else
        tbl.bindSpecified = true
    end
    if tbl.extraType == nil then
        tbl.extraType = {}
    end
    if tbl.extraVlaue == nil then
        tbl.extraVlaue = {}
    end
    if tbl.bestAttInfo == nil then
        tbl.bestAttInfoSpecified = false
        tbl.bestAttInfo = nil
    else
        if tbl.bestAttInfoSpecified == nil then 
            tbl.bestAttInfoSpecified = true
            if chatV2_adj.AdjustBestAttInfo ~= nil then
                chatV2_adj.AdjustBestAttInfo(tbl.bestAttInfo)
            end
        end
    end
    if tbl.jiPinInfo == nil then
        tbl.jiPinInfoSpecified = false
        tbl.jiPinInfo = nil
    else
        if tbl.jiPinInfoSpecified == nil then 
            tbl.jiPinInfoSpecified = true
            if chatV2_adj.AdjustJiPinInfo ~= nil then
                chatV2_adj.AdjustJiPinInfo(tbl.jiPinInfo)
            end
        end
    end
end

--region metatable chatV2.ReqGM
---@type chatV2.ReqGM
chatV2_adj.metatable_ReqGM = {
    _ClassName = "chatV2.ReqGM",
}
chatV2_adj.metatable_ReqGM.__index = chatV2_adj.metatable_ReqGM
--endregion

---@param tbl chatV2.ReqGM 待调整的table数据
function chatV2_adj.AdjustReqGM(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ReqGM)
    if tbl.command == nil then
        tbl.commandSpecified = false
        tbl.command = ""
    else
        tbl.commandSpecified = true
    end
end

--region metatable chatV2.ResGM
---@type chatV2.ResGM
chatV2_adj.metatable_ResGM = {
    _ClassName = "chatV2.ResGM",
}
chatV2_adj.metatable_ResGM.__index = chatV2_adj.metatable_ResGM
--endregion

---@param tbl chatV2.ResGM 待调整的table数据
function chatV2_adj.AdjustResGM(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ResGM)
    if tbl.content == nil then
        tbl.contentSpecified = false
        tbl.content = ""
    else
        tbl.contentSpecified = true
    end
end

--region metatable chatV2.ReqChat
---@type chatV2.ReqChat
chatV2_adj.metatable_ReqChat = {
    _ClassName = "chatV2.ReqChat",
}
chatV2_adj.metatable_ReqChat.__index = chatV2_adj.metatable_ReqChat
--endregion

---@param tbl chatV2.ReqChat 待调整的table数据
function chatV2_adj.AdjustReqChat(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ReqChat)
    if tbl.channel == nil then
        tbl.channelSpecified = false
        tbl.channel = 0
    else
        tbl.channelSpecified = true
    end
    if tbl.message == nil then
        tbl.messageSpecified = false
        tbl.message = ""
    else
        tbl.messageSpecified = true
    end
    if tbl.privateRoleId == nil then
        tbl.privateRoleIdSpecified = false
        tbl.privateRoleId = 0
    else
        tbl.privateRoleIdSpecified = true
    end
    if tbl.sound == nil then
        tbl.soundSpecified = false
        tbl.sound = false
    else
        tbl.soundSpecified = true
    end
    if tbl.sendToName == nil then
        tbl.sendToNameSpecified = false
        tbl.sendToName = ""
    else
        tbl.sendToNameSpecified = true
    end
    if tbl.quickChatId == nil then
        tbl.quickChatIdSpecified = false
        tbl.quickChatId = 0
    else
        tbl.quickChatIdSpecified = true
    end
end

--region metatable chatV2.ResChat
---@type chatV2.ResChat
chatV2_adj.metatable_ResChat = {
    _ClassName = "chatV2.ResChat",
}
chatV2_adj.metatable_ResChat.__index = chatV2_adj.metatable_ResChat
--endregion

---@param tbl chatV2.ResChat 待调整的table数据
function chatV2_adj.AdjustResChat(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ResChat)
    if tbl.senderId == nil then
        tbl.senderIdSpecified = false
        tbl.senderId = 0
    else
        tbl.senderIdSpecified = true
    end
    if tbl.sendName == nil then
        tbl.sendNameSpecified = false
        tbl.sendName = ""
    else
        tbl.sendNameSpecified = true
    end
    if tbl.channel == nil then
        tbl.channelSpecified = false
        tbl.channel = 0
    else
        tbl.channelSpecified = true
    end
    if tbl.message == nil then
        tbl.messageSpecified = false
        tbl.message = ""
    else
        tbl.messageSpecified = true
    end
    if tbl.privateRoleId == nil then
        tbl.privateRoleIdSpecified = false
        tbl.privateRoleId = 0
    else
        tbl.privateRoleIdSpecified = true
    end
    if tbl.isVip == nil then
        tbl.isVipSpecified = false
        tbl.isVip = false
    else
        tbl.isVipSpecified = true
    end
    if tbl.sound == nil then
        tbl.soundSpecified = false
        tbl.sound = false
    else
        tbl.soundSpecified = true
    end
    if tbl.quickChatId == nil then
        tbl.quickChatIdSpecified = false
        tbl.quickChatId = 0
    else
        tbl.quickChatIdSpecified = true
    end
    if tbl.privateName == nil then
        tbl.privateNameSpecified = false
        tbl.privateName = ""
    else
        tbl.privateNameSpecified = true
    end
    if tbl.sendSex == nil then
        tbl.sendSexSpecified = false
        tbl.sendSex = 0
    else
        tbl.sendSexSpecified = true
    end
    if tbl.sendCarre == nil then
        tbl.sendCarreSpecified = false
        tbl.sendCarre = 0
    else
        tbl.sendCarreSpecified = true
    end
    if tbl.privateSex == nil then
        tbl.privateSexSpecified = false
        tbl.privateSex = 0
    else
        tbl.privateSexSpecified = true
    end
    if tbl.privateCarre == nil then
        tbl.privateCarreSpecified = false
        tbl.privateCarre = 0
    else
        tbl.privateCarreSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.roleLettering == nil then
        tbl.roleLetteringSpecified = false
        tbl.roleLettering = ""
    else
        tbl.roleLetteringSpecified = true
    end
    if tbl.isDelete == nil then
        tbl.isDeleteSpecified = false
        tbl.isDelete = 0
    else
        tbl.isDeleteSpecified = true
    end
    if tbl.btnsId == nil then
        tbl.btnsIdSpecified = false
        tbl.btnsId = 0
    else
        tbl.btnsIdSpecified = true
    end
    if tbl.sendItemInfo == nil then
        tbl.sendItemInfoSpecified = false
        tbl.sendItemInfo = nil
    else
        if tbl.sendItemInfoSpecified == nil then 
            tbl.sendItemInfoSpecified = true
            if chatV2_adj.AdjustSenditemInfo ~= nil then
                chatV2_adj.AdjustSenditemInfo(tbl.sendItemInfo)
            end
        end
    end
    if tbl.redBagId == nil then
        tbl.redBagIdSpecified = false
        tbl.redBagId = 0
    else
        tbl.redBagIdSpecified = true
    end
    if tbl.state == nil then
        tbl.state = {}
    else
        if chatV2_adj.AdjustChatRedBagState ~= nil then
            for i = 1, #tbl.state do
                chatV2_adj.AdjustChatRedBagState(tbl.state[i])
            end
        end
    end
    if tbl.unionPosition == nil then
        tbl.unionPositionSpecified = false
        tbl.unionPosition = 0
    else
        tbl.unionPositionSpecified = true
    end
    if tbl.onlySelfView == nil then
        tbl.onlySelfViewSpecified = false
        tbl.onlySelfView = 0
    else
        tbl.onlySelfViewSpecified = true
    end
    if tbl.remoteHostId == nil then
        tbl.remoteHostIdSpecified = false
        tbl.remoteHostId = 0
    else
        tbl.remoteHostIdSpecified = true
    end
    if tbl.remote == nil then
        tbl.remoteSpecified = false
        tbl.remote = 0
    else
        tbl.remoteSpecified = true
    end
    if tbl.targetHostId == nil then
        tbl.targetHostIdSpecified = false
        tbl.targetHostId = 0
    else
        tbl.targetHostIdSpecified = true
    end
end

--region metatable chatV2.ChatRedBagState
---@type chatV2.ChatRedBagState
chatV2_adj.metatable_ChatRedBagState = {
    _ClassName = "chatV2.ChatRedBagState",
}
chatV2_adj.metatable_ChatRedBagState.__index = chatV2_adj.metatable_ChatRedBagState
--endregion

---@param tbl chatV2.ChatRedBagState 待调整的table数据
function chatV2_adj.AdjustChatRedBagState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ChatRedBagState)
    if tbl.roleid == nil then
        tbl.roleidSpecified = false
        tbl.roleid = 0
    else
        tbl.roleidSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable chatV2.SenditemInfo
---@type chatV2.SenditemInfo
chatV2_adj.metatable_SenditemInfo = {
    _ClassName = "chatV2.SenditemInfo",
}
chatV2_adj.metatable_SenditemInfo.__index = chatV2_adj.metatable_SenditemInfo
--endregion

---@param tbl chatV2.SenditemInfo 待调整的table数据
function chatV2_adj.AdjustSenditemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_SenditemInfo)
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

--region metatable chatV2.ReqLookOther
---@type chatV2.ReqLookOther
chatV2_adj.metatable_ReqLookOther = {
    _ClassName = "chatV2.ReqLookOther",
}
chatV2_adj.metatable_ReqLookOther.__index = chatV2_adj.metatable_ReqLookOther
--endregion

---@param tbl chatV2.ReqLookOther 待调整的table数据
function chatV2_adj.AdjustReqLookOther(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ReqLookOther)
    if tbl.targetUid == nil then
        tbl.targetUidSpecified = false
        tbl.targetUid = 0
    else
        tbl.targetUidSpecified = true
    end
end

--region metatable chatV2.ResLookOther
---@type chatV2.ResLookOther
chatV2_adj.metatable_ResLookOther = {
    _ClassName = "chatV2.ResLookOther",
}
chatV2_adj.metatable_ResLookOther.__index = chatV2_adj.metatable_ResLookOther
--endregion

---@param tbl chatV2.ResLookOther 待调整的table数据
function chatV2_adj.AdjustResLookOther(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ResLookOther)
    if tbl.roleInfo == nil then
        tbl.roleInfoSpecified = false
        tbl.roleInfo = nil
    else
        if tbl.roleInfoSpecified == nil then 
            tbl.roleInfoSpecified = true
            if chatV2_adj.AdjustRoleInfo ~= nil then
                chatV2_adj.AdjustRoleInfo(tbl.roleInfo)
            end
        end
    end
    if tbl.heroInfoList == nil then
        tbl.heroInfoList = {}
    else
        if chatV2_adj.AdjustHeroInfo ~= nil then
            for i = 1, #tbl.heroInfoList do
                chatV2_adj.AdjustHeroInfo(tbl.heroInfoList[i])
            end
        end
    end
end

--region metatable chatV2.ResAnnounce
---@type chatV2.ResAnnounce
chatV2_adj.metatable_ResAnnounce = {
    _ClassName = "chatV2.ResAnnounce",
}
chatV2_adj.metatable_ResAnnounce.__index = chatV2_adj.metatable_ResAnnounce
--endregion

---@param tbl chatV2.ResAnnounce 待调整的table数据
function chatV2_adj.AdjustResAnnounce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ResAnnounce)
    if tbl.params == nil then
        tbl.params = {}
    end
    if tbl.announce == nil then
        tbl.announceSpecified = false
        tbl.announce = ""
    else
        tbl.announceSpecified = true
    end
    if tbl.showType == nil then
        tbl.showType = {}
    end
    if tbl.remarks == nil then
        tbl.remarksSpecified = false
        tbl.remarks = ""
    else
        tbl.remarksSpecified = true
    end
    if tbl.frequency == nil then
        tbl.frequencySpecified = false
        tbl.frequency = 0
    else
        tbl.frequencySpecified = true
    end
    if tbl.cd == nil then
        tbl.cdSpecified = false
        tbl.cd = 0
    else
        tbl.cdSpecified = true
    end
    if tbl.minLevel == nil then
        tbl.minLevelSpecified = false
        tbl.minLevel = 0
    else
        tbl.minLevelSpecified = true
    end
    if tbl.timeType == nil then
        tbl.timeTypeSpecified = false
        tbl.timeType = 0
    else
        tbl.timeTypeSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = ""
    else
        tbl.paramSpecified = true
    end
    if tbl.seenType == nil then
        tbl.seenTypeSpecified = false
        tbl.seenType = 0
    else
        tbl.seenTypeSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapId = {}
    end
    if tbl.minRein == nil then
        tbl.minReinSpecified = false
        tbl.minRein = 0
    else
        tbl.minReinSpecified = true
    end
    if tbl.maxRein == nil then
        tbl.maxReinSpecified = false
        tbl.maxRein = 0
    else
        tbl.maxReinSpecified = true
    end
    if tbl.alwaysSeen == nil then
        tbl.alwaysSeenSpecified = false
        tbl.alwaysSeen = 0
    else
        tbl.alwaysSeenSpecified = true
    end
    if tbl.maxLevel == nil then
        tbl.maxLevelSpecified = false
        tbl.maxLevel = 0
    else
        tbl.maxLevelSpecified = true
    end
    if tbl.monsterType == nil then
        tbl.monsterTypeSpecified = false
        tbl.monsterType = 0
    else
        tbl.monsterTypeSpecified = true
    end
    if tbl.monsterLevel == nil then
        tbl.monsterLevelSpecified = false
        tbl.monsterLevel = 0
    else
        tbl.monsterLevelSpecified = true
    end
end

--region metatable chatV2.ReqPullChatHistory
---@type chatV2.ReqPullChatHistory
chatV2_adj.metatable_ReqPullChatHistory = {
    _ClassName = "chatV2.ReqPullChatHistory",
}
chatV2_adj.metatable_ReqPullChatHistory.__index = chatV2_adj.metatable_ReqPullChatHistory
--endregion

---@param tbl chatV2.ReqPullChatHistory 待调整的table数据
function chatV2_adj.AdjustReqPullChatHistory(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ReqPullChatHistory)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable chatV2.ResPullChatHistory
---@type chatV2.ResPullChatHistory
chatV2_adj.metatable_ResPullChatHistory = {
    _ClassName = "chatV2.ResPullChatHistory",
}
chatV2_adj.metatable_ResPullChatHistory.__index = chatV2_adj.metatable_ResPullChatHistory
--endregion

---@param tbl chatV2.ResPullChatHistory 待调整的table数据
function chatV2_adj.AdjustResPullChatHistory(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ResPullChatHistory)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.pulledMsgs == nil then
        tbl.pulledMsgs = {}
    else
        if chatV2_adj.AdjustHistoryInfo ~= nil then
            for i = 1, #tbl.pulledMsgs do
                chatV2_adj.AdjustHistoryInfo(tbl.pulledMsgs[i])
            end
        end
    end
end

--region metatable chatV2.ReqSendSpecialAnnounce
---@type chatV2.ReqSendSpecialAnnounce
chatV2_adj.metatable_ReqSendSpecialAnnounce = {
    _ClassName = "chatV2.ReqSendSpecialAnnounce",
}
chatV2_adj.metatable_ReqSendSpecialAnnounce.__index = chatV2_adj.metatable_ReqSendSpecialAnnounce
--endregion

---@param tbl chatV2.ReqSendSpecialAnnounce 待调整的table数据
function chatV2_adj.AdjustReqSendSpecialAnnounce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ReqSendSpecialAnnounce)
    if tbl.announceId == nil then
        tbl.announceIdSpecified = false
        tbl.announceId = 0
    else
        tbl.announceIdSpecified = true
    end
    if tbl.channelType == nil then
        tbl.channelTypeSpecified = false
        tbl.channelType = 0
    else
        tbl.channelTypeSpecified = true
    end
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
end

--region metatable chatV2.ReqBtnsReply
---@type chatV2.ReqBtnsReply
chatV2_adj.metatable_ReqBtnsReply = {
    _ClassName = "chatV2.ReqBtnsReply",
}
chatV2_adj.metatable_ReqBtnsReply.__index = chatV2_adj.metatable_ReqBtnsReply
--endregion

---@param tbl chatV2.ReqBtnsReply 待调整的table数据
function chatV2_adj.AdjustReqBtnsReply(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ReqBtnsReply)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.senderId == nil then
        tbl.senderIdSpecified = false
        tbl.senderId = 0
    else
        tbl.senderIdSpecified = true
    end
    if tbl.toRid == nil then
        tbl.toRidSpecified = false
        tbl.toRid = 0
    else
        tbl.toRidSpecified = true
    end
end

--region metatable chatV2.ResHuntAnnounceHistory
---@type chatV2.ResHuntAnnounceHistory
chatV2_adj.metatable_ResHuntAnnounceHistory = {
    _ClassName = "chatV2.ResHuntAnnounceHistory",
}
chatV2_adj.metatable_ResHuntAnnounceHistory.__index = chatV2_adj.metatable_ResHuntAnnounceHistory
--endregion

---@param tbl chatV2.ResHuntAnnounceHistory 待调整的table数据
function chatV2_adj.AdjustResHuntAnnounceHistory(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ResHuntAnnounceHistory)
    if tbl.info == nil then
        tbl.info = {}
    end
end

--region metatable chatV2.ResHuntAnnounceUpdate
---@type chatV2.ResHuntAnnounceUpdate
chatV2_adj.metatable_ResHuntAnnounceUpdate = {
    _ClassName = "chatV2.ResHuntAnnounceUpdate",
}
chatV2_adj.metatable_ResHuntAnnounceUpdate.__index = chatV2_adj.metatable_ResHuntAnnounceUpdate
--endregion

---@param tbl chatV2.ResHuntAnnounceUpdate 待调整的table数据
function chatV2_adj.AdjustResHuntAnnounceUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, chatV2_adj.metatable_ResHuntAnnounceUpdate)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = ""
    else
        tbl.infoSpecified = true
    end
end

return chatV2_adj