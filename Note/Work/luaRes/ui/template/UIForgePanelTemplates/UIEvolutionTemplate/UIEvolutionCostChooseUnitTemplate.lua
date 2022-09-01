---@class UIEvolutionCostChooseUnitTemplate
local UIEvolutionCostChooseUnitTemplate = {};

UIEvolutionCostChooseUnitTemplate.mLid = nil;

UIEvolutionCostChooseUnitTemplate.mIndex = nil;

UIEvolutionCostChooseUnitTemplate.mItemId = nil;

UIEvolutionCostChooseUnitTemplate.mIsAdd = true;

--region Components

function UIEvolutionCostChooseUnitTemplate:GetIcon_UISprite()
    if (self.mIcon_UISprite == nil) then
        self.mIcon_UISprite = self:Get("icon", "UISprite");
    end
    return self.mIcon_UISprite;
end

function UIEvolutionCostChooseUnitTemplate:GetCount_Text()
    if (self.mCount_Text == nil) then
        self.mCount_Text = self:Get("num", "UILabel");
    end
    return self.mCount_Text;
end

function UIEvolutionCostChooseUnitTemplate:GetSelect_GameObject()
    if (self.mSelect_GameObject == nil) then
        self.mSelect_GameObject = self:Get("choose", "GameObject")
    end
    return self.mSelect_GameObject;
end

function UIEvolutionCostChooseUnitTemplate:GetName_UILabel()
    if (self.mNameLabel == nil) then
        self.mNameLabel = self:Get("name", "UILabel")
    end
    return self.mNameLabel
end

--endregion

--region Method

--region CallFunction

function UIEvolutionCostChooseUnitTemplate:OnClickAddCost()
    if (self.mIsAdd) then
        if (CS.CSScene.MainPlayerInfo.BagInfo:TryAddEvolutionCost(self.mLid)) then
            luaEventManager.DoCallback(LuaCEvent.Evolution_OnAddCostSuccess);
        end
    else
        local index = CS.CSScene.MainPlayerInfo.BagInfo:GetEvolutionCostIndex(self.mLid)
        if (index >= 0) then
            CS.CSScene.MainPlayerInfo.BagInfo:LessEvolutionCost(index);
            luaEventManager.DoCallback(LuaCEvent.Evolution_OnLessCostSuccess, index);
        end
    end

end

--endregion

--region Public

function UIEvolutionCostChooseUnitTemplate:ShowCostChooseUnit(lid, count, btnIndex)
    self.mLid = lid;
    self.mIndex = btnIndex;
    local index = CS.CSScene.MainPlayerInfo.BagInfo:GetEvolutionCostIndex(self.mLid)
    self.mIsAdd = index < 0;
    self:GetSelect_GameObject():SetActive(not self.mIsAdd);
    local isGet, bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(lid)
    if (isGet) then
        self.mItemId = bagItemInfo.itemId;
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemId)
        if (isFind) then
            self:GetIcon_UISprite().spriteName = itemTable.icon;
            self:GetName_UILabel().text = itemTable.name
        end
        self:GetCount_Text().text = count;
    end
end

--endregion

--region Private
function UIEvolutionCostChooseUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickAddCost;
end

function UIEvolutionCostChooseUnitTemplate:RemoveEvents()

end

function UIEvolutionCostChooseUnitTemplate:Clear()
    self.mIcon_UISprite = nil;
    self.mCount_Text = nil;

    self.mItemId = nil;
    self.mLid = nil;
    self.mIndex = nil;
end

--endregion

--endregion

function UIEvolutionCostChooseUnitTemplate:Init()
    self:InitEvents();
end

function UIEvolutionCostChooseUnitTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIEvolutionCostChooseUnitTemplate;