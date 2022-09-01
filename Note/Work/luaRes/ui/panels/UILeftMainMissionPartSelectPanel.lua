---为左侧任务栏服务的选择界面
---@class UILeftMainMissionPartSelectPanel:UIBase
local UILeftMainMissionPartSelectPanel = {}

function UILeftMainMissionPartSelectPanel:Init()
    ---@type UISprite
    self.Bg = self:GetCurComp('WidgetRoot/Tip/Bg', 'UISprite')
    ---@type UISprite
    self.arrow = self:GetCurComp('WidgetRoot/Tip/Arrow', "UISprite")
    ---@type UIGridContainer
    self.mainGrid = self:GetCurComp('WidgetRoot/Tip/Info/Grid', 'UIGridContainer')
    ---@type UnityEngine.GameObject
    self.childObj = self:GetCurComp('WidgetRoot/Tip1', 'GameObject')
    ---@type UIGridContainer
    self.childGrid = self:GetCurComp('WidgetRoot/Tip1/Info/Grid', 'UIGridContainer')
    ---@type UISprite
    self.childBg = self:GetCurComp('WidgetRoot/Tip1/Bg', 'UISprite')
    ---@type UnityEngine.GameObject
    self.blackbox = self:GetCurComp('WidgetRoot/blackbox', 'GameObject')

    self.childObj:SetActive(false)
    CS.UIEventListener.Get(self.blackbox).onClick = function()
        self:OnClickBlackbox()
    end
end

---@param options table<number,{showName:string,isDisabled:boolean|nil,clickCallBack:fun(param:any,go:UnityEngine.GameObject),param:any}>
---@param position UnityEngine.Vector3 指向的世界坐标,忽略z坐标
function UILeftMainMissionPartSelectPanel:Show(options, position)
    if options == nil or #options == 0 then
        self:ClosePanel()
        return
    end
    self:RefreshButtons(options)
    self:DoComposing(position)
end

---刷新按钮选项
---@private
---@param options table<number,{showName:string,clickCallBack:fun(param:any,go:UnityEngine.GameObject),param:any}>
function UILeftMainMissionPartSelectPanel:RefreshButtons(options)
    self.mainGrid.MaxCount = #options
    for i = 1, #options do
        local optionTemp = options[i]
        local go = self.mainGrid.controlList[i - 1]
        local label = self:GetComp(go.transform, "Label", "UILabel")
        label.text = optionTemp.showName
        CS.UIEventListener.Get(go).onClick = function()
            optionTemp.clickCallBack(optionTemp.param, go)
        end
    end
end

---执行排版
---@private
---@param position UnityEngine.Vector3
function UILeftMainMissionPartSelectPanel:DoComposing(position)
    ---将箭头放在目标位置
    local targetLocalPositionForArrow = self.arrow.transform:InverseTransformPoint(position)
    local localPosOffset = self.arrow.transform.localPosition - targetLocalPositionForArrow
    local panelLocalPos = self.go.transform.localPosition
    panelLocalPos = panelLocalPos - localPosOffset + self.arrow.transform.localPosition
    panelLocalPos.z = 0
    panelLocalPos.y = panelLocalPos.y + self.arrow.height * 0.5
    ---调整背景高度
    self.Bg.height = self.mainGrid.CellHeight * self.mainGrid.MaxCount + 6
    self.go.transform.localPosition = panelLocalPos
end

function UILeftMainMissionPartSelectPanel:OnClickBlackbox()
    self:ClosePanel()
end

return UILeftMainMissionPartSelectPanel