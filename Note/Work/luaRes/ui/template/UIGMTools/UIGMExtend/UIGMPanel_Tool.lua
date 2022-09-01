---GM工具分面板-工具面板面板
---设置左右设配
---设置界面偏差
---设置分辨率
---@class UIGMPanel_Tool:TemplateBase
local UIGMPanel_Tool = {}

--region 初始化
function UIGMPanel_Tool:Init(panel)
    self:InitLexFit();
    self:InitWindowDeviation();
    self:InitResolutionRatioFit();
    self:InitGameTimeScale();
    self:InitMsgSendMonitor();
end

function UIGMPanel_Tool:Show(pos)
    self.go:SetActive(true)
end

function UIGMPanel_Tool:Hide()
    self.go:SetActive(false)
end
--endregion

--region 左右刘海适配
function UIGMPanel_Tool:GetLexFitRoot()
    if self.mGetLexFitRoot == nil then
        self.mGetLexFitRoot = self:Get("ToolTable/LexFit", "GameObject")
    end
    return self.mGetLexFitRoot
end

function UIGMPanel_Tool:GetLexFitDataLabel()
    if self.mGetLexFitDataLabel == nil then
        self.mGetLexFitDataLabel = self:Get("ToolTable/LexFit/DataLabel", "UILabel")
    end
    return self.mGetLexFitDataLabel
end
function UIGMPanel_Tool:InitLexFit()
    self:SetShiPeiBtn(self:GetLexFitRoot(), "leftshipei", "Chat Input", CS.EOrientationState.Left)
    self:SetShiPeiBtn(self:GetLexFitRoot(), "rightshipei", "Chat Input", CS.EOrientationState.Right)
    self:SetShiPeiBtn(self:GetLexFitRoot(), "rightandleftshipei", "Chat Input", CS.EOrientationState.LeftAndRight)
    self:SetShiPeiBtn(self:GetLexFitRoot(), "closeshipei", "Chat Input", CS.EOrientationState.None)
end

function UIGMPanel_Tool:SetShiPeiBtn(go, btnName, inputName, enum)
    local shipeiBtn = self:GetCurComp(go, btnName, "GameObject")
    local inputBtn = self:GetCurComp(go, inputName, "UIInput")
    CS.UIEventListener.Get(shipeiBtn).onClick = function()
        CS.CSGame.Sington:SetPixelzoom(inputBtn.value);
        CS.CSGame.OrientationState = enum
        self:GetLexFitDataLabel().text = tostring(CS.Constant.OrigionSceneWidth) .. ":" .. tostring(CS.Constant.OrigionSceneHeight) .. "  " .. tostring(CS.Constant.pixelzoom) .. "  " .. CS.Constant.PhoneName .. "     " .. CS.Constant.mWhiteListIp
    end
    self:GetLexFitDataLabel().text = tostring(CS.Constant.OrigionSceneWidth) .. ":" .. tostring(CS.Constant.OrigionSceneHeight) .. "  " .. tostring(CS.Constant.pixelzoom) .. "  " .. CS.Constant.PhoneName .. "     " .. CS.Constant.mWhiteListIp
end
--endregion

--region 界面整体偏差
function UIGMPanel_Tool:GetWindowDeviationRoot()
    if self.mGetWindowDeviationRoot == nil then
        self.mGetWindowDeviationRoot = self:Get("ToolTable/WindowDeviation", "GameObject")
    end
    return self.mGetWindowDeviationRoot
end

function UIGMPanel_Tool:BtnDeviation()
    if self.mBtnDeviation == nil then
        self.mBtnDeviation = self:Get("ToolTable/WindowDeviation/btndev", "GameObject")
    end
    return self.mBtnDeviation
end

function UIGMPanel_Tool:XDeviationInput()
    if self.mXDeviationInput == nil then
        self.mXDeviationInput = self:Get("ToolTable/WindowDeviation/XDeviation", "UIInput")
    end
    return self.mXDeviationInput
end

function UIGMPanel_Tool:YDeviationInput()
    if self.mYDeviationInput == nil then
        self.mYDeviationInput = self:Get("ToolTable/WindowDeviation/YDeviation", "UIInput")
    end
    return self.mYDeviationInput
end

function UIGMPanel_Tool:InitWindowDeviation()
    CS.UIEventListener.Get(self:BtnDeviation()).onClick = function()
        local x = self:XDeviationInput().value
        local y = self:YDeviationInput().value
        CS.CSGame.Sington:UpdatePosDev(x, y);
    end
end
--endregion

--region 整体分辨率
function UIGMPanel_Tool:ResolutionRatioInput()
    if self.mResolutionRatioInput == nil then
        self.mResolutionRatioInput = self:Get("ToolTable/ResolutionRatioFit/ResolutionRatio", "UIInput")
    end
    return self.mResolutionRatioInput
end
function UIGMPanel_Tool:BtnResolution()
    if self.mBtnResolution == nil then
        self.mBtnResolution = self:Get("ToolTable/ResolutionRatioFit/btnResolution", "GameObject")
    end
    return self.mBtnResolution
end

function UIGMPanel_Tool:InitResolutionRatioFit()
    CS.UIEventListener.Get(self:BtnResolution()).onClick = function()
        CS.CSGame.Sington:SetResolutionRatioFit(self:ResolutionRatioInput().value);
    end
