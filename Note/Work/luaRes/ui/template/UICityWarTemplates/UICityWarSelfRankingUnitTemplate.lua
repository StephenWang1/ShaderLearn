local UICityWarSelfRankingUnitTemplate = {};

UICityWarSelfRankingUnitTemplate.mRankVo = nil;

UICityWarSelfRankingUnitTemplate.mRankType = nil;

UICityWarSelfRankingUnitTemplate.mItemUnitDic = nil;

UICityWarSelfRankingUnitTemplate.mItemShowMaxCount = 3;

--region Components

function UICityWarSelfRankingUnitTemplate:GetRankDes_GameObject()
    if(self.mRankDes_GameObject == nil) then
        self.mRankDes_GameObject = self:Get("lb_MyRankNumber","GameObject");
    end
    return self.mRankDes_GameObject;
end

function UICityWarSelfRankingUnitTemplate:GetLostItemDes_GameObject()
    if(self.mLostItemDes_GameObject == nil) then
        self.mLostItemDes_GameObject = self:Get("MyLostItem","GameObject");
    end
    return self.mLostItemDes_GameObject;
end

function UICityWarSelfRankingUnitTemplate:GetScoreDes_GameObject()
    if(self.mScoreDes_GameObject == nil) then
        self.mScoreDes_GameObject = self:Get("MyIntegral","GameObject");
    end
    return self.mScoreDes_GameObject;
end

function UICityWarSelfRankingUnitTemplate:GetBtnDetails_GameObject()
    if(self.mBtnDetails_GameObject == nil) then
        self.mBtnDetails_GameObject = self:Get("details","GameObject");
    end
    return self.mBtnDetails_GameObject;
end

function UICityWarSelfRankingUnitTemplate:GetRankValue_Text()
    if(self.mRankValue_Text == nil) then
        self.mRankValue_Text = self:Get("lb_MyRankNumber/MyRankNumber","UILabel");
    end
    return self.mRankValue_Text;
end

function UICityWarSelfRankingUnitTemplate:GetScoreValue_Text()
    if(self.mScoreValue_Text == nil) then
        self.mScoreValue_Text = self:Get("MyIntegral/MyIntegralNumber","UILabel");
    end
    return self.mScoreValue_Text;
end

function UICityWarSelfRankingUnitTemplate:GetItemGridContainer()
    if(self.mItemGridContainer == nil) then
        self.mItemGridContainer = self:Get("MyLostItem/LostItemList","UIGridContainer");
    end
    return self.mItemGridContainer;
end

--endregion

--region Method

--region Public

function UICityWarSelfRankingUnitTemplate:UpdateUnit(rankVo, rankType)
    self.mRankVo = rankVo;
    self.mRankType = rankType;
    self:UpdateUI();

end

function UICityWarSelfRankingUnitTemplate:UpdateUI()
    if(self.mRankVo ~= nil) then
        self:GetScoreDes_GameObject():SetActive(self.mRankType ~= Utility.EnumToInt(CS.duplicateV2.SabacRankType.Lose));
        self:GetLostItemDes_GameObject():SetActive(self.mRankType == Utility.EnumToInt(CS.duplicateV2.SabacRankType.Lose) and self.mRankVo.loseItems ~= nil and self.mRankVo.loseItems.Count > 0);
        self:GetBtnDetails_GameObject():SetActive(self.mRankType == Utility.EnumToInt(CS.duplicateV2.SabacRankType.Lose));

        self:GetScoreValue_Text().text = self.mRankVo.score;
        self:GetRankValue_Text().text = self.mRankVo.rank;


        if(self.mRankType == Utility.EnumToInt(CS.duplicateV2.SabacRankType.Lose)) then
            self:UpdateLossItem();
        end
    end
end

function UICityWarSelfRankingUnitTemplate:UpdateLossItem()
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

function UICityWarSelfRankingUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnDetails_GameObject()).onClick = function()
        if(self.mRankVo ~= nil) then
            uimanager:CreatePanel("UICityWarDieDropItemPanel", nil, {itemIdList = self.mRankVo.loseItems, rankVo = self.mRankVo});
        end
    end;
end

function UICityWarSelfRankingUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UICityWarSelfRankingUnitTemplate:Init()
    self:InitEvents();
end

function UICityWarSelfRankingUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UICityWarSelfRankingUnitTemplate;