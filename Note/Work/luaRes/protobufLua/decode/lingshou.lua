--[[本文件为工具自动生成,禁止手动修改]]
local lingshouV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData lingshouV2.LingShouInfo lua中的数据结构
---@return lingshouV2.LingShouInfo C#中的数据结构
function lingshouV2.LingShouInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.LingShouInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.xlevel ~= nil and decodedData.xlevelSpecified ~= false then
        data.xlevel = decodedData.xlevel
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.nowSkin ~= nil and decodedData.nowSkinSpecified ~= false then
        data.nowSkin = decodedData.nowSkin
    end
    if decodedData.tianfuId ~= nil and decodedData.tianfuIdSpecified ~= false then
        data.tianfuId = decodedData.tianfuId
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    if decodedData.talentList ~= nil and decodedData.talentListSpecified ~= false then
        for i = 1, #decodedData.talentList do
            data.talentList:Add(lingshouV2.TalentInfo(decodedData.talentList[i]))
        end
    end
    if decodedData.lsEquipList ~= nil and decodedData.lsEquipListSpecified ~= false then
        for i = 1, #decodedData.lsEquipList do
            data.lsEquipList:Add(lingshouV2.LSEquipInfo(decodedData.lsEquipList[i]))
        end
    end
    return data
end

---@param decodedData lingshouV2.HuanXingInfo lua中的数据结构
---@return lingshouV2.HuanXingInfo C#中的数据结构
function lingshouV2.HuanXingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.HuanXingInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.xlevel ~= nil and decodedData.xlevelSpecified ~= false then
        data.xlevel = decodedData.xlevel
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.tianfuId ~= nil and decodedData.tianfuIdSpecified ~= false then
        data.tianfuId = decodedData.tianfuId
    end
    if decodedData.timeout ~= nil and decodedData.timeoutSpecified ~= false then
        data.timeout = decodedData.timeout
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData lingshouV2.TalentInfo lua中的数据结构
---@return lingshouV2.TalentInfo C#中的数据结构
function lingshouV2.TalentInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.TalentInfo()
    if decodedData.cls ~= nil and decodedData.clsSpecified ~= false then
        data.cls = decodedData.cls
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData lingshouV2.LSEquipInfo lua中的数据结构
---@return lingshouV2.LSEquipInfo C#中的数据结构
function lingshouV2.LSEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.LSEquipInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.shengLingLv ~= nil and decodedData.shengLingLvSpecified ~= false then
        data.shengLingLv = decodedData.shengLingLv
    end
    return data
end

---@param decodedData lingshouV2.ResLingShouInfo lua中的数据结构
---@return lingshouV2.ResLingShouInfo C#中的数据结构
function lingshouV2.ResLingShouInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLingShouInfo()
    if decodedData.lingShou ~= nil and decodedData.lingShouSpecified ~= false then
        data.lingShou = lingshouV2.LingShouInfo(decodedData.lingShou)
    end
    if decodedData.huanXingList ~= nil and decodedData.huanXingListSpecified ~= false then
        data.huanXingList = lingshouV2.HuanXingInfo(decodedData.huanXingList)
    end
    return data
end

