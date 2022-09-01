local RoleMarryRingItemInfo_UIItem = {}
setmetatable(RoleMarryRingItemInfo_UIItem,luaComponentTemplates.UIItemInfoPanel_Info_UIItem)



--region 引用
function RoleMarryRingItemInfo_UIItem:GetPlayerMarryInfo()
    if self.PlayerMarryInfo == nil then
        self.PlayerMarryInfo = CS.CSScene.MainPlayerInfo.MarryInfo:GetPlayerMarryInfo()
    end
    return self.PlayerMarryInfo
end

function RoleMarryRingItemInfo_UIItem:GetGlobalTableManager()
    if self.GlobalTableManager == nil then
        self.GlobalTableManager = CS.Cfg_GlobalTableManager.Instance
    end
    return self.GlobalTableManager
end
--endregion

---刷新绑定数据
function RoleMarryRingItemInfo_UIItem:RefreshBindInfo()
end


---刷新icon
function RoleMarryRingItemInfo_UIItem:RefreshUIItem()
    if self:GetUIItemRoot_GameObject() and CS.StaticUtility.IsNull(self:GetUIItemRoot_GameObject()) == false then
        local itemInfo = self.ItemInfo
        self:GetUIItem_UIItemInfoPanel():RefreshUIWithItemInfo(itemInfo)
    end
end

---刷新强化等级
function RoleMarryRingItemInfo_UIItem:RefreshStrengthenInfo()
    if CS.StaticUtility.IsNull(self:GetintensifyNum_UILabel()) == false then
        self:GetintensifyNum_UILabel().gameObject:SetActive(false)
    end
end

---第一行信息
function RoleMarryRingItemInfo_UIItem:RefreshWeight()
    if self.BagItemInfo == nil then
        return
    end
    self.PlayerMarryInfo = nil
    self:GetWeight_UILabel().text =  self:GetGlobalTableManager():GetBagMarryRingMarryingTimeText(self.BagItemInfo.marryTime)
end

---第二行信息
function RoleMarryRingItemInfo_UIItem:RefreshLasting()
    if self.BagItemInfo == nil then
        return
    end
    self:GetNaijiu_UILabel().text = self:GetGlobalTableManager():GetBagMarryRingRankText(self.BagItemInfo.serverId,self.BagItemInfo.number)
end

---装备标识
function RoleMarryRingItemInfo_UIItem:RefreshWearState()
    self:GetWearState_GameObject():SetActive(false)
end

---刷新效果削减文本
function RoleMarryRingItemInfo_UIItem:RefreshWeakenWarning()

end

---刷新可交易状态
function RoleMarryRingItemInfo_UIItem:RefreshTrade()

end


return RoleMarryRingItemInfo_UIItem