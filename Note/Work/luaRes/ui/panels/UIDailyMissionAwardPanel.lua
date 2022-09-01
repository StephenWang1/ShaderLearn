---日常任务买卖对话框
local UIDailyMissionAwardPanel = {}

--region 局部变量
UIDailyMissionAwardPanel.taskNpcid = 0
UIDailyMissionAwardPanel.npcPanelId = 0
UIDailyMissionAwardPanel.btnType = -1
--endregion
--region 初始化
function UIDailyMissionAwardPanel:Init()
    self:InitComponents()
    UIDailyMissionAwardPanel.BindUIEvents()
    UIDailyMissionAwardPanel.BindNetMessage()
end
---@param
function UIDailyMissionAwardPanel:Show(id, taskNpcid, npcConfigId, npcId, btntype)
    if id then
        UIDailyMissionAwardPanel.taskNpcid = taskNpcid
        UIDailyMissionAwardPanel.btnType = btntype == nil and -1 or btntype
        UIDailyMissionAwardPanel.npcPanelId = id
        UIDailyMissionAwardPanel.InitUI(id)
        --UIDailyMissionAwardPanel.OpenTaskPanel()
    else
        uimanager:ClosePanel('UIDailyMissionAwardPanel')
    end
end

--- 初始化组件
function UIDailyMissionAwardPanel:InitComponents()

    ---@type Top_UILabel top
    UIDailyMissionAwardPanel.lb_name = self:GetCurComp("WidgetRoot/view/lb_name", "Top_UILabel")
    ---@type Top_UILabel 对话内容
    UIDailyMissionAwardPanel.lb_describe = self:GetCurComp("WidgetRoot/view/lb_describe", "Top_UILabel")
    ---@type Top_UIGridContainer btn列表
    UIDailyMissionAwardPanel.BtnList = self:GetCurComp("WidgetRoot/view/Daily/BtnList", "Top_UIGridContainer")
    ---@type UIPanel
    UIDailyMissionAwardPanel.DailyUIPanel = self:GetCurComp("WidgetRoot/view/Daily", "UIPanel")
    ---@type UnityEngine.GameObject
    UIDailyMissionAwardPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
end

function UIDailyMissionAwardPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIDailyMissionAwardPanel.btn_close).onClick = function()
        uimanager:ClosePanel('UIDailyMissionAwardPanel')
    end
end

function UIDailyMissionAwardPanel.BindNetMessage()
    --UIDailyMissionAwardPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_TaskNpcDepartureView, UIDailyMissionAwardPanel.TaskNpcDepartureView)
    UIDailyMissionAwardPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIDailyMissionAwardPanel.MainPlayerBeginWalk)
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end
--endregion
--region 函数监听
function UIDailyMissionAwardPanel.OnClickBtnCallBack(go, btnInfo)
    if btnInfo.type == 1 then
        UIDailyMissionAwardPanel.CreatePanel(btnInfo.panelName, nil, UIDailyMissionAwardPanel.taskNpcid)
    elseif btnInfo.type == 2 then
        UIDailyMissionAwardPanel.CreatePanel(btnInfo.panelName, nil, { type = btnInfo.param, isOpenBag = true, showID = UIDailyMissionAwardPanel.npcPanelId })
    elseif btnInfo.type == 3 then
        UIDailyMissionAwardPanel.CreatePanel(btnInfo.panelName, nil, btnInfo.param)
    elseif btnInfo.type == 4 then
        UIDailyMissionAwardPanel.CreatePanel(btnInfo.panelName, nil, btnInfo.param)
    elseif btnInfo.type == 6 then
        uimanager:ClosePanel(UIDailyMissionAwardPanel)
    elseif btnInfo.type == 7 then
        --比奇传送盟重
        networkRequest.ReqDeliverByConfig(CS.Cfg_GlobalTableManager.Instance.BiQiDeliveID)
        uimanager:ClosePanel(UIDailyMissionAwardPanel)
    elseif btnInfo.type == 8 then
        --盟重传送比奇
        networkRequest.ReqDeliverByConfig(CS.Cfg_GlobalTableManager.Instance.MengZhongDeliveID)
        uimanager:ClosePanel(UIDailyMissionAwardPanel)
    end
    uimanager:ClosePanel('UIDailyMissionAwardPanel')
