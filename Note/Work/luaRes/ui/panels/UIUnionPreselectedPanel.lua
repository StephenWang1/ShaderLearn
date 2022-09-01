---@class UIUnionPreselectedPanel:UIBase 联盟预选面板
local UIUnionPreselectedPanel = {}

--region 局部变量

---当前投票类型
---private
function UIUnionPreselectedPanel.GetVoteLeagueType()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetLeagueInfo():GetTodayLeagueVoteType()
    end
    return 0
end

--endregion

--region 初始化

function UIUnionPreselectedPanel:Init()
    self:InitComponents()
    UIUnionPreselectedPanel.InitParameters()
    UIUnionPreselectedPanel.BindUIEvents()
    UIUnionPreselectedPanel.BindNetMessage()
    ---请求联盟投票信息
    networkRequest.ReqCommon(luaEnumReqServerCommonType.CountType, luaEnumLeagueInfoMsgType.ThatDayLeagueVoteType, nil, nil)
    networkRequest.ReqAllOtherWillJoinUniteUnion()
end

--- 初始化变量
function UIUnionPreselectedPanel.InitParameters()
    UIUnionPreselectedPanel.allLeagueTemplateDic = {}
    UIUnionPreselectedPanel.allTemplateDic = {}
end

--- 初始化组件
function UIUnionPreselectedPanel:InitComponents()
    ---@type UICountdownLabel 倒计时文本
    UIUnionPreselectedPanel.timeCountDown = self:GetCurComp("WidgetRoot/Panel/UnionList/Scroll View/time", "UICountdownLabel")
    ---@type UIGridContainer 联盟列表
    UIUnionPreselectedPanel.grid = self:GetCurComp("WidgetRoot/Panel/UnionList/Scroll View/Grid", "UIGridContainer")
    ---@type UnityEngine.GameObject 查看详情按钮
    UIUnionPreselectedPanel.detailBtn = self:GetCurComp("WidgetRoot/event/detailBtn", "GameObject")
    ---@type UnityEngine.GameObject 帮助按钮
    UIUnionPreselectedPanel.btn_help = self:GetCurComp("WidgetRoot/event/btn_help", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIUnionPreselectedPanel.closeBtn = self:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")

    --region 投票详情
    ---@type UILoopScrollViewPlus 投票排行榜
    UIUnionPreselectedPanel.rankMiddle = self:GetCurComp("WidgetRoot/voteView/rank/Scroll View/rankMiddle", "UILoopScrollViewPlus")
    ---@type Top_UIGridContainer
    UIUnionPreselectedPanel.topGrid = self:GetCurComp("WidgetRoot/voteView/rankTops", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject
    UIUnionPreselectedPanel.noRank = self:GetCurComp("WidgetRoot/voteView/noRank", "GameObject")
    --endregion

    ---@type UIScrollViewArrow
    UIUnionPreselectedPanel.arrowPanel = self:GetCurComp("WidgetRoot/voteView/rank/arrowPanel", "UIScrollViewArrow")
end

function UIUnionPreselectedPanel.BindUIEvents()
    CS.UIEventListener.Get(UIUnionPreselectedPanel.detailBtn).onClick = UIUnionPreselectedPanel.OnDetailBtnClickCallBack
    CS.UIEventListener.Get(UIUnionPreselectedPanel.btn_help).onClick = UIUnionPreselectedPanel.OnHelpBtnClickCallBack
    CS.UIEventListener.Get(UIUnionPreselectedPanel.closeBtn).onClick = UIUnionPreselectedPanel.OnCloseBtnClickCallBack
end

function UIUnionPreselectedPanel.BindNetMessage()
    UIUnionPreselectedPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIUnionPreselectedPanel.OnResCommonMessageCallBack)
    ---投票详情排行榜
    UIUnionPreselectedPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshAllLeagueUnionRankInfo, UIUnionPreselectedPanel.OnAllWillUnionMessageCallBack)

end
--endregion

--region 函数监听

---点击帮助按钮回调
---@param go UnityEngine.GameObject
function UIUnionPreselectedPanel.OnHelpBtnClickCallBack(go)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(173)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---点击查看详情按钮回调
---@param go UnityEngine.GameObject
function UIUnionPreselectedPanel.OnDetailBtnClickCallBack(go)
    uimanager:CreatePanel("UIUnionPreselectedVotePanel", nil)
end

---点击关闭按钮回调
---@param go UnityEngine.GameObject
function UIUnionPreselectedPanel.OnCloseBtnClickCallBack(go)
    uimanager:ClosePanel("UIUnionPreselectedPanel")
end

--endregion

--region 网络消息处理

---返回所有服所有联服同盟投票
---@private
function UIUnionPreselectedPanel.OnAllWillUnionMessageCallBack()
    UIUnionPreselectedPanel.curVoteList = {}
    UIUnionPreselectedPanel.RefreshRankMiddle()
end

function UIUnionPreselectedPanel.OnResCommonMessageCallBack(id, tblData)
    if tblData == nil then
        return
    end
    if tblData.type == LuaEnumCommonMsgType.CountType then
        ---当天联盟投票类型
        if tblData.data == luaEnumLeagueInfoMsgType.ThatDayLeagueVoteType then
            ---投票联盟类型
            UIUnionPreselectedPanel.InitUI()
        end
    elseif tblData.type == LuaEnumCommonMsgType.LeagueVoteResult then
        ---联盟投票结果
        if tblData.data64 == 1 then
            gameMgr:GetPlayerDataMgr():GetLeagueInfo():SetTodayLeagueVoteType(tblData.data)
            ---成功
            UIUnionPreselectedPanel.RefreshVoteInfo()
        end
    end
end

--endregion

--region UI

function UIUnionPreselectedPanel.InitUI()
    local leagueList = clientTableManager.cfg_leagueManager:GetSortedLeagueList()
    ---初始化联盟列表
    UIUnionPreselectedPanel.grid.MaxCount = #leagueList
    for i = 1, #leagueList do
        local go = UIUnionPreselectedPanel.grid.controlList[i - 1]
        if go then
            local info = {}
            info.bgABStr = leagueList[i]:GetPainting() == nil and "" or leagueList[i]:GetPainting()
            info.curVoteType = UIUnionPreselectedPanel.GetVoteLeagueType()
            info.curLeagueType = leagueList[i]:GetId() == nil and 0 or leagueList[i]:GetId()
            local temp
            if UIUnionPreselectedPanel.allLeagueTemplateDic[go] == nil then
                temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIUnionPreselectedPanel_UnitTemplate)
                UIUnionPreselectedPanel.allLeagueTemplateDic[go] = temp
            else
                temp = UIUnionPreselectedPanel.allLeagueTemplateDic[go]
            end
            temp:SetTemplate(info)
        end
    end
    UIUnionPreselectedPanel.InitTime()
    UIUnionPreselectedPanel.InitTops()
end

function UIUnionPreselectedPanel.InitTime()
    local beginTime, endTime = gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetUnionVoteTimeData()
    UIUnionPreselectedPanel.timeCountDown:StartCountDown(nil, 8, endTime, luaEnumColorType.Red1,
            "后公布预选结果", nil, UIUnionPreselectedPanel.TimeEndCallBack)
end

---刷新投票情况
function UIUnionPreselectedPanel.RefreshVoteInfo()
    for i, v in pairs(UIUnionPreselectedPanel.allLeagueTemplateDic) do
        v:RefreshVoteState(UIUnionPreselectedPanel.GetVoteLeagueType())
    end
end

--region 投票详情

function UIUnionPreselectedPanel.InitTops()
    local tops = LuaGlobalTableDeal:GetLeagueVoteTops()
    UIUnionPreselectedPanel.topGrid.MaxCount = #tops
    for i = 1, #tops do
        local go = UIUnionPreselectedPanel.topGrid.controlList[i - 1]
        if go then
            local label = CS.Utility_Lua.Get(go.transform, "Label", "Top_UILabel")
            local bg = CS.Utility_Lua.Get(go.transform, "Sprite", "Top_UISprite")
            local arrow = CS.Utility_Lua.Get(go.transform, "arrow", "UISprite")
            local boxcollider = CS.Utility_Lua.GetComponent(go.transform, "BoxCollider")
            label.text = tops[i].str
            bg.width = tops[i].width
            arrow.gameObject:SetActive(tops[i].isShowArrow)
            arrow:UpdateAnchors()
            go.transform.localPosition = { x = tops[i].posX, y = 0, z = 0 }
            local origion = boxcollider.size
            boxcollider.size = { x = tops[i].width, y = origion.y }
            CS.UIEventListener.Get(go).onClick = function(go)
                UIUnionPreselectedPanel.OnTopBtnClickCallBack(bg, tops[i].type)
            end

            if tops[i].type == LuaEnumLeagueComponentType.prosperity then
                UIUnionPreselectedPanel.OnTopBtnClickCallBack(bg, tops[i].type)
            end
        end
    end
end

