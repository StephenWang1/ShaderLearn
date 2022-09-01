---@class UIPrisonPanel 典狱长对话面板
local UIPrisonPanel = {}

--region 局部变量
UIPrisonPanel.btnType = 1
UIPrisonPanel.remainTime = 0
UIPrisonPanel.IenumRefreshTime = nil
--endregion

--region 初始化

function UIPrisonPanel:Init()
    self:InitComponents()
    UIPrisonPanel.BindUIEvents()
    UIPrisonPanel.InitGrid()
    UIPrisonPanel.BindNetMessage()
end

function UIPrisonPanel:Show(time)
    if time then
        UIPrisonPanel.remainTime = time
        UIPrisonPanel.RefreshTime()
    end
end
--- 初始化组件
function UIPrisonPanel:InitComponents()
    ---@type UnityEngine.GameObject
    UIPrisonPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    ---@type Top_UIGridContainer
    UIPrisonPanel.BtnList = self:GetCurComp("WidgetRoot/view/PrisonBtn/BtnList", "Top_UIGridContainer")
    ---@type Top_UILabel 监狱倒计时
    UIPrisonPanel.lb_countdown = self:GetCurComp("WidgetRoot/view/lb_countdown", "Top_UILabel")
end

function UIPrisonPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIPrisonPanel.btn_close).onClick = UIPrisonPanel.OnClickbtn_close
end

function UIPrisonPanel.BindNetMessage()
end
--endregion

--region 函数监听
--点击关闭函数
---@param go UnityEngine.GameObject
function UIPrisonPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIPrisonPanel')
end

function UIPrisonPanel.OnBtnTypeClick(go)
    if UIPrisonPanel.btnType == 1 then
        local temp = {}
        temp.centerBtnCallBack = function(go)
            uimanager:ClosePanel('UIPrisonPanel')
        end
        uimanager:CreatePanel("UIPrisonPromptPanel", nil, temp)
    elseif UIPrisonPanel.btnType == 2 or UIPrisonPanel.btnType == 3 then
        networkRequest.ReqEarlyLeavePrison(UIPrisonPanel.btnType)
        uimanager:ClosePanel('UIPrisonPanel')
    end
end

--endregion

--region 网络消息处理

--endregion

--region UI

function UIPrisonPanel.InitGrid()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20559)
    if not isFind then
        return
    end
    local btnsInfo = string.Split(info.value, '&')
    if btnsInfo == nil then
        return
    end
    UIPrisonPanel.BtnList.MaxCount = #btnsInfo
    for i, v in pairs(btnsInfo) do
        local go = UIPrisonPanel.BtnList.controlList[i - 1].gameObject
        if go then
            local btnInfo = string.Split(v, '#')
            local label = CS.Utility_Lua.GetComponent(go.transform:Find('label'), "Top_UILabel")
            if label then
                label.text = btnInfo[2]
            end
            CS.UIEventListener.Get(go).onClick = nil
            CS.UIEventListener.Get(go).onClick = function(go)
                UIPrisonPanel.btnType = tonumber(btnInfo[1])
                UIPrisonPanel.OnBtnTypeClick(go)
            end
        end
    end
end

function UIPrisonPanel.RefreshTime()
    if UIPrisonPanel.remainTime ~= 0 then
        if UIPrisonPanel.IenumRefreshTime ~= nil then
            StopCoroutine(UIPrisonPanel.IenumRefreshTime)
            UIPrisonPanel.IenumRefreshTime = nil
        end
        UIPrisonPanel.IenumRefreshTime = StartCoroutine(UIPrisonPanel.IEnumRefreshTime, UIPrisonPanel.remainTime)
    else
        UIPrisonPanel.lb_countdown.gameObject:SetActive(false)
    end
end

--endregion

--region otherFunction

function UIPrisonPanel.IEnumRefreshTime(time)
    local isRefresh = true
    local refreshTime = time / 1000
    refreshTime = math.ceil(refreshTime)
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            UIPrisonPanel.lb_countdown.text = "0"
            UIPrisonPanel:ClosePanel()
        end
        UIPrisonPanel.lb_countdown.text = '(关押倒计时' .. refreshTime .. '秒)'
        refreshTime = refreshTime - 1
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

--endregion

--region ondestroy

function ondestroy()
    if UIPrisonPanel.IenumRefreshTime ~= nil then
        StopCoroutine(UIPrisonPanel.IenumRefreshTime)
        UIPrisonPanel.IenumRefreshTime = nil
    end
end

--endregion

return UIPrisonPanel