---野外boss额外处理
---@class FieldBossExtraDeal:luaobject
local FieldBossExtraDeal = {}

---从global表中读取行会秘境boss数据
---@alias HangHuiMiJingBossData table<number,{mapID:number,bossID:number,count:number,isExist:boolean|nil,modifyDest:number}>
---@return HangHuiMiJingBossData
function FieldBossExtraDeal:GetHangHuiMiJingBossDataFromGlobal()
    if self.mHangHuiMiJingBossData == nil then
        self.mHangHuiMiJingBossData = {}
        local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22748)
        if tbl and tbl.value ~= nil then
            local strs = string.Split(tbl.value, '&')
            if strs then
                for i = 1, #strs do
                    local bossStrTemp = strs[i]
                    local bossStrs = string.Split(bossStrTemp, '#')
                    if bossStrs and #bossStrs >= 2 then
                        local mapID = tonumber(bossStrs[1])
                        local bossID = tonumber(bossStrs[2])
                        local bossCount = tonumber(bossStrs[3])
                        table.insert(self.mHangHuiMiJingBossData,
                                { mapID = mapID,
                                  bossID = bossID,
                                  count = bossCount })
                    end
                end
            end
        end
    end
    return self.mHangHuiMiJingBossData
end

---额外处理野外boss
---@param resFieldBossOpenMsg bossV2.ResFieldBossInfo
function FieldBossExtraDeal:DealFieldBossOpenMsg(resFieldBossOpenMsg)
    if resFieldBossOpenMsg == nil then
        return
    end
    self:DealFieldBossInHangHuiMiJing(resFieldBossOpenMsg)
end

---额外处理行会秘境中的野外boss
---@private
---@param resFieldBossOpenMsg bossV2.ResFieldBossInfo
function FieldBossExtraDeal:DealFieldBossInHangHuiMiJing(resFieldBossOpenMsg)
    local hangHuiMiJingData = self:GetHangHuiMiJingBossDataFromGlobal()
    if hangHuiMiJingData == nil then
        return
    end
    self:ResetCache(hangHuiMiJingData)
    self:SetModifyState(resFieldBossOpenMsg, hangHuiMiJingData)
    self:DoModify(resFieldBossOpenMsg, hangHuiMiJingData)
end

---重置缓存
---@private
---@param hangHuiMiJingData HangHuiMiJingBossData
function FieldBossExtraDeal:ResetCache(hangHuiMiJingData)
    for i = 1, #hangHuiMiJingData do
        ---@type boolean|nil 服务器message中有没有这个boss
        hangHuiMiJingData[i].isExist = false
        ---@type number 0:不处理 1:添加 2:移除
        hangHuiMiJingData[i].modifyDest = 0
    end
end

---设置修改状态
---@private
---@param resFieldBossOpenMsg bossV2.ResFieldBossInfo 服务器数据
---@param hangHuiMiJingData HangHuiMiJingBossData 处理数据
function FieldBossExtraDeal:SetModifyState(resFieldBossOpenMsg, hangHuiMiJingData)
    ---行会boss首领排名  nil:没有行会  -1:没有打过 0 不在前3名 1 2 3分别对应名词
    local unionBossRankNo = gameMgr:GetPlayerDataMgr():GetUnionInfo():GetUnionBossRankNo()

    for j = 1, #hangHuiMiJingData do
        local dataTemp = hangHuiMiJingData[j]

        if unionBossRankNo == nil then
            ---当没有行会的玩家，看到秘境boss列表为三个秘境副本的假的刷新状态
            dataTemp.modifyDest = 1
        elseif unionBossRankNo == -1 or unionBossRankNo == 0 then
            ---当有行会的玩家，但非击杀行会首领BOSS前三的行会，则不显示三个秘境副本的boss信息
            dataTemp.modifyDest = 2
        else
            ---击杀了行会首领BOSS前三行会，本行会只能看到自己秘境的BOSS真实刷新状态，不再显示另外2个排名的副本BOSS信息
            if not self:IsCanLookBoosByUnionRank(dataTemp.mapID, unionBossRankNo) then
                dataTemp.modifyDest = 2
            else
                dataTemp.modifyDest = 1
            end
        end
    end

    for i = 1, #resFieldBossOpenMsg.boss do
        ---@type bossV2.FieldBossInfo
        local bossTemp = resFieldBossOpenMsg.boss[i]
        for j = 1, #hangHuiMiJingData do
            local dataTemp = hangHuiMiJingData[j]
            if dataTemp.bossID == bossTemp.bossId then
                dataTemp.isExist = true
                break
            end
        end
    end
