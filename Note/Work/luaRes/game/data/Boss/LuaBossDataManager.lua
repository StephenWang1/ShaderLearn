---@class LuaBossDataManager boss管理类
local LuaBossDataManager = {}

---@param tblData roleV2.BossKillData 存储终极boss击杀数据
function LuaBossDataManager:SaveFinalBossData(tblData)
    self.mMainBossKillData = tblData
    for i = 1, #tblData.killDatas do
        self:SaveSingleTypeData(tblData.killDatas[i])
    end
    luaEventManager.DoCallback(LuaCEvent.FinalBossTimesChange)
end

---@param typeKillData roleV2.BossTypeKillData 存储每个类型数据
function LuaBossDataManager:SaveSingleTypeData(typeKillData)
    if self.mBossTypeToKillData == nil then
        self.mBossTypeToKillData = {}
    end
    self.mBossTypeToKillData[typeKillData.type] = typeKillData
end

---@return roleV2.BossTypeKillData 单个类型对应数据
---@param type LuaEnumFinalBossType
function LuaBossDataManager:GetSingleTypeData(type)
    if self.mBossTypeToKillData == nil then
        return
    end
    return self.mBossTypeToKillData[type]
end

---生肖Boss状态储存
function LuaBossDataManager:SaveShengXiaoState(state)
    self.state = state
end

---生肖boss状态获取
function LuaBossDataManager:SetBossState(tblData, needshow)
    self.tblData = tblData
    if tblData == nil then
        return
    end
    for i = 1, #tblData.boss do
        if tblData.boss[i].monsterLid ~= 0 then
            self:SaveShengXiaoState(2)
            if needshow == true then
                CS.CSUIRedPointManager.GetInstance():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_ShengXiao))
            end
            return
        end
    end
    if tblData.time == nil then
        return
    end
    ---显示次日还是今日的判断 时间策划说写死
    local tenHour = 36000000
    if tblData.time - CS.CSServerTime.Instance.TotalMillisecond - tenHour < 0 then
        self:SaveShengXiaoState(1)
        return
    end
    self:SaveShengXiaoState(3)
end

---获取生肖Boss状态
function LuaBossDataManager:GetShengXiaoState()
    self:SetBossState(self.tblData)
    return self.state
end

---生肖Boss红点
function LuaBossDataManager:ShengXiaoRedPoint()
    if self.isOpen == nil or self.isOpen == false then
        if self.state == 2 and self:IsMatchCondition() then
            return true
        end
    end
    return false
end

---是否满足生肖boss条件
function LuaBossDataManager:IsMatchCondition()
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(23110)
    if Lua_GlobalTABLE == nil then
        return true
    end
    local condition = string.Split(Lua_GlobalTABLE.value, "#")
    for i = 1, #condition do
        local conditionResult = Utility.IsMainPlayerMatchCondition_LuaAndCS(tonumber(condition[i]))
        if conditionResult.success == false then
            return false
        end
    end
    return true

end

---缓存是否显示红点
function LuaBossDataManager:SaveIsOpen()
    if self.state == 2 then
        self.isOpen = true
    end
end

return LuaBossDataManager