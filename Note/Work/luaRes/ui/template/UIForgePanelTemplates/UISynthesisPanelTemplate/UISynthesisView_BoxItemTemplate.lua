---合成界面宝箱内物品的模板
---@class UISynthesisView_BoxItemTemplate:TemplateBase
local UISynthesisView_BoxItemTemplate = {}

---@return UnityEngine.GameObject
function UISynthesisView_BoxItemTemplate:GetUIItemGo()
    if self.mUIItemGo == nil then
        self.mUIItemGo = self:Get("UIItem", "GameObject")
    end
    return self.mUIItemGo
end

---Icon的UISprite
---@return UISprite
function UISynthesisView_BoxItemTemplate:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("UIItem/icon", "UISprite")
    end
    return self.mIconSprite
end

---Count的UISprite
---@return UILabel
function UISynthesisView_BoxItemTemplate:GetCountLabel()
    if self.mCountLabel == nil then
        self.mCountLabel = self:Get("UIItem/count", "UILabel")
    end
    return self.mCountLabel
end

---更好的箭头标识
---@return UnityEngine.GameObject
function UISynthesisView_BoxItemTemplate:GetArrowSignGo()
    if self.mArrowSignGo == nil then
        self.mArrowSignGo = self:Get("UIItem/good", "GameObject")
    end
    return self.mArrowSignGo
end

---@param ownerPanel UIBase
function UISynthesisView_BoxItemTemplate:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    CS.UIEventListener.Get(self:GetUIItemGo()).onClick = function()
        if self.mItemID == nil or self.mItemID == 0 then
            return
        end
        local itemTblExist, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemID)
        if itemTbl == nil then
            return
        end
        uiStaticParameter.UIItemInfoManager:CreatePanel({
            itemInfo = itemTbl,
            showRight = false
        })
    end
end

---@public
---@param itemId number
function UISynthesisView_BoxItemTemplate:RefreshItemID(itemId)
    self.mItemID = itemId
    self:GetCountLabel().text = ""
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        self:GetIconSprite().spriteName = ""
    else
        self:GetIconSprite().spriteName = itemTbl:GetIcon()
    end
    self:GetArrowSignGo():SetActive(false)
end

return UISynthesisView_BoxItemTemplate