---@param decodedData lingshouV2.ReqLevelUpLingShou lua中的数据结构
---@return lingshouV2.ReqLevelUpLingShou C#中的数据结构
function lingshouV2.ReqLevelUpLingShou(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqLevelUpLingShou()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.useType ~= nil and decodedData.useTypeSpecified ~= false then
        data.useType = decodedData.useType
    end
    return data
end

---@param decodedData lingshouV2.ResLevelUpLingShou lua中的数据结构
---@return lingshouV2.ResLevelUpLingShou C#中的数据结构
function lingshouV2.ResLevelUpLingShou(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLevelUpLingShou()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.xlevel ~= nil and decodedData.xlevelSpecified ~= false then
        data.xlevel = decodedData.xlevel
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.tianfuId ~= nil and decodedData.tianfuIdSpecified ~= false then
        data.tianfuId = decodedData.tianfuId
    end
    if decodedData.timeout ~= nil and decodedData.timeoutSpecified ~= false then
        data.timeout = decodedData.timeout
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData lingshouV2.ReqLevelUpLingShouTalent lua中的数据结构
---@return lingshouV2.ReqLevelUpLingShouTalent C#中的数据结构
function lingshouV2.ReqLevelUpLingShouTalent(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqLevelUpLingShouTalent()
    if decodedData.cls ~= nil and decodedData.clsSpecified ~= false then
        data.cls = decodedData.cls
    end
    return data
end

---@param decodedData lingshouV2.ResLevelUpLingShouTalent lua中的数据结构
---@return lingshouV2.ResLevelUpLingShouTalent C#中的数据结构
function lingshouV2.ResLevelUpLingShouTalent(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLevelUpLingShouTalent()
    if decodedData.cls ~= nil and decodedData.clsSpecified ~= false then
        data.cls = decodedData.cls
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData lingshouV2.ReqPutOnLingShouEquip lua中的数据结构
---@return lingshouV2.ReqPutOnLingShouEquip C#中的数据结构
function lingshouV2.ReqPutOnLingShouEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqPutOnLingShouEquip()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.uniqueId ~= nil and decodedData.uniqueIdSpecified ~= false then
        data.uniqueId = decodedData.uniqueId
    end
    return data
end

---@param decodedData lingshouV2.ResLingShouEquipChange lua中的数据结构
---@return lingshouV2.ResLingShouEquipChange C#中的数据结构
function lingshouV2.ResLingShouEquipChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLingShouEquipChange()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.lsEquip ~= nil and decodedData.lsEquipSpecified ~= false then
        data.lsEquip = lingshouV2.LSEquipInfo(decodedData.lsEquip)
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData lingshouV2.ReqPutOffLingShouEquip lua中的数据结构
---@return lingshouV2.ReqPutOffLingShouEquip C#中的数据结构
function lingshouV2.ReqPutOffLingShouEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqPutOffLingShouEquip()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData lingshouV2.ReqPutOnSkin lua中的数据结构
---@return lingshouV2.ReqPutOnSkin C#中的数据结构
function lingshouV2.ReqPutOnSkin(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqPutOnSkin()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData lingshouV2.ResSkinChange lua中的数据结构
---@return lingshouV2.ResSkinChange C#中的数据结构
function lingshouV2.ResSkinChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResSkinChange()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData lingshouV2.ReqPutOffLingSkin lua中的数据结构
---@return lingshouV2.ReqPutOffLingSkin C#中的数据结构
function lingshouV2.ReqPutOffLingSkin(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqPutOffLingSkin()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData lingshouV2.ReqActivateLingShou lua中的数据结构
---@return lingshouV2.ReqActivateLingShou C#中的数据结构
function lingshouV2.ReqActivateLingShou(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqActivateLingShou()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData lingshouV2.ReqLevelUpTianFu lua中的数据结构
---@return lingshouV2.ReqLevelUpTianFu C#中的数据结构
function lingshouV2.ReqLevelUpTianFu(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqLevelUpTianFu()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData lingshouV2.ResLevelUpTianFu lua中的数据结构
---@return lingshouV2.ResLevelUpTianFu C#中的数据结构
function lingshouV2.ResLevelUpTianFu(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLevelUpTianFu()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.tianfuId ~= nil and decodedData.tianfuIdSpecified ~= false then
        data.tianfuId = decodedData.tianfuId
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    return data
end

---@param decodedData lingshouV2.ResRemoveSkin lua中的数据结构
---@return lingshouV2.ResRemoveSkin C#中的数据结构
function lingshouV2.ResRemoveSkin(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResRemoveSkin()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData lingshouV2.ReqShengLing lua中的数据结构
---@return lingshouV2.ReqShengLing C#中的数据结构
function lingshouV2.ReqShengLing(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqShengLing()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData lingshouV2.ResLingShouTaskPanel lua中的数据结构
---@return lingshouV2.ResLingShouTaskPanel C#中的数据结构
function lingshouV2.ResLingShouTaskPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLingShouTaskPanel()
    if decodedData.taskInfo ~= nil and decodedData.taskInfoSpecified ~= false then
        for i = 1, #decodedData.taskInfo do
            data.taskInfo:Add(lingshouV2.LinshouTaskInfo(decodedData.taskInfo[i]))
        end
    end
    if decodedData.secInfo ~= nil and decodedData.secInfoSpecified ~= false then
        for i = 1, #decodedData.secInfo do
            data.secInfo:Add(lingshouV2.LinshouSectionInfo(decodedData.secInfo[i]))
        end
    end
    if decodedData.finishCount ~= nil and decodedData.finishCountSpecified ~= false then
        data.finishCount = decodedData.finishCount
    end
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    --C#的lingshouV2.ResLingShouTaskPanel类中没有找到allComplete字段,不填充数据
    return data
end

---@param decodedData lingshouV2.LinshouTaskInfo lua中的数据结构
---@return lingshouV2.LinshouTaskInfo C#中的数据结构
function lingshouV2.LinshouTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.LinshouTaskInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.goalInfo ~= nil and decodedData.goalInfoSpecified ~= false then
        data.goalInfo = decodeTable.task.TaskGoalInfo(decodedData.goalInfo)
    end
    --C#的lingshouV2.LinshouTaskInfo类中没有找到section字段,不填充数据
    return data
end

---@param decodedData lingshouV2.LinshouSectionInfo lua中的数据结构
---@return lingshouV2.LinshouSectionInfo C#中的数据结构
function lingshouV2.LinshouSectionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.LinshouSectionInfo()
    if decodedData.sec ~= nil and decodedData.secSpecified ~= false then
        data.sec = decodedData.sec
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.lockState ~= nil and decodedData.lockStateSpecified ~= false then
        data.lockState = decodedData.lockState
    end
    return data
end

---@param decodedData lingshouV2.ResLingShouTaskInfo lua中的数据结构
---@return lingshouV2.ResLingShouTaskInfo C#中的数据结构
function lingshouV2.ResLingShouTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLingShouTaskInfo()
    if decodedData.taskInfo ~= nil and decodedData.taskInfoSpecified ~= false then
        for i = 1, #decodedData.taskInfo do
            data.taskInfo:Add(lingshouV2.LinshouTaskInfo(decodedData.taskInfo[i]))
        end
    end
    return data
end

---@param decodedData lingshouV2.ResLinshouSectionInfo lua中的数据结构
---@return lingshouV2.ResLinshouSectionInfo C#中的数据结构
function lingshouV2.ResLinshouSectionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ResLinshouSectionInfo()
    if decodedData.secInfo ~= nil and decodedData.secInfoSpecified ~= false then
        data.secInfo = lingshouV2.LinshouSectionInfo(decodedData.secInfo)
    end
    return data
end

---@param decodedData lingshouV2.ReqGetRewards lua中的数据结构
---@return lingshouV2.ReqGetRewards C#中的数据结构
function lingshouV2.ReqGetRewards(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqGetRewards()
    data.id = decodedData.id
    return data
end

---@param decodedData lingshouV2.ReqGetSecRewards lua中的数据结构
---@return lingshouV2.ReqGetSecRewards C#中的数据结构
function lingshouV2.ReqGetSecRewards(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.lingshouV2.ReqGetSecRewards()
    data.sec = decodedData.sec
    return data
end

--[[lingshouV2.UnlockLingShouTask 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[lingshouV2.UnlockSecEffect 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return lingshouV2