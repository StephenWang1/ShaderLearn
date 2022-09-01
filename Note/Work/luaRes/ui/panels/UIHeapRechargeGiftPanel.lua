---@class UIHeapRechargeGiftPanel:UIBase 累充活动
local UIHeapRechargeGiftPanel = {}

---获得服务器发送活动信息
---@return activitiesV2.ResOneActivitiesInfo
function UIHeapRechargeGiftPanel.GetServerSingleActivityInfo()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(UIHeapRechargeGiftPanel.curType)
    end
    return nil
end

--region 初始化

function UIHeapRechargeGiftPanel:Init()
    self:InitComponents()
    UIHeapRechargeGiftPanel.InitParameters()
    UIHeapRechargeGiftPanel.BindUIEvents()
    UIHeapRechargeGiftPanel.BindNetMessage()
end

---@param activityData SpecialActivityPanelData
function UIHeapRechargeGiftPanel:Show(activityData)
    if activityData == nil then
        return
    end
    UIHeapRechargeGiftPanel.curGear = 0
    UIHeapRechargeGiftPanel.GearIsInitialized = false
    UIHeapRechargeGiftPanel.activityAllData = activityData
    UIHeapRechargeGiftPanel.curType = activityData.mEventID
    UIHeapRechargeGiftPanel.InitUI()
end

---初始化变量
function UIHeapRechargeGiftPanel.InitParameters()
    ---充值档位
    UIHeapRechargeGiftPanel.gears = { 20, 200 }
    UIHeapRechargeGiftPanel.curGear = 0
    UIHeapRechargeGiftPanel.curType = 0
    UIHeapRechargeGiftPanel.curActivityId = 0
    UIHeapRechargeGiftPanel.IsInitialized = false
    ---@type table<number,<number,activitiesV2.TheRecharge>>
    UIHeapRechargeGiftPanel.activityDataTbl = {}
    UIHeapRechargeGiftPanel.AllGoUnitTemplateDic = {}
end

---初始化组件
function UIHeapRechargeGiftPanel:InitComponents()
    ---@type UILabel 活动时间
    UIHeapRechargeGiftPanel.time = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    ---@type UILoopScrollViewPlus 列表
    UIHeapRechargeGiftPanel.grid = self:GetCurComp("WidgetRoot/view/GiftList/scroll/grid", "UILoopScrollViewPlus")
    ---@type Top_UIScrollView
    UIHeapRechargeGiftPanel.scrollView = self:GetCurComp("WidgetRoot/view/GiftList/scroll", "Top_UIScrollView")
    ---@type Top_UIToggle
    UIHeapRechargeGiftPanel.firstToggle = self:GetCurComp("WidgetRoot/events/Y20Toggle", "Top_UIToggle")
    ---@type Top_UIToggle
    UIHeapRechargeGiftPanel.secondToggle = self:GetCurComp("WidgetRoot/events/Y200Toggle", "Top_UIToggle")
    ---@type GameObject
    UIHeapRechargeGiftPanel.extraTemplateGo = self:GetCurComp("WidgetRoot/view/GiftList/extra template", "GameObject")
end

function UIHeapRechargeGiftPanel.BindUIEvents()
    CS.EventDelegate.Add(UIHeapRechargeGiftPanel.firstToggle.onChange, UIHeapRechargeGiftPanel.FirstToggleChanged)
    CS.EventDelegate.Add(UIHeapRechargeGiftPanel.secondToggle.onChange, UIHeapRechargeGiftPanel.SecondToggleChanged)
end

function UIHeapRechargeGiftPanel.BindNetMessage()
    UIHeapRechargeGiftPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneActivitiesInfoMessage, UIHeapRechargeGiftPanel.onResOneActivitiesInfoCallBack)
end
--endregion

--region 函数监听
function UIHeapRechargeGiftPanel.FirstToggleChanged()
    if UIHeapRechargeGiftPanel.curGear == UIHeapRechargeGiftPanel.gears[1] then
        return
    end

    if UIHeapRechargeGiftPanel.firstToggle.value then
        UIHeapRechargeGiftPanel.curGear = UIHeapRechargeGiftPanel.gears[1]
        UIHeapRechargeGiftPanel.RefreshGridView()
    end
end

function UIHeapRechargeGiftPanel.SecondToggleChanged()

    if UIHeapRechargeGiftPanel.curGear == UIHeapRechargeGiftPanel.gears[2] then
        return
    end

    if UIHeapRechargeGiftPanel.secondToggle.value then
        UIHeapRechargeGiftPanel.curGear = UIHeapRechargeGiftPanel.gears[2]
        UIHeapRechargeGiftPanel.RefreshGridView()
    end
end

--endregion


--region 网络消息处理

---接收活动信息累充回调
---@param tblData activitiesV2.ResOneActivitiesInfo
function UIHeapRechargeGiftPanel.onResOneActivitiesInfoCallBack(id, tblData)
    if tblData == nil or tblData.type ~= UIHeapRechargeGiftPanel.curType then
        return
    end
    UIHeapRechargeGiftPanel.RefreshHeapRechargeView()
end

--endregion

--region View

function UIHeapRechargeGiftPanel.InitUI()
    if UIHeapRechargeGiftPanel.activityAllData == nil then
        return
    end
    if UIHeapRechargeGiftPanel.activityAllData ~= nil and UIHeapRechargeGiftPanel.activityAllData.mFinishTime ~= nil then
        UIHeapRechargeGiftPanel.time:StartCountDown(nil, 8, UIHeapRechargeGiftPanel.activityAllData.mFinishTime * 1000,
                '活动倒计时', "", nil, nil)
    end

    UIHeapRechargeGiftPanel.RefreshHeapRechargeView()
    UIHeapRechargeGiftPanel.InitToggleView()
end

function UIHeapRechargeGiftPanel.InitToggleView()
    UIHeapRechargeGiftPanel.firstToggle.value = UIHeapRechargeGiftPanel.curGear == UIHeapRechargeGiftPanel.gears[1]
    UIHeapRechargeGiftPanel.secondToggle.value = UIHeapRechargeGiftPanel.curGear == UIHeapRechargeGiftPanel.gears[2]
end

---刷新累充视图
function UIHeapRechargeGiftPanel.RefreshHeapRechargeView()
    UIHeapRechargeGiftPanel.RefreshActivityData()
    UIHeapRechargeGiftPanel.RefreshGridView()
end

---刷新累充列表视图
function UIHeapRechargeGiftPanel.RefreshGridView()
    if UIHeapRechargeGiftPanel.scrollView == nil then
        return
    end

    if UIHeapRechargeGiftPanel.grid == nil then
        return
    end
    UIHeapRechargeGiftPanel.scrollView:ResetPosition()
    UIHeapRechargeGiftPanel.RefreshUnitGrid()
end

---刷新累充列表
function UIHeapRechargeGiftPanel.RefreshUnitGrid()
    if not UIHeapRechargeGiftPanel.IsInitialized then
        UIHeapRechargeGiftPanel.grid:Init(UIHeapRechargeGiftPanel.RefreshUnitTemplateView, nil)
    else
        UIHeapRechargeGiftPanel.grid:ResetPage()
    end
    UIHeapRechargeGiftPanel.RefreshExtraUnitTemplateView()
end

---刷新累充单元
function UIHeapRechargeGiftPanel.RefreshUnitTemplateView(go, line)
    if UIHeapRechargeGiftPanel.activityDataTbl[UIHeapRechargeGiftPanel.curGear] == nil then
        return false
    end

    if go == nil or line + 1 > #UIHeapRechargeGiftPanel.activityDataTbl[UIHeapRechargeGiftPanel.curGear] then
        return false
    end

    ---@type activitiesV2.TheRecharge
    local data = UIHeapRechargeGiftPanel.activityDataTbl[UIHeapRechargeGiftPanel.curGear][line + 1]
    local template = UIHeapRechargeGiftPanel.AllGoUnitTemplateDic[go]
    if template == nil then
        ---@type UIHeapRechargeUnitTemplate
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIHeapRechargeUnitTemplate)
        UIHeapRechargeGiftPanel.AllGoUnitTemplateDic[go] = template
    end

    template:SetTemplate(data)
    return true
end

