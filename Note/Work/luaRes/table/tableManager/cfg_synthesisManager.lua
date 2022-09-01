---@class cfg_synthesisManager:TableManager
local cfg_synthesisManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_synthesis
function cfg_synthesisManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_synthesis> 遍历方法
function cfg_synthesisManager:ForPair(action)
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
function cfg_synthesisManager:PostProcess()
end

---合成配方对应的合成单体数据
---@type table<number, LuaSynthesis_Item> key为合成表ID
cfg_synthesisManager.AllSynthesisDic = {}

---根据传入的材料,判定是存在对应的合成配方
---@param itemId 道具ItemId
function cfg_synthesisManager:IsCanSynthesis(itemId)
    return gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisByItemId(itemId) ~= nil
end

return cfg_synthesisManager