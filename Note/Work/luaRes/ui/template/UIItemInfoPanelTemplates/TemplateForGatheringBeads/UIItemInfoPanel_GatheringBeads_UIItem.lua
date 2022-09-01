---聚灵珠上部分刷新信息
---@class UIItemInfoPanel_GatheringBeads_UIItem:UIItemInfoPanel_Info_UIItem
local UIItemInfoPanel_GatheringBeads_UIItem = {}
setmetatable(UIItemInfoPanel_GatheringBeads_UIItem, luaComponentTemplates.UIItemInfoPanel_Info_UIItem)

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_GatheringBeads_UIItem:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    local gatheringInfo = commonData.gatheringInfo
    if bagItemInfo then
        self.BagItemInfo = bagItemInfo
        if itemInfo == nil then
            ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            itemInfo = self.ItemInfo
        end
    end
    self.GatheringInfo = gatheringInfo
    self:RefreshWearState()
    self:RefreshItem()
    self:RefreshCDTime()
    self:RefreshShowButton()
    self:RefreshStrengthenInfo()
    self:RefreshLasting()
    self:RefreshWeakenWarning()
end

---刷新CD时间(该位置还有属性,如聚灵珠的经验值)
---CD时间及其他(聚灵珠重写)
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS 背包物品表信息
function UIItemInfoPanel_GatheringBeads_UIItem:RefreshCDTime()
    if CS.StaticUtility.IsNull(self:GetCDTimeLabel_UILabel()) == false then
        local str = ""
        local color = luaEnumColorType.Gray
        if self.BagItemInfo then
            color = ternary(self.BagItemInfo.luck < self.BagItemInfo.maxStar, luaEnumColorType.Gray, luaEnumColorType.BluePurple)
            str = color .. "存储经验 : " .. tostring(self.BagItemInfo.luck) .. "/" .. tostring(self.BagItemInfo.maxStar) .. "[-]"
        else
            if self.ItemInfo and self.GatheringInfo then
                str = color .. "存储经验 : 0/" .. tostring(self.ItemInfo.useParam.list[1]) .. "[-]"
            end
        end
        local useInfo = ""
        if self.GatheringInfo and self.GatheringInfo.totalCount ~= 0 then
            useInfo = color .. "每日可使用次数:" .. self.GatheringInfo.useCount .. "/" .. self.GatheringInfo.totalCount
        end
        self:GetCDTimeLabel_UILabel().gameObject:SetActive(self.BagItemInfo)
        self:GetCDTimeLabel_UILabel().text = str .. "\n" .. useInfo
    end
end

function UIItemInfoPanel_GatheringBeads_UIItem:RefreshLasting()
    self:GetNaijiu_UILabel().text = ""
end

return UIItemInfoPanel_GatheringBeads_UIItem