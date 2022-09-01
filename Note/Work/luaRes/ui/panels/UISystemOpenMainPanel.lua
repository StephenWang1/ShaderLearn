---@class UISystemOpenMainPanel:UIBase 系统预告及变强
local UISystemOpenMainPanel = {}


--region 初始化

function UISystemOpenMainPanel:Init()
    self:InitComponents()
    UISystemOpenMainPanel.InitParameters()
    UISystemOpenMainPanel.BindUIEvents()
end

--- 初始化变量
function UISystemOpenMainPanel.InitParameters()
    ---@type table<UnityEngine.GameObject,UIBookMarkBaseTempate>
    UISystemOpenMainPanel.allBookMarkTemplates = {}
    ---@type number
    UISystemOpenMainPanel.curPageId = nil
    ---@type number
    UISystemOpenMainPanel.curPageType = nil

    UISystemOpenMainPanel.curPages = nil
end

--- 初始化组件
function UISystemOpenMainPanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭按钮
    UISystemOpenMainPanel.closeBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type Top_UIGridContainer 页签
    UISystemOpenMainPanel.pageList = self:GetCurComp("WidgetRoot/events/toggles", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 面板父节点
    UISystemOpenMainPanel.panelRoot = self:GetCurComp("WidgetRoot/view", "GameObject")

end

function UISystemOpenMainPanel.BindUIEvents()
    CS.UIEventListener.Get(UISystemOpenMainPanel.closeBtn).onClick = UISystemOpenMainPanel.OnClickCloseBtn
end

function UISystemOpenMainPanel.BindNetMessage()
    UISystemOpenMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleSystemPreviewMessage, UISystemOpenMainPanel.onResSystemPreviewCallBack)
    UISystemOpenMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.SystemOpenReminderMessage, UISystemOpenMainPanel.onResSystemOpenChangedCallBack)
end

function UISystemOpenMainPanel.Show(customData)
    if customData ~= nil then
        UISystemOpenMainPanel.curPageType = customData.targetPageType
    end
    UISystemOpenMainPanel.InitPageView()
end

--endregion

--region 函数监听

function UISystemOpenMainPanel.OnClickCloseBtn()
    uimanager:ClosePanel("UIStrongerPanel")
    uimanager:ClosePanel("UISystemOpenPanel")
    uimanager:ClosePanel("UISystemOpenMainPanel")
end

---页签点击回调
---@param data RankPageInfo
function UISystemOpenMainPanel.OnClickBookMarkCallBack(data)
    if data == nil then
        return
    end
    if UISystemOpenMainPanel.curPageId == data.id then
        return
    end
    UISystemOpenMainPanel.curPageId = data.id
    UISystemOpenMainPanel.SwitchPanel(data)
    UISystemOpenMainPanel.RefreshBookMarksStatu(data.id)
end

--endregion

--region 网络消息处理

function UISystemOpenMainPanel.onResSystemPreviewCallBack()
    local pages = UISystemOpenMainPanel.GetPageInfoList()
    if #pages ~= #UISystemOpenMainPanel.pages then
        UISystemOpenMainPanel.InitPageView()
    end
end

function UISystemOpenMainPanel.onResSystemOpenChangedCallBack()
    local pages = UISystemOpenMainPanel.GetPageInfoList()
    if #pages ~= #UISystemOpenMainPanel.pages then
        UISystemOpenMainPanel.InitPageView()
    end
end
--endregion

--region UI

