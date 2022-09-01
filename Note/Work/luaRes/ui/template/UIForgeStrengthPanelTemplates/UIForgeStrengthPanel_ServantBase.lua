---@class UIForgeStrengthPanel_ServantBase:UIServantPanel_Base 升星灵兽装备模板
local UIForgeStrengthPanel_ServantBase = {}

setmetatable(UIForgeStrengthPanel_ServantBase, luaComponentTemplates.UIServantPanel_Base)

UIForgeStrengthPanel_ServantBase.mCurrentChooseId = nil

UIForgeStrengthPanel_ServantBase.CurrentChooseGridTemp = nil

function UIForgeStrengthPanel_ServantBase:ChooseBagItemInfo(lid)
    local go = self.mLidToGrid[lid]
    if go then
        self:OnClickEquip(go)
    end
end

function UIForgeStrengthPanel_ServantBase:Init(panel)
    self:RunBaseFunction("Init", panel)
    ---锻造道具改变事件
    ---@type function
    self.OnStrengthenBagItemChange = function(msgId, bagItemInfo)
        self:OnStrengthenBagItemChangeFun(msgId, bagItemInfo)
    end
    self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.StrengthenBagItemChange, self.OnStrengthenBagItemChange)
end

--[[function UIForgeStrengthPanel_ServantBase:OnEnable()
    self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.StrengthenBagItemChange, self.OnStrengthenBagItemChange)
end

function UIForgeStrengthPanel_ServantBase:OnDisable()
    self.ServantPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.StrengthenBagItemChange, self.OnStrengthenBagItemChange)
end]]

function UIForgeStrengthPanel_ServantBase:OnStrengthenBagItemChangeFun(msgId, bagItemInfo)
    local lid = bagItemInfo.lid
    if lid and lid ~= self.mCurrentChooseId then
        if self.mCurrentChooseId then
            self.mLidToChoose[self.mCurrentChooseId] = false
        end
        if self.CurrentChooseGridTemp then
            self:ShowChooseEffect(self.CurrentChooseGridTemp, false)
        elseif self.mCurrentChooseId then
            local go = self.mLidToGrid[self.mCurrentChooseId]
            self:ShowChooseEffect(go, false)
        end

        local go = self.mLidToGrid[lid]
        if go then
            self:ShowChooseEffect(go, true)
        else
            self.mCurCliekGridInfo = nil
        end

        self.mCurrentChooseId = bagItemInfo.lid
        self.mLidToChoose[lid] = true
        self.CurrentChooseGridTemp = go
    end
end

---重写以隐藏按钮
function UIForgeStrengthPanel_ServantBase:InitInfo()
    self:GetAllBtn_GameObject():SetActive(false)
    self:GetEquipHelp_GameObject():SetActive(false)
end

---重写隐藏肉身
function UIForgeStrengthPanel_ServantBase:IsShowBodyEquip()
    return false
end

---重写隐藏法宝
function UIForgeStrengthPanel_ServantBase:IsShowServantMagicWeapon()
    return false
end

---重写是否显示箭头
---@return boolean
function UIForgeStrengthPanel_ServantBase:IsShowArrow()
    return false
end

---重写是否再次点击装备时显示装备tips
---@return boolean
function UIForgeStrengthPanel_ServantBase:IsDoubleClickGridToShowTips()
    return true
end

return UIForgeStrengthPanel_ServantBase