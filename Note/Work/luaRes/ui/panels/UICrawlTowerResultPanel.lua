local UICrawlTowerResultPanel = {}

--region 局部变量
UICrawlTowerResultPanel.IsSucess = false
--endregion

--region 组件
---一星奖励信息分组
---@return Top_UIGridContainer
function UICrawlTowerResultPanel:GetRewardInfo_UIGridContainer()
    if (self.mRewardInfoGrid == nil) then
        self.mRewardInfoGrid = self:GetCurComp("WidgetRoot/view/win/Scroll/GridContainer", "Top_UIGridContainer")
    end
    return self.mRewardInfoGrid
end

---二星奖励信息分组
---@return Top_UIGridContainer
function UICrawlTowerResultPanel:GetRewardInfo2_UIGridContainer()
    if (self.mRewardInfo2Grid == nil) then
        self.mRewardInfo2Grid = self:GetCurComp("WidgetRoot/view/win/Scroll/GridContainer2", "Top_UIGridContainer")
    end
    return self.mRewardInfo2Grid
end

---三星奖励信息分组
---@return Top_UIGridContainer
function UICrawlTowerResultPanel:GetRewardInfo3_UIGridContainer()
    if (self.mRewardInfo3Grid == nil) then
        self.mRewardInfo3Grid = self:GetCurComp("WidgetRoot/view/win/Scroll/GridContainer3", "Top_UIGridContainer")
    end
    return self.mRewardInfo3Grid
end

function UICrawlTowerResultPanel:GetRewardGrid_UIGridContainer()
    if (self.mRewardGrid == nil) then
        self.mRewardGrid = self:GetCurComp("WidgetRoot/view/win/Scroll/rewardList", "Top_UIGridContainer")
    end
    return self.mRewardGrid
end

function UICrawlTowerResultPanel:GetStarGrid_UIGridContainer()
    if (self.mStarGrid == nil) then
        self.mStarGrid = self:GetCurComp("WidgetRoot/view/win/Star/StarGrid", "Top_UIGridContainer")
    end
    return self.mStarGrid
end

function UICrawlTowerResultPanel:GetTitle_UISprite()
    if (self.mTitleSprite == nil) then
        self.mTitleSprite = self:GetCurComp("WidgetRoot/view/win/title", "Top_UISprite")
    end
    return self.mTitleSprite
end

function UICrawlTowerResultPanel:GetExitBtn_GameObject()
    if (self.mExitBtn == nil) then
        self.mExitBtn = self:GetCurComp("WidgetRoot/event/btn_exit", "GameObject")
    end
    return self.mExitBtn
end

function UICrawlTowerResultPanel:GetNextBtn_GameObject()
    if (self.mNextBtn == nil) then
        self.mNextBtn = self:GetCurComp("WidgetRoot/event/btn_next", "GameObject")
    end
    return self.mNextBtn
end

function UICrawlTowerResultPanel:GetPlayerTowerInfo()
    return gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo()
end

function UICrawlTowerResultPanel:GetPlayerTowerData()
    return self:GetPlayerTowerInfo():GetPlayerTowerData()
end
function UICrawlTowerResultPanel:GetLabel_UICountDownLabel()
    if (self.mCountDownLabel == nil) then
        self.mCountDownLabel = self:GetCurComp("WidgetRoot/view/Label", "UICountdownLabel")
    end
    return self.mCountDownLabel
end

function UICrawlTowerResultPanel:GetWin_GameObject()
    if (self.mWinGo == nil) then
        self.mWinGo = self:GetCurComp("WidgetRoot/view/win", "GameObject")
    end
    return self.mWinGo
end

function UICrawlTowerResultPanel:GetLose_GameObject()
    if (self.mLoseGo == nil) then
        self.mLoseGo = self:GetCurComp("WidgetRoot/view/lose", "GameObject")
    end
    return self.mLoseGo
end
--endregion

--region 初始化
function UICrawlTowerResultPanel:Init()
    self:BindUIEvent()
    self:BindMessage()
end

function UICrawlTowerResultPanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetExitBtn_GameObject()).onClick = function()
        self:ExitBtnOnClick()
    end

    CS.UIEventListener.Get(self:GetNextBtn_GameObject()).onClick = function()
        self:NextBtnOnClick()
    end
end

function UICrawlTowerResultPanel:BindMessage()

end

function UICrawlTowerResultPanel:Show(data, dupdata)
    local res, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(CS.CSScene.MainPlayerInfo.MapID)
    if (res) then
        if (mapInfo.announceDeliver ~= 1072) then
            if (uimanager:GetPanel("UICrawlTowerResultPanel")) then
                uimanager:ClosePanel("UICrawlTowerResultPanel")
            end
        end
    end
    UICrawlTowerResultPanel.IsSucess = data.sucess
    self:RefreshUIPanel(data)

    local time = CS.CSServerTime.DateTimeToStampForMilli(CS.CSServerTime.Now:AddSeconds(dupdata.finishCount))
    self:GetLabel_UICountDownLabel():StartCountDown(nil, 1, time, "将在[00ff00]", "[-]后自动退出", nil, function()
        networkRequest.ReqExitDuplicate(0)
        --if (UICrawlTowerResultPanel.IsSucess == false) then
        --    uimanager:CreatePanel("UIStrongerPanel")
        --end
        uimanager:ClosePanel("UIPromptCrawlTowerPanel")
        uimanager:ClosePanel("UICrawlTowerResultPanel")
    end)
end
--endregion

--region 客户端事件
function UICrawlTowerResultPanel:ExitBtnOnClick()
    --if (UICrawlTowerResultPanel.IsSucess == false) then
    --    uimanager:CreatePanel("UIStrongerPanel")
    --end
    networkRequest.ReqExitDuplicate(0)
    uimanager:ClosePanel("UICrawlTowerRewardPanel")
    uimanager:ClosePanel("UICrawlTowerResultPanel")
