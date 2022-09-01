---@class UIForgeQuenchListPanel:UIBase
local UIForgeQuenchListPanel = {}

---@return LuaForgeQuenchDataManager
function UIForgeQuenchListPanel.GetForgeQuenchMgr()
    if UIForgeQuenchListPanel.mForgeQuenchMgr == nil then
        UIForgeQuenchListPanel.mForgeQuenchMgr = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr()
    end
    return UIForgeQuenchListPanel.mForgeQuenchMgr
end

--region 初始化

function UIForgeQuenchListPanel:Init()
    self:InitComponents()
    UIForgeQuenchListPanel.InitParameters()
    UIForgeQuenchListPanel.BindNetMessage()
end

--- 初始化变量
function UIForgeQuenchListPanel.InitParameters()
    UIForgeQuenchListPanel.curMainPageType = 0
    ---@type table<UnityEngine.GameObject,UIForgeQuenchListPanel_FirstPageTemplate>
    UIForgeQuenchListPanel.GoAndTemplateDic = {}
    ---@type table<number,UnityEngine.GameObject>
    UIForgeQuenchListPanel.TypeAndGoDic = {}

    UIForgeQuenchListPanel.isInitializedPage = false
end

--- 初始化组件
function UIForgeQuenchListPanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭按钮
    UIForgeQuenchListPanel.closeBtn = self:GetCurComp("", "GameObject")
    ---@type Top_UIScrollView
    UIForgeQuenchListPanel.scrollView = self:GetCurComp("WidgetRoot/view/ScrollView", "Top_UIScrollView")
    ---@type Top_UIGridContainer 页签Grid
    UIForgeQuenchListPanel.pageGrid = self:GetCurComp("WidgetRoot/view/ScrollView/PageGrid", "Top_UIGridContainer")
    ---@type Top_UITable 页签Table
    UIForgeQuenchListPanel.pageTable = self:GetCurComp("WidgetRoot/view/ScrollView/PageGrid", "Top_UITable")
end

function UIForgeQuenchListPanel.BindNetMessage()
    UIForgeQuenchListPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCuiLianMessage, UIForgeQuenchListPanel.OnResCuiLianMessage)
end

function UIForgeQuenchListPanel:Show()
    UIForgeQuenchListPanel.InitPageView()
end

--endregion

--region 函数监听

function UIForgeQuenchListPanel.OnClickCloseBtn()
    uimanager:ClosePanel("UIForgeQuenchingItemListPanel")
end

function UIForgeQuenchListPanel.OnPageClickCallBack(type)
    UIForgeQuenchListPanel.curMainPageType = type
    UIForgeQuenchListPanel.RefreshPageState()
end

function UIForgeQuenchListPanel.OnSecondPageClickCallBack(type)
    UIForgeQuenchListPanel.RefreshPageGridState(type)
end

--endregion

--region 网络消息处理

---淬炼结果回调
function UIForgeQuenchListPanel.OnResCuiLianMessage(msgId, tblData)
    if tblData == nil then
        return
    end

    if tblData.state == 1 then
        UIForgeQuenchListPanel.ResetView()
    end
end

--endregion

--region UI

function UIForgeQuenchListPanel.InitPageView()
    local pageTbl = UIForgeQuenchListPanel.GetForgeQuenchMgr():GetForgeQuenchPageTblInfo()
    local count, pageType = #pageTbl, 0
    UIForgeQuenchListPanel.pageGrid.MaxCount = count
    for i = 1, count do
        local go = UIForgeQuenchListPanel.pageGrid.controlList[i - 1]
        if go then
            local template = UIForgeQuenchListPanel.GoAndTemplateDic[go]
            if template == nil then
                ---@type UIForgeQuenchListPanel_FirstPageTemplate
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIForgeQuenchListPanel_FirstPageTemplate)
                UIForgeQuenchListPanel.GoAndTemplateDic[go] = template
            end
            template:SetTemplate({
                pageInfo = pageTbl[i],
                callBack = UIForgeQuenchListPanel.OnPageClickCallBack,
                clickSecondPageCallBack = UIForgeQuenchListPanel.OnSecondPageClickCallBack
            })
            pageType = pageTbl[i].type
            UIForgeQuenchListPanel.TypeAndGoDic[pageType] = go

            if not UIForgeQuenchListPanel.isInitializedPage then
                UIForgeQuenchListPanel.isInitializedPage = template:InitShowListView()
            end
        end
    end
end

function UIForgeQuenchListPanel.RefreshPageState()
    for i, v in pairs(UIForgeQuenchListPanel.GoAndTemplateDic) do
        v:ChangeState(UIForgeQuenchListPanel.curMainPageType)
    end
    UIForgeQuenchListPanel.scrollView:Reposition()
    UIForgeQuenchListPanel.pageTable:Reposition()
end

function UIForgeQuenchListPanel.RefreshPageGridState(type)
    for i, v in pairs(UIForgeQuenchListPanel.GoAndTemplateDic) do
        v:ChangeGridState(type)
    end
end

function UIForgeQuenchListPanel.ResetView()
    UIForgeQuenchListPanel.curMainPageType = 0
    for i, v in pairs(UIForgeQuenchListPanel.GoAndTemplateDic) do
        v:ResetView()
    end
    UIForgeQuenchListPanel.scrollView:Reposition()
    UIForgeQuenchListPanel.pageTable:Reposition()
end

--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()

end

--endregion

return UIForgeQuenchListPanel