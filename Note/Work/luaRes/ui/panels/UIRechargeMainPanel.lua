---领奖主界面(由原领奖界面和竞技界面合并而来)
---@class UIRechargeMainPanel:UIBase
local UIRechargeMainPanel = {}

--region 组件
---关闭按钮
---@return UnityEngine.GameObject
function UIRechargeMainPanel:GetCloseButtonGo()
    if self.mCloseButtonGo == nil then
        self.mCloseButtonGo = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseButtonGo
end

---页签toggle的gridcontainer
---@return UIGridContainer
function UIRechargeMainPanel:GetBookMarkToggleGridContainer()
    if self.mBookMarkToggleGridContainer == nil then
        self.mBookMarkToggleGridContainer = self:GetCurComp("WidgetRoot/events/toggles", "UIGridContainer")
    end
    return self.mBookMarkToggleGridContainer
end
--endregion

--region 属性
---获取当前页签
---@return LuaEnumRechargeMainBookMarkType
function UIRechargeMainPanel:GetCurrentBookMark()
    return self.mCurrentBookMark
end

---获取当前子界面
---@return UIBase
function UIRechargeMainPanel:GetCurrentSubPanel()
    return self.mCurrentSubPanel
end

---@return table<string, UIBase>
function UIRechargeMainPanel:GetOpenedPanelDic()
    if self.mOpenedPanelDic == nil then
        self.mOpenedPanelDic = {}
    end
    return self.mOpenedPanelDic
end

---@return table<number, string>
function UIRechargeMainPanel:GetOpeningPanelList()
    if self.mOpeningPanelList == nil then
        self.mOpeningPanelList = {}
    end
    return self.mOpeningPanelList
end

---@return table<LuaEnumRechargeMainBookMarkType, {rootGo:UnityEngine.GameObject,checkmarkGo:UnityEngine.GameObject}>
function UIRechargeMainPanel:GetBookMarkTypeToBookMarkGo()
    if self.mBookMarkTypeToBookMarkGoMap == nil then
        self.mBookMarkTypeToBookMarkGoMap = {}
    end
    return self.mBookMarkTypeToBookMarkGoMap
end

---@return CSMainPlayerInfo
function UIRechargeMainPanel:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end
--endregion

--region 初始化
---@private
function UIRechargeMainPanel:Init()
    self:BindUIEvents()
    self:RegisterUIPanels()
    self:RefreshBookMarkUI()
end

---@private
function UIRechargeMainPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGo()).onClick = function()
        self:ClosePanel()
    end
end

