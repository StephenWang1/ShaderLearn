---@class UIGuildelEctionsPanel:UIBase 帮会选举界面
local UIGuildelEctionsPanel = {}

local Utility = Utility

UIGuildelEctionsPanel.mScrollStartPosY = 59

---投票界面y轴偏移
UIGuildelEctionsPanel.mPosYOffset = -15



--region 局部变量定义
---竞选格子对应模板
---@type table<UnityEngine.GameObject,UIGuildelEctionsGridTemplate>
UIGuildelEctionsPanel.mGoToTemplate = nil

---当前选中lid
UIGuildelEctionsPanel.mCurrentChooseLid = nil

---存储Scroll初始位置
UIGuildelEctionsPanel.mScrollStartPos = nil

---@type number
---当前Scroll适配的行数
UIGuildelEctionsPanel.mCurrentSuitLine = nil
--endregion

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIGuildelEctionsPanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UIScrollView 竞选Scroll
function UIGuildelEctionsPanel:GetElectionScrollView()
    if self.mElectionScroll == nil then
        self.mElectionScroll = self:GetCurComp("WidgetRoot/view/Scroll View", "UIScrollView")
    end
    return self.mElectionScroll
end

---@return SpringPanel 竞选ScrollSpring
function UIGuildelEctionsPanel:GetElectionSpringPanel()
    if (self.mSpringPanel == nil) then
        self.mSpringPanel = self:GetCurComp("WidgetRoot/view/Scroll View", "SpringPanel");
    end
    return self.mSpringPanel;
end

---@return UIGridContainer 竞选列表container
function UIGuildelEctionsPanel:GetEctionsList_UIGridContainer()
    if self.mEctionsContainer == nil then
        self.mEctionsContainer = self:GetCurComp("WidgetRoot/view/Scroll View/player", "Top_UIGridContainer")
    end
    return self.mEctionsContainer
end

---@return UICountdownLabel 竞选倒计时
function UIGuildelEctionsPanel:GetTimeCountDown_UICountdownLabel()
    if self.mTimeCountDown == nil then
        self.mTimeCountDown = self:GetCurComp("WidgetRoot/view/lb_time", "UICountdownLabel")
    end
    return self.mTimeCountDown
end

---@return UnityEngine.GameObject 竞选按钮
function UIGuildelEctionsPanel:GetEctionsBtn_GameObject()
    if self.mEctionsBtn == nil then
        self.mEctionsBtn = self:GetCurComp("WidgetRoot/events/btn_ections", "GameObject")
    end
    return self.mEctionsBtn
end

---@return UnityEngine.GameObject 竞选中描述
function UIGuildelEctionsPanel:GetElectionDes_GameObject()
    if self.mElectionDes == nil then
        self.mElectionDes = self:GetCurComp("WidgetRoot/events/electionDes", "GameObject")
    end
    return self.mElectionDes
end

---@return UILabel 竞选消费
function UIGuildelEctionsPanel:GetElectionCost_UILabel()
    if self.mElectionCostLb == nil then
        self.mElectionCostLb = self:GetCurComp("WidgetRoot/view/Costgold", "UILabel")
    end
    return self.mElectionCostLb
end

---@return UISprite 竞选消费Icon
function UIGuildelEctionsPanel:GetElectionCost_UISprite()
    if self.mElectionCostSp == nil then
        self.mElectionCostSp = self:GetCurComp("WidgetRoot/view/Costgold/icon", "UISprite")
    end
    return self.mElectionCostSp
end

---@return UnityEngine.GameObject 帮助按钮
function UIGuildelEctionsPanel:GetHelpBtn_GameObject()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/events/btn_description", "GameObject")
    end
    return self.mHelpBtn
end
--endregion

--region 属性
---@return CSMainPlayerInfo 玩家信息
function UIGuildelEctionsPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2 帮会信息
function UIGuildelEctionsPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil then
        if self:GetPlayerInfo() then
            self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mUnionInfoV2
end

