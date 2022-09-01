local UnionDataInfo = {}

--region 行会召唤令
---队伍是否可以使用行会召唤令
function UnionDataInfo:TeamCanUseUnionSummonToken()
    if CS.CSScene.MainPlayerInfo ~= nil then
        if CS.CSScene.MainPlayerInfo.GroupInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup == true and CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo.captainAllowMode == LuaEnumTeamReqType.TeamLeaderReview then
            local captainPlayerInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2.CaptainPlayerInfo
            if captainPlayerInfo ~= nil and captainPlayerInfo.roleId ~= CS.CSScene.MainPlayerInfo.ID then
                local mainPlayerUnionName = CS.CSScene.MainPlayerInfo.UIUnionName
                return mainPlayerUnionName ~= captainPlayerInfo.unionName
            end
        end
    end
    return true
end
--endregion

return UnionDataInfo