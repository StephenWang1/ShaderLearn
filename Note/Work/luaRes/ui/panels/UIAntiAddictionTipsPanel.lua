---防沉迷提示界面
---@class UIAntiAddictionTipsPanel:UIBase
local UIAntiAddictionTipsPanel = {}

UIAntiAddictionTipsPanel.mExitMinTime = 0

---获取内容文本
function UIAntiAddictionTipsPanel:GetContentLabel()
    if self.mContentLabel == nil then
        self.mContentLabel = self:GetCurComp("view/Content", "UILabel")
    end
    return self.mContentLabel
end

---剩余时间文本
function UIAntiAddictionTipsPanel:GetTimeLabel()
    if self.mTimeLabel == nil then
        self.mTimeLabel = self:GetCurComp("view/time", "UILabel")
    end
    return self.mTimeLabel
end

---关闭按钮
function UIAntiAddictionTipsPanel:GetCloseButtonGO()
    if self.mCloseButtonGO == nil then
        self.mCloseButtonGO = self:GetCurComp("events/close", "GameObject")
    end
    return self.mCloseButtonGO
end

---确定按钮
function UIAntiAddictionTipsPanel:GetEnsureButtonGO()
    if self.mEnsureButtonGO == nil then
        self.mEnsureButtonGO = self:GetCurComp("events/CenterBtn", "GameObject")
    end
    return self.mEnsureButtonGO
end

---背景Box
function UIAntiAddictionTipsPanel:GetBackBoxGO()
    if self.mBackBoxGO == nil then
        self.mBackBoxGO = self:GetCurComp("box", "GameObject")
    end
    return self.mBackBoxGO
end

---背景Box
function UIAntiAddictionTipsPanel:GetBackGroundGO()
    if self.mBackGroundGO == nil then
        self.mBackGroundGO = self:GetCurComp("view/background", "GameObject")
    end
    return self.mBackGroundGO
end

function UIAntiAddictionTipsPanel:Init()
    UIAntiAddictionTipsPanel.mExitMinTime = CS.UnityEngine.Time.time + 3
end

---@param fcmstate number 防沉迷状态
---@param lastTime number 剩余时间(分钟)
---@param reason number 打开提示原因
function UIAntiAddictionTipsPanel:Show(fcmstate, lastTime, reason)
    if fcmstate == nil or lastTime == nil then
        uimanager:ClosePanel("UIAntiAddictionTipsPanel")
        return
    end
    self.reason = reason
    local isContentExist, content
    if reason == 3 then
        ---22点~8点，未成年人不可登入游戏
        local tbl
        isContentExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(996)
        content = tbl.value
    else
        isContentExist, content = CS.Cfg_GlobalTableManager.Instance:TryGetFCMTipContentByFCMState(fcmstate)
        if isContentExist == false then
            content = "根据国家规定，未成年玩家法定节假日（不包含双休日）每日累计不得超过3小时，其他时间每日累计不得超过1.5小时。"
        end
    end
    ---3秒后点击才生效
    if lastTime == 0 then
        UIAntiAddictionTipsPanel.mExitMinTime = CS.UnityEngine.Time.time + 3
    else

    end
    if CS.StaticUtility.IsNull(self:GetContentLabel()) == false then
        self:GetContentLabel().text = content
    end
    if CS.StaticUtility.IsNull(self:GetTimeLabel()) == false then
        if reason == 3 then
            ---22点~8点，未成年人不可登入游戏,不显示时间
            self:GetTimeLabel().gameObject:SetActive(false)
        else
            local timeStr
            local hourNum = math.floor(lastTime / 60)
            local timeNum = lastTime % 60
            if hourNum > 0 then
                timeStr = "[ffdd00]" .. tostring(hourNum) .. "小时" .. tostring(timeNum) .. "分钟[-]"
            else
                timeStr = "[ffdd00]" .. tostring(timeNum) .. "分钟[-]"
            end
            self:GetTimeLabel().gameObject:SetActive(true)
            self:GetTimeLabel().text = "剩余游戏时间:    " .. timeStr
        end
    end
    CS.UIEventListener.Get(self:GetEnsureButtonGO()).onClick = function()
        self:OnReturnToLoginButtonClicked()
    end
    CS.UIEventListener.Get(self:GetCloseButtonGO()).onClick = function()
        self:OnReturnToLoginButtonClicked()
    end
    CS.UIEventListener.Get(self:GetBackBoxGO()).onClick = function()
        self:OnReturnToLoginButtonClicked()
    end
    CS.UIEventListener.Get(self:GetBackGroundGO()).onClick = function()
        self:OnReturnToLoginButtonClicked()
    end
end

---返回到登录界面按钮点击事件
function UIAntiAddictionTipsPanel:OnReturnToLoginButtonClicked()
    if CS.UnityEngine.Time.time < UIAntiAddictionTipsPanel.mExitMinTime then
        return
    end
    if self.reason == 3 then
        ---22点~8点，未成年人不可登入游戏
        if self.isClicked == nil then
            self.isClicked = true
            clientMessageDeal.OnReturnLogin(false)
        end
        UIAntiAddictionTipsPanel:ClosePanel()
        return
    end
    UIAntiAddictionTipsPanel:ClosePanel()
end

return UIAntiAddictionTipsPanel