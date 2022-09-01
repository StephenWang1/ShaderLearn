---@class LuaTowerInfo:luaobject
local LuaTowerInfo = {}

--region 获取、设置Tower数据
---@return towerV2.ResRoleTowerInfo
function LuaTowerInfo:GetPlayerTowerData()
    if (self.mPlayerTowerData == nil) then
        self.mPlayerTowerData = {}
    end
    return self.mPlayerTowerData
end

---@param info towerV2.ResRoleTowerInfo
function LuaTowerInfo:SetPlayerTowerData(info)
    self.mPlayerTowerData = info
end

---获取当前层数的表数据
---@return TABLE.cfg_tower
function LuaTowerInfo:GetCurTowerTblData()
    local info = clientTableManager.cfg_towerManager:TryGetValue(self:GetPlayerTowerData().level)
    if (info ~= nil) then
        return info
    else
        ---默认第一关卡信息
        return clientTableManager.cfg_towerManager:TryGetValue(1)
    end
end

--endregion

---@return number 特效id
function LuaTowerInfo:GetItemEffectId(itemId)
    if self.mItemIsToNeedShowEffect == nil then
        self.mItemIsToNeedShowEffect = self:GetEffectShowData()
    end
    return self.mItemIsToNeedShowEffect[itemId]
end

---@return table<number,number> 道具id-特效id
function LuaTowerInfo:GetEffectShowData()
    local itemIdToEffect = {}
    local globalInfo = LuaGlobalTableDeal.GetGlobalTabl(22920)
    if globalInfo then
        local data = string.Split(globalInfo.value, '&')
        for i = 1, #data do
            local strs = string.Split(data[i], '#')
            if #strs >= 2 then
                local id = tonumber(strs[1])
                local effect = tonumber(strs[2])
                if id and effect then
                    itemIdToEffect[id] = effect
                end
            end
        end
    end
    return itemIdToEffect
end

---获取当前层数的奖励
---@return table<number,number> 道具id-道具数量
function LuaTowerInfo:GetCurrentReward()
    if (self.mCurrentReward == nil) then
        self.mCurrentReward = {}
    end
    return self.mCurrentReward
end

---设置当前层数的奖励
function LuaTowerInfo:SetCurrentReward(data)
    self.mCurrentReward = data
end

function LuaTowerInfo:Init()

end

function LuaTowerInfo:OnDestroy()

end

return LuaTowerInfo