function UISystemOpenMainPanel.InitPageView()
    ---@type<number, ContendMainRankPageInfo>
    UISystemOpenMainPanel.pages = UISystemOpenMainPanel.GetPageInfoList()

    local targetIndex = 1
    UISystemOpenMainPanel.pageList.MaxCount = #UISystemOpenMainPanel.pages
    for i = 1, #UISystemOpenMainPanel.pages do
        local go = UISystemOpenMainPanel.pageList.controlList[i - 1]
        if go then
            local template = UISystemOpenMainPanel.allBookMarkTemplates[go] == nil and
                    templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBookMarkBaseTempate) or UISystemOpenMainPanel.allBookMarkTemplates[go]
            local data = {}
            data.callBack = UISystemOpenMainPanel.OnClickBookMarkCallBack
            local data = {}
            data.pageData = UISystemOpenMainPanel.pages[i]
            data.callBack = function()
                UISystemOpenMainPanel.OnClickBookMarkCallBack(data.pageData)
            end
            template:SetTemplate(data)
            if UISystemOpenMainPanel.allBookMarkTemplates[go] == nil then
                UISystemOpenMainPanel.allBookMarkTemplates[go] = template
            end
            if UISystemOpenMainPanel.curPageType ~= nil and UISystemOpenMainPanel.curPageType == UISystemOpenMainPanel.pages[i].type then
                targetIndex = i
            end
        end
    end
    if UISystemOpenMainPanel.pages[targetIndex] ~= nil then
        UISystemOpenMainPanel.OnClickBookMarkCallBack(UISystemOpenMainPanel.pages[targetIndex])
    end
end

--endregion

--region otherFunction

---获得页签视图信息
---@return table<number,RankPageInfo>
function UISystemOpenMainPanel.GetPageInfoList()
    local pages = {}
    local systemTbl = gameMgr:GetPlayerDataMgr():GetSystemPreviewMgr():GetSystemPerviewTbl()
    if #systemTbl > 0 then
        ---@type RankPageInfo
        local pageInfo = {
            id = 0,
            str = "系统预告",
            pageType = LuaEnumSystemPageType.System,
            redEnum = "SystemPreview"
        }
        table.insert(pages, pageInfo)
    end
    if Utility.CheckSystemOpenState(84) then
        local pageInfo = {
            id = 1,
            str = "变强",
            pageType = LuaEnumSystemPageType.Stronge,
            redEnum = nil
        }
        table.insert(pages, pageInfo)
    end
    return pages
end

---刷新页签状态
function UISystemOpenMainPanel.RefreshBookMarksStatu(id)
    for i, v in pairs(UISystemOpenMainPanel.allBookMarkTemplates) do
        v:RefreshToggleStatu(id)
    end
end

---切换界面
function UISystemOpenMainPanel.SwitchPanel(data)
    ---@type UIStrongerPanel
    local strongerPanel = uimanager:GetPanel("UIStrongerPanel")
    ---@type UISystemOpenPanel
    local systemOpenPanel = uimanager:GetPanel("UISystemOpenPanel")
    if data.pageType == LuaEnumSystemPageType.Stronge then
        if strongerPanel then
            if strongerPanel.IsHiden then
                uimanager:ReShowPanel(strongerPanel)
            end
            strongerPanel:ResetView()
        else
            uimanager:CreatePanel("UIStrongerPanel", function(panel)
                if panel then
                    if panel.go ~= nil and not CS.StaticUtility.IsNull(panel.go) then
                        panel.go.transform:SetParent(UISystemOpenMainPanel.panelRoot.transform)
                    end
                end
            end)
        end

        if systemOpenPanel then
            uimanager:HidePanel(systemOpenPanel)
        end
    else
        if systemOpenPanel then
            if systemOpenPanel.IsHiden then
                uimanager:ReShowPanel(systemOpenPanel)
            end
            systemOpenPanel.ResetView()
        else
            uimanager:CreatePanel("UISystemOpenPanel", function(panel)
                if panel then
                    if panel.go ~= nil and not CS.StaticUtility.IsNull(panel.go) then
                        panel.go.transform:SetParent(UISystemOpenMainPanel.panelRoot.transform)
                    end
                end
            end)
        end

        if strongerPanel then
            uimanager:HidePanel(strongerPanel)
        end
    end
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UISystemOpenMainPanel