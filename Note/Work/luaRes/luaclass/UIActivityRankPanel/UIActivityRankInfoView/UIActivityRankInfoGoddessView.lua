---@class UIActivityRankInfoGoddessView:UIActivityRankInfoViewBase
local UIActivityRankInfoGoddessView = {}
setmetatable(UIActivityRankInfoGoddessView, luaclass.UIActivityRankInfoViewBase)


--刷新详细子类型数据
function UIActivityRankInfoGoddessView:SetInfoValueUnit(lebel, index, data)
    if CS.CSScene.MainPlayerInfo == nil then
        return ''
    end
    local otherInfo = CS.CSScene.MainPlayerInfo.ActivityInfo
    if otherInfo == nil then
        return ''
    end
    if index == 0 then
        local percentage = 0
        if otherInfo.GoddessMaxEarnings ~= 0 then
            percentage = data.settleInfo.secondValue / otherInfo.GoddessMaxEarnings * 100
        end
        percentage = string.format('%.1f', percentage)
        lebel.text = data.settleInfo.secondValue .. '(' .. percentage .. '%)'
    elseif index == 1 then
        local percentage = 0;
        if otherInfo.GoddessMaxKillNumber ~= 0 then
            percentage = data.settleInfo.thirdValue / otherInfo.GoddessMaxKillNumber * 100
        end

        percentage = string.format('%.1f', percentage)
        lebel.text = data.settleInfo.thirdValue .. '(' .. percentage .. '%)'
    end
end

return UIActivityRankInfoGoddessView