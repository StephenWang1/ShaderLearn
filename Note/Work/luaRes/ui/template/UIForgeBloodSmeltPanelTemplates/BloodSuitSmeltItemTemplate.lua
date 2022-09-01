---@class BloodSuitSmeltItemTemplate:copytemplatebase 血继熔炼单个模板
local BloodSuitSmeltItemTemplate = {}

setmetatable(BloodSuitSmeltItemTemplate, luaComponentTemplates.copytemplatebase)

local CheckNullFunction = CS.StaticUtility.IsNull
local CSUtility_Lua = CS.Utility_Lua

--region初始化
---@param panel UIForgeBloodSmeltPanel
function BloodSuitSmeltItemTemplate:Init(panel)
    self.mRootPanel = panel
    self:InitComponent()
    self:BindEvent()
end

function BloodSuitSmeltItemTemplate:CacheItemInfo(itemId)
    return self.mRootPanel:CacheItemInfo(itemId)
end

function BloodSuitSmeltItemTemplate:NeedChooseItem()
    if self.mBagItemInfo and self.mRootPanel then

    end
end

function BloodSuitSmeltItemTemplate:InitComponent()
    ---@type UISprite
    ---icon
    self.mIcon_Sp = "icon"

    ---@type UnityEngine.GameObject
    ---选中
    self.mChooseGo = "check"

    ---@type
    self.bloodLevel = "BloodLv"

    self.mBloodEffect = "RecycleEffect"
end

---@return UILabel
function BloodSuitSmeltItemTemplate:GetBloodLevel_UILabel()
    if self.mBloodLevel == nil then
        local go = self:GetUIComponentController():GetCustomType(self.bloodLevel, "GameObject")
        if go then
            self.mBloodLevel = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
        end
    end
    return self.mBloodLevel
end

---@return UnityEngine.GameObject
function BloodSuitSmeltItemTemplate:GetBloodEffect_GameObject()
    if self.mBloodEffectGO == nil then
        self.mBloodEffectGO = self:GetUIComponentController():GetCustomType(self.mBloodEffect, "GameObject")
    end
    return self.mBloodEffectGO
end

function BloodSuitSmeltItemTemplate:BindEvent()
    CS.UIEventListener.Get(self.go).onClick = function(go)
        self:OnItemClicked(go)
    end
end

function BloodSuitSmeltItemTemplate:GetPrefabGO()
    if self.mPrefabGo == nil and self.mRootPanel then
        self.mPrefabGo = self.mRootPanel:GetCurComp("WidgetRoot/view/Cost/ScrollView/itemTemplate", "GameObject")
    end
    return self.mPrefabGo
end
--endregion

---@param bagItemInfo bagV2.BagItemInfo
function BloodSuitSmeltItemTemplate:RefreshItem(bagItemInfo)
    local data = self:CacheItemInfo(bagItemInfo.itemId)
    self.mBagItemInfo = bagItemInfo
    if data == nil then
        return
    end
    self:GetBloodEffect_GameObject():SetActive(false)
    self:SetItemChoose(self:GetItemChooseState(bagItemInfo.lid), false)
    self:GetUIComponentController():SetSpriteName(self.mIcon_Sp, data:GetIcon())
    local level = bagItemInfo.bloodLevel
    self:GetUIComponentController():SetObjectActive(self.bloodLevel, level > 0)
    if not CS.StaticUtility.IsNull(self:GetBloodLevel_UILabel()) then
        self:GetBloodLevel_UILabel().text = level
    end
    self:GetUIComponentController():Apply()
end

function BloodSuitSmeltItemTemplate:GetItemChooseState(lid)
    if self.mRootPanel then
        return self.mRootPanel:GetSmeltItemChooseState(lid)
    end
end

---设置道具选中
function BloodSuitSmeltItemTemplate:SetItemChoose(isChoose, needRefreh)
    self:GetUIComponentController():SetObjectActive(self.mChooseGo, isChoose)
    if needRefreh then
        self:GetUIComponentController():Apply()
    end
end

---点击道具
function BloodSuitSmeltItemTemplate:OnItemClicked(go)
    if self.mRootPanel then
        self.mRootPanel:OnSmeltItemClicked(go, self.mBagItemInfo)
    end
end

---设置熔炼特效
function BloodSuitSmeltItemTemplate:SetSmeltEffectChoose()
    if not CS.StaticUtility.IsNull(self:GetBloodEffect_GameObject()) then
        self:GetBloodEffect_GameObject():SetActive(true)
    end
end

return BloodSuitSmeltItemTemplate