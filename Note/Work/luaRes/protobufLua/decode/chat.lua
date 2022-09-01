--[[本文件为工具自动生成,禁止手动修改]]
local chatV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData chatV2.OtherMsgInfo lua中的数据结构
---@return chatV2.OtherMsgInfo C#中的数据结构
function chatV2.OtherMsgInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.OtherMsgInfo()
    if decodedData.targetUid ~= nil and decodedData.targetUidSpecified ~= false then
        data.targetUid = decodedData.targetUid
    end
    if decodedData.sendUid ~= nil and decodedData.sendUidSpecified ~= false then
        data.sendUid = decodedData.sendUid
    end
    if decodedData.sendName ~= nil and decodedData.sendNameSpecified ~= false then
        data.sendName = decodedData.sendName
    end
    if decodedData.receivedUid ~= nil and decodedData.receivedUidSpecified ~= false then
        data.receivedUid = decodedData.receivedUid
    end
    if decodedData.receivedName ~= nil and decodedData.receivedNameSpecified ~= false then
        data.receivedName = decodedData.receivedName
    end
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.vipLevel ~= nil and decodedData.vipLevelSpecified ~= false then
        data.vipLevel = decodedData.vipLevel
    end
    if decodedData.isMonthCard ~= nil and decodedData.isMonthCardSpecified ~= false then
        data.isMonthCard = decodedData.isMonthCard
    end
    return data
end

---@param decodedData chatV2.AttributeInfo lua中的数据结构
---@return chatV2.AttributeInfo C#中的数据结构
function chatV2.AttributeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.AttributeInfo()
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

---@param decodedData chatV2.EquipItemInfo lua中的数据结构
---@return chatV2.EquipItemInfo C#中的数据结构
function chatV2.EquipItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.EquipItemInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.bestAttInfo ~= nil and decodedData.bestAttInfoSpecified ~= false then
        data.bestAttInfo = chatV2.BestAttInfo(decodedData.bestAttInfo)
    end
    if decodedData.jiPinInfo ~= nil and decodedData.jiPinInfoSpecified ~= false then
        data.jiPinInfo = chatV2.JiPinInfo(decodedData.jiPinInfo)
    end
    if decodedData.niePanLv ~= nil and decodedData.niePanLvSpecified ~= false then
        data.niePanLv = decodedData.niePanLv
    end
    return data
end

---@param decodedData chatV2.BestAttInfo lua中的数据结构
---@return chatV2.BestAttInfo C#中的数据结构
function chatV2.BestAttInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.BestAttInfo()
    if decodedData.attId ~= nil and decodedData.attIdSpecified ~= false then
        data.attId = decodedData.attId
    end
    if decodedData.attType ~= nil and decodedData.attTypeSpecified ~= false then
        data.attType = decodedData.attType
    end
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

---@param decodedData chatV2.LingBaoInfo lua中的数据结构
---@return chatV2.LingBaoInfo C#中的数据结构
function chatV2.LingBaoInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.LingBaoInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.uniqueId ~= nil and decodedData.uniqueIdSpecified ~= false then
        data.uniqueId = decodedData.uniqueId
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
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

---@param decodedData chatV2.JiPinInfo lua中的数据结构
---@return chatV2.JiPinInfo C#中的数据结构
function chatV2.JiPinInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.JiPinInfo()
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

---@param decodedData chatV2.ScoreInfo lua中的数据结构
---@return chatV2.ScoreInfo C#中的数据结构
function chatV2.ScoreInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ScoreInfo()
    if decodedData.equipScore ~= nil and decodedData.equipScoreSpecified ~= false then
        data.equipScore = decodedData.equipScore
    end
    if decodedData.xzScore ~= nil and decodedData.xzScoreSpecified ~= false then
        data.xzScore = decodedData.xzScore
    end
    if decodedData.szScore ~= nil and decodedData.szScoreSpecified ~= false then
        data.szScore = decodedData.szScore
    end
    if decodedData.lzScore ~= nil and decodedData.lzScoreSpecified ~= false then
        data.lzScore = decodedData.lzScore
    end
    return data
end

---@param decodedData chatV2.RoleInfo lua中的数据结构
---@return chatV2.RoleInfo C#中的数据结构
function chatV2.RoleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.RoleInfo()
    if decodedData.windId ~= nil and decodedData.windIdSpecified ~= false then
        data.windId = decodedData.windId
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.fashionTitle ~= nil and decodedData.fashionTitleSpecified ~= false then
        data.fashionTitle = decodedData.fashionTitle
    end
    if decodedData.fashionCloth ~= nil and decodedData.fashionClothSpecified ~= false then
        data.fashionCloth = decodedData.fashionCloth
    end
    if decodedData.fashionWeapon ~= nil and decodedData.fashionWeaponSpecified ~= false then
        data.fashionWeapon = decodedData.fashionWeapon
    end
    if decodedData.fashionWing ~= nil and decodedData.fashionWingSpecified ~= false then
        data.fashionWing = decodedData.fashionWing
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    if decodedData.playerAttribute ~= nil and decodedData.playerAttributeSpecified ~= false then
        data.playerAttribute = chatV2.AttributeInfo(decodedData.playerAttribute)
    end
    if decodedData.equipItemBeanList ~= nil and decodedData.equipItemBeanListSpecified ~= false then
        for i = 1, #decodedData.equipItemBeanList do
            data.equipItemBeanList:Add(chatV2.EquipItemInfo(decodedData.equipItemBeanList[i]))
        end
    end
    if decodedData.strengthList ~= nil and decodedData.strengthListSpecified ~= false then
        for i = 1, #decodedData.strengthList do
            data.strengthList:Add(decodedData.strengthList[i])
        end
    end
    if decodedData.szList ~= nil and decodedData.szListSpecified ~= false then
        for i = 1, #decodedData.szList do
            data.szList:Add(chatV2.ShenZhuangInfo(decodedData.szList[i]))
        end
    end
    if decodedData.szFightPower ~= nil and decodedData.szFightPowerSpecified ~= false then
        data.szFightPower = decodedData.szFightPower
    end
    if decodedData.szSuit ~= nil and decodedData.szSuitSpecified ~= false then
        data.szSuit = decodedData.szSuit
    end
    if decodedData.szCount ~= nil and decodedData.szCountSpecified ~= false then
        data.szCount = decodedData.szCount
    end
    if decodedData.lbList ~= nil and decodedData.lbListSpecified ~= false then
        for i = 1, #decodedData.lbList do
            data.lbList:Add(chatV2.LingBaoInfo(decodedData.lbList[i]))
        end
    end
    if decodedData.ringList ~= nil and decodedData.ringListSpecified ~= false then
        for i = 1, #decodedData.ringList do
            data.ringList:Add(chatV2.RingInfo(decodedData.ringList[i]))
        end
    end
    if decodedData.treasureInfo ~= nil and decodedData.treasureInfoSpecified ~= false then
        data.treasureInfo = chatV2.TreasureInfo(decodedData.treasureInfo)
    end
    if decodedData.godAxInfo ~= nil and decodedData.godAxInfoSpecified ~= false then
        data.godAxInfo = chatV2.GodAxInfo(decodedData.godAxInfo)
    end
    if decodedData.legacyEquipInfo ~= nil and decodedData.legacyEquipInfoSpecified ~= false then
        data.legacyEquipInfo = chatV2.LegacyEquipInfo(decodedData.legacyEquipInfo)
    end
    if decodedData.runesInfo ~= nil and decodedData.runesInfoSpecified ~= false then
        data.runesInfo = chatV2.RunesInfo(decodedData.runesInfo)
    end
    if decodedData.scoreInfo ~= nil and decodedData.scoreInfoSpecified ~= false then
        data.scoreInfo = chatV2.ScoreInfo(decodedData.scoreInfo)
    end
    if decodedData.lianHunEquipInfo ~= nil and decodedData.lianHunEquipInfoSpecified ~= false then
        data.lianHunEquipInfo = chatV2.LianHunEquipInfo(decodedData.lianHunEquipInfo)
    end
    if decodedData.dragonEquipList ~= nil and decodedData.dragonEquipListSpecified ~= false then
        for i = 1, #decodedData.dragonEquipList do
            data.dragonEquipList:Add(chatV2.DragonEquipInfo(decodedData.dragonEquipList[i]))
        end
    end
    if decodedData.shouhuId ~= nil and decodedData.shouhuIdSpecified ~= false then
        data.shouhuId = decodedData.shouhuId
    end
    if decodedData.zhuZaiInfo ~= nil and decodedData.zhuZaiInfoSpecified ~= false then
        data.zhuZaiInfo = chatV2.ZhuZaiInfo(decodedData.zhuZaiInfo)
    end
    if decodedData.godSwordLegendsLv ~= nil and decodedData.godSwordLegendsLvSpecified ~= false then
        data.godSwordLegendsLv = decodedData.godSwordLegendsLv
    end
    if decodedData.godArmorLegendsLv ~= nil and decodedData.godArmorLegendsLvSpecified ~= false then
        data.godArmorLegendsLv = decodedData.godArmorLegendsLv
    end
    if decodedData.leiShenInfo ~= nil and decodedData.leiShenInfoSpecified ~= false then
        data.leiShenInfo = chatV2.LeiShenInfo(decodedData.leiShenInfo)
    end
    return data
end

---@param decodedData chatV2.LeiShenInfo lua中的数据结构
---@return chatV2.LeiShenInfo C#中的数据结构
function chatV2.LeiShenInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.LeiShenInfo()
    if decodedData.leiShenEquipInfo ~= nil and decodedData.leiShenEquipInfoSpecified ~= false then
        for i = 1, #decodedData.leiShenEquipInfo do
            data.leiShenEquipInfo:Add(chatV2.LeiShenEquipInfo(decodedData.leiShenEquipInfo[i]))
        end
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData chatV2.LeiShenEquipInfo lua中的数据结构
---@return chatV2.LeiShenEquipInfo C#中的数据结构
function chatV2.LeiShenEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.LeiShenEquipInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData chatV2.ZhuZaiInfo lua中的数据结构
---@return chatV2.ZhuZaiInfo C#中的数据结构
function chatV2.ZhuZaiInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ZhuZaiInfo()
    if decodedData.zhuZaiEquipInfo ~= nil and decodedData.zhuZaiEquipInfoSpecified ~= false then
        for i = 1, #decodedData.zhuZaiEquipInfo do
            data.zhuZaiEquipInfo:Add(chatV2.ZhuZaiEquipInfo(decodedData.zhuZaiEquipInfo[i]))
        end
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData chatV2.ZhuZaiEquipInfo lua中的数据结构
---@return chatV2.ZhuZaiEquipInfo C#中的数据结构
function chatV2.ZhuZaiEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ZhuZaiEquipInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData chatV2.LianHunEquipInfo lua中的数据结构
---@return chatV2.LianHunEquipInfo C#中的数据结构
function chatV2.LianHunEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.LianHunEquipInfo()
    if decodedData.equips ~= nil and decodedData.equipsSpecified ~= false then
        for i = 1, #decodedData.equips do
            data.equips:Add(chatV2.EquipInfo(decodedData.equips[i]))
        end
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData chatV2.EquipInfo lua中的数据结构
---@return chatV2.EquipInfo C#中的数据结构
function chatV2.EquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.EquipInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.bind ~= nil and decodedData.bindSpecified ~= false then
        data.bind = decodedData.bind
    end
    if decodedData.improveLevel ~= nil and decodedData.improveLevelSpecified ~= false then
        data.improveLevel = decodedData.improveLevel
    end
    if decodedData.extraType ~= nil and decodedData.extraTypeSpecified ~= false then
        for i = 1, #decodedData.extraType do
            data.extraType:Add(decodedData.extraType[i])
        end
    end
    if decodedData.extraValue ~= nil and decodedData.extraValueSpecified ~= false then
        for i = 1, #decodedData.extraValue do
            data.extraValue:Add(decodedData.extraValue[i])
        end
    end
    if decodedData.soulUp ~= nil and decodedData.soulUpSpecified ~= false then
        data.soulUp = decodedData.soulUp
    end
    if decodedData.bestAttInfo ~= nil and decodedData.bestAttInfoSpecified ~= false then
        data.bestAttInfo = chatV2.BestAttInfo(decodedData.bestAttInfo)
    end
    if decodedData.JiPinInfo ~= nil and decodedData.JiPinInfoSpecified ~= false then
        data.JiPinInfo = chatV2.JiPinInfo(decodedData.JiPinInfo)
    end
    if decodedData.fuLingLv ~= nil and decodedData.fuLingLvSpecified ~= false then
        data.fuLingLv = decodedData.fuLingLv
    end
    if decodedData.fuLingValue ~= nil and decodedData.fuLingValueSpecified ~= false then
        data.fuLingValue = decodedData.fuLingValue
    end
    if decodedData.hongMengLv ~= nil and decodedData.hongMengLvSpecified ~= false then
        data.hongMengLv = decodedData.hongMengLv
    end
    if decodedData.niePanLv ~= nil and decodedData.niePanLvSpecified ~= false then
        data.niePanLv = decodedData.niePanLv
    end
    return data
