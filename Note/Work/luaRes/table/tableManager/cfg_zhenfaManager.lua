---@class cfg_zhenfaManager:TableManager
local cfg_zhenfaManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_zhenfa
function cfg_zhenfaManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_zhenfa> 遍历方法
function cfg_zhenfaManager:ForPair(action)
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
function cfg_zhenfaManager:PostProcess()
end

---获取已解锁的阵法装备位
---@param zhenFaId number
---@return table<LuaEnumPlayerEquipIndex>
function cfg_zhenfaManager:GetUnLockedEquipIndex(zhenFaId)
    local zhenFaTbl = self:TryGetValue(zhenFaId)
    if zhenFaTbl == nil or zhenFaTbl:GetSubtype() == nil or zhenFaTbl:GetSubtype().list == nil then
        return
    end
    return zhenFaTbl:GetSubtype().list
end

---@class FaZhenEffectInfo
---@field faZhenEffectName string
---@field faZhenLocalPosition UnityEngine.Vector3
---@field faZhenScale UnityEngine.Vector3


---@param zhenFaId
---@return table<number,FaZhenEffectInfo>
function cfg_zhenfaManager:GetFaZhenEffectInfoList(zhenFaId)
    local zhenFaTbl = self:TryGetValue(zhenFaId)
    local effectNameTable = {}
    if zhenFaTbl ~= nil then
        local effectName = zhenFaTbl:GetEffectName()
        local effect1Info = self:GetZhenFaEffect(zhenFaTbl:GetEffect1())
        if effect1Info ~= nil and CS.StaticUtility.IsNullOrEmpty(effectName) == false then
            effect1Info.faZhenEffectName = string.format("%s_1", effectName)
            effectNameTable[1] = effect1Info
        end

        local effect2Info = self:GetZhenFaEffect(zhenFaTbl:GetEffect2())
        if effect2Info ~= nil and CS.StaticUtility.IsNullOrEmpty(effectName) == false then
            effect2Info.faZhenEffectName = string.format("%s_2", effectName)
            effectNameTable[2] = effect2Info
        end
    end
    return effectNameTable
end

---@param effectFormat  TABLE.IntListJingHao
---@return FaZhenEffectInfo
function cfg_zhenfaManager:GetZhenFaEffect(effectFormat)
    if effectFormat == nil then
        return
    end
    ---@type FaZhenEffectInfo
    local zhenFaEffectInfo = {}
    local effectInfoList = effectFormat.list
    if type(effectInfoList) ~= 'table' or #effectInfoList < 4 then
        return
    end
    zhenFaEffectInfo.faZhenLocalPosition = CS.UnityEngine.Vector3(10000 - tonumber(effectInfoList[1]), 10000 - tonumber(effectInfoList[2]), 10000 - tonumber(effectInfoList[3]))
    zhenFaEffectInfo.faZhenScale = CS.UnityEngine.Vector3(tonumber(effectInfoList[4]) / 100, tonumber(effectInfoList[5]) / 100, 0)
    return zhenFaEffectInfo
end

return cfg_zhenfaManager