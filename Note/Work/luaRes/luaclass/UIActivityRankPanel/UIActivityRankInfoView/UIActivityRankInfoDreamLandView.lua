---@class UIActivityRankInfoDreamLandView:UIActivityRankInfoViewBase
local UIActivityRankInfoDreamLandView = {}
setmetatable(UIActivityRankInfoDreamLandView, luaclass.UIActivityRankInfoViewBase)

--设置行会信息
function UIActivityRankInfoDreamLandView:SetUnionInfo(data)
    self.uninname.text = data.settleInfo.unionName
end

--刷新详细子类型数据
function UIActivityRankInfoDreamLandView:SetInfoValueUnit(lebel, index, data)
    if CS.CSScene.MainPlayerInfo == nil then
        return ''
    end
    local otherInfo = CS.CSScene.MainPlayerInfo.ActivityInfo
    if otherInfo == nil then
        return ''
    end
    if index == 0 then
        local tatio = otherInfo.AllBossHurt == 0 and 0 or data.settleInfo.firstValue / otherInfo.AllBossHurt * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.firstValue .. '(' .. tatio .. '%)'
    elseif index == 1 then
        local tatio = otherInfo.AllBossKill == 0 and 0 or data.settleInfo.secondValue / otherInfo.AllBossKill * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.secondValue .. '(' .. tatio .. '%)'
    elseif index == 2 then
        local tatio = otherInfo.AllKill == 0 and 0 or data.settleInfo.thirdValue / otherInfo.AllKill * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.thirdValue .. '(' .. tatio .. '%)'
    end
end

return UIActivityRankInfoDreamLandView