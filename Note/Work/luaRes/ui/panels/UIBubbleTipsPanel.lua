---@class UIBubbleTipsPanel:UIBase
local UIBubbleTipsPanel = {}

function UIBubbleTipsPanel:InitComponents()
    ---@type Top_UISprite 左侧贴图
    UIBubbleTipsPanel.leftSprite = self:GetCurComp("WidgetRoot/Tip/leftSprite", "Top_UISprite")
    ---@type Top_UISprite 右侧贴图
    UIBubbleTipsPanel.rightSprite = self:GetCurComp("WidgetRoot/Tip/rightSprite", "Top_UISprite")
    ---@type Top_UILabel 文字描述
    UIBubbleTipsPanel.Label = self:GetCurComp("WidgetRoot/Tip/Label", "Top_UILabel")
    ---@type Top_TweenAlpha tween组件
    UIBubbleTipsPanel.Tip = self:GetCurComp("WidgetRoot/Tip", "Top_TweenAlpha")
    ---@type TipWidget
    UIBubbleTipsPanel.TipWidget = self:GetCurComp("WidgetRoot/Tip", "Top_UIWidget")
    ---@type UIPanel
    self.panel_UIPanel = CS.Utility_Lua.GetComponent(self.go, "UIPanel")
    self.startLayer = self.panel_UIPanel.depth

end
function UIBubbleTipsPanel:InitOther()
    ---1 配置ID
    self.configID = nil
    ---2 父物体
    self.parent = nil
    ---3 偏移量
    self.excursion = nil
    ---4 描述
    self.des = nil
    ---5 方向
    self.direction = nil
    ---6 依附面板
    self.dependPanel = ""
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ClosePanel, UIBubbleTipsPanel.ConstraintHidePanel)
    --CS.System.String.Format("{0},{1},{2}", 1, 2, 3);
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_CloseBubbleTipsPanel, function()
        self:HidePanelWhatever()
    end)
end

---1 配置ID
---2 父物体
---3 偏移量
---4 描述
---5 方向
function UIBubbleTipsPanel:Show(...)
    self:ShowBubbleTips(...)
end

function UIBubbleTipsPanel:ShowBubbleTips(...)
    local contentTable = { ... }
    local specialParameter = contentTable[1]
    if specialParameter == nil then
        return
    end
    self.configID = specialParameter[LuaEnumTipConfigType.ConfigID]
    self.parent = specialParameter[LuaEnumTipConfigType.Parent]
    self.excursion = specialParameter[LuaEnumTipConfigType.Excursion]
    self.des = specialParameter[LuaEnumTipConfigType.Describe]
    self.direction = tonumber(specialParameter[LuaEnumTipConfigType.Direction])
    self.dependPanel = specialParameter[LuaEnumTipConfigType.DependPanel]
    if self.configID == nil then
        return
    end
    local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(self.configID)
    if isfind == false then
        return
    end
    if self.parent == nil then
        local panel = uimanager:GetPanel(data.panels)
        if panel == nil or CS.StaticUtility.IsNull(panel.go) then
            uimanager:ClosePanel(self)
            return
        end
        self.parent = self:GetComp(panel.go.transform,data.button,"Transform")
        if CS.StaticUtility.IsNull(self.parent) then
            uimanager:ClosePanel(self)
            return
        end
    end
    if self.excursion == nil then
        self.excursion = CS.UnityEngine.Vector3(data.displacement, data.distance, 0)
    end
    if self.des == nil then
        self.des = data.content
    end
    if self.direction == nil then
        self.direction = tonumber(data.direction)
    end
    local parent = self.go.transform.parent
    self.go.transform:SetParent(self.parent)
    self.go.transform.localPosition = self.excursion
    self.go.transform:SetParent(parent)
    self.Label.text = CS.Utility.FormattingString(self.des)
    self:SetDirection(self.direction)
    self:SetSize(self.direction)
    self:SetLabelSite(self.direction)
    UIBubbleTipsPanel.Tip:PlayForward();
    StopCoroutine(UIBubbleTipsPanel.mHidePanelCoroutine)
    UIBubbleTipsPanel.mHidePanelCoroutine = StartCoroutine(UIBubbleTipsPanel.HidePanel)
end

function UIBubbleTipsPanel:HidePanel()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    UIBubbleTipsPanel.Tip:PlayReverse();
end

