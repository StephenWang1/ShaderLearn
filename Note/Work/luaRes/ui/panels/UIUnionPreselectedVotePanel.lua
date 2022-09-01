---@class UIUnionPreselectedVotePanel:UIBase 投票排行榜详情面板
local UIUnionPreselectedVotePanel = {}

--region 初始化

function UIUnionPreselectedVotePanel:Init()
    self:InitComponents()
    UIUnionPreselectedVotePanel.InitParameters()
    UIUnionPreselectedVotePanel.BindUIEvents()
    UIUnionPreselectedVotePanel.BindNetMessage()
    UIUnionPreselectedVotePanel.InitUI()
    networkRequest.ReqAllOtherWillJoinUniteUnion()
end

--- 初始化变量
function UIUnionPreselectedVotePanel.InitParameters()
    UIUnionPreselectedVotePanel.curSelectType = 0
    UIUnionPreselectedVotePanel.curSelectTopBg = nil
    UIUnionPreselectedVotePanel.allTemplateDic = {}
    UIUnionPreselectedVotePanel.IsInitialized = false
    UIUnionPreselectedVotePanel.curAllWillInfo = {}
end

--- 初始化组件
function UIUnionPreselectedVotePanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭按钮
    UIUnionPreselectedVotePanel.closeBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UILoopScrollViewPlus 投票排行榜
    UIUnionPreselectedVotePanel.rankMiddle = self:GetCurComp("WidgetRoot/panel/rankView/Scroll View/rankMiddle", "UILoopScrollViewPlus")
    ---@type Top_UIGridContainer
    UIUnionPreselectedVotePanel.topGrid = self:GetCurComp("WidgetRoot/panel/rankTops", "Top_UIGridContainer")
end

function UIUnionPreselectedVotePanel.BindUIEvents()
    CS.UIEventListener.Get(UIUnionPreselectedVotePanel.closeBtn).onClick = UIUnionPreselectedVotePanel.OnCloseBtnClickCallBack
end

function UIUnionPreselectedVotePanel.BindNetMessage()
    UIUnionPreselectedVotePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshAllLeagueUnionRankInfo, UIUnionPreselectedVotePanel.OnAllWillUnionMessageCallBack)
end
--endregion

--region 函数监听
---点击关闭按钮回调
---@param go UnityEngine.GameObject
function UIUnionPreselectedVotePanel.OnCloseBtnClickCallBack(go)
    uimanager:ClosePanel("UIUnionPreselectedVotePanel")
end

---点击榜顶回调
---@param type number
function UIUnionPreselectedVotePanel.OnTopBtnClickCallBack(bg, type)
    if UIUnionPreselectedVotePanel.curSelectType == type then
        return
    end
    if UIUnionPreselectedVotePanel.IsComponentTypeNeedSort(type) then
        UIUnionPreselectedVotePanel.curSelectType = type
        ---设置背景高亮
        if UIUnionPreselectedVotePanel.curSelectTopBg then
            UIUnionPreselectedVotePanel.curSelectTopBg.spriteName = "ActivityRank_ourside_titlebg1"
        end
        if bg then
            bg.spriteName = 'ActivityRank_ourside_titlebg'
            UIUnionPreselectedVotePanel.curSelectTopBg = bg
        end
        ---根据type 排序刷新列表
        UIUnionPreselectedVotePanel.RefreshRankMiddle()
    end
end

--endregion


--region 网络消息处理

---返回所有服所有联服同盟投票
---@private
function UIUnionPreselectedVotePanel.OnAllWillUnionMessageCallBack()
    UIUnionPreselectedVotePanel.curVoteList = {}
    UIUnionPreselectedVotePanel.RefreshRankMiddle()
end

--endregion

--region UI

function UIUnionPreselectedVotePanel.InitUI()
    UIUnionPreselectedVotePanel.InitTops()
end

