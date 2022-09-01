---@class UISecretBookTipsPanel:UIBase
local UISecretBookTipsPanel = {}


--region 初始化
function UISecretBookTipsPanel:Init()
    self:InitComponents()
    UISecretBookTipsPanel.InitOther()
    UISecretBookTipsPanel.BindUIEvent()
    UISecretBookTipsPanel.BindNetEvent()
end

function UISecretBookTipsPanel:InitComponents()

    ---@type Top_UISprite 左侧贴图
    UISecretBookTipsPanel.leftSprite = self:GetCurComp("WidgetRoot/Tip/leftSprite", "Top_UISprite")
    ---@type Top_UISprite 右侧贴图
    UISecretBookTipsPanel.rightSprite = self:GetCurComp("WidgetRoot/Tip/rightSprite", "Top_UISprite")
    ---@type Top_UILabel 文字描述
    UISecretBookTipsPanel.Label = self:GetCurComp("WidgetRoot/Tip/Label", "Top_UILabel")

    --- 按钮
    UISecretBookTipsPanel.Btn = self:GetCurComp("WidgetRoot/Tip/Label/Btn", "GameObject")
    ---按钮描述
    UISecretBookTipsPanel.BtnLabel = self:GetCurComp("WidgetRoot/Tip/Label/Btn/Label", "Top_UILabel")

    ---@type Top_TweenAlpha tween组件
    UISecretBookTipsPanel.Tip = self:GetCurComp("WidgetRoot/Tip", "Top_TweenAlpha")
    ---@type TipWidget
    UISecretBookTipsPanel.TipWidget = self:GetCurComp("WidgetRoot/Tip", "Top_UIWidget")
    ---@type UIPanel
    UISecretBookTipsPanel.panel_UIPanel = CS.Utility_Lua.GetComponent(self.go, "UIPanel")

    ---@type UICheatPushLinkConnector
    UISecretBookTipsPanel.TipConnector = self:GetCurComp("WidgetRoot/Tip", "UICheatPushLinkConnector")

    UISecretBookTipsPanel.startLayer = UISecretBookTipsPanel.panel_UIPanel.depth

    UISecretBookTipsPanel.Tip1 = self:GetCurComp("WidgetRoot/Tip1", "GameObject")
    UISecretBookTipsPanel.Tip1Btn = self:GetCurComp("WidgetRoot/Tip1/leftSprite", "GameObject")
    UISecretBookTipsPanel.Tip1Label = self:GetCurComp("WidgetRoot/Tip1/Label", "Top_UILabel")
    UISecretBookTipsPanel.Tip1Close = self:GetCurComp("WidgetRoot/Tip1/close", "GameObject")
end

function UISecretBookTipsPanel.InitOther()
    ---1 配置ID
    UISecretBookTipsPanel.configID = nil
    ---2 父物体
    UISecretBookTipsPanel.parent = nil
    ---3 偏移量
    UISecretBookTipsPanel.excursion = nil
    ---4 描述
    UISecretBookTipsPanel.des = nil
    ---5 方向
    UISecretBookTipsPanel.direction = nil
    ---6 依附面板
    UISecretBookTipsPanel.dependPanel = ""
    ---显示时间
    UISecretBookTipsPanel.showTime = 5
end

---1 配置ID
---2 父物体
---3 方向
---3 other
function UISecretBookTipsPanel:Show(customData)
    if customData == nil then
        if isOpenLog then
            luaDebug.Log("参数为空")
        end
        UISecretBookTipsPanel.HidePanelWhatever()
        return
    end
    UISecretBookTipsPanel.ShowBubbleTips(customData)
end

--endregion
--region 绑定UI事件
function UISecretBookTipsPanel.BindUIEvent()
    CS.UIEventListener.Get(UISecretBookTipsPanel.Btn).onClick = UISecretBookTipsPanel.OnClickBtnCallBack
    CS.UIEventListener.Get(UISecretBookTipsPanel.Tip1Btn).onClick = UISecretBookTipsPanel.OnClickBtnCallBack
    CS.UIEventListener.Get(UISecretBookTipsPanel.Tip1Close).onClick = UISecretBookTipsPanel.OnClickTip1Close
end

--endregion
--region 绑定消息事件
function UISecretBookTipsPanel.BindNetEvent()
    UISecretBookTipsPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ClosePanel, UISecretBookTipsPanel.ConstraintHidePanel)
    UISecretBookTipsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_CloseBubbleTipsPanel, UISecretBookTipsPanel.OnCloseBubbleTipsCallBack)
    UISecretBookTipsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_TaskSubmit, UISecretBookTipsPanel.OnTaskSubmit)
end

--endregion
--region 响应UI事件
---点击界面按钮
function UISecretBookTipsPanel.OnClickBtnCallBack(go)
    if UISecretBookTipsPanel.configTable == nil then
        return
    end
    if UISecretBookTipsPanel.configTable.type == LuaEnumCheatPushTabelType.Mission then
        networkRequest.ReqMainTaskPush(UISecretBookTipsPanel.configTable.type, UISecretBookTipsPanel.Other)
        UISecretBookTipsPanel.Tip1.gameObject:SetActive(false)
        UISecretBookTipsPanel.Tip.gameObject:SetActive(false)
    elseif UISecretBookTipsPanel.configTable.type == LuaEnumCheatPushTabelType.SecretBook then
        if UISecretBookTipsPanel.dependPanel ~= nil and UISecretBookTipsPanel.dependPanel ~= "" then
            uimanager:ClosePanel(UISecretBookTipsPanel.dependPanel)
        end
        uimanager:CreatePanel("UISecretBookPanel", nil, UISecretBookTipsPanel.configTable.jump)
        UISecretBookTipsPanel.HidePanelWhatever()
    end
end

function UISecretBookTipsPanel.OnClickTip1Close()
    UISecretBookTipsPanel.Tip1.gameObject:SetActive(false)
    UISecretBookTipsPanel.Tip.gameObject:SetActive(false)
end

--endregion
--region 响应消息事件
---强制隐藏面板
function UISecretBookTipsPanel.ConstraintHidePanel(id, panelName)
    if panelName == nil then
        return
    end
    if UISecretBookTipsPanel.dependPanel == nil then
        return
    end
    if panelName == UISecretBookTipsPanel.dependPanel then
        UISecretBookTipsPanel:HidePanelWhatever()
    end
end

---播放面板消失动画
function UISecretBookTipsPanel.OnCloseBubbleTipsCallBack()
    UISecretBookTipsPanel.HidePanelWhatever()
end

---提交任务
function UISecretBookTipsPanel.OnTaskSubmit()
    if UISecretBookTipsPanel.configTable.type == LuaEnumCheatPushTabelType.Mission then
        UISecretBookTipsPanel.Tip1.gameObject:SetActive(false)
        UISecretBookTipsPanel.Tip.gameObject:SetActive(false)
    end
end

