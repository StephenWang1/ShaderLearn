---@class UIItemInfoPanel_Info_FixLowerSkill 道具固定下方的技能
local UIItemInfoPanel_Info_FixLowerSkill = {}

--region 组件
---技能ICON
---@return UISprite
function UIItemInfoPanel_Info_FixLowerSkill:GetSkillIconSprite()
    if self.mGetSkillIconSprite == nil then
        self.mGetSkillIconSprite = self:Get("skillIcon", "UISprite")
    end
    return self.mGetSkillIconSprite
end

---技能名字
---@return UILabel
function UIItemInfoPanel_Info_FixLowerSkill:GetSkillNameLabel()
    if self.mGetSkillNameLabel == nil then
        self.mGetSkillNameLabel = self:Get("skillName", "UILabel")
    end
    return self.mGetSkillNameLabel
end

---技能状态
---@return UILabel
function UIItemInfoPanel_Info_FixLowerSkill:GetSkillStateLabel()
    if self.mGetSkillNameState == nil then
        self.mGetSkillNameState = self:Get("skillState", "UILabel")
    end
    return self.mGetSkillNameState
end

---技能描述
---@return UILabel
function UIItemInfoPanel_Info_FixLowerSkill:GetSkillDescLabel()
    if self.mGetSkillDescLabel == nil then
        self.mGetSkillDescLabel = self:Get("skillDesc", "UILabel")
    end
    return self.mGetSkillDescLabel
end

--endregion

---@type TABLE.cfg_items
UIItemInfoPanel_Info_FixLowerSkill.ItemTbl = nil

---@type TABLE.cfg_skills
UIItemInfoPanel_Info_FixLowerSkill.SkillTbl = nil

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_FixLowerSkill:RefreshWithInfo(commonData)
    local CSItemInfo = commonData.itemInfo
    if CSItemInfo == nil then
        luaclass.UIRefresh:RefreshActive(self.go, false)
        return
    end
    self.ItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(CSItemInfo.id)
    if (self.ItemTbl == nil) then
        self.go:SetActive(false)
        return ;
    end

    local skillInfo, skillCondition, isActivate, ActivateLimitCount = self:GetSkillData(commonData, self.ItemTbl)
    if (skillInfo == nil or skillCondition == nil) then
        self.go:SetActive(false)
        return ;
    end
    self.SkillTbl = skillInfo;

    self:UpdateInfo(skillInfo, skillCondition, isActivate, ActivateLimitCount)
end

---@param skillTbl TABLE.cfg_skills
---@param skillCondition CS.TABLE.CFG_CONDITIONS
---@param ActivateLimitCount number 套装激活总数量
function UIItemInfoPanel_Info_FixLowerSkill:UpdateInfo(skillTbl, skillCondition, isActivate, ActivateLimitCount)
    self:GetSkillIconSprite().spriteName = skillTbl:GetIcon()

    local name = skillTbl:GetName()

    self:GetSkillNameLabel().text = "[FF0000]" .. name
    if (isActivate == false) then
        self:GetSkillStateLabel().text = "[878787]" .. tostring(ActivateLimitCount) .. "件后激活"
    else
        self:GetSkillStateLabel().text = "[878787]Lv" .. skillCondition.level
    end
    local len = self:getStringLength(name)

    self:GetSkillStateLabel().transform.localPosition = CS.UnityEngine.Vector3(-70 + len * 18, 18, 0);
    self:GetSkillDescLabel().text = "               [878787]" .. CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(skillCondition.id, "[878787]")
end

-- 获取字符串的长度（任何单个字符长度都为1）
function UIItemInfoPanel_Info_FixLowerSkill:getStringLength(inputstr)
    if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
        return nil
    end
    local length = 0  -- 字符的个数
    local i = 1
    while true do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 239 then
            byteCount = 4  -- 4字节字符
        elseif curByte > 223 then
            byteCount = 3  -- 汉字
        elseif curByte > 128 then
            byteCount = 2  -- 双字节字符
        else
            byteCount = 1  -- 单字节字符
        end
        -- local char = string.sub(inputstr, i, i + byteCount - 1)
        -- print(char)  -- 打印单个字符
        i = i + byteCount
        length = length + 1
        if i > #inputstr then
            break
        end
    end
    return length
end

---@param itemTbl TABLE.cfg_items
---@param commonData UIItemTipInfoCommonData
---@return TABLE.cfg_skills,CS.TABLE.CFG_CONDITIONS,boolean
function UIItemInfoPanel_Info_FixLowerSkill:GetSkillData(commonData, itemTbl)
    local divineId = itemTbl:GetDivineId();
    ---@type TABLE.cfg_divinesuit
    local divineTbl = clientTableManager.cfg_divinesuitManager:TryGetValue(divineId);
    local type = 0;
    local subtype = 1
    if (divineTbl ~= nil) then
        type = divineTbl:GetType();
        subtype = divineTbl:GetSubType();
    end
    ---@type LuaPlayerEquipmentListData
    local equipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(type, subtype);
    local isBagOrUrlLink = false

    local otherMainPlayer = commonData.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL
    if (otherMainPlayer and commonData.roleId ~= nil and commonData.roleId ~= CS.CSScene.MainPlayerInfo.ID) then
        equipmentListData = gameMgr:GetOtherPlayerDataMgr():GetEquipmentList(type, subtype)
    elseif (commonData.roleId ~= nil and commonData.roleId ~= CS.CSScene.MainPlayerInfo.ID) then
        isBagOrUrlLink = true
    elseif (commonData.bagItemInfo ~= nil and commonData.bagItemInfo.index ~= 0) then
        equipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(type, subtype);
    else
        isBagOrUrlLink = true
    end

    ---@type table<LuaEquipSuitAdditionItem>
    local allAttribute = equipmentListData:GetAdditionDataList(subtype)
    if (allAttribute == nil) then
        return nil, nil
    end
    ---@param item LuaEquipSuitAdditionItem
    for i, item in pairs(allAttribute) do
        local skillID, level, isActivate, ActivateLimitCount = item:GetSkill();
        if (isBagOrUrlLink) then
            level = 1;
            isActivate = false;
        end
        if (skillID ~= nil and skillID ~= 0) then
            local skillTbl = clientTableManager.cfg_skillsManager:TryGetValue(skillID);
            ---@type CS.TABLE.CFG_CONDITIONS
            local skillCondition = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillID, level);
            return skillTbl, skillCondition, isActivate, ActivateLimitCount
        end
    end
    return nil, nil
end

return UIItemInfoPanel_Info_FixLowerSkill