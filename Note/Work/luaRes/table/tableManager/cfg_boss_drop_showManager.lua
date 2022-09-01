---@class cfg_boss_drop_showManager:TableManager
local cfg_boss_drop_showManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_boss_drop_show
function cfg_boss_drop_showManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_boss_drop_show> 遍历方法
function cfg_boss_drop_showManager:ForPair(action)
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
function cfg_boss_drop_showManager:PostProcess()
end

---获取符合条件的Boss掉落信息列表
---@param id number
---@return table<number,TABLE.CFG_DROP_SHOW_GROUP>
function cfg_boss_drop_showManager:GetMeetDropItemInfoList(id)
    local tbl = {}
    local dropInfo = self:TryGetValue(id)
    if dropInfo then
        if dropInfo:GetDisplayConditionType() ~= nil then
            if dropInfo:GetDisplayConditionType() == 1 then
            elseif (dropInfo:GetDisplayConditionType() == 2) then
            elseif (dropInfo:GetDisplayConditionType() == 3) then
            elseif (dropInfo:GetDisplayConditionType() == 4) then
            elseif (dropInfo:GetDisplayConditionType() == 5) then
                if dropInfo:GetDropGroup() ~= nil and dropInfo:GetDropGroup().list ~= nil and dropInfo:GetDropGroup().list.Count > 0 then
                    for i = 0, dropInfo:GetDropGroup().list.Count - 1 do
                        if dropInfo:GetDropGroup().list[i].list ~= null and dropInfo:GetDropGroup().list[i].list.Count > 0 then
                            local targetTbl = clientTableManager.cfg_drop_show_groupManager:GetMeetItemGroupInfo(dropInfo:GetDropGroup().list[i].list)
                            for i = 1, #targetTbl do
                                table.insert(tbl, targetTbl[i])
                            end
                        end
                    end
                end
            end
        end
    end
    return tbl
end

return cfg_boss_drop_showManager