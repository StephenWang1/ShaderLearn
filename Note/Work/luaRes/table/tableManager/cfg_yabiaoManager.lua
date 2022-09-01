---@class cfg_yabiaoManager:TableManager
local cfg_yabiaoManager = {}

--region 基础刷新
---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_yabiao
function cfg_yabiaoManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_yabiao> 遍历方法
function cfg_yabiaoManager:ForPair(action)
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
function cfg_yabiaoManager:PostProcess()
end
--endregion

--region 数据
---@type table<LuaEnumPersonDartCarType,table<TABLE.cfg_yabiao>> 押镖分类型字典
cfg_yabiaoManager.ConfigYaBiaoDic = nil

---初始化镖车分类字典
function cfg_yabiaoManager:InitConfigYaBiaoDic()
    if self.ConfigYaBiaoDic ~= nil then
        return
    end
    self.ConfigYaBiaoDic = {}
    if self.dic ~= nil and type(self.dic) == 'table' then
        for k,v in pairs(self.dic) do
            ---@type TABLE.cfg_yabiao
            local configYaBiaoTbl = v
            if configYaBiaoTbl ~= nil and configYaBiaoTbl:GetType() ~= nil then
                if self.ConfigYaBiaoDic[configYaBiaoTbl:GetType()] == nil then
                    self.ConfigYaBiaoDic[configYaBiaoTbl:GetType()] = {}
                end
                local configYaBiaoList = self.ConfigYaBiaoDic[configYaBiaoTbl:GetType()]
                table.insert(configYaBiaoList,configYaBiaoTbl)
            end

        end
    end
end

---通过镖车类型获取配置镖车信息列表
---@param dartCarType LuaEnumPersonDartCarType
---@return table<TABLE.cfg_yabiao> 配置的镖车列表
function cfg_yabiaoManager:GetConfigYaBiaoList(dartCarType)
    if self.ConfigYaBiaoDic == nil then
        self:InitConfigYaBiaoDic()
    end
    return self.ConfigYaBiaoDic[dartCarType]
end
--endregion

--region 获取
---获取奖励列表
---@param dartCarId number 镖车id
---@return table<table<number,number>> 奖励列表
function cfg_yabiaoManager:GetRewardList(dartCarId)
    local tbl = self:TryGetValue(dartCarId)
    local rewardTbl = {}
    if tbl ~= nil then
        local reward = tbl:GetReward()
        if reward ~= nil and type(reward.list) == 'table' and Utility.GetLuaTableCount(reward.list) %2 == 0 then
            local count = reward.list / 2
            for k = 1,count do
                local itemTbl = {}
                itemTbl.itemId = tonumber(reward.list[k * 2 - 1])
                itemTbl.count = tonumber(reward.list[k * 2])
                table.insert(rewardTbl,itemTbl)
            end
        end
    end
    return rewardTbl
end

---获取花费列表
---@param dartCarId number 镖车id
---@return table<table<number,number>> 花费列表
function cfg_yabiaoManager:GetCostList(dartCarId)
    local tbl = self:TryGetValue(dartCarId)
    local costTbl = {}
    if tbl ~= nil then
        local cost = tbl:GetConsume()
        if cost ~= nil and type(cost.list) == 'table' and Utility.GetLuaTableCount(cost.list) %2 == 0 then
            local count = cost.list / 2
            for k = 1,count do
                local itemTbl = {}
                itemTbl.itemId = tonumber(cost.list[k * 2 - 1])
                itemTbl.count = tonumber(cost.list[k * 2])
                table.insert(costTbl,itemTbl)
            end
        end
    end
    return costTbl
end

---获取白日门押镖奖励列表
---@param dartCarId number 镖车id
---@return table<table<number,number>> 奖励列表
function cfg_yabiaoManager:GetBaiRiMenRewardList(dartCarId)
    local tbl = self:TryGetValue(dartCarId)
    local rewardTbl = {}
    if tbl ~= nil then
        local reward = tbl:GetRewardNew()
        if reward ~= nil and type(reward.list) == 'table' and Utility.GetLuaTableCount(reward.list) > 0 then
            for k,v in pairs(reward.list) do
                if type(v.list) == 'table' and Utility.GetLuaTableCount(v.list) > 1 then
                    local itemTbl = {}
                    itemTbl.itemId = tonumber(v.list[1])
                    itemTbl.count = tonumber(v.list[2])
                    table.insert(rewardTbl,itemTbl)
                end
            end
        end
    end
    return rewardTbl
end

---获取白日门押镖消耗列表
---@param dartCarId number 镖车id
---@return table<table<number,number>> 奖励列表
function cfg_yabiaoManager:GetBaiRiMenCostList(dartCarId)
    local tbl = self:TryGetValue(dartCarId)
    local costTbl = {}
    if tbl ~= nil then
        local cost = tbl:GetConsumeNew()
        if cost ~= nil and type(cost.list) == 'table' and Utility.GetLuaTableCount(cost.list) > 0 then
            for k,v in pairs(cost.list) do
                if type(v.list) == 'table' and Utility.GetLuaTableCount(v.list) > 1 then
                    local itemTbl = {}
                    itemTbl.itemId = tonumber(v.list[1])
                    itemTbl.count = tonumber(v.list[2])
                    table.insert(costTbl,itemTbl)
                end
            end
        end
    end
    return costTbl
end
--endregion

return cfg_yabiaoManager