---@private
function UIRechargeMainPanel:RegisterUIPanels()
    if self.mUIPanelMap == nil then
        ---@class UIRechargeMainBookMarkData
        ---@field sortorder number 排序顺序
        ---@field togglename string UI上的toggle名
        ---@field panelname string 界面名
        ---@field panelparam any 界面参数
        ---@field redpoints table<number, number> 红点列表
        ---@field isShow fun():boolean 是否显示页签
        ---@field switchAvailable fun():boolean,string|nil 页签是否可切换回调
        ---
        ---@field isRedPointOn fun():boolean 页签的红点是否可用(不需要在table中定义,自动加上的方法)
        ---
        ---@type table<LuaEnumRechargeMainBookMarkType, UIRechargeMainBookMarkData>
        self.mUIPanelMap = {}
    end
    self.mUIPanelMap[LuaEnumRechargeMainBookMarkType.Activity] = {
        sortorder = 1,
        togglename = "活动",
        panelname = "UICompetitionPanel",
        panelparam = nil,
        redpoints = {
            CS.RedPointKey.Activity_Competition_FirstKill,
            CS.RedPointKey.Activity_Competition_FirstDrop,
            CS.RedPointKey.Activity_Competition_Recycle,
            CS.RedPointKey.Activity_Competition_ServerOpen,
            gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint),
        },
        isShow = function()
            return CS.CSSystemController.Sington:CheckSystem(30) --竞技
                    or
                    gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():IsShowPotentialInvest() --潜能投资
                    or self:IsShowGiftPage()
        end,
        switchAvailable = function()
            return true
        end,
    }
    self.mUIPanelMap[LuaEnumRechargeMainBookMarkType.Award] = {
        sortorder = 2,
        togglename = "领奖",
        panelname = "UIRechargePanel",
        panelparam = { type = LuaEnumRechargeType.Reward },
        redpoints = {
            CS.RedPointKey.Recharge_Reward,
            gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.AccumulatedRecharge),
        },
        isShow = function()
            local isOpen = true
            local noticeId = clientTableManager.cfg_noticeManager:TryGetValue(87)
            if noticeId then
                isOpen = Utility.IsNoticeOpenSystem(noticeId)
                if isOpen == false then
                    return false
                end
            end
            return CS.CSSystemController.Sington:CheckSystem(87)
        end,
        switchAvailable = function()
            return true
        end,
    }
    self.mUIPanelMap[LuaEnumRechargeMainBookMarkType.Recharge] = {
        sortorder = 3,
        togglename = "充值",
        panelname = "UIRechargePanel",
        panelparam = { type = LuaEnumRechargeType.NormalRecharge },
        redpoints = { },
        isShow = function()
            return true
        end,
        switchAvailable = function()
            return true
        end,
    }
    self.mUIPanelMap[LuaEnumRechargeMainBookMarkType.LianChong] = {
        sortorder = 5,
        togglename = "连充",
        panelname = "UIRechargePanel",
        panelparam = { type = LuaEnumRechargeType.ContinueRecharge },
        redpoints = {
            CS.RedPointKey.Recharge_ContinueReward,
            gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianChongRedPoint),
        },
        isShow = function()
            local isOpen = false
            local noticeId = clientTableManager.cfg_noticeManager:TryGetValue(88)
            if noticeId then
                isOpen = Utility.IsNoticeOpenSystem(noticeId)
            end
            return isOpen
        end,
        switchAvailable = function()
            return true
        end,
    }
    self.mUIPanelMap[LuaEnumRechargeMainBookMarkType.LastRecharge] = {
        sortorder = 4,
        togglename = "终身限购",
        panelname = "UIRechargePanel",
        panelparam = { type = LuaEnumRechargeType.LastRecharge },
        redpoints = {
            CS.RedPointKey.Recharge_LastRecharge,
        },
        isShow = function()
            if LuaGlobalTableDeal:GetLastRechargeOpenConditionState() == false then
                return
            end
            ---@type rechargegiftboxV2.RechargeGiftBoxInfo
            local csData = CS.CSScene.MainPlayerInfo.RechargeInfo.CurrentRechargeGiftBoxInfo
            if csData == nil then
                return false
            end
            local buyRewardList = csData.buyTimes
            local buyInfo, temp = CS.CSRechargeInfoV2.GetBuyRewardInfo_LastRecharge(buyRewardList)
            for i = 0, buyInfo.Count - 1 do
                local id = buyInfo[i]
                ---@type TABLE.CFG_RECHARGE
                --local tableInfo = self:GetBuyTableData(id)
                --if tableInfo and tableInfo.isTimeLimit == 2 then
                --    --终生限购礼包
                --    return true
                --end
                local isExist, tableInfo = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(id)
                if tableInfo and tableInfo.isTimeLimit == 2 then
                    return true
                end
            end
            return false
        end,
        switchAvailable = function()
            return true
        end,
    }
end

---noticeId对应的notice表条件是否满足
---@param noticeId number
---@return boolean
function UIRechargeMainPanel:IsNoticeConditionReachable(noticeId)
    local noticeTbl = clientTableManager.cfg_noticeManager:TryGetValue(noticeId)
    if noticeTbl == nil then
        return false
    end
    local openConditionList = noticeTbl:GetOpenCondition()
    if openConditionList == nil or openConditionList.list == nil then
        return true
    end
    for i = 0, openConditionList.list.Count - 1 do
        if openConditionList.list[i] ~= 0 and not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(openConditionList.list[i]) then
            return false
        end
    end
    return true
end

---刷新页签UI
---@private
function UIRechargeMainPanel:RefreshBookMarkUI()
    if self.mUIPanelMap == nil or Utility.GetTableCount(self.mUIPanelMap) == 0 then
        self:GetBookMarkToggleGridContainer().MaxCount = 0
        return
    end
    ---@type table<number, UIRechargeMainBookMarkData>
    local list = {}
    local receivingFirstReward = gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFinishReceivingTheFirstRechargeReward()
    for i, v in pairs(self.mUIPanelMap) do
        ---开服前7天98元首充未领取完时 隐藏充值、终身限购入口
        if (not (v.panelparam ~= nil and
                (v.panelparam.type == LuaEnumRechargeType.NormalRecharge or v.panelparam.type == LuaEnumRechargeType.LastRecharge) and
                not receivingFirstReward)) then
            table.insert(list, { key = i, value = v })
        end
    end
    table.sort(list, function(left, right)
        return left.key < right.key
    end)
    local amountOfBookMark = 0
    local openedList = {}
    for i = 1, #list do
        if list[i].value.isShow ~= nil and list[i].value.isShow() then
            amountOfBookMark = amountOfBookMark + 1
            table.insert(openedList, list[i])
        end
    end
    self:GetBookMarkToggleGridContainer().MaxCount = amountOfBookMark
    for i = 1, amountOfBookMark do
        if openedList[i].value.isShow ~= nil and openedList[i].value.isShow() then
            ---@type LuaEnumRechargeMainBookMarkType
            local bookmarkType = openedList[i].key
            ---@type UIRechargeMainBookMarkData
            local bookmarkData = openedList[i].value
            ---@type UnityEngine.GameObject
            local go = self:GetBookMarkToggleGridContainer().controlList[i - 1]
            ---@type UILabel
            local label1 = self:GetComp(go.transform, "Background/Label", "UILabel")
            ---@type UILabel
            local label2 = self:GetComp(go.transform, "Checkmark/Label", "UILabel")
            label1.text = bookmarkData.togglename
            label2.text = bookmarkData.togglename
            ---@type UnityEngine.GameObject
            local checkmarkGo = self:GetComp(go.transform, "Checkmark", "GameObject")
            checkmarkGo:SetActive(false)
            self:GetBookMarkTypeToBookMarkGo()[bookmarkType] = { rootGo = go, checkmarkGo = checkmarkGo }
            CS.UIEventListener.Get(go).onClick = function()

                local isSwitchAvailable, failReason = bookmarkData.switchAvailable()
                if isSwitchAvailable then
                    self:SwitchToBookMark(bookmarkType)
                elseif failReason ~= nil then
                    Utility.ShowPopoTips(go, failReason, 290, "UIRechargeMainPanel")
                end
            end
            ---@type UIRedPoint
            local redpoint = self:GetComp(go.transform, "redPoint", "UIRedPoint")
            if CS.StaticUtility.IsNull(redpoint) == false and bookmarkData.redpoints ~= nil and #bookmarkData.redpoints > 0 then
                for j = 1, #bookmarkData.redpoints do
                    redpoint:AddRedPointKey(bookmarkData.redpoints[j])
                end
                bookmarkData.isRedPointOn = function()
                    local redpointMgr = CS.CSUIRedPointManager.GetInstance()
                    for j = 1, #bookmarkData.redpoints do
                        if redpointMgr:GetRedPointValue(bookmarkData.redpoints[j]) then
                            return true
                        end
                    end
                    return false
                end
            else
                bookmarkData.isRedPointOn = function()
                    return false
                end
            end
        end
    end
end

---@private
---@param bookmark LuaEnumRechargeMainBookMarkType
---@param customData any
function UIRechargeMainPanel:Show(bookmark, customData)
    ---@type LuaEnumRechargeMainBookMarkType
    local bookmarktype = bookmark
    if type(bookmarktype) == "table" then
        bookmarktype = bookmarktype.type
        if (bookmark.PanelLayerType ~= nil) then
            self.mPanelLayerType = bookmark.PanelLayerType;
        end
        if customData == nil then
            customData = bookmark.customData
        end
    end
    if bookmarktype == nil then
        if self.mCurrentBookMark == nil then
            bookmarktype = self:GetDefaultBookMarkID()
        else
            bookmarktype = self.mCurrentBookMark
        end
    end
    self:SwitchToBookMark(bookmarktype, customData)
end