---@return CSBagInfoV2 背包信息
function UIGuildelEctionsPanel:GetBagInfoV2()
    if self.mBagInfo == nil then
        if self:GetPlayerInfo() then
            self.mBagInfo = self:GetPlayerInfo().BagInfo
        end
    end
    return self.mBagInfo
end


--endregion

--region 初始化
function UIGuildelEctionsPanel:Init()
    self:BindEvents()
    self:BindMessage()
end

function UIGuildelEctionsPanel:Show()
    networkRequest.ReqGetPlayerUnionInfo()
    self:RefreshEctionsCost()
    self.mScrollStartPos = self:GetElectionScrollView().transform.localPosition
end

function UIGuildelEctionsPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).onClick = function()
        self:ShowHelpDes()
    end
    CS.UIEventListener.Get(self:GetEctionsBtn_GameObject()).onClick = function(go)
        self:OnEctionsBtnClicked(go)
    end
end

function UIGuildelEctionsPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionInfoChange, function()
        self:RefreshPanelInfo()
    end)
end

--endregion

--region 服务器消息
---竞选界面信息
function UIGuildelEctionsPanel:RefreshPanelInfo()
    self:RefreshEctionsList()
    self:RefreshTimeShow()
end
--endregion

--region UI事件
---刷新竞选消费
function UIGuildelEctionsPanel:RefreshEctionsCost()
    self:GetElectionCost_UILabel().text = self:GetEctionsCostCondition(1)
    if self:GetEctionsCostItemInfo() then
        self:GetElectionCost_UISprite().spriteName = self:GetEctionsCostItemInfo().icon
    end
end

---刷新竞选列表
function UIGuildelEctionsPanel:RefreshEctionsList()
    local mIsEctions = false
    local ectionsList = self:GetUnionInfoV2().EctionsList
    self:GetEctionsList_UIGridContainer().MaxCount = ectionsList.Count
    local line = 0
    local aimGo
    for i = 0, ectionsList.Count - 1 do
        ---@type unionV2.ElectionInfo
        local ections = ectionsList[i]
        local go = self:GetEctionsList_UIGridContainer().controlList[i]
        local template = self:GetTemplate(go)
        if template then
            local customData = {}
            customData.MemberInfo = ections
            customData.Index = i
            customData.OnVoteCallBack = function(go, lid)
                self:OnVoteClicked(go, lid)
            end
            template:RefreshInfo(customData, math.floor(i / 3) + 1)
            if ections.member.roleId == self.mCurrentChooseLid then
                line = math.floor(i / 3) + 1
                aimGo = template.go
                template.toggle_UIToggle:Set(true)
            else
                template.toggle_UIToggle:Set(false)
            end
        end
        --判断竞选
        if ections.member.roleId == self:GetPlayerInfo().ID then
            mIsEctions = true
        end
    end
    local maxLine = math.ceil(ectionsList.Count / 3)
    local cellHeight = self:GetEctionsList_UIGridContainer().CellHeight
    self:SuitScrollView(line, maxLine, cellHeight, aimGo)
    self:GetEctionsBtn_GameObject():SetActive(not mIsEctions)
    self:GetElectionDes_GameObject():SetActive(mIsEctions)
    self:GetElectionCost_UILabel().gameObject:SetActive(not mIsEctions)
end

---@return UIGuildelEctionsGridTemplate 获取模板
function UIGuildelEctionsPanel:GetTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildelEctionsGridTemplate, self)
    end
    return template
end

---点击投票
---@param playerInfo unionV2.UnionMemberInfo 投票玩家信息
function UIGuildelEctionsPanel:OnVoteClicked(go, lid)
    if lid and go then
        if not self:IsLevelCanVote() then
            Utility.ShowPopoTips(go, self:GetLevelNotEnoughDes(), 150)--%d级可投票
            return
        end

        if not self:IsVoteMoneyEnough() then
            Utility.ShowPopoTips(go, self:GetVoteMoneyNotEnoughDes(), 151)--帮会竞选投票时货币不足
            return
        end

        networkRequest.ReqElectionVote(lid)
    end
end

---刷新时间显示
---系统创建的帮会，首次结算时间为开服第4天的晚上7点
---其他情况下的结算时间，为首位参选玩家发起后的次日晚上7点
function UIGuildelEctionsPanel:RefreshTimeShow()
    local time = self:GetUnionInfoV2().UnionInfo.electionEndTime
    if time and time ~= 0 then
        self:GetTimeCountDown_UICountdownLabel().gameObject:SetActive(true)
        self:GetTimeCountDown_UICountdownLabel():StartCountDown(nil, 8, time, luaEnumColorType.TimeCountRed, "后投票结束", nil, nil)
    else
        self:GetTimeCountDown_UICountdownLabel().gameObject:SetActive(false)
    end
end

---点击竞选按钮
function UIGuildelEctionsPanel:OnEctionsBtnClicked(go)
    if not self:IsPrefixEnough() then
        Utility.ShowPopoTips(go, self:GetPrefixNotEnoughDes(), 152)--战勋达到%s后可竞选
        return
    end

    if not (self:GetUnionInfoV2() and self:GetUnionInfoV2():IsCanEctions()) then
        Utility.ShowPopoTips(go, self:GetTimeNotEnoughDes(), 170)--加入行会%d小时才能竞选
        return
    end

    if not self:IsMoneyEnough() then
        Utility.ShowPopoTips(go, self:GetCostNotEnoughDes(), 153)--帮会竞选参选时货币不足
        return
    end

    networkRequest.ReqJoinElection()
end

---显示帮助描述
function UIGuildelEctionsPanel:ShowHelpDes()
    if self:GetEctionsTipsInfo() then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, self:GetEctionsTipsInfo())
    end
end

---点击显示投票面板并存储选中信息
function UIGuildelEctionsPanel:ShowData(pos, lid, line)
    self:GetAuctionItemPanel(pos, lid)
    self:SaveCurrentChooseLid(lid, line)
end

---@return UIAuctionItemPanel
function UIGuildelEctionsPanel:GetAuctionItemPanel(pos, lid)
    local data = {}
    ---@type UIGuildelEctionsPanel_Vote
    data.Template = luaComponentTemplates.UIGuildelEctionsPanel_Vote
    data.VoteCost = self:GetVoteEctionsCost(1)
    data.VoteItemInfo = self:GetVoteItemInfo()
    data.VoteLid = lid
    uimanager:CreatePanel("UIAuctionItemPanel", function(panel)
        ---@type UIAuctionItemPanel
        self.mAuctionItemPanel = panel
        panel:SetAlpha(1)
        self:SetAimPos(panel, pos)
    end, data)
end

---@param panel UIAuctionItemPanel
function UIGuildelEctionsPanel:SetAimPos(panel, pos, jumpLine)
    if pos == nil or panel == nil or CS.StaticUtility.IsNull(panel.go) then
        return
    end

    local itemWidth = self:GetEctionsList_UIGridContainer().CellWidth
    local itemHeight = self:GetEctionsList_UIGridContainer().CellHeight
    local aimPos = self.go.transform:InverseTransformPoint(pos)
    local auctionItemPanelBg = panel.Template.bg_UISprite
    local height = auctionItemPanelBg.height
    local width = auctionItemPanelBg.width
    local offX = -54
    local offY = -20
    local pos = aimPos + CS.UnityEngine.Vector3((width / 2 + itemWidth / 2) + offX, (itemHeight - height) + offY, 0)
    if jumpLine then
        pos.y = jumpLine % 2 == 0 and 125 + offY or -33 + offY
    end
    pos.y = pos.y + self.mPosYOffset
    panel.go.transform.localPosition = pos
end

---位置适配
function UIGuildelEctionsPanel:SaveCurrentChooseLid(lid, line)
    self.mCurrentChooseLid = lid
end

---适配ScrollView位置
---@param line number 需要scroll滑动到第几行
---@param maxLine number 最大行数
---@param cellHeight number 每行高度
---@param aimGo UnityEngine.GameObject 目标位置
function UIGuildelEctionsPanel:SuitScrollView(line, maxLine, cellHeight, aimGo)
    local scrollPos = self:GetElectionScrollView().transform.localPosition
    local currentLine = math.ceil((scrollPos.y - self.mScrollStartPosY) / cellHeight) + 1
    if not (line == currentLine or line == currentLine + 1) then
        local index
        index = line >= maxLine and maxLine - 2 or line - 1;
        index = index < 0 and 0 or index;
        -- self:GetElectionScrollView():ResetPosition()
        local addY = index * cellHeight;
        local pos = self.mScrollStartPos;
        local targetPos = CS.UnityEngine.Vector3(pos.x, pos.y + addY, pos.z);
        if not CS.StaticUtility.IsNull(self:GetElectionScrollView()) then
            self:GetElectionScrollView():Begin(targetPos, 10)
        end
    end
    local jumpLine = nil
    if not (line == currentLine or line == currentLine + 1) then
        jumpLine = line == maxLine and 1 or 0
    end

    if not CS.StaticUtility.IsNull(aimGo) then
        local pos = aimGo.transform.position
        self:SetAimPos(self.mAuctionItemPanel, pos, jumpLine)
    end
end
--endregion

function update()
    if UIGuildelEctionsPanel.lastTime and CS.UnityEngine.Time.time - UIGuildelEctionsPanel.lastTime > 0.04 and UIGuildelEctionsPanel.mAimGo then
        UIGuildelEctionsPanel:SetAimPos(UIGuildelEctionsPanel.mAuctionItemPanel, UIGuildelEctionsPanel.mAimGo.transform.position)
        UIGuildelEctionsPanel.lastTime = nil
    end
end

--region数据
--region 投票

---@return number 投票花费条件
---@param type number 类型 0 货币id 1 货币数目
function UIGuildelEctionsPanel:GetVoteEctionsCost(type)
    if self.mVoteCost == nil then
        self.mVoteCost = CS.Cfg_GlobalTableManager.Instance:VoteEctionsCost()
    end
    if self.mVoteCost and self.mVoteCost.Length >= 2 then
        return self.mVoteCost[type]
    end
    return 0
end

---@return TABLE.CFG_ITEMS 投票道具item信息
function UIGuildelEctionsPanel:GetVoteItemInfo()
    if self.mVoteItemInfo == nil then
        ___, self.mVoteItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self:GetVoteEctionsCost(0))
    end
    return self.mVoteItemInfo
end

---@return boolean 玩家投票货币是否足够
function UIGuildelEctionsPanel:IsVoteMoneyEnough()
    if self:GetBagInfoV2() then
        local costID = self:GetVoteEctionsCost(0)
        local costNum = self:GetVoteEctionsCost(1)
        local playerHas = self:GetBagInfoV2():GetCoinAmount(costID)
        --if res then
        return playerHas >= costNum
        --end
    end
    return false
end

---@return string 玩家投票货币不够描述
function UIGuildelEctionsPanel:GetVoteMoneyNotEnoughDes()
    if self.mVoteMoneyDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(151)
        if res and self:GetVoteItemInfo() then
            self.mVoteMoneyDes = string.format(desInfo.content, self:GetVoteItemInfo().name)
        end
    end
    return self.mVoteMoneyDes
end

---@return boolean 等级是否足够投票
function UIGuildelEctionsPanel:IsLevelCanVote()
    local mLevelLimit = CS.Cfg_GlobalTableManager.Instance:VoteEctionsLevelLimit()
    local playerLevel = self:GetPlayerInfo().Level
    return playerLevel >= mLevelLimit
end

---@return string 等级是否足够投票
function UIGuildelEctionsPanel:GetLevelNotEnoughDes()
    if self.mVoteLevelDes == nil then
        local mLevelLimit = CS.Cfg_GlobalTableManager.Instance:VoteEctionsLevelLimit()
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(150)
        if res then
            self.mVoteLevelDes = string.format(desInfo.content, mLevelLimit)
        end
    end
    return self.mVoteLevelDes
end
--endregion

--region 竞选
---@return TABLE.CFG_DESCRIPTION 竞选Tips
function UIGuildelEctionsPanel:GetEctionsTipsInfo()
    if self.mEctionsTipsInfo == nil then
        ___, self.mEctionsTipsInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(111)
    end
    return self.mEctionsTipsInfo
end

---@return TABLE.CFG_ITEMS 竞选消耗道具信息
function UIGuildelEctionsPanel:GetEctionsCostItemInfo()
    local id = self:GetEctionsCostCondition(0)
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    if res then
        return itemInfo
    end
end

---@param type number 条件类型 1 战勋 0 入会时间
---@return number 竞选条件
function UIGuildelEctionsPanel:GetEctionsCondition(type)
    if self.mEctionsCondition == nil then
        self.mEctionsCondition = CS.Cfg_GlobalTableManager.Instance:EctionsCondition()
    end
    if type and self.mEctionsCondition and self.mEctionsCondition.Length >= 2 then
        return self.mEctionsCondition[type]
    end
    return 0
end

---@return boolean 功勋等级是否足够
function UIGuildelEctionsPanel:IsPrefixEnough()
    if self:GetPlayerInfo() then
        --  local playerPrefix = self:GetPlayerInfo().PrefixId
        local conditionid = self:GetEctionsCondition(1)
        return Utility.IsMainPlayerMatchCondition(conditionid).success
    end
    return false
end

---@param type number 类型 0 id 1 数目
---@return number 竞选消耗货币Id 或者货币数目
function UIGuildelEctionsPanel:GetEctionsCostCondition(type)
    if self.mCostCondition == nil then
        self.mCostCondition = CS.Cfg_GlobalTableManager.Instance:EctionsCostCondition()
    end
    if type and self.mCostCondition and self.mCostCondition.Length >= 2 then
        return self.mCostCondition[type]
    end
    return 0
end

---@return boolean 道具是否足够
function UIGuildelEctionsPanel:IsMoneyEnough()
    if self:GetBagInfoV2() then
        local costID = self:GetEctionsCostCondition(0)
        local costNum = self:GetEctionsCostCondition(1)
        local playerHas = self:GetBagInfoV2():GetCoinAmount(costID)
        --if res then
        return playerHas >= costNum
        --end
    end
    return false
end

---@return string 获取战勋不足描述
function UIGuildelEctionsPanel:GetPrefixNotEnoughDes()
    if self.mPrefixDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(152)
        if res then
            local conditionid = self:GetEctionsCondition(1)
            local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(conditionid)
            if conditionTbl and conditionTbl:GetConditionParam() and conditionTbl:GetConditionParam().list.Count > 0 then
                self.mPrefixDes = string.format(desInfo.content, conditionTbl:GetConditionParam().list[0])
            end
            --local playerCareer = self:GetPlayerInfo().Career
            --local showInfo = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(conditionid, playerCareer)
        end
    end
    return self.mPrefixDes
end

---@return string  竞选入会时间不足描述
function UIGuildelEctionsPanel:GetTimeNotEnoughDes()
    if self.mTimeDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(170)
        if res then
            local condition = self:GetEctionsCondition(0)
            self.mTimeDes = string.format(desInfo.content, condition)
        end
    end
    return self.mTimeDes
end

---@return string 竞选货币不足描述
function UIGuildelEctionsPanel:GetCostNotEnoughDes()
    if self.mCostDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(153)
        if res and self:GetEctionsCostItemInfo() then
            self.mCostDes = string.format(desInfo.content, self:GetEctionsCostItemInfo().name)
        end
    end
    return self.mCostDes
end
--endregion
--endregion

function ondestroy()
    networkRequest.ReqGetUnionJournal(UIGuildelEctionsPanel:GetUnionInfoV2().UnionID)
    uimanager:ClosePanel("UIAuctionItemPanel")
end

return UIGuildelEctionsPanel