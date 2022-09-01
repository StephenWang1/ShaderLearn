local MonthCardTableData = {}
function MonthCardTableData:GetCommerceCardDefaultClickBtnType(cardId)
    local defaultClickBtnType = 0
    local cardInfoIsFind,cardInfo = CS.Cfg_MonthCardTableManager.Instance:TryGetValue(cardId)
    if cardInfoIsFind then
        defaultClickBtnType = cardInfo.btnClick
    end
    return defaultClickBtnType
end
return MonthCardTableData