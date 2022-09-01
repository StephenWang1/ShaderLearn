---@class UIAppearancePanelGridTemplate:TemplateBase
local UIAppearancePanelGridTemplate = {}

---@return UISprite
function UIAppearancePanelGridTemplate:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("Icon", "UISprite")
    end
    return self.mIconSprite
end

---@return UISprite
function UIAppearancePanelGridTemplate:GetUsingSign()
    if self.mUsingSign == nil then
        self.mUsingSign = self:Get("use", "UISprite")
    end
    return self.mUsingSign
end

---@return UnityEngine.GameObject
function UIAppearancePanelGridTemplate:GetSelectedEffect()
    if self.mSelectedEffect == nil then
        self.mSelectedEffect = self:Get("SelectedEffect", "GameObject")
    end
    return self.mSelectedEffect
end

---新外观标识
---@return UnityEngine.GameObject
function UIAppearancePanelGridTemplate:GetNewAppearanceSign()
    if self.mNewAppearanceSignGo == nil then
        self.mNewAppearanceSignGo = self:Get("new", "GameObject")
    end
    return self.mNewAppearanceSignGo
end

---@param info bagV2.BagItemInfo
---@param isSelected boolean
function UIAppearancePanelGridTemplate:Refresh(info, isSelected)
    self.bagItemInfo = info
    if info ~= nil then
        local itemID = info.itemId
        if gameMgr:GetPlayerDataMgr() ~= nil then
            if isSelected then
                gameMgr:GetPlayerDataMgr():GetAppearanceInfo():ClickAndTryRemoveRedPoint(itemID)
            end
            self:GetNewAppearanceSign():SetActive(gameMgr:GetPlayerDataMgr():GetAppearanceInfo():IsNewAppearance(itemID))
        else
            self:GetNewAppearanceSign():SetActive(false)
        end
    else
        self:GetNewAppearanceSign():SetActive(false)
    end
    local appearanceTbl = CS.AppearanceData.GetAppearanceTable(info)
    if appearanceTbl then
        self:GetIconSprite().gameObject:SetActive(true)
        self:GetIconSprite().spriteName = tostring(appearanceTbl.icon)
        self:GetUsingSign().gameObject:SetActive(CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:IsFashionEnabled(info))
        self:GetSelectedEffect():SetActive(isSelected == true)
    else
        self:GetIconSprite().gameObject:SetActive(false)
        self:GetUsingSign().gameObject:SetActive(false)
        self:GetSelectedEffect():SetActive(false)
    end
end

return UIAppearancePanelGridTemplate