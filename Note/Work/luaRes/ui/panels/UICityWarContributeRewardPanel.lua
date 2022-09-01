---@class UICityWarContributeRewardPanel:UIBase
local UICityWarContributeRewardPanel = {};

---@type table<CS.UnityEngine.GameObject, UICityWarContributeRankRewardUnitTemplate>
UICityWarContributeRewardPanel.mRankRewardUnitDic = nil;

UICityWarContributeRewardPanel.mMaxShowRankRewardCount = 5;

function UICityWarContributeRewardPanel:GetBtnClose_GameObject()
    if(self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/CloseBtn","GameObject")
    end
    return self.mBtnClose_GameObject;
end

function UICityWarContributeRewardPanel:GetMinRewardDes_Text()
    if(self.mMinRewardDes_Text == nil) then
        self.mMinRewardDes_Text = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/title2/desc","UILabel");
    end
    return self.mMinRewardDes_Text;
end

function UICityWarContributeRewardPanel:GetRankRewardGridContainer()
    if(self.mRankRewardGridContainer == nil) then
        self.mRankRewardGridContainer = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/ScrollView_rankReward/Grid","UIGridContainer");
    end
    return self.mRankRewardGridContainer;
end

---@return UICityWarContributeRankRewardUnitTemplate
function UICityWarContributeRewardPanel:GetDefaultRankRewardUnit()
    if(self.mDefaultRankRewardUnit == nil) then
        self.mDefaultRankRewardUnit = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/introduce/labelGroup/LowReward","GameObject"), luaComponentTemplates.UICityWarContributeRankRewardUnitTemplate)
    end
    return self.mDefaultRankRewardUnit;
end

function UICityWarContributeRewardPanel:GetAllContributeRewardDesRoot_GameObject()
    if(self.mAllContributeRewardDesRoot_GameObject == nil) then
        self.mAllContributeRewardDesRoot_GameObject = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/ScrollView_combineSbk","GameObject")
    end
    return self.mAllContributeRewardDesRoot_GameObject;
end

function UICityWarContributeRewardPanel:GetAllContributeReward_Text()
    if(self.mAllContributeReward_Text == nil) then
        self.mAllContributeReward_Text = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/ScrollView_combineSbk/rank1/value","UILabel")
    end
    return self.mAllContributeReward_Text;
end

function UICityWarContributeRewardPanel:GetWinnerContributeReward_Text()
    if(self.mWinnerContributeReward_Text == nil) then
        self.mWinnerContributeReward_Text = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/ScrollView_combineSbk/rank2/value","UILabel")
    end
    return self.mWinnerContributeReward_Text;
end

function UICityWarContributeRewardPanel:GetLoserContributeReward_Text()
    if(self.mLoserContributeReward_Text == nil) then
        self.mLoserContributeReward_Text = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/ScrollView_combineSbk/rank3/value","UILabel")
    end
    return self.mLoserContributeReward_Text;
end

function UICityWarContributeRewardPanel:OnResSabacDonateRankInfoMessage()
    self:UpdateUI();
end

function UICityWarContributeRewardPanel:UpdateUI()
    self:GetAllContributeRewardDesRoot_GameObject():SetActive(true);
    self:GetAllContributeReward_Text().text = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetAllContributeValue().."钻石";
    self:GetWinnerContributeReward_Text().text = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetWinnerContributeValue().."钻石";
    self:GetLoserContributeReward_Text().text = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetLoserContributeValue().."钻石";
    self:GetMinRewardDes_Text().text = luaEnumColorType.Gray.."(累计捐献"..gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetMinRewardNeedCoinValue().."以上)[-]";
end

function UICityWarContributeRewardPanel:UpdateRankReward()
    if(self.mRankRewardUnitDic == nil) then
        self.mRankRewardUnitDic = {};
    end
    local gridContainer = self:GetRankRewardGridContainer();
    gridContainer.MaxCount = self.mMaxShowRankRewardCount;
    for i = 0, self.mMaxShowRankRewardCount - 1 do
        local gobj = gridContainer.controlList[i];
        local rankRewardTbl = clientTableManager.cfg_sbk_donate_rewardManager:TryGetValue(i + 1);
        if(self.mRankRewardUnitDic[gobj] == nil) then
            self.mRankRewardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICityWarContributeRankRewardUnitTemplate, self);
        end
        if(rankRewardTbl ~= nil) then
            self.mRankRewardUnitDic[gobj]:UpdateUnit(rankRewardTbl);
        end
    end

    local defaultTbl = clientTableManager.cfg_sbk_donate_rewardManager:TryGetValue(0);
    if(defaultTbl ~= nil) then
        self:GetDefaultRankRewardUnit():UpdateUnit(defaultTbl);
    end
end

---@private
function UICityWarContributeRewardPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarContributeRewardPanel");
    end

    self.CallOnResSabacDonateRankInfoMessage = function()
        self:OnResSabacDonateRankInfoMessage();
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSabacDonateRankInfoMessage, self.CallOnResSabacDonateRankInfoMessage)
end

function UICityWarContributeRewardPanel:Init()
    self:InitEvents()
end

function UICityWarContributeRewardPanel:Show()
    networkRequest.ReqSabacDonateRankInfo();
    self:UpdateRankReward();
    self:GetAllContributeRewardDesRoot_GameObject():SetActive(false);
end


return UICityWarContributeRewardPanel;