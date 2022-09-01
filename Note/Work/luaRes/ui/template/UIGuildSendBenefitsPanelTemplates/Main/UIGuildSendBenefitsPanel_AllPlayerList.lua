---多发
local UIGuildSendBenefitsPanel_AllPlayerList = {}
setmetatable(UIGuildSendBenefitsPanel_AllPlayerList, luaComponentTemplates.UIGuildSendBenefitsPanel_Base)

---发布按钮点击
function UIGuildSendBenefitsPanel_AllPlayerList:GrantBtnOnClick(go)
    self:RunBaseFunction("GrantBtnOnClick")
    if self.bagItemInfo == nil or self.itemInfo == nil then
        print("没有物品")
        return
    end
    ---输入数值上下限
    local minValue = 0
    local maxValue = 999999
    ---global表内备注了元宝设置了上下限
    if self.itemInfo.id == 1000002 then
        minValue = CS.Cfg_GlobalTableManager.Instance:GetYuanBaoMinLimit()
        maxValue = CS.Cfg_GlobalTableManager.Instance:GetYuanBaoMaxLimit()
    end

    ---元宝数量不足
    if self.bagItemInfo.count < minValue then
        Utility.ShowPopoTips(go.transform, nil, 179)
        return
    end

    ---没有选择玩家
    if self.choosePlayerList == nil or self.choosePlayerList.Count == 0 then
        Utility.ShowPopoTips(go.transform, nil, 180)
        return
    end
    local customData = {}
    customData.IsClosePanel = false
    customData.minValue = minValue
    customData.maxValue = maxValue
    customData.itemInfo = self.itemInfo
    customData.multiple = self.choosePlayerList.Count
    customData.showMaxValue = self.bagItemInfo.count
    customData.confirmCallBack = function(prompPanel)
        self.grantTotalNum = tonumber(prompPanel.totalNum)
        self.grantNum = tonumber(prompPanel.inputValue)
        if prompPanel:IsExcess() then
            Utility.ShowPopoTips(prompPanel.confirmBtn_GameObject.transform, nil, 179)
            return
        end

        Utility.ShowSecondConfirmPanel({ PromptWordId = 50, des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(50, self.grantTotalNum, self.itemInfo.name), ComfireAucion = function()
            networkRequest.ReqGiveSpoils(self.bagItemInfo.lid, self.grantNum, self.choosePlayerList)
            uimanager:ClosePanel("UIPromptPanel")
            uimanager:ClosePanel("UIGuildSendBenefitsPanel")
            uimanager:ClosePanel("UIGuildSendBenefitsPromptPanel")
        end })
    end
    uimanager:CreatePanel("UIGuildSendBenefitsPromptPanel", nil, customData)
end
--endregion
return UIGuildSendBenefitsPanel_AllPlayerList