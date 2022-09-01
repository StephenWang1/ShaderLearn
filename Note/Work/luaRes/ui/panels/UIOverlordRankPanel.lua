---@class UIOverlordRankPanel:UIBase 霸业（行会排行榜）
local UIOverlordRankPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIOverlordRankPanel:Init()
    networkRequest.ReqSendAllUnionInfo()
    self:InitComponents()
    UIOverlordRankPanel.InitParameters()
    UIOverlordRankPanel.BindUIEvents()
    UIOverlordRankPanel.BindNetMessage()
    UIOverlordRankPanel.InitRankTemplate()
end

function UIOverlordRankPanel:Show(customData)
    if customData ~= nil then
        UIOverlordRankPanel.curId = customData.targetPage == nil and 0 or customData.targetPage
    end
    UIOverlordRankPanel.InitUI()
end

--- 初始化变量
function UIOverlordRankPanel.InitParameters()
    UIOverlordRankPanel.allBookMarkTemplates = {}
    UIOverlordRankPanel.curRankTbl = nil
    UIOverlordRankPanel.curId = 0
end

--- 初始化组件
function UIOverlordRankPanel:InitComponents()
    ---@type Top_UIGridContainer  页签
    UIOverlordRankPanel.bookMarkGrid = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject  主视图
    UIOverlordRankPanel.mainView = self:GetCurComp("WidgetRoot/view/MainView", "GameObject")
    ---@type UnityEngine.GameObject  详情排行
    UIOverlordRankPanel.rankView = self:GetCurComp("WidgetRoot/view/RankView", "GameObject")
    ---@type UnityEngine.GameObject  关闭按钮
    UIOverlordRankPanel.closeBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.Transform
    UIOverlordRankPanel.lowPoint = self:GetCurComp("WidgetRoot/view/MainView/lowPoint", "Transform")
    ---@type UnityEngine.Transform
    UIOverlordRankPanel.hightPoint = self:GetCurComp("WidgetRoot/view/MainView/hightPoint", "Transform")
end

function UIOverlordRankPanel.BindUIEvents()
    CS.UIEventListener.Get(UIOverlordRankPanel.closeBtn).onClick = UIOverlordRankPanel.OnClickCloseBtn
end

function UIOverlordRankPanel.BindNetMessage()
    UIOverlordRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIOverlordRankPanel.OnCommentMessage)
    UIOverlordRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionBattleMessage, UIOverlordRankPanel.OnResUnionBattleMessage)
    UIOverlordRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLeaderGloryMessage, UIOverlordRankPanel.OnResLeaderGloryMessage)
    UIOverlordRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPositionInfoMessage, UIOverlordRankPanel.OnResPositionInfoMessage)
    UIOverlordRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResReturnRewardStateMessage, UIOverlordRankPanel.OnResReturnRewardStateMessage)
    UIOverlordRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionAchievementMessage, UIOverlordRankPanel.OnResUnionAchievementMessage)

end

function UIOverlordRankPanel.InitRankTemplate()

    UIOverlordRankPanel.mainViewTemplate = templatemanager.GetNewTemplate(UIOverlordRankPanel.mainView, luaComponentTemplates.UIOverlordRank_MainViewTemplate)
    local data = {}
    -- data.targetViewClass = uiStaticParameter.UIRankManager:GetLuaViewClassOfLeaderRankId(UIOverlordRankPanel.curId)
    data.timeEndCallBack = function()
        uimanager:ClosePanel("UIOverlordRankPanel")
    end
    UIOverlordRankPanel.mainViewTemplate:SetTemplate(data)
    UIOverlordRankPanel.miniRankViewTemplate = templatemanager.GetNewTemplate(UIOverlordRankPanel.rankView, luaComponentTemplates.UIOverlordRank_MiniRankTemplate)
end


--endregion

--region 函数监听

---点击关闭
function UIOverlordRankPanel.OnClickCloseBtn()
    uimanager:ClosePanel("UIOverlordRankPanel")
end

---点击页签
function UIOverlordRankPanel.OnClickBookMarkCallBack(go, tblInfo)
    UIOverlordRankPanel.miniRankViewTemplate:SetShowState(false)
    if tblInfo ~= nil and UIOverlordRankPanel.curId ~= tblInfo.id then
        UIOverlordRankPanel.curOverlordRankTbl = tblInfo
        UIOverlordRankPanel.curId = tblInfo.id
        networkRequest.ReqGetMeritData(tblInfo.id)
        -- networkRequest.ReqLookRank(tblInfo.rankId)
        UIOverlordRankPanel.RefreshMainView()
        UIOverlordRankPanel.RefreshBookMarksStatu(tblInfo.id)
    end
end

--endregion

--region 网络消息处理

---行会之争
function UIOverlordRankPanel.OnResUnionBattleMessage()
    if UIOverlordRankPanel.curId ~= 1 then
        return
    end
    UIOverlordRankPanel.RefreshRankView()

end

---领袖之路
function UIOverlordRankPanel.OnResLeaderGloryMessage()
    if UIOverlordRankPanel.curId ~= 2 then
        return
    end
    UIOverlordRankPanel.RefreshRankView()
end

---建功立业
function UIOverlordRankPanel.OnResUnionAchievementMessage()
    if UIOverlordRankPanel.curId ~= 3 then
        return
    end
    UIOverlordRankPanel.RefreshRankView()
end

