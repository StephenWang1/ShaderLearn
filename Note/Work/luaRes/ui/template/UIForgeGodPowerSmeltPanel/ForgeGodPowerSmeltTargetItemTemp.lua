---神力界面的目标模板
---@class ForgeGodPowerSmeltTargetItemTemp
local ForgeGodPowerSmeltTargetItemTemp = {}

---@type TABLE.cfg_items
ForgeGodPowerSmeltTargetItemTemp.ItemTable = nil

function ForgeGodPowerSmeltTargetItemTemp:Init()
    CS.UIEventListener.Get(self.go).onClick = function()
        if(self.ItemTable ~= nil) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(self.ItemTable:GetId()), showRight = false })
        end
    end
end

---得到目标材料显示的Item的根节点
function ForgeGodPowerSmeltTargetItemTemp:GetIcon()
    if self.mGetIcon == nil then
        self.mGetIcon = self:Get("icon", "Top_UISprite")
    end
    return self.mGetIcon
end

---得到目标材料显示的Item的特效
function ForgeGodPowerSmeltTargetItemTemp:GetEffect()
    if self.mGetEffect == nil then
        self.mGetEffect = self:Get("icon", "CSUIEffectLoad")
    end
    return self.mGetEffect
end

---@param itemTbl TABLE.cfg_items
function ForgeGodPowerSmeltTargetItemTemp:UpdateData(itemTbl)
    self.ItemTable = itemTbl
    if(itemTbl==nil) then
        self:Reset()
        return;
    end
    self:GetIcon().gameObject:SetActive(true)
    self:GetIcon().spriteName = itemTbl:GetIcon()

    ---@type TABLE.cfg_divinesuit
    local divinesuit = Utility.GetDivineSuitTblByBagItemID(itemTbl:GetId())

    local textureName = Utility.GetSLEquipIndexEffectID(divinesuit:GetType(), itemTbl:GetSubType())
    --local textureName = "23042001"
    local key = tostring(divinesuit:GetType()).."_"..tostring(itemTbl:GetSubType()).."_"..tostring(divinesuit:GetLevel()).."_"..tostring(textureName)
    if(key == self.LastEffectKey) then
        return
    end
    self.LastEffectKey = key
    self:GetEffect():DestroyEffect()
    self:GetEffect().effectId = "700278"
    self:GetEffect():LoadEffect(function (obj)
        obj:SetActive(false)
        Utility.LoadSLMaterial(obj, divinesuit:GetType(), itemTbl:GetId(), divinesuit:GetLevel(), textureName)
    end)
end

function ForgeGodPowerSmeltTargetItemTemp:Reset()
    self.LastEffectKey = nil
    self:GetEffect():DestroyEffect()
    self:GetIcon().gameObject:SetActive(false)
end

function ForgeGodPowerSmeltTargetItemTemp:Reset()
    self:GetIcon().gameObject:SetActive(false)
end

return ForgeGodPowerSmeltTargetItemTemp