---@class cfg_inlay_effectManager:TableManager
local cfg_inlay_effectManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_inlay_effect
function cfg_inlay_effectManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_inlay_effect> 遍历方法
function cfg_inlay_effectManager:ForPair(action)
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
function cfg_inlay_effectManager:PostProcess()
end

---获取镶嵌效果特效杂项参数解析后的数据
---@param id number 表id
---@return LuaEnumInlayEffectTblParamsType,any
function cfg_inlay_effectManager:GetInlayEffectParticleParams(id)
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return
    end
    local paramsTable = Utility.ChangeNumberTable(string.Split(tbl:GetEffectParam(), '#'))
    if type(paramsTable) ~= 'table' or Utility.GetLuaTableCount(paramsTable) <= 0 then
        return
    end
    local paramsType = paramsTable[1]
    if paramsType == LuaEnumInlayEffectTblParamsType.EffectColor then
        local color = self:GetEffectColor(id)
        return paramsType, color
    end
end

---获取特效颜色
---@param id number 表id
---@return UnityEngine.Color
function cfg_inlay_effectManager:GetEffectColor(id)
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return
    end
    local paramsTable = Utility.ChangeNumberTable(string.Split(tbl:GetEffectParam(), '#'))
    if type(paramsTable) ~= 'table' or Utility.GetLuaTableCount(paramsTable) < 5 or paramsTable[1] ~= LuaEnumInlayEffectTblParamsType.EffectColor then
        return
    end
    local r = paramsTable[2] / 255
    local g = paramsTable[3] / 255
    local b = paramsTable[4] / 255
    local a = paramsTable[5] / 255
    return CS.UnityEngine.Color(r, g, b, a)
end

---获取buff表中的TipsDes
---@param id number
---@return string
function cfg_inlay_effectManager:GetBuffesTipsDes(id)
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return
    end
    local buffIDS = tbl:GetBuffers()
    if (buffIDS == nil or buffIDS.list == nil or #buffIDS.list < 0) then
        return
    end
    local str = ''
    for i = 1, #buffIDS.list do
        local buffTbl = clientTableManager.cfg_buffManager:TryGetValue(buffIDS.list[i])
        if (buffTbl ~= nil) then
            str = Utility.CombineStringQuickly(str, i == 0 and '' or '\n', buffTbl:GetTipsTxt())
        end
    end
    return str
end

return cfg_inlay_effectManager