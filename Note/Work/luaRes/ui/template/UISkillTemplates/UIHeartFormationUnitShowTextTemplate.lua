local UIHeartFormationUnitShowTextTemplate = {};

--region Components

--region GameObject

--endregion

--region UILabel

function UIHeartFormationUnitShowTextTemplate:GetHeartSkillName_Text()
    if(self.mHeartSkillName_Text == nil) then
        self.mHeartSkillName_Text = self:Get("Label", "UILabel");
    end
    return self.mHeartSkillName_Text;
end

function UIHeartFormationUnitShowTextTemplate:GetHeartSkillValue_Text()
    if(self.mHeartSkillValue_Text == nil) then
        self.mHeartSkillValue_Text = self:Get("value", "UILabel");
    end
    return self.mHeartSkillValue_Text;
end

function UIHeartFormationUnitShowTextTemplate:GetSkillFormationIcon_UISprite()
    if(self.mSkillFormationIcon_UISprite == nil) then
        self.mSkillFormationIcon_UISprite = self:Get("img","UISprite");
    end
    return self.mSkillFormationIcon_UISprite;
end

function UIHeartFormationUnitShowTextTemplate:GetHeartSkillIcon_UISprite()
    if(self.mHeartSkillIcon_UISprite == nil) then
        self.mHeartSkillIcon_UISprite = self:Get("skillIcon","UISprite");
    end
    return self.mHeartSkillIcon_UISprite;
end

--endregion

--endregion

--region Method

--region Public

function UIHeartFormationUnitShowTextTemplate:ShowText(heartSkillType)
    local useHeartSkillDic = CS.CSScene.MainPlayerInfo.SkillInfoV2.UseHeartSkillDic;
    local isFind0, heartSkillId = useHeartSkillDic:TryGetValue(heartSkillType);
    if(isFind0) then
        self:ShowHeartSkillText(heartSkillId);
    else
        self:GetHeartSkillName_Text().text = luaEnumColorType.Gray..self:GetSecretSkillTypeName(heartSkillType).."[-]";
        self:GetHeartSkillValue_Text().text = luaEnumColorType.Red.."未启用[-]";
    end
end

function UIHeartFormationUnitShowTextTemplate:ShowHeartSkillText(heartSkillId)
    local isFind1, skillBean = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic:TryGetValue(heartSkillId);
    local isGetValue, tableValue = CS.Cfg_SkillTableManager.Instance:TryGetValue(heartSkillId);
    self:GetHeartSkillIcon_UISprite().gameObject:SetActive(true);
    self:GetSkillFormationIcon_UISprite().gameObject:SetActive(false);
    if(isFind1) then
        local skillCondition = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillBean.skillId, skillBean.level)
        if(skillCondition ~= nil) then
            self:GetHeartSkillValue_Text().text = luaEnumColorType.White..CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(skillCondition.id, luaEnumColorType.Yellow).."[-]";
        end
    end
    if(isGetValue) then
        self:GetHeartSkillName_Text().text = luaEnumColorType.White..tableValue.name.."[-]";
        self:GetHeartSkillIcon_UISprite().spriteName = tableValue.icon;
    end
end

function UIHeartFormationUnitShowTextTemplate:ShowFormationText(formationId, formationLevel)
    local formationLevelTable = CS.Cfg_SkillFormationLevelTableManager.Instance:GetSkillFormationLevelTableData(formationId, formationLevel);
    local isFind, formationTable = CS.Cfg_SkillHeartFormationTableManager.Instance:TryGetValue(formationId);
    self:GetSkillFormationIcon_UISprite().gameObject:SetActive(true);
    self:GetHeartSkillIcon_UISprite().gameObject:SetActive(false);
    if(formationLevelTable ~= nil) then
        if(isFind) then
            self:GetHeartSkillName_Text().text = luaEnumColorType.BlueWhite..formationTable.name.."[-]";
        end
        self:GetHeartSkillValue_Text().text =  luaEnumColorType.BlueWhite..CS.Cfg_SkillFormationLevelTableManager.Instance:GetFormationDescription(formationLevelTable, luaEnumColorType.BlueWhite).."[-]";
        self:GetSkillFormationIcon_UISprite().spriteName = formationTable.icon2;
    else
        self:GetHeartSkillName_Text().text = "心法组合可激活心阵";
        self:GetHeartSkillValue_Text().text = "";
        --self:GetHeartSkillName_Text().text = "";
        --self:GetHeartSkillValue_Text().text = luaEnumColorType.Red.."心阵未激活[-]";
        self:GetSkillFormationIcon_UISprite().spriteName = "xz0";
    end
end

--endregion

--region Private

function UIHeartFormationUnitShowTextTemplate:GetSecretSkillTypeName(secretSkillType)
    --if(secretSkillType == LuaEnumSecretSkillType.SecretLife) then
    --    return "生命";
    --elseif(secretSkillType == LuaEnumSecretSkillType.SecretDefense) then
    --    return "防御";
    --elseif(secretSkillType == LuaEnumSecretSkillType.SecretElementalAttack) then
    --    return "元素攻击";
    --elseif(secretSkillType == LuaEnumSecretSkillType.SecretElementalDefense) then
    --    return "元素防御";
    --elseif(secretSkillType == LuaEnumSecretSkillType.SecretResistanceToOccupation) then
    --    return "职业防御";
    --elseif(secretSkillType == LuaEnumSecretSkillType.SecretResistanceToSkill) then
    --    return "技能防御";
    --end
    return "心法";
end

function UIHeartFormationUnitShowTextTemplate:InitEvents()

end

function UIHeartFormationUnitShowTextTemplate:RemoveEvents()

end

function UIHeartFormationUnitShowTextTemplate:Clear()
    self.mHeartSkillValue_Text = nil;
    self.mHeartSkillName_Text = nil;
end
--endregion

--endregion

function UIHeartFormationUnitShowTextTemplate:Init()
    self:InitEvents();
end

function UIHeartFormationUnitShowTextTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIHeartFormationUnitShowTextTemplate;