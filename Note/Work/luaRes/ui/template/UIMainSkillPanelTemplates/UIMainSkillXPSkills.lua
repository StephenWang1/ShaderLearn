---主界面xp技能
---@class UIMainSkillXPSkills:TemplateBase
local UIMainSkillXPSkills = {}

---@private
function UIMainSkillXPSkills:GetSkill1Pos1Trans()
    if self.mSkill1Pos1Trans == nil then
        self.mSkill1Pos1Trans = self:Get("pos1/skill1", "Transform")
    end
    return self.mSkill1Pos1Trans
end

---@private
function UIMainSkillXPSkills:GetSkill1Pos2Trans()
    if self.mSkill1Pos2Trans == nil then
        self.mSkill1Pos2Trans = self:Get("pos2/skill1", "Transform")
    end
    return self.mSkill1Pos2Trans
end

---@private
function UIMainSkillXPSkills:GetSkill2Pos1Trans()
    if self.mSkill2Pos1Trans == nil then
        self.mSkill2Pos1Trans = self:Get("pos1/skill2", "Transform")
    end
    return self.mSkill2Pos1Trans
end

---@private
function UIMainSkillXPSkills:GetSkill2Pos2Trans()
    if self.mSkill2Pos2Trans == nil then
        self.mSkill2Pos2Trans = self:Get("pos2/skill2", "Transform")
    end
    return self.mSkill2Pos2Trans
end

---根据xp技能的index和位置的index决定取哪个Transform作为技能框位置跟随Transform
---@param xpSkillIndex number
---@param posIndex number
---@return UnityEngine.Transform
function UIMainSkillXPSkills:GetSkillPosTrans(xpSkillIndex, posIndex)
    if xpSkillIndex == 1 and posIndex == 0 then
        return self:GetSkill1Pos1Trans()
    elseif xpSkillIndex == 1 and posIndex == 1 then
        return self:GetSkill1Pos2Trans()
    elseif xpSkillIndex == 2 and posIndex == 0 then
        return self:GetSkill2Pos1Trans()
    elseif xpSkillIndex == 2 and posIndex == 1 then
        return self:GetSkill2Pos2Trans()
    end
end

---获取xp技能1的模板
---@return UIMainSkillXPSkillTemplate
function UIMainSkillXPSkills:GetXPSkill1Template()
    if self.mXPSkill1Template == nil then
        local go = self:Get("xpskill1", "GameObject")
        if go then
            self.mXPSkill1Template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMainSkillXPSkillTemplate, self)
        end
    end
    return self.mXPSkill1Template
end

---获取xp技能1的模板
---@return UIMainSkillXPSkillTemplate
function UIMainSkillXPSkills:GetXPSkill2Template()
    if self.mXPSkill2Template == nil then
        local go = self:Get("xpskill2", "GameObject")
        if go then
            self.mXPSkill2Template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMainSkillXPSkillTemplate, self)
        end
    end
    return self.mXPSkill2Template
end

---获取当前显示状态
---@return boolean
function UIMainSkillXPSkills:GetCurrentShowState()
    return self.mState
end

---获取当前位置
---@return number 当前位置,有效值为0和1
function UIMainSkillXPSkills:GetCurrentPos()
    return self.mPos
end

---归属界面
---@return UIMainSkillPanel
function UIMainSkillXPSkills:GetOwnerPanel()
    return self.mOwnerPanel
end

---@param ownerPanel UIMainSkillPanel
function UIMainSkillXPSkills:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
end

---初始化
function UIMainSkillXPSkills:Initialize()
    ---初始化时隐藏xp技能按键
    self:SetCurrentSkillPosType(self.mOwnerPanel.skillPosState)
    self:RefreshXPSkills(true)
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.XPSkillChanged, function()
        self:RefreshXPSkills()
    end)
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.XPSkillEnergyChanged, function()
        self:RefreshXPSkills()
    end)
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.XPSkillSliderIsInCD, function()
        self.mXPSliderCDState = true
    end)
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.XPSkillSliderCDFinished, function()
        self.mXPSliderCDState = false
        self:RefreshXPSkills()
    end)
end

---设置当前的技能键位类型
---@param pos number 键位类型,只能是1或2
function UIMainSkillXPSkills:SetCurrentSkillPosType(pos)
    if pos ~= 0 and pos ~= 1 then
        return
    end
    if self.mPos == pos then
        return
    end
    self.mPos = pos
    self:GetXPSkill1Template().go.transform.position = self:GetSkillPosTrans(1, self.mPos).position
    self:GetXPSkill2Template().go.transform.position = self:GetSkillPosTrans(2, self.mPos).position
end

