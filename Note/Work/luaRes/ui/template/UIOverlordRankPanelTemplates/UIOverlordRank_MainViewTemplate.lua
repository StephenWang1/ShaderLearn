---@class UIOverLordRank_MainViewTemplate:UIContendRank_MainViewTemplate  霸业主视图
local UIOverlordRank_MainViewTemplate = {}

--region Show
function UIOverlordRank_MainViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end

--初始化变量
function UIOverlordRank_MainViewTemplate:InitParameters()
    self.timeEndCallBack = nil
    self.curUnitTemplate = nil
    self.myRankItemTemplat = nil
    self.curTbl = 0
    self.rankInfo = CS.CSScene.MainPlayerInfo.RankInfoV2
    self.unitTemplateDic = {}
end

function UIOverlordRank_MainViewTemplate:InitComponents()
    ---@type Top_UILabel
    self.countdown = self:Get("time", "UICountdownLabel")
    ---@type Top_UILabel
    self.lastRefreshTime = self:Get("lastRefreshTime", "UICountdownLabel")
    ---@type Top_UISprite
    self.sprite = self:Get("sprite", "Top_UISprite")
    ---@type Top_UILabel
    self.decs = self:Get("Decs", "Top_UILabel")
    ---@type UILoopScrollViewPlus
    self.rankGrid = self:Get("Scroll View/firstRankGrid", "UILoopScrollViewPlus")
    ---@type Top_UIGridContainer
    self.topGrid = self:Get("background/rankTops", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject
    self.topBG = self:Get("background", "GameObject")
    ---@type UIScrollView
    self.ScrollView = self:Get("Scroll View", "UIScrollView")
    ---@type SpringPanel
    self.scrollViewSpring = self:Get("Scroll View", "SpringPanel")
end

---@param data.timeEndCallBack function 倒计时完毕回调
---@param data.targetViewClass     table
function UIOverlordRank_MainViewTemplate:SetTemplate(data)
    if data then
        self.timeEndCallBack = data.timeEndCallBack

        local _, time = CS.Cfg_OverlordTableManager.Instance:GetRemainTime()

        self.countdown:StartCountDown(nil, 8, time, luaEnumColorType.TimeCountRed, "后结束", nil, self.timeEndCallBack)
    end
end

function UIOverlordRank_MainViewTemplate:RefreshView(data)
    if data then
        if self.curViewClass ~= nil then
            self.curViewClass:Destory()
        end
        ---@type luaobject
        self.curViewClass = data.targetViewClass:New()

        self.curOverlordTbl = data.curTbl
        self.curViewClass:Show(self)
    end
end

function UIOverlordRank_MainViewTemplate:RefreshOverlordRannkList()
    if self.curViewClass ~= nil then
        self.curViewClass:RefreshRankView()
    end
end

function UIOverlordRank_MainViewTemplate:RefreshSingleRankRewardState(subType)
    if self.curViewClass ~= nil then
        self.curViewClass:RefreshSingleRankRewardState(subType)
    end
end

function UIOverlordRank_MainViewTemplate:RefreshLastRefreshTime(time)
    if time then
        self.lastRefreshTime:StopCountDown()
        self.lastRefreshTime:StartCountBySecond(nil, 7, math.ceil(time / 1000), luaEnumColorType.TimeCountRed .. '距离下次刷新', "[-]", nil, nil)
    end
end


--endregion


--region UI函数监听

--endregion


--region otherFunction



--endregion

--region ondestroy

function UIOverlordRank_MainViewTemplate:onDestroy()
    if self.curViewClass ~= nil then
        self.curViewClass:Destory()
    end
end

--endregion

return UIOverlordRank_MainViewTemplate