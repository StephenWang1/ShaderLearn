---@class UIConsumeRankPanel : UIBase 联服消费排行活动
local UIConsumeRankPanel = {}

---获得服务器发送活动信息
---@return activitiesV2.ResOneActivitiesInfo
function UIConsumeRankPanel.GetServerSingleActivityInfo()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(UIConsumeRankPanel.curType)
    end
    return nil
end

--region 初始化

function UIConsumeRankPanel:Init()
    self:InitComponents()
    UIConsumeRankPanel.InitParameters()
    UIConsumeRankPanel.BindNetMessage()
end

---@param activityData SpecialActivityPanelData
function UIConsumeRankPanel:Show(activityData)
    if activityData == nil then
        return
    end
    UIConsumeRankPanel.activityAllData = activityData
    UIConsumeRankPanel.curType = activityData.mEventID
    UIConsumeRankPanel.InitUI()
end

--- 初始化变量
function UIConsumeRankPanel.InitParameters()
    UIConsumeRankPanel.IsInitialized = false
    ---@type number cfg_special_activityManager表eventID 活动类型
    UIConsumeRankPanel.curType = 0
    ---@type table<number,activitiesV2.ConsumRankInfo>
    UIConsumeRankPanel.curRankList = {}
    ---@type table<UnityEngine.GameObject,UIConsumeRankPanel_UnitTemplate>
    UIConsumeRankPanel.rankUnitAndTemplateDic = {}
    ---@type activitiesV2.ServerConsumRankInfo
    UIConsumeRankPanel.curRankInfo = nil
end

--- 初始化组件
function UIConsumeRankPanel:InitComponents()
    ---@type UILabel 活动时间
    UIConsumeRankPanel.time = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    ---@type Top_UILabel 我的排名
    UIConsumeRankPanel.MyRank = self:GetCurComp('WidgetRoot/view/MyRank/rank', 'Top_UILabel')
    ---@type Top_UILabel 我的消费
    UIConsumeRankPanel.MyConsume = self:GetCurComp('WidgetRoot/view/MyConsume/value', 'Top_UILabel')
    ---@type Top_UILabel 提示
    UIConsumeRankPanel.des = self:GetCurComp('WidgetRoot/view/desc/Label', 'Top_UILabel')
    ---@type Top_UIGridContainer 排行榜列表
    UIConsumeRankPanel.rankGrid = self:GetCurComp('WidgetRoot/view/Scroll View/firstRankGrid', 'Top_UIGridContainer')
end

function UIConsumeRankPanel.BindNetMessage()
    UIConsumeRankPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneActivitiesInfoMessage, UIConsumeRankPanel.onResOneActivitiesInfoCallBack)
end
--endregion

--region 函数监听

--endregion


--region 网络消息处理

---接收活动信息消费排行回调
---@param tblData activitiesV2.ResOneActivitiesInfo
function UIConsumeRankPanel.onResOneActivitiesInfoCallBack(id, tblData)
    if tblData == nil or tblData.type ~= UIConsumeRankPanel.curType then
        return
    end
    UIConsumeRankPanel.RefreshRankView()
end

--endregion

--region View

function UIConsumeRankPanel.InitUI()
    if UIConsumeRankPanel.activityAllData == nil then
        return
    end

    if UIConsumeRankPanel.activityAllData ~= nil and UIConsumeRankPanel.activityAllData.mFinishTime ~= nil then
        UIConsumeRankPanel.time:StartCountDown(nil, 8, UIConsumeRankPanel.activityAllData.mFinishTime * 1000,
                '活动倒计时', "", nil, nil)
    end
    UIConsumeRankPanel.RefreshRankView()

    local mActivityID = 4009004
    if (UIConsumeRankPanel.activityAllData ~= nil and UIConsumeRankPanel.activityAllData.mActivityID ~= nil) then
        mActivityID = UIConsumeRankPanel.activityAllData.mActivityID
    end

    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(mActivityID)
    if specialActivityTbl ~= nil then
        UIConsumeRankPanel.des.text = specialActivityTbl:GetSmallName()
    end
end

---刷新排行视图
function UIConsumeRankPanel.RefreshRankView()
    UIConsumeRankPanel.RefreshRankData()
    if UIConsumeRankPanel.curRankInfo == nil then
        return
    end
    UIConsumeRankPanel.RefreshMyRankView()
    UIConsumeRankPanel.RefreshRankGridView()
end

---刷新主角排行视图
function UIConsumeRankPanel.RefreshMyRankView()
    local myRank = UIConsumeRankPanel.curRankInfo.myRank
    UIConsumeRankPanel.MyRank.text = myRank == 0 and luaEnumColorType.Gray .. '未上榜' or tostring(myRank)
    UIConsumeRankPanel.MyConsume.text = tostring(UIConsumeRankPanel.curRankInfo.myCousumCount)
end

---刷新排行列表视图
function UIConsumeRankPanel.RefreshRankGridView()
    local count = #UIConsumeRankPanel.curRankList > 3 and 3 or #UIConsumeRankPanel.curRankList
    UIConsumeRankPanel.rankGrid.MaxCount = count
    for i = 1, count do
        local go = UIConsumeRankPanel.rankGrid.controlList[i - 1]
        if go then
            ---@type UIConsumeRankPanel_UnitTemplate
            local temp = UIConsumeRankPanel.rankUnitAndTemplateDic[go]
            if temp == nil then
                temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIConsumeRankPanel_UnitTemplate)
                UIConsumeRankPanel.rankUnitAndTemplateDic[go] = temp
            end
            temp:SetTemplate({
                rankData = UIConsumeRankPanel.curRankList[i]
            })
        end
    end
end

--endregion

--region otherFunction

function UIConsumeRankPanel.RefreshRankData()
    local info = UIConsumeRankPanel.GetServerSingleActivityInfo()
    if info == nil or info.consumRanks == nil then
        UIConsumeRankPanel.curRankInfo = nil
        UIConsumeRankPanel.curRankList = {}
        return
    end
    UIConsumeRankPanel.curRankInfo = info.consumRanks
    --[[    UIConsumeRankPanel.curRankInfo = {
            myRank = 1,
            myCousumCount = 10,
            infos = {
                { rid = 1, count = 100, rank = 1, shId = 1, roleName = "ABC", configId = 2009001 },
                { rid = 2, count = 100, rank = 2, shId = 2, roleName = "CBD", configId = 2009002 },
                { rid = 3, count = 100, rank = 3, shId = 1, roleName = "QAQ", configId = 2009003 }
            }
        }]]

    UIConsumeRankPanel.curRankList = UIConsumeRankPanel.curRankInfo.infos
    table.sort(UIConsumeRankPanel.curRankList, function(l, r)
        return l.rank < r.rank
    end)


end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIConsumeRankPanel
