---@class UIEvolutionCostChooseViewTemplate
local UIEvolutionCostChooseViewTemplate = {};

UIEvolutionCostChooseViewTemplate.mEvolutionTable = nil;

---@type table<number,UIEvolutionCostChooseUnitTemplate>
UIEvolutionCostChooseViewTemplate.mCostChooseUnitDic = nil;

UIEvolutionCostChooseViewTemplate.mSelectBagItemInfo = nil;

UIEvolutionCostChooseViewTemplate.mClickIndex = nil;

UIEvolutionCostChooseViewTemplate.mClickOrderDic = nil;

--region Components

--region GameObject

function UIEvolutionCostChooseViewTemplate:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:Get("bg", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

--endregion

function UIEvolutionCostChooseViewTemplate:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:Get("Scroll View/gridContainer", "UIGridContainer");
    end
    return self.mGridContainer;
end

function UIEvolutionCostChooseViewTemplate:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:Get("Scroll View", "UIScrollView");
    end
    return self.mScrollView;
end

--endregion

--region Method

--region Public

function UIEvolutionCostChooseViewTemplate:ShowCostChooseView(selectBagItemInfo, btnIndex)
    self.go:SetActive(true);
    self.mClickOrderDic = {};
    self:GetScrollView():ResetPosition();
    self:UpdateChooseItem(selectBagItemInfo, btnIndex);
end

function UIEvolutionCostChooseViewTemplate:UpdateChooseItem(selectBagItemInfo, btnIndex)
    self.mSelectBagItemInfo = selectBagItemInfo;
    self.mClickIndex = btnIndex;
    self:UpdateCostChooseView();
end

function UIEvolutionCostChooseViewTemplate:UpdateCostChooseView()
    if (self.mSelectBagItemInfo == nil) then
        return ;
    end
    local isFind, evolutionTable = CS.Cfg_EvolutionTableManager.Instance:TryGetValue(self.mSelectBagItemInfo.itemId);
    if (isFind) then
        self.mEvolutionTable = evolutionTable;
        local gridContainer = self:GetGridContainer();
        if CS.StaticUtility.IsNull(gridContainer) == false then
            local showLidAndCountDic = CS.CSScene.MainPlayerInfo.BagInfo:GetEvolutionViewShowDic(evolutionTable, self.mSelectBagItemInfo.lid);
            if (showLidAndCountDic ~= nil) then
                gridContainer.MaxCount = showLidAndCountDic.Count;
                local index = 0;
                for k, v in pairs(showLidAndCountDic) do
                    local gobj = gridContainer.controlList[index];
                    --if(self.mCostChooseUnitDic[index] == nil) then
                    self.mCostChooseUnitDic[index] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIEvolutionCostChooseUnitTemplate);
                    --end
                    self.mCostChooseUnitDic[index]:ShowCostChooseUnit(k, v, self.mClickIndex);
                    index = index + 1;
                end
            end
        end
    end
end

function UIEvolutionCostChooseViewTemplate:Close()
    self.go:SetActive(false);
end
--endregion

--region Private

function UIEvolutionCostChooseViewTemplate:Initialize()
    self.mCostChooseUnitDic = {};

end

function UIEvolutionCostChooseViewTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        self:Close();
    end

    self.CallOnEvolutionAddCost = function(msgId, clickIndex)
        self:UpdateCostChooseView();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnAddCostSuccess, self.CallOnEvolutionAddCost)

    self.CallOnLessCostSuccess = function(msgId, clickIndex)
        self:UpdateCostChooseView();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnLessCostSuccess, self.CallOnLessCostSuccess)
end

function UIEvolutionCostChooseViewTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnAddCostSuccess, self.CallOnEvolutionAddCost)
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnAddCostSuccess, self.CallOnLessCostSuccess)
end

function UIEvolutionCostChooseViewTemplate:Clear()
    self.mGridContainer = nil;
    self.mClickOrderDic = nil;
    self.mEvolutionTable = nil;
    self.mCostChooseUnitDic = nil;
end

--endregion

--endregion

function UIEvolutionCostChooseViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:Initialize();
    self:InitEvents();
end

function UIEvolutionCostChooseViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIEvolutionCostChooseViewTemplate;