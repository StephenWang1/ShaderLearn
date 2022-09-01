---行会秘境
---@class GuildActivity_GuildForHangHuiMiJingArea:GuildActivity_Base
local GuildActivity_GuildForHangHuiMiJingArea = {}

setmetatable(GuildActivity_GuildForHangHuiMiJingArea, luaComponentTemplates.GuildActivity_Base)

---0:本行会未开启行会秘境活动
---1:行会合并前,行会排名前3的行会无条件开启行会秘境
---2:行会合并后,排名第一、第二的行会无条件开启行会秘境
---3:行会合并后,第三行会的繁荣度必须不低于某个最小繁荣度
---@type number
GuildActivity_GuildForHangHuiMiJingArea.state = 0
---当前开服天数
---@type number
GuildActivity_GuildForHangHuiMiJingArea.openServerDays = 0
---当前行会排名
---@type number
GuildActivity_GuildForHangHuiMiJingArea.currentUnionRank = 0
---行会合并的小时数(从开服首日0时开始到行会第一次自动合并的小时数)
---@type number
GuildActivity_GuildForHangHuiMiJingArea.unionCombineHours = 0
---第三行会最小繁荣度
---@type number
GuildActivity_GuildForHangHuiMiJingArea.thirdMinUnionProsPerity = 0
---行会排名限制
---@type number
GuildActivity_GuildForHangHuiMiJingArea.unionRankLimit = 0
---是否可以进入地图
---@type boolean
GuildActivity_GuildForHangHuiMiJingArea.canEnterMap = false

function GuildActivity_GuildForHangHuiMiJingArea:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel", commonData)
    ---当前页状态
    self.state = 0
    ---是否可以进入地图
    self.canEnterMap = false
    ---当前开服天数
    self.openServerDays = CS.CSScene.MainPlayerInfo.ActualOpenDays
    ---当前行会排名
    self.currentUnionRank = Utility.GetMainPlayerUnionRank()
    ---如果行会排名不存在,则返回
    if self.currentUnionRank <= 0 then
        return
    end
    ---获取当前行会的繁荣度
    ___, self.currentProsPerity = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionProsPerity:TryGetValue(self.currentUnionRank)
    ---行会合并的小时数(从开服首日0时开始到行会第一次自动合并的小时数)
    self.unionCombineHours = Utility.GetUnionCombineHours()
    ---行会排名限制,行会合并后第三行会的繁荣度最小值
    self.unionRankLimit, self.thirdMinUnionProsPerity = Utility.GetThirdUnionHangHuiMiJingLimitCondition()
    ---根据开服天数和当前行会排名可以得到当前活动页的状态
    if self.openServerDays * 24 <= self.unionCombineHours then
        ---行会合并前,行会排名前3的行会无条件开启行会秘境，行会排行第4开始无法开启秘境
        self.state = 1
        self.canEnterMap = true
    else
        ---行会合并后
        if self.currentUnionRank < self.unionRankLimit then
            ---排名第一、第二的行会无条件开启行会秘境
            self.state = 2
            self.canEnterMap = true
        else
            ---第三行会的繁荣度必须不低于某个最小值
            self.state = 3
            self.canEnterMap = self.currentProsPerity >= self.thirdMinUnionProsPerity
        end
    end

    self:RefreshUI()
end

