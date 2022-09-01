---@class cfg_refine_masterManager:TableManager
local cfg_refine_masterManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_refine_master
function cfg_refine_masterManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_refine_master> 遍历方法
function cfg_refine_masterManager:ForPair(action)
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
function cfg_refine_masterManager:PostProcess()

end

---得到单个炼制详细信息数据
---@param key number 表ID
---@param isLimitCondtion boolean 筛选出符合限制条件的选项
---@return table<number,TableRefineDetailedInfo>
function cfg_refine_masterManager:GetSingleRefineDetailedInfo(key, isLimitCondtion)
    local nowData = self:TryGetValue(key)
    if nowData == nil then
        return nil
    end
    if nowData:GetCostNum() == nil or nowData:GetGainNum() == nil or nowData:GetCost() == nil or nowData:GetCondtions() == nil then
        return nil
    end
    local costList = string.Split(nowData:GetCostNum(), "#")
    local number1 = #costList
    local number2 = nowData:GetGainNum().list.Count
    local number3 = #nowData:GetCost().list
    local number4 = #nowData:GetCondtions().list
    local ismatching = number1 == number2 and number2 == number3 and number3 == number4
    if ismatching == false then
        return nil
    end
    ---@type table<number,TableRefineDetailedInfo>
    local RefineDetailedInfoList = {}
    for i = 1, number1 do
        ---@class TableRefineDetailedInfo
        local TableRefineDetailedInfo = {
            ---花费
            cost = tonumber(costList[i]),
            ---获得基准
            gain = nowData:GetGainNum().list[i - 1],
            ---消耗道具
            itemID = nowData:GetCost().list[i].list[1],
            ---消耗道具数量
            itemCost = nowData:GetCost().list[i].list[2],
            ---限制列表
            condtionsList = nowData:GetCondtions().list[i].list,
            ---兑换比例
            ratio = nowData:GetRatio().list[i],
            ---消耗道具兑换系数
            costRate = nowData:GetCostRate().list[i],
            ---index
            index = i,
        }
        local isMeetCondtion = true
        if isLimitCondtion and TableRefineDetailedInfo.condtionsList ~= nil then
            for i, v in pairs(TableRefineDetailedInfo.condtionsList) do
                if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) then
                    isMeetCondtion = false
                end
            end
        end
        if isMeetCondtion then
            table.insert(RefineDetailedInfoList, TableRefineDetailedInfo)
        end
    end
    return RefineDetailedInfoList
end

return cfg_refine_masterManager