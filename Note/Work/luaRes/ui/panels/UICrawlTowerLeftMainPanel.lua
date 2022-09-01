local UICrawlTowerLeftMainPanel = {}

--region 局部变量
function UICrawlTowerLeftMainPanel:GetHideBtn_GameObject()
    if (self.mHideBtn == nil) then
        self.mHideBtn = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject")
    end
    return self.mHideBtn
end

function UICrawlTowerLeftMainPanel:GetExitBtn_GameObject()
    if (self.mExitBtn == nil) then
        self.mExitBtn = self:GetCurComp("WidgetRoot/Tween/events/btn_exit", "GameObject")
    end
    return self.mExitBtn
end

function UICrawlTowerLeftMainPanel:GetRightBtn_GameObject()
    if (self.mRightBtn == nil) then
        self.mRightBtn = self:GetCurComp("WidgetRoot/Tween/events/btn_right", "GameObject")
    end
    return self.mRightBtn
end

function UICrawlTowerLeftMainPanel:GetHelpBtn_GameObject()
    if (self.mHelpBtn == nil) then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/Tween/events/helpBtn", "GameObject")
    end
    return self.mHelpBtn
end

function UICrawlTowerLeftMainPanel:GetTitle_UILabel()
    if (self.mTitle == nil) then
        self.mTitle = self:GetCurComp("WidgetRoot/Tween/view/lb_name", "Top_UILabel")
    end
    return self.mTitle
end

function UICrawlTowerLeftMainPanel:GetTime_UICountDownLabel()
    if (self.mTime == nil) then
        self.mTime = self:GetCurComp("WidgetRoot/Tween/view/Time", "UICountdownLabel")
    end
    return self.mTime
end

function UICrawlTowerLeftMainPanel:GetStarGrid_UIGridContainer()
    if (self.mStarGrid == nil) then
        self.mStarGrid = self:GetCurComp("WidgetRoot/Tween/view/StarGrid", "Top_UIGridContainer")
    end
    return self.mStarGrid
end

function UICrawlTowerLeftMainPanel:GetDropItem_UIGridContainer()
    if (self.mDropItem_UIGridContainer == nil) then
        self.mDropItem_UIGridContainer = self:GetCurComp("WidgetRoot/Tween/view/DropItem", "Top_UIGridContainer")
    end
    return self.mDropItem_UIGridContainer
end

function UICrawlTowerLeftMainPanel:GetPlayerTowerData()
    return gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData()
end

function UICrawlTowerLeftMainPanel:GetTowerTblData()
    if (self:GetPlayerTowerData() ~= nil) then
        local level = self:GetPlayerTowerData().level > 0 and self:GetPlayerTowerData().level or 1
        local data = clientTableManager.cfg_towerManager:TryGetValue(level)
        if (data ~= nil) then
            return data
        end
    end

end
--endregion

--region 组件

--endregion

--region 初始化
function UICrawlTowerLeftMainPanel:Init()
    self:InitData()
    self:InitComponents()
    self:BindUIEvent()
    self:BindMessage()
    self:RefreshItemGird()
end

function UICrawlTowerLeftMainPanel:InitData()
    self.mGoToTemplate = {}
    self.IsOpen = true
    local data = clientTableManager.cfg_towerManager:TryGetValue(self:GetPlayerTowerData().level + 1)
    self.tableData = data
    if (data ~= nil) then
        local isfind, dupinfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(data:GetDuplicateId())
        self.dupinfo = dupinfo
        if (isfind) then
            local time = CS.CSServerTime.DateTimeToStampForMilli(CS.CSServerTime.Now:AddSeconds(dupinfo.totalTime))
            self:GetTime_UICountDownLabel():StartCountDown(nil, 7, time, nil, nil, nil, nil)
        end
    end

end

function UICrawlTowerLeftMainPanel:InitComponents()
    self.arrow_TweenRotation = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "TweenRotation")
    self.panelTween_TweenPosition = self:GetCurComp("WidgetRoot/Tween", "TweenPosition")
end

function UICrawlTowerLeftMainPanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).onClick = function()
        self:HelpBtnOnClick()
    end
    CS.UIEventListener.Get(self:GetExitBtn_GameObject()).onClick = function()
        self:ExitBtnOnClick()
    end

    CS.UIEventListener.Get(self:GetRightBtn_GameObject()).onClick = function()
        self:RightBtnOnClick()
    end

    CS.UIEventListener.Get(self:GetHideBtn_GameObject()).onClick = function()
        self:HideBtnOnClick()
    end
