---@class UIArrestPanel:UIBase 百晓生面板
local UIArrestPanel = {}

--region 局部变量
--当前类型 1：仇人 2：悬赏
UIArrestPanel.curType = 2
UIArrestPanel.mapNpcid = 0
--endregion


--region 初始化

function UIArrestPanel:Init()
    self:AddCollider()
    self:InitComponents()
    UIArrestPanel.BindUIEvents()
    UIArrestPanel.BindNetMessage()
end

--- 初始化组件
function UIArrestPanel:InitComponents()
    ---@type Top_UIGridContainer toggle组
    UIArrestPanel.ToggleList = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 仇人按钮
    UIArrestPanel.hatreToggle = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList/hatreToggle", "GameObject")
    ---@type UnityEngine.GameObject 仇人高亮
    UIArrestPanel.hatreCheck = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList/hatreToggle/check", "GameObject")
    ---@type UnityEngine.GameObject 悬赏按钮
    UIArrestPanel.arrestToggle = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList/arrestToggle", "GameObject")
    ---@type UnityEngine.GameObject 悬赏高亮
    UIArrestPanel.arrestCheck = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList/arrestToggle/check", "GameObject")
    ---@type UnityEngine.GameObject 仇人面板
    UIArrestPanel.hatredPanel = self:GetCurComp("WidgetRoot/view/UIHatredPanel", "GameObject")
    ---@type UnityEngine.GameObject 悬赏面板
    UIArrestPanel.arrestPanel = self:GetCurComp("WidgetRoot/view/UIArrestPanel", "GameObject")
    ---@type UnityEngine.Transform 关闭面板
    UIArrestPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "Transform")
end

function UIArrestPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIArrestPanel.CloseBtn.gameObject).onClick = UIArrestPanel.OnClickCloseBtn
    --点击仇人事件
    CS.UIEventListener.Get(UIArrestPanel.hatreToggle).onClick = UIArrestPanel.OnClickhatreToggle
    --点击悬赏事件
    CS.UIEventListener.Get(UIArrestPanel.arrestToggle).onClick = UIArrestPanel.OnClickarrestToggle
end

function UIArrestPanel.InitTemplates()
    local info = {}
    info.mapNpcId = UIArrestPanel.mapNpcid
    UIArrestPanel.arrestPanelViewTemplate = templatemanager.GetNewTemplate(UIArrestPanel.arrestPanel, luaComponentTemplates.UIArrestPanelViewTemplate)
    UIArrestPanel.hatrePanelViewTemplate = templatemanager.GetNewTemplate(UIArrestPanel.hatredPanel, luaComponentTemplates.UIHatredPanelViewTemplate)
    UIArrestPanel.arrestPanelViewTemplate:SetTemplate(info)
    UIArrestPanel.hatrePanelViewTemplate:SetTemplate(info)
    UIArrestPanel.hatrePanelViewTemplate:RefreshGrid()
end

function UIArrestPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResOfferListMessage, UIArrestPanel.OnResOfferListMessageCallBack)
    UIArrestPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFriendInfoMessage, UIArrestPanel.OnResFriendInfoMessageCallBack)
    UIArrestPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionMemberInfoMessage, UIArrestPanel.OnResUnionMemberInfoMessageCallBack)
    UIArrestPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_EnemyFriendLoveNumChange, UIArrestPanel.OnEnemyFriendLoveChange)
    UIArrestPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdataArrestList, UIArrestPanel.OnResOfferListMessageCallBack)
    UIArrestPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdataArrestOfID, UIArrestPanel.UpdataArrestInfo)
    UIArrestPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIArrestPanel.MainPlayerBeginWalk)
    UIArrestPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOfferMatterCodeMessage, UIArrestPanel.OnResOfferMatterCodeMessage)
end

function UIArrestPanel:Show(mapnpcid)
    if mapnpcid then
        UIArrestPanel.mapNpcid = type(mapnpcid) == 'number' and mapnpcid or mapnpcid[1] ~= nil and mapnpcid[1] or 0
    end
    UIArrestPanel.InitTemplates()
    UIArrestPanel.InitUI()
    networkRequest.ReqUnionMemberInfo()
end

--endregion

--region 函数监听

--点击关闭函数
---@param go UnityEngine.GameObject
function UIArrestPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIArrestPanel')
end

