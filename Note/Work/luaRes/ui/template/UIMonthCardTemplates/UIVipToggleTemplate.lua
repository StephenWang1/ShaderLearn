---Vip 开关模板
local UIVipToggleTemplate = {}

---初始化
function UIVipToggleTemplate:Init()
    self:InitComponents()
    self:BindMessage()
    self:InitParameters()
end
---初始化组件
function UIVipToggleTemplate:InitComponents()
    --vip等级 UILabel
    self.mVipLevel_UILabel = self:Get("Label", "UILabel")
    --开关
    self.mToggle_UIToggle = CS.Utility_Lua.GetComponent(self.go,"UIToggle")
    --vip面板
    self.mVipPanel = uimanager:GetPanel("UIVipPanel")
end
---初始化参数
function UIVipToggleTemplate:InitParameters()
    --vip等级
    self.mVipLevel = 0
    --是否是可选择的
    self.mOptionalStatus = false
end
---绑定消息
function UIVipToggleTemplate:BindMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClick
end
---设置面板
function UIVipToggleTemplate:SetPanel(vipLevel, optionalStatus)
    self.mVipLevel = vipLevel
    local vipStr = "VIP" .. tostring(self.mVipLevel)
    if optionalStatus then
        vipStr = "[e7d392]VIP" .. tostring(self.mVipLevel)
    end
    self.mVipLevel_UILabel.text = vipStr
    self.mOptionalStatus = optionalStatus
    if not self.mOptionalStatus then
        self.mToggle_UIToggle.enabled = false
    else
        self.mToggle_UIToggle.enabled = true
    end
    if self.mVipLevel == 1 then
        self.mToggle_UIToggle.value = true
    end
end
---点击
function UIVipToggleTemplate:OnClick()
    if not self.mOptionalStatus then
        CS.Utility.ShowTips("VIP等级不足，请提升等级", 1, CS.ColorType.Red)
        return
    end
    if self.mVipPanel ~= nil then
        if self.mVipLevel ~= nil and self.mVipLevel ~= 0 then
            self.mVipPanel.RefreshVipDescription(self.mVipLevel)
        end
    end
end

return UIVipToggleTemplate