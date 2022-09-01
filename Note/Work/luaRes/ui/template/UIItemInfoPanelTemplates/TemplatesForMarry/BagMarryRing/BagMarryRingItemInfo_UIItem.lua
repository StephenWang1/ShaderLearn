local BagMarryRingItemInfo_UIItem = {}
setmetatable(BagMarryRingItemInfo_UIItem,luaComponentTemplates.RoleMarryRingItemInfo_UIItem)
function BagMarryRingItemInfo_UIItem:RefreshWeight()
    self:GetWeight_UILabel().text = "婚戒"
end

---刷新绑定数据
function BagMarryRingItemInfo_UIItem:RefreshBindInfo()
    if self.BagItemInfo ~= nil then
        self.IsNeedShowBind, self.IsNeedShowBindTwoParamet = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.BagItemInfo)
    elseif self.ItemInfo ~= nil then
        self.IsNeedShowBind, self.IsNeedShowBindTwoParamet = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.ItemInfo)
    end
end

function BagMarryRingItemInfo_UIItem:RefreshLasting()
    self:GetNaijiu_UILabel().gameObject:SetActive(false)
end
return BagMarryRingItemInfo_UIItem