end

---根据参数创建界面,panelName可能为界面名,也可能为[Jump]101之类的jumpID或者其他
function UIDailyMissionAwardPanel.CreatePanel(panelName, action, param)
    if #panelName > 6 and string.lower(string.sub(panelName, 1, 6)) == "[jump]" then
        ---jump表ID
        ---@type number
        local jumpID = tonumber(string.sub(panelName, 7))
        if param == nil or type(param) ~= "table" then
            param = {}
        end
        uiTransferManager:TransferToPanel(jumpID, param, action)
        return
    end
    uimanager:CreatePanel(panelName, nil, param)
end

function UIDailyMissionAwardPanel.ShowEffect(go, btnInfo)
    if btnInfo == nil then
        return
    end
    if btnInfo.type == 1 then
        if UIDailyMissionAwardPanel.taskNpcid then
            local missionNpcID, csmission = CS.CSMissionManager.Instance:IsTaskNpc(UIDailyMissionAwardPanel.taskNpcid, false)
            if csmission ~= nil then
                if go ~= nil then
                    go.gameObject:SetActive(csmission.IsSubmit and csmission.IsNeedBuy == false)
                end
            end
        end
    end
end
--endregion
--region 网络消息处理
function UIDailyMissionAwardPanel.MainPlayerBeginWalk()
    uimanager:ClosePanel('UIDailyMissionAwardPanel')
end

--endregion
--region UI
---@param viewInfo.Top string
---@param viewInfo.Des string
function UIDailyMissionAwardPanel.InitUI(id)
    local isFind, info = CS.Cfg_NpcPanelTableManager.Instance.NpcPanelViewDic:TryGetValue(id)
    if isFind then
        UIDailyMissionAwardPanel.lb_name.text = info.title
        UIDailyMissionAwardPanel.lb_describe.text = info.des
        UIDailyMissionAwardPanel.InitBtnGrid(info.btnList)
    end
end

function UIDailyMissionAwardPanel.InitBtnGrid(btns)
    local length = btns.Count - 1
    for i = 0, length do
        UIDailyMissionAwardPanel.BtnList.MaxCount = btns.Count
        local go = UIDailyMissionAwardPanel.BtnList.controlList[i]
        if go == nil then
            return
        end
        local btnLabel = CS.Utility_Lua.GetComponent(go.transform:Find('label'), "Top_UILabel")
        local effect = go.transform:Find('effect')
        if btnLabel then
            btnLabel.text = btns[i].btnStr
        end
        if UIDailyMissionAwardPanel.btnType == btns[i].type then
            UIDailyMissionAwardPanel.OnClickBtnCallBack(go, btns[i])
            return
        end
        UIDailyMissionAwardPanel.ShowEffect(effect, btns[i])
        --添加委托
        CS.UIEventListener.Get(go).onClick = nil
        CS.UIEventListener.Get(go).onClick = function(go)
            UIDailyMissionAwardPanel.OnClickBtnCallBack(go, btns[i])
        end
    end
    local count = btns.Count
    if count >= 3 then
        local pos = UIDailyMissionAwardPanel.BtnList.transform.localPosition
        UIDailyMissionAwardPanel.BtnList.transform.localPosition = { x = pos.x, y = UIDailyMissionAwardPanel.DailyUIPanel.clipOffset.y - UIDailyMissionAwardPanel.BtnList.CellHeight * (count - 3) * 0.5, z = pos.z }
    end
end

--endregion
--region otherFunction
function UIDailyMissionAwardPanel.OpenTaskPanel()
    uimanager:CreatePanel("UISpecialMissionPanel", nil, UIDailyMissionAwardPanel.taskNpcid)
end

--endregion
--region ondestroy
function ondestroy()
    if UIDailyMissionAwardPanel.ReleaseClientEventHandler ~= nil then
        UIDailyMissionAwardPanel:ReleaseClientEventHandler()
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion
return UIDailyMissionAwardPanel