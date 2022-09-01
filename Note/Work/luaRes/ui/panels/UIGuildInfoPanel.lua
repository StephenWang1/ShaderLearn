---帮会信息面板
---@class UIGuildInfoPanel:UIBase
local UIGuildInfoPanel = {}

local Utility = Utility

--region 局部变量定义
---改名卡ID
UIGuildInfoPanel.mRenameItemID = 6000007

UIGuildInfoPanel.ClipRegionY = 0
UIGuildInfoPanel.ClipRegionW = 166

--endregion

--region属性
---@return CSUnionInfoV2 帮会信息
function UIGuildInfoPanel:GetUnionInfoV2()
    if self.mGuildV2Info == nil then
        if self:GetMainPlayerInfo() then
            self.mGuildV2Info = self:GetMainPlayerInfo().UnionInfoV2
        end
    end
    return self.mGuildV2Info
end

---@return CSBagInfoV2 背包信息
function UIGuildInfoPanel:GetBagInfoV2()
    if self.mBagV2Info == nil then
        self.mBagV2Info = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagV2Info
end

---@return CSMainPlayerInfo 玩家信息
function UIGuildInfoPanel:GetMainPlayerInfo()
    if self.MainPlayerInfo == nil then
        self.MainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.MainPlayerInfo
end

---@return TABLE.CFG_ITEMS 改名卡信息
function UIGuildInfoPanel:GetRenameCardItemInfo()
    if self.mRenameCardInfo == nil then
        ___, self.mRenameCardInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mRenameItemID)
    end
    return self.mRenameCardInfo
end

---@return TABLE.CFG_DESCRIPTION 帮会成员数量Tips
function UIGuildInfoPanel:GetMemberCountTipsInfo()
    if self.mMemberCountTipsInfo == nil then
        ___, self.mMemberCountTipsBtn = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(103)
    end
    return self.mMemberCountTipsBtn
end

---@return TABLE.CFG_DESCRIPTION 帮会排名Tips
function UIGuildInfoPanel:GetGuildRankTipsInfo()
    if self.mGuildRankTipsInfo == nil then
        ___, self.mGuildRankTipsInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(104)
    end
    return self.mGuildRankTipsInfo
end

---@return TABLE.CFG_DESCRIPTION 管辖城市Tips
function UIGuildInfoPanel:GetJurisdictionCityTipsInfo()
    if self.mJurisdictionCityTipsInfo == nil then
        ___, self.mJurisdictionCityTipsInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(105)
    end
    return self.mJurisdictionCityTipsInfo
end

---@return TABLE.CFG_DESCRIPTION 税收Tips
function UIGuildInfoPanel:GetTaxTipsInfo()
    if self.mTaxTipsInfo == nil then
        ___, self.mTaxTipsInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(106)
    end
    return self.mTaxTipsInfo
end

---@return TABLE.CFG_PROMPTFRAME 弹劾会长时间不足信息
function UIGuildInfoPanel:GetAccuseChiefInfo()
    if self.mAccuseChief == nil then
        ___, self.mAccuseChief = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(169)
    end
    return self.mAccuseChief
end

---@return number 可修改公告总次数
function UIGuildInfoPanel:GetTotalChangeAnnouncementTime()
    if self.mTotalChangeTime == nil then
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20232)
        if res then
            self.mTotalChangeTime = tonumber(info.value)
        end
    end
    return self.mTotalChangeTime
end


--endregion

--region 组件
---@return UILabel 帮会名称
function UIGuildInfoPanel:GetUnionNameLabel_UILabel()
    if self.mGetUnionNameLabel == nil then
        self.mGetUnionNameLabel = self:GetCurComp("WidgetRoot/View/lb_unionName", "UILabel")
    end
    return self.mGetUnionNameLabel
end

---@return UnityEngine.GameObject 改名按钮
function UIGuildInfoPanel:GetRenameBtn_GameObject()
    if self.mRenameBtn == nil then
        self.mRenameBtn = self:GetCurComp("WidgetRoot/Event/btn_rename", "GameObject")
    end
    return self.mRenameBtn
end

---@return UISprite 帮会Icon
function UIGuildInfoPanel:GetGuildIcon_UISprite()
    if self.mGuildIcon == nil then
        self.mGuildIcon = self:GetCurComp("WidgetRoot/Event/unionIcon/Sprite", "UISprite")
    end
    return self.mGuildIcon
end

---@return UILabel 帮会会长
function UIGuildInfoPanel:GetGuildLeader_UILabel()
    if self.mGuildLeaderLabel == nil then
        self.mGuildLeaderLabel = self:GetCurComp("WidgetRoot/View/lb_leaderName", "UILabel")
    end
    return self.mGuildLeaderLabel
end

---@return UILabel 竞选/弹劾按钮文字
function UIGuildInfoPanel:GetCampaignBtn_UILabel()
    if self.mCampaignBtnSp == nil then
        self.mCampaignBtnSp = self:GetCurComp("WidgetRoot/Event/btn_announce/Label", "UILabel")
    end
    return self.mCampaignBtnSp
end

---@return UnityEngine.GameObject 竞选按钮
function UIGuildInfoPanel:GetCampaignBtn_GameObject()
    if self.mCampaignBtn == nil then
        self.mCampaignBtn = self:GetCurComp("WidgetRoot/Event/btn_announce", "GameObject")
    end
    return self.mCampaignBtn
end

---@return UnityEngine.GameObject 竞选按钮特效
function UIGuildInfoPanel:GetCampaignBtnEffect_GameObject()
    if self.mCampaignBtnEffect == nil then
        self.mCampaignBtnEffect = self:GetCurComp("WidgetRoot/Event/btn_announce/effect", "GameObject")
    end
    return self.mCampaignBtnEffect
end

---@return UILabel 帮会成员数量
function UIGuildInfoPanel:GetMemberCountLabel_UILabel()
    if self.mMemberCountLabel == nil then
        self.mMemberCountLabel = self:GetCurComp("WidgetRoot/View/lb_memberCount", "UILabel")
    end
    return self.mMemberCountLabel
end

---@return UnityEngine.GameObject 帮会人数按钮
function UIGuildInfoPanel:GetMemberCountTipsBtn_GameObject()
    if self.mMemberCountTipsBtn == nil then
        self.mMemberCountTipsBtn = self:GetCurComp("WidgetRoot/View/lb_memberCount/bg", "GameObject")
    end
    return self.mMemberCountTipsBtn
end

---@return UILabel 帮会排名
function UIGuildInfoPanel:GetGuildRankLabel_UILabel()
    if self.mGuildRankLabel == nil then
        self.mGuildRankLabel = self:GetCurComp("WidgetRoot/View/lb_unionrank", "UILabel")
    end
    return self.mGuildRankLabel
end

---@return UnityEngine.GameObject 帮会排名按钮
function UIGuildInfoPanel:GetGuildRankTipsBtn_GameObject()
    if self.mGuildRankTipsBtn == nil then
        self.mGuildRankTipsBtn = self:GetCurComp("WidgetRoot/View/lb_unionrank/bg", "GameObject")
    end
    return self.mGuildRankTipsBtn
end

---@return UILabel 管辖城市
function UIGuildInfoPanel:GetJurisdictionCity_UILabel()
    if self.mJurisdictionCity == nil then
        self.mJurisdictionCity = self:GetCurComp("WidgetRoot/View/lb_unioncity", "UILabel")
    end
    return self.mJurisdictionCity
end

---@return UnityEngine.GameObject 帮会管辖城市按钮
function UIGuildInfoPanel:GetJurisdictionCityTipsBtn_GameObject()
    if self.mJurisdictionCityTipsBtn == nil then
        self.mJurisdictionCityTipsBtn = self:GetCurComp("WidgetRoot/View/lb_unioncity/bg", "GameObject")
    end
    return self.mJurisdictionCityTipsBtn
end

---@return UnityEngine.GameObject 今日税收GO
function UIGuildInfoPanel:GetTaxToday_GameObject()
    if self.mTexTodayGO == nil then
        self.mTexTodayGO = self:GetCurComp("WidgetRoot/View/lb_taxes/money", "GameObject")
    end
    return self.mTexTodayGO
end

---@return UILabel 无税收文本
function UIGuildInfoPanel:GetNoneRate_UILabel()
    if self.mNoneRateLabel == nil then
        self.mNoneRateLabel = self:GetCurComp("WidgetRoot/View/lb_taxes/None", "UILabel")
    end
    return self.mNoneRateLabel
end

---@return UILabel 今日税收
function UIGuildInfoPanel:GetTaxToday_UILabel()
    if self.mTexToday == nil then
        self.mTexToday = self:GetCurComp("WidgetRoot/View/lb_taxes/money/Rate", "UILabel")
    end
    return self.mTexToday
end

---@return UnityEngine.GameObject 今日税收按钮
function UIGuildInfoPanel:GetTaxTodayTipsBtn_GameObject()
    if self.mTaxTodayTipsBtn == nil then
        self.mTaxTodayTipsBtn = self:GetCurComp("WidgetRoot/View/lb_taxes/bg", "GameObject")
    end
    return self.mTaxTodayTipsBtn
end

---@return UnityEngine.GameObject 编辑公告按钮
function UIGuildInfoPanel:GetSubmitButton_GameObject()
    if self.mSubmitButton == nil then
        self.mSubmitButton = self:GetCurComp("WidgetRoot/Event/btn_writing", "GameObject")
    end
    return self.mSubmitButton
end

---@return UILabel 置顶消息
function UIGuildInfoPanel:GetStickyMessage_UILabel()
    if self.mStickyMessage == nil then
        self.mStickyMessage = self:GetCurComp("WidgetRoot/Event/unionNote/Topplacement/info", "UILabel")
    end
    return self.mStickyMessage
end

---@return GuildLogController 帮会日志组件
function UIGuildInfoPanel:GetGuildLogController_GuildLogController()
    if self.mLogController == nil then
        self.mLogController = self:GetCurComp("WidgetRoot/Event/unionNote/ScrollView/gird", "IrregularLoopScrollView")
    end
    return self.mLogController
end

---@return UnityEngine.GameObject 取消编辑公告按钮
function UIGuildInfoPanel:GetCancelAnnouncement_GameObject()
    if self.mCancelAnnouncementButton == nil then
        self.mCancelAnnouncementButton = self:GetCurComp("WidgetRoot/Event/btn_oppose", "GameObject")
    end
    return self.mCancelAnnouncementButton
end

---@return UnityEngine.GameObject 确认编辑公告按钮
function UIGuildInfoPanel:GetChangeAnnouncementButton_GameObject()
    if self.mChangeAnnouncementButton == nil then
        self.mChangeAnnouncementButton = self:GetCurComp("WidgetRoot/Event/btn_agree", "GameObject")
    end
    return self.mChangeAnnouncementButton
end

---@return UIInput 帮会公告
function UIGuildInfoPanel:GetAnnouncementLabel_UIInput()
    if self.mAnnouncementInput == nil then
        self.mAnnouncementInput = self:GetCurComp("WidgetRoot/Event/ScrollView/announcement", "UIInput")
    end
    return self.mAnnouncementInput
end

---@return UnityEngine.BoxCollider 帮会公告Collider
function UIGuildInfoPanel:GetAnnouncement_BoxCollider()
    if self.mAnnouncementCollider == nil then
        self.mAnnouncementCollider = self:GetCurComp("WidgetRoot/Event/ScrollView/announcement", "BoxCollider")
    end
    return self.mAnnouncementCollider
end

---@return UnityEngine.GameObject 沙漏图标
function UIGuildInfoPanel:GetHourGlassSign_GameObject()
    if self.mHourGlass == nil then
        self.mHourGlass = self:GetCurComp("WidgetRoot/Event/unionNote/Topplacement/loading", "GameObject")
    end
    return self.mHourGlass
end

---@return UIScrollView 公告Scroll
function UIGuildInfoPanel:GetAnnouncementScroll()
    if self.mAnnounceScroll == nil then
        self.mAnnounceScroll = self:GetCurComp("WidgetRoot/Event/ScrollView", "UIScrollView")
    end
    return self.mAnnounceScroll
end

function UIGuildInfoPanel:GetAnnouncementPanel()
    if self.mAnnouncePanel == nil and self:GetAnnouncementScroll() then
        self.mAnnouncePanel = self:GetAnnouncementScroll().panel
        if self.mAnnouncePanel == nil then
            self.mAnnouncePanel = self:GetCurComp("WidgetRoot/Event/ScrollView", "UIPanel")
        end
    end
    return self.mAnnouncePanel
end

---@return UnityEngine.BoxCollider
function UIGuildInfoPanel:GetDragAnnouncement_BoxColloder()
    if self.mDragAnnouncementCol == nil then
        self.mDragAnnouncementCol = self:GetCurComp("WidgetRoot/Event/Drag", "BoxCollider")
    end
    return self.mDragAnnouncementCol
end

---@return UnityEngine.GameObject 聊天总结点
function UIGuildInfoPanel:GetChat_Go()
    if self.mChatGo == nil then
        self.mChatGo = self:GetCurComp("WidgetRoot/Event/unionNote/Chat", "GameObject")
    end
    return self.mChatGo
end

---@return UnityEngine.GameObject 查看繁荣度
function UIGuildInfoPanel:GetViewBenefit_Go()
    if self.mViewBenefitsBtn == nil then
        self.mViewBenefitsBtn = self:GetCurComp("WidgetRoot/View/lb_unioncity/btn_view", "GameObject")
    end
    return self.mViewBenefitsBtn
end

---@return UnityEngine.GameObject 查看繁荣度
function UIGuildInfoPanel:GetViewActivity_Go()
    if self.mViewActivityBtn == nil then
        self.mViewActivityBtn = self:GetCurComp("WidgetRoot/View/lb_taxes/btn_view", "GameObject")
    end
    return self.mViewActivityBtn
