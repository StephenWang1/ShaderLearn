---灵兽装备上部分显示
---@class UIItemInfoPanel_ServantEquip_UIItem:UIItemInfoPanel_Info_UIItem
local UIItemInfoPanel_ServantEquip_UIItem = {}

setmetatable(UIItemInfoPanel_ServantEquip_UIItem, luaComponentTemplates.UIItemInfoPanel_Info_UIItem)

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_ServantEquip_UIItem:RefreshWithInfo(commonData)
    ---@type bagV2.BagItemInfo 背包信息
    self.BagItemInfo = commonData.bagItemInfo
    ---@type TABLE.CFG_ITEMS 物品信息
    self.ItemInfo = commonData.itemInfo
    self.showBind = commonData.showBind
    self.IsNeedShowBind = false
    if self.BagItemInfo ~= nil then
        self.IsNeedShowBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.BagItemInfo)
    elseif self.ItemInfo ~= nil then
        self.IsNeedShowBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.ItemInfo)
    end
    self:RefreshWearState()
    self:RefreshUIItem()
    self:RefreshWeight()
    self:RefreshLasting()
    self:RefreshStrengthenInfo()
    self:RefreshFrame()
    self:RefreshBind()
end

function UIItemInfoPanel_ServantEquip_UIItem:RefreshLasting()
    if CS.StaticUtility.IsNull(self:GetNaijiu_UILabel()) == false then
        ---灵兽法宝
        if self.ItemInfo ~= nil and CS.CSServantInfoV2.IsServantMagicWeapon(self.ItemInfo.subType) == true then
            local showItemLevel = self.ItemInfo.itemLevel ~= nil and type(self.ItemInfo.itemLevel) == 'number' and self.ItemInfo.itemLevel > 0
            self:GetNaijiu_UILabel().gameObject:SetActive(showItemLevel)
            if showItemLevel then
                self:GetNaijiu_UILabel().text = string.format("品级 %s阶", self.ItemInfo.itemLevel)
            end
            return
        end
        if self.BagItemInfo and self.ItemInfo and self.BagItemInfo.isWastageLasting ~= -1 then
            self:GetNaijiu_UILabel().gameObject:SetActive(true)
            local itemInfoNaiJiu = self.BagItemInfo.currentLasting
            local NaiJiuValue = ""
            if itemInfoNaiJiu >= -10 then
                if (self.ItemInfo.maxLasting > 0) then
                    local currentLastingMaxValue = CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax()
                    NaiJiuValue = Utility.NewGetBBCode(self.BagItemInfo.currentLasting > currentLastingMaxValue) .. tostring(self.BagItemInfo.currentLasting) .. " [-]/ " .. tostring(self.ItemInfo.maxLasting)
                else
                    NaiJiuValue = tostring(self.BagItemInfo.currentLasting) .. " / --"
                end
            else
                NaiJiuValue = "永不损坏"
            end
            local naijiuState = ternary(self.ItemInfo.isWastageLasting < 0, false, true)
            self:GetNaijiu_UILabel().gameObject:SetActive(naijiuState)
            self:GetNaijiu_UILabel().text = "持久  " .. NaiJiuValue
        else
            self:GetNaijiu_UILabel().gameObject:SetActive(false)
        end
    end
end

function UIItemInfoPanel_ServantEquip_UIItem:RefreshWeight()
    if self:GetWeight_UILabel() then
        local type = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetItemType(self.ItemInfo.subType)
        if type ~= "" then
            self:GetWeight_UILabel().gameObject:SetActive(true)
            local textContent = "类型 " .. type
            ---血继套装类型
            local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.ItemInfo.id)
            if bloodsuitTbl then
                textContent = textContent .. "  " .. bloodsuitTbl:GetQualityName()
            end
            self:GetWeight_UILabel().text = textContent
        else
            self:GetWeight_UILabel().gameObject:SetActive(false)
        end
    end
end

function UIItemInfoPanel_ServantEquip_UIItem:RefreshWearState()
    local state = false
    if self:GetWearState_GameObject() and CS.StaticUtility.IsNull(self:GetWearState_GameObject()) == false and self.BagItemInfo and self.ItemInfo then
        state = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsEquippedByAnyServant(self.BagItemInfo.lid)
    end
    self.isEquip = state
    self:GetWearState_GameObject():SetActive(state)
end

---刷新绑定
function UIItemInfoPanel_ServantEquip_UIItem:RefreshBind()
    if self:GetBind_TweenPosition() == nil then
        return
    end
    if self.showBind == nil or self.showBind == false then
        self:GetBind_TweenPosition().gameObject:SetActive(false)
        return
    end
    if self.ItemInfo ~= nil then
        if self.isEquip == true then
            self:GetBind_TweenPosition():PlayForward()
        else
            self:GetBind_TweenPosition():PlayReverse()
        end
        self:GetBind_TweenPosition().gameObject:SetActive(self.IsNeedShowBind)
    end
end

return UIItemInfoPanel_ServantEquip_UIItem