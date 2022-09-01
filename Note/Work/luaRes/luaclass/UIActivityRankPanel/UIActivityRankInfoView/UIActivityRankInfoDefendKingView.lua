---@class UIActivityRankInfoDefendKingView:UIActivityRankInfoViewBase
local UIActivityRankInfoDefendKingView = {}
setmetatable(UIActivityRankInfoDefendKingView, luaclass.UIActivityRankInfoViewBase)

--设置行会信息
function UIActivityRankInfoDefendKingView:SetUnionInfo(data)
    self.uninname.text = data.settleInfo.unionName
end

--刷新详细子类型数据
function UIActivityRankInfoDefendKingView:SetInfoValueUnit(lebel, index, data)
    if CS.CSScene.MainPlayerInfo == nil then
        return ''
    end
    local otherInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.defendKingOtherInfo
    if otherInfo == nil then
        return ''
    end
    if index == 0 then
        local tatio = otherInfo.totalKillSmall == 0 and 0 or data.settleInfo.firstValue / otherInfo.totalKillSmall * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.firstValue .. '(' .. tatio .. '%)'
    elseif index == 1 then
        local tatio = otherInfo.totalKillBig == 0 and 0 or data.settleInfo.secondValue / otherInfo.totalKillBig * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.secondValue .. '(' .. tatio .. '%)'
    elseif index == 2 then
        local tatio = otherInfo.totalKill == 0 and 0 or data.settleInfo.thirdValue / otherInfo.totalKill * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.thirdValue .. '(' .. tatio .. '%)'
    elseif index == 3 then
        local tatio = otherInfo.totalDied == 0 and 0 or data.settleInfo.fourthValue / otherInfo.totalDied * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.fourthValue .. '(' .. tatio .. '%)'
    end
end

return UIActivityRankInfoDefendKingView