end

--endregion

--region 初始化

function UIGuildInfoPanel:Init()
    self:BindMessage()
    self:BindEvents()
    if (self:GetAnnouncementPanel()) then
        self.BaseClipRegion = self:GetAnnouncementPanel().baseClipRegion
    end
    ---@type UIGuildChatWindowTemplate
    self.ChatTemplate = templatemanager.GetNewTemplate(self:GetChat_Go(), luaComponentTemplates.UIGuildChatWindowTemplate, self)
end

function UIGuildInfoPanel:Show(customData)
    self.isEdit = false
    self:RefreshInfo()
    networkRequest.ReqGetPlayerUnionInfo()--行会基础信息
    networkRequest.ReqGetUnionJournal(self:GetUnionInfoV2().UnionID)--行会日志

    if customData and customData.isOpenAccusePanel then
        self:OnCampaignButtonClicked()
    end
    -- self:SuitAnnounceScroll()
    networkRequest.ReqSpoilsHouse()--行会信息界面有战利品数目显示
end

function UIGuildInfoPanel:BindEvents()
    CS.UIEventListener.Get(self:GetRenameBtn_GameObject()).onClick = function()
        self:OnRenameButtonClicked()
    end
    CS.UIEventListener.Get(self:GetCampaignBtn_GameObject()).onClick = function()
        self:OnCampaignButtonClicked()
    end
    CS.UIEventListener.Get(self:GetMemberCountTipsBtn_GameObject()).onClick = function()
        self:OnMemberCountTipsBtnClicked()
    end
    CS.UIEventListener.Get(self:GetGuildRankTipsBtn_GameObject()).onClick = function()
        self:OnGuildRankTipsClicked()
    end
    CS.UIEventListener.Get(self:GetJurisdictionCityTipsBtn_GameObject()).onClick = function()
        self:OnJurisdictionCityTipsBtnClicked()
    end
    CS.UIEventListener.Get(self:GetTaxTodayTipsBtn_GameObject()).onClick = function()
        self:OnTaxTodayTipsBtnClicked()
    end
    CS.UIEventListener.Get(self:GetSubmitButton_GameObject()).onClick = function()
        self:OnSubmitButtonClicked()
    end
    CS.UIEventListener.Get(self:GetCancelAnnouncement_GameObject()).onClick = function()
        self:OnCancelAnnouncementButtonClicked()
    end
    CS.UIEventListener.Get(self:GetChangeAnnouncementButton_GameObject()).onClick = function()
        self:OnChangeAnnouncementButtonClicked()
    end
    CS.UIEventListener.Get(self:GetStickyMessage_UILabel().gameObject).onClick = function()
        self:OnStickyMessageClicked()
    end
    CS.UIEventListener.Get(self:GetViewBenefit_Go().gameObject).onClick = function()
        self:SwitchToPanel(LuaEnumGuildPanelType.GuildWelfare)
    end
    CS.UIEventListener.Get(self:GetViewActivity_Go().gameObject).onClick = function()
        self:SwitchToPanel(LuaEnumGuildPanelType.GuildActivity)
    end

end

function UIGuildInfoPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionInfoChange, function()
        self:RefreshInfo()
        --这里是为了在竞选列表变化时刷新显示
        self:RefreshStickyMessage()
    end)
    -- UIGuildInfoPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionJournalChange, function()
    --self:OnResGetUnionJournalMessageReceived()
    --end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_SendClickUnionRedPackInfo, function(msgId, data)
        self:GetGuildLogController_GuildLogController():RefreshCurrentPage()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionChatAnnounceMessage, UIGuildInfoPanel.OnResUnionChatAnnounceMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResChatMessage, UIGuildInfoPanel.OnResChatMessageMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAnnounceMessage, UIGuildInfoPanel.OnResAnnounceMessageMessageReceived)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.OnClickUnionChatBagItem, UIGuildInfoPanel.OnBagItemClicked)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionSpoilsChange, function()
        self:RefreshSpoilsShow()
    end)
end
--endregion

--region 客户端消息
---接受到帮会日志信息
function UIGuildInfoPanel:OnResGetUnionJournalMessageReceived()
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().JournalList then
        self:GetGuildLogController_GuildLogController():Init(self:GetUnionInfoV2().JournalList)
        self:RefreshStickyMessage()
    end
end

