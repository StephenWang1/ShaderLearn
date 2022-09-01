---充值模板
---@class UIRechargeTemplate
local UIRechargeTemplate = {}
---初始化
function UIRechargeTemplate:Init()
    self:InitComponents()
    self:BindMessage()
end
---初始化组件
function UIRechargeTemplate:InitComponents()
    --人民币UILabel
    self.mPrice_UILabel = self:Get("Price", "UILabel")
    --游戏货币UILabel
    self.mIngot_UILabel = self:Get("Ingot", "UILabel")
    --图标UISprite
    self.mIcon_UISprite = self:Get("background/bg/Sprite", "UISprite")
end
---初始化参数
function UIRechargeTemplate:InitParameters()
    --ID
    self.mID = 0
    --人民币
    self.mPrice = 0
    --游戏货币
    self.mIngot = 0
end
---绑定消息
function UIRechargeTemplate:BindMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClick
end
---显示
function UIRechargeTemplate:Show(id)
    self.mID = id

end
---点击
function UIRechargeTemplate:OnClick()
    --对接支付平台
    self:AfterPay(true)
end
function UIRechargeTemplate:AfterPay(paySucceed)
    if paySucceed then

    else

    end
end
return UIRechargeTemplate