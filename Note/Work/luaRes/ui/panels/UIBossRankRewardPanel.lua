local UIBossRankRewardPanel = {};

UIBossRankRewardPanel.mUnitDic = nil;

--region Components

function UIBossRankRewardPanel:GetBtnClose_GameObject()
    if(self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/CloseBtn","GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UIBossRankRewardPanel:GetUnitGridContainer()
    if(self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:GetCurComp("WidgetRoot/view/ScrollView/Grid","UIGridContainer");
    end
    return self.mUnitGridContainer;
end

--endregion

--region Method

--region Public

function UIBossRankRewardPanel:UpdateUI()
    local gridContainer = self:GetUnitGridContainer();
    if(self.mMonsterId ~= nil) then
        local isFind, rankRewardDic = CS.Cfg_LadderRankRewardManager.Instance.linkIdToRewardTableDic:TryGetValue(self.mMonsterId);
        if(isFind) then
            if(self.mUnitDic == nil) then
                self.mUnitDic = {};
            end
            if(rankRewardDic.Count > 6) then
                gridContainer.MaxCount = 6;
                local index = 0;
                for k,v in pairs(rankRewardDic) do
                    if(index >= 6) then
                        break;
                    end
                    local gobj = gridContainer.controlList[index];
                    if(self.mUnitDic[gobj] == nil) then
                        self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIBossRankRewardUnitTemplate);
                    end
                    self.mUnitDic[gobj]:UpdateUnit(v);
                    index = index + 1;
                    local bg = self:GetComp(gobj.transform, "Background", "GameObject")
                    bg:SetActive(index % 2 == 1)
                end
            else
                gridContainer.MaxCount = rankRewardDic.Count;
                local index = 0;
                for k,v in pairs(rankRewardDic) do
                    local gobj = gridContainer.controlList[index];
                    if(self.mUnitDic[gobj] == nil) then
                        self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIBossRankRewardUnitTemplate);
                    end
                    self.mUnitDic[gobj]:UpdateUnit(v);
                    index = index + 1;
                    local bg = self:GetComp(gobj.transform, "Background", "GameObject")
                    bg:SetActive(index % 2 == 1)
                end
            end
        else
            gridContainer.MaxCount = 0;
        end
    else
        gridContainer.MaxCount = 0;
    end
end

--endregion

--region Private

function UIBossRankRewardPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIBossRankRewardPanel");
    end
end

function UIBossRankRewardPanel:RemoveEvents()

end

--endregion

--endregion

function UIBossRankRewardPanel:Init()
    self:InitEvents();
end

function UIBossRankRewardPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    if(customData.monsterId == nil) then
        uimanager:ClosePanel("UIBossRankRewardPanel");
    end

    self.mMonsterId = customData.monsterId;
    self:UpdateUI();
end

function ondestroy()
    UIBossRankRewardPanel:RemoveEvents();
end

return UIBossRankRewardPanel;