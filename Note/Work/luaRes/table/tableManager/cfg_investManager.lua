---@class cfg_investManager:TableManager
local cfg_investManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_invest
function cfg_investManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_invest> 遍历方法
function cfg_investManager:ForPair(action)
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
function cfg_investManager:PostProcess()

end

---得到投资期数字典
---@return table<number,table<number,TABLE.cfg_invest>> key  投资期数  value 同期数的所有数据
function cfg_investManager:GetInvestTurmDic()
    if self.mInvestGroupDic == nil then
        ---@type table<number,table<number,TABLE.cfg_invest>> key  投资期数  value 同期数的所有数据
        self.mInvestGroupDic = {}
        for i, v in pairs(self.dic) do
            ---@type TABLE.cfg_invest
            local temp = v
            if self.mInvestGroupDic[temp:GetTurn()] == nil then
                self.mInvestGroupDic[temp:GetTurn()] = {}
            end
            table.insert(self.mInvestGroupDic[temp:GetTurn()], v)
        end
    end
    return self.mInvestGroupDic
end

return cfg_investManager