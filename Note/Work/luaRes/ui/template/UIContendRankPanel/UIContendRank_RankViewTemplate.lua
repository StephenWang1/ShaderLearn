---@class UIContendRank_RankViewTemplate:TemplateBase 夺榜详情排行视图
local UIContendRank_RankViewTemplate = {}

---获取当前排行信息
---@return<number,rankV2.RoleRankDataInfo>
function UIContendRank_RankViewTemplate:GetCurRankList()
    if self.rankList == nil and gameMgr:GetPlayerDataMgr() ~= nil then
        self.rankList = gameMgr:GetPlayerDataMgr():GetRankData():GetCurRankTbl()
    end
    return self.rankList
end

--region 初始化

function UIContendRank_RankViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIContendRank_RankViewTemplate:InitParameters()
    ---@type TABLE.CFG_CONTEND_RANK
    self.curContendRankTbl = nil
    self.isInitOne = true
    self.isInit = true
    self.unitTemplateDic = {}
end

function UIContendRank_RankViewTemplate:InitComponents()
    ---@type UnityEngine.GameObject
    self.closeBtn = self:Get("event/CloseBtn", "GameObject")
    ---@type Top_UIGridContainer
    self.rankTopGrid = self:Get("rankTops", "Top_UIGridContainer")
    ---@type Top_LoopScrollView 列表
    self.rankMiddle = self:Get("view/Scroll View/firstRankMiddle", "UILoopScrollViewPlus")

    self.RankTempCallBack = function(go, line)
        return self:ContendRankTempCallBack(go, line)
    end
end

function UIContendRank_RankViewTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.closeBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.closeBtn).OnClickLuaDelegate = self.OnCloseBtnClick
end


--endregion

--region Show

function UIContendRank_RankViewTemplate:SetTemplate(data)
    self.closeCallBack = data.closeCallBack
end

function UIContendRank_RankViewTemplate:SetShowState(isOpen, tbl)
    self.go:SetActive(isOpen)
    self.curContendRankTbl = tbl
    if isOpen then
        self:RefreshView()
    end
end

function UIContendRank_RankViewTemplate:RefreshView(tbl)
    if tbl ~= nil then
        self.curContendRankTbl = tbl
    end
    self:RefreshTop()
    self:RefreshRankList()
end

function UIContendRank_RankViewTemplate:RefreshTop()
    if self.curContendRankTbl == nil then
        return
    end
    local content = string.Split(self.curContendRankTbl.content, "#")
    for i = 1, #content do
        self.rankTopGrid.MaxCount = i
        local goLabel = CS.Utility_Lua.GetComponent(self.rankTopGrid.controlList[i - 1].transform:Find("rankTop"), "Top_UILabel")
        if goLabel then
            goLabel.text = content[i]
        end
    end
    self:RefreshTopPos()
end

function UIContendRank_RankViewTemplate:RefreshTopPos()
    local posList = self.curContendRankTbl.secondTopPos.list
    for i = 0, posList.Count - 1 do
        local go = self.rankTopGrid.controlList[i]
        if go then
            go.transform.localPosition = CS.UnityEngine.Vector3(posList[i], 1, 0)
        end
    end
end

function UIContendRank_RankViewTemplate:RefreshRankList()
    self.myRankItemTemplat = nil
    self.rankList = nil
    if self.isInitOne then
        self.isInitOne = false
        self.rankMiddle:Init(self.RankTempCallBack)
    else
        self.rankMiddle:ResetPage()
    end
end

---设置数据
function UIContendRank_RankViewTemplate:ContendRankTempCallBack(go, line)
    if self:GetCurRankList() == nil or #self:GetCurRankList() == 0 or go == nil or self.curContendRankTbl == nil or #self:GetCurRankList() - 1 - 3 < line then
        return false
    end
    --不显示前三名数据
    local index = line + 3
    local data = self:GetCurRankList()[index + 1]
    ---@type UIContendRank_UnitTemplate
    local rankTemp = self.unitTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIContendRank_UnitTemplate) or self.unitTemplateDic[go]
    local temp = {}
    temp.rankIndex = index + 1
    temp.rankConfigId = self.curContendRankTbl.rankId
    temp.rankInfo = data.roleRankInfo
    temp.wifeRankInfo = data.wifeRankInfo
    temp.servantRankInfo = data.servantRankInfo
    temp.damageItemRankInfo = data.damageItemRankInfo
    temp.rid = data.roleRankInfo.uid
    temp.tblInfo = self.curContendRankTbl
    temp.isMain = false
    temp.ClickGoCallBack = function()
        if self.curUnitTemplate ~= nil then
            if self.curUnitTemplate.rid == temp.rid then
                return
            end
            self.curUnitTemplate:SetChoseHightState(false)
        end
        rankTemp:SetChoseHightState(true)
        self.curUnitTemplate = rankTemp
    end
    temp.useTemplate = uiStaticParameter.UIRankManager:GetLuaClassOfContendRankType(self.curContendRankTbl.rankId, true)
    rankTemp:SetChoseHightState(self.curUnitTemplate ~= nil and self.curUnitTemplate.rid == temp.rid)
    rankTemp:SetTemplate(temp)
    if self.unitTemplateDic[go] == nil then
        self.unitTemplateDic[go] = rankTemp
    end
    --if list[line].roleRankInfo.uid == CS.CSScene.MainPlayerInfo.ID then
    --    self.myRankItemTemplat = rankTemp
    --end
    return true
end

--endregion


--region UI函数监听

function UIContendRank_RankViewTemplate:OnCloseBtnClick()
    self:SetShowState(false)
    if self.closeCallBack ~= nil then
        self.closeCallBack()
    end
end


--endregion


--region otherFunction



--endregion

--region ondestroy

function UIContendRank_RankViewTemplate:onDestroy()

end

--endregion

return UIContendRank_RankViewTemplate