--点击仇人函数
---@param go UnityEngine.GameObject
function UIArrestPanel.OnClickhatreToggle(go)
    UIArrestPanel.curType = 1
    UIArrestPanel.RefreshTemplat()
    networkRequest.ReqOpenFriendPanel(2)
end

--点击悬赏函数
---@param go UnityEngine.GameObject
function UIArrestPanel.OnClickarrestToggle(go)
    UIArrestPanel.curType = 2
    UIArrestPanel.RefreshTemplat()
end

--endregion


--region 网络消息处理

function UIArrestPanel.MainPlayerBeginWalk()
    uimanager:ClosePanel('UIArrestPanel')
end

---返回悬赏列表消息
function UIArrestPanel.OnResOfferListMessageCallBack()
    if UIArrestPanel.curType == 2 then
        UIArrestPanel.arrestPanelViewTemplate:RefreshGrid()
    end
end

---返回仇人消息
function UIArrestPanel.OnResFriendInfoMessageCallBack(msgId, tblData, csData)
    if UIArrestPanel.curType == 1 and csData.type == 2 then
        UIArrestPanel.hatrePanelViewTemplate:RefreshGrid()
    end
end
---返回行会成员列表消息
function UIArrestPanel.OnResUnionMemberInfoMessageCallBack()
    UIArrestPanel.hatrePanelViewTemplate:RefreshGrid()
end

function UIArrestPanel.OnEnemyFriendLoveChange(msgId, info)
    if info then
        UIArrestPanel.hatrePanelViewTemplate:RefreshPlayFriendLove(info)
    end

end

function UIArrestPanel.UpdataArrestInfo(msgId, type, id)
    if id then
        UIArrestPanel.arrestPanelViewTemplate:RefreshTemplateOfID(id)
    end
end

function UIArrestPanel.OnResOfferMatterCodeMessage(id, data)
    if data then
        local panel = uimanager:GetPanel("UIPromptPanel")
        if panel == nil or panel.GetCenterButton_GameObject() == nil or not panel.isListenArrestCode then
            return
        end
        local go = panel.GetCenterButton_GameObject()

        if data.code == 1 then
            uimanager:ClosePanel('UIPromptPanel')
        elseif data.code == 10 then
            --悬赏玩家不存在
            Utility.ShowPopoTips(go, nil, 115, "UIPromptPanel")
        elseif data.code == 11 then
            --货币不足
            if UIArrestPanel.GetgoldName() then
                if UIArrestPanel.GetgoldName() then
                    local isfind, promptFramInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(137)
                    if isfind then
                        local str = string.format(promptFramInfo.content, UIArrestPanel.GetgoldName())
                        Utility.ShowPopoTips(go, str, 137, "UIPromptPanel")
                    end
                end
            end
        elseif data.code == 12 then
            --悬赏自己
            Utility.ShowPopoTips(go, str, 206, "UIPromptPanel")
        elseif data.code == 13 then
            --已悬赏
            uimanager:ClosePanel('UIPromptPanel')
        end
    end
end

--endregion

--region UI



--初始化
function UIArrestPanel.InitUI()
    UIArrestPanel.RefreshTemplat()
end

---根据type刷新显示面板
function UIArrestPanel.RefreshTemplat()
    UIArrestPanel.hatreCheck:SetActive(UIArrestPanel.curType == 1)
    UIArrestPanel.arrestCheck:SetActive(UIArrestPanel.curType == 2)
    UIArrestPanel.hatrePanelViewTemplate:SetPanelState(UIArrestPanel.curType == 1)
    UIArrestPanel.arrestPanelViewTemplate:SetPanelState(UIArrestPanel.curType == 2)
end

--endregion

--region otherFunction

function UIArrestPanel.GetgoldName()
    if UIArrestPanel.goldName == nil then
        local list = CS.Cfg_GlobalTableManager.Instance:GetNeedCoinList()
        if list.Count < 3 then
            return
        end
        local needInfo = string.Split(list[1], '#')
        local needID = tonumber(needInfo[2])

        local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(needID)
        if isFind then
            UIArrestPanel.goldName = CS.Cfg_ItemsTableManager.Instance:GetItemName(info.id)
        end
    end
    return UIArrestPanel.goldName
end

--endregion

return UIArrestPanel