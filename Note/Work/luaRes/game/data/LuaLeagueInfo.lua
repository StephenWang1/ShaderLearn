---@class LuaLeagueInfo 玩家联盟信息
local LuaLeagueInfo = {}

---@class PlayerLeagueData 玩家联盟数据
---@field mPlayerLeagueType number 玩家联盟类型
---@field mPlayerLeaguePos number 玩家联盟职位


---@type PlayerLeagueData
LuaLeagueInfo.PlayerLeagueData = nil

function LuaLeagueInfo:Init()
    self.PlayerLeagueData = {}
end

---@public
---获取玩家联盟基本数据
function LuaLeagueInfo:GetLeagueBasicData()
    return self.mLeagueBasicData
end

---获取玩家联盟类型
---@return number LuaEnumLeagueType 联盟类型
function LuaLeagueInfo:GetLeagueType()
    if self.PlayerLeagueData ~= nil then
        return self.PlayerLeagueData.mPlayerLeagueType
    end
end

---@param tblData shareV2.EnterShareMapInfo
---存储联盟数据
function LuaLeagueInfo:RefreshLeagueInfo(tblData)
    ---@private
    self.mLeagueBasicData = tblData
    self.PlayerLeagueData.mPlayerLeagueType = tblData.uniteUnionType
    luaEventManager.DoCallback(LuaCEvent.PlayerLeagueInfoChange)

    ---判断是否是第一次进入跨服地图
    --[[    local isKuaFu = luaclass.RemoteHostDataClass:IsKuaFuMap()
        local time = gameMgr:GetPlayerDataMgr():GetLeagueInfo():GetLoginLeagueMapTime()
        local hasLeague = gameMgr:GetPlayerDataMgr():GetLeagueInfo():IsMainPlayerInLeague()
        if isKuaFu and time <= 0 and not hasLeague then
            local customData = {}
            customData.id = 132
            customData.Callback = function()
                local npcList = LuaGlobalTableDeal:GetLeagueMapNpcIdList()
                local time = CS.CSServerTime.Instance.TotalSeconds
                math.randomseed(tostring(time):reverse():sub(1, 7))
                local index = math.random(1, 4)
                local mapNpcData = npcList[index]
                if mapNpcData then
                    local id = mapNpcData.MapNpcId
                    local npcList = {}
                    table.insert(npcList, id)
                    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(npcList, "UILeagueNpcPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, index)
                end
            end
            Utility.ShowPromptTipsPanel(customData)
        end]]
end

---主角是否有联盟
---@return boolean
function LuaLeagueInfo:IsMainPlayerInLeague()
    local type = self:GetLeagueType();
    type = type == nil and 0 or type;
    return type > 0;
end

---主角的职位是否大于等于副盟主
---@return boolean
function LuaLeagueInfo:MainPlayerPostIsBetterThenFuMengZhu()
    local mainPlayerPost = self:GetLianMengPost()
    return mainPlayerPost ~= nil and type(mainPlayerPost) == 'number' and mainPlayerPost <= LuaEnumLianMengPost.FuMengZhu
end

---获取主角联盟职位
---@return LuaEnumLianMengPost
function LuaLeagueInfo:GetLianMengPost()
    if self.mLeagueBasicData ~= nil then
        return self.mLeagueBasicData.unitePosition
    end
end

--region 全联服投票信息
---获得当前联盟投票
function LuaLeagueInfo:GetTodayLeagueVoteType()
    return self.mTodayLeagueVoteType == nil and 0 or self.mTodayLeagueVoteType
end

---设置当前联盟投票
function LuaLeagueInfo:SetTodayLeagueVoteType(value)
    if self.mTodayLeagueVoteType == value then
        return
    end
    self.mTodayLeagueVoteType = value
    ---刷新lua红点
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.LeagueVote)
end

---获取全联服投票排行信息
---@public
---@return table<number,UnionVoteInfo>
function LuaLeagueInfo:GetAllWillLeagueVoteRankInfo()
    return self.AllWillLeagueVoteRankInfo
end

