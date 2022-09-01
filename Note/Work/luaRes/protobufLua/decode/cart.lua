--[[本文件为工具自动生成,禁止手动修改]]
local cartV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData cartV2.ResBodyGuardInfo lua中的数据结构
---@return cartV2.ResBodyGuardInfo C#中的数据结构
function cartV2.ResBodyGuardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResBodyGuardInfo()
    if decodedData.cartState ~= nil and decodedData.cartStateSpecified ~= false then
        data.cartState = decodedData.cartState
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
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
    return data
end

---@param decodedData cartV2.ResUnionCartInfo lua中的数据结构
---@return cartV2.ResUnionCartInfo C#中的数据结构
function cartV2.ResUnionCartInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResUnionCartInfo()
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.joinNum ~= nil and decodedData.joinNumSpecified ~= false then
        data.joinNum = decodedData.joinNum
    end
    if decodedData.moveInterval ~= nil and decodedData.moveIntervalSpecified ~= false then
        data.moveInterval = decodedData.moveInterval
    end
    if decodedData.distance ~= nil and decodedData.distanceSpecified ~= false then
        data.distance = decodedData.distance
    end
    if decodedData.totalDis ~= nil and decodedData.totalDisSpecified ~= false then
        data.totalDis = decodedData.totalDis
    end
    if decodedData.myScore ~= nil and decodedData.myScoreSpecified ~= false then
        data.myScore = decodedData.myScore
    end
    if decodedData.cartState ~= nil and decodedData.cartStateSpecified ~= false then
        data.cartState = decodedData.cartState
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.isInRange ~= nil and decodedData.isInRangeSpecified ~= false then
        data.isInRange = decodedData.isInRange
    end
    if decodedData.opposeNum ~= nil and decodedData.opposeNumSpecified ~= false then
        data.opposeNum = decodedData.opposeNum
    end
    return data
end

---@param decodedData cartV2.UnionCartRank lua中的数据结构
---@return cartV2.UnionCartRank C#中的数据结构
function cartV2.UnionCartRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.UnionCartRank()
    if decodedData.selfInfos ~= nil and decodedData.selfInfosSpecified ~= false then
        for i = 1, #decodedData.selfInfos do
            data.selfInfos:Add(cartV2.UnionCartRankPlayerInfo(decodedData.selfInfos[i]))
        end
    end
    if decodedData.otherInfos ~= nil and decodedData.otherInfosSpecified ~= false then
        for i = 1, #decodedData.otherInfos do
            data.otherInfos:Add(cartV2.UnionCartRankPlayerInfo(decodedData.otherInfos[i]))
        end
    end
    if decodedData.common ~= nil and decodedData.commonSpecified ~= false then
        data.common = cartV2.UnionCartRankCommon(decodedData.common)
    end
    return data
end

---@param decodedData cartV2.UnionCartRankPlayerInfo lua中的数据结构
---@return cartV2.UnionCartRankPlayerInfo C#中的数据结构
function cartV2.UnionCartRankPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.UnionCartRankPlayerInfo()
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
    if decodedData.selfDis ~= nil and decodedData.selfDisSpecified ~= false then
        data.selfDis = decodedData.selfDis
    end
    if decodedData.killNum ~= nil and decodedData.killNumSpecified ~= false then
        data.killNum = decodedData.killNum
    end
    if decodedData.diedNum ~= nil and decodedData.diedNumSpecified ~= false then
        data.diedNum = decodedData.diedNum
    end
    if decodedData.grade ~= nil and decodedData.gradeSpecified ~= false then
        data.grade = decodedData.grade
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.titleType ~= nil and decodedData.titleTypeSpecified ~= false then
        data.titleType = decodedData.titleType
    end
    if decodedData.like ~= nil and decodedData.likeSpecified ~= false then
        for i = 1, #decodedData.like do
            data.like:Add(decodedData.like[i])
        end
    end
    return data
end

---@param decodedData cartV2.UnionCartRankCommon lua中的数据结构
---@return cartV2.UnionCartRankCommon C#中的数据结构
function cartV2.UnionCartRankCommon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.UnionCartRankCommon()
    if decodedData.totalDis ~= nil and decodedData.totalDisSpecified ~= false then
        data.totalDis = decodedData.totalDis
    end
    if decodedData.totalKill ~= nil and decodedData.totalKillSpecified ~= false then
        data.totalKill = decodedData.totalKill
    end
    if decodedData.totalDied ~= nil and decodedData.totalDiedSpecified ~= false then
        data.totalDied = decodedData.totalDied
    end
    if decodedData.rankDis ~= nil and decodedData.rankDisSpecified ~= false then
        data.rankDis = decodedData.rankDis
    end
    if decodedData.rankKill ~= nil and decodedData.rankKillSpecified ~= false then
        data.rankKill = decodedData.rankKill
    end
    if decodedData.rankDied ~= nil and decodedData.rankDiedSpecified ~= false then
        data.rankDied = decodedData.rankDied
    end
    if decodedData.rankGrade ~= nil and decodedData.rankGradeSpecified ~= false then
        data.rankGrade = decodedData.rankGrade
    end
    if decodedData.isArrive ~= nil and decodedData.isArriveSpecified ~= false then
        data.isArrive = decodedData.isArrive
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    return data
end

