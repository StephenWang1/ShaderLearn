---@class UIPlayerMenuBtnManager:UIBase 玩家菜单按钮管理
local UIPlayerMenuBtnManager = {}

---@param key number panelID
---@param customData XLua.ILuaTable
---@field customData.isSharePlayer   boolean 是否为联服玩家
---@field customData.playerSomeInfo  groupV2.ResHasPlayerSomeInfo
---@field customData.unionMemberInfo unionV2.UnionMemberInfo
---@field customData.teamPlayerData  groupV2.PlayerInfo
function UIPlayerMenuBtnManager:GetMeetPlayerMenuBtns(key, customData)
    local meetMenuBtns = {}
    self.curData = customData
    local isFind, info = CS.Cfg_GlobalTableManager.CfgInstance.playerMenuBtnDicOfPanelType:TryGetValue(key)
    if isFind then
        local CountOne = info.Count
        if CountOne == 0 then
            return nil
        end
        local btnTabel = {}
        for i1 = 0, CountOne - 1 do
            btnTabel = {}
            local CountTwo = info[i1].Count
            if CountTwo ~= 0 then
                for i2 = 0, CountTwo - 1 do
                    if self:CheckPlayerMeetShow(info[i1][i2]) then
                        table.insert(btnTabel, info[i1][i2])
                    end
                end
            end
            table.insert(meetMenuBtns, btnTabel)
        end
    end
    return meetMenuBtns
end
---检测菜单按钮是否显示
---@return boolean 是否显示
function UIPlayerMenuBtnManager:CheckPlayerMeetShow(btnId)
    btnId = tonumber(btnId)
    if btnId == 0 then
        return false
    end
    if CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    if self.curData == nil or self.curData.playerSomeInfo == nil then
        return true
    end
    local data = self.curData
    local mainPlayerinfo = CS.CSScene.MainPlayerInfo

    --添加好友
    if btnId == LuaEnumGuildTipType.AddFriend then
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end

        ---联服玩家不显示
        if self.curData.isSharePlayer then
            return false
        end

        local info = mainPlayerinfo.FriendInfoV2:GetFriend(data.playerSomeInfo.roleId)
        return info == nil
    end

    --私聊
    if btnId == LuaEnumGuildTipType.PrivateChat then
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        if (self.curData.teamPlayerData ~= nil and CS.CSScene.MainPlayerInfo) then
            return self.curData.teamPlayerData.roleId ~= CS.CSScene.MainPlayerInfo.ID
        else
            return true
        end
    end

    --夫妻赠送钻石
    if btnId == LuaEnumGuildTipType.SendDiamond then
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        return mainPlayerinfo.MarryInfo.LoverInfo ~= nil and mainPlayerinfo.MarryInfo.LoverInfo.rid == data.playerSomeInfo.roleId
    end

    --邀请入队
    if btnId == LuaEnumGuildTipType.InvitedTeam then
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        if ((not mainPlayerinfo.GroupInfoV2.IsHaveGroup) and data.playerSomeInfo.teamId ~= 0) then
            return false;
        end

        ---联服玩家且不在联服地图不显示
        if self.curData.isSharePlayer and not Utility.IsKuaFuMap(self.curData.playerSomeInfo.mapId) then
            return false
        end
        ---本服玩家且不在本服地图不显示
--[[        if not self.curData.isSharePlayer and Utility.IsKuaFuMap(self.curData.playerSomeInfo.mapId) then
            return false
        end]]

        if (self.curData.teamPlayerData ~= nil) then
            return not mainPlayerinfo.GroupInfoV2:IsTeamMember(self.curData.teamPlayerData.roleId);
        end
        return true;
    end

    --申请入队
    if btnId == LuaEnumGuildTipType.ApplyTeam then
        ---联服玩家且不在联服地图不显示
        if self.curData.isSharePlayer and not Utility.IsKuaFuMap(self.curData.playerSomeInfo.mapId) then
            return false
        end
        ---本服玩家且不在本服地图不显示
