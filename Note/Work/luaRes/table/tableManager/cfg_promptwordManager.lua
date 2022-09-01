---@class cfg_promptwordManager:TableManager
local cfg_promptwordManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_promptword
function cfg_promptwordManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_promptword> 遍历方法
function cfg_promptwordManager:ForPair(action)
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
function cfg_promptwordManager:PostProcess()
end

---获取二次确认文本
---@param id number
---@return string
function cfg_promptwordManager:GetSecondConfirmContent(id,...)
    ---@type TABLE.CFG_PROMPTWORD
    local tableIsFind,csTable = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(id)
    if csTable == nil or CS.StaticUtility.IsNullOrEmpty(csTable.des) then
        return
    end
    local des = string.format(csTable.des,...)
    des = string.gsub(des, '\\n', '\n')
    return des
end

return cfg_promptwordManager