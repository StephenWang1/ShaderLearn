---@class UIBagPanel_GridTemplateBase:copytemplatebase 交易行背包格子基础模板
local UIBagPanel_GridTemplateBase = {}
setmetatable(UIBagPanel_GridTemplateBase, luaComponentTemplates.copytemplatebase)

--region 组件

---@return UnityEngine.GameObject 星级
function UIBagPanel_GridTemplateBase:GetStrengthen_Go()
    if self.mStrengthGo == nil then
        self.mStrengthGo = self:GetUIComponentController():GetCustomType(self.Strengthen_UILabel, "GameObject")
    end
    return self.mStrengthGo
end

---@return UnityEngine.GameObject 星级背景
function UIBagPanel_GridTemplateBase:GetStrengthenBG_Go()
    if self.mStrengthenBG_GameObject == nil and self:GetStrengthen_Go() then
        self.mStrengthenBG_GameObject = CS.Utility_Lua.Get(self:GetStrengthen_Go().transform, "Sprite", "GameObject")
    end
    return self.mStrengthenBG_GameObject
end

---@return UnityEngine.BoxCollider 交互的碰撞盒
function UIBagPanel_GridTemplateBase:GetBoxCollider()
    if self.mBoxCollider == nil then
        self.mBoxCollider = self:GetUIComponentController():GetCustomType("", "BoxCollider")
    end
    return self.mBoxCollider
end

--endregion

function UIBagPanel_GridTemplateBase:GetPrefabGO()
    if self.mPrefabGo == nil and self.mRootPanel then
        self.mPrefabGo = self.mRootPanel:Get("ScrollView/bagController/itemTemplate1", "GameObject")
    end
    return self.mPrefabGo
end

---@param panel UIAuctionPanel_BagPanel
function UIBagPanel_GridTemplateBase:Init(panel)
    self.mRootPanel = panel
    -- self:InitComponents()
    self:AddPath()
    self:InitParameters()
end

function UIBagPanel_GridTemplateBase:AddPath()
    ---Icon
    self.ItemIcon_UISprite = "icon"
    ---道具数量
    self.ItemCount_UILabel = "count"
    ---锁
    self.ItemLock_UISprite = "lock"
    ---绿色箭头
    self.GoodSprite_GameObject = "good"
    self.Frame_UISprite = "quality"
    ---强化
    self.Strengthen_UILabel = "strengthen"
    self.Star_SP = "star"
    self.RedPoint_UISprite = "redpoint"
    self.Check_GameObject = "check"
    ---特效节点
    self.effect_GameObject = "effect"
    ---血继标识
    self.BloodSuitSign = "BloodLv"
    ---血继标识文本
    self.BloodSuitLabel = "BloodLvLabel"
end

function UIBagPanel_GridTemplateBase:InitParameters()
    ---背包物品信息,bagV2.BagItemInfo类型
    ---@type bagV2.BagItemInfo
    self.BagItemInfo = nil
    ---物品信息,TABLE.CFG_ITEMS类型
    ---@type TABLE.CFG_ITEMS
    self.ItemInfo = nil
end

---刷新
function UIBagPanel_GridTemplateBase:RefreshUI(bagItemInfo)
    self.BagItemInfo = bagItemInfo
    if bagItemInfo then
        local res
        res, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
        if res then
            self:RefreshIcon()
            self:RefreshCount()

            self:SetLasting()
            self.isShowGoodSprite = false
            self:ShowGoodSprite()
            --self:ShowRedPoint()
        end
    end
    self:RefreshStrengthenInfo()
    self:RefreshFrame()
    self:ShowNeedObj()
    self:HideCheckObj()
    self:GetUIComponentController():Apply()
end

