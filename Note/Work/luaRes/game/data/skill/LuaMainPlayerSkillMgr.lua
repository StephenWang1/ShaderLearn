---@class LuaMainPlayerSkillMgr 调用参考 gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr()
local LuaMainPlayerSkillMgr = {}

---技能信息字典
---@type table<number,LuaSkillDetailedInfo> key：技能ID  value：LuaSkillDetailedInfo
LuaMainPlayerSkillMgr.SkillInfoDic = {}

function LuaMainPlayerSkillMgr:Init()
    self.SkillInfoDic = {}
    self.careerSkillList = nil
end

---刷新所有技能数据
---@param tblData skillV2.ResSkill
function LuaMainPlayerSkillMgr:RefreshAllSkill(tblData)
    if tblData == nil or tblData.skillList == nil then
        return
    end
    self.SkillInfoDic = {}
    for i, v in pairs(tblData.skillList) do
        if self.SkillInfoDic[v.skillId] == nil then
            self.SkillInfoDic[v.skillId] = luaclass.LuaSkillDetailedInfo:New()
        end
        self.SkillInfoDic[v.skillId]:RefreShData(v)
    end
    self:RefreshIntensifySkillInfo()
    self:SetCareerSkill()
end

---单个技能变化数据刷新
---@param tblData skillV2.skillBean
function LuaMainPlayerSkillMgr:RefreshOneSkillChange(skillBean)
    if skillBean ~= nil then
        if self.SkillInfoDic[skillBean.skillId] == nil then
            self.SkillInfoDic[skillBean.skillId] = luaclass.LuaSkillDetailedInfo:New()
        end
        self.SkillInfoDic[skillBean.skillId]:RefreShData(skillBean)
    end
    self:RefreshIntensifySkillInfo()
    self:RefreShNowSkillList()
    self:RereshNotLearnSkillIDTblData()
end

---刷新当前技能面板显示的技能列表
function LuaMainPlayerSkillMgr:RefreShNowSkillList()
    if self.SkillInfoDic == nil then
        return
    end
    local nowCount = Utility.GetTableCount(self.SkillInfoDic)
    if self.OldCount ~= nowCount then
        self.OldCount = nowCount
        self:SetCareerSkill()
    end
end

---刷新强化技能數據
function LuaMainPlayerSkillMgr:RefreshIntensifySkillInfo()
    for i, v in pairs(self.SkillInfoDic) do
        if v ~= nil and v:GetIntensifySkillIDList() ~= nil then
            for c, skillID in pairs(v:GetIntensifySkillIDList()) do
                local skillInfo = self.SkillInfoDic[skillID]
                if skillInfo ~= nil then
                    v:SetIntensifySkill(skillInfo)
                end
            end
        end
    end
end

---得到当前职业的技能列表
---@return table<number,TABLE.cfg_skills>
function LuaMainPlayerSkillMgr:GetCareerSkill()
    --if self.careerSkillList == nil then
    --
    --end
    self:SetCareerSkill()
    return self.careerSkillList
end

---得到当前职业的需要技能书的技能列表，仅初始化一次
---@return table<number,TABLE.cfg_skills>
function LuaMainPlayerSkillMgr:GetNeedSkillBookCareerSkill()
    if self.NeedSkillBookCareerSkill == nil then
        self.NeedSkillBookCareerSkill = {}
        if self.careerSkillList == nil then
            self:SetCareerSkill()
        end
        for i = 1, #self.careerSkillList do
            table.insert(self.NeedSkillBookCareerSkill, self.careerSkillList[i])
        end
    end
    return self.NeedSkillBookCareerSkill
end

---设置当前技能列表
function LuaMainPlayerSkillMgr:SetCareerSkill()
    ---@type table<number,TABLE.cfg_skills>
    self.careerSkillList = {}
    local careerIndex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local skillInfoDic = clientTableManager.cfg_skillsManager.dic
    if skillInfoDic == nil then
        return
    end
    for i, v in pairs(skillInfoDic) do
        ---@type TABLE.cfg_skills
        local skillTable = v
        local skillID = skillTable:GetId()
        if skillTable ~= nil then
            local cls = skillTable:GetCls()
            if (cls == 0 or cls == 4 or cls == 10 or cls == 11) and skillTable:GetIsShow() ~= 0 then
                if skillTable:GetCareer() == careerIndex then
                    table.insert(self.careerSkillList, skillTable)
                elseif self.SkillInfoDic ~= nil and self.SkillInfoDic[skillID] ~= nil then
                    table.insert(self.careerSkillList, skillTable)
                elseif skillTable:GetCareer() == 0 and cls == 11 and self:IsMeetShowQiShuSkillLimit(skillTable:GetId()) then
                    table.insert(self.careerSkillList, skillTable)
                end
            end
        end
    end
    table.sort(self.careerSkillList, function(left, right)
        ---@type TABLE.cfg_skills
        local nowLeft = left
        ---@type TABLE.cfg_skills
        local nowRight = right
        return nowLeft:GetIndex() < nowRight:GetIndex()
    end)
end

---强化仅能书是否可用
function LuaMainPlayerSkillMgr:IsCanUseIntensifySkillBook(skillID, skillBookItemID)
    if self.SkillInfoDic == nil or skillID == nil or skillBookItemID == nil then
        return false
    end
    ---@type LuaSkillDetailedInfo
    local IntensifySkillInfo = self.SkillInfoDic[skillID]
    if IntensifySkillInfo == nil then
        local skillTable = clientTableManager.cfg_skillsManager:TryGetValue(skillID)
        if skillTable ~= nil and skillTable:GetSkillBook() == skillBookItemID then
            return true
        end
    else
        if IntensifySkillInfo:GetNowSkillsConditionTable() ~= nil and IntensifySkillInfo:GetNowSkillsConditionTable():GetCostBook() ~= nil then
            local skillBookList = IntensifySkillInfo:GetNowSkillsConditionTable():GetCostBook().list
            for i = 0, skillBookList.Count - 1 do
                if skillBookList[i] == skillBookItemID then
                    return true
                end
            end
        end
    end
    return false
end

---是否是满足限制开启技能条件
---@return boolean
function LuaMainPlayerSkillMgr:IsMeetShowQiShuSkillLimit(skillID)
    local isMeet, conditionList = self:IsMeetLimitOpenSkill(skillID)
    if isMeet == false then
        return false
    end
    for i, v in pairs(conditionList) do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) then
            return false
        end
    end
    return true
end

---是否是满足限制开启技能
function LuaMainPlayerSkillMgr:IsMeetLimitOpenSkill(skillID)
    if self:GetMeetLimitOpenSkillList() == nil then
        return false
    end
    if self:GetMeetLimitOpenSkillList()[skillID] == nil then
        return false
    else
        return true, self:GetMeetLimitOpenSkillList()[skillID]
    end
end

---得到满足限制开启技能列表
function LuaMainPlayerSkillMgr:GetMeetLimitOpenSkillList()
    if LuaMainPlayerSkillMgr.meetLimitOpenSkillList == nil then
        ---@type table<number,table<number,number>> key 技能ID value 限制列表
        LuaMainPlayerSkillMgr.meetLimitOpenSkillList = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22860)
        if data == nil then
            return
        end
        local str = string.Split(data.value, '&')
        for i, v in pairs(str) do
            local conditionList = {}
            local str_condition = string.Split(v, '#')
            local skillID = tonumber(str_condition[1])
            for i = 2, #str_condition do
                table.insert(conditionList, tonumber(str_condition[i]))
            end
            LuaMainPlayerSkillMgr.meetLimitOpenSkillList[skillID] = conditionList
        end
    end
    return LuaMainPlayerSkillMgr.meetLimitOpenSkillList
end

LuaMainPlayerSkillMgr.qiShuSkillID = 800001
---是否能学习骑术技能
function LuaMainPlayerSkillMgr:IsCanLearnQishuSkill()
    if self:IsMeetShowQiShuSkillLimit(self.qiShuSkillID) then
        if self.SkillInfoDic[self.qiShuSkillID] == nil then
            local skillInfo = clientTableManager.cfg_skillsManager:TryGetValue(self.qiShuSkillID)
            if skillInfo ~= nil then
                local IsMeetLimitOpenSkill = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(skillInfo:GetCondition())
                if IsMeetLimitOpenSkill then
                    return true
                end
            end
        else
            if self.SkillInfoDic[self.qiShuSkillID]:IsSkillExpMax() == true then
                return true
            end
        end
    end
    return false
end

---刷新特殊红点
function LuaMainPlayerSkillMgr:CallSpecialRed()
    local QiShuSkill = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.QiShuSkill);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(QiShuSkill);
end

--region 技能书
---@return table<number,TABLE.cfg_skills_condition>
function LuaMainPlayerSkillMgr:GetNotLearnSkillIDTbl()
    if self.mNotLearnSkillIDTbl == nil then
        self:RereshNotLearnSkillIDTblData()
    end
    return self.mNotLearnSkillIDTbl