end

---@param decodedData chatV2.TreasureEquipInfo lua中的数据结构
---@return chatV2.TreasureEquipInfo C#中的数据结构
function chatV2.TreasureEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.TreasureEquipInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData chatV2.RunesInfos lua中的数据结构
---@return chatV2.RunesInfos C#中的数据结构
function chatV2.RunesInfos(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.RunesInfos()
    if decodedData.runesList ~= nil and decodedData.runesListSpecified ~= false then
        for i = 1, #decodedData.runesList do
            data.runesList:Add(chatV2.RunesInfo(decodedData.runesList[i]))
        end
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData chatV2.RunesInfo lua中的数据结构
---@return chatV2.RunesInfo C#中的数据结构
function chatV2.RunesInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.RunesInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData chatV2.LegacyEquipInfos lua中的数据结构
---@return chatV2.LegacyEquipInfos C#中的数据结构
function chatV2.LegacyEquipInfos(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.LegacyEquipInfos()
    if decodedData.legacyEquipInfo ~= nil and decodedData.legacyEquipInfoSpecified ~= false then
        for i = 1, #decodedData.legacyEquipInfo do
            data.legacyEquipInfo:Add(chatV2.LegacyEquipInfo(decodedData.legacyEquipInfo[i]))
        end
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData chatV2.LegacyEquipInfo lua中的数据结构
---@return chatV2.LegacyEquipInfo C#中的数据结构
function chatV2.LegacyEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.LegacyEquipInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData chatV2.GodAxInfo lua中的数据结构
---@return chatV2.GodAxInfo C#中的数据结构
function chatV2.GodAxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.GodAxInfo()
    if decodedData.godAxId ~= nil and decodedData.godAxIdSpecified ~= false then
        data.godAxId = decodedData.godAxId
    end
    if decodedData.fightValue ~= nil and decodedData.fightValueSpecified ~= false then
        data.fightValue = decodedData.fightValue
    end
    return data
end

---@param decodedData chatV2.ShenZhuangInfo lua中的数据结构
---@return chatV2.ShenZhuangInfo C#中的数据结构
function chatV2.ShenZhuangInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ShenZhuangInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData chatV2.RingInfo lua中的数据结构
---@return chatV2.RingInfo C#中的数据结构
function chatV2.RingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.RingInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData chatV2.HeroInfo lua中的数据结构
---@return chatV2.HeroInfo C#中的数据结构
function chatV2.HeroInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.HeroInfo()
    if decodedData.windId ~= nil and decodedData.windIdSpecified ~= false then
        data.windId = decodedData.windId
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.fashionTitle ~= nil and decodedData.fashionTitleSpecified ~= false then
        data.fashionTitle = decodedData.fashionTitle
    end
    if decodedData.fashionCloth ~= nil and decodedData.fashionClothSpecified ~= false then
        data.fashionCloth = decodedData.fashionCloth
    end
    if decodedData.fashionWeapon ~= nil and decodedData.fashionWeaponSpecified ~= false then
        data.fashionWeapon = decodedData.fashionWeapon
    end
    if decodedData.fashionWing ~= nil and decodedData.fashionWingSpecified ~= false then
        data.fashionWing = decodedData.fashionWing
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    if decodedData.number ~= nil and decodedData.numberSpecified ~= false then
        data.number = decodedData.number
    end
    if decodedData.playerAttribute ~= nil and decodedData.playerAttributeSpecified ~= false then
        data.playerAttribute = chatV2.AttributeInfo(decodedData.playerAttribute)
    end
    if decodedData.equipItemBeanList ~= nil and decodedData.equipItemBeanListSpecified ~= false then
        for i = 1, #decodedData.equipItemBeanList do
            data.equipItemBeanList:Add(chatV2.EquipItemInfo(decodedData.equipItemBeanList[i]))
        end
    end
    if decodedData.strengthList ~= nil and decodedData.strengthListSpecified ~= false then
        for i = 1, #decodedData.strengthList do
            data.strengthList:Add(decodedData.strengthList[i])
        end
    end
    if decodedData.lbList ~= nil and decodedData.lbListSpecified ~= false then
        for i = 1, #decodedData.lbList do
            data.lbList:Add(chatV2.LingBaoInfo(decodedData.lbList[i]))
        end
    end
    if decodedData.ringList ~= nil and decodedData.ringListSpecified ~= false then
        for i = 1, #decodedData.ringList do
            data.ringList:Add(chatV2.RingInfo(decodedData.ringList[i]))
        end
    end
    if decodedData.szList ~= nil and decodedData.szListSpecified ~= false then
        for i = 1, #decodedData.szList do
            data.szList:Add(chatV2.ShenZhuangInfo(decodedData.szList[i]))
        end
    end
    if decodedData.szFightPower ~= nil and decodedData.szFightPowerSpecified ~= false then
        data.szFightPower = decodedData.szFightPower
    end
    if decodedData.szSuit ~= nil and decodedData.szSuitSpecified ~= false then
        data.szSuit = decodedData.szSuit
    end
    if decodedData.szCount ~= nil and decodedData.szCountSpecified ~= false then
        data.szCount = decodedData.szCount
    end
    if decodedData.treasureEquipInfo ~= nil and decodedData.treasureEquipInfoSpecified ~= false then
        data.treasureEquipInfo = chatV2.TreasureEquipInfo(decodedData.treasureEquipInfo)
    end
    if decodedData.legacyEquipInfo ~= nil and decodedData.legacyEquipInfoSpecified ~= false then
        data.legacyEquipInfo = chatV2.LegacyEquipInfo(decodedData.legacyEquipInfo)
    end
    if decodedData.scoreInfo ~= nil and decodedData.scoreInfoSpecified ~= false then
        data.scoreInfo = chatV2.ScoreInfo(decodedData.scoreInfo)
    end
    if decodedData.lianHunEquipInfo ~= nil and decodedData.lianHunEquipInfoSpecified ~= false then
        data.lianHunEquipInfo = chatV2.LianHunEquipInfo(decodedData.lianHunEquipInfo)
    end
    if decodedData.dragonEquipList ~= nil and decodedData.dragonEquipListSpecified ~= false then
        for i = 1, #decodedData.dragonEquipList do
            data.dragonEquipList:Add(chatV2.DragonEquipInfo(decodedData.dragonEquipList[i]))
        end
    end
    if decodedData.zhuZaiInfo ~= nil and decodedData.zhuZaiInfoSpecified ~= false then
        data.zhuZaiInfo = chatV2.ZhuZaiInfo(decodedData.zhuZaiInfo)
    end
    if decodedData.godSwordLegendsLv ~= nil and decodedData.godSwordLegendsLvSpecified ~= false then
        data.godSwordLegendsLv = decodedData.godSwordLegendsLv
    end
    if decodedData.godArmorLegendsLv ~= nil and decodedData.godArmorLegendsLvSpecified ~= false then
        data.godArmorLegendsLv = decodedData.godArmorLegendsLv
    end
    if decodedData.leiShenInfo ~= nil and decodedData.leiShenInfoSpecified ~= false then
        data.leiShenInfo = chatV2.LeiShenInfo(decodedData.leiShenInfo)
    end
    return data
end

---@param decodedData chatV2.ChatItemInfo lua中的数据结构
---@return chatV2.ChatItemInfo C#中的数据结构
function chatV2.ChatItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ChatItemInfo()
    if decodedData.uniqueId ~= nil and decodedData.uniqueIdSpecified ~= false then
        data.uniqueId = decodedData.uniqueId
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.attType ~= nil and decodedData.attTypeSpecified ~= false then
        data.attType = decodedData.attType
    end
    if decodedData.attValue ~= nil and decodedData.attValueSpecified ~= false then
        data.attValue = decodedData.attValue
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.configId ~= nil and decodedData.configIdSpecified ~= false then
        data.configId = decodedData.configId
    end
    if decodedData.jiPinInfo ~= nil and decodedData.jiPinInfoSpecified ~= false then
        data.jiPinInfo = chatV2.JiPinInfo(decodedData.jiPinInfo)
    end
    return data
end

---@param decodedData chatV2.TreasureInfo lua中的数据结构
---@return chatV2.TreasureInfo C#中的数据结构
function chatV2.TreasureInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.TreasureInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.heroId ~= nil and decodedData.heroIdSpecified ~= false then
        data.heroId = decodedData.heroId
    end
    return data
end

---@param decodedData chatV2.HistoryInfo lua中的数据结构
---@return chatV2.HistoryInfo C#中的数据结构
function chatV2.HistoryInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.HistoryInfo()
    if decodedData.content ~= nil and decodedData.contentSpecified ~= false then
        data.content = decodedData.content
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.otherMsgInfo ~= nil and decodedData.otherMsgInfoSpecified ~= false then
        data.otherMsgInfo = chatV2.OtherMsgInfo(decodedData.otherMsgInfo)
    end
    if decodedData.chatItemInfos ~= nil and decodedData.chatItemInfosSpecified ~= false then
        for i = 1, #decodedData.chatItemInfos do
            data.chatItemInfos:Add(chatV2.ChatItemInfo(decodedData.chatItemInfos[i]))
        end
    end
    return data
end

---@param decodedData chatV2.DragonEquipInfo lua中的数据结构
---@return chatV2.DragonEquipInfo C#中的数据结构
function chatV2.DragonEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.DragonEquipInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.bind ~= nil and decodedData.bindSpecified ~= false then
        data.bind = decodedData.bind
    end
    if decodedData.extraType ~= nil and decodedData.extraTypeSpecified ~= false then
        for i = 1, #decodedData.extraType do
            data.extraType:Add(decodedData.extraType[i])
        end
    end
    if decodedData.extraVlaue ~= nil and decodedData.extraVlaueSpecified ~= false then
        for i = 1, #decodedData.extraVlaue do
            data.extraVlaue:Add(decodedData.extraVlaue[i])
        end
    end
    if decodedData.bestAttInfo ~= nil and decodedData.bestAttInfoSpecified ~= false then
        data.bestAttInfo = chatV2.BestAttInfo(decodedData.bestAttInfo)
    end
    if decodedData.jiPinInfo ~= nil and decodedData.jiPinInfoSpecified ~= false then
        data.jiPinInfo = chatV2.JiPinInfo(decodedData.jiPinInfo)
    end
    return data
end

---@param decodedData chatV2.ReqGM lua中的数据结构
---@return chatV2.ReqGM C#中的数据结构
function chatV2.ReqGM(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ReqGM()
    if decodedData.command ~= nil and decodedData.commandSpecified ~= false then
        data.command = decodedData.command
    end
    return data
end

---@param decodedData chatV2.ResGM lua中的数据结构
---@return chatV2.ResGM C#中的数据结构
function chatV2.ResGM(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ResGM()
    if decodedData.content ~= nil and decodedData.contentSpecified ~= false then
        data.content = decodedData.content
    end
    return data
end

---@param decodedData chatV2.ReqChat lua中的数据结构
---@return chatV2.ReqChat C#中的数据结构
function chatV2.ReqChat(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ReqChat()
    if decodedData.channel ~= nil and decodedData.channelSpecified ~= false then
        data.channel = decodedData.channel
    end
    if decodedData.message ~= nil and decodedData.messageSpecified ~= false then
        data.message = decodedData.message
    end
    if decodedData.privateRoleId ~= nil and decodedData.privateRoleIdSpecified ~= false then
        data.privateRoleId = decodedData.privateRoleId
    end
    if decodedData.sound ~= nil and decodedData.soundSpecified ~= false then
        data.sound = decodedData.sound
    end
    if decodedData.sendToName ~= nil and decodedData.sendToNameSpecified ~= false then
        data.sendToName = decodedData.sendToName
    end
    if decodedData.quickChatId ~= nil and decodedData.quickChatIdSpecified ~= false then
        data.quickChatId = decodedData.quickChatId
    end
    return data
end

---@param decodedData chatV2.ResChat lua中的数据结构
---@return chatV2.ResChat C#中的数据结构
function chatV2.ResChat(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ResChat()
    if decodedData.senderId ~= nil and decodedData.senderIdSpecified ~= false then
        data.senderId = decodedData.senderId
    end
    if decodedData.sendName ~= nil and decodedData.sendNameSpecified ~= false then
        data.sendName = decodedData.sendName
    end
    if decodedData.channel ~= nil and decodedData.channelSpecified ~= false then
        data.channel = decodedData.channel
    end
    if decodedData.message ~= nil and decodedData.messageSpecified ~= false then
        data.message = decodedData.message
    end
    if decodedData.privateRoleId ~= nil and decodedData.privateRoleIdSpecified ~= false then
        data.privateRoleId = decodedData.privateRoleId
    end
    if decodedData.isVip ~= nil and decodedData.isVipSpecified ~= false then
        data.isVip = decodedData.isVip
    end
    if decodedData.sound ~= nil and decodedData.soundSpecified ~= false then
        data.sound = decodedData.sound
    end
    if decodedData.quickChatId ~= nil and decodedData.quickChatIdSpecified ~= false then
        data.quickChatId = decodedData.quickChatId
    end
    if decodedData.privateName ~= nil and decodedData.privateNameSpecified ~= false then
        data.privateName = decodedData.privateName
    end
    if decodedData.sendSex ~= nil and decodedData.sendSexSpecified ~= false then
        data.sendSex = decodedData.sendSex
    end
    if decodedData.sendCarre ~= nil and decodedData.sendCarreSpecified ~= false then
        data.sendCarre = decodedData.sendCarre
    end
    if decodedData.privateSex ~= nil and decodedData.privateSexSpecified ~= false then
        data.privateSex = decodedData.privateSex
    end
    if decodedData.privateCarre ~= nil and decodedData.privateCarreSpecified ~= false then
        data.privateCarre = decodedData.privateCarre
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.roleLettering ~= nil and decodedData.roleLetteringSpecified ~= false then
        data.roleLettering = decodedData.roleLettering
    end
    if decodedData.isDelete ~= nil and decodedData.isDeleteSpecified ~= false then
        data.isDelete = decodedData.isDelete
    end
    if decodedData.btnsId ~= nil and decodedData.btnsIdSpecified ~= false then
        data.btnsId = decodedData.btnsId
    end
    if decodedData.sendItemInfo ~= nil and decodedData.sendItemInfoSpecified ~= false then
        data.sendItemInfo = chatV2.SenditemInfo(decodedData.sendItemInfo)
    end
    if decodedData.redBagId ~= nil and decodedData.redBagIdSpecified ~= false then
        data.redBagId = decodedData.redBagId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        for i = 1, #decodedData.state do
            data.state:Add(chatV2.ChatRedBagState(decodedData.state[i]))
        end
    end
    if decodedData.unionPosition ~= nil and decodedData.unionPositionSpecified ~= false then
        data.unionPosition = decodedData.unionPosition
    end
    if decodedData.onlySelfView ~= nil and decodedData.onlySelfViewSpecified ~= false then
        data.onlySelfView = decodedData.onlySelfView
    end
    if decodedData.remoteHostId ~= nil and decodedData.remoteHostIdSpecified ~= false then
        data.remoteHostId = decodedData.remoteHostId
    end
    if decodedData.remote ~= nil and decodedData.remoteSpecified ~= false then
        data.remote = decodedData.remote
    end
    if decodedData.targetHostId ~= nil and decodedData.targetHostIdSpecified ~= false then
        data.targetHostId = decodedData.targetHostId
    end
    return data
end

---@param decodedData chatV2.ChatRedBagState lua中的数据结构
---@return chatV2.ChatRedBagState C#中的数据结构
function chatV2.ChatRedBagState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ChatRedBagState()
    if decodedData.roleid ~= nil and decodedData.roleidSpecified ~= false then
        data.roleid = decodedData.roleid
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData chatV2.SenditemInfo lua中的数据结构
---@return chatV2.SenditemInfo C#中的数据结构
function chatV2.SenditemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.SenditemInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData chatV2.ReqLookOther lua中的数据结构
---@return chatV2.ReqLookOther C#中的数据结构
function chatV2.ReqLookOther(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ReqLookOther()
    if decodedData.targetUid ~= nil and decodedData.targetUidSpecified ~= false then
        data.targetUid = decodedData.targetUid
    end
    return data
end

---@param decodedData chatV2.ResLookOther lua中的数据结构
---@return chatV2.ResLookOther C#中的数据结构
function chatV2.ResLookOther(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ResLookOther()
    if decodedData.roleInfo ~= nil and decodedData.roleInfoSpecified ~= false then
        data.roleInfo = chatV2.RoleInfo(decodedData.roleInfo)
    end
    if decodedData.heroInfoList ~= nil and decodedData.heroInfoListSpecified ~= false then
        for i = 1, #decodedData.heroInfoList do
            data.heroInfoList:Add(chatV2.HeroInfo(decodedData.heroInfoList[i]))
        end
    end
    return data
end

---@param decodedData chatV2.ResAnnounce lua中的数据结构
---@return chatV2.ResAnnounce C#中的数据结构
function chatV2.ResAnnounce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ResAnnounce()
    if decodedData.params ~= nil and decodedData.paramsSpecified ~= false then
        for i = 1, #decodedData.params do
            data.params:Add(decodedData.params[i])
        end
    end
    if decodedData.announce ~= nil and decodedData.announceSpecified ~= false then
        data.announce = decodedData.announce
    end
    if decodedData.showType ~= nil and decodedData.showTypeSpecified ~= false then
        for i = 1, #decodedData.showType do
            data.showType:Add(decodedData.showType[i])
        end
    end
    if decodedData.remarks ~= nil and decodedData.remarksSpecified ~= false then
        data.remarks = decodedData.remarks
    end
    if decodedData.frequency ~= nil and decodedData.frequencySpecified ~= false then
        data.frequency = decodedData.frequency
    end
    if decodedData.cd ~= nil and decodedData.cdSpecified ~= false then
        data.cd = decodedData.cd
    end
    if decodedData.minLevel ~= nil and decodedData.minLevelSpecified ~= false then
        data.minLevel = decodedData.minLevel
    end
    if decodedData.timeType ~= nil and decodedData.timeTypeSpecified ~= false then
        data.timeType = decodedData.timeType
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.seenType ~= nil and decodedData.seenTypeSpecified ~= false then
        data.seenType = decodedData.seenType
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        for i = 1, #decodedData.mapId do
            data.mapId:Add(decodedData.mapId[i])
        end
    end
    if decodedData.minRein ~= nil and decodedData.minReinSpecified ~= false then
        data.minRein = decodedData.minRein
    end
    if decodedData.maxRein ~= nil and decodedData.maxReinSpecified ~= false then
        data.maxRein = decodedData.maxRein
    end
    if decodedData.alwaysSeen ~= nil and decodedData.alwaysSeenSpecified ~= false then
        data.alwaysSeen = decodedData.alwaysSeen
    end
    if decodedData.maxLevel ~= nil and decodedData.maxLevelSpecified ~= false then
        data.maxLevel = decodedData.maxLevel
    end
    if decodedData.monsterType ~= nil and decodedData.monsterTypeSpecified ~= false then
        data.monsterType = decodedData.monsterType
    end
    if decodedData.monsterLevel ~= nil and decodedData.monsterLevelSpecified ~= false then
        data.monsterLevel = decodedData.monsterLevel
    end
    return data
end

---@param decodedData chatV2.ReqPullChatHistory lua中的数据结构
---@return chatV2.ReqPullChatHistory C#中的数据结构
function chatV2.ReqPullChatHistory(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ReqPullChatHistory()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData chatV2.ResPullChatHistory lua中的数据结构
---@return chatV2.ResPullChatHistory C#中的数据结构
function chatV2.ResPullChatHistory(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ResPullChatHistory()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.pulledMsgs ~= nil and decodedData.pulledMsgsSpecified ~= false then
        for i = 1, #decodedData.pulledMsgs do
            data.pulledMsgs:Add(chatV2.HistoryInfo(decodedData.pulledMsgs[i]))
        end
    end
    return data
end

---@param decodedData chatV2.ReqSendSpecialAnnounce lua中的数据结构
---@return chatV2.ReqSendSpecialAnnounce C#中的数据结构
function chatV2.ReqSendSpecialAnnounce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ReqSendSpecialAnnounce()
    if decodedData.announceId ~= nil and decodedData.announceIdSpecified ~= false then
        data.announceId = decodedData.announceId
    end
    if decodedData.channelType ~= nil and decodedData.channelTypeSpecified ~= false then
        data.channelType = decodedData.channelType
    end
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    return data
end

---@param decodedData chatV2.ReqBtnsReply lua中的数据结构
---@return chatV2.ReqBtnsReply C#中的数据结构
function chatV2.ReqBtnsReply(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ReqBtnsReply()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.senderId ~= nil and decodedData.senderIdSpecified ~= false then
        data.senderId = decodedData.senderId
    end
    if decodedData.toRid ~= nil and decodedData.toRidSpecified ~= false then
        data.toRid = decodedData.toRid
    end
    return data
end

---@param decodedData chatV2.ResHuntAnnounceHistory lua中的数据结构
---@return chatV2.ResHuntAnnounceHistory C#中的数据结构
function chatV2.ResHuntAnnounceHistory(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ResHuntAnnounceHistory()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(decodedData.info[i])
        end
    end
    return data
end

---@param decodedData chatV2.ResHuntAnnounceUpdate lua中的数据结构
---@return chatV2.ResHuntAnnounceUpdate C#中的数据结构
function chatV2.ResHuntAnnounceUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.chatV2.ResHuntAnnounceUpdate()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = decodedData.info
    end
    return data
end

return chatV2