---刷新置顶信息
function UIGuildInfoPanel:RefreshStickyMessage()
    ---@type unionV2.UnionJournal
    local topInfo = self:GetUnionInfoV2().TopUnionJournal
    if topInfo then
        self:GetStickyMessage_UILabel().text = topInfo.operation
    end
    -- self:GetGuildLogController_GuildLogController():ShowTopNote(topInfo ~= nil)
    self:GetHourGlassSign_GameObject():SetActive(self:GetUnionInfoV2().IsTopUnionJournalShowHourglass)
end

---刷新基础信息
function UIGuildInfoPanel:RefreshInfo()
    if self:GetUnionInfoV2() then
        ---@type unionV2.ResSendPlayerUnionInfo
        local info = self:GetUnionInfoV2().UnionInfo
        if info then
            --帮会名称
            self:GetUnionNameLabel_UILabel().text = info.unionInfo.unionName
            --帮会徽章
            self:GetGuildIcon_UISprite().spriteName = info.unionInfo.unionIcon
            --帮主名字
            local hasLeader = info.unionInfo.leaderId ~= 0
            if hasLeader then
                self:GetGuildLeader_UILabel().text = info.unionInfo.leaderName
                local IsShowBtn = info.unionInfo.leaderId ~= self:GetMainPlayerInfo().ID
                local isAccuse = info.unionInfo.isImpeachment
                self:GetCampaignBtn_GameObject():SetActive(IsShowBtn or isAccuse) --帮主不显示弹劾按钮
            else
                ---@type unionV2.UnionMemberInfo
                local ActingPresidentID = self:GetUnionInfoV2().ActingPresidentRoleID
                local ActingPresidentName = self:GetUnionInfoV2().ActingPresidentName
                local show = luaEnumColorType.Red .. "会长待竞选"
                if ActingPresidentID ~= 0 then
                    show = ActingPresidentName .. luaEnumColorType.Gray .. "(代理)"
                end
                self:GetGuildLeader_UILabel().text = show
                self:GetCampaignBtn_GameObject():SetActive(true)
            end
            local word = self:GetUnionInfoV2():IsCurrentEction() and "竞选中" or "竞选"
            self:GetCampaignBtn_UILabel().text = ternary(hasLeader, "弹劾", word)
            self:GetCampaignBtnEffect_GameObject():SetActive(not hasLeader) --当前无帮主时，显示竞选按钮，且一直环绕特效
            --人数
            local isCrowded = info.unionInfo.crown--是否拥挤
            local color = ternary(isCrowded, luaEnumColorType.Red, "")
            self:GetMemberCountLabel_UILabel().text = color .. info.unionInfo.unionNum .. ternary(isCrowded, "(拥挤)", "")
            --排名
            self:GetGuildRankLabel_UILabel().text = info.unionInfo.rank
            --繁荣度
            self:GetJurisdictionCity_UILabel().text = Utility.GetUnionActiveValue(info.unionInfo.rank)

            --编辑公告
            self:SetAnnouncementState(true)
            self:GetSubmitButton_GameObject():SetActive(self:GetUnionInfoV2():CanModifyAnnouncement())
            self:GetAnnouncementLabel_UIInput().value = string.gsub(info.unionInfo.announcement, "\\n", "\n")
        end
        self:GetRenameBtn_GameObject():SetActive(self:GetUnionInfoV2():CanChangeUnionName())
    end
end
--endregion

--region UI事件
---改名按钮事件
function UIGuildInfoPanel:OnRenameButtonClicked()
    local isCanRename = self:GetBagInfoV2():IsContainByItemId(self.mRenameItemID)
    if isCanRename then
        uimanager:CreatePanel("UIRenamePanel", nil, self:GetRenameCardItemInfo())
    else
        uiStaticParameter.mUnionInfoToShop = true
        CS.Utility.ShowTips("请购买行会改名卡", 1, CS.ColorType.Red)
        local customData = {}
        customData.type = LuaEnumStoreType.Diamond
        uimanager:CreatePanel("UIShopPanel", nil, customData)
    end
end

