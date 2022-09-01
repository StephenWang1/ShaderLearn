--[[本文件为工具自动生成,禁止手动修改]]
local skillV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData skillV2.SkillBean lua中的数据结构
---@return skillV2.SkillBean C#中的数据结构
function skillV2.SkillBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.SkillBean()
    data.skillId = decodedData.skillId
    data.level = decodedData.level
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.oldExp ~= nil and decodedData.oldExpSpecified ~= false then
        data.oldExp = decodedData.oldExp
    end
    return data
end

---@param decodedData skillV2.ResSkill lua中的数据结构
---@return skillV2.ResSkill C#中的数据结构
function skillV2.ResSkill(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.ResSkill()
    if decodedData.skillList ~= nil and decodedData.skillListSpecified ~= false then
        for i = 1, #decodedData.skillList do
            data.skillList:Add(skillV2.SkillBean(decodedData.skillList[i]))
        end
    end
    if decodedData.fightValue ~= nil and decodedData.fightValueSpecified ~= false then
        data.fightValue = decodedData.fightValue
    end
    if decodedData.skillShortcut ~= nil and decodedData.skillShortcutSpecified ~= false then
        for i = 1, #decodedData.skillShortcut do
            data.skillShortcut:Add(decodedData.skillShortcut[i])
        end
    end
    --C#的skillV2.ResSkill类中没有找到xpSkillEnergy字段,不填充数据
    return data
end

---@param decodedData skillV2.ResOneSkillChange lua中的数据结构
---@return skillV2.ResOneSkillChange C#中的数据结构
function skillV2.ResOneSkillChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.ResOneSkillChange()
    data.skillBean = skillV2.SkillBean(decodedData.skillBean)
    if decodedData.fightValue ~= nil and decodedData.fightValueSpecified ~= false then
        data.fightValue = decodedData.fightValue
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    return data
end

--[[skillV2.ResMultiSkillChange 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData skillV2.SkillIdInfo lua中的数据结构
---@return skillV2.SkillIdInfo C#中的数据结构
function skillV2.SkillIdInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.SkillIdInfo()
    data.skillId = decodedData.skillId
    return data
end

---@param decodedData skillV2.ReqSetSkillShortcut lua中的数据结构
---@return skillV2.ReqSetSkillShortcut C#中的数据结构
function skillV2.ReqSetSkillShortcut(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.ReqSetSkillShortcut()
    if decodedData.skillShortcut ~= nil and decodedData.skillShortcutSpecified ~= false then
        for i = 1, #decodedData.skillShortcut do
            data.skillShortcut:Add(decodedData.skillShortcut[i])
        end
    end
    return data
end

---@param decodedData skillV2.SecretSkillUpdate lua中的数据结构
---@return skillV2.SecretSkillUpdate C#中的数据结构
function skillV2.SecretSkillUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.SecretSkillUpdate()
    if decodedData.skillId ~= nil and decodedData.skillIdSpecified ~= false then
        data.skillId = decodedData.skillId
    end
    if decodedData.site ~= nil and decodedData.siteSpecified ~= false then
        data.site = decodedData.site
    end
    return data
end

--[[skillV2.ReqTakeOffSecret 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData skillV2.SecretSkillInfo lua中的数据结构
---@return skillV2.SecretSkillInfo C#中的数据结构
function skillV2.SecretSkillInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.SecretSkillInfo()
    if decodedData.secretSkill ~= nil and decodedData.secretSkillSpecified ~= false then
        for i = 1, #decodedData.secretSkill do
            data.secretSkill:Add(skillV2.SecretSkill(decodedData.secretSkill[i]))
        end
    end
    if decodedData.form ~= nil and decodedData.formSpecified ~= false then
        data.form = decodedData.form
    end
    if decodedData.oldForms ~= nil and decodedData.oldFormsSpecified ~= false then
        for i = 1, #decodedData.oldForms do
            data.oldForms:Add(skillV2.OldForm(decodedData.oldForms[i]))
        end
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.lastDefaultForm ~= nil and decodedData.lastDefaultFormSpecified ~= false then
        for i = 1, #decodedData.lastDefaultForm do
            data.lastDefaultForm:Add(skillV2.SecretSkill(decodedData.lastDefaultForm[i]))
        end
    end
    return data
end

---@param decodedData skillV2.OldForm lua中的数据结构
---@return skillV2.OldForm C#中的数据结构
function skillV2.OldForm(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.OldForm()
    if decodedData.formId ~= nil and decodedData.formIdSpecified ~= false then
        data.formId = decodedData.formId
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData skillV2.SecretSkill lua中的数据结构
---@return skillV2.SecretSkill C#中的数据结构
function skillV2.SecretSkill(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.SecretSkill()
    if decodedData.key ~= nil and decodedData.keySpecified ~= false then
        data.key = decodedData.key
    end
    if decodedData.skillId ~= nil and decodedData.skillIdSpecified ~= false then
        data.skillId = decodedData.skillId
    end
    return data
end

--[[skillV2.ReqSwitchFormation 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData skillV2.ResSecretBack lua中的数据结构
---@return skillV2.ResSecretBack C#中的数据结构
function skillV2.ResSecretBack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.skillV2.ResSecretBack()
    if decodedData.upOrDown ~= nil and decodedData.upOrDownSpecified ~= false then
        data.upOrDown = decodedData.upOrDown
    end
    if decodedData.skillId ~= nil and decodedData.skillIdSpecified ~= false then
        data.skillId = decodedData.skillId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.form ~= nil and decodedData.formSpecified ~= false then
        data.form = decodedData.form
    end
    return data
end

--[[skillV2.ResXpSkillEnergyChange 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[skillV2.UpEquipProficient 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[skillV2.AllEquipProficientInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[skillV2.EquipProficientInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[skillV2.ReqStudySpecialSkill 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return skillV2