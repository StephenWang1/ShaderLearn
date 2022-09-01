---@class UIRechargeLuxuryGiftPanel : UIBase 充值豪礼
local UIRechargeLuxuryGiftPanel = {}

---获得服务器发送活动信息
---@return activitiesV2.ResOneActivitiesInfo
function UIRechargeLuxuryGiftPanel.GetServerSingleActivityInfo()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(UIRechargeLuxuryGiftPanel.curType)
    end
    return nil
end

--region 初始化

function UIRechargeLuxuryGiftPanel:Init()
    self:InitComponents()
    UIRechargeLuxuryGiftPanel.InitParameters()
    UIRechargeLuxuryGiftPanel.BindUIEvents()
    UIRechargeLuxuryGiftPanel.BindNetMessage()
end

---@param activityData SpecialActivityPanelData
function UIRechargeLuxuryGiftPanel:Show(activityData)
    if activityData == nil then
        return
    end
    UIRechargeLuxuryGiftPanel.activityAllData = activityData
    UIRechargeLuxuryGiftPanel.curType = activityData.mEventID
    UIRechargeLuxuryGiftPanel.InitUI()
end

--- 初始化变量
function UIRechargeLuxuryGiftPanel.InitParameters()
    UIRechargeLuxuryGiftPanel.mIsRecharge = true
    UIRechargeLuxuryGiftPanel.timeFormat = '活动时间      %d月%d日    %d月%d日'
    UIRechargeLuxuryGiftPanel.curActivityID = 0

    ---@type<UnityEngine.GameObject,UIItem>
    UIRechargeLuxuryGiftPanel.allTemplateByRewardGoTbl = {}
    ---@type SpecialActivityPanelData
    UIRechargeLuxuryGiftPanel.activityAllData = nil
    ---@type activitiesV2.ResOneActivitiesInfo
    UIRechargeLuxuryGiftPanel.singleActivityData = nil
    ---@type number cfg_special_activityManager表eventID 活动类型
    UIRechargeLuxuryGiftPanel.curType = 0
end

--- 初始化组件
function UIRechargeLuxuryGiftPanel:InitComponents()
    ---@type UILabel 活动时间
    UIRechargeLuxuryGiftPanel.time = self:GetCurComp("WidgetRoot/view/label_remainDay", "UICountdownLabel")
    ---@type UILabel 充值提示
    UIRechargeLuxuryGiftPanel.title = self:GetCurComp("WidgetRoot/view/title", "UILabel")
    ---@type UILabel 累充进度
    UIRechargeLuxuryGiftPanel.rechargeNum = self:GetCurComp("WidgetRoot/view/rechargeNum", "UILabel")
    ---@type UnityEngine.GameObject 已领取
    UIRechargeLuxuryGiftPanel.getedObj = self:GetCurComp("WidgetRoot/view/has_got", "GameObject")
    ---@type UIGridContainer 奖励预览
    UIRechargeLuxuryGiftPanel.reward = self:GetCurComp("WidgetRoot/view/scroll/reward", "UIGridContainer")
    ---@type UISprite 充值(领取)按钮
    UIRechargeLuxuryGiftPanel.btn_recharge = self:GetCurComp("WidgetRoot/view/btn_recharge", "UISprite")
    ---@type UILabel 充值(领取)按钮文本
    UIRechargeLuxuryGiftPanel.btn_Label = self:GetCurComp("WidgetRoot/view/btn_recharge/Label", "UILabel")
    ---@type UnityEngine.GameObject 按钮特效
    UIRechargeLuxuryGiftPanel.effect = self:GetCurComp("WidgetRoot/view/btn_recharge/Effect", "GameObject")
end

function UIRechargeLuxuryGiftPanel.BindUIEvents()
    CS.UIEventListener.Get(UIRechargeLuxuryGiftPanel.btn_recharge.gameObject).onClick = UIRechargeLuxuryGiftPanel.OnClickReChagreBtn
end

function UIRechargeLuxuryGiftPanel.BindNetMessage()
    UIRechargeLuxuryGiftPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneActivitiesInfoMessage, UIRechargeLuxuryGiftPanel.onResOneActivitiesInfoCallBack)

end
--endregion

--region 函数监听
---点击领取（充值）按钮
function UIRechargeLuxuryGiftPanel.OnClickReChagreBtn()
    if UIRechargeLuxuryGiftPanel.mIsRecharge then
        Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.CrossServerRechargeToReward)
    else
        networkRequest.ReqGetOneActivitiesAward(UIRechargeLuxuryGiftPanel.curActivityID)
    end
end

--endregion

--region 网络消息处理

---接收活动信息充值豪礼回调
---@param tblData activitiesV2.ResOneActivitiesInfo
function UIRechargeLuxuryGiftPanel.onResOneActivitiesInfoCallBack(id, tblData)
    if tblData == nil or tblData.type ~= UIRechargeLuxuryGiftPanel.curType then
        return
    end
    UIRechargeLuxuryGiftPanel.RefreshRechargeView()
end

--endregion

--region UI

function UIRechargeLuxuryGiftPanel.InitUI()
    if UIRechargeLuxuryGiftPanel.activityAllData == nil then
        return
    end
    --local showStr = ''
    --if UIRechargeLuxuryGiftPanel.activityAllData.mStartTime ~= nil and UIRechargeLuxuryGiftPanel.activityAllData.mFinishTime ~= nil then
    --    local startTimeStr = CS.Utility_Lua.GetYearMonthDayDescribeByMillisecond(UIRechargeLuxuryGiftPanel.activityAllData.mStartTime * 1000)
    --    local endTimeStr = CS.Utility_Lua.GetYearMonthDayDescribeByMillisecond(UIRechargeLuxuryGiftPanel.activityAllData.mFinishTime * 1000)
    --    showStr = string.format(UIRechargeLuxuryGiftPanel.timeFormat, startTimeStr[1], startTimeStr[2], endTimeStr[1], endTimeStr[2])
    --end
    --UIRechargeLuxuryGiftPanel.time.text = showStr

    if UIRechargeLuxuryGiftPanel.activityAllData ~= nil and UIRechargeLuxuryGiftPanel.activityAllData.mFinishTime ~= nil then
        UIRechargeLuxuryGiftPanel.time:StartCountDown(nil, 8, UIRechargeLuxuryGiftPanel.activityAllData.mFinishTime * 1000,
                '活动倒计时', "", nil, nil)
    end

    UIRechargeLuxuryGiftPanel.RefreshRechargeView()
end

---刷新活动视图
function UIRechargeLuxuryGiftPanel.RefreshRechargeView()

    local info = UIRechargeLuxuryGiftPanel.GetServerSingleActivityInfo()

    if info == nil or info.oneActivitiesInfo == nil or #info.oneActivitiesInfo == 0 then
        return
    end

    table.sort(info.oneActivitiesInfo, UIRechargeLuxuryGiftPanel.SortTbl)

    for i = 1, #info.oneActivitiesInfo do
        if info.oneActivitiesInfo[i].finish ~= 1 then
            ---未领取或未达到领取，显示
            UIRechargeLuxuryGiftPanel.curActivityID = info.oneActivitiesInfo[i].configId
            UIRechargeLuxuryGiftPanel.RefreshMainRechargeView(info.oneActivitiesInfo[i])
            return
        elseif i == #info.oneActivitiesInfo then
            ---所有都领取过，显示最后一个
            UIRechargeLuxuryGiftPanel.curActivityID = info.oneActivitiesInfo[i].configId
            UIRechargeLuxuryGiftPanel.RefreshMainRechargeView(info.oneActivitiesInfo[i])
            return
        end
    end
end

---刷新活动主视图
---@param activityInfo activitiesV2.OneActivitiesInfo
function UIRechargeLuxuryGiftPanel.RefreshMainRechargeView(activityInfo)
    ---@type TABLE.cfg_special_activity
    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityInfo.configId)
    if specialActivityTbl == nil then
        return
    end

    local totalCount = (specialActivityTbl:GetGoal() ~= nil and #specialActivityTbl:GetGoal().list > 0) and specialActivityTbl:GetGoal().list[1] or 0
    local boxId = (specialActivityTbl:GetAward() ~= nil and #specialActivityTbl:GetAward().list > 0) and specialActivityTbl:GetAward().list[1] or 0
    local rechargeShowStr = ''
    if activityInfo.finish ~= 1 then
        rechargeShowStr = activityInfo.dataParam >= totalCount and
                luaEnumColorType.Green .. activityInfo.dataParam .. '/' .. totalCount or
                luaEnumColorType.Red .. activityInfo.dataParam .. '[-]/' .. totalCount
    end

    UIRechargeLuxuryGiftPanel.mIsRecharge = activityInfo.finish == 0

    UIRechargeLuxuryGiftPanel.title.text = specialActivityTbl:GetSmallName() == nil and '' or specialActivityTbl:GetSmallName()

    UIRechargeLuxuryGiftPanel.btn_recharge.spriteName = UIRechargeLuxuryGiftPanel.mIsRecharge and 'anniu2' or 'anniu10'

    UIRechargeLuxuryGiftPanel.btn_Label.text = UIRechargeLuxuryGiftPanel.mIsRecharge and '[ffcda5]立即充值[-]' or '[fff0c2]领取奖励[-]'

    UIRechargeLuxuryGiftPanel.rechargeNum.text = rechargeShowStr

    UIRechargeLuxuryGiftPanel.getedObj:SetActive(activityInfo.finish == 1)

    UIRechargeLuxuryGiftPanel.effect:SetActive(not UIRechargeLuxuryGiftPanel.mIsRecharge)

    UIRechargeLuxuryGiftPanel.btn_recharge.gameObject:SetActive(activityInfo.finish ~= 1)

    UIRechargeLuxuryGiftPanel.RefreshRechargeRewardView(boxId)
end

---刷新奖励视图
function UIRechargeLuxuryGiftPanel.RefreshRechargeRewardView(boxId)

    local rewards = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(boxId)

    UIRechargeLuxuryGiftPanel.reward.MaxCount = rewards.Count
    for i = 0, rewards.Count - 1 do
        local go = UIRechargeLuxuryGiftPanel.reward.controlList[i]
        if go then
            ---@type bagV2.CoinInfo
            local rewardInfo = rewards[i]
            ---@type UIItem
            local template = UIRechargeLuxuryGiftPanel.allTemplateByRewardGoTbl[go]
            if template == nil then
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                UIRechargeLuxuryGiftPanel.allTemplateByRewardGoTbl[go] = template
            end
            local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.itemId)
            if isFind then
                template:RefreshUIWithItemInfo(itemInfo, rewardInfo.count)
                template:RefreshOtherUI({ showItemInfo = itemInfo })
            end
        end
    end
end

--endregion

--region otherFunction

function UIRechargeLuxuryGiftPanel.SortTbl(l, r)
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

return UIRechargeLuxuryGiftPanel