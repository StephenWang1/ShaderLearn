---我的献祭联盟信息
local UISealTowerPanel_LeagueInfo_Normal = {}

setmetatable(UISealTowerPanel_LeagueInfo_Normal,luaComponentTemplates.UISealTowerPanel_LeagueInfo_Base)

--region 刷新
function UISealTowerPanel_LeagueInfo_Normal:RefreshCurPanel()
    self:RunBaseFunction("RefreshCurPanel")
    local leagueColor = self:GetLeagueColor(self.leagueInfo)
    local leagueName = leagueColor .. self.leagueTableInfo:GetName() .. "[-]"
    self:RefreshLabel(self.name_UILabel, leagueName .. luaEnumColorType.Gray .. "("  .. tostring(self.leagueInfo.sealTowerValue) .. ")")
    self:RefreshLabel(self.attackValue_UILabel,self.leagueInfo.damageDes)
end

function UISealTowerPanel_LeagueInfo_Normal:GetLeagueColor(leagueInfo)
    --[[
    自己的联盟显示蓝色
    看除自己联盟以外的联盟玩家第一名显示橙色，第二名显示绿色，第三名显示紫色
    当玩家无联盟的时候，则全显示白色
    --]]
    if luaclass.SealTowerDataInfo.MainPlayerLeagueType == 0 then
        return luaEnumColorType.White
    end
    if luaclass.SealTowerDataInfo.MainPlayerLeagueType == leagueInfo.type then
        return luaEnumColorType.Blue2
    end
    local rank = leagueInfo.rank
    if luaclass.SealTowerDataInfo.MainPlayerLeagueRank < leagueInfo.rank then
        rank = rank - 1
    end
    if rank == 1 then
        return luaEnumColorType.Orange
    elseif rank == 2 then
        return luaEnumColorType.Green
    elseif rank == 3 then
        return luaEnumColorType.SimplePurple
    end
    return luaEnumColorType.White
end
--endregion

return UISealTowerPanel_LeagueInfo_Normal