end

function UICrawlTowerLeftMainPanel:BindMessage()
    self.ResRoleTowerInfo = function(msgid, tblData)
        self:GetTime_UICountDownLabel():StopCountDown()
        uimanager:CreatePanel("UICrawlTowerResultPanel", nil, tblData, self.dupinfo)
    end

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateEndMessage, self.ResRoleTowerInfo)
end

function UICrawlTowerLeftMainPanel:Show()
    self:RefreshUIPanel()
end

--endregion

--region 客户端事件
function UICrawlTowerLeftMainPanel:HelpBtnOnClick()
    Utility.ShowHelpPanel({ id = 176 })
end

function UICrawlTowerLeftMainPanel:ExitBtnOnClick()
    ---接收打断传送提示消息
    --二次弹框确认
    local isFind, showInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(63)
    if isFind then
        local data = {
            Title = showInfo.title == nil and '' or showInfo.title,
            Content = showInfo.des,
            CenterDescription = showInfo.leftButton,
            ID = 134,
            CallBack = function()
                networkRequest.ReqExitDuplicate(0)
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, data)
    end
end

function UICrawlTowerLeftMainPanel:RightBtnOnClick()
    ---接收打断传送提示消息
    uimanager:CreatePanel("UICrawlTowerRewardPanel")
end

function UICrawlTowerLeftMainPanel:HideBtnOnClick()
    if self.panelTween_TweenPosition == nil then
        return
    end
    if self.IsOpen then
        self.panelTween_TweenPosition:PlayForward()
        self.arrow_TweenRotation:PlayReverse()
    else
        self.panelTween_TweenPosition:PlayReverse()
        self.arrow_TweenRotation:PlayForward()
    end
    self.IsOpen = not self.IsOpen
end
--endregion

--region 服务器事件

--endregion

--region 界面刷新
function UICrawlTowerLeftMainPanel:RefreshUIPanel()
    self:GetTitle_UILabel().text = "闯天关" .. tostring(self:GetPlayerTowerData().level + 1) .. "层"
end
--endregion

---刷新道具展示信息
function UICrawlTowerLeftMainPanel:RefreshItemGird()
    if self.tableData == nil or self.tableData:GetNormalReward() == nil then
        self:GetDropItem_UIGridContainer().MaxCount = 0
        return
    end
    ---@type table<number,UICrawlTowerLeftMainPanel_RewardData>
    local nowDataList = self:GetItemGirdInfoList()
    self:GetDropItem_UIGridContainer().MaxCount = #nowDataList
    for i = 1, #nowDataList do
        local nowData = nowDataList[i]
        local go = self:GetDropItem_UIGridContainer().controlList[i - 1]
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
        if icon ~= nil and nowData.ItemTabel ~= nil then
            icon.spriteName = nowData.ItemTabel.icon
            CS.UIEventListener.Get(icon.gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = nowData.ItemTabel })
            end
        end
        if count ~= nil then
            if tonumber(nowData.itemCount) == 1 then
                count.text = ""
            else
                count.text = Utility.GetNumStr(nowData.itemCount)
            end
        end
    end
end

---得到奖励道具信息列表
---@return table<number,UICrawlTowerLeftMainPanel_RewardData>
function UICrawlTowerLeftMainPanel:GetItemGirdInfoList()
    local rewardList = {}
    local temp = self.tableData
    if temp ~= nil and temp:GetNormalReward() ~= nil then
        for i, v in pairs(temp:GetNormalReward().list) do
            local mitemID = v.list[1]
            local mitemCount = v.list[2]
            local isFind, mItemTabel = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(mitemID))
            ---@class UICrawlTowerLeftMainPanel_RewardData
            local RewardData = {
                ---道具ID
                itemID = mitemID,
                ---道具数量
                itemCount = mitemCount,
                ---@type CS.TABLE.cfg_items 道具Table
                ItemTabel = mItemTabel,
            }
            table.insert(rewardList, RewardData)
        end
    end
    local mItemTable = gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData().awardList[gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData().level + 1]
    local mitemId = mItemTable.key
    local isFind, mItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(mitemId))
    local SpecialRewardData = {
        ---道具ID
        itemID = mitemId,
        ---道具数量
        itemCount = mItemTable.value,
        ---@type CS.TABLE.cfg_items 道具Table
        ItemTabel = mItemInfo,
    }
    table.insert(rewardList, SpecialRewardData)
    return rewardList
end

return UICrawlTowerLeftMainPanel