---@class cfg_practice_roomManager:TableManager
local cfg_practice_roomManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_practice_room
function cfg_practice_roomManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_practice_room> 遍历方法
function cfg_practice_roomManager:ForPair(action)
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
function cfg_practice_roomManager:PostProcess()
end

---是否显示练功房倒计时
function cfg_practice_roomManager:IsPracticeMap(mapID)
    local dic = self:GetDupIdDic()
    if dic == nil then
        return false;
    end
    ---@type TABLE.cfg_practice_room
    local data = dic[mapID];
    if data == nil then
        return false
    end
    if data:GetExpUpCost() == nil or data:GetExpUpCost().list == nil or #data:GetExpUpCost().list == 0 then
        return false
    end
    return true, data
end

---得到副本ID字典
function cfg_practice_roomManager:GetDupIdDic()
    if self.dupIdDic == nil then
        self.dupIdDic = {}
        for i, v in pairs(self.dic) do
            ---@type TABLE.cfg_practice_room
            local Temp = v;
            if Temp:GetDupId() ~= nil then
                self.dupIdDic[Temp:GetDupId()] = v;
            end
        end
    end
    return self.dupIdDic
end

return cfg_practice_roomManager