---刷新物品Icon
function UIBagPanel_GridTemplateBase:RefreshIcon()
    self:GetUIComponentController():SetObjectActive(self.ItemIcon_UISprite, true)
    local sp = ""
    if self.ItemInfo.reuseType and self.ItemInfo.reuseType.list and self.ItemInfo.reuseType.list.Count >= 2
            and self.BagItemInfo.leftUseNum and self.BagItemInfo.leftUseNum == 1 then
        sp = tostring(self.ItemInfo.reuseType.list[1])
    else
        sp = self.ItemInfo.icon
    end
    self:GetUIComponentController():SetSpriteName(self.ItemIcon_UISprite, sp)

    if self.ItemInfo and self.BagItemInfo then
        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.ItemInfo.id)
        if bloodsuitTbl and self.BagItemInfo.bloodLevel > 0 then
            self:GetUIComponentController():SetObjectActive(self.BloodSuitSign, true)
            self:GetUIComponentController():SetObjectActive(self.BloodSuitLabel, true)
            self:GetUIComponentController():SetLabelContent(self.BloodSuitLabel, tostring(self.BagItemInfo.bloodLevel))
        else
            self:GetUIComponentController():SetObjectActive(self.BloodSuitSign, false)
            self:GetUIComponentController():SetObjectActive(self.BloodSuitLabel, false)
        end
    else
        self:GetUIComponentController():SetObjectActive(self.BloodSuitSign, false)
        self:GetUIComponentController():SetObjectActive(self.BloodSuitLabel, false)
    end
end

---刷新物品数量
function UIBagPanel_GridTemplateBase:RefreshCount()
    local showInfo = ""
    if self.ItemInfo.reuseType ~= nil and self.ItemInfo.reuseType.list and self.ItemInfo.reuseType.list[0] == LuaEnumItemUseNumType.ShowUIBagPanel and self.BagItemInfo.leftUseNum and self.BagItemInfo.leftUseNum > 1 then
        showInfo = self.BagItemInfo.leftUseNum
    elseif self.ItemInfo.overlying ~= nil and self.ItemInfo.overlying ~= 1 and self.BagItemInfo.count > 1 then
        showInfo = self.BagItemInfo.count
    end
    self:GetUIComponentController():SetLabelContent(self.ItemCount_UILabel, showInfo)
end

---刷新强化显示
function UIBagPanel_GridTemplateBase:RefreshStrengthenInfo()
    local isShow = self.BagItemInfo and self.BagItemInfo.intensify and self.BagItemInfo.intensify > 0
    if isShow then
        local showInfo, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
        self:GetUIComponentController():SetLabelContent(self.Strengthen_UILabel, showInfo)
        self:GetUIComponentController():SetSpriteName(self.Star_SP, icon)
    end
    self:RefreshStrengthItemShow(isShow)
end

---刷新星级显示
function UIBagPanel_GridTemplateBase:RefreshStrengthItemShow(isShow)
    self:GetUIComponentController():SetObjectActive(self.Star_SP, isShow)
    self:GetStrengthenBG_Go():SetActive(isShow)
    self:GetUIComponentController():SetObjectActive(self.Strengthen_UILabel, isShow)
end

---置空
function UIBagPanel_GridTemplateBase:ResetUI()
    self.BagItemInfo = nil
    self.ItemInfo = nil
    self:GetUIComponentController():SetObjectActive(self.ItemIcon_UISprite, false)
    self:GetUIComponentController():SetLabelContent(self.ItemCount_UILabel, "")
    self:GetUIComponentController():SetObjectActive(self.GoodSprite_GameObject, false)
    self:GetUIComponentController():SetObjectActive(self.ItemLock_UISprite.gameObject, false)
    self:GetUIComponentController():SetObjectActive(self.BloodSuitSign, false)
    self:GetUIComponentController():SetObjectActive(self.BloodSuitLabel, false)
    self:RefreshStrengthItemShow(false)
    self:RefreshStrengthenInfo()
    self:HideNeedlessObj()
    self:HideCheckObj()
    self:RefreshFrame()
    self:SetItemChoose(false)
    self:GetUIComponentController():Apply()
end

