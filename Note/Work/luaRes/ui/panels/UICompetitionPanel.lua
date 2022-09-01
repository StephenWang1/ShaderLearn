---@class UICompetitionPanel:UIBase 商业化_竞技面板
local UICompetitionPanel = {}

---当前选中类型
---@type number
UICompetitionPanel.mCurrentType = nil

---注册人数参数
---@type number
UICompetitionPanel.registerNum = nil

---@type boolean
---是否需要显示箭头
UICompetitionPanel.NeedShowArrow = false

---@type table<number,activityV2.ActivityDataInfo>
UICompetitionPanel.PrefixIdToData = {}

UICompetitionPanel.mStartScrollView = nil

---@type number 最大显示奖励5条
UICompetitionPanel.mMaxShowNum = 5

---@type table<number,table<number,{info:activityV2.ActivityDataInfo,CommonTable:TABLE.CFG_ACTIVITY_COMMON}>>
UICompetitionPanel.OpenActivityToData = {}
---当前为开服竞技页签时 子Group
UICompetitionPanel.mCurrentSubType = 0
---当前选中的分页签
UICompetitionPanel.mCurrentSubTog = nil
--- 首个未完成状态是否还在
UICompetitionPanel.mFirstUnfinsh = false

--region For PreferenceGift and PotentialInvest
---@type boolean 是否需要重新请求倒计时结束之后的礼包
UICompetitionPanel.IsNeedReqGiftWithTimeOut = true

---@return TABLE.CFG_DESCRIPTION 帮助描述
function UICompetitionPanel:GetRechargeHelpDes()
    if self.mRechargeHelpDes == nil then
        ___, self.mRechargeHelpDes = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(132)
    end
    return self.mRechargeHelpDes
end

---@return TABLE.CFG_ITEMS 获取道具缓存信息
function UICompetitionPanel:GetItemInfoCache(itemId)
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

---@return CSMainPlayerInfo
function UICompetitionPanel:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end
--endregion

--region 数据
---页签列表
---@type table<number, luaEnumCompetitionType>
UICompetitionPanel.mBookMarkType = {
    --luaEnumCompetitionType.LevelUp,
    --luaEnumCompetitionType.Prefix,
    luaEnumCompetitionType.PreferenceGift,
    luaEnumCompetitionType.PotentialInvest,
    luaEnumCompetitionType.OpenActivity,
    luaEnumCompetitionType.FirstKill,
    luaEnumCompetitionType.FirstDrop,
    luaEnumCompetitionType.Recycle,
}

---页签名字
---@type table<number,string>
UICompetitionPanel.mBookMarkName = {
    [luaEnumCompetitionType.OpenActivity] = "冲级奖励",
    --[luaEnumCompetitionType.LevelUp] = "冲级奖励",
    [luaEnumCompetitionType.FirstKill] = "首杀奖励",
    [luaEnumCompetitionType.FirstDrop] = "首爆奖励",
    --[luaEnumCompetitionType.Prefix] = "战勋竞技",
    [luaEnumCompetitionType.Recycle] = "装备回收",
    [luaEnumCompetitionType.PreferenceGift] = "特惠礼包",
    [luaEnumCompetitionType.PotentialInvest] = "潜能投资",
}

function UICompetitionPanel:GetGroupNum()
    ---@type table<number,number> 数据组数
    if self.mTypeGroup == nil then
        self.mTypeGroup = {}
    end
    local list = CS.Cfg_GlobalTableManager.Instance:GetCompetitionBookMarkGroupNum()
    if list and list.Count >= 5 then
        --self.mTypeGroup[luaEnumCompetitionType.LevelUp] = list[0]
        self.mTypeGroup[luaEnumCompetitionType.FirstKill] = list[1]
        self.mTypeGroup[luaEnumCompetitionType.FirstDrop] = list[2]
        --self.mTypeGroup[luaEnumCompetitionType.Prefix] = list[3]
        --self.mTypeGroup[luaEnumCompetitionType.Recycle] = list[4]
        self.mTypeGroup[luaEnumCompetitionType.OpenActivity] = list[5]
    end
end

UICompetitionPanel.mBookMarkRedPointKey = {
    [luaEnumCompetitionType.OpenActivity] = CS.RedPointKey.Activity_Competition_ServerOpen,
    [luaEnumCompetitionType.FirstKill] = CS.RedPointKey.Activity_Competition_FirstKill,
    [luaEnumCompetitionType.FirstDrop] = CS.RedPointKey.Activity_Competition_FirstDrop,
    [luaEnumCompetitionType.Recycle] = CS.RedPointKey.Activity_Competition_Recycle,
    [luaEnumCompetitionType.PotentialInvest] = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint),
}

-----页签类型对应的Toggle
-----@type table<number,UIToggle>
--UICompetitionPanel.mTypeToToggle = {}

---@type number
---列表数目
UICompetitionPanel.ListCount = 5

---@return CSMainPlayerInfo 主角信息
function UICompetitionPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSActivityInfoV2 活动信息
function UICompetitionPanel:GetActivityV2()
    if self.mActivityV2 == nil and self:GetMainPlayerInfo() then
        self.mActivityV2 = self:GetMainPlayerInfo().ActivityInfo
    end
    return self.mActivityV2
end

---@return CSBagInfoV2
function UICompetitionPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end
--endregion

--region 组件
---@return UIGridContainer 页签Container
function UICompetitionPanel:GetBookMark_UIGridContainer()
    if self.mBookMarkContainer == nil then
        self.mBookMarkContainer = self:GetCurComp("WidgetRoot/events/btn", "UIGridContainer")
    end
    return self.mBookMarkContainer
end

---@return UnityEngine.GameObject 关闭按钮
function UICompetitionPanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end
---@return UnityEngine.GameObject 竞技分页签
function UICompetitionPanel:GetSubBtn_GameObject()
    if self.mSubBtn == nil then
        self.mSubBtn = self:GetCurComp("WidgetRoot/window2/leftAll", "GameObject")
    end
    return self.mSubBtn
end
---@return UILoopScrollViewPlus 竞技分页签Container
function UICompetitionPanel:GetSubBookMark_UIGridContainer()
    if self.mSubBookMarkContainer == nil then
        self.mSubBookMarkContainer = self:GetCurComp("WidgetRoot/window2/leftAll/ScorllView/BookMark", "UILoopScrollViewPlus")
    end
    return self.mSubBookMarkContainer
end
---@return UILoopScrollViewPlus 类型1&4Container
function UICompetitionPanel:GetTypeOne_UIGridContainer()
    if self.mType1Container == nil then
        self.mType1Container = self:GetCurComp("WidgetRoot/view/scroll/type1", "UILoopScrollViewPlus")
    end
    return self.mType1Container
end

---@return UILoopScrollViewPlus 类型2Container
function UICompetitionPanel:GetTypeTwo_UIGridContainer()
    if self.mType2Container == nil then
        self.mType2Container = self:GetCurComp("WidgetRoot/view/scroll/type2", "UILoopScrollViewPlus")
    end
    return self.mType2Container
end

---@return UILoopScrollViewPlus 类型3Container
function UICompetitionPanel:GetTypeThree_UIGridContainer()
    if self.mType3Container == nil then
        self.mType3Container = self:GetCurComp("WidgetRoot/view/scroll/type3", "UILoopScrollViewPlus")
    end
    return self.mType3Container
end

---@return UIGridContainer 类型4Container
function UICompetitionPanel:GetTypeFour_UIGridContainer()
    if self.mType4Container == nil then
        self.mType4Container = self:GetCurComp("WidgetRoot/view/scroll/type4", "UIGridContainer")
    end
    return self.mType4Container
end

---@return UILoopScrollViewPlus 类型5回收Container
function UICompetitionPanel:GetTypeFive_UIGridContainer()
    if self.mType5Container == nil then
        self.mType5Container = self:GetCurComp("WidgetRoot/view/scroll/type5", "UILoopScrollViewPlus")
    end
    return self.mType5Container
end
---@return UIGridContainer 类型6Container
function UICompetitionPanel:GetTypeSix_UIGridContainer()
    if self.mType6Container == nil then
        self.mType6Container = self:GetCurComp("WidgetRoot/view/scroll/type6", "UIGridContainer")
    end
    return self.mType6Container
end
---特惠奖励根节点
---@return UnityEngine.GameObject
function UICompetitionPanel:GetPreferentialGiftRoot()
    if self.mPreferentialGiftRoot == nil then
        self.mPreferentialGiftRoot = self:GetCurComp("WidgetRoot/view/SpeciallyPreferentialGift", "GameObject")
    end
    return self.mPreferentialGiftRoot
end
---潜能投资根节点
---@return UnityEngine.GameObject
function UICompetitionPanel:GetPotentialInvestRoot()
    if self.mPotentialInvestRoot == nil then
        self.mPotentialInvestRoot = self:GetCurComp("WidgetRoot/view/PotentialInvest", "GameObject")
    end
    return self.mPotentialInvestRoot
end

---@return UIScrollView
function UICompetitionPanel:GetScrollView()
    if self.mScrollView == nil then
        self.mScrollView = self:GetCurComp("WidgetRoot/view/scroll", "UIScrollView")
    end
    return self.mScrollView
