local UISliderBasic = {}

function UISliderBasic:Init(panel)
    self.mOwnerPanel = panel;
    self:InitComponents()
    self:InitOther()
end
---通过工具生成 控件变量
function UISliderBasic:InitComponents()
    self.mSlider_UISprite = self:Get("Slider", "UISprite")
    self.mSlider_TweenFillAmount = self:Get("Slider", "TweenFillAmount")
end
---初始化 变量 按钮点击 服务器消息事件等
function UISliderBasic:InitOther()
    --填充速度
    self.mFillSpeed = 0.25
    --填充时间(每次通过计算刷新)
    self.mFillTime = 0
    --结束事件
    self.mSlider_TweenFillAmount:SetOnFinished(function()
        self:OnFillFinished()
    end)
end
---播放
---@field from 起始值
---@field to 目标值
function UISliderBasic:Play(from, to)
    if self.mSlider_TweenFillAmount == nil then
        print("未找到TweenFillAmount")
        return
    end
    local dif = to - from
    if dif < 0 then
        dif = -dif
    end
    self.mFillTime = dif / self.mFillSpeed
    self.mSlider_TweenFillAmount.duration = self.mFillTime / 2
    self.mSlider_TweenFillAmount.from = from
    self.mSlider_TweenFillAmount.to = to
    self.mSlider_TweenFillAmount:ResetToBeginning()
    self.mSlider_TweenFillAmount:PlayTween()
end
---填充j结束，子类重写
function UISliderBasic.OnFillFinished()

end

return UISliderBasic