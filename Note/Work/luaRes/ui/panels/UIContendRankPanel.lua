---@class UIContendRankPanel:UIBase 夺榜面板
local UIContendRankPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIContendRankPanel:Init()
    self:InitComponents()
    UIContendRankPanel.InitParameters()
    UIContendRankPanel.BindUIEvents()
    UIContendRankPanel.BindNetMessage()
    UIContendRankPanel.InitRankTemplate()
end

function UIContendRankPanel:Show(customData)
    if customData ~= nil then
        UIContendRankPanel.curContendRankid = customData.targetPage == nil and 0 or customData.targetPage
    end
    UIContendRankPanel.InitUI()
end

--- 初始化变量
function UIContendRankPanel.InitParameters()
    UIContendRankPanel.allBookMarkTemplates = {}
    UIContendRankPanel.curContendRankTbl = nil
    UIContendRankPanel.isShowRankView = false
    UIContendRankPanel.curContendRankid = 0
end

--- 初始化组件
function UIContendRankPanel:InitComponents()
    ---@type Top_UIGridContainer  页签
    UIContendRankPanel.bookMarkGrid = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject  主视图
    UIContendRankPanel.mainView = self:GetCurComp("WidgetRoot/view/MainView", "GameObject")
    ---@type UnityEngine.GameObject  排行视图
    UIContendRankPanel.rankView = self:GetCurComp("WidgetRoot/view/RankView", "GameObject")
    ---@type UnityEngine.GameObject  关闭按钮
    UIContendRankPanel.closeBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject  详情按钮
    UIContendRankPanel.detailBtn = self:GetCurComp("WidgetRoot/events/detailBtn", "GameObject")
end

function UIContendRankPanel.BindUIEvents()
    CS.UIEventListener.Get(UIContendRankPanel.closeBtn).onClick = UIContendRankPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UIContendRankPanel.detailBtn).onClick = UIContendRankPanel.OnClickDetailBtn
end

function UIContendRankPanel.BindNetMessage()
    UIContendRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLookRankMessage, UIContendRankPanel.OnResLookRankMessageCallback)
    UIContendRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIContendRankPanel.OnCommentMessage)
end

function UIContendRankPanel.InitRankTemplate()
    UIContendRankPanel.mainViewTemplate = templatemanager.GetNewTemplate(UIContendRankPanel.mainView, luaComponentTemplates.UIContendRank_MainViewTemplate)
    local data = {}
    data.timeEndCallBack = function()
        uimanager:ClosePanel("UIContendRankPanel")
    end
    UIContendRankPanel.mainViewTemplate:SetTemplate(data)
    data = {}
    data.closeCallBack = UIContendRankPanel.CloseRankCallBack
    UIContendRankPanel.rankViewTemplate = templatemanager.GetNewTemplate(UIContendRankPanel.rankView, luaComponentTemplates.UIContendRank_RankViewTemplate)
    UIContendRankPanel.rankViewTemplate:SetTemplate(data)
end

--endregion

--region 函数监听

---点击页签
function UIContendRankPanel.OnClickBookMarkCallBack(go, tblInfo)
    UIContendRankPanel.curContendRankTbl = tblInfo
    if tblInfo ~= nil then
        networkRequest.ReqLookRank(tblInfo.rankId)
        UIContendRankPanel.RefreshMainView()
        UIContendRankPanel.RefreshBookMarksStatu(tblInfo.id)
    end

end
---点击关闭
function UIContendRankPanel.OnClickCloseBtn()
    uimanager:ClosePanel("UIContendRankPanel")
end

---点击详情
function UIContendRankPanel.OnClickDetailBtn()
    UIContendRankPanel.isShowRankView = not UIContendRankPanel.isShowRankView
    UIContendRankPanel.rankViewTemplate:SetShowState(UIContendRankPanel.isShowRankView, UIContendRankPanel.curContendRankTbl)
end

--endregion

--region 网络消息处理
function UIContendRankPanel.OnResLookRankMessageCallback(id, data)
    if data then
        UIContendRankPanel.RefreshMainViewRank(data.rankId)
        UIContendRankPanel.RefreshRankViewRank(data.rankId)
        -- UIContendRankPanel.mainViewTemplate:RefreshLastRefreshTime(data.refreshTime)
    end