end

---@return UnityEngine.GameObject 提示箭头
function UICompetitionPanel:GetArrow_GameObject()
    if self.mArrowObj == nil then
        self.mArrowObj = self:GetCurComp("WidgetRoot/events/DownArrow", "GameObject")
    end
    return self.mArrowObj
end

---@return TweenAlpha 提示箭头动画
function UICompetitionPanel:GetDownArrowTween()
    if self.mDownArrowTween == nil then
        self.mDownArrowTween = self:GetCurComp("WidgetRoot/events/DownArrow", "TweenAlpha")
    end
    return self.mDownArrowTween
end

---@return UnityEngine.GameObject 提示箭头
function UICompetitionPanel:GetUpArrow_GameObject()
    if self.mUpArrowObj == nil then
        self.mUpArrowObj = self:GetCurComp("WidgetRoot/events/UpArrow", "GameObject")
    end
    return self.mUpArrowObj
end

---@return TweenAlpha 提示箭头动画
function UICompetitionPanel:GetUpArrowTween()
    if self.mUpArrowTween == nil then
        self.mUpArrowTween = self:GetCurComp("WidgetRoot/events/UpArrow", "TweenAlpha")
    end
    return self.mUpArrowTween
end

---@return UICountdownLabel 倒计时
function UICompetitionPanel:GetTimeCountLabel_UICountdownLabel()
    if self.mTimeCountLabel == nil then
        self.mTimeCountLabel = self:GetCurComp("WidgetRoot/window2/timeCount", "UICountdownLabel")
    end
    return self.mTimeCountLabel
end

---@return UICountdownLabel 潜能倒计时
function UICompetitionPanel:GetTimePotentialInvest_UICountdownLabel()
    if self.mTimePotentialInvest == nil then
        self.mTimePotentialInvest = self:GetCurComp("WidgetRoot/view/PotentialInvest/Slogan/Time", "UICountdownLabel")
    end
    return self.mTimePotentialInvest
end

---@return UnityEngine.GameObject 子节点
function UICompetitionPanel:GetChildTemplate()
    if self.mChildTemplate == nil then
        self.mChildTemplate = self:GetCurComp("WidgetRoot/view/UIItemTemplate", "GameObject")
    end
    return self.mChildTemplate
end

--endregion

--region 初始化
function UICompetitionPanel:Init()
    self:GetGroupNum()
    self:BindEvents()
    self:BindMessage()
    self:InitBookMark()
    self.mTypeToInit = {}
    UICompetitionPanel.mStartScrollView = self:GetScrollView().transform.localPosition
    if not CS.StaticUtility.IsNull(self:GetChildTemplate()) then
        self:GetChildTemplate():SetActive(false)
    end
end

function UICompetitionPanel:Show(customData)
    local currentType = self.normalOpenType
    local type = type(customData)
    if (customData ~= nil and customData.PanelLayerType ~= nil) then
        self.mPanelLayerType = customData.PanelLayerType;
    end
    if type == 'table' and customData and customData.type then
        currentType = customData.type
    elseif type == 'string' then
        currentType = tonumber(customData)
    else
        if self.mIsHidenBefore == nil or self.mIsHidenBefore == true or currentType == nil then
            self.mIsHidenBefore = false
            local currentRedPointType = self:GetFirstRedPointType()
            if currentRedPointType then
                currentType = currentRedPointType
            end
        end
    end
    if currentType == nil then
        ---如果不管怎样都为nil，则选择第一个可以打开的
        local bookmarkArray = self:GetBookMarkArray()
        if #bookmarkArray > 0 then
            currentType = bookmarkArray[1]
        end
    end
    --self.normalOpenType = luaEnumCompetitionType.OpenActivity
    --if self.mTypeToToggle then
    --    local toggle = self.mTypeToToggle[self.normalOpenType]
    --    if not CS.StaticUtility.IsNull(toggle) then
    --        --toggle:Set(true)
    --        --self:OnToggleClicked(self.normalOpenType)
    --    end
    --end
    self:SwitchToType(currentType, true)
end

function UICompetitionPanel:ReShowSelf()
    self:RunBaseFunction("ReShowSelf")
    self.mIsHidenBefore = true
end

---获取第一个亮着红点的页签类型
---@return luaEnumCompetitionType
function UICompetitionPanel:GetFirstRedPointType()
    local csRedPointMgr = CS.CSUIRedPointManager.GetInstance()
    --for bookmarkType, key in pairs(self.mBookMarkRedPointKey) do
    --    if csRedPointMgr:GetRedPointValue(key) then
    --        return bookmarkType
    --    end
    --end

    for i = 1, #self.mBookMarkType do
        local competitionType = self.mBookMarkType[i]
        local redpointTemp = self.mBookMarkRedPointKey[competitionType]
        if redpointTemp ~= nil then
            if csRedPointMgr:GetRedPointValue(redpointTemp) then
                return competitionType
            end
        end
    end

    --
    --if self:GetActivityV2() and self:GetActivityV2().GetCompetitionNormalRedPoint then
    --    local redPointType = self:GetActivityV2():GetCompetitionNormalRedPoint()
    --    for i = 0, redPointType.Count - 1 do
    --        local type = redPointType[i]
    --        if (self.mTypeToToggle[type]) then
    --            return type
    --        end
    --    end
    --end
    --return self.normalOpenType
end

function UICompetitionPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
    self:GetScrollView().onDragFinished = function()
        self:RefreshArrow()
    end
end

function UICompetitionPanel:BindMessage()
    UICompetitionPanel.OnResOpenPanelMessageReceivedFunc = function(magId, tblData, csData)
        self:OnResOpenPanelMessageReceived(csData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOpenPanelMessage, UICompetitionPanel.OnResOpenPanelMessageReceivedFunc)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResActivityCommonStatusMessage, function()
        if self.mCurrentType == luaEnumCompetitionType.OpenActivity then
            ---开服竞技状态刷新时刷新下开服竞技的红点
            self.mUpdateOpenActivityRedPointSign = 10
            ---开服竞技状态下如果收到红点,则向服务器请求界面数据
            self.mReReqOpenActivitymsg = true
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshType5BtnState()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RecycleBagDataChange, function()
        self:OnBagItemChange()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOpenStoreByIdMessage, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RechargeRewardChange, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:RefreshUI()
    end)
end
--endregion

--region 服务器消息
---@param csData activityV2.ResOpenPanel
function UICompetitionPanel:OnResOpenPanelMessageReceived(csData)
    if csData == nil or csData.info == nil then
        if isOpenLog then
            luaDebug.LogError("服务器数据activityV2.ResOpenPanel或者这里面的info是空的")
        end
        return
    end
    if isOpenLog then
        luaDebug.Log("当前注册人数" .. tostring(csData.info.registerNum))
    end
    self.registerNum = csData.info.registerNum
    local type = csData.activityType
    if type == luaEnumCompetitionType.OpenActivity then
        local data = self:GetShowRewardInfo(csData.info.activityDataInfo, 1, csData.activityType, type)
        self:InitOpenActivityData(data)
        self:InitOpenActivitySunTog()
        self:RefreshLoopScrollViewBySubTog()
        self.mUpdateOpenActivityRedPointSign = 10
    else
        local groupNum = self.mTypeGroup[csData.activityType]
        if groupNum == nil then
            groupNum = 1
        end

        local showList = self:GetShowRewardInfo(csData.info.activityDataInfo, groupNum, csData.activityType, type)
        if type == luaEnumCompetitionType.FirstDrop then
            ---优化首爆排序
            local cslist = CS.Utility_Lua.activityDataList
            cslist:Clear()
            for i = 1, #showList do
                cslist:Add(showList[i])
            end
            CS.Utility_Lua.SortFirstDropList(cslist)
            for i = 1, #showList do
                showList[i] = cslist[i - 1]
            end
            cslist:Clear()
        else
            ---优化首爆之外的排序
            local cslist = CS.Utility_Lua.activityDataList
            cslist:Clear()
            for i = 1, #showList do
                cslist:Add(showList[i])
            end
            CS.Utility_Lua.SortNormalActivityDataList(cslist)
            for i = 1, #showList do
                showList[i] = cslist[i - 1]
            end
            cslist:Clear()
        end
        local loopScrollView
        if showList then
            if type == luaEnumCompetitionType.FirstKill then
                loopScrollView = self:GetTypeTwo_UIGridContainer()
            elseif type == luaEnumCompetitionType.FirstDrop then
                loopScrollView = self:GetTypeThree_UIGridContainer()
            elseif type == luaEnumCompetitionType.Recycle then
                loopScrollView = self:GetTypeFive_UIGridContainer()
            end
        end
        if loopScrollView == nil then
            return
        end
        self.showList = showList
        self.showList = self:TrySortTable(showList, type)
        self:RefreshLoopScrollViewByTableInfo(loopScrollView, type)

        if self.mNeedSuitPanel and self:NeedJump(type) then
            self.mNeedSuitPanel = false
            local JumpLine
            local maxLine = #showList
            if type == luaEnumCompetitionType.Recycle then
                JumpLine = self:GetRecycleJumpLine(showList)
            else
                JumpLine = self:GetJumpLine(showList)
            end
            self:LoopScrollViewPlusJumpToLine(loopScrollView, JumpLine - 1, maxLine)
        end
    end
    if self.mCurrentType == luaEnumCompetitionType.OpenActivity then
        ---开服竞技状态刷新时刷新下开服竞技的红点
        self.mUpdateOpenActivityRedPointSign = 10
    end
