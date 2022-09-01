---@class UIDefKingRankSecondView 保卫国王排行榜视图二（成员）
local UIDefKingRankSecondView = {}

--region 初始化

function UIDefKingRankSecondView:Init()
    self:InitComponents()
    self:InitParameters()
    --self:BindUIMessage()
    --self:BindNetMessage()
end
--初始化变量
function UIDefKingRankSecondView:InitParameters()
    self.tempCallBack = function(item, data)
        self:RankTempCallBack(item, data)
    end
    self.rankUnitDic = {}
    self.myUnionRankInfo = {}
end

function UIDefKingRankSecondView:InitComponents()
    ---@type Top_LoopScrollView
    self.rankMiddle = self:Get("Scroll View/secondRankMiddle", "Top_LoopScrollView")
    ---@type Top_UILabel 我的排名
    self.firstValue = self:Get("secondOurRankItem/firstValue", "Top_UILabel")
    ---@type Top_UILabel 获得积分
    self.secondValue = self:Get("secondOurRankItem/secondValue", "Top_UILabel")
    ---@type Top_UILabel 扣除积分
    self.thirdValue = self:Get("secondOurRankItem/thirdValue", "Top_UILabel")
    ---@type Top_UILabel 间谍积分
    self.fouthValue = self:Get("secondOurRankItem/fouthValue", "Top_UILabel")
    ---@type Top_UILabel 总积分
    self.fifthValue = self:Get("secondOurRankItem/fifthValue", "Top_UILabel")
end

function UIDefKingRankSecondView:BindUIMessage()

end

function UIDefKingRankSecondView:BindNetMessage()

end

--endregion

--region UI

---刷新视图
function UIDefKingRankSecondView:RefreshView()
    local rankList = CS.CSScene.MainPlayerInfo.ActivityInfo.LastDefMemRankList
    self.myUnionRankInfo = {}
    local mainPlayerUnionId = CS.CSScene.MainPlayerInfo.ID
    for i = 0, rankList.Count - 1 do
        if mainPlayerUnionId == rankList[i].rid then
            self.myUnionRankInfo.unionInfo = rankList[i]
            self.myUnionRankInfo.index = i + 1
        end
    end
    self:RefreshUI()
    self:RefreshGrid(rankList)
end

---刷新UI
function UIDefKingRankSecondView:RefreshUI()
    self.firstValue.text = self.myUnionRankInfo.index == nil and '未上榜' or '第' .. self.myUnionRankInfo.index .. '名'
    self.secondValue.text = self.myUnionRankInfo.unionInfo == nil and '0' or tostring(self.myUnionRankInfo.unionInfo.acquireScore)
    self.thirdValue.text = self.myUnionRankInfo.unionInfo == nil and '0' or tostring(self.myUnionRankInfo.unionInfo.reduceScore)
    self.fouthValue.text = self.myUnionRankInfo.unionInfo == nil and '0' or tostring(self.myUnionRankInfo.unionInfo.spyScore)
    self.fifthValue.text = self.myUnionRankInfo.unionInfo == nil and '0' or tostring(self.myUnionRankInfo.unionInfo.score)
end
---刷新列表
function UIDefKingRankSecondView:RefreshGrid(rankList)
    self.rankMiddle:ResetToBegining(true)
    self.rankMiddle:Init(rankList, self.tempCallBack)
end

function UIDefKingRankSecondView:RankTempCallBack(item, data)
    local go = item.widget.gameObject
    if go == nil then
        return
    end
    local unitTemp = self.rankUnitDic[go] ~= nil and self.rankUnitDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UIDefKingRankSecondUnit)
    local temp = {}
    temp.firstSpriteName = (item.dataIndex + 1) > 3 and '' or (item.dataIndex + 1)
    temp.firstValue = (item.dataIndex + 1) > 3 and tostring(item.dataIndex + 1) or ''
    temp.secondValue = data.name
    temp.thirdValue = data.acquireScore
    temp.fouthValue = data.reduceScore
    temp.fifthValue = data.score
    temp.sixthValue = data.spyScore
    temp.callback = function()
        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
            roleId = data.rid,
            roleName = data.name
        })
    end
    unitTemp:SetTemplate(temp)
    if self.rankUnitDic[go] == nil then
        self.rankUnitDic[go] = unitTemp
    end
end

--endregion

--region UI函数监听

--endregion

--region otherFunction

function UIDefKingRankSecondView:ChangeViewState(isOpen)
    self.go:SetActive(isOpen)
end
--endregion


return UIDefKingRankSecondView