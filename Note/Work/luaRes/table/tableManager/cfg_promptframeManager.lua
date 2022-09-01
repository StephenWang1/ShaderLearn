---@class cfg_promptframeManager:TableManager
local cfg_promptframeManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_promptframe
function cfg_promptframeManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_promptframe> 遍历方法
function cfg_promptframeManager:ForPair(action)
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
function cfg_promptframeManager:PostProcess()
end

---获取气泡文本内容
---@param id number
---@return string
function cfg_promptframeManager:GetPopContent(id,...)
    ---@type TABLE.CFG_PROMPTFRAME
    local tableIsFind,csTable = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
    if csTable == nil or CS.StaticUtility.IsNullOrEmpty(csTable.content) then
        return
    end
    local des = string.format(csTable.content,...)
    return des
end

return cfg_promptframeManager