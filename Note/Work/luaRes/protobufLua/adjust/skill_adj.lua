--[[本文件为工具自动生成,禁止手动修改]]
local skillV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable skillV2.SkillBean
---@type skillV2.SkillBean
skillV2_adj.metatable_SkillBean = {
    _ClassName = "skillV2.SkillBean",
}
skillV2_adj.metatable_SkillBean.__index = skillV2_adj.metatable_SkillBean
--endregion

---@param tbl skillV2.SkillBean 待调整的table数据
function skillV2_adj.AdjustSkillBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_SkillBean)
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.oldExp == nil then
        tbl.oldExpSpecified = false
        tbl.oldExp = 0
    else
        tbl.oldExpSpecified = true
    end
end

--region metatable skillV2.ResSkill
---@type skillV2.ResSkill
skillV2_adj.metatable_ResSkill = {
    _ClassName = "skillV2.ResSkill",
}
skillV2_adj.metatable_ResSkill.__index = skillV2_adj.metatable_ResSkill
--endregion

---@param tbl skillV2.ResSkill 待调整的table数据
function skillV2_adj.AdjustResSkill(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ResSkill)
    if tbl.skillList == nil then
        tbl.skillList = {}
    else
        if skillV2_adj.AdjustSkillBean ~= nil then
            for i = 1, #tbl.skillList do
                skillV2_adj.AdjustSkillBean(tbl.skillList[i])
            end
        end
    end
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
    if tbl.skillShortcut == nil then
        tbl.skillShortcut = {}
    end
    if tbl.xpSkillEnergy == nil then
        tbl.xpSkillEnergySpecified = false
        tbl.xpSkillEnergy = 0
    else
        tbl.xpSkillEnergySpecified = true
    end
end

--region metatable skillV2.ResOneSkillChange
---@type skillV2.ResOneSkillChange
skillV2_adj.metatable_ResOneSkillChange = {
    _ClassName = "skillV2.ResOneSkillChange",
}
skillV2_adj.metatable_ResOneSkillChange.__index = skillV2_adj.metatable_ResOneSkillChange
--endregion

---@param tbl skillV2.ResOneSkillChange 待调整的table数据
function skillV2_adj.AdjustResOneSkillChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ResOneSkillChange)
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
end

--region metatable skillV2.ResMultiSkillChange
---@type skillV2.ResMultiSkillChange
skillV2_adj.metatable_ResMultiSkillChange = {
    _ClassName = "skillV2.ResMultiSkillChange",
}
skillV2_adj.metatable_ResMultiSkillChange.__index = skillV2_adj.metatable_ResMultiSkillChange
--endregion

---@param tbl skillV2.ResMultiSkillChange 待调整的table数据
function skillV2_adj.AdjustResMultiSkillChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ResMultiSkillChange)
    if tbl.skillList == nil then
        tbl.skillList = {}
    else
        if skillV2_adj.AdjustSkillBean ~= nil then
            for i = 1, #tbl.skillList do
                skillV2_adj.AdjustSkillBean(tbl.skillList[i])
            end
        end
    end
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
end

--region metatable skillV2.SkillIdInfo
---@type skillV2.SkillIdInfo
skillV2_adj.metatable_SkillIdInfo = {
    _ClassName = "skillV2.SkillIdInfo",
}
skillV2_adj.metatable_SkillIdInfo.__index = skillV2_adj.metatable_SkillIdInfo
--endregion

---@param tbl skillV2.SkillIdInfo 待调整的table数据
function skillV2_adj.AdjustSkillIdInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_SkillIdInfo)
end

--region metatable skillV2.ReqSetSkillShortcut
---@type skillV2.ReqSetSkillShortcut
skillV2_adj.metatable_ReqSetSkillShortcut = {
    _ClassName = "skillV2.ReqSetSkillShortcut",
}
skillV2_adj.metatable_ReqSetSkillShortcut.__index = skillV2_adj.metatable_ReqSetSkillShortcut
--endregion

---@param tbl skillV2.ReqSetSkillShortcut 待调整的table数据
function skillV2_adj.AdjustReqSetSkillShortcut(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ReqSetSkillShortcut)
    if tbl.skillShortcut == nil then
        tbl.skillShortcut = {}
    end
end

--region metatable skillV2.SecretSkillUpdate
---@type skillV2.SecretSkillUpdate
skillV2_adj.metatable_SecretSkillUpdate = {
    _ClassName = "skillV2.SecretSkillUpdate",
}
skillV2_adj.metatable_SecretSkillUpdate.__index = skillV2_adj.metatable_SecretSkillUpdate
--endregion

---@param tbl skillV2.SecretSkillUpdate 待调整的table数据
function skillV2_adj.AdjustSecretSkillUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_SecretSkillUpdate)
    if tbl.skillId == nil then
        tbl.skillIdSpecified = false
        tbl.skillId = 0
    else
        tbl.skillIdSpecified = true
    end
    if tbl.site == nil then
        tbl.siteSpecified = false
        tbl.site = 0
    else
        tbl.siteSpecified = true
    end
end

--region metatable skillV2.ReqTakeOffSecret
---@type skillV2.ReqTakeOffSecret
skillV2_adj.metatable_ReqTakeOffSecret = {
    _ClassName = "skillV2.ReqTakeOffSecret",
}
skillV2_adj.metatable_ReqTakeOffSecret.__index = skillV2_adj.metatable_ReqTakeOffSecret
--endregion

---@param tbl skillV2.ReqTakeOffSecret 待调整的table数据
function skillV2_adj.AdjustReqTakeOffSecret(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ReqTakeOffSecret)
    if tbl.skillId == nil then
        tbl.skillIdSpecified = false
        tbl.skillId = 0
    else
        tbl.skillIdSpecified = true
    end
end

--region metatable skillV2.SecretSkillInfo
---@type skillV2.SecretSkillInfo
skillV2_adj.metatable_SecretSkillInfo = {
    _ClassName = "skillV2.SecretSkillInfo",
}
skillV2_adj.metatable_SecretSkillInfo.__index = skillV2_adj.metatable_SecretSkillInfo
--endregion

---@param tbl skillV2.SecretSkillInfo 待调整的table数据
function skillV2_adj.AdjustSecretSkillInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_SecretSkillInfo)
    if tbl.secretSkill == nil then
        tbl.secretSkill = {}
    else
        if skillV2_adj.AdjustSecretSkill ~= nil then
            for i = 1, #tbl.secretSkill do
                skillV2_adj.AdjustSecretSkill(tbl.secretSkill[i])
            end
        end
    end
    if tbl.form == nil then
        tbl.formSpecified = false
        tbl.form = 0
    else
        tbl.formSpecified = true
    end
    if tbl.oldForms == nil then
        tbl.oldForms = {}
    else
        if skillV2_adj.AdjustOldForm ~= nil then
            for i = 1, #tbl.oldForms do
                skillV2_adj.AdjustOldForm(tbl.oldForms[i])
            end
        end
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.lastDefaultForm == nil then
        tbl.lastDefaultForm = {}
    else
        if skillV2_adj.AdjustSecretSkill ~= nil then
            for i = 1, #tbl.lastDefaultForm do
                skillV2_adj.AdjustSecretSkill(tbl.lastDefaultForm[i])
            end
        end
    end
end

--region metatable skillV2.OldForm
---@type skillV2.OldForm
skillV2_adj.metatable_OldForm = {
    _ClassName = "skillV2.OldForm",
}
skillV2_adj.metatable_OldForm.__index = skillV2_adj.metatable_OldForm
--endregion

---@param tbl skillV2.OldForm 待调整的table数据
function skillV2_adj.AdjustOldForm(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_OldForm)
    if tbl.formId == nil then
        tbl.formIdSpecified = false
        tbl.formId = 0
    else
        tbl.formIdSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable skillV2.SecretSkill
---@type skillV2.SecretSkill
skillV2_adj.metatable_SecretSkill = {
    _ClassName = "skillV2.SecretSkill",
}
skillV2_adj.metatable_SecretSkill.__index = skillV2_adj.metatable_SecretSkill
--endregion

---@param tbl skillV2.SecretSkill 待调整的table数据
function skillV2_adj.AdjustSecretSkill(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_SecretSkill)
    if tbl.key == nil then
        tbl.keySpecified = false
        tbl.key = 0
    else
        tbl.keySpecified = true
    end
    if tbl.skillId == nil then
        tbl.skillIdSpecified = false
        tbl.skillId = 0
    else
        tbl.skillIdSpecified = true
    end
end

--region metatable skillV2.ReqSwitchFormation
---@type skillV2.ReqSwitchFormation
skillV2_adj.metatable_ReqSwitchFormation = {
    _ClassName = "skillV2.ReqSwitchFormation",
}
skillV2_adj.metatable_ReqSwitchFormation.__index = skillV2_adj.metatable_ReqSwitchFormation
--endregion

---@param tbl skillV2.ReqSwitchFormation 待调整的table数据
function skillV2_adj.AdjustReqSwitchFormation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ReqSwitchFormation)
    if tbl.form == nil then
        tbl.formSpecified = false
        tbl.form = 0
    else
        tbl.formSpecified = true
    end
end

--region metatable skillV2.ResSecretBack
---@type skillV2.ResSecretBack
skillV2_adj.metatable_ResSecretBack = {
    _ClassName = "skillV2.ResSecretBack",
}
skillV2_adj.metatable_ResSecretBack.__index = skillV2_adj.metatable_ResSecretBack
--endregion

---@param tbl skillV2.ResSecretBack 待调整的table数据
function skillV2_adj.AdjustResSecretBack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ResSecretBack)
    if tbl.upOrDown == nil then
        tbl.upOrDownSpecified = false
        tbl.upOrDown = 0
    else
        tbl.upOrDownSpecified = true
    end
    if tbl.skillId == nil then
        tbl.skillIdSpecified = false
        tbl.skillId = 0
    else
        tbl.skillIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.form == nil then
        tbl.formSpecified = false
        tbl.form = 0
    else
        tbl.formSpecified = true
    end
end

--region metatable skillV2.ResXpSkillEnergyChange
---@type skillV2.ResXpSkillEnergyChange
skillV2_adj.metatable_ResXpSkillEnergyChange = {
    _ClassName = "skillV2.ResXpSkillEnergyChange",
}
skillV2_adj.metatable_ResXpSkillEnergyChange.__index = skillV2_adj.metatable_ResXpSkillEnergyChange
--endregion

---@param tbl skillV2.ResXpSkillEnergyChange 待调整的table数据
function skillV2_adj.AdjustResXpSkillEnergyChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ResXpSkillEnergyChange)
end

--region metatable skillV2.UpEquipProficient
---@type skillV2.UpEquipProficient
skillV2_adj.metatable_UpEquipProficient = {
    _ClassName = "skillV2.UpEquipProficient",
}
skillV2_adj.metatable_UpEquipProficient.__index = skillV2_adj.metatable_UpEquipProficient
--endregion

---@param tbl skillV2.UpEquipProficient 待调整的table数据
function skillV2_adj.AdjustUpEquipProficient(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_UpEquipProficient)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable skillV2.AllEquipProficientInfo
---@type skillV2.AllEquipProficientInfo
skillV2_adj.metatable_AllEquipProficientInfo = {
    _ClassName = "skillV2.AllEquipProficientInfo",
}
skillV2_adj.metatable_AllEquipProficientInfo.__index = skillV2_adj.metatable_AllEquipProficientInfo
--endregion

---@param tbl skillV2.AllEquipProficientInfo 待调整的table数据
function skillV2_adj.AdjustAllEquipProficientInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_AllEquipProficientInfo)
    if tbl.infos == nil then
        tbl.infos = {}
    else
        if skillV2_adj.AdjustEquipProficientInfo ~= nil then
            for i = 1, #tbl.infos do
                skillV2_adj.AdjustEquipProficientInfo(tbl.infos[i])
            end
        end
    end
end

--region metatable skillV2.EquipProficientInfo
---@type skillV2.EquipProficientInfo
skillV2_adj.metatable_EquipProficientInfo = {
    _ClassName = "skillV2.EquipProficientInfo",
}
skillV2_adj.metatable_EquipProficientInfo.__index = skillV2_adj.metatable_EquipProficientInfo
--endregion

---@param tbl skillV2.EquipProficientInfo 待调整的table数据
function skillV2_adj.AdjustEquipProficientInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_EquipProficientInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable skillV2.ReqStudySpecialSkill
---@type skillV2.ReqStudySpecialSkill
skillV2_adj.metatable_ReqStudySpecialSkill = {
    _ClassName = "skillV2.ReqStudySpecialSkill",
}
skillV2_adj.metatable_ReqStudySpecialSkill.__index = skillV2_adj.metatable_ReqStudySpecialSkill
--endregion

---@param tbl skillV2.ReqStudySpecialSkill 待调整的table数据
function skillV2_adj.AdjustReqStudySpecialSkill(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, skillV2_adj.metatable_ReqStudySpecialSkill)
    if tbl.skillId == nil then
        tbl.skillIdSpecified = false
        tbl.skillId = 0
    else
        tbl.skillIdSpecified = true
    end
end

return skillV2_adj