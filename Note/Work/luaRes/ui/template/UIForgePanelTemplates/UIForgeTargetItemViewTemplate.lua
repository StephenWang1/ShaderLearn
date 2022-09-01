---@class UIForgeTargetItemViewTemplate
local UIForgeTargetItemViewTemplate = {};

UIForgeTargetItemViewTemplate.mItemTable = nil;

UIForgeTargetItemViewTemplate.mProbability = 0;

--region Components

function UIForgeTargetItemViewTemplate:GetSuccessProbability_UILabel()
    if (self.mSuccessProbability_UILabel == nil) then
        self.mSuccessProbability_UILabel = self:Get("successrate", "UILabel");
    end
    return self.mSuccessProbability_UILabel;
end

function UIForgeTargetItemViewTemplate:GetItemIcon_UISprite()
    if (self.mItemIcon_UISprite == nil) then
        self.mItemIcon_UISprite = self:Get("ItemIcon/icon", "UISprite");
    end
    return self.mItemIcon_UISprite;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public

function UIForgeTargetItemViewTemplate:ShowItemAndProbability(itemId, probability)
    if (itemId or probability) then
        self:ShowItemIcon(itemId)
        self:ShowProbability(probability)
    end
end

---显示icon
function UIForgeTargetItemViewTemplate:ShowItemIcon(itemId)
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    if (isFind) then
        self.mItemTable = itemTable;
        self:GetItemIcon_UISprite().spriteName = self.mItemTable.icon;
    end
end

---显示几率
function UIForgeTargetItemViewTemplate:ShowProbability(probability)
    self.mProbability = probability;
    self:GetSuccessProbability_UILabel().text = probability;
end

function UIForgeTargetItemViewTemplate:SetProbabilityActive(active)
    self:GetSuccessProbability_UILabel().gameObject:SetActive(active);
end

--endregion

--region Private

function UIForgeTargetItemViewTemplate:Initialize()

end

function UIForgeTargetItemViewTemplate:InitEvents()

end

function UIForgeTargetItemViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UIForgeTargetItemViewTemplate:Init()
    self:Initialize();
    self:InitEvents();
end

function UIForgeTargetItemViewTemplate:RemoveEvents()
    self:RemoveEvents();
end

return UIForgeTargetItemViewTemplate;