---迷你视图
function UIOverlordRankPanel.OnResPositionInfoMessage(id, tblData, csData)
    if tblData and UIOverlordRankPanel.miniRankViewTemplate ~= nil then
        UIOverlordRankPanel.miniRankViewTemplate:RefreshRankView(csData.leader)
        UIOverlordRankPanel.curRankTbl = nil
    end
end

function UIOverlordRankPanel.OnResReturnRewardStateMessage(id, tblData)
    if tblData then
        if UIOverlordRankPanel.mainViewTemplate ~= nil then
            UIOverlordRankPanel.mainViewTemplate:RefreshSingleRankRewardState(tblData.subtype)
        end
    end
end

function UIOverlordRankPanel.OnCommentMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.PlayIsOnLine then
        if UIOverlordRankPanel.curRankTbl == nil or CS.StaticUtility.IsNull(UIOverlordRankPanel.curRankTbl.go) then
            return
        end
        if UIOverlordRankPanel.curRankTbl.rankData == nil then
            return
        end
        if serverData.data == nil or serverData.data64 == nil or serverData.data64 ~= UIOverlordRankPanel.curRankTbl.rankData.rid then
            return
        end
        ---不在线
        if serverData.data == 0 then
            if UIOverlordRankPanel.curRankTbl:GetPlayerName() ~= nil and not CS.StaticUtility.IsNull(UIOverlordRankPanel.curRankTbl:GetPlayerName()) then
                Utility.ShowPopoTips(UIOverlordRankPanel.curRankTbl:GetPlayerName(), nil, 268, "UIRankPanel")
            end
            ---在线
        elseif serverData.data == 1 then
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
                roleId = UIOverlordRankPanel.curRankTbl.rankData.rid,
                roleName = UIOverlordRankPanel.curRankTbl.rankData.name,
                roleSex = UIOverlordRankPanel.curRankTbl.rankData.sex,
            })
        end
    end
end

--endregion

--region UI

function UIOverlordRankPanel.InitUI()
    UIOverlordRankPanel.InitBookMark()
    UIOverlordRankPanel.miniRankViewTemplate:SetShowState(false)
end

function UIOverlordRankPanel.InitBookMark()
    local showIds = CS.Cfg_OverlordTableManager.Instance:GetMatchConditionContendRankIds()
    UIOverlordRankPanel.bookMarkGrid.MaxCount = showIds.Count
    for i = 0, showIds.Count - 1 do
        local go = UIOverlordRankPanel.bookMarkGrid.controlList[i]
        if go ~= nil then
            local template
            if UIOverlordRankPanel.allBookMarkTemplates[go] == nil then
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIOverlordRank_BookMarkTemplate)
                UIOverlordRankPanel.allBookMarkTemplates[go] = template
            else
                template = UIOverlordRankPanel.allBookMarkTemplates[go]
            end
            local data = {}
            data.callBack = UIOverlordRankPanel.OnClickBookMarkCallBack
            data.id = showIds[i]
            template:SetTemplate(data)
        end
        if UIOverlordRankPanel.curId == 0 then
            if i == 0 then
                UIOverlordRankPanel.curId = showIds[i]
            end
        end
    end

    if UIOverlordRankPanel.curId ~= 0 then
        --请求排行榜数据
        local isFind, info = CS.Cfg_OverlordTableManager.Instance.dic:TryGetValue(UIOverlordRankPanel.curId)
        if isFind then
            UIOverlordRankPanel.curOverlordRankTbl = info
            networkRequest.ReqGetMeritData(UIOverlordRankPanel.curId)
        end
        UIOverlordRankPanel.RefreshMainView()
    end

    if showIds.Count > 0 then
        UIOverlordRankPanel.RefreshBookMarksStatu(UIOverlordRankPanel.curId)
    end
end

---刷新页签高亮状态
function UIOverlordRankPanel.RefreshBookMarksStatu(id)
    for i, v in pairs(UIOverlordRankPanel.allBookMarkTemplates) do
        v:RefreshToggleStatu(id)
    end
end

---刷新排行面板
function UIOverlordRankPanel.RefreshMainView()
    if UIOverlordRankPanel.mainViewTemplate ~= nil then
        local data = {}
        data.curTbl = UIOverlordRankPanel.curOverlordRankTbl
        data.targetViewClass = uiStaticParameter.UIRankManager:GetLuaViewClassOfLeaderRankId(UIOverlordRankPanel.curId)
        UIOverlordRankPanel.mainViewTemplate:RefreshView(data)
    end
end

function UIOverlordRankPanel.RefreshRankView()
    if UIOverlordRankPanel.mainViewTemplate ~= nil then
        UIOverlordRankPanel.mainViewTemplate:RefreshOverlordRannkList()
    end
end

--刷新迷你视图ui
function UIOverlordRankPanel.RefreshMiniRankState()

end

--endregion
--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCommonMessage, UIOverlordRankPanel.OnCommentMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUnionBattleMessage, UIOverlordRankPanel.OnResUnionBattleMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLeaderGloryMessage, UIOverlordRankPanel.OnResLeaderGloryMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPositionInfoMessage, UIOverlordRankPanel.OnResPositionInfoMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResReturnRewardStateMessage, UIOverlordRankPanel.OnResReturnRewardStateMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUnionAchievementMessage, UIOverlordRankPanel.OnResUnionAchievementMessage)
end

--endregion

return UIOverlordRankPanel