--endregion
--region UI
---显示推送气泡内容
function UISecretBookTipsPanel.ShowBubbleTips(customData)
    UISecretBookTipsPanel.configTable = customData[LuaEnumTipConfigType.ConfigTable]
    UISecretBookTipsPanel.parent = customData[LuaEnumTipConfigType.Parent]
    UISecretBookTipsPanel.excursion = customData[LuaEnumTipConfigType.Excursion]
    UISecretBookTipsPanel.direction = tonumber(customData[LuaEnumTipConfigType.Direction])
    UISecretBookTipsPanel.dependPanel = customData[LuaEnumTipConfigType.DependPanel]
    UISecretBookTipsPanel.Other = customData[LuaEnumTipConfigType.Other]
    if UISecretBookTipsPanel.configTable == nil then
        if isOpenLog then
            luaDebug.Log("传入表数据为空")
        end
        UISecretBookTipsPanel.HidePanelWhatever()
        return
    end

    if UISecretBookTipsPanel.parent ~= nil then
        local pos = UISecretBookTipsPanel.parent.position
        --暂无调整位置需求
        if UISecretBookTipsPanel.excursion ~= nil then
            local localPos = UISecretBookTipsPanel.parent.localPosition
        end
        pos = UISecretBookTipsPanel.go.transform.parent:InverseTransformPoint(pos)
        UISecretBookTipsPanel.go.transform.localPosition = pos
        UISecretBookTipsPanel.TipConnector.transform.localPosition = CS.UnityEngine.Vector3.zero
        --if UISecretBookTipsPanel.dependPanel and UISecretBookTipsPanel.TipConnector then
        --    UISecretBookTipsPanel.TipConnector:SetPanelName(UISecretBookTipsPanel.dependPanel)
        --end
    elseif UISecretBookTipsPanel.dependPanel and UISecretBookTipsPanel.TipConnector then
        UISecretBookTipsPanel.go.transform.localPosition = CS.UnityEngine.Vector3.zero
        UISecretBookTipsPanel.TipConnector:SetPosition(UISecretBookTipsPanel.dependPanel)
    end

    UISecretBookTipsPanel.Label.text = CS.Utility.FormattingString(UISecretBookTipsPanel.configTable.text)

    UISecretBookTipsPanel.BtnLabel.text = CS.Utility.FormattingString(UISecretBookTipsPanel.configTable.keyText)
    ---如果为传入方向则取表中的方向
    if UISecretBookTipsPanel.direction == nil then
        if UISecretBookTipsPanel.configTable.direction ~= 0 then
            UISecretBookTipsPanel.direction = UISecretBookTipsPanel.configTable.direction
        else
            UISecretBookTipsPanel.direction = LuaEnumPromptframeDirectionType.RIGHT
        end
    end
    UISecretBookTipsPanel.showTime = UISecretBookTipsPanel.configTable.showTime
    if UISecretBookTipsPanel.configTable.type == LuaEnumCheatPushTabelType.Mission then
        UISecretBookTipsPanel.Tip1Label.text = CS.Utility.FormattingString(UISecretBookTipsPanel.configTable.text)
        UISecretBookTipsPanel.Tip1.gameObject:SetActive(true)
        UISecretBookTipsPanel.Tip.gameObject:SetActive(false)
    elseif UISecretBookTipsPanel.configTable.type == LuaEnumCheatPushTabelType.SecretBook then
        if UISecretBookTipsPanel.mHidePanelCoroutine ~= nil then
            StopCoroutine(UISecretBookTipsPanel.mHidePanelCoroutine)
            UISecretBookTipsPanel.mHidePanelCoroutine = nil
        end
        UISecretBookTipsPanel.mHidePanelCoroutine = StartCoroutine(UISecretBookTipsPanel.HidePanel)
        UISecretBookTipsPanel.Tip1.gameObject:SetActive(false)
        UISecretBookTipsPanel.Tip.gameObject:SetActive(true)
        --处理此界面的互斥
        UISecretBookTipsPanel.go:SetActive(true)
    end
    UISecretBookTipsPanel.SetCheatPushTipsPos()


end

function UISecretBookTipsPanel.SetCheatPushTipsPos()
    ---如果为空默认为左侧
    if UISecretBookTipsPanel.direction == nil then
        UISecretBookTipsPanel.direction = 4
    end
    UISecretBookTipsPanel.SetDirection(UISecretBookTipsPanel.direction)
    UISecretBookTipsPanel.SetSize(UISecretBookTipsPanel.direction)
    UISecretBookTipsPanel.SetLabelSite(UISecretBookTipsPanel.direction)
    UISecretBookTipsPanel.Tip:PlayForward();
end

---设置组件方向
function UISecretBookTipsPanel.SetDirection(direction)
    if direction == LuaEnumPromptframeDirectionType.DOWN then
        UISecretBookTipsPanel.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, -90)
        UISecretBookTipsPanel.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, -90)
    elseif direction == LuaEnumPromptframeDirectionType.UP then
        UISecretBookTipsPanel.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 90)
        UISecretBookTipsPanel.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 90)
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        UISecretBookTipsPanel.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
        UISecretBookTipsPanel.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        UISecretBookTipsPanel.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 180)
        UISecretBookTipsPanel.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 180)
    end
end