---@param decodedData cartV2.ResUnionCartFinish lua中的数据结构
---@return cartV2.ResUnionCartFinish C#中的数据结构
function cartV2.ResUnionCartFinish(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResUnionCartFinish()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = cartV2.UnionCartRank(decodedData.rank)
    end
    if decodedData.showTime ~= nil and decodedData.showTimeSpecified ~= false then
        data.showTime = decodedData.showTime
    end
    return data
end

---@param decodedData cartV2.ReqUnionCartRankRecord lua中的数据结构
---@return cartV2.ReqUnionCartRankRecord C#中的数据结构
function cartV2.ReqUnionCartRankRecord(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ReqUnionCartRankRecord()
    data.index = decodedData.index
    return data
end

---@param decodedData cartV2.ResUnionCartRankRecord lua中的数据结构
---@return cartV2.ResUnionCartRankRecord C#中的数据结构
function cartV2.ResUnionCartRankRecord(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResUnionCartRankRecord()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = cartV2.UnionCartRank(decodedData.rank)
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData cartV2.ResPersonalCartList lua中的数据结构
---@return cartV2.ResPersonalCartList C#中的数据结构
function cartV2.ResPersonalCartList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResPersonalCartList()
    if decodedData.cartList ~= nil and decodedData.cartListSpecified ~= false then
        for i = 1, #decodedData.cartList do
            data.cartList:Add(cartV2.PersonalCartInfo(decodedData.cartList[i]))
        end
    end
    if decodedData.beRobbedCount ~= nil and decodedData.beRobbedCountSpecified ~= false then
        data.beRobbedCount = decodedData.beRobbedCount
    end
    if decodedData.robCount ~= nil and decodedData.robCountSpecified ~= false then
        data.robCount = decodedData.robCount
    end
    return data
end

---@param decodedData cartV2.PersonalCartInfo lua中的数据结构
---@return cartV2.PersonalCartInfo C#中的数据结构
function cartV2.PersonalCartInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.PersonalCartInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    if decodedData.startTime ~= nil and decodedData.startTimeSpecified ~= false then
        data.startTime = decodedData.startTime
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.canReward ~= nil and decodedData.canRewardSpecified ~= false then
        data.canReward = decodedData.canReward
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData cartV2.ResPersonalCartSituation lua中的数据结构
---@return cartV2.ResPersonalCartSituation C#中的数据结构
function cartV2.ResPersonalCartSituation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResPersonalCartSituation()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    if decodedData.targetName ~= nil and decodedData.targetNameSpecified ~= false then
        data.targetName = decodedData.targetName
    end
    if decodedData.targetUnionName ~= nil and decodedData.targetUnionNameSpecified ~= false then
        data.targetUnionName = decodedData.targetUnionName
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
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData cartV2.ReqEscortCart lua中的数据结构
---@return cartV2.ReqEscortCart C#中的数据结构
function cartV2.ReqEscortCart(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ReqEscortCart()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    return data
end

---@param decodedData cartV2.ResUpdatePersonalCart lua中的数据结构
---@return cartV2.ResUpdatePersonalCart C#中的数据结构
function cartV2.ResUpdatePersonalCart(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResUpdatePersonalCart()
    if decodedData.addList ~= nil and decodedData.addListSpecified ~= false then
        for i = 1, #decodedData.addList do
            data.addList:Add(cartV2.PersonalCartInfo(decodedData.addList[i]))
        end
    end
    if decodedData.removeList ~= nil and decodedData.removeListSpecified ~= false then
        for i = 1, #decodedData.removeList do
            data.removeList:Add(decodedData.removeList[i])
        end
    end
    return data
end

---@param decodedData cartV2.ReqReceiveReward lua中的数据结构
---@return cartV2.ReqReceiveReward C#中的数据结构
function cartV2.ReqReceiveReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ReqReceiveReward()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.bei ~= nil and decodedData.beiSpecified ~= false then
        data.bei = decodedData.bei
    end
    return data
end

---@param decodedData cartV2.CartMatterCode lua中的数据结构
---@return cartV2.CartMatterCode C#中的数据结构
function cartV2.CartMatterCode(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.CartMatterCode()
    if decodedData.code ~= nil and decodedData.codeSpecified ~= false then
        data.code = decodedData.code
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    return data
end

---@param decodedData cartV2.ResPersonalCartHpUpdate lua中的数据结构
---@return cartV2.ResPersonalCartHpUpdate C#中的数据结构
function cartV2.ResPersonalCartHpUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResPersonalCartHpUpdate()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.isRobbed ~= nil and decodedData.isRobbedSpecified ~= false then
        data.isRobbed = decodedData.isRobbed
    end
    return data
end

---@param decodedData cartV2.ReqPersonalCartPosition lua中的数据结构
---@return cartV2.ReqPersonalCartPosition C#中的数据结构
function cartV2.ReqPersonalCartPosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ReqPersonalCartPosition()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData cartV2.ResPersonalCartPosition lua中的数据结构
---@return cartV2.ResPersonalCartPosition C#中的数据结构
function cartV2.ResPersonalCartPosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResPersonalCartPosition()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData cartV2.LikeList lua中的数据结构
---@return cartV2.LikeList C#中的数据结构
function cartV2.LikeList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.LikeList()
    if decodedData.likes ~= nil and decodedData.likesSpecified ~= false then
        for i = 1, #decodedData.likes do
            data.likes:Add(decodedData.likes[i])
        end
    end
    return data
end

---@param decodedData cartV2.ReqStartFreightCar lua中的数据结构
---@return cartV2.ReqStartFreightCar C#中的数据结构
function cartV2.ReqStartFreightCar(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ReqStartFreightCar()
    if decodedData.carConfigId ~= nil and decodedData.carConfigIdSpecified ~= false then
        data.carConfigId = decodedData.carConfigId
    end
    return data
end

---@param decodedData cartV2.ResFreightCarInfo lua中的数据结构
---@return cartV2.ResFreightCarInfo C#中的数据结构
function cartV2.ResFreightCarInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResFreightCarInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.masterId ~= nil and decodedData.masterIdSpecified ~= false then
        data.masterId = decodedData.masterId
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.masterUnionId ~= nil and decodedData.masterUnionIdSpecified ~= false then
        data.masterUnionId = decodedData.masterUnionId
    end
    if decodedData.uniteUnionType ~= nil and decodedData.uniteUnionTypeSpecified ~= false then
        data.uniteUnionType = decodedData.uniteUnionType
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.masterName ~= nil and decodedData.masterNameSpecified ~= false then
        data.masterName = decodedData.masterName
    end
    if decodedData.carConfigId ~= nil and decodedData.carConfigIdSpecified ~= false then
        data.carConfigId = decodedData.carConfigId
    end
    --C#的cartV2.ResFreightCarInfo类中没有找到hp字段,不填充数据
    --C#的cartV2.ResFreightCarInfo类中没有找到yabiaoId字段,不填充数据
    --C#的cartV2.ResFreightCarInfo类中没有找到mapId字段,不填充数据
    --C#的cartV2.ResFreightCarInfo类中没有找到x字段,不填充数据
    --C#的cartV2.ResFreightCarInfo类中没有找到y字段,不填充数据
    --C#的cartV2.ResFreightCarInfo类中没有找到line字段,不填充数据
    return data
end

---@param decodedData cartV2.ResRoleFreightInfo lua中的数据结构
---@return cartV2.ResRoleFreightInfo C#中的数据结构
function cartV2.ResRoleFreightInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResRoleFreightInfo()
    if decodedData.deliveryCount ~= nil and decodedData.deliveryCountSpecified ~= false then
        data.deliveryCount = decodedData.deliveryCount
    end
    if decodedData.plunderCount ~= nil and decodedData.plunderCountSpecified ~= false then
        data.plunderCount = decodedData.plunderCount
    end
    return data
end

---@param decodedData cartV2.ResFreightCarHpChange lua中的数据结构
---@return cartV2.ResFreightCarHpChange C#中的数据结构
function cartV2.ResFreightCarHpChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResFreightCarHpChange()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    return data
end

---@param decodedData cartV2.ResFreightCarPointChange lua中的数据结构
---@return cartV2.ResFreightCarPointChange C#中的数据结构
function cartV2.ResFreightCarPointChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.cartV2.ResFreightCarPointChange()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    return data
end

--[[cartV2.ResFinishFreightCar 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return cartV2