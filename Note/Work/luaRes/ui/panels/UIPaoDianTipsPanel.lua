local UIPaoDianTipsPanel = {}

UIPaoDianTipsPanel.exp = nil
--region 组件
function UIPaoDianTipsPanel.GetTitle_UILabel()
    if (UIPaoDianTipsPanel.mTitle == nil) then
        UIPaoDianTipsPanel.mTitle = UIPaoDianTipsPanel:GetCurComp("WidgetRoot/Title", "UILabel")
    end
    return UIPaoDianTipsPanel.mTitle
end

function UIPaoDianTipsPanel:GetTimeContent_UILabel()
    if (self.mTimeContent == nil) then
        self.mTimeContent = self:GetCurComp("WidgetRoot/TimeContent", "UILabel")
    end
    return self.mTimeContent
end

function UIPaoDianTipsPanel.GetOfflineTimeContent_UILabel()
    if (UIPaoDianTipsPanel.mOfflineTimeContent == nil) then
        UIPaoDianTipsPanel.mOfflineTimeContent = UIPaoDianTipsPanel:GetCurComp("WidgetRoot/OfflineTimeContent", "UILabel")
    end
    return UIPaoDianTipsPanel.mOfflineTimeContent
end

function UIPaoDianTipsPanel:GetExpContent_UILabel()
    if (self.mExpContent == nil) then
        self.mExpContent = self:GetCurComp("WidgetRoot/ExpContent", "UILabel")
    end
    return self.mExpContent
end

function UIPaoDianTipsPanel.GetExpContent2_UILabel()
    if (UIPaoDianTipsPanel.mExpContent2 == nil) then
        UIPaoDianTipsPanel.mExpContent2 = UIPaoDianTipsPanel:GetCurComp("WidgetRoot/ExpContent2", "UILabel")
    end
    return UIPaoDianTipsPanel.mExpContent2
end

function UIPaoDianTipsPanel.GetCancleBtn_GameObject()
    if (UIPaoDianTipsPanel.mCancleBtn == nil) then
        UIPaoDianTipsPanel.mCancleBtn = UIPaoDianTipsPanel:GetCurComp("WidgetRoot/events/LeftBtn", "GameObject")
    end
    return UIPaoDianTipsPanel.mCancleBtn
end

function UIPaoDianTipsPanel.GetConfirmBtn_GameObject()
    if (UIPaoDianTipsPanel.mConfirmBtn == nil) then
        UIPaoDianTipsPanel.mConfirmBtn = UIPaoDianTipsPanel:GetCurComp("WidgetRoot/events/RightBtn", "GameObject")
    end
    return UIPaoDianTipsPanel.mConfirmBtn
end

function UIPaoDianTipsPanel.GetCloseBtn_GameObject()
    if (UIPaoDianTipsPanel.mCloseBtn == nil) then
        UIPaoDianTipsPanel.mCloseBtn = UIPaoDianTipsPanel:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return UIPaoDianTipsPanel.mCloseBtn
end

function UIPaoDianTipsPanel.GetMainChatPanel()
    if (UIPaoDianTipsPanel.mainchatpanel == nil) then
        UIPaoDianTipsPanel.mainchatpanel = uimanager:GetPanel("UIMainChatPanel")
    end
    return UIPaoDianTipsPanel.mainchatpanel
end

---@return UnityEngine.GameObject 基础
function UIPaoDianTipsPanel:GetExpContent1_GO()
    if self.mExpContent1Go == nil then
        self.mExpContent1Go = self:GetCurComp("WidgetRoot/title/ExpContent1", "GameObject")
    end
    return self.mExpContent1Go
end

---@return UILabel 基础
function UIPaoDianTipsPanel:GetExpNum1_UILabel()
    if self.mExpNum1Lb == nil then
        self.mExpNum1Lb = self:GetCurComp("WidgetRoot/value/ExpNum1", "UILabel")
    end
    return self.mExpNum1Lb
end

---@return UnityEngine.GameObject 繁荣度
function UIPaoDianTipsPanel:GetExpContent2_GO()
    if self.mExpContent2Go == nil then
        self.mExpContent2Go = self:GetCurComp("WidgetRoot/title/ExpContent2", "GameObject")
    end
    return self.mExpContent2Go
end

---@return UILabel 繁荣度
function UIPaoDianTipsPanel:GetExpNum2_UILabel()
    if self.mExpNum2Lb == nil then
        self.mExpNum2Lb = self:GetCurComp("WidgetRoot/value/ExpNum2", "UILabel")
    end
    return self.mExpNum2Lb
end

---@return UnityEngine.GameObject VIP
function UIPaoDianTipsPanel:GetExpContent3_GO()
    if self.mExpContent3Go == nil then
        self.mExpContent3Go = self:GetCurComp("WidgetRoot/title/ExpContent3", "GameObject")
    end
    return self.mExpContent3Go
end

---@return UILabel VIP
function UIPaoDianTipsPanel:GetExpNum3_UILabel()
    if self.mExpNum3Lb == nil then
        self.mExpNum3Lb = self:GetCurComp("WidgetRoot/value/ExpNum3", "UILabel")
    end
    return self.mExpNum3Lb
end

--endregion

--region 初始化
function UIPaoDianTipsPanel:Init()
    UIPaoDianTipsPanel.BindUIEvent()
    local isFind, tblData = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20356)
    if (isFind) then
        UIPaoDianTipsPanel.TotalTime = tonumber(tblData.value:Split("#")[3])
    end
end

---@param data roleV2.BubbleOfflineExp
function UIPaoDianTipsPanel:Show(data)
    if data then
        local time = data.offlineTime
        local hour = math.floor(time / (60 * 60 * 1000))
        local minute = math.floor((time - hour * (60 * 60 * 1000)) / (60 * 1000))
        local minuteShow = minute > 0 and minute .. "分[-]" or ""
        local lastDay = luaEnumColorType.Gray .. "前一日离线时长  " .. hour .. "时" .. minuteShow
        self:GetTimeContent_UILabel().text = lastDay

        local dataColor = "[A4CEf6]"
        local center = 22
        local des = 32

        local num = 0
        num = num + 1
        self:GetExpNum1_UILabel().text = dataColor .. data.exp

        if data.developExp > 0 then
            num = num + 1
            self:GetExpNum2_UILabel().text = dataColor .. data.developExp
        else
            self:GetExpNum2_UILabel().gameObject:SetActive(false)
            self:GetExpContent2_GO():SetActive(false)
        end

        if data.vipExp > 0 then
            num = num + 1
            self:GetExpNum3_UILabel().text = dataColor .. data.vipExp .. "[-][00ff00](" .. data.vipPercent .. "%)[-]"
        else
            self:GetExpNum3_UILabel().gameObject:SetActive(false)
            self:GetExpContent3_GO():SetActive(false)
        end

        local totalHeight = (num - 1) * des / 2 + center

        local posValue1 = self:GetExpNum1_UILabel().transform.localPosition
        posValue1.y = totalHeight
        self:GetExpNum1_UILabel().transform.localPosition = posValue1
        local posContent1 = self:GetExpContent1_GO().transform.localPosition
        posContent1.y = totalHeight
        self:GetExpContent1_GO().transform.localPosition = posContent1

        if data.developExp > 0 then
            totalHeight = totalHeight - des

            local posValue2 = self:GetExpNum2_UILabel().transform.localPosition
            posValue2.y = totalHeight
            self:GetExpNum2_UILabel().transform.localPosition = posValue2
            local posContent2 = self:GetExpContent2_GO().transform.localPosition
            posContent2.y = totalHeight
            self:GetExpContent2_GO().transform.localPosition = posContent2
        end

        if data.vipExp > 0 then
            totalHeight = totalHeight - des

            local posValue3 = self:GetExpNum3_UILabel().transform.localPosition
            posValue3.y = totalHeight
            self:GetExpNum3_UILabel().transform.localPosition = posValue3
            local posContent3 = self:GetExpContent3_GO().transform.localPosition
            posContent3.y = totalHeight
            self:GetExpContent3_GO().transform.localPosition = posContent3
        end
    else
        self:ClosePanel()
    end
end

function UIPaoDianTipsPanel.BindUIEvent()
    CS.UIEventListener.Get(UIPaoDianTipsPanel.GetCloseBtn_GameObject()).onClick = UIPaoDianTipsPanel.CloseBtnOnClick
    CS.UIEventListener.Get(UIPaoDianTipsPanel.GetConfirmBtn_GameObject()).onClick = UIPaoDianTipsPanel.ConfirmBtnOnClick
end
--endregion

--region UIEvents
function UIPaoDianTipsPanel.CancleBtnOnClick(go)
    uimanager:ClosePanel("UIPaoDianTipsPanel")
end

function UIPaoDianTipsPanel.CloseBtnOnClick(go)
    uimanager:ClosePanel("UIPaoDianTipsPanel")
end

function UIPaoDianTipsPanel.ConfirmBtnOnClick(go)
    uiStaticParameter.ExpNeedDelay = true
    local uimainchat = uimanager:GetPanel("UIMainChatPanel")
    if (uimainchat ~= nil) then
        uimainchat.OffLineBubbleOnlineExpMessage()
        Utility.RemoveFlashPrompt(1, 3)
    end
    networkRequest.ReqReceiveBubbleOfflineExp()
    uimanager:ClosePanel("UIPaoDianTipsPanel")

    --region tips
    --local dataTipsData = {}
    --dataTipsData.dialogType = LuaEnumDialogTipsShapeType.NoArrow
    --dataTipsData.contents = "经验  +" .. tostring(UIPaoDianTipsPanel.exp)
    --dataTipsData.highLightContent = nil
    --dataTipsData.contentsWidth = 270
    --dataTipsData.time = 1
    --uimanager:CreatePanel("UIDialogTipsContainerPanel", function(dialogTipsContainer)
    --    if UIPaoDianTipsPanel then
    --        UIPaoDianTipsPanel.mDialogTips = dialogTipsContainer.CreateDialogTips(dataTipsData)
    --        UIPaoDianTipsPanel.SetTipsPostion(UIPaoDianTipsPanel.mDialogTips)
    --    end
    --end)
    --endregion
end
--endregion

function UIPaoDianTipsPanel.SetTipsPostion(panel)
    if panel == nil then
        return
    end
    --判断界限 设置位置
    panel.go.transform.position = uimanager:GetPanel("UIMainChatPanel").GetOffLineEndPoint_GameObject().transform.position
end

--region 网络消息

--endregion

function ondestroy()

end

return UIPaoDianTipsPanel