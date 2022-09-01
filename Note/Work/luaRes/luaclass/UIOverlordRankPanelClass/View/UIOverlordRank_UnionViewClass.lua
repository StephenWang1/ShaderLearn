---@class UIOverlordRank_UnionViewClass 行会之争视图
local UIOverlordRank_UnionViewClass = {}

function UIOverlordRank_UnionViewClass:Show(targetTbl)
    ---@type table 目标单元模板
    self.tbl = targetTbl
    ---@type table overlord表
    self.overlordTbl = targetTbl.curOverlordTbl
    self.rankInfo = CS.CSScene.MainPlayerInfo.RankInfoV2
    self.isInit = true
    self:InitParam()
    self:RefreshView()
    self:InitTop()
    self:SetScrollViewState()
end

function UIOverlordRank_UnionViewClass:RefreshView()
    --更新图片
    self.tbl.sprite.spriteName = self.overlordTbl.head
    --更新标语
    self.tbl.decs.text = self.overlordTbl.des
end

function UIOverlordRank_UnionViewClass:InitParam()
    self.curWight = 108

    self.curScrollViewPos = { x = -82, y = 110, z = 0 }
end

function UIOverlordRank_UnionViewClass:InitTop()
    local topList = CS.Cfg_OverlordTableManager.Instance:GetTopInfosOfId(self.overlordTbl.id)
    self.tbl.topGrid.MaxCount = topList.Count

    for i = 0, topList.Count - 1 do
        local go = self.tbl.topGrid.controlList[i]
        if go ~= nil then
            local info = topList[i]
            local goLabel = CS.Utility_Lua.GetComponent(go.transform:Find("rankTop"), "Top_UILabel")
            goLabel.text = info.str
            go.transform.localPosition = CS.UnityEngine.Vector3(info.pos, 0, 0)
        end
    end

    self.tbl.topBG:SetActive(topList.Count ~= 0)

end

function UIOverlordRank_UnionViewClass:SetScrollViewState()
    --self.tbl.ScrollView.transform.localPosition = self.curScrollViewPos
    --滚到最上方
    self.tbl.ScrollView:ScrollImmediately(0)
end

function UIOverlordRank_UnionViewClass:GetRankList()
    return self.rankInfo ~= nil and self.rankInfo.OverlordUnionList or nil
end

function UIOverlordRank_UnionViewClass:SetPlusWight()
    local go = self.tbl.rankGrid.itemPrefab
    if go ~= nil then
        local bg = CS.Utility_Lua.GetComponent(go.transform:Find("Background"), "Top_UISprite")
        local goWidght = CS.Utility_Lua.GetComponent(go.transform, "UIWidget")
        local goBox = CS.Utility_Lua.GetComponent(go.transform, "BoxCollider")
        bg.height = self.curWight
        goWidght.height = self.curWight
        local boxSize = goBox.size
        goBox .size = { x = boxSize.x, y = self.curWight }
    end
    self.tbl.rankGrid:ResetCellLength()
end

function UIOverlordRank_UnionViewClass:RefreshRankView()
    self:SetPlusWight()
    self.rankList = self:GetRankList()
    self.tbl.unitTemplateIDDic = {}
    if self.isInit then
        self.isInit = false
        self.tbl.rankGrid:Init(function(go, line)
            return self:RankTempCallBack(go, line)
        end)
    else
        self.tbl.rankGrid:ResetPage()
    end
end

function UIOverlordRank_UnionViewClass:RankTempCallBack(go, line)
    local count
    if self.rankList == nil then
        count = 3
    elseif self.overlordTbl ~= nil and self.rankList.Count > self.overlordTbl.number then
        count = self.overlordTbl.number
    else
        count = self.rankList.Count
    end

    if go == nil or CS.StaticUtility.IsNull(go) or count < line + 1 or self.tbl == nil then
        return false
    end
    local rankTemp
    if self.tbl.unitTemplateDic[go] == nil then
        rankTemp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIOverlordRank_UnitTemplate)
        self.tbl.unitTemplateDic[go] = rankTemp
    else
        rankTemp = self.tbl.unitTemplateDic[go]
    end
    local data = (self.rankList ~= nil and self.rankList.Count > line) and self.rankList[line] or nil
    if data ~= nil and data.id ~= nil then
        self.tbl.unitTemplateIDDic[data.id] = rankTemp
    elseif data.merit ~= nil and data.merit.Count > 0 and data.merit[0].id ~= 0 then
        self.tbl.unitTemplateIDDic[data.merit[0].id] = rankTemp
    end

    local temp = {}
    temp.rankIndex = line + 1
    temp.rankInfo = data
    temp.tblInfo = self.overlordTbl
    --temp.ClickGoCallBack = function()
    --    self.temp.curUnitTemplate = rankTemp
    --end
    temp.useTemplate = uiStaticParameter.UIRankManager:GetLuaUnitClassOfLeaderRankType(self.overlordTbl.id)
    rankTemp:SetTemplate(temp)
    return true
end

---刷新单个排行榜奖励状态
function UIOverlordRank_UnionViewClass:RefreshSingleRankRewardState(subType)
    if self.tbl.unitTemplateIDDic == nil then
        return
    end
    for i, v in pairs(self.tbl.unitTemplateIDDic) do
        local isMeetLeaderRank = v.rankData.sex ~= nil and v.rankData.id == subType
        if v.rankData ~= nil then
            if (v.rankData.subtype == subType or isMeetLeaderRank) then
                v.useTemplate:RefreshRewardState(v)
            end
        end
    end
end

function UIOverlordRank_UnionViewClass:RefreshTimeEnd()
    local _, time = CS.Cfg_OverlordTableManager.Instance:GetRemainTime(self.overlordTbl.tbl.id)
    self.tbl.countdown:StartCountDown(nil, 8, time, luaEnumColorType.TimeCountRed, "后结束", nil, self.timeEndCallBack)
end

function UIOverlordRank_UnionViewClass:Destory()
    self.tbl = nil
    self.overlordTbl = nil
    self.isInit = nil
    self.rankList = nil
    self.rankInfo = nil
    self.curWight = nil
    self.curScrollViewPos = nil
end

return UIOverlordRank_UnionViewClass