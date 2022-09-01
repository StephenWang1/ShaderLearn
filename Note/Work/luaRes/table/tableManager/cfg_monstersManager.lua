---@class cfg_monstersManager:TableManager
local cfg_monstersManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_monsters
function cfg_monstersManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_monsters> 遍历方法
function cfg_monstersManager:ForPair(action)
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
function cfg_monstersManager:PostProcess()
end

---获取Boss掉落信息列表
---@return table<number,TABLE.CFG_DROP_SHOW_GROUP>
function cfg_monstersManager:GetDropShowList(id)
    local tbl = {}
    local info = self:TryGetValue(id)
    if info ~= nil and info:GetDropShow() ~= nil then
        local dropinfo = CS.Cfg_BossDropShowTableManager.Instance:GetDropItemList(info:GetDropShow().list)
        if (dropinfo ~= nil) then
            for i = 0, dropinfo.Length - 1 do
                local list = clientTableManager.cfg_boss_drop_showManager:GetMeetDropItemInfoList(dropinfo[i].id)
                for i = 1, #list do
                    table.insert(tbl, list[i])
                end
            end
        end
    end
    return tbl
end

return cfg_monstersManager