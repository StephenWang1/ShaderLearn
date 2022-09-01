---勋章信息界面UIItem 物品信息界面信息
---@class UIItemInfoPanel_Info_Medal:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_Info_Medal = {}

setmetatable(UIItemInfoPanel_Info_Medal, luaComponentTemplates.UIItemInfoPanel_Info_UIItem)

function UIItemInfoPanel_Info_Medal:GetMedalMaxDurable()
    if self.MedalMaxDurable == nil then
        self.MedalMaxDurable = CS.Cfg_GlobalTableManager.Instance:GetMedalMaxDurable()
    end
    if self.MedalMaxDurable == nil then
        return 0
    end
    return self.MedalMaxDurable
end

function UIItemInfoPanel_Info_Medal:GetUIItem_UIItemInfoPanel()
    if (self.mUIItem_UIItemInfoPanel == nil) then
        self.mUIItem_UIItemInfoPanel = templatemanager.GetNewTemplate(self:GetUIItemRoot_GameObject(), luaComponentTemplates.UIItem_UIItemInfoPanel_Medal)
    end
    return self.mUIItem_UIItemInfoPanel;
end

---刷新排行
--function UIItemInfoPanel_Info_Medal:RefreshRank()
--    self:GetItemRank_UILabel().gameObject:SetActive(false)
--end

---刷新重量
function UIItemInfoPanel_Info_Medal:RefreshWeight()
    self:GetWeight_UILabel().gameObject:SetActive(false)
end

---刷新持久
function UIItemInfoPanel_Info_Medal:RefreshLasting()
    local itemInfo = self.ItemInfo
    local bagItemInfo = self.BagItemInfo
    if bagItemInfo and itemInfo and self.ismainPlayer then
        --if itemInfo.subType == LuaEnumEquiptype.Medal then
        --    if bagItemInfo.inlayInfoList ~= nil or bagItemInfo.inlayInfoList.Count ~= 0 then
        --        self:GetNaijiu_UILabel().text = ''
        --        return
        --    end
        --end

        local itemInfoNaiJiu = bagItemInfo.currentLasting
        local durableValue = ''
        if (itemInfo.isWastageLasting > -1) then
            local currentLastingMaxValue = CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax()
            durableValue = Utility.NewGetBBCode(bagItemInfo.currentLasting > currentLastingMaxValue) .. tostring(bagItemInfo.currentLasting) .. " / " .. tostring(itemInfo.maxLasting) .. "[-]"
        else
            durableValue = tostring(bagItemInfo.currentLasting) .. " / --"
        end
        local naijiuState = ternary(itemInfo.isWastageLasting < 0, false, true)
        self:GetNaijiu_UILabel().gameObject:SetActive(naijiuState)
        local str = (itemInfo.subType == LuaEnumEquiptype.Medal or itemInfo.subType == LuaEnumEquiptype.DoubleMedal) and bagItemInfo.currentLasting > self:GetMedalMaxDurable() and '' or '' .. '[-]'
        self:GetNaijiu_UILabel().text = "持久  " .. durableValue .. luaEnumColorType.Red .. str
    else
        self:GetNaijiu_UILabel().gameObject:SetActive(false)
    end
end

return UIItemInfoPanel_Info_Medal