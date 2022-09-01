---@class UIContinuityRechargeRepayPanel:UIBase 累充
local UIContinuityRechargeRepayPanel = {}

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIContinuityRechargeRepayPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("view/RepayPanel/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UILoopScrollViewPlus
function UIContinuityRechargeRepayPanel:GetLoop_UILoopScrollViewPlus()
    if self.mLoop == nil then
        self.mLoop = self:GetCurComp("view/RepayPanel/view/ScrollView/GridContainer", "UILoopScrollViewPlus")
    end
    return self.mLoop
end

---@return UILabel
function UIContinuityRechargeRepayPanel:GetMyRechargeNum_UILabel()
    if self.mMyRecharge == nil then
        self.mMyRecharge = self:GetCurComp("view/RepayPanel/view/ContinuityRechargeTitle/num", "UILabel")
    end
    return self.mMyRecharge
end
--endregion


---获得当前期充值计划信息
---@return rechargeV2.ResCumChargeInfo
function UIContinuityRechargeRepayPanel:GetAccumulatedRechargInfo()
    if self.mAccumulatedRechargInfo == nil then
        if gameMgr:GetPlayerDataMgr() then
            local period = gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():GetCurPeriod()
            return gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():GetMissionInfoByPeriod(period)
        end
    end
    return self.mAccumulatedRechargInfo
end

--region初始化
function UIContinuityRechargeRepayPanel:Init()
    self:BindEvents()
    self:BindMessage()
    self:InitComponents()
    self:InitParameters()
    ---请求累计充值活动数据
    networkRequest.ReqCumRechargeData()
end

--region 初始化


--- 初始化变量
function UIContinuityRechargeRepayPanel:InitParameters()
    self.curPeriod = 1
    self.amountFormat = "[fff0c2]我的累充  [ffe36f]%d元"
    ---@type table<number, rechargeV2.Reward> 奖励
    self.missionShowList = {}
    self.amountNum = 0
    self.IsInitialized = false
end

--- 初始化组件
function UIContinuityRechargeRepayPanel:InitComponents()
    ---@type Top_UILabel
    self.amount = self:GetCurComp("WidgetRoot/myRecharge/Num", "Top_UILabel")
    ---@type UICountdownLabel 倒计时
    self.time = self:GetCurComp("WidgetRoot/Time", "UICountdownLabel")
    ---@type Top_UIScrollView
    self.scrollView = self:GetCurComp("WidgetRoot/ScrollView", "Top_UIScrollView")
    ---@type UILoopScrollViewPlus
    self.grid = self:GetCurComp("WidgetRoot/ScrollView/GridContainer", "UILoopScrollViewPlus")
end

--endregion

function UIContinuityRechargeRepayPanel:Show(customData)
    if customData then
        ---默认为1期
        self.curPeriod = customData.Period == nil and 1 or customData.Period
    end
end

function UIContinuityRechargeRepayPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
end

function UIContinuityRechargeRepayPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCumRechargeDataMessage, function()
        self:OnResCumRechargeDataMessageReceived()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCumChargeInfoMessage, function()
        self:OnResCumChargeInfoMessageReceived()
    end)
end

---初次发送返回所有
function UIContinuityRechargeRepayPanel:OnResCumRechargeDataMessageReceived()
    self.mAccumulatedRechargInfo = nil
    self:RefreshRecharge()
end

---返回某期用于刷新
function UIContinuityRechargeRepayPanel:OnResCumChargeInfoMessageReceived()
    self.mAccumulatedRechargInfo = nil
    self:RefreshRechargeView()
end

--endregion

function UIContinuityRechargeRepayPanel:RefreshRecharge()
    local info = self:GetAccumulatedRechargInfo()
    if info ~= nil and info.endTime ~= nil then
        -- self.time:StartCountDown(nil, 8, info.endTime, '活动剩余时间', "", nil, nil)
    end
    self:RefreshRechargeView()
end

--region View

---刷新累充视图
function UIContinuityRechargeRepayPanel:RefreshRechargeView()
    local info = self:GetAccumulatedRechargInfo()
    if info == nil then
        return
    end
    self.amountNum = info.amount
    self:GetMyRechargeNum_UILabel().text = string.format(self.amountFormat, info.amount)
    self:RefreshRechargeMissionView()

    --data.missionData.state
end

function UIContinuityRechargeRepayPanel:RefreshRechargeMissionView()
    self:RefreshMissionShowData()
    self:RefreshMissionGridView()
end

---刷新累充任务视图
function UIContinuityRechargeRepayPanel:RefreshMissionGridView()
    if not self.IsInitialized then
        self:GetLoop_UILoopScrollViewPlus():Init(function(go, line)
            return self:RefreshMissionUnitTemplateView(go, line)
        end, nil)
    else
        self:GetLoop_UILoopScrollViewPlus():ResetPage()
    end
end

---刷新单个
function UIContinuityRechargeRepayPanel:RefreshMissionUnitTemplateView(go, line)
    if go == nil or line + 1 > #self.missionShowList then
        return false
    end
    local data = {}
    data.missionData = self.missionShowList[line + 1]
    data.amount = self.amountNum
    local template = self:GetGridTemplate(go)
    template:SetTemplate(data)
    return true
end

---@return UIAccumulatedRechargeUnitTemplate 单个格子模板
function UIContinuityRechargeRepayPanel:GetGridTemplate(go)
    if self.allGoUnitTemplateDic == nil then
        self.allGoUnitTemplateDic = {}
    end
    local template = self.allGoUnitTemplateDic[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAccumulatedRechargeUnitTemplate)
        self.allGoUnitTemplateDic[go] = template
    end
    return template
end
--endregion

--region otherFunction

---刷新累充任务数据
function UIContinuityRechargeRepayPanel:RefreshMissionShowData()
    self.missionShowList = {}
    local info = self:GetAccumulatedRechargInfo()
    if info == nil then
        return
    end

    ---拷贝数据
    for i = 1, #info.rewards do
        table.insert(self.missionShowList, info.rewards[i])
    end
    table.sort(self.missionShowList, function(l, r)
        return self:SortTbl(l, r)
    end)
end

---@param l rechargeV2.Reward
---@param r rechargeV2.Reward
function UIContinuityRechargeRepayPanel:SortTbl(l, r)
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

--endregion

return UIContinuityRechargeRepayPanel