end

---屏蔽某些类型的跳转
function UICompetitionPanel:NeedJump(type)
    if type == luaEnumCompetitionType.FirstDrop then
        return false
    end
    if type == luaEnumCompetitionType.Recycle then
        return false
    end
    return true
end

---排序
---@param showList table<number,activityV2.ActivityDataInfo>
---@param type luaEnumCompetitionType
function UICompetitionPanel:TrySortTable(showList, type)
    if type == luaEnumCompetitionType.FirstDrop then
        showList = self:SortFirstDropList(showList)
    elseif type == luaEnumCompetitionType.Recycle then
        showList = self:SortRecycleList(showList)
    end
    return showList
end

---@return number 获得任务状态排序，越小越前
function UICompetitionPanel:GetStateOrder(state)
    if state == 1 then
        return 1
    elseif state == 0 then
        return 2
    elseif state == 2 then
        return 3
    elseif state == 3 then
        return 4
    end
    return 0
end

function UICompetitionPanel:CallOpenActivityRedPoint()
    ---刷新竞技界面开服竞技的红点
    local luaRedPointMgr = gameMgr:GetLuaRedPointManager()
    luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_DengJi))
    luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_LingShou))
    luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_YuanShi))
    luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_DengXin))
    luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_XunZhang))
    luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_XingJi))
    luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_ZhanXun))
end

---@param list table<number,activityV2.ActivityDataInfo>
function UICompetitionPanel:InitOpenActivityData(list)
    if (list == nil or #list <= 0) then
        return
    end
    self.OpenActivityToData = {}
    for i = 1, #list do
        local isget
        ---@type TABLE.CFG_ACTIVITY_COMMON
        local tab_act
        isget, tab_act = CS.Cfg_Activity_CommonTableManager.Instance:TryGetValue(list[i].activityId)
        if (isget) then
            local tabTemp = {}
            tabTemp.info = list[i]
            tabTemp.CommonTable = tab_act
            if (self.OpenActivityToData == nil or #self.OpenActivityToData == 0) then
                local tab = {}
                table.insert(tab, tabTemp)
                self.OpenActivityToData[1] = tab
            else
                for j = 1, #self.OpenActivityToData do
                    if (self.OpenActivityToData[j][1] ~= nil) then
                        if (isget and self.OpenActivityToData[j][1].CommonTable.group == tab_act.group) then
                            table.insert(self.OpenActivityToData[j], tabTemp)
                            break
                        elseif j == #self.OpenActivityToData then
                            local tab = {}
                            table.insert(tab, tabTemp)
                            self.OpenActivityToData[j + 1] = tab
                            break
                        end
                    end
                end
            end
        end
    end
end

function UICompetitionPanel:InitOpenActivitySunTog()
    --if (self.OpenActivityToData == nil or #self.OpenActivityToData <= 0) then
    --    return
    --end
    if (self.mCurrentSubType == 0) then
        ---红点自动选
        local ind = self:GetFirstOpenServerActivityType()
        if (ind ~= nil) then
            self.mCurrentSubType = ind
        else
            if (self.OpenActivityToData[1] ~= nil and self.OpenActivityToData[1][1] ~= nil) then
                self.mCurrentSubType = self.OpenActivityToData[1][1].CommonTable.group
            end
        end
    else

    end
end
--endregion

--region 页签栏
-----点击页签
--function UICompetitionPanel:OnToggleClicked(type, subType)
--    local loop = self:GetCurrentLoop()
--    if loop then
--        loop:JumpToLine(0)
--    end
--
--    self:SaveInitLoopState(type, false)
--    self:SetRechargeEntrancePanel(type)
--    self.mNeedSuitPanel = true
--    self:GetScrollView():ResetPosition()
--
--    --if self.mCurrentType == luaEnumCompetitionType.OpenActivity and type ~= luaEnumCompetitionType.OpenActivity then
--    --    if (not CS.StaticUtility.IsNull(self:GetSubBtn_GameObject())) then
--    --        self:GetSubBtn_GameObject():SetActive(false)
--    --    end
--    --end
--
--    self.mCurrentType = type
--    self:GetTypeTwo_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.FirstKill)
--    self:GetTypeThree_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.FirstDrop)
--    self:GetTypeSix_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.OpenActivity)
--    self:GetTypeFive_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.Recycle)
--    networkRequest.ReqOpenPanel(type)
--    self:RefreshTimeShow(type)
--    if (subType == nil and type ~= 6) then
--        self.mCurrentSubType = 0
--    elseif subType ~= nil then
--        self.mCurrentSubType = subType
--    end
--end

---@return UILoopScrollViewPlus
function UICompetitionPanel:GetCurrentLoop()
    if self.mCurrentType == luaEnumCompetitionType.FirstKill then
        return self:GetTypeTwo_UIGridContainer()
    elseif self.mCurrentType == luaEnumCompetitionType.FirstDrop then
        return self:GetTypeThree_UIGridContainer()
    elseif self.mCurrentType == luaEnumCompetitionType.FirstDrop then
        return self:GetTypeThree_UIGridContainer()
    elseif self.mCurrentType == luaEnumCompetitionType.Recycle then
        return self:GetTypeFive_UIGridContainer()
    end
end

---[[---点击竞技分页签
function UICompetitionPanel:OnSubToggleClicked(group)
    self:SaveInitLoopState(6, false)
    self:SetRechargeEntrancePanel(6, group)
    self.mNeedSuitPanel = true
    if (self.mCurrentSubType ~= group) then
        self:GetScrollView():ResetPosition()
    end
    self.mCurrentSubType = group
    --self:SetSubTog(go)
    self:SetSubInfo()
    self:JumpToRedLine(group)
    self:RefreshTimeShow(6, group)
end
--]]

