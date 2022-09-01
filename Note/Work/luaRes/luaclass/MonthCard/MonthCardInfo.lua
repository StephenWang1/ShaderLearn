local MonthCardInfo = {}

--region 功能
function MonthCardInfo:TryTipRenewMonthCard()
    local cardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(LuaEnumCardType.Coceral)
    if cardInfo ~= nil then
        local canRenewCard = CS.CSScene.MainPlayerInfo.MonthCardInfo:MonthCardNeedRenew(cardInfo.kind, cardInfo.cardType)
        if canRenewCard == true then
            if cardInfo.cardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard then
                local cardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCardInfoByCardType(cardInfo.kind, cardInfo.cardType)
                if cardInfo == nil then
                    return
                end
                if cardInfo.endTime -CS.CSScene.MainPlayerInfo.serverTime>5000 then
                    return
                end
            end
            Utility.TryAddFlashPromp({ id = LuaEnumFlashIdType.MengZhongCommerceHint, clickCallBack = function()
                Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.MengZhongCommerceHint)
                local renewCardType = tonumber(cardInfo.cardType)
                local commonData = {}
                if renewCardType == LuaEnumCoceralCardType.BiqiMonthCard then
                    commonData.PromptWordId = 136
                elseif renewCardType == LuaEnumCoceralCardType.MengZhongMonthCard then
                    commonData.PromptWordId = 135
                elseif renewCardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard then
                    commonData.PromptWordId = 103
                end
                commonData.ComfireAucion = function()
                    uimanager:CreatePanel("UICommercePanel", nil, { clickRenewBtn = true })
                end
                commonData.CancelCallBack = function()
                    uimanager:CreatePanel("UIShopPanel", nil, { type = LuaEnumStoreType.YuanBao, chooseStore = { 3035001 } })
                end
                Utility.ShowSecondConfirmPanel(commonData)
            end })
        end
    end
end
--endregion
return MonthCardInfo