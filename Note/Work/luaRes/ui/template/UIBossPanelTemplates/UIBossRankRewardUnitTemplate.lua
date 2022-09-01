local UIBossRankRewardUnitTemplate = {};

UIBossRankRewardUnitTemplate.mRankRewardTable = nil;

UIBossRankRewardUnitTemplate.mUIItemDic = nil;

--region Components

function UIBossRankRewardUnitTemplate:GetRankSprite_UISprite()
    if(self.mRankSprite_UISprite == nil) then
        self.mRankSprite_UISprite = self:Get("Total/rankingSprite","UISprite");
    end
    return self.mRankSprite_UISprite;
end

function UIBossRankRewardUnitTemplate:GetRankValue_Text()
    if(self.mRankValue_Text == nil) then
        self.mRankValue_Text = self:Get("Total/rankingValue","UILabel");
    end
    return self.mRankValue_Text;
end

function UIBossRankRewardUnitTemplate:GetRewardGridContainer()
    if(self.mRewardGridContainer == nil) then
        self.mRewardGridContainer = self:Get("quiteDropGrid","UIGridContainer");
    end
    return self.mRewardGridContainer;
end

--endregion

--region Method

--region Public

function UIBossRankRewardUnitTemplate:UpdateUnit(rankRewardTable)
    self.mRankRewardTable = rankRewardTable;
    self:UpdateUI();
end

function UIBossRankRewardUnitTemplate:UpdateUI()
    if(self.mRankRewardTable ~= nil) then
        --self:GetRankSprite_UISprite().gameObject:SetActive(self.mRankRewardTable.rank ~= 0 and self.mRankRewardTable.rank <= 3);
        self:GetRankSprite_UISprite().gameObject:SetActive(false);

        --self:GetRankValue_Text().gameObject:SetActive(self.mRankRewardTable.rank == 0 or self.mRankRewardTable.rank > 3);
        self:GetRankValue_Text().text = "第"..(self.mRankRewardTable.rank == 6 and "6-10" or tostring(self.mRankRewardTable.rank)).."名";
        --self:GetRankSprite_UISprite().spriteName = "paihang"..self.mRankRewardTable.rank;
    end
    self:UpdateReward();
end

function UIBossRankRewardUnitTemplate:UpdateReward()
    if(self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end
    local gridContainer = self:GetRewardGridContainer();
    if(self.mRankRewardTable ~= nil) then
        gridContainer.MaxCount = self.mRankRewardTable.item.list.Count
        if(gridContainer.MaxCount > 0) then
            for i = 0, self.mRankRewardTable.item.list.Count - 1 do
                local list = self.mRankRewardTable.item.list[i].list;
                local gobj = gridContainer.controlList[i];
                if(self.mUIItemDic[gobj] == nil) then
                    self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                if(list ~= nil and list.Count >= 2) then
                    local itemId = list[0];
                    local count = list[1];
                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                    if(isFind) then
                        self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, count);
                        CS.UIEventListener.Get(gobj).onClick = function()
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
                        end
                    end
                else
                    self.mUIItemDic[gobj]:ResetUI();
                end
            end
        end
    else
        gridContainer.MaxCount = 0;
    end
end

--endregion

--region Private

function UIBossRankRewardUnitTemplate:InitEvents()

end

function UIBossRankRewardUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UIBossRankRewardUnitTemplate:OnEnable()
    self:InitEvents();
end

function UIBossRankRewardUnitTemplate:OnDisable()
    self:RemoveEvents();
end

function UIBossRankRewardUnitTemplate:Init()

end

function UIBossRankRewardUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIBossRankRewardUnitTemplate;