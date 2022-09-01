---@class cfg_uilogicManager:TableManager
local cfg_uilogicManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_uilogic
function cfg_uilogicManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_uilogic> 遍历方法
function cfg_uilogicManager:ForPair(action)
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
function cfg_uilogicManager:PostProcess()
end

---获取界面名对应的UI逻辑
---@param panelName
---@return TABLE.cfg_uilogic
function cfg_uilogicManager:GetUILogic(panelName)
    if self.dic then
        for i, v in pairs(self.dic) do
            ---@type TABLE.cfg_uilogic
            local tbl = v
            if tbl:GetPanelName() == panelName then
                return tbl
            end
        end
    end
    return nil
end

return cfg_uilogicManager