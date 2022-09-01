---@class UIGuildSendRedPackCouponPanelTemplate:UIGuildSendRedPanelTemplate 战利品发放红包券
local UIGuildSendRedPackCouponPanelTemplate = {}

setmetatable(UIGuildSendRedPackCouponPanelTemplate, luaComponentTemplates.UIGuildSendRedPanelTemplate)

UIGuildSendRedPackCouponPanelTemplate.mCanChangeMoneyNum = false

---刷新红包显示
function UIGuildSendRedPackCouponPanelTemplate:RefreshSendRedPack(customData)
    if customData == nil then
        return
    end
    ---@type bagV2.BagItemInfo
    local bagItemInfo = self.mBagItemInfo
    if bagItemInfo then
        local num = bagItemInfo.redBagMoney
        self.mMaxSendMoney = math.min(self.mMaxSendMoney, num)
        self:SetMoneyNum(num)
        self:GetMoneyInputBg_Go():SetActive(true)
        self:GetMoneyInputBox_BoxCollider().enabled = false
        self:SetMemberNum(self.mNormalMemberNum)
    end
end

return UIGuildSendRedPackCouponPanelTemplate