---刷新额外累充单元
function UIHeapRechargeGiftPanel.RefreshExtraUnitTemplateView()
    local go = UIHeapRechargeGiftPanel.extraTemplateGo
    ---@type activitiesV2.TheRecharge
    local data = UIHeapRechargeGiftPanel.activityExtraDataTbl[UIHeapRechargeGiftPanel.curGear][1]
    local template = UIHeapRechargeGiftPanel.AllGoUnitTemplateDic[go]
    if template == nil then
        ---@type UIHeapRechargeUnitTemplate
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIHeapRechargeUnitTemplate)
        UIHeapRechargeGiftPanel.AllGoUnitTemplateDic[go] = template
    end

    template:SetTemplate(data)
end

--endregion

--region otherFunction

function UIHeapRechargeGiftPanel.RefreshActivityData()
    UIHeapRechargeGiftPanel.activityDataTbl = {}
    UIHeapRechargeGiftPanel.activityExtraDataTbl = {}

    local info = UIHeapRechargeGiftPanel.GetServerSingleActivityInfo()
    if info == nil or info.recharges == nil or #info.recharges == 0 then
        return
    end
    ---根据档位区分
    for i = 1, #info.recharges do
        ---@type activitiesV2.TheRecharge
        local info = info.recharges[i]

        local lTbl = clientTableManager.cfg_special_activityManager:TryGetValue(info.id)
        if lTbl ~= nil and lTbl:GetSmallId() ~= nil then
            if (lTbl:GetSmallId() ~= 999) then
                if UIHeapRechargeGiftPanel.activityDataTbl[info.theGear] == nil then
                    UIHeapRechargeGiftPanel.activityDataTbl[info.theGear] = {}
                end
                table.insert(UIHeapRechargeGiftPanel.activityDataTbl[info.theGear], info)
            else
                if UIHeapRechargeGiftPanel.activityExtraDataTbl[info.theGear] == nil then
                    UIHeapRechargeGiftPanel.activityExtraDataTbl[info.theGear] = {}
                end
                table.insert(UIHeapRechargeGiftPanel.activityExtraDataTbl[info.theGear], info)
            end
        end
    end

    for i, v in pairs(UIHeapRechargeGiftPanel.activityDataTbl) do
        table.sort(v, UIHeapRechargeGiftPanel.SortTbl)
    end
    for i, v in pairs(UIHeapRechargeGiftPanel.activityExtraDataTbl) do
        table.sort(v, UIHeapRechargeGiftPanel.SortTbl)
    end
    if not UIHeapRechargeGiftPanel.GearIsInitialized then
        UIHeapRechargeGiftPanel.GearIsInitialized = true
        UIHeapRechargeGiftPanel.SetCurShowGear()
    end
end

---@param l activitiesV2.TheRecharge
---@param r activitiesV2.TheRecharge
function UIHeapRechargeGiftPanel.SortTbl(l, r)
    if l == nil or r == nil then
        return false
    end
    local aRewardType = l.rewardType == 3 and 0 or l.rewardType
    local bRewardType = r.rewardType == 3 and 0 or r.rewardType

    if aRewardType ~= bRewardType then
        if aRewardType == 1 or bRewardType == 1 then
            return bRewardType == 1
        end
        return aRewardType > bRewardType
    end

    local a, b = 0, 0
    local lTbl = clientTableManager.cfg_special_activityManager:TryGetValue(l.id)
    if lTbl ~= nil and lTbl:GetSmallId() ~= nil then
        a = lTbl:GetSmallId()
    end

    local rTbl = clientTableManager.cfg_special_activityManager:TryGetValue(r.id)
    if rTbl ~= nil and rTbl:GetSmallId() ~= nil then
        b = rTbl:GetSmallId()
    end

    return a < b
end

---设置当前应该显示的档位
function UIHeapRechargeGiftPanel.SetCurShowGear()
    ---@type activitiesV2.TheRecharge
    local giftUnit = nil
    for i, v in pairs(UIHeapRechargeGiftPanel.activityDataTbl) do
        for j = 1, #v do
            giftUnit = v[j]
            if giftUnit.rewardType == 2 then
                if UIHeapRechargeGiftPanel.curGear > v[j].theGear or UIHeapRechargeGiftPanel.curGear == 0 then
                    UIHeapRechargeGiftPanel.curGear = v[j].theGear
                end
            end
        end
    end
    if UIHeapRechargeGiftPanel.curGear == 0 then
        UIHeapRechargeGiftPanel.curGear = UIHeapRechargeGiftPanel.gears[1]
    end
end

--endregion

--region ondestroy

function ondestroy()

end

--endregion

return UIHeapRechargeGiftPanel