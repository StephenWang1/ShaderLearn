---@class cfg_demon_bossManager:TableManager
local cfg_demon_bossManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_demon_boss
function cfg_demon_bossManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_demon_boss> 遍历方法
function cfg_demon_bossManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_demon_bossManager:PostProcess()
end

---获取需要检测的装备位id
---@param monsterId number monster
---@return table 装备位下标表
function cfg_demon_bossManager:GetHurtParamsTable(monsterId)
    local info = self:TryGetValue(monsterId)
    if info ~= nil and CS.StaticUtility.IsNullOrEmpty(info.hurtParamExtra) == false then
        return string.Split(info.hurtParamExtra,'#')
    end
end

---魔之boss是否有限制
---@param monsterId number monster
---@return boolean 是否有限制
function cfg_demon_bossManager:MagicBossHaveLimit(monsterId)
    local magicBossTableInfo = self:TryGetValue(monsterId)
    if magicBossTableInfo == nil then
        return false
    end
    return magicBossTableInfo.hurtType > 0
end

---魔之boss是否可以攻击
---@param monsterId number monster
---@return boolean 是否可以攻击（破盾）
function cfg_demon_bossManager:MagicBossCanAttack(monsterId)
    local magicBossTableInfo = self:TryGetValue(monsterId)
    if magicBossTableInfo == nil then
        return false
    end
    local checkEquipType = magicBossTableInfo.hurtType
    local checkEquipParams = magicBossTableInfo.hurtParam
    if checkEquipType == LuaEnumMagicBossCheckEquipType.None then
        return true
    end
    if checkEquipType == LuaEnumMagicBossCheckEquipType.Equip then
        ---人物装备
        local equipIndexTable = self:GetHurtParamsTable(monsterId)
        if equipIndexTable == nil or type(equipIndexTable) ~= 'table' or CS.StaticUtility.IsNullOrEmpty(checkEquipParams) == true then
            return true
        end
        local levelAndReinLvTable = string.Split(checkEquipParams,'#')
        if levelAndReinLvTable ~= nil and type(levelAndReinLvTable) == 'table' and #levelAndReinLvTable > 1 then
            local reinLv = tonumber(levelAndReinLvTable[1])
            local level = tonumber(levelAndReinLvTable[2])
            for k,v in pairs(equipIndexTable) do
                local equipBagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(v)
                if equipBagItemInfo == nil or equipBagItemInfo.ItemTABLE == nil or (equipBagItemInfo.ItemTABLE.reinLv < reinLv and equipBagItemInfo.ItemTABLE.useLv < level) then
                    return false
                end
            end
        end
        return true
    elseif checkEquipType == LuaEnumMagicBossCheckEquipType.Servant then
        ---灵兽
        local servantDic = CS.CSScene.MainPlayerInfo.ServantInfoV2.Servants
        if servantDic == nil or servantDic.Count <= 0 then
            return false
        end
        local levelAndReinLvTable = string.Split(checkEquipParams,'#')
        if levelAndReinLvTable == nil then
            return true
        end
        local servantSeatTable = self:GetHurtParamsTable(monsterId)
        for k,v in pairs(servantSeatTable) do
            local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServentIndexByDic(v)
            if servantInfo ~= nil and servantInfo.servantEgg ~= nil then
                local limitReinLv = tonumber(levelAndReinLvTable[1])
                local limitLv = tonumber(levelAndReinLvTable[2])
                if limitReinLv ~= nil and servantInfo.rein >= limitReinLv then
                    return true
                end
                if limitLv ~= nil and servantInfo.level >= limitLv then
                    return true
                end
            end
        end
        return false
    end
    return false
end

---获取魔之boss配置的满状态恢复时间
---@param monsterId number monster
---@return number 满状态恢复时间
function cfg_demon_bossManager:GetMagicBossMaxStatusRecoverTime(monsterId)
    local recoverTime = 0
    local magicBossTableInfo = self:TryGetValue(monsterId)
    if magicBossTableInfo ~= nil and magicBossTableInfo.reFullTime ~= nil and type(magicBossTableInfo.reFullTime) == 'number' then
        recoverTime = magicBossTableInfo.reFullTime
    end
    return recoverTime
end

---获取魔之boss描述内容
---@param monsterId number monster
---@return string 描述内容
function cfg_demon_bossManager:GetMagicBossDes(monsterId)
    local des = ""
    local magicBossTableInfo = self:TryGetValue(monsterId)
    if magicBossTableInfo ~= nil and magicBossTableInfo.hurtType ~= nil then
        if magicBossTableInfo.hurtType == LuaEnumMagicBossCheckEquipType.Equip or magicBossTableInfo.hurtType == LuaEnumMagicBossCheckEquipType.Servant then
            local isCanAttack = self:MagicBossCanAttack(monsterId)
            local tableDes = string.Split(magicBossTableInfo.des,'#')
            if tableDes ~= nil and type(tableDes) == 'table' and #tableDes > 1 then
                des = ternary(isCanAttack == true,tableDes[1],tableDes[2])
            end
        end
    end
    return des
end

---获取魔之boss类型
---@param monsterId number monster
---@return LuaEnumMagicBossDropType 魔之boss类型
function cfg_demon_bossManager:GetMagicBossType(monsterId)
    local type = LuaEnumMagicBossDropType.None
    local magicBossTableInfo = self:TryGetValue(monsterId)
    if magicBossTableInfo ~= nil then
        return magicBossTableInfo.dropType
    end
    return type
end

---获取魔之boss击杀奖励表
---@param monsterId number 怪物id
---@param career number 职业
---@return table 击杀魔之boss奖励表
function cfg_demon_bossManager:GetMagicBossKillRewardTable(monsterId,career)
    local magicBossTableInfo = self:TryGetValue(monsterId)
    if magicBossTableInfo ~= nil and magicBossTableInfo.killReward ~= nil and magicBossTableInfo.killReward.list ~= nil and type(magicBossTableInfo.killReward.list) == 'table' then
        local killRewardTable = {}
        for k,v in pairs(magicBossTableInfo.killReward.list) do
            if v ~= nil and v.list ~= nil and type(v.list) == 'table' and #v.list > 3 then
                local configItemTable = v.list
                local itemTable = {}
                local configCareer = configItemTable[3]
                if configCareer == career or configCareer == LuaEnumCareer.Common then
                    local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(configItemTable[1]))
                    if itemInfoIsFind == true then
                        itemTable.itemInfo = itemInfo
                        itemTable.itemId = configItemTable[1]
                        itemTable.count = tonumber(configItemTable[2])
                        itemTable.career = tonumber(configItemTable[3])
                        itemTable.showGaiLv = configItemTable[4] ~= nil and configItemTable[4] == 1
                        table.insert(killRewardTable,itemTable)
                    end
                end
            end
        end
        return killRewardTable
    end
end

---检测魔之boss默认选择condition
---@param monsterId number 怪物id
---@return boolean 是否满足condition条件
function cfg_demon_bossManager:CheckMagicBossDefaultChooseCondition(monsterId)
    local magicBossTableInfo = self:TryGetValue(monsterId)
    if magicBossTableInfo ~= nil then
        if magicBossTableInfo:GetChooseCondition() == nil or magicBossTableInfo:GetChooseCondition() == 0 then
            return true
        end
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(magicBossTableInfo:GetChooseCondition())
    end
    return false
end
return cfg_demon_bossManager