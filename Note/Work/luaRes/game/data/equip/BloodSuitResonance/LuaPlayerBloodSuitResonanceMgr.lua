---血继套装数据管理   调用参考 gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitResonanceMgr()
---@class LuaPlayerBloodSuitResonanceMgr
local LuaPlayerBloodSuitResonanceMgr = {}

---初始化血继信息
function LuaPlayerBloodSuitResonanceMgr:Init()
    self:InitBloodSuitResonanceDicInfo()
end

---初始化血继套装信息
function LuaPlayerBloodSuitResonanceMgr:InitBloodSuitResonanceDicInfo()
    self.tableBloodGroupDic = clientTableManager.cfg_bloodsuit_resonanceManager:GetBloodGroupDic()
    if self.tableBloodGroupDic == nil then
        return
    end
    ---@type table<number,LuaPlayerBloodSuitResonanceGroup> 血继套装字典
    self.BloodSuitResonanceDic = {}
    for i, v in pairs(self.tableBloodGroupDic) do
        if self.BloodSuitResonanceDic[i] == nil then
            self.BloodSuitResonanceDic[i] = luaclass.LuaPlayerBloodSuitResonanceGroup:New()
        end
        self.BloodSuitResonanceDic[i]:RefreShData(i)
    end
end

---得到单个套装
---@param groupID number
function LuaPlayerBloodSuitResonanceMgr:GetSingleBloodSuitResonanceByGroupID(groupID)
    if self.BloodSuitResonanceDic[groupID] == nil then
        return nil
    end
    return self.BloodSuitResonanceDic[groupID]
end

---得到道具对应的套装列表
---@param 道具id
---@return table<number,LuaPlayerBloodSuitResonanceGroup>
function LuaPlayerBloodSuitResonanceMgr:GetSingleBloodSuitResonanceByItemID(itemId)
    if self.BloodSuitResonanceDic == nil then
        return nil
    end
        local Resonancelist = {}
    for i, v in pairs(self.BloodSuitResonanceDic) do
        ---@type LuaPlayerBloodSuitResonanceGroup
        local temp = v
        if temp ~= nil and temp:IsContainsTargetItem(itemId) then
            table.insert(Resonancelist, temp)
        end
    end
    return Resonancelist
end

return LuaPlayerBloodSuitResonanceMgr