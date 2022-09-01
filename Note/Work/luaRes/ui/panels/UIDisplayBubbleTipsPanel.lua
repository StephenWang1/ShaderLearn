---@class UIDisplayBubbleTipsPanel:UIBase 通用不关闭气泡
local UIDisplayBubbleTipsPanel = {}

--region 组件
---@return UILabel
function UIDisplayBubbleTipsPanel:GetDes_UILabel()
    if self.mDesLabel == nil then
        self.mDesLabel = self:GetCurComp("WidgetRoot/Tip/Label", "UILabel")
    end
    return self.mDesLabel
end

---@return UISprite
function UIDisplayBubbleTipsPanel:GetLeftSprite_UISprite()
    if self.mLeftSprite == nil then
        self.mLeftSprite = self:GetCurComp("WidgetRoot/Tip/leftSprite", "UISprite")
    end
    return self.mLeftSprite
end

---@return UISprite
function UIDisplayBubbleTipsPanel:GetRightSprite_UISprite()
    if self.mRightSprite == nil then
        self.mRightSprite = self:GetCurComp("WidgetRoot/Tip/rightSprite", "UISprite")
    end
    return self.mRightSprite
end

---@return Top_UIWidget
function UIDisplayBubbleTipsPanel:GetWidget()
    if self.mWidget == nil then
        self.mWidget = self:GetCurComp("WidgetRoot/Tip", "Top_UIWidget")
    end
    return self.mWidget
end

---@return TweenPosition 跳动动画
function UIDisplayBubbleTipsPanel:GetJump_TweenPosition()
    if self.mJumpTween == nil then
        self.mJumpTween = self:GetCurComp("WidgetRoot", "TweenPosition")
    end
    return self.mJumpTween
end

--endregion

--region 初始化
function UIDisplayBubbleTipsPanel:Init()
    self:BindMessage()
end

---@param custonData
function UIDisplayBubbleTipsPanel:Show(go, configId, isShowTween, ...)
    self:RefreshShow(go, configId, ...)
    if isShowTween == nil then
        isShowTween = false
    end
    self:GetJump_TweenPosition().enabled = isShowTween
end

function UIDisplayBubbleTipsPanel:BindMessage()
    UIDisplayBubbleTipsPanel.HidePanelFunc = function()
        self:HidePanel()
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.CloseDisplayBubble, UIDisplayBubbleTipsPanel.HidePanelFunc)
end

--endregion

--region
function UIDisplayBubbleTipsPanel:RefreshShow(go, configId, ...)
    if not CS.StaticUtility.IsNull(go) then
        local res, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(configId)
        if res then
            local excursion = CS.UnityEngine.Vector3(data.displacement, data.distance, 0) + go.transform.localPosition
            self.go.transform.localPosition = excursion
            if not self:GetDes_UILabel() then
                if ... then
                    self:GetDes_UILabel().text = string.gsub(string.format(data.content, ...), '\\n', '\n')
                else
                    self:GetDes_UILabel().text = data.content
                end
            end
            local dir = tonumber(data.direction)
            self:SetDirection(dir)
            self:SetSize(dir)
            self:SetLabelSite(dir)
        end
    end
end

---设置组件方向
function UIDisplayBubbleTipsPanel:SetDirection(direction)
    local Vec = CS.UnityEngine.Vector3.zero
    if direction == LuaEnumPromptframeDirectionType.DOWN then
        Vec.z = 0
    elseif direction == LuaEnumPromptframeDirectionType.UP then
        Vec.z = 180
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        Vec.z = 90
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        Vec.z = -90
    end
    self:GetLeftSprite_UISprite().transform.localEulerAngles = Vec
    self:GetRightSprite_UISprite().transform.localEulerAngles = Vec
end

---设置组件大小
function UIDisplayBubbleTipsPanel:SetSize(direction)
    local offset = 20;
    local realHeight
    local realWidth
    if direction == LuaEnumPromptframeDirectionType.UP or direction == LuaEnumPromptframeDirectionType.DOWN then
        realHeight = self:GetDes_UILabel().height * 2 + offset
        realWidth = self:GetDes_UILabel().width * 0.5 + offset
    elseif direction == LuaEnumPromptframeDirectionType.LEFT or direction == LuaEnumPromptframeDirectionType.RIGHT then
        realHeight = self:GetDes_UILabel().width + 60
        realWidth = self:GetDes_UILabel().height * 0.5 + offset
    end
    --图片有旋转所以高度是调整width
    self:GetLeftSprite_UISprite().height = realHeight
    self:GetRightSprite_UISprite().height = realHeight
    self:GetLeftSprite_UISprite().width = realWidth
    self:GetRightSprite_UISprite().width = realWidth
end

---设置字体位置
function UIDisplayBubbleTipsPanel:SetLabelSite(direction)
    local y = (self:GetDes_UILabel().height * 2)
    local x = (self:GetDes_UILabel().width / 2);
    if direction == LuaEnumPromptframeDirectionType.UP then
        self:GetDes_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-x, -y + 20, 0)
    elseif direction == LuaEnumPromptframeDirectionType.DOWN then
        self:GetDes_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-x, y - 30, 0)
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        self:GetDes_UILabel().transform.localPosition = CS.UnityEngine.Vector3(x - 50, 0, 0)
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        self:GetDes_UILabel().transform.localPosition = CS.UnityEngine.Vector3(-x * 2 - 40, 0, 0)
    end
end

function UIDisplayBubbleTipsPanel:HidePanel()
    self:ClosePanel()
end

return UIDisplayBubbleTipsPanel