---@class UIGMPanel_PortInfo:TemplateBase 手动输入端口ip
local UIGMPanel_PortInfo = {}

---@return UIToggle
function UIGMPanel_PortInfo:GetIsUsePortToggle()
    if self.mUsePortToggle == nil then
        self.mUsePortToggle = self:Get("Tg_IsUseProtAndIp", "UIToggle")
    end
    return self.mUsePortToggle
end

---@return UIInput
function UIGMPanel_PortInfo:GetPortLb_UIInput()
    if self.mPortInput == nil then
        self.mPortInput = self:Get("Port/Input/input", "UIInput")
    end
    return self.mPortInput
end

---@return UIInput
function UIGMPanel_PortInfo:GetIpLb_UIInput()
    if self.mIpInput == nil then
        self.mIpInput = self:Get("Ip/Input/input", "UIInput")
    end
    return self.mIpInput
end

function UIGMPanel_PortInfo:Init()
    if CS.Top_CSGame.Sington then
        self.mIsUsePortAndIp = CS.Top_CSGame.Sington._IsUsePortAndIP
        self:GetIsUsePortToggle().value = self.mIsUsePortAndIp;
        self.mPort = CS.Top_CSGame.Sington.Port
        self:GetPortLb_UIInput().value = self.mPort;
        self.mIp = CS.Top_CSGame.Sington.IP
        self:GetIpLb_UIInput().value = self.mIp;
    end
    self:BindEvents()
end

function UIGMPanel_PortInfo:BindEvents()
    CS.EventDelegate.Add(self:GetIsUsePortToggle().onChange, function()
        if self:GetIsUsePortToggle().value ~= self.mIsUsePortAndIp then
            CS.Top_CSGame.Sington._IsUsePortAndIP = self:GetIsUsePortToggle().value
            self.mIsUsePortAndIp = self:GetIsUsePortToggle().value
        end
    end)

    CS.EventDelegate.Add(self:GetPortLb_UIInput().onChange, function()
        if self:GetPortLb_UIInput().value ~= self.mPort then
            CS.Top_CSGame.Sington.Port = self:GetPortLb_UIInput().value
            self.mPort = self:GetPortLb_UIInput().value
        end
    end)

    CS.EventDelegate.Add(self:GetIpLb_UIInput().onChange, function()
        if self:GetPortLb_UIInput().value ~= self.mIp then
            CS.Top_CSGame.Sington.IP = self:GetIpLb_UIInput().value
            self.mIp = self:GetIpLb_UIInput().value
        end
    end)
end

return UIGMPanel_PortInfo