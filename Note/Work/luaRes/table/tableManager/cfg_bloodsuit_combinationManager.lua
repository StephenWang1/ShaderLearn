---@class cfg_bloodsuit_combinationManager:TableManager
local cfg_bloodsuit_combinationManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_bloodsuit_combination
function cfg_bloodsuit_combinationManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_bloodsuit_combination> 遍历方法
function cfg_bloodsuit_combinationManager:ForPair(action)
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
function cfg_bloodsuit_combinationManager:PostProcess()
    self:InitEquipTypeDic()
end

---血继装备类型字典 k 页签类型 v TABLE.cfg_bloodsuit_combination
---@type table<number,TABLE.cfg_bloodsuit_combination>
cfg_bloodsuit_combinationManager.EquipTypeDic={}

---初始化装备类型字典
function cfg_bloodsuit_combinationManager:InitEquipTypeDic()
    if self.dic then
        for i, v in pairs(self.dic) do
            ---@type TABLE.cfg_bloodsuit_combination
            local temp=v;
            if temp~=nil then
                temp:GetType()
                cfg_bloodsuit_combinationManager.EquipTypeDic[temp:GetType()]=temp
            end
        end
    end
end

return cfg_bloodsuit_combinationManager