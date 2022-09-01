---@class UILeagueNpcPanel:UIBase 跨服联盟NPC界面
local UILeagueNpcPanel = {}

local CheckNullFunction = CS.StaticUtility.IsNull

---@type uniteunionV2.UniteUnionInfo 单个联盟数据
UILeagueNpcPanel.mSingleLeagueData = nil

--region 数据
---@return CSMainPlayerInfo 玩家数据
function UILeagueNpcPanel:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSUnionInfoV2 行会数据
function UILeagueNpcPanel:GetUnionInfoV2()
    if self.mUnionInfo == nil and self:GetPlayerInfo() then
        self.mUnionInfo = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfo
end

--endregion

--region 组件
---@return UILabel 联盟名称
function UILeagueNpcPanel:GetLeagueName_UILabel()
    if self.mLeagueName == nil then
        self.mLeagueName = self:GetCurComp("WidgetRoot/view/LeagueInfo/name", "UILabel")
    end
    return self.mLeagueName
end

---@return UILabel 联盟繁荣
function UILeagueNpcPanel:GetLeagueProsperity_UILabel()
    if self.mLeagueProsperity == nil then
        self.mLeagueProsperity = self:GetCurComp("WidgetRoot/view/LeagueInfo/prosperity", "UILabel")
    end
    return self.mLeagueProsperity
end

---@return UILabel 联盟介绍
function UILeagueNpcPanel:GetLeagueDetails_UILabel()
    if self.mLeagueDetails == nil then
        self.mLeagueDetails = self:GetCurComp("WidgetRoot/view/LeagueInfo/details", "UILabel")
    end
    return self.mLeagueDetails
end

---@return UISprite 联盟Icon
function UILeagueNpcPanel:GetLeagueProsperity_UISprite()
    if self.mLeagueIcon == nil then
        self.mLeagueIcon = self:GetCurComp("WidgetRoot/view/LeagueInfo/icon", "UISprite")
    end
    return self.mLeagueIcon
end

---@return UILoopScrollViewPlus 盟主
function UILeagueNpcPanel:GetLeagueLeaders_UILoopScrollViewPlus()
    if self.mLeagueLeadersLoop == nil then
        self.mLeagueLeadersLoop = self:GetCurComp("WidgetRoot/view/Leader/ScrollView/Content", "UILoopScrollViewPlus")
    end
    return self.mLeagueLeadersLoop
end

---@return UnityEngine.GameObject 加入联盟按钮
function UILeagueNpcPanel:GetEnterLeagueBtn_Go()
    if self.mEnterBtn == nil then
        self.mEnterBtn = self:GetCurComp("WidgetRoot/view/EnterBtn", "GameObject")
    end
    return self.mEnterBtn
end

---@return UILabel 进入按钮文本
function UILeagueNpcPanel:GetEnterLeagueBtn_UILabel()
    if self.mEnterBtnLb == nil then
        self.mEnterBtnLb = self:GetCurComp("WidgetRoot/view/EnterBtn/Label", "UILabel")
    end
    return self.mEnterBtnLb
end

---@return UnityEngine.GameObject 帮助按钮
function UILeagueNpcPanel:GetHelpBtn_Go()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/view/btn_help", "GameObject")
    end
    return self.mHelpBtn
end

---@return UnityEngine.GameObject 关闭按钮
function UILeagueNpcPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UIScrollView
function UILeagueNpcPanel:GetScrollView_UIScrollView()
    if self.mScr == nil then
        self.mScr = self:GetCurComp("WidgetRoot/view/Leader/ScrollView", "UIScrollView")
    end
    return self.mScr
end

---@return UIPanel
function UILeagueNpcPanel:GetScrollView_UIPanel()
    if self.mScrUIPanel == nil then
        self.mScrUIPanel = self:GetCurComp("WidgetRoot/view/Leader/ScrollView", "UIPanel")
    end
    return self.mScrUIPanel
end

---@return UnityEngine.GameObject 提示箭头
function UILeagueNpcPanel:GetArrow_GameObject()
    if self.mArrowObj == nil then
        self.mArrowObj = self:GetCurComp("WidgetRoot/view/Leader/DownArrow", "GameObject")
    end
    return self.mArrowObj
end

---@return TweenAlpha 提示箭头动画
function UILeagueNpcPanel:GetDownArrowTween()
    if self.mDownArrowTween == nil then
        self.mDownArrowTween = self:GetCurComp("WidgetRoot/view/Leader/DownArrow", "TweenAlpha")
    end
    return self.mDownArrowTween
end

---@return UnityEngine.GameObject 提示箭头
function UILeagueNpcPanel:GetUpArrow_GameObject()
    if self.mUpArrowObj == nil then
        self.mUpArrowObj = self:GetCurComp("WidgetRoot/view/Leader/UpArrow", "GameObject")
    end
    return self.mUpArrowObj
end

---@return TweenAlpha 提示箭头动画
function UILeagueNpcPanel:GetUpArrowTween()
    if self.mUpArrowTween == nil then
        self.mUpArrowTween = self:GetCurComp("WidgetRoot/view/Leader/UpArrow", "TweenAlpha")
    end
    return self.mUpArrowTween
end

---@return UnityEngine.GameObject 没有行会
function UILeagueNpcPanel:GetNoUnion_Go()
    if self.mNoUnionGo == nil then
        self.mNoUnionGo = self:GetCurComp("WidgetRoot/view/NoUnion", "GameObject")
    end
    return self.mNoUnionGo
end

---@return UnityEngine.GameObject 没有联盟
function UILeagueNpcPanel:GetNoLeague_Go()
    if self.mNoLeagueGo == nil then
        self.mNoLeagueGo = self:GetCurComp("WidgetRoot/view/NoLeague", "GameObject")
    end
    return self.mNoLeagueGo
end
--endregion

--region 初始化
function UILeagueNpcPanel:Init()
    self:BindEvents()
    self:BindMessage()
end

function UILeagueNpcPanel:Show(info)
    if info == nil then
        info = 1
    end

    if info then
        self.mLeagueType = info
        networkRequest.ReqOneUniteUnion(info)
        self:RefreshLeagueInfo()
    end
end

function UILeagueNpcPanel:BindEvents()
    if CheckNullFunction(self:GetEnterLeagueBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetEnterLeagueBtn_Go()).onClick = function(go)
            self:OnEnterLeagueBtnClicked(go)
        end
    end
    if CheckNullFunction(self:GetHelpBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetHelpBtn_Go()).onClick = function(go)
            Utility.ShowHelpPanel({ id = 174 })
        end
    end
    if CheckNullFunction(self:GetCloseBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function(go)
            self:ClosePanel()
        end
    end
    self:GetScrollView_UIScrollView().onDragFinished = function()
        self:RefreshArrow()
    end
end

function UILeagueNpcPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneUniteUnionMessage, function(msgId, tblData)
        self:RefreshLeague(tblData)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.PlayerLeagueInfoChange, function()
        self:RefreshBtnData()
    end)
end
--endregion

--region 服务器消息处理
---@param tblData uniteunionV2.UniteUnionInfo 单个同盟信息
function UILeagueNpcPanel:RefreshLeague(tblData)
    self.mSingleLeagueData = tblData
    if tblData then
        self:RefreshBtnData()
        local allLeagueData, allProsperity = self:DealData(tblData.members)
        self:RefreshLeagueLeaders(allLeagueData)
        if CheckNullFunction(self:GetLeagueProsperity_UILabel()) == false then
            self:GetLeagueProsperity_UILabel().text = "(总繁荣  " .. allProsperity .. ")"
        end
    end
end

---self:IsSelfHasLeague()的数据刷新不在联盟npc里面，所以在变动时候需要单独刷新
function UILeagueNpcPanel:RefreshBtnData()
    local canEnter = self:CanShowEnterLeagueBtn()
    self:GetEnterLeagueBtn_Go():SetActive(canEnter)
    self:GetEnterLeagueBtn_UILabel().text = self:IsSelfHasLeague() and "退出联盟" or "加入联盟"
    self:SuitScrollView()
end

---界面适配
function UILeagueNpcPanel:SuitScrollView()
    local isManager = self:GetUnionInfoV2():IsUnionManager(LuaEnumGuildPosType.President) and self:GetUnionInfoV2().UnionID ~= 0
    self:GetNoLeague_Go():SetActive(not self:IsSelfHasLeague() and self:HasUnion() and not isManager)
    self:GetNoUnion_Go():SetActive(not self:HasUnion())
    local canEnter = self:CanShowEnterLeagueBtn() or (not self:IsSelfHasLeague()) or (not self:HasUnion())
    local pos = self:GetScrollView_UIScrollView().gameObject.transform.localPosition
    pos.y = canEnter and -32 or -72
    local baseClipRegion = self:GetScrollView_UIPanel().baseClipRegion
    baseClipRegion.w = canEnter and 366 or 446
    self:GetScrollView_UIPanel().baseClipRegion = baseClipRegion
    self:GetScrollView_UIScrollView().gameObject.transform.localPosition = pos
end

function UILeagueNpcPanel:HasUnion()
    if self:GetPlayerInfo() then
        return self:GetPlayerInfo().UnionInfoV2.UnionID ~= 0
    end
    return false
end


---@class CustomLeadersInfo
---@field LeaderName string 名字
---@field UnionName string 行会名
---@field HostId XLua.Cast.Int32 平台serverId*1000+platId
---@field IsLeader boolean 是否是盟主


---@class CustomUnionInfo
---@field UnionName string 行会名
---@field UnionActive string 行会繁荣
---@field HostId XLua.Cast.Int32 平台serverId*1000+platId

---@class CustomLeagueShow
---@field type number 标题0/会长1/行会2
---@field CustomLeadersInfo CustomLeadersInfo 会长信息
---@field CustomUnionInfo CustomUnionInfo 行会信息
---@field Title string 标题名字

---@param members table<number, uniteunionV2.UniteUnionMember> 同盟成员
---@return table<number,CustomLeadersInfo>,number 返回副盟主列表,行会繁荣度
function UILeagueNpcPanel:DealData(members)
    --临时副盟主数据
    local LeadersList = {}
    --临时行会数据
    local UnionList = {}
    ---@type table<number,CustomLeagueShow> 所有要显示的数据
    local AllLeagueShow = {}
    --临时盟主数据
    local leaderInfo
    local allProsperity = 0--联盟总繁荣
    if members then
        for i = 1, #members do
            --一个行会的数据
            ---@type uniteunionV2.UniteUnionMember
            local union = members[i]
            local unionName = union.unionName
            local unionHost = luaclass.RemoteHostDataClass:GetLianFuPrefixNameByHostId(union.hostId)

            --添加会长数据
            ---@type CustomLeadersInfo
            local customLeadersInfo = {}
            customLeadersInfo.UnionName = unionName
            customLeadersInfo.HostId = unionHost
            customLeadersInfo.LeaderName = union.unionLeader.name

            if union.unionLeaderPosition == 1 then
                customLeadersInfo.IsLeader = true
                leaderInfo = customLeadersInfo
            else
                table.insert(LeadersList, customLeadersInfo)
            end
            --添加副会长数据
            local viceLeaders = union.leaderSecond
            if viceLeaders then
                for j = 1, #viceLeaders do
                    local viceLeaderInfo = viceLeaders[j]
                    ---@type CustomLeadersInfo
                    local customLeadersInfo = {}
                    customLeadersInfo.UnionName = unionName
                    customLeadersInfo.HostId = unionHost
                    customLeadersInfo.LeaderName = viceLeaderInfo.name
                    table.insert(LeadersList, customLeadersInfo)
                end
            end
            --添加行会数据
            ---@type CustomUnionInfo
            local unionInfo = {}
            unionInfo.UnionName = unionName
            unionInfo.UnionActive = union.unionActive
            unionInfo.HostId = unionHost
            table.insert(UnionList, unionInfo)
            allProsperity = allProsperity + union.unionActive
        end

        ------开始整理数据------
        ---添加标题
        ---@type CustomLeagueShow
        local addTitleData1 = {}
        addTitleData1.type = 0
        addTitleData1.Title = "联盟领袖"
        table.insert(AllLeagueShow, addTitleData1)

        ---添加盟主
        ---@type CustomLeagueShow
        local addLeaderInfo = {}
        addLeaderInfo.type = 1
        addLeaderInfo.CustomLeadersInfo = leaderInfo
        table.insert(AllLeagueShow, addLeaderInfo)

        ---添加副盟主
        for i = 1, #LeadersList do
            ---@type CustomLeagueShow
            local addViceLeaderInfo = {}
            addViceLeaderInfo.type = 1
            addViceLeaderInfo.CustomLeadersInfo = LeadersList[i]
            table.insert(AllLeagueShow, addViceLeaderInfo)
        end

        ---添加标题
        local addTitleData2 = {}
        addTitleData2.type = 0
        addTitleData2.Title = "联盟行会"
        table.insert(AllLeagueShow, addTitleData2)

        ---添加行会数据
        for j = 1, #UnionList do
            ---@type CustomLeagueShow
            local addUnionData = {}
            addUnionData.type = 2
            addUnionData.CustomUnionInfo = UnionList[j]
            table.insert(AllLeagueShow, addUnionData)
        end
    end
    return AllLeagueShow, allProsperity
end

--endregion

--region UI事件

---刷新盟主信息
function UILeagueNpcPanel:RefreshLeagueLeaders(allLeagueData)
    if CheckNullFunction(self:GetLeagueLeaders_UILoopScrollViewPlus()) == false then
        self:GetLeagueLeaders_UILoopScrollViewPlus():Init(function(go, line)
            if line < #allLeagueData then
                self:RefreshLeader(allLeagueData[line + 1], go)
                return true
            else
                return false
            end
        end, nil)
    end
    local showBtn = self:CanShowEnterLeagueBtn()

    local maxNum = showBtn and 8 or 10
    local canMove = #allLeagueData > maxNum
    local pos = self:GetArrow_GameObject().transform.localPosition
    pos.y = showBtn and -230 or -314
    self:GetArrow_GameObject().transform.localPosition = pos
    self:RefreshArrow(canMove)
end

---刷新单个盟主信息
function UILeagueNpcPanel:RefreshLeader(data, go)
    local template = self:GetLeadersTemplate(go)
    if template then
        template:RefreshLeader(data)
    end
end

---@return UILeagueNpcPanel_LeaderTemplate 盟主模板
function UILeagueNpcPanel:GetLeadersTemplate(go)
    if CheckNullFunction(go) then
        return
    end
    if self.mGoToLeaderTemplate == nil then
        self.mGoToLeaderTemplate = {}
    end
    local template = self.mGoToLeaderTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UILeagueNpcPanel_LeaderTemplate)
        self.mGoToLeaderTemplate[go] = template
    end
    return template
end

---请求加入联盟
function UILeagueNpcPanel:OnEnterLeagueBtnClicked(go)
    local CD = LuaGlobalTableDeal:GetQuitLeagueCD()

    local customData = {}
    if self:IsSelfHasLeague() then
        local id = 131
        customData.id = id
        if self.mExitLeagueStr == nil then
            local promptInfo = self:CachePromptWordData(id)
            if promptInfo and CD > 0 then
                self.mExitLeagueStr = string.format(promptInfo.des, CD)
            end
        end
        customData.str = self.mExitLeagueStr
        customData.Callback = function()
            networkRequest.ReqApplyExitUniteUnion(self.mLeagueType)
            networkRequest.ReqOneUniteUnion(self.mLeagueType)
        end
    else
        if CD > 0 and self.mSingleLeagueData then
            local exitTime = self.mSingleLeagueData.selfUnionExitTimeS * 1000
            local currentTime = CS.CSServerTime.Instance.TotalMillisecond
            if exitTime and exitTime ~= 0 then
                local time = currentTime - exitTime
                if time < CD * 60 * 60 * 1000 then
                    local info = self:CachePromptFrameData(410)
                    if info then
                        local desTime = CD * 60 * 60 * 1000 - time
                        local hour, minute, second = Utility.MillisecondToFormatTime(desTime)
                        local str = string.format(info.content, Utility.GetIntPart(hour) .. ":" .. Utility.GetIntPart(minute) .. ":" .. Utility.GetMaxIntPart(second))
                        Utility.ShowPopoTips(go, str, 25)
                    end
                    return
                end
            end
        end
        local id = 130
        customData.id = id
        if self.mJoinLeagueStr == nil then
            local promptInfo = self:CachePromptWordData(id)
            local leagueInfo = self:GetCurrentLeagueBasicInfo()
            if promptInfo and leagueInfo then
                self.mJoinLeagueStr = string.format(promptInfo.des, leagueInfo:GetName())
            end
        end
        customData.str = self.mJoinLeagueStr
        customData.Callback = function()
            networkRequest.ReqApplyJoinUniteUnion(self.mLeagueType)
        end
    end
    Utility.ShowPromptTipsPanel(customData)
end

---@return boolean 是否有联盟
function UILeagueNpcPanel:IsSelfHasLeague()
    return gameMgr:GetPlayerDataMgr():GetLeagueInfo():IsMainPlayerInLeague()
end

---@return boolean 是否可以加入联盟
function UILeagueNpcPanel:CanShowEnterLeagueBtn()
    ---会长
    local isManager = self:GetUnionInfoV2():IsUnionManager(LuaEnumGuildPosType.President) and self:GetUnionInfoV2().UnionID ~= 0
    if not isManager then
        return false
    end

    ---联盟已满
    local LeagueFull = false
    local LeagueMaxNum = LuaGlobalTableDeal:GetPerLeagueMaxUnionNum()
    if LeagueMaxNum and self.mSingleLeagueData and self.mSingleLeagueData.members then
        local num = #self.mSingleLeagueData.members
        LeagueFull = num >= LeagueMaxNum
    end

    ---可加入（联盟行会共存规则，服务器发送）
    local canJoin = true
    if self.mSingleLeagueData and self.mSingleLeagueData.canJoin then
        canJoin = self.mSingleLeagueData.canJoin == 1
        if self.mSingleLeagueData.selfUnionExitTimeS > 0 then
            canJoin = true
        end
    end

    ---有联盟且是同一个联盟显示/都显示
    local needShow = true
    if self:IsSelfHasLeague() then
        needShow = self.mLeagueType == gameMgr:GetPlayerDataMgr():GetLeagueInfo():GetLeagueType()
        if needShow then
            return needShow
        end
    end
    --[[
    print("canJoin", canJoin)
    print("isManager", isManager)
    print("LeagueFull", LeagueFull)
    print("needShow", needShow)
    canJoin = true
    isManager = true
    needShow = true
    --]]
    return canJoin and isManager and not LeagueFull and needShow
end

---@return TABLE.CFG_PROMPTFRAME 气泡表
function UILeagueNpcPanel:CachePromptFrameData(id)
    if self.mIdToPromptFrameData == nil then
        self.mIdToPromptFrameData = {}
    end
    local info = self.mIdToPromptFrameData[id]
    if info == nil then
        ___, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(id)
        self.mIdToPromptFrameData[id] = info
    end
    return info
end

---@return TABLE.CFG_PROMPTWORD 弹窗表
function UILeagueNpcPanel:CachePromptWordData(id)
    if self.mIdToPromptWordData == nil then
        self.mIdToPromptWordData = {}
    end
    local info = self.mIdToPromptWordData[id]
    if info == nil then
        ___, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(id)
        self.mIdToPromptWordData[id] = info
    end
    return info
end
--endregion

--region 获取联盟基本信息
---刷新联盟基本显示
function UILeagueNpcPanel:RefreshLeagueInfo()
    local LeagueInfo = self:GetCurrentLeagueBasicInfo()
    if LeagueInfo == nil then
        return
    end

    if CheckNullFunction(self:GetLeagueName_UILabel()) == false then
        self:GetLeagueName_UILabel().text = LeagueInfo:GetName()
    end

    if CheckNullFunction(self:GetLeagueDetails_UILabel()) == false then
        self:GetLeagueDetails_UILabel().text = LeagueInfo:GetDes()
    end

    if CheckNullFunction(self:GetLeagueProsperity_UISprite()) == false then
        self:GetLeagueProsperity_UISprite().spriteName = LeagueInfo:GetIcon()
    end
end

---@return TABLE.cfg_league 联盟基础数据
function UILeagueNpcPanel:GetCurrentLeagueBasicInfo()
    if self.mLeagueInfo == nil then
        self.mLeagueInfo = clientTableManager.cfg_leagueManager:TryGetValue(self.mLeagueType)
    end
    return self.mLeagueInfo
end

--endregion

--region  提示箭头
function UILeagueNpcPanel:RefreshArrow(canMove)
    if canMove or canMove == nil then
        local state = self:GetScrollView_UIScrollView():GetScrollViewSoftState(false)
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

return UILeagueNpcPanel