function UIUnionPreselectedVotePanel.InitTops()
    local tops = LuaGlobalTableDeal:GetLeagueVoteTops()
    UIUnionPreselectedVotePanel.topGrid.MaxCount = #tops
    for i = 1, #tops do
        local go = UIUnionPreselectedVotePanel.topGrid.controlList[i - 1]
        if go then
            local label = CS.Utility_Lua.Get(go.transform, "Label", "Top_UILabel")
            local bg = CS.Utility_Lua.Get(go.transform, "Sprite", "Top_UISprite")
            local arrow = CS.Utility_Lua.Get(go.transform, "arrow", "GameObject")
            local boxcollider = CS.Utility_Lua.GetComponent(go.transform, "BoxCollider")
            label.text = tops[i].str
            bg.width = tops[i].width
            arrow:SetActive(tops[i].isShowArrow)
            go.transform.localPosition = { x = tops[i].posX, y = 0, z = 0 }
            local origion = boxcollider.size
            boxcollider.size = { x = tops[i].width, y = origion.y }
            CS.UIEventListener.Get(go).onClick = function(go)
                UIUnionPreselectedVotePanel.OnTopBtnClickCallBack(bg, tops[i].type)
            end

            if tops[i].type == LuaEnumLeagueComponentType.prosperity then
                UIUnionPreselectedVotePanel.OnTopBtnClickCallBack(bg, tops[i].type)
            end
        end
    end
end

function UIUnionPreselectedVotePanel.RefreshRankMiddle()
    ---@type table<number,UnionVoteInfo>
    UIUnionPreselectedVotePanel.curVoteList = UIUnionPreselectedVotePanel.GetSortedList()
    if not UIUnionPreselectedVotePanel.IsInitialized then
        UIUnionPreselectedVotePanel.IsInitialized = true
        UIUnionPreselectedVotePanel.rankMiddle:Init(UIUnionPreselectedVotePanel.RankTempCallBack)
    else
        UIUnionPreselectedVotePanel.rankMiddle:ResetPage()
    end
end

function UIUnionPreselectedVotePanel.RankTempCallBack(go, line)
    if go == nil or #UIUnionPreselectedVotePanel.curVoteList < line + 1 then
        return false
    end
    local template = {}
    if UIUnionPreselectedVotePanel.allTemplateDic[go] == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIUnionPreselectedVotePanel_UnitTemplate)
    else
        template = UIUnionPreselectedVotePanel.allTemplateDic[go]
    end
    template:SetTemplate({
        ---@type UnionVoteInfo
        unionVoteInfo = UIUnionPreselectedVotePanel.curVoteList[line + 1],
        otherData = {
            rank = line + 1,
        },
    })
    return true
end

--endregion

--region otherFunction

---获取联盟投票排行榜信息
---@private
---@return table<number,UnionVoteInfo>
function UIUnionPreselectedVotePanel.GetLeagueVoteRankInfo()
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetLeagueInfo() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetLeagueInfo():GetAllWillLeagueVoteRankInfo()
    end
    return nil
end

---获取排序后的列表
function UIUnionPreselectedVotePanel.GetSortedList()
    local tbl = {}
    if UIUnionPreselectedVotePanel.GetLeagueVoteRankInfo() ~= nil then
        tbl = UIUnionPreselectedVotePanel.GetLeagueVoteRankInfo()
        table.sort(tbl, UIUnionPreselectedVotePanel.SortData)
    end
    return tbl
end

---排序规则
function UIUnionPreselectedVotePanel.SortData(l, r)
    if l == nil or r == nil then
        return false
    end
    if UIUnionPreselectedVotePanel.curSelectType == LuaEnumLeagueComponentType.pepoleCount then
        return l.unionCount > r.unionCount
    elseif UIUnionPreselectedVotePanel.curSelectType == LuaEnumLeagueComponentType.FreeCount then
        return l.freeCount > r.freeCount
    elseif UIUnionPreselectedVotePanel.curSelectType == LuaEnumLeagueComponentType.GloryCount then
        return l.gloryCount > r.gloryCount
    elseif UIUnionPreselectedVotePanel.curSelectType == LuaEnumLeagueComponentType.CourageCount then
        return l.courageCount > r.courageCount
    elseif UIUnionPreselectedVotePanel.curSelectType == LuaEnumLeagueComponentType.FearlessCount then
        return l.fearlessCount > r.fearlessCount
    elseif UIUnionPreselectedVotePanel.curSelectType == LuaEnumLeagueComponentType.prosperity then
        return l.prosperityNum > r.prosperityNum
    end
    return false
end

---是否需要重新排序刷新页面
---@return boolean
function UIUnionPreselectedVotePanel.IsComponentTypeNeedSort(type)
    return type == LuaEnumLeagueComponentType.pepoleCount or
            type == LuaEnumLeagueComponentType.FreeCount or
            type == LuaEnumLeagueComponentType.GloryCount or
            type == LuaEnumLeagueComponentType.CourageCount or
            type == LuaEnumLeagueComponentType.FearlessCount or
            type == LuaEnumLeagueComponentType.prosperity
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIUnionPreselectedVotePanel