local UICoinsShowViewTemplate = {};

--region Components
function UICoinsShowViewTemplate:GetCoinsShowContent_UIGridContainer()
    if(self.mCoinsShowContent_UIGridContainer == nil) then
        self.mCoinsShowContent_UIGridContainer = self:Get("CoinsShow", "UIGridContainer");
    end
    return self.mCoinsShowContent_UIGridContainer;
end
--endregion


--region Method

--region CallFunc
function UICoinsShowViewTemplate:OnCoinsValueChanged(coinsId)
    for k,v in pairs(self.mShowCoinsUnitDic) do
        if(v.mCoinId == coinsId) then
            v:SetShowCoins(coinsId);
        end
    end
end
--endregion

---根据货币id列表显示货币资源
function UICoinsShowViewTemplate:SetShowCoinsWithList(coinsIdList)
    if(self.mShowCoinsUnitDic == nil) then
        self.mShowCoinsUnitDic = {};
    end
    local gridContainer = self:GetCoinsShowContent_UIGridContainer();

    if(coinsIdList ~= nil) then
        gridContainer.MaxCount = coinsIdList.Count;
        for i = 0, coinsIdList.Count - 1 do
            local v = coinsIdList[i];
            local unit = gridContainer.controlList[i];
            if(self.mShowCoinsUnitDic[unit] == nil) then
                self.mShowCoinsUnitDic[unit] = templatemanager.GetNewTemplate(unit, luaComponentTemplates.UICoinsShowUnitTemplate);
            end
            CS.UIEventListener.Get(unit.gameObject).onClick = function()
                local ___,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v)
                if itemInfo then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemInfo})
                end
            end
            self.mShowCoinsUnitDic[unit]:SetShowCoins(v);
        end
    else
        gridContainer.MaxCount = 0;
    end
end

function UICoinsShowViewTemplate:Clear()
    self.mCoinsShowContent_UIGridContainer = nil
    self.mShowCoinsUnitDic = nil;
end

function UICoinsShowViewTemplate:InitEvents()
    --self.CallFuncOnBagChanged = function(id, tabledata)
    --    if(tabledata ~= nil) then
    --        if(tabledata.coinList ~= nil) then
    --            for k,v in pairs(tabledata.coinList) do
    --                for k1, v1 in pairs(self.mShowCoinsUnitDic) do
    --                    if(v1:CompareId(v.itemId)) then
    --                        v1:SetShowCoins(v.itemId);
    --                        --break;
    --                    end
    --                end
    --            end
    --        end
    --
    --        if(tabledata.itemList ~= nil) then
    --            for k,v in pairs(tabledata.itemList) do
    --                for k1, v1 in pairs(self.mShowCoinsUnitDic) do
    --                    if(v1:CompareId(v.itemId)) then
    --                        v1:SetShowCoins(v.itemId);
    --                        --break;
    --                    end
    --                end
    --            end
    --        else
    --            for k1, v1 in pairs(self.mShowCoinsUnitDic) do
    --                v1:CheckShowCoins();
    --            end
    --        end
    --
    --        if(tabledata.removedIdList ~= nil) then
    --            for k1, v1 in pairs(self.mShowCoinsUnitDic) do
    --                v1:SetShowCoins(v1.mCoinId);
    --            end
    --        end
    --    end
    --end
    --self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.CallFuncOnBagChanged);
end

--endregion

function UICoinsShowViewTemplate:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel;
    self:InitEvents();
end

function UICoinsShowViewTemplate:OnDestroy()
    --self:RemoveEvents();
    self:Clear();
end

return UICoinsShowViewTemplate;