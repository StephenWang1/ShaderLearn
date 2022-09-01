---@class cfg_recoverManager:TableManager
local cfg_recoverManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_recover
function cfg_recoverManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_recover> 遍历方法
function cfg_recoverManager:ForPair(action)
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
function cfg_recoverManager:PostProcess()
end

--region 回收选项
---@return table<number,TABLE.cfg_recover>
function cfg_recoverManager:GetAllMenu()
    if self.mRecoverList == nil then
        self.mRecoverList = {}
        self:ForPair(function(k, v)
            table.insert(self.mRecoverList, v)
        end)
    end
    return self.mRecoverList
end
--endregion

return cfg_recoverManager