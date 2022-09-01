---@class UISpeciallyPreferentialPanel:UIBase 限购礼包活动面板
local UISpeciallyPreferentialPanel = {}

---获得服务器发送活动信息
---@return activitiesV2.ResOneActivitiesInfo
function UISpeciallyPreferentialPanel.GetServerSingleActivityInfo()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(UISpeciallyPreferentialPanel.curType)
    end
    return nil
end

--region 初始化

function UISpeciallyPreferentialPanel:Init()
    self:InitComponents()
    self:BindNetMessage()
    UISpeciallyPreferentialPanel.InitParameters()
end

--- 初始化变量
function UISpeciallyPreferentialPanel.InitParameters()
    ---最大显示数量
    UISpeciallyPreferentialPanel.MaxShowCount = LuaGlobalTableDeal.GetTotalSpeciallyPreferentialCount()
    UISpeciallyPreferentialPanel.IsInitialized = false

    ---@type table<UnityEngine.GameObject,UIPurchaseLimitGiftBoxUnitTemplate>
    UISpeciallyPreferentialPanel.AllGoUnitTemplateDic = {}
    ---@type<number,activitiesV2.OneActivitiesInfo>
    UISpeciallyPreferentialPanel.GiftBoxShowList = {}
    ---@type table<number,UIPurchaseLimitGiftBoxUnitTemplate>
    --UISpeciallyPreferentialPanel.AllIDUnitTemplateDic = {}

    ---@type SpecialActivityPanelData
    UISpeciallyPreferentialPanel.activityAllData = nil
    ---@type activitiesV2.ResOneActivitiesInfo
    UISpeciallyPreferentialPanel.singleActivityData = nil
    ---@type number cfg_special_activityManager表eventID 活动类型
    UISpeciallyPreferentialPanel.curType = 0
end

--- 初始化组件
function UISpeciallyPreferentialPanel:InitComponents()
    ---@type UICountdownLabel 倒计时组件
    UISpeciallyPreferentialPanel.time = self:GetCurComp("WidgetRoot/view/label_remainDay", "UICountdownLabel")
    ---@type UILoopScrollViewPlus 礼包列表
    UISpeciallyPreferentialPanel.grid = self:GetCurComp("WidgetRoot/view/ScrollViewReward/Grid", "UILoopScrollViewPlus")
    ---@type UIScrollView
    UISpeciallyPreferentialPanel.rewardScrollView = self:GetCurComp("WidgetRoot/view/ScrollViewReward", "UIScrollView")
end

function UISpeciallyPreferentialPanel:BindNetMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneActivitiesInfoMessage, UISpeciallyPreferentialPanel.onResOneActivitiesInfoCallBack)
end

---@param activityData SpecialActivityPanelData
function UISpeciallyPreferentialPanel:Show(activityData)
    if activityData == nil then
        return
    end

    UISpeciallyPreferentialPanel.activityAllData = activityData
    UISpeciallyPreferentialPanel.curType = activityData.mEventID

    UISpeciallyPreferentialPanel.InitUI()
end

--endregion

--region 网络消息处理

---接收活动信息限购礼包回调
---@param tblData activitiesV2.ResOneActivitiesInfo
function UISpeciallyPreferentialPanel.onResOneActivitiesInfoCallBack(id, tblData)
    if tblData == nil or tblData.type ~= UISpeciallyPreferentialPanel.curType then
        return
    end
    UISpeciallyPreferentialPanel.RefreshGiftBox()
end

--endregion

--region UI
function UISpeciallyPreferentialPanel.InitUI()
    if UISpeciallyPreferentialPanel.activityAllData ~= nil and UISpeciallyPreferentialPanel.activityAllData.mFinishTime ~= nil then
        UISpeciallyPreferentialPanel.time:StartCountDown(nil, 8, UISpeciallyPreferentialPanel.activityAllData.mFinishTime * 1000,
                '活动倒计时', "", nil, nil)
    end
    UISpeciallyPreferentialPanel.RefreshGiftBox()
end

---刷新礼包视图及数据
function UISpeciallyPreferentialPanel.RefreshGiftBox()
    if UISpeciallyPreferentialPanel.rewardScrollView == nil then
        return
    end
    if UISpeciallyPreferentialPanel.grid == nil then
        return
    end
    UISpeciallyPreferentialPanel.rewardScrollView:ResetPosition()
    UISpeciallyPreferentialPanel.RefreshGiftBoxShowData()
    UISpeciallyPreferentialPanel.RefreshGiftBoxView()
end

---刷新礼包视图
function UISpeciallyPreferentialPanel.RefreshGiftBoxView()
    if not UISpeciallyPreferentialPanel.IsInitialized then
        UISpeciallyPreferentialPanel.grid:Init(UISpeciallyPreferentialPanel.RefreshGiftBoxTemplateView, nil)
    else
        UISpeciallyPreferentialPanel.grid:ResetPage()
    end
    UISpeciallyPreferentialPanel.rewardScrollView:SetSoftnessValue(true, 3)
end

---刷新单个礼包视图
function UISpeciallyPreferentialPanel.RefreshGiftBoxTemplateView(go, line)
    if go == nil or line + 1 > #UISpeciallyPreferentialPanel.GiftBoxShowList then
        return false
    end
    if line + 1 > UISpeciallyPreferentialPanel.MaxShowCount then
        return false
    end
    ---@type activitiesV2.OneActivitiesInfo
    local data = UISpeciallyPreferentialPanel.GiftBoxShowList[line + 1]

    local template = UISpeciallyPreferentialPanel.AllGoUnitTemplateDic[go]
    if template == nil then
        ---@type UIPurchaseLimitGiftBoxUnitTemplate
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIPurchaseLimitGiftBoxUnitTemplate)
        UISpeciallyPreferentialPanel.AllGoUnitTemplateDic[go] = template
    end
    template:Refresh(data)
    return true
end

--endregion

--region otherFunction

---刷新显示限购礼包列表数据
function UISpeciallyPreferentialPanel.RefreshGiftBoxShowData()
    UISpeciallyPreferentialPanel.GiftBoxShowList = {}

    local info = UISpeciallyPreferentialPanel.GetServerSingleActivityInfo()
    if info == nil or info.oneActivitiesInfo == nil or #info.oneActivitiesInfo == 0 then
        return
    end

    UISpeciallyPreferentialPanel.GiftBoxShowList = info.oneActivitiesInfo

    table.sort(UISpeciallyPreferentialPanel.GiftBoxShowList, UISpeciallyPreferentialPanel.SortTbl)
end

function UISpeciallyPreferentialPanel.SortTbl(l, r)
    if l == nil or r == nil then
        return false
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

return UISpeciallyPreferentialPanel