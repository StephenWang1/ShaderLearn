local UIRolePanel_GridTemplatesElement = {}
setmetatable(UIRolePanel_GridTemplatesElement, luaComponentTemplates.UIRolePanel_GridTemplateBase)

function UIRolePanel_GridTemplatesElement:RedPoint()
    if self.red == nil then
        self.red = self:Get('background/Red', 'Top_UIRedPoint')
    end
    return self.red
end

function UIRolePanel_GridTemplatesElement:GetElementInfo()
    if self.elementInfo == nil then
        self.elementInfo = CS.CSScene.MainPlayerInfo.ElementInfo
    end
    return self.elementInfo
end

function UIRolePanel_GridTemplatesElement:Init()
    self:RunBaseFunction("Init")
    --self:BindEvent()
end

function UIRolePanel_GridTemplatesElement:OnEnable()
    self:BindEvent()
end

function UIRolePanel_GridTemplatesElement:OnDisable()
    self:ReleaseEvent()
end

function UIRolePanel_GridTemplatesElement:BindEvent()
    self.mClientMsgHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    self.mClientMsgHandler:AddEvent(CS.CEvent.V2_EquipIndexAddElement, function(id, index)
        self:RefreshElementEffect(index)
    end)
end

function UIRolePanel_GridTemplatesElement:ReleaseEvent()
    if self.mClientMsgHandler ~= nil then
        self.mClientMsgHandler:UnRegAll(true)
        self.mClientMsgHandler = nil
    end
end

--region 刷新格子
function UIRolePanel_GridTemplatesElement:ShowEquip(bagItemInfo, equipIndex)
    self.bagItemInfo = bagItemInfo
    self.equipIndex = equipIndex
    self.ItemInfo = nil
    self:RefreshGrid(bagItemInfo)
    if self:RedPoint() ~= nil then
        self:RedPoint():RemoveRedPointKey();
        local temp = self:GetRedPointKey(equipIndex)
        if temp then
            self:RedPoint():AddRedPointKey(temp)
        end
    end

    if bagItemInfo ~= nil then
        self.ItemInfo = bagItemInfo.ItemTABLE
        self.isCanInlay = self:GetElementInfo():IsCanInlayEquip(self.ItemInfo)
        self.elementTableInfo = self:GetElementInfo():GetElementTableInfo(equipIndex)
        local color = ternary(self.isCanInlay, CS.UnityEngine.Color(1, 1, 1), CS.UnityEngine.Color(0, 0, 0))
        if self:GetIcon_UISprite() ~= nil then
            self:GetIcon_UISprite().color = color
        end
        if self.elementTableInfo ~= nil and self:GetElementAdd_UISprite() ~= nil and not CS.StaticUtility.IsNull(self:GetElementAdd_UISprite()) then
            self:GetElementAdd_UISprite().spriteName = self.elementTableInfo.icon
            self:GetElementAdd_UISprite().gameObject:SetActive(true)
        else
            self:GetElementAdd_UISprite().gameObject:SetActive(false)
        end
    end
end
--endregion

--region 元素特效
---刷新元素特效
function UIRolePanel_GridTemplatesElement:RefreshElementEffect(index)
    if not self:GetElementInfo():CheckIsSameTypeElement(index, self.equipIndex) then
        return
    end
    local elementInfo = self:GetElementInfo():GetElement(index)
    if elementInfo == nil then
        return
    end
    local elementEffectId = self:GetElementInfo():GetElementEffectIdByItemId(elementInfo.id)
    if self:GetElementAdd_GameObject() ~= nil and elementEffectId ~= "" then
        --self:PlayElementEffect(elementEffectId)
    end
end

function UIRolePanel_GridTemplatesElement:PlayElementEffect(effectId)
    if self:GetElementAdd_UISprite() == nil or CS.StaticUtility.IsNull(self:GetElementAdd_UISprite()) then
        return
    end
    self.elementEffect = self:GetCurComp(self:GetElementAdd_UISprite().transform, "effect", "CSUIEffectLoad")
    if self.elementEffect ~= nil then
        if self.elementEffect.effectId ~= effectId then
            self.elementEffect:ChangeEffect(effectId)
        end
        self.elementEffect.gameObject:SetActive(false)
        self.elementEffect.gameObject:SetActive(true)
    end
end
--endregion

---选中特效
function UIRolePanel_GridTemplatesElement:ChooseItem(isShow)
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(isShow)
        self.isChoose = isShow
    end
end

function UIRolePanel_GridTemplatesElement:GetRedPointKey()
    if self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON) then
        return CS.RedPointKey.Element_weap
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES) then
        return CS.RedPointKey.Element_clothes
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND) then
        return CS.RedPointKey.Element_BraceletL
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING) then
        return CS.RedPointKey.Element_ringL
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_BELT) then
        return CS.RedPointKey.Element_belt
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SHOES) then
        return CS.RedPointKey.Element_shoe
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING) then
        return CS.RedPointKey.Element_ringR
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND) then
        return CS.RedPointKey.Element_BraceletR
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE) then
        return CS.RedPointKey.Element_Necklace
    elseif self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_HEAD) then
        return CS.RedPointKey.Element_Helmet
    end
end

---重写设置选中特效
function UIRolePanel_GridTemplatesElement:HideChoose()

end

function UIRolePanel_GridTemplatesElement:OnDestroy()
    self:ReleaseEvent()
end

return UIRolePanel_GridTemplatesElement