---@class UIActivityRankInfoUnionCarView:UIActivityRankInfoViewBase
local UIActivityRankInfoUnionCarView = {}
setmetatable(UIActivityRankInfoUnionCarView, luaclass.UIActivityRankInfoViewBase)

--设置行会信息
function UIActivityRankInfoUnionCarView:SetUnionInfo(data)
    self.uninname.text = data.settleInfo.UnionName
end

--刷新详细子类型数据
function UIActivityRankInfoUnionCarView:SetInfoValueUnit(lebel, index, data)
    if CS.CSScene.MainPlayerInfo == nil then
        return ''
    end
    local mainPlayerUnionDartCarInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.MainPlayerUnionDartCarInfo
    if mainPlayerUnionDartCarInfo == nil then
        return ''
    end
    if index == 0 then
        local tatio = mainPlayerUnionDartCarInfo.totalDis == 0 and 0 or data.settleInfo.firstValue / mainPlayerUnionDartCarInfo.totalDis * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.firstValue .. '(' .. tatio .. '%)'
    elseif index == 1 then
        local tatio = mainPlayerUnionDartCarInfo.totalKill == 0 and 0 or data.settleInfo.secondValue / mainPlayerUnionDartCarInfo.totalKill * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.secondValue .. '(' .. tatio .. '%)'
    elseif index == 2 then
        local tatio = mainPlayerUnionDartCarInfo.totalDied == 0 and 0 or data.settleInfo.thirdValue /  mainPlayerUnionDartCarInfo.totalDied * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.thirdValue .. '(' .. tatio .. '%)'
    end
end

return UIActivityRankInfoUnionCarView