---@class UICityWarContributePanel:UIBase
local UICityWarContributePanel = {};

---@type table<CS.UnityEngine.GameObject, UICityWarContributeRankUnitTemplate>
UICityWarContributePanel.mUnitDic = nil;

function UICityWarContributePanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UICityWarContributePanel:GetBtnContribute_GameObject()
    if (self.mBtnContribute_GameObject == nil) then
        self.mBtnContribute_GameObject = self:GetCurComp("WidgetRoot/events/EnterBtn", "GameObject");
    end
    return self.mBtnContribute_GameObject;
end

function UICityWarContributePanel:GetBtnContributeReward_GameObject()
    if (self.mBtnContributeReward_GameObject == nil) then
        self.mBtnContributeReward_GameObject = self:GetCurComp("WidgetRoot/events/btn_reward", "GameObject")
    end
    return self.mBtnContributeReward_GameObject;
end

function UICityWarContributePanel:GetContributeDes_Text()
    if (self.mContributeDes_Text == nil) then
        self.mContributeDes_Text = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/details", "UILabel")
    end
    return self.mContributeDes_Text;
end

function UICityWarContributePanel:GetContributeUnitGridContainer()
    if (self.mContributeUnitGridContainer == nil) then
        self.mContributeUnitGridContainer = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/ScrollView/Grid", "UIGridContainer")
    end
    return self.mContributeUnitGridContainer;
end

function UICityWarContributePanel:GetMainPlayerContributeRankUnit()
    if (self.mMainPlayerContributeRankUnit == nil) then
        self.mMainPlayerContributeRankUnit = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/introduce/labelGroup/myrank", "GameObject"), luaComponentTemplates.UICityWarContributeRankUnitTemplate)
    end
    return self.mMainPlayerContributeRankUnit;
end

---@private
function UICityWarContributePanel:OnResSabacDonateRankInfoMessage()
    self:UpdateUI();
end

---@public
function UICityWarContributePanel:UpdateUI()
    local desId = 226;
    ---@type TABLE.cfg_description
    local desTbl = clientTableManager.cfg_descriptionManager:TryGetValue(desId);
    if (desTbl ~= nil) then
        self:GetContributeDes_Text().text = desTbl:GetValue();
    end
    self:UpdateContributeRank();
end

function UICityWarContributePanel:UpdateContributeRank()
    if (self.mUnitDic == nil) then
        self.mUnitDic = {};
    end

    local list = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetContributeRank();
    local gridContainer = self:GetContributeUnitGridContainer();
    local count = (list == nil or #list < 5) and 5 or #list
    gridContainer.MaxCount = count;
    for i = 1, count do
        local gobj = gridContainer.controlList[i - 1];
        if (self.mUnitDic[gobj] == nil) then
            self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICityWarContributeRankUnitTemplate);
        end
        if list == nil then
            self.mUnitDic[gobj]:UpdateUnit(nil, i);
        else
            self.mUnitDic[gobj]:UpdateUnit(list[i], i);
        end
    end
    local mainPlayerRank = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetMainPlayerContributeRank();
    if mainPlayerRank then
        self:GetMainPlayerContributeRankUnit():UpdateUnit(mainPlayerRank, mainPlayerRank.rankNo);
    else
        self:GetMainPlayerContributeRankUnit():UpdateUnit(nil);
    end

end

---@private
function UICityWarContributePanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarContributePanel");
    end;

    CS.UIEventListener.Get(self:GetBtnContribute_GameObject()).onClick = function()
        uimanager:CreatePanel("UICityWarContributeCountPanel");
    end;

    CS.UIEventListener.Get(self:GetBtnContributeReward_GameObject()).onClick = function()
        uimanager:CreatePanel("UICityWarContributeRewardPanel");
    end

    self.CallOnResSabacDonateRankInfoMessage = function()
        self:OnResSabacDonateRankInfoMessage();
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSabacDonateRankInfoMessage, self.CallOnResSabacDonateRankInfoMessage)
end

function UICityWarContributePanel:Init()
    self:InitEvents();
end

function UICityWarContributePanel:Show()
    networkRequest.ReqSabacDonateRankInfo()
    self:GetMainPlayerContributeRankUnit():UpdateUnit(nil);

end

return UICityWarContributePanel;