function UICompetitionPanel:JumpToRedLine(group)
    local line = -1
    local temp = self:GetFirstLineOfTargetOpenServerActivityType(group)
    if (temp ~= nil) then
        for i = 1, #self.showList do
            if (temp == self.showList[i].CommonTable.order) then
                line = i - 1
            end
        end
    end
    if (line == -1) then
        for i = 1, #self.showList do
            if (self:GetActivityFinishState(self.showList[i].info) == 0) then
                line = i - 1
                break
            end
        end
    end
    if (line == -1) then
        return
    end
    self:JumpToLine(line, #self.showList)
end

---分页签显示
function UICompetitionPanel:SetSubInfo()
    if (self.showList == nil) then
        return
    end
    local showList = {}
    for i = 1, #self.showList do
        if (self.showList[i].info ~= nil) then
            table.insert(showList, self.showList[i].info)
        end
    end
    table.sort(showList, self.SortByTableData)
    return self:RefreshTableTypeContainer(showList, self:GetTypeSix_UIGridContainer(), luaEnumCompetitionType.OpenActivity)
end

--function UICompetitionPanel:SetSubTog(go)
--    if (go == nil or CS.StaticUtility.IsNull(go)) then
--        return
--    end
--    self:SetSubTogAct(false)
--    self.mCurrentSubTog = go
--    self:SetSubTogAct(true)
--end
--
--function UICompetitionPanel:SetSubTogAct(val)
--    if (self.mCurrentSubTog ~= nil) then
--        local ck = self:GetComp(self.mCurrentSubTog.transform, "checkmark", "GameObject")
--        if (ck ~= nil and not CS.StaticUtility.IsNull(ck)) then
--            ck:SetActive(val)
--        end
--    end
--end

---获得页签显示状态或者条件
---@return boolean|System.Collections.Generic.List1T
function UICompetitionPanel:GetBookMarkShowStateOrShowCondition(type, subType)
    if type == luaEnumCompetitionType.PotentialInvest then
        ---潜能投资页签显示条件
        return gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():IsShowPotentialInvest()
    end
    if type == luaEnumCompetitionType.PreferenceGift then
        ---特惠礼包页签显示条件
        local csData = self:GetPlayerInfo().RechargeInfo.CurrentRechargeGiftBoxInfo
        local buyRewardList = csData.buyTimes
        local buyInfo = CS.CSRechargeInfoV2.GetBuyRewardInfo(buyRewardList)
        local ShowPreferenceList = {}
        self:AddBuyingReward(buyInfo, ShowPreferenceList)
        return #ShowPreferenceList > 0
    end

    local T = type
    if (subType == nil) then
        T = 0
    end
    self.mConditions = CS.Cfg_GlobalTableManager.Instance:GetCompetitionBookMarkShowCondition(T)
    local res, condition
    if (subType == nil) then
        subType = type
    end
    res, condition = self.mConditions:TryGetValue(subType)
    if res then
        return condition
    end
end

function UICompetitionPanel:IsOpenDaysEnough(OpenDays, LimitTime)
    if (LimitTime.list.Count >= 2 and OpenDays >= LimitTime.list[0] and OpenDays <= LimitTime.list[1]) then
        return true
    end
    return false
end

---添加直购礼包
function UICompetitionPanel:AddBuyingReward(buyInfo, ShowList)
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
function UICompetitionPanel:GetBuyTableData(id)
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

---获取需要显示页签
---@return table<number, luaEnumCompetitionType>
function UICompetitionPanel:GetBookMarkArray()
    if self.showBookMark ~= nil then
        return self.showBookMark
    end
    local showBookMark = {}
    for i = 1, #self.mBookMarkType do
        local type = self.mBookMarkType[i]
        local condition = self:GetBookMarkShowStateOrShowCondition(type)
        if condition == true or condition == false then
            if condition then
                table.insert(showBookMark, type)
            end
        else
            if condition then
                if condition.Count > 0 then
                    local noticeId = condition[0]
                    if Utility.GetActivityOpen(noticeId) then
                        table.insert(showBookMark, type)
                    end
                end
            end
        end
    end
    if showBookMark and #showBookMark > 0 then
        self.normalOpenType = showBookMark[1]
    end
    self.showBookMark = showBookMark
    return self.showBookMark
end

---初始化页签
function UICompetitionPanel:InitBookMark()
    local bookmarkArray = self:GetBookMarkArray()
    if true then
        ---此处将loopscrollview当做gridcontatiner来用了
        self:GetSubBookMark_UIGridContainer().MaxCount = #bookmarkArray
        for i = 1, #bookmarkArray do
            self:InitSingleBookMark(self:GetSubBookMark_UIGridContainer().itemsList[i - 1], bookmarkArray[i])
        end
        return
    end

    --self:GetBookMark_UIGridContainer().MaxCount = #bookmarkArray
    --for i = 0, self:GetBookMark_UIGridContainer().controlList.Count - 1 do
    --    ---base
    --    ---@type number 页签类型
    --    local type = bookmarkArray[i + 1]
    --    ---@type UnityEngine.GameObject
    --    local go = self:GetBookMark_UIGridContainer().controlList[i]
    --
    --    ---toggle
    --    ---@type UIToggle
    --    local toggle = CS.Utility_Lua.GetComponent(go, "UIToggle")
    --    local bg = CS.Utility_Lua.Get(go.transform, "bg", "UISprite")
    --    --self.mTypeToToggle[type] = toggle
    --
    --    ---label
    --    ---@type UILabel
    --    local label = CS.Utility_Lua.Get(go.transform, "bg/label", "UILabel")
    --    local label2 = CS.Utility_Lua.Get(go.transform, "Checkmark/label", "UILabel")
    --    if not CS.StaticUtility.IsNull(label) then
    --        label.text = self.mBookMarkName[type]
    --    end
    --    if not CS.StaticUtility.IsNull(label2) then
    --        label2.text = self.mBookMarkName[type]
    --    end
    --
    --    ---event
    --    if not CS.StaticUtility.IsNull(toggle) then
    --        CS.UIEventListener.Get(toggle.gameObject).onClick = function()
    --            --self:OnToggleClicked(type)
    --            self:OnNewBookMarkClicked(type)
    --        end
    --    end
    --
    --    ---redpoint
    --    ---@type UIRedPoint 红点
    --    local redPoint = CS.Utility_Lua.Get(go.transform, "redPoint", "UIRedPoint")
    --    local redPointInfo = self.mBookMarkRedPointKey[type]
    --    if redPointInfo then
    --        redPoint:AddRedPointKey(redPointInfo)
    --    end
    --end
end
--endregion

--region 新刷新UI
---初始化单个页签
---@param go UnityEngine.GameObject
---@param bookmarkType luaEnumCompetitionType
function UICompetitionPanel:InitSingleBookMark(go, bookmarkType)
    ---label
    ---@type UILabel
    local label = CS.Utility_Lua.Get(go.transform, "background/Label", "UILabel")
    local label2 = CS.Utility_Lua.Get(go.transform, "checkmark/Label", "UILabel")
    if not CS.StaticUtility.IsNull(label) then
        label.text = self.mBookMarkName[bookmarkType]
    end
    if not CS.StaticUtility.IsNull(label2) then
        label2.text = self.mBookMarkName[bookmarkType]
    end
    ---event
    if not CS.StaticUtility.IsNull(go) then
        if self.mTypeToGo == nil then
            self.mTypeToGo = {}
        end
        self.mTypeToGo[bookmarkType] = go
        CS.UIEventListener.Get(go).onClick = function()
            self:SwitchToType(bookmarkType, true)
        end
    end
    ---redpoint
    ---@type UIRedPoint 红点
    local redPoint = CS.Utility_Lua.Get(go.transform, "redPoint", "UIRedPoint")
    local redPointInfo = self.mBookMarkRedPointKey[bookmarkType]
    if redPointInfo then
        redPoint:AddRedPointKey(redPointInfo)
    end
end

---刷新UI
---@public
function UICompetitionPanel:RefreshUI()
    self:SwitchToType(self.normalOpenType, true)
end

---新版页签点击事件
---@param type luaEnumCompetitionType
function UICompetitionPanel:SwitchToType(type, isForce)
    if type == self.normalOpenType and isForce ~= true then
        return
    end
    local loop = self:GetCurrentLoop()
    if loop then
        loop:JumpToLine(0)
    end
    self.normalOpenType = type
    self:SaveInitLoopState(type, false)
    self:SetRechargeEntrancePanel(type)
    self.mNeedSuitPanel = true
    self:GetScrollView():ResetPosition()

    --if self.mCurrentType == luaEnumCompetitionType.OpenActivity and type ~= luaEnumCompetitionType.OpenActivity then
    --    if (not CS.StaticUtility.IsNull(self:GetSubBtn_GameObject())) then
    --        self:GetSubBtn_GameObject():SetActive(false)
    --    end
    --end

    self.mCurrentType = type
    self:GetTypeTwo_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.FirstKill)
    self:GetTypeThree_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.FirstDrop)
    self:GetTypeSix_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.OpenActivity)
    self:GetTypeFive_UIGridContainer().gameObject:SetActive(type == luaEnumCompetitionType.Recycle)
    self:GetPotentialInvestTemplate().go:SetActive(type == luaEnumCompetitionType.PotentialInvest)
    self:GetPreferentialGiftTemplate().go:SetActive(type == luaEnumCompetitionType.PreferenceGift)
    if type == luaEnumCompetitionType.PreferenceGift then
        self:GetPreferentialGiftTemplate():Refresh()
        self.NeedShowArrow = false
        self:RefreshArrow()
    elseif type == luaEnumCompetitionType.PotentialInvest then
        self:GetPotentialInvestTemplate():Refresh()
        self.NeedShowArrow = false
        self:RefreshArrow()
    end

    if type == luaEnumCompetitionType.OpenActivity or
            type == luaEnumCompetitionType.FirstKill or
            type == luaEnumCompetitionType.FirstDrop or
            type == luaEnumCompetitionType.Recycle
    then
        networkRequest.ReqOpenPanel(type)
    end
    self:RefreshTimeShow(type)
    self:RefreshPotentialInvestTimeShow(luaEnumCompetitionType.PotentialInvest, nil) --wxs
    if self.mTypeToGo ~= nil then
        for typeTemp, go in pairs(self.mTypeToGo) do
            ---@type UnityEngine.GameObject
            local bookmarkGo = CS.Utility_Lua.Get(go.transform, "checkmark", "GameObject")
            if CS.StaticUtility.IsNull(bookmarkGo) == false then
                bookmarkGo:SetActive(type == typeTemp)
            end
        end
    end
end
--endregion

--region 潜能投资
---潜能投资模板
---@return UIRechargeMain_PotentialInvest
function UICompetitionPanel:GetPotentialInvestTemplate()
    if self.mPotentialInvestTemplate == nil then
        self.mPotentialInvestTemplate = templatemanager.GetNewTemplate(self:GetPotentialInvestRoot(), luaComponentTemplates.UIRechargeMain_PotentialInvest, self)
    end
    return self.mPotentialInvestTemplate
end
--endregion

--region 特惠礼包
---特惠礼包模板
---@return UIRechargeMain_PreferenceGift
function UICompetitionPanel:GetPreferentialGiftTemplate()
    if self.mPreferentialGiftTemplate == nil then
        self.mPreferentialGiftTemplate = templatemanager.GetNewTemplate(self:GetPreferentialGiftRoot(), luaComponentTemplates.UIRechargeMain_PreferenceGift, self)
    end
    return self.mPreferentialGiftTemplate
end
--endregion

