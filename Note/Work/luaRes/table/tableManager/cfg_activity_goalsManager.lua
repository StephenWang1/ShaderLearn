---@class cfg_activity_goalsManager:TableManager
local cfg_activity_goalsManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_activity_goals
function cfg_activity_goalsManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_activity_goals> 遍历方法
function cfg_activity_goalsManager:ForPair(action)
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
function cfg_activity_goalsManager:PostProcess()
end

---获取活动进度
---@return number,number 完成进度，目标进度
function cfg_activity_goalsManager:GetActivityProgress(activityId)
    local finish = -1
    local aim = -1
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return finish, aim
    end

    local data = self:TryGetValue(activityId)
    if data then
        aim = data:GetGoalParam()
        local goalType = data:GetGoalType()

        local finishItemIdList = nil
        if data:GetGoalExtParams() and data:GetGoalExtParams().list then
            finishItemIdList = data:GetGoalExtParams().list;
        end
        if goalType then
            if goalType == 1000 then
                ---角色等级大于
                finish = mainPlayerInfo.Level
            elseif goalType == 1001 then
                ---角色转生大于goalParam
                finish = mainPlayerInfo.ReinLevel
            elseif goalType == 1008 then
                ---战勋达到nbvalue
                local prefixId = math.ceil((math.floor((aim - 1) / 10) + 1) * 1000 + math.floor((aim - 1) % 10) + 1)
                local res, prefixData = CS.Cfg_PrefixTableManager.Instance.dic:TryGetValue(prefixId)
                if res then
                    aim = prefixData.nbvalue
                end
                finish = mainPlayerInfo.FightPower
            elseif goalType == 1012 then
                ---宝石等级达到
                local baoShiId = mainPlayerInfo.BagInfo.SpecialEquipID_BaoShi
                local res, godFuranceinfio = CS.Cfg_GodFurnaceTableManager.Instance.dic:TryGetValue(baoShiId)
                if res then
                    finish = tonumber(godFuranceinfio.lv)
                end
            elseif goalType == 1013 then
                ---穿戴aim件aimLevel1等级aimlevel2转生等级装备
                local equipNum = 0
                if (finishItemIdList and #finishItemIdList >= 2) then
                    aim = finishItemIdList[1]
                    local aimLevel1 = finishItemIdList[2]
                    local aimLevel2 = 0
                    if (#finishItemIdList >= 3) then
                        aimLevel2 = finishItemIdList[3]
                    end
                    local data = mainPlayerInfo.EquipInfo.Equips
                    for k, v in pairs(data) do
                        ---@type TABLE.CFG_ITEMS
                        local itemInfo = v.ItemTABLE
                        if itemInfo then
                            if (itemInfo.reinLv >= aimLevel2 and aimLevel2 ~= 0) or (itemInfo.useLv >= aimLevel1 and aimLevel1) then
                                equipNum = equipNum + 1
                            end
                        end
                    end
                end
                finish = equipNum
            elseif goalType == 1014 then
                ---aim件装备达到星
                finish = 0
                if finishItemIdList and #finishItemIdList >= 2 then
                    aim = finishItemIdList[1]
                    local data = mainPlayerInfo.EquipInfo.Equips
                    for k, v in pairs(data) do
                        ---@type TABLE.CFG_ITEMS
                        local itemInfo = v.ItemTABLE
                        if itemInfo then
                            if itemInfo.intensify >= finishItemIdList[1] then
                                finish = finish + 1
                            end
                        end
                    end
                end
            elseif goalType == 1015 then
                aim = 1
                if finishItemIdList then
                    local data = mainPlayerInfo.EquipInfo.Equips
                    for k, v in pairs(data) do
                        ---@type TABLE.CFG_ITEMS
                        local itemInfo = v.ItemTABLE
                        if itemInfo then
                            for i = 1, #finishItemIdList do
                                if finishItemIdList[i] == itemInfo.id then
                                    finish = 1
                                    return finish, aim
                                end
                            end
                        end
                    end
                end
                finish = 0
            elseif goalType == 1016 then
                ---镶嵌aimProgress 个 level等级以上元素
                local progress = 0
                if finishItemIdList and #finishItemIdList >= 2 then
                    aim = finishItemIdList[1]
                    local level = finishItemIdList[2]
                    local data = mainPlayerInfo.ElementInfo.Elements
                    for k, v in pairs(data) do
                        local res, elementData = CS.Cfg_ElementTableManager.Instance.dic:TryGetValue(v.id)
                        if res then
                            if elementData.quality >= level then
                                progress = progress + 1
                            end
                        end
                    end
                end
                finish = progress
            elseif goalType == 1017 then
                ---穿戴aim件(level级或reinlevel转) （type（1武器衣服2防具3首饰4首饰或防具））
                local progress = 0
                if finishItemIdList and #finishItemIdList >= 4 then
                    aim = finishItemIdList[1]
                    local type = finishItemIdList[2]
                    local level = finishItemIdList[3]
                    local reinLevel = finishItemIdList[4]
                    local data = mainPlayerInfo.EquipInfo.Equips
                    for k, v in pairs(data) do
                        ---@type TABLE.CFG_ITEMS
                        local itemInfo = v.ItemTABLE
                        if itemInfo then
                            if (itemInfo.useLv >= level) or (itemInfo.reinLv >= reinLevel) then
                                if itemInfo.type == luaEnumItemType.Equip then
                                    local subType = itemInfo.subType
                                    if type == 1 then
                                        if subType == LuaEnumEquipSubType.Equip_wuqi or subType == LuaEnumEquipSubType.Equip_yifu then
                                            progress = progress + 1
                                        end
                                    elseif type == 2 then
                                        if subType == LuaEnumEquipSubType.Equip_toukui or subType == LuaEnumEquipSubType.Equip_yaodai or subType == LuaEnumEquipSubType.Equip_xiezi then
                                            progress = progress + 1
                                        end
                                    elseif type == 3 then
                                        if subType == LuaEnumEquipSubType.Equip_xianglian or subType == LuaEnumEquipSubType.Equip_shouzhuo or subType == LuaEnumEquipSubType.Equip_jiezhi then
                                            progress = progress + 1
                                        end
                                    elseif type == 4 then
                                        if subType == LuaEnumEquipSubType.Equip_toukui or subType == LuaEnumEquipSubType.Equip_yaodai
                                                or subType == LuaEnumEquipSubType.Equip_xiezi or subType == LuaEnumEquipSubType.Equip_xianglian
                                                or subType == LuaEnumEquipSubType.Equip_shouzhuo or subType == LuaEnumEquipSubType.Equip_jiezhi then
                                            progress = progress + 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                finish = progress
            elseif goalType == 1018 then
                ---灵兽战力
                local servant1 = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantFightPower(1)
                local servant2 = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantFightPower(2)
                local servant3 = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantFightPower(3)
                finish = servant1 + servant2 + servant3
            elseif goalType == 1019 then
                ---灯芯
                local dxID = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_DengXin
                ---@type TABLE.CFG_GODFURNACE
                local tab2
                local isget, tab2 = CS.Cfg_GodFurnaceTableManager.Instance:TryGetValue(dxID)
                if (isget) then
                    finish = tab2.lv
                end
            elseif goalType == 1020 then
                ---勋章
                finish = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.ShengWang)
            elseif goalType == 1021 then
                ---矿
                finish = Utility.BlackIronCost
            elseif goalType == 1022 then
                ---人物等级达到X级或Y转
                if finishItemIdList and #finishItemIdList >= 2 then
                    aim = 1
                    local level = finishItemIdList[1]
                    local reinLevel = finishItemIdList[2]
                    if mainPlayerInfo.Level >= level or mainPlayerInfo.ReinLevel >= reinLevel then
                        finish = 1
                    else
                        finish = 0
                    end
                end
            elseif goalType == 1023 then
                ---装备专精总登记
                finish = gameMgr:GetPlayerDataMgr():GetEquipProficientMgr().AllLevel
                aim = data:GetGoalParam()
            end
        end
    end
    ---有些条件没开 ==-1 这时候进度里并不能展示出来,需要处理成0:元石竞技,灯芯
    if (finish < 0) then
        finish = 0
    end
    return finish, aim
end

return cfg_activity_goalsManager