end

function UIContendRankPanel.OnCommentMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.PlayIsOnLine then
        if UIContendRankPanel.CurSelectTemplate == nil or CS.StaticUtility.IsNull(UIContendRankPanel.CurSelectTemplate.go) then
            return
        end
        if serverData.data == nil or serverData.data64 == nil or serverData.data64 ~= UIContendRankPanel.CurSelectTemplate.rid then
            return
        end
        --不在线
        if serverData.data == 0 then
            if UIContendRankPanel.CurSelectTemplate.promptPoint ~= nil and not CS.StaticUtility.IsNull(UIContendRankPanel.CurSelectTemplate.promptPoint) then
                Utility.ShowPopoTips(UIContendRankPanel.CurSelectTemplate.promptPoint, nil, 268, "UIContendRankPanel")
            end
            ---在线
        elseif serverData.data == 1 and UIContendRankPanel.CurSelectTemplate.rankData then
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
                roleId = UIContendRankPanel.CurSelectTemplate.rid,
                roleName = UIContendRankPanel.CurSelectTemplate.rankData.name,
                roleSex = UIContendRankPanel.CurSelectTemplate.rankData.sex,
                roleCareer = UIContendRankPanel.CurSelectTemplate.rankData.career
            })
        end
    end
end

--endregion

--region UI

function UIContendRankPanel.InitUI()
    UIContendRankPanel.InitBookMark()
    UIContendRankPanel.rankViewTemplate:SetShowState(false, UIContendRankPanel.tblInfo)
end

function UIContendRankPanel.InitBookMark()
    local showIds = CS.Cfg_ContendRankTableManager.Instance:GetMatchConditionContendRankIds()
    UIContendRankPanel.bookMarkGrid.MaxCount = showIds.Count
    for i = 0, showIds.Count - 1 do
        local go = UIContendRankPanel.bookMarkGrid.controlList[i]
        if go ~= nil then
            local template = UIContendRankPanel.allBookMarkTemplates[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIContendRank_BookMarkTemplate) or UIContendRankPanel.allBookMarkTemplates[go]
            local data = {}
            data.callBack = UIContendRankPanel.OnClickBookMarkCallBack
            data.id = showIds[i]
            if UIContendRankPanel.allBookMarkTemplates[go] == nil then
                UIContendRankPanel.allBookMarkTemplates[go] = template
            end
            template:SetTemplate(data)
        end

        if UIContendRankPanel.curContendRankid == 0 then
            if i == 0 then
                UIContendRankPanel.curContendRankid = showIds[i]
            end
        end
    end

    if UIContendRankPanel.curContendRankid ~= 0 then
        local isFind, info = CS.Cfg_ContendRankTableManager.Instance.dic:TryGetValue(UIContendRankPanel.curContendRankid)
        if isFind then
            UIContendRankPanel.curContendRankTbl = info
            networkRequest.ReqLookRank(info.rankId)
        end
        UIContendRankPanel.mainViewTemplate:RefreshView(info)
    end

    if showIds.Count > 0 then
        UIContendRankPanel.RefreshBookMarksStatu(UIContendRankPanel.curContendRankid)
    end
end

function UIContendRankPanel.RefreshMainView()
    UIContendRankPanel.mainViewTemplate:RefreshView(UIContendRankPanel.curContendRankTbl)
end

function UIContendRankPanel.RefreshMainViewRank(randTblId)
    UIContendRankPanel.mainViewTemplate:RefreshRankList(randTblId, UIContendRankPanel.curContendRankTbl)
end

function UIContendRankPanel.RefreshRankViewRank(randTblId)
    if UIContendRankPanel.isShowRankView then
        UIContendRankPanel.rankViewTemplate:RefreshView(UIContendRankPanel.curContendRankTbl)
    end
end

---刷新页签高亮状态
function UIContendRankPanel.RefreshBookMarksStatu(id)
    for i, v in pairs(UIContendRankPanel.allBookMarkTemplates) do
        v:RefreshToggleStatu(id)
    end
end

--endregion

--region otherFunction
function UIContendRankPanel.CloseRankCallBack()
    UIContendRankPanel.isShowRankView = not UIContendRankPanel.isShowRankView
end
--endregion

return UIContendRankPanel