---点击榜顶回调
---@param type number
function UIUnionPreselectedPanel.OnTopBtnClickCallBack(bg, type)
    if UIUnionPreselectedPanel.curSelectType == type then
        return
    end
    if UIUnionPreselectedPanel.IsComponentTypeNeedSort(type) then
        UIUnionPreselectedPanel.curSelectType = type
        ---设置背景高亮
        if UIUnionPreselectedPanel.curSelectTopBg then
            UIUnionPreselectedPanel.curSelectTopBg.spriteName = "ActivityRank_ourside_titlebg1"
        end
        if bg then
            bg.spriteName = 'ActivityRank_ourside_titlebg'
            UIUnionPreselectedPanel.curSelectTopBg = bg
        end
        ---根据type 排序刷新列表
        UIUnionPreselectedPanel.RefreshRankMiddle()
    end
end

function UIUnionPreselectedPanel.RefreshRankMiddle()
    ---@type table<number,UnionVoteInfo>
    UIUnionPreselectedPanel.curVoteList = UIUnionPreselectedPanel.GetSortedList()
    UIUnionPreselectedPanel.noRank:SetActive(#UIUnionPreselectedPanel.curVoteList == 0)
    if not UIUnionPreselectedPanel.IsInitialized then
        UIUnionPreselectedPanel.IsInitialized = true
        UIUnionPreselectedPanel.rankMiddle:Init(UIUnionPreselectedPanel.RankTempCallBack)
    else
        UIUnionPreselectedPanel.rankMiddle:ResetPage()
    end
    UIUnionPreselectedPanel.arrowPanel:InitMaxCount(#UIUnionPreselectedPanel.curVoteList)
end

function UIUnionPreselectedPanel.RankTempCallBack(go, line)
    if go == nil or #UIUnionPreselectedPanel.curVoteList < line + 1 then
        return false
    end
    local template = {}
    if UIUnionPreselectedPanel.allTemplateDic[go] == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIUnionPreselectedVotePanel_UnitTemplate)
    else
        template = UIUnionPreselectedPanel.allTemplateDic[go]
    end
    template:SetTemplate({
        ---@type UnionVoteInfo
        unionVoteInfo = UIUnionPreselectedPanel.curVoteList[line + 1],
        otherData = {
            rank = line + 1,
        },
    })
    return true
end

--endregion

--endregion

--region otherFunction

function UIUnionPreselectedPanel.TimeEndCallBack()
    uimanager:ClosePanel("UIUnionPreselectedPanel")
    -- uimanager:ClosePanel("UIUnionPreselectedVotePanel")
end

--region 投票详情

---获取联盟投票排行榜信息
---@private
---@return table<number,UnionVoteInfo>
function UIUnionPreselectedPanel.GetLeagueVoteRankInfo()
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetLeagueInfo() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetLeagueInfo():GetAllWillLeagueVoteRankInfo()
    end
    return nil
end

---获取排序后的列表
function UIUnionPreselectedPanel.GetSortedList()
    local tbl = {}
    if UIUnionPreselectedPanel.GetLeagueVoteRankInfo() ~= nil then
        tbl = UIUnionPreselectedPanel.GetLeagueVoteRankInfo()
        table.sort(tbl, UIUnionPreselectedPanel.SortData)
    end
    return tbl
end

---排序规则
function UIUnionPreselectedPanel.SortData(l, r)
    if l == nil or r == nil then
        return false
    end
    if UIUnionPreselectedPanel.curSelectType == LuaEnumLeagueComponentType.pepoleCount then
        return l.unionCount > r.unionCount
    elseif UIUnionPreselectedPanel.curSelectType == LuaEnumLeagueComponentType.FreeCount then
        return l.freeCount > r.freeCount
    elseif UIUnionPreselectedPanel.curSelectType == LuaEnumLeagueComponentType.GloryCount then
        return l.gloryCount > r.gloryCount
    elseif UIUnionPreselectedPanel.curSelectType == LuaEnumLeagueComponentType.CourageCount then
        return l.courageCount > r.courageCount
    elseif UIUnionPreselectedPanel.curSelectType == LuaEnumLeagueComponentType.FearlessCount then
        return l.fearlessCount > r.fearlessCount
    elseif UIUnionPreselectedPanel.curSelectType == LuaEnumLeagueComponentType.prosperity then
        return l.prosperityNum > r.prosperityNum
    end
    return false
end

---是否需要重新排序刷新页面
---@return boolean
function UIUnionPreselectedPanel.IsComponentTypeNeedSort(type)
    return type == LuaEnumLeagueComponentType.pepoleCount or
            type == LuaEnumLeagueComponentType.FreeCount or
            type == LuaEnumLeagueComponentType.GloryCount or
            type == LuaEnumLeagueComponentType.CourageCount or
            type == LuaEnumLeagueComponentType.FearlessCount or
            type == LuaEnumLeagueComponentType.prosperity
end

--endregion

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIUnionPreselectedPanel