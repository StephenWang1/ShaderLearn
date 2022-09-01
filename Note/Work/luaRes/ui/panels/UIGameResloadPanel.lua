local UIGameResloadPanel = {}

local unityTime = CS.UnityEngine.Time

---上次显示时间
UIGameResloadPanel.mLastShowTime = nil
---显示持续时间
UIGameResloadPanel.mHideTime = 3

function UIGameResloadPanel:InitComponents()
    UIGameResloadPanel.bg = self:GetCurComp('WidgetRoot/bg', 'GameObject')
    UIGameResloadPanel.infobg = self:GetCurComp('WidgetRoot/infobg', 'GameObject')
    UIGameResloadPanel.line = self:GetCurComp('WidgetRoot/bg/line', 'Top_UISprite')
    UIGameResloadPanel.loadNo = self:GetCurComp('WidgetRoot/bg/loadNo', 'Top_UILabel')
    UIGameResloadPanel.scheduleInfo = self:GetCurComp('WidgetRoot/infobg/info2', 'Top_UILabel')

end
function UIGameResloadPanel:InitOther()
    UIGameResloadPanel.nowTime = 0
    UIGameResloadPanel.nowLoadSize = 0
    UIGameResloadPanel.isShowLine = false
    UIGameResloadPanel.isNeedClosePanel = false
    CS.UIEventListener.Get(UIGameResloadPanel.bg.gameObject).onClick = UIGameResloadPanel.SetScheduleInfoActove
end

function update()
    UIGameResloadPanel.RefreShHotSchedule()
    if UIGameResloadPanel.mLastShowTime then
        local currentTime = unityTime.time
        if (currentTime - UIGameResloadPanel.mLastShowTime > UIGameResloadPanel.mHideTime) then
         --   UIGameResloadPanel.infobg.gameObject:SetActive(false)
        end
    end
end

---刷新热更进度
function UIGameResloadPanel.RefreShHotSchedule()
    if (CS.UnityEngine.Time.time - UIGameResloadPanel.nowTime >= 1) then
        UIGameResloadPanel.nowTime = CS.UnityEngine.Time.time;
        local waitingDownloadMaxSize = CS.CSResUpdateMgr.Instance.waitingDownloadMaxSize
        local waitingDownloadNowSize =   CS.Resource.NowDownLoadSum-- CS.SFOut.IResUpdateMgr.PreciseCurGameDownloadByteNum --CS.CSResUpdateMgr.Instance.waitingDownloadNowSize
        if waitingDownloadMaxSize ~= 0 and waitingDownloadNowSize ~= 0 then
            local line = waitingDownloadNowSize / waitingDownloadMaxSize;
            UIGameResloadPanel.line.fillAmount = line
            UIGameResloadPanel.loadNo.text = math.modf((line) * 100) .. "%"
            UIGameResloadPanel.RefreShscheduleInfo(waitingDownloadNowSize, waitingDownloadMaxSize)
            if math.modf((line) * 100) >= 100 and UIGameResloadPanel.isNeedClosePanel == false then
                UIGameResloadPanel.isNeedClosePanel = true
            end

            if UIGameResloadPanel.isShowLine == false then
                -- UIGameResloadPanel.bg.gameObject:SetActive(true)
                UIGameResloadPanel.isShowLine = true
            end
        end
        if UIGameResloadPanel.isNeedClosePanel or waitingDownloadMaxSize == 0 then
            CS.SDKManager.GameInterface:startBackdownIL2CPP();
            uimanager:ClosePanel('UIGameResloadPanel')
            UIGameResloadPanel.isNeedClosePanel = false
        end
    end
end

function UIGameResloadPanel.RefreShscheduleInfo(waitingDownloadNowSize, waitingDownloadMaxSize)

    UIGameResloadPanel.WifiShow()

    local newLoadSize = waitingDownloadNowSize;
    local speed = CS.Utility.DataSize(waitingDownloadNowSize - UIGameResloadPanel.nowLoadSize, "#.##")
    UIGameResloadPanel.scheduleInfo.text = CS.Utility.DataSize(waitingDownloadNowSize, "#.##") .. "/" .. CS.Utility.DataSize(waitingDownloadMaxSize, "#.##") .. "(" .. speed .. "/S)"
    UIGameResloadPanel.nowLoadSize = newLoadSize

end

---设置热更详细信息开关状态
function UIGameResloadPanel.SetScheduleInfoActove()
    UIGameResloadPanel.infobg.gameObject:SetActive(not UIGameResloadPanel.infobg.gameObject.activeInHierarchy)
    UIGameResloadPanel.mLastShowTime = unityTime.time
end

function UIGameResloadPanel:Init()
    self:InitComponents()
    self:InitOther()
    self.WifiShow()

end

function UIGameResloadPanel.WifiShow()
    local isWifi = CS.CSResUpdateMgr.Instance.IsWifiConnect
    if CS.CSResUpdateMgr.Instance.IsPermanentGameHotTip then
        UIGameResloadPanel.bg.gameObject:SetActive(true)
        return
    end
    if isWifi == false and UIGameResloadPanel.bg.gameObject.activeInHierarchy == false then
        UIGameResloadPanel.bg.gameObject:SetActive(true)
    end
    if isWifi == true and UIGameResloadPanel.bg.gameObject.activeInHierarchy then
        UIGameResloadPanel.bg.gameObject:SetActive(false)
        UIGameResloadPanel.infobg.gameObject:SetActive(false)
    end
end

function UIGameResloadPanel:RefreshUI()

end
return UIGameResloadPanel