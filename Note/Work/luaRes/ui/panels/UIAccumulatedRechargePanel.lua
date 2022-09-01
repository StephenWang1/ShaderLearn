---@class UIAccumulatedRechargePanel:UIBase 累计充值领豪礼
local UIAccumulatedRechargePanel = {}

---获得当前期充值计划信息
---@return rechargeV2.ResCumChargeInfo
function UIAccumulatedRechargePanel.GetAccumulatedRechargInfo()
    if UIAccumulatedRechargePanel.mAccumulatedRechargInfo == nil then
        if gameMgr:GetPlayerDataMgr() then
            return gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():GetMissionInfoByPeriod(UIAccumulatedRechargePanel.curPeriod)
        end
    end
    return UIAccumulatedRechargePanel.mAccumulatedRechargInfo
end

--region 初始化

function UIAccumulatedRechargePanel:Init()
    self:InitComponents()
    UIAccumulatedRechargePanel.InitParameters()
    UIAccumulatedRechargePanel.BindUIEvents()
    UIAccumulatedRechargePanel.BindNetMessage()
    ---请求累计充值活动数据
    networkRequest.ReqCumRechargeData()
end

function UIAccumulatedRechargePanel:Show(customData)
    if customData then
        ---默认为1期
        UIAccumulatedRechargePanel.curPeriod = customData.Period == nil and 1 or customData.Period
    end
end

--- 初始化变量
function UIAccumulatedRechargePanel.InitParameters()
    UIAccumulatedRechargePanel.curPeriod = 1
    UIAccumulatedRechargePanel.amountFormat = "[fff0c2]我的累充  [ffe36f]%d元"
    ---@type table<number, rechargeV2.Reward> 奖励
    UIAccumulatedRechargePanel.missionShowList = {}
    UIAccumulatedRechargePanel.allGoUnitTemplateDic = {}
    UIAccumulatedRechargePanel.amountNum = 0
    UIAccumulatedRechargePanel.IsInitialized = false
end

--- 初始化组件
function UIAccumulatedRechargePanel:InitComponents()
    ---@type Top_UILabel
    UIAccumulatedRechargePanel.amount = self:GetCurComp("WidgetRoot/myRecharge/Num", "Top_UILabel")
    ---@type UICountdownLabel 倒计时
    UIAccumulatedRechargePanel.time = self:GetCurComp("WidgetRoot/Time", "UICountdownLabel")
    ---@type Top_UIScrollView
    UIAccumulatedRechargePanel.scrollView = self:GetCurComp("WidgetRoot/ScrollView", "Top_UIScrollView")
    ---@type UILoopScrollViewPlus
    UIAccumulatedRechargePanel.grid = self:GetCurComp("WidgetRoot/ScrollView/GridContainer", "UILoopScrollViewPlus")
end

function UIAccumulatedRechargePanel.BindUIEvents()

end

function UIAccumulatedRechargePanel.BindNetMessage()
    UIAccumulatedRechargePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCumRechargeDataMessage, UIAccumulatedRechargePanel.OnResCumRechargeDataMessageReceived)
    UIAccumulatedRechargePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCumChargeInfoMessage, UIAccumulatedRechargePanel.OnResCumChargeInfoMessageReceived)
end
--endregion

--region 函数监听

--endregion


--region 网络消息处理

---初次发送返回所有
function UIAccumulatedRechargePanel.OnResCumRechargeDataMessageReceived()
    UIAccumulatedRechargePanel.mAccumulatedRechargInfo = nil
    UIAccumulatedRechargePanel.InitUI()
end

---返回某期用于刷新
function UIAccumulatedRechargePanel.OnResCumChargeInfoMessageReceived()
    UIAccumulatedRechargePanel.mAccumulatedRechargInfo = nil
    UIAccumulatedRechargePanel.RefreshRechargeView()
end


--endregion

--region View

