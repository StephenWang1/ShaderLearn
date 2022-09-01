---@class UIRegisterGiftPanel:UIBase 登录有礼活动面板
local UIRegisterGiftPanel = {}

---获得服务器发送活动信息
---@return activitiesV2.ResOneActivitiesInfo
function UIRegisterGiftPanel.GetServerSingleActivityInfo()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(UIRegisterGiftPanel.curType)
    end
    return nil
end

--region 初始化

function UIRegisterGiftPanel:Init()
    self:InitComponents()
    UIRegisterGiftPanel.InitParameters()
    UIRegisterGiftPanel.BindNetMessage()
end

---@param activityData SpecialActivityPanelData
function UIRegisterGiftPanel:Show(activityData)
    if activityData == nil then
        return
    end
    UIRegisterGiftPanel.activityAllData = activityData
    UIRegisterGiftPanel.curType = activityData.mEventID
    UIRegisterGiftPanel.curActivityId = activityData.mActivityID
    UIRegisterGiftPanel.InitUI()
end

--- 初始化变量
function UIRegisterGiftPanel.InitParameters()
    UIRegisterGiftPanel.curType = 0
    UIRegisterGiftPanel.curActivityId = 0
    UIRegisterGiftPanel.IsInitialized = false
    UIRegisterGiftPanel.desStrFormat = "等级需要达到%d级"
    UIRegisterGiftPanel.GiftShowList = {}
    UIRegisterGiftPanel.AllGoUnitTemplateDic = {}
end

--- 初始化组件
function UIRegisterGiftPanel:InitComponents()
    ---@type UILabel 活动时间
    UIRegisterGiftPanel.time = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    ---@type UILabel 描述
    UIRegisterGiftPanel.des = self:GetCurComp("WidgetRoot/view/desc/Label", "Top_UILabel")
    ---@type UILoopScrollViewPlus 列表
    UIRegisterGiftPanel.grid = self:GetCurComp("WidgetRoot/view/GiftList/scroll/grid", "UILoopScrollViewPlus")
    ---@type Top_UIScrollView
    UIRegisterGiftPanel.scrollView = self:GetCurComp("WidgetRoot/view/GiftList/scroll", "Top_UIScrollView")
end

function UIRegisterGiftPanel.BindNetMessage()
    UIRegisterGiftPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneActivitiesInfoMessage, UIRegisterGiftPanel.onResOneActivitiesInfoCallBack)
end
--endregion

--region 函数监听

--endregion


--region 网络消息处理

function UIRegisterGiftPanel.onResOneActivitiesInfoCallBack(id, tblData)
    if tblData == nil or tblData.type ~= UIRegisterGiftPanel.curType then
        return
    end
    UIRegisterGiftPanel.RefreshGiftView()
end

--endregion

--region View

function UIRegisterGiftPanel.InitUI()

    if UIRegisterGiftPanel.activityAllData == nil then
        return
    end

    if UIRegisterGiftPanel.activityAllData ~= nil and UIRegisterGiftPanel.activityAllData.mFinishTime ~= nil then
        UIRegisterGiftPanel.time:StartCountDown(nil, 8, UIRegisterGiftPanel.activityAllData.mFinishTime * 1000,
                '活动倒计时', "", nil, nil)
    end

    local tbl = clientTableManager.cfg_special_activityManager:TryGetValue(UIRegisterGiftPanel.curActivityId)
    if tbl and tbl:GetSupply() and tbl:GetSupply().list and #tbl:GetSupply().list > 0 then
        local conditionId = tbl:GetSupply().list[1]
        ---@type TABLE.cfg_conditions
        local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(conditionId)
        if conditionTbl and conditionTbl:GetConditionParam() and conditionTbl:GetConditionParam().list ~= nil and conditionTbl:GetConditionParam().list.Count > 0 then
            UIRegisterGiftPanel.des.text = string.format(UIRegisterGiftPanel.desStrFormat, conditionTbl:GetConditionParam().list[0])
        end
    end

    UIRegisterGiftPanel.RefreshGiftView()
end

function UIRegisterGiftPanel.RefreshGiftView()
    if UIRegisterGiftPanel.scrollView == nil then
        return
    end

    if UIRegisterGiftPanel.grid == nil then
        return
    end

    UIRegisterGiftPanel.scrollView:ResetPosition()
    UIRegisterGiftPanel.RefreshGiftShowData()
    UIRegisterGiftPanel.RefreshGridView()
end

function UIRegisterGiftPanel.RefreshGridView()
    if not UIRegisterGiftPanel.IsInitialized then
        UIRegisterGiftPanel.grid:Init(UIRegisterGiftPanel.RefreshGiftUnitTemplateView, nil)
    else
        UIRegisterGiftPanel.grid:ResetPage()
    end
end

function UIRegisterGiftPanel.RefreshGiftUnitTemplateView(go, line)
    if go == nil or line + 1 > #UIRegisterGiftPanel.GiftShowList then
        return false
    end
    ---@type activitiesV2.OneActivitiesInfo
    local data = UIRegisterGiftPanel.GiftShowList[line + 1]

    local template = UIRegisterGiftPanel.AllGoUnitTemplateDic[go]
    if template == nil then
        ---@type UIRegisterGiftPanelUnitTemplate
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIRegisterGiftPanelUnitTemplate)
        UIRegisterGiftPanel.AllGoUnitTemplateDic[go] = template
    end
    template:SetTemplate(data)
    return true
end

--endregion

--region otherFunction

function UIRegisterGiftPanel.RefreshGiftShowData()
    UIRegisterGiftPanel.GiftShowList = {}

    local info = UIRegisterGiftPanel.GetServerSingleActivityInfo()
    if info == nil or info.oneActivitiesInfo == nil or #info.oneActivitiesInfo == 0 then
        return
    end

    UIRegisterGiftPanel.GiftShowList = info.oneActivitiesInfo

    table.sort(UIRegisterGiftPanel.GiftShowList, UIRegisterGiftPanel.SortTbl)
end
---@param l activitiesV2.OneActivitiesInfo
---@param r activitiesV2.OneActivitiesInfo
function UIRegisterGiftPanel.SortTbl(l, r)
    if l == nil or r == nil then
        return false
    end

    if l.finish ~= r.finish then
        if l.finish == 1 or r.finish == 1 then
            return r.finish == 1
        end
        return l.finish > r.finish
    end

    local a, b = 0, 0
    local lTbl = clientTableManager.cfg_special_activityManager:TryGetValue(l.configId)
    if lTbl ~= nil and lTbl:GetSmallId() ~= nil then
        a = lTbl:GetSmallId()
    end

    local rTbl = clientTableManager.cfg_special_activityManager:TryGetValue(r.configId)
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

return UIRegisterGiftPanel