---点击竞选按钮
function UIGuildInfoPanel:OnCampaignButtonClicked()
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().UnionInfo then
        if self:GetUnionInfoV2().UnionInfo.unionInfo.leaderId ~= 0 then
            --有帮主弹劾
            local isCurrentHasAccuse = self:GetUnionInfoV2().UnionInfo.unionInfo.isImpeachment
            if isCurrentHasAccuse then
                uimanager:CreatePanel("UIAccuseChiefPanel")
                return
            end

            local customData = {}
            --帮主离线两天
            local isAccuseChiefNeedMoney = self:GetUnionInfoV2():IsAccuseChiefNeedMoney()
            local time
            if isAccuseChiefNeedMoney then
                customData.ID = 42
                time = CS.Cfg_GlobalTableManager.Instance:AccuseChiefLeaderLeaveTime()
                customData.CenterCostID = self:GetAccuseChiefCost(0)
                customData.CenterCostNum = self:GetAccuseChiefCost(1)
                customData.CenterCallBack = function(go)
                    if self:GetIsMoneyEnough() then
                        if self:ReqAccuseChief(go) then
                            uimanager:ClosePanel("UIGuildAccusePromptPanel")
                        end
                    else
                        local des = self:GetAccuseChiefMoneyTipsInfo()
                        Utility.ShowPopoTips(go, des, 154)
                    end
                end
            else
                customData.ID = 43
                time = CS.Cfg_GlobalTableManager.Instance:AccuseChiefLeaderLeaveTime()
                customData.CenterCallBack = function(go)
                    if self:ReqAccuseChief(go) then
                        uimanager:ClosePanel("UIGuildAccusePromptPanel")
                    end
                end
            end
            uimanager:CreatePanel("UIGuildAccusePromptPanel", nil, customData, time)

        else
            if self:GetUnionInfoV2():IsCurrentEction() then
                --无帮主竞选
                uimanager:CreatePanel("UIGuildelEctionsPanel")
            else
                uimanager:CreatePanel("UIGuildUnmannedElectionsPanel")
            end
        end
    end
end

---请求弹劾会长
function UIGuildInfoPanel:ReqAccuseChief(go)
    --入帮时间是否足够
    local IsAddTimeArrive = self:GetUnionInfoV2():IsCanAccuseChief()
    if not IsAddTimeArrive then
        if self:GetAccuseChiefInfo() then
            local addTime = CS.Cfg_GlobalTableManager.Instance:AccuseChiefTime()
            local des = string.format(self:GetAccuseChiefInfo().content, addTime)
            Utility.ShowPopoTips(go, des, 169)
        end
        return false
    end
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().LeaderUnionMemberInfo then
        networkRequest.ReqImpeachLeader(self:GetUnionInfoV2().LeaderUnionMemberInfo.roleId)
        uimanager:CreatePanel("UIAccuseChiefPanel")
        uimanager:ClosePanel("UIGuildAccusePromptPanel")
    end
    return true
end

---@param type number 类型 0 货币id 1 数目弹劾会长消费
function UIGuildInfoPanel:GetAccuseChiefCost(type)
    if self.mCost == nil then
        self.mCost = CS.Cfg_GlobalTableManager.Instance:AccuseChiefCostMoney()
    end
    if self.mCost and self.mCost.Length >= 2 then
        return self.mCost[type]
    end
    return 0
end

---@return boolean 玩家弹劾会长货币是否足够
function UIGuildInfoPanel:GetIsMoneyEnough()
    local coinItemID = self:GetAccuseChiefCost(0)
    local coinNum = self:GetAccuseChiefCost(1)
    local playerHas = self:GetBagInfoV2():GetCoinAmount(coinItemID)
    --if has then
    return playerHas >= coinNum
    --end
    --return false
end

---@return string 弹劾会长货币不足提示
function UIGuildInfoPanel:GetAccuseChiefMoneyTipsInfo()
    if self.mCostDes == nil then
        local coinItemID = self:GetAccuseChiefCost(0)
        local res, coinInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(coinItemID)
        if res then
            local res1, desInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(154)
            if res1 then
                self.mCostDes = string.format(desInfo.content, coinInfo.name)
            end
        end
    end
    return self.mCostDes
end

---@return string 获取免费弹劾会长弹窗提示
function UIGuildInfoPanel:GetFreeAccuseChiefTipsInfo()
    if self.mFreeAccuseTips == nil then
        local res, desInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(43)
        if res then
            local time = CS.Cfg_GlobalTableManager.Instance:AccuseChiefLeaderLeaveTime()
            self.mFreeAccuseTips = string.gsub(string.format(desInfo.des, time), '\\n', '\n')
        end
    end
    return self.mFreeAccuseTips

end

---@return string 获取花费弹劾会长弹窗提示
function UIGuildInfoPanel:GetCostAccuseChiefTipsInfo()
    if self.mCostAccuseTips == nil then
        local res, desInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(42)
        if res then
            local time = CS.Cfg_GlobalTableManager.Instance:AccuseChiefLeaderLeaveTime()
            self.mCostAccuseTips = string.gsub(string.format(desInfo.des, time), '\\n', '\n')
        end
    end
    return self.mCostAccuseTips
end

---显示提示面板
function UIGuildInfoPanel:ShowPromptPanel(tableInfo, content, callBack)
    local CallBackInfo = {
        Title = tableInfo.title,
        LeftDescription = tableInfo.leftButton,
        RightDescription = tableInfo.rightButton,
        Content = content,
        CallBack = callBack,
        ID = tableInfo.id
    }
    uimanager:CreatePanel("UIPromptPanel", nil, CallBackInfo)