---初始化ui
function UIAccumulatedRechargePanel.InitUI()
    local info = UIAccumulatedRechargePanel.GetAccumulatedRechargInfo()
    if info ~= nil and info.endTime ~= nil then
        UIAccumulatedRechargePanel.time:StartCountDown(nil, 8, info.endTime,
                '活动剩余时间', "", nil, nil)
    end

    UIAccumulatedRechargePanel.RefreshRechargeView()
end

---刷新累充视图
function UIAccumulatedRechargePanel.RefreshRechargeView()
    local info = UIAccumulatedRechargePanel.GetAccumulatedRechargInfo()
    if info == nil then
        return
    end
    UIAccumulatedRechargePanel.amountNum = info.amount
    UIAccumulatedRechargePanel.amount.text = string.format(UIAccumulatedRechargePanel.amountFormat, info.amount)
    UIAccumulatedRechargePanel.RefreshRechargeMissionView()
end

function UIAccumulatedRechargePanel.RefreshRechargeMissionView()
    if UIAccumulatedRechargePanel.scrollView == nil then
        return
    end

    if UIAccumulatedRechargePanel.grid == nil then
        return
    end

    UIAccumulatedRechargePanel.scrollView:ResetPosition()
    UIAccumulatedRechargePanel.RefreshMissionShowData()
    UIAccumulatedRechargePanel.RefreshMissionGridView()
end

---刷新累充任务视图
function UIAccumulatedRechargePanel.RefreshMissionGridView()
    if not UIAccumulatedRechargePanel.IsInitialized then
        UIAccumulatedRechargePanel.grid:Init(UIAccumulatedRechargePanel.RefreshMissionUnitTemplateView, nil)
    else
        UIAccumulatedRechargePanel.grid:ResetPage()
    end
end

function UIAccumulatedRechargePanel.RefreshMissionUnitTemplateView(go, line)
    if go == nil or line + 1 > #UIAccumulatedRechargePanel.missionShowList then
        return false
    end
    local data = {}
    data.missionData = UIAccumulatedRechargePanel.missionShowList[line + 1]
    data.amount = UIAccumulatedRechargePanel.amountNum
    local template = UIAccumulatedRechargePanel.allGoUnitTemplateDic[go]
    if template == nil then
        ---@type UIAccumulatedRechargeUnitTemplate
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAccumulatedRechargeUnitTemplate)
        UIAccumulatedRechargePanel.allGoUnitTemplateDic[go] = template
    end
    template:SetTemplate(data)
    return true
end

--endregion

--region otherFunction

---刷新累充任务数据
function UIAccumulatedRechargePanel.RefreshMissionShowData()
    UIAccumulatedRechargePanel.missionShowList = {}
    local info = UIAccumulatedRechargePanel.GetAccumulatedRechargInfo()
    if info == nil then
        return
    end

    ---拷贝数据
    for i = 1, #info.rewards do
        table.insert(UIAccumulatedRechargePanel.missionShowList, info.rewards[i])
    end
    table.sort(UIAccumulatedRechargePanel.missionShowList, UIAccumulatedRechargePanel.SortTbl)
end

---@param l rechargeV2.Reward
---@param r rechargeV2.Reward
function UIAccumulatedRechargePanel.SortTbl(l, r)
    if l == nil or r == nil then
        return false
    end

    if l.state ~= r.state then
        if l.state == 1 or r.state == 1 then
            return r.state == 1
        end
        return l.state > r.state
    end

    local a, b = 0, 0
    local lTbl = clientTableManager.cfg_cum_rechargeManager:TryGetValue(l.id)
    if lTbl ~= nil and lTbl:GetSmallId() ~= nil then
        a = lTbl:GetSmallId()
    end

    local rTbl = clientTableManager.cfg_cum_rechargeManager:TryGetValue(r.id)
    if rTbl ~= nil and rTbl:GetSmallId() ~= nil then
        b = rTbl:GetSmallId()
    end

    return a < b
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIAccumulatedRechargePanel