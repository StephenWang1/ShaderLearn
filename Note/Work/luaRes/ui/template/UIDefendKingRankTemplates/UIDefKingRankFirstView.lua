---@class UIDefKingRankFirstView 保卫国王排行榜视图一（帮会）
local UIDefKingRankFirstView = {}

--region 初始化

function UIDefKingRankFirstView:Init()
    self:InitParameters()
    self:InitComponents()
    self:BindUIMessage()
end
--初始化变量
function UIDefKingRankFirstView:InitParameters()
    self.tempCallBack = function(item, data)
        self:RankTempCallBack(item, data)
    end
    self.rankUnitDic = {}
    self.myUnionRankInfo = {}
end

function UIDefKingRankFirstView:InitComponents()
    ---@type Top_LoopScrollView
    self.rankMiddle = self:Get("Scroll View/firstRankMiddle", "Top_LoopScrollView")
    ---@type Top_UILabel 本帮排名
    self.firstValue = self:Get("firstOurRankItem/firstValue", "Top_UILabel")
    ---@type Top_UILabel 本帮获得积分
    self.secondValue = self:Get("firstOurRankItem/secondValue", "Top_UILabel")
    ---@type Top_UILabel 本帮被扣除积分
    self.thirdValue = self:Get("firstOurRankItem/thirdValue", "Top_UILabel")
    ---@type Top_UILabel 总积分
    self.fourthValue = self:Get("firstOurRankItem/fourthValue", "Top_UILabel")
end

function UIDefKingRankFirstView:BindUIMessage()
    -- CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    -- CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
end

--endregion

--region UI

function UIDefKingRankFirstView:RefreshView()
    local rankList = CS.CSScene.MainPlayerInfo.ActivityInfo.LastDefUnionRankList
    self.myUnionRankInfo = {}
    local mainPlayerUnionId = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID
    for i = 0, rankList.Count - 1 do
        if mainPlayerUnionId == rankList[i].unionId then
            self.myUnionRankInfo.unionInfo = rankList[i]
            self.myUnionRankInfo.index = i + 1
        end
    end
    self:RefreshUI()
    self:RefreshGrid(rankList)
end

function UIDefKingRankFirstView:RefreshUI()
    self.firstValue.text = self.myUnionRankInfo.index == nil and '未上榜' or '第' .. self.myUnionRankInfo.index .. '名'
    self.secondValue.text = self.myUnionRankInfo.unionInfo == nil and '0' or tostring(self.myUnionRankInfo.unionInfo.acquireScore)
    self.thirdValue.text = self.myUnionRankInfo.unionInfo == nil and '0' or tostring(self.myUnionRankInfo.unionInfo.reduceScore)
    self.fourthValue.text = self.myUnionRankInfo.unionInfo == nil and '0' or tostring(self.myUnionRankInfo.unionInfo.score)
end

function UIDefKingRankFirstView:RefreshGrid(rankList)
    self.rankMiddle:ResetToBegining(true)
    self.rankMiddle:Init(rankList, self.tempCallBack)
end

function UIDefKingRankFirstView:RankTempCallBack(item, data)
    local go = item.widget.gameObject
    if go == nil then
        return
    end
    ---@type UIDefKingRankFirstUnit
    local unitTemp = self.rankUnitDic[go] ~= nil and self.rankUnitDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UIDefKingRankFirstUnit)
    local temp = {}
    temp.firstSpriteName = (item.dataIndex + 1) > 3 and '' or (item.dataIndex + 1)
    temp.firstValue = (item.dataIndex + 1) > 3 and tostring(item.dataIndex + 1) or ''
    temp.secondValue = data.unionName
    temp.thirdValue = tostring(data.score)
    temp.rewardValue = data.rewards
    unitTemp:SetTemplate(temp)
    if self.rankUnitDic[go] == nil then
        self.rankUnitDic[go] = unitTemp
    end
end

--endregion

--region UI函数监听

--endregion

--region otherFunction

function UIDefKingRankFirstView:ChangeViewState(isOpen)
    self.go:SetActive(isOpen)
end

--endregion

return UIDefKingRankFirstView