---显示加锁
function UIBagPanel_GridTemplateBase:ShowLock()
    self:ResetUI()
    self:GetUIComponentController():SetObjectActive(self.ItemLock_UISprite, true)
end

--region 可以重写的方法
---隐藏不需要的显示（重写隐藏不需要道具）
function UIBagPanel_GridTemplateBase:HideNeedlessObj()
end

---显示自己需要的显示(重写需要显示)
function UIBagPanel_GridTemplateBase:ShowNeedObj()
end

function UIBagPanel_GridTemplateBase:HideCheckObj(isShow)
    self:GetUIComponentController():SetObjectActive(self.Check_GameObject, isShow)
end

---设置耐久值
function UIBagPanel_GridTemplateBase:SetLasting()
    local limitingValue = tonumber(CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax())
    if self.ItemInfo.type == luaEnumItemType.Equip and self.BagItemInfo.currentLasting >= 0 and self.BagItemInfo.currentLasting <= limitingValue then
        self:GetUIComponentController():SetSpriteRGBA(self.ItemIcon_UISprite, 232, 80, 56, 255)
    else
        self:GetUIComponentController():SetSpriteColor(self.ItemIcon_UISprite, CS.UnityEngine.Color.white)
    end
end

---显示更好箭头
function UIBagPanel_GridTemplateBase:ShowGoodSprite()
    if self.BagItemInfo and self.ItemInfo then
        self.arrowType = Utility.GetArrowType(self.BagItemInfo)
    end
    if self.arrowType ~= LuaEnumArrowType.NONE then
        local sp = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(self.arrowType)
        self:GetUIComponentController():SetObjectActive(self.GoodSprite_GameObject, true)
        self:GetUIComponentController():SetSpriteName(self.GoodSprite_GameObject, sp)
    else
        self:GetUIComponentController():SetObjectActive(self.GoodSprite_GameObject, false)
    end
end

---显示小红点
function UIBagPanel_GridTemplateBase:ShowRedPoint()
    local isShow = false
    if self.ItemInfo.bagSign > 0 then
        if self.ItemInfo.type == luaEnumItemType.SkillBook then
            isShow = CS.CSScene.MainPlayerInfo.SkillInfoV2:CheckSKillHaveRedPoint(self.ItemInfo)
        else
            isShow = true
        end
    else
        isShow = CS.Utility_Lua.IsBagItemCanShowRedPoint(self.ItemInfo)
    end
    self:GetUIComponentController():SetObjectActive(self.RedPoint_UISprite, isShow)
end

---设置选中（重写设置选中）
function UIBagPanel_GridTemplateBase:SetItemChoose(isChoose)
    self:GetUIComponentController():SetObjectActiveImmediately(self.effect_GameObject, isChoose)
end

---刷新品质
function UIBagPanel_GridTemplateBase:RefreshFrame()
    self:GetUIComponentController():SetObjectActive(self.Frame_UISprite, self.ItemInfo ~= nil)
    local sp = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipFrameIcon(self.ItemInfo)
    self:GetUIComponentController():SetSpriteName(self.Frame_UISprite, sp)
end
--endregion

---隐藏Icon和显示(用于拖拽时候)
function UIBagPanel_GridTemplateBase:ShowIcon(isShow)
    self:GetUIComponentController():SetObjectActive(self.ItemIcon_UISprite, isShow)
    self:GetUIComponentController():SetObjectActive(self.ItemCount_UILabel, isShow)
    self:GetUIComponentController():SetObjectActive(self.GoodSprite_GameObject, isShow)
    self:GetUIComponentController():SetObjectActive(self.Frame_UISprite, isShow)
    self:GetUIComponentController():SetObjectActive(self.Strengthen_UILabel, isShow)
end

function UIBagPanel_GridTemplateBase:SetBoxColliderEnabled(isEnabled)
    if not CS.StaticUtility.IsNull(self:GetBoxCollider()) then
        self:GetBoxCollider().enabled = isEnabled
    end
end

return UIBagPanel_GridTemplateBase