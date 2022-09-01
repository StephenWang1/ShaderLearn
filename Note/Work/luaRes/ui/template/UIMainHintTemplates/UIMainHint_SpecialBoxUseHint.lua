---@class UIMainHint_SpecialBoxUseHint:UIBasicHint
local UIMainHint_SpecialBoxUseHint = {}

setmetatable(UIMainHint_SpecialBoxUseHint, luaComponentTemplates.UIBasicHint)

---主Icon
---@return UISprite
function UIMainHint_SpecialBoxUseHint:GetMainIcon_UISprite()
    if self.mMainIcon_Equip == nil then
        self.mMainIcon_Equip = self:Get("BetterBagItem/view/equip/icon", "UISprite")
    end
    return self.mMainIcon_Equip
end

---操作名
---@return UILabel
function UIMainHint_SpecialBoxUseHint:GetOperationName_UILabel()
    if self.mMainName_UILabel == nil then
        self.mMainName_UILabel = self:Get("BetterBagItem/view/mName", "UILabel")
    end
    return self.mMainName_UILabel
end

---目标名
---@return UILabel
function UIMainHint_SpecialBoxUseHint:GetTargetName_UILabel()
    if self.mSubName_UILabel == nil then
        self.mSubName_UILabel = self:Get("BetterBagItem/view/mName2", "UILabel")
    end
    return self.mSubName_UILabel
end

---强化等级文字
---@return UILabel
function UIMainHint_SpecialBoxUseHint:GetStrengthen_UILabel()
    if self.mStrength_UILabel == nil then
        self.mStrength_UILabel = self:Get("BetterBagItem/view/equip/strengthen", "UILabel")
    end
    return self.mStrength_UILabel
end

---数量文字
---@return UILabel
function UIMainHint_SpecialBoxUseHint:GetCount_UILabel()
    if self.mCount_UILabel == nil then
        self.mCount_UILabel = self:Get("BetterBagItem/view/equip/count", "UILabel")
    end
    return self.mCount_UILabel
end

---使用按钮文字
---@return UILabel
function UIMainHint_SpecialBoxUseHint:GetUseButtonLabel_UILabel()
    if self.mUseButtonLabel_UILabel == nil then
        self.mUseButtonLabel_UILabel = self:Get("BetterBagItem/event/btn_use/Label", "UILabel")
    end
    return self.mUseButtonLabel_UILabel
end

---是否有更好装备提示的游戏物体
---@return UnityEngine.GameObject
function UIMainHint_SpecialBoxUseHint:GetIsBetterEquipSign_GameObject()
    if self.mIsBetterEquipSign_GameObject == nil then
        self.mIsBetterEquipSign_GameObject = self:Get("BetterBagItem/view/equip/betterSign", "GameObject")
    end
    return self.mIsBetterEquipSign_GameObject
end

---关闭按钮
---@return UnityEngine.GameObject
function UIMainHint_SpecialBoxUseHint:GetCloseButtonGO()
    if self.mCloseButtonGO == nil then
        self.mCloseButtonGO = self:Get("BetterBagItem/event/btn_close", "GameObject")
    end
    return self.mCloseButtonGO
end

---使用按钮
---@return UnityEngine.GameObject
function UIMainHint_SpecialBoxUseHint:GetUseButtonGO()
    if self.mUseButtonGO == nil then
        self.mUseButtonGO = self:Get("BetterBagItem/event/btn_use", "GameObject")
    end
    return self.mUseButtonGO
end

---注册所有组件,包括Collider组件和TweenComponents组件,使用RegisterSingleCollider和RegisterSingleTweenComponent方法
---@protected
function UIMainHint_SpecialBoxUseHint:RegisterAllComponents()
    self:RegisterSingleTweenComponent("BetterBagItem")
    self:RegisterSingleCollider("BetterBagItem/event/btn_use")
    self:RegisterSingleCollider("BetterBagItem/event/btn_close")
    self:RegisterSingleCollider("BetterBagItem/bg")
end

---@param bagItemInfo bagV2.BagItemInfo
---@param count number 宝箱可用数量
function UIMainHint_SpecialBoxUseHint:RefreshData(bagItemInfo, count)
    if bagItemInfo == nil or bagItemInfo.ItemTABLE == nil then
        self:Close(false)
        return
    end
    self.mBagItemInfo = bagItemInfo
    ---@type CSBagInfoV2
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    --local count = bagInfo:GetItemCountByItemId(bagItemInfo.itemId)
    self:GetCount_UILabel().text = count < 2 and "" or tostring(count)
    self:GetMainIcon_UISprite().spriteName = bagItemInfo.ItemTABLE.icon
    self:GetStrengthen_UILabel().text = ""
    self:GetOperationName_UILabel().text = "[ffffff]可开启[-]"
    self:GetTargetName_UILabel().text = bagItemInfo.ItemTABLE.name
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
    self:GetUseButtonLabel_UILabel().text = "[ffcda5]立即开启[-]"
end

function UIMainHint_SpecialBoxUseHint:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGO()).onClick = function()
        self:Close(true)
    end
    CS.UIEventListener.Get(self:GetUseButtonGO().gameObject).onClick = function()
        uimanager:CreatePanel("UISpecialTreasureBagPanel", nil, { bagItemInfo = self.mBagItemInfo })
        self:Close(true)
    end
end

function UIMainHint_SpecialBoxUseHint:BindMessages()
    self:GetClientMessageHandlerManager():AddEvent(CS.CEvent.OpenPanel, function(msgID, panelName)
        ---打开宝箱界面后关闭推荐
        if self:GetIsOn() and panelName == "UISpecialTreasureBagPanel" then
            self:Close(true)
        end
    end)
end

function UIMainHint_SpecialBoxUseHint:SetIsOn(isOn)
    self:RunBaseFunction("SetIsOn", isOn)
    uiStaticParameter.mIsBigJuLingZhuTipExist = isOn
end

function UIMainHint_SpecialBoxUseHint:OnReshown()
    if self:GetIsOn() == false or CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    local specialBoxKeyInfos = Utility.GetSpecialBoxKeyInfos()
    ---@type CSBagInfoV2
    local mainPlayerBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    local quality = 0
    local recommendedBagItem = nil
    local boxCanUseCount = 0
    local mainPlayerLevel = CS.CSScene.MainPlayerInfo.Level
    local mainPlayerReinLevel = CS.CSScene.MainPlayerInfo.ReinLevel
    for i, v in pairs(specialBoxKeyInfos) do
        local boxItemID = i
        local keyItemID = v.keyId
        local keyItemUseMinCount = v.keyNum
        local boxItemCount = mainPlayerBagInfo:GetItemCountByItemId(boxItemID)
        local keyItemCount = mainPlayerBagInfo:GetItemCountByItemId(keyItemID)
        local maxUseCountPerDay = Utility.GetSpecialBoxUseCountLimitPerDay(boxItemID)
        local res, useNum = mainPlayerBagInfo.ItemUseTime:TryGetValue(boxItemID)
        if maxUseCountPerDay == 0 or useNum < maxUseCountPerDay then
            ---每日最大使用次数为0或者当前使用次数小于最大使用次数时才可以用宝箱
            if keyItemCount >= keyItemUseMinCount and boxItemCount > 0 then
                ---当前钥匙数量不小于最小钥匙使用数量时才可以使用宝箱
                ---@type TABLE.CFG_ITEMS
                local boxItemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(boxItemID)
                local keyItemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(keyItemID)
                if clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(boxItemTbl.id) == LuaEnumUseItemParam.CanUse
                        and clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(keyItemTbl.id) == LuaEnumUseItemParam.CanUse then
                    if quality == 0 or boxItemTbl.quality > quality then
                        quality = boxItemTbl.quality
                        recommendedBagItem = mainPlayerBagInfo:GetBagItemInfo(boxItemID)
                        boxCanUseCount = keyItemCount > boxItemCount and boxItemCount or keyItemCount
                    end
                end
            end
        end
    end
    if recommendedBagItem == nil then
        return false
    end
    return true
end

return UIMainHint_SpecialBoxUseHint