---设置组件大小
function UISecretBookTipsPanel.SetSize(direction)
    local TipSizeRange = CS.Cfg_GlobalTableManager.Instance.TipSizeRange;
    if TipSizeRange == nil then
        return
    end
    local upAndDown = TipSizeRange[1]
    local leftAndRight = TipSizeRange[2]
    local marginNumber = 60;
    local moduleWidth = 0;
    local moduleheight = 0;
    if direction == LuaEnumPromptframeDirectionType.UP or direction == LuaEnumPromptframeDirectionType.DOWN then
        moduleWidth = UISecretBookTipsPanel.Label.width / 2 + marginNumber
        UISecretBookTipsPanel.leftSprite.width = 140-- moduleWidth
        UISecretBookTipsPanel.leftSprite.height = moduleWidth-- upAndDown[1]
        UISecretBookTipsPanel.rightSprite.width = 140 -- moduleWidth
        UISecretBookTipsPanel.rightSprite.height = moduleWidth-- upAndDown[1]
    elseif direction == LuaEnumPromptframeDirectionType.LEFT or direction == LuaEnumPromptframeDirectionType.RIGHT then
        moduleheight = UISecretBookTipsPanel.Label.width + marginNumber * 2
        UISecretBookTipsPanel.leftSprite.width = moduleheight-- leftAndRight[0]
        UISecretBookTipsPanel.leftSprite.height = 60-- moduleheight
        UISecretBookTipsPanel.rightSprite.width = moduleheight-- leftAndRight[0]
        UISecretBookTipsPanel.rightSprite.height = 60-- moduleheight
    end
end

---设置字体位置
function UISecretBookTipsPanel.SetLabelSite(direction)
    local x = (UISecretBookTipsPanel.rightSprite.width + 25) / 2;
    if direction == LuaEnumPromptframeDirectionType.DOWN then
        UISecretBookTipsPanel.Label.transform.localPosition = CS.UnityEngine.Vector3(0, -50, 0)
    elseif direction == LuaEnumPromptframeDirectionType.UP then
        UISecretBookTipsPanel.Label.transform.localPosition = CS.UnityEngine.Vector3(0, 110, 0)
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        UISecretBookTipsPanel.Label.transform.localPosition = CS.UnityEngine.Vector3(x, 30, 0)
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        UISecretBookTipsPanel.Label.transform.localPosition = CS.UnityEngine.Vector3(-x, 30, 0)
    end
end

function UISecretBookTipsPanel.SetLayer(value)
    UISecretBookTipsPanel.panel_UIPanel.depth = value
end

function UISecretBookTipsPanel.SetStartLayer()
    UISecretBookTipsPanel.panel_UIPanel.depth = self.startLayer
end

--endregion
--region otherFunc
function UISecretBookTipsPanel.HidePanel()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(UISecretBookTipsPanel.showTime))
    UISecretBookTipsPanel.Tip1.gameObject:SetActive(false)
    UISecretBookTipsPanel.Tip:PlayReverse();
end

---隐藏面板Whatever
function UISecretBookTipsPanel.HidePanelWhatever()
    StopCoroutine(UISecretBookTipsPanel.mHidePanelCoroutine)
    if UISecretBookTipsPanel.Tip ~= nil and CS.StaticUtility.IsNull(UISecretBookTipsPanel.Tip) == false then
        UISecretBookTipsPanel.Tip.enabled = false
    end
    if UISecretBookTipsPanel.TipWidget ~= nil and CS.StaticUtility.IsNull(UISecretBookTipsPanel.TipWidget) == false then
        UISecretBookTipsPanel.TipWidget.alpha = 0
    end
end

--endregion
function ondestroy()
    if UISecretBookTipsPanel.mHidePanelCoroutine ~= nil then
        StopCoroutine(UISecretBookTipsPanel.mHidePanelCoroutine)
        UISecretBookTipsPanel.mHidePanelCoroutine = nil
    end
    --luaEventManager.RemoveCallback(LuaCEvent.ClosePanel, UISecretBookTipsPanel.ConstraintHidePanel)
end

return UISecretBookTipsPanel