end

function UICrawlTowerResultPanel:NextBtnOnClick()
    local towerdata = self:GetPlayerTowerData()
    local data = clientTableManager.cfg_towerManager:TryGetValue(towerdata.level + 1)
    if (data ~= nil) then
        local mainmenus = uimanager:GetPanel("UIMainMenusPanel")
        if (mainmenus ~= nil) then
            mainmenus.LeftCenterPanelName = ""
        end
        uimanager:ClosePanel("UICrawlTowerRewardPanel")
        uimanager:CreatePanel("UIPromptCrawlTowerPanel", nil, false)
        --uimanager:ClosePanel("UICrawlTowerLeftMainPanel")
        --uimanager:ClosePanel("UICrawlTowerResultPanel")
    end
end


--endregion

--region 刷新面板
function UICrawlTowerResultPanel:RefreshUIPanel(data)
    if (UICrawlTowerResultPanel.IsSucess) then
        self:GetWin_GameObject():SetActive(true)
        self:GetLose_GameObject():SetActive(false)
        self:GetTitle_UISprite().spriteName = "tower_win"
        self:GetTitle_UISprite():MakePixelPerfect()
        self:RefreshReward()
        self:RefreshNextBtn()
    else
        if (uimanager:GetPanel("UIDeadPanel") ~= nil) then
            uimanager:ClosePanel("UIDeadPanel")
        end
        self:GetWin_GameObject():SetActive(false)
        self:GetLose_GameObject():SetActive(true)

        self:GetRewardInfo_UIGridContainer().MaxCount = 0
        self:GetRewardInfo2_UIGridContainer().MaxCount = 0
        self:GetRewardInfo3_UIGridContainer().MaxCount = 0

        self:GetTitle_UISprite().spriteName = "tower_lose"
        self:GetTitle_UISprite():MakePixelPerfect()
    end
end

function UICrawlTowerResultPanel:RefreshNextBtn(star)
    local towerdata = self:GetPlayerTowerData()
    local data = clientTableManager.cfg_towerManager:TryGetValue(towerdata.level + 1)
    if (data ~= nil) then
        if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(data.totalLv.list)) then
            self:GetNextBtn_GameObject():SetActive(true)
            self:GetExitBtn_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-90, -93, 0)
        else
            self:GetNextBtn_GameObject():SetActive(false)
        end
    end
end

---
function UICrawlTowerResultPanel:GetRefreshRewardList()
    local list = {}
    for i, v in pairs(gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetCurrentReward()) do

        local mitemID = v.itemId
        local mitemCount = v.count

        local isFind, mItemTabel = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(mitemID))
        local RewardData = {
            ---道具ID
            itemID = mitemID,
            ---道具数量
            itemCount = mitemCount,
            ---@type CS.TABLE.cfg_items 道具Table
            ItemTabel = mItemTabel,
        }
        table.insert(list, RewardData)
    end
    --local mItemTable = gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData().awardList[gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData().level]
    --local mitemId = mItemTable.key
    --local isFind, mItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(mitemId))
    --local SpecialRewardData = {
    --    ---道具ID
    --    itemID = mitemId,
    --    ---道具数量
    --    itemCount = mItemTable.value,
    --    ---@type CS.TABLE.cfg_items 道具Table
    --    ItemTabel = mItemInfo,
    --}
    table.insert(list, SpecialRewardData)
    return list
end

---刷新奖励组
function UICrawlTowerResultPanel:RefreshReward()
    self.RefreshRewardList = self:GetRefreshRewardList()
    self:GetRewardInfo_UIGridContainer().MaxCount = #self.RefreshRewardList

    local flycount = 0
    local mainchatpanel = uimanager:GetPanel("UIMainChatPanel")
    ---一星奖励组
    for i = 0, self:GetRewardInfo_UIGridContainer().MaxCount - 1 do
        local go = self:GetRewardInfo_UIGridContainer().controlList[i]
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        local info = self.RefreshRewardList[i + 1]

        icon.spriteName = info.ItemTabel.icon
        self:RefreshRewardItem(go, info.itemID, info.itemCount)
        if (mainchatpanel ~= nil) then
            local toPosition = mainchatpanel.bagPos.position;
            if (flycount ~= 0) then
                luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = info.itemID, from = go.transform.position, to = toPosition });
            end
        end
    end
end

---刷新单个奖励格子
---@param go UnityEngine.GameObject 奖励格子
---@param itemId number 奖励id
---@param rewardNum number 奖励数目
function UICrawlTowerResultPanel:RefreshRewardItem(go, itemId, rewardNum)
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    ---@type CSUIEffectLoad
    local mEffectLoad = CS.Utility_Lua.Get(go.transform, "frame", "CSUIEffectLoad")
    local effectId = gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetItemEffectId(itemId)
    if effectId then
        mEffectLoad.effectId = effectId
    end
    mEffectLoad.gameObject:SetActive(effectId)
    local itemInfo = self:GetItemInfoCache(itemId)
    if itemInfo then
        icon.spriteName = itemInfo.icon
        CS.UIEventListener.Get(go).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
        end
    end
    if rewardNum >= 100000 then
        count.text = string.format("%.0f", tostring(rewardNum / 10000)) .. "万"
    else
        if rewardNum >= 2 then
            count.text = tostring(rewardNum)
        end
    end
end

---@return TABLE.CFG_ITEMS 获取道具缓存信息
function UICrawlTowerResultPanel:GetItemInfoCache(itemId)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[itemId]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = info
    end
    return info
end
--endregion

function ondestroy()

end

return UICrawlTowerResultPanel