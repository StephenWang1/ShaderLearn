---@class UICityWarRankRewardPanel:UIBase
local UICityWarRankRewardPanel = {};

---@type LuaEnumCityWarRankRewardType
UICityWarRankRewardPanel.mSelectRewardType = nil;

---@type table<CS.UnityEngine.GameObject, UICityWarRankRewardTemplate>
UICityWarRankRewardPanel.mUnitDic = nil;

function UICityWarRankRewardPanel:GetBtnClose_GameObject()
    if(self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/CloseBtn","GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UICityWarRankRewardPanel:GetBtnRankReward_GameObject()
    if(self.mBtnRakReward_GameObject == nil) then
        self.mBtnRakReward_GameObject = self:GetCurComp("WidgetRoot/events/btn","GameObject")
    end
    return self.mBtnRakReward_GameObject;
end

function UICityWarRankRewardPanel:GetBtnPersonalReward_GameObject()
    if(self.mBtnPersonalReward_GameObject == nil) then
        self.mBtnRakReward_GameObject = self:GetCurComp("WidgetRoot/events/btnPersonal","GameObject")
    end
    return self.mBtnRakReward_GameObject;
end

function UICityWarRankRewardPanel:GetBtnRank_GameObject()
    if(self.mBtnRank_GameObject == nil) then
        self.mBtnRank_GameObject = self:GetCurComp("WidgetRoot/events/RankBtn","GameObject");
    end
    return self.mBtnRank_GameObject;
end

function UICityWarRankRewardPanel:GetTglPersonalReward_UIToggle()
    if(self.mTglPersonalReward_UIToggle == nil) then
        self.mTglPersonalReward_UIToggle = self:GetCurComp("WidgetRoot/events/btnPersonal","UIToggle")
    end
    return self.mTglPersonalReward_UIToggle;
end

function UICityWarRankRewardPanel:GetTglRankReward_UIToggle()
    if(self.mTglRankReward_UIToggle == nil) then
        self.mTglRankReward_UIToggle = self:GetCurComp("WidgetRoot/events/btn","UIToggle")
    end
    return self.mTglRankReward_UIToggle;
end

function UICityWarRankRewardPanel:GetTitle_Text()
    if(self.mTitle_Text == nil) then
        self.mTitle_Text = self:GetCurComp("WidgetRoot/view/lb_rank","UILabel")
    end
    return self.mTitle_Text;
end


function UICityWarRankRewardPanel:GetUnitGridContainer()
    if(self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:GetCurComp("WidgetRoot/view/ScrollView/Grid","UIGridContainer")
    end
    return self.mUnitGridContainer;
end

---@public
---@param type LuaEnumCityWarRankRewardType
function UICityWarRankRewardPanel:UpdateRankRewardType(type)
    self.mSelectRewardType = type;
    self:UpdateUI();
    self:UpdateToggle();
end

---@public 更新UI
function UICityWarRankRewardPanel:UpdateUI()
    if(self.mSelectRewardType == LuaEnumCityWarRankRewardType.ScoreRankReward) then
        self:UpdateToRankReward();
    elseif(self.mSelectRewardType == LuaEnumCityWarRankRewardType.PersonalReward) then
        self:UpdateToPersonalReward();
    end
end

function UICityWarRankRewardPanel:UpdateToggle()
    if(self.mSelectRewardType == LuaEnumCityWarRankRewardType.ScoreRankReward) then
        self:GetTglRankReward_UIToggle().value = true;
    elseif(self.mSelectRewardType == LuaEnumCityWarRankRewardType.PersonalReward) then
        self:GetTglPersonalReward_UIToggle().value = true;
    end
end

function UICityWarRankRewardPanel:UpdateToRankReward()
    self:GetTitle_Text().text = "积分排行奖励";
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    self:GetBtnRank_GameObject():SetActive(true);
    local gridContainer = self:GetUnitGridContainer();
    local scoreRankRewards = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetScoreRankRewards();
    if(scoreRankRewards ~= nil and #scoreRankRewards > 0) then
        gridContainer.MaxCount = #scoreRankRewards;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            if(self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICityWarRankRewardTemplate);
            end
            self.mUnitDic[gobj]:UpdateUIToScoreRankReward(scoreRankRewards[i + 1]);
        end
    end
end

function UICityWarRankRewardPanel:UpdateToPersonalReward()
    self:GetTitle_Text().text = "个人积分奖励";
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    self:GetBtnRank_GameObject():SetActive(false);
    local gridContainer = self:GetUnitGridContainer();
    local personalReward = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetPersonalRewards();
    if(personalReward ~= nil and #personalReward > 0) then
        gridContainer.MaxCount = #personalReward;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            if(self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICityWarRankRewardTemplate);
            end
            self.mUnitDic[gobj]:UpdateUIToPersonalReward(personalReward[i + 1]);
        end
    end
end

function UICityWarRankRewardPanel:Init()
    CS.UIEventListener.Get(self:GetBtnRankReward_GameObject()).onClick = function()
        self:UpdateRankRewardType(LuaEnumCityWarRankRewardType.ScoreRankReward);
    end

    CS.UIEventListener.Get(self:GetBtnPersonalReward_GameObject()).onClick = function()
        self:UpdateRankRewardType(LuaEnumCityWarRankRewardType.PersonalReward);
    end

    CS.UIEventListener.Get(self:GetBtnRank_GameObject()).onClick = function()
        uimanager:CreatePanel("UICityWarRankingPanel");
    end

    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarRankRewardPanel");
    end
end

function UICityWarRankRewardPanel:Show()
    self:UpdateRankRewardType(LuaEnumCityWarRankRewardType.ScoreRankReward);
end
--
--function ondestroy()
--
--end

return UICityWarRankRewardPanel;