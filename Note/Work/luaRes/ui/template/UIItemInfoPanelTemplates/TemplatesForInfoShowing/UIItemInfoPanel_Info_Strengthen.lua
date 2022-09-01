---物品信息界面强化信息
---@type 物品信息界面信息
local UIItemInfoPanel_Info_Strengthen = {}

setmetatable(UIItemInfoPanel_Info_Strengthen, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
---星星
---@return UIGridContainer
function UIItemInfoPanel_Info_Strengthen:GetStars_UIGridContainer()
    if self.mStars_UIGridContainer == nil then
        self.mStars_UIGridContainer = self:Get("UIItemStars", "UIGridContainer")
    end
    return self.mStars_UIGridContainer
end

---强化等级
function UIItemInfoPanel_Info_Strengthen:GetStarNum_UILabel()
    if self.mStarNum_UILabel == nil then
        self.mStarNum_UILabel = self:Get("num", "UILabel")
    end
    return self.mStarNum_UILabel
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_Strengthen:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    if bagItemInfo then
        --self:GetStars_UIGridContainer().MaxCount = bagItemInfo.intensify
        self:GetStarNum_UILabel().text = tostring(bagItemInfo.intensify)
    else
        if self.go then
            self.go:SetActive(false)
        end
    end
end

return UIItemInfoPanel_Info_Strengthen