function UIBubbleTipsPanel:Init()
    self:InitComponents()
    self:InitOther()
end

function UIBubbleTipsPanel:RefreshUI()

end

function UIBubbleTipsPanel:SetParent()

end

---设置组件方向
function UIBubbleTipsPanel:SetDirection(direction)
    if direction == LuaEnumPromptframeDirectionType.UP then
        self.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 180)
        self.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 180)
    elseif direction == LuaEnumPromptframeDirectionType.DOWN then
        self.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
        self.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        self.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, -90)
        self.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, -90)
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        self.leftSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 90)
        self.rightSprite.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 90)
    end
end

---设置组件大小
function UIBubbleTipsPanel:SetSize(direction)
    local TipSizeRange = CS.Cfg_GlobalTableManager.Instance.TipSizeRange;
    if TipSizeRange == nil then
        return
    end
    local upAndDown = TipSizeRange[1]
    local leftAndRight = TipSizeRange[2]
    local marginNumber = 20;
    local moduleWidth = 0;
    local moduleheight = 0;
    if direction == LuaEnumPromptframeDirectionType.UP or direction == LuaEnumPromptframeDirectionType.DOWN then
        if upAndDown[0] < self.Label.width / 2 + marginNumber then
            moduleWidth = self.Label.width / 2 + marginNumber
        else
            moduleWidth = upAndDown[0]
        end
        self.leftSprite.width = moduleWidth
        self.leftSprite.height = upAndDown[1]
        self.rightSprite.width = moduleWidth
        self.rightSprite.height = upAndDown[1]
    elseif direction == LuaEnumPromptframeDirectionType.LEFT or direction == LuaEnumPromptframeDirectionType.RIGHT then
        if leftAndRight[1] < self.Label.width + marginNumber * 2 then
            moduleheight = self.Label.width + marginNumber * 2
        else
            moduleheight = leftAndRight[1]
        end
        self.leftSprite.width = leftAndRight[0]
        self.leftSprite.height = moduleheight
        self.rightSprite.width = leftAndRight[0]
        self.rightSprite.height = moduleheight
    end
end

---设置字体位置
function UIBubbleTipsPanel:SetLabelSite(direction)
    local y = 30;
    local x = (self.rightSprite.height + 25) / 2;
    if direction == LuaEnumPromptframeDirectionType.UP then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, -y, 0)
    elseif direction == LuaEnumPromptframeDirectionType.DOWN then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, y, 0)
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, x, 0)
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, -x, 0)
    end
end

---设置位置
function UIBubbleTipsPanel:SetLabelSite(direction)
    local y = 30;
    local x = (self.rightSprite.height + 10) / 2;
    if direction == LuaEnumPromptframeDirectionType.UP then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, -y, 0)
    elseif direction == LuaEnumPromptframeDirectionType.DOWN then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, y, 0)
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(x, 0, 0)
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(-x, 0, 0)
    end
end

function UIBubbleTipsPanel:SetLayer(value)
    self.panel_UIPanel.depth = value
end

function UIBubbleTipsPanel:SetStartLayer()
    self.panel_UIPanel.depth = self.startLayer
end

--强制隐藏面板
function UIBubbleTipsPanel.ConstraintHidePanel(id, panelName)
    if panelName == nil then
        return
    end
    if UIBubbleTipsPanel.dependPanel == nil then
        return
    end
    if panelName == UIBubbleTipsPanel.dependPanel then
        UIBubbleTipsPanel:HidePanelWhatever()
    end
end

---隐藏面板Whatever
function UIBubbleTipsPanel:HidePanelWhatever()
    StopCoroutine(UIBubbleTipsPanel.mHidePanelCoroutine)
    if UIBubbleTipsPanel.Tip ~= nil and CS.StaticUtility.IsNull(UIBubbleTipsPanel.Tip) == false then
        UIBubbleTipsPanel.Tip.enabled = false
    end
    if UIBubbleTipsPanel.TipWidget ~= nil and CS.StaticUtility.IsNull(UIBubbleTipsPanel.TipWidget) == false then
        UIBubbleTipsPanel.TipWidget.alpha = 0
    end
end

function ondestroy()
    StopCoroutine(UIBubbleTipsPanel.mHidePanelCoroutine)
end

return UIBubbleTipsPanel