end

---帮会人数Tips
function UIGuildInfoPanel:OnMemberCountTipsBtnClicked()
    self:CreateHelpTips(self:GetMemberCountTipsInfo())
end

---帮会排名Tips
function UIGuildInfoPanel:OnGuildRankTipsClicked()
    self:CreateHelpTips(self:GetGuildRankTipsInfo())
end

---管辖城市Tips
function UIGuildInfoPanel:OnJurisdictionCityTipsBtnClicked()
    self:CreateHelpTips(self:GetJurisdictionCityTipsInfo())
end

---税收Tips
function UIGuildInfoPanel:OnTaxTodayTipsBtnClicked()
    self:CreateHelpTips(self:GetTaxTipsInfo())
end

---创建帮助界面
function UIGuildInfoPanel:CreateHelpTips(tableInfo)
    if tableInfo then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, tableInfo)
    end
end

---编辑公告/确定
function UIGuildInfoPanel:OnSubmitButtonClicked()
    if self:GetTotalChangeAnnouncementTime() and self:GetUnionInfoV2() and self:GetUnionInfoV2().UnionInfo then
        if self:GetUnionInfoV2().UnionInfo.unionInfo.modifyCount < self:GetTotalChangeAnnouncementTime() then
            self:SetAnnouncementState(false)
            self:GetAnnouncementLabel_UIInput().isSelected = true
        else
            CS.Utility.ShowTips("今日修改次数已用完", 1, CS.ColorType.Red)
        end
    end
end

---取消编辑公告
function UIGuildInfoPanel:OnCancelAnnouncementButtonClicked()
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().UnionInfo then
        self:GetAnnouncementLabel_UIInput().value = string.gsub(self:GetUnionInfoV2().UnionInfo.unionInfo.announcement, "\\n", "\n")
    end
    self:SetAnnouncementState(true)
end

---确认编辑公告
function UIGuildInfoPanel:OnChangeAnnouncementButtonClicked()
    local info = self:GetAnnouncementLabel_UIInput().text
    if CS.StaticUtility.IsNullOrEmpty(info) then
        CS.Utility.ShowTips("公告内容不可为空", 1, CS.ColorType.Red)
    else
        if self:GetChangeAnnouncementTipsInfo() and self:GetTotalChangeAnnouncementTime() and self:GetUnionInfoV2() and self:GetUnionInfoV2().UnionInfo then
            local ChangeInfo = {
                Title = self:GetChangeAnnouncementTipsInfo().title,
                LeftDescription = self:GetChangeAnnouncementTipsInfo().leftButton,
                RightDescription = self:GetChangeAnnouncementTipsInfo().rightButton,
                Content = string.format(self:GetChangeAnnounceContent(), self:GetTotalChangeAnnouncementTime() - self:GetUnionInfoV2().UnionInfo.unionInfo.modifyCount),
                ID = self:GetChangeAnnouncementTipsInfo().id,
                CallBack = function()
                    self:ConfirmChangeAnnouncement()
                end
            }
            uimanager:CreatePanel("UIPromptPanel", nil, ChangeInfo)
        end
    end
end

---@return TABLE.CFG_PROMPTWORD 编辑弹窗内容
function UIGuildInfoPanel:GetChangeAnnouncementTipsInfo()
    if self.mChangeAnnounceTips == nil then
        local res, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(10)
        if res then
            self.mChangeAnnounceTips = info
        end
    end
    return self.mChangeAnnounceTips
end

---@return string 描述
function UIGuildInfoPanel:GetChangeAnnounceContent()
    if self.mContent == nil then
        if self:GetChangeAnnouncementTipsInfo() then
            self.mContent = string.gsub(self:GetChangeAnnouncementTipsInfo().des, "\\n", '\n')
        end
    end
    return self.mContent
end

---确认修改公告
function UIGuildInfoPanel:ConfirmChangeAnnouncement()
    local info = self:GetAnnouncementLabel_UIInput().text
    if info then
        networkRequest.ReqChangeAnnouncement(info)
        self:SetAnnouncementState(true)
    end
end

---设置公告选中状态
function UIGuildInfoPanel:SetAnnouncementState(isShow)
    self:GetAnnouncement_BoxCollider().enabled = not isShow
    self:GetSubmitButton_GameObject():SetActive(isShow)
    self:GetChangeAnnouncementButton_GameObject():SetActive(not isShow)
    self:GetCancelAnnouncement_GameObject():SetActive(not isShow)
end

