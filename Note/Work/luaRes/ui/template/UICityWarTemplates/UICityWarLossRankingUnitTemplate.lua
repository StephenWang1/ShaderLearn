local UICityWarLossRankingUnitTemplate = {};

UICityWarLossRankingUnitTemplate.mRankVo = nil;

UICityWarLossRankingUnitTemplate.mRankType = nil;

UICityWarLossRankingUnitTemplate.mItemUnitDic = nil;

UICityWarLossRankingUnitTemplate.mItemShowMaxCount = 3;

--region Components

function UICityWarLossRankingUnitTemplate:GetBtnDetails_GameObject()
    if(self.mBtnDetails_GameObject == nil) then
        self.mBtnDetails_GameObject = self:Get("btnDetails", "GameObject");
    end
    return self.mBtnDetails_GameObject;
end

function UICityWarLossRankingUnitTemplate:GetRankValue_Text()
    if(self.mRankValue_Text == nil) then
        self.mRankValue_Text = self:Get("rank", "UILabel");
    end
    return self.mRankValue_Text;
end

function UICityWarLossRankingUnitTemplate:GetUnionName_Text()
    if(self.mUnionName_Text == nil) then
        self.mUnionName_Text = self:Get("union", "UILabel");
    end
    return self.mUnionName_Text;
end

function UICityWarLossRankingUnitTemplate:GetPlayerName_Text()
    if(self.mPlayerName_Text == nil) then
        self.mPlayerName_Text = self:Get("playerName","UILabel");
    end
    return self.mPlayerName_Text;
end

function UICityWarLossRankingUnitTemplate:GetRankSprite_UISprite()
    if(self.mRankSprite_UISprite == nil) then
        self.mRankSprite_UISprite = self:Get("firstSprite","UISprite")
    end
    return self.mRankSprite_UISprite;
end

function UICityWarLossRankingUnitTemplate:GetItemGridContainer()
    if(self.mItemGridContainer == nil) then
        self.mItemGridContainer = self:Get("itemGrid","UIGridContainer");
    end
    return self.mItemGridContainer;
end

--endregion

--region Method

--region Public

function UICityWarLossRankingUnitTemplate:UpdateUnit(rankVo, type)
    self.mRankVo = rankVo;
    self.mRankType = type;
    self:UpdateUI();
    self:UpdateLossItem();
end

function UICityWarLossRankingUnitTemplate:UpdateUI()
    if(self.mRankVo ~= nil) then
        self:GetRankValue_Text().gameObject:SetActive(self.mRankVo.rank > 3);
        self:GetRankSprite_UISprite().gameObject:SetActive(self.mRankVo.rank <= 3);
        if(self.mRankVo.rank <= 3) then
            self:GetRankSprite_UISprite().spriteName = tostring(self.mRankVo.rank);
        end
        self:GetUnionName_Text().text = self.mRankVo.unionName;
        self:GetRankValue_Text().text = tostring(self.mRankVo.rank);
        self:GetPlayerName_Text().text = self.mRankVo.name;
    end
end

function UICityWarLossRankingUnitTemplate:UpdateLossItem()
    if(self.mItemUnitDic == nil) then
        self.mItemUnitDic = {};
    end
    if(self.mRankVo ~= nil) then
        local gridContainer = self:GetItemGridContainer();
        local lossItems = self.mRankVo.loseItems;
        if(lossItems ~= nil) then
            local maxCount = lossItems.Count > self.mItemShowMaxCount and self.mItemShowMaxCount or lossItems.Count;
            gridContainer.MaxCount = maxCount;
            for i = 0, maxCount - 1 do
                local gobj = gridContainer.controlList[i];
                if(self.mItemUnitDic[gobj] == nil) then
                    self.mItemUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(lossItems[i]);
                if(isFind) then
                    self.mItemUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, 1);
                    CS.UIEventListener.Get(gobj).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemTable})
                    end
                end
            end
        else
            gridContainer.MaxCount = 0;
        end
    end
end

--endregion

--region Private

function UICityWarLossRankingUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnDetails_GameObject()).onClick = function()
        if(self.mRankVo ~= nil) then
            uimanager:CreatePanel("UICityWarDieDropItemPanel", nil, {itemIdList = self.mRankVo.loseItems, rankVo = self.mRankVo});
        end
    end
end

--endregion

--endregion

function UICityWarLossRankingUnitTemplate:Init()
    self:InitEvents();
end

function UICityWarLossRankingUnitTemplate:OnDestroy()

end

return UICityWarLossRankingUnitTemplate;