---lua技能信息
---@class LuaXPSkillInfo:luaobject
local LuaXPSkillInfo = {}

---获取归属者
---@return PlayerDataManager
function LuaXPSkillInfo:GetOwner()
    return self.mOwner
end

---获取xp技能能量
---@return number
function LuaXPSkillInfo:GetXPSkillEnergy()
    return self.mXPSkillEnergy or 0
end

---获取xp技能最大能量
---@return number
function LuaXPSkillInfo:GetXPSkillMaxEnergy()
    if self.mXPSkillMaxEnergy == nil then
        local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22555)
        if tblExist and tbl then
            local strs = string.Split(tbl.value, '#')
            local mainPlayerCareer = CS.CSScene.MainPlayerInfo.Career
            if mainPlayerCareer == CS.ECareer.Warrior then
                --战士
                if #strs >= 1 then
                    self.mXPSkillMaxEnergy = tonumber(strs[1])
                end
            elseif mainPlayerCareer == CS.ECareer.Master then
                --法师
                if #strs >= 2 then
                    self.mXPSkillMaxEnergy = tonumber(strs[2])
                end
            elseif mainPlayerCareer == CS.ECareer.Taoist then
                --道士
                if #strs >= 3 then
                    self.mXPSkillMaxEnergy = tonumber(strs[3])
                end
            end
        end
    end
    return self.mXPSkillMaxEnergy
end

---设置xp技能能量
---@private
---@param xpEnergy number
function LuaXPSkillInfo:SetXPSkillEnergy(xpEnergy)
    if xpEnergy == nil then
        return
    end
    if self.mXPSkillEnergy == xpEnergy then
        return
    end
    self.mXPSkillEnergy = xpEnergy
    ---分发xp技能能量变化事件
    local mainPlayerCoord
    if CS.CSScene.Sington and CS.CSScene.Sington.MainPlayer and CS.CSScene.Sington.MainPlayer.OldCell then
        mainPlayerCoord = CS.CSScene.Sington.MainPlayer.OldCell.Coord
    end
    luaEventManager.DoCallback(LuaCEvent.XPSkillEnergyChanged, mainPlayerCoord)
end

---获取技能信息
---@return skillV2.ResSkill
function LuaXPSkillInfo:GetSkillInfo()
    return self.mSkillInfo
end

---获取xp技能列表
---@return table<number,{tbl:TABLE.CFG_SKILLS,level:number}>
function LuaXPSkillInfo:GetXPSkills()
    if self.mXPSkills == nil then
        self.mXPSkills = {}
    end
    return self.mXPSkills
end

---@param owner PlayerDataManager
function LuaXPSkillInfo:Init(owner)
    self.mOwner = owner
    self:GetOwner():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResXpSkillEnergyChangeMessage, function(id, tbl)
        ---设置xp能量
        self:SetXPSkillEnergy(tbl.xpSkillEnergy)
    end)
    self:GetOwner():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, function(id, tbl)
        ---刷新技能书使用状态
        self:RefreshSkillBookUse(tbl)
    end)
    self:GetOwner():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillMessage, function(id, tbl)
        self.mSkillInfo = tbl
        ---刷新所有技能状态
        self:RefreshXPSkillList()
        ---设置xp能量
        self:SetXPSkillEnergy(tbl.xpSkillEnergy)
    end)
end

---刷新xp技能列表
---@private
function LuaXPSkillInfo:RefreshXPSkillList()
    if self:GetSkillInfo() == nil then
        return
    end
    local skillTblMgr = CS.Cfg_SkillTableManager.Instance
    local isChanged = false
    for i = 1, #self:GetSkillInfo().skillList do
        local skillBean = self:GetSkillInfo().skillList[i]
        ---@type TABLE.CFG_SKILLS
        local skillTbl
        ___, skillTbl = skillTblMgr:TryGetValue(skillBean.skillId)
        if skillTbl and skillTbl.cls == 4 then
            ---只考虑xp技能
            local isExistAlready = false
            for j = 1, #self:GetXPSkills() do
                if self:GetXPSkills()[j].tbl.id == skillBean.skillId then
                    isExistAlready = true
                    break
                end
            end
            if isExistAlready == false then
                isChanged = true
                table.insert(self:GetXPSkills(), { tbl = skillTbl, level = skillBean.level })
            end
        end
    end
    if isChanged then
        ---按index从小到大排序
        table.sort(self:GetXPSkills(), function(leftTbl, rightTbl)
            return leftTbl.tbl.index > rightTbl.tbl.index and true or false
        end)
        luaEventManager.DoCallback(LuaCEvent.XPSkillChanged)
    end
end

---刷新技能书使用结果
---@param skillBean skillV2.SkillBean
function LuaXPSkillInfo:RefreshSkillBookUse(skillBean)
    if skillBean == nil then
        return
    end
    ---@type TABLE.CFG_SKILLS
    local skillTbl
    ___, skillTbl = CS.Cfg_SkillTableManager.Instance:TryGetValue(skillBean.skillId)
    if skillTbl and skillTbl.cls == 4 then
        ---只考虑xp技能
        local isExistAlready = false
        for i = 1, #self:GetXPSkills() do
            if self:GetXPSkills()[i].tbl.id == skillBean.skillId then
                isExistAlready = true
                break
            end
        end
        if isExistAlready == false then
            table.insert(self:GetXPSkills(), { tbl = skillTbl, level = skillBean.level })
            ---按index从小到大排序
            table.sort(self:GetXPSkills(), function(leftTbl, rightTbl)
                return leftTbl.tbl.index > rightTbl.tbl.index and true or false
            end)
            luaEventManager.DoCallback(LuaCEvent.XPSkillChanged)
        end
    end
end

return LuaXPSkillInfo