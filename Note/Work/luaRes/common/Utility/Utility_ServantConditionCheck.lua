---@type Utility
local Utility = Utility

LuaServantConditionType = {
    ---灵兽等级且转生等级是否达到
    ServantLevelAndReinLv = 55,
    ---灵兽指定装备位列表上是否都有装备
    ServantEquipIndexHaveEquip = 61,
}

---@param id number TABLE.CFG_CONDITION表格的ID
---@param isOtherPlayer boolean 是否是其他玩家
---@return LuaMatchConditionResult
function Utility.IsServantMatchCondition(id,isOtherPlayer)
    ---@type TABLE.cfg_conditions
    local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(id)
    ;if conditionTbl == nil then
        return
    end
    if(conditionTbl:GetConditionType() == LuaServantConditionType.ServantLevelAndReinLv) then
        local servantSeatType
        local servantInfo
        if conditionTbl ~= nil and conditionTbl:GetConditionParam() ~= nil and conditionTbl:GetConditionParam().list.Count > 0 then
            servantSeatType = conditionTbl:GetConditionParam().list[0]
        end
        if type(servantSeatType) ~= 'number' then
            return false
        end
        if isOtherPlayer == true then
            servantInfo = gameMgr:GetOtherPlayerDataMgr():GetOtherServantInfoByServantSeatType(servantSeatType)
        else
            servantInfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantInfoByServantIndex(servantSeatType)
        end
        return Utility.IsServantMatchCondition_LevelAndReinLv(conditionTbl,servantInfo)
    elseif (conditionTbl:GetConditionType() == LuaServantConditionType.ServantEquipIndexHaveEquip) then
        return Utility.IsServantMatchCondition_EquipIndexHaveEquip(conditionTbl)
    end
    return nil
end

---@param conditionsTbl TABLE.cfg_conditions
---@param servantInfo servantV2.ServantInfo
function Utility.IsServantMatchCondition_LevelAndReinLv(conditionsTbl,servantInfo)
    ---@type LuaMatchConditionResult
    local result = {}

    if servantInfo == nil or conditionsTbl == nil or conditionsTbl:GetConditionParam() == nil or conditionsTbl:GetConditionParam().list.Count < 3 then
        result.success = false
        result.txt = "conditionId" .. tostring(conditionsTbl:GetId()) .. "数据配置出错"
        result.param = nil
        result.type = nil
    end

    ---@type luaEnumServantSeatType
    local servantSeatType = tonumber(conditionsTbl:GetConditionParam().list[0])
    local servantLimitLevel = tonumber(conditionsTbl:GetConditionParam().list[1])
    local servantLimitReinLv = tonumber(conditionsTbl:GetConditionParam().list[2])

    result.param = {limitLevel = servantLimitLevel,limitReinLv = servantLimitReinLv}
    result.type = conditionsTbl:GetConditionType()

    if servantInfo == nil then
        result.success = false
        result.txt = "没有灵兽位类型" .. tostring(servantSeatType) .. "的灵兽数据"
        return result
    end
    if servantInfo.rein >= servantLimitReinLv and servantInfo.level >= servantLimitLevel then
        result.success = true
    else
        result.success = false
        result.txt = conditionsTbl:GetShow()
    end
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
function Utility.IsServantMatchCondition_EquipIndexHaveEquip(conditionsTbl)
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = false
    if conditionsTbl == nil then
        return result
    end
    result.txt = conditionsTbl:GetTxt()
    result.type = conditionsTbl:GetConditionType()
    result.param = conditionsTbl:GetConditionParam()
    if conditionsTbl:GetConditionParam() == nil or conditionsTbl:GetConditionParam().list == nil then
        return result
    end
    local equipIndexTable = conditionsTbl:GetConditionParam().list
    local length = conditionsTbl:GetConditionParam().list.Count - 1
    for k = 0,length do
        local equipIndex = conditionsTbl:GetConditionParam().list[k]
        if gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetEquipByEquipIndex(equipIndex) == nil then
            return result
        end
    end
    result.success = true
    return result
end

---@param idList table<number>
---@return LuaMatchConditionResult
function Utility.IsServantMatchConditionList_AND(idList, isOtherPlayer)
    ---@type LuaMatchConditionResult
    local result = {}
    if type(idList) ~= 'table' or Utility.GetLuaTableCount(idList) <= 0 then
        result.success = false
        result.txt = "传入数据结构出错"
        result.param = nil
        result.type = nil
        return result
    end
    local conditionResult
    for k,v in pairs(idList) do
        conditionResult = Utility.IsServantMatchCondition(v,isOtherPlayer)
        if conditionResult == nil then
            ---@type TABLE.cfg_conditions
            local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(v)
            if conditionTbl ~= nil then
                result.success = false
                result.txt =  conditionTbl:GetTxt()
                result.param = conditionTbl:GetConditionParam()
                result.type = conditionTbl:GetConditionType()
                result.id = v
                return result
            end
        end
        if conditionResult ~= nil and conditionResult.success == false then
            return conditionResult
        end
    end
    return conditionResult
end

---@param idList table<number>
---@return LuaMatchConditionResult
function Utility.IsServantMatchConditionList_OR(idList, isOtherPlayer)
    ---@type LuaMatchConditionResult
    local result = {}
    if type(idList) ~= 'table' or Utility.GetLuaTableCount(idList) <= 0 then
        result.success = false
        result.txt = "传入数据结构出错"
        result.param = nil
        result.type = nil
        return result
    end
    local conditionResult
    for k,v in pairs(idList) do
        conditionResult = Utility.IsServantMatchCondition(v,isOtherPlayer)
        if conditionResult == nil then
            ---@type TABLE.cfg_conditions
            local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(v)
            if conditionTbl ~= nil then
                result.success = false
                result.txt =  conditionTbl:GetTxt()
                result.param = conditionTbl:GetConditionParam()
                result.type = conditionTbl:GetConditionType()
                result.id = v
                return result
            end
        end
        if conditionResult ~= nil and conditionResult.success == true then
            return conditionResult
        end
    end
    return conditionResult
end