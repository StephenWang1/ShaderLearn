local UISealTowerPanel = {}

setmetatable(uibase,luaComponentTemplates.UIRefreshTemplate)
--region 初始化
function UISealTowerPanel:Init()
    self:InitComponent()
    self:BindEvents()
    self:BindMessage()
    self:InitParams()
end

function UISealTowerPanel:InitComponent()
    self.Panel_TweenAlpha = self:GetCurComp("WidgetRoot","Top_TweenAlpha")

    self.ToKillMonsterBtn_GameObject = self:GetCurComp("WidgetRoot/monsterNum/btn_kill","GameObject")
    self.CloseBtn_GameObject = self:GetCurComp("WidgetRoot/CloseBtn","GameObject")

    self.MonsterTime_UILabel = self:GetCurComp("WidgetRoot/monsterTime","UILabel")
    self.MonsterNum_UILabel = self:GetCurComp("WidgetRoot/monsterNum/number","UILabel")

    self.LeagueList_UILoopScrollViewPlus = self:GetCurComp("WidgetRoot/UnionSacrifice/SacrificeList","UILoopScrollViewPlus")

    self.MySacrifice_GameObject = self:GetCurComp("WidgetRoot/MySacrifice","GameObject")
    self.MainPlayerSacrificeTitle = self:GetCurComp("WidgetRoot/introduce/labelGroup/enterConditon","GameObject")
end

function UISealTowerPanel:BindEvents()
    self:BindClickCallBack(self.ToKillMonsterBtn_GameObject,function(go)
        local monsterNum = luaclass.SealTowerDataInfo.MonsterNum
        ---没有怪物就显示气泡
        if monsterNum == nil or (type(monsterNum) == 'number' and monsterNum <= 0) then
            Utility.ShowPopoTips(go.transform,nil,423)
            return
        end
        networkRequest.ReqGetSealTowerMonsterPoint()
    end)
    self:BindClickCallBack(self.CloseBtn_GameObject,function()
        uimanager:ClosePanel(self)
    end)
end

function UISealTowerPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshSealTowerDataInfo, function()
        self:RefreshPanel()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshSingleSealTowerDataInfo, function(type)
        self:RefreshSingleLeague(type)
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshMainPlayerLeague()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshMainPlayerLeague()
    end)
end

function UISealTowerPanel:InitParams()
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetLeagueInfo() ~= nil then
        networkRequest.ReqUniteUnionSealTowerRank(0)
    else
        uimanager:ClosePanel(self)
    end
end
--endregion

--region 刷新
function UISealTowerPanel:Show()
    self:InitShow()
end

---刷新面板
function UISealTowerPanel:RefreshPanel()
    self:InitShow()
    if self:AnalysisParams() == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshNextRemainTime()
    self:RefreshRemainMonsterNum()
    self:RefreshLeagueList()
    self:RefreshMainPlayerLeague()
    --self:RefreshAttackMonsterBtn()
end

---初始化显示（面板在请求接收到之后显示面板）
function UISealTowerPanel:InitShow()
    if self.isInit ~= true then
        if CS.StaticUtility.IsNull(self.Panel_TweenAlpha) == false then
            self.Panel_TweenAlpha:Play()
        end
        self.isInit = true
    end
end

---解析数据
function UISealTowerPanel:AnalysisParams()
    self.remainTime = luaclass.SealTowerDataInfo:GetRemainTime()
    self.leagueTable = luaclass.SealTowerDataInfo:GetSortSealTowerLeagueData()
    if self.leagueTable == nil or type(self.leagueTable) ~= 'table' or #self.leagueTable <= 0 then
        return false
    end
    return true
end

---刷新下波/下次开启剩余时间
function UISealTowerPanel:RefreshNextRemainTime()
    self:RefreshLabel(self.MonsterTime_UILabel,luaclass.SealTowerDataInfo:GetSealTowerNextStartDes())
    self:RefreshUpdate(function()
        self:RefreshLabel(self.MonsterTime_UILabel,luaclass.SealTowerDataInfo:GetSealTowerNextStartDes())
    end)
end

---刷新剩余怪物数量
function UISealTowerPanel:RefreshRemainMonsterNum()
    self:RefreshLabel(self.MonsterNum_UILabel,luaclass.SealTowerDataInfo:GetRemainMonsterNumText())
end

---刷新联盟列表
function UISealTowerPanel:RefreshLeagueList()
    self.leagueTable = luaclass.SealTowerDataInfo:GetSortSealTowerLeagueData()
    if self.leagueTable == nil or type(self.leagueTable) ~= 'table' or #self.leagueTable <= 0 then
        return false
    end
    if self.IsInitLeagueList == true then
        self:RefreshLoopScrollViewPlusCurPage(self.LeagueList_UILoopScrollViewPlus)
    else
        self.sealTowerTemplateTable = {}
        self:RefreshLoopScrollViewPlus(self.LeagueList_UILoopScrollViewPlus,self.leagueTable,function(go,line,info)
            local template = templatemanager.GetNewTemplate(go,luaComponentTemplates.UISealTowerPanel_LeagueInfo_Normal)
            if template ~= nil then
                template:RefreshPanel({leagueInfo = info,line = line})
                self.sealTowerTemplateTable[info.type] = template
            end
        end)
    end
end

---刷新单个联盟信息
---@param
function UISealTowerPanel:RefreshSingleLeague(type)
    local sealTowerLeagueInfo = luaclass.SealTowerDataInfo:GetSealTowerLeagueData(type)
    local sealTowerLeagueTemplate = self.sealTowerTemplateTable[type]
    if sealTowerLeagueInfo ~= nil and sealTowerLeagueTemplate ~= nil then
        sealTowerLeagueTemplate:RefreshPanel({leagueInfo = sealTowerLeagueInfo})
    end
end

---刷新主角联盟信息
function UISealTowerPanel:RefreshMainPlayerLeague()
    local mainPlayerLeagueInfo = luaclass.SealTowerDataInfo:GetMainPlayerLeagueInfo()
    if mainPlayerLeagueInfo == nil then
        self:RefreshActive(self.MySacrifice_GameObject,false)
        self:RefreshActive(self.MainPlayerSacrificeTitle,false)
        return
    end
    self:RefreshActive(self.MainPlayerSacrificeTitle,true)
    if self.mainPlayerLeagueTemplate == nil and CS.StaticUtility.IsNull(self.MySacrifice_GameObject) == false then
        self.mainPlayerLeagueTemplate = templatemanager.GetNewTemplate(self.MySacrifice_GameObject,luaComponentTemplates.UISealTowerPanel_LeagueInfo_MySacrifice)
    end
    if self.mainPlayerLeagueTemplate ~= nil then
        self.mainPlayerLeagueTemplate:RefreshPanel({leagueInfo = mainPlayerLeagueInfo})
    end
end

---刷新前往击杀按钮
function UISealTowerPanel:RefreshAttackMonsterBtn()
    local monsterNum = luaclass.SealTowerDataInfo.MonsterNum
    self:RefreshActive(self.ToKillMonsterBtn_GameObject,monsterNum ~= nil and type(monsterNum) == 'number' and monsterNum > 0)
end

function ondestroy()
    UISealTowerPanel:onDestroy()
end
--endregion

return UISealTowerPanel