--[[        if not self.curData.isSharePlayer and Utility.IsKuaFuMap(self.curData.playerSomeInfo.mapId) then
            return false
        end]]

        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        return (not mainPlayerinfo.GroupInfoV2.IsHaveGroup) and data.playerSomeInfo.teamId ~= 0
    end

    --邀请入会
    if btnId == LuaEnumGuildTipType.InviteMembership then

        --[[        ---联服玩家且不在联服地图不显示
                if self.curData.isSharePlayer and not luaclass.RemoteHostDataClass:IsKuaFuMap() then
                    return false
                end
                --]]

        ---联服玩家都不显示
        if self.curData.isSharePlayer then
            return false
        end

        ---本服玩家且不在本服地图不显示
        if not self.curData.isSharePlayer and luaclass.RemoteHostDataClass:IsKuaFuMap() then
            return false
        end

        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        if mainPlayerinfo.UnionInfoV2 ~= nil and mainPlayerinfo.UnionInfoV2.UnionInfo ~= nil and data.playerSomeInfo.unionId == 0 then
            local mypos = mainPlayerinfo.UnionInfoV2:GetCurrentPosition()
            local canInvite = CS.CSUnionInfoV2.HasUnionApprovalAuthority(mypos);
            local levelArrive = CS.CSUnionInfoV2.IsLevelCanJoinUnion(data.playerSomeInfo.level);
            --本人有行会且达到审批职位，对方无行会且达到入会等级，点击对方头像，显示邀请入会
            return mainPlayerinfo.UnionInfoV2.UnionID ~= 0 and canInvite and levelArrive
        end
        return false
    end

    --申请入会
    if btnId == LuaEnumGuildTipType.ApplyUnion then
        ---联服玩家不显示
        if self.curData.isSharePlayer then
            return false
        end
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        if mainPlayerinfo.UnionInfoV2 ~= nil and mainPlayerinfo.UnionInfoV2.UnionInfo ~= nil and data.playerSomeInfo.unionId == 0 then
            local canInvite = CS.CSUnionInfoV2.HasUnionApprovalAuthority(data.playerSomeInfo.unionPosition);
            local levelArrive = CS.CSUnionInfoV2.IsLevelCanJoinUnion(mainPlayerinfo.Level);
            --对方有行会且达到审批职位，我方无行会且达到入会等级，点击对方头像，显示申请入会
            return mainPlayerinfo.UnionInfoV2.UnionID == 0 and canInvite and levelArrive
        end
        return false
    end

    --设置职位
    if btnId == LuaEnumGuildTipType.SetPosition then
        return true
    end

    --踢出公会
    if btnId == LuaEnumGuildTipType.OutGuild then
        return true
    end

    --转让队长
    if btnId == LuaEnumGuildTipType.TransferCaptain then
        if (self.curData.teamPlayerData ~= nil) then
            if (self.curData.teamPlayerData.roleId ~= CS.CSScene.MainPlayerInfo.ID) then
                if (CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain) then
                    return true;
                end
            end
        end
        return false
    end

    --踢出队伍
    if btnId == LuaEnumGuildTipType.OutTemp then
        if (self.curData.teamPlayerData ~= nil) then
            return mainPlayerinfo.GroupInfoV2:IsMyTeamMember(mainPlayerinfo.ID, self.curData.teamPlayerData.roleId) and mainPlayerinfo.ID ~= self.curData.teamPlayerData.roleId;
        end
        return false;
    end

    --查看他人灵兽
    if btnId == LuaEnumGuildTipType.CheckOtherPeopleServant then
        return true
    end

    --查看灵兽主人信息
    if btnId == LuaEnumGuildTipType.CheckMasterInfo then
        return true
    end

    --查看玩家信息
    if btnId == LuaEnumGuildTipType.CheckInformation then
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        return true
    end

    --送花
    if btnId == LuaEnumGuildTipType.SendFlowers then
        if (self.curData.teamPlayerData ~= nil and CS.CSScene.MainPlayerInfo) then
            return self.curData.teamPlayerData.roleId ~= CS.CSScene.MainPlayerInfo.ID
        else
            return true
        end
    end

    --划拳
    if btnId == LuaEnumGuildTipType.PullFist then
        ---联服玩家不显示划拳
        if self.curData.isSharePlayer then
            return false
        end

        ---主角联服地图不显示
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            return false
        end

        ---玩家联服地图不显示
        if Utility.IsKuaFuMap(self.curData.playerSomeInfo.mapId) then
            return false
        end

        if (self.curData.teamPlayerData ~= nil and CS.CSScene.MainPlayerInfo) then
            return self.curData.teamPlayerData.roleId ~= CS.CSScene.MainPlayerInfo.ID
        else
            return true
        end
    end

    --授权语音
    if btnId == LuaEnumGuildTipType.AuthorizationVoice then
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        if data.unionMemberInfo ~= nil then
            return not data.unionMemberInfo.canSendVoice and not CS.CSScene.MainPlayerInfo.UnionInfoV2.IsVoiceQuotaFull
        end
        return false
    end

    --取消授权语音
    if btnId == LuaEnumGuildTipType.UnAuthorizationVoice then
        --if not data.playerSomeInfo.isOnline then
        --    return false
        --end
        if data.unionMemberInfo ~= nil then
            return data.unionMemberInfo.canSendVoice
        end
        return false
    end

    --退出队伍
    if (btnId == LuaEnumGuildTipType.LeaveTeam) then
        if (self.curData.teamPlayerData ~= nil) then
            return mainPlayerinfo.ID == self.curData.teamPlayerData.roleId and mainPlayerinfo.GroupInfoV2.IsHaveGroup;
        end
        return false;
    end

    --追踪
    if btnId == LuaEnumGuildTipType.Track then
        return true
    end

    --面对面交易
    if btnId == LuaEnumGuildTipType.Trade then
        if (self.curData.teamPlayerData ~= nil and CS.CSScene.MainPlayerInfo) then
            return self.curData.teamPlayerData.roleId ~= CS.CSScene.MainPlayerInfo.ID
            --else
            --    if self.curData~=nil and self.curData.playerSomeInfo and mainPlayerinfo.Level>=CS.Cfg_GlobalTableManager.Instance.FaceToFaceLimitLevel and self.curData.playerSomeInfo.level>=CS.Cfg_GlobalTableManager.Instance.FaceToFaceLimitLevel  then
            --        return true
            --    end
            --    return true
        end
        return true
    end

    return false
end

return UIPlayerMenuBtnManager