end

---执行修改
---@private
---@param resFieldBossOpenMsg bossV2.ResFieldBossInfo 服务器数据
---@param hangHuiMiJingData HangHuiMiJingBossData 处理数据
function FieldBossExtraDeal:DoModify(resFieldBossOpenMsg, hangHuiMiJingData)
    for i = 1, #hangHuiMiJingData do
        local dataTemp = hangHuiMiJingData[i]
        if dataTemp.modifyDest == 1 then
            ---添加(服务器无时需要添加假的)
            if not dataTemp.isExist then
                self:Add(resFieldBossOpenMsg, dataTemp)
            end
        elseif dataTemp.modifyDest == 2 then
            ---移除(服务器有时需要显示)
            if dataTemp.isExist then
                self:Remove(resFieldBossOpenMsg, dataTemp)
            end
        end
    end
end

---移除一个行会秘境boss
---@param resFieldBossOpenMsg bossV2.ResFieldBossInfo 服务器数据
function FieldBossExtraDeal:Remove(resFieldBossOpenMsg, dataTemp)

    for i = #resFieldBossOpenMsg.boss, 1, -1 do
        ---@type bossV2.FieldBossInfo
        local bossData = resFieldBossOpenMsg.boss[i]

        if bossData.bossId == dataTemp.bossID then
            table.remove(resFieldBossOpenMsg.boss, i)
        end
    end
end

---添加一个假的行会秘境boss
---@param resFieldBossOpenMsg bossV2.ResFieldBossInfo 服务器数据
function FieldBossExtraDeal:Add(resFieldBossOpenMsg, dataTemp)
    ---@type TABLE.CFG_DUPLICATE
    local duplicateTblExist, duplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(dataTemp.mapID)
    if duplicateTbl ~= nil then
        ---加入首次活动前的boss或者首次活动后的boss
        local bossTbl = clientTableManager.cfg_bossManager:TryGetValue(dataTemp.bossID)
        if bossTbl then
            table.insert(resFieldBossOpenMsg.boss, {
                id = dataTemp.bossID,
                mapId = dataTemp.mapID,
                mapIdSpecified = true,
                bossId = dataTemp.bossID,
                bossIdSpecified = true,
                configId = bossTbl:GetConfId(),
                configIdSpecified = true,
                peopleCount = 0,
                peopleCountSpecified = true,
                killCount = 0,
                killCountSpecified = true,
                count = dataTemp.count,
                countSpecified = true,
                type = bossTbl:GetType(),
                typeSpecified = true,
                freshTime = 0,
                freshTimeSpecified = true,
            })
        end
    end
end

---是否是本行会才能看到的BOSS
---@param mapId number boss所在地图id
---@return boolean
function FieldBossExtraDeal:IsCanLookBoosByUnionRank(mapId, curUnionRank)
    ---如果是行会秘境副本,首先检查下是否满足进入条件
    local mijingDuplicateID = math.floor(mapId / 100)
    if curUnionRank == 1 then
        return mijingDuplicateID == 230
    elseif curUnionRank == 2 then
        return mijingDuplicateID == 231
    elseif curUnionRank == 3 then
        return mijingDuplicateID == 232
    end
    return false
end

return FieldBossExtraDeal