---获取默认页签ID
---@private
---@return LuaEnumRechargeMainBookMarkType
function UIRechargeMainPanel:GetDefaultBookMarkID()
    ---优先取有红点的可访问页签,次取从左到右第一个页签,最后取默认活动
    local sortIndex = 99999999
    local isRedPointExist = false
    local bookmarkType
    for i, v in pairs(self.mUIPanelMap) do
        if v.isShow ~= nil and v.isShow() and v.switchAvailable() then
            local isReplace = false
            local localRedPointState = v.isRedPointOn ~= nil and v.isRedPointOn()
            if localRedPointState then
                if isRedPointExist then
                    isReplace = v.sortorder < sortIndex
                else
                    isReplace = true
                end
            else
                if isRedPointExist then
                    isReplace = false
                else
                    isReplace = v.sortorder < sortIndex
                end
            end
            if isReplace then
                isRedPointExist = localRedPointState
                sortIndex = v.sortorder
                bookmarkType = i
            end
        end
    end
    if bookmarkType ~= nil then
        return bookmarkType
    else
        return LuaEnumRechargeMainBookMarkType.Activity
    end
end
--endregion

--region 刷新UI
---切换页签
---@public
function UIRechargeMainPanel:SwitchToBookMark(bookmark, customData)
    if bookmark == nil or bookmark == self.mCurrentBookMark then
        return
    end
    if self.mCurrentBookMark ~= nil then
        local bookmarkPreviousGos = self:GetBookMarkTypeToBookMarkGo()[self.mCurrentBookMark]
        if bookmarkPreviousGos ~= nil and CS.StaticUtility.IsNull(bookmarkPreviousGos.checkmarkGo) == false then
            bookmarkPreviousGos.checkmarkGo:SetActive(false)
        end
    end
    self.mCurrentBookMark = bookmark
    local bookmarkCurrentGos = self:GetBookMarkTypeToBookMarkGo()[self.mCurrentBookMark]
    if bookmarkCurrentGos ~= nil and CS.StaticUtility.IsNull(bookmarkCurrentGos.checkmarkGo) == false then
        bookmarkCurrentGos.checkmarkGo:SetActive(true)
    end
    local bookmarkData = self:GetBookMarkPanelData(self.mCurrentBookMark)
    if customData ~= nil then
        self:SwitchCurrentPanel(bookmarkData.panelname, customData)
    else
        self:SwitchCurrentPanel(bookmarkData.panelname, bookmarkData.panelparam)
    end
end

---@param bookmark LuaEnumRechargeMainBookMarkType
---@return UIRechargeMainBookMarkData
function UIRechargeMainPanel:GetBookMarkPanelData(bookmark)
    if self.mUIPanelMap == nil or bookmark == nil then
        return nil
    end
    return self.mUIPanelMap[bookmark]
end

function UIRechargeMainPanel:IsShowGiftPage()
    ---特惠礼包页签显示条件
    local csData = self:GetPlayerInfo().RechargeInfo.CurrentRechargeGiftBoxInfo
    local buyRewardList = csData.buyTimes
    local buyInfo = CS.CSRechargeInfoV2.GetBuyRewardInfo(buyRewardList)
    local ShowPreferenceList = {}
    self:AddBuyingReward(buyInfo, ShowPreferenceList)
    return #ShowPreferenceList > 0
end

---添加直购礼包
function UIRechargeMainPanel:AddBuyingReward(buyInfo, ShowList)
    local sortTable = {}
    for i = 0, buyInfo.Count - 1 do
        local id = buyInfo[i]
        table.insert(sortTable, id)
    end
    for j = 1, #sortTable do
        local id = sortTable[j]
        local data = {}
        data.id = id
        local tableInfo = self:GetBuyTableData(id)
        data.tableInfo = tableInfo
        if (tableInfo.isTimeLimit ~= 2) then
            --非终生限购礼包
            data.type = tableInfo.isTimeLimit == 1 and luaEnumRechargeRewardType.LimitBuy or luaEnumRechargeRewardType.Buy
            if tableInfo.isTimeLimit == 1 then
                if (tableInfo.conditions ~= nil) then
                    local conditionList = string.Split(tableInfo.conditions, '&')
                    if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(conditionList)) then
                        local days = tableInfo.effectiveTime
                        if CS.CSRechargeInfoV2.IsShowReward(days) then
                            table.insert(ShowList, data)
                        end
                    end
                else
                    local days = tableInfo.effectiveTime
                    if CS.CSRechargeInfoV2.IsShowReward(days) then
                        table.insert(ShowList, data)
                    end
                end
            else
                table.insert(ShowList, data)
            end
        end
    end
end

---@return TABLE.CFG_RECHARGE 充值表
function UIRechargeMainPanel:GetBuyTableData(id)
    if self.mIdToBuyTableInfo == nil then
        self.mIdToBuyTableInfo = {}
    end
    local data = self.mIdToBuyTableInfo[id]
    if data == nil then
        ___, data = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(id)
        self.mIdToBuyTableInfo[id] = data
    end
    return data
end
--endregion

--region UI界面管理
---打开界面/以参数刷新界面,并关闭之前的界面
---@private
function UIRechargeMainPanel:SwitchCurrentPanel(panelName, panelParam)
    if self.mOnPanelOpened == nil then
        ---@param uibase UIBase
        self.mOnPanelOpened = function(uibase)
            self:GetOpenedPanelDic()[uibase._PanelName] = uibase
            for i = 1, #self:GetOpeningPanelList() do
                if self:GetOpeningPanelList()[i] == uibase._PanelName then
                    table.remove(self:GetOpeningPanelList(), i)
                    break
                end
            end
            if self.mCurrentOpenedPanelName ~= uibase._PanelName or self.IsHiden then
                uibase:HideSelf()
            end
        end
    end
    if self.mCurrentOpenedPanelName ~= nil and self.mCurrentOpenedPanelName ~= panelName then
        local openedPanel = self:GetOpenedPanelDic()[self.mCurrentOpenedPanelName]
        if openedPanel ~= nil then
            openedPanel:HideSelf()
        end
    end
    self.mCurrentOpenedPanelName = panelName
    local isOpening = false
    for i = 1, #self:GetOpeningPanelList() do
        if self:GetOpeningPanelList()[i] == panelName then
            isOpening = true
            break
        end
    end
    if isOpening then
        uimanager:CreatePanel(panelName, self.mOnPanelOpened, panelParam)
    else
        local currentPanel = uimanager:GetPanel(panelName)
        if currentPanel ~= nil then
            currentPanel:ReShowSelf()
            currentPanel:Show(panelParam)
            self:GetOpenedPanelDic()[panelName] = currentPanel
        else
            table.insert(self:GetOpeningPanelList(), panelName)
            if panelParam == nil then
                panelParam = {}
            elseif type(panelParam) ~= "table" then
                panelParam = { type = panelParam }
            end
            if panelParam ~= nil and type(panelParam) == "table" and self.mPanelLayerType ~= nil then
                panelParam.PanelLayerType = self.mPanelLayerType
            end
            uimanager:CreatePanel(panelName, self.mOnPanelOpened, panelParam)
        end
    end
end
--endregion

--region 隐藏/显示界面
function UIRechargeMainPanel:HideSelf()
    self:RunBaseFunction("HideSelf")
    if self._PanelState == LuaEnumUIState.IsGoingToBeDestroyed then
        return
    end
    local openedPanels = self:GetOpenedPanelDic()
    for panelname, uibase in pairs(openedPanels) do
        uibase:HideSelf()
    end
end

function UIRechargeMainPanel:ReShowSelf()
    self:RunBaseFunction("ReShowSelf")
    if self._PanelState == LuaEnumUIState.IsGoingToBeDestroyed then
        return
    end
    local openedPanels = self:GetOpenedPanelDic()
    for panelname, uibase in pairs(openedPanels) do
        if panelname == self.mCurrentOpenedPanelName then
            uibase:ReShowSelf()
            break
        end
    end
end
--endregion

--region 析构
---@private
function UIRechargeMainPanel:ClosePanel(...)
    self:RunBaseFunction("ClosePanel", ...)
    self:ClearOpenedPanels()
end

function ondestroy()
    UIRechargeMainPanel:ClearOpenedPanels()
end

---清理打开过的或者正在打开的界面
---@private
function UIRechargeMainPanel:ClearOpenedPanels()
    if self.mOpenedPanelDic ~= nil and Utility.GetTableCount(self.mOpenedPanelDic) > 0 then
        for panelname, uibase in pairs(self.mOpenedPanelDic) do
            uimanager:ClosePanel(uibase)
        end
        self.mOpenedPanelDic = {}
    end
    if self.mOpeningPanelList ~= nil and Utility.GetTableCount(self.mOpeningPanelList) > 0 then
        for panelname, v in pairs(self.mOpeningPanelList) do
            uimanager:ClosePanel(panelname)
        end
        self.mOpeningPanelList = {}
    end
end
--endregion

return UIRechargeMainPanel