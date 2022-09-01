---@class UIContendRankMainPanel:UIBase 新夺榜及霸业 综合面板
local UIContendRankMainPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIContendRankMainPanel:Init()
    self:InitComponents()
    UIContendRankMainPanel.InitParameters()
    UIContendRankMainPanel.BindUIEvents()
    UIContendRankMainPanel.InitPageView()
end

--- 初始化变量
function UIContendRankMainPanel.InitParameters()
    ---@type table<UnityEngine.GameObject,UIContendRankMain_BookMarkTemplate>
    UIContendRankMainPanel.allBookMarkTemplates = {}
    ---@type number
    UIContendRankMainPanel.curPageId = nil
    ---@type number
    UIContendRankMainPanel.curPageType = nil
end

--- 初始化组件
function UIContendRankMainPanel:InitComponents()
    ---@type UnityEngine.GameObject 面板父节点
    UIContendRankMainPanel.panelRoot = self:GetCurComp("WidgetRoot/view", "GameObject")
    ---@type Top_UIGridContainer 页签列表
    UIContendRankMainPanel.pageList = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 关闭按钮
    UIContendRankMainPanel.closeBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
end

function UIContendRankMainPanel.BindUIEvents()
    CS.UIEventListener.Get(UIContendRankMainPanel.closeBtn).onClick = UIContendRankMainPanel.OnClickCloseBtn
end

--endregion

--region 函数监听

function UIContendRankMainPanel.OnClickCloseBtn()
    uimanager:ClosePanel("UIContendRankMainPanel")
    uimanager:ClosePanel("UIContendRankPanel")
    uimanager:ClosePanel("UIOverlordRankPanel")
end

---页签点击回调
---@param data RankPageInfo
function UIContendRankMainPanel.OnClickBookMarkCallBack(data)
    if data == nil then
        return
    end
    if UIContendRankMainPanel.curPageId == data.id then
        return
    end
    UIContendRankMainPanel.curPageId = data.id
    UIContendRankMainPanel.RefreshBookMarksStatu(data.id)
    local contendRankPanel = uimanager:GetPanel("UIContendRankPanel")
    local overlordRankPanel = uimanager:GetPanel("UIOverlordRankPanel")
    local panelData = { targetPage = data.panelParam }
    if data.pageType == 0 then
        if contendRankPanel then
            contendRankPanel:Show(panelData)
            if contendRankPanel.IsHiden then
                uimanager:ReShowPanel(contendRankPanel)
            end
        else
            uimanager:CreatePanel("UIContendRankPanel", function(panel)
                if panel then
                    if panel.go ~= nil and not CS.StaticUtility.IsNull(panel.go) then
                        panel.go.transform:SetParent(UIContendRankMainPanel.panelRoot.transform)
                    end
                end
            end, panelData)
        end

        if overlordRankPanel then
            uimanager:HidePanel(overlordRankPanel)
        end
    else
        if overlordRankPanel then
            overlordRankPanel:Show(panelData)
            if overlordRankPanel.IsHiden then
                uimanager:ReShowPanel(overlordRankPanel)
            end
        else
            uimanager:CreatePanel("UIOverlordRankPanel", function(panel)
                if panel then
                    if panel.go ~= nil and not CS.StaticUtility.IsNull(panel.go) then
                        panel.go.transform:SetParent(UIContendRankMainPanel.panelRoot.transform)
                    end
                end
            end, panelData)
        end

        if contendRankPanel then
            uimanager:HidePanel(contendRankPanel)
        end
    end
end

--endregion

--region UI

function UIContendRankMainPanel.InitPageView()
    ---@type<number, ContendMainRankPageInfo>
    local pages = UIContendRankMainPanel.GetPageInfoList()
    UIContendRankMainPanel.pageList.MaxCount = #pages
    for i = 1, #pages do
        local go = UIContendRankMainPanel.pageList.controlList[i - 1]
        if go then
            local template = UIContendRankMainPanel.allBookMarkTemplates[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIContendRankMain_BookMarkTemplate) or UIContendRankMainPanel.allBookMarkTemplates[go]
            local data = {}
            data.callBack = UIContendRankMainPanel.OnClickBookMarkCallBack
            local data = {}
            data.pageData = pages[i]
            data.callBack = function()
                UIContendRankMainPanel.OnClickBookMarkCallBack(data.pageData)
            end
            template:SetTemplate(data)
            if UIContendRankMainPanel.allBookMarkTemplates[go] == nil then
                UIContendRankMainPanel.allBookMarkTemplates[go] = template
            end
        end
    end
    UIContendRankMainPanel.OnClickBookMarkCallBack(pages[1])
end

--endregion

--region otherFunctionb

function UIContendRankMainPanel.GetPageInfoList()
    local pages = {}
    local contendShowIds = CS.Cfg_ContendRankTableManager.Instance:GetMatchConditionContendRankIds()
    local overlordShowIds = CS.Cfg_OverlordTableManager.Instance:GetMatchConditionContendRankIds()
    local contendMaxCount, overlordMaxCount = contendShowIds.Count - 1, overlordShowIds.Count - 1
    local id, lid, isFind, contendRankTbl, overlordRankTbl
    lid = 1
    for i = 0, contendMaxCount do
        id = contendShowIds[i]
        isFind, contendRankTbl = CS.Cfg_ContendRankTableManager.Instance:TryGetValue(id)
        if isFind then
            ---@class RankPageInfo
            local pageInfo = {
                id = lid,
                str = contendRankTbl.title,
                pageType = 0,
                panelParam = id,
                hotFlag = contendRankTbl.hotFlag,
                redEnum = nil
            }
            table.insert(pages, pageInfo)
            lid = lid + 1
        end
    end
    for i = 0, overlordMaxCount do
        id = overlordShowIds[i]
        isFind, overlordRankTbl = CS.Cfg_OverlordTableManager.Instance:TryGetValue(id)
        if isFind then
            ---@type RankPageInfo
            local pageInfo = {
                id = lid,
                str = overlordRankTbl.tabName,
                pageType = 1,
                panelParam = id,
                hotFlag = nil,
                redEnum = 23000 + id
            }
            table.insert(pages, pageInfo)
            lid = lid + 1
        end
    end
    return pages
end

function UIContendRankMainPanel.RefreshBookMarksStatu(id)
    for i, v in pairs(UIContendRankMainPanel.allBookMarkTemplates) do
        v:RefreshToggleStatu(id)
    end
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIContendRankMainPanel
