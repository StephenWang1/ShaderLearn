---@class LuaSkillDetailedInfo 单个技能详细信息
local LuaSkillDetailedInfo = {}

---得到技能表
---@return TABLE.cfg_skills
function LuaSkillDetailedInfo:GetSkillTable()
    if self.mskillTable == nil and self.skillid ~= nil then
        self.mskillTable = clientTableManager.cfg_skillsManager:TryGetValue(self.skillid)
    end
    return self.mskillTable
end

---是否满足学习技能条件
---@return TABLE.cfg_skills
function LuaSkillDetailedInfo:IsMeetStudyCondition()
    if self:GetSkillTable() ~= nil then
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(self:GetSkillTable():GetCondition())
    end
end

---得到当前技能条件表
---@return TABLE.cfg_skills_condition
function LuaSkillDetailedInfo:GetNowSkillsConditionTable()
    if self.mNowSkillsCondition == nil and self.skillid ~= nil and self.level ~= nil then
        self.mNowSkillsCondition = clientTableManager.cfg_skills_conditionManager:GetSkillsCondition(self.skillid, self.level)
    end
    return self.mNowSkillsCondition
end

---得到下一级技能条件表
---@return TABLE.cfg_skills_condition
function LuaSkillDetailedInfo:GetNextSkillsConditionTable()
    if self.mNextSkillsCondition == nil and self.skillid ~= nil and self.level ~= nil then
        self.mNextSkillsCondition = clientTableManager.cfg_skills_conditionManager:GetSkillsCondition(self.skillid, self.level + 1)
    end
    return self.mNextSkillsCondition
end

---是否是高级技能
function LuaSkillDetailedInfo:IsHighSkill()
    if self:GetNowSkillsConditionTable() ~= nil and self:GetNowSkillsConditionTable().cost ~= nil then
        local skillCostArray = string.Split(self:GetNowSkillsConditionTable().cost, "#")
        if skillCostArray ~= nil and #skillCostArray > 1 then
            local item = clientTableManager.cfg_itemsManager:TryGetValue(tonumber(skillCostArray[1]))
            if item ~= nil then
                return item:GetType() == Utility.EnumToInt(CS.EItem_Type.HighSkillExp)
            end
        end
    end
end

---技能是否满级
function LuaSkillDetailedInfo:IsSkillMax()
    if self:GetNextSkillsConditionTable() == nil then
        return true
    else
        return false
    end
end
---技能经验是否满
function LuaSkillDetailedInfo:IsSkillExpMax()
    local maxExp = self:GetSkillExpMax()
    if maxExp == nil then
        return false
    end
    return self.exp >= maxExp
end
---得到技能经验最大值
function LuaSkillDetailedInfo:GetSkillExpMax()
    if self:GetNowSkillsConditionTable() == nil then
        return nil
    end
    if self:GetNowSkillsConditionTable():GetCost() ~= nil then
        local strlist = string.Split(self:GetNowSkillsConditionTable():GetCost(), '#')
        if strlist ~= nil and #strlist >= 2 then
            return tonumber(strlist[2])
        end
    end
    return nil
end

---得到强化技能ID列表
function LuaSkillDetailedInfo:GetIntensifySkillIDList()
    if self:GetSkillTable() ~= nil and self:GetSkillTable():GetIntensifySkill() ~= nil then
        return self:GetSkillTable():GetIntensifySkill().list
    end
end

---是否是自己的强化技能
---@param skillid number
function LuaSkillDetailedInfo:IsThisIntensifySkill(skillid)
    if self:GetIntensifySkillIDList() == nil then
        return false
    end
    if self:GetIntensifySkillIDList() ~= nil then
        for i, v in pairs(self:GetIntensifySkillIDList()) do
            if v == skillid then
                return true
            end
        end
    end
    return false
end

---得到强化技能信息
---@param skillId number 指定技能ID 如果不传的话默认寻找第一个强化技能
function LuaSkillDetailedInfo:GetIntensifySkillInfo(skillId)
    if self.intensifySkillDic == nil then
        return nil
    end
    if skillId == nil then
        for i, v in pairs(self.intensifySkillDic) do
            if v ~= nil then
                return v
            end
        end
    else
        return self.intensifySkillDic[skillId]
    end
end

