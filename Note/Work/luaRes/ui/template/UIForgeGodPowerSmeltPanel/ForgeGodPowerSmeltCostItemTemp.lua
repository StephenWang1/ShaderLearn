---神力界面花费道具模板
---@class ForgeGodPowerSmeltCostItemTemp
local ForgeGodPowerSmeltCostItemTemp = {}

---得到材料花费的根节点
function ForgeGodPowerSmeltCostItemTemp:GetIcon()
    if self.mGetIcon == nil then
        self.mGetIcon = self:Get("icon", "Top_UISprite")
    end
    return self.mGetIcon
end

---得到材料花费的根节点
function ForgeGodPowerSmeltCostItemTemp:GetCheck()
    if self.mGetCheck == nil then
        self.mGetCheck = self:Get("check", "GameObject")
    end
    return self.mGetCheck
end

---得到目标材料显示的Item的特效
function ForgeGodPowerSmeltCostItemTemp:GetEffect()
    if self.mGetEffect == nil then
        self.mGetEffect = self:Get("icon", "CSUIEffectLoad")
    end
    return self.mGetEffect
end


---@type UIForgeGodPowerSmeltPanel
ForgeGodPowerSmeltCostItemTemp.UIForgeGodPowerSmeltPanel = nil

---@type bagV2.BagItemInfo
ForgeGodPowerSmeltCostItemTemp.BagItemInfo = nil

---是否被选择,在确认消耗的时候,会去判定这个值,如果为true,那么会加入消耗列表中
---@type boolean
ForgeGodPowerSmeltCostItemTemp.IsBeSelect = nil

---@type UIForgeGodPowerSmeltPanel 把母面板传入
function ForgeGodPowerSmeltCostItemTemp:Init(UIForgeGodPowerSmeltPanel)
    self.UIForgeGodPowerSmeltPanel = UIForgeGodPowerSmeltPanel
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnClickItem()
    end
end

---更新道具
---@param bagItemInfo bagV2.BagItemInfo
function ForgeGodPowerSmeltCostItemTemp:UpdateItem(bagItemInfo)
    self.BagItemInfo = bagItemInfo
    self.IsBeSelect = false
    self:GetIcon().spriteName = Utility.GetItemTblByBagItemInfo(bagItemInfo):GetIcon()

    --local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    -----@type TABLE.cfg_divinesuit
    --local divinesuit = Utility.GetDivineSuitTblByBagItemID(itemTbl:GetId())
    --
    --local textureName = Utility.GetSLEquipIndexEffectID(divinesuit:GetType(), itemTbl:GetSubType())
    ----local textureName = "23042001"
    --local key = tostring(divinesuit:GetType()).."_"..tostring(itemTbl:GetSubType()).."_"..tostring(divinesuit:GetLevel()).."_"..tostring(textureName)
    --if(key == self.LastEffectKey) then
    --    return
    --end
    --self.LastEffectKey = key
    --self:GetEffect():DestroyEffect()
    --self:GetEffect().effectId = "700278"
    --self:GetEffect():LoadEffect(function (obj)
    --    obj:SetActive(false)
    --    Utility.LoadSLMaterial(obj, divinesuit:GetType(), itemTbl:GetId(), divinesuit:GetLevel(), textureName)
    --end)
end

---是否被选择
function ForgeGodPowerSmeltCostItemTemp:Select(isSelect)
    self.IsBeSelect = isSelect
    self:UpdateSelectSign(self.IsBeSelect);
    if(isSelect) then
        self.UIForgeGodPowerSmeltPanel:OnClickCostItemTempOnUpdateLevel(self.IsBeSelect, self.BagItemInfo)
    end
end

function ForgeGodPowerSmeltCostItemTemp:OnClickItem()
    self.IsBeSelect = not self.IsBeSelect
    self:UpdateSelectSign(self.IsBeSelect);
    self.UIForgeGodPowerSmeltPanel:OnClickCostItemTempOnUpdateLevel(self.IsBeSelect, self.BagItemInfo)
end

function ForgeGodPowerSmeltCostItemTemp:UpdateSelectSign(select)
    self:GetCheck():SetActive(select)
end

function ForgeGodPowerSmeltCostItemTemp:Reset()
    self.IsBeSelect = nil
end



return ForgeGodPowerSmeltCostItemTemp