---设置全联服投票排行信息
---@public
function LuaLeagueInfo:SetAllWillLeagueVoteRankInfo(data)
    ---@table<number,UnionVoteInfo>
    self.AllWillLeagueVoteRankInfo = self:ParseAllWillLeagueVoteRankInfo(data)
    luaEventManager.DoCallback(LuaCEvent.RefreshAllLeagueUnionRankInfo)
end

---解析全联服投票排行信息
---@private
function LuaLeagueInfo:ParseAllWillLeagueVoteRankInfo(data)
    local tbl = {}
    if data ~= nil and data.otherServerUnionVoteAllInfo ~= nil then
        ---解析所有联服
        for i = 1, #data.otherServerUnionVoteAllInfo do
            local lianFuAllUnionInfo = data.otherServerUnionVoteAllInfo[i]
            ---解析单个联服的所有帮会
            if lianFuAllUnionInfo.otherUnionVoteInfo ~= nil then
                for j = 1, #lianFuAllUnionInfo.otherUnionVoteInfo do
                    ---解析单个联服的单个帮会的投票信息
                    local unionLeagueInfo = lianFuAllUnionInfo.otherUnionVoteInfo[j]
                    if unionLeagueInfo then

                        local GloryCount, FreeCount, CourageCount, FearlessCount = 0, 0, 0, 0

                        ---联盟投票信息解析
                        if unionLeagueInfo.WillJoinUniteUnionInfo ~= nil then
                            for i2 = 1, #unionLeagueInfo.WillJoinUniteUnionInfo do
                                local voteInfo = unionLeagueInfo.WillJoinUniteUnionInfo[i2]
                                if voteInfo.uniteUnionType == LuaEnumLeagueType.Courage then
                                    CourageCount = voteInfo.uniteUnionCount
                                elseif voteInfo.uniteUnionType == LuaEnumLeagueType.Fearless then
                                    FearlessCount = voteInfo.uniteUnionCount
                                elseif voteInfo.uniteUnionType == LuaEnumLeagueType.Glory then
                                    GloryCount = voteInfo.uniteUnionCount
                                elseif voteInfo.uniteUnionType == LuaEnumLeagueType.Free then
                                    FreeCount = voteInfo.uniteUnionCount
                                end
                            end
                        end

                        ---@class UnionVoteInfo 客户端自定义投票排行表结构
                        local UnionVoteInfo = {
                            ---@type number 服务器主机id
                            hostId = unionLeagueInfo.hostId,
                            ---@type number 行会人数
                            unionCount = unionLeagueInfo.num,
                            ---@type number 帮会id
                            unionId = unionLeagueInfo.unionId,
                            ---@type string 行会名称
                            unionName = unionLeagueInfo.unionName,
                            ---@type number 行会繁荣度
                            prosperityNum = unionLeagueInfo.activeCount,
                            ---@type number 荣耀联盟人数
                            gloryCount = GloryCount,
                            ---@type number 自由联盟人数
                            freeCount = FreeCount,
                            ---@type number 勇气联盟人数
                            courageCount = CourageCount,
                            ---@type number 无畏联盟人数
                            fearlessCount = FearlessCount,
                        }

                        table.insert(tbl, UnionVoteInfo)
                    end
                end
            end
        end

    end
    return tbl
end
--endregion

--region 联盟Npc数据返回
---刷新玩家联盟类型
---@param type number 联盟类型
function LuaLeagueInfo:RefreshLeagueType(type)
    self.PlayerLeagueData.mPlayerLeagueType = type
end

---@param pos number 玩家联盟职位
---@param pos LuaEnumLianMengPost 联盟职位
function LuaLeagueInfo:RefreshPlayerLeaguePos(pos)
    self.PlayerLeagueData.mPlayerLeaguePos = pos
end
--endregion

---刷新进入跨服地图次数
function LuaLeagueInfo:RefreshLoginLeagueMapTime(time)
    self.mLoginLeagueTime = time
end

---@return number 获取进入跨服地图次数
function LuaLeagueInfo:GetLoginLeagueMapTime()
    if self.mLoginLeagueTime then
        return self.mLoginLeagueTime
    end
    return 0
end

return LuaLeagueInfo