---指定强化技能技能书是否可用
---@param bagItemLid number 背包技能书ItemID
---@return boolean
function LuaSkillDetailedInfo:IsCanUseIntensifySkillBook(bagItemLid)
    if self:GetIntensifySkillIDList() == nil then
        return false
    end
    for i, v in pairs(self:GetIntensifySkillIDList()) do
        return self:GetSkillBookBagItem(v)
    end
    return false
end

---是否有强化技能技能书
---@param IntensifySkillID number 指定技能ID 如果不传的话默认寻找第一个强化技能
---@return boolean,bagItemInfo,number
function LuaSkillDetailedInfo:IsHaveIntensifySkillBook(IntensifySkillID)
    if self:GetIntensifySkillIDList() == nil then
        return false
    end
    for i, v in pairs(self:GetIntensifySkillIDList()) do
        if IntensifySkillID ~= nil then
            if v == IntensifySkillID then
                return self:GetSkillBookBagItem(v)
            end
        else
            return self:GetSkillBookBagItem(v)
        end
    end
    return false
end

---得到背包里面的技能书
---@param skillID 指定技能ID 如果不传的话默认寻找自己的技能
---@return  boolean,bagItemInfo,TABLE.cfg_skills
function LuaSkillDetailedInfo:GetSkillBookBagItem(skillID)
    if skillID == nil then
        if self:GetSkillTable() ~= nil then
            skillID = self:GetSkillTable():GetId()
        end
    end
    if skillID == nil then
        return false
    end
    local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagSkillBookItemInfo(skillID)
    return bagItemInfo ~= nil, bagItemInfo, skillID
end

function LuaSkillDetailedInfo:Init()
    ---服务器技能信息skillV2.SkillBean
    self.SkillBean = nil
    ---技能ID
    self.skillid = nil
    ---技能等级
    self.level = nil
    ---技能经验
    self.exp = nil
    ---旧的经验
    self.oldExp = nil
    ---@type table<number,LuaSkillDetailedInfo> 强化技能列表
    self.intensifySkillDic = {}
end

---刷新单个技能数据
---@param tblData skillV2.SkillBean
function LuaSkillDetailedInfo:RefreShData(tblData)
    if tblData == nil then
        self:RevertData()
        return
    end
    ---服务器技能信息skillV2.SkillBean
    self.SkillBean = tblData
    self:SetSkillID(tblData.skillId)
    self:SetSkillLevel(tblData.level)
    ---技能经验
    self.exp = tblData.exp
    ---旧的经验
    self.oldExp = tblData.oldExp

end

---设置技能ID
function LuaSkillDetailedInfo:SetSkillID(skillid)
    if skillid ~= self.skillid then
        self:RevertData()
        self.skillid = skillid
    end
end

---设置技能等级
function LuaSkillDetailedInfo:SetSkillLevel(level)
    if level ~= self.level then
        self.level = level
        self.mNowSkillsCondition = nil
        self.mNextSkillsCondition = nil
    end
end

---设置强化技能
---@param skillInfo LuaSkillDetailedInfo
function LuaSkillDetailedInfo:SetIntensifySkill(skillInfo)
    if skillInfo == nil or skillInfo.skillid == nil then
        return
    end
    if self:IsThisIntensifySkill(skillInfo.skillid) == nil then
        return
    end
    self.intensifySkillDic[skillInfo.skillid] = skillInfo
end

---技能书是否可用于此技能
---@param itemInfo bagV2.BagItemInfo
---@return boolean
function LuaSkillDetailedInfo:IsCanUseSkillBookByItemInfo(itemInfo)
    if itemInfo == nil then
        return false
    end
    if self:IsSkillMax() then
        return false
    end
    if self:IsSkillExpMax() then
        return false
    end
    ---@type TABLE.cfg_skills_condition
    local skillCondtionTbl = self:GetNowSkillsConditionTable()
    if skillCondtionTbl == nil or skillCondtionTbl:GetCostBook() == nil then
        return false
    end
    if skillCondtionTbl:GetCostBook().list == nil or skillCondtionTbl:GetCostBook().list.Count <= 0 then
        return false
    end
    return skillCondtionTbl:GetCostBook().list[0] == itemInfo.id
end

---重置数据
function LuaSkillDetailedInfo:RevertData()
    self.level = nil
    self.exp = nil
    self.oldExp = nil
    self.mskillTable = nil
    self.mNowSkillsCondition = nil
    self.mNextSkillsCondition = nil
end

return LuaSkillDetailedInfo