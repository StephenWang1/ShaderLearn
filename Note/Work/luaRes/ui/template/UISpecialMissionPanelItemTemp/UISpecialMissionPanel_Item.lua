local UISpecialMissionPanel_Item = {}


function UISpecialMissionPanel_Item:InitComponents()
    ---图片
    self.mIcon_UISprite = self:Get("icon", "Top_UISprite")
    self.count = self:Get("count", "Top_UILabel")
    self.add = self:Get("add", "GameObject")
    self.countData=0;
    self.maxCount=0;
    self.isMeet=false;

    ---ItemId
    self.mItemId = -1
    ---Item数据
    self.mItemInfo = nil
    if self.mIcon_UISprite ~= nil then
        self.mIcon_UISprite.gameObject:SetActive(true)
    end

end

function UISpecialMissionPanel_Item:InitOther()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClinkItem
end

function UISpecialMissionPanel_Item:Init()
    self:InitComponents()
    self:InitOther()
end

---显示UI
function UISpecialMissionPanel_Item:RefreshUI(itemID,count,maxCount)
    self.countData=count;
    self.maxCount=maxCount;
    self.isMeet=count>=maxCount and maxCount~=0
    self.mItemId = itemID
    self.mItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(itemID)
    local spriteName = ""
    if self.mItemInfo ~= nil then
        spriteName = self.mItemInfo.icon
    end
    if self.mIcon_UISprite ~= nil then
        self.mIcon_UISprite.spriteName = spriteName
    end
    self.count.text=count
    self.add:SetActive(false)
end

function UISpecialMissionPanel_Item:OnClinkItem()
    if self.mItemInfo == nil then
        print("UISpecialMissionPanel_Item:找不到此物品信息，id为：" .. tostring(self.mItemId))
        return
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = self.mItemInfo,rightUpButtonsModule = luaComponentTemplates.UISpecialMissionPanel_ItemPartRightUpOperate,showRight = true})
end

return UISpecialMissionPanel_Item