--region 竞技时间显示
---获取倒计时时间戳
---@return XLua.Cast.Int64 结束时间戳
function UICompetitionPanel:GetActiveTimeSpan(type, subType)
    local condition = self:GetBookMarkShowStateOrShowCondition(type, subType)
    --在这里判断 如果是潜能投资 则判断是否开启独立的潜能投资倒计时
    if type == luaEnumCompetitionType.PotentialInvest and condition == true then
        local timeSpan = self:GetActivityV2():GetEndTimeStamp(7) * 1000
        return timeSpan
    end
    local indexAdd = subType == nil and 0 or 1
    local timeSpan = -1
    if condition == true or condition == false then
        return timeSpan
    else
        if condition then
            if condition.Count >= 2 - indexAdd then
                ---类型Id
                local conditionId = condition[1 - indexAdd]
                if conditionId == 1 then
                    --开服天数
                    if condition.Count >= 4 - indexAdd then
                        local endTime = condition[3 - indexAdd]
                        timeSpan = self:GetActivityV2():GetEndTimeStamp(endTime) * 1000
                    end
                elseif conditionId == 2 - indexAdd then
                    --固定时间戳
                    if condition.Count >= 4 - indexAdd then
                        local endTime = condition[3 - indexAdd]
                        timeSpan = endTime
                    end
                end
            end
        end
        return timeSpan
    end
end

---刷新竞技时间
function UICompetitionPanel:RefreshTimeShow(type, subType)
    ---@type System.TimeSpan
    local timeSpan = -1
    if type ~= luaEnumCompetitionType.OpenActivity and subType ~= nil then
        subType = nil
    end
    if type == luaEnumCompetitionType.OpenActivity then
        timeSpan = self:GetActiveTimeSpan(type, subType)
        if timeSpan ~= -1 then
            self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(true)
            self:GetTimeCountLabel_UICountdownLabel():StartCountDown(nil, 8, timeSpan, "[bb3520]", "后结束[-]", nil, function()
                self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(false)
            end)
        end
    else
        self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(false)
    end

end

--endregion

---刷新潜能投资时间
--region  --luaEnumCompetitionType.PotentialInvest
function UICompetitionPanel:RefreshPotentialInvestTimeShow(type, subType)
    ---@type System.TimeSpan
    if type == luaEnumCompetitionType.PotentialInvest then
        local timeSpan = self:GetActiveTimeSpan(type, subType)
        if timeSpan ~= -1 then
            self:GetTimePotentialInvest_UICountdownLabel().gameObject:SetActive(true)
            self:GetTimePotentialInvest_UICountdownLabel():StartCountDown(nil, 8, timeSpan, "[bb3520]", "后结束[-]", nil, function()
                self:GetTimePotentialInvest_UICountdownLabel().gameObject:SetActive(false)
            end)
        else
            self:GetTimePotentialInvest_UICountdownLabel().gameObject:SetActive(false)
        end
    end
end
--endregion
--region 通用
---@param left activityV2.ActivityDataInfo
---@param right activityV2.ActivityDataInfo
function UICompetitionPanel.SortLevelUpShow(left, right)
    if left == nil or right == nil then
        return false
    end

    local leftState = UICompetitionPanel:GetActivityFinishState(left)
    local rightState = UICompetitionPanel:GetActivityFinishState(right)
    local leftHasReward = leftState == 2 or leftState == 3
    local rightHasReward = rightState == 2 or rightState == 3
    if leftHasReward == rightHasReward then
        local leftFinish = leftState == 1
        local rightFinish = rightState == 1
        if leftFinish == rightFinish then
            return UICompetitionPanel.SortByTableData(left, right)
        else
            if leftFinish then
                return true
            else
                return false
            end
        end
    else
        if leftHasReward then
            return false
        else
            return true
        end
    end
    return false
end

---按表格order排序
---@param left activityV2.ActivityDataInfo
---@param right activityV2.ActivityDataInfo
function UICompetitionPanel.SortByTableData(left, right)
    local leftTable = UICompetitionPanel:TemporaryCacheTableData(left.activityId)
    local rightTable = UICompetitionPanel:TemporaryCacheTableData(right.activityId)
    if leftTable and rightTable then
        if leftTable.order ~= rightTable.order then
            return leftTable.order < rightTable.order and true or false
        else
            return false
        end
    end
    return false
end

---获取显示数据
---@param activityListInfo activityV2.ActivityListInfo 总数据
---@param groupNum number 组数
---@param activityType number 活动类型
---@param clientType number 自定义类型
---@return table<number,activityV2.ActivityDataInfo>
function UICompetitionPanel:GetShowRewardInfo(activityListInfo, groupNum, activityType, clientType)
    local showList = {}

    if activityListInfo == nil or groupNum == nil or activityType == nil then
        return showList
    end

    ---@type table<number,activityV2.ActivityDataInfo>
    local dataList = activityListInfo
    local group = math.floor(dataList.Count / groupNum)
    local dataListCount = dataList.Count
    for i = 0, group - 1 do
        local mNeedBreak = false
        for j = 0, groupNum - 1 do
            if not mNeedBreak then
                local index = i * groupNum + j
                if index < dataListCount then
                    ---@type activityV2.ActivityDataInfo
                    local info = dataList[index]
                    if j == groupNum - 1 then
                        --是本组最后一个直接添加
                        self:AddData(showList, info, activityType)
                    else
                        if (self:AddDataByActivityType(showList, info, activityType)) then
                            mNeedBreak = true
                        end
                    end
                end
            end
        end
    end
    return showList
end

---@param left activityV2.ActivityDataInfo
---@param right activityV2.ActivityDataInfo
---首爆排序
function UICompetitionPanel.SortFirstDrop(left, right)
    if left == nil or right == nil then
        return false
    end
    if left.leftCount ~= right.leftCount then
        if left.leftCount == 0 then
            return false
        elseif right.leftCount == 0 then
            return true
        else
            return UICompetitionPanel.SortByTableData(left, right)
        end
    else
        return UICompetitionPanel.SortByTableData(left, right)
    end
end

---@param addTable table<number,activityV2.ActivityDataInfo> 需要添加数据table
---@param info activityV2.ActivityDataInfo
function UICompetitionPanel:AddDataByActivityType(addTable, info, activityType)
    if addTable and info then
        if info.dataType == 1 or info.data == 2 then
            --个人数据
            if info.roleGoalInfo and info.roleGoalInfo.rewardState ~= 2 then
                local leaveNum = info.leftCount
                if leaveNum > 0 then
                    self:AddData(addTable, info, activityType)
                    return true
                end
            end
        elseif info.dataType == 3 then
            --个人和全服数据
            local state = self:GetActivityFinishState(info)
            if state ~= 2 then
                self:AddData(addTable, info, activityType)
                return true
            end
        end
    end
    return false
end

---判断添加条件
function UICompetitionPanel:AddData(addTable, info, activityType)
    if activityType == luaEnumCompetitionType.LevelUp or activityType == luaEnumCompetitionType.OpenActivity then
        ---首杀多判断一次条件
        local commonInfo = self:TemporaryCacheTableData(info.activityId)
        if commonInfo then
            local conditions = commonInfo.displayCondition
            if conditions then
                local conditionsList = conditions.list
                if conditionsList.Count > 0 then
                    local match = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(conditionsList)
                    if match then
                        table.insert(addTable, info)
                    end
                end
            else
                table.insert(addTable, info)
            end
        end
    else
        table.insert(addTable, info)
    end
end

---@return number 获取活动完成状态 0未完成（表示没领完且不可领） 1可领（表示有可领的） 2已完成（表示全部领完）3没有剩余了
---@param info activityV2.ActivityDataInfo
function UICompetitionPanel:GetActivityFinishState(info)
    --local commonInfo = self:TemporaryCacheTableData(info.activityId)
    if info.leftCount <= 0 then
        return 3
    end
    if info.dataType == 1 then
        if (info.roleGoalInfo == nil) then
            return 0
        end
        return info.roleGoalInfo.rewardState
    elseif info.dataType == 2 then
        if info.serverGoalInfo then
            if (info.serverGoalInfo.rewardState == 2) then
                if (info.roleGoalInfo == nil) then
                    return 0
                end
                return info.roleGoalInfo.rewardState
            else
                return info.serverGoalInfo.rewardState
            end
        end
    elseif info.dataType == 3 then
        local progress = 0
        if info.serverGoalInfo then
            local dataList = info.serverGoalInfo.serverGoalInfos
            if dataList and self:GetMainPlayerInfo() then
                for i = 0, dataList.Count - 1 do
                    ---@type activityV2.ServerGoalInfo
                    local temp = dataList[i]
                    local finishRoleId = temp.finishRoleId
                    if finishRoleId == self:GetMainPlayerInfo().ID and not temp.award then
                        return 1--首杀首爆玩家未领
                    end
                    if temp.ok then
                        progress = progress + 1 --统计有多少完成了
                    end
                end
                local canReward = info.serverGoalInfo.roleCanRewardGoalId--这是所有领过的任务id
                if canReward then
                    if canReward.Count < progress then
                        return 1 --表示没领完
                    end
                    if canReward.Count >= dataList.Count then
                        return 2 -- 表示全部领完
                    end
                end
            end
        end
    end
    return 0
end

---@param loopScroll UILoopScrollViewPlus
---@param type number 类型
function UICompetitionPanel:RefreshLoopScrollViewByTableInfo(loopScroll, type)
    if not CS.StaticUtility.IsNull(self:GetScrollView()) then
        self.mCurrentNeedRefreshType4 = false
    end
    if CS.StaticUtility.IsNull(loopScroll) or self.showList == nil or type == nil then
        return
    end
    local state = self:GetLoopState(type)
    if state then
        loopScroll:RefreshCurrentPage()
    else
        self:SaveInitLoopState(type, true)
        loopScroll:Init(function(go, line)
            if line < #self.showList then
                local data = self.showList[line + 1]
                local temp = self:GetGoTemp(type, go)
                if temp then
                    go:SetActive(false);
                    local tableData = self:TemporaryCacheTableData(data.activityId)
                    temp:Refresh(data, tableData, self.registerNum)
                    temp:SetBGColor(line % 2 == 0)
                    go:SetActive(true);
                    return true
                else
                    return false
                end
            else
                return false
            end
        end, nil)
    end
    self.NeedShowArrow = #self.showList > self.ListCount
    self:RefreshArrow()
end
--[[
---@param loopScroll UILoopScrollViewPlus
---@param type number 类型
---@param showList table<number,activityV2.ActivityDataInfo>
function UICompetitionPanel:RefreshLoopScrollViewByTableInfo2(loopScroll, type)
    if not CS.StaticUtility.IsNull(self:GetScrollView()) then
        self.mCurrentNeedRefreshType4 = false
    end
    if CS.StaticUtility.IsNull(loopScroll) or self.showList == nil or type == nil then
        return
    end
    local state = self.mCurrentSubType == type
    if state then
        loopScroll:RefreshCurrentPage()
    else
        self:SaveInitLoopState(type, true)
        loopScroll:Init(function(go, line)
            if line < #self.showList then
                local data = self.showList[line + 1]
                local temp = self:GetGoTemp(6, go)
                if temp then
                    go:SetActive(false);
                    local tableData = self:TemporaryCacheTableData(data.activityId)
                    temp:Refresh(data, tableData, self.registerNum)
                    temp:SetBGColor(line % 2 == 0)
                    go:SetActive(true);
                    return true
                else
                    return false
                end
            else
                return false
            end
        end, nil)
    end
    self.NeedShowArrow = #self.showList > self.ListCount
    self:RefreshArrow()
end]]

---[[
function UICompetitionPanel:RefreshLoopScrollViewBySubTog()
    if (self.OpenActivityToData == nil or #self.OpenActivityToData <= 0) then
        return
    end
    --if (self:GetSubBookMark_UIGridContainer() == nil or self.OpenActivityToData == nil or #self.OpenActivityToData <= 0) then
    --    return
    --end
    if true then
        if #self.OpenActivityToData > 0 then
            ---@type table<number,activityV2.ActivityDataInfo>
            local data = self.OpenActivityToData[1]
            if (data == nil or #data <= 0 or data[1] == nil) then
                return
            end
            self.showList = data
            self:OnSubToggleClicked(data[1].CommonTable.group)
        end
        return
    end
    --self:GetSubBookMark_UIGridContainer():Init(function(go, line)
    --    if line < #self.OpenActivityToData then
    --        ---@type table<number,activityV2.ActivityDataInfo>
    --        local data = self.OpenActivityToData[line + 1]
    --        local ckLb = self:GetComp(go.transform, "checkmark/Label", 'UILabel')
    --        local bgLb = self:GetComp(go.transform, "background/Label", 'UILabel')
    --        ---@type Top_UIRedPoint
    --        local redPoint = self:GetComp(go.transform, "redPoint", "UIRedPoint")
    --        if (data == nil or #data <= 0 or data[1] == nil) then
    --            return false
    --        end
    --        if (ckLb ~= nil) then
    --            ckLb.text = data[1].CommonTable.name
    --        end
    --        if (bgLb ~= nil) then
    --            bgLb.text = data[1].CommonTable.name
    --        end
    --        --注册开服竞技各类型的红点
    --        local group = data[1].CommonTable.group
    --        if group == 1 then
    --            ---等级竞技
    --            redPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_DengJi))
    --        elseif group == 2 then
    --            ---灵兽竞技
    --            redPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_LingShou))
    --        elseif group == 3 then
    --            ---元石竞技
    --            redPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_YuanShi))
    --        elseif group == 4 then
    --            ---灯芯竞技
    --            redPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_DengXin))
    --        elseif group == 5 then
    --            ---勋章竞技
    --            redPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_XunZhang))
    --        elseif group == 6 then
    --            ---星级竞技
    --            redPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_XingJi))
    --        elseif group == 7 then
    --            ---战勋竞技
    --            redPoint:AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_ZhanXun))
    --        end
    --        CS.UIEventListener.Get(go).onClick = function(go)
    --            self.showList = data
    --            self:OnSubToggleClicked(go, data[1].CommonTable.group)
    --        end
    --        if (self.mCurrentSubType == data[1].CommonTable.group) then
    --            self.showList = data
    --            self:OnSubToggleClicked(go, data[1].CommonTable.group)
    --        end
    --        return true
    --    else
    --        return false
    --    end
    --end, nil)
end
--]]

---获取开服竞技活动的红点状态
---@param openServerActivityType number 1~6,映射的是activity_common表中group字段
function UICompetitionPanel:GetOpenServerActivityRedPointState(openServerActivityType)
    local list = self:GetOpenServerActivityDataByActivityType(openServerActivityType)
    if list == nil then
        return
    end
    ---遍历竞技活动列表,如果有未领的则返回true
    for i = 1, #list do
        if list[i].info and list[i].info.leftCount then
            if self:GetActivityFinishState(list[i].info) == 1 then
                return true
            end
        end
    end
    return false
end

---获取开服竞技中某个类型的列表
---@return table<number,{info:activityV2.ActivityDataInfo,CommonTable:TABLE.CFG_ACTIVITY_COMMON}>
function UICompetitionPanel:GetOpenServerActivityDataByActivityType(openServerActivityType)
    if self.OpenActivityToData == nil or openServerActivityType == nil then
        return
    end
    for i = 1, #self.OpenActivityToData do
        local list = self.OpenActivityToData[i]
        if #list > 0 then
            if list[1].CommonTable.group == openServerActivityType then
                return list
            end
        end
    end
end

---获取第一个有红点的活动类型,以及相应的第一行的order值,如果没有找到有红点的类型,则返回1,1
---@return number,number|nil
function UICompetitionPanel:GetFirstOpenServerActivityType()
    if self.OpenActivityToData == nil then
        return nil
    end
    for i = 1, #self.OpenActivityToData do
        local list = self.OpenActivityToData[i]
        if #list > 0 then
            local group = nil
            local minLine = nil
            for j = 1, #list do
                local temp = list[j]
                if self:GetActivityFinishState(temp.info) == 1 then
                    local lineTemp = temp.CommonTable.order
                    if minLine == nil then
                        minLine = lineTemp
                        group = temp.CommonTable.group
                    else
                        if minLine > lineTemp then
                            minLine = lineTemp
                        end
                    end
                end
            end
            if minLine ~= nil then
                return group, minLine
            end
        end
    end
    return nil
end

---获取目标开服竞技活动类型列表中第一个有红点的order值,若没有则返回1
---@param activityType
function UICompetitionPanel:GetFirstLineOfTargetOpenServerActivityType(activityType)
    local list = self:GetOpenServerActivityDataByActivityType(activityType)
    if list and #list > 0 then
        local minLine = nil
        for j = 1, #list do
            local temp = list[j]
            if self:GetActivityFinishState(temp.info) == 1 then
                local lineTemp = temp.CommonTable.order
                if minLine == nil then
                    minLine = lineTemp
                else
                    if minLine > lineTemp then
                        minLine = lineTemp
                    end
                end
            end
        end
        if minLine ~= nil then
            return minLine
        end
    end
    return nil
end

function UICompetitionPanel:SaveInitLoopState(type, state)
    if type == nil then
        return
    end
    if self.mTypeToInit == nil then
        self.mTypeToInit = {}
    end
    self.mTypeToInit[type] = state
end

function UICompetitionPanel:GetLoopState(type)
    if self.mTypeToInit == nil then
        self.mTypeToInit = {}
    end
    local state = self.mTypeToInit[type]
    if state ~= nil then
        return state
    end
    return false
end

---@param loopScroll UILoopScrollViewPlus
function UICompetitionPanel:LoopScrollViewPlusJumpToLine(loopScroll, JumpLine, mMaxLine)
    if JumpLine + self.mMaxShowNum - 1 > mMaxLine then
        JumpLine = mMaxLine - self.mMaxShowNum + 1
    end
    if JumpLine <= 1 then
        JumpLine = 1
    end
    loopScroll:JumpToLineSmooth(JumpLine - 1)
end

---跳转到某行
function UICompetitionPanel:JumpToLine(JumpLine, mMaxLine)
    if JumpLine + self.mMaxShowNum - 1 > mMaxLine then
        JumpLine = mMaxLine - self.mMaxShowNum + 1
    end
    if JumpLine <= 1 then
        JumpLine = 1
    end

    local lineHeight = self:GetTypeFour_UIGridContainer().CellHeight
    local height = (lineHeight * (JumpLine - 1))
    local pos = self.mStartScrollView + CS.UnityEngine.Vector3(0, height, 0)
    self:GetScrollView():Begin(pos, 8)
end

---@return number 获取跳转行
function UICompetitionPanel:GetJumpLine(showList)
    for i = 1, #showList do
        local state = self:GetActivityFinishState(showList[i])
        if state == 1 then
            return i
        end
    end
    for i = 1, #showList do
        local state = self:GetActivityFinishState(showList[i])
        if state == 0 then
            return i
        end
    end
    return -1
end

--endregion

--region UI事件
function UICompetitionPanel:SetRechargeEntrancePanel(type, subType)
    if (type == luaEnumCompetitionType.OpenActivity) then
        --if (subType == 1) then
        --else
        --    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.OpenActivity
        --end
    elseif (type == luaEnumCompetitionType.FirstKill) then
        uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.FirstKillReward
    elseif (type == luaEnumCompetitionType.FirstDrop) then
        uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.FirstDropReward
    end
end

---@param activityData activityV2.ActivityListInfo
---@return number 第一个红点行数
function UICompetitionPanel:RefreshPrefixContainer(activityData)
    if activityData == nil then
        return
    end
    local showList = {}
    self.PrefixIdToData = {}
    local playerPrefix = self:GetMainPlayerInfo().PrefixId
    local countNum = 0
    for i = 0, activityData.activityDataInfo.Count - 1 do
        ---@type activityV2.ActivityDataInfo
        local data = activityData.activityDataInfo[i]
        self.PrefixIdToData[data.activityId] = data
        local tableData = self:TemporaryCacheTableData(data.activityId)
        if tableData and tableData.smallid == 1 then
            local prefixEnough = self:IsPlayerArrivePrefix(tableData, playerPrefix)
            if countNum < 5 or prefixEnough then
                table.insert(showList, data)
                countNum = countNum + 1
            end
        end
    end
    return self:RefreshTableTypeContainer(showList, self:GetTypeFour_UIGridContainer(), luaEnumCompetitionType.Prefix)
end

---判断玩家是否满足战勋
function UICompetitionPanel:IsPlayerArrivePrefix(tblData, playerPrefix)
    if tblData == nil or tblData.goalIds == nil or tblData.goalIds.list == nil or tblData.goalIds.list.Count <= 0 then
        return false
    end
    local goalId = tblData.goalIds.list[0]
    local res, goalInfo = CS.Cfg_ActivityGoalsTableManager.Instance.dic:TryGetValue(goalId)
    if res then
        if goalInfo.goalType == 1008 then
            local parms = goalInfo.goalParam

            local prefixId = math.ceil((math.floor((parms - 1) / 10) + 1) * 1000 + ((parms - 1) % 10) + 1)
            local desPrefix = math.floor(prefixId / 1000) - math.floor(playerPrefix / 1000)
            local des = (prefixId) % 1000 + desPrefix * 10 - playerPrefix % 1000
            if prefixId - playerPrefix <= 2 or (des <= 2 and des ~= 0) then
                return true
            end
        end
    end
    return false
end

---@param container Top_UIGridContainer
---@param showList table<number,activityV2.ActivityDataInfo>
---@return number 第一个红点行数
---刷新战勋竞技
function UICompetitionPanel:RefreshTableTypeContainer(showList, container, type)
    local redPointLine = nil
    local firstHasNotRewardLine = nil
    local realRedPointLine = nil
    --self:GetScrollView():ResetPosition()
    --UICompetitionPanel.mStartScrollView = self:GetScrollView().transform.localPosition
    container.MaxCount = #showList
    if #showList > 0 then
        UICompetitionPanel.mFirstUnfinsh = false
        for i = 0, container.controlList.Count - 1 do
            ---@type UnityEngine.GameObject
            local gp = container.controlList[i]
            ---@type UICompetitionPanel_Type4Template
            local temp = self:GetGoTemp(type, gp)
            if temp then
                local tableData = self:TemporaryCacheTableData(showList[i + 1].activityId)
                temp:Refresh(showList[i + 1], tableData, self.registerNum, i)
                temp:SetBGColor(i % 2 == 0)
                local isLastChildReward = true
                local isLastBidAimFinish = true
                if i == 0 then
                    isLastChildReward = true
                    isLastBidAimFinish = true
                elseif i > 0 then
                    local go = container.controlList[i - 1]
                    ---@type UICompetitionPanel_Type4Template
                    local lastTemp = self:GetGoTemp(type, go)
                    isLastChildReward = lastTemp:IsAllChildRewarded()
                    isLastBidAimFinish = lastTemp:IsBigAimFinish()
                end
                local selfReward = temp:IsAllChildRewarded()
                local selfFinish = temp:IsBigAimFinish()

                if redPointLine == nil and isLastChildReward and not selfReward then
                    redPointLine = temp.line
                end

                if firstHasNotRewardLine == nil and not selfFinish then
                    firstHasNotRewardLine = temp.line
                end

                if realRedPointLine == nil and redPointLine and (temp:IsShowRedPoint() and isLastBidAimFinish) then
                    realRedPointLine = temp.line
                    redPointLine = realRedPointLine
                end

                temp:RefreshRedPoint(isLastBidAimFinish)
                temp.mCanShowSmallChild = isLastBidAimFinish

                if self.mNeedSuitPanel then
                    temp.mNeedShowChild = redPointLine == temp.line
                    temp:SetChildShow()
                end
            end
        end
    end
    if redPointLine == nil then
        redPointLine = -1
    end
    if firstHasNotRewardLine == nil then
        firstHasNotRewardLine = -1
    end

    self.NeedShowArrow = #showList > self.ListCount
    self:RefreshArrow()
    return redPointLine, firstHasNotRewardLine
end

---刷新Scroll
function UICompetitionPanel:SuitScrollView(line, needRefreshAllState)
    local container = self:GetTypeFour_UIGridContainer()
    local type = luaEnumCompetitionType.Prefix

    local height = 0
    local heightDic = {}
    local basicRegion
    if (self:GetScrollView().panel) then
        basicRegion = self:GetScrollView().panel.baseClipRegion
    end
    local currentPos = self:GetScrollView().transform.localPosition
    if container.controlList then
        ---@type UISprite
        local childHeight = CS.Utility_Lua.Get(container.controlTemplate.transform, "backGround", "UISprite")
        local cellDes = container.CellHeight - childHeight.height

        for i = 0, container.controlList.Count - 1 do
            ---@type UnityEngine.GameObject
            local gp = container.controlList[i]
            ---@type UICompetitionPanel_Type4Template
            local temp = self:GetGoTemp(type, gp)
            if temp then
                if needRefreshAllState then
                    temp:RefreshNeedShowChild(line == temp.line)
                end
                local childSize = temp:GetSelfHeight() + cellDes
                local pos = gp.transform.localPosition
                pos.y = height
                height = height - childSize
                heightDic[i] = -height
                gp.transform.localPosition = pos
                temp:SetBGColor(i % 2 == 0)
            end
        end
    end

    if line == nil then
        line = 0
    end
    local lastHeight = 0
    if line - 1 >= 0 then
        lastHeight = heightDic[line - 1]
    end
    if line >= container.controlList.Count or line < 0 then
        return
    end

    local currentHeight = heightDic[line]
    local go = container.controlList[line]
    ---@type UICompetitionPanel_Type4Template
    local temp = self:GetGoTemp(type, go)
    local childHeight = 0
    if temp then
        childHeight = temp:GetSelfHeight()
    end
    local startPos = lastHeight + self.mStartScrollView.y
    local endPos = currentHeight + self.mStartScrollView.y
    local scrollStartPos = currentPos.y
    local scrollEndPos = scrollStartPos + basicRegion.w
    local height = lastHeight - (basicRegion.w - childHeight)
    local needMove = scrollEndPos < endPos
    if height and needMove then
        local pos = self.mStartScrollView + CS.UnityEngine.Vector3(0, height, 0)
        self:GetScrollView():Begin(pos, 8)
    end

    local finalIndex = container.controlList.Count - 1
    local finalHeight = heightDic[finalIndex]
    local finalGo = container.controlList[finalIndex]
    local finalTemp = self:GetGoTemp(type, finalGo)
    local finalChildHeight = 0
    if finalTemp then
        finalChildHeight = temp:GetSelfHeight()
    end
    if finalHeight then
        local finalLastHeight = heightDic[finalIndex - 1]
        local finalHeight = finalLastHeight - (basicRegion.w - finalChildHeight)
        local finalEndPos = heightDic[finalIndex] + self.mStartScrollView.y
        if finalEndPos < scrollEndPos then
            local pos = self.mStartScrollView + CS.UnityEngine.Vector3(0, finalHeight, 0)
            self:GetScrollView():Begin(pos, 8)
        end
    end
end

---@return TABLE.CFG_ACTIVITY_COMMON 临时缓存活动数据
function UICompetitionPanel:TemporaryCacheTableData(id)
    if self.mActivityIdToData == nil then
        self.mActivityIdToData = {}
    end
    local data = self.mActivityIdToData[id]
    if data == nil then
        local res
        res, data = CS.Cfg_Activity_CommonTableManager.Instance.dic:TryGetValue(id)
        if res then
            self.mActivityIdToData[id] = data
        end
    end
    return data
end

---@return TABLE.CFG_ACTIVITY_GOALS 缓存目标数据
function UICompetitionPanel:TemporaryCacheGoalTableData(id)
    if self.mGoalIdToData == nil then
        self.mGoalIdToData = {}
    end
    local data = self.mGoalIdToData[id]
    if data == nil then
        ___, data = CS.Cfg_ActivityGoalsTableManager.Instance.dic:TryGetValue(id)
        self.mGoalIdToData[id] = data
    end
    return data
end

---@param type number 活动类型
function UICompetitionPanel:GetGoTemp(type, go)
    if type == nil or CS.StaticUtility.IsNull(go) then
        return
    end

    if type == luaEnumCompetitionType.LevelUp then
        if self.mTypeOneTemp == nil then
            self.mTypeOneTemp = {}
        end
        local temp = self.mTypeOneTemp[go]
        if temp == nil then
            ---@type  UICompetitionPanel_Type1Template
            temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICompetitionPanel_Type1Template, self)
            self.mTypeOneTemp[go] = temp
        end
        return temp
    elseif type == luaEnumCompetitionType.FirstKill then
        if self.mTypeTwoTemp == nil then
            self.mTypeTwoTemp = {}
        end
        local temp = self.mTypeTwoTemp[go]
        if temp == nil then
            ---@type UICompetitionPanel_Type2Template
            temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICompetitionPanel_Type2Template, self)
            self.mTypeTwoTemp[go] = temp
        end
        return temp
    elseif type == luaEnumCompetitionType.FirstDrop then
        if self.mTypeThreeTemp == nil then
            self.mTypeThreeTemp = {}
        end
        local temp = self.mTypeThreeTemp[go]
        if temp == nil then
            ---@type UICompetitionPanel_Type3Template
            temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICompetitionPanel_Type3Template, self)
            self.mTypeThreeTemp[go] = temp
        end
        return temp
    elseif type == luaEnumCompetitionType.Prefix or type == luaEnumCompetitionType.OpenActivity then
        if self.mTypeFourTemp == nil then
            self.mTypeFourTemp = {}
        end
        local temp = self.mTypeFourTemp[go]
        if temp == nil then
            ---@type UICompetitionPanel_Type4Template
            temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICompetitionPanel_Type4Template, self)
            self.mTypeFourTemp[go] = temp
        end
        return temp
    elseif type == luaEnumCompetitionType.Recycle then
        if self.mTypeFiveTemp == nil then
            ---@type table<UnityEngine.GameObject,UICompetitionPanel_Type5Template>
            self.mTypeFiveTemp = {}
        end
        local temp = self.mTypeFiveTemp[go]
        if temp == nil then
            ---@type UICompetitionPanel_Type5Template
            temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICompetitionPanel_Type5Template, self)
            self.mTypeFiveTemp[go] = temp
        end
        return temp
    end
end

function UICompetitionPanel:RefreshArrow()
    if self.NeedShowArrow then
        local state = self:GetScrollView():GetScrollViewSoftState(false)
        local numState = Utility.EnumToInt(state)
        self:GetUpArrow_GameObject():SetActive(numState ~= 1)
        self:GetArrow_GameObject():SetActive(numState ~= 3)
        self:GetUpArrowTween():PlayTween()
        self:GetDownArrowTween():PlayTween()
    else
        self:GetUpArrow_GameObject():SetActive(false)
        self:GetArrow_GameObject():SetActive(false)
    end
end

--endregion

function update()
    if UICompetitionPanel.mUpdateOpenActivityRedPointSign ~= nil then
        if UICompetitionPanel.mUpdateOpenActivityRedPointSign > 0 then
            UICompetitionPanel.mUpdateOpenActivityRedPointSign = UICompetitionPanel.mUpdateOpenActivityRedPointSign - 1
        else
            UICompetitionPanel:CallOpenActivityRedPoint()
            UICompetitionPanel.mUpdateOpenActivityRedPointSign = nil
        end
    end
    if UICompetitionPanel.mReReqOpenActivitymsg == true then
        UICompetitionPanel.mReReqOpenActivitymsg = nil
        if UICompetitionPanel.mCurrentType then
            networkRequest.ReqOpenPanel(UICompetitionPanel.mCurrentType)
        end
    end
end

--region 类型3首爆
---首爆排序
---@param showList table<number,activityV2.ActivityDataInfo>
function UICompetitionPanel:SortFirstDropList(showList)
    local finishTbl = {}
    local unfinishTbl = {}
    local receivedTbl = {}
    for i = 1, #showList do
        local temp = showList[i]
        local state = self:GetActivityFinishState(temp)
        if state == 0 then
            table.insert(unfinishTbl, temp)
        elseif state == 1 then
            table.insert(finishTbl, temp)
        else
            table.insert(receivedTbl, temp)
        end
    end
    local finalTbl = {}
    self:AddTbl(finalTbl, finishTbl)
    self:AddTbl(finalTbl, unfinishTbl)
    self:AddTbl(finalTbl, receivedTbl)
    return finalTbl
end
--endregion

--region 类型5回收
---背包缓存数据改变
function UICompetitionPanel:OnBagItemChange()
    self.showList = self:SortRecycleList(self.showList)
    self:RefreshLoopScrollViewByTableInfo(self:GetTypeFive_UIGridContainer(), luaEnumCompetitionType.Recycle)
end

function UICompetitionPanel:SortRecycleList(showList)
    local finishTbl = {}
    local unfinishTbl = {}
    local receivedTbl = {}
    for i = 1, #showList do
        local temp = showList[i]
        local state = self:GetRecycleItemState(temp)
        if state == 0 then
            table.insert(unfinishTbl, temp)
        elseif state == 1 then
            table.insert(finishTbl, temp)
        else
            table.insert(receivedTbl, temp)
        end
    end
    local finalTbl = {}
    self:AddTbl(finalTbl, finishTbl)
    self:AddTbl(finalTbl, unfinishTbl)
    self:AddTbl(finalTbl, receivedTbl)
    return finalTbl
end

function UICompetitionPanel:AddTbl(mainTbl, addTbl)
    if mainTbl == nil or addTbl == nil then
        return
    end
    for i = 1, #addTbl do
        table.insert(mainTbl, addTbl[i])
    end
end

---@return number 获取活动完成状态 0未完成（表示没领完且不可领） 1可领（表示有可领的） 2已完成（表示全部领完）3没有剩余了
---@param info activityV2.ActivityDataInfo
function UICompetitionPanel:GetRecycleItemState(info)
    if info == nil or info.roleGoalInfo == nil then
        return 0
    end
    if info.roleGoalInfo.rewardState == 2 then
        return 2
    end
    if info.leftCount <= 0 then
        return 3
    end
    local res, commmonInfo = CS.Cfg_Activity_CommonTableManager.Instance.dic:TryGetValue(info.activityId)
    if res then
        local goalIds = commmonInfo.goalIds
        if goalIds and goalIds.list and goalIds.list.Count > 0 then
            local goalId = goalIds.list[0]
            local res1, goalInfo = CS.Cfg_ActivityGoalsTableManager.Instance.dic:TryGetValue(goalId)
            if res1 then
                local aims = goalInfo.goalParam
                local state = gameMgr:GetPlayerDataMgr():GetCompetitionDataMgr():HasRecycleItemInBag(aims)
                return state == true and 1 or 0
            end
        end
    end
end

---刷新每个子节点按钮状态
function UICompetitionPanel:RefreshType5BtnState()
    if self.mTypeFiveTemp then
        for k, v in pairs(self.mTypeFiveTemp) do
            local template = v
            if template then
                template:RefreshBtnState()
            end
        end
    end
end

---@return number 回收跳转行
function UICompetitionPanel:GetRecycleJumpLine(showList)
    for i = 1, #showList do
        ---@type activityV2.ActivityDataInfo
        local info = showList[i]
        if uiStaticParameter.mCompetitionRecycleRedPointActivityId == -1 then
            if info.leftCount > 0 then
                return i
            end
        else
            if info.activityId == uiStaticParameter.mCompetitionRecycleRedPointActivityId then
                return i
            end
        end
    end
    return -1
end
--endregion

--region 特效获取
---@return table<number,table<number,number>>
function UICompetitionPanel:GetActivityEffect(activityId)
    if self.mActivityIdToEffectData == nil then
        self.mActivityIdToEffectData = {}
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22376)
        if res then
            local strs = string.Split(info.value, '&')
            for i = 1, #strs do
                local str = string.Split(strs[i], '#')
                if #str > 1 then
                    local id = tonumber(str[1])
                    self.mActivityIdToEffectData[id] = str
                end
            end
        end
    end
    return self.mActivityIdToEffectData[activityId]
end
--endregion

--region ondestroy
function ondestroy()
    UICompetitionPanel:GetScrollView().onDragFinished = nil
end
--endregion

return UICompetitionPanel