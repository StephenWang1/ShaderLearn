---@class cfg_deliverManager:TableManager
local cfg_deliverManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_deliver
function cfg_deliverManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_deliver> 遍历方法
function cfg_deliverManager:ForPair(action)
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
function cfg_deliverManager:PostProcess()
end

---检测玩家是否可以进入配置的地图
---@param deliverId number
function cfg_deliverManager:CheckMainPlayerCanEnterMap(deliverId)
    local tbl = self:TryGetValue(deliverId)
    if tbl == nil then
        return false
    end
    if tbl:GetToMapId() == nil or tbl:GetToMapId() == 0 then
        return true
    end
    local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(tbl:GetToMapId())
    if mapTbl == nil then
        return false
    end
    if mapTbl:GetConditionId() == nil or mapTbl:GetConditionId().list == nil then
        return true
    end
    return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(mapTbl:GetConditionId().list)
end

---获取传送的mapId
---@param deliverId number
function cfg_deliverManager:GetToMapId(deliverId)
    local tbl = self:TryGetValue(deliverId)
    if tbl == nil then
        return 0
    end
    return tbl:GetToMapId()
end

---通过itemId获取jumpId
---@param deliverId number
---@param itemId number
---@return number/nil jumpId
function cfg_deliverManager:GetJumpIdByItemId(deliverId, itemId)
    local tbl = self:TryGetValue(deliverId)
    if tbl == nil then
        return 0
    end

    local costItemList = string.Split(tbl:GetItem(), '&')
    local index = 1
    for k, v in pairs(costItemList) do
        if CS.StaticUtility.IsNullOrEmpty(v) == false then
            local itemIdAndCostNum = string.Split(v, '#')
            if #itemIdAndCostNum > 1 then
                local curItemId = tonumber(itemIdAndCostNum[1])
                if curItemId == itemId then
                    break
                end
            end
        end
        index = index + 1
    end
    if tbl:GetItemJump() ~= nil and tbl:GetItemJump().list ~= nil and index <= #tbl:GetItemJump().list then
        return tbl:GetItemJump().list[index]
    end
end

---检测玩家是否可以传送配置的地图
---@param deliverId number
function cfg_deliverManager:CheckMainPlayerCanDeliverMap(deliverId)
    local tbl = self:TryGetValue(deliverId)
    if tbl == nil then
        return false
    end
    return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditonListOrList(tbl:GetCondition())
end

---@class DeliverCondition
---@field conditionTbl TABLE.cfg_conditions
---@field isMeet boolean
---@field str string

---获得传送限制条件信息
---@param deliverId number
---@return table<table<DeliverCondition>>
function cfg_deliverManager:GetDeliverConditionInfo(deliverId)
    local conditionInfoTbl = {}
    local tbl = self:TryGetValue(deliverId)
    if tbl == nil then
        return nil
    end
    if tbl:GetCondition() == nil or tbl:GetCondition().list == nil or tbl:GetCondition().list.Count == 0 then
        return nil
    end
    local mIsMeet = 0
    local condtionTbl, conditionId
    for i = 0, tbl:GetCondition().list.Count - 1 do
        local conditionInfoList = {}
        if tbl:GetCondition().list[i].list ~= nil and tbl:GetCondition().list[i].list.Count > 0 then
            for j = 0, tbl:GetCondition().list[i].list.Count - 1 do
                conditionId = tbl:GetCondition().list[i].list[j]
                ---@type TABLE.cfg_conditions
                condtionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(conditionId)
                if condtionTbl then
                    mIsMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId)
                    table.insert(conditionInfoList,
                            {
                                conditionTbl = condtionTbl,
                                isMeet = mIsMeet,
                                str = condtionTbl:GetTxt()
                            })
                end
            end
        end
        if #conditionInfoList > 0 then
            table.insert(conditionInfoTbl, conditionInfoList)
        end
    end
    return conditionInfoTbl
end

---获得传送显示文本
---@return string
function cfg_deliverManager:GetDeliverConditionStr(deliverId)
    local str = ''
    local tbl = self:GetDeliverConditionInfo(deliverId)
    local isFirst = false
    if tbl then
        for i = 1, #tbl do
            if i ~= 1 then
                str = str .. ' 或 '
            end
            isFirst = true
            if tbl[i] ~= nil and #tbl[i] > 0 then
                for j = 1, #tbl[i] do
                    local info = tbl[i][j]
                    if info.str ~= nil and info.str ~= '' then
                        if isFirst then
                            isFirst = false
                        else
                            str = str .. ' 和 '
                        end
                        if info.isMeet then
                            str = str .. '[00ff00]'
                        else
                            str = str .. '[e85038]'
                        end
                        str = str .. info.str .. '[-]'
                    end
                end
            end
        end
    end
    return str
end

return cfg_deliverManager