end
--endregion

--region 游戏速率
function UIGMPanel_Tool:InputGameTimeScale()
    if self.mInputGameTimeScale == nil then
        self.mInputGameTimeScale = self:Get("ToolTable/GameTimeScale/InputGameTimeScale", "UIInput")
    end
    return self.mInputGameTimeScale
end

function UIGMPanel_Tool:BtnGameTimeScale()
    if self.mBtnGameTimeScale == nil then
        self.mBtnGameTimeScale = self:Get("ToolTable/GameTimeScale/BtnGameTimeScale", "GameObject")
    end
    return self.mBtnGameTimeScale
end

function UIGMPanel_Tool:InitGameTimeScale()
    CS.UIEventListener.Get(self:BtnGameTimeScale()).onClick = function()
        local scale = tonumber(self:InputGameTimeScale().value)
        CS.UnityEngine.Time.timeScale = 1 / scale
    end
end
--endregion

--region 消息发送监视
---@return UIToggle
function UIGMPanel_Tool:GetIsMonitoringToggle()
    if self.mIsMonitoringToggle == nil then
        self.mIsMonitoringToggle = self:Get("ToolTable/MsgSendMonitor/IsMonitoring", "UIToggle")
    end
    return self.mIsMonitoringToggle
end

---@return UIInput
function UIGMPanel_Tool:GetSingleMsgAmountAlertLimitUIInput()
    if self.mSingleMsgAmountAlertLimitUIInput == nil then
        self.mSingleMsgAmountAlertLimitUIInput = self:Get("ToolTable/MsgSendMonitor/MsgAmountAlert_Single", "UIInput")
    end
    return self.mSingleMsgAmountAlertLimitUIInput
end

---@return UIInput
function UIGMPanel_Tool:GetSingleMsgLengthAlertLimitUIInput()
    if self.mSingleMsgLengthAlertLimitUIInput == nil then
        self.mSingleMsgLengthAlertLimitUIInput = self:Get("ToolTable/MsgSendMonitor/MsgLengthAlert_Single", "UIInput")
    end
    return self.mSingleMsgLengthAlertLimitUIInput
end

---@return UIInput
function UIGMPanel_Tool:GetAllMsgAmountAlertLimitUIInput()
    if self.mAllMsgAmountAlertLimitUIInput == nil then
        self.mAllMsgAmountAlertLimitUIInput = self:Get("ToolTable/MsgSendMonitor/MsgAmountAlert_All", "UIInput")
    end
    return self.mAllMsgAmountAlertLimitUIInput
end

---@return UIInput
function UIGMPanel_Tool:GetAllMsgLengthAlertLimitUIInput()
    if self.mAllMsgLengthAlertLimitUIInput == nil then
        self.mAllMsgLengthAlertLimitUIInput = self:Get("ToolTable/MsgSendMonitor/MsgLengthAlert_All", "UIInput")
    end
    return self.mAllMsgLengthAlertLimitUIInput
end

function UIGMPanel_Tool:InitMsgSendMonitor()
    self:GetIsMonitoringToggle().value = CS.MsgSendMonitor.IsMonitoring
    CS.EventDelegate.Add(self:GetIsMonitoringToggle().onChange, function()
        CS.MsgSendMonitor.IsMonitoring = self:GetIsMonitoringToggle().value
    end)
    self:GetSingleMsgAmountAlertLimitUIInput().value = CS.MsgSendMonitor.singleMsgAmountLimitInOneFrame
    CS.EventDelegate.Add(self:GetSingleMsgAmountAlertLimitUIInput().onChange, function()
        local num = tonumber(self:GetSingleMsgAmountAlertLimitUIInput().value)
        if num then
            CS.MsgSendMonitor.singleMsgAmountLimitInOneFrame = num
        end
    end)
    self:GetSingleMsgLengthAlertLimitUIInput().value = CS.MsgSendMonitor.singleMsgLengthLimitInOneFrame
    CS.EventDelegate.Add(self:GetSingleMsgLengthAlertLimitUIInput().onChange, function()
        local num = tonumber(self:GetSingleMsgLengthAlertLimitUIInput().value)
        if num then
            CS.MsgSendMonitor.singleMsgLengthLimitInOneFrame = num
        end
    end)
    self:GetAllMsgAmountAlertLimitUIInput().value = CS.MsgSendMonitor.allMsgAmountLimitInOneFrame
    CS.EventDelegate.Add(self:GetAllMsgAmountAlertLimitUIInput().onChange, function()
        local num = tonumber(self:GetAllMsgAmountAlertLimitUIInput().value)
        if num then
            CS.MsgSendMonitor.allMsgAmountLimitInOneFrame = num
        end
    end)
    self:GetAllMsgLengthAlertLimitUIInput().value = CS.MsgSendMonitor.allMsgLengthLimitInOneFrame
    CS.EventDelegate.Add(self:GetAllMsgLengthAlertLimitUIInput().onChange, function()
        local num = tonumber(self:GetAllMsgLengthAlertLimitUIInput().value)
        if num then
            CS.MsgSendMonitor.allMsgLengthLimitInOneFrame = num
        end
    end)
end
--endregion

return UIGMPanel_Tool