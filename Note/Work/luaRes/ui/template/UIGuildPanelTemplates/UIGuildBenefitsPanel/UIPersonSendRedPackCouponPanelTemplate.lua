---@class UIPersonSendRedPackCouponPanelTemplate: UIGuildSendRedPackCouponPanelTemplate 个人发放红包券
local UIPersonSendRedPackCouponPanelTemplate = {}
setmetatable(UIPersonSendRedPackCouponPanelTemplate, luaComponentTemplates.UIGuildSendRedPackCouponPanelTemplate)

UIPersonSendRedPackCouponPanelTemplate.mCanChangeMoneyNum = false

---刷新按钮
function UIPersonSendRedPackCouponPanelTemplate:RefreshBtn()
    if self.mBagItemInfo == nil then
        return
    end
    local num = self.mBagItemInfo.count > 1 and 2 or 1
    self.mBtn_UIGridContainer.MaxCount = num
    local go = self.mBtn_UIGridContainer.controlList[0].gameObject
    local lb = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    lb.text = "发放"
    CS.UIEventListener.Get(go).onClick = function(go)
        self:OnSendBtnClicked(go)
    end
    if (num ~= 1) then
        local go2 = self.mBtn_UIGridContainer.controlList[1].gameObject
        local lb2 = CS.Utility_Lua.Get(go2.transform, "Label", "UILabel")
        lb2.text = "全部发放"
        CS.UIEventListener.Get(go2).onClick = function(go)
            self:OnSendAllBtnClicked(go)
        end
    end
end

---发放（个人发放走道具使用消息）
function UIPersonSendRedPackCouponPanelTemplate:OnSendBtnClicked(go)
    networkRequest.ReqUseItem(1, self.mBagItemInfo.lid, self.mFinalSendMember)
    self:ClosePanel()
end

---全部发放（个人发放走道具使用消息）
function UIPersonSendRedPackCouponPanelTemplate:OnSendAllBtnClicked(go)
    if self.mBagItemInfo then
        networkRequest.ReqUseItem(self.mBagItemInfo.count, self.mBagItemInfo.lid, self.mFinalSendMember)
        self:ClosePanel()
    end
end

return UIPersonSendRedPackCouponPanelTemplate