end

function LuaMainPlayerSkillMgr:RereshNotLearnSkillIDTblData()
    self.mNotLearnSkillIDTbl = {}
    self.mNotLearnSkillTblList = {}
    --region 筛选出未学习的技能id
    local allSkillTbl = LuaMainPlayerSkillMgr:GetNeedSkillBookCareerSkill()
    local isSame = false
    ---储存未学习的技能id
    local notLearnSkillIDTbl = {}
    for i = 1, #allSkillTbl do
        local info = allSkillTbl[i]
        isSame = false
        for i, v in pairs(self.SkillInfoDic) do
            if v:GetSkillTable() ~= nil then
                if v:GetSkillTable():GetId() == info:GetId() then
                    isSame = true
                end
            end
        end
        if not isSame then
            table.insert(notLearnSkillIDTbl, allSkillTbl[i]:GetId())
            table.insert(self.mNotLearnSkillTblList, allSkillTbl[i])
        end
    end
    --endregion

    --region 拿到未学习技能的condition表数据
    if #notLearnSkillIDTbl ~= 0 then
        for i = 1, #notLearnSkillIDTbl do
            local skillConditiontbl = clientTableManager.cfg_skills_conditionManager:GetSkillsCondition(notLearnSkillIDTbl[i], 1)
            if skillConditiontbl and skillConditiontbl:GetCostBook() ~= nil then
                if skillConditiontbl:GetCostBook().list ~= nil and skillConditiontbl:GetCostBook().list.Count > 0 then
                    table.insert(self.mNotLearnSkillIDTbl, skillConditiontbl)
                end
            end
        end
    end
    --endregion
end

---判断物品是否为可学习的技能书
---@param itemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerSkillMgr:IsCanStudySkillBook(itemInfo)

    if not self:IsSkillBook(itemInfo) then
        return false
    end
    local notLearnSkillConditionTbl = self:GetNotLearnSkillIDTbl()
    local iscanUse = false;
    if #notLearnSkillConditionTbl > 0 then
        for i = 1, #notLearnSkillConditionTbl do
            local table = clientTableManager.cfg_skillsManager:TryGetValue(notLearnSkillConditionTbl[i]:GetSkillId())
            if table ~= nil and (table:GetCls() == 4 or table:GetCls() == 9) then
                if itemInfo.id == table:GetSkillBook() then
                    iscanUse = true;
                end
            else
                for j = 0, notLearnSkillConditionTbl[i]:GetCostBook().list.Count - 1 do
                    if itemInfo.id == notLearnSkillConditionTbl[i]:GetCostBook().list[j] then
                        iscanUse = true;
                    end
                end
            end
        end
    end

    return iscanUse
end

---技能书是否可用
---@param itemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerSkillMgr:IsCanUseSkillBookByItemInfo(itemInfo)
    ---是否为技能书
    if not self:IsSkillBook(itemInfo) then
        return false
    end
    ---判断此技能书是否可以学习
    if self:IsCanStudySkillBook(itemInfo) then
        return true
    end
    ---遍历当前已学习的技能列表，判断是否为消耗物
    for i, v in pairs(self.SkillInfoDic) do
        if v:IsCanUseSkillBookByItemInfo(itemInfo) then
            return true
        end
    end
    return false
end

---判断类型是否为主角匹配的技能书
---@param itemInfo bagV2.BagItemInfo
---@return boolean
function LuaMainPlayerSkillMgr:IsSkillBook(itemInfo)
    local playerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local playerSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    return itemInfo ~= nil and itemInfo.type == luaEnumItemType.SkillBook and
            (itemInfo.sex == playerSex or itemInfo.sex == 0) and
            (itemInfo.career == playerCareer or itemInfo.career == 0) and
            itemInfo.useParam ~= null and itemInfo.useParam.list.Count > 0 and
            clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id) == LuaEnumUseItemParam.CanUse
end

---判断技能书是不是已经学习
---@param itemID number
---@return boolean
function LuaMainPlayerSkillMgr:HasTheSkillBookBeenLearned(itemID)
    local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemID);
    if (itemTable ~= nil and itemTable:GetType() == luaEnumItemType.SkillBook and itemTable:GetUseParam() ~= nil and itemTable:GetUseParam().list.Count > 1) then
        if self.SkillInfoDic[itemTable:GetUseParam().list[0]] ~= nil then
            return true
        end
    end
    return false
end


--endregion

return LuaMainPlayerSkillMgr
