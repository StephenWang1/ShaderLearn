---@class cfg_divinesuitManager:TableManager
local cfg_divinesuitManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_divinesuit
function cfg_divinesuitManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_divinesuit> 遍历方法
function cfg_divinesuitManager:ForPair(action)
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
function cfg_divinesuitManager:PostProcess()
end

---获取套装类型
---@param suitId number 套装id
---@return number 套装类型/nil
function cfg_divinesuitManager:GetSuitType(suitId)
    local tbl = self:TryGetValue(suitId)
    if tbl ~= nil then
        return tbl.type
    end
end

---@class divineSuitPartParams 神力套装套装部件参数
---@field suitPartType LuaEquipmentItemType
---@field partName string

---获取套装部件列表
---@param divineSuitId number
---@return table<divineSuitPartParams>
function cfg_divinesuitManager:GetDivineSuitParts(divineSuitId)
    local divineSuitTbl = self:TryGetValue(divineSuitId)
    if divineSuitTbl == nil or CS.StaticUtility.IsNullOrEmpty(divineSuitTbl:GetSubtypeShow()) then
        return
    end
    local divineSuitPartList = {}
    local partParamsList = string.Split(divineSuitTbl:GetSubtypeShow(),'&')
    if type(partParamsList) ~= 'table' or #partParamsList <= 0 then
        return
    end
    for k,v in pairs(partParamsList) do
        local partParams = string.Split(v,'#')
        if type(partParams) == 'table' and #partParams > 1 then
            ---@type divineSuitPartParams
            local divineSuitPartParams = {}
            divineSuitPartParams.suitPartType = tonumber(partParams[1])
            divineSuitPartParams.partName = partParams[2]
            table.insert(divineSuitPartList,divineSuitPartParams)
        end
    end
    return divineSuitPartList
end

return cfg_divinesuitManager