---点击置顶消息
function UIGuildInfoPanel:OnStickyMessageClicked()
    if self:GetUnionInfoV2() then
        ---@type unionV2.UnionJournal 帮会置顶日志
        local info = self:GetUnionInfoV2().TopUnionJournal
        if info then
            local res, newsInfo = CS.Cfg_Union_NewsTableManager.Instance.dic:TryGetValue(info.id)
            if res and newsInfo.openPanel then
                uimanager:CreatePanel(newsInfo.openPanel)
            end
        end
    end
end

---刷新帮会日志
---@param csData unionV2.ResUnionChatAnnounce
function UIGuildInfoPanel.OnResUnionChatAnnounceMessageReceived(msgId, tblData, csData)
    luaclass.ChatData:FilterUnionChatShowChatData(csData)
    UIGuildInfoPanel:GetGuildLogController_GuildLogController():Init(csData)
end

---适配
function UIGuildInfoPanel:SuitAnnounceScroll()
    local offset = 42
    local offset2 = 10
    local canChange = self:GetUnionInfoV2():CanModifyAnnouncement()
    if not CS.StaticUtility.IsNull(self:GetAnnouncementScroll()) then
        local baseClipRegion = self.BaseClipRegion
        if baseClipRegion and self:GetAnnouncementPanel() then
            baseClipRegion.y = canChange and self.ClipRegionY - offset2 / 2 or self.ClipRegionY - offset / 2
            baseClipRegion.w = canChange and self.ClipRegionW + offset2 or self.ClipRegionW + offset
            self:GetAnnouncementPanel().baseClipRegion = baseClipRegion
            self:GetDragAnnouncement_BoxColloder().center = CS.UnityEngine.Vector3(baseClipRegion.x, baseClipRegion.y, 0)
            self:GetDragAnnouncement_BoxColloder().size = CS.UnityEngine.Vector3(baseClipRegion.z, baseClipRegion.w, 0)
        end
    end
end

--endregion

--region 日志
---收到聊天消息
---@param csData chatV2.ResChat
function UIGuildInfoPanel.OnResChatMessageMessageReceived(msgID, tblData, csData)
    if luaclass.ChatData:ShowChatData(csData) == false then
        return
    end
    if not CS.StaticUtility.IsNull(UIGuildInfoPanel:GetGuildLogController_GuildLogController()) then
        UIGuildInfoPanel:GetGuildLogController_GuildLogController():AddUnionChatMessage(csData)
    end
end

---收到日志
---@param csData
function UIGuildInfoPanel.OnResAnnounceMessageMessageReceived(msgID, tblData, csData)
    if not CS.StaticUtility.IsNull(UIGuildInfoPanel:GetGuildLogController_GuildLogController()) then
        UIGuildInfoPanel:GetGuildLogController_GuildLogController():AddUnionAnnounceMessage(csData)
    end
end
--endregion

--region 聊天背包
function UIGuildInfoPanel.OnBagItemClicked(msgId, info)
    UIGuildInfoPanel.ChatTemplate:OnBagItemClicked(msgId, info)
end

--endregion

--region 跳转界面
---跳转界面
function UIGuildInfoPanel:SwitchToPanel(type)
    ---@type UIGuildPanel
    if self.mGuildPanel == nil then
        self.mGuildPanel = uimanager:GetPanel("UIGuildPanel")
    end
    if self.mGuildPanel then
        self.mGuildPanel:ChooseToggle(type)
    end
end
--endregion

--region 战利品相关
---@return number 战利品元宝总数
function UIGuildInfoPanel:RefreshSpoilsShow()
    local allDic = self:GetUnionInfoV2().SpoilsDic
    local total = 0
    if allDic then
        CS.Utility_Lua.luaForeachCsharp:Foreach(allDic, function(k, v)
            ---@type bagV2.BagItemInfo
            local info = v
            if info then
                if info.itemId == LuaEnumCoinType.YuanBao then
                    total = total + info.count
                end
            end
        end)
    end
    self:GetTaxToday_UILabel().text = total
    self:GetTaxToday_GameObject():SetActive(true)
    self:GetNoneRate_UILabel().gameObject:SetActive(false)
    return 0
end
--endregion

--region update
function update()
    if UIGuildInfoPanel.ChatTemplate and UIGuildInfoPanel.ChatTemplate:GetBagTemplate() then
        UIGuildInfoPanel.ChatTemplate:GetBagTemplate():GetChatBagInteraction():OnUpdate(CS.UnityEngine.Time.time)
    end
end
--endregion

function ondestroy()
    if UIGuildInfoPanel.ChatTemplate then
        UIGuildInfoPanel.ChatTemplate:ClearVoice()
    end
end

return UIGuildInfoPanel