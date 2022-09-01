local SealTowerDataInfo = {}

--region 数据
---@param 封印塔活动是否开启 boolean
SealTowerDataInfo.SealTowerIsOpen = false
---@param 倒计时结束时间 number
SealTowerDataInfo.EndTime = 0
---@param 怪物数量 number
SealTowerDataInfo.MonsterNum = 0
---@param 封印塔主角的积分 number
SealTowerDataInfo.MainPlayerTowerScore = 0
---@param 主角的联盟类型 number
SealTowerDataInfo.MainPlayerLeagueType = 0
---@param 主角的联盟排名 number
SealTowerDataInfo.MainPlayerLeagueRank = 0
---@param 封印塔联盟列表 table<table>
SealTowerDataInfo.SealTowerLeagueTable = {}
---@param 剩余时间文本格式 string
SealTowerDataInfo.RemainTimeFormat = "%02d:%02d:%02d"

---联服封印塔是否增加了伤害(以客户端buff的形式显示表现)
---@type boolean
SealTowerDataInfo.isTowerAddDamageOpened = false
---联服封印塔增加的伤害(万分比分子)
---@type number
SealTowerDataInfo.towerAddDamagePercentage = 0
--endregion

--region 数据刷新
---刷新封印塔联盟数据
---@param tblData uniteunionV2.ResUniteUnionSealTowerRank  封印塔联盟数据（服务器数据）
function SealTowerDataInfo:RefreshSealTowerInfo(tblData)
    self:ClearSealTowerInfo()
    if tblData == nil then
        return
    end
    self.SealTowerIsOpen = tblData.isOpen == 1
    self.EndTime = tblData.lastTime
    self.MonsterNum = tblData.hasCount
    self.MainPlayerTowerScore = ternary(tblData.myTowerValue == nil, 0, tblData.myTowerValue)
    self.MainPlayerLeagueType = tblData.myUniteUnionType
    self:RefreshLeagueData(tblData.tower)
    luaEventManager.DoCallback(LuaCEvent.RefreshSealTowerDataInfo)
end

---刷新封印塔所有联盟数据
---@param tblData table table<uniteunionV2.SealTower>
function SealTowerDataInfo:RefreshLeagueData(tblData)
    if tblData ~= nil and type(tblData) == 'table' and #tblData > 0 then
        for k, v in pairs(tblData) do
            if v ~= nil and v.type ~= nil then
                local sealTowerLeagueData = self:GetSealTowerLeagueData(v.type)
                if sealTowerLeagueData == nil then
                    sealTowerLeagueData = {}
                    self.SealTowerLeagueTable[v.type] = sealTowerLeagueData
                end
                self:RefreshSingleLeagueData(v)
                if v.type == self.MainPlayerLeagueType then
                    self.MainPlayerLeagueRank = v.rank
                end
            end
        end
    end
end

---刷新单个封印塔联盟数据
---@param tblData uniteunionV2.SealTower
---@param sendMsg boolean 是否发送单个封印塔联盟数据变动消息
function SealTowerDataInfo:RefreshSingleLeagueData(tblData, sendMsg)
    if tblData == nil or type(tblData) ~= 'table' then
        return
    end
    local leagueData = self:GetSealTowerLeagueData(tblData.type)
    if leagueData == nil then
        return
    end
    leagueData.id = tblData.id
    leagueData.type = tblData.type
    leagueData.rank = tblData.rank
    leagueData.sealTowerValue = tblData.sealTowerValue
    if leagueData.sealTowerValue <= 0 then
        leagueData.damageDes = LuaGlobalTableDeal:GetSealTowerDamageDes(0)
    else
        leagueData.damageDes = LuaGlobalTableDeal:GetSealTowerDamageDes(leagueData.rank)
    end
    if sendMsg == true then
        luaEventManager.DoCallback(LuaCEvent.RefreshSingleSealTowerDataInfo, tblData.type)
    end
end

---清理封印塔联盟数据
function SealTowerDataInfo:ClearSealTowerInfo()
    self.SealTowerIsOpen = false
    self.EndTime = 0
    self.MonsterNum = 0
    self.MainPlayerTowerScore = 0
    self.MainPlayerLeagueType = 0
    self.SealTowerLeagueTable = {}
end
--endregion

--region 获取
---获取封印塔联盟数据
---@param type LuaEnumLeagueType 联盟类型
---@return table 联盟数据/nil
function SealTowerDataInfo:GetSealTowerLeagueData(type)
    if self.SealTowerLeagueTable == nil then
        return nil
    end
    return self.SealTowerLeagueTable[type]
end

---获取怪物攻城下次开始文本内容
---@return string 描述内容
function SealTowerDataInfo:GetSealTowerNextStartDes()
    local color = luaEnumColorType.Red
    local desTextFormat = ternary(self.SealTowerIsOpen == true, "距离下波怪物攻城还有", "距离下次怪物攻城还有")
    local remainTimeText = self:GetRemainTimeText()
    return color .. desTextFormat .. remainTimeText
end

---获取怪物攻城剩余时间
---@return number 剩余时间（毫秒）
function SealTowerDataInfo:GetRemainTime()
    if self.EndTime <= 0 then
        return 0
    end
    local remainTime = self.EndTime - CS.CSScene.MainPlayerInfo.serverTime
    if remainTime <= 0 then
        return 0
    end
    return remainTime
end

---获取剩余时间文本
---@return string 剩余时间文本（00::00:00）
function SealTowerDataInfo:GetRemainTimeText()
    local remainTime = self:GetRemainTime()
    local hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
    local remainTimeText = string.format(self.RemainTimeFormat, Utility.GetMaxIntPart(hour), Utility.GetMaxIntPart(minute), Utility.GetMaxIntPart(second))
    return remainTimeText
end

---过去剩余怪物刷量显示文本
---@return string 怪物数量文本F
function SealTowerDataInfo:GetRemainMonsterNumText()
    local num = tostring(self.MonsterNum)
    if self.MonsterNum > 0 then
        num = luaEnumColorType.Green .. num
    end
    return "剩余攻城怪物  " .. num
end

---获取主角的联盟信息
---@return table 客户端联盟数据类
function SealTowerDataInfo:GetMainPlayerLeagueInfo()
    if self.MainPlayerLeagueType == nil or self.MainPlayerLeagueType <= 0 then
        return
    end
    if self.MainPlayerLeagueType ~= nil and self.SealTowerLeagueTable ~= nil and type(self.SealTowerLeagueTable) == 'table' then
        return self:GetSealTowerLeagueData(self.MainPlayerLeagueType)
    end
end
--endregion

--region 排序
---获取封印塔联盟排序数据
---@return 获取排序后的联盟排行
function SealTowerDataInfo:GetSortSealTowerLeagueData()
    if self.SealTowerLeagueTable == nil or type(self.SealTowerLeagueTable) ~= 'table' then
        return nil
    end
    local cloneSealTowerLeagueTable = Utility.CopyTable(self.SealTowerLeagueTable)
    if cloneSealTowerLeagueTable ~= nil then
        table.sort(cloneSealTowerLeagueTable, function(l, r)
            return l.rank < r.rank
        end)
    end
    return cloneSealTowerLeagueTable
end
--endregion

--region 数据清理
---游戏场景退回到登录/选角界面时触发
function SealTowerDataInfo:OnExitDestroy()
    self:ClearSealTowerInfo()
    self.isTowerAddDamageOpened = false
    self.towerAddDamagePercentage = 0
end
--endregion

return SealTowerDataInfo