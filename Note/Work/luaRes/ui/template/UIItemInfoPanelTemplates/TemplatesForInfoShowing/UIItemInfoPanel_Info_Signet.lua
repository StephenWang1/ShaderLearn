---@type 物品信息界面信息
local UIItemInfoPanel_Info_Signet = {}

setmetatable(UIItemInfoPanel_Info_Signet, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
---标题文本
---@return UILabel
function UIItemInfoPanel_Info_Signet:GetTitleLabel_UILabel()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:Get("title", "UILabel")
    end
    return self.mTitleLabel_UILabel
end

---属性值文本
---@return UILabel
function UIItemInfoPanel_Info_Signet:GetAttributeValueLabel_UILabel()
    if self.mAttributeValueLabel_UILabel == nil then
        self.mAttributeValueLabel_UILabel = self:Get("AttrValue", "UILabel")
    end
    return self.mAttributeValueLabel_UILabel
end

---标头
---@return UILabel
function UIItemInfoPanel_Info_Signet:GetIcon_UISprite()
    if self.mIcon_UILabelGameObject == nil then
        self.mIcon_UILabelGameObject = self:Get("icon", "UISprite")
    end
    return self.mIcon_UILabelGameObject
end
--endregion
---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_Signet:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self:RefreshAttributes(bagItemInfo, itemInfo,nil)
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_Signet:RefreshAttributes(bagItemInfo, itemInfo, signetInfo)
    if signetInfo ~= nil then
        local isfind, tabel_Item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(signetInfo.id)
        if isfind then
            local des = self:GetDes(signetInfo.fuDong)
            self:GetTitleLabel_UILabel().text = "[73ddf7]印记属性"
            self:GetAttributeValueLabel_UILabel().text = CS.Cfg_SignetTableManager.Instance:GetDescription(tabel_Item.id, signetInfo.fuDong)
            self:GetIcon_UISprite().spriteName = tabel_Item.icon
            self:GetIcon_UISprite().gameObject:SetActive(true)
        end
    else
        self:GetTitleLabel_UILabel().text = "[73ddf7]印记属性"
        local fudong = 0
        if bagItemInfo ~= nil then
            fudong = bagItemInfo.imprint
        end
        self:GetAttributeValueLabel_UILabel().text =  CS.Cfg_SignetTableManager.Instance:GetDescription(itemInfo.id, fudong)
    end
end

---得到描述
function UIItemInfoPanel_Info_Signet:GetDes(imprint)
    local desinfoList = {}
    local Color = '[ffffff]'
    local des = ''
    if imprint == 0 then
        Color = '[ffffff]'
    else
        Color = '[00ff00]'
        des = " (" .. (imprint / 10) .. "%)"
    end
    desinfoList[1] = Color
    desinfoList[2] = des
    return desinfoList
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_Signet:SignetNeedLevel(bagItemInfo, itemInfo)
    local color = '[ffffff]'
    if itemInfo.reinLv == 0 and itemInfo.useLv ~= 0 then
        return "\r\n" .. color .. "需要装备等级    " .. itemInfo.useLv .. "级"
    elseif itemInfo.useLv == 0 and itemInfo.reinLv ~= 0 then
        return "\r\n" .. color .. "需要装备转生等级    " .. itemInfo.reinLv .. "级"
    elseif itemInfo.useLv ~= 0 and itemInfo.reinLv ~= 0 then
        return "\r\n" .. color .. "需要装备" .. itemInfo.useLv .. "级转生" .. itemInfo.reinLv .. "级"
    else
        return "\r\n" .. color .. "   "
    end
end

function UIItemInfoPanel_Info_Signet:ShowAttribute()

end
return UIItemInfoPanel_Info_Signet