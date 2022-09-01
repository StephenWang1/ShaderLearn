---带有文本的进度条
local UISliderWithText = {}

setmetatable(UISliderWithText, luaComponentTemplates.UISliderBasic)

function UISliderWithText:Init()
    self:InitComponents()
    self:InitOther()
end
---通过工具生成 控件变量
function UISliderWithText:InitComponents()
    self:RunBaseFunction("InitComponents")
    --文本
    self.mText_UILabel = self:Get("Text", "UILabel")
end
---初始化 变量 按钮点击 服务器消息事件等
function UISliderWithText:InitOther()
    self:RunBaseFunction("InitOther")
    --是否更新事件标识符
    self.mIsUpdateAction = false
end

return UISliderWithText