---@private
function GuildActivity_GuildForHangHuiMiJingArea:RefreshUI()
    self:GetBossPrompt_UILabel().gameObject:SetActive(true)
    local luaTable = clientTableManager.cfg_union_activityManager:TryGetValue(self.activityInfo.UnionActivityTable.id)
    if luaTable then
        self:RefreshLabel(self:GetBossPrompt_UILabel(), luaTable:GetDes())
    end
    if self.state == 0 then
        --self:GetBossPrompt_UILabel().gameObject:SetActive(false)
        self:GetButton_GameObject():SetActive(false)
        --self:GetBossPrompt_UILabel().gameObject:SetActive(true)
        self:GetButtonEffect_GameObject():SetActive(false)
        return
    end

    local unionBossRank = gameMgr:GetPlayerDataMgr():GetUnionInfo():GetUnionBossRankNo()
    if unionBossRank == 1 then
        ---第一行会
        self:GetBossPrompt_UILabel().text = "行会首领排名第一"
        self:GetBtnBG_UISprite().spriteName = "anniu1"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.764, 0.956, 1)
    elseif unionBossRank == 2 then
        ---第二行会
        self:GetBossPrompt_UILabel().text = "行会首领排名第二"
        self:GetBtnBG_UISprite().spriteName = "anniu1"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.764, 0.956, 1)
    elseif unionBossRank == 3 then
        ---第三行会
        self:GetBossPrompt_UILabel().text = "行会首领排名第三"
        self:GetBtnBG_UISprite().spriteName = "anniu1"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.764, 0.956, 1)
    elseif unionBossRank == 0 then
        ---没有进前三,不能打
        self:GetBossPrompt_UILabel().text = "行会首领排名前三专属"
        self:GetBtnBG_UISprite().spriteName = "anniu26"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.447, 0.447, 0.447)
    elseif unionBossRank == -1 then
        ---全服的行会首领还没打过,依然可以打
        self:GetBossPrompt_UILabel().text = "行会首领排名前三专属"
        self:GetBtnBG_UISprite().spriteName = "anniu1"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.764, 0.956, 1)
    else
        ---一般是连行会都没有
        self:GetBossPrompt_UILabel().text = "行会首领排名前三专属"
        self:GetBtnBG_UISprite().spriteName = "anniu26"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.447, 0.447, 0.447)
    end
    --self:GetButtonEffect_GameObject():SetActive(self.canEnterMap)
    self:GetButton_GameObject():SetActive(true)
    local duplicateID = gameMgr:GetPlayerDataMgr():GetUnionInfo():GetUnionMJDuplicate()
    ---@type TABLE.CFG_DUPLICATE
    local duplicateTblExist, duplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateID)
    if duplicateTbl then
        local mapName = duplicateTbl.name
        if #mapName > 6 then
            --去掉末尾的2个汉字
            mapName = string.sub(mapName, 1, #mapName - 6)
        end
        self:GetButton_UILabel().text = mapName
    else
        self:GetButton_UILabel().text = self.UnionActivityTableInfo.buttonLabel
    end
end

---进入按钮点击事件
---@private
function GuildActivity_GuildForHangHuiMiJingArea:EnterBtnOnClick(go)
    local dailyActivityTimeTbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(self.UnionActivityTableInfo.id)
    if dailyActivityTimeTbl == nil then
        return
    end
    local canEnterDuplicate = false
    if self.state == 1 then
        canEnterDuplicate = true
    elseif self.state == 2 then
        canEnterDuplicate = true
    elseif self.state == 3 then
        if self.currentProsPerity < self.thirdMinUnionProsPerity then
            canEnterDuplicate = false
            Utility.ShowPopoTips(go, "今日繁荣度不足", 290, "UIGuildActivitiesPanel")
            return
        else
            canEnterDuplicate = true
        end
    end
    --if true then
    --    networkRequest.ReqDeliverByConfig(dailyActivityTimeTbl:GetDeliverId(), false)
    --    return
    --end
    if canEnterDuplicate then
        local deliverTbl = clientTableManager.cfg_deliverManager:TryGetValue(dailyActivityTimeTbl:GetDeliverId())
        if deliverTbl == nil then
            return
        end
        local targetMapID = deliverTbl:GetToMapId()
        local isMapConditionConfirm, failedConditionID = self:IsCanEnterMap(targetMapID)
        if isMapConditionConfirm == false then
            if failedConditionID ~= nil then
                ---@type TABLE.CFG_CONDITIONS
                local isExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(failedConditionID)
                if conditionTbl.conditionType == 1 then
                    ---等级不足
                    Utility.ShowPopoTips(go, "达到" .. tostring(conditionTbl.conditionParam.list[0]) .. "级可进入", 290, "UIGuildActivitiesPanel")
                elseif conditionTbl.conditionType == 3 then
                    ---转生等级不足
                    Utility.ShowPopoTips(go, "达到" .. tostring(conditionTbl.conditionParam.list[0]) .. "转可进入", 290, "UIGuildActivitiesPanel")
                elseif conditionTbl.conditionType == 6 then
                    ---VIP等级不足
                    Utility.ShowPopoTips(go, "达到VIP" .. tostring(conditionTbl.conditionParam.list[0]) .. "可进入", 290, "UIGuildActivitiesPanel")
                end
            end
            return
        end
        ---检查当前地图是否在行会秘境地图,如果已在行会秘境中,则弹出气泡“已在当前地图”并返回
        local currentMapID = CS.CSScene.getMapID()
        ---@type TABLE.CFG_DUPLICATE
        local duplicateExist, currentDuplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(currentMapID)
        if currentDuplicateTbl ~= nil and (currentDuplicateTbl.type == 45 or currentDuplicateTbl.type == 54) then
            ---VIP等级不足
            Utility.ShowPopoTips(go, "已在当前地图", 290, "UIGuildActivitiesPanel")
            return
        end

        ---行会秘境进入的副本条件没有变(所以上面的就不想动了),根据当前行会首领的排名/自己公会的排名进入不同的副本
        local unionBossRankDuplicate = gameMgr:GetPlayerDataMgr():GetUnionInfo():GetUnionMJDuplicate()
        if (unionBossRankDuplicate == 0) then
            ---没有权限
            Utility.ShowPopoTips(go, "未获得进入权限", 290, "UIGuildActivitiesPanel")
        else
            networkRequest.ReqEnterDuplicate(unionBossRankDuplicate)
        end
    end
end

---是否可以进入地图
---@private
---@param mapID number
---@return boolean, table<number, number>|nil
function GuildActivity_GuildForHangHuiMiJingArea:IsCanEnterMap(mapID)
    local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(mapID)
    if mapTbl == nil then
        return false
    end
    if mapTbl:GetConditionId() == nil or mapTbl:GetConditionId().list == nil or mapTbl:GetConditionId().list.Count == 0 then
        return true
    end
    for i = 1, mapTbl:GetConditionId().list.Count do
        local conditionID = mapTbl:GetConditionId().list[i - 1]
        if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false then
            return false, conditionID
        end
    end
    return true
end

return GuildActivity_GuildForHangHuiMiJingArea