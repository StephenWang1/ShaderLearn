local UIEvolutionCostButtonTemplate = {};

UIEvolutionCostButtonTemplate.mIndex = 0;

--region Components

--region GameObject

function UIEvolutionCostButtonTemplate:GetAdd_GameObject()
    if (self.mAdd_GameObject == nil) then
        self.mAdd_GameObject = self:Get("add", "GameObject");
    end
    return self.mAdd_GameObject;
end

function UIEvolutionCostButtonTemplate:GetLess_GameObject()
    if (self.mLess_GameObject == nil) then
        self.mLess_GameObject = self:Get("unsnatch", "GameObject");
    end
    return self.mLess_GameObject;
end

--endregion

function UIEvolutionCostButtonTemplate:GetItemIcon_UISprite()
    if (self.mItemIcon_UISprite == nil) then
        self.mItemIcon_UISprite = self:Get("icon", "UISprite");
    end
    return self.mItemIcon_UISprite;
end

--endregion

--region Method

--region CallFunction

function UIEvolutionCostButtonTemplate:OnBtnLessClick()
    CS.CSScene.MainPlayerInfo.BagInfo:LessEvolutionCost(self.mIndex);
    luaEventManager.DoCallback(LuaCEvent.Evolution_OnLessCostSuccess, self.mIndex);
end

--endregion

--region Public

function UIEvolutionCostButtonTemplate:ShowCostButton(index)
    self.mIndex = index;
    self:ShowCostItem();
end

function UIEvolutionCostButtonTemplate:ShowCostItem()
    local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetEvolutionCost(self.mIndex);
    if (bagItemInfo ~= nil) then
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId);
        self:GetItemIcon_UISprite().gameObject:SetActive(isFind);
        self:GetAdd_GameObject():SetActive(not isFind);
        self:GetLess_GameObject():SetActive(isFind);
        if (isFind) then
            self:GetItemIcon_UISprite().spriteName = itemTable.icon;
        end
    else
        self:GetAdd_GameObject():SetActive(true);
        self:GetLess_GameObject():SetActive(false);
        self:GetItemIcon_UISprite().gameObject:SetActive(false);
    end
end

--endregion

--region Private

function UIEvolutionCostButtonTemplate:InitEvents()

    CS.UIEventListener.Get(self:GetAdd_GameObject()).onClick = function()
        luaEventManager.DoCallback(LuaCEvent.Evolution_OnAddCostButtonClick, self.mIndex);
    end

    CS.UIEventListener.Get(self:GetLess_GameObject()).onClick = function()
        self:OnBtnLessClick();
    end

    self.CallOnEvolutionAddCost = function()
        self:ShowCostItem();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnAddCostSuccess, self.CallOnEvolutionAddCost)

    self.CallOnLessCostSuccess = function(msgId, clickIndex)
        self:ShowCostItem();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnLessCostSuccess, self.CallOnLessCostSuccess)
end

function UIEvolutionCostButtonTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnAddCostSuccess, self.CallOnEvolutionAddCost)
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnLessCostSuccess, self.CallOnLessCostSuccess)
end

function UIEvolutionCostButtonTemplate:Clear()

end

--endregion

--endregion

function UIEvolutionCostButtonTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitEvents();
end

function UIEvolutionCostButtonTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIEvolutionCostButtonTemplate;