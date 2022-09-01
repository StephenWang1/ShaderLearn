---@class UIContendRank_MainViewTemplate:TemplateBase 夺榜主界面视图
local UIContendRank_MainViewTemplate = {}

---获取当前排行信息
---@return<number,rankV2.RoleRankDataInfo>
function UIContendRank_MainViewTemplate:GetCurRankList()
    if self.rankList == nil and gameMgr:GetPlayerDataMgr() ~= nil then
        self.rankList = gameMgr:GetPlayerDataMgr():GetRankData():GetCurRankTbl()
    end
    return self.rankList
end

--region 初始化

function UIContendRank_MainViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UIContendRank_MainViewTemplate:InitParameters()
    self.timeEndCallBack = nil
    self.curUnitTemplate = nil
    self.myRankItemTemplat = nil
    self.curTbl = 0
    self.unitTemplateDic = {}
end

function UIContendRank_MainViewTemplate:InitComponents()
    ---@type Top_UILabel
    self.countdown = self:Get("time", "UICountdownLabel")
    ---@type Top_UILabel
    self.lastRefreshTime = self:Get("lastRefreshTime", "UICountdownLabel")
    ---@type Top_UISprite
    self.sprite = self:Get("sprite", "Top_UISprite")
    ---@type Top_UILabel
    self.decs = self:Get("Decs", "Top_UILabel")
    ---@type Top_UIGridContainer
    self.rankGrid = self:Get("Scroll View/firstRankGrid", "Top_UIGridContainer")
end

function UIContendRank_MainViewTemplate:BindUIMessage()
    -- CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    -- CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
end

--endregion

--region Show

---@param data.timeEndCallBack function 倒计时完毕回调
function UIContendRank_MainViewTemplate:SetTemplate(data)
    self.timeEndCallBack = data.timeEndCallBack

    local _, time = CS.Cfg_ContendRankTableManager.Instance:GetRemainTime()

    self.countdown:StartCountDown(nil, 8, time, luaEnumColorType.TimeCountRed, "后结束", nil, self.timeEndCallBack)
end

function UIContendRank_MainViewTemplate:RefreshView(tbl)
    self.curTbl = tbl
    --更新图片
    self.sprite.spriteName = "ContendRank" .. tostring(tbl.id)

    self.decs.text = tbl.ps

    networkRequest.ReqRankRewardInfo(tbl.rankId)

    -- _, self.targetTime = CS.Cfg_ContendRankTableManager.Instance:GetRemainTime(tbl.id)

    --self.countdown:StartCountDown(nil, 8, self.targetTim, luaEnumColorType.TimeCountRed, "后结束", nil, self.timeEndCallBack)
end

function UIContendRank_MainViewTemplate:RefreshLastRefreshTime(time)
    if time then
        self.lastRefreshTime:StopCountDown()
        self.lastRefreshTime:StartCountBySecond(nil, 7, math.ceil(time / 1000), luaEnumColorType.TimeCountRed .. '距离下次刷新', "[-]", nil, nil)
    end
end

function UIContendRank_MainViewTemplate:RefreshRankList(rankCfgId, contendRankTblInfo)
    self.rankList = nil

    self.rankGrid.MaxCount = 3
    for i = 0, self.rankGrid.controlList.Count - 1 do
        local go = self.rankGrid.controlList[i]
        local data = (self:GetCurRankList() ~= nil and #self:GetCurRankList() > i) and self:GetCurRankList()[i + 1] or nil
        if go ~= nil then
            local rankTemp = self.unitTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIContendRank_UnitTemplate) or self.unitTemplateDic[go]
            local temp = {}
            temp.rankIndex = i + 1
            temp.rankConfigId = rankCfgId
            if data ~= nil then
                temp.rankInfo = data.roleRankInfo
                temp.wifeRankInfo = data.wifeRankInfo
                temp.servantRankInfo = data.servantRankInfo
                temp.damageItemRankInfo = data.damageItemRankInfo
                temp.rid = data.roleRankInfo.uid
                if data.roleRankInfo.uid == CS.CSScene.MainPlayerInfo.ID then
                    self.myRankItemTemplat = rankTemp
                end
            else
                temp.rankInfo = nil
                temp.wifeRankInfo = nil
                temp.servantRankInfo = nil
                temp.damageItemRankInfo = nil
                temp.rid = nil
            end
            temp.tblInfo = contendRankTblInfo
            temp.isMain = true
            temp.ClickGoCallBack = function()
                --[[                if self.curUnitTemplate ~= nil then
                                    if self.curUnitTemplate.rid == temp.rid then
                                        return
                                    end
                                    self.curUnitTemplate:SetChoseHightState(false)
                                end
                                rankTemp:SetChoseHightState(true)]]
                self.curUnitTemplate = rankTemp
            end
            temp.useTemplate = uiStaticParameter.UIRankManager:GetLuaClassOfContendRankType(rankCfgId, true)
            rankTemp:SetTemplate(temp)
            if self.unitTemplateDic[go] == nil then
                self.unitTemplateDic[go] = rankTemp
            end
        end
    end
end

--endregion


--region UI函数监听

--endregion


--region otherFunction



--endregion

--region ondestroy

--endregion

return UIContendRank_MainViewTemplate