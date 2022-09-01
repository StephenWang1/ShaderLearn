local UICityWarMiDaoFaZhenTipsUnitTemplate = {};

--region Components

function UICityWarMiDaoFaZhenTipsUnitTemplate:GetPlayerName_Text()
    if (self.mPlayerName_Text == nil) then
        self.mPlayerName_Text = self:Get("name", "UILabel");
    end
    return self.mPlayerName_Text;
end

function UICityWarMiDaoFaZhenTipsUnitTemplate:GetCostValue_Text()
    if (self.mCostValue_Text == nil) then
        self.mCostValue_Text = self:Get("costValue", "UILabel");
    end
    return self.mCostValue_Text;
end

function UICityWarMiDaoFaZhenTipsUnitTemplate:GetUnionName_Text()
    if (self.mUnionName_Text == nil) then
        self.mUnionName_Text = self:Get("guild", "UILabel");
    end
    return self.mUnionName_Text;
end

function UICityWarMiDaoFaZhenTipsUnitTemplate:GetBtnActive_GameObject()
    if (self.mBtnActive_GameObject == nil) then
        self.mBtnActive_GameObject = self:Get("ActivateBtn", "GameObject")
    end
    return self.mBtnActive_GameObject;
end

function UICityWarMiDaoFaZhenTipsUnitTemplate:GetActiveState_Text()
    if (self.mActiveState_Text == nil) then
        self.mActiveState_Text = self:Get("state", "UILabel");
    end
    return self.mActiveState_Text;
end

--endregion

--region Method

---@param tacticsInfo duplicateV2.SabacTacticsInfo
function UICityWarMiDaoFaZhenTipsUnitTemplate:UpdateUnit(tacticsInfo, shaBakSkillConfig)
    ---沙巴克密道法阵配置信息
    self.mShaBaKSkillConfig = shaBakSkillConfig;

    if (tacticsInfo ~= nil) then
        self:GetBtnActive_GameObject():SetActive(tacticsInfo.roleId == CS.CSScene.MainPlayerInfo.ID and not tacticsInfo.active);
        self:GetActiveState_Text().gameObject:SetActive(not (tacticsInfo.roleId == CS.CSScene.MainPlayerInfo.ID and not tacticsInfo.active));
        self:GetActiveState_Text().text = tacticsInfo.active and "已激活" or "待激活";
        self:GetPlayerName_Text().text = tacticsInfo.roleName;

        if tacticsInfo.uniteType ~= 0 then
            local tbl = clientTableManager.cfg_leagueManager:TryGetValue(tacticsInfo.uniteType)
            if tbl and tbl:GetName() then
                self:GetUnionName_Text().text = tbl:GetName()
            end
        else
            self:GetUnionName_Text().text = tacticsInfo.unionName;
        end
    end

    if (self.mShaBaKSkillConfig ~= nil and self.mShaBaKSkillConfig.Count > 1) then
        local needNum = self.mShaBaKSkillConfig[1];
        self:GetCostValue_Text().gameObject:SetActive(self:GetBtnActive_GameObject().activeSelf);
        self:GetCostValue_Text().text = tostring(needNum);
    end
end

--endregion

function UICityWarMiDaoFaZhenTipsUnitTemplate:Init()
    CS.UIEventListener.Get(self:GetBtnActive_GameObject()).onClick = function()
        if (self.mShaBaKSkillConfig ~= nil and self.mShaBaKSkillConfig.Count > 1) then
            local mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.YuanBao);
            --if(not isFind) then
            --    mNum = 0;
            --end
            local needNum = self.mShaBaKSkillConfig[1];
            if (mNum >= needNum) then
                networkRequest.ReqActiveSabacTactics();
            else
                local TipsInfo = {}
                TipsInfo[LuaEnumTipConfigType.Describe] = "元宝不足";
                TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnActive_GameObject().transform;
                TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
            end
        else
            networkRequest.ReqActiveSabacTactics();
        end
    end
end

return UICityWarMiDaoFaZhenTipsUnitTemplate;