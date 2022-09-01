---@class cfg_recastManager:TableManager
local cfg_recastManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_recast
function cfg_recastManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_recast> 遍历方法
function cfg_recastManager:ForPair(action)
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
function cfg_recastManager:PostProcess()
end

--region 重铸类型分类
---@type table<LuaEnumRecastType,table<number,TABLE.cfg_recast>> 表格类型分类
cfg_recastManager.RecastTypeList = nil


---获取重铸表列表
---@param type LuaEnumRecastType
---@return table<number,TABLE.cfg_recast>
function cfg_recastManager:GetRecastList(type)
    if self.RecastTypeList == nil then
        self:InitRecastTypeList()
    end
    if type(self.RecastTypeList) == 'table' then
        return self.RecastTypeList[type]
    end
end

---获取重铸默认表（等级为1的表）
---@param type LuaEnumRecastType
---@return TABLE.cfg_recast
function cfg_recastManager:GetFistRecastTbl(type)
    return self:GetRecastTbl(type,1)
end

---通过类型和等级获取重铸表
---@param curType LuaEnumRecastType
---@param level number
---@return TABLE.cfg_recast
function cfg_recastManager:GetRecastTbl(curType, level)
    if self.RecastTypeList == nil then
        self:InitRecastTypeList()
    end
    if type(self.RecastTypeList) == 'table' and type(self.RecastTypeList[curType]) == 'table' then
        return self.RecastTypeList[curType][level]
    end
end

---初始化重铸类型列表
function cfg_recastManager:InitRecastTypeList()
    if type(self.RecastTypeList) == 'table' or type(self.dic) ~= 'table' then
        return
    end
    self.RecastTypeList = {}
    for k,v in pairs(self.dic) do
        ---@type TABLE.cfg_recast
        local tbl = v
        if type(self.RecastTypeList[tbl:GetType()]) ~= 'table' then
            self.RecastTypeList[tbl:GetType()] = {}
        end
        self.RecastTypeList[tbl:GetType()][tbl:GetLevel()] = tbl
    end
end
--endregion

--region 获取
---@return table<CostItemInfo> 升级重铸道具消耗
function cfg_recastManager:GetUpRecastItemCost(recastId)
    if type(recastId) ~= 'number' then
        return
    end
    local costItemInfoList = {}
    local recastTbl = self:TryGetValue(recastId)
    if recastTbl ~= nil and recastTbl:GetCost() ~= nil and Utility.GetLuaTableCount(recastTbl:GetCost().list) > 0 then
        for k,v in pairs(recastTbl:GetCost().list) do
            ---@type CostItemInfo
            local costItemInfo = {}
            ---@type TABLE.IntList
            local itemIdAndCount = v
            if itemIdAndCount ~= nil and itemIdAndCount.list ~= nil and #itemIdAndCount.list > 1 then
                costItemInfo.itemId = itemIdAndCount.list[1]
                costItemInfo.costNumber = itemIdAndCount.list[2]
                table.insert(costItemInfoList,costItemInfo)
            end
        end
    end
    return costItemInfoList
end

---@return table<CostItemInfo> 升级重铸货币消耗
function cfg_recastManager:GetUpRecastCoinCost(recastId)
    if type(recastId) ~= 'number' then
        return
    end
    local costItemInfoList = {}
    local recastTbl = self:TryGetValue(recastId)
    if recastTbl ~= nil and recastTbl:GetCost2() ~= nil and Utility.GetLuaTableCount(recastTbl:GetCost2().list) > 1 then
        ---@type CostItemInfo
        local costItemInfo = {}
        costItemInfo.itemId = recastTbl:GetCost2().list[1]
        costItemInfo.costNumber = recastTbl:GetCost2().list[2]
        table.insert(costItemInfoList,costItemInfo)
    end
    return costItemInfoList
end

---@return string 获取重铸技能描述内容
function cfg_recastManager:GetRecastSkillDes(recastId)
    if type(recastId) ~= 'number' then
        return
    end
    local recastTbl = self:TryGetValue(recastId)
    if recastTbl ~= nil then
        return recastTbl:GetDesc()
    end
end

---@param recastId number
---@return TABLE.cfg_buff 通过重铸id获取buff表信息
function cfg_recastManager:GetBuffInfoByRecastId(recastId)
    if type(recastId) ~= 'number' then
        return
    end
    local recastTbl = self:TryGetValue(recastId)
    if recastTbl ~= nil and type(recastTbl:GetBuffid()) == 'number' then
        return clientTableManager.cfg_buffManager:TryGetValue(recastTbl:GetBuffid())
    end
end

---@param recastId number
---@return string 物品信息面板buff描述内容
function cfg_recastManager:GetItemInfoPanelDes(recastId)
    local buffTbl = self:GetBuffInfoByRecastId(recastId)
    if buffTbl ~= nil then
        return buffTbl:GetTipsTxt()
    end
end
--endregion

return cfg_recastManager