---根据xp技能数据刷新xp技能按键
function UIMainSkillXPSkills:RefreshXPSkills(isFirstTime)
    --print("RefreshXPSkills")
    if self.mOnXPSkillBtnClicked == nil then
        self.mOnXPSkillBtnClicked = function(xpSkillTbl)
            self:OnXPSkillButtonClicked(xpSkillTbl)
        end
    end
    if gameMgr:GetPlayerDataMgr() == nil then
        self:GetXPSkill2Template():SetShowState(false, false)
        self:GetXPSkill1Template():SetShowState(false, false)
        return
    end
    local skillInfo = gameMgr:GetPlayerDataMgr():GetXPSkillInfo()
    if skillInfo == nil then
        self:GetXPSkill2Template():SetShowState(false, false)
        self:GetXPSkill1Template():SetShowState(false, false)
        return
    end
    local xpSkills = skillInfo:GetXPSkills()
    local xpSkillCount = #xpSkills
    if xpSkillCount == nil or xpSkillCount == 0 or skillInfo:GetXPSkillEnergy() < skillInfo:GetXPSkillMaxEnergy() then
        ---xp技能不存在或者技能能量不足时,关闭两个技能
        self:GetXPSkill2Template():SetShowState(false, false)
        self:GetXPSkill1Template():SetShowState(false, false)
    elseif (xpSkillCount == 1) then
        if self.mXPSliderCDState then
            ---xp技能进度条正在CD状态,不弹出技能
            --print("xp技能进度条正在CD状态,不弹出技能")
            return
        end
        self:GetXPSkill1Template():SetShowState(true, isFirstTime ~= true)
        self:GetXPSkill2Template():SetShowState(false, false)
        self:GetXPSkill1Template():BindClickEvent(self.mOnXPSkillBtnClicked)
        self:GetXPSkill1Template():Refresh(xpSkills[1])
    else
        if self.mXPSliderCDState then
            ---xp技能进度条正在CD状态,不弹出技能
            --print("xp技能进度条正在CD状态,不弹出技能")
            return
        end
        self:GetXPSkill1Template():SetShowState(true, isFirstTime ~= true)
        self:GetXPSkill2Template():SetShowState(true, isFirstTime ~= true)
        self:GetXPSkill1Template():BindClickEvent(self.mOnXPSkillBtnClicked)
        self:GetXPSkill2Template():BindClickEvent(self.mOnXPSkillBtnClicked)
        self:GetXPSkill1Template():Refresh(xpSkills[1])
        self:GetXPSkill2Template():Refresh(xpSkills[2])
    end
end

---xp技能按下事件
---@param xpSkillData {tbl:TABLE.CFG_SKILLS,level:number}
function UIMainSkillXPSkills:OnXPSkillButtonClicked(xpSkillData)
    if xpSkillData and xpSkillData.tbl and xpSkillData.level then
        self:UseXPSkill(xpSkillData.tbl.id, xpSkillData.level)
    end
end

--region 使用XP技能
---使用XP技能
---@param skillID number
---@param level number
function UIMainSkillXPSkills:UseXPSkill(skillID, level)
    if skillID == 0 or skillID == nil or level == nil then
        return
    end
    if not CS.CSServerTime.IsServerTimeReceived then
        CS.Utility.ShowTips("服务器时间未初始化，技能中断释放", 1.5, CS.ColorType.Red);
        return
    end
    if LuaGlobalTableDeal.IsAnyAntiSkillReleaseBuffExistInMainPlayer() then
        --print("玩家身上有禁止施法的buff存在")
        ---玩家身上有禁止施法的buff存在
        return
    end
    local mskill = CS.CSScene.Sington.MainPlayer.SkillEngine:AddSkill(skillID, skillID, level);
    if mskill ~= nil and mskill.SkillCondition ~= nil then
        if mskill.SkillCondition.costMp <= CS.CSScene.MainPlayerInfo.MP or self:IsReleaseDotType(skillID) then
            self:UseSkillCondition(skillID)
        else
            CS.Utility.ShowTips("法力不足", 1.5, CS.ColorType.Red);
        end
    end
end

---是否是对点类型的技能
---@private
function UIMainSkillXPSkills:IsReleaseDotType(skillID)
    local isfind, SkillData = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(skillID)
    if isfind then
        if SkillData.releaseTypeClient == 2 then
            return true
        end
    end
    return false
end

---使用技能条件
---@private
function UIMainSkillXPSkills:UseSkillCondition(skillID)
    self:GetOwnerPanel():CloseUnlockedDotSkill(self)
    local isfind, SkillData = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(skillID)
    if isfind then
        local isActive = CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill == SkillData;
        self:GetOwnerPanel():CloseSelectSkill()
        if isActive then
            return
        end
        if SkillData.releaseTypeClient == 1 then
            self:CastSkill(skillID)
        elseif SkillData.releaseTypeClient == 2 then

        else
            self:CastSkill(skillID)
        end
    end
end

---使用技能
---@private
function UIMainSkillXPSkills:CastSkill(skillID)
    local avatar = CS.CSScene.Sington:getCurAttackAvatar();
    Utility.ShowChangAttackPatternTip(avatar, skillID)
    CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.NowSelectSkill.SkillID = skillID
    CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.NowSelectSkill.SkillReleaseType = CS.ESkillReleaseType.Target
    CS.CSAutoFight.IsOnClickButtonAttack = true;

    CS.CSAutoPauseMgr.Instance:CacheCurrentFrameStateData();
    CS.CSAutoPauseMgr.Instance:TryEnterPausedState();
    CS.CSScene.Sington.MainPlayer:CastSkillOrItem(skillID, false, true)
end
--endregion

return UIMainSkillXPSkills