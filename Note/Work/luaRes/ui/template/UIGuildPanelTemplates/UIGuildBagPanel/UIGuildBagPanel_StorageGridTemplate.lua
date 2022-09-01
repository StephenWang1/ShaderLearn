---帮会仓库格子模板
---@class UIGuildBagPanel_StorageGridTemplate:TemplateBase
local UIGuildBagPanel_StorageGridTemplate = {}

function UIGuildBagPanel_StorageGridTemplate:Init()
    self:InitComponent()
end

function UIGuildBagPanel_StorageGridTemplate:InitComponent()
    ---更好标志
    ---@type UISprite
    self.good_UISprite = self:Get("icon/good", "UISprite")
    ---数目
    ---@type UILabel
    self.count_UILabel = self:Get("icon/count", "UILabel")
    ---icon
    ---@type UISprite
    self.icon_UISprite = self:Get("icon", "UISprite")
    ---锁
    ---@type UnityEngine.GameObject
    self.lock_GameObject = self:Get("lock", "GameObject")

    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnSingleClicked()
    end
end

---@param oneItemAllInfo unionV2.OneItemAllInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIGuildBagPanel_StorageGridTemplate:RefreshItem(oneItemAllInfo, itemInfo, isLock)
    self.OneItemAllInfo = oneItemAllInfo
    self.icon_UISprite.gameObject:SetActive(oneItemAllInfo)
    self.lock_GameObject:SetActive(isLock)
    if oneItemAllInfo and itemInfo then
        if(oneItemAllInfo.itemCount == 1) then
            self.count_UILabel.text = ""
        else
            self.count_UILabel.text = oneItemAllInfo.itemCount
        end
        self.icon_UISprite.spriteName = itemInfo.icon
        local arrowType = Utility.GetArrowTypeByItemId(itemInfo)
        self.good_UISprite.gameObject:SetActive(arrowType ~= LuaEnumArrowType.NONE)
        if arrowType ~= LuaEnumArrowType.NONE then
            local sp = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(arrowType)
            self.good_UISprite.spriteName = sp
        end
    end
end

---单击
function UIGuildBagPanel_StorageGridTemplate:OnSingleClicked()
    if self.OneItemAllInfo then
        networkRequest.ReqGetBagItemInfo(self.OneItemAllInfo.itemId)
    end
end

return UIGuildBagPanel_StorageGridTemplate