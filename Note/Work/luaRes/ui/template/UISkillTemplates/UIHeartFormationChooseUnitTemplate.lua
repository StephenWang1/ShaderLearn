local UIHeartFormationChooseUnitTemplate = {};

UIHeartFormationChooseUnitTemplate.mOldFormationList = {};

UIHeartFormationChooseUnitTemplate.mHasFormation = false;

UIHeartFormationChooseUnitTemplate.mFormationId = 0;

--region Components

--region GameObject

function UIHeartFormationChooseUnitTemplate:GetIsActive_GameObject()
    if(self.mIsActive_GameObject == nil) then
        self.mIsActive_GameObject = self:Get("active", "GameObject");
    end
    return self.mIsActive_GameObject;
end

--function UIHeartFormationChooseUnitTemplate:GetTglUse_GameObject()
--    if(self.mTglUse_GameObject == nil) then
--        self.mTglUse_GameObject = self:Get("isUse", "GameObject");
--    end
--    return self.mTglUse_GameObject;
--end

function UIHeartFormationChooseUnitTemplate:GetFormationIcon_UISprite()
    if(self.mFormationIcon_UISprite == nil) then
        self.mFormationIcon_UISprite = self:Get("skillIcon","UISprite");
    end
    return self.mFormationIcon_UISprite;
end

function UIHeartFormationChooseUnitTemplate:GetChooseEffect_GameObject()
    if(self.mChooseEffect_GameObject == nil) then
        self.mChooseEffect_GameObject = self:Get("choose","GameObject");
    end
    return self.mChooseEffect_GameObject;
end

--endregion

--region UILabel

function UIHeartFormationChooseUnitTemplate:GetHeartSKillName_Text()
    if(self.mHeartSkillName_Text == nil) then
        self.mHeartSkillName_Text = self:Get("name", "UILabel");
    end
    return self.mHeartSkillName_Text;
end

function UIHeartFormationChooseUnitTemplate:GetHeartSkillValue_Text()
    if(self.mHeartSkillValue_Text == nil) then
        self.mHeartSkillValue_Text = self:Get("value", "UILabel");
    end
    return self.mHeartSkillValue_Text;
end

--endregion

--function UIHeartFormationChooseUnitTemplate:GetTglUse_UIToggle()
--    if(self.mTglUse_UIToggle == nil) then
--        self.mTglUse_UIToggle = CS.Utility_Lua.GetComponent(self:GetTglUse_GameObject(),"UIToggle");
--    end
--    return self.mTglUse_UIToggle;
--end

--endregion

--region Method

--region CallFunction

function UIHeartFormationChooseUnitTemplate:OnClickBtnUse()
    self:Choose();
    luaEventManager.DoCallback(LuaCEvent.Skill_OnHeartSkillFormationChooseClicked, self);
end

--endregion

--region Public

function UIHeartFormationChooseUnitTemplate:ShowHeartFormationUnit(oldFormation)
    self.mFormationId = oldFormation.formId;
    self.mFormationLevel = oldFormation.level;
    local isUsed = CS.CSScene.MainPlayerInfo.SkillInfoV2.CurUseHeartSkillFormationId == self.mFormationId;
    self:GetIsActive_GameObject():SetActive(isUsed);
    local isFind, formationTable = CS.Cfg_SkillHeartFormationTableManager.Instance:TryGetValue(self.mFormationId);
    if(isFind) then
        local formationLevelTable = CS.Cfg_SkillFormationLevelTableManager.Instance:GetSkillFormationLevelTableData(self.mFormationId, self.mFormationLevel);
        self:GetFormationIcon_UISprite().spriteName = formationTable.icon2;
        self:GetHeartSKillName_Text().text = formationTable.name;
        if(formationLevelTable ~= nil) then
            self:GetHeartSkillValue_Text().text = CS.Cfg_SkillFormationLevelTableManager.Instance:GetFormationDescription(formationLevelTable, luaEnumColorType.Green);
        end
    end
    self:UpdateChooseState();
end

function UIHeartFormationChooseUnitTemplate:Choose()
    self:GetChooseEffect_GameObject():SetActive(true);
end

function UIHeartFormationChooseUnitTemplate:UnChoose()
    self:GetChooseEffect_GameObject():SetActive(false);
end

--endregion

--region Private

function UIHeartFormationChooseUnitTemplate:UpdateChooseState()
    local curFormationId = CS.CSScene.MainPlayerInfo.SkillInfoV2.CurUseHeartSkillFormationId;
    if(curFormationId == self.mFormationId) then
        self:OnClickBtnUse();
    end
end

function UIHeartFormationChooseUnitTemplate:InitEvents()
    --CS.UIEventListener.Get(self:GetTglUse_GameObject()).onClick = function()
    --    self:OnClickBtnUse();
    --end

    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnClickBtnUse();
    end
end

function UIHeartFormationChooseUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UIHeartFormationChooseUnitTemplate:Init()
    self:InitEvents()
